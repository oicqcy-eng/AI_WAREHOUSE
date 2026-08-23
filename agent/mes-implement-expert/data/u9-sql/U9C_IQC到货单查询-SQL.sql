/*U9C IQC 到货单查询 —— 从 U9C 取 IQC 来料检待检数据（通用模板，2026-08-21 v1）
 * 库: 华纬 U9C ERP（192.168.200.16/HWAWAYU9CDB，--profile u9c）
 * 用法: node query-mes.js 本文件 --profile u9c -p receipt_no= -p item_code= --show 1|2|3|4
 *   receipt_no=到货单号（空=不限定）  item_code=物料编码（空=不限定）
 * 来源: 2026-08-21 U9C 首次连库实测；对照既有 ESB_IssueWoItem_Queue 发料队列模式
 * 用途: IQC 来料检验对接（T-f768f52017 / T-ea50fe8918）取数核心——
 *   MES 从 U9C 的 esb_iqc_receipt_outbox（IQC 到货单出站队列）拉取待检数据，
 *   用户只执行检验判定、不人工触发数据获取（见 操作手册 v1.1 K-010）
 *
 * ── 口径说明（务必先读）────────────────────────────
 * [表] esb_iqc_receipt_outbox = U9C→MES 的 IQC 到货单同步队列（29 列，ESB 中台 outbox 模式，
 *      与发料队列 ESB_IssueWoItem_Queue 同为 ESB 出站队列但结构不同：本表 29 列 vs 发料队列 40 列）。
 *      字段详解见 ../u9-sql/U9C数据库字典-基础.md
 * [状态机] sync_status 语义（待实测确认，参考发料队列约定）：
 *   0=待同步（MES 未消费，IQC 取数主查）/ 非 0=已消费或失败
 *   retry_count/next_retry_time=失败重试；claim_token/claimed_time=消费中租约；last_error=最近错误
 * [数据] 2026-08-21 实测仅 1 条测试单：TEST-IQC-20260821-001（物料 21106-001171，qc_conclusion=待检）
 * ⚠️ source_created_time 为 null（测试数据未填）——真实数据的时区/UTC 口径待正式数据验证
 * ⚠️ 查询只读：本模板不 UPDATE 队列状态（消费/标记由 MES 侧完成），AI 连库仅取数核对
 */

/*① 待同步到货单清单（sync_status=0，IQC 取数核心；支持按单/按物料过滤） */
SELECT receipt_no          AS 到货单号
      ,receipt_line_no     AS 到货单行
      ,item_code           AS 物料编码
      ,item_name           AS 物料名称
      ,item_specs          AS 规格
      ,arrived_qty         AS 到货数量
      ,uom_code            AS 单位
      ,qc_conclusion       AS 检验结论
      ,furnace_no          AS 炉号
      ,batch_no            AS 批号
      ,source_created_time AS 来源时间
      ,created_time        AS 入队时间
FROM esb_iqc_receipt_outbox
WHERE sync_status = 0
  AND ('{{receipt_no}}' = '' OR receipt_no = '{{receipt_no}}')
  AND ('{{item_code}}' = ''  OR item_code  = '{{item_code}}')
ORDER BY created_time;

/*② 按到货单号/物料查全部状态记录（含已消费，核对历史用） */
SELECT receipt_no          AS 到货单号
      ,item_code           AS 物料编码
      ,item_name           AS 物料名称
      ,arrived_qty         AS 到货数量
      ,qc_conclusion       AS 检验结论
      ,sync_status         AS 同步状态
      ,retry_count         AS 重试次数
      ,claim_token         AS 消费租约
      ,last_error          AS 最近错误
      ,source_created_time AS 来源时间
      ,processed_time      AS 处理时间
FROM esb_iqc_receipt_outbox
WHERE ('{{receipt_no}}' = '' OR receipt_no = '{{receipt_no}}')
  AND ('{{item_code}}' = ''  OR item_code  = '{{item_code}}')
ORDER BY source_created_time DESC, receipt_no;

/*③ 同步状态分布（看积压/失败概览） */
SELECT sync_status     AS 同步状态
      ,COUNT(*)        AS 单数
      ,SUM(CASE WHEN last_error IS NOT NULL THEN 1 ELSE 0 END) AS 有错误
FROM esb_iqc_receipt_outbox
GROUP BY sync_status
ORDER BY sync_status;

/*④ 失败/重试清单（last_error 非空，排查同步中断） */
SELECT receipt_no          AS 到货单号
      ,item_code           AS 物料编码
      ,sync_status         AS 同步状态
      ,retry_count         AS 重试次数
      ,next_retry_time     AS 下次重试
      ,last_error          AS 最近错误
      ,modified_time       AS 最后修改
FROM esb_iqc_receipt_outbox
WHERE last_error IS NOT NULL
ORDER BY modified_time DESC;
