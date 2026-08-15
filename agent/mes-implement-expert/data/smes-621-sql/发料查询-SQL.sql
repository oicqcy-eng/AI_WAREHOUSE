/*发料查询 —— 工单材料领料/缺料核对（通用模板，2026-08-15 沉淀）
 * 库: sMES 共库（192.168.200.18/sMES_Home_Prod，--profile home）
 * 用法: node query-mes.js 本文件 --profile home -p mono=MO1012608050056
 *   mono=工单号（必填）。查厂区限定也可叠加设备前缀/产品等条件
 * 来源: 华纬用户提供（`delivery/inbox/日常运维报错截图/发料查询SQL-28.sql`）
 * 用途: 首站扫码上料报"条码不存在MES中"等发料问题排查的核心查询
 *
 * ── 口径说明（务必先读）────────────────────────────
 * 表: Tbloemomateriallist a（工单材料/发料表） JOIN Tbloemobasis b（工单主档）
 *   a.stdqty            = 标准用量（KG/每PCS）
 *   b.MOQTY             = 工单数量
 *   a.REQUIREQTY        = U9 材料需求数量（含损耗；>0 = 需求已同步到 MES）
 *   a.ORGMATERIALQTY    = 已领料数量（=0 即未发料/未同步）
 *   a.SUBSTITUTEMATERIALNO = 原料条码/物料号
 * 判读: REQUIREQTY>0 且 ORGMATERIALQTY=0 → U9 需求已到、领料动作未发生/未同步
 * ⚠️ 别用 TBLOEMOMATERIALINBASIS_ERP 查发料（另一链路表，会误导"0条=没同步"）
 * 排障详情见 delivery/projects/hw-spring-mes/ops-knowledge/ 首站扫码上料排障卡
 */
SELECT a.stdqty                                  AS 标准用量KG每PCS
      ,b.MOQTY                                   AS 工单数量
      ,(b.MOQTY * a.stdqty)                      AS 理论领料用量
      ,a.REQUIREQTY                               AS U9材料需求数量
      ,a.ORGMATERIALQTY                           AS 已领料数量
      ,(a.REQUIREQTY - a.ORGMATERIALQTY)          AS 缺料数量
      ,a.SUBSTITUTEMATERIALNO                     AS 原料条码
      ,CASE WHEN a.stdqty = 0 THEN 0
            ELSE FLOOR(a.REQUIREQTY / a.stdqty)   END AS 理论需生产PCS
      ,CASE WHEN a.stdqty = 0 THEN 0
            ELSE FLOOR(a.ORGMATERIALQTY / a.stdqty) END AS 领料可生产PCS
      ,CASE WHEN a.stdqty = 0 THEN 0
            WHEN a.REQUIREQTY <= a.ORGMATERIALQTY THEN 0
            ELSE FLOOR((a.REQUIREQTY - a.ORGMATERIALQTY) / a.stdqty) END AS 缺料不可生产PCS
FROM Tbloemomateriallist a
LEFT JOIN Tbloemobasis b ON a.MONO = b.MONO
WHERE a.MONO = '{{mono}}';
