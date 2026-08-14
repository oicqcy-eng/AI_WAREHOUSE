/*今日设备报工查询 —— 按厂区设备前缀查报工（6视角，2026-08-14 重庆模式通用化）
 * 库: sMES_Home_Prod 共库（--profile home，总部 192.168.200.18）；重庆/泽根为独立服务器走各自 --profile
 * 用法: node tools/query-mes.js 本文件 --profile home -p prefix=101-01-DH -p date=2026-08-14 --show N
 *   prefix=厂区设备前缀(见 设备编号前缀-厂区映射.md): 一厂大簧=101-01-DH、三厂小簧=X%、金晟=JS-* 等
 *   date=YYYY-MM-DD 指定日；date='' 则全量(累计/按天/工单视角适用, 明细/人员/设备视角会慢)
 *   N=1 累计概览 / 2 按天分布 / 3 指定日明细 / 4 按工单汇总 / 5 按人员统计 / 6 按设备汇总
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 * 核心链路: TBLWIPCONT_EQUIPMENT(设备进出站报工, InputQty/OutputQty=本次报工投入/产出, STARTTIME)
 *          JOIN TBLWIPLOTLOG_REPORT(经 LOGGROUPSERIAL 拿 LOTNO/MONO/PRODUCTNO/OPNO, 与 equipment 同量;
 *              ENDTIME 为空=进行中未出站; OPNO='LOTCREATE' 是开批记录非报工)
 *          注意: TBLWIPCont_Resource.INPUTQTY 为资源加工量(≠本次报工投入), 勿用于投入统计
 * 人员: TBLWIPCont_Resource(资源使用, USERNO=报工人员, EVENTTIME=报工时间) → TBLUSRUSERBASIS(USERNO→USERNAME)
 * 共库注意: Home 共库多厂区并存, 视角⑤按人员/⑥按设备必须带 prefix 限定(LOGGROUPSERIAL∈厂区设备报工组),
 *           否则会统计进其他厂区人员/设备
 * 口径变更日志（改模板必记；改后须同步 厂区报工报表规范.md + 各厂实例说明 + 报表口径注意）:
 *   2026-08-14 V4 审计确认（不改 SQL）：① 分次续报组（同批同工序一天多次进出站）的
 *     E 侧多行是真实报工（白班/晚班各报一次），SUM 精确=组总量非膨胀，COUNT=真实进出站次数；
 *     ② RESCLASS 0/1/4 的 USERNO 均为人员工号，⑤ 必须 DISTINCT(LOGGROUPSERIAL,USERNO)、勿按
 *     RESCLASS=0 过滤——认知修正见 厂区报工报表规范.md 五节速查
 *   2026-08-14 V2→V3: ⑤按人员改为严格当日量——报工量来源从 TBLWIPLOTLOG_REPORT(当前累计,
 *     携带跨日开批量)改为 TBLWIPCONT_EQUIPMENT(按 STARTTIME 过滤当日, InputQty/OutputQty),
 *     每人=当天实际报工量; 与重庆模板/SSMS 运行版同步修改
 *   2026-08-14 V1→V2: 重庆报工模式通用化——3视角扩为6视角(①累计 ②按天 ③明细 ④工单 ⑤人员 ⑥设备),
 *     对齐重庆报表板块; ⑤按人员新增 prefix 限定(共库多厂区必须); ②/④支持 date='' 全量
 *   2026-08-14 V1: 初版 3 视角(汇总/明细/工单), 支持 -p prefix + -p date
 */

/*—— ① 累计概览(prefix 限定; date='' 则全量) ——*/
SELECT COUNT(*) 报工记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) 设备数
      ,COUNT(DISTINCT L.LOTNO) 生产批数
      ,COUNT(DISTINCT L.MONO) 工单数
      ,ISNULL(SUM(E.InputQty),0) 投入总数
      ,ISNULL(SUM(E.OutputQty),0) 产出总数
      ,CONVERT(CHAR(10),MIN(E.STARTTIME),120) 最早
      ,CONVERT(CHAR(10),MAX(E.STARTTIME),120) 最晚
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}');

/*—— ② 按天分布(prefix 限定, 全量) ——*/
SELECT CONVERT(CHAR(10),E.STARTTIME,120) 日期
      ,COUNT(*) 记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) 设备数
      ,ISNULL(SUM(E.InputQty),0) 投入
      ,ISNULL(SUM(E.OutputQty),0) 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
GROUP BY CONVERT(CHAR(10),E.STARTTIME,120)
ORDER BY 日期;

/*—— ③ 指定日明细: 设备×生产批×作业站 逐条（-p date=YYYY-MM-DD；date='' 则全量）——*/
SELECT E.EQUIPMENTNO 设备
      ,ISNULL(EQP.EquipmentName,'') 设备名
      ,L.LOTNO 生产批
      ,L.OPNO 作业站
      ,ISNULL(OP.OPNAME,'') 工序名
      ,E.InputQty 投入
      ,E.OutputQty 产出
      ,CONVERT(CHAR(16),E.STARTTIME,120) 开始
      ,CONVERT(CHAR(16),E.ENDTIME,120) 结束
