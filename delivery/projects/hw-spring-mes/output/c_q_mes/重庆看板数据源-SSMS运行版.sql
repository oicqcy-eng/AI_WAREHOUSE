/* ============================================================
 * 重庆 sMES 看板数据源 —— SSMS 直接运行版（2026-08-15 导出）
 * ------------------------------------------------------------
 * 【连接信息】
 *   服务器: 172.16.64.11   （重庆独立 sMES，非总部共库）
 *   数据库: sMES_Home_Prod
 *   账号:   只读账号（切勿用 sa / 写账号；注意只跑 SELECT）
 *   SQL Server 身份验证
 *
 * 【用途】重庆看板（8-21 初版节点）数据源：在制品分布/设备状态/当日产出/人员现况
 * 【用法】
 *   1. 顶部 @date 变量改日期（视角③④⑤当日产出用），F5 一次跑全部 6 个视角
 *   2. 视角①在制品分布/②在制品明细/③设备状态 = 当前实时状态，与 @date 无关
 *   3. 想单看某个视角：选中对应 SELECT 段再执行即可
 *   4. 结果可在 SSMS 里「结果→将结果另存为」导出 CSV/Excel
 *
 * 【口径说明】见文件末尾「口径与注意」节，务必先读
 * 【同源同步】本文件与参数化模板 delivery/projects/hw-spring-mes/input/c_q_mes/sql/
 *             重庆看板数据源-SQL.sql 同源（{{date}} 占位符 → 本版 @date 变量）。模板口径变更后须同步本文件。
 * ============================================================ */

DECLARE @date VARCHAR(10) = '2026-08-14';   -- 当日产出视角用；空='' 全量


/* —— ① 在制品分布: 产线×工序×状态 汇总（当前在制批，CURQTY 求和） —— */
SELECT CASE WHEN ISNULL(S.PSNO,'') LIKE 'CQSPR%' OR ISNULL(S.AREANO,'') LIKE 'QY-CQSPR%' THEN '弹簧线(CQSPR)'
            WHEN ISNULL(S.PSNO,'') LIKE 'CQSTB%' OR ISNULL(S.AREANO,'') LIKE 'QY-CQSTB%' THEN '稳定杆线(CQSTB)'
            ELSE '其他' END                        AS 产线
      ,S.OPNO                                     AS 工序
      ,CASE S.STATUS WHEN 0 THEN '排队' WHEN 1 THEN '运行' WHEN 2 THEN '暂停'
                     WHEN 9 THEN 'SPC检验' WHEN 22 THEN '制程检验' ELSE CONVERT(VARCHAR,S.STATUS) END AS 状态
      ,COUNT(*)                                   AS 在制批数
      ,ISNULL(SUM(S.CURQTY),0)                    AS 在制数量
FROM TBLWIPLOTSTATE S
WHERE S.STATUS IN (0,1,2,9,22)
GROUP BY CASE WHEN ISNULL(S.PSNO,'') LIKE 'CQSPR%' OR ISNULL(S.AREANO,'') LIKE 'QY-CQSPR%' THEN '弹簧线(CQSPR)'
              WHEN ISNULL(S.PSNO,'') LIKE 'CQSTB%' OR ISNULL(S.AREANO,'') LIKE 'QY-CQSTB%' THEN '稳定杆线(CQSTB)'
              ELSE '其他' END
        ,S.OPNO
        ,CASE S.STATUS WHEN 0 THEN '排队' WHEN 1 THEN '运行' WHEN 2 THEN '暂停'
                       WHEN 9 THEN 'SPC检验' WHEN 22 THEN '制程检验' ELSE CONVERT(VARCHAR,S.STATUS) END
ORDER BY 产线, 在制数量 DESC;


/* —— ② 在制品明细: 当前在制批清单（批号/工单/产品/工序/状态/数量/区段/最后事件） ——
 * 关联: TBLWIPLOTBASIS(主批号 BASELOTNO→MONO/产品)，产品名 TBLPRDPRODUCTBASIS
 */
