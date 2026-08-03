# Agent 业务层 (agent/)

> **定位**: 将业务知识、Prompt、工具、流程、数据、评估组合成可运营的智能体资产
> **核心原则**: 一个 Agent = 一个自包含目录，找某个 Agent 的所有物料进一个目录

## 与 ai/ 的分工

| 层 | 职责 | 内容 |
|----|------|------|
| `ai/` | AI 基础设施 | 模型推理(serving)、GPU(gpu)、向量库(vector-db)、训练(training) |
| `agent/` | AI Agent 业务 | 业务知识、Prompt、工具、流程、数据、评估、交付与运营 |

**依赖方向**: `agent → 使用 ai/ 的推理与向量库 + operations/manufacturing/base 的业务数据`

- 知识向量化后存放于 `ai/vector-db/`，`knowledge/` 只保留**引用清单**与来源资料，不存向量
- Agent 推理调用 `ai/serving/`，GPU 调度依赖 `ai/gpu/`

## 目录结构

```
agent/
├── mes-implement-expert/    MES实施专家
├── mes-report-agent/        MES项目汇报
├── industrial-consultant/   工业数字化顾问
└── _shared/                 跨 Agent 公共资产(模板/通用Prompt/公共工具脚本)
```

## Agent 模块模板

```
agent/<agent-name>/           ← kebab-case
├── README.md       能力定义 / 依赖 / 使用入口
├── config/         Agent配置(模型/参数/路由)
├── prompt/         system/role/task prompt + few-shot + 优化记录
├── knowledge/      知识引用清单 / FAQ / SOP / 案例
├── tools/          接口定义 / SQL 模板 / 脚本
├── workflow/       多步流程定义
├── data/           数据字典 / 样本数据
├── evaluation/     测试问题库 / 标准答案 / 准确率记录
└── runbooks/       使用 / 维护 / 故障手册
```

与业务模块模板(deploy/monitor/runbooks/database/config/tests)一一对应：
`deploy→config`、`database→data`、`monitor→evaluation`、`runbooks→runbooks`、`tests→evaluation`。

## 命名与边界

- 目录名 kebab-case；脚本文件动词开头；不存放真实密钥
- 跨 Agent 的通用资产放 `_shared/`，业务专属内容不得混入
- 生命周期(规划→运营闭环)见 `docs/agent-lifecycle.md` —— 生命周期是**过程**，用文档表达，不用目录表达
- 每个 Agent 的 prompt/knowledge/evaluation 必须**内聚在本目录**，不散落全局
