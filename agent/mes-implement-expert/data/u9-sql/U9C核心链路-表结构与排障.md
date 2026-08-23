# U9C 核心链路 · 表结构与断连排障手册

> **系统**：华纬 U9C ERP（用友）｜ **连接**：`192.168.200.16/HWAWAYU9CDB`（`--profile u9c`，凭据仅 db.local.json）
> **定位**：断连对冲资产 —— **表结构 + 结果逻辑已固化，数据库连不上也能判断链路、定位排查环节**。实时数据（队列明细等）断连拿不到，但链路/状态机/字段语义在此。
> **实测日期**：2026-08-21 首连实测（7554 表全 dbo）；核心表均为**超宽表**（MO_MO 330 列/MO_MOPickList 220 列/CBO_ItemMaster 200+/PM_Receivement 250 列），本文只沉淀**关键字段**，全宽标注备查。

---

## 〇、U9C 表命名与弹性字段约定（先读）

- 全库 **7554 张表，全在 dbo**（无 schema 分层）；用友 U9C 业务表命名：`模块缩写_业务对象`（PM=采购/收货、MO=制造订单/领料、CBO=公共主数据、ESB=接口队列、Base=基础）
- **弹性字段惯例**：表尾大量 `DescFlexField_PubDescSegN`（公共弹性段）/`NameSegmentN`（名称分段）列，**非业务字段**，各客户可能配置用途，引用时按实际数据判，不猜
- **多语言表**：`XXX_Trl` 为多语言翻译表，业务主表在无后缀表
- 所有单据头表通用列：`ID(bigint 主键)/Org(组织)/DocNo(单号)/BusinessDate/Version/CreatedOn/CreatedBy/ModifiedOn/ModifiedBy` + `Cancel_*/Hold*/Release*`（作废/挂起/释放）+ `WF*`（工作流状态）

---

## 一、核心链路总览（断连先看这张图）

```
┌───────────────────────── U9C 侧 ─────────────────────────┐   ┌──────────── sMES 侧 ────────────┐
│                                                          │   │                                  │
│ ①IQC到货单链路：                                          │   │                                  │
│   PM_Receivement(收货单头,250列)                            │   │  MES QMS 拉取队列 → 检验判定 →   │
│        │ source_receivement_id                            │   │  结果回传(T-f768f52017)           │
│        ▼                                                  │   │                                  │
│   esb_iqc_receipt_outbox(同步队列,29列) ──────────────────────→  QMS IQC 待检单                  │
│                                                          │   │                                  │
│ ②发料链路：                                               │   │                                  │
│   MO_MO(工单,330列) → MO_MOPickList(领料单,220列,标准用量)   │   │  MES 扫码上料校验                 │
│        │  wo_no/item_no/qty                               │   │  (今日发料查询)                   │
│        ▼                                                  │   │                                  │
│   ESB_IssueWoItem_Queue(发料队列,40列) ──────────────────────→  MES 发料数据消费                  │
│                                                          │   │                                  │
│ ③主数据：CBO_ItemMaster(物料,200+列) · Base_UOM(单位,100列)    │                                  │
└──────────────────────────────────────────────────────────┘   └──────────────────────────────────┘
```

## 二、IQC 到货单链路（IQC 对接核心，T-f768f52017）

### 链路环节与排障点

| 环节 | 关键表/字段 | 数据怎么走 | 断连排查点（可能卡在哪） |
|------|------------|-----------|------------------------|
| ① U9C 收货单产生 | `PM_Receivement`（头） | 采购到货在 U9C 做收货 → 生成收货单 | 收货单是否存在？DocNo/Supplier_Code/Status 正常？ |
| ② 同步入队 | `esb_iqc_receipt_outbox` | 接口把收货单头/行同步到 outbox 队列 | **主查**：队列有无该单？`sync_status`=0(待同步)？`retry_count`/`last_error` 是否报错 |
| ③ MES 拉取消费 | 队列 claim 字段 | MES 侧消费脚本拉取，加租约防重复 | `claim_token`/`claimed_time` 是否有值（被谁锁住）？`processed_time` 为空=没消费完 |
| ④ QMS 检验判定 | sMES QMS 侧 | 用户执行检验，写 qc_conclusion | QMS 待检单有没有生成？检验结论是否回写？ |
| ⑤ 结果回传 | 队列/回传表 | 检验结果写回 U9C（接口） | 回传链路（未实测，待 MES 侧确认） |

### 核心表结构

