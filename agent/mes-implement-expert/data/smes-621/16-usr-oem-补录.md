# smes-621 补录：USR 人员/班别 + OEM 工单（真·生产独有 16 表）

> **定位**：2026-08-23 批量补录 —— 设计文档《SMES_621数据库设计文档20250313.html》与主字典（01~08）均未覆盖的**真·生产独有**表（仅存于生产库，断连无结构可查）。本次按 8 个业务核心前缀（WIP/PRD/INV/QC/EQP/OP/USR/OEM）分 7 个补录文件批量连库拉取。
> **来源**：连库实测 `INFORMATION_SCHEMA.COLUMNS`（profile `home`，192.168.200.18/sMES_Home_Prod，2026-08-23），7 文件共 **320 表 / 3209 列**。
> **说明**：字段结构断连可查；表级说明为**表名英文词根直译**，仅辅助检索识别，非正式中文语义（个别表若在 [09-core-ops-补录.md](09-core-ops-补录.md) 已有语义备注可交叉对照）。
> **衔接**：主字典 01~08（192 表）｜核心查询补录 [09-core-ops-补录.md](09-core-ops-补录.md)（68 表）｜本文件及 10~16（320 表）｜全量 1472 表分层见 [sMES全量表清单.md](../smes-621-sql/sMES全量表清单.md)。

本文件 16 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| `TBLOEMODISPQTY_PROXENE` | 工单ODISP数量_PROXENE | 15 |
| `tblOEMOFeature` | 工单O特性 | 3 |
| `TBLOEMOMATERIALTOERPLOG` | 工单O物料至ERP历程 | 11 |
| `TBLOEMOSEMIOUT` | 工单O半出 | 8 |
| `TBLOEMOSERIALCREATEMAX` | 工单O序列号创建最大 | 4 |
| `TBLUSRCATEGORYDEATIL` | 人员类别明细(原拼写笔误) | 9 |
| `TBLUSREXCEPTIONITEMBASIS` | 人员异常ITEM主档 | 6 |
| `TBLUSROPERATORLOGINEXCEP` | 人员操作员登录异常/例外 | 6 |
| `TBLUSROPERATORLOGINLOG` | 人员操作员登录历程 | 10 |
| `TBLUSROPERATORLOGINSTATE` | 人员操作员登录状态 | 7 |
| `TBLUSRPDLINEBASIS` | 人员PD产线主档 | 7 |
| `TBLUSRPDLINESET` | 人员PD产线SET | 7 |
| `TBLUSRSHIFTEXCEPTIONTIME` | 人员班别异常时间 | 5 |
| `TBLUSRUSERAGENT` | 人员用户AGENT | 4 |
| `TBLUSRWORKTIME` | 人员作业/工作时间 | 13 |
| `TBLUSRWORKTIMETEMPLATE` | 人员作业/工作时间模板 | 10 |

## TBLOEMODISPQTY_PROXENE — 工单ODISP数量_PROXENE

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | NODEID | nvarchar(80) | 否 |
| 3 | OPNo | nvarchar(20) | 否 |
| 4 | MANUFACTURESEQ | decimal | 否 |
| 5 | FIXEMPTIME | decimal | 是 |
| 6 | VAREMPTIME | decimal | 是 |
| 7 | COUNTOPUNITQTY | decimal | 否 |
| 8 | FIXEQPTIME | decimal | 是 |
| 9 | VAREQPTIME | decimal | 是 |
| 10 | COUNTEQPUNITQTY | decimal | 否 |
| 11 | CREATOR | nvarchar(30) | 否 |
| 12 | CREATEDATETIME | datetime | 否 |
| 13 | MODIFIER | nvarchar(10) | 是 |
| 14 | MODIFYDATETIME | datetime | 是 |
| 15 | MAXDISPATCHQTY | decimal | 是 |

## tblOEMOFeature — 工单O特性

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONo | nvarchar(50) | 否 |
| 2 | FeatureNo | nvarchar(50) | 否 |
| 3 | Qty | numeric | 是 |

## TBLOEMOMATERIALTOERPLOG — 工单O物料至ERP历程

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

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
| 9 | MATERIALRETURNNO | nvarchar(50) | 是 |
| 10 | LOGDATE | datetime | 是 |
| 11 | STATUS | numeric | 否 |

## TBLOEMOSEMIOUT — 工单O半出

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | INVENTORYNO | nvarchar(20) | 否 |
| 3 | PRODUCTNO | nvarchar(50) | 否 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | LOCATORNO | nvarchar(20) | 否 |
| 6 | UNITNO | nvarchar(30) | 否 |
| 7 | QTY | numeric | 是 |
| 8 | STATE | numeric | 是 |

## TBLOEMOSERIALCREATEMAX — 工单O序列号创建最大

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SERIALSTRING | nvarchar(100) | 否 |
| 2 | SERIALLENGTH | numeric | 否 |
| 3 | DECIMALTYPE | numeric | 否 |
| 4 | MAXSERIALNO | numeric | 否 |

