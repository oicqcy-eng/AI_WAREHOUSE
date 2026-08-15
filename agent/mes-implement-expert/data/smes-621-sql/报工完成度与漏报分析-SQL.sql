/*报工完成度与漏报分析 —— 定位"该报工没走完/漏出站"（6视角，2026-08-15 实战沉淀）
 * 库: sMES_Home_Prod 共库（--profile home）；重庆/泽根为独立服务器走各自 --profile
 * 用法: node tools/query-mes.js 本文件 --profile home -p prefix=101-01-DH -p date=2026-08-14 --show N
 *   prefix=厂区设备前缀(见 设备编号前缀-厂区映射.md): 一厂大簧=101-01-DH、三厂小簧=X%、金晟=JS-* 等
 *   date=YYYY-MM-DD 指定日；date='' 则全量(①完成度/⑥趋势适用)
 *   N=1 完成度总览 / 2 当日未完结明细 / 3 滞留未完结清单 / 4 未完结按设备 / 5 未完结按工序 / 6 按天完成率趋势
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 *
 * ── 核心概念与口径（务必先读）────────────────────────────
 * 【报工记录】= TBLWIPCONT_EQUIPMENT E JOIN TBLWIPLOTLOG_REPORT L（经 LOGGROUPSERIAL）
 *             E=设备进出站报工(InputQty/OutputQty=本次投入/产出, STARTTIME=进站)，
 *             L=报工日志(同量; L.STARTTIME=报工开始, L.ENDTIME=报工结束)。
 *             E 与 L 通过 LOGGROUPSERIAL 1:1~1:N（分次续报=同批同工序一天多次进出站，同组多行 E）。
 * 【进行中/未完结判据（2026-08-15 实测确认）】= L.ENDTIME IS NULL 且 L.OPNO <> 'LOTCREATE'
 *             ——注意不是 E.ENDTIME！设备可已出站(E.ENDTIME 非空)但报工日志未完结(L.ENDTIME 空)。
 *             实测样例：进站=报工开始(08:43)、设备已出站、L.ENDTIME 仍空→报工流程未走完。
 * 【漏报工信号】L.ENDTIME 空 = 上了料/开始报工但没走完报工流程（一厂"上料问题"主因的直接证据）。
 * 【完成率】已完结数 / 当日报工记录总数（口径透明可复验；≠客户周会"报工曝光率"，后者口径未沉淀，
 *            本查询提供的是"报工流程完成度"，用于定位卡点，勿直接替代客户 KPI）。
 * 【共库注意】Home 共库多厂区并存，全部视角必须带 prefix 限定(LOGGROUPSERIAL∈厂区设备报工组)。
 * 【口径变更日志】2026-08-15 初版——报工完成度/漏报分析（对账: 一厂8-14 27条/80,244/未完结2 与
 *             已沉淀报表完全一致；滞留清单 8-14~8-15 实测 49 条未完结跨天滞留真实存在）
 */

/*—— ① 完成度总览(prefix 限定; date 指定则只统计该日; date='' 全量) ——
 * 已完结 = L.ENDTIME 非空；未完结 = L.ENDTIME 空；完成率 = 已完结/总数
 */
SELECT COUNT(*)                                   AS 报工记录数
      ,SUM(CASE WHEN L.ENDTIME IS NULL THEN 1 ELSE 0 END) AS 未完结数
      ,SUM(CASE WHEN L.ENDTIME IS NOT NULL THEN 1 ELSE 0 END) AS 已完结数
      ,ROUND(100.0 * SUM(CASE WHEN L.ENDTIME IS NOT NULL THEN 1 ELSE 0 END)
              / NULLIF(COUNT(*),0), 1)            AS 完成率
      ,COUNT(DISTINCT E.EQUIPMENTNO)              AS 设备数
      ,COUNT(DISTINCT L.LOTNO)                     AS 生产批数
      ,ISNULL(SUM(E.InputQty),0)                   AS 投入
      ,ISNULL(SUM(E.OutputQty),0)                  AS 产出
      ,CONVERT(CHAR(10),MIN(E.STARTTIME),120)      AS 最早
      ,CONVERT(CHAR(10),MAX(E.STARTTIME),120)      AS 最晚
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND L.OPNO <> 'LOTCREATE'
  AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}');

/*—— ② 当日未完结明细: 当天进站、仍未完结的报工逐条（-p date=YYYY-MM-DD 必填） ——
 * 信号: 当天上了料/开始报工但报工未走完(未点出站/未点结束)的记录——上料问题排查清单
 */