FROM TBLWIPCONT_EQUIPMENT E
LEFT JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}')
ORDER BY E.STARTTIME;

/*—— ④ 按工单汇总(prefix 限定; date='' 则全量) ——*/
SELECT L.MONO 工单
      ,L.PRODUCTNO 产品编号
      ,ISNULL(P.PRODUCTNAME,'') 产品名
      ,COUNT(DISTINCT E.EQUIPMENTNO) 设备数
      ,ISNULL(SUM(E.InputQty),0) 投入
      ,ISNULL(SUM(E.OutputQty),0) 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLPRDPRODUCTBASIS P ON L.PRODUCTNO = P.PRODUCTNO AND L.PRODUCTVERSION = P.PRODUCTVERSION
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}')
GROUP BY L.MONO, L.PRODUCTNO, P.PRODUCTNAME
ORDER BY L.MONO;

/*—— ⑤ 按报工人员统计: 指定日报工按人员汇总（-p date=YYYY-MM-DD；date='' 则全量）——
 * 人员: TBLWIPCont_Resource.USERNO(报工人员)
 * 投入产出: TBLWIPCONT_EQUIPMENT 当日口径——按 STARTTIME 过滤当天的 InputQty/OutputQty
 *          (= report.INPUTQTY/GOODQTY+FAILQTY, V3 验证一致; 2026-08-14 V2→V3 改严格当日量,
 *           不再携带跨日开批累计)
 * 姓名: TBLUSRUSERBASIS(USERNO→USERNAME)
 * 共库限定: 报工组∈该厂区设备报工组(prefix), 只统计本厂区人员
 * RESCLASS(2026-08-14 审计): 0/1/4 三类 USERNO 均为人员工号, 同人同组可能多行
 *        (0 和 4 各一行、部分人另加 1); 必须 DISTINCT(LOGGROUPSERIAL, USERNO) 防重复,
 *        切勿 WHERE RESCLASS=0 过滤(会丢仅 1/4 行的记录)
 * 分次续报(2026-08-14 审计): 同批同工序一天多次进出站时 X 对同一 LOGGROUPSERIAL 多行,
 *        SUM 精确=组总量(非膨胀), COUNT(DISTINCT LOGGROUPSERIAL) 组数正确
 * 口径: 每人=他当天参与的报工组的当日量总和；多人协作按参与人各计一次,
 *       人员总和≈当日报工日志总量(重复计入故略大), 勿精确对表
 * 注: 进行中报工(STARTTIME 当天、ENDTIME 空)计入, 产出为当前已出量(可小于投入)
 */
SELECT R.USERNO 工号
      ,ISNULL(U.USERNAME,'') 姓名
      ,COUNT(DISTINCT X.LOGGROUPSERIAL) 报工次数
      ,COUNT(DISTINCT P.LOTNO) 生产批
      ,COUNT(DISTINCT P.MONO) 工单
      ,ISNULL(SUM(X.InputQty),0) 投入
      ,ISNULL(SUM(X.OutputQty),0) 产出
FROM (SELECT DISTINCT E.LOGGROUPSERIAL, E.InputQty, E.OutputQty
      FROM TBLWIPCONT_EQUIPMENT E
      WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
        AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}')) X
JOIN (SELECT DISTINCT LOGGROUPSERIAL, USERNO FROM TBLWIPCont_Resource) R
  ON X.LOGGROUPSERIAL = R.LOGGROUPSERIAL
LEFT JOIN TBLUSRUSERBASIS U ON R.USERNO = U.USERNO
LEFT JOIN (SELECT LOGGROUPSERIAL, MAX(LOTNO) LOTNO, MAX(MONO) MONO
           FROM TBLWIPLOTLOG_REPORT WHERE OPNO <> 'LOTCREATE'
           GROUP BY LOGGROUPSERIAL) P
  ON X.LOGGROUPSERIAL = P.LOGGROUPSERIAL
GROUP BY R.USERNO, U.USERNAME
ORDER BY ISNULL(SUM(X.InputQty),0) DESC;

/*—— ⑥ 按设备汇总(prefix 限定; date='' 则全量)——*/
SELECT E.EQUIPMENTNO 设备
      ,ISNULL(EQP.EquipmentName,'') 设备名
      ,COUNT(*) 报工次数
      ,COUNT(DISTINCT L.LOTNO) 生产批数
      ,COUNT(DISTINCT L.MONO) 工单数
      ,ISNULL(SUM(E.InputQty),0) 投入
      ,ISNULL(SUM(E.OutputQty),0) 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
WHERE E.EQUIPMENTNO LIKE '{{prefix}}%'
  AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}')
GROUP BY E.EQUIPMENTNO, EQP.EquipmentName
ORDER BY SUM(E.InputQty) DESC;
