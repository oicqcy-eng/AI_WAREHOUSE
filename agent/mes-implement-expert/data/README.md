# data — 数据资产

**MES实施专家** 的数据模型与样本。**原则**: 只存数据字典与脱敏样本，客户现场数据不入库。

## 文件说明

| 文件 | 用途 |
|------|------|
| `dictionary.md` | 数据字典：Agent 会引用的业务数据字段定义 |
| `samples.md` | 脱敏样本数据：few-shot/评估用 |
| `smes-621/` | 通用 SMES 数据字典（sMES_Production_61100，189表）解析库，见下方说明 |

## smes-621 数据字典（通用）

> `smes-621/` 是从客户数据字典《SMES_621数据库设计文档20250313.html》解析的**通用 MES 数据字典**（数据库 sMES_Production_61100，189 表 / 12,866 字段）。原件存 `delivery/inbox/`。

- 入口: `smes-621/README.md`（模块地图）
- 8 个模块文件: `01-wip-workorder.md` … `08-andon-system-erp.md`（字段级全量）
- 领域提炼: `smes-621/knowledge-cards.md`（K-621 系列）
- 引用方式: 回答字段/表结构问题时可查 `[smes-621]`

## 与业务模块数据的关系

| 数据 | 源头 | 说明 |
|------|------|------|
| 工单/排程 | `manufacturing/work-order/` `scheduling/` | 本目录只引用字段定义 |
| 设备OEE | `manufacturing/equipment/` | 同上 |
| 质量NCR | `manufacturing/quality/` | 同上 |
| 追溯批次 | `manufacturing/traceability/` | 同上 |

## 规范

1. **字典先行**: 任何被 Agent 引用的字段先入 `dictionary.md`
2. **脱敏**: 样本数据客户名/人员名/真实编码一律替换（如「机加工厂A」）
3. **真实数据查询**: 通过 `tools/query-templates.sql` 只读查询，不落地入库
