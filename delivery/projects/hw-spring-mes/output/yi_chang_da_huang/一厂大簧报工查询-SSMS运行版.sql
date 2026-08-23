/* ============================================================
 * 一厂大簧 sMES 报工查询 —— SSMS 直接运行版（2026-08-15 导出）
 * ------------------------------------------------------------
 * 【连接信息】
 *   服务器: 192.168.200.18   （总部 sMES 共库，一厂/二厂/三厂共用，非重庆独立库）
 *   数据库: sMES_Home_Prod
 *   账号:   只读账号（切勿用 sa / 写账号；本库无 sql 语法限制，注意只跑 SELECT）
 *   SQL Server 身份验证
 *
 * 【用法】
 *   1. 顶部 @date 变量改日期，F5 一次跑全部 6 个视角
 *   2. @date = '' 表示不按日期过滤（全量统计，②⑥会慢）
 *   3. 想单看某个视角：选中对应 SELECT 段再执行即可
 *   4. 查询结果可在 SSMS 里「结果→将结果另存为」导出 CSV/Excel
 *
 * 【口径说明】见文件末尾「口径与注意」节
 * 【同源同步】本文件与通用模板 agent/mes-implement-expert/data/smes-621-sql/
 *             今日设备报工查询-SQL.sql 同源（模板用 {{date}}/{{prefix}} 占位符，
 *             本版硬编码一厂前缀 101-01-DH + @date 变量，口径一致）。模板口径变更后须同步本文件。
 * ============================================================ */

DECLARE @date VARCHAR(10) = '2026-08-14';   -- 改成你要查的日期 YYYY-MM-DD；'' = 全量


/* —— ① 累计概览（一厂限定；@date 指定则只统计该日） —— */
SELECT COUNT(*)                 AS 报工记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) AS 设备数
      ,COUNT(DISTINCT L.LOTNO)   AS 生产批数
      ,COUNT(DISTINCT L.MONO)    AS 工单数
      ,ISNULL(SUM(E.InputQty),0) AS 投入总数
      ,ISNULL(SUM(E.OutputQty),0)AS 产出总数
      ,CONVERT(CHAR(10),MIN(E.STARTTIME),120) AS 最早
      ,CONVERT(CHAR(10),MAX(E.STARTTIME),120) AS 最晚
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date);


/* —— ② 按天分布（一厂限定，全量历史，@date 不参与） —— */
SELECT CONVERT(CHAR(10),E.STARTTIME,120) AS 日期
      ,COUNT(*)                  AS 记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) AS 设备数
      ,ISNULL(SUM(E.InputQty),0) AS 投入
      ,ISNULL(SUM(E.OutputQty),0)AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
GROUP BY CONVERT(CHAR(10),E.STARTTIME,120)
ORDER BY 日期;


/* —— ③ 指定日明细：设备×生产批×作业站 逐条 —— */
SELECT E.EQUIPMENTNO AS 设备
      ,ISNULL(EQP.EquipmentName,'') AS 设备名
      ,L.LOTNO AS 生产批
      ,L.OPNO   AS 作业站
      ,ISNULL(OP.OPNAME,'') AS 工序名
      ,E.InputQty AS 投入
      ,E.OutputQty AS 产出
      ,CONVERT(CHAR(16),E.STARTTIME,120) AS 开始
      ,CONVERT(CHAR(16),E.ENDTIME,120) AS 结束
FROM TBLWIPCONT_EQUIPMENT E
LEFT JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
ORDER BY E.STARTTIME;


/* —— ④ 按工单累计汇总（@date 指定则只统计该日） —— */
SELECT L.MONO AS 工单
      ,L.PRODUCTNO AS 产品编号
      ,ISNULL(P.PRODUCTNAME,'') AS 产品名
      ,COUNT(DISTINCT E.EQUIPMENTNO) AS 设备数
      ,ISNULL(SUM(E.InputQty),0) AS 投入
      ,ISNULL(SUM(E.OutputQty),0) AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLPRDPRODUCTBASIS P ON L.PRODUCTNO = P.PRODUCTNO AND L.PRODUCTVERSION = P.PRODUCTVERSION
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
GROUP BY L.MONO, L.PRODUCTNO, P.PRODUCTNAME
ORDER BY L.MONO;


/* —— ⑤ 指定日报工按人员统计（重点：报工人员是谁；量=当天实际报工） ——
 * 注意（2026-08-23 RESCLASS 语义修正）：TBLWIPCont_Resource.RESCLASS
 * 0=EMP人时（USERNO=作业人员）/ 1=EQP机时（USERNO=报工者=操作报工账号）/
 * 4=UCB群组（每笔EMP冗余一行）；参与人员=0∪1 去重（口径B：报工的人也是
 * 一起作业的，用户确认）；同人同组多行，必须 DISTINCT(LOGGROUPSERIAL, USERNO)
 * 防重复，勿把 RESCLASS=4 单独当人员。
 * X 子查询 GROUP BY 聚合成组总量（防分次续报同量合并漏算）；
 * R 子查询按 EVENTTIME 当天过滤（防跨天组历史成员带入今日）。 */
SELECT R.USERNO AS 工号
      ,ISNULL(U.USERNAME,'') AS 姓名
      ,COUNT(DISTINCT X.LOGGROUPSERIAL) AS 报工次数
      ,COUNT(DISTINCT P.LOTNO) AS 生产批
      ,COUNT(DISTINCT P.MONO) AS 工单
      ,ISNULL(SUM(X.InputQty),0) AS 投入
      ,ISNULL(SUM(X.OutputQty),0) AS 产出
