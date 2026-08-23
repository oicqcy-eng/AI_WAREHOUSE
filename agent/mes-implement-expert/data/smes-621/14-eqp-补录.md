# smes-621 补录：EQP 设备/模治具（真·生产独有 24 表）

> **定位**：2026-08-23 批量补录 —— 设计文档《SMES_621数据库设计文档20250313.html》与主字典（01~08）均未覆盖的**真·生产独有**表（仅存于生产库，断连无结构可查）。本次按 8 个业务核心前缀（WIP/PRD/INV/QC/EQP/OP/USR/OEM）分 7 个补录文件批量连库拉取。
> **来源**：连库实测 `INFORMATION_SCHEMA.COLUMNS`（profile `home`，192.168.200.18/sMES_Home_Prod，2026-08-23），7 文件共 **320 表 / 3209 列**。
> **说明**：字段结构断连可查；表级说明为**表名英文词根直译**，仅辅助检索识别，非正式中文语义（个别表若在 [09-core-ops-补录.md](09-core-ops-补录.md) 已有语义备注可交叉对照）。
> **衔接**：主字典 01~08（192 表）｜核心查询补录 [09-core-ops-补录.md](09-core-ops-补录.md)（68 表）｜本文件及 10~16（320 表）｜全量 1472 表分层见 [sMES全量表清单.md](../smes-621-sql/sMES全量表清单.md)。

本文件 24 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| `TBLEQPACCCATEGORYSTATEBASIS` | 设备ACC类别状态主档 | 11 |
| `TBLEQPCARRIERBASIS` | 设备载具主档 | 7 |
| `TBLEQPCARRIERCATEGORY` | 设备载具类别 | 5 |
| `TBLEQPCARRIERTYPE` | 设备载具类型 | 10 |
| `TBLEQPCOMPCYCLEBASIS` | 设备COMP周期主档 | 8 |
| `TBLEQPCONSUMEBASIS` | 设备耗用主档 | 8 |
| `TBLEQPCYCLEBASIS` | 设备周期主档 | 6 |
| `TBLEQPEQUIPMENTTYPEACCTYPE` | 设备设备类型ACC类型 | 2 |
| `TBLEQPFAVORITE` | 设备FAVORITE | 3 |
| `TBLEQPLOCATORDETAIL` | 设备储位A至R明细 | 9 |
| `TBLEQPLOCATORDETAILLOG` | 设备储位A至R明细历程 | 13 |
| `TBLEQPLOCATORSTATUS` | 设备储位A至RSTATUS | 4 |
| `TBLEQPMASKGROUPBASIS` | 设备网版/遮罩群组主档 | 4 |
| `TBLEQPMASKGROUPDETAIL` | 设备网版/遮罩群组明细 | 2 |
| `TBLEQPMTTRSUMMARY` | 设备MTTRSUMMARY | 9 |
| `tblEQPParameterBasis` | 设备参数主档 | 8 |
| `TBLEQPRECIPEBASIS` | 设备配方/参数主档 | 7 |
| `TBLEQPRECIPEDETAIL` | 设备配方/参数明细 | 10 |
| `TBLEQPREDICLESETBASIS` | 设备REDICLESET主档 | 7 |
| `TBLEQPREDICLESETLAYER` | 设备REDICLESETLAYER | 4 |
| `TBLEQPRETICLESETBASIS` | 设备RETICLESET主档 | 7 |
| `TBLEQPRETICLESETLAYER` | 设备RETICLESETLAYER | 4 |
| `TBLEQPSTOCKERBASIS` | 设备仓储柜主档 | 12 |
| `TBLEQPTOOLBASIS` | 设备工装/刀具主档 | 6 |

## TBLEQPACCCATEGORYSTATEBASIS — 设备ACC类别状态主档

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ACCESSORYCATEGORY | nvarchar(50) | 否 |
| 2 | ACCESSORYSTATE | numeric | 否 |
| 3 | ACCESSORYSTATENAME | nvarchar(50) | 是 |
| 4 | INITIALFLAG | numeric | 否 |
| 5 | ISSUESTATE | numeric | 否 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | CREATOR | nvarchar(30) | 是 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | OPERATIONNAME | nvarchar(50) | 否 |
| 10 | INTERFACENAME | nvarchar(50) | 是 |
| 11 | EXECUTIONFILE | nvarchar(50) | 是 |

## TBLEQPCARRIERBASIS — 设备载具主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CARRIERNO | nvarchar(50) | 否 |
| 2 | CARRIERCATEGORY | nvarchar(50) | 是 |
| 3 | CARRIERTYPE | nvarchar(50) | 是 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | ISSUESTATE | numeric | 否 |

