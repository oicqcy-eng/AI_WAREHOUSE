# 运维手册 — MES实施专家

> 日常维护操作，保持 Agent 持续有效。

## 日常检查

- [ ] **模型服务**: 推理端点可用（`ai/serving/`）
- [ ] **知识检索**: 向量库 collection 存在且有索引
- [ ] **工具连通**: 只读查询可执行
- [ ] **交付物**: `docs/deliverables/` 产出可访问

## 例行维护（周/月）

### 知识维护
- 行业知识变更 → 更新 `docs/industry-knowledge/` + 重新向量化
- Agent 专属知识 → 更新 `knowledge/` 并登记 `index.md` ID

### Prompt 维护
- 反馈/评估暴露问题 → 改 `prompt/system.md`，写 `prompt/optimization-log.md`
- few-shot 过期 → 更新 `prompt/few-shot.md`

### 评估维护
- 每月跑一次 `evaluation/test-cases.md` 全量回归
- 新业务场景 → 补测试题，保持覆盖率

## 版本发布流程

1. 跑全量评估 → `evaluation/scorecard.md` 达标（≥0.85）
2. 更新 `CHANGELOG.md`（版本号 + 变更）
3. `git tag agent/mes-implement-expert/vX.Y.Z`
4. 同步更新 `config/agent.yaml` 版本号
