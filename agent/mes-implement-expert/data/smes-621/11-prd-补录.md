# smes-621 补录：PRD 产品/工艺/配方（真·生产独有 61 表）

> **定位**：2026-08-23 批量补录 —— 设计文档《SMES_621数据库设计文档20250313.html》与主字典（01~08）均未覆盖的**真·生产独有**表（仅存于生产库，断连无结构可查）。本次按 8 个业务核心前缀（WIP/PRD/INV/QC/EQP/OP/USR/OEM）分 7 个补录文件批量连库拉取。
> **来源**：连库实测 `INFORMATION_SCHEMA.COLUMNS`（profile `home`，192.168.200.18/sMES_Home_Prod，2026-08-23），7 文件共 **320 表 / 3209 列**。
> **说明**：字段结构断连可查；表级说明为**表名英文词根直译**，仅辅助检索识别，非正式中文语义（个别表若在 [09-core-ops-补录.md](09-core-ops-补录.md) 已有语义备注可交叉对照）。
> **衔接**：主字典 01~08（192 表）｜核心查询补录 [09-core-ops-补录.md](09-core-ops-补录.md)（68 表）｜本文件及 10~16（320 表）｜全量 1472 表分层见 [sMES全量表清单.md](../smes-621-sql/sMES全量表清单.md)。

本文件 61 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| `TBLPRDAUTOSPLITBIN` | 产品/工艺自动拆分分箱/容器 | 3 |
| `TBLPRDAUTOSPLITDATACHANGE` | 产品/工艺自动拆分数据变更 | 4 |
| `TBLPRDAUTOSPLITDETAIL` | 产品/工艺自动拆分明细 | 13 |
| `TBLPRDAUTOSPLITRULE` | 产品/工艺自动拆分规则 | 10 |
| `TBLPRDENGBASIS` | 产品/工艺工程主档 | 11 |
| `TBLPRDENGOPRECIPE` | 产品/工艺工程工序配方/参数 | 6 |
| `TBLPRDENGPROPERTY` | 产品/工艺工程属性 | 6 |
| `TBLPRDENGRECIPE_ACCESSORY` | 产品/工艺工程ECIPE_ACCESSORY | 7 |
| `TBLPRDENGRECIPE_ATTACH` | 产品/工艺工程ECIPE_附件 | 4 |
| `TBLPRDENGRECIPE_ATTACHFILE` | 产品/工艺工程ECIPE_附件文件 | 5 |
| `TBLPRDENGRECIPE_ATTRIBUTE` | 产品/工艺工程ECIPE_属性UTE | 9 |
| `TBLPRDENGRECIPE_MATERIAL` | 产品/工艺工程ECIPE_物料 | 8 |
| `TBLPRDENGRECIPE_SHOW` | 产品/工艺工程ECIPE_SHOW | 7 |
| `TBLPRDENGRECIPEBASIS` | 产品/工艺工程ECIPE主档 | 9 |
| `TBLPRDEQCSAMPLERULE` | 产品/工艺E质量抽样/样本规则 | 11 |
| `TBLPRDEQCSAMPLERULEBIN` | 产品/工艺E质量抽样/样本规则分箱/容器 | 3 |
| `TBLPRDEQPCONSTRAINT` | 产品/工艺设备CONSTRA进T | 7 |
| `tblPRDeSOP_File` | 产品/工艺ES工序_文件 | 2 |
| `tblPRDeSOPBasis` | 产品/工艺ES工序主档 | 50 |
| `tblPRDeSOPBasisNew` | 产品/工艺ES工序主档NEW | 15 |
| `TBLPRDFTPROGRAMBASIS` | 产品/工艺FT程序主档 | 7 |
| `TBLPRDFTPROGRAMBIN` | 产品/工艺FT程序分箱/容器 | 7 |
| `TBLPRDLIMITEDTIMECONTROL` | 产品/工艺限定时间控制 | 13 |
| `TBLPRDLIMITEDTIMECONTROLLOG` | 产品/工艺限定时间控制历程 | 9 |
| `TBLPRDLIMITEDTIMEHOLDREASON` | 产品/工艺限定时间暂停原因 | 7 |
| `TBLPRDMODULEBASIS` | 产品/工艺工单DULE主档 | 12 |
| `TBLPRDOPATTRIB` | 产品工序属性 | 10 |
| `TBLPRDOPCAPITEM` | 产品工序C接口TEM | 10 |
| `TBLPRDOPEQPRECIPE` | 产品工序设备配方/参数 | 9 |
| `tblPRDOPPrice` | 产品工序单价 | 15 |
| `TBLPRDOPQCITEMPARAMETER` | 产品工序质量I临时/温度ARA仪表/计数 | 5 |
| `tblPRDOPSUBOPPrice` | 产品工序子作业单价 | 16 |
| `TBLPRDPACKAGETYPE` | 产品/工艺包装AGE类型 | 8 |
| `TBLPRDPACKINGACCESSORY` | 产品/工艺包装进GACCESSORY | 6 |
| `TBLPRDPACKINGLABELRULEBASIS` | 产品/工艺包装进G标签规则主档 | 10 |
| `TBLPRDPACKINGLABELRULEDETAIL` | 产品/工艺包装进G标签规则明细 | 12 |
| `TBLPRDPACKINGLABELRULEDETAIL_M` | 产品/工艺包装进G标签规则明细_M | 10 |
| `TBLPRDPACKINGRULEACCESSORY` | 产品/工艺包装进G规则ACCESSORY | 6 |
| `TBLPRDPACKINGRULEBASIS` | 产品/工艺包装进G规则主档 | 31 |
| `TBLPRDPACKINGRULEMAP` | 产品/工艺包装进G规则映射 | 6 |
| `TBLPRDPACKINGSERIALRULEBASIS` | 产品/工艺包装进G序列号规则主档 | 9 |
| `TBLPRDPACKINGSERIALRULEDETAIL` | 产品/工艺包装进G序列号规则明细 | 13 |
| `TBLPRDPRODUCTENGNO` | 产品/工艺产品工程编号 | 7 |
| `TBLPRDPRODUCTLABELRULEBASIS` | 产品/工艺产品标签规则主档 | 10 |
| `TBLPRDPRODUCTLABELRULEDETAIL` | 产品/工艺产品标签规则明细 | 12 |
| `TBLPRDPRODUCTLABELRULEDETAIL_M` | 产品/工艺产品标签规则明细_M | 10 |
| `TBLPRDPRODUCTPROGRAMS` | 产品/工艺产品程序S | 3 |
| `TBLPRDPRODUCTSERIALRULEBASIS` | 产品/工艺产品序列号规则主档 | 9 |
| `TBLPRDPRODUCTSERIALRULEDETAIL` | 产品/工艺产品序列号规则明细 | 13 |
| `TBLPRDPROGRAMBASIS` | 产品/工艺程序主档 | 6 |
| `TBLPRDQCITEM` | 产品/工艺质量ITEM | 7 |
| `TBLPRDQCRULEBASIS` | 产品/工艺质量规则主档 | 13 |
| `tblPRDQuantityConversion` | 产品/工艺数量换算 | 11 |
| `TBLPRDRECIPE` | 产品/工艺配方/参数 | 3 |
| `TBLPRDRECIPEBASIS` | 产品/工艺配方/参数主档 | 7 |
| `TBLPRDRECIPEDETAIL` | 产品/工艺配方/参数明细 | 7 |
| `TBLPRDRUNTIMESETUPLOG` | 产品/工艺RUN时间准备/设定历程 | 26 |
| `TBLPRDSAMPLEPOSITION_FAB` | 产品/工艺抽样/样本位置_FAB | 2 |
| `TBLPRDSAMPLERULE_FAB` | 产品/工艺抽样/样本规则_FAB | 9 |
| `TBLPRDSTAGESTEPSET` | 产品/工艺阶段步骤SET | 7 |
| `TBLPRDSTAGESTEPSETDETAIL` | 产品/工艺阶段步骤SET明细 | 5 |