## TBLEQPCARRIERCATEGORY — 设备载具类别

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CARRIERCATEGORY | nvarchar(50) | 否 |
| 2 | DESCRIPTION | nvarchar(255) | 是 |
| 3 | CREATOR | nvarchar(30) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | ISSUESTATE | numeric | 否 |

## TBLEQPCARRIERTYPE — 设备载具类型

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CARRIERTYPE | nvarchar(50) | 否 |
| 2 | CARRIERCATEGORY | nvarchar(50) | 是 |
| 3 | USELAYER | numeric | 否 |
| 4 | CARRIERLAYER | numeric | 是 |
| 5 | CARRIERCAPACITY | numeric | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | CREATOR | nvarchar(30) | 是 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | ISSUESTATE | numeric | 否 |
| 10 | STARTPOSITION | numeric | 是 |

## TBLEQPCOMPCYCLEBASIS — 设备COMP周期主档

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTNO | nvarchar(50) | 否 |
| 2 | WAFERSIZE | numeric | 否 |
| 3 | CYCLENO | nvarchar(25) | 否 |
| 4 | WAFERCONTENT | nvarchar(500) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | REVISOR | nvarchar(30) | 是 |
| 8 | REVISEDATE | datetime | 是 |

## TBLEQPCONSUMEBASIS — 设备耗用主档

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTTYPE | nvarchar(25) | 否 |
| 2 | CONSUMENO | nvarchar(25) | 否 |
| 3 | QUANTITY | numeric | 否 |
| 4 | TOLERANCEQTY | numeric | 否 |
| 5 | PERIOD | numeric | 否 |
| 6 | TOLERANCEPERIOD | numeric | 否 |
| 7 | CREATOR | nvarchar(30) | 是 |
| 8 | CREATEDATE | datetime | 是 |

## TBLEQPCYCLEBASIS — 设备周期主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CYCLENO | nvarchar(25) | 否 |
| 2 | CYCLENAME | nvarchar(25) | 是 |
| 3 | CREATOR | nvarchar(30) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | REVISOR | nvarchar(30) | 是 |
| 6 | REVISEDATE | datetime | 是 |

## TBLEQPEQUIPMENTTYPEACCTYPE — 设备设备类型ACC类型

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTTYPE | nvarchar(50) | 否 |
| 2 | ACCESSORYTYPE | nvarchar(50) | 否 |

## TBLEQPFAVORITE — 设备FAVORITE

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | HOSTID | nvarchar(50) | 是 |
| 2 | PAGENO | nvarchar(50) | 是 |
| 3 | EQUIPMENTNO | nvarchar(50) | 是 |

## TBLEQPLOCATORDETAIL — 设备储位A至R明细

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOCATORNO | nvarchar(20) | 否 |
| 2 | CONTENTNO | nvarchar(50) | 否 |
| 3 | CONTENTQTY | numeric | 是 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | AREANO | nvarchar(20) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | LOTNO | nvarchar(50) | 是 |
| 9 | CARRIERNO | nvarchar(50) | 是 |

## TBLEQPLOCATORDETAILLOG — 设备储位A至R明细历程

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SRCSTOCKERNO | nvarchar(20) | 是 |
| 2 | DESSTOCKERNO | nvarchar(20) | 是 |
| 3 | SRCLOCATORNO | nvarchar(20) | 是 |
| 4 | DESLOCATORNO | nvarchar(20) | 是 |
| 5 | CONTENTNO | nvarchar(50) | 是 |
| 6 | CONTENTQTY | numeric | 是 |
| 7 | OPNO | nvarchar(20) | 是 |
| 8 | AREANO | nvarchar(20) | 是 |
| 9 | STATUS | nvarchar(255) | 是 |
| 10 | CREATOR | nvarchar(30) | 是 |
| 11 | CREATEDATE | datetime | 是 |
| 12 | LOTNO | nvarchar(50) | 是 |
| 13 | CARRIERNO | nvarchar(50) | 是 |

## TBLEQPLOCATORSTATUS — 设备储位A至RSTATUS

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | STOCKERNO | nvarchar(20) | 是 |
| 2 | LOCATORNO | nvarchar(20) | 否 |
| 3 | HAVECONTENT | numeric | 否 |
| 4 | CONTENTTYPE | numeric | 否 |

## TBLEQPMASKGROUPBASIS — 设备网版/遮罩群组主档

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MASKGROUP | nvarchar(50) | 否 |
| 2 | DESCRIPTION | nvarchar(255) | 是 |
| 3 | CREATOR | nvarchar(30) | 是 |
| 4 | CREATEDATE | datetime | 是 |

