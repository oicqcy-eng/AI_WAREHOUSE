# AI-WAREHOUSE 系统架构

## 部署架构
```
[用户/API] → [Nginx 网关] → 基础数据层 → 生产执行层 → 制造支撑层 → 运营管理层 → AI智能层
                    ↓
            [共享基础设施]
            PG / Redis / MinIO
            Prometheus / Grafana / Loki
```

## 模块分层
| 层 | 模块 | 说明 |
|----|------|------|
| 基础数据 | master-data, barcode | 企业主数据与条码体系 |
| 生产执行 | production, work-order, scheduling, process, andon | 生产全流程执行 |
| 制造支撑 | quality, equipment, material, warehouse, mould, energy, traceability | 生产保障与支撑 |
| 运营管理 | system, document, reporting, kanban, iiot | 管理与可视化 |
| AI智能 | ai-serving, gpu, vector-db, training | 智能分析与推理 |

## 环境规划
- dev: Docker Compose, 1×RTX4090
- staging: Docker Compose, 1×A100 40G
- prod: K8s 集群, 2×A100 80G