## TBLPRDAUTOSPLITBIN — 产品/工艺自动拆分分箱/容器

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | RULEINDEX | numeric | 否 |
| 3 | BINNO | nvarchar(10) | 否 |

## TBLPRDAUTOSPLITDATACHANGE — 产品/工艺自动拆分数据变更

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | RULEINDEX | numeric | 否 |
| 3 | PROPERTYNO | nvarchar(20) | 否 |
| 4 | PROPERTYVALUE | nvarchar(255) | 否 |

## TBLPRDAUTOSPLITDETAIL — 产品/工艺自动拆分明细

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | RULEINDEX | numeric | 否 |
| 3 | NEXTNODEID | nvarchar(80) | 是 |
| 4 | SPLITDATACHANGERULE | nvarchar(30) | 是 |
| 5 | OPTLOTNO | numeric | 是 |
| 6 | OPTCUSTOMERLOTNO | numeric | 是 |
| 7 | OPTPRODUCTNO | numeric | 是 |
| 8 | ADDLOTNO | nvarchar(50) | 是 |
| 9 | ADDCUSTOMERLOTNO | nvarchar(50) | 是 |
| 10 | ADDPRODUCTNO | nvarchar(50) | 是 |
| 11 | NUMLOTNO | numeric | 是 |
| 12 | NUMCUSTOMERLOTNO | numeric | 是 |
| 13 | NUMPRODUCTNO | numeric | 是 |

## TBLPRDAUTOSPLITRULE — 产品/工艺自动拆分规则

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | RULEOPTION | numeric | 否 |
| 3 | LOTQTY | numeric | 是 |
| 4 | LOTLIMIT | numeric | 是 |
| 5 | MERGEOPTION | numeric | 否 |
| 6 | SPLITSTARTCODE | nvarchar(5) | 是 |
| 7 | ISSUESTATE | numeric | 否 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | CREATOR | nvarchar(30) | 是 |
| 10 | CREATEDATE | datetime | 是 |

## TBLPRDENGBASIS — 产品/工艺工程主档

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ENGNO | nvarchar(30) | 否 |
| 2 | ENGVERSION | nvarchar(3) | 否 |
| 3 | ENGCODE | nvarchar(35) | 否 |
| 4 | PSNO | nvarchar(50) | 否 |
| 5 | PROCESSNO | nvarchar(64) | 是 |
| 6 | PROCESSVERSION | nvarchar(3) | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |
| 8 | CREATOR | nvarchar(30) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | ISSUESTATE | numeric | 是 |
| 11 | CURVERSION | numeric | 否 |

