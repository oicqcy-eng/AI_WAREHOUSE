---
name: smes-coverage
description: AI-WAREHOUSE 与鼎华SMES的模块覆盖对照表
metadata:
  type: reference
---

# 鼎华SMES 模块覆盖对照

基于用户提供的鼎华SMES系统截图界面，逐一对照覆盖情况。

## 全覆盖清单

| 鼎华SMES模块 | 仓库路径 | 覆盖状态 | 说明 |
|-------------|---------|:--------:|------|
| 系统管理 | `base/system/` | ✅ | 用户/角色/权限/审计/通知 |
| 基础资料 | `base/master-data/` | ✅ | 编码/客户/供应商/员工/部门/工序 |
| 工艺管理 | `manufacturing/process/` | ✅ | 工艺路线/SOP/参数/版本 |
| 生产管理 | `manufacturing/production/` | ✅ | 执行/派工/报工/WIP |
| 工单管理 | `manufacturing/work-order/` | ✅ | 拆分/优先级/完工 |
| 排程管理 | `manufacturing/scheduling/` | ✅ | MPS/MRP/APS/产能分析 |
| 品质管理 | `manufacturing/quality/` | ✅ | IQC/IPQC/OQC/SPC/NCR |
| 设备管理 | `manufacturing/equipment/` | ✅ | 台账/OEE/保养/维修/校准 |
| 模具管理 | `manufacturing/mould/` | ✅ | 台账/寿命/保养 |
| 物料管理 | `manufacturing/material/` | ✅ | BOM/需求/供应商/批次 |
| 仓库管理 | `manufacturing/warehouse/` | ✅ | 出入库/盘点/库位/调拨 |
| 条码管理 | `base/barcode/` | ✅ | 条码规则/打印/扫描 |
| 看板管理 | `operations/kanban/` | ✅ | 生产/品质/设备/OEE大屏 |
| 安灯管理 | `manufacturing/andon/` | ✅ | 异常呼叫/升级/响应 |
| 追溯管理 | `manufacturing/traceability/` | ✅ | 批次/正反追溯/合规 |
| 文档管理 | `operations/document/` | ✅ | 图纸/文档/审批/检索 |
| 报表管理 | `operations/reporting/` | ✅ | 自定义报表/导出/分发 |
| 能源管理 | `operations/energy/` | ✅ | 能耗/能效/碳排 |

## AI-WAREHOUSE 超越鼎华的部分

| 能力 | 仓库路径 | 说明 |
|------|---------|------|
| AI推理 | `ai/serving/` | vLLM/Triton 大模型推理 |
| GPU管理 | `ai/gpu/` | DCGM监控/调度策略 |
| 向量数据库 | `ai/vector-db/` | Milvus/Qdrant |
| 模型训练 | `ai/training/` | 分布式训练任务 |
| IIoT采集 | `operations/iiot/` | 边缘网关/协议适配/规则引擎 |
