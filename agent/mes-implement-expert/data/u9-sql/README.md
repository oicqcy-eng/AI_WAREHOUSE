# U9 ERP（用友）接口查询 SQL 资产库

> 华纬 **U9 ERP**（用友）相关接口查询 —— MES 从 U9 取数（发料/领料/IQC到货单）的接口契约，与 `data/smes-621-sql/`（鼎捷 sMES 数据库内查询）是**两套不同体系**。
> 来源: `delivery/inbox/SQL/U9_ERP发料查询SQL.docx`（2026-07-06 归档）+ **2026-08-21 U9C 首次连库实测**。原件保留在本地 `raw/` 原件区供追溯。

## 说明

- 本目录沉淀 **U9 ERP 侧**的查询 SQL（U9 库表 + MES 侧跨库关联）
- ✅ **连通状态（2026-08-21 启用）**：U9C ERP 库已可直连 —— **192.168.200.16/HWAWAYU9CDB**（SQL Server 2019，7554 表全 dbo），账号 `u9_readonly_user` 仅只读。运行方式：`node query-mes.js <file.sql> --profile u9c`（profile 见 `config/db.local.json`，凭据不入库；与 sMES 共库 `home`/重庆 `cq` 平级）
- U9 关键库表：`esb_iqc_receipt_outbox`（**IQC 到货单同步队列**）、`ESB_IssueWoItem_Queue`（发料队列表）、`MO_MO`（工单）、`MO_MOPickList`（工单领料清单）、`CBO_ItemMaster`（物料主数据）、`Base_UOM`（单位）
- 关联 MES 侧库表：`[MES].[sMES_Home_Prod].[dbo].[TBLOEMOBASIS]`（OEM 工单基础表）
- 每个 SQL 文件为独立查询，可直接复制执行；字段说明见文件内注释
- 与 sMES 数据库（`sMES_Production_61100`）的查询分开存放，避免混用
- **表结构按需验证，不全量沉淀**（7554 表）；字典见 [U9C数据库字典-基础.md](U9C数据库字典-基础.md)

## 查询清单

| 文件 | 查询内容 | 涉及核心表 |
|------|---------|-----------|
| [U9_ERP发料查询-SQL.sql](U9_ERP发料查询-SQL.sql) | U9 发料数据取数（取 1 条待同步发料记录，关联领料单标准用量，校验工单已在 MES） | ESB_IssueWoItem_Queue, MO_MO, MO_MOPickList, CBO_ItemMaster, Base_UOM, MES.TBLOEMOBASIS |
| [U9C_IQC到货单查询-SQL.sql](U9C_IQC到货单查询-SQL.sql) | **IQC 到货单取数（4 视角）**：①待同步清单(sync_status=0) ②按单/物料全状态 ③状态分布 ④失败重试；`--profile u9c -p receipt_no= -p item_code=` | esb_iqc_receipt_outbox |
| [U9C数据库字典-基础.md](U9C数据库字典-基础.md) | U9C 库概况 + 已实测表结构（esb_iqc_receipt_outbox 29 列详解 + 测试数据） | — |
| [U9C核心链路-表结构与排障.md](U9C核心链路-表结构与排障.md) | **断连对冲手册**：U9C 核心链路（IQC到货单/发料/工单/物料/单位）+ 每表关键字段（超宽表提炼）+ 环节拆分 + 断连排障点 | PM_Receivement, esb_iqc_receipt_outbox, MO_MO, MO_MOPickList, ESB_IssueWoItem_Queue, CBO_ItemMaster, Base_UOM |

## 业务背景（为什么有这份 SQL）

- **用途**：MES 从 U9 拉取工单发料数据，供工单扫码上料校验等环节消费。查询只取 `sync_status = 0`（待同步）记录，且要求工单已在 MES 建立（`exists TBLOEMOBASIS`），保证推入 MES 的发料数据可对上工单。
- **单位映射**：U9 单位码 → sMES 单位码（公斤 → W013、公斤(5位) → W016），是两系统单位体系换算规则，改单位口径时需同步维护此映射。
- **关联问题**：重庆调拨条码 P1（task T-c038ddec12）——MES 扫码上料校验需要物料**条码**，但 U9 领料表（`MO_MOPickList`）与发料队列（`ESB_IssueWoItem_Queue`）**均无物料条码字段**，2026-07-06 评估「U9 增字段/提供其他接口」方案不可行，正是基于这份 SQL 对应的数据链路得出的结论。

## 使用

- 查 U9 接口取数/发料同步 → 本目录对应文件
- 查 sMES 数据库内通用查询 → `../smes-621-sql/`
- 引用方式: 回答 U9 接口类问题时查 `[u9-sql]`
