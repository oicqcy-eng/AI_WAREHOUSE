# runbooks — 使用与维护手册

**MES实施专家** 的运行维护手册，对齐仓库 `runbooks/` 规范（deploy/ops/troubleshoot）。

## 手册索引

| 手册 | 内容 | 状态 |
|------|------|:----:|
| `deploy.md` | 部署/接入步骤 | 待填充 |
| `ops.md` | 日常运维（配置/知识/评估维护） | 待填充 |
| `troubleshoot.md` | 常见故障排查 | 待填充 |

## 运行依赖速查

| 依赖 | 说明 | 对应仓库 |
|------|------|----------|
| 模型推理 | 主模型/轻量模型 | `ai/serving/` |
| 知识检索 | 向量库 collection: mes-knowledge | `ai/vector-db/` |
| 业务数据 | 只读查询 | `shared/database/` |
| 交付物输出 | 生成成品 | `docs/deliverables/` |

## 维护清单（定期）

- [ ] Prompt 是否与知识库同步（知识变更 → Prompt 上下文核对）
- [ ] 测试集是否覆盖最新业务场景（新增场景 → 补测试题）
- [ ] 评分记录是否回填（跑评估后写 `evaluation/scorecard.md`）
- [ ] CHANGELOG 是否更新（版本发布后）
