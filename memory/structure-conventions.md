---
name: structure-conventions
description: AI-WAREHOUSE 目录结构规范、模块模板、命名约定
metadata:
  type: reference
---

# 仓库结构规范

## 7 层架构

```
base/              基础层 — 所有模块依赖的基础服务
manufacturing/     制造执行层 — MES 核心业务
operations/        运营管理层 — 基于制造数据的可视化
ai/                AI智能层 — 独立 AI 能力
agent/             AI Agent 业务层 — 一个 Agent 一个自包含目录
delivery/          客户交付执行层 — 项目自包含(inbox + projects)，客户端数据只进这里
shared/            共享基础设施 — 横切所有层
```

辅助区：`skills/`（可复用 Claude Skills，SKILL.md 格式）、`docs/`（规范/行业知识）、`memory/`（项目记忆）。

依赖顺序：shared → base → manufacturing → operations，ai 可独立部署；
agent/ 使用 ai/ 的推理与向量库 + 业务层数据；delivery/ 交付后回哺 knowledge/skills。

## 模块模板

每个模块遵循统一内部结构：

```
module/
├── deploy/         部署配置
│   ├── docker-compose.yml   Docker Compose 本地部署
│   └── k8s/                  K8s 资源清单
├── monitor/        监控告警
│   └── prometheus-rules.yml  Prometheus 告警规则
├── runbooks/       运维手册
│   ├── deploy.md            部署步骤
│   ├── ops.md               日常运维
│   └── troubleshoot.md      故障排查
├── database/       数据库
│   ├── migrations/          DDL 迁移脚本
│   ├── queries/             常用查询模板
│   └── seed/                种子数据
├── config/         配置模板
└── tests/          运维验证
    └── smoke-test.sh        冒烟测试
```

## Agent 模块模板（agent/ 下）

```
agent/<agent-name>/
├── README.md       能力定义 / 依赖 / 使用入口
├── CHANGELOG.md    版本变更记录(语义化版本+git tag，不做目录快照)
├── config/         Agent配置(模型/参数/路由)
├── prompt/         system/role/task prompt + few-shot + 优化记录
├── knowledge/      知识引用清单 / FAQ / SOP / 案例
├── tools/          接口定义 / SQL 模板 / 脚本
├── workflow/       多步流程定义
├── data/           数据字典 / 样本数据
├── evaluation/     测试问题库 / 标准答案 / 评分(准确率/专业度/稳定性)
└── runbooks/       使用 / 维护 / 故障手册
```

对应关系：`deploy→config`、`database→data`、`monitor→evaluation`、`runbooks→runbooks`、`tests→evaluation`。
知识分级：L1 行业知识 `docs/industry-knowledge/` → L2 通用 `agent/_shared/` → L3 Agent 专属 `knowledge/`。
版本发布：`git tag agent/<agent-name>/vX.Y.Z`。生命周期过程见 `docs/agent-lifecycle.md`。

## 交付项目模板（delivery/projects/ 下）

```
delivery/projects/<客户项目>/
├── README.md         项目背景/目标/状态
├── input/            项目输入(脱敏)
│   ├── requirements/  需求文档
│   ├── sql/           数据/查询脚本(脱敏)
│   ├── report_ui/     报表/看板规格
│   └── interfaces/    接口/集成规格
├── knowledge/        项目专属知识/决策
├── output/           交付物(方案/PPT/SOP/报表)
└── CHANGELOG.md      交付记录
```

核心规则：客户端数据只进 delivery/（脱敏）；新资料先落 inbox/；可复用经验交付后回哺。

## 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 目录名 | kebab-case | `master-data/`, `work-order/` |
| 脚本文件 | 动词开头 | `deploy.sh`, `health-check.sh` |
| 配置文件 | 组件命名 | `prometheus-rules.yml`, `docker-compose.yml` |
| README | 每个目录一个 | `README.md` |

## 关键约定

1. **不存放真实密钥**: 配置文件用 `.example` 后缀，`.env` 在 .gitignore 中
2. **配置与手册同步**: 修改 deploy/ 或 config/ 必须更新对应 runbooks/
3. **模块可独立部署**: 每个模块的 docker-compose.yml 可单独启动
4. **监控规则随模块走**: 告警规则放在模块的 monitor/ 下，由 Prometheus 统一加载