## TBLUSRCATEGORYDEATIL — 人员类别明细(原拼写笔误)

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CATEGORYNO | nvarchar(50) | 否 |
| 2 | USERNO | nvarchar(10) | 否 |
| 3 | PARAMETERVALUE | numeric | 否 |
| 4 | Creator | nvarchar(50) | 是 |
| 5 | CreateDate | datetime | 是 |
| 6 | EDITOR | nvarchar(50) | 是 |
| 7 | EDITDATE | datetime | 是 |
| 8 | GUID | nvarchar(50) | 是 |
| 9 | TBLUSRCATEGORYBASISGUID | nvarchar(50) | 是 |

## TBLUSREXCEPTIONITEMBASIS — 人员异常ITEM主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EXCEPTIONITEMNO | nvarchar(50) | 否 |
| 2 | EXCEPREASON | nvarchar(50) | 否 |
| 3 | CREATOR | nvarchar(30) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | REVISER | nvarchar(20) | 是 |
| 6 | REVISEDATE | datetime | 是 |

## TBLUSROPERATORLOGINEXCEP — 人员操作员登录异常/例外

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGINSERIAL | nvarchar(20) | 否 |
| 2 | EXCEPREASON | nvarchar(50) | 否 |
| 3 | EXCEPTIME | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | EXCEPTIONITEMNO | nvarchar(50) | 否 |

## TBLUSROPERATORLOGINLOG — 人员操作员登录历程

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGINSERIAL | nvarchar(20) | 否 |
| 2 | LOGINSTATE | numeric | 否 |
| 3 | USERNO | nvarchar(30) | 否 |
| 4 | LOGINTYPE | numeric | 否 |
| 5 | LOGINAREA | nvarchar(20) | 否 |
| 6 | WORKDAY | nvarchar(10) | 否 |
| 7 | SHIFTNO | nvarchar(20) | 否 |
| 8 | LOGINDATE | datetime | 否 |
| 9 | LOGOUTDATE | datetime | 是 |
| 10 | WORKINGHOUR | numeric | 是 |

## TBLUSROPERATORLOGINSTATE — 人员操作员登录状态

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | USERNO | nvarchar(30) | 否 |
| 2 | LOGINSERIAL | nvarchar(20) | 否 |
| 3 | LOGINTYPE | numeric | 否 |
| 4 | LOGINAREA | nvarchar(20) | 否 |
| 5 | WORKDAY | nvarchar(10) | 否 |
| 6 | SHIFTNO | nvarchar(20) | 否 |
| 7 | LOGINDATE | datetime | 否 |

## TBLUSRPDLINEBASIS — 人员PD产线主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PDLINENO | nvarchar(50) | 否 |
| 2 | PDLINENAME | nvarchar(50) | 是 |
| 3 | STATE | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | ISSUESTATE | numeric | 否 |

## TBLUSRPDLINESET — 人员PD产线SET

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PDDATE | datetime | 否 |
| 2 | SHIFTNO | nvarchar(20) | 否 |
| 3 | PDLINENO | nvarchar(50) | 否 |
| 4 | USERNO | nvarchar(30) | 否 |
| 5 | DEPARTMENTNO | nvarchar(20) | 否 |
| 6 | CREATOR | nvarchar(30) | 否 |
| 7 | CREATEDATE | datetime | 是 |

## TBLUSRSHIFTEXCEPTIONTIME — 人员班别异常时间

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | DEPARTMENTNO | nvarchar(20) | 否 |
| 2 | SHIFTNO | nvarchar(20) | 否 |
| 3 | EXCEPREASON | nvarchar(50) | 否 |
| 4 | EXCEPTIME | numeric | 是 |
| 5 | EXCEPTIONITEMNO | nvarchar(50) | 否 |

## TBLUSRUSERAGENT — 人员用户AGENT

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | USERNO | nvarchar(30) | 否 |
| 2 | AGENT | nvarchar(10) | 否 |
| 3 | AGENTDATE | datetime | 是 |
| 4 | AGENTCREATEDATE | datetime | 是 |

## TBLUSRWORKTIME — 人员作业/工作时间

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OBJTYPE | numeric | 否 |
| 2 | OBJNO | nvarchar(30) | 否 |
| 3 | WORKDATE | datetime | 否 |
| 4 | STARTTIME | datetime | 否 |
| 5 | ENDTIME | datetime | 否 |
| 6 | EXCEPTTIME | numeric | 否 |
| 7 | ACTUALTIME | numeric | 否 |
| 8 | TEMPLATECOLOR | numeric | 是 |
| 9 | CONFIRM | numeric | 否 |
| 10 | DESCRIPTION | nvarchar(255) | 是 |
| 11 | WORKMONTH | numeric | 是 |
| 12 | WORKYEAR | numeric | 是 |
| 13 | TEMPLATENO | nvarchar(20) | 是 |

## TBLUSRWORKTIMETEMPLATE — 人员作业/工作时间模板

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | STARTTIME | datetime | 否 |
| 2 | ENDTIME | datetime | 否 |
| 3 | EXCEPTTIME | numeric | 否 |
| 4 | ACTUALTIME | numeric | 否 |
| 5 | TEMPLATENO | nvarchar(20) | 否 |
| 6 | TEMPLATECOLOR | numeric | 是 |
| 7 | CREATOR | nvarchar(30) | 是 |
| 8 | CREATEDATE | datetime | 是 |
| 9 | ISSUESTATE | numeric | 否 |
| 10 | DESCRIPTION | nvarchar(255) | 是 |

