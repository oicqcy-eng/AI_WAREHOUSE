# knowledge — 知识库

**L3 Agent 专属知识**：本 Agent 高频引用的知识条目。

## 文件说明

| 文件 | 用途 |
|------|------|
| `index.md` | **知识引用清单**（唯一入口，所有知识在此登记 ID） |
| `faq.md` | 高频问题标准答案 |
| `sop.md` | 标准操作流程（调研/评审等） |
| `cases.md` | 脱敏实施案例 |

## 知识分级（L1/L2/L3）

- **L1 行业知识** → `docs/industry-knowledge/`（共享，跨 Agent）
- **L2 通用知识** → `agent/_shared/`（共享模板/方法论）
- **L3 本 Agent** → 本目录（引用 + 要点）
- **向量数据** → `ai/vector-db/`（collection: mes-knowledge）

## 维护规范

1. **知识必须登记**：新条目先写入 `index.md` 分配 ID，再写内容
2. **内容与引用分离**：大文档/版权资料不入库，`index.md` 留引用和要点
3. **向量化**：检索类条目同步进 `ai/vector-db/mes-knowledge`
4. **脱敏**：案例/客户信息必须脱敏，客户现场数据不入库
