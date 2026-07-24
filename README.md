# AI-WAREHOUSE 🏭🤖

> **复合AI平台 · 运维实施仓库**
>
> 覆盖 **鼎华SMES全功能模块** + **AI智能层** 的运维实施中心。
> 按业务功能模块组织，每个模块自包含部署/监控/手册/数据库/配置。

---

## 🏗️ 模块全景

### 📋 基础数据层

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[master-data](master-data/)** | 基础资料（编码/客户/供应商/员工/部门/工序） | 8071 | 部署·监控·手册 |
| **[barcode](barcode/)** | 条码/RFID（规则/打印/扫描配置） | 8076 | 部署·监控 |

### 🏭 生产执行层

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[production](production/)** | 生产管理（执行/派工/报工/WIP） | 8083 | 部署·监控 |
| **[work-order](work-order/)** | 工单管理（拆分/优先级/完工） | 8085 | 部署·监控 |
| **[scheduling](scheduling/)** | 排程管理（MPS/MRP/APS） | 8073 | 部署·监控 |
| **[process](process/)** | 工艺管理（路线/SOP/参数） | 8087 | 部署·监控 |
| **[andon](andon/)** | 安灯（异常呼叫/升级/响应） | 8088 | 部署·监控 |

### 🏗️ 制造支撑层

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[quality](quality/)** | 品质管理（IQC/IPQC/OQC/SPC） | 8081 | 部署·监控·手册 |
| **[equipment](equipment/)** | 设备管理（台账/OEE/保养/维修） | 8082 | 部署·监控 |
| **[material](material/)** | 物料管理（BOM/需求/供应商/批次） | 8084 | 部署·监控 |
| **[warehouse](warehouse/)** | 仓库管理（出入库/盘点/库位） | 8072 | 部署·监控 |
| **[mould](mould/)** | 模具管理（台账/寿命/保养） | 8075 | 部署·监控 |
| **[energy](energy/)** | 能源管理（能耗/能效/碳排） | 8089 | 部署·监控 |
| **[traceability](traceability/)** | 追溯管理（批次/正反追溯） | 8094 | 部署·监控 |

### 📊 运营管理层

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[system](system/)** | 系统管理（用户/角色/权限/审计/通知） | 8086 | 部署·监控·手册 |
| **[document](document/)** | 文档管理（图纸/文档/审批/检索） | 8093 | 部署·监控 |
| **[reporting](reporting/)** | 报表引擎（报表/导出/分发） | 8091 | 部署·监控 |
| **[kanban](kanban/)** | 看板管理（生产/品质/设备/安灯大屏） | 8074 | 部署·监控 |
| **[iiot](iiot/)** | IIoT采集（边缘网关/协议/采集器） | 8090 | 部署·监控 |

### 🤖 AI 智能层

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[ai-serving](ai-serving/)** | AI推理（vLLM/Triton） | 8000 | 部署·监控 |
| **[gpu](gpu/)** | GPU资源（DCGM/调度/监控） | 9400 | 监控·手册 |
| **[vector-db](vector-db/)** | 向量数据库（Milvus/Qdrant） | 19530 | 部署·监控 |
| **[training](training/)** | 模型训练（分布式训练） | - | 部署·监控 |

### 🔧 共享基础设施

| 组件 | 目录 | 说明 |
|------|------|------|
| PostgreSQL | [shared/database](shared/database/) | 关系数据库运维 |
| MySQL | [shared/database](shared/database/) | 关系数据库运维 |
| Redis | [shared/database](shared/database/) | 缓存运维 |
| Nginx | [shared/gateway](shared/gateway/) | API网关 |
| MinIO | [shared/gateway](shared/gateway/) | 对象存储 |
| Prometheus | [shared/monitoring](shared/monitoring/) | 指标采集 |
| Grafana | [shared/monitoring](shared/monitoring/) | 可视化面板 |
| Loki | [shared/monitoring](shared/monitoring/) | 日志汇聚 |
| SSL | [shared/security](shared/security/) | 证书管理 |
| Ansible | [shared/automation](shared/automation/) | 自动化 |
| Terraform | [shared/automation](shared/automation/) | IaC |

---

## 🚀 快速开始

```bash
# 1. 启动基础设施
docker compose -f shared/database/docker-compose.yml up -d
docker compose -f shared/monitoring/docker-compose.yml up -d

# 2. 启动基础数据
docker compose -f master-data/deploy/docker-compose.yml up -d

# 3. 启动业务模块（按需）
docker compose -f quality/deploy/docker-compose.yml up -d
docker compose -f equipment/deploy/docker-compose.yml up -d

# 4. 启动 AI 推理
docker compose -f ai-serving/deploy/docker-compose.yml up -d

# 5. 健康检查
./cicd/scripts/health-check.sh
```

---

## 📂 全局目录

| 目录 | 说明 |
|------|------|
| [cicd/](cicd/) | CI/CD 流水线与部署脚本 |
| [environments/](environments/) | 环境配置 (dev/staging/prod) |
| [docs/](docs/) | 架构文档 |
| [scripts/](scripts/) | 工具脚本 |

---

## 📋 覆盖对照

| 鼎华SMES模块 | AI_WAREHOUSE | 覆盖 |
|-------------|-------------|------|
| 系统管理 | system/ | ✅ |
| 基础资料 | master-data/ | ✅ |
| 工艺管理 | process/ | ✅ |
| 生产管理 | production/ + work-order/ + scheduling/ | ✅ |
| 品质管理 | quality/ | ✅ |
| 设备管理 | equipment/ | ✅ |
| 物料管理 | material/ | ✅ |
| 仓库管理 | warehouse/ | ✅ |
| 排程管理 | scheduling/ | ✅ |
| 看板管理 | kanban/ | ✅ |
| 安灯管理 | andon/ | ✅ |
| 追溯管理 | traceability/ | ✅ |
| 文档管理 | document/ | ✅ |
| 报表管理 | reporting/ | ✅ |
| 能源管理 | energy/ | ✅ |
| 模具管理 | mould/ | ✅ |
| 条码管理 | barcode/ | ✅ |
| **AI智能层** | ai-serving/ gpu/ vector-db/ training/ | ⭐ **超越** |
| **IIoT边缘** | iiot/ | ⭐ **超越** |
