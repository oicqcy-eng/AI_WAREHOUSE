# AI-WAREHOUSE 🏭🤖

> **复合AI平台 · 运维实施仓库**
>
> 覆盖鼎华SMES全功能 + AI智能层 + AI Agent业务层 + 客户交付执行，按业务层级组织，模块自包含。

> 📖 想了解仓库**怎么建起来的、每个决策为什么** → 看 [BUILDING.md](BUILDING.md)（完整建设历程）。

---

## 🏗️ 层级结构

```
base/               ← 基础层：所有模块依赖的基础
├── system/         系统管理
├── master-data/    基础资料
└── barcode/        条码/RFID

manufacturing/      ← 制造执行层：MES 核心业务
├── scheduling/     排程管理 (MPS/MRP/APS)
├── production/     生产管理
├── work-order/     工单管理
├── process/        工艺管理
├── andon/          安灯管理
├── quality/        品质管理 (IQC/IPQC/OQC/SPC)
├── traceability/   追溯管理
├── equipment/      设备管理 (台账/OEE/保养)
├── mould/          模具管理
├── material/       物料管理
└── warehouse/      仓库管理

operations/         ← 运营管理层：基于制造数据的可视化
├── kanban/         看板管理 (生产/品质/设备大屏)
├── reporting/      报表引擎
├── document/       文档管理
├── energy/         能源管理
└── iiot/           IIoT采集 (边缘网关/协议)

ai/                 ← AI智能层：差异化优势
├── serving/        AI推理 (vLLM/Triton)
├── gpu/            GPU资源 (DCGM/调度)
├── vector-db/      向量数据库
└── training/       模型训练

agent/              ← AI Agent 能力资产库：一个 Agent 一个自包含目录，可版本化/可评估/可运营
├── mes-implement-expert/   MES实施专家
├── mes-report-agent/       MES项目汇报
├── industrial-consultant/  工业数字化顾问
└── _shared/                跨 Agent 公共资产(模板/通用Prompt/工具)

知识分级: 行业知识 docs/industry-knowledge/ · 通用知识 _shared/ · Agent 专属 knowledge/
工程化:   语义化版本+git tag · 每 Agent CHANGELOG · evaluation 质量体系

delivery/           ← 客户交付执行区：项目自包含，客户端数据只进这里(脱敏)
├── inbox/            统一收件箱：新资料先进再归类
└── projects/         客户交付项目(按需创建,含 input/knowledge/output)

skills/             ← 可复用 Claude Skills (SKILL.md 格式)
└── delivery-review/   交付物质量复核示例

shared/             ← 共享基础设施 (横切所有层)
    database/       PostgreSQL / Redis
    gateway/        Nginx API网关
    monitoring/     Prometheus / Grafana / Loki
    security/       SSL / 安全基线
    automation/     Ansible / Terraform
```

---

## 🚀 快速开始

```bash
# 1. 基础设施
docker compose -f shared/database/docker-compose.yml up -d
docker compose -f shared/monitoring/docker-compose.yml up -d

# 2. 基础层
docker compose -f base/system/deploy/docker-compose.yml up -d
docker compose -f base/master-data/deploy/docker-compose.yml up -d

# 3. 制造层 (按需)
docker compose -f manufacturing/quality/deploy/docker-compose.yml up -d
docker compose -f manufacturing/equipment/deploy/docker-compose.yml up -d

# 4. AI智能层 (需GPU)
docker compose -f ai/serving/deploy/docker-compose.yml up -d vllm

# 5. 健康检查
./cicd/scripts/health-check.sh
```

---

## 📋 鼎华SMES覆盖对照

| 鼎华模块 | 仓库路径 | 状态 |
|---------|---------|:----:|
| 系统管理 | base/system/ | ✅ |
| 基础资料 | base/master-data/ | ✅ |
| 工艺管理 | manufacturing/process/ | ✅ |
| 生产管理 | manufacturing/production/ | ✅ |
| 工单管理 | manufacturing/work-order/ | ✅ |
| 排程管理 | manufacturing/scheduling/ | ✅ |
| 品质管理 | manufacturing/quality/ | ✅ |
| 设备管理 | manufacturing/equipment/ | ✅ |
| 模具管理 | manufacturing/mould/ | ✅ |
| 物料管理 | manufacturing/material/ | ✅ |
| 仓库管理 | manufacturing/warehouse/ | ✅ |
| 条码管理 | base/barcode/ | ✅ |
| 看板管理 | operations/kanban/ | ✅ |
| 安灯管理 | manufacturing/andon/ | ✅ |
| 追溯管理 | manufacturing/traceability/ | ✅ |
| 文档管理 | operations/document/ | ✅ |
| 报表管理 | operations/reporting/ | ✅ |
| 能源管理 | operations/energy/ | ✅ |
| **AI智能层** | ai/* | ⭐ 超越 |
| **IIoT边缘** | operations/iiot/ | ⭐ 超越 |
