# CHANGELOG — 工业数字化顾问 Agent

本文件记录该 Agent 的能力、Prompt、知识、工具、流程的版本变更。
版本号遵循语义化版本 `vMAJOR.MINOR.PATCH`，发布时以 git tag 标记：

```bash
git tag agent/industrial-consultant/vX.Y.Z
```

版本发布前必须在 `evaluation/` 跑质量评估（准确率/专业度/稳定性），结果记入对应版本。

## [v0.1.0] - 2026-08-03

- 初始化 Agent 骨架：config / prompt / knowledge / tools / workflow / data / evaluation / runbooks
- 定义能力边界：工业企业数字化诊断，覆盖 MES/IIoT/AI/数据治理，输出诊断报告与演进路线
