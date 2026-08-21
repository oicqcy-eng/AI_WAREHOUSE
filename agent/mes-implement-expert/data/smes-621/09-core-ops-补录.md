# smes-621 核心业务表补录（字典缺失 68 表）

> **定位**：2026-08-21 连库实测发现 —— 189 表主字典（源自设计文档 20250313）**未覆盖**本目录 22 个 SQL 查询模板实际使用的 **68 张核心业务表**（报工/权限/生产批/点检/发料/工单/设备/工序等）。本文件为**连库实测补录**（`INFORMATION_SCHEMA.COLUMNS` 导出，1727 列），字段说明以语义备注为主，无设计文档中文注释。
> **衔接**：与 [sMES核心链路-表结构与排障.md](../smes-621-sql/sMES核心链路-表结构与排障.md) 五链路配套；全量 1472 表清单与差异分析见 [sMES全量表清单.md](../smes-621-sql/sMES全量表清单.md)。

本模块 68 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [TBLEMSACCESSORYSTATE](#tblemsaccessorystate) | 模治具状态 | 24 |
| [TBLEMSACCESSORYSTATELOG](#tblemsaccessorystatelog) | 模治具状态历程 | 23 |
| [TBLEMSCOMBINEACCSTATE](#tblemscombineaccstate) | 模治具组合状态 | 11 |
| [TBLEMSEQPACCSTATE](#tblemseqpaccstate) | 设备模治具状态 | 10 |
| [TBLEMSEQUIPMENTSTATE](#tblemsequipmentstate) | 设备状态 | 16 |
| [TBLEMSEQUIPMENTSTATELOG](#tblemsequipmentstatelog) | 设备状态历程 | 25 |
| [TBLENTCUSTOMERBASIS](#tblentcustomerbasis) | 客户主档 | 38 |
| [TBLENTSUBCONTRACTOR](#tblentsubcontractor) | 外包商主档 | 13 |
| [TBLEQPACCESSORYBASIS](#tbleqpaccessorybasis) | 模治具主档 | 23 |
| [TBLEQPACCESSORYCATEGORY](#tbleqpaccessorycategory) | 模治具类别 | 12 |
| [TBLEQPACCESSORYTYPE](#tbleqpaccessorytype) | 模治具类型 | 12 |
| [TBLEQPACCSTATEBASIS](#tbleqpaccstatebasis) | 模治具状态主档 | 11 |
| [TBLEQPEQUIPMENTBASIS](#tbleqpequipmentbasis) | 设备主档 | 71 |
| [TBLEQPGROUPDETAIL](#tbleqpgroupdetail) |  | 9 |
| [TBLINVFGDINBASIS](#tblinvfgdinbasis) | 成品入库单 | 16 |
| [TBLINVFGDINDETAIL](#tblinvfgdindetail) | 成品入库明细 | 16 |
| [TBLMTLMATERIALBASIS](#tblmtlmaterialbasis) | 物料主档 | 59 |
| [TBLOEMOBASIS](#tbloemobasis) | 工单MO主档 | 81 |
| [TBLOEMOMATERIALINBASIS_ERP](#tbloemomaterialinbasis_erp) | 工单材料领入(ERP)【⚠️发料核对勿用此表,会误导】 | 17 |
| [TBLOEMOMATERIALLIST](#tbloemomateriallist) | 工单材料清单(发料核对主表) | 72 |
| [TBLOEROBASIS](#tbloerobasis) | 订单RO主档 | 12 |
| [TBLOERODETAIL](#tbloerodetail) | 订单RO明细 | 28 |
| [TBLOPBASIS](#tblopbasis) | 工序作业站主档 | 64 |
| [TBLPRDPRODUCTBASIS](#tblprdproductbasis) | 产品主档 | 75 |
| [TBLPRDPRODUCTPROCESS](#tblprdproductprocess) | 产品制程流程 | 23 |
| [TBLPRDSUBOPBASIS](#tblprdsubopbasis) | 产品子作业 | 21 |
| [TBLPRSNODEBASIS](#tblprsnodebasis) |  | 20 |
| [TBLQCREASONBASIS](#tblqcreasonbasis) | 不良原因主档 | 15 |
| [TBLSMDAREABASIS](#tblsmdareabasis) | SMT区域主档 | 20 |
| [TBLSMDAREARELATION](#tblsmdarearelation) | SMT区域关系 | 23 |
| [TBLSYSFUNCTION](#tblsysfunction) | 系统功能(菜单) | 19 |
| [TBLUSRDEPARTMENTBASIS](#tblusrdepartmentbasis) | 部门主档 | 12 |
| [TBLUSRGROUPBASIS](#tblusrgroupbasis) | 作业群组主档 | 10 |
| [TBLUSRGROUPPRIV](#tblusrgrouppriv) | 群组权限(PRIVTYPE: 9菜单/0平台/8按钮) | 13 |
| [TBLUSRGROUPPRIVCONTROL](#tblusrgroupprivcontrol) | 群组控件禁用 | 3 |
| [TBLUSRSHIFTBASIS](#tblusrshiftbasis) | 班别主档 | 14 |
| [TBLUSRUSERBASIS](#tblusruserbasis) | 用户主档 | 27 |
| [TBLUSRUSERGROUP](#tblusrusergroup) | 用户-群组关联 | 15 |
| [TBLWIPCONT_ACCESSORY](#tblwipcont_accessory) | 报工-模治具耗用 | 14 |
| [TBLWIPCONT_EQUIPMENT](#tblwipcont_equipment) | 报工-设备报工组【报工主表】 | 21 |
| [TBLWIPCONT_ERROR](#tblwipcont_error) | 报工-不良记录 | 19 |
| [TBLWIPCONT_MATERIAL](#tblwipcont_material) | 报工-物料耗用【进站消耗主表】 | 19 |
| [TBLWIPCONT_MATERIALLOT](#tblwipcont_materiallot) | 报工-物料批次耗用 | 15 |
| [TBLWIPCONT_PARTIALIN](#tblwipcont_partialin) | 进站记录 | 21 |
| [TBLWIPCONT_PARTIALIN_PCSNO](#tblwipcont_partialin_pcsno) | 进站记录-PCS序号 | 12 |
| [TBLWIPCONT_PARTIALOUT](#tblwipcont_partialout) | 出站记录 | 28 |
| [TBLWIPCONT_PARTIALOUT_PCSNO](#tblwipcont_partialout_pcsno) | 出站记录-PCS序号 | 13 |
| [TBLWIPCONT_RESOURCE](#tblwipcont_resource) | 报工-人员资源【工时主表】 | 21 |
| [TBLWIPDISPATCHSTATE](#tblwipdispatchstate) | 派工状态 | 27 |
| [TBLWIPEQPMATERIALSTATE](#tblwipeqpmaterialstate) | 设备上料状态【扫码上料主表】 | 17 |
| [TBLWIPEQPQCLISTDETAIL](#tblwipeqpqclistdetail) | 设备点检项目明细 | 27 |
| [TBLWIPEQPQCLISTLOG](#tblwipeqpqclistlog) | 设备点检执行记录 | 17 |
| [TBLWIPERFBASIS](#tblwiperfbasis) | 工程变更(ECR)主档 | 39 |
| [TBLWIPFIRSTCHECK](#tblwipfirstcheck) | 首件检验 | 22 |
| [TBLWIPLOTBASIS](#tblwiplotbasis) | 生产批主档 | 45 |
| [TBLWIPLotEQPChangeLog](#tblwiploteqpchangelog) |  | 23 |
| [TBLWIPLOTLOG_REPORT](#tblwiplotlog_report) | 生产批日志【报工/历程主表】 | 45 |
| [TBLWIPLOTSTATE](#tblwiplotstate) | 生产批状态 | 58 |
| [TBLWIPMERGECONTENT](#tblwipmergecontent) | 并批内容 | 28 |
| [TBLWIPOPERATORLOG](#tblwipoperatorlog) | 人员上下工时日志 | 27 |
| [TBLWIPOPERATORSTATE](#tblwipoperatorstate) | 人员作业现况 | 14 |
| [TBLWIPOSBASIS](#tblwiposbasis) | 工序段主档 | 31 |
| [TBLWIPOSDETAIL](#tblwiposdetail) | 工序段明细 | 32 |
| [TBLWIPREWORKREASON](#tblwipreworkreason) | 返工原因 | 14 |
| [TBLWIPSPLITCONTENT](#tblwipsplitcontent) | 分批内容 | 28 |
| [TBLWIPSUBOPLOG_REPORT](#tblwipsuboplog_report) | 子作业报工日志 | 17 |
| [TBLWIPWAITBASIS](#tblwipwaitbasis) | 等待/暂停主档 | 41 |
| [TBLWIPWAITLOTDISPOSITION](#tblwipwaitlotdisposition) | 等待批处置 | 19 |

## TBLEMSACCESSORYSTATE — 模治具状态

> 字段数：24 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCSERIALNO | nvarchar(20) | 是 |
| 2 | ACCESSORYNO | nvarchar(50) | 否 |
| 3 | ACCESSORYVERSION | nvarchar(5) | 否 |
| 4 | ACCESSORYSTATE | numeric | 否 |
| 5 | ACCESSORYTYPE | nvarchar(50) | 是 |
| 6 | STARTTIME | datetime | 否 |
| 7 | USERNO | nvarchar(30) | 是 |
| 8 | DESCRIPTION | nvarchar(4000) | 是 |
| 9 | APPLYTIME | datetime | 是 |
| 10 | ACCUMULATEQTY | numeric | 是 |
| 11 | ACCSPAREQTY | numeric | 是 |
| 12 | ACCTOTALUSEDQTY | numeric | 是 |
| 13 | ACCREPAIRQTY | numeric | 是 |
| 14 | LocatorNo | nvarchar(20) | 是 |
| 15 | ExpectRepairFinishDate | datetime | 是 |
| 16 | PlanRepairFinishDate | datetime | 是 |
| 17 | PlanRepairer | nvarchar(30) | 是 |
| 18 | SubcontractorNo | nvarchar(20) | 是 |
| 19 | ACLoadTime | numeric | 是 |
| 20 | ACUnLoadTime | numeric | 是 |
| 21 | TempLocatorNo | nvarchar(20) | 是 |
| 22 | Creator | nvarchar(50) | 是 |
| 23 | CreateDate | datetime | 是 |
| 24 | GUID | nvarchar(50) | 是 |

## TBLEMSACCESSORYSTATELOG — 模治具状态历程

> 字段数：23 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCSERIALNO | nvarchar(20) | 否 |
| 2 | ACCESSORYNO | nvarchar(50) | 是 |
| 3 | ACCESSORYVERSION | nvarchar(5) | 是 |
| 4 | ACCESSORYSTATE | numeric | 否 |
| 5 | ACCESSORYTYPE | nvarchar(50) | 是 |
| 6 | STARTTIME | datetime | 否 |
| 7 | ENDTIME | datetime | 否 |
| 8 | USERNO | nvarchar(30) | 是 |
| 9 | DESCRIPTION | nvarchar(4000) | 是 |
| 10 | APPLYTIME | datetime | 是 |
| 11 | ACCUMULATEQTY | numeric | 是 |
| 12 | LocatorNo | nvarchar(20) | 是 |
| 13 | AddLifeType | numeric | 是 |
| 14 | AddLife | numeric | 是 |
| 15 | RealAddLife | numeric | 是 |
| 16 | CHANGETTOOLTIME | numeric | 是 |
| 17 | EDITDATE | datetime | 是 |
| 18 | CHANGETOOLTIME | numeric | 是 |
| 19 | Creator | nvarchar(50) | 是 |
| 20 | CreateDate | datetime | 是 |
| 21 | EDITOR | nvarchar(50) | 是 |
| 22 | GUID | nvarchar(50) | 是 |
| 23 | ORIGINGUID | nvarchar(50) | 是 |

## TBLEMSCOMBINEACCSTATE — 模治具组合状态

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | COMBINEACCCATEGORY | nvarchar(50) | 否 |
| 2 | COMBINEACCTYPE | nvarchar(50) | 否 |
| 3 | COMBINEACCNO | nvarchar(50) | 否 |
| 4 | COMBINEPOSITION | decimal | 是 |
| 5 | ACCESSORYCATEGORY | nvarchar(50) | 否 |
| 6 | ACCESSORYTYPE | nvarchar(50) | 否 |
| 7 | ACCESSORYNO | nvarchar(50) | 否 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | CREATOR | nvarchar(50) | 是 |
| 10 | GUID | nvarchar(50) | 是 |
| 11 | TBLEMSACCESSORYSTATEGUID | nvarchar(50) | 是 |

## TBLEMSEQPACCSTATE — 设备模治具状态

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 2 | EQUIPMENTNO | nvarchar(50) | 否 |
| 3 | ACCESSORYTYPE | nvarchar(50) | 是 |
| 4 | ACCESSORYNO | nvarchar(50) | 否 |
| 5 | USERNO | nvarchar(30) | 是 |
| 6 | STARTTIME | datetime | 是 |
| 7 | ACCESSORYVERSION | nvarchar(5) | 是 |
| 8 | Creator | nvarchar(50) | 是 |
| 9 | CreateDate | datetime | 是 |
| 10 | GUID | nvarchar(50) | 是 |

## TBLEMSEQUIPMENTSTATE — 设备状态

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQPSERIALNO | nvarchar(20) | 是 |
| 2 | EQUIPMENTNO | nvarchar(50) | 否 |
| 3 | EQUIPMENTSTATE | numeric | 否 |
| 4 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 5 | STARTTIME | datetime | 否 |
| 6 | USERNO | nvarchar(30) | 是 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |
| 9 | HandleUserNo | nvarchar(30) | 是 |
| 10 | PlanStartTime | datetime | 是 |
| 11 | Remarks | nvarchar(255) | 是 |
| 12 | PLANENDTIME | datetime | 是 |
| 13 | REPAIRTYPE | numeric | 是 |
| 14 | Creator | nvarchar(50) | 是 |
| 15 | CreateDate | datetime | 是 |
| 16 | GUID | nvarchar(50) | 是 |

## TBLEMSEQUIPMENTSTATELOG — 设备状态历程

> 字段数：25 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQPSERIALNO | nvarchar(20) | 否 |
| 2 | EQUIPMENTNO | nvarchar(50) | 是 |
| 3 | EQUIPMENTSTATE | numeric | 否 |
| 4 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 5 | STARTTIME | datetime | 否 |
| 6 | ENDTIME | datetime | 否 |
| 7 | USERNO | nvarchar(30) | 是 |
| 8 | DESCRIPTION | nvarchar(4000) | 是 |
| 9 | LOTSERIAL | nvarchar(55) | 是 |
| 10 | HandleUserNo | nvarchar(30) | 是 |
| 11 | PlanStartTime | datetime | 是 |
| 12 | ActualEndTime | datetime | 是 |
| 13 | Remarks | nvarchar(255) | 是 |
| 14 | Revisor | nvarchar(30) | 是 |
| 15 | ReviseDate | datetime | 是 |
| 16 | AdjustORGEquipmentState | numeric | 是 |
| 17 | AdjustPREEquipmentState | numeric | 是 |
| 18 | EDITDATE | datetime | 是 |
| 19 | PLANENDTIME | datetime | 是 |
| 20 | REPAIRTYPE | numeric | 是 |
| 21 | Creator | nvarchar(50) | 是 |
| 22 | CreateDate | datetime | 是 |
| 23 | EDITOR | nvarchar(50) | 是 |
| 24 | GUID | nvarchar(50) | 是 |
| 25 | ORIGINGUID | nvarchar(50) | 是 |

## TBLENTCUSTOMERBASIS — 客户主档

> 字段数：38 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CUSTOMERNO | nvarchar(50) | 否 |
| 2 | CUSTOMERNAME | nvarchar(255) | 是 |
| 3 | CUSTOMERSNAME | nvarchar(255) | 是 |
| 4 | TELNO | nvarchar(40) | 是 |
| 5 | FAXNO | nvarchar(40) | 是 |
| 6 | WWW | nvarchar(50) | 是 |
| 7 | TAXCODE | nvarchar(40) | 是 |
| 8 | ADDRESS | nvarchar(255) | 是 |
| 9 | DIRECTOR | nvarchar(50) | 是 |
| 10 | CREATOR | nvarchar(50) | 是 |
| 11 | CREATEDATE | datetime | 是 |
| 12 | DESCRIPTION | nvarchar(4000) | 是 |
| 13 | ISSUESTATE | numeric | 是 |
| 14 | ADDRESS2 | nvarchar(255) | 是 |
| 15 | COUNTRY | nvarchar(50) | 是 |
| 16 | STATUS | nvarchar(5) | 是 |
| 17 | CURRENCY | nvarchar(6) | 是 |
| 18 | INVTYPENO | nvarchar(1) | 是 |
| 19 | INVADDR | nvarchar(255) | 是 |
| 20 | INVADDR2 | nvarchar(255) | 是 |
| 21 | INVCUSTNO | nvarchar(20) | 是 |
| 22 | INVREMARK | nvarchar(100) | 是 |
| 23 | CUSTTYPE | nvarchar(1) | 是 |
| 24 | ARTYPE | nvarchar(1) | 是 |
| 25 | FREIGHTTERMS | nvarchar(20) | 是 |
| 26 | PAYMENTTERMS | nvarchar(20) | 是 |
| 27 | ACCTNO | nvarchar(50) | 是 |
| 28 | DELIVERYTERM | nvarchar(50) | 是 |
| 29 | FORWARDERASSIGNED | nvarchar(50) | 是 |
| 30 | BROKERASSIGNED | nvarchar(50) | 是 |
| 31 | INSURANCECOVERAGE | nvarchar(50) | 是 |
| 32 | REVISER | nvarchar(50) | 是 |
| 33 | REVISEDATE | datetime | 是 |
| 34 | CUSTOMERENAME | nvarchar(50) | 是 |
| 35 | ERPNo | nvarchar(50) | 是 |
| 36 | EDITOR | nvarchar(50) | 是 |
| 37 | EDITDATE | datetime | 是 |
| 38 | GUID | nvarchar(50) | 是 |

## TBLENTSUBCONTRACTOR — 外包商主档

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SUBCONTRACTORNO | nvarchar(20) | 否 |
| 2 | SUBCONTRACTORNAME | nvarchar(255) | 是 |
| 3 | DESCRIPTION | nvarchar(4000) | 是 |
| 4 | CREATOR | nvarchar(50) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | ERPNo | nvarchar(20) | 是 |
| 8 | MAXOUTPUTQTY | numeric | 是 |
| 9 | OUTPUTTYPE | varchar(1) | 是 |
| 10 | ECINTEGRATION | numeric | 是 |
| 11 | EDITOR | nvarchar(50) | 是 |
| 12 | EDITDATE | datetime | 是 |
| 13 | GUID | nvarchar(50) | 是 |

## TBLEQPACCESSORYBASIS — 模治具主档

> 字段数：23 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCESSORYNO | nvarchar(50) | 否 |
| 2 | ACCESSORYTYPE | nvarchar(50) | 是 |
| 3 | VENDORNO | nvarchar(50) | 是 |
| 4 | MODELNO | nvarchar(50) | 是 |
| 5 | DESCRIPTION | nvarchar(4000) | 是 |
| 6 | CREATOR | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | ISSUESTATE | numeric | 是 |
| 9 | ASSETNO | nvarchar(50) | 是 |
| 10 | ACCESSORYVERSION | nvarchar(5) | 否 |
| 11 | CURVERSION | numeric | 否 |
| 12 | ACCESSORYCATEGORY | nvarchar(50) | 是 |
| 13 | ERPNO | nvarchar(50) | 是 |
| 14 | LocatorNo | nvarchar(20) | 是 |
| 15 | AccessoryName | nvarchar(50) | 是 |
| 16 | STDNumberCavity | numeric | 是 |
| 17 | GoodNumberCavity | numeric | 是 |
| 18 | Revisor | nvarchar(30) | 是 |
| 19 | ReviseDate | datetime | 是 |
| 20 | Priority | numeric | 是 |
| 21 | EDITOR | nvarchar(50) | 是 |
| 22 | EDITDATE | datetime | 是 |
| 23 | GUID | nvarchar(50) | 是 |

## TBLEQPACCESSORYCATEGORY — 模治具类别

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCESSORYCATEGORY | nvarchar(50) | 否 |
| 2 | DESCRIPTION | nvarchar(4000) | 是 |
| 3 | CREATOR | nvarchar(50) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | ISSUESTATE | numeric | 是 |
| 6 | CombineACC | numeric | 否 |
| 7 | PositionQty | numeric | 否 |
| 8 | DESCROPTION | nvarchar(255) | 是 |
| 9 | STOCKSTATUS | numeric | 否 |
| 10 | EDITOR | nvarchar(50) | 是 |
| 11 | EDITDATE | datetime | 是 |
| 12 | GUID | nvarchar(50) | 是 |

## TBLEQPACCESSORYTYPE — 模治具类型

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCESSORYTYPE | nvarchar(50) | 否 |
| 2 | DESCRIPTION | nvarchar(4000) | 是 |
| 3 | CREATOR | nvarchar(50) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | ISSUESTATE | numeric | 是 |
| 6 | ACCESSORYCATEGORY | nvarchar(50) | 是 |
| 7 | STDNumberCavity | numeric | 是 |
| 8 | COMBINEACC | numeric | 否 |
| 9 | STOCKSTATUS | numeric | 否 |
| 10 | EDITOR | nvarchar(50) | 是 |
| 11 | EDITDATE | datetime | 是 |
| 12 | GUID | nvarchar(50) | 是 |

## TBLEQPACCSTATEBASIS — 模治具状态主档

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCESSORYSTATE | numeric | 否 |
| 2 | STATETYPE | numeric | 否 |
| 3 | STATENAME | nvarchar(50) | 是 |
| 4 | STATECOLOR | numeric | 否 |
| 5 | DESCRIPTION | nvarchar(4000) | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | Creator | nvarchar(50) | 是 |
| 8 | CreateDate | datetime | 是 |
| 9 | EDITOR | nvarchar(50) | 是 |
| 10 | EDITDATE | datetime | 是 |
| 11 | GUID | nvarchar(50) | 是 |

## TBLEQPEQUIPMENTBASIS — 设备主档

> 字段数：71 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTNO | nvarchar(50) | 否 |
| 2 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 3 | CAPACITY | numeric | 是 |
| 4 | VENDORNO | nvarchar(50) | 是 |
| 5 | MODELNO | nvarchar(50) | 是 |
| 6 | DESCRIPTION | nvarchar(4000) | 是 |
| 7 | CREATOR | nvarchar(50) | 是 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | ISSUESTATE | numeric | 是 |
| 10 | ENGINEERGROUPNO | nvarchar(20) | 是 |
| 11 | ASSETNO | nvarchar(50) | 是 |
| 12 | EQUIPMENTCLASS | nvarchar(50) | 是 |
| 13 | LOADPORT | numeric | 是 |
| 14 | AUTOFLAG | numeric | 是 |
| 15 | EACONTROLLER | nvarchar(200) | 是 |
| 16 | EQPRECIPE | numeric | 是 |
| 17 | QCLISTNO | nvarchar(50) | 是 |
| 18 | MaxTime | numeric | 是 |
| 19 | FixEqpTime | numeric | 是 |
| 20 | VarEqpTime | numeric | 是 |
| 21 | CountEqpUnitQty | numeric | 是 |
| 22 | COUNTER | numeric | 是 |
| 23 | ERPNO | nvarchar(50) | 是 |
| 24 | EquipmentName | nvarchar(255) | 是 |
| 25 | PRODUCTIONINF | numeric | 否 |
| 26 | ALLOWMULTIWORK | numeric | 否 |
| 27 | SETUPIGNOREMACHINE | numeric | 是 |
| 28 | SPC_PQC | numeric | 是 |
| 29 | EQUIPMENTCHECKUP | nvarchar(1) | 否 |
| 30 | EQUIPMENTCHECKUPRATE | nvarchar(1) | 否 |
| 31 | EQUIPMENTCHECKUPTIME | datetime | 是 |
| 32 | Counter_Pre | numeric | 是 |
| 33 | OutUserOption | numeric | 否 |
| 34 | OutLaberTimeOption | numeric | 否 |
| 35 | OutLaberExclusive | numeric | 否 |
| 36 | OutMachineExclusive | numeric | 否 |
| 37 | OutQtyDefinition | numeric | 否 |
| 38 | OutQtyOption | numeric | 否 |
| 39 | OutQtyAllowZero | numeric | 否 |
| 40 | CounterUpdateTime | datetime | 是 |
| 41 | CounterEQTime | datetime | 是 |
| 42 | SPC_PQC2 | varchar(10) | 是 |
| 43 | RecordTimeOutDate | datetime | 是 |
| 44 | StdTimeOut | numeric | 否 |
| 45 | StdTimeOutQty | numeric | 否 |
| 46 | LotBinding | numeric | 否 |
| 47 | LineInventoryNo | nvarchar(20) | 是 |
| 48 | COUNTERBYLOT | numeric | 否 |
| 49 | COUNTERBYCHECKOUT | numeric | 否 |
| 50 | COUNTERBYCHECKIN | numeric | 否 |
| 51 | COUNTER_PRECHECKIN | numeric | 否 |
| 52 | COUNTERBYWAIT | numeric | 否 |
| 53 | COUNTERBYRELEASEWAIT | numeric | 否 |
| 54 | COUNTERMULTIPLE | numeric | 否 |
| 55 | COUNTERBYCHECKOUTWAIT | numeric | 否 |
| 56 | COUNTERBYLOTWAIT | numeric | 否 |
| 57 | ISAUTOCINEXTEQ | numeric | 否 |
| 58 | CINEXTEQ | nvarchar(50) | 是 |
| 59 | ACCESSORYASSIGN | numeric | 是 |
| 60 | COUNTER_LASTCOUNT | numeric | 否 |
| 61 | EQPAUTOCHECKOUTFLAG | nvarchar(1) | 否 |
| 62 | STDTIMEOUTNONAUTOCOUNT | numeric | 否 |
| 63 | COUNTDIFFOUTLIER | numeric | 否 |
| 64 | STDTIMEOUTNONAUTORATIO | numeric | 否 |
| 65 | EDITOR | nvarchar(50) | 是 |
| 66 | EDITDATE | datetime | 是 |
| 67 | GUID | nvarchar(50) | 是 |
| 68 | C_PointIP | nvarchar(50) | 是 |
| 69 | C_PrinterName | nvarchar(50) | 是 |
| 70 | C_LOTCONCURRENTLIMIT | numeric | 是 |
| 71 | C_factoryno | varchar(20) | 是 |

## TBLEQPGROUPDETAIL 

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTGROUP | nvarchar(50) | 否 |
| 2 | EQUIPMENTNO | nvarchar(50) | 否 |
| 3 | TBLEQPGROUPBASISGUID | nvarchar(50) | 是 |
| 4 | Creator | nvarchar(50) | 是 |
| 5 | CreateDate | datetime | 是 |
| 6 | EDITOR | nvarchar(50) | 是 |
| 7 | EDITDATE | datetime | 是 |
| 8 | GUID | nvarchar(50) | 是 |
| 9 | TBLEQPEQUIPMENTBASISGUID | nvarchar(50) | 是 |

## TBLINVFGDINBASIS — 成品入库单

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FGDINNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | DESCRIPTION | nvarchar(4000) | 是 |
| 4 | CREATOR | nvarchar(50) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | INVENTORYNO | nvarchar(20) | 是 |
| 7 | INPUTDATE | datetime | 是 |
| 8 | SOURCE | numeric | 否 |
| 9 | FROMINVENTORYNO | nvarchar(20) | 是 |
| 10 | REVISER | nvarchar(50) | 是 |
| 11 | REVISEDATE | datetime | 是 |
| 12 | LocatorNo | nvarchar(20) | 是 |
| 13 | ISSUESTATE | numeric | 是 |
| 14 | EDITOR | nvarchar(50) | 是 |
| 15 | EDITDATE | datetime | 是 |
| 16 | GUID | nvarchar(50) | 是 |

## TBLINVFGDINDETAIL — 成品入库明细

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FGDINNO | nvarchar(20) | 否 |
| 2 | PRODUCTNO | nvarchar(50) | 否 |
| 3 | PRODUCTVERSION | nvarchar(50) | 否 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | QTY | numeric | 否 |
| 6 | UNITNO | nvarchar(30) | 是 |
| 7 | LOCATORNO | nvarchar(20) | 否 |
| 8 | BASELOTNO | nvarchar(50) | 是 |
| 9 | StockLotNo | nvarchar(50) | 是 |
| 10 | fromInventoryNo | nvarchar(20) | 是 |
| 11 | OPNo | nvarchar(20) | 否 |
| 12 | Creator | nvarchar(50) | 是 |
| 13 | CreateDate | datetime | 是 |
| 14 | EDITOR | nvarchar(50) | 是 |
| 15 | EDITDATE | datetime | 是 |
| 16 | GUID | nvarchar(50) | 是 |

## TBLMTLMATERIALBASIS — 物料主档

> 字段数：59 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALNO | nvarchar(50) | 否 |
| 2 | MATERIALTYPE | nvarchar(50) | 否 |
| 3 | ISSUESTATE | numeric | 是 |
| 4 | DESCRIPTION | nvarchar(4000) | 是 |
| 5 | CREATOR | nvarchar(50) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | MATERIALNAME | nvarchar(255) | 是 |
| 8 | MATERIALSPEC | nvarchar(255) | 是 |
| 9 | PUTINPLACE | numeric | 是 |
| 10 | COUNTWAY | numeric | 是 |
| 11 | CHECKLOTNO | numeric | 是 |
| 12 | UNITTYPE | nvarchar(64) | 否 |
| 13 | SAFEQTY | numeric | 是 |
| 14 | UNITNO | nvarchar(30) | 否 |
| 15 | EX_MTLBASIS1 | nvarchar(20) | 是 |
| 16 | KEYMATERIALS | numeric | 是 |
| 17 | ERPNo | nvarchar(50) | 是 |
| 18 | USER_DEFINED01 | nvarchar(255) | 是 |
| 19 | USER_DEFINED02 | nvarchar(255) | 是 |
| 20 | USER_DEFINED03 | nvarchar(255) | 是 |
| 21 | USER_DEFINED04 | nvarchar(255) | 是 |
| 22 | USER_DEFINED05 | nvarchar(255) | 是 |
| 23 | USER_DEFINED06 | nvarchar(255) | 是 |
| 24 | USER_DEFINED07 | nvarchar(255) | 是 |
| 25 | USER_DEFINED08 | nvarchar(255) | 是 |
| 26 | USER_DEFINED09 | nvarchar(255) | 是 |
| 27 | USER_DEFINED10 | nvarchar(255) | 是 |
| 28 | USER_DEFINED11 | numeric | 是 |
| 29 | USER_DEFINED12 | numeric | 是 |
| 30 | USER_DEFINED13 | numeric | 是 |
| 31 | USER_DEFINED14 | numeric | 是 |
| 32 | USER_DEFINED15 | numeric | 是 |
| 33 | USER_DEFINED16 | numeric | 是 |
| 34 | USER_DEFINED17 | numeric | 是 |
| 35 | USER_DEFINED18 | numeric | 是 |
| 36 | USER_DEFINED19 | numeric | 是 |
| 37 | USER_DEFINED20 | numeric | 是 |
| 38 | USER_DEFINED21 | datetime | 是 |
| 39 | USER_DEFINED22 | datetime | 是 |
| 40 | USER_DEFINED23 | datetime | 是 |
| 41 | USER_DEFINED24 | datetime | 是 |
| 42 | USER_DEFINED25 | datetime | 是 |
| 43 | USER_DEFINED26 | datetime | 是 |
| 44 | USER_DEFINED27 | datetime | 是 |
| 45 | USER_DEFINED28 | datetime | 是 |
| 46 | USER_DEFINED29 | datetime | 是 |
| 47 | USER_DEFINED30 | datetime | 是 |
| 48 | USER_DEFINED31 | nvarchar(255) | 是 |
| 49 | USER_DEFINED32 | nvarchar(255) | 是 |
| 50 | USER_DEFINED33 | numeric | 是 |
| 51 | USER_DEFINED34 | numeric | 是 |
| 52 | GraphNo | nvarchar(255) | 是 |
| 53 | QCCategory | nvarchar(50) | 是 |
| 54 | ARTICLENO | nvarchar(50) | 是 |
| 55 | ShelfLife | numeric | 是 |
| 56 | CheckValidity | numeric | 是 |
| 57 | EDITOR | nvarchar(50) | 是 |
| 58 | EDITDATE | datetime | 是 |
| 59 | GUID | nvarchar(50) | 是 |

## TBLOEMOBASIS — 工单MO主档

> 字段数：81 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | RONO | nvarchar(25) | 否 |
| 3 | ITEMNO | numeric | 否 |
| 4 | MOSTATE | numeric | 否 |
| 5 | MOQTY | numeric | 否 |
| 6 | PRODUCTNO | nvarchar(50) | 否 |
| 7 | PRODUCTVERSION | nvarchar(5) | 否 |
| 8 | PRIORITY | numeric | 否 |
| 9 | PLANFINISHDATE | datetime | 是 |
| 10 | BELONGTOMONO | nvarchar(50) | 是 |
| 11 | DESCRIPTION | nvarchar(4000) | 是 |
| 12 | CREATOR | nvarchar(50) | 是 |
| 13 | CREATEDATE | datetime | 是 |
| 14 | ISSUESTATE | numeric | 是 |
| 15 | UNRELEASELOTQTY | numeric | 否 |
| 16 | MOUNITNO | nvarchar(30) | 否 |
| 17 | LOTSERIAL | nvarchar(55) | 是 |
| 18 | MOTYPENO | numeric | 否 |
| 19 | MOSOURCE | numeric | 是 |
| 20 | ENGNO | nvarchar(64) | 否 |
| 21 | ENGVERSION | nvarchar(5) | 否 |
| 22 | CUSTOMERNO | nvarchar(50) | 是 |
| 23 | INCOMINGKEY | nvarchar(55) | 是 |
| 24 | CUSTOMERLOTNO | nvarchar(50) | 是 |
| 25 | COMPONENTFROMINV | numeric | 是 |
| 26 | FACTORYNO | nvarchar(20) | 否 |
| 27 | RETURNNO | nvarchar(20) | 是 |
| 28 | ORGMOSTATE | numeric | 是 |
| 29 | MOCLOSEDATE | datetime | 是 |
| 30 | PlanStartDate | datetime | 是 |
| 31 | StockInLotNo | nvarchar(50) | 是 |
| 32 | USER_DEFINED01 | nvarchar(255) | 是 |
| 33 | USER_DEFINED02 | nvarchar(255) | 是 |
| 34 | USER_DEFINED03 | nvarchar(255) | 是 |
| 35 | USER_DEFINED04 | nvarchar(255) | 是 |
| 36 | USER_DEFINED05 | nvarchar(255) | 是 |
| 37 | USER_DEFINED06 | nvarchar(255) | 是 |
| 38 | USER_DEFINED07 | nvarchar(255) | 是 |
| 39 | USER_DEFINED08 | nvarchar(255) | 是 |
| 40 | USER_DEFINED09 | nvarchar(255) | 是 |
| 41 | USER_DEFINED10 | nvarchar(255) | 是 |
| 42 | USER_DEFINED11 | numeric | 是 |
| 43 | USER_DEFINED12 | numeric | 是 |
| 44 | USER_DEFINED13 | numeric | 是 |
| 45 | USER_DEFINED14 | numeric | 是 |
| 46 | USER_DEFINED15 | numeric | 是 |
| 47 | USER_DEFINED16 | numeric | 是 |
| 48 | USER_DEFINED17 | numeric | 是 |
| 49 | USER_DEFINED18 | numeric | 是 |
| 50 | USER_DEFINED19 | numeric | 是 |
| 51 | USER_DEFINED20 | numeric | 是 |
| 52 | USER_DEFINED21 | datetime | 是 |
| 53 | USER_DEFINED22 | datetime | 是 |
| 54 | USER_DEFINED23 | datetime | 是 |
| 55 | USER_DEFINED24 | datetime | 是 |
| 56 | USER_DEFINED25 | datetime | 是 |
| 57 | USER_DEFINED26 | datetime | 是 |
| 58 | USER_DEFINED27 | datetime | 是 |
| 59 | USER_DEFINED28 | datetime | 是 |
| 60 | USER_DEFINED29 | datetime | 是 |
| 61 | USER_DEFINED30 | datetime | 是 |
| 62 | USER_DEFINED31 | nvarchar(255) | 是 |
| 63 | USER_DEFINED32 | nvarchar(255) | 是 |
| 64 | USER_DEFINED33 | numeric | 是 |
| 65 | USER_DEFINED34 | numeric | 是 |
| 66 | STORAGE_SPACES_NO | nvarchar(50) | 是 |
| 67 | WAREHOUSE_NO | nvarchar(50) | 是 |
| 68 | ACTUALSTARTDATE | datetime | 是 |
| 69 | ACTUALFINISHDATE | datetime | 是 |
| 70 | ERPMOLineNo | nvarchar(50) | 是 |
| 71 | PreMOState | numeric | 是 |
| 72 | AutoRunERPMOCloseSyncFlag | numeric | 是 |
| 73 | PREMONO | nvarchar(50) | 是 |
| 74 | MOCLASS | nvarchar(50) | 是 |
| 75 | MATERIALPRE | nvarchar(1) | 是 |
| 76 | EDITOR | nvarchar(50) | 是 |
| 77 | EDITDATE | datetime | 是 |
| 78 | GUID | nvarchar(50) | 是 |
| 79 | PCSNOTOLOG | numeric | 否 |
| 80 | OSNO | nvarchar(50) | 是 |
| 81 | PRODUCTNAME | nvarchar(50) | 是 |

## TBLOEMOMATERIALINBASIS_ERP — 工单材料领入(ERP)【⚠️发料核对勿用此表,会误导】

> 字段数：17 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | UNITNO | nvarchar(30) | 否 |
| 5 | QTY | numeric | 否 |
| 6 | MATERIALLEVEL | numeric | 否 |
| 7 | MATERIALTYPE | nvarchar(50) | 是 |
| 8 | INPUTDATE | datetime | 是 |
| 9 | SUBSTITUTEMATERIALNO | nvarchar(50) | 否 |
| 10 | MATERIALINNO | nvarchar(50) | 否 |
| 11 | STATE | numeric | 否 |
| 12 | EDITDATE | datetime | 是 |
| 13 | Creator | nvarchar(50) | 是 |
| 14 | CreateDate | datetime | 是 |
| 15 | EDITOR | nvarchar(50) | 是 |
| 16 | GUID | nvarchar(50) | 是 |
| 17 | ORIGINGUID | nvarchar(50) | 是 |

## TBLOEMOMATERIALLIST — 工单材料清单(发料核对主表)

> 字段数：72 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLEVEL | numeric | 是 |
| 4 | STDQTY | numeric | 是 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | DECREASERATE | numeric | 否 |
| 7 | OPNO | nvarchar(20) | 否 |
| 8 | SPECIFIED | numeric | 是 |
| 9 | PUTINPLACETYPE | numeric | 是 |
| 10 | MOFLAG | numeric | 是 |
| 11 | MATERIALMONO | nvarchar(50) | 否 |
| 12 | MATERIALTYPE | nvarchar(50) | 否 |
| 13 | COUNTWAY | numeric | 否 |
| 14 | CHECKLOTNO | numeric | 否 |
| 15 | DESCRIPTION | nvarchar(4000) | 是 |
| 16 | ORGMATERIALNO | nvarchar(50) | 是 |
| 17 | EX_MTLLIST1 | nvarchar(20) | 是 |
| 18 | EX_MTLLIST2 | nvarchar(20) | 是 |
| 19 | MATERIALVERSION | nvarchar(5) | 是 |
| 20 | ORGMATERIALQTY | numeric | 是 |
| 21 | SUBSTITUTEMATERIALNO | nvarchar(50) | 否 |
| 22 | SUBSTITUTEMATERIALLEVEL | numeric | 是 |
| 23 | REQUIREQTY | numeric | 否 |
| 24 | SUBSTITUTESTDQTY | numeric | 否 |
| 25 | QPAMolecular | numeric | 是 |
| 26 | QPADenominator | numeric | 是 |
| 27 | SubstituteQPAMolecular | numeric | 是 |
| 28 | SubstituteQPADenominator | numeric | 是 |
| 29 | USER_DEFINED01 | nvarchar(255) | 是 |
| 30 | USER_DEFINED02 | nvarchar(255) | 是 |
| 31 | USER_DEFINED03 | nvarchar(255) | 是 |
| 32 | USER_DEFINED04 | nvarchar(255) | 是 |
| 33 | USER_DEFINED05 | nvarchar(255) | 是 |
| 34 | USER_DEFINED06 | nvarchar(255) | 是 |
| 35 | USER_DEFINED07 | nvarchar(255) | 是 |
| 36 | USER_DEFINED08 | nvarchar(255) | 是 |
| 37 | USER_DEFINED09 | nvarchar(255) | 是 |
| 38 | USER_DEFINED10 | nvarchar(255) | 是 |
| 39 | USER_DEFINED11 | numeric | 是 |
| 40 | USER_DEFINED12 | numeric | 是 |
| 41 | USER_DEFINED13 | numeric | 是 |
| 42 | USER_DEFINED14 | numeric | 是 |
| 43 | USER_DEFINED15 | numeric | 是 |
| 44 | USER_DEFINED16 | numeric | 是 |
| 45 | USER_DEFINED17 | numeric | 是 |
| 46 | USER_DEFINED18 | numeric | 是 |
| 47 | USER_DEFINED19 | numeric | 是 |
| 48 | USER_DEFINED20 | numeric | 是 |
| 49 | USER_DEFINED21 | datetime | 是 |
| 50 | USER_DEFINED22 | datetime | 是 |
| 51 | USER_DEFINED23 | datetime | 是 |
| 52 | USER_DEFINED24 | datetime | 是 |
| 53 | USER_DEFINED25 | datetime | 是 |
| 54 | USER_DEFINED26 | datetime | 是 |
| 55 | USER_DEFINED27 | datetime | 是 |
| 56 | USER_DEFINED28 | datetime | 是 |
| 57 | USER_DEFINED29 | datetime | 是 |
| 58 | USER_DEFINED30 | datetime | 是 |
| 59 | USER_DEFINED31 | nvarchar(255) | 是 |
| 60 | USER_DEFINED32 | nvarchar(255) | 是 |
| 61 | USER_DEFINED33 | numeric | 是 |
| 62 | USER_DEFINED34 | numeric | 是 |
| 63 | DICIMALDIGIT | numeric | 否 |
| 64 | PositionNo | nvarchar(50) | 否 |
| 65 | MTLSyncMode | numeric | 是 |
| 66 | MINStockQTY | numeric | 是 |
| 67 | SOURCEOFINFO | numeric | 否 |
| 68 | REQUIREQTY_Used | numeric | 否 |
| 69 | Creator | nvarchar(50) | 是 |
| 70 | CreateDate | datetime | 是 |
| 71 | GUID | nvarchar(50) | 是 |
| 72 | TBLOEMOBASISGUID | nvarchar(50) | 是 |

## TBLOEROBASIS — 订单RO主档

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RONO | nvarchar(25) | 否 |
| 2 | CUSTOMERNO | nvarchar(50) | 否 |
| 3 | DESCRIPTION | nvarchar(4000) | 是 |
| 4 | CREATOR | nvarchar(50) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | LOTSERIAL | nvarchar(55) | 是 |
| 8 | ROSTATE | numeric | 否 |
| 9 | DueDate | datetime | 是 |
| 10 | EDITOR | nvarchar(50) | 是 |
| 11 | EDITDATE | datetime | 是 |
| 12 | GUID | nvarchar(50) | 是 |

## TBLOERODETAIL — 订单RO明细

> 字段数：28 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RONO | nvarchar(25) | 否 |
| 2 | ITEMNO | numeric | 否 |
| 3 | PRODUCTNO | nvarchar(50) | 否 |
| 4 | ORDERQTY | numeric | 否 |
| 5 | UNRELEASEQTY | numeric | 否 |
| 6 | STATE | numeric | 否 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | CREATOR | nvarchar(50) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | ROUNITNO | nvarchar(64) | 否 |
| 11 | LOTSERIAL | nvarchar(55) | 是 |
| 12 | CUSTOMERNO | nvarchar(50) | 是 |
| 13 | ORDERTYPE | nvarchar(30) | 是 |
| 14 | SHIPQTY | numeric | 否 |
| 15 | PRIORITY | numeric | 否 |
| 16 | BOOKINGFLAG | numeric | 否 |
| 17 | SHIPPINGFLAG | numeric | 否 |
| 18 | UNITPRICE | numeric | 是 |
| 19 | UNITMEASURE | nvarchar(30) | 是 |
| 20 | CURRENCY | nvarchar(30) | 是 |
| 21 | ORDERDATE | datetime | 是 |
| 22 | REVISER | nvarchar(50) | 是 |
| 23 | REVISEDATE | datetime | 是 |
| 24 | CUSTOMERNAME | nvarchar(100) | 是 |
| 25 | DueDate | datetime | 是 |
| 26 | EDITOR | nvarchar(50) | 是 |
| 27 | EDITDATE | datetime | 是 |
| 28 | GUID | nvarchar(50) | 是 |

## TBLOPBASIS — 工序作业站主档

> 字段数：64 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OPNO | nvarchar(20) | 否 |
| 2 | OPNAME | nvarchar(500) | 是 |
| 3 | OPTYPE | nvarchar(20) | 否 |
| 4 | OPCLASS | numeric | 否 |
| 5 | OPSHORTNAME | nvarchar(500) | 是 |
| 6 | OPORDER | numeric | 是 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | CREATOR | nvarchar(50) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | ISSUESTATE | numeric | 是 |
| 11 | RULEXMLSTRING | nvarchar(-1) | 是 |
| 12 | PSNO | nvarchar(50) | 是 |
| 13 | PRINTOUTONRUNCARD | numeric | 是 |
| 14 | STDUNITRUNTIME | numeric | 否 |
| 15 | COUNTOPUNITQTY | numeric | 否 |
| 16 | STDQUEUETIME | numeric | 否 |
| 17 | PARTIALMODE | numeric | 是 |
| 18 | MaterialOption | numeric | 否 |
| 19 | MULTIOPERATORMODE | numeric | 是 |
| 20 | ERPNO | nvarchar(20) | 是 |
| 21 | OSOPTION | decimal | 否 |
| 22 | OSNO | nvarchar(40) | 是 |
| 23 | NEEDFIRSTCHECKOK | numeric | 是 |
| 24 | SPC_PQC | numeric | 是 |
| 25 | AUTOCI | numeric | 是 |
| 26 | DEFAULTEQPNO | nvarchar(50) | 是 |
| 27 | OUTPUTRATE | numeric | 否 |
| 28 | QC_Control | numeric | 否 |
| 29 | ISCHECKSTARTINGCHECKLIST | nvarchar(1) | 是 |
| 30 | SPC_PQC2 | varchar(10) | 是 |
| 31 | QC_Control2 | varchar(10) | 是 |
| 32 | QCCheckRate | numeric | 否 |
| 33 | PQCCheckRate | numeric | 否 |
| 34 | NeedPQCheckOK | numeric | 否 |
| 35 | PlugInUnit | numeric | 否 |
| 36 | PlugIn | numeric | 否 |
| 37 | CHECKOUTSTDQTY | numeric | 否 |
| 38 | AUTOSPLITLOT | numeric | 否 |
| 39 | AutoDispCallMtl | numeric | 否 |
| 40 | NeedSelfCheckOK | numeric | 否 |
| 41 | SelfCheckRate | numeric | 否 |
| 42 | NeedEndCheckOK | numeric | 否 |
| 43 | EndCheckRate | numeric | 否 |
| 44 | DefaultOSReturnQCFlag | numeric | 否 |
| 45 | DEFAULTOSOUTERPDOCTYPE | nvarchar(50) | 是 |
| 46 | PANELSIDE | numeric | 否 |
| 47 | STARTINGCHECKMODE | numeric | 是 |
| 48 | CONTROLPASS | nvarchar(1) | 否 |
| 49 | NeedSN | numeric | 否 |
| 50 | EDITOR | nvarchar(50) | 是 |
| 51 | EDITDATE | datetime | 是 |
| 52 | GUID | nvarchar(50) | 是 |
| 53 | PQCCHECKTIME | numeric | 是 |
| 54 | Print_Type | numeric | 是 |
| 55 | C_INSTORAGE | nvarchar(50) | 是 |
| 56 | C_OUTSTORAGE | nvarchar(20) | 是 |
| 57 | C_OUTSTORAGENAME | nvarchar(50) | 是 |
| 58 | C_PRODUCTIONTIME | numeric | 是 |
| 59 | C_isPhoto | numeric | 是 |
| 60 | C_InputSerial | numeric | 是 |
| 61 | C_PDAMaterialOption | int | 是 |
| 62 | C_EnableU9CStockinLabelAPI | int | 否 |
| 63 | C_EnableEndProduction | int | 是 |
| 64 | C_EnableColorScore | numeric | 是 |

## TBLPRDPRODUCTBASIS — 产品主档

> 字段数：75 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(10) | 否 |
| 3 | PRODUCTNAME | nvarchar(255) | 是 |
| 4 | PRODUCTTYPE | nvarchar(50) | 否 |
| 5 | ISSUESTATE | numeric | 是 |
| 6 | CREATOR | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | DESCRIPTION | nvarchar(4000) | 是 |
| 9 | CURVERSION | numeric | 否 |
| 10 | UNITNO | nvarchar(30) | 是 |
| 11 | UNITTYPE | nvarchar(30) | 是 |
| 12 | SPECNO | nvarchar(120) | 否 |
| 13 | CARTONQTY | numeric | 否 |
| 14 | PALLETQTY | numeric | 否 |
| 15 | PACKOIPATH | nvarchar(500) | 是 |
| 16 | BOXQTY | numeric | 是 |
| 17 | PRODUCTCODE | nvarchar(30) | 是 |
| 18 | SERIALTYPENO_LOT | nvarchar(50) | 是 |
| 19 | SERIALTYPENO_COMP | nvarchar(50) | 是 |
| 20 | PictureName | nvarchar(50) | 是 |
| 21 | LOTSTDQTY | numeric | 是 |
| 22 | ERPNo | nvarchar(50) | 是 |
| 23 | ItemSpec | nvarchar(255) | 是 |
| 24 | USER_DEFINED01 | nvarchar(255) | 是 |
| 25 | USER_DEFINED02 | nvarchar(255) | 是 |
| 26 | USER_DEFINED03 | nvarchar(255) | 是 |
| 27 | USER_DEFINED04 | nvarchar(255) | 是 |
| 28 | USER_DEFINED05 | nvarchar(255) | 是 |
| 29 | USER_DEFINED06 | nvarchar(255) | 是 |
| 30 | USER_DEFINED07 | nvarchar(255) | 是 |
| 31 | USER_DEFINED08 | nvarchar(255) | 是 |
| 32 | USER_DEFINED09 | nvarchar(255) | 是 |
| 33 | USER_DEFINED10 | nvarchar(255) | 是 |
| 34 | USER_DEFINED11 | numeric | 是 |
| 35 | USER_DEFINED12 | numeric | 是 |
| 36 | USER_DEFINED13 | numeric | 是 |
| 37 | USER_DEFINED14 | numeric | 是 |
| 38 | USER_DEFINED15 | numeric | 是 |
| 39 | USER_DEFINED16 | numeric | 是 |
| 40 | USER_DEFINED17 | numeric | 是 |
| 41 | USER_DEFINED18 | numeric | 是 |
| 42 | USER_DEFINED19 | numeric | 是 |
| 43 | USER_DEFINED20 | numeric | 是 |
| 44 | USER_DEFINED21 | datetime | 是 |
| 45 | USER_DEFINED22 | datetime | 是 |
| 46 | USER_DEFINED23 | datetime | 是 |
| 47 | USER_DEFINED24 | datetime | 是 |
| 48 | USER_DEFINED25 | datetime | 是 |
| 49 | USER_DEFINED26 | datetime | 是 |
| 50 | USER_DEFINED27 | datetime | 是 |
| 51 | USER_DEFINED28 | datetime | 是 |
| 52 | USER_DEFINED29 | datetime | 是 |
| 53 | USER_DEFINED30 | datetime | 是 |
| 54 | USER_DEFINED31 | nvarchar(255) | 是 |
| 55 | USER_DEFINED32 | nvarchar(255) | 是 |
| 56 | USER_DEFINED33 | numeric | 是 |
| 57 | USER_DEFINED34 | numeric | 是 |
| 58 | GraphNo | nvarchar(255) | 是 |
| 59 | QCCategory | nvarchar(50) | 是 |
| 60 | ARTICLENO | nvarchar(51) | 是 |
| 61 | STOCKLOTNO | numeric | 否 |
| 62 | ProductPCSNo | numeric | 否 |
| 63 | OSerp_type | nvarchar(20) | 是 |
| 64 | OSReturnerp_type | nvarchar(20) | 是 |
| 65 | MPQty | numeric | 是 |
| 66 | MPCount | numeric | 是 |
| 67 | ISPRODUCTPCSNO | numeric | 是 |
| 68 | PCBTIMECONTROLMODE | numeric | 是 |
| 69 | PCBTIMELIMIT | numeric | 是 |
| 70 | SINGLEBOARDTIME | numeric | 是 |
| 71 | EDITOR | nvarchar(50) | 是 |
| 72 | EDITDATE | datetime | 是 |
| 73 | GUID | nvarchar(50) | 是 |
| 74 | stdqty | int | 是 |
| 75 | Runcardno | nvarchar(50) | 否 |

## TBLPRDPRODUCTPROCESS — 产品制程流程

> 字段数：23 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | PSNO | nvarchar(50) | 否 |
| 4 | PSORDER | numeric | 否 |
| 5 | PROCESSNO | nvarchar(64) | 否 |
| 6 | DEFAULTPROCESS | numeric | 是 |
| 7 | HAVECOMPONENT | numeric | 否 |
| 8 | HAVELEVEL | numeric | 否 |
| 9 | MOTYPENO | numeric | 否 |
| 10 | PROCESSVERSION | nvarchar(5) | 否 |
| 11 | EquipmentGroup | nvarchar(50) | 是 |
| 12 | APSFixEQPTime | numeric | 是 |
| 13 | APSVarEQPTime | numeric | 是 |
| 14 | STDWorkTimeQty | numeric | 是 |
| 15 | TransferQty | numeric | 是 |
| 16 | LotRearTime | numeric | 是 |
| 17 | ISSUESTATE | numeric | 是 |
| 18 | Creator | nvarchar(50) | 是 |
| 19 | CreateDate | datetime | 是 |
| 20 | EDITOR | nvarchar(50) | 是 |
| 21 | EDITDATE | datetime | 是 |
| 22 | GUID | nvarchar(50) | 是 |
| 23 | TBLPRDPRODUCTBASISGUID | nvarchar(50) | 是 |

## TBLPRDSUBOPBASIS — 产品子作业

> 字段数：21 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SUBOPNO | nvarchar(20) | 否 |
| 2 | SUBOPNAME | nvarchar(255) | 否 |
| 3 | DESCRIPTION | nvarchar(4000) | 是 |
| 4 | PSNO | nvarchar(50) | 否 |
| 5 | SUBOPORDER | numeric | 否 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | FIXEMPTIME | numeric | 否 |
| 8 | VAREMPTIME | numeric | 否 |
| 9 | FIXEQPTIME | numeric | 否 |
| 10 | VAREQPTIME | numeric | 否 |
| 11 | COUNTUNITQTY | numeric | 否 |
| 12 | NEEDREPORT | numeric | 否 |
| 13 | AUTOCO | numeric | 否 |
| 14 | CONFIRMLOTSTATE | numeric | 否 |
| 15 | RECORDEQP | numeric | 否 |
| 16 | PRINTOUT | numeric | 否 |
| 17 | CREATOR | nvarchar(50) | 是 |
| 18 | CREATEDATE | datetime | 是 |
| 19 | EDITOR | nvarchar(50) | 是 |
| 20 | EDITDATE | datetime | 是 |
| 21 | GUID | nvarchar(50) | 是 |

## TBLPRSNODEBASIS 

> 字段数：20 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | NODEID | nvarchar(100) | 否 |
| 2 | NODENO | nvarchar(50) | 否 |
| 3 | NODETYPE | numeric | 否 |
| 4 | PROCESSNO | nvarchar(64) | 是 |
| 5 | GROUPNO | nvarchar(30) | 是 |
| 6 | CREATOR | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | PROCESSVERSION | nvarchar(5) | 是 |
| 10 | NODEVERSION | nvarchar(5) | 是 |
| 11 | STAGENO | nvarchar(50) | 是 |
| 12 | SEQUENCE | numeric | 是 |
| 13 | OPSeq | nvarchar(4) | 是 |
| 14 | Remark | nvarchar(255) | 是 |
| 15 | CONFLUENCE | numeric | 否 |
| 16 | ISSUESTATE | numeric | 是 |
| 17 | EDITOR | nvarchar(50) | 是 |
| 18 | EDITDATE | datetime | 是 |
| 19 | GUID | nvarchar(50) | 是 |
| 20 | TBLPRDPRODUCTPROCESSGUID | nvarchar(50) | 是 |

## TBLQCREASONBASIS — 不良原因主档

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | REASONNO | nvarchar(100) | 否 |
| 2 | REASONNAME | nvarchar(100) | 否 |
| 3 | REASONTYPE | numeric | 是 |
| 4 | REASONLEVEL | numeric | 否 |
| 5 | DESCRIPTION | nvarchar(4000) | 是 |
| 6 | CREATOR | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | ISSUESTATE | numeric | 是 |
| 9 | REASONSUBTYPE | nvarchar(4000) | 是 |
| 10 | EFFECTIVE | numeric | 是 |
| 11 | Invalidity | numeric | 是 |
| 12 | PLANPROCESSTIME | numeric | 是 |
| 13 | EDITOR | nvarchar(50) | 是 |
| 14 | EDITDATE | datetime | 是 |
| 15 | GUID | nvarchar(50) | 是 |

## TBLSMDAREABASIS — SMT区域主档

> 字段数：20 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | AREANO | nvarchar(20) | 否 |
| 2 | AREANAME | nvarchar(50) | 否 |
| 3 | AREATYPE | numeric | 否 |
| 4 | AREACLASS | numeric | 否 |
| 5 | BASEAREANO | nvarchar(20) | 是 |
| 6 | FACTORYNO | nvarchar(20) | 否 |
| 7 | DEPARTMENTNO | nvarchar(20) | 是 |
| 8 | DESCRIPTION | nvarchar(4000) | 是 |
| 9 | CREATOR | nvarchar(50) | 是 |
| 10 | CREATEDATE | datetime | 是 |
| 11 | ISSUESTATE | numeric | 是 |
| 12 | AREACOMPOSE | numeric | 否 |
| 13 | DISPATCHBYMACHINE_C | numeric | 否 |
| 14 | CALENDARID | nvarchar(20) | 是 |
| 15 | WIPEQPCheckMode | nvarchar(2) | 否 |
| 16 | SMTAREATYPE | numeric | 否 |
| 17 | EDITOR | nvarchar(50) | 是 |
| 18 | EDITDATE | datetime | 是 |
| 19 | GUID | nvarchar(50) | 是 |
| 20 | BACKGROUNDIMAGE | varbinary(-1) | 是 |

## TBLSMDAREARELATION — SMT区域关系

> 字段数：23 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BASEAREANO | nvarchar(50) | 否 |
| 2 | CONTAINAREANO | nvarchar(50) | 否 |
| 3 | OBJECTNO | nvarchar(50) | 否 |
| 4 | OBJECTTYPE | numeric | 否 |
| 5 | OBJECTTEXT | nvarchar(50) | 否 |
| 6 | OBJECTX | numeric | 否 |
| 7 | OBJECTY | numeric | 否 |
| 8 | OBJECTLENGTH | numeric | 否 |
| 9 | OBJECTWIDTH | numeric | 否 |
| 10 | OBJECTCOLOR | numeric | 否 |
| 11 | OBJECTSEQUENCE | numeric | 是 |
| 12 | OBJECTAREATYPE | numeric | 是 |
| 13 | BORDERCOLOR | numeric | 是 |
| 14 | BORDERSTYLE | numeric | 是 |
| 15 | TEXTCOLOR | numeric | 是 |
| 16 | OBJECTSQUENCE | numeric | 是 |
| 17 | Creator | nvarchar(50) | 是 |
| 18 | CreateDate | datetime | 是 |
| 19 | EDITOR | nvarchar(50) | 是 |
| 20 | EDITDATE | datetime | 是 |
| 21 | GUID | nvarchar(50) | 是 |
| 22 | TBLOPAREAGUID | nvarchar(50) | 是 |
| 23 | TBLSMDAREABASISGUID | nvarchar(50) | 是 |

## TBLSYSFUNCTION — 系统功能(菜单)

> 字段数：19 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FUNCTIONNO | nvarchar(50) | 否 |
| 2 | FUNCTIONNAME | nvarchar(50) | 否 |
| 3 | FUNCTIONORDER | numeric | 否 |
| 4 | MODULENO | nvarchar(10) | 否 |
| 5 | FORMNAME | nvarchar(50) | 是 |
| 6 | WEBURL | nvarchar(100) | 是 |
| 7 | CREATOR | nvarchar(50) | 是 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | PRIVOPTION | numeric | 是 |
| 10 | ISSUEOPTION | numeric | 是 |
| 11 | ISSUETABLE | nvarchar(50) | 是 |
| 12 | EXECUTIONFILE | nvarchar(50) | 是 |
| 13 | FUNCTIONKEY | nvarchar(30) | 是 |
| 14 | ExecutionMode | numeric | 否 |
| 15 | H5FUNCTIONKEY | nvarchar(50) | 是 |
| 16 | ISSUESTATE | numeric | 是 |
| 17 | EDITOR | nvarchar(50) | 是 |
| 18 | EDITDATE | datetime | 是 |
| 19 | GUID | nvarchar(50) | 是 |

## TBLUSRDEPARTMENTBASIS — 部门主档

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | DEPARTMENTNO | nvarchar(20) | 否 |
| 2 | DEPARTMENTNAME | nvarchar(500) | 是 |
| 3 | DESCRIPTION | nvarchar(4000) | 是 |
| 4 | CREATOR | nvarchar(50) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | DEPARTMENTSNAME | nvarchar(500) | 是 |
| 8 | COSTCENTER | nvarchar(30) | 是 |
| 9 | ERPNO | nvarchar(20) | 是 |
| 10 | EDITOR | nvarchar(50) | 是 |
| 11 | EDITDATE | datetime | 是 |
| 12 | GUID | nvarchar(50) | 是 |

## TBLUSRGROUPBASIS — 作业群组主档

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GROUPNO | nvarchar(50) | 否 |
| 2 | GROUPNAME | nvarchar(50) | 否 |
| 3 | CREATOR | nvarchar(50) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | DESCRIPTION | nvarchar(4000) | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | GROUPLEADER | nvarchar(50) | 是 |
| 8 | EDITOR | nvarchar(50) | 是 |
| 9 | EDITDATE | datetime | 是 |
| 10 | GUID | nvarchar(50) | 是 |

## TBLUSRGROUPPRIV — 群组权限(PRIVTYPE: 9菜单/0平台/8按钮)

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GROUPNO | nvarchar(50) | 否 |
| 2 | PRIVTYPE | numeric | 否 |
| 3 | PRIVNO | nvarchar(50) | 否 |
| 4 | CONTROLPRIV | numeric | 否 |
| 5 | Creator | nvarchar(50) | 是 |
| 6 | CreateDate | datetime | 是 |
| 7 | EDITOR | nvarchar(50) | 是 |
| 8 | EDITDATE | datetime | 是 |
| 9 | GUID | nvarchar(50) | 是 |
| 10 | TBLUSRGROUPBASISGUID | nvarchar(50) | 是 |
| 11 | TBLOPBASISGUID | nvarchar(50) | 是 |
| 12 | TBLEQPGROUPBASISGUID | nvarchar(50) | 是 |
| 13 | PRIVISSUE | numeric | 否 |

## TBLUSRGROUPPRIVCONTROL — 群组控件禁用

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GROUPNO | nvarchar(20) | 否 |
| 2 | PRIVNO | nvarchar(50) | 否 |
| 3 | CONTROLNAME | nvarchar(30) | 否 |

## TBLUSRSHIFTBASIS — 班别主档

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | DEPARTMENTNO | nvarchar(20) | 否 |
| 2 | SHIFTNO | nvarchar(20) | 否 |
| 3 | SHIFTNAME | nvarchar(50) | 否 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | CREATOR | nvarchar(50) | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | FROMTIME | datetime | 是 |
| 9 | TOTIME | datetime | 是 |
| 10 | ERPNO | nvarchar(20) | 是 |
| 11 | SHOWNAME | nvarchar(2) | 是 |
| 12 | EDITOR | nvarchar(50) | 是 |
| 13 | EDITDATE | datetime | 是 |
| 14 | GUID | nvarchar(50) | 是 |

## TBLUSRUSERBASIS — 用户主档

> 字段数：27 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | USERNO | nvarchar(50) | 否 |
| 2 | USERNAME | nvarchar(50) | 否 |
| 3 | USERLEVEL | numeric | 否 |
| 4 | PASSWORD | nvarchar(50) | 否 |
| 5 | CREATOR | nvarchar(50) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | ISSUESTATE | numeric | 是 |
| 9 | USERTYPE | numeric | 否 |
| 10 | DEPARTMENTNO | nvarchar(50) | 是 |
| 11 | CUSTOMERNO | nvarchar(50) | 是 |
| 12 | EMAILADDRESS | nvarchar(255) | 是 |
| 13 | CHANGEDATE | datetime | 是 |
| 14 | SHIFTNO | nvarchar(50) | 是 |
| 15 | MOBILENO | nvarchar(50) | 是 |
| 16 | RESETPASSWORD | numeric | 否 |
| 17 | ERPNo | nvarchar(50) | 是 |
| 18 | RESIGNATIONDATE | datetime | 是 |
| 19 | TITLENO | nvarchar(50) | 是 |
| 20 | COMEDAY | datetime | 是 |
| 21 | LineId | nvarchar(50) | 是 |
| 22 | WeChatId | nvarchar(50) | 是 |
| 23 | WatchId | nvarchar(50) | 是 |
| 24 | ICCard | nvarchar(50) | 是 |
| 25 | EDITOR | nvarchar(50) | 是 |
| 26 | EDITDATE | datetime | 是 |
| 27 | GUID | nvarchar(50) | 是 |

## TBLUSRUSERGROUP — 用户-群组关联

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | USERNO | nvarchar(50) | 否 |
| 2 | GROUPNO | nvarchar(50) | 否 |
| 3 | GROUPTYPE | numeric | 否 |
| 4 | AGENTOF | nvarchar(50) | 否 |
| 5 | AGENTDATE | datetime | 是 |
| 6 | AGENTCREATEDATE | datetime | 是 |
| 7 | ISSUESTATE | numeric | 是 |
| 8 | Creator | nvarchar(50) | 是 |
| 9 | CreateDate | datetime | 是 |
| 10 | EDITOR | nvarchar(50) | 是 |
| 11 | EDITDATE | datetime | 是 |
| 12 | GUID | nvarchar(50) | 是 |
| 13 | TBLUSRGROUPBASISGUID | nvarchar(50) | 是 |
| 14 | TBLUSRUSERBASISGUID | nvarchar(50) | 是 |
| 15 | TBLEQPENGINEERGROUPBASISGUID | nvarchar(50) | 是 |

## TBLWIPCONT_ACCESSORY — 报工-模治具耗用

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(50) | 是 |
| 2 | EQUIPMENTNO | nvarchar(50) | 是 |
| 3 | ACCESSORYTYPE | nvarchar(50) | 是 |
| 4 | ACCESSORYNO | nvarchar(50) | 是 |
| 5 | STARTTIME | datetime | 是 |
| 6 | ENDTIME | datetime | 是 |
| 7 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 8 | USEQTY | numeric | 是 |
| 9 | NEXTDAY | datetime | 是 |
| 10 | REASONNO | nvarchar(20) | 是 |
| 11 | STATE | nvarchar(1) | 是 |
| 12 | Creator | nvarchar(50) | 是 |
| 13 | CreateDate | datetime | 是 |
| 14 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_EQUIPMENT — 报工-设备报工组【报工主表】

> 字段数：21 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(50) | 是 |
| 2 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 3 | EQUIPMENTNO | nvarchar(50) | 是 |
| 4 | RECIPEGROUP | nvarchar(50) | 是 |
| 5 | RECIPEVERSION | numeric | 是 |
| 6 | EQUIPMENTCLASS | nvarchar(50) | 是 |
| 7 | STARTTIME | datetime | 是 |
| 8 | ENDTIME | datetime | 是 |
| 9 | LOADPORT | numeric | 是 |
| 10 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 11 | InputQty | numeric | 是 |
| 12 | OutputQty | numeric | 是 |
| 13 | EVENTTIME | datetime | 是 |
| 14 | FROMLOTNO | nvarchar(50) | 是 |
| 15 | FROMLOGGROUPSERIAL | nvarchar(50) | 是 |
| 16 | STATUS | numeric | 否 |
| 17 | ORGInputQTY | numeric | 否 |
| 18 | TransferOutputQTY | numeric | 否 |
| 19 | Creator | nvarchar(50) | 是 |
| 20 | CreateDate | datetime | 是 |
| 21 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_ERROR — 报工-不良记录

> 字段数：19 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 是 |
| 2 | OPNO | nvarchar(20) | 是 |
| 3 | ERRORNO | nvarchar(20) | 是 |
| 4 | ERRORLEVEL | numeric | 是 |
| 5 | ERRORQTY | numeric | 是 |
| 6 | COMPONENTNO | nvarchar(30) | 是 |
| 7 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 8 | REASONTYPE | numeric | 是 |
| 9 | DESCRIPTION | nvarchar(4000) | 是 |
| 10 | SCRAPFLAG | numeric | 否 |
| 11 | EVENTTIME | datetime | 否 |
| 12 | DET_ERRORQTY | numeric | 否 |
| 13 | LOTNO | nvarchar(50) | 否 |
| 14 | InventoryNo | nvarchar(20) | 是 |
| 15 | PCSNo | nvarchar(50) | 是 |
| 16 | OSNO | nvarchar(50) | 是 |
| 17 | Creator | nvarchar(50) | 是 |
| 18 | CreateDate | datetime | 是 |
| 19 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_MATERIAL — 报工-物料耗用【进站消耗主表】

> 字段数：19 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLEVEL | numeric | 否 |
| 4 | MATERIALTYPE | nvarchar(50) | 否 |
| 5 | USEQTY | numeric | 否 |
| 6 | UNITNO | nvarchar(30) | 否 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 9 | UNDISTRIBUTEQTY | numeric | 是 |
| 10 | MESNO | nvarchar(50) | 是 |
| 11 | EventTime | datetime | 是 |
| 12 | EQUIPMENTNO | nvarchar(50) | 是 |
| 13 | MaterialOption | numeric | 是 |
| 14 | ID | nvarchar(50) | 是 |
| 15 | UPDATER | nvarchar(50) | 是 |
| 16 | UPDATEDATE | datetime | 是 |
| 17 | Creator | nvarchar(50) | 是 |
| 18 | CreateDate | datetime | 是 |
| 19 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_MATERIALLOT — 报工-物料批次耗用

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | LOTQTY | numeric | 否 |
| 5 | EQUIPMENTNO | nvarchar(50) | 是 |
| 6 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 7 | UNDISTRIBUTEQTY | numeric | 是 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | EX_MATERIALLOT1 | nvarchar(20) | 是 |
| 10 | EX_MATERIALLOT2 | nvarchar(20) | 是 |
| 11 | EX_MATERIALLOT3 | nvarchar(20) | 是 |
| 12 | Remarks | nvarchar(255) | 是 |
| 13 | MainId | nvarchar(50) | 是 |
| 14 | Creator | nvarchar(50) | 是 |
| 15 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_PARTIALIN — 进站记录

> 字段数：21 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LotNo | nvarchar(50) | 否 |
| 2 | LogGroupSerial | nvarchar(50) | 否 |
| 3 | OPNo | nvarchar(20) | 否 |
| 4 | EventTime | datetime | 否 |
| 5 | UserNo | nvarchar(30) | 否 |
| 6 | AreaNo | nvarchar(20) | 否 |
| 7 | InputQty | numeric | 否 |
| 8 | EQUIPMENTNO | nvarchar(50) | 否 |
| 9 | CHECKINTIME | datetime | 是 |
| 10 | LotSerial | nvarchar(55) | 是 |
| 11 | NCFileName | nvarchar(50) | 是 |
| 12 | NCFileVersion | numeric | 是 |
| 13 | EDITDATE | datetime | 是 |
| 14 | Creator | nvarchar(50) | 是 |
| 15 | CreateDate | datetime | 是 |
| 16 | EDITOR | nvarchar(50) | 是 |
| 17 | GUID | nvarchar(50) | 是 |
| 18 | ORIGINGUID | nvarchar(50) | 是 |
| 19 | C_HEATNUMBER | nvarchar(500) | 是 |
| 20 | C_ONLYCODE | varchar(50) | 是 |
| 21 | C_PCSNO | varchar(50) | 是 |

## TBLWIPCONT_PARTIALIN_PCSNO — 进站记录-PCS序号

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LotNo | nvarchar(50) | 否 |
| 2 | OpNo | nvarchar(20) | 否 |
| 3 | PCSNo | nvarchar(50) | 否 |
| 4 | EventTime | datetime | 否 |
| 5 | EquipmentNo | nvarchar(50) | 否 |
| 6 | SNSTATE | numeric | 否 |
| 7 | ISSUESTATE | numeric | 是 |
| 8 | Creator | nvarchar(50) | 是 |
| 9 | CreateDate | datetime | 是 |
| 10 | Editor | nvarchar(50) | 是 |
| 11 | EditDate | datetime | 是 |
| 12 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_PARTIALOUT — 出站记录

> 字段数：28 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LotNo | nvarchar(50) | 否 |
| 2 | LogGroupSerial | nvarchar(50) | 否 |
| 3 | OPNo | nvarchar(50) | 否 |
| 4 | EventTime | datetime | 否 |
| 5 | UserNo | nvarchar(30) | 否 |
| 6 | AreaNo | nvarchar(20) | 否 |
| 7 | InputQty | numeric | 否 |
| 8 | GOODQTY | numeric | 是 |
| 9 | SCRAPQTY | numeric | 是 |
| 10 | EQUIPMENTNO | nvarchar(50) | 是 |
| 11 | RWOMESNO | nvarchar(50) | 否 |
| 12 | LotSerial | nvarchar(55) | 是 |
| 13 | SPLITLOTLOGGROUPSERIAL | nvarchar(50) | 是 |
| 14 | QCFormNo | nvarchar(30) | 是 |
| 15 | NETGUID | nvarchar(36) | 是 |
| 16 | EDITDATE | datetime | 是 |
| 17 | HISTORYTYPE | numeric | 否 |
| 18 | Creator | nvarchar(50) | 是 |
| 19 | CreateDate | datetime | 是 |
| 20 | EDITOR | nvarchar(50) | 是 |
| 21 | GUID | nvarchar(50) | 是 |
| 22 | ORIGINGUID | nvarchar(50) | 是 |
| 23 | C_HEATNUMBER | nvarchar(500) | 是 |
| 24 | C_ONLYCODE | nvarchar(50) | 是 |
| 25 | C_StockinBarcode | nvarchar(100) | 是 |
| 26 | C_materilSerial | varchar(50) | 是 |
| 27 | C_MaterialSerial | varchar(50) | 是 |
| 28 | C_ColorScore | numeric | 是 |

## TBLWIPCONT_PARTIALOUT_PCSNO — 出站记录-PCS序号

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LotNo | nvarchar(50) | 否 |
| 2 | OpNo | nvarchar(50) | 否 |
| 3 | PCSNo | nvarchar(50) | 否 |
| 4 | EventTime | datetime | 否 |
| 5 | GoodQty | numeric | 是 |
| 6 | ScrapQty | nvarchar(12) | 是 |
| 7 | EquipmentNo | nvarchar(50) | 否 |
| 8 | ISSUESTATE | numeric | 是 |
| 9 | Creator | nvarchar(50) | 是 |
| 10 | CreateDate | datetime | 是 |
| 11 | Editor | nvarchar(50) | 是 |
| 12 | EditDate | datetime | 是 |
| 13 | GUID | nvarchar(50) | 是 |

## TBLWIPCONT_RESOURCE — 报工-人员资源【工时主表】

> 字段数：21 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | MONO | nvarchar(50) | 否 |
| 3 | BASELOTNO | nvarchar(50) | 否 |
| 4 | OPNO | nvarchar(20) | 否 |
| 5 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 6 | RESCLASS | numeric | 否 |
| 7 | RESTYPE | nvarchar(50) | 否 |
| 8 | RESITEM | nvarchar(50) | 否 |
| 9 | RESVALUE | numeric | 是 |
| 10 | STDVALUE | numeric | 否 |
| 11 | INPUTQTY | numeric | 否 |
| 12 | USERNO | nvarchar(30) | 否 |
| 13 | EVENTTIME | datetime | 否 |
| 14 | RWOMESNO | nvarchar(50) | 否 |
| 15 | SUBRWOMESNO | nvarchar(50) | 是 |
| 16 | PriceType | numeric | 否 |
| 17 | UnitPrice | numeric | 否 |
| 18 | PriceRate | numeric | 否 |
| 19 | Creator | nvarchar(50) | 是 |
| 20 | CreateDate | datetime | 是 |
| 21 | GUID | nvarchar(50) | 是 |

## TBLWIPDISPATCHSTATE — 派工状态

> 字段数：27 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTNO | nvarchar(50) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | QTY | numeric | 否 |
| 5 | WORKDATE | datetime | 否 |
| 6 | SEQ | numeric | 否 |
| 7 | REVISER | nvarchar(50) | 是 |
| 8 | REVISEDATE | datetime | 是 |
| 9 | DispEndTime | datetime | 是 |
| 10 | QcLotFlag | numeric | 是 |
| 11 | DispQCLot | numeric | 是 |
| 12 | DispStartTime | datetime | 是 |
| 13 | DispAreaNo | nvarchar(20) | 是 |
| 14 | ShiftNO | nvarchar(20) | 是 |
| 15 | StdDispStartTime | datetime | 是 |
| 16 | StdDispEndTime | datetime | 是 |
| 17 | CombinedTag | nvarchar(40) | 是 |
| 18 | ChildProcessNo | nvarchar(64) | 否 |
| 19 | ChildProcessVersion | nvarchar(5) | 否 |
| 20 | REVISDATE | datetime | 是 |
| 21 | DISPSTARTTIMEPRE | datetime | 是 |
| 22 | DISPENDTIMEPRE | datetime | 是 |
| 23 | APSEQPSTARTTIME | datetime | 是 |
| 24 | APSEQPENDTIME | datetime | 是 |
| 25 | Creator | nvarchar(50) | 是 |
| 26 | CreateDate | datetime | 是 |
| 27 | GUID | nvarchar(50) | 是 |

## TBLWIPEQPMATERIALSTATE — 设备上料状态【扫码上料主表】

> 字段数：17 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EquipmentNo | nvarchar(50) | 否 |
| 2 | MaterialNo | nvarchar(50) | 否 |
| 3 | CheckLotNo | numeric | 否 |
| 4 | MONo | nvarchar(50) | 否 |
| 5 | InputMaterialNo | nvarchar(50) | 否 |
| 6 | MaterialLotNo | nvarchar(50) | 否 |
| 7 | Seq | numeric | 否 |
| 8 | InputQty | numeric | 否 |
| 9 | Qty | numeric | 否 |
| 10 | Reviser | nvarchar(50) | 否 |
| 11 | ReviseDate | datetime | 否 |
| 12 | OPNo | nvarchar(20) | 否 |
| 13 | PositionNo | nvarchar(50) | 否 |
| 14 | ORGMONo | nvarchar(50) | 否 |
| 15 | Creator | nvarchar(50) | 是 |
| 16 | CreateDate | datetime | 是 |
| 17 | GUID | nvarchar(50) | 是 |

## TBLWIPEQPQCLISTDETAIL — 设备点检项目明细

> 字段数：27 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | QCLISTSERIAL | nvarchar(120) | 否 |
| 2 | QCITEM | nvarchar(1000) | 否 |
| 3 | QCRESULT | numeric | 否 |
| 4 | INPUTVALUE | nvarchar(50) | 是 |
| 5 | STDVALUE | nvarchar(12) | 是 |
| 6 | MAXIVALUE | nvarchar(12) | 是 |
| 7 | MINIVALUE | nvarchar(12) | 是 |
| 8 | INPUTDATACOUNT | numeric | 否 |
| 9 | D01 | nvarchar(50) | 是 |
| 10 | D02 | nvarchar(50) | 是 |
| 11 | D03 | nvarchar(50) | 是 |
| 12 | D04 | nvarchar(50) | 是 |
| 13 | D05 | nvarchar(50) | 是 |
| 14 | D06 | nvarchar(50) | 是 |
| 15 | D07 | nvarchar(50) | 是 |
| 16 | D08 | nvarchar(50) | 是 |
| 17 | D09 | nvarchar(50) | 是 |
| 18 | D10 | nvarchar(50) | 是 |
| 19 | QCORDER | numeric | 否 |
| 20 | QCTYPE | numeric | 是 |
| 21 | Creator | nvarchar(50) | 是 |
| 22 | CreateDate | datetime | 是 |
| 23 | EDITOR | nvarchar(50) | 是 |
| 24 | EDITDATE | datetime | 是 |
| 25 | GUID | nvarchar(50) | 是 |
| 26 | FILENAME | nvarchar(500) | 是 |
| 27 | C_FILECONTENT | varbinary(-1) | 是 |

## TBLWIPEQPQCLISTLOG — 设备点检执行记录

> 字段数：17 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | QCLISTSERIAL | nvarchar(100) | 否 |
| 2 | EQUIPMENTNO | nvarchar(50) | 否 |
| 3 | QCLISTNO | nvarchar(100) | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 是 |
| 5 | LOGGROUPSERIAL | nvarchar(55) | 是 |
| 6 | QCRESULT | numeric | 否 |
| 7 | DESCRIPTION | nvarchar(4000) | 是 |
| 8 | CREATOR | nvarchar(50) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | REVISER | nvarchar(50) | 是 |
| 11 | REVISEDATE | datetime | 是 |
| 12 | EquipmentCheckUpRate | nvarchar(1) | 否 |
| 13 | EDITDATE | datetime | 是 |
| 14 | EDITOR | nvarchar(50) | 是 |
| 15 | GUID | nvarchar(50) | 是 |
| 16 | ORIGINGUID | nvarchar(50) | 是 |
| 17 | STAGING | numeric | 否 |

## TBLWIPERFBASIS — 工程变更(ECR)主档

> 字段数：39 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ERFNO | nvarchar(20) | 否 |
| 2 | LOTSERIAL | nvarchar(55) | 否 |
| 3 | LOTNO | nvarchar(50) | 否 |
| 4 | ERFTYPE | numeric | 否 |
| 5 | STATUS | numeric | 否 |
| 6 | RULENO | nvarchar(30) | 是 |
| 7 | OPNO | nvarchar(20) | 否 |
| 8 | CUSTOMERNO | nvarchar(50) | 是 |
| 9 | MCLASSNO | nvarchar(30) | 否 |
| 10 | SCRAPQTY | numeric | 否 |
| 11 | UNITNO | nvarchar(30) | 否 |
| 12 | CREATOR | nvarchar(30) | 否 |
| 13 | CREATEDATE | datetime | 否 |
| 14 | CURGROUPNO | nvarchar(20) | 否 |
| 15 | ERFSOURCE | numeric | 否 |
| 16 | PRODUCTNO | nvarchar(50) | 是 |
| 17 | LOTISVALID | numeric | 否 |
| 18 | HOLDTIME | numeric | 是 |
| 19 | CREATEDEPARTMENTNO | nvarchar(20) | 是 |
| 20 | DUTYDEPARTMENTNO | nvarchar(20) | 否 |
| 21 | CREATEERF | numeric | 否 |
| 22 | MODULESERIAL | nvarchar(50) | 否 |
| 23 | MODULENO | nvarchar(50) | 否 |
| 24 | MODULEVERSION | nvarchar(3) | 否 |
| 25 | MODULENODEID | nvarchar(80) | 否 |
| 26 | MODULESTAGENO | nvarchar(50) | 否 |
| 27 | CREATEQTY | numeric | 是 |
| 28 | RELEASEQTY | numeric | 是 |
| 29 | RELEASER | nvarchar(10) | 是 |
| 30 | RELEASEDATE | datetime | 是 |
| 31 | DISPDESCRIPTION | nvarchar(500) | 是 |
| 32 | CONTLOGGROUPSERIAL | nvarchar(50) | 是 |
| 33 | BASELOTNO | nvarchar(50) | 是 |
| 34 | BATCHLOT | nvarchar(4000) | 是 |
| 35 | LOTDISPTYPELIMIT | nvarchar(30) | 是 |
| 36 | HOLDDESCRIPTION | nvarchar(-1) | 是 |
| 37 | CURQTY | numeric | 是 |
| 38 | MONO | nvarchar(50) | 是 |
| 39 | NodeID | nvarchar(80) | 是 |

## TBLWIPFIRSTCHECK — 首件检验

> 字段数：22 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | QCFORMNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(50) | 否 |
| 3 | LOTNO | nvarchar(50) | 否 |
| 4 | USERNO | nvarchar(50) | 否 |
| 5 | AREANO | nvarchar(50) | 否 |
| 6 | CHECKQTY | numeric | 否 |
| 7 | DEFECTQTY | numeric | 否 |
| 8 | CHECKTIME | datetime | 否 |
| 9 | QCRESULT | nvarchar(50) | 否 |
| 10 | QCTYPE | nvarchar(50) | 否 |
| 11 | CheckOutTime | datetime | 是 |
| 12 | PCSNO | nvarchar(50) | 是 |
| 13 | QCItemResult | nvarchar(50) | 是 |
| 14 | PanelNo | nvarchar(50) | 是 |
| 15 | SMTOPSeq | nvarchar(4) | 是 |
| 16 | EquipmentNo | nvarchar(50) | 是 |
| 17 | PositionNo | nvarchar(50) | 是 |
| 18 | ApplyQcType | nvarchar(50) | 是 |
| 19 | ApplyQcFormNo | nvarchar(50) | 是 |
| 20 | Creator | nvarchar(50) | 是 |
| 21 | CreateDate | datetime | 是 |
| 22 | GUID | nvarchar(50) | 是 |

## TBLWIPLOTBASIS — 生产批主档

> 字段数：45 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BASELOTNO | nvarchar(50) | 否 |
| 2 | ORGLOTNO | nvarchar(50) | 否 |
| 3 | LOTSTATE | numeric | 否 |
| 4 | RONO | nvarchar(25) | 否 |
| 5 | ITEMNO | numeric | 否 |
| 6 | MONO | nvarchar(50) | 否 |
| 7 | PRODUCTNO | nvarchar(50) | 否 |
| 8 | PRODUCTVERSION | nvarchar(5) | 是 |
| 9 | CUSTOMERLOTNO | nvarchar(50) | 是 |
| 10 | CUSTOMERNO | nvarchar(50) | 是 |
| 11 | INPUTQTY | numeric | 否 |
| 12 | INPUTUNITNO | nvarchar(64) | 否 |
| 13 | PRIORITY | numeric | 是 |
| 14 | HOTLOT | numeric | 是 |
| 15 | WIPDATE | datetime | 是 |
| 16 | DESCRIPTION | nvarchar(4000) | 是 |
| 17 | CREATEDATE | datetime | 是 |
| 18 | CREATOR | nvarchar(50) | 是 |
| 19 | LOTSERIAL | nvarchar(55) | 是 |
| 20 | ENGNO | nvarchar(64) | 否 |
| 21 | ENGVERSION | nvarchar(5) | 否 |
| 22 | DEVICENO | nvarchar(50) | 是 |
| 23 | EX_LOTBASIS1 | nvarchar(20) | 是 |
| 24 | EX_LOTBASIS2 | nvarchar(20) | 是 |
| 25 | EX_LOTBASIS3 | nvarchar(20) | 是 |
| 26 | PLANFINISHDATE | datetime | 是 |
| 27 | RETURNNO | nvarchar(20) | 是 |
| 28 | DISPNO | nvarchar(50) | 是 |
| 29 | DISPSEQ | nvarchar(30) | 是 |
| 30 | PLANSTARTDATE | datetime | 是 |
| 31 | PriceType | numeric | 否 |
| 32 | BaseProcessNo | nvarchar(64) | 否 |
| 33 | BaseProcessVersion | nvarchar(5) | 否 |
| 34 | ChildProcessNo | nvarchar(64) | 否 |
| 35 | ChildProcessVersion | nvarchar(5) | 否 |
| 36 | LotNoType | numeric | 否 |
| 37 | ChildProcessType | numeric | 是 |
| 38 | OperateType | numeric | 是 |
| 39 | OperateOPno | nvarchar(64) | 是 |
| 40 | ChildEndOperate | numeric | 是 |
| 41 | CURLOTSTATUS | numeric | 是 |
| 42 | ISSUESTATE | numeric | 是 |
| 43 | EDITOR | nvarchar(50) | 是 |
| 44 | EDITDATE | datetime | 是 |
| 45 | GUID | nvarchar(50) | 是 |

## TBLWIPLotEQPChangeLog 

> 字段数：23 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGSERIAL | nvarchar(36) | 否 |
| 2 | LOTNO | nvarchar(64) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 否 |
| 5 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 6 | FROMEQUIPMENTNO | nvarchar(50) | 否 |
| 7 | TOEQUIPMENTNO | nvarchar(50) | 否 |
| 8 | MOVEDATE | datetime | 是 |
| 9 | MOVEQTY | numeric | 否 |
| 10 | FROMBEFOREQTY | numeric | 否 |
| 11 | FROMAFTERQTY | numeric | 否 |
| 12 | TOBEFOREQTY | numeric | 否 |
| 13 | TOAFTERQTY | numeric | 否 |
| 14 | USERNO | nvarchar(64) | 否 |
| 15 | AREANO | nvarchar(30) | 是 |
| 16 | FROMEQUIPMENTSTATE | numeric | 是 |
| 17 | TOEQUIPMENTSTATE | numeric | 是 |
| 18 | EDITDATE | datetime | 是 |
| 19 | Creator | nvarchar(50) | 是 |
| 20 | CreateDate | datetime | 是 |
| 21 | EDITOR | nvarchar(50) | 是 |
| 22 | GUID | nvarchar(50) | 是 |
| 23 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPLOTLOG_REPORT — 生产批日志【报工/历程主表】

> 字段数：45 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 2 | BASELOTNO | nvarchar(50) | 是 |
| 3 | LOTNO | nvarchar(50) | 是 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | STATUS | numeric | 是 |
| 6 | PREOPENDTIME | datetime | 是 |
| 7 | ARRIVETIME | datetime | 是 |
| 8 | STARTTIME | datetime | 是 |
| 9 | ENDTIME | datetime | 是 |
| 10 | INPUTQTY | numeric | 是 |
| 11 | INPUTUNITNO | nvarchar(30) | 是 |
| 12 | GOODQTY | numeric | 是 |
| 13 | FAILQTY | numeric | 是 |
| 14 | GOODUNITNO | nvarchar(30) | 是 |
| 15 | ENGNO | nvarchar(64) | 否 |
| 16 | ENGVERSION | nvarchar(5) | 否 |
| 17 | RECIPENO | nvarchar(300) | 否 |
| 18 | RECIPEVERSION | nvarchar(15) | 否 |
| 19 | RECIPESQL | nvarchar(400) | 否 |
| 20 | NODEID | nvarchar(100) | 否 |
| 21 | FACTORYNO | nvarchar(20) | 否 |
| 22 | MODULESERIAL | nvarchar(50) | 否 |
| 23 | MODULENO | nvarchar(50) | 否 |
| 24 | MODULEVERSION | nvarchar(5) | 否 |
| 25 | PRODUCTNO | nvarchar(50) | 是 |
| 26 | PRODUCTVERSION | nvarchar(5) | 否 |
| 27 | CUSTOMERLOTNO | nvarchar(50) | 是 |
| 28 | DEVICENO | nvarchar(50) | 是 |
| 29 | AREANO | nvarchar(20) | 否 |
| 30 | LOSSQTY | numeric | 是 |
| 31 | COMPLETEFLAG | numeric | 否 |
| 32 | CHECKINTIME | datetime | 是 |
| 33 | CHECKOUTTIME | datetime | 是 |
| 34 | OPGROUPNO | nvarchar(20) | 是 |
| 35 | SERIALNO | nvarchar(50) | 是 |
| 36 | MONO | nvarchar(50) | 是 |
| 37 | PDLINENO | nvarchar(50) | 是 |
| 38 | ERPNo | nvarchar(50) | 是 |
| 39 | DefectQTY | numeric | 否 |
| 40 | EDITDATE | datetime | 是 |
| 41 | Creator | nvarchar(50) | 是 |
| 42 | CreateDate | datetime | 是 |
| 43 | EDITOR | nvarchar(50) | 是 |
| 44 | GUID | nvarchar(50) | 是 |
| 45 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPLOTSTATE — 生产批状态

> 字段数：58 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | BASELOTNO | nvarchar(50) | 否 |
| 3 | ORGLOTNO | nvarchar(50) | 否 |
| 4 | STATUS | numeric | 否 |
| 5 | LOTSERIAL | nvarchar(55) | 否 |
| 6 | AREANO | nvarchar(20) | 否 |
| 7 | PSNO | nvarchar(50) | 否 |
| 8 | PROCESSNO | nvarchar(30) | 是 |
| 9 | OPNO | nvarchar(20) | 否 |
| 10 | NODEID | nvarchar(100) | 否 |
| 11 | CURQTY | numeric | 否 |
| 12 | CURUNITNO | nvarchar(64) | 否 |
| 13 | SYSQTY | numeric | 否 |
| 14 | SYSUNITNO | nvarchar(64) | 否 |
| 15 | BRNO | nvarchar(20) | 否 |
| 16 | PHASENO | numeric | 否 |
| 17 | HAVECOMPONENT | numeric | 否 |
| 18 | HAVELEVEL | numeric | 否 |
| 19 | PSORDER | numeric | 否 |
| 20 | LINKNAME | nvarchar(20) | 是 |
| 21 | REVERSEID | numeric | 是 |
| 22 | EVENTTIME | datetime | 是 |
| 23 | LOTSTAMP | numeric | 否 |
| 24 | GOSTATUS | numeric | 是 |
| 25 | PROCESSVERSION | nvarchar(5) | 否 |
| 26 | NODEVERSION | nvarchar(5) | 否 |
| 27 | MODULENO | nvarchar(50) | 否 |
| 28 | MODULEVERSION | nvarchar(5) | 否 |
| 29 | OPREFERENCE | numeric | 否 |
| 30 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 31 | PREOPENDTIME | datetime | 是 |
| 32 | ARRIVETIME | datetime | 是 |
| 33 | OPSTATUS | numeric | 是 |
| 34 | ENGNO | nvarchar(64) | 否 |
| 35 | ENGVERSION | nvarchar(5) | 否 |
| 36 | RECIPENO | nvarchar(300) | 否 |
| 37 | RECIPEVERSION | nvarchar(15) | 否 |
| 38 | RECIPESQL | nvarchar(400) | 否 |
| 39 | BATCHSERIAL | nvarchar(50) | 是 |
| 40 | MODULESERIAL | nvarchar(50) | 否 |
| 41 | MODULENODEID | nvarchar(100) | 否 |
| 42 | MODULESTAGENO | nvarchar(50) | 否 |
| 43 | MODULESEQUENCE | numeric | 否 |
| 44 | MAINPROCESSNO | nvarchar(64) | 是 |
| 45 | MAINPROCESSVERSION | nvarchar(5) | 是 |
| 46 | EVENTUSERNO | nvarchar(30) | 是 |
| 47 | EVENTDESCRIPTION | nvarchar(255) | 是 |
| 48 | EX_LOTSTATE1 | nvarchar(20) | 是 |
| 49 | EX_LOTSTATE2 | nvarchar(20) | 是 |
| 50 | EX_LOTSTATE3 | nvarchar(20) | 是 |
| 51 | FACTORYNO | nvarchar(20) | 否 |
| 52 | OPGROUPNO | nvarchar(20) | 是 |
| 53 | GOLINKNAME | nvarchar(20) | 是 |
| 54 | PDLINENO | nvarchar(50) | 是 |
| 55 | OPERATETYPE | numeric | 是 |
| 56 | Creator | nvarchar(50) | 是 |
| 57 | CreateDate | datetime | 是 |
| 58 | GUID | nvarchar(50) | 是 |

## TBLWIPMERGECONTENT — 并批内容

> 字段数：28 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FROMLOTNO | nvarchar(50) | 否 |
| 2 | FROMLOTSERIAL | nvarchar(55) | 否 |
| 3 | FROMREVERSEID | numeric | 否 |
| 4 | TOLOTNO | nvarchar(50) | 否 |
| 5 | TOLOTSERIAL | nvarchar(55) | 否 |
| 6 | TOREVERSEID | numeric | 否 |
| 7 | MERGETYPE | numeric | 否 |
| 8 | FROMLOTQTY | numeric | 是 |
| 9 | FROMSCRAPQTY | numeric | 是 |
| 10 | FROMOTHERQTY | numeric | 是 |
| 11 | TOLOTQTY | numeric | 是 |
| 12 | TOSCRAPQTY | numeric | 是 |
| 13 | TOOTHERQTY | numeric | 是 |
| 14 | OPNO | nvarchar(20) | 是 |
| 15 | USERNO | nvarchar(30) | 是 |
| 16 | EVENTTIME | datetime | 是 |
| 17 | REFLOTNO | nvarchar(50) | 是 |
| 18 | FROMBASELOTNO | nvarchar(50) | 是 |
| 19 | TOBASELOTNO | nvarchar(50) | 是 |
| 20 | FROMMONO | nvarchar(50) | 是 |
| 21 | TOMONO | nvarchar(50) | 是 |
| 22 | LotStatus | numeric | 是 |
| 23 | EDITDATE | datetime | 是 |
| 24 | Creator | nvarchar(50) | 是 |
| 25 | CreateDate | datetime | 是 |
| 26 | EDITOR | nvarchar(50) | 是 |
| 27 | GUID | nvarchar(50) | 是 |
| 28 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPOPERATORLOG — 人员上下工时日志

> 字段数：27 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SID | nvarchar(64) | 否 |
| 2 | USERNO | nvarchar(30) | 否 |
| 3 | SHIFTNO | nvarchar(20) | 否 |
| 4 | LOGINDATE | datetime | 否 |
| 5 | LOGOUTDATE | datetime | 否 |
| 6 | EXCEPTIONTIME | numeric | 否 |
| 7 | WORKTIME | numeric | 否 |
| 8 | REALWORKTIME | numeric | 否 |
| 9 | STDWORKTIME | numeric | 否 |
| 10 | QTY | numeric | 否 |
| 11 | WORKDATE | datetime | 否 |
| 12 | OPNO | nvarchar(20) | 否 |
| 13 | MULTIOPERATORMODE | numeric | 否 |
| 14 | LOGINPLACENO | nvarchar(50) | 否 |
| 15 | EVENTTIME | datetime | 是 |
| 16 | POSITIONNO | nvarchar(50) | 否 |
| 17 | SUBOPNO | nvarchar(20) | 否 |
| 18 | EW001 | nvarchar(20) | 是 |
| 19 | EW002 | nvarchar(20) | 是 |
| 20 | EW003 | numeric | 是 |
| 21 | ParameterValue | numeric | 是 |
| 22 | EDITDATE | datetime | 是 |
| 23 | Creator | nvarchar(50) | 是 |
| 24 | CreateDate | datetime | 是 |
| 25 | EDITOR | nvarchar(50) | 是 |
| 26 | GUID | nvarchar(50) | 是 |
| 27 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPOPERATORSTATE — 人员作业现况

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | USERNO | nvarchar(30) | 否 |
| 2 | SHIFTNO | nvarchar(20) | 否 |
| 3 | LOGINDATE | datetime | 否 |
| 4 | WORKDATE | datetime | 否 |
| 5 | OPNO | nvarchar(20) | 否 |
| 6 | MULTIOPERATORMODE | numeric | 否 |
| 7 | LOGINPLACENO | nvarchar(50) | 否 |
| 8 | POSITIONNO | nvarchar(50) | 否 |
| 9 | SUBOPNO | nvarchar(20) | 否 |
| 10 | SID | nvarchar(64) | 否 |
| 11 | ParameterValue | numeric | 是 |
| 12 | Creator | nvarchar(50) | 是 |
| 13 | CreateDate | datetime | 是 |
| 14 | GUID | nvarchar(50) | 是 |

## TBLWIPOSBASIS — 工序段主档

> 字段数：31 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OSNO | nvarchar(20) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | PREPARENAME | nvarchar(30) | 是 |
| 4 | NEEDBYDATE | datetime | 是 |
| 5 | OSQTY | numeric | 否 |
| 6 | STATUS | numeric | 否 |
| 7 | SHPDATE | datetime | 是 |
| 8 | CLOSEDATE | datetime | 是 |
| 9 | PRICE | numeric | 是 |
| 10 | SUBCONTRACTORNO | nvarchar(20) | 是 |
| 11 | NODEID | nvarchar(100) | 是 |
| 12 | OSITEMNO | nvarchar(2) | 是 |
| 13 | RETURNOPNO | nvarchar(20) | 是 |
| 14 | RETURNNODEID | nvarchar(100) | 是 |
| 15 | SHPUSERNO | nvarchar(30) | 是 |
| 16 | CREATOR | nvarchar(50) | 是 |
| 17 | CREATEDATE | datetime | 是 |
| 18 | DESCRIPTION | nvarchar(4000) | 是 |
| 19 | REVISER | nvarchar(50) | 是 |
| 20 | REVISEDATE | datetime | 是 |
| 21 | OSTYPE | numeric | 是 |
| 22 | ERPDOCType | nvarchar(50) | 是 |
| 23 | S_Warehouse_No | nvarchar(50) | 是 |
| 24 | S_Storage_Spaces_No | nvarchar(50) | 是 |
| 25 | DispStartTime | datetime | 是 |
| 26 | DispEndTime | datetime | 是 |
| 27 | ModifyCount | numeric | 否 |
| 28 | ISSUESTATE | numeric | 是 |
| 29 | EDITOR | nvarchar(50) | 是 |
| 30 | EDITDATE | datetime | 是 |
| 31 | GUID | nvarchar(50) | 是 |

## TBLWIPOSDETAIL — 工序段明细

> 字段数：32 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OSNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | RCVDATE | datetime | 是 |
| 4 | STATUS | numeric | 否 |
| 5 | INPUTQTY | numeric | 否 |
| 6 | INPUTUNITNO | nvarchar(30) | 是 |
| 7 | GOODQTY | numeric | 是 |
| 8 | SCRAPQTY | numeric | 是 |
| 9 | OTHERQTY | numeric | 是 |
| 10 | DESCRIPTION | nvarchar(4000) | 是 |
| 11 | UNITPRICE | numeric | 是 |
| 12 | RETURNUNITNO | nvarchar(30) | 是 |
| 13 | RCVUSERNO | nvarchar(30) | 是 |
| 14 | LogGroupSerial | nvarchar(50) | 是 |
| 15 | LOTSEQUENCE | numeric | 否 |
| 16 | SPC_OK | nvarchar(1) | 是 |
| 17 | SPCQTY | numeric | 是 |
| 18 | TEMPINPUTERRQTY | numeric | 是 |
| 19 | BACKQTY | numeric | 否 |
| 20 | TapeoutQTY | numeric | 是 |
| 21 | ExcessQTY | numeric | 否 |
| 22 | LOSSQTY | numeric | 否 |
| 23 | IssueDefectQTY | numeric | 否 |
| 24 | ValuationQTY | numeric | 否 |
| 25 | TURNBACKQTY | numeric | 是 |
| 26 | DAMAGEQTY | numeric | 是 |
| 27 | Creator | nvarchar(50) | 是 |
| 28 | CreateDate | datetime | 是 |
| 29 | EDITOR | nvarchar(50) | 是 |
| 30 | EDITDATE | datetime | 是 |
| 31 | GUID | nvarchar(50) | 是 |
| 32 | OPNO | nvarchar(200) | 是 |

## TBLWIPREWORKREASON — 返工原因

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | REWORKLOTNO | nvarchar(50) | 否 |
| 3 | REASONNO | nvarchar(20) | 否 |
| 4 | EVENTTIME | datetime | 否 |
| 5 | OpNo | nvarchar(50) | 否 |
| 6 | ReworkOpNo | nvarchar(50) | 否 |
| 7 | EquipmentNo | nvarchar(50) | 否 |
| 8 | LotState | numeric | 否 |
| 9 | EDITDATE | datetime | 是 |
| 10 | Creator | nvarchar(50) | 是 |
| 11 | CreateDate | datetime | 是 |
| 12 | EDITOR | nvarchar(50) | 是 |
| 13 | GUID | nvarchar(50) | 是 |
| 14 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPSPLITCONTENT — 分批内容

> 字段数：28 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FROMLOTNO | nvarchar(50) | 否 |
| 2 | FROMLOTSERIAL | nvarchar(55) | 否 |
| 3 | FROMREVERSEID | numeric | 否 |
| 4 | TOLOTNO | nvarchar(50) | 否 |
| 5 | TOLOTSERIAL | nvarchar(55) | 否 |
| 6 | TOREVERSEID | numeric | 否 |
| 7 | SPLITTYPE | numeric | 否 |
| 8 | MAJORLOT | numeric | 否 |
| 9 | FROMLOTQTY | numeric | 是 |
| 10 | FROMSCRAPQTY | numeric | 是 |
| 11 | FROMOTHERQTY | numeric | 是 |
| 12 | TOLOTQTY | numeric | 是 |
| 13 | TOSCRAPQTY | numeric | 是 |
| 14 | TOOTHERQTY | numeric | 是 |
| 15 | OPNO | nvarchar(20) | 是 |
| 16 | USERNO | nvarchar(30) | 是 |
| 17 | EVENTTIME | datetime | 是 |
| 18 | FROMBASELOTNO | nvarchar(50) | 是 |
| 19 | TOBASELOTNO | nvarchar(50) | 是 |
| 20 | FROMMONO | nvarchar(50) | 是 |
| 21 | TOMONO | nvarchar(50) | 是 |
| 22 | LotStatus | numeric | 是 |
| 23 | EDITDATE | datetime | 是 |
| 24 | Creator | nvarchar(50) | 是 |
| 25 | CreateDate | datetime | 是 |
| 26 | EDITOR | nvarchar(50) | 是 |
| 27 | GUID | nvarchar(50) | 是 |
| 28 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPSUBOPLOG_REPORT — 子作业报工日志

> 字段数：17 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | SUBOPNO | nvarchar(20) | 否 |
| 5 | STATUS | numeric | 否 |
| 6 | STARTTIME | datetime | 是 |
| 7 | ENDTIME | datetime | 是 |
| 8 | GOODQTY | numeric | 否 |
| 9 | SCRAPQTY | numeric | 否 |
| 10 | EXCESSQTY | numeric | 否 |
| 11 | LACKQTY | numeric | 否 |
| 12 | CREATOR | nvarchar(50) | 是 |
| 13 | CREATEDATE | datetime | 是 |
| 14 | EDITDATE | datetime | 是 |
| 15 | EDITOR | nvarchar(50) | 是 |
| 16 | GUID | nvarchar(50) | 是 |
| 17 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPWAITBASIS — 等待/暂停主档

> 字段数：41 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | WAITNO | nvarchar(20) | 否 |
| 2 | BASELOTNO | nvarchar(50) | 否 |
| 3 | LOTNO | nvarchar(50) | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 否 |
| 5 | WAITSOURCE | numeric | 否 |
| 6 | WAITTYPE | numeric | 否 |
| 7 | WAITTIME | numeric | 是 |
| 8 | STATUS | numeric | 否 |
| 9 | LOTISVALID | numeric | 否 |
| 10 | OPNO | nvarchar(20) | 否 |
| 11 | CREATEQTY | numeric | 否 |
| 12 | UNITNO | nvarchar(30) | 否 |
| 13 | CREATOR | nvarchar(50) | 是 |
| 14 | CREATEDATE | datetime | 是 |
| 15 | CUSTOMERNO | nvarchar(50) | 是 |
| 16 | PRODUCTNO | nvarchar(50) | 是 |
| 17 | CREATEDEPARTMENTNO | nvarchar(20) | 是 |
| 18 | RULENO | nvarchar(20) | 是 |
| 19 | WAITDESCRIPTION | nvarchar(3000) | 是 |
| 20 | MODULESERIAL | nvarchar(50) | 否 |
| 21 | MODULENO | nvarchar(50) | 否 |
| 22 | MODULEVERSION | nvarchar(5) | 否 |
| 23 | MODULENODEID | nvarchar(100) | 否 |
| 24 | MODULESTAGENO | nvarchar(50) | 否 |
| 25 | RELEASEQTY | numeric | 是 |
| 26 | RELEASER | nvarchar(30) | 是 |
| 27 | RELEASEDATE | datetime | 是 |
| 28 | CONTLOGGROUPSERIAL | nvarchar(50) | 是 |
| 29 | BATCHWAITNO | nvarchar(20) | 是 |
| 30 | MONO | nvarchar(50) | 是 |
| 31 | EQUIPMENTNO | nvarchar(50) | 是 |
| 32 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 33 | ReworkFlag | numeric | 否 |
| 34 | WAITCOUNTERORG | numeric | 否 |
| 35 | WAITCOUNTERCOMMIT | numeric | 否 |
| 36 | WAITLOTSTATUS | numeric | 否 |
| 37 | INVROLLBACKFLAG | numeric | 否 |
| 38 | ISSUESTATE | numeric | 是 |
| 39 | EDITOR | nvarchar(50) | 是 |
| 40 | EDITDATE | datetime | 是 |
| 41 | GUID | nvarchar(50) | 是 |

## TBLWIPWAITLOTDISPOSITION — 等待批处置

> 字段数：19 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-21）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | WAITNO | nvarchar(20) | 否 |
| 2 | LOTSERIAL | nvarchar(55) | 否 |
| 3 | LOTDISPTYPE | numeric | 否 |
| 4 | CREATOR | nvarchar(50) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | DESCRIPTION | nvarchar(4000) | 是 |
| 7 | NODEID | nvarchar(100) | 是 |
| 8 | INVENTORYNO | nvarchar(50) | 是 |
| 9 | RETURNTYPE | numeric | 是 |
| 10 | RETURNNODEID | nvarchar(100) | 是 |
| 11 | MODULENO | nvarchar(50) | 是 |
| 12 | MODULEVERSION | nvarchar(5) | 是 |
| 13 | STARTNODEID | nvarchar(100) | 是 |
| 14 | LOTNO | nvarchar(50) | 是 |
| 15 | EVENTID | nvarchar(100) | 是 |
| 16 | EDITDATE | datetime | 是 |
| 17 | EDITOR | nvarchar(50) | 是 |
| 18 | GUID | nvarchar(50) | 是 |
| 19 | ORIGINGUID | nvarchar(50) | 是 |