FROM (SELECT E.LOGGROUPSERIAL, SUM(E.InputQty) InputQty, SUM(E.OutputQty) OutputQty
      FROM TBLWIPCONT_EQUIPMENT E
      WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
        AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
      GROUP BY E.LOGGROUPSERIAL) X
JOIN (SELECT DISTINCT LOGGROUPSERIAL, USERNO FROM TBLWIPCont_Resource
      WHERE @date = '' OR CONVERT(CHAR(10),EVENTTIME,120) = @date) R
  ON X.LOGGROUPSERIAL = R.LOGGROUPSERIAL
LEFT JOIN TBLUSRUSERBASIS U ON R.USERNO = U.USERNO
LEFT JOIN (SELECT LOGGROUPSERIAL, MAX(LOTNO) LOTNO, MAX(MONO) MONO
           FROM TBLWIPLOTLOG_REPORT WHERE OPNO <> 'LOTCREATE'
           GROUP BY LOGGROUPSERIAL) P
  ON X.LOGGROUPSERIAL = P.LOGGROUPSERIAL
GROUP BY R.USERNO, U.USERNAME
ORDER BY SUM(X.InputQty) DESC;


/* —— ⑥ 按设备汇总（@date 指定则只统计该日） —— */
SELECT E.EQUIPMENTNO AS 设备
      ,ISNULL(EQP.EquipmentName,'') AS 设备名
      ,COUNT(*)                  AS 报工次数
      ,COUNT(DISTINCT L.LOTNO)   AS 生产批数
      ,COUNT(DISTINCT L.MONO)    AS 工单数
      ,ISNULL(SUM(E.InputQty),0) AS 投入
      ,ISNULL(SUM(E.OutputQty),0)AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
WHERE E.EQUIPMENTNO LIKE '101-01-DH%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
GROUP BY E.EQUIPMENTNO, EQP.EquipmentName
ORDER BY SUM(E.InputQty) DESC;


/* ============================================================
 * 口径与注意（重要）
 * ------------------------------------------------------------
 * 1. 一厂大簧判定：EQUIPMENTNO 前 10 位 = '101-01-DH'（229 台）；二厂大簧
 *    无此前缀。Home 共库多厂区并存，本文件所有查询都带 prefix 限定，
 *    否则会统计进其他厂区（②按天/⑥按设备尤甚）。
 * 2. 本次报工投入/产出 = TBLWIPCONT_EQUIPMENT.InputQty/OutputQty
 *    = TBLWIPLOTLOG_REPORT.INPUTQTY / GOODQTY(良品)+FAILQTY(不良)。
 *    ⚠️ 两表逐条一致【仅对无分次续报组成立】（2026-08-14 A3 实测：
 *    当日 27 行中 19 行相等 / 8 行不等，8 行全属 4 个分次续报组——组内
 *    E 单行=该次续报量、L 单行=组总量，E 组内 SUM = L 组总量精确相等）。
 *    注意 TBLWIPCont_Resource.INPUTQTY 是资源加工量（≠本次报工投入），
 *    不要拿它统计投入。
 * 3. 报工人员不在设备进出站表（Creator 为空），须从
 *    TBLWIPCont_Resource.USERNO 取（按 EVENTTIME 过滤）。
 * 4. 同一报工组（LOGGROUPSERIAL）可能多人协作 → 每人各计一次，
 *    ⑤的人员口径总和会略大于报工日志总量（重复计入），对表时注意。
 * 5. ⑤报工量=当天实际报工量（TBLWIPCONT_EQUIPMENT 按 STARTTIME 过滤当日
 *    InputQty/OutputQty），不再携带跨日开批累计；进行中报工（ENDTIME 为空）
 *    计入，产出为当前已出量（可小于投入）。
 * 6. RESCLASS 认知（2026-08-23 字典+实测语义修正，废止 2026-08-14 旧表述）：
 *    RESCLASS 0=EMP人时（USERNO=作业人员）/ 1=EQP机时（USERNO=报工者=操作报工
 *    账号）/ 4=UCB群组（每笔 EMP 冗余一行）。参与人员=0∪1 去重=口径B（用户确认：
 *    报工的人也是一起作业的）。同人同组多行（0/1/4 各一行），必须
 *    DISTINCT(LOGGROUPSERIAL, USERNO)；勿把 RESCLASS=4 单独当人员。
 * 7. DS 账号 = 系统管理员代报（2026-08-14 用户确认），看纯车间报工可加
 *     AND R.USERNO <> 'DS'。
 * 8. OPNO='LOTCREATE' 是开批记录，非报工（⑤已排除；③按进出站逐条，如出现
 *    DEVICENO='Batch' 行即开批，跳过即可）。
 * 9. 分次续报（一厂有，2026-08-14 实测 4 组）：同批同工序一天多次进出站共用
 *    LOGGROUPSERIAL（如 MO1012608100092-001 C02 回火：08:15 AH41 报 1000 +
 *    18:40 AH51 续报 1961），①记录数=真实进出站次数、SUM 精确=组总量（非膨胀）；
 *    ③明细按进出站逐条列 2 行如实反映；⑤⑥已用 GROUP BY 聚合防同量合并漏算。
 * 10. 进行中判据 = TBLWIPLOTLOG_REPORT.ENDTIME 空（设备可能已出站
 *     E.ENDTIME 非空但报工未闭环 L.ENDTIME 空）。
 * ============================================================ */