## TBLPRDENGOPRECIPE — 产品/工艺工程工序配方/参数

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ENGNO | nvarchar(30) | 否 |
| 2 | ENGVERSION | nvarchar(3) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | RECIPENO | nvarchar(60) | 是 |
| 5 | RECIPEVERSION | nvarchar(3) | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDENGPROPERTY — 产品/工艺工程属性

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ENGNO | nvarchar(30) | 否 |
| 2 | ENGVERSION | nvarchar(3) | 否 |
| 3 | PROPERTYNO | nvarchar(20) | 否 |
| 4 | DEFAULTVALUE | nvarchar(255) | 是 |
| 5 | PROPERTYSEQUENCE | numeric | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDENGRECIPE_ACCESSORY — 产品/工艺工程ECIPE_ACCESSORY

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | SERIALNO | numeric | 否 |
| 4 | ACCESSORYCATEGORY | nvarchar(50) | 否 |
| 5 | ACCESSORYTYPE | nvarchar(50) | 是 |
| 6 | PROPERTYNO | nvarchar(200) | 是 |
| 7 | ENGSHOW | numeric | 是 |

## TBLPRDENGRECIPE_ATTACH — 产品/工艺工程ECIPE_附件

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | ATTACHFILE | nvarchar(100) | 是 |
| 4 | ATTACHGRAPH | nvarchar(100) | 是 |

## TBLPRDENGRECIPE_ATTACHFILE — 产品/工艺工程ECIPE_附件文件

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | ATTACHTYPE | nvarchar(10) | 否 |
| 4 | ATTACHNAME | nvarchar(50) | 否 |
| 5 | ATTACHBODY | varbinary(-1) | 是 |

## TBLPRDENGRECIPE_ATTRIBUTE — 产品/工艺工程ECIPE_属性UTE

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | ATTRIBNO | nvarchar(20) | 否 |
| 4 | ATTRIBSOURCE | numeric | 否 |
| 5 | ATTRIBSEQUENCE | numeric | 否 |
| 6 | ATTRIBVALUE | nvarchar(255) | 是 |
| 7 | ATTRIBSCRIPT | nvarchar(3000) | 是 |
| 8 | LOTPROPERTYNO | nvarchar(20) | 是 |
| 9 | ENGSHOW | numeric | 是 |

## TBLPRDENGRECIPE_MATERIAL — 产品/工艺工程ECIPE_物料

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | SERIALNO | numeric | 否 |
| 4 | MATERIALTYPE | nvarchar(50) | 否 |
| 5 | MATERIALNO | nvarchar(50) | 是 |
| 6 | FIELDNAME | nvarchar(200) | 是 |
| 7 | PROPERTYNO | nvarchar(200) | 是 |
| 8 | ENGSHOW | numeric | 是 |

## TBLPRDENGRECIPE_SHOW — 产品/工艺工程ECIPE_SHOW

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | CONTENTTYPE | numeric | 否 |
| 4 | CONTENTNO | nvarchar(50) | 否 |
| 5 | TABLESOURCE | numeric | 是 |
| 6 | FIELDNAME | nvarchar(50) | 否 |
| 7 | ENGSHOW | numeric | 是 |

## TBLPRDENGRECIPEBASIS — 产品/工艺工程ECIPE主档

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPENO | nvarchar(60) | 否 |
| 2 | RECIPEVERSION | nvarchar(3) | 否 |
| 3 | ISSUESTATE | numeric | 否 |
| 4 | CURVERSION | numeric | 否 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | ATTACHFILE | numeric | 是 |
| 9 | ATTACHGRAPH | numeric | 是 |

## TBLPRDEQCSAMPLERULE — 产品/工艺E质量抽样/样本规则

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | RULEOPTION | numeric | 否 |
| 3 | SAMPLETYPE | numeric | 否 |
| 4 | SAMPLEQTY | numeric | 是 |
| 5 | MAXBINQTY | numeric | 是 |
| 6 | ASSIGNBINNO | nvarchar(10) | 是 |
| 7 | ISSUESTATE | numeric | 否 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | CREATOR | nvarchar(30) | 是 |
| 10 | CREATEDATE | datetime | 是 |
| 11 | SAMPLEFUNCTION | nvarchar(50) | 是 |

## TBLPRDEQCSAMPLERULEBIN — 产品/工艺E质量抽样/样本规则分箱/容器

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | BINORDER | numeric | 否 |
| 3 | BINNO | nvarchar(10) | 否 |

## TBLPRDEQPCONSTRAINT — 产品/工艺设备CONSTRA进T

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | OPNO | nvarchar(50) | 否 |
| 4 | EQUIPMENTNO | nvarchar(50) | 否 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |

## tblPRDeSOP_File — 产品/工艺ES工序_文件

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | FileName | nvarchar(50) | 否 |
| 2 | FileBody | varbinary(-1) | 否 |

## tblPRDeSOPBasis — 产品/工艺ES工序主档

