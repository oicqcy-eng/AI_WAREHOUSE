/*重庆检验/质检记录 —— 不良/送检/首检 三源视角（6视角，2026-08-15 实战沉淀）
 * 库: 重庆独立 sMES（172.16.64.11/sMES_Home_Prod，--profile cq）
 * 用法: node query-mes.js 本文件 --profile cq -p date=2026-08-15 --show N
 *   date=YYYY-MM-DD 指定日；date='' 则全量（②不良TOP原因/⑥工序设备适用全量）
 *   N=1 当日不良明细 / 2 不良TOP原因汇总 / 3 当日送检明细 / 4 当日首检明细 / 5 当日送检汇总 / 6 不良按工序×设备
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 *
 * ── 核心口径与实测结论（务必先读）────────────────────────
 * 【三张源表】不良=tblWIPCont_Error（按次登记，经 LOGGROUPSERIAL→TBLWIPCONT_EQUIPMENT 取设备）
 *           送检=TBLWIPCONT_PARTIALOUT（重庆检验主源，自带 EQUIPMENTNO，QCFormNo 重庆未填）
 *           首检=TBLWIPFIRSTCHECK（重庆极少：实测仅 1 条，QCRESULT Y=合格/N=不合格/I=检验中，QCTYPE 待验）
 * 【送检量恒等】实测 1579 条 全部 INPUTQTY = GOODQTY + SCRAPQTY → 合格率 = 良品/送检量 口径可靠。
 * 【报废标记】tblWIPCont_Error.SCRAPFLAG 重庆全 0（41条/502件）——未启用，勿用 SCRAPFLAG 区分报废/返修；
 *            重庆"报废量"权威信号 = 送检 SCRAPQTY。
 * 【两源交叉核对】重庆实测 不良表 ERRORQTY 合计 502 ⟷ 送检 SCRAPQTY 合计 501，差 1 件——
 *            两源是同一判定(送检时登记不良)的两面，差异即需核查点；使用时勿把两者相加当总量。
 * 【产线判定】OPNO 前缀 OP-CQSPR%（弹簧线）/ OP-CQSTB%（稳定杆线），否则"其他"。
 * 【口径变更日志】2026-08-15 初版——重庆检验/质检记录（质量分析数据源，支撑质量周报/不良 TOP 定位）
 */

/*—— ① 当日不良明细: 不良逐条（-p date=YYYY-MM-DD；date='' 全量） ——*/
SELECT CONVERT(CHAR(16),E.EVENTTIME,120)                     AS 时间
      ,CASE WHEN E.OPNO LIKE 'OP-CQSPR%' THEN '弹簧线'
            WHEN E.OPNO LIKE 'OP-CQSTB%' THEN '稳定杆线' ELSE '其他' END AS 产线
      ,E.LOTNO                                              AS 生产批
      ,ISNULL(B.MONO,'')                                    AS 工单
      ,ISNULL(P.PRODUCTNAME,'')                             AS 产品名
      ,E.OPNO                                               AS 工序
      ,ISNULL(OP.OPNAME,'')                                 AS 工序名
      ,E.ERRORNO                                            AS 不良码
      ,ISNULL(R.REASONNAME,'')                              AS 原因名
      ,CASE R.REASONTYPE WHEN 0 THEN '报废现象' WHEN 6 THEN '设备DOWN'
                         WHEN 7 THEN '报废原因' WHEN 11 THEN '多余'
                         WHEN 12 THEN '短少' ELSE CONVERT(VARCHAR,R.REASONTYPE) END AS 原因类型
      ,E.ERRORQTY                                           AS 数量
      ,ISNULL((SELECT MIN(EQ.EQUIPMENTNO) FROM TBLWIPCONT_EQUIPMENT EQ
               WHERE EQ.LOGGROUPSERIAL=E.LOGGROUPSERIAL),'') AS 设备
      ,ISNULL(E.Creator,'')                                 AS 登记人
