/*重庆批次追溯全链路 —— 生产批→工序历程→检验(送检/首检)→不良（6视角，2026-08-15 实战沉淀）
 * 库: 重庆独立 sMES（172.16.64.11/sMES_Home_Prod，--profile cq）
 * 用法: node query-mes.js 本文件 --profile cq -p lotno=MO1072608140002-001 --show N
 *   lotno=生产批号（必填，形如 MO1072608140002-001；子批可填 MO1072608140002-001-SP01）
 *   N=1 批基本信息 / 2 工序报工历程 / 3 检验记录(送检+首检) / 4 不良明细 / 5 序列号清单 / 6 追溯汇总
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 *
 * ── 核心口径与实测结论（务必先读）────────────────────────
 * 【链路】TBLWIPLOTBASIS(批主档) → TBLWIPLOTLOG_REPORT(工序报工, 含 FAILQTY 不良量)
 *        → TBLWIPCONT_PARTIALOUT(送检, 重庆检验主数据源) / TBLWIPFIRSTCHECK(首检, 重庆极少)
 *        → tblWIPCont_Error(不良, 按批记) ；序列号 tblWIPCont_PCSNo ⚠️重庆空表(0条)未启用
 * 【检验主源=送检】重庆实测 TBLWIPCONT_PARTIALOUT 1579 条/482 批，TBLWIPFIRSTCHECK 仅 1 批——
 *        重庆检验流程走「送检」(PARTIALOUT)，首检几乎不用；QCFormNo 列重庆未填(空)。
 * 【三角对账(2026-08-15 实测, 批 MO1072608140002-001)】磨面工序：
 *        报工 FAILQTY=7 ⟺ 不良表 ERRORQTY=7(磨面不平) ⟺ 送检 SCRAPQTY=7(送355/良品348) —— 三者完全一致。
 * 【序列号】tblWIPCont_PCSNo 重庆 0 条——未启用按件/序号追踪，追溯粒度到"批"；
 *        如需按件追溯：不良表有 PCSNo 列(重庆为空)、送检表为批粒度，方案设计时勿假设有序列号。
 * 【追溯汇总】按工序：投入 INPUTQTY / 良品 GOODQTY / 不良 FAILQTY / 送检报废(SCRAPQTY)；
 *        良品率 = GOODQTY / INPUTQTY。
 * 【口径变更日志】2026-08-15 初版——重庆批次追溯（支撑 8-13 重庆"批次追溯方案缺失"P2 数据侧）
 */

/*—— ① 批基本信息: 批主档+产品+客户（-p lotno=生产批号） ——*/
SELECT B.BASELOTNO                                  AS 生产批
      ,ISNULL(B.ORGLOTNO,'')                        AS 原始批
      ,ISNULL(B.MONO,'')                            AS 工单
      ,B.PRODUCTNO                                  AS 产品编号
      ,ISNULL(P.PRODUCTNAME,'')                     AS 产品名
      ,ISNULL(C.CUSTOMERNAME,'')                    AS 客户
      ,B.INPUTQTY                                   AS 投入数量
      ,CASE B.LOTSTATE WHEN 0 THEN '未下线' WHEN 1 THEN '已下线'
                       WHEN 99 THEN '转库结批' WHEN 100 THEN '分批结批'
                       WHEN 101 THEN '并批结批' ELSE CONVERT(VARCHAR,B.LOTSTATE) END AS 批状态
      ,CONVERT(CHAR(16),B.CREATEDATE,120)           AS 开批时间
      ,ISNULL(B.DEVICENO,'')                        AS 开批设备
FROM TBLWIPLOTBASIS B
LEFT JOIN TBLPRDPRODUCTBASIS P ON B.PRODUCTNO = P.PRODUCTNO AND B.PRODUCTVERSION = P.PRODUCTVERSION
LEFT JOIN TBLENTCUSTOMERBASIS C ON B.CUSTOMERNO = C.CUSTOMERNO
WHERE B.BASELOTNO = '{{lotno}}';

/*—— ② 工序报工历程: 该批各工序报工（投入/良品/不良/起止/设备） ——
 * 设备: TBLWIPCONT_EQUIPMENT 经 LOGGROUPSERIAL 关联（同组取一条，若分次续报多行取最早设备）
 * 注: FAILQTY=该工序报工不良量，与④不良明细 ERRORQTY 应一致（实测三角对账通过）
 */
SELECT L.OPNO                                      AS 工序
      ,ISNULL(OP.OPNAME,'')                        AS 工序名
      ,L.INPUTQTY                                  AS 投入
      ,L.GOODQTY                                   AS 良品
      ,L.FAILQTY                                   AS 不良
      ,ISNULL((SELECT MIN(E.EQUIPMENTNO) FROM TBLWIPCONT_EQUIPMENT E WHERE E.LOGGROUPSERIAL=L.LOGGROUPSERIAL),'') AS 设备
      ,CONVERT(CHAR(16),L.STARTTIME,120)           AS 开始
      ,CONVERT(CHAR(16),L.ENDTIME,120)             AS 结束