**`esb_iqc_receipt_outbox`（29 列，已实测全列）** —— 详见 [U9C数据库字典-基础.md](U9C数据库字典-基础.md)；取数模板 [U9C_IQC到货单查询-SQL.sql](U9C_IQC到货单查询-SQL.sql)
- 单据：`receipt_no`/`receipt_line_no`/`item_code`/`item_name`/`item_specs`/`arrived_qty`/`uom_code`
- 检验：`qc_conclusion`（实测值"待检"）/`furnace_no`(炉号)/`batch_no`(批号)
- 状态机：`sync_status`(0=待同步)/`retry_count`/`next_retry_time`/`claim_token`/`claimed_time`/`last_error`/`processed_time`
- 关联：`source_receivement_id`/`source_line_id` → 指向 U9C 源收货单（测试单为 `-202608210001` 负数模拟值，**正式关联待验证**）

**`PM_Receivement`（250 列超宽，业务列 111+）** —— U9C 采购收货单**头**表（关键字段实测）
| 字段 | 类型 | 语义 |
|------|------|------|
| ID / Org / DocNo / BusinessDate | bigint/bigint/nvarchar50/datetime | 主键 / 组织 / 收货单号 / 业务日期 |
| Supplier_Supplier / Supplier_Code / Supplier_ShortName | bigint / nvarchar255 | 供应商 |
| Payer_Code / PayerSite_Code | nvarchar255 | 付款方 / 付款方地点 |
| SrcDocType / RcvDocType / BizType | int | 源单据类型 / 收货类型 / 业务类型 |
| Status | int | 单据状态（取值未实测，断连后按单据状态语义推断） |
| TotalMnyAC / TotalTaxAC / TotalNetMnyAC | decimal | 金额/税额/净额（本位币 AC） |
| RcvBy | bigint | 收货人 |
| ApprovedBy / ApprovedOn / WFCurrentState | nvarchar50/datetime/int | 审批人 / 审批时间 / 工作流状态 |
| IsDisused | bit | 是否停用 |

> ⚠️ `PM_Receivement` 未发现行表（`PM_ReceivementLine` 不存在），行级明细可能已由接口直接展开到 outbox；**行明细取数链路待 MES 对接方确认**。

## 三、发料链路（扫码上料校验）

### 链路环节与排障点

| 环节 | 关键表 | 数据怎么走 | 断连排查点 |
|------|--------|-----------|----------|
| ① 工单建立 | `MO_MO` | 生产工单（330 列） | 工单 DocNo/ItemMaster/ProductQty/DocState 正常？ |
| ② 领料单标准用量 | `MO_MOPickList` | 领料明细（220 列），算 std_qty | 工单领料明细在？BOMReqQty/IssuedQty 口径 |
| ③ 发料同步入队 | `ESB_IssueWoItem_Queue` | 发料数据进队列（40 列） | **主查**：队列有无该单？sync_status=0？last_error |
| ④ MES 消费校验 | sMES 侧 | MES 拉取发料，扫码上料校验 | MES 侧报工/上料界面有无发料数据 |

### 核心表结构

**`ESB_IssueWoItem_Queue`（40 列，2026-08-23 全列复核，全列已实测）** —— 发料队列（[U9_ERP发料查询-SQL.sql](U9_ERP发料查询-SQL.sql) 实际用到其中 32 列）
| 字段 | 类型 | 语义 |
|------|------|------|
| id / source_biz_key | bigint / nvarchar200 | 主键 / 源业务键 |
| source_cvouchtype | nvarchar50 | 源单据类别 |
| doc_type_no / doc_no / seq | nvarchar20/50 / int | 源单据类型 / 单据号 / 行序 |
| create_date | datetime | 创建日期（SQL 取数用；与 create_time 两列并存，语义区分待正式数据确认） |
| biz_status | tinyint | 业务状态 |
| header_remark | nvarchar500 | 单头备注 |
| applicant_no | nvarchar50 | 申请人 |
| workstation_no | nvarchar50 | 工作站 |
| barcode | nvarchar50 | 物料条码（⚠️ 队列有 barcode 列，但 [T-c038ddec12](任务池) 已定论：领料表/发料队列实际无可用条码数据支撑扫码校验，**不要据此翻案**） |
| wo_no / item_no | nvarchar50 | 工单号 / 物料编码 |
| item_feature_no / replaced_item_feature_no | nvarchar60 | 物料特征 / 替代料特征 |
| qpa_molecular / qpa_denominator | decimal | 分子/分母（QPA） |
| std_qty / qty | decimal | 标准用量 / 数量 |
| unit_no | nvarchar20 | 单位码（U9C 单位 → sMES 映射：公斤→W013、公斤(5位)→W016） |
| item_type | tinyint | 物料类型 |
| input_datetime | datetime | 输入/入队时间 |
| warehouse_no / location_no / lot_no | nvarchar50 | 仓库 / 库位 / 批次 |
| expiry_date | datetime | 到期日 |
| detail_remark | nvarchar500 | 行明细备注 |
| positive_negative | decimal | 正负量（替代/冲销等） |
| replaced_item_no / replaced_qty | nvarchar50/decimal | 替代料编码 / 替代数量 |
| replaced_type / issue_to_type / sub_type | tinyint | 替代类型 / 发料去向类型 / 子类型 |
| op_no | nvarchar50 | 工序号 |
| **sync_status** | tinyint | **同步状态（0=待同步，MES 未消费）** |
| sync_msg / sync_time | nvarchar500/datetime | 同步信息 / 同步时间 |
| create_time | datetime | 创建时间（与 create_date 并存，勿混用） |
| doc_no_trim | nvarchar50 | 去空格单据号（MES 侧 MONO 匹配用） |

