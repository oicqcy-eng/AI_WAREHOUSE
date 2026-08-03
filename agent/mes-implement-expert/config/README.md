# config — Agent 配置

本目录存放 **MES实施专家** 的 Agent 配置。配置决定行为：模型、检索、工具权限、输出约束。

## 文件说明

| 文件 | 用途 | 是否入库 |
|------|------|:--------:|
| `agent.yaml` | 版本基线配置（模板） | ✅ 入库 |
| `agent.local.yaml` | 本机/环境覆盖（复制自模板填写） | ❌ 入库（`.gitignore`） |

## 关键配置项

| 项 | 说明 |
|----|------|
| `model.base_url` | 推理服务地址，按环境用 `{{ENV.xxx}}` 注入 |
| `model.primary / light` | 主模型（复杂推理）与轻量模型（分类抽取）分工 |
| `retrieval` | 向量检索参数；`score_threshold` 低于阈值的知识不注入，防幻觉 |
| `tools_enabled` | 工具白名单，最小权限原则：默认只读 |
| `behavior.no_hallucination` | 咨询输出硬约束：不确定须声明，禁止编造客户数据 |
| `evaluation.min_score` | 版本发布门槛（对应 `evaluation/`） |

## 规范

1. **agent.yaml 是基线**：版本发布时随 CHANGELOG 一起走 git tag
2. **密钥不入库**：真实密钥走环境变量/密钥管理
3. **修改配置必须过评估**：改模型/检索参数后，重跑 `evaluation/test-cases.md`
