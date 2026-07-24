# 制造执行层 (manufacturing/)

> **定位**: MES 核心业务模块，覆盖生产全流程执行与管理
> **包含模块**: scheduling, production, work-order, process, andon, quality, traceability, equipment, mould, material, warehouse（共11个）
> **部署顺序**: 先部署生产执行类（scheduling/production/work-order），再部署支撑类（quality/equipment/warehouse）

本层是平台的核心，涵盖从排程、生产执行、品质管控到设备管理、仓储物流的全链路。
各模块可独立部署，按需组合上线。

| 模块 | 端口 | 说明 |
|------|------|------|
| scheduling | 8073 | 主生产计划、MRP、APS排程 |
| production | 8083 | 生产执行、派工、报工 |
| work-order | 8085 | 工单全生命周期管理 |
| process | 8087 | 工艺路线、SOP、版本 |
| andon | 8088 | 异常呼叫、升级策略 |
| quality | 8081 | IQC/IPQC/OQC、SPC、NCR |
| traceability | 8094 | 批次、正反追溯 |
| equipment | 8082 | 台账、OEE、保养、维修 |
| mould | 8075 | 模具台账、寿命、保养 |
| material | 8084 | BOM、需求、供应商 |
| warehouse | 8072 | 出入库、盘点、库位 |