> 字段数：50 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ProductNo | nvarchar(50) | 否 |
| 2 | ProductVersion | nvarchar(5) | 否 |
| 3 | OPNo | nvarchar(20) | 否 |
| 4 | SubOPNo | nvarchar(50) | 否 |
| 5 | SOPFile | nvarchar(255) | 否 |
| 6 | PageNo | nvarchar(20) | 是 |
| 7 | Description | nvarchar(255) | 是 |
| 8 | Creator | nvarchar(30) | 否 |
| 9 | CreateDate | datetime | 否 |
| 10 | FILENAME01 | nvarchar(50) | 否 |
| 11 | FILENAME02 | nvarchar(50) | 否 |
| 12 | FILENAME03 | nvarchar(50) | 否 |
| 13 | FILENAME04 | nvarchar(50) | 否 |
| 14 | FILENAME05 | nvarchar(50) | 否 |
| 15 | POSITIONNO | nvarchar(50) | 否 |
| 16 | FILENAME06 | nvarchar(50) | 否 |
| 17 | FILENAME07 | nvarchar(50) | 否 |
| 18 | FILENAME08 | nvarchar(50) | 否 |
| 19 | FILENAME09 | nvarchar(50) | 否 |
| 20 | FILENAME10 | nvarchar(50) | 否 |
| 21 | SUBOPSEQUENCE01 | numeric | 否 |
| 22 | SUBOPSEQUENCE02 | numeric | 否 |
| 23 | SUBOPSEQUENCE03 | numeric | 否 |
| 24 | SUBOPSEQUENCE04 | numeric | 否 |
| 25 | SUBOPSEQUENCE05 | numeric | 否 |
| 26 | SUBOPSEQUENCE06 | numeric | 否 |
| 27 | SUBOPSEQUENCE07 | numeric | 否 |
| 28 | SUBOPSEQUENCE08 | numeric | 否 |
| 29 | SUBOPSEQUENCE09 | numeric | 否 |
| 30 | SUBOPSEQUENCE10 | numeric | 否 |
| 31 | FILENAME11 | nvarchar(50) | 是 |
| 32 | FILENAME12 | nvarchar(50) | 是 |
| 33 | FILENAME13 | nvarchar(50) | 是 |
| 34 | FILENAME14 | nvarchar(50) | 是 |
| 35 | FILENAME15 | nvarchar(50) | 是 |
| 36 | FILENAME16 | nvarchar(50) | 是 |
| 37 | FILENAME17 | nvarchar(50) | 是 |
| 38 | FILENAME18 | nvarchar(50) | 是 |
| 39 | FILENAME19 | nvarchar(50) | 是 |
| 40 | FILENAME20 | nvarchar(50) | 是 |
| 41 | SUBOPSEQUENCE11 | numeric | 否 |
| 42 | SUBOPSEQUENCE12 | numeric | 否 |
| 43 | SUBOPSEQUENCE13 | numeric | 否 |
| 44 | SUBOPSEQUENCE14 | numeric | 否 |
| 45 | SUBOPSEQUENCE15 | numeric | 否 |
| 46 | SUBOPSEQUENCE16 | numeric | 否 |
| 47 | SUBOPSEQUENCE17 | numeric | 否 |
| 48 | SUBOPSEQUENCE18 | numeric | 否 |
| 49 | SUBOPSEQUENCE19 | numeric | 否 |
| 50 | SUBOPSEQUENCE20 | numeric | 否 |

## tblPRDeSOPBasisNew — 产品/工艺ES工序主档NEW

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ProductNo | nvarchar(50) | 否 |
| 2 | ProductVersion | nvarchar(5) | 否 |
| 3 | OPNo | nvarchar(20) | 否 |
| 4 | SubOPSequence | numeric | 否 |
| 5 | Seq | numeric | 否 |
| 6 | FileName | nvarchar(255) | 否 |
| 7 | Description | nvarchar(4000) | 是 |
| 8 | Creator | nvarchar(50) | 是 |
| 9 | CreateDate | datetime | 是 |
| 10 | DocFileName | nvarchar(100) | 是 |
| 11 | ISSUESTATE | numeric | 是 |
| 12 | EDITOR | nvarchar(50) | 是 |
| 13 | EDITDATE | datetime | 是 |
| 14 | GUID | nvarchar(50) | 是 |
| 15 | TBLPRDPRODUCTBASISGUID | nvarchar(50) | 是 |

## TBLPRDFTPROGRAMBASIS — 产品/工艺FT程序主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PROGRAMNO | nvarchar(50) | 否 |
| 2 | PROGRAMVERSION | nvarchar(3) | 否 |
| 3 | CURVERSION | numeric | 否 |
| 4 | ISSUESTATE | numeric | 否 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDFTPROGRAMBIN — 产品/工艺FT程序分箱/容器

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PROGRAMNO | nvarchar(50) | 否 |
| 2 | PROGRAMVERSION | nvarchar(3) | 否 |
| 3 | BINNO | nvarchar(10) | 否 |
| 4 | BINVALUE | numeric | 否 |
| 5 | DGRADE | numeric | 否 |
| 6 | RANK | nvarchar(25) | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDLIMITEDTIMECONTROL — 产品/工艺限定时间控制

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BOUNDARY | nvarchar(5) | 否 |
| 2 | REFERENCENO | nvarchar(50) | 否 |
| 3 | REFERENCEVERSION | nvarchar(3) | 否 |
| 4 | OPREFERENCE | numeric | 否 |
| 5 | MOTYPENO | numeric | 否 |
| 6 | FROMOPNO | nvarchar(20) | 否 |
| 7 | TOOPNO | nvarchar(20) | 否 |
| 8 | VALIDMINUTE | numeric | 否 |
| 9 | MCLASSNO | nvarchar(30) | 是 |
| 10 | HOLDDESCRIPTION | nvarchar(4000) | 是 |
| 11 | CREATOR | nvarchar(30) | 是 |
| 12 | CREATEDATE | datetime | 是 |
| 13 | ISSUESTATE | numeric | 否 |

