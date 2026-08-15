/* ============================================================
 * 重庆 sMES 检验/质检记录 —— SSMS 直接运行版（2026-08-15 导出）
 * ------------------------------------------------------------
 * 【连接信息】
 *   服务器: 172.16.64.11   （重庆独立 sMES，非总部共库）
 *   数据库: sMES_Home_Prod
 *   账号:   只读账号（切勿用 sa / 写账号；注意只跑 SELECT）
 *   SQL Server 身份验证
 *
 * 【用途】不良/送检/首检 三源质检数据：当日质量情况 + 不良 TOP 原因 + 质量问题工序/设备定位，
 *         支撑质量周报与 8-13 重庆质量类问题分析。
 *
 * 【用法】
 *   1. 顶部 @date 变量改日期，F5 一次跑全部 6 个视角
 *   2. 视角②(不良TOP原因)/⑥(工序×设备)设 @date='' 可跑全量累计
 *   3. 想单看某个视角：选中对应 SELECT 段再执行即可
 *   4. 结果可在 SSMS 里「结果→将结果另存为」导出 CSV/Excel
 *
 * 【口径说明】见文件末尾「口径与注意」节，务必先读
 * 【同源同步】本文件与参数化模板 delivery/projects/hw-spring-mes/input/c_q_mes/sql/
 *             重庆检验质检记录-SQL.sql 同源（{{date}} 占位符 → 本版 @date 变量）。
 *             模板口径变更后须同步本文件。
 * ============================================================ */

DECLARE @date VARCHAR(10) = '2026-08-15';   -- 指定日；@date='' 全量（②⑥看累计时用）


/* —— ① 当日不良明细: 不良逐条（@date 指定日；@date='' 全量） —— */
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
WHERE (@date = '' OR CONVERT(CHAR(10),E.EVENTTIME,120)=@date)
ORDER BY E.EVENTTIME;


/* —— ② 不良TOP原因汇总: 不良码×原因 聚合（质量分析核心；@date='' 全量看累计） —— */
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
WHERE (@date = '' OR CONVERT(CHAR(10),E.EVENTTIME,120)=@date)
GROUP BY R.REASONNO, R.REASONNAME, R.REASONTYPE
ORDER BY SUM(E.ERRORQTY) DESC;


/* —— ③ 当日送检明细: 送检逐条（@date 指定日；@date='' 全量） ——
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
WHERE (@date = '' OR CONVERT(CHAR(10),PO.EventTime,120)=@date)
ORDER BY PO.EventTime;


/* —— ④ 当日首检明细: 首检逐条（@date 指定日；@date='' 全量） ——
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
WHERE (@date = '' OR CONVERT(CHAR(10),F.CHECKTIME,120)=@date)
ORDER BY F.CHECKTIME;


/* —— ⑤ 当日送检汇总: 按工序 送检批数/量/良品/报废/合格率（报废量=质量权威信号） ——
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
WHERE (@date = '' OR CONVERT(CHAR(10),PO.EventTime,120)=@date)
GROUP BY CASE WHEN PO.OPNo LIKE 'OP-CQSPR%' THEN '弹簧线'
              WHEN PO.OPNo LIKE 'OP-CQSTB%' THEN '稳定杆线' ELSE '其他' END
        ,PO.OPNo, OP.OPNAME
ORDER BY 报废量 DESC;


/* —— ⑥ 不良按工序×设备: 定位"哪道工序哪个设备"质量问题（@date='' 全量累计） ——
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
                 AND (@date='' OR CONVERT(CHAR(10),E2.EVENTTIME,120)=@date)
               ORDER BY E2.ERRORQTY DESC),'')              AS 主原因
FROM tblWIPCont_Error E
OUTER APPLY (SELECT MIN(EQ.EQUIPMENTNO) EQUIPMENTNO FROM TBLWIPCONT_EQUIPMENT EQ
             WHERE EQ.LOGGROUPSERIAL=E.LOGGROUPSERIAL) D
LEFT JOIN tblOPBasis OP ON E.OPNO=OP.OPNO
WHERE (@date = '' OR CONVERT(CHAR(10),E.EVENTTIME,120)=@date)
GROUP BY E.OPNO, OP.OPNAME, D.EQUIPMENTNO
ORDER BY SUM(E.ERRORQTY) DESC;


/* ============================================================
 * 【口径与注意】—— 用前必读
 * ------------------------------------------------------------
 * 1. 【三张源表】不良=tblWIPCont_Error（按次登记，设备经 LOGGROUPSERIAL→TBLWIPCONT_EQUIPMENT 取最早一台）；
 *    送检=TBLWIPCONT_PARTIALOUT（重庆检验主源，1579条/482批，自带 EQUIPMENTNO，QCFormNo 重庆未填）；
 *    首检=TBLWIPFIRSTCHECK（重庆极少，实测全表仅 1 条）。
 * 2. 【送检量恒等】实测 1579 条全部 INPUTQTY=GOODQTY+SCRAPQTY → ⑤合格率=良品/送检量 口径可靠。
 * 3. 【报废标记】tblWIPCont_Error.SCRAPFLAG 重庆全 0（未启用）——勿用其区分报废/返修；
 *    重庆"报废量"权威信号 = 送检 SCRAPQTY（⑤的报废量列）。
 * 4. 【两源交叉核对】重庆全量实测 不良表 ERRORQTY 合计 502 ⟷ 送检 SCRAPQTY 合计 501，差 1 件——
 *    两源是同一判定(送检时登记不良)的两面，差异即需核查点；勿把两者相加当总量。
 *    8-15 当日两源一致：报废 7 ⟺ 不良 7。
 * 5. 【产线判定】OPNO 前缀 OP-CQSPR%=弹簧线 / OP-CQSTB%=稳定杆线。
 * 6. 【实测洞察(2026-08-15)】TOP 原因=漏油(320)/漆膜不良(115)；最大质量问题设备=
 *    空心杆喷丸喷涂 EQ-CQSTB-PW-01（不良量 438，主因漏油）——可直接支撑质量改善议题。
 * 7. 重庆为独立库独立服务器，无总部共库多厂区前缀问题，无需 prefix 限定。
 * 8. 模板变更后须同步本文件：input/c_q_mes/sql/重庆检验质检记录-SQL.sql（权威参数化版）。
 * ============================================================ */
