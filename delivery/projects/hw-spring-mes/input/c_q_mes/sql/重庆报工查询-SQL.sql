/*重庆报工查询 —— 累计概览/产线拆分/按天分布/指定日明细/按工单汇总/按人员统计（2026-08-14 实战沉淀）
 * 库: 重庆独立 sMES 服务器（172.16.64.11/sMES_Home_Prod）
 * 用法: node query-mes.js 本文件 --profile cq --show N -p date=2026-08-14
 *   N=1 累计概览 / 2 产线拆分 / 3 按天分布 / 4 指定日明细(需 -p date) / 5 按工单汇总 / 6 按人员统计(需 -p date)
 * 核心链路: TBLWIPCONT_EQUIPMENT(设备进出站, InputQty/OutputQty=本次报工投入/产出, STARTTIME)
 *          JOIN TBLWIPLOTLOG_REPORT(经 LOGGROUPSERIAL 拿 LOTNO/MONO/PRODUCTNO/OPNO,
 *             与 equipment 同量; ENDTIME 为空=进行中未出站)
 *          注意: TBLWIPCont_Resource.INPUTQTY 为资源加工量(≠本次报工投入), 勿用于投入统计
 *          注意含 OPNO='LOTCREATE' 的开批记录(DEVICENO='Batch')，非报工，勿混淆
 * 人员: TBLWIPCont_Resource(资源使用, USERNO=报工人员, EVENTTIME=报工时间, INPUTQTY=资源加工量)
 *      姓名映射 TBLUSRUSERBASIS(USERNO→USERNAME, 重庆17人全映射成功)
 * 设备前缀: EQ-CQSPR-*(弹簧线28台) + EQ-CQSTB-*(稳定杆线58台)，见 knowledge/设备口径卡.md
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 *
 * 口径变更日志（改模板必记；改后须同步 SSMS 运行版 + 知识卡速查 + 报表口径注意）:
 *   2026-08-14 V4 审计确认（不改 SQL）：RESCLASS 0/1/4 的 USERNO 均为人员工号（实测，
 *     HW2994 仅在 RESCLASS=1 出现），⑥ 必须 DISTINCT(LOGGROUPSERIAL,USERNO)、勿按 RESCLASS=0
 *     过滤——认知修正见 knowledge/设备口径卡.md；当日 19 条无分次续报组（一厂有，见通用模板）
 *   2026-08-14 V3→V4: ⑥按人员改为严格当日量——报工量来源从 TBLWIPLOTLOG_REPORT(当前累计,
 *     携带跨日开批)改为 TBLWIPCONT_EQUIPMENT(按 STARTTIME 过滤当日 InputQty/OutputQty),
 *     每人=当天实际报工量; 与通用模板同步修改; ④日期条件统一 ''='{{date}}' 写法
 *   2026-08-14 V2→V3: 口径再验证——equipment.InputQty/OutputQty 与 report.INPUTQTY/
 *     GOODQTY+FAILQTY 完全一致(今日19条逐条核对), 均=本次报工量; 修正 V2 误判"equipment
 *     为生产批累计"(实为 resource.INPUTQTY 资源加工量≠本次投入, 勿用于投入统计)
 *   2026-08-14 V1→V2: ①新增第6视角(按报工人员统计) ②口径澄清——本次投入/产出以
 *     TBLWIPLOTLOG_REPORT.INPUTQTY/GOODQTY+FAILQTY 为准 ③报工人员取
 *     TBLWIPCont_Resource.USERNO(设备表 Creator 为空)
 *   2026-08-14 V1: 初版 5 视角(累计/产线/按天/明细/工单)
 */

/*—— ① 累计概览(全量) ——*/
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
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%';

/*—— ② 按产线拆分(累计) ——*/
SELECT CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线(CQSPR)'
            WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线(CQSTB)'
            ELSE '其他' END 产线
      ,COUNT(*) 记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) 设备数
      ,COUNT(DISTINCT L.MONO) 工单数
      ,ISNULL(SUM(E.InputQty),0) 投入
      ,ISNULL(SUM(E.OutputQty),0) 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY CASE WHEN E.EQUIPMENTNO LIKE 'EQ-CQSPR%' THEN '弹簧线(CQSPR)'
              WHEN E.EQUIPMENTNO LIKE 'EQ-CQSTB%' THEN '稳定杆线(CQSTB)'
              ELSE '其他' END
ORDER BY 产线;

/*—— ③ 按天分布(全量) ——*/
SELECT CONVERT(CHAR(10),E.STARTTIME,120) 日期
      ,COUNT(*) 记录数
      ,COUNT(DISTINCT E.EQUIPMENTNO) 设备数
      ,ISNULL(SUM(E.InputQty),0) 投入
      ,ISNULL(SUM(E.OutputQty),0) 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY CONVERT(CHAR(10),E.STARTTIME,120)
ORDER BY 日期;

/*—— ④ 指定日明细: 设备×生产批×作业站 逐条（-p date=YYYY-MM-DD；date='' 则全量）——*/
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
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}')
ORDER BY E.STARTTIME;

/*—— ⑤ 按工单累计汇总 ——*/
SELECT L.MONO 工单
      ,L.PRODUCTNO 产品编号
      ,ISNULL(P.PRODUCTNAME,'') 产品名
      ,COUNT(DISTINCT E.EQUIPMENTNO) 设备数
      ,ISNULL(SUM(E.InputQty),0) 投入
      ,ISNULL(SUM(E.OutputQty),0) 产出
FROM TBLWIPCONT_EQUIPMENT E
JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLPRDPRODUCTBASIS P ON L.PRODUCTNO = P.PRODUCTNO AND L.PRODUCTVERSION = P.PRODUCTVERSION
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
GROUP BY L.MONO, L.PRODUCTNO, P.PRODUCTNAME
ORDER BY L.MONO;

/*—— ⑥ 按报工人员统计: 指定日报工按人员汇总（-p date=YYYY-MM-DD；date='' 则全量）——
 * 人员: TBLWIPCont_Resource.USERNO(报工人员)
 * 投入产出: TBLWIPCONT_EQUIPMENT 当日口径——按 STARTTIME 过滤当天的 InputQty/OutputQty
 *          (= report.INPUTQTY/GOODQTY+FAILQTY, V3 验证一致; 2026-08-14 V3→V4 改严格当日量,
 *           不再携带跨日开批累计)
 * 姓名: TBLUSRUSERBASIS(USERNO→USERNAME)
 * RESCLASS(2026-08-14 审计): 0/1/4 三类 USERNO 均为人员工号, 同人同组可能多行;
 *        必须 DISTINCT(LOGGROUPSERIAL, USERNO) 防重复, 切勿 WHERE RESCLASS=0 过滤
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
      WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
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