FROM tblWIPCont_Error E
LEFT JOIN TBLQCREASONBASIS R ON E.ERRORNO=R.REASONNO
LEFT JOIN TBLWIPLOTBASIS B ON E.LOTNO=B.BASELOTNO
LEFT JOIN TBLPRDPRODUCTBASIS P ON B.PRODUCTNO=P.PRODUCTNO AND B.PRODUCTVERSION=P.PRODUCTVERSION
LEFT JOIN tblOPBasis OP ON E.OPNO=OP.OPNO
WHERE ('' = '{{date}}' OR CONVERT(CHAR(10),E.EVENTTIME,120)='{{date}}')
ORDER BY E.EVENTTIME;

/*—— ② 不良TOP原因汇总: 不良码×原因 聚合（质量分析核心；date='' 全量看累计） ——*/
SELECT TOP 20 R.REASONNO                                    AS 不良码
      ,ISNULL(R.REASONNAME,'')                              AS 原因名
      ,CASE R.REASONTYPE WHEN 0 THEN '报废现象' WHEN 6 THEN '设备DOWN'
                         WHEN 7 THEN '报废原因' WHEN 11 THEN '多余'
                         WHEN 12 THEN '短少' ELSE CONVERT(VARCHAR,R.REASONTYPE) END AS 原因类型
      ,SUM(E.ERRORQTY)                                      AS 不良量
      ,COUNT(DISTINCT E.LOTNO)                              AS 涉及批数
      ,COUNT(*)                                             AS 记录数
      ,CONVERT(CHAR(10),MIN(E.EVENTTIME),120)               AS 最早
      ,CONVERT(CHAR(10),MAX(E.EVENTTIME),120)               AS 最晚
FROM tblWIPCont_Error E
LEFT JOIN TBLQCREASONBASIS R ON E.ERRORNO=R.REASONNO
WHERE ('' = '{{date}}' OR CONVERT(CHAR(10),E.EVENTTIME,120)='{{date}}')
GROUP BY R.REASONNO, R.REASONNAME, R.REASONTYPE
ORDER BY SUM(E.ERRORQTY) DESC;

/*—— ③ 当日送检明细: 送检逐条（-p date=YYYY-MM-DD；date='' 全量） ——
 * 送检=重庆检验主流程；InputQty=送检量(实测=良品+报废)
 */
SELECT CONVERT(CHAR(16),PO.EventTime,120)                   AS 时间
      ,CASE WHEN PO.OPNo LIKE 'OP-CQSPR%' THEN '弹簧线'
            WHEN PO.OPNo LIKE 'OP-CQSTB%' THEN '稳定杆线' ELSE '其他' END AS 产线
      ,PO.LotNo                                             AS 生产批
      ,ISNULL(B.MONO,'')                                    AS 工单
      ,PO.OPNo                                              AS 工序
      ,ISNULL(OP.OPNAME,'')                                 AS 工序名
      ,PO.InputQty                                          AS 送检量
      ,PO.GOODQTY                                           AS 良品
      ,PO.SCRAPQTY                                          AS 报废
      ,ISNULL(PO.UserNo,'')                                 AS 检验员
      ,ISNULL(PO.EQUIPMENTNO,'')                            AS 设备
      ,ISNULL(PO.QCFormNo,'')                               AS 检验单号
FROM TBLWIPCONT_PARTIALOUT PO
LEFT JOIN TBLWIPLOTBASIS B ON PO.LotNo=B.BASELOTNO
LEFT JOIN tblOPBasis OP ON PO.OPNo=OP.OPNO
WHERE ('' = '{{date}}' OR CONVERT(CHAR(10),PO.EventTime,120)='{{date}}')
ORDER BY PO.EventTime;

/*—— ④ 当日首检明细: 首检逐条（-p date=YYYY-MM-DD；date='' 全量） ——
 * ⚠️ 重庆首检极少(实测全表仅 1 条)；QCRESULT Y=合格/N=不合格/I=检验中
 */
SELECT CONVERT(CHAR(16),F.CHECKTIME,120)                    AS 时间
      ,F.LOTNO                                              AS 生产批
      ,ISNULL(B.MONO,'')                                    AS 工单
      ,F.OPNO                                               AS 工序
      ,ISNULL(OP.OPNAME,'')                                 AS 工序名
      ,F.CHECKQTY                                           AS 检验量
      ,F.DEFECTQTY                                          AS 不良量
      ,CASE F.QCRESULT WHEN 'Y' THEN '合格' WHEN 'N' THEN '不合格'
                       WHEN 'I' THEN '检验中' ELSE F.QCRESULT END AS 结果
      ,ISNULL(F.QCTYPE,'')                                  AS 检验类型
      ,ISNULL(F.USERNO,'')                                  AS 检验员
      ,ISNULL(F.EquipmentNo,'')                             AS 设备
      ,ISNULL(F.QCFORMNO,'')                                AS 检验单号