## TBLPRDLIMITEDTIMECONTROLLOG — 产品/工艺限定时间控制历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BOUNDARY | nvarchar(5) | 否 |
| 2 | REFERENCENO | nvarchar(50) | 否 |
| 3 | REFERENCEVERSION | nvarchar(3) | 否 |
| 4 | VALIDMINUTE | numeric | 是 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |
| 7 | FROMOPNO | nvarchar(20) | 否 |
| 8 | TOOPNO | nvarchar(20) | 否 |
| 9 | MOTYPENO | numeric | 否 |

## TBLPRDLIMITEDTIMEHOLDREASON — 产品/工艺限定时间暂停原因

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BOUNDARY | nvarchar(5) | 否 |
| 2 | REFERENCENO | nvarchar(50) | 否 |
| 3 | REFERENCEVERSION | nvarchar(3) | 否 |
| 4 | HOLDITEMNO | nvarchar(50) | 否 |
| 5 | FROMOPNO | nvarchar(20) | 否 |
| 6 | TOOPNO | nvarchar(20) | 否 |
| 7 | MOTYPENO | numeric | 否 |

## TBLPRDMODULEBASIS — 产品/工艺工单DULE主档

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MODULENO | nvarchar(45) | 否 |
| 2 | MODULEVERSION | nvarchar(3) | 否 |
| 3 | MODULENAME | nvarchar(100) | 否 |
| 4 | MODULETYPE | nvarchar(50) | 否 |
| 5 | ISSUESTATE | numeric | 否 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | CURVERSION | numeric | 否 |
| 10 | UNITNO | nvarchar(30) | 是 |
| 11 | UNITTYPE | nvarchar(30) | 是 |
| 12 | PSNO | nvarchar(50) | 否 |

## TBLPRDOPATTRIB — 产品工序属性

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SERIALNO | nvarchar(50) | 否 |
| 2 | ATTRIBTYPE | numeric | 否 |
| 3 | ATTRIBNO | nvarchar(20) | 否 |
| 4 | ATTRIBSOURCE | numeric | 否 |
| 5 | ATTRIBPHASE | numeric | 否 |
| 6 | ATTRIBSEQUENCE | numeric | 否 |
| 7 | ATTRIBVALUE | nvarchar(255) | 是 |
| 8 | ATTRIBSCRIPT | nvarchar(3000) | 是 |
| 9 | SAVETOLOTPROPERTYNO | nvarchar(20) | 是 |
| 10 | QCItemNo | nvarchar(25) | 是 |

## TBLPRDOPCAPITEM — 产品工序C接口TEM

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | CAPITEM | nvarchar(50) | 否 |
| 5 | CAPVALUE | nvarchar(20) | 否 |
| 6 | CREATOR | nvarchar(30) | 否 |
| 7 | CREATEDATE | datetime | 否 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | REVISER | nvarchar(10) | 是 |
| 10 | REVISEDATE | datetime | 是 |

## TBLPRDOPEQPRECIPE — 产品工序设备配方/参数

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SERIALNO | nvarchar(50) | 否 |
| 2 | EQUIPMENTNO | nvarchar(50) | 否 |
| 3 | RECIPEGROUP | nvarchar(50) | 是 |
| 4 | ISSUESTATE | numeric | 是 |
| 5 | Creator | nvarchar(50) | 是 |
| 6 | CreateDate | datetime | 是 |
| 7 | Editor | nvarchar(50) | 是 |
| 8 | EditDate | datetime | 是 |
| 9 | GUID | nvarchar(50) | 是 |

## tblPRDOPPrice — 产品工序单价

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ProductNo | nvarchar(50) | 否 |
| 2 | ProductVersion | nvarchar(5) | 否 |
| 3 | OpNo | nvarchar(20) | 否 |
| 4 | PriceType | numeric | 否 |
| 5 | PieceUrgPrice | numeric | 是 |
| 6 | PiecePrice | numeric | 是 |
| 7 | PieceRedoPrice | numeric | 是 |
| 8 | TimeUrgPrice | numeric | 是 |
| 9 | TimePrice | numeric | 是 |
| 10 | TimeRedoPrice | numeric | 是 |
| 11 | Isabled | numeric | 否 |
| 12 | EffectDate | datetime | 否 |
| 13 | Description | nvarchar(255) | 是 |
| 14 | Creator | nvarchar(30) | 是 |
| 15 | CreateDate | datetime | 是 |

## TBLPRDOPQCITEMPARAMETER — 产品工序质量I临时/温度ARA仪表/计数

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SERIALNO | nvarchar(50) | 否 |
| 2 | QCITEMNO | nvarchar(25) | 否 |
| 3 | QCITEMTYPE | numeric | 否 |
| 4 | PARAMETERNO | nvarchar(20) | 否 |
| 5 | PARAMETERVALUE | nvarchar(255) | 是 |