SELECT S.LOTNO                                    AS 生产批
      ,ISNULL(B.MONO,'')                          AS 工单
      ,ISNULL(P.PRODUCTNAME,'')                   AS 产品名
      ,S.OPNO                                     AS 工序
      ,CASE S.STATUS WHEN 0 THEN '排队' WHEN 1 THEN '运行' WHEN 2 THEN '暂停'
                     WHEN 9 THEN 'SPC检验' WHEN 22 THEN '制程检验' ELSE CONVERT(VARCHAR,S.STATUS) END AS 状态
      ,S.CURQTY                                   AS 当前量
      ,ISNULL(S.PSNO,'')                          AS 区段
      ,ISNULL(S.AREANO,'')                        AS 区域
      ,CONVERT(CHAR(16),S.EVENTTIME,120)          AS 最后事件
FROM TBLWIPLOTSTATE S
LEFT JOIN TBLWIPLOTBASIS B ON S.LOTNO = B.BASELOTNO
LEFT JOIN TBLPRDPRODUCTBASIS P ON B.PRODUCTNO = P.PRODUCTNO AND B.PRODUCTVERSION = P.PRODUCTVERSION
WHERE S.STATUS IN (0,1,2,9,22)
ORDER BY S.STATUS, S.EVENTTIME DESC;


/* —— ③ 设备状态: 每设备最新状态日志 + @date 当天是否报工（产线×状态汇总） ——
 * 最新状态=MAX(STARTTIME)那条；当天报工=TBLWIPCONT_EQUIPMENT 当日有记录(活动=在加工)
 * ⚠️ 状态日志仅覆盖部分设备(重庆 29/98)，无日志但有当日报工=按"加工中"处理
 */
SELECT CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线'
            WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线' ELSE '其他' END AS 产线
      ,CASE WHEN LS.EQUIPMENTSTATE IS NULL AND ACT.EQUIPMENTNO IS NOT NULL THEN '加工(当日有报工)'
            ELSE ISNULL(LS.STATENAME,'未记录') END AS 设备状态
      ,COUNT(*)                                   AS 设备数
FROM TBLEQPEQUIPMENTBASIS E
LEFT JOIN (SELECT s.EQUIPMENTNO, s.EQUIPMENTSTATE,
                  CASE s.EQUIPMENTSTATE WHEN 0 THEN '闲置' WHEN 1 THEN '加工' WHEN 2 THEN '故障'
                                        WHEN 3 THEN '维修' WHEN 4 THEN '保养' WHEN 5 THEN '暂停'
                                        WHEN 6 THEN '设置' WHEN 7 THEN '关机' ELSE CONVERT(VARCHAR,s.EQUIPMENTSTATE) END AS STATENAME
           FROM TBLEMSEQUIPMENTSTATELOG s
           JOIN (SELECT EQUIPMENTNO, MAX(STARTTIME) mx FROM TBLEMSEQUIPMENTSTATELOG GROUP BY EQUIPMENTNO) t
             ON s.EQUIPMENTNO = t.EQUIPMENTNO AND s.STARTTIME = t.mx) LS
  ON E.EQUIPMENTNO = LS.EQUIPMENTNO
LEFT JOIN (SELECT DISTINCT EQUIPMENTNO FROM TBLWIPCONT_EQUIPMENT
           WHERE CONVERT(CHAR(10),STARTTIME,120) = @date) ACT
  ON E.EQUIPMENTNO = ACT.EQUIPMENTNO
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线'
              WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线' ELSE '其他' END
        ,CASE WHEN LS.EQUIPMENTSTATE IS NULL AND ACT.EQUIPMENTNO IS NOT NULL THEN '加工(当日有报工)'
              ELSE ISNULL(LS.STATENAME,'未记录') END
ORDER BY 产线, 设备状态;


/* —— ④ 当日产出: 产线×工序 汇总（@date 指定日；@date='' 全量） —— */
SELECT CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线(CQSPR)'
            WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线(CQSTB)'
            ELSE '其他' END                       AS 产线
      ,L.OPNO                                     AS 工序
      ,ISNULL(OP.OPNAME,'')                       AS 工序名
      ,COUNT(*)                                   AS 报工记录数
      ,COUNT(DISTINCT L.LOTNO)                    AS 生产批数
      ,ISNULL(SUM(E.InputQty),0)                  AS 投入
      ,ISNULL(SUM(E.OutputQty),0)                 AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
