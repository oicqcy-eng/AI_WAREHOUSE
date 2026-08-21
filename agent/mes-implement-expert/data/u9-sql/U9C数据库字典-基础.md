# U9C 数据库字典（基础）

> **系统**：华纬 U9C ERP（用友）｜ **服务器**：192.168.200.16:1433（SQL Server 2019, 15.0.2000.5）｜ **库**：`HWAWAYU9CDB` ｜ **账号**：`u9_readonly_user`（只读）
> **连接**：`node agent/mes-implement-expert/tools/query-mes.js agent/mes-implement-expert/data/u9-sql/<file.sql> --profile u9c`（profile 见 `config/db.local.json`，凭据不入库；相对路径基于 cwd=仓库根）
> **首连**：2026-08-21（用户提供连接信息）
> **体系定位**：U9C 与 sMES 平级独立系统，资产归 `data/u9-sql/`，**不混入** smes-621 资产（见 CLAUDE.md 服务器拓扑）

## 一、库概况

| 项 | 值 | 说明 |
|----|----|----|
| 版本 | SQL Server 2019 | 15.0.2000.5 |
| 库名 | HWAWAYU9CDB | 用友 U9C 业务库 |
| 表总数 | 7554 | 全部 dbo schema（2026-08-21 实测） |
| 账号权限 | 只读（SELECT） | query-mes.js 强制 SELECT-only，不改队列状态 |

> ⚠️ 7554 张表为用友 U9C 全量业务表，**不全量沉淀**；按连库沉淀策略「表结构按需验证」，用到哪个模块查哪个。本字典只记录已实测/已用的表。

## 二、已实测关键表

### 2.1 `esb_iqc_receipt_outbox` — IQC 到货单同步队列（IQC 对接核心）

> **用途**：U9C→MES 的 IQC 来料检待检数据**出站队列**（ESB 中台 outbox 模式，与发料队列 `ESB_IssueWoItem_Queue` 同构）。MES 从本表拉取待检到货单，用户只执行检验判定、不人工触发取数。
> **关联**：IQC 对接 U9 任务 T-f768f52017；模拟前置 T-ea50fe8918

| 列名 | 类型 | 语义 |
|------|------|------|
| id | bigint | 主键 |
| source_receivement_id / source_line_id | bigint | 源到货单头/行 ID |
| receipt_no | nvarchar(100) | 到货单号 |
| receipt_line_no | int | 到货单行号 |
| item_code / item_name / item_specs | nvarchar | 物料编码/名称/规格 |
| arrived_qty | decimal | 到货数量 |
| uom_code | nvarchar(50) | 单位码 |
| qc_conclusion | nvarchar(100) | 检验结论（实测值：`待检`；预期 合格/不良/让步 等） |
| furnace_no / batch_no | nvarchar(100) | 炉号 / 批号 |
| reserved_field1~5 | nvarchar(500) | 预留扩展字段 |
| sync_status | int | 同步状态（ESB 队列约定 0=待同步；其余取值待正式数据确认） |
| sync_response_log | nvarchar(max) | 同步响应日志 |
| retry_count / next_retry_time | int / datetime2 | 失败重试次数 / 下次重试时间 |
| claim_token / claimed_time | uniqueidentifier / datetime2 | 消费租约（MES 拉取时锁定，防并发重复取） |
| last_error | nvarchar(2000) | 最近一次错误（排查同步中断主查） |
| source_created_time | datetime2 | 源单建立时间（⚠️ 实测测试数据为 null，待正式数据验证） |
| created_time / modified_time / processed_time | datetime2 | 入队 / 修改 / 处理完成时间 |

**数据现状**（2026-08-21）：仅 1 条测试单 `TEST-IQC-20260821-001`（物料 21106-001171，到货 1，qc_conclusion=待检，source_created_time=null）——与 8-21 郑少青/姜皓翔上午给出 IQC 测试数据吻合。

**取数模板**：[U9C_IQC到货单查询-SQL.sql](U9C_IQC到货单查询-SQL.sql)（4 视角：①待同步清单 ②按单/物料全状态 ③状态分布 ④失败重试）

### 2.2 `ESB_IssueWoItem_Queue` — 发料同步队列（既有资产，发料取数）

> 见 [U9_ERP发料查询-SQL.sql](U9_ERP发料查询-SQL.sql)。关键字段：doc_no/wo_no/item_no/qty/std_qty/unit_no/sync_status。关联问题 T-c038ddec12（调拨条码无物料条码字段）。

### 2.3 `esb_mes_wo_create` — MES 工单创建同步状态表（2026-08-21 补录）

> **用途**：U9C → MES 的**工单创建/同步状态表**（wo_no 维度，ESB outbox 模式），记录 U9 工单下发 MES 的 create/update/status 各阶段回执。发料链路的上游工单入口，与 `ESB_IssueWoItem_Queue`（发料）同属 ESB 接口层。实测 11 列，全列沉淀。

| 列名 | 类型 | 语义 |
|------|------|------|
| ID | nvarchar(255) | 主键 |
| wo_no | nvarchar(255) | 工单号（非空） |
| wo_state | nvarchar(255) | 工单状态 |
| modifytime / esbmodifytime | datetime | 修改时间 / ESB 修改时间 |
| create_code / create_message | nvarchar(255) | 创建回执：码 / 信息 |
| update_code / update_message | nvarchar(255) | 更新回执：码 / 信息 |
| status_code / status_message | nvarchar(255) | 状态回执：码 / 信息 |

> ⚠️ 状态码取值（create/update/status_code）未实测，需对照 MES 消费逻辑或更多正式数据确认；取值语义断连时按"回执码+回执信息"配对推断。

### 2.4 其他 U9C 模块表（核心链路已实测，其余按需验证）

- 已实测（详见 [U9C核心链路-表结构与排障.md](U9C核心链路-表结构与排障.md)）：`MO_MO`(330列)/`MO_MOPickList`(220列)/`PM_Receivement`(250列)/`CBO_ItemMaster`(200+)/`Base_UOM`(100列)——关键字段已提炼
- 其余 7549 张标准用友产品表：**不全量沉淀**，查 [U9C全量表清单.md](U9C全量表清单.md)（7554 表地图）→ 按需 `INFORMATION_SCHEMA` 验证

## 三、使用注意

- **时区**：datetime2 时间字段的存储口径（本地/UTC）待正式数据验证；sMES 库实测为北京时间，U9C 需独立确认
- **只读铁律**：本队列的 `sync_status` 等状态字段由 MES 侧消费时更新，**AI 连库只取数核对，绝不 UPDATE**
- **状态机语义**：`sync_status`/`claim_token` 的完整取值需对照 MES 消费逻辑（姜皓翔侧）或更多正式数据实证后再定版，当前注释为约定推测
- 需要新模块取数时：按「用到即验证」流程——`INFORMATION_SCHEMA` 验证表/字段 → 跑通 → 沉淀参数化模板到本目录
