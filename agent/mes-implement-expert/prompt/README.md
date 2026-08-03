# prompt — Prompt 工程

本目录管理 **MES实施专家** 的 Prompt 资产，核心是**可追踪、可评估**。

## 文件说明

| 文件 | 用途 |
|------|------|
| `system.md` | System Prompt：角色定义、工作原则、知识边界、输出规范 |
| `few-shot.md` | Few-shot 示例：约束输出格式（调研/方案/推广三场景） |
| `optimization-log.md` | 优化记录：每次变更的动机与评估效果 |

## 规范

1. **Prompt 有版本**：`system.md` 顶部标注版本号，变更写入 `optimization-log.md`
2. **Prompt 与知识联动**：Prompt 引用 `knowledge/` 的知识ID，知识更新即 Prompt 上下文变化
3. **改 Prompt 必须过评估**：变更后重跑 `evaluation/test-cases.md`，对比 `scorecard.md`
4. **few-shot 对齐 workflow**：每个 few-shot 对应 `workflow/` 的一个流程阶段
