# AI-WAREHOUSE 🏭🤖

> **复合AI平台 · 运维实施仓库**
>
> 按业务功能模块组织的运维实施中心，覆盖 AI 推理 + 智能制造全链路的
> 部署、监控、维护、灾备与日常运维。

---

## 🏗️ 功能模块导航

### 🏭 制造域

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[quality](quality/)** | 质量管理 (IQC/IPQC/OQC/SPC/NCR) | 8081 | [部署](quality/runbooks/deploy.md) · [监控](quality/monitor/) · [故障排查](quality/runbooks/troubleshoot.md) |
| **[equipment](equipment/)** | 设备管理 (台账/OEE/保养/维修) | 8082 | [部署](equipment/runbooks/deploy.md) · [监控](equipment/monitor/) |
| **[production](production/)** | 生产管理 (执行/派工/报工/WIP) | 8083 | 部署 · 监控 |
| **[material](material/)** | 物料管理 (库存/BOM/出入库) | 8084 | 部署 · 监控 |
| **[work-order](work-order/)** | 工单管理 (拆分/优先级/完工) | 8085 | 部署 · 监控 |
| **[system](system/)** | 系统配置 (用户/角色/权限/审计) | 8086 | [部署](system/runbooks/deploy.md) · [监控](system/monitor/) |
| **[process](process/)** | 工艺管理 (路线/SOP/参数/版本) | 8087 | 部署 · 监控 |
| **[andon](andon/)** | 安灯 (异常呼叫/升级/响应) | 8088 | 部署 · 监控 |
| **[energy](energy/)** | 能源管理 (能耗/能效/碳排) | 8089 | 部署 · 监控 |
| **[iiot](iiot/)** | IIoT 采集 (边缘/协议/采集器) | 8090 | 部署 · 监控 |
| **[reporting](reporting/)** | 报表引擎 (报表/导出/分发) | 8091 | 部署 · 监控 |
| **[notification](notification/)** | 通知服务 (站内/邮件/短信/企微) | 8092 | 部署 · 监控 |
| **[document](document/)** | 文档管理 (图纸/文档/审批/检索) | 8093 | 部署 · 监控 |
| **[traceability](traceability/)** | 追溯管理 (批次/正反追溯) | 8094 | 部署 · 监控 |

### 🤖 AI 域

| 模块 | 说明 | 端口 | 运维入口 |
|------|------|------|---------|
| **[ai-serving](ai-serving/)** | AI 推理 (vLLM / Triton) | 8000 | [部署](ai-serving/runbooks/deploy.md) · [监控](ai-serving/monitor/) |
| **[gpu](gpu/)** | GPU 资源管理 | 9400 | [运维](gpu/runbooks/ops.md) · [监控](gpu/monitor/) |
| **[vector-db](vector-db/)** | 向量数据库 (Milvus / Qdrant) | 19530 | 部署 · 监控 |
| **[training](training/)** | 模型训练 | - | 部署 · 监控 |

### 🔧 共享基础设施

| 组件 | 说明 | 目录 |
|------|------|------|
| **PostgreSQL** | 关系数据库 | [shared/database/postgresql/](shared/database/postgresql/) |
| **Redis** | 缓存 | [shared/database/redis/](shared/database/redis/) |
| **Nginx** | API 网关 | [shared/gateway/nginx/](shared/gateway/nginx/) |
| **MinIO** | 对象存储 | [shared/storage/minio/](shared/storage/minio/) |
| **Prometheus** | 指标采集 | [shared/monitoring/prometheus/](shared/monitoring/prometheus/) |
| **Grafana** | 可视化面板 | [shared/monitoring/grafana/](shared/monitoring/grafana/) |
| **Loki** | 日志汇聚 | [shared/monitoring/loki/](shared/monitoring/loki/) |
| **SSL** | 证书管理 | [shared/security/ssl/](shared/security/ssl/) |
| **Ansible** | 自动化 | [shared/automation/ansible/](shared/automation/ansible/) |
| **Terraform** | IaC | [shared/automation/terraform/](shared/automation/terraform/) |

---

## 🚀 快速开始

```bash
# 1. 启动基础设施 (数据库/缓存/监控)
docker compose -f shared/database/docker-compose.yml up -d
docker compose -f shared/monitoring/docker-compose.yml up -d

# 2. 启动业务模块 (以 quality 为例)
docker compose -f quality/deploy/docker-compose.yml up -d

# 3. 启动 AI 推理 (需要 GPU)
docker compose -f ai-serving/deploy/docker-compose.yml up -d vllm

# 4. 健康检查
./cicd/scripts/health-check.sh
```

---

## 📋 运维原则

1. **模块自治** — 每个模块的部署/监控/文档都在自己目录内
2. **IaC 优先** — 所有配置以代码形式管理
3. **可观测性** — 无监控不发布
4. **文档即运维** — Runbook 与配置同步更新

---

## 📂 全局目录

| 目录 | 说明 |
|------|------|
| [cicd/](cicd/) | CI/CD 流水线与部署脚本 |
| [environments/](environments/) | 环境变量配置 (dev/staging/prod) |
| [docs/](docs/) | 全局架构文档与变更日志 |
| [scripts/](scripts/) | 全局工具脚本 |
