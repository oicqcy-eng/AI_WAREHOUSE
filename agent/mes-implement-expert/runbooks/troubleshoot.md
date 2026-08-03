# 故障排查 — MES实施专家

> 常见问题与处理步骤。先看症状，按顺序排查。

## T1: 回答明显错误/幻觉

**症状**: 输出与领域事实不符、编造数据
**排查**:
1. 检查 `config/agent.yaml` `temperature`（过高 → 降低到 0.3）
2. 检查 `retrieval.score_threshold`（过低 → 无关知识注入，调高到 0.6）
3. 检查 `knowledge/` 是否有对应知识；没有 → 补充知识 + 登记 index
4. 检查 `prompt/system.md` `no_hallucination` 是否生效
**处理**: 定位后修复 → 重跑 `evaluation/test-cases.md` → 记录 `optimization-log.md`

## T2: 检索不到知识

**症状**: 明确存在的知识，Agent 未引用
**排查**:
1. 向量库 `mes-knowledge` collection 是否存在/有数据
2. `top_k` 是否太小（`config` → 适当调大）
3. 知识是否已向量化（`knowledge/README.md` 规范）

## T3: 工具查询失败

**症状**: `sql_query`/`mes_query` 报错
**排查**:
1. 只读连接配置（`config/agent.local.yaml`）
2. 模板 SQL 表名是否与对应模块 `database/` 一致（`tools/query-templates.sql`）
3. 权限：确认是只读账号

## T4: 评估不达标

**症状**: `evaluation/scorecard.md` 准确率 < 0.85
**排查**:
1. 看哪类题失分（K/S/B）→ 定位薄弱点
2. K类失分 → 补知识；S类失分 → 改进 few-shot/流程；B类失分 → 改 System Prompt 边界
3. 修复后重跑，达标才发布

## 处理规范

- 每次故障记录到 `prompt/optimization-log.md`（如果根因是 Prompt/知识）
- 无法解决时，回滚到上一 git tag 版本（`CHANGELOG.md` 记录）