FROM TBLWIPFIRSTCHECK F
LEFT JOIN TBLWIPLOTBASIS B ON F.LOTNO=B.BASELOTNO
LEFT JOIN tblOPBasis OP ON F.OPNO=OP.OPNO
WHERE ('' = '{{date}}' OR CONVERT(CHAR(10),F.CHECKTIME,120)='{{date}}')
ORDER BY F.CHECKTIME;

/*—— ⑤ 当日送检汇总: 按工序 送检批数/量/良品/报废/合格率（报废量=质量权威信号） ——
 * 合格率 = 良品/送检量（实测送检量=良品+报废，口径可靠）
 */
SELECT CASE WHEN PO.OPNo LIKE 'OP-CQSPR%' THEN '弹簧线'
            WHEN PO.OPNo LIKE 'OP-CQSTB%' THEN '稳定杆线' ELSE '其他' END AS 产线
      ,PO.OPNo                                              AS 工序
      ,ISNULL(OP.OPNAME,'')                                 AS 工序名
      ,COUNT(DISTINCT PO.LotNo)                             AS 送检批数
      ,COUNT(*)                                             AS 送检记录数
      ,SUM(PO.InputQty)                                     AS 送检量
      ,SUM(PO.GOODQTY)                                      AS 良品量
      ,SUM(PO.SCRAPQTY)                                     AS 报废量
      ,ROUND(100.0*SUM(PO.GOODQTY)/NULLIF(SUM(PO.InputQty),0),1) AS 合格率
FROM TBLWIPCONT_PARTIALOUT PO
LEFT JOIN tblOPBasis OP ON PO.OPNo=OP.OPNO
WHERE ('' = '{{date}}' OR CONVERT(CHAR(10),PO.EventTime,120)='{{date}}')
GROUP BY CASE WHEN PO.OPNo LIKE 'OP-CQSPR%' THEN '弹簧线'
              WHEN PO.OPNo LIKE 'OP-CQSTB%' THEN '稳定杆线' ELSE '其他' END
        ,PO.OPNo, OP.OPNAME
ORDER BY 报废量 DESC;

/*—— ⑥ 不良按工序×设备: 定位"哪道工序哪个设备"质量问题（date='' 全量累计） ——
 * 设备: 经 LOGGROUPSERIAL→TBLWIPCONT_EQUIPMENT 取最早一台；主原因=该工序不良量最大原因(工序级)
 */
SELECT E.OPNO                                              AS 工序
      ,ISNULL(OP.OPNAME,'')                                AS 工序名
      ,ISNULL(D.EQUIPMENTNO,'')                            AS 设备
      ,COUNT(*)                                            AS 不良记录数
      ,SUM(E.ERRORQTY)                                     AS 不良量
      ,ISNULL((SELECT TOP 1 R.REASONNAME FROM tblWIPCont_Error E2
               LEFT JOIN TBLQCREASONBASIS R ON E2.ERRORNO=R.REASONNO
               WHERE E2.OPNO=E.OPNO
                 AND (''='{{date}}' OR CONVERT(CHAR(10),E2.EVENTTIME,120)='{{date}}')
               ORDER BY E2.ERRORQTY DESC),'')              AS 主原因
FROM tblWIPCont_Error E
OUTER APPLY (SELECT MIN(EQ.EQUIPMENTNO) EQUIPMENTNO FROM TBLWIPCONT_EQUIPMENT EQ
             WHERE EQ.LOGGROUPSERIAL=E.LOGGROUPSERIAL) D
LEFT JOIN tblOPBasis OP ON E.OPNO=OP.OPNO
WHERE ('' = '{{date}}' OR CONVERT(CHAR(10),E.EVENTTIME,120)='{{date}}')
GROUP BY E.OPNO, OP.OPNAME, D.EQUIPMENTNO
ORDER BY SUM(E.ERRORQTY) DESC;
