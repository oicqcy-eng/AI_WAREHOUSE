# smes-621 补录：INV 库存/进出库（真·生产独有 43 表）

> **定位**：2026-08-23 批量补录 —— 设计文档《SMES_621数据库设计文档20250313.html》与主字典（01~08）均未覆盖的**真·生产独有**表（仅存于生产库，断连无结构可查）。本次按 8 个业务核心前缀（WIP/PRD/INV/QC/EQP/OP/USR/OEM）分 7 个补录文件批量连库拉取。
> **来源**：连库实测 `INFORMATION_SCHEMA.COLUMNS`（profile `home`，192.168.200.18/sMES_Home_Prod，2026-08-23），7 文件共 **320 表 / 3209 列**。
> **说明**：字段结构断连可查；表级说明为**表名英文词根直译**，仅辅助检索识别，非正式中文语义（个别表若在 [09-core-ops-补录.md](09-core-ops-补录.md) 已有语义备注可交叉对照）。
> **衔接**：主字典 01~08（192 表）｜核心查询补录 [09-core-ops-补录.md](09-core-ops-补录.md)（68 表）｜本文件及 10~16（320 表）｜全量 1472 表分层见 [sMES全量表清单.md](../smes-621-sql/sMES全量表清单.md)。

本文件 43 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| `TBLINVENGINEERGROUPBASIS` | 库存工程进EER群组主档 | 5 |
| `TBLINVFGDINCOMPONENT` | 库存FGD进COMPONENT | 6 |
| `tblINVFGDInDetail_PCSNo` | 库存FGD进明细_PCS序号编号 | 6 |
| `TBLINVFGDINVENTORYCOMPONENT` | 库存FGD库存EN至RYCOMPONENT | 8 |
| `TBLINVFGDINVENTORYCOMPONENTLOG` | 库存FGD库存EN至RYCOMPONENT历程 | 9 |
| `TBLINVFGDINVENTORYLOG` | 库存FGD库存EN至RY历程 | 10 |
| `TBLINVMATERIALADJUSTBASIS` | 库存物料调整主档 | 6 |
| `TBLINVMATERIALADJUSTDETAIL` | 库存物料调整明细 | 8 |
| `TBLINVMATERIALINBASIS` | 库存物料进主档 | 7 |
| `TBLINVMATERIALINDETAIL` | 库存物料进明细 | 8 |
| `TBLINVMATERIALOUTBASIS` | 库存物料出主档 | 7 |
| `TBLINVMATERIALOUTDETAIL` | 库存物料出明细 | 8 |
| `TBLINVMATERIALRETURNBASIS` | 库存物料退回主档 | 8 |
| `TBLINVMATERIALRETURNDETAIL` | 库存物料退回明细 | 6 |
| `TBLINVMATERIALWIPRETURNBASIS` | 库存物料在制品退回主档 | 9 |
| `TBLINVMATERIALWIPRETURNDETAIL` | 库存物料在制品退回明细 | 6 |
| `TBLINVPREORDERBASIS` | 库存PRE订单/顺序主档 | 6 |
| `TBLINVPREORDERDETAIL` | 库存PRE订单/顺序明细 | 4 |
| `TBLINVRAWINVENTORY` | 库存RAW库存EN至RY | 6 |
| `TBLINVRAWINVENTORYLOC` | 库存RAW库存EN至RY储位 | 6 |
| `TBLINVSCRINCOMPONENT` | 库存SCR进COMPONENT | 7 |
| `TBLINVSCRINFAILBIN` | 库存SCR进不良分箱/容器 | 11 |
| `TBLINVSCRINVENTORYCOMPONENT` | 库存SCR库存EN至RYCOMPONENT | 8 |
| `TBLINVSCRINVENTORYFAILBIN` | 库存SCR库存EN至RY不良分箱/容器 | 11 |
| `TBLINVSEMIINBASIS` | 库存半进主档 | 11 |
| `TBLINVSEMIINCOMPONENT` | 库存半进COMPONENT | 6 |
| `TBLINVSEMIINDETAIL` | 库存半进明细 | 8 |
| `TBLINVSEMIINVENTORY` | 库存半库存EN至RY | 11 |
| `TBLINVSEMIINVENTORYCOMPONENT` | 库存半库存EN至RYCOMPONENT | 8 |
| `TBLINVSEMIOUTBASIS` | 库存半出主档 | 6 |
| `TBLINVSEMIOUTCOMPONENT` | 库存半出COMPONENT | 6 |
| `TBLINVSEMIOUTDETAIL` | 库存半出明细 | 8 |
| `TBLINVTRANSACTIONLOG` | 库存事务/交易历程 | 5 |
| `TBLINVTRANSACTIONSTATE` | 库存事务/交易状态 | 5 |
| `TBLINVWIP_COMPONENTSCRAP` | 库存在制品_COMPONENT报废 | 11 |
| `TBLINVWIP_FAILBIN` | 库存在制品_不良分箱/容器 | 16 |
| `TBLINVWIP_INCOMING` | 库存在制品_进CO最小G | 15 |
| `TBLINVWIP_INCOMING_COMP` | 库存在制品_进CO最小G_COMP | 4 |
| `TBLINVWIP_MOENTRUST` | 库存在制品_工单ENTRUST | 5 |
| `TBLINVWIP_MORETURN` | 库存在制品_工单退回 | 5 |
| `TBLINVWIP_RAW_SCRAPERROR` | 库存在制品_RAW_报废错误 | 3 |
| `TBLINVWIP_RAW_SCRAPLOG` | 库存在制品_RAW_报废历程 | 9 |
| `TBLINVWIPINVENTORY_COMPONENT` | 库存在制品库存EN至RY_COMPONENT | 7 |

