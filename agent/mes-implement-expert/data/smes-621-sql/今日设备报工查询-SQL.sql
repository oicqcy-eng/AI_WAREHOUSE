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
 * 人员: TBLWIPCont_Resource.USERNO(报工人员, EVENTTIME 报工时间)
 * 投入产出: TBLWIPLOTLOG_REPORT 本次口径(INPUTQTY 投入 / GOODQTY+FAILQTY 产出)
 * 姓名: TBLUSRUSERBASIS(USERNO→USERNAME)
 * 共库限定: LOGGROUPSERIAL∈该厂区设备报工组(prefix), 只统计本厂区人员
 * 口径: 每人按"参与报工的serial数"计；同一次报工多人协作时按参与人各计一次，
 *       人员口径投入/产出总和 ≠ 报工日志总量(多人重复计入)，勿直接对表
 * 注: 进行中报工(ENDTIME 为空)含在统计内，INPUTQTY 为当前累计投入
 */
SELECT X.USERNO 工号
      ,ISNULL(U.USERNAME,'') 姓名
      ,COUNT(*) 报工次数
      ,COUNT(DISTINCT P.LOTNO) 生产批
      ,COUNT(DISTINCT P.MONO) 工单
      ,SUM(P.INPUTQTY) 投入
      ,SUM(P.GOODQTY+P.FAILQTY) 产出
FROM (SELECT DISTINCT R.USERNO, R.LOGGROUPSERIAL
      FROM TBLWIPCont_Resource R
      WHERE R.LOGGROUPSERIAL IN (SELECT DISTINCT E.LOGGROUPSERIAL
                                 FROM TBLWIPCONT_EQUIPMENT E
                                 WHERE E.EQUIPMENTNO LIKE '{{prefix}}%')
        AND ('' = '{{date}}' OR CONVERT(CHAR(10),R.EVENTTIME,120) = '{{date}}')) X
LEFT JOIN TBLUSRUSERBASIS U ON X.USERNO = U.USERNO
JOIN (SELECT LOGGROUPSERIAL, INPUTQTY, GOODQTY, FAILQTY, LOTNO, MONO FROM TBLWIPLOTLOG_REPORT
      WHERE OPNO <> 'LOTCREATE'
        AND LOGGROUPSERIAL IN (SELECT DISTINCT E.LOGGROUPSERIAL
                               FROM TBLWIPCONT_EQUIPMENT E
                               WHERE E.EQUIPMENTNO LIKE '{{prefix}}%')) P
  ON X.LOGGROUPSERIAL = P.LOGGROUPSERIAL
GROUP BY X.USERNO, U.USERNAME
ORDER BY SUM(P.INPUTQTY) DESC;

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
