# Agent 业务层 (agent/)

> **定位**: 企业级制造业 AI Agent 能力资产库 —— 将业务知识、Prompt、工具、流程、数据、评估组合成**可版本化、可评估、可运营**的智能体资产
> **核心原则**: 一个 Agent = 一个自包含目录，找某个 Agent 的所有物料进一个目录

## 与 ai/ 的分工

| 层 | 职责 | 内容 |
|----|------|------|
| `ai/` | AI 基础设施 | 模型推理(serving)、GPU(gpu)、向量库(vector-db)、训练(training) |
| `agent/` | AI Agent 业务 | 业务知识、Prompt、工具、流程、数据、评估、版本与交付 |

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
├── CHANGELOG.md    版本变更记录(见"版本管理")
├── config/         Agent配置(模型/参数/路由)
├── prompt/         system/role/task prompt + few-shot + 优化记录
├── knowledge/      知识引用清单 / FAQ / SOP / 案例
├── tools/          接口定义 / SQL 模板 / 脚本
├── workflow/       多步流程定义
├── data/           数据字典 / 样本数据
├── evaluation/     测试问题库 / 标准答案 / 评分记录
└── runbooks/       使用 / 维护 / 故障手册
```

与业务模块模板(deploy/monitor/runbooks/database/config/tests)一一对应：
`deploy→config`、`database→data`、`monitor→evaluation`、`runbooks→runbooks`、`tests→evaluation`。

## 版本管理（Agent 工程化）

Agent 会持续迭代，必须可回溯"现在这个 Prompt 为什么这样写"。

- **语义化版本** `vMAJOR.MINOR.PATCH`：
  - MAJOR：能力边界/架构变更，不向后兼容
  - MINOR：新增能力/Prompt 优化/知识补充，向后兼容
  - PATCH：修复缺陷/微调
- **发布 = git tag**：`git tag agent/<agent-name>/vX.Y.Z`，**不做目录快照复制**（Git 本身即版本管理，`versions/v1.0/` 目录是冗余反模式）
- **每 Agent 维护 `CHANGELOG.md`**：记录每次变更内容、理由、评估结果
- 变更必须过质量评估（见下），评估基准随版本存档

## 质量体系（Agent 工程化）

> 不评估的 Agent 无法迭代。评价维度对齐业务价值，不是"能不能回答"。

- 每个 Agent 在 `evaluation/` 维护：**测试问题库 + 标准答案 + 评分记录**
- 核心指标：**准确率 / 专业度 / 稳定性**（同一问题多次回答一致性）
- 版本发布前必须跑评估；评估结果写入 CHANGELOG 对应版本

## 知识资产分级

知识按"共享范围"分三层，内容与引用分离：

| 级别 | 内容 | 存放位置 |
|------|------|----------|
| L1 行业业务知识 | 鼎华MES/U9/汽配/精益生产等行业经验与方法论 | `docs/industry-knowledge/`（共享索引）或对应业务模块 |
| L2 通用知识 | 标准/方法论/模板/通用案例 | `agent/_shared/` |
| L3 Agent 专属知识 | 引用清单/FAQ/SOP/案例 | 各 Agent 的 `knowledge/` |
| 向量化数据 | 检索用向量 | `ai/vector-db/`（knowledge/ 只存引用） |

## 命名与边界

- 目录名 kebab-case；脚本文件动词开头；不存放真实密钥
- 跨 Agent 的通用资产放 `_shared/`，业务专属内容不得混入
- 生命周期(规划→版本→运营闭环)见 `docs/agent-lifecycle.md` —— 生命周期是**过程**，用文档表达，不用目录表达
- 每个 Agent 的 prompt/knowledge/evaluation 必须**内聚在本目录**，不散落全局