## TBLINVENGINEERGROUPBASIS — 库存工程进EER群组主档

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ENGINEERGROUPNO | nvarchar(20) | 否 |
| 2 | ENGINEERGROUPNAME | nvarchar(50) | 是 |
| 3 | DESCRIPTION | nvarchar(255) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |

## TBLINVFGDINCOMPONENT — 库存FGD进COMPONENT

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FGDINNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | COMPONENTNO | nvarchar(30) | 否 |
| 4 | GOODQTY | numeric | 是 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | UNITNO | nvarchar(30) | 是 |

## tblINVFGDInDetail_PCSNo — 库存FGD进明细_PCS序号编号

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FGDInNo | nvarchar(20) | 否 |
| 2 | ProductNo | nvarchar(50) | 否 |
| 3 | ProductVersion | nvarchar(50) | 否 |
| 4 | LotNo | nvarchar(50) | 否 |
| 5 | OPNo | nvarchar(20) | 否 |
| 6 | PCSNo | nvarchar(50) | 否 |

## TBLINVFGDINVENTORYCOMPONENT — 库存FGD库存EN至RYCOMPONENT

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOCATORNO | nvarchar(20) | 否 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | GOODQTY | numeric | 是 |
| 6 | SCRAPQTY | numeric | 是 |
| 7 | UNITNO | nvarchar(30) | 是 |
| 8 | BOOKINGFLAG | numeric | 是 |

## TBLINVFGDINVENTORYCOMPONENTLOG — 库存FGD库存EN至RYCOMPONENT历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOCATORNO | nvarchar(20) | 否 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | GOODQTY | numeric | 是 |
| 6 | SCRAPQTY | numeric | 是 |
| 7 | UNITNO | nvarchar(30) | 是 |
| 8 | BOOKINGFLAG | numeric | 是 |
| 9 | CREATEDATE | datetime | 否 |

## TBLINVFGDINVENTORYLOG — 库存FGD库存EN至RY历程

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | PRODUCTNO | nvarchar(50) | 是 |
| 3 | UNITNO | nvarchar(30) | 是 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | LOCATORNO | nvarchar(20) | 否 |
| 6 | LOCQTY | numeric | 否 |
| 7 | BELONGTOTYPE | numeric | 是 |
| 8 | BELONGTONO | nvarchar(50) | 是 |
| 9 | INPUTDATE | datetime | 是 |
| 10 | BASELOTNO | nvarchar(50) | 是 |

## TBLINVMATERIALADJUSTBASIS — 库存物料调整主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALADJUSTNO | nvarchar(20) | 否 |
| 2 | INVENTORYNO | nvarchar(20) | 是 |
| 3 | STATE | numeric | 否 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 否 |

## TBLINVMATERIALADJUSTDETAIL — 库存物料调整明细

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALADJUSTNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | UNITNO | nvarchar(30) | 是 |
| 5 | ORGQTY | numeric | 否 |
| 6 | FINALQTY | numeric | 否 |
| 7 | LOCATORNO | nvarchar(20) | 否 |
| 8 | DIFFQTY | numeric | 是 |

