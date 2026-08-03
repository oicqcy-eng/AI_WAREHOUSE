# memory — 项目记忆

> **定位**: 本仓库的**项目设计记忆与决策记录**，供 Claude Code 与协作者快速理解仓库背景。
> 每个文件带 frontmatter(name/description/type)，便于检索。

## 存什么 ✅

- 仓库设计演化与决策缘由（`design-evolution.md`）
- 结构规范与模块模板（`structure-conventions.md`）
- 业务模块覆盖对照（`smes-coverage.md`）
- 使用指南 / 后续任务（`usage-guide.md`、`next-steps.md`）

## 不存什么 ❌

| 内容 | 应放位置 |
|------|----------|
| 业务知识 / 行业方法论 | `docs/industry-knowledge/` 或对应业务模块 |
| Agent 专属知识引用 | 各 Agent 的 `knowledge/` |
| 客户交付物 / 成品 | `docs/deliverables/` |
| 客户现场数据 / 密钥 | 不入库（脱敏或外部存储） |

## 与 Agent "记忆"概念的区别 ⚠️

- 本目录 = **仓库项目记忆**（静态、可提交、给协作者读）
- Agent **运行时记忆**（对话上下文 / 用户画像 / 会话状态）= 动态数据，**不入库**，由运行层承载（数据库 / 向量库 / Redis）
- 二者不要混淆：仓库里不存 Agent 的运行时记忆
