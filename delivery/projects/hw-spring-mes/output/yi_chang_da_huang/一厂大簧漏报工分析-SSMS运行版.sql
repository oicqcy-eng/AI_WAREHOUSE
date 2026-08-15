/* ============================================================
 * 一厂大簧 sMES 报工完成度与漏报分析 —— SSMS 直接运行版（2026-08-15 导出）
 * ------------------------------------------------------------
 * 【连接信息】
 *   服务器: 192.168.200.18   （总部 sMES 共库，一厂/二厂/三厂共用，非重庆独立库）
 *   数据库: sMES_Home_Prod
 *   账号:   只读账号（切勿用 sa / 写账号；注意只跑 SELECT）
 *   SQL Server 身份验证
 *
 * 【用途】定位"该报工没走完/漏出站"——一厂报工率低（vs 70% 目标）主因=上料问题，
 *         本查询提供报工流程完成度 + 未完结报工清单，供周会定位卡点（工序/设备/批次）。
 *
 * 【用法】
 *   1. 顶部 @date 变量改日期，F5 一次跑全部 6 个视角
 *   2. 视角②（当日未完结明细）按 @date 查当天上料未走完报工的记录
 *   3. 视角③（滞留未完结）查"当前仍没走完"的报工（与 @date 无关，是当下状态）
 *   4. 想单看某个视角：选中对应 SELECT 段再执行即可
 *   5. 查询结果可在 SSMS 里「结果→将结果另存为」导出 CSV/Excel
 *
 * 【口径说明】见文件末尾「口径与注意」节，务必先读
 * 【同源同步】本文件与通用模板 agent/mes-implement-expert/data/smes-621-sql/
 *             报工完成度与漏报分析-SQL.sql 同源（模板用 {{date}}/{{prefix}} 占位符，
 *             本版硬编码一厂前缀 101-01-DH + @date 变量，口径一致）。模板口径变更后须同步本文件。
 * ============================================================ */

DECLARE @date VARCHAR(10) = '2026-08-14';   -- 改成你要查的日期 YYYY-MM-DD（视角①②④用；③滞留是当下状态与日期无关）


/* —— ① 报工完成度总览（一厂限定；@date 指定则只统计该日；@date='' 全量） ——
 * 已完结=L.ENDTIME非空；未完结=L.ENDTIME空；完成率=已完结/总数
 */
SELECT COUNT(*)                                        AS 报工记录数
      ,SUM(CASE WHEN L.ENDTIME IS NULL THEN 1 ELSE 0 END) AS 未完结数
      ,SUM(CASE WHEN L.ENDTIME IS NOT NULL THEN 1 ELSE 0 END) AS 已完结数
      ,ROUND(100.0 * SUM(CASE WHEN L.ENDTIME IS NOT NULL THEN 1 ELSE 0 END)
              / NULLIF(COUNT(*),0), 1)                 AS 完成率
      ,COUNT(DISTINCT E.EQUIPMENTNO)                   AS 设备数
      ,COUNT(DISTINCT L.LOTNO)                          AS 生产批数
      ,ISNULL(SUM(E.InputQty),0)                        AS 投入
      ,ISNULL(SUM(E.OutputQty),0)                       AS 产出
      ,CONVERT(CHAR(10),MIN(E.STARTTIME),120)           AS 最早
      ,CONVERT(CHAR(10),MAX(E.STARTTIME),120)           AS 最晚
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND L.OPNO <> 'LOTCREATE'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date);


/* —— ② 当日未完结明细: @date 当天进站、仍未完结的报工逐条 ——
 * 信号: 当天上了料/开始报工但报工未走完(未点出站/未点结束)——上料问题排查清单
 * 实测 8-14: 2 条，均卷簧 C01（BJ05 5000/AJ52 1500）
 */
SELECT E.EQUIPMENTNO                      AS 设备
      ,ISNULL(EQP.EquipmentName,'')       AS 设备名
      ,L.LOTNO                            AS 生产批
      ,L.MONO                             AS 工单
      ,L.OPNO                             AS 工序
      ,ISNULL(OP.OPNAME,'')               AS 工序名
      ,E.InputQty                         AS 投入
      ,E.OutputQty                        AS 产出
      ,CONVERT(CHAR(16),E.STARTTIME,120)  AS 设备进站
      ,CONVERT(CHAR(16),E.ENDTIME,120)    AS 设备出站
      ,CONVERT(CHAR(16),L.STARTTIME,120)  AS 报工开始
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
  AND CONVERT(CHAR(10),E.STARTTIME,120) = @date
ORDER BY E.STARTTIME;


/* —— ③ 滞留未完结清单: 当前仍未完结的报工，按进站日分布（与 @date 无关，查"当下"） ——
 * 用途: 看跨天滞留规模——历史进站、至今未走完报工流程的记录（8-14 实测 49 条，最早可追溯到 8-05 前）
 */
SELECT CONVERT(CHAR(10),L.STARTTIME,120)  AS 进站日
      ,COUNT(*)                           AS 滞留未完结数
      ,COUNT(DISTINCT E.EQUIPMENTNO)      AS 设备数
      ,ISNULL(SUM(E.InputQty),0)          AS 滞留投入
      ,ISNULL(SUM(E.OutputQty),0)         AS 滞留产出
      ,DATEDIFF(DAY, MIN(L.STARTTIME), GETDATE()) AS 最早滞留天数
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
GROUP BY CONVERT(CHAR(10),L.STARTTIME,120)
ORDER BY 进站日 DESC;