## TBLINVMATERIALINBASIS — 库存物料进主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALINNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | DESCRIPTION | nvarchar(255) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 否 |
| 6 | INVENTORYNO | nvarchar(20) | 是 |
| 7 | VENDORNO | nvarchar(20) | 是 |

## TBLINVMATERIALINDETAIL — 库存物料进明细

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALINNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | UNITNO | nvarchar(30) | 是 |
| 5 | QTY | numeric | 否 |
| 6 | LOCATORNO | nvarchar(20) | 否 |
| 7 | LIMITTIME | numeric | 否 |
| 8 | QCFORMNO | nvarchar(30) | 是 |

## TBLINVMATERIALOUTBASIS — 库存物料出主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALOUTNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | PREORDERNO | nvarchar(20) | 是 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | INVENTORYNO | nvarchar(20) | 是 |

## TBLINVMATERIALOUTDETAIL — 库存物料出明细

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALOUTNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | LOCATORNO | nvarchar(20) | 否 |
| 5 | PUTINPLACETYPE | numeric | 否 |
| 6 | PUTINPLACENO | nvarchar(50) | 否 |
| 7 | UNITNO | nvarchar(30) | 是 |
| 8 | QTY | numeric | 否 |

## TBLINVMATERIALRETURNBASIS — 库存物料退回主档

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALRETURNNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | INVENTORYNO | nvarchar(20) | 是 |
| 4 | VENDORNO | nvarchar(20) | 是 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 否 |
| 8 | RETURNDATE | datetime | 是 |

## TBLINVMATERIALRETURNDETAIL — 库存物料退回明细

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALRETURNNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | LOCATORNO | nvarchar(20) | 否 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | QTY | numeric | 否 |

## TBLINVMATERIALWIPRETURNBASIS — 库存物料在制品退回主档

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALRETURNNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | INVENTORYNO | nvarchar(20) | 是 |
| 4 | FROMINVENTORYNO | nvarchar(20) | 是 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 否 |
| 8 | RETURNDATE | datetime | 是 |
| 9 | FROMPLACETYPE | numeric | 是 |

## TBLINVMATERIALWIPRETURNDETAIL — 库存物料在制品退回明细

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MATERIALRETURNNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | LOCATORNO | nvarchar(20) | 否 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | QTY | numeric | 否 |

## TBLINVPREORDERBASIS — 库存PRE订单/顺序主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PREORDERNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | INVENTORYNO | nvarchar(20) | 是 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |

## TBLINVPREORDERDETAIL — 库存PRE订单/顺序明细

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PREORDERNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | UNITNO | nvarchar(30) | 是 |
| 4 | QTY | numeric | 否 |

## TBLINVRAWINVENTORY — 库存RAW库存EN至RY

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | SAFEQTY | numeric | 否 |
| 4 | CURQTY | numeric | 否 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | ALLOCATEQTY | numeric | 否 |

## TBLINVRAWINVENTORYLOC — 库存RAW库存EN至RY储位

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOCATORNO | nvarchar(20) | 否 |
| 3 | MATERIALNO | nvarchar(50) | 否 |
| 4 | MATERIALLOTNO | nvarchar(50) | 否 |
| 5 | LOCQTY | numeric | 否 |
| 6 | INPUTDATE | datetime | 是 |

## TBLINVSCRINCOMPONENT — 库存SCR进COMPONENT

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SCRINNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | GOODQTY | numeric | 是 |
| 7 | UNITNO | nvarchar(30) | 是 |

## TBLINVSCRINFAILBIN — 库存SCR进不良分箱/容器

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SCRINNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | BIN1 | numeric | 是 |
| 5 | BIN2 | numeric | 是 |
| 6 | BIN3 | numeric | 是 |
| 7 | BIN4 | numeric | 是 |
| 8 | BIN5 | numeric | 是 |
| 9 | BIN6 | numeric | 是 |
| 10 | BIN7 | numeric | 是 |
| 11 | BIN8 | numeric | 是 |

## TBLINVSCRINVENTORYCOMPONENT — 库存SCR库存EN至RYCOMPONENT

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | GOODQTY | numeric | 是 |
| 7 | UNITNO | nvarchar(30) | 是 |
| 8 | BOOKINGFLAG | numeric | 是 |

