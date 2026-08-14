/* ============================================================
 * 重庆 sMES 报工查询 —— SSMS 直接运行版（2026-08-14 导出）
 * ------------------------------------------------------------
 * 【连接信息】
 *   服务器: 172.16.64.11   （重庆独立 sMES，非总部 192.168.200.18）
 *   数据库: sMES_Home_Prod
 *   账号:   只读账号（切勿用 sa / 写账号；本库无 sql 语法限制，注意只跑 SELECT）
 *   SQL Server 身份验证
 *
 * 【用法】
 *   1. 顶部 @date 变量改日期，F5 一次跑全部 6 个视角
 *   2. @date = '' 表示不按日期过滤（全量统计，④⑥会慢）
 *   3. 想单看某个视角：选中对应 SELECT 段再执行即可
 *
 * 【口径说明】见文件末尾「口径与注意」节
 * 【同源同步】本文件与仓库模板 sql/重庆报工查询-SQL.sql 同源（工具版用 {{date}} 占位符，
 *             本版用 @date 变量，口径一致）。模板口径变更后须同步本文件。
 * ============================================================ */

DECLARE @date VARCHAR(10) = '2026-08-14';   -- 改成你要查的日期 YYYY-MM-DD；'' = 全量


/* —— ① 累计概览（全量） —— */
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
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%';


/* —— ② 按产线拆分（累计） —— */
SELECT CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线(CQSPR)'
            WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线(CQSTB)'
            ELSE '其他' END      AS 产线
      ,COUNT(*)                  AS 记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) AS 设备数
      ,COUNT(DISTINCT L.MONO)    AS 工单数
      ,ISNULL(SUM(E.InputQty),0) AS 投入
      ,ISNULL(SUM(E.OutputQty),0)AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线(CQSPR)'
              WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线(CQSTB)'
              ELSE '其他' END
ORDER BY 产线;


/* —— ③ 按天分布（全量） —— */
SELECT CONVERT(CHAR(10),E.STARTTIME,120) AS 日期
      ,COUNT(*)                  AS 记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) AS 设备数
      ,ISNULL(SUM(E.InputQty),0) AS 投入
      ,ISNULL(SUM(E.OutputQty),0)AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY CONVERT(CHAR(10),E.STARTTIME,120)
ORDER BY 日期;


/* —— ④ 指定日明细：设备×生产批×作业站 逐条 —— */
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
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
ORDER BY E.STARTTIME;


/* —— ⑤ 按工单累计汇总 —— */
SELECT L.MONO AS 工单
      ,L.PRODUCTNO AS 产品编号
      ,ISNULL(P.PRODUCTNAME,'') AS 产品名
      ,COUNT(DISTINCT E.EQUIPMENTNO) AS 设备数
      ,ISNULL(SUM(E.InputQty),0) AS 投入
      ,ISNULL(SUM(E.OutputQty),0) AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLPRDPRODUCTBASIS P ON L.PRODUCTNO = P.PRODUCTNO AND L.PRODUCTVERSION = P.PRODUCTVERSION
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY L.MONO, L.PRODUCTNO, P.PRODUCTNAME
ORDER BY L.MONO;


/* —— ⑥ 指定日报工按人员统计（重点：报工人员是谁） —— */
SELECT X.USERNO AS 工号
      ,ISNULL(U.USERNAME,'') AS 姓名
      ,COUNT(*)               AS 报工次数
      ,COUNT(DISTINCT P.LOTNO)AS 生产批
      ,COUNT(DISTINCT P.MONO) AS 工单
      ,SUM(P.INPUTQTY)        AS 投入
      ,SUM(P.GOODQTY + P.FAILQTY) AS 产出
FROM (SELECT DISTINCT USERNO, LOGGROUPSERIAL
      FROM TBLWIPCont_Resource
      WHERE @date = '' OR CONVERT(CHAR(10),EVENTTIME,120) = @date) X
LEFT JOIN TBLUSRUSERBASIS U ON X.USERNO = U.USERNO
JOIN (SELECT LOGGROUPSERIAL, INPUTQTY, GOODQTY, FAILQTY, LOTNO, MONO
      FROM TBLWIPLOTLOG_REPORT
      WHERE OPNO <> 'LOTCREATE'
        AND LOGGROUPSERIAL IN (SELECT DISTINCT LOGGROUPSERIAL
                               FROM TBLWIPCont_Resource
                               WHERE @date = '' OR CONVERT(CHAR(10),EVENTTIME,120) = @date)) P
  ON X.LOGGROUPSERIAL = P.LOGGROUPSERIAL
GROUP BY X.USERNO, U.USERNAME
ORDER BY SUM(P.INPUTQTY) DESC;


/* ============================================================
 * 口径与注意（重要）
 * ------------------------------------------------------------
 * 1. 本次报工投入/产出 = TBLWIPLOTLOG_REPORT 的
 *    INPUTQTY(投入) / GOODQTY(良品)+FAILQTY(不良)；
 *    TBLWIPCONT_EQUIPMENT 的 InputQty/OutputQty 是生产批累计值，
 *    同一生产批多次进出会变大，别拿它当"单次报工量"。
 * 2. 报工人员不在设备进出站表（Creator 为空），须从
 *    TBLWIPCont_Resource.USERNO 取（按 EVENTTIME 过滤）。
 * 3. 同一报工组（LOGGROUPSERIAL）可能多人协作 → 每人各计一次，
 *    ⑥的人员口径投入/产出总和会大于报工日志总量，对表时注意。
 * 4. 进行中报工（TBLWIPLOTLOG_REPORT.ENDTIME 为空）⑥也会统计，
 *    其投入为当前累计值（如 LW 拉弯 20000→2771 未闭环）。
 * 5. DS 账号 = 系统管理员代报（2026-08-14 用户确认），
 *    想只看真实车间报工可加  AND X.USERNO <> 'DS'。
 * 6. OPNO='LOTCREATE' 是开批记录，非报工，已排除。
 * ============================================================ */
