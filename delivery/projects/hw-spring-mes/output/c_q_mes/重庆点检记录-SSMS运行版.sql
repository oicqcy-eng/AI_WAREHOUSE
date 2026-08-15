/* ============================================================
 * 重庆 sMES 点检记录 —— SSMS 直接运行版（2026-08-15 导出）
 * ------------------------------------------------------------
 * 【连接信息】
 *   服务器: 172.16.64.11   （重庆独立 sMES，非总部共库）
 *   数据库: sMES_Home_Prod
 *   账号:   只读账号（切勿用 sa / 写账号；注意只跑 SELECT）
 *   SQL Server 身份验证
 *
 * 【用途】设备点检执行情况：点检概览/按设备/明细/项目级 NG 定位，
 *         支撑设备点检执行率与设备点检 NG 跟进。
 *
 * 【用法】
 *   1. 顶部 @date 变量改日期，F5 一次跑全部 6 个视角
 *   2. 视角②③④⑤⑥设 @date='' 可跑全量累计
 *   3. 视角④（项目明细）最细粒度，可定位具体 NG 检查项目（如报警灯/压力）
 *   4. 想单看某个视角：选中对应 SELECT 段再执行即可
 *   5. 结果可在 SSMS 里「结果→将结果另存为」导出 CSV/Excel
 *
 * 【口径说明】见文件末尾「口径与注意」节，务必先读
 * 【同源同步】本文件与通用模板 agent/mes-implement-expert/data/smes-621-sql/
 *             点检记录查询-SQL.sql 同源（模板用 {{prefix}}/{{date}} 占位符，
 *             本版硬编码重庆前缀 EQ-CQ% + @date 变量，口径一致）。模板口径变更后须同步本文件。
 * ============================================================ */

DECLARE @date VARCHAR(10) = '2026-08-15';   -- 指定日；@date='' 全量（②③④⑤⑥看累计时用）


/* —— ① 点检概览: 记录数/设备数/点检单数/NG数/NG率（@date 指定日；@date='' 全量） —— */
SELECT COUNT(*)                                        AS 点检记录数
      ,COUNT(DISTINCT A.EQUIPMENTNO)                   AS 设备数
      ,COUNT(DISTINCT A.QCLISTNO)                      AS 点检单数
      ,SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)   AS NG数
      ,ROUND(100.0*SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)
              /NULLIF(COUNT(*),0),1)                   AS NG率
      ,CONVERT(CHAR(10),MIN(A.CREATEDATE),120)         AS 最早
      ,CONVERT(CHAR(10),MAX(A.CREATEDATE),120)         AS 最晚
FROM TBLWIPEQPQCLISTLOG A
WHERE A.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date='' OR CONVERT(CHAR(10),A.CREATEDATE,120)=@date);


/* —— ② 按设备点检汇总: 设备/设备名/次数/NG/最近（定位"点检执行少或NG多"设备） —— */
SELECT A.EQUIPMENTNO                                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')                     AS 设备名
      ,COUNT(*)                                         AS 点检次数
      ,SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)    AS NG次数
      ,COUNT(DISTINCT A.QCLISTNO)                       AS 涉及点检单
      ,CONVERT(CHAR(16),MAX(A.CREATEDATE),120)          AS 最近点检
FROM TBLWIPEQPQCLISTLOG A
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO=A.EQUIPMENTNO
WHERE A.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date='' OR CONVERT(CHAR(10),A.CREATEDATE,120)=@date)
GROUP BY A.EQUIPMENTNO, EQP.EquipmentName
ORDER BY 点检次数 DESC;


/* —— ③ 点检记录明细: 主表逐条（时间/设备/设备名/点检单/结果/登记人） —— */
SELECT CONVERT(CHAR(16),A.CREATEDATE,120)               AS 时间
      ,A.EQUIPMENTNO                                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')                     AS 设备名
      ,A.QCLISTNO                                       AS 点检单号
      ,CASE A.QCRESULT WHEN 0 THEN 'OK' WHEN 1 THEN 'NG' ELSE CONVERT(VARCHAR,A.QCRESULT) END AS 结果
      ,ISNULL(A.DESCRIPTION,'')                         AS 说明
      ,ISNULL(A.CREATOR,'')                             AS 登记人
FROM TBLWIPEQPQCLISTLOG A
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO=A.EQUIPMENTNO
WHERE A.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date='' OR CONVERT(CHAR(10),A.CREATEDATE,120)=@date)
ORDER BY A.CREATEDATE;


/* —— ④ 点检项目明细: 检查项目逐项（最细粒度: 哪个项目/输入值/标准值/OK-NG） ——
 * 关联: 明细 D.QCLISTSERIAL=主表 A.QCLISTSERIAL；QCTYPE 0=标准值/1=范围值/2=显示信息/3=输入数据
 * 实测 8-15: 含 EQ-CQSPR-PS-01 报警灯 NG（点检单 A8）——可直接定位具体异常项
 */