## TBLINVSCRINVENTORYFAILBIN — 库存SCR库存EN至RY不良分箱/容器

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | BIN1 | numeric | 是 |
| 5 | BIN2 | numeric | 是 |
| 6 | BIN3 | numeric | 是 |
| 7 | BIN4 | numeric | 是 |
| 8 | BIN5 | numeric | 是 |
| 9 | BIN6 | numeric | 是 |
| 10 | BIN7 | numeric | 是 |
| 11 | BIN8 | numeric | 是 |

## TBLINVSEMIINBASIS — 库存半进主档

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SEMIINNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | DESCRIPTION | nvarchar(255) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 否 |
| 6 | INVENTORYNO | nvarchar(20) | 是 |
| 7 | INPUTDATE | datetime | 是 |
| 8 | SOURCE | numeric | 否 |
| 9 | FROMINVENTORYNO | nvarchar(20) | 是 |
| 10 | REVISER | nvarchar(10) | 是 |
| 11 | REVISEDATE | datetime | 是 |

## TBLINVSEMIINCOMPONENT — 库存半进COMPONENT

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SEMIINNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | COMPONENTNO | nvarchar(30) | 否 |
| 4 | GOODQTY | numeric | 是 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | UNITNO | nvarchar(30) | 是 |

## TBLINVSEMIINDETAIL — 库存半进明细

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SEMIINNO | nvarchar(20) | 否 |
| 2 | PRODUCTNO | nvarchar(50) | 是 |
| 3 | PRODUCTVERSION | nvarchar(5) | 是 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | QTY | numeric | 否 |
| 6 | UNITNO | nvarchar(30) | 是 |
| 7 | LOCATORNO | nvarchar(20) | 否 |
| 8 | BASELOTNO | nvarchar(50) | 是 |

## TBLINVSEMIINVENTORY — 库存半库存EN至RY

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | PRODUCTNO | nvarchar(50) | 是 |
| 3 | UNITNO | nvarchar(30) | 是 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | LOCATORNO | nvarchar(20) | 否 |
| 6 | LOCQTY | numeric | 否 |
| 7 | BELONGTOTYPE | numeric | 是 |
| 8 | BELONGTONO | nvarchar(50) | 是 |
| 9 | INPUTDATE | datetime | 是 |
| 10 | BASELOTNO | nvarchar(50) | 是 |
| 11 | SEMIINNO | nvarchar(20) | 是 |

## TBLINVSEMIINVENTORYCOMPONENT — 库存半库存EN至RYCOMPONENT

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOCATORNO | nvarchar(20) | 否 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | GOODQTY | numeric | 是 |
| 6 | SCRAPQTY | numeric | 是 |
| 7 | UNITNO | nvarchar(30) | 是 |
| 8 | BOOKINGFLAG | numeric | 是 |

## TBLINVSEMIOUTBASIS — 库存半出主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SEMIOUTNO | nvarchar(20) | 否 |
| 2 | STATE | numeric | 否 |
| 3 | DESCRIPTION | nvarchar(255) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | INVENTORYNO | nvarchar(20) | 是 |

## TBLINVSEMIOUTCOMPONENT — 库存半出COMPONENT

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SEMIOUTNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | COMPONENTNO | nvarchar(30) | 否 |
| 4 | GOODQTY | numeric | 是 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | UNITNO | nvarchar(30) | 是 |

## TBLINVSEMIOUTDETAIL — 库存半出明细

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SEMIOUTNO | nvarchar(20) | 否 |
| 2 | PRODUCTNO | nvarchar(50) | 是 |
| 3 | LOTNO | nvarchar(50) | 否 |
| 4 | LOCATORNO | nvarchar(20) | 否 |
| 5 | PUTINPLACETYPE | numeric | 否 |
| 6 | PUTINPLACENO | nvarchar(50) | 是 |
| 7 | UNITNO | nvarchar(30) | 是 |
| 8 | QTY | numeric | 否 |

## TBLINVTRANSACTIONLOG — 库存事务/交易历程

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | TRANSACTIONID | nvarchar(50) | 否 |
| 2 | SOURCE | numeric | 否 |
| 3 | TICKETNO | nvarchar(20) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 否 |

## TBLINVTRANSACTIONSTATE — 库存事务/交易状态

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | TRANSACTIONID | nvarchar(50) | 否 |
| 2 | SOURCE | numeric | 否 |
| 3 | TICKETNO | nvarchar(20) | 是 |
| 4 | CREATOR | nvarchar(30) | 否 |
| 5 | CREATEDATE | datetime | 否 |