SELECT E.EQUIPMENTNO                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')     AS 设备名
      ,L.LOTNO                          AS 生产批
      ,L.MONO                           AS 工单
      ,L.OPNO                           AS 工序
      ,ISNULL(OP.OPNAME,'')             AS 工序名
      ,E.InputQty                       AS 投入
      ,E.OutputQty                      AS 产出
      ,CONVERT(CHAR(16),E.STARTTIME,120) AS 设备进站
      ,CONVERT(CHAR(16),E.ENDTIME,120)  AS 设备出站
      ,CONVERT(CHAR(16),L.STARTTIME,120) AS 报工开始
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
  AND CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}'
ORDER BY E.STARTTIME;

/*—— ③ 滞留未完结清单: 当前仍未完结的报工，按进站日分布（与 date 无关，查的是"当下"） ——
 * 用途: 看跨天滞留规模——历史进站、至今未走完报工流程的记录（如 8-13 进站、8-15 仍未完结）
 * 含滞留天数 = DATEDIFF(DAY, 进站日, 今天)
 */
SELECT CONVERT(CHAR(10),L.STARTTIME,120) AS 进站日
      ,COUNT(*)                          AS 滞留未完结数
      ,COUNT(DISTINCT E.EQUIPMENTNO)     AS 设备数
      ,ISNULL(SUM(E.InputQty),0)         AS 滞留投入
      ,ISNULL(SUM(E.OutputQty),0)        AS 滞留产出
      ,DATEDIFF(DAY, MIN(L.STARTTIME), GETDATE()) AS 最早滞留天数
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
GROUP BY CONVERT(CHAR(10),L.STARTTIME,120)
ORDER BY 进站日 DESC;

/*—— ④ 未完结报工按设备汇总（当前滞留+当日合计，定位"卡壳设备"） ——*/
SELECT E.EQUIPMENTNO                      AS 设备
      ,ISNULL(EQP.EquipmentName,'')       AS 设备名
      ,COUNT(*)                           AS 未完结报工数
      ,SUM(CASE WHEN CONVERT(CHAR(10),E.STARTTIME,120)='{{date}}' THEN 1 ELSE 0 END) AS 其中当日
      ,COUNT(DISTINCT L.LOTNO)            AS 生产批数
      ,ISNULL(SUM(E.InputQty),0)          AS 投入
      ,ISNULL(SUM(E.OutputQty),0)         AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
GROUP BY E.EQUIPMENTNO, EQP.EquipmentName
ORDER BY COUNT(*) DESC;

/*—— ⑤ 未完结报工按工序汇总（定位"卡壳工序"，如上料问题集中在卷簧 C01/热卷 H03） ——*/
SELECT L.OPNO                            AS 工序
      ,ISNULL(OP.OPNAME,'')              AS 工序名
      ,COUNT(*)                          AS 未完结报工数
      ,COUNT(DISTINCT E.EQUIPMENTNO)     AS 设备数
      ,ISNULL(SUM(E.InputQty),0)         AS 投入
      ,ISNULL(SUM(E.OutputQty),0)        AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
GROUP BY L.OPNO, OP.OPNAME
ORDER BY COUNT(*) DESC;

/*—— ⑥ 按天完成率趋势: 每天报工记录/未完结/完成率（date='' 全量；看报工率变化趋势） ——
 * 口径: 每天按 E.STARTTIME 归属当日; 完成率=当日已完结数/当日记录数(未完结含跨天待完结)
 * 注意: 早于某天的未完结记录会持续计入后续"完成率"分母的未完结，趋势用于看波动而非绝对准确
 */
SELECT CONVERT(CHAR(10),E.STARTTIME,120) AS 日期
      ,COUNT(*)                          AS 报工记录数
      ,SUM(CASE WHEN L.ENDTIME IS NULL THEN 1 ELSE 0 END) AS 未完结数
      ,ROUND(100.0 * SUM(CASE WHEN L.ENDTIME IS NOT NULL THEN 1 ELSE 0 END)
              / NULLIF(COUNT(*),0), 1)   AS 完成率
      ,COUNT(DISTINCT E.EQUIPMENTNO)     AS 设备数
      ,ISNULL(SUM(E.InputQty),0)         AS 投入
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND L.OPNO <> 'LOTCREATE'
GROUP BY CONVERT(CHAR(10),E.STARTTIME,120)
ORDER BY 日期;
