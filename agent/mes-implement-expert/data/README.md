# data — 数据资产

**MES实施专家** 的数据模型与样本。**原则**: 只存数据字典与脱敏样本，客户现场数据不入库。

## 文件说明

| 文件 | 用途 |
|------|------|
| `dictionary.md` | 数据字典：Agent 会引用的业务数据字段定义 |
| `samples.md` | 脱敏样本数据：few-shot/评估用 |
| `smes-621/` | 通用 SMES 数据字典（sMES_Production_61100，189表）解析库，见下方说明 |
| `smes-621-sql/` | 鼎捷 sMES 通用查询 SQL 资产库，见下方说明 |
| `u9-sql/` | **U9 ERP（用友）接口查询 SQL 资产库**（MES←U9 发料取数），见下方说明 |
| `iiot/` | **鼎华智能 IIoT 数采平台资产库**（重庆数采系统，独立于 sMES；时序数据在 InfluxDB 8086），见下方说明 |

## smes-621 数据字典（通用）

> `smes-621/` 是从客户数据字典《SMES_621数据库设计文档20250313.html》解析的**通用 MES 数据字典**（数据库 sMES_Production_61100，189 表 / 12,866 字段）。原件存 `delivery/inbox/`。

- 入口: `smes-621/README.md`（模块地图）
- 8 个模块文件: `01-wip-workorder.md` … `08-andon-system-erp.md`（字段级全量）
- 领域提炼: `smes-621/knowledge-cards.md`（K-621 系列）
- 引用方式: 回答字段/表结构问题时可查 `[smes-621]`

## smes-621-sql 通用查询 SQL 资产库

> `smes-621-sql/` 是鼎捷 sMES 数据库（`sMES_Production_61100`）内的**通用查询 SQL**，与 smes-621 数据字典配套。
> **体系边界**：本目录 SQL 均为**鼎捷 sMES** 查询，与**老 MES（玖坤）无关**（玖坤仅涉及设备点检表导出专项，见 task T-970e6a2c96）。

- 入口: `smes-621-sql/README.md`（查询清单 17 个）+ `file_index.md`
- 引用方式: 回答查询类问题时查 `[smes-621-sql]`

## u9-sql U9 ERP 接口查询 SQL 资产库

> `u9-sql/` 是 **U9 ERP（用友）** 接口查询 SQL，MES 从 U9 取发料/领料数据的接口契约，与 sMES 数据库查询分开放。

- 入口: `u9-sql/README.md`（业务背景 + 表结构）+ `file_index.md`
- 关键表: `ESB_IssueWoItem_Queue`（发料队列）`MO_MOPickList`（领料清单）`MO_MO`（工单）`CBO_ItemMaster`（物料）`Base_UOM`（单位），跨库关联 MES `TBLOEMOBASIS`
- 引用方式: 回答 U9 接口/发料同步类问题时查 `[u9-sql]`

## iiot 鼎华智能 IIoT 数采平台资产库

> `iiot/` 是**重庆数采平台**（鼎华智能 IIoT v2.2.6.0）的资产库。数采实时数据在 **InfluxDB(8086)** 时序库，**不落 sMES**；MES 与数采当前各自为政（2026-08-14 探查）。
> 体系边界：IIOT ≠ sMES ≠ LIMS ≠ U9，四套独立系统互不混入。

- 入口: `iiot/README.md`（服务器拓扑/端口/凭据现状/待打通点）
- 引用方式: 回答数采/采集数据类问题时查 `[iiot]`

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