## TBLINVWIP_COMPONENTSCRAP — 库存在制品_COMPONENT报废

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTSERIAL | nvarchar(55) | 否 |
| 3 | LOTNO | nvarchar(50) | 是 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | OPNO | nvarchar(20) | 是 |
| 6 | UNITNO | nvarchar(30) | 是 |
| 7 | GOODQTY | numeric | 否 |
| 8 | SCRAPQTY | numeric | 否 |
| 9 | BASELOTNO | nvarchar(50) | 是 |
| 10 | INPUTDATE | datetime | 是 |
| 11 | BOOKINGFLAG | numeric | 否 |

## TBLINVWIP_FAILBIN — 库存在制品_不良分箱/容器

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | BASELOTNO | nvarchar(50) | 是 |
| 7 | INPUTDATE | datetime | 是 |
| 8 | BOOKINGFLAG | numeric | 否 |
| 9 | BIN1 | numeric | 是 |
| 10 | BIN2 | numeric | 是 |
| 11 | BIN3 | numeric | 是 |
| 12 | BIN4 | numeric | 是 |
| 13 | BIN5 | numeric | 是 |
| 14 | BIN6 | numeric | 是 |
| 15 | BIN7 | numeric | 是 |
| 16 | BIN8 | numeric | 是 |

## TBLINVWIP_INCOMING — 库存在制品_进CO最小G

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 是 |
| 2 | LOTSERIAL | nvarchar(55) | 否 |
| 3 | LOTNO | nvarchar(50) | 是 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | QTY | numeric | 否 |
| 7 | BASELOTNO | nvarchar(50) | 是 |
| 8 | INPUTDATE | datetime | 是 |
| 9 | FROMBUNO | nvarchar(50) | 是 |
| 10 | PRODUCTNO | nvarchar(50) | 是 |
| 11 | PRODUCTVERSION | nvarchar(5) | 是 |
| 12 | CUSTOMERNO | nvarchar(50) | 是 |
| 13 | PRIORITY | numeric | 是 |
| 14 | MOTYPENO | numeric | 是 |
| 15 | RELEASESTATE | numeric | 是 |

## TBLINVWIP_INCOMING_COMP — 库存在制品_进CO最小G_COMP

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 否 |
| 2 | COMPONENTNO | nvarchar(30) | 否 |
| 3 | GOODQTY | numeric | 是 |
| 4 | UNITNO | nvarchar(30) | 是 |

## TBLINVWIP_MOENTRUST — 库存在制品_工单ENTRUST

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | MONO | nvarchar(50) | 否 |
| 3 | CUSTOMERNO | nvarchar(50) | 是 |
| 4 | PRODUCTNO | nvarchar(50) | 是 |
| 5 | MOQTY | numeric | 是 |

## TBLINVWIP_MORETURN — 库存在制品_工单退回

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | MONO | nvarchar(50) | 是 |
| 3 | CUSTOMERNO | nvarchar(50) | 是 |
| 4 | PRODUCTNO | nvarchar(50) | 是 |
| 5 | MOQTY | numeric | 是 |

## TBLINVWIP_RAW_SCRAPERROR — 库存在制品_RAW_报废错误

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SERIALNO | nvarchar(20) | 否 |
| 2 | ERRORNO | nvarchar(20) | 否 |
| 3 | ERRORQTY | numeric | 是 |

## TBLINVWIP_RAW_SCRAPLOG — 库存在制品_RAW_报废历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SERIALNO | nvarchar(20) | 否 |
| 2 | INVENTORYNO | nvarchar(20) | 是 |
| 3 | MATERIALNO | nvarchar(50) | 是 |
| 4 | MATERIALLOTNO | nvarchar(50) | 是 |
| 5 | SCRAPQTY | numeric | 否 |
| 6 | UNITNO | nvarchar(30) | 是 |
| 7 | USERNO | nvarchar(30) | 是 |
| 8 | EVENTTIME | datetime | 否 |
| 9 | DESCRIPTION | nvarchar(255) | 是 |

## TBLINVWIPINVENTORY_COMPONENT — 库存在制品库存EN至RY_COMPONENT

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | INVENTORYNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | COMPONENTNO | nvarchar(30) | 否 |
| 4 | GOODQTY | numeric | 是 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | UNITNO | nvarchar(30) | 是 |
| 7 | BOOKINGFLAG | numeric | 是 |