**`MO_MO`（330 列超宽，关键列）** —— 生产工单主档
| 字段 | 语义 |
|------|------|
| ID / DocNo / BusinessDate | 主键 / 工单号 / 业务日期 |
| ItemMaster / ItemVersion | 物料主数据 / 物料版本 |
| ProductUOM / ProductQty / MRPQty | 产品单位 / 生产数量 / MRP 数量 |
| DocState | 单据状态（编号 106 列，取值待实测） |
| TotalCompleteQty / TotalRcvQty / TotalScrapQty | 累计完工 / 累计收货 / 累计报废 |
| StartDate / CompleteDate / ActualStartDate / ActualCompleteDate | 计划/实际 开工/完工 |
| ParentMO / ParentMODocNo / ParentMOVer | 父工单 |
| ProductLotNo / ProductLotMaster | 产品批次 |

**`MO_MOPickList`（220 列超宽，关键列）** —— 工单领料清单
| 字段 | 语义 |
|------|------|
| ID / MO / DocLineNO | 主键 / 所属工单 / 行号 |
| ItemMaster / SubstitutedItem | 物料 / 替代料 |
| BOMReqQty / STDReqQty | BOM 需求数量 / 标准需求数量 |
| ActualReqQty / IssuedQty / IssueNotDeliverQty | 实际需求 / 已发数量 / 未发数量 |
| ReserveQty / ReserveExeQty | 预留量 / 预留执行量 |
| IssueUOM / RcvUOM / IssueBaseUOM | 发放/接收/基础 单位 |
| PlanReqDate / ActualReqDate / ActualIssueDate | 计划需求/实际需求/实际发放 日期 |

## 四、主数据（物料 / 单位）

| 表 | 列数 | 关键字段（实测） | 用途 |
|----|:---:|----------------|------|
| `CBO_ItemMaster` | 200+ | `Code`(156)/`Name`(157)/`SearchCode`/`ItemFormAttribute`/`Org`/`MasterOrg`/`InventoryUOM`/`PurchaseUOM`/`SalesUOM`/`ManufactureUOM`/`ItemSource` + NameSegmentN 弹性段 | 物料主数据（item_no ↔ Code 匹配） |
| `Base_UOM` | 100 | `Code`/`ShortName`/`UOMClass`/`IsBase`/`RatioToBase`/`BaseUOM`/`Effective_IsEffective` + DescFlexField 弹性段 | 单位主数据（unit_no ↔ Code 匹配） |

> 单位映射口径（已实测逻辑）：U9C 单位码 `公斤`→sMES `W013`、`公斤(5位)`→`W016`（见 [U9_ERP发料查询-SQL.sql](U9_ERP发料查询-SQL.sql)）。

## 五、通用排障套路（断连也能用）

1. **先判链路段**：问题在 U9C 源头（收货/发料/工单没产生）→ 队列（没同步/卡状态/报错）→ MES 消费（没拉/没处理）→ MES 展示（没显示）？按上面的环节表逐段排除
2. **队列是核心枢纽**：`esb_iqc_receipt_outbox` / `ESB_IssueWoItem_Queue` 的 `sync_status` + `last_error` + `retry_count` 三字段定位同步问题；`claim_token` 有值=被 MES 锁住，查消费端
3. **字段匹配口径**：工单/物料/单位匹配先确认两系统编码一致（U9C `item_no` ↔ sMES 物料、`unit_no` 单位映射、`doc_no_trim` 去空格），口径错最常见
4. **断连期**：查询模板参数化命令 + 本手册链路，可离线推演问题环节；实时确认需 DBA 提供当时队列快照

## 关联资产

- IQC 取数模板：[U9C_IQC到货单查询-SQL.sql](U9C_IQC到货单查询-SQL.sql)（4 视角）｜ 发料取数：[U9_ERP发料查询-SQL.sql](U9_ERP发料查询-SQL.sql)
- 库概况/已实测表：[U9C数据库字典-基础.md](U9C数据库字典-基础.md)｜ 连接方式：`config/db.local.json` → `--profile u9c`
- 待验证项：sync_status 完整取值、PM_Receivement 行表、IQC 结果回传链路、source_receivement_id 正式关联