SELECT CONVERT(CHAR(16),A.CREATEDATE,120)               AS 时间
      ,A.EQUIPMENTNO                                    AS 设备
      ,A.QCLISTNO                                       AS 点检单号
      ,D.QCORDER                                        AS 次序
      ,D.QCITEM                                         AS 检查项目
      ,CASE D.QCTYPE WHEN 0 THEN '标准值' WHEN 1 THEN '范围值'
                     WHEN 2 THEN '显示信息' WHEN 3 THEN '输入数据'
                     ELSE CONVERT(VARCHAR,D.QCTYPE) END AS 项目类型
      ,ISNULL(D.INPUTVALUE,'')                          AS 输入值
      ,ISNULL(D.STDVALUE,'')                            AS 标准值
      ,ISNULL(D.MINIVALUE,'')                           AS 最小值
      ,ISNULL(D.MAXIVALUE,'')                           AS 最大值
      ,CASE D.QCRESULT WHEN 0 THEN 'OK' WHEN 1 THEN 'NG' ELSE CONVERT(VARCHAR,D.QCRESULT) END AS 结果
FROM TBLWIPEQPQCLISTLOG A
JOIN tblWIPEQPQCListDetail D ON D.QCLISTSERIAL=A.QCLISTSERIAL
WHERE A.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date='' OR CONVERT(CHAR(10),A.CREATEDATE,120)=@date)
ORDER BY A.CREATEDATE, D.QCORDER;


/* —— ⑤ 未通过点检NG清单: 主表 QCRESULT=1 逐条（点检未通过，需跟进） —— */
SELECT CONVERT(CHAR(16),A.CREATEDATE,120)               AS 时间
      ,A.EQUIPMENTNO                                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')                     AS 设备名
      ,A.QCLISTNO                                       AS 点检单号
      ,ISNULL(A.DESCRIPTION,'')                         AS 说明
      ,ISNULL(A.CREATOR,'')                             AS 登记人
FROM TBLWIPEQPQCLISTLOG A
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO=A.EQUIPMENTNO
WHERE A.QCRESULT=1
  AND A.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date='' OR CONVERT(CHAR(10),A.CREATEDATE,120)=@date)
ORDER BY A.CREATEDATE;


/* —— ⑥ 按天点检趋势: 每天记录数/设备/NG/NG率（@date='' 全量看执行节奏与 NG 波动） —— */
SELECT CONVERT(CHAR(10),A.CREATEDATE,120)               AS 日期
      ,COUNT(*)                                         AS 点检记录数
      ,COUNT(DISTINCT A.EQUIPMENTNO)                    AS 设备数
      ,SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)    AS NG数
      ,ROUND(100.0*SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)
              /NULLIF(COUNT(*),0),1)                    AS NG率
FROM TBLWIPEQPQCLISTLOG A
WHERE A.EQUIPMENTNO LIKE 'EQ-CQ%'
  AND (@date='' OR CONVERT(CHAR(10),A.CREATEDATE,120)=@date)
GROUP BY CONVERT(CHAR(10),A.CREATEDATE,120)
ORDER BY 日期;


/* ============================================================
 * 【口径与注意】—— 用前必读
 * ------------------------------------------------------------
 * 1. 【源表】主表 TBLWIPEQPQCLISTLOG（一次点检一条）JOIN 明细 tblWIPEQPQCListDetail（项目行）
 *    （D.QCLISTSERIAL=A.QCLISTSERIAL）。
 * 2. 【结果语义】QCRESULT 主表与明细同为 numeric：0=OK / 1=NG。
 *    重庆实测(2026-08-15)：主表 0=350 / 1=29；NG=点检未通过项。
 * 3. 【项目类型】明细 QCTYPE：0=标准值 / 1=范围值 / 2=显示信息 / 3=输入数据。
 * 4. 【重庆判定】设备前缀 EQ-CQ%（98 台，弹簧线 EQ-CQSPR / 稳定杆线 EQ-CQSTB）。
 *    重庆独立库，无共库多厂区问题；本文件全部视角已内建 'EQ-CQ%' 限定，勿改。
 * 5. 【数据规模】重庆点检 379 条(06-26~08-15)；8-15 当日 17 条/17 设备/10 单/NG 2。
 *    ④ 实测定位到 EQ-CQSPR-PS-01 报警灯 NG（点检单 A8）——项目级异常可见。
 * 6. 模板变更后须同步本文件：agent/mes-implement-expert/data/smes-621-sql/
 *    点检记录查询-SQL.sql（权威模板，含 {{prefix}}/{{date}} 占位符）。
 * ============================================================ */