## tblPRDOPSUBOPPrice — 产品工序子作业单价

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ProductNo | nvarchar(50) | 否 |
| 2 | ProductVersion | nvarchar(5) | 否 |
| 3 | OpNo | nvarchar(20) | 否 |
| 4 | SUBOPNo | nvarchar(20) | 否 |
| 5 | PriceType | numeric | 否 |
| 6 | PieceUrgPrice | numeric | 是 |
| 7 | PiecePrice | numeric | 是 |
| 8 | PieceRedoPrice | numeric | 是 |
| 9 | TimeUrgPrice | numeric | 是 |
| 10 | TimePrice | numeric | 是 |
| 11 | TimeRedoPrice | numeric | 是 |
| 12 | Isabled | numeric | 否 |
| 13 | EffectDate | datetime | 否 |
| 14 | Description | nvarchar(255) | 是 |
| 15 | Creator | nvarchar(30) | 是 |
| 16 | CreateDate | datetime | 是 |

## TBLPRDPACKAGETYPE — 产品/工艺包装AGE类型

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKAGETYPE | nvarchar(50) | 否 |
| 2 | DBSPLITQTY | numeric | 否 |
| 3 | CREATOR | nvarchar(30) | 是 |
| 4 | CREATEDATE | datetime | 是 |
| 5 | ISSUESTATE | numeric | 否 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | MINSPLITQTY | numeric | 否 |
| 8 | CODE | nvarchar(2) | 是 |

## TBLPRDPACKINGACCESSORY — 产品/工艺包装进GACCESSORY

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | ACCESSORYBARCODE | nvarchar(50) | 否 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |

## TBLPRDPACKINGLABELRULEBASIS — 产品/工艺包装进G标签规则主档

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | LABELTYPE | nvarchar(5) | 否 |
| 4 | PRINTCOUNT | numeric | 否 |
| 5 | LABELPATH | nvarchar(100) | 否 |
| 6 | CREATOR | nvarchar(30) | 否 |
| 7 | CREATEDATE | datetime | 否 |
| 8 | REVISER | nvarchar(10) | 是 |
| 9 | REVISEDATE | datetime | 是 |
| 10 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDPACKINGLABELRULEDETAIL — 产品/工艺包装进G标签规则明细

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | LABELTYPE | nvarchar(5) | 否 |
| 4 | ITEMNO | numeric | 否 |
| 5 | ITEMNAME | nvarchar(50) | 否 |
| 6 | DATAPROPERTY | numeric | 否 |
| 7 | USERDEFINE | nvarchar(50) | 是 |
| 8 | SOURCETYPE | nvarchar(50) | 是 |
| 9 | SEARCHSTART | numeric | 是 |
| 10 | SEARCHEND | numeric | 是 |
| 11 | DESCRIPTION | nvarchar(255) | 是 |
| 12 | SEPARATESIGN | nvarchar(1) | 是 |

## TBLPRDPACKINGLABELRULEDETAIL_M — 产品/工艺包装进G标签规则明细_M

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | LABELTYPE | nvarchar(5) | 否 |
| 4 | MULTIITEMNO | numeric | 否 |
| 5 | ITEMNAME | nvarchar(50) | 否 |
| 6 | DATAPROPERTY | numeric | 否 |
| 7 | USERDEFINE | nvarchar(50) | 是 |
| 8 | SOURCETYPE | nvarchar(50) | 是 |
| 9 | SEARCHSTART | numeric | 是 |
| 10 | SEARCHEND | numeric | 是 |

## TBLPRDPACKINGRULEACCESSORY — 产品/工艺包装进G规则ACCESSORY

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | ACCESSORYBARCODE | nvarchar(50) | 否 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |

## TBLPRDPACKINGRULEBASIS — 产品/工艺包装进G规则主档

> 字段数：31 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | ISSUESTATE | numeric | 否 |
| 4 | CURVERSION | numeric | 否 |
| 5 | LEVELMAX | numeric | 否 |
| 6 | L1_NAME | nvarchar(50) | 否 |
| 7 | L1_QTY | numeric | 否 |
| 8 | L1_SOPPATH | nvarchar(500) | 是 |
| 9 | L2_NAME | nvarchar(50) | 是 |
| 10 | L2_QTY | numeric | 是 |
| 11 | L2_SOPPATH | nvarchar(500) | 是 |
| 12 | L3_NAME | nvarchar(50) | 是 |
| 13 | L3_QTY | numeric | 是 |
| 14 | L3_SOPPATH | nvarchar(500) | 是 |
| 15 | L4_NAME | nvarchar(50) | 是 |
| 16 | L4_QTY | numeric | 是 |
| 17 | L4_SOPPATH | nvarchar(500) | 是 |
| 18 | L5_NAME | nvarchar(50) | 是 |
| 19 | L5_QTY | numeric | 是 |
| 20 | L5_SOPPATH | nvarchar(500) | 是 |
| 21 | L6_NAME | nvarchar(50) | 是 |
| 22 | L6_QTY | numeric | 是 |
| 23 | L6_SOPPATH | nvarchar(500) | 是 |
| 24 | CREATOR | nvarchar(30) | 否 |
| 25 | CREATEDATE | datetime | 否 |
| 26 | L1_UNITNO | nvarchar(30) | 否 |
| 27 | L2_UNITNO | nvarchar(30) | 是 |
| 28 | L3_UNITNO | nvarchar(30) | 是 |
| 29 | L4_UNITNO | nvarchar(30) | 是 |
| 30 | L5_UNITNO | nvarchar(30) | 是 |
| 31 | L6_UNITNO | nvarchar(30) | 是 |