/* —— ④ 未完结报工按设备汇总（当前滞留合计 + 其中@date当日，定位"卡壳设备"） —— */
SELECT E.EQUIPMENTNO                      AS 设备
      ,ISNULL(EQP.EquipmentName,'')       AS 设备名
      ,COUNT(*)                           AS 未完结报工数
      ,SUM(CASE WHEN CONVERT(CHAR(10),E.STARTTIME,120)=@date THEN 1 ELSE 0 END) AS 其中当日
      ,COUNT(DISTINCT L.LOTNO)            AS 生产批数
      ,ISNULL(SUM(E.InputQty),0)          AS 投入
      ,ISNULL(SUM(E.OutputQty),0)         AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
GROUP BY E.EQUIPMENTNO, EQP.EquipmentName
ORDER BY COUNT(*) DESC;


/* —— ⑤ 未完结报工按工序汇总（定位"卡壳工序"——8-14 实测卷簧 C01 占 102 条绝对主体） —— */
SELECT L.OPNO                             AS 工序
      ,ISNULL(OP.OPNAME,'')               AS 工序名
      ,COUNT(*)                           AS 未完结报工数
      ,COUNT(DISTINCT E.EQUIPMENTNO)      AS 设备数
      ,ISNULL(SUM(E.InputQty),0)          AS 投入
      ,ISNULL(SUM(E.OutputQty),0)         AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND L.OPNO <> 'LOTCREATE'
  AND L.ENDTIME IS NULL
GROUP BY L.OPNO, OP.OPNAME
ORDER BY COUNT(*) DESC;


/* —— ⑥ 按天完成率趋势: 每天报工记录/未完结/完成率（@date='' 全量，看报工率变化趋势） ——
 * 口径: 每天按 E.STARTTIME 归属当日；完成率=当日已完结数/当日记录数（未完结含跨天待完结）
 * 注意: 早于某天的未完结记录会持续计入后续"完成率"分母的未完结，趋势用于看波动而非绝对准确
 */
SELECT CONVERT(CHAR(10),E.STARTTIME,120)  AS 日期
      ,COUNT(*)                           AS 报工记录数
      ,SUM(CASE WHEN L.ENDTIME IS NULL THEN 1 ELSE 0 END) AS 未完结数
      ,ROUND(100.0 * SUM(CASE WHEN L.ENDTIME IS NOT NULL THEN 1 ELSE 0 END)
              / NULLIF(COUNT(*),0), 1)    AS 完成率
      ,COUNT(DISTINCT E.EQUIPMENTNO)      AS 设备数
      ,ISNULL(SUM(E.InputQty),0)          AS 投入
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND L.OPNO <> 'LOTCREATE'
GROUP BY CONVERT(CHAR(10),E.STARTTIME,120)
ORDER BY 日期;


/* ============================================================
 * 【口径与注意】—— 用前必读
 * ------------------------------------------------------------
 * 1. 【报工记录】= TBLWIPCONT_EQUIPMENT E JOIN TBLWIPLOTLOG_REPORT L（LOGGROUPSERIAL 关联）
 *    E=设备进出站报工(InputQty/OutputQty=本次投入/产出, STARTTIME=进站)，
 *    L=报工日志(同量; L.STARTTIME=报工开始, L.ENDTIME=报工结束)。
 * 2. 【进行中/未完结判据】= L.ENDTIME IS NULL 且 L.OPNO<>'LOTCREATE'。
 *    注意不是 E.ENDTIME！设备可已出站(E.ENDTIME 非空)但报工日志未完结(L.ENDTIME 空)。
 *    实测样例：进站=报工开始(08:43)、设备已出站、L.ENDTIME 仍空 → 报工流程未走完。
 * 3. 【漏报工信号】L.ENDTIME 空 = 上了料/开始报工但没走完报工流程（一厂"上料问题"的直接证据）。
 * 4. 【完成率口径】已完结数/当日报工记录总数，口径透明可复验。
 *    ⚠️ 本口径 ≠ 客户周会"报工曝光率 51.9%"（后者计算方式未沉淀到仓库，勿直接替代 KPI）。
 *    本查询用途=定位报工卡点（工序/设备/批次），辅助分析上料问题，不作对外 KPI。
 * 5. 【对账（2026-08-15 实测）】一厂 8-14：27 条/未完结 2/投入=产出 80,244，
 *    与已沉淀报表「一厂大簧报工数据报表」完全一致；滞留清单 49 条跨天滞留真实存在。
 *    一厂判定口径：EQUIPMENTNO 前 10 位 = '101-01-DH' → 一厂大簧（229 台）；无此前缀=二厂大簧。
 * 6. 共库多厂区并存，本文件全部视角已内建 '101-01-DH%' 前缀限定，勿改。
 * 7. 模板变更后须同步本文件：agent/mes-implement-expert/data/smes-621-sql/
 *    报工完成度与漏报分析-SQL.sql（权威模板，含 {{prefix}}/{{date}} 占位符）。
 * ============================================================ */
