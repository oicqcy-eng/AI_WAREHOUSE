/*点检记录查询 —— 设备点检执行情况（6视角，2026-08-15 实战沉淀）
 * 库: sMES_Home_Prod 共库（--profile home）；重庆/泽根为独立服务器走各自 --profile
 * 用法: node tools/query-mes.js 本文件 --profile home -p prefix=101-01-DH -p date=2026-08-15 --show N
 *   prefix=厂区设备前缀: 一厂大簧=101-01-DH、金晟=JS、二厂=F、重庆=EQ-CQ(独立库) 等;
 *         空='' 则查全库（共库多厂区并存时慎用，会混入所有厂区）
 *   date=YYYY-MM-DD 指定日；date='' 则全量
 *   N=1 点检概览 / 2 按设备点检汇总 / 3 点检记录明细 / 4 点检项目明细 / 5 未通过点检NG清单 / 6 按天点检趋势
 * 时区: 库内北京时间，日期直接 CONVERT(CHAR(10),时间,120) 过滤
 *
 * ── 核心口径与实测结论（务必先读）────────────────────────
 * 【源表】主表 TBLWIPEQPQCLISTLOG A（一次点检一条: EQUIPMENTNO/QCLISTNO点检单号/QCRESULT/CREATOR）
 *        明细 tblWIPEQPQCListDetail D（一条点检的项目行: QCORDER次序/QCITEM检查项目/QCTYPE/INPUTVALUE输入值/
 *        STDVALUE标准值/MINIVALUE最小值/MAXIVALUE最大值/QCRESULT）；D.QCLISTSERIAL=A.QCLISTSERIAL 关联。
 * 【结果语义（实测确认）】QCRESULT 主表与明细同为 numeric: 0=OK / 1=NG。
 *        重庆主表实测 0=350 / 1=29；NG 即点检未通过项。
 * 【项目类型】明细 QCTYPE: 0=标准值 / 1=范围值 / 2=显示信息 / 3=输入数据。
 * 【数据规模】重庆 379 条(06-26~08-15)；共库 28,781 条(2025-05~)；一厂 101-01-DH 1004 条/60 设备/9 单。
 * 【NG判定】主表 QCRESULT=1 为该次点检整体 NG；明细 QCRESULT=1 为该检查项 NG。
 *        ⑤NG清单查主表；④中逐项可见哪个项目 NG。两者可交叉核对。
 * 【口径变更日志】2026-08-15 初版——点检记录查询（替换/升级客户旧「点检项目-SQL.sql」，补日期过滤+厂区限定+6视角）
 */

/*—— ① 点检概览: 记录数/设备数/点检单数/NG数/NG率（prefix 限定; date 指定则单日） ——*/
SELECT COUNT(*)                                        AS 点检记录数
      ,COUNT(DISTINCT A.EQUIPMENTNO)                   AS 设备数
      ,COUNT(DISTINCT A.QCLISTNO)                      AS 点检单数
      ,SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)   AS NG数
      ,ROUND(100.0*SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)
              /NULLIF(COUNT(*),0),1)                   AS NG率
      ,CONVERT(CHAR(10),MIN(A.CREATEDATE),120)         AS 最早
      ,CONVERT(CHAR(10),MAX(A.CREATEDATE),120)         AS 最晚
FROM TBLWIPEQPQCLISTLOG A
WHERE ('{{prefix}}'='' OR A.EQUIPMENTNO LIKE '{{prefix}}%')
  AND ('{{date}}'='' OR CONVERT(CHAR(10),A.CREATEDATE,120)='{{date}}');

/*—— ② 按设备点检汇总: 设备/设备名/次数/NG/最近（定位"点检执行少或NG多"设备） ——*/
SELECT A.EQUIPMENTNO                                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')                     AS 设备名
      ,COUNT(*)                                         AS 点检次数
      ,SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)    AS NG次数
      ,COUNT(DISTINCT A.QCLISTNO)                       AS 涉及点检单
      ,CONVERT(CHAR(16),MAX(A.CREATEDATE),120)          AS 最近点检