GROUP BY CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线(CQSPR)'
              WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线(CQSTB)'
              ELSE '其他' END
        ,L.OPNO, OP.OPNAME
ORDER BY 产线, 投入 DESC;


/* —— ⑤ 当日产出: 按设备明细（@date 指定日；@date='' 全量） —— */
SELECT E.EQUIPMENTNO                               AS 设备
      ,ISNULL(EQP.EquipmentName,'')                AS 设备名
      ,CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线' ELSE '稳定杆线' END AS 产线
      ,COUNT(*)                                    AS 报工记录数
      ,COUNT(DISTINCT L.LOTNO)                     AS 生产批数
      ,ISNULL(SUM(E.InputQty),0)                   AS 投入
      ,ISNULL(SUM(E.OutputQty),0)                  AS 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date = '' OR CONVERT(CHAR(10),E.STARTTIME,120) = @date)
GROUP BY E.EQUIPMENTNO, EQP.EquipmentName,
         CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线' ELSE '稳定杆线' END
ORDER BY 投入 DESC;


/* —— ⑥ 人员现况: 当前登录操作人员（DISTINCT 防同人同班重复行） —— */
SELECT DISTINCT O.USERNO                          AS 工号
      ,ISNULL(U.USERNAME,'')                      AS 姓名
      ,O.SHIFTNO                                  AS 班次
      ,CONVERT(CHAR(10),O.WORKDATE,120)           AS 工作日期
      ,CONVERT(CHAR(16),MAX(O.LOGINDATE),120)     AS 最近登录
FROM TBLWIPOPERATORSTATE O
LEFT JOIN TBLUSRUSERBASIS U ON O.USERNO = U.USERNO
GROUP BY O.USERNO, U.USERNAME, O.SHIFTNO, CONVERT(CHAR(10),O.WORKDATE,120)
ORDER BY 工作日期 DESC, 工号;


/* ============================================================
 * 【口径与注意】—— 用前必读
 * ------------------------------------------------------------
 * 1. 【在制品】= TBLWIPLOTSTATE（生产批状态，每工序一行，CURQTY=当前量）：
 *    STATUS 0 Queue排队 / 1 Running运行 / 2 Wait暂停 / 9 SPC检验 / 22 制程检验 = 在制；
 *    11 良品线边仓 / 12 不良品线边仓 = 已下线入边仓（非在制，如需列示另查）。
 *    重庆实测(2026-08-15)：0=233条 / 1=30条 / 11=147 / 12=39。
 * 2. 【产线判定】区段 PSNO 前缀（CQSPR-RJ=弹簧线冷卷 / CQSTB-KX=稳定杆线），兜底 AREANO（QY-CQSPR%）。
 * 2.5【工序译名】重庆 OPNO 译名以工序作业站字典为准，勿凭记忆：LW=冷弯（非拉弯，用户确认）、
 *     RCL-H=热处理、DD-H=电镀、PWPT-H=喷丸、LHZP-H=冷弯分组、MM=磨面、FZBZ-H=分组包装。
 * 3. 【设备状态】= TBLEMSEQUIPMENTSTATELOG 每设备最新一条(MAX STARTTIME)：
 *    EQUIPMENTSTATE 0闲置/1加工/2故障/3维修/4保养/5暂停/6设置/7关机。
 *    ⚠️ 重庆状态日志仅 29/98 台有记录 → 无日志但当天有报工 = "加工(当日有报工)"补全；
 *    无日志且无当日报工 = "未记录"（可能未开机/待机，勿臆断）。
 * 4. 【当日产出】= 报工链路 E(设备进出站) JOIN L(报工日志) 经 LOGGROUPSERIAL；
 *    InputQty/OutputQty=本次报工投入/产出，按 E.STARTTIME 过滤当日。
 *    对账(2026-08-15)：8-14 重庆 19 条(弹簧线 4/稳定杆线 15)、投入 14,672 产出 13,975，与重庆报工报表一致。
 * 5. 【人员现况】= TBLWIPOPERATORSTATE 按事件记，同人同班多行→DISTINCT(USERNO,WORKDATE)。
 * 6. 模板变更后须同步本文件：input/c_q_mes/sql/重庆看板数据源-SQL.sql（权威参数化版）。
 * ============================================================ */
