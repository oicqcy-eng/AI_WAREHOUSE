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
 *      RESCLASS(2026-08-23 语义修正): 0=EMP人时(USERNO=作业人员)/1=EQP机时(USERNO=报工者=操作报工账号)/4=UCB群组(冗余)
 *      ——统计参与人员=R1 子查询全 RESCLASS DISTINCT(组,USERNO)=口径B(用户确认报工的人也是一起作业的), 勿改 R1 过滤
 *      姓名映射 TBLUSRUSERBASIS(USERNO→USERNAME, 重庆17人全映射成功)
 * 设备前缀: EQ-CQSPR-*(弹簧线40台) + EQ-CQSTB-*(稳定杆线58台)（2026-08-15 复核），见 knowledge/设备口径卡.md
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 *
 * 口径变更日志（改模板必记；改后须同步 SSMS 运行版 + 知识卡速查 + 报表口径注意）:
 *   2026-08-23 V7 注释修正（不改 SQL）：RESCLASS 语义字典+实测修正——0=EMP人时(USERNO=作业人员)
 *     /1=EQP机时(USERNO=报工者=操作报工账号)/4=UCB群组(冗余); 参与人员=0∪1去重=口径B
 *     (用户确认"报工的人也是一起作业的"), 旧"0/1/4均为人时归属者、勿按RESCLASS=0过滤"表述废止;
 *     ⑥ R1 子查询全 RESCLASS DISTINCT 恰好=口径B, SQL 不变仅注释修正
 *   2026-08-22 V6 新增⑦跨天收口视角（改 SQL）：当日出站但非当日新开批(ENDTIME=当日、
 *     STARTTIME<当日)——用户咨询"多人协作判定"（非看登录设备，看 Resource 同组多 USERNO，
 *     知识卡/规范已补）后要求报表同表体现"当日新开批+跨天收口"两口径；①-⑥不动
 *   2026-08-14 V5 隐患修复（改 SQL）：⑥ X 子查询改 GROUP BY E.LOGGROUPSERIAL 聚合成组总量
 *     （防"同量合并漏算"）+ R 子查询加 EVENTTIME 当天过滤（防跨天组历史成员带入今日）——
 *     重庆当日实测未触发（C1 重复行=0 / C2 成员 EVENTTIME 全在当天）但逻辑隐患真实，
 *     修正后结果与 V4 完全一致；与通用模板同步修改
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
 * RESCLASS(2026-08-23 字典+实测语义修正): 0=EMP人时(USERNO=作业人员, INPUTQTY=每人报工量)
 *        1=EQP机时(USERNO=报工者=操作报工账号, INPUTQTY=出站量) 4=UCB群组(每笔EMP冗余一行)
 *        同人同组多行(0/1/4各一行), 必须 DISTINCT(LOGGROUPSERIAL, USERNO) 防重复
 *        参与人员=0∪1 去重(口径B: 报工的人也是一起作业的, 用户确认)——勿把 RESCLASS=4 单独当人员
 * 分次续报(2026-08-14 审计, 重庆当日无): X 用 GROUP BY 聚合成组总量——防"同量合并漏算"
 *        (若用 DISTINCT(组,量) 且同组两次续报量相同会合并漏算)
 * 成员时间限定(2026-08-14 审计): R 按 EVENTTIME 当天过滤——防跨天组历史成员带入今日
 * 口径: 每人=他当天参与的报工组的当日量总和；多人协作按参与人各计一次,
 *       人员总和≈当日报工日志总量(重复计入故略大), 勿精确对表
 * 注: 进行中报工(STARTTIME 当天、ENDTIME 空)计入, 产出为当前已出量(可小于投入);
 *       进行中判据=TBLWIPLOTLOG_REPORT.ENDTIME 空(设备可已出站 E.ENDTIME 非空)
 */
SELECT R.USERNO 工号
      ,ISNULL(U.USERNAME,'') 姓名
      ,COUNT(DISTINCT X.LOGGROUPSERIAL) 报工次数
      ,COUNT(DISTINCT P.LOTNO) 生产批
      ,COUNT(DISTINCT P.MONO) 工单
      ,ISNULL(SUM(X.InputQty),0) 投入
      ,ISNULL(SUM(X.OutputQty),0) 产出
FROM (SELECT E.LOGGROUPSERIAL, SUM(E.InputQty) InputQty, SUM(E.OutputQty) OutputQty
      FROM TBLWIPCONT_EQUIPMENT E
      WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
        AND ('' = '{{date}}' OR CONVERT(CHAR(10),E.STARTTIME,120) = '{{date}}')
      GROUP BY E.LOGGROUPSERIAL) X
JOIN (SELECT DISTINCT LOGGROUPSERIAL, USERNO FROM TBLWIPCont_Resource
      WHERE '' = '{{date}}' OR CONVERT(CHAR(10),EVENTTIME,120) = '{{date}}') R
  ON X.LOGGROUPSERIAL = R.LOGGROUPSERIAL
LEFT JOIN TBLUSRUSERBASIS U ON R.USERNO = U.USERNO
LEFT JOIN (SELECT LOGGROUPSERIAL, MAX(LOTNO) LOTNO, MAX(MONO) MONO
           FROM TBLWIPLOTLOG_REPORT WHERE OPNO <> 'LOTCREATE'
           GROUP BY LOGGROUPSERIAL) P
  ON X.LOGGROUPSERIAL = P.LOGGROUPSERIAL
GROUP BY R.USERNO, U.USERNAME
ORDER BY ISNULL(SUM(X.InputQty),0) DESC;

/*—— ⑦ 跨天收口: 当日出站(ENDTIME=当日)但非当日新开批(STARTTIME<当日) ——
 * 口径(2026-08-22 用户需求): 报工报表需同时体现"当日新开批"与"跨天收口"两口径,
 *       当日实际交付 = 当日新开批产出(④今日明细 STARTTIME=当日) + 跨天收口产出(本视角)
 * 判定: E.ENDTIME 在当日(已出站) 且 E.STARTTIME 不在当日(跨天批), 即"8-21 出站的 8-14/8-15 开批"
 * 例: 8-21 实测 4 组(投入34373/产出21209), 含空心杆冷弯 MO1072608110002(8-11开批 20000→8156)
 * 用途: 看"产线当天实际交付多少活", 跨天收口常大于当日新开批产出, 勿只看当日新开批口径
 */
SELECT E.LOGGROUPSERIAL 报工组
      ,E.EQUIPMENTNO 设备
      ,ISNULL(EQP.EquipmentName,'') 设备名
      ,L.LOTNO 生产批
      ,L.MONO 工单
      ,L.PRODUCTNO 产品编号
      ,ISNULL(OP.OPNAME,'') 工序名
      ,CONVERT(CHAR(10),E.STARTTIME,120) 开批日
      ,CONVERT(CHAR(10),E.ENDTIME,120) 出站日
      ,E.InputQty 投入
      ,E.OutputQty 产出
FROM TBLWIPCONT_EQUIPMENT E
LEFT JOIN TBLWIPLOTLOG_REPORT L ON E.LOGGROUPSERIAL = L.LOGGROUPSERIAL
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO = E.EQUIPMENTNO
LEFT JOIN tblOPBasis OP ON L.OPNO = OP.OPNO
WHERE E.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND CONVERT(CHAR(10),E.ENDTIME,120) = '{{date}}'
  AND CONVERT(CHAR(10),E.STARTTIME,120) <> '{{date}}'
ORDER BY E.ENDTIME;
