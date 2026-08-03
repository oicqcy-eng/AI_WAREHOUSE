# 部署手册 — MES实施专家

> Agent 接入与部署步骤。作为可运行 Agent 时的接入流程；当前为能力资产库阶段，主要完成「配置就绪」。

## 前置条件

- 模型推理服务可用：`ai/serving/`（见 `ai/serving/README.md`）
- 向量库可用：`ai/vector-db/` collection `mes-knowledge`
- 只读数据库连接：`shared/database/`

## 部署步骤

1. **配置就绪**
   ```bash
   cp config/agent.yaml config/agent.local.yaml
   # 填写 agent.local.yaml 的 ENV 变量（base_url、密钥引用）
   ```

2. **知识向量化**
   - 将 `knowledge/` 检索类条目向量化，导入 `mes-knowledge` collection
   - 校验 `retrieval.score_threshold`（config）符合预期

3. **工具连通**
   - 配置 `mes_query`/`sql_query` 只读连接（`tools/README.md`）
   - 验证 `tools/query-templates.sql` 样例可执行

4. **冒烟验证**
   - 跑 1 题 `evaluation/test-cases.md`（如 K-1）验证回答质量
   - 确认输出遵守 System Prompt（引用标注/不编造）

## 验证通过标准

- 测试集首轮跑通，准确率 ≥ 0.85（`evaluation/scorecard.md` 回填）
- 工具只读权限验证通过（无写权限）