## TBLPRDPACKINGRULEMAP — 产品/工艺包装进G规则映射

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | PACKINGRULENO | nvarchar(50) | 否 |
| 4 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |

## TBLPRDPACKINGSERIALRULEBASIS — 产品/工艺包装进G序列号规则主档

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | SERIALTYPE | numeric | 否 |
| 4 | TOTALLENGTH | numeric | 否 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |
| 7 | REVISER | nvarchar(10) | 是 |
| 8 | REVISEDATE | datetime | 是 |
| 9 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDPACKINGSERIALRULEDETAIL — 产品/工艺包装进G序列号规则明细

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGRULENO | nvarchar(50) | 否 |
| 2 | PACKINGRULEVERSION | nvarchar(5) | 否 |
| 3 | SERIALTYPE | numeric | 否 |
| 4 | ITEMNO | numeric | 否 |
| 5 | CODESTART | numeric | 否 |
| 6 | CODEEND | numeric | 否 |
| 7 | SOURCETYPE | nvarchar(50) | 否 |
| 8 | SERIALLENGTH | numeric | 否 |
| 9 | SEARCHSTART | numeric | 是 |
| 10 | SEARCHEND | numeric | 是 |
| 11 | DECIMALTYPE | numeric | 是 |
| 12 | USERDEFINE | nvarchar(50) | 是 |
| 13 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDPRODUCTENGNO — 产品/工艺产品工程编号

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | ENGNO | nvarchar(30) | 否 |
| 4 | ENGVERSION | nvarchar(3) | 否 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |

## TBLPRDPRODUCTLABELRULEBASIS — 产品/工艺产品标签规则主档

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | LABELTYPE | nvarchar(2) | 否 |
| 4 | PRINTCOUNT | numeric | 否 |
| 5 | LABELPATH | nvarchar(100) | 否 |
| 6 | CREATOR | nvarchar(30) | 否 |
| 7 | CREATEDATE | datetime | 否 |
| 8 | REVISER | nvarchar(10) | 是 |
| 9 | REVISEDATE | datetime | 是 |
| 10 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDPRODUCTLABELRULEDETAIL — 产品/工艺产品标签规则明细

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | LABELTYPE | nvarchar(2) | 否 |
| 4 | ITEMNO | numeric | 否 |
| 5 | ITEMNAME | nvarchar(50) | 否 |
| 6 | DATAPROPERTY | numeric | 否 |
| 7 | USERDEFINE | nvarchar(50) | 是 |
| 8 | SOURCETYPE | nvarchar(50) | 是 |
| 9 | SEARCHSTART | numeric | 是 |
| 10 | SEARCHEND | numeric | 是 |
| 11 | DESCRIPTION | nvarchar(255) | 是 |
| 12 | SEPARATESIGN | nvarchar(1) | 是 |

## TBLPRDPRODUCTLABELRULEDETAIL_M — 产品/工艺产品标签规则明细_M

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | LABELTYPE | nvarchar(2) | 否 |
| 4 | MULTIITEMNO | numeric | 否 |
| 5 | ITEMNAME | nvarchar(50) | 否 |
| 6 | DATAPROPERTY | numeric | 否 |
| 7 | USERDEFINE | nvarchar(50) | 是 |
| 8 | SOURCETYPE | nvarchar(50) | 是 |
| 9 | SEARCHSTART | numeric | 是 |
| 10 | SEARCHEND | numeric | 是 |

## TBLPRDPRODUCTPROGRAMS — 产品/工艺产品程序S

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | PROGRAMNO | nvarchar(50) | 否 |

## TBLPRDPRODUCTSERIALRULEBASIS — 产品/工艺产品序列号规则主档

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | SERIALTYPE | numeric | 否 |
| 4 | TOTALLENGTH | numeric | 否 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |
| 7 | REVISER | nvarchar(10) | 是 |
| 8 | REVISEDATE | datetime | 是 |
| 9 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDPRODUCTSERIALRULEDETAIL — 产品/工艺产品序列号规则明细

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | SERIALTYPE | numeric | 否 |
| 4 | ITEMNO | numeric | 否 |
| 5 | CODESTART | numeric | 否 |
| 6 | CODEEND | numeric | 否 |
| 7 | SOURCETYPE | nvarchar(50) | 否 |
| 8 | SERIALLENGTH | numeric | 否 |
| 9 | SEARCHSTART | numeric | 是 |
| 10 | SEARCHEND | numeric | 是 |
| 11 | DECIMALTYPE | numeric | 是 |
| 12 | USERDEFINE | nvarchar(50) | 是 |
| 13 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDPROGRAMBASIS — 产品/工艺程序主档

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PROGRAMNO | nvarchar(50) | 否 |
| 2 | PROGRAMTYPE | nvarchar(10) | 是 |
| 3 | ISSUESTATE | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDQCITEM — 产品/工艺质量ITEM

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | QCITEMNO | nvarchar(25) | 否 |
| 3 | QCITEMTYPE | numeric | 否 |
| 4 | PRODUCTVERSION | nvarchar(5) | 否 |
| 5 | OPNO | nvarchar(20) | 否 |
| 6 | EXECUTEORDER | numeric | 否 |
| 7 | INLINE | numeric | 否 |

