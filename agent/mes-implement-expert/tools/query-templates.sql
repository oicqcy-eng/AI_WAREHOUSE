-- =============================================================
-- MES实施专家 — 只读 SQL 查询模板
-- 规范: 一律只读(SELECT)；必须带 LIMIT 防大表扫描；表名占位符 {{schema.table}}
-- 实际表名以对应模块 database/ 为准
-- =============================================================

-- 1. 工单执行进度概览
-- 用途: 判断车间在制品/工单状态分布
-- 指向: manufacturing/work-order/
SELECT
  wo.status            AS 工单状态,
  COUNT(*)             AS 工单数,
  SUM(wo.plan_qty)     AS 计划数量
FROM {{mes_schema}}.work_order AS wo
WHERE wo.plan_date BETWEEN '{{start_date}}' AND '{{end_date}}'
GROUP BY wo.status
ORDER BY 工单数 DESC
LIMIT 50;

-- 2. 设备 OEE 汇总（示例骨架）
-- 用途: 设备效率现状调研
-- 指向: manufacturing/equipment/
SELECT
  eq.equipment_code AS 设备编码,
  eq.available_rate AS 可用率,
  eq.performance_rate AS 性能率,
  eq.quality_rate   AS 良品率,
  (eq.available_rate * eq.performance_rate * eq.quality_rate) AS oee
FROM {{mes_schema}}.equipment_metrics AS eq
WHERE eq.stat_date = '{{stat_date}}'
ORDER BY oee ASC
LIMIT 100;

-- 3. 质量不良分布（Top N）
-- 用途: 品质问题定位
-- 指向: manufacturing/quality/
SELECT
  q.defect_code  AS 不良代码,
  q.defect_desc  AS 不良描述,
  COUNT(*)       AS 不良次数,
  SUM(q.qty)     AS 不良数量
FROM {{mes_schema}}.quality_ncr AS q
WHERE q.created_at BETWEEN '{{start_date}}' AND '{{end_date}}'
GROUP BY q.defect_code, q.defect_desc
ORDER BY 不良数量 DESC
LIMIT 20;

-- 4. 批次正追溯（成品→原料批次）
-- 用途: 追溯合规查询
-- 指向: manufacturing/traceability/
SELECT
  tr.finished_lot AS 成品批次,
  tr.raw_lot      AS 原料批次,
  tr.process_code AS 工序,
  tr.equipment    AS 设备,
  tr.operator     AS 操作员,
  tr.occur_at     AS 发生时间
FROM {{mes_schema}}.lot_traceability AS tr
WHERE tr.finished_lot = '{{lot_no}}'
ORDER BY tr.occur_at ASC
LIMIT 200;
