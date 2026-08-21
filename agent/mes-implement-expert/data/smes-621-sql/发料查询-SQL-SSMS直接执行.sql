/*发料问题查询 —— SSMS 直接执行版（2026-08-21 从通用模板生成）
 * 库: sMES 共库（192.168.200.18/sMES_Home_Prod；重庆独立库表同名）
 * 用法: SSMS 打开本文件 → 改第 1 处 @mono = '工单号' → 整段 F5 执行
 *   结果会返回 3 个表，按 ① 发料核对 / ② 扫码上料 / ③ 进站核对 顺序排列
 *   只想看发料核对 → 删掉 /*②* / 和 /*③* / 两段再执行
 * 来源: 华纬用户提供（8-15 发料查询SQL-28.sql + 8-16 投喂截图），模板见「发料查询-SQL.sql」
 * 用途: 首站扫码上料报「条码不存在MES」/ 上料数量对不上 等发料问题排查核心查询
 *
 * ── 口径说明（务必先读）────────────────────────────
 * [①] 表: Tbloemomateriallist a（工单材料/发料表） JOIN Tbloemobasis b（工单主档）
 *   a.stdqty=标准用量(KG/PCS)   b.MOQTY=工单数量   a.REQUIREQTY=U9材料需求(含损耗)
 *   a.ORGMATERIALQTY=已领料数量(=0 即未发料/未同步)  a.SUBSTITUTEMATERIALNO=原料条码
 *   判读: REQUIREQTY>0 且 ORGMATERIALQTY=0 → U9 需求已到、领料动作未发生/未同步
 *   ⚠️ 别用 TBLOEMOMATERIALINBASIS_ERP 查发料（另一链路表，会误导「0条=没同步」）
 * [②] 表: TBLWIPEQPMATERIALSTATE（设备物料状态，17列，两库均有）
 *   MONo=工单号   EquipmentNo=设备   OPNo=作业站（LOTCREATE=生产批开立/首站）
 *   InputMaterialNo=扫码原料条码   MaterialLotNo=原料批次   Seq=序号
 *   InputQty=已上料数量   Qty=需求/应上料数量   → (InputQty-Qty)≠0 即上料数量有差异
 *   ⚠️ 时间字段实测 CreateDate 多为 NULL，看时间线用 ReviseDate
 *   ⚠️ 一条原料批次按设备各一行（同批分配给多台设备），勿用 COUNT 当批次数
 * [③] 表: TBLWIPCONT_MATERIAL（报工消耗物料）
 *   ⚠️ LOTSERIAL=原料批次序列号（非生产批！）；生产批号在 LOGGROUPSERIAL 前缀
 *   LOGGROUPSERIAL LIKE (该工单生产批 BASELOTNO)+'%' → 按物料汇总 SUM(USEQTY)=实际进站消耗
 *   生产批: TBLWIPLOTBASIS.BASELOTNO = MONO+'-NNN'（工单→生产批可多批，取任一即可前缀过滤）
 *   进站消耗 vs ①的需求/已领 → 缺料已领但报工消耗为 0 / 消耗量低于需求 = 上料未执行或绑定异常
 * 判读闭环: ①需求>0 已领=0 → 未发料（条码不存在）；②③有上料/消耗但量<需求 → 数量/绑定对不上
 * 排障卡: delivery/projects/hw-spring-mes/ops-knowledge/ 首站扫码上料（8-15 条码不存在 / 8-16 上料量核对）
 */

DECLARE @mono nvarchar(50) = 'MO1012608050056';   -- ★ 改这里：工单号

/*① 发料核对 —— U9 发料侧：理论领料 / 需求 / 已领 / 缺料 / 可生产 PCS */
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
WHERE a.MONO = @mono;

/*② 扫码上料状态 —— TBLWIPEQPMATERIALSTATE：按设备看已上料 vs 需求/上料差异 */
SELECT MONo                                      AS 工单号
      ,EquipmentNo                                AS 设备
      ,InputMaterialNo                            AS 扫码原料
      ,MaterialLotNo                              AS 原料批次
      ,Seq                                        AS 序号
      ,OPNo                                       AS 作业站
      ,InputQty                                   AS 已上料数量
      ,Qty                                        AS 需求数量
      ,(InputQty - Qty)                           AS 上料差异
      ,ISNULL(ReviseDate,'')                      AS 最近时间
FROM TBLWIPEQPMATERIALSTATE
WHERE MONo = @mono
ORDER BY EquipmentNo, Seq;

/*③ 报工进站核对 —— TBLWIPCONT_MATERIAL：实际进站消耗 vs U9 需求/已领 */
SELECT w.MATERIALNO                               AS 物料号
      ,COUNT(DISTINCT w.LOGGROUPSERIAL)           AS 报工组数
      ,SUM(w.USEQTY)                              AS 实际进站消耗量
      ,SUM(w.UNDISTRIBUTEQTY)                     AS 未分配量
      ,(SELECT TOP 1 a.REQUIREQTY
        FROM Tbloemomateriallist a
        WHERE a.MONO = @mono AND a.MATERIALNO = w.MATERIALNO) AS U9需求数量
      ,(SELECT TOP 1 a.ORGMATERIALQTY
        FROM Tbloemomateriallist a
        WHERE a.MONO = @mono AND a.MATERIALNO = w.MATERIALNO) AS 已领料数量
FROM TBLWIPCONT_MATERIAL w
WHERE w.LOGGROUPSERIAL LIKE
      (SELECT TOP 1 BASELOTNO FROM TBLWIPLOTBASIS WHERE MONO = @mono) + '%'
GROUP BY w.MATERIALNO
ORDER BY w.MATERIALNO;