## TBLPRDQCRULEBASIS — 产品/工艺质量规则主档

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(25) | 否 |
| 2 | EQUIPMENTNO | nvarchar(25) | 否 |
| 3 | OPNO | nvarchar(30) | 否 |
| 4 | QCMETHOD | numeric | 否 |
| 5 | QCNUM | numeric | 是 |
| 6 | SHIFTA | nvarchar(5) | 是 |
| 7 | SHIFTB | nvarchar(5) | 是 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | CREATOR | nvarchar(30) | 是 |
| 10 | CREATEDATE | datetime | 是 |
| 11 | QCITEM | nvarchar(25) | 是 |
| 12 | QCTYPE | numeric | 是 |
| 13 | MODULENO | nvarchar(10) | 是 |

## tblPRDQuantityConversion — 产品/工艺数量换算

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ProductNo | nvarchar(50) | 否 |
| 2 | ProductVersion | nvarchar(50) | 否 |
| 3 | FromNodeNo | nvarchar(50) | 否 |
| 4 | ToNodeNo | nvarchar(50) | 否 |
| 5 | LinkName | nvarchar(50) | 否 |
| 6 | Numerator | numeric | 否 |
| 7 | Denominator | numeric | 否 |
| 8 | ProcessNo | nvarchar(64) | 是 |
| 9 | ProcessVersion | nvarchar(50) | 是 |
| 10 | Revisor | nvarchar(30) | 是 |
| 11 | ReviseDate | datetime | 是 |

## TBLPRDRECIPE — 产品/工艺配方/参数

> 字段数：3 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | PRODUCTVERSION | nvarchar(5) | 否 |
| 3 | RECIPEGROUP | nvarchar(50) | 否 |

## TBLPRDRECIPEBASIS — 产品/工艺配方/参数主档

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

## TBLPRDRECIPEDETAIL — 产品/工艺配方/参数明细

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RECIPEGROUP | nvarchar(50) | 否 |
| 2 | RECIPEVERSION | numeric | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | RECIPENO | nvarchar(20) | 否 |
| 5 | RECIPEVALUE | nvarchar(255) | 是 |
| 6 | SEQUENCE | numeric | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |

## TBLPRDRUNTIMESETUPLOG — 产品/工艺RUN时间准备/设定历程

> 字段数：26 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGTYPE | nvarchar(5) | 否 |
| 2 | LOGTIME | datetime | 否 |
| 3 | ProductNo | nvarchar(50) | 否 |
| 4 | ProductVersion | nvarchar(5) | 否 |
| 5 | AreaNO | nvarchar(20) | 否 |
| 6 | OPNo | nvarchar(20) | 否 |
| 7 | EquipmentNo | nvarchar(50) | 否 |
| 8 | EquipmentType | nvarchar(50) | 否 |
| 9 | StdUnitEMPTime | numeric | 否 |
| 10 | StdUnitEQPTime | numeric | 否 |
| 11 | CountEQPUnitQty | numeric | 否 |
| 12 | StdUnitRunTime | numeric | 否 |
| 13 | CountOPUnitQty | numeric | 否 |
| 14 | StdQueueTime | numeric | 否 |
| 15 | Creator | nvarchar(10) | 是 |
| 16 | CreateDate | datetime | 是 |
| 17 | FixEMPTimea | numeric | 是 |
| 18 | VarEMPTime | numeric | 是 |
| 19 | FixEQPTime | numeric | 是 |
| 20 | VarEQPTime | numeric | 是 |
| 21 | FixEMPTime | numeric | 是 |
| 22 | WorkPriceType | numeric | 是 |
| 23 | WorkPrice | numeric | 是 |
| 24 | EquivalentRatio | numeric | 否 |
| 25 | StampingSpeed | numeric | 否 |
| 26 | EQPTYPESYN | numeric | 是 |

## TBLPRDSAMPLEPOSITION_FAB — 产品/工艺抽样/样本位置_FAB

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | POSITION | nvarchar(20) | 否 |

## TBLPRDSAMPLERULE_FAB — 产品/工艺抽样/样本规则_FAB

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RULENO | nvarchar(50) | 否 |
| 2 | EVERYNUM | numeric | 否 |
| 3 | SAMPLEPIECENUM | numeric | 否 |
| 4 | SAMPLEPOINTNUM | numeric | 否 |
| 5 | REJECTNUM | numeric | 否 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | ISSUESTATE | numeric | 否 |
| 9 | REJECTACTION | nvarchar(20) | 否 |

## TBLPRDSTAGESTEPSET — 产品/工艺阶段步骤SET

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | STAGENO | nvarchar(50) | 是 |
| 3 | OPNO | nvarchar(50) | 是 |
| 4 | DESCRIPTION | nvarchar(255) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | ISSUESTATE | numeric | 否 |

## TBLPRDSTAGESTEPSETDETAIL — 产品/工艺阶段步骤SET明细

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PRODUCTNO | nvarchar(50) | 否 |
| 2 | STAGENO | nvarchar(50) | 是 |
| 3 | OPNO | nvarchar(50) | 是 |
| 4 | EQUIPMENTTYPE | nvarchar(50) | 是 |
| 5 | EQUIPMENTNO | nvarchar(50) | 是 |

