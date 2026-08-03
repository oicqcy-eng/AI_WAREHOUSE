# 数据字典 — MES实施专家

> 本 Agent 方案中引用的核心业务数据字段。字段定义与对应模块 `database/` 一致。

## 工单（work_order）— 源自 manufacturing/work-order/

| 字段 | 类型 | 说明 |
|------|------|------|
| work_order_no | string | 工单号 |
| status | enum | 状态: 待排/已排/生产中/完工/关闭 |
| plan_qty | int | 计划数量 |
| plan_date | date | 计划日期 |
| product_code | string | 产品编码 |
| due_date | date | 交期 |

## 设备指标（equipment_metrics）— 源自 manufacturing/equipment/

| 字段 | 类型 | 说明 |
|------|------|------|
| equipment_code | string | 设备编码 |
| available_rate | float | 可用率（时间稼动） |
| performance_rate | float | 性能率（速度稼动） |
| quality_rate | float | 良品率 |
| stat_date | date | 统计日期 |

> OEE = 可用率 × 性能率 × 良品率

## 质量（quality_ncr）— 源自 manufacturing/quality/

| 字段 | 类型 | 说明 |
|------|------|------|
| defect_code | string | 不良代码 |
| defect_desc | string | 不良描述 |
| qty | int | 不良数量 |
| created_at | datetime | 发生时间 |

## 追溯（lot_traceability）— 源自 manufacturing/traceability/

| 字段 | 类型 | 说明 |
|------|------|------|
| finished_lot | string | 成品批次 |
| raw_lot | string | 原料批次 |
| process_code | string | 工序编码 |
| equipment | string | 设备 |
| operator | string | 操作员 |
| occur_at | datetime | 发生时间 |

## 新增字段规范

1. 新字段先确认对应模块 `database/` 中已定义
2. 本字典只收录 Agent 会引用的字段，避免全文复制