## TBLEQPMASKGROUPDETAIL — 设备网版/遮罩群组明细

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MASKGROUP | nvarchar(50) | 否 |
| 2 | MASKID | nvarchar(50) | 否 |

## TBLEQPMTTRSUMMARY — 设备MTTRSUMMARY

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | AREANO | nvarchar(50) | 是 |
| 2 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 3 | EQUIPMENTNO | nvarchar(50) | 否 |
| 4 | COLYEAR | numeric | 否 |
| 5 | COLMONTH | numeric | 否 |
| 6 | BREAKDOWNTIMES | numeric | 是 |
| 7 | MTTR | numeric | 是 |
| 8 | MTBF | numeric | 是 |
| 9 | AVAILABILITY | numeric | 是 |

## tblEQPParameterBasis — 设备参数主档

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EquipmentNo | nvarchar(50) | 否 |
| 2 | SeqNo | numeric | 否 |
| 3 | ParameterNo | nvarchar(20) | 否 |
| 4 | SpecType | numeric | 否 |
| 5 | ParameterValue | numeric | 是 |
| 6 | REVISER | nvarchar(10) | 否 |
| 7 | REVISEDATE | datetime | 否 |
| 8 | EQPParamDate | datetime | 是 |

## TBLEQPRECIPEBASIS — 设备配方/参数主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPEGROUP | nvarchar(50) | 否 |
| 2 | RECIPEVERSION | numeric | 否 |
| 3 | DESCRIPTION | nvarchar(255) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | ISSUESTATE | numeric | 是 |
| 7 | CURVERSION | numeric | 否 |

## TBLEQPRECIPEDETAIL — 设备配方/参数明细

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPEGROUP | nvarchar(50) | 否 |
| 2 | RECIPEVERSION | numeric | 否 |
| 3 | RECIPENO | nvarchar(20) | 否 |
| 4 | RECIPEVALUE | nvarchar(255) | 是 |
| 5 | SEQUENCE | numeric | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | TYPE | numeric | 是 |
| 8 | STDVALUE | numeric | 是 |
| 9 | MAXIMUM | numeric | 是 |
| 10 | MINIMUM | numeric | 是 |

## TBLEQPREDICLESETBASIS — 设备REDICLESET主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | REDICLESETNO | nvarchar(50) | 否 |
| 2 | REDICLESETVERSION | nvarchar(3) | 否 |
| 3 | ISSUESTATE | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | CURVERSION | numeric | 否 |

## TBLEQPREDICLESETLAYER — 设备REDICLESETLAYER

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | REDICLESETNO | nvarchar(50) | 是 |
| 2 | REDICLESETVERSION | nvarchar(3) | 是 |
| 3 | LAYER | nvarchar(50) | 是 |
| 4 | MASKID | nvarchar(50) | 是 |

## TBLEQPRETICLESETBASIS — 设备RETICLESET主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RETICLESETNO | nvarchar(50) | 否 |
| 2 | RETICLESETVERSION | nvarchar(3) | 否 |
| 3 | ISSUESTATE | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | CURVERSION | numeric | 否 |

## TBLEQPRETICLESETLAYER — 设备RETICLESETLAYER

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RETICLESETNO | nvarchar(50) | 否 |
| 2 | RETICLESETVERSION | nvarchar(3) | 否 |
| 3 | LAYER | nvarchar(50) | 否 |
| 4 | MASKGROUP | nvarchar(50) | 否 |

## TBLEQPSTOCKERBASIS — 设备仓储柜主档

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | STOCKERNO | nvarchar(20) | 否 |
| 2 | FACTORYNO | nvarchar(20) | 是 |
| 3 | VNUMBER | numeric | 否 |
| 4 | HNUMBER | numeric | 否 |
| 5 | LOCATORTYPE | numeric | 否 |
| 6 | CONTENTTYPE | numeric | 否 |
| 7 | QTYLIMIT | numeric | 否 |
| 8 | CREATOR | nvarchar(30) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | ISSUESTATE | numeric | 是 |
| 11 | REVISER | nvarchar(10) | 是 |
| 12 | REVISEDATE | datetime | 是 |

## TBLEQPTOOLBASIS — 设备工装/刀具主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | TOOLNO | nvarchar(20) | 否 |
| 2 | TOOLNAME | nvarchar(50) | 是 |
| 3 | DESCRIPTION | nvarchar(255) | 是 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | ISSUESTATE | numeric | 否 |

