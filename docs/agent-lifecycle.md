# Agent 生命周期（过程模型）

> 生命周期是**过程**，用本文档表达；目录按 Agent 组织资产（见 `agent/`）。
> 本模型描述一个 Agent 从规划到运营闭环的完整路径，各阶段产出落进对应 Agent 目录。

## 生命周期闭环

```
规划 → 业务 → 知识 → Agent → 流程 → 工具 → 数据 → Prompt → 评估 → 发布 → 应用 → 运营
  ↑                                                                             │
  └──────────────────────── 反馈优化（评估+运营结果回流） ───────────────────────┘
```

| 阶段 | 做什么 | 产出落点 |
|------|--------|----------|
| 01 项目规划 | 目标/范围/用户/版本规划 | `docs/` 或 Agent README 能力定义 |
| 02 业务分析 | 业务域与行业资产 | `docs/industry-knowledge/`（L1）、Agent `knowledge/`（L3） |
| 03 知识构建 | 资料清洗 → 结构化知识 | 引用清单进 `knowledge/`，向量进 `ai/vector-db/` |
| 04 Agent 定义 | 能力边界/配置 | 对应 Agent 的 `config/` + README |
| 05 流程设计 | 多步执行路径 | 对应 Agent 的 `workflow/` |
| 06 工具集成 | 接口/查询/脚本 | 对应 Agent 的 `tools/` |
| 07 数据准备 | 字典/样本/权限 | 对应 Agent 的 `data/` |
| 08 Prompt 工程 | prompt 与 few-shot | 对应 Agent 的 `prompt/` |
| 09 评估验证 | 测试集/标准答案/评分(准确率/专业度/稳定性) | 对应 Agent 的 `evaluation/` |
| 10 版本发布 | 语义化版本 + git tag + CHANGELOG 更新 | `CHANGELOG.md` + `git tag agent/<name>/vX.Y.Z` |
| 11 应用交付 | 部署/对接业务模块 | 对应 Agent 的 `runbooks/` + README |
| 12 运营优化 | 反馈/问题统计/prompt 迭代 | 回流到 `evaluation/` 与 `prompt/` |

**交付物归属**: Agent 生成的成品（方案/汇报/PPT/SOP）= 一次性交付物，
归档到 `docs/deliverables/<客户或项目>/`，**不散落在 agent 内**；agent 内只保留生成能力(workflow/tools)。

## 关键原则

1. **一个 Agent 的资产内聚在一个目录**，阶段只是过程描述，不是目录结构
2. **评估驱动迭代**：运营阶段产生的反馈，回流到 09 评估与 08 Prompt
3. **知识单一来源 + 分级**：L1 行业知识(`docs/industry-knowledge/`) → L2 通用知识(`_shared/`) → L3 Agent 专属(`knowledge/`)；向量数据在 `ai/vector-db/`
4. **版本可回溯**：每次发布 = git tag + CHANGELOG + 评估基准存档；evaluation/ 保留历史，支撑模型与 Prompt 的版本对比
5. **能力与成品分离**：agent/ 存可复用能力，`docs/deliverables/` 存一次性成品
6. **生命周期是过程**：本文档描述过程，目录结构始终按 Agent 内聚，不做阶段式目录