FROM TBLWIPEQPQCLISTLOG A
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO=A.EQUIPMENTNO
WHERE ('{{prefix}}'='' OR A.EQUIPMENTNO LIKE '{{prefix}}%')
  AND ('{{date}}'='' OR CONVERT(CHAR(10),A.CREATEDATE,120)='{{date}}')
GROUP BY A.EQUIPMENTNO, EQP.EquipmentName
ORDER BY 点检次数 DESC;

/*—— ③ 点检记录明细: 主表逐条（时间/设备/设备名/点检单/结果/登记人） ——*/
SELECT CONVERT(CHAR(16),A.CREATEDATE,120)               AS 时间
      ,A.EQUIPMENTNO                                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')                     AS 设备名
      ,A.QCLISTNO                                       AS 点检单号
      ,CASE A.QCRESULT WHEN 0 THEN 'OK' WHEN 1 THEN 'NG' ELSE CONVERT(VARCHAR,A.QCRESULT) END AS 结果
      ,ISNULL(A.DESCRIPTION,'')                         AS 说明
      ,ISNULL(A.CREATOR,'')                             AS 登记人
FROM TBLWIPEQPQCLISTLOG A
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO=A.EQUIPMENTNO
WHERE ('{{prefix}}'='' OR A.EQUIPMENTNO LIKE '{{prefix}}%')
  AND ('{{date}}'='' OR CONVERT(CHAR(10),A.CREATEDATE,120)='{{date}}')
ORDER BY A.CREATEDATE;

/*—— ④ 点检项目明细: 检查项目逐项（最细粒度: 哪个项目/输入值/标准值/OK-NG） ——
 * 关联: 明细 D.QCLISTSERIAL=主表 A.QCLISTSERIAL；QCTYPE 0=标准值/1=范围值/2=显示信息/3=输入数据
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
WHERE ('{{prefix}}'='' OR A.EQUIPMENTNO LIKE '{{prefix}}%')
  AND ('{{date}}'='' OR CONVERT(CHAR(10),A.CREATEDATE,120)='{{date}}')
ORDER BY A.CREATEDATE, D.QCORDER;

/*—— ⑤ 未通过点检NG清单: 主表 QCRESULT=1 逐条（点检未通过，需跟进） ——*/
SELECT CONVERT(CHAR(16),A.CREATEDATE,120)               AS 时间
      ,A.EQUIPMENTNO                                    AS 设备
      ,ISNULL(EQP.EquipmentName,'')                     AS 设备名
      ,A.QCLISTNO                                       AS 点检单号
      ,ISNULL(A.DESCRIPTION,'')                         AS 说明
      ,ISNULL(A.CREATOR,'')                             AS 登记人
FROM TBLWIPEQPQCLISTLOG A
LEFT JOIN TBLEQPEQUIPMENTBASIS EQP ON EQP.EQUIPMENTNO=A.EQUIPMENTNO
WHERE A.QCRESULT=1
  AND ('{{prefix}}'='' OR A.EQUIPMENTNO LIKE '{{prefix}}%')
  AND ('{{date}}'='' OR CONVERT(CHAR(10),A.CREATEDATE,120)='{{date}}')
ORDER BY A.CREATEDATE;

/*—— ⑥ 按天点检趋势: 每天记录数/设备/NG/NG率（date='' 全量看执行节奏与 NG 波动） ——*/
SELECT CONVERT(CHAR(10),A.CREATEDATE,120)               AS 日期
      ,COUNT(*)                                         AS 点检记录数
      ,COUNT(DISTINCT A.EQUIPMENTNO)                    AS 设备数
      ,SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)    AS NG数
      ,ROUND(100.0*SUM(CASE WHEN A.QCRESULT=1 THEN 1 ELSE 0 END)
              /NULLIF(COUNT(*),0),1)                    AS NG率
FROM TBLWIPEQPQCLISTLOG A
WHERE ('{{prefix}}'='' OR A.EQUIPMENTNO LIKE '{{prefix}}%')
  AND ('{{date}}'='' OR CONVERT(CHAR(10),A.CREATEDATE,120)='{{date}}')
GROUP BY CONVERT(CHAR(10),A.CREATEDATE,120)
ORDER BY 日期;
