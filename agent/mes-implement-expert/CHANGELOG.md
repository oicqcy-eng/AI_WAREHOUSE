# CHANGELOG — MES实施专家 Agent

本文件记录该 Agent 的能力、Prompt、知识、工具、流程的版本变更。
版本号遵循语义化版本 `vMAJOR.MINOR.PATCH`，发布时以 git tag 标记：

```bash
git tag agent/mes-implement-expert/vX.Y.Z
```

版本发布前必须在 `evaluation/` 跑质量评估（准确率/专业度/稳定性），结果记入对应版本。

## [v0.2.0] - 2026-08-03

- 完整落盘为标准模板（首个 Agent 样板），覆盖全链路：
  - config/: agent.yaml 配置模板（模型/检索/工具白名单/发布门槛）
  - prompt/: system.md 角色定义 + few-shot.md 三场景 + optimization-log.md
  - knowledge/: index.md 引用清单 + faq.md/sop.md/cases.md
  - tools/: 工具清单 + query-templates.sql 只读模板
  - workflow/: 实施咨询四阶段流程（调研→差距→方案→计划）
  - data/: dictionary.md 数据字典 + samples.md 脱敏样本
  - evaluation/: test-cases.md 测试集(6题) + scorecard.md 评分记录
  - runbooks/: deploy/ops/troubleshoot 三手册
- 版本状态: 基线待评估（测试集就绪，首轮运行后回填 scorecard）

## [v0.1.0] - 2026-08-03

- 初始化 Agent 骨架：config / prompt / knowledge / tools / workflow / data / evaluation / runbooks
- 定义能力边界：基于鼎华SMES业务模型输出实施咨询、模块规划、差异分析