FROM TBLWIPLOTLOG_REPORT L
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE L.LOTNO = '{{lotno}}' AND L.OPNO <> 'LOTCREATE'
ORDER BY L.STARTTIME;

/*—— ③ 检验记录: 送检(PARTIALOUT) + 首检(FIRSTCHECK) 合并，按时间排序 ——
 * ⚠️ 重庆检验主源=送检（1579条/482批），首检极少；QCFormNo 重庆未填
 */
SELECT X.工序
      ,X.类型
      ,X.检验量
      ,X.良品量
      ,X.[报废/不良量]
      ,X.检验员
      ,X.设备
      ,X.检验单号
      ,X.时间
FROM (SELECT L.OPNO                       AS 工序
            ,N'送检'                      AS 类型
            ,L.INPUTQTY                   AS 检验量
            ,L.GOODQTY                    AS 良品量
            ,L.SCRAPQTY                   AS [报废/不良量]
            ,ISNULL(L.UserNo,'')          AS 检验员
            ,ISNULL(L.EQUIPMENTNO,'')     AS 设备
            ,ISNULL(L.QCFormNo,'')        AS 检验单号
            ,CONVERT(CHAR(16),L.EventTime,120) AS 时间
      FROM TBLWIPCONT_PARTIALOUT L
      WHERE L.LOTNO = '{{lotno}}'
      UNION ALL
      SELECT F.OPNO
            ,N'首检'
            ,F.CHECKQTY
            ,F.CHECKQTY - F.DEFECTQTY
            ,F.DEFECTQTY
            ,ISNULL(F.USERNO,'')
            ,ISNULL(F.EquipmentNo,'')
            ,F.QCFORMNO
            ,CONVERT(CHAR(16),F.CHECKTIME,120)
      FROM TBLWIPFIRSTCHECK F
      WHERE F.LOTNO = '{{lotno}}') X
ORDER BY X.时间;

/*—— ④ 不良明细: 该批不良记录（原因码/原因名/数量/报废/时间） ——
 * 关联: ERRORNO→TBLQCREASONBASIS.REASONNO；报废标记 SCRAPFLAG 0=返修/1=报废(以实测为准)
 */
SELECT E.OPNO                                     AS 工序
      ,E.ERRORNO                                  AS 不良码
      ,ISNULL(R.REASONNAME,'')                    AS 原因名
      ,ISNULL(R.REASONTYPE,0)                     AS 原因类型
      ,E.ERRORQTY                                 AS 数量
      ,E.SCRAPFLAG                                AS 报废标记
      ,ISNULL(E.PCSNo,'')                         AS [序号(重庆空)]
      ,CONVERT(CHAR(16),E.EVENTTIME,120)          AS 时间
      ,ISNULL(E.Creator,'')                       AS 登记人
FROM tblWIPCont_Error E
LEFT JOIN TBLQCREASONBASIS R ON E.ERRORNO = R.REASONNO
WHERE E.LOTNO = '{{lotno}}'
ORDER BY E.EVENTTIME;

/*—— ⑤ 序列号清单: ⚠️重庆 tblWIPCont_PCSNo 空表(0条)——未启用按件追踪 ——
 * 本视角预留：若日后启用按序列号，返回该批各工序的成品序号/状态/设备；当前重庆返回 0 行。
 * 按件追溯方案设计时，勿假设此表有数据（重庆粒度=批）。
 */
SELECT PCSNo                                     AS 成品序号
      ,OPNo                                      AS 工序
      ,ISNULL(PCSStatus,'')                      AS 序号状态
      ,ISNULL(EquipmentNo,'')                    AS 设备
      ,CONVERT(CHAR(16),CreateDate,120)          AS 生成时间
FROM tblWIPCont_PCSNo
WHERE LotNo = '{{lotno}}'
ORDER BY PCSNo;

/*—— ⑥ 追溯汇总: 按工序汇总 投入/良品/不良/送检报废，看批的良品率 ——
 * 良品率 = 良品/投入；送检报废=该工序送检的报废量(独立来源, 可交叉核对)
 */
SELECT L.OPNO                                    AS 工序
      ,ISNULL(OP.OPNAME,'')                      AS 工序名
      ,L.INPUTQTY                                AS 投入
      ,L.GOODQTY                                 AS 良品
      ,L.FAILQTY                                 AS 不良
      ,ROUND(100.0*L.GOODQTY/NULLIF(L.INPUTQTY,0),1) AS 良品率
      ,ISNULL((SELECT SUM(SCRAPQTY) FROM TBLWIPCONT_PARTIALOUT PO WHERE PO.LOTNO=L.LOTNO AND PO.OPNO=L.OPNO),0) AS 送检报废
FROM TBLWIPLOTLOG_REPORT L
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE L.LOTNO = '{{lotno}}' AND L.OPNO <> 'LOTCREATE'
ORDER BY L.STARTTIME;
