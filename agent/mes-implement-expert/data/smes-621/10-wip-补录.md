# smes-621 补录：WIP 在制品/报工/生产批（真·生产独有 112 表）

> **定位**：2026-08-23 批量补录 —— 设计文档《SMES_621数据库设计文档20250313.html》与主字典（01~08）均未覆盖的**真·生产独有**表（仅存于生产库，断连无结构可查）。本次按 8 个业务核心前缀（WIP/PRD/INV/QC/EQP/OP/USR/OEM）分 7 个补录文件批量连库拉取。
> **来源**：连库实测 `INFORMATION_SCHEMA.COLUMNS`（profile `home`，192.168.200.18/sMES_Home_Prod，2026-08-23），7 文件共 **320 表 / 3209 列**。
> **说明**：字段结构断连可查；表级说明为**表名英文词根直译**，仅辅助检索识别，非正式中文语义（个别表若在 [09-core-ops-补录.md](09-core-ops-补录.md) 已有语义备注可交叉对照）。
> **衔接**：主字典 01~08（192 表）｜核心查询补录 [09-core-ops-补录.md](09-core-ops-补录.md)（68 表）｜本文件及 10~16（320 表）｜全量 1472 表分层见 [sMES全量表清单.md](../smes-621-sql/sMES全量表清单.md)。

本文件 112 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| `TBLWIPABNORMALSTATE` | 在制品异常状态 | 7 |
| `TBLWIPADJUSTDETAIL` | 在制品调整明细 | 2 |
| `TBLWIPADJUSTLOG` | 在制品调整历程 | 9 |
| `tblWIPAlLotBasis` | 在制品AL批主档 | 7 |
| `TBLWIPAREAOPERATORLOG` | 在制品区域操作员历程 | 9 |
| `TBLWIPCARRIERSTATE` | 在制品载具状态 | 6 |
| `TBLWIPCARRIERSTATEDETAIL` | 在制品载具状态明细 | 7 |
| `TBLWIPCARRIERSTATEDETAILLOG` | 在制品载具状态明细历程 | 9 |
| `TBLWIPCOMPONENTPROPERTY` | 在制品COMPONENT属性 | 5 |
| `TBLWIPCOMPONENTSTATE` | 在制品COMPONENT状态 | 8 |
| `TBLWIPCONT_ABNORMAL` | 在制品控制_异常 | 9 |
| `TBLWIPCONT_ABNORMALREPAIR` | 在制品控制_异常维修 | 5 |
| `TBLWIPCONT_ATTRIB` | 在制品控制_属性 | 6 |
| `TBLWIPCONT_ATTRIBADJUSTLOG` | 在制品控制_属性调整历程 | 8 |
| `TBLWIPCONT_BIN` | 在制品控制_分箱/容器 | 12 |
| `TBLWIPCONT_COMPONENTATTRIB` | 在制品控制_COMPONENT属性 | 5 |
| `TBLWIPCONT_DEFECTCODE` | 在制品控制_缺陷编码 | 11 |
| `TBLWIPCONT_MATERIALLOTCOMP` | 在制品控制_物料批COMP | 13 |
| `TBLWIPCONT_OPWORKTIME` | 在制品控制_工序作业/工作时间 | 7 |
| `tblWIPCont_PCSNO_WAIT` | 在制品控制_PCS序号编号_等待 | 10 |
| `TBLWIPCONT_PCSNO_WAIT_ERROR` | 在制品控制_PCS序号编号_等待_错误 | 9 |
| `tblWIPCont_PCSNO_WAIT_LOG` | 在制品控制_PCS序号编号_等待_历程 | 11 |
| `TBLWIPCONT_QCITEM` | 在制品控制_质量ITEM | 10 |
| `tblWIPCont_Resource_Log` | 在制品控制_资源_历程 | 16 |
| `TBLWIPCONT_RESOURCE_SHARE` | 在制品控制_资源_共享 | 15 |
| `TBLWIPCONT_RTBIN` | 在制品控制_RT分箱/容器 | 28 |
| `TBLWIPCONT_SAMPLEBIN` | 在制品控制_抽样/样本分箱/容器 | 10 |
| `TBLWIPCONT_SAMPLECOMPONENT` | 在制品控制_抽样/样本COMPONENT | 8 |
| `TBLWIPCONT_SAMPLEPOINT` | 在制品控制_抽样/样本点 | 6 |
| `TBLWIPDISPATCHSTATE_20260315` | 在制品派工状态_20260315 | 27 |
| `TBLWIPECNATTRIB` | 在制品ECN属性 | 5 |
| `TBLWIPECNATTRIBLOG` | 在制品ECN属性历程 | 5 |
| `TBLWIPECNBASIS` | 在制品ECN主档 | 8 |
| `TBLWIPECNLOG` | 在制品ECN历程 | 8 |
| `TBLWIPEQPCONSUMELOG` | 在制品设备耗用历程 | 7 |
| `TBLWIPEQPCONSUMESTATUS` | 在制品设备耗用STATUS | 9 |
| `TBLWIPEQUIPMENTPRODUCTIVITY` | 在制品设备产品IVITY | 11 |
| `TBLWIPERF_ATTACHFILE` | 在制品ERF_附件文件 | 7 |
| `TBLWIPERFBATCHLOT` | 在制品ERF批次批 | 6 |
| `TBLWIPERFCREATEDATA` | 在制品ERF创建数据 | 14 |
| `TBLWIPERFDISPOSITION` | 在制品ERF处置 | 11 |
| `TBLWIPERFHOLDREASON` | 在制品ERF暂停原因 | 9 |
| `TBLWIPERFHOLDREASONDISP` | 在制品ERF暂停原因DISP | 10 |
| `TBLWIPERFLOTDISPOSITION` | 在制品ERF批处置 | 16 |
| `TBLWIPFUTUREHOLD` | 在制品预/未来暂停 | 10 |
| `TBLWIPFUTUREHOLDLOG` | 在制品预/未来暂停历程 | 10 |
| `TBLWIPFUTUREHOLDREASON` | 在制品预/未来暂停原因 | 7 |
| `TBLWIPFUTUREOS` | 在制品预/未来OS | 9 |
| `TBLWIPFUTUREOSLOG` | 在制品预/未来OS历程 | 9 |
| `TBLWIPFUTUREWAIT` | 在制品预/未来等待 | 7 |
| `TBLWIPFUTUREWAITLOG` | 在制品预/未来等待历程 | 7 |
| `TBLWIPGOODBINSTATE` | 在制品良品分箱/容器状态 | 10 |
| `TBLWIPINVCOUNTDETAIL` | 在制品库存盘点/计数明细 | 19 |
| `TBLWIPINVCOUNTDETAIL_MTL` | 在制品库存盘点/计数明细_物料简 | 13 |
| `TBLWIPINVCOUNTDETAIL_PRD` | 在制品库存盘点/计数明细_产品/工艺 | 13 |
| `TBLWIPINVCOUNTSTATE` | 在制品库存盘点/计数状态 | 14 |
| `TBLWIPLAYOUT` | 在制品布局 | 8 |
| `TBLWIPLIMITEDTIMECONTROL` | 在制品限定时间控制 | 8 |
| `TBLWIPLOTADJUSTBASIS` | 在制品批调整主档 | 5 |
| `TBLWIPLOTADJUSTDETAIL` | 在制品批调整明细 | 5 |
| `TBLWIPLOTECNATTRIB` | 在制品批ECN属性 | 10 |
| `TBLWIPLOTGPEQUIPMENT` | 在制品批GP设备 | 4 |
| `TBLWIPLOTLOG_MODULE` | 在制品批历程_工单DULE | 20 |
| `TBLWIPLOTLOG_OPGROUPNO` | 在制品批历程_工序群组编号 | 15 |
| `TBLWIPLOTNOTEXECUTEOP` | 在制品批号TEXECUTE工序 | 2 |
| `TBLWIPLOTOPAREA` | 在制品批工序区域 | 5 |
| `TBLWIPLOTPHASELOG` | 在制品批阶段历程 | 4 |
| `TBLWIPLOTPROCESS` | 在制品批制程 | 13 |
| `tblWIPLotProcessChangeLogDetail` | 在制品批制程变更历程明细 | 4 |
| `TBLWIPLOTPSLOG` | 在制品批PS历程 | 5 |
| `TBLWIPLOTQCLOG` | 在制品批质量历程 | 10 |
| `TBLWIPLOTSPCLOG_INPUTERROR` | 在制品批SPC历程_投入错误 | 5 |
| `TBLWIPLOTSTATE_BACKUP` | 在制品批状态_备份 | 58 |
| `tblWIPMOLinePackConfig` | 在制品工单产线包装配置 | 11 |
| `tblWIPMOLinePackLabelPrinter` | 在制品工单产线包装标签打印ER | 4 |
| `tblWIPMOLinePackRelation` | 在制品工单产线包装关系 | 4 |
| `TBLWIPMOPACKINGBASIS` | 在制品工单包装进G主档 | 42 |
| `TBLWIPMOPACKINGBOX` | 在制品工单包装进GBOX | 9 |
| `TBLWIPMOPACKINGBOXDETAIL` | 在制品工单包装进GBOX明细 | 11 |
| `TBLWIPMOPACKINGCARTON` | 在制品工单包装进GCAR至N | 7 |
| `TBLWIPMOPACKINGPALLET` | 在制品工单包装进GPALLET | 5 |
| `TBLWIPMOPDLINESTATE_TEST` | 在制品工单PD产线状态_TEST | 13 |
| `TBLWIPOPEVENT` | 在制品工序EVENT | 23 |
| `TBLWIPOPGROUPSTATE` | 在制品工序群组状态 | 8 |
| `TBLWIPOPMATERIALSTATE` | 在制品工序物料状态 | 7 |
| `TBLWIPOSDETAIL_COMPONENT` | 在制品OS明细_COMPONENT | 7 |
| `tblWIPOSPurchaseStockinLog` | 在制品OSPURCHASE库存进历程 | 10 |
| `tblWIPOSReturnGoodLog` | 在制品OS退回良品历程 | 9 |
| `TBLWIPPACKINGBASIS` | 在制品包装进G主档 | 9 |
| `TBLWIPPACKINGBOXDETAIL` | 在制品包装进GBOX明细 | 6 |
| `TBLWIPPACKINGLIST_BIN` | 在制品包装进G清单_分箱/容器 | 24 |
| `TBLWIPPACKINGLIST_COMPONENT` | 在制品包装进G清单_COMPONENT | 11 |
| `TBLWIPPACKINGLIST_GENERAL` | 在制品包装进G清单_GENERAL | 10 |
| `TBLWIPPACKINGLISTBASIS` | 在制品包装进G清单主档 | 8 |
| `tblWIPPDLinePositionState` | 在制品PD产线位置状态 | 6 |
| `TBLWIPPNGROUP` | 在制品PN群组 | 4 |
| `TBLWIPRETURN_COMPONENT` | 在制品退回_COMPONENT | 5 |
| `TBLWIPREVERSEBATCH` | 在制品反向/冲销批次 | 4 |
| `TBLWIPREVERSEHISTORY` | 在制品反向/冲销历史 | 11 |
| `TBLWIPREVERSELOG` | 在制品反向/冲销历程 | 14 |
| `TBLWIPREVERSEUNCOMMIT` | 在制品反向/冲销未提交 | 2 |
| `TBLWIPRollBackLog` | 在制品ROLLBACK历程 | 28 |
| `TBLWIPSHIPPINGBASIS` | 在制品SHIPP进G主档 | 12 |
| `TBLWIPSHIPPINGPACKINGLIST` | 在制品SHIPP进G包装进G清单 | 2 |
| `TBLWIPSUM_MATERIAL` | 在制品SUM_物料 | 12 |
| `TBLWIPSUM_MATERIALSTATE` | 在制品SUM_物料状态 | 7 |
| `TBLWIPSUM_RESOURCE` | 在制品SUM_资源 | 11 |
| `TBLWIPTEMP_ATTRIB` | 在制品临时/温度_属性 | 11 |
| `TBLWIPTEMP_COMPONENTATTRIB` | 在制品临时/温度_COMPONENT属性 | 10 |
| `tblWIPTemp_DailyWR_DailyEmpOff` | 在制品临时/温度_日WR_日EMPOFF | 5 |
| `TBLWIPTEMP_QCITEM` | 在制品临时/温度_质量ITEM | 7 |
| `TBLWIPTEMP_SAMPLEBIN` | 在制品临时/温度_抽样/样本分箱/容器 | 10 |

## TBLWIPABNORMALSTATE — 在制品异常状态

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | ABNORMALNO | nvarchar(20) | 否 |
| 3 | POSITION | nvarchar(50) | 否 |
| 4 | LINKNAME | nvarchar(20) | 是 |
| 5 | PRIORITY | numeric | 是 |
| 6 | LOTSERIAL | nvarchar(55) | 是 |
| 7 | ABNORMALQTY | numeric | 否 |

## TBLWIPADJUSTDETAIL — 在制品调整明细

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ADJUSTSERIAL | nvarchar(25) | 否 |
| 2 | REASONNO | nvarchar(20) | 否 |

## TBLWIPADJUSTLOG — 在制品调整历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ADJUSTSERIAL | nvarchar(25) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | INPUTQTY | numeric | 是 |
| 5 | BONUSQTY | numeric | 是 |
| 6 | DEDUCTIONQTY | numeric | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |
| 8 | USERID | nvarchar(10) | 是 |
| 9 | RECORDDATE | datetime | 是 |

## tblWIPAlLotBasis — 在制品AL批主档

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | AllotNo | nvarchar(50) | 否 |
| 2 | LotNo | nvarchar(50) | 否 |
| 3 | FromOPNo | nvarchar(20) | 否 |
| 4 | ToOPNo | nvarchar(20) | 否 |
| 5 | Qty | numeric | 否 |
| 6 | EventTime | datetime | 否 |
| 7 | UserNo | nvarchar(30) | 否 |

## TBLWIPAREAOPERATORLOG — 在制品区域操作员历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | AREANO | nvarchar(20) | 否 |
| 2 | DEPARTMENTNO | nvarchar(20) | 否 |
| 3 | SHIFTNO | nvarchar(20) | 否 |
| 4 | USERNO | nvarchar(30) | 否 |
| 5 | LOGINTIME | datetime | 否 |
| 6 | LOGOUTTIME | datetime | 否 |
| 7 | EXCEPTIONTIME | numeric | 否 |
| 8 | LOGINCOMMENT | nvarchar(255) | 是 |
| 9 | LOGOUTCOMMENT | nvarchar(255) | 是 |

## TBLWIPCARRIERSTATE — 在制品载具状态

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CARRIERNO | nvarchar(50) | 否 |
| 2 | CARRIERCATEGORY | nvarchar(50) | 否 |
| 3 | CARRIERTYPE | nvarchar(50) | 否 |
| 4 | CARRIERSTATE | numeric | 是 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |
| 6 | LOTNO | nvarchar(50) | 是 |

## TBLWIPCARRIERSTATEDETAIL — 在制品载具状态明细

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | CARRIERNO | nvarchar(50) | 否 |
| 2 | CARRIERPOSITION | numeric | 否 |
| 3 | BCIP | nvarchar(50) | 否 |
| 4 | CONTENTID | nvarchar(50) | 否 |
| 5 | FLAG | numeric | 否 |
| 6 | LOTNO | nvarchar(50) | 否 |
| 7 | COMPONENTNO | nvarchar(50) | 否 |

## TBLWIPCARRIERSTATEDETAILLOG — 在制品载具状态明细历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(50) | 否 |
| 2 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 3 | CARRIERNO | nvarchar(50) | 否 |
| 4 | CARRIERPOSITION | numeric | 否 |
| 5 | BCIP | nvarchar(50) | 否 |
| 6 | CONTENTID | nvarchar(50) | 否 |
| 7 | FLAG | numeric | 否 |
| 8 | LOTNO | nvarchar(50) | 否 |
| 9 | COMPONENTNO | nvarchar(50) | 否 |

## TBLWIPCOMPONENTPROPERTY — 在制品COMPONENT属性

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | COMPONENTNO | nvarchar(30) | 否 |
| 3 | PROPERTYNO | nvarchar(20) | 否 |
| 4 | PROPERTYVALUE | nvarchar(255) | 是 |
| 5 | LOTSERIAL | nvarchar(55) | 是 |

## TBLWIPCOMPONENTSTATE — 在制品COMPONENT状态

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | COMPONENTNO | nvarchar(30) | 否 |
| 3 | GOODQTY | numeric | 是 |
| 4 | SCRAPQTY | numeric | 是 |
| 5 | UNITNO | nvarchar(30) | 是 |
| 6 | EXECUTESTATE | numeric | 是 |
| 7 | STATUS | numeric | 否 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |

## TBLWIPCONT_ABNORMAL — 在制品控制_异常

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 是 |
| 2 | OPNO | nvarchar(20) | 是 |
| 3 | ABNORMALNO | nvarchar(20) | 是 |
| 4 | POSITION | nvarchar(50) | 是 |
| 5 | ABNORMALQTY | numeric | 否 |
| 6 | USERNO | nvarchar(30) | 是 |
| 7 | LOTNO | nvarchar(50) | 是 |
| 8 | SHIFTNO | nvarchar(20) | 是 |
| 9 | EVENTTIME | datetime | 是 |

## TBLWIPCONT_ABNORMALREPAIR — 在制品控制_异常维修

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 是 |
| 2 | OPNO | nvarchar(20) | 是 |
| 3 | ABNORMALNO | nvarchar(20) | 是 |
| 4 | REPAIRNO | nvarchar(20) | 是 |
| 5 | DESCRIPTION | nvarchar(255) | 是 |

## TBLWIPCONT_ATTRIB — 在制品控制_属性

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 是 |
| 2 | ATTRIBNO | nvarchar(20) | 是 |
| 3 | ATTRIBVALUE | nvarchar(255) | 是 |
| 4 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 5 | MACHINE_ID | nvarchar(50) | 是 |
| 6 | REPORT_TIME | datetime | 是 |

## TBLWIPCONT_ATTRIBADJUSTLOG — 在制品控制_属性调整历程

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 2 | ATTRIBNO | nvarchar(20) | 否 |
| 3 | COMPONENTNO | nvarchar(30) | 是 |
| 4 | ATTRIBVALUEORG | nvarchar(50) | 是 |
| 5 | ATTRIBVALUENEW | nvarchar(50) | 是 |
| 6 | DESCRIPTION | nvarchar(255) | 是 |
| 7 | REVISOR | nvarchar(30) | 否 |
| 8 | REVISEDATE | datetime | 否 |

## TBLWIPCONT_BIN — 在制品控制_分箱/容器

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | LOTSERIAL | nvarchar(55) | 是 |
| 3 | PROGRAMNO | nvarchar(50) | 是 |
| 4 | PROGRAMVERSION | nvarchar(3) | 是 |
| 5 | BIN1 | numeric | 是 |
| 6 | BIN2 | numeric | 是 |
| 7 | BIN3 | numeric | 是 |
| 8 | BIN4 | numeric | 是 |
| 9 | BIN5 | numeric | 是 |
| 10 | BIN6 | numeric | 是 |
| 11 | BIN7 | numeric | 是 |
| 12 | BIN8 | numeric | 是 |

## TBLWIPCONT_COMPONENTATTRIB — 在制品控制_COMPONENT属性

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 是 |
| 2 | COMPONENTNO | nvarchar(30) | 是 |
| 3 | ATTRIBNO | nvarchar(20) | 是 |
| 4 | ATTRIBVALUE | nvarchar(255) | 是 |
| 5 | LOGGROUPSERIAL | nvarchar(50) | 是 |

## TBLWIPCONT_DEFECTCODE — 在制品控制_缺陷编码

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SPCSERIAL | nvarchar(50) | 是 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOTSERIAL | nvarchar(55) | 是 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | COMPONENTNO | nvarchar(30) | 是 |
| 6 | CODETYPE | nvarchar(10) | 是 |
| 7 | AREA | nvarchar(20) | 是 |
| 8 | AREATYPE | numeric | 是 |
| 9 | POINT | numeric | 是 |
| 10 | DEFECTCODE | nvarchar(20) | 是 |
| 11 | LOGGROUPSERIAL | nvarchar(50) | 是 |

## TBLWIPCONT_MATERIALLOTCOMP — 在制品控制_物料批COMP

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BASELOTNO | nvarchar(50) | 是 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | LOTSERIAL | nvarchar(55) | 是 |
| 4 | MATERIALNO | nvarchar(50) | 是 |
| 5 | MATERIALLEVEL | numeric | 是 |
| 6 | MATERIALTYPE | nvarchar(50) | 是 |
| 7 | USEQTY | numeric | 是 |
| 8 | UNITNO | nvarchar(30) | 是 |
| 9 | MATERIALLOTNO | nvarchar(50) | 是 |
| 10 | LOTQTY | numeric | 是 |
| 11 | EQUIPMENTNO | nvarchar(50) | 是 |
| 12 | COMPONENTNO | nvarchar(30) | 是 |
| 13 | COMPQTY | numeric | 是 |

## TBLWIPCONT_OPWORKTIME — 在制品控制_工序作业/工作时间

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 2 | LOGINSERIAL | nvarchar(20) | 否 |
| 3 | USERNO | nvarchar(30) | 否 |
| 4 | STARTTIME | datetime | 否 |
| 5 | ENDTIME | datetime | 否 |
| 6 | WORKTIME | numeric | 否 |
| 7 | WORKDAY | nvarchar(10) | 否 |

## tblWIPCont_PCSNO_WAIT — 在制品控制_PCS序号编号_等待

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GUID | nvarchar(50) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | OPNO | nvarchar(50) | 是 |
| 4 | TYPE | nvarchar(2) | 是 |
| 5 | EQUIPMENTNO | nvarchar(50) | 是 |
| 6 | PCSNO | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | CREATEBY | nvarchar(50) | 是 |
| 9 | RETRYCOUNT | numeric | 是 |
| 10 | QTY | numeric | 是 |

## TBLWIPCONT_PCSNO_WAIT_ERROR — 在制品控制_PCS序号编号_等待_错误

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GUID | nvarchar(50) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | OPNO | nvarchar(50) | 是 |
| 4 | TYPE | nvarchar(2) | 是 |
| 5 | EQUIPMENTNO | nvarchar(50) | 是 |
| 6 | PCSNO | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | CREATEBY | nvarchar(50) | 是 |
| 9 | EventTime | datetime | 是 |

## tblWIPCont_PCSNO_WAIT_LOG — 在制品控制_PCS序号编号_等待_历程

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GUID | nvarchar(50) | 否 |
| 2 | LOTNO | nvarchar(50) | 是 |
| 3 | OPNO | nvarchar(50) | 是 |
| 4 | TYPE | nvarchar(2) | 是 |
| 5 | EQUIPMENTNO | nvarchar(50) | 是 |
| 6 | PCSNO | nvarchar(50) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | CREATEBY | nvarchar(50) | 是 |
| 9 | EventTime | datetime | 是 |
| 10 | RONO | nvarchar(50) | 是 |
| 11 | QTY | numeric | 是 |

## TBLWIPCONT_QCITEM — 在制品控制_质量ITEM

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | LOTSERIAL | nvarchar(55) | 是 |
| 3 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | SPCSERIAL | nvarchar(50) | 否 |
| 6 | WIPQCITEM | nvarchar(25) | 是 |
| 7 | QCITEMNO | nvarchar(25) | 是 |
| 8 | QCITEMTYPE | numeric | 是 |
| 9 | USERNO | nvarchar(30) | 是 |
| 10 | EVENTTIME | datetime | 是 |

## tblWIPCont_Resource_Log — 在制品控制_资源_历程

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | MONO | nvarchar(50) | 是 |
| 3 | BASELOTNO | nvarchar(50) | 是 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 6 | RESCLASS | numeric | 是 |
| 7 | RESTYPE | nvarchar(50) | 是 |
| 8 | RESITEM | nvarchar(50) | 否 |
| 9 | RESVALUE | numeric | 是 |
| 10 | STDVALUE | numeric | 是 |
| 11 | INPUTQTY | numeric | 是 |
| 12 | USERNO | nvarchar(50) | 否 |
| 13 | EVENTTIME | datetime | 否 |
| 14 | ModifyTime | datetime | 否 |
| 15 | RWOMESNO | nvarchar(50) | 是 |
| 16 | SUBRWOMESNO | nvarchar(50) | 是 |

## TBLWIPCONT_RESOURCE_SHARE — 在制品控制_资源_共享

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | MONO | nvarchar(50) | 否 |
| 3 | LOGGROUPSERIAL | nvarchar(50) | 否 |
| 4 | OPNO | nvarchar(20) | 否 |
| 5 | RESCLASS | numeric | 否 |
| 6 | RESITEM | nvarchar(50) | 否 |
| 7 | RESVALUE | numeric | 是 |
| 8 | STDVALUE | numeric | 否 |
| 9 | INPUTQTY | numeric | 否 |
| 10 | OUTPUTQTY | numeric | 否 |
| 11 | USERNO | nvarchar(30) | 否 |
| 12 | EVENTTIME | datetime | 否 |
| 13 | CREATEDATE | datetime | 否 |
| 14 | ITEMNO | numeric | 否 |
| 15 | MEMO | nvarchar(-1) | 否 |

## TBLWIPCONT_RTBIN — 在制品控制_RT分箱/容器

> 字段数：28 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | LOTSERIAL | nvarchar(55) | 是 |
| 3 | PROGRAMNO | nvarchar(50) | 是 |
| 4 | PROGRAMVERSION | nvarchar(3) | 是 |
| 5 | RTORDER | numeric | 是 |
| 6 | RQTY | numeric | 是 |
| 7 | SCRAPQTY | numeric | 是 |
| 8 | LOSSQTY | numeric | 是 |
| 9 | SAMPLEBINNO | nvarchar(10) | 是 |
| 10 | STARTTIME | datetime | 是 |
| 11 | ENDTIME | datetime | 是 |
| 12 | USERNO | nvarchar(30) | 是 |
| 13 | BIN1 | numeric | 是 |
| 14 | RTBIN1 | numeric | 是 |
| 15 | BIN2 | numeric | 是 |
| 16 | RTBIN2 | numeric | 是 |
| 17 | BIN3 | numeric | 是 |
| 18 | RTBIN3 | numeric | 是 |
| 19 | BIN4 | numeric | 是 |
| 20 | RTBIN4 | numeric | 是 |
| 21 | BIN5 | numeric | 是 |
| 22 | RTBIN5 | numeric | 是 |
| 23 | BIN6 | numeric | 是 |
| 24 | RTBIN6 | numeric | 是 |
| 25 | BIN7 | numeric | 是 |
| 26 | RTBIN7 | numeric | 是 |
| 27 | BIN8 | numeric | 是 |
| 28 | RTBIN8 | numeric | 是 |

## TBLWIPCONT_SAMPLEBIN — 在制品控制_抽样/样本分箱/容器

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | LOTSERIAL | nvarchar(55) | 是 |
| 3 | BIN1 | numeric | 是 |
| 4 | BIN2 | numeric | 是 |
| 5 | BIN3 | numeric | 是 |
| 6 | BIN4 | numeric | 是 |
| 7 | BIN5 | numeric | 是 |
| 8 | BIN6 | numeric | 是 |
| 9 | BIN7 | numeric | 是 |
| 10 | BIN8 | numeric | 是 |

## TBLWIPCONT_SAMPLECOMPONENT — 在制品控制_抽样/样本COMPONENT

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SPCSERIAL | nvarchar(50) | 是 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | OPNO | nvarchar(20) | 是 |
| 5 | COMPONENTNO | nvarchar(30) | 是 |
| 6 | EVENTTIME | datetime | 是 |
| 7 | QCITEMNO | nvarchar(25) | 是 |
| 8 | LOGGROUPSERIAL | nvarchar(50) | 是 |

## TBLWIPCONT_SAMPLEPOINT — 在制品控制_抽样/样本点

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BATCHSERIAL | nvarchar(55) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | COMPONENTNO | nvarchar(30) | 否 |
| 5 | POSITION | nvarchar(20) | 否 |
| 6 | POSITIONVALUE | numeric | 否 |

## TBLWIPDISPATCHSTATE_20260315 — 在制品派工状态_20260315

> 字段数：27 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

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

## TBLWIPECNATTRIB — 在制品ECN属性

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ECNNO | nvarchar(50) | 否 |
| 2 | ATTRIBNO | nvarchar(20) | 否 |
| 3 | ATTRIBVALUE | nvarchar(255) | 否 |
| 4 | OPNO | nvarchar(20) | 否 |
| 5 | ATTRIBTYPE | numeric | 否 |

## TBLWIPECNATTRIBLOG — 在制品ECN属性历程

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ECNNO | nvarchar(50) | 否 |
| 2 | ATTRIBNO | nvarchar(20) | 否 |
| 3 | ATTRIBVALUE | nvarchar(255) | 否 |
| 4 | OPNO | nvarchar(20) | 否 |
| 5 | ATTRIBTYPE | numeric | 否 |

## TBLWIPECNBASIS — 在制品ECN主档

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ECNNO | nvarchar(50) | 否 |
| 2 | STARTDATE | datetime | 是 |
| 3 | ENDDATE | datetime | 是 |
| 4 | ISSUESTATE | numeric | 否 |
| 5 | CUSTOMERNO | nvarchar(50) | 否 |
| 6 | PRODUCTNO | nvarchar(50) | 否 |
| 7 | PRODUCTVERSION | nvarchar(5) | 否 |
| 8 | MONO | nvarchar(50) | 否 |

## TBLWIPECNLOG — 在制品ECN历程

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ECNNO | nvarchar(50) | 否 |
| 2 | STARTDATE | datetime | 否 |
| 3 | ENDDATE | datetime | 否 |
| 4 | ISSUESTATE | numeric | 否 |
| 5 | CUSTOMERNO | nvarchar(50) | 否 |
| 6 | PRODUCTNO | nvarchar(50) | 否 |
| 7 | PRODUCTVERSION | nvarchar(5) | 否 |
| 8 | MONO | nvarchar(50) | 否 |

## TBLWIPEQPCONSUMELOG — 在制品设备耗用历程

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTNO | nvarchar(25) | 否 |
| 2 | CONSUMENO | nvarchar(25) | 否 |
| 3 | CONSUMESEQ | nvarchar(30) | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | ACCQTY | numeric | 是 |
| 7 | ACCPERIOD | numeric | 是 |

## TBLWIPEQPCONSUMESTATUS — 在制品设备耗用STATUS

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTNO | nvarchar(25) | 否 |
| 2 | CONSUMENO | nvarchar(25) | 否 |
| 3 | CONSUMESEQ | nvarchar(30) | 否 |
| 4 | CURQTY | numeric | 否 |
| 5 | CURPERIOD | numeric | 否 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | REVISOR | nvarchar(30) | 是 |
| 9 | REVISEDATE | datetime | 是 |

## TBLWIPEQUIPMENTPRODUCTIVITY — 在制品设备产品IVITY

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EQUIPMENTNO | nvarchar(50) | 否 |
| 2 | STARTTIME | datetime | 否 |
| 3 | ENDTIME | datetime | 否 |
| 4 | NORMALOPERATION | nvarchar(1) | 否 |
| 5 | OPGROUPNO | nvarchar(20) | 否 |
| 6 | WARRANTYNO | nvarchar(10) | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |
| 8 | STATUS | nvarchar(10) | 是 |
| 9 | CREATOR | nvarchar(30) | 是 |
| 10 | CREATEDATE | datetime | 是 |
| 11 | ERPNO | nvarchar(50) | 是 |

## TBLWIPERF_ATTACHFILE — 在制品ERF_附件文件

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | ERFNO | nvarchar(20) | 否 |
| 3 | ATTACHTYPE | nvarchar(10) | 否 |
| 4 | ATTACHNAME | nvarchar(50) | 否 |
| 5 | STATUS | numeric | 否 |
| 6 | ATTACHPOINT | numeric | 否 |
| 7 | ATTACHBODY | varbinary(-1) | 是 |

## TBLWIPERFBATCHLOT — 在制品ERF批次批

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ERFNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | BASELOTNO | nvarchar(50) | 否 |
| 4 | OPNO | nvarchar(20) | 否 |
| 5 | REFLOTFLAG | numeric | 是 |
| 6 | LOGGROUPSERIAL | nvarchar(50) | 是 |

## TBLWIPERFCREATEDATA — 在制品ERF创建数据

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | REPAIRNO | nvarchar(60) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | ERFTYPE | numeric | 否 |
| 4 | OPNO | nvarchar(20) | 否 |
| 5 | ERFQTY | numeric | 否 |
| 6 | HOLDUSER | nvarchar(10) | 否 |
| 7 | HOLDDATE | datetime | 否 |
| 8 | ERFSOURCE | numeric | 否 |
| 9 | LOTISVALID | numeric | 否 |
| 10 | SPCSERIAL | nvarchar(1000) | 是 |
| 11 | QCITEMTYPE | numeric | 是 |
| 12 | CUSTOMERNO | nvarchar(50) | 是 |
| 13 | PRODUCTNO | nvarchar(50) | 是 |
| 14 | HOLDDESCRIPTION | nvarchar(-1) | 是 |

## TBLWIPERFDISPOSITION — 在制品ERF处置

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ERFNO | nvarchar(20) | 否 |
| 2 | DISPORDER | numeric | 否 |
| 3 | DISPTYPE | numeric | 否 |
| 4 | DISPDESCRIPTION | nvarchar(500) | 否 |
| 5 | CREATOR | nvarchar(30) | 否 |
| 6 | CREATEDATE | datetime | 否 |
| 7 | NEXTDISPTYPE | numeric | 否 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |
| 9 | GROUPNO | nvarchar(20) | 否 |
| 10 | NEXTGROUPNO | nvarchar(20) | 是 |
| 11 | CONTACTORNAME | nvarchar(50) | 是 |

## TBLWIPERFHOLDREASON — 在制品ERF暂停原因

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ERFNO | nvarchar(20) | 否 |
| 2 | HOLDITEMNO | nvarchar(50) | 否 |
| 3 | QTY | numeric | 是 |
| 4 | LOTSERIAL | nvarchar(55) | 是 |
| 5 | COMPONENTNO | nvarchar(30) | 否 |
| 6 | GOODQTY | numeric | 是 |
| 7 | SCRAPQTY | numeric | 是 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | AREANO | nvarchar(10) | 否 |

## TBLWIPERFHOLDREASONDISP — 在制品ERF暂停原因DISP

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ERFNO | nvarchar(20) | 否 |
| 2 | HOLDITEMNO | nvarchar(50) | 否 |
| 3 | QTY | numeric | 是 |
| 4 | HOLDDISPOSITION | nvarchar(100) | 是 |
| 5 | LOTSERIAL | nvarchar(55) | 是 |
| 6 | COMPONENTNO | nvarchar(30) | 否 |
| 7 | GOODQTY | numeric | 是 |
| 8 | SCRAPQTY | numeric | 是 |
| 9 | DESCRIPTION | nvarchar(255) | 是 |
| 10 | AREANO | nvarchar(10) | 否 |

## TBLWIPERFLOTDISPOSITION — 在制品ERF批处置

> 字段数：16 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ERFNO | nvarchar(20) | 否 |
| 2 | LOTDISPORDER | numeric | 否 |
| 3 | LOTDISPTYPE | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 否 |
| 5 | CREATEDATE | datetime | 否 |
| 6 | NODEID | nvarchar(80) | 是 |
| 7 | INVENTORYNO | nvarchar(50) | 是 |
| 8 | RETURNTYPE | numeric | 是 |
| 9 | RETURNNODEID | nvarchar(80) | 是 |
| 10 | LOTSERIAL | nvarchar(55) | 是 |
| 11 | DESCRIPTION | nvarchar(255) | 是 |
| 12 | ENGNO | nvarchar(30) | 是 |
| 13 | ENGVERSION | nvarchar(3) | 是 |
| 14 | MODULENO | nvarchar(50) | 是 |
| 15 | MODULEVERSION | nvarchar(3) | 是 |
| 16 | STARTNODEID | nvarchar(80) | 是 |

## TBLWIPFUTUREHOLD — 在制品预/未来暂停

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | HOLDTIME | numeric | 否 |
| 4 | MCLASSNO | nvarchar(30) | 是 |
| 5 | HOLDDESCRIPTION | nvarchar(4000) | 是 |
| 6 | CREATOR | nvarchar(30) | 是 |
| 7 | CREATEDATE | datetime | 是 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |
| 9 | MODULENO | nvarchar(50) | 否 |
| 10 | MODULEVERSION | nvarchar(3) | 否 |

## TBLWIPFUTUREHOLDLOG — 在制品预/未来暂停历程

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | HOLDTIME | numeric | 否 |
| 4 | MCLASSNO | nvarchar(30) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | MODULENO | nvarchar(50) | 否 |
| 8 | MODULEVERSION | nvarchar(3) | 否 |
| 9 | ERFNO | nvarchar(20) | 否 |
| 10 | HOLDDESCRIPTION | nvarchar(4000) | 否 |

## TBLWIPFUTUREHOLDREASON — 在制品预/未来暂停原因

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | HOLDTIME | numeric | 否 |
| 4 | HOLDITEMNO | nvarchar(50) | 否 |
| 5 | LOTSERIAL | nvarchar(55) | 是 |
| 6 | MODULENO | nvarchar(50) | 否 |
| 7 | MODULEVERSION | nvarchar(3) | 否 |

## TBLWIPFUTUREOS — 在制品预/未来OS

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | CREATOR | nvarchar(30) | 否 |
| 4 | CREATEDATE | datetime | 否 |
| 5 | DESCRIPTION | nvarchar(250) | 是 |
| 6 | MODULENO | nvarchar(45) | 否 |
| 7 | MODULEVERSION | nvarchar(3) | 否 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |
| 9 | OSNO | nvarchar(20) | 否 |

## TBLWIPFUTUREOSLOG — 在制品预/未来OS历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | DESCRIPTION | nvarchar(250) | 是 |
| 4 | CREATOR | nvarchar(30) | 否 |
| 5 | CREATEDATE | datetime | 否 |
| 6 | MODULENO | nvarchar(50) | 否 |
| 7 | MODULEVERSION | nvarchar(3) | 否 |
| 8 | SYSOSNO | nvarchar(20) | 是 |
| 9 | REALOSNO | nvarchar(20) | 否 |

## TBLWIPFUTUREWAIT — 在制品预/未来等待

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | WAITTIME | numeric | 否 |
| 4 | DESCRIPTION | nvarchar(100) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | LOTSERIAL | nvarchar(55) | 是 |

## TBLWIPFUTUREWAITLOG — 在制品预/未来等待历程

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | WAITTIME | numeric | 否 |
| 4 | DESCRIPTION | nvarchar(100) | 是 |
| 5 | CREATOR | nvarchar(30) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | WAITNO | nvarchar(20) | 否 |

## TBLWIPGOODBINSTATE — 在制品良品分箱/容器状态

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | LOTSERIAL | nvarchar(55) | 是 |
| 3 | BIN1 | numeric | 是 |
| 4 | BIN2 | numeric | 是 |
| 5 | BIN3 | numeric | 是 |
| 6 | BIN4 | numeric | 是 |
| 7 | BIN5 | numeric | 是 |
| 8 | BIN6 | numeric | 是 |
| 9 | BIN7 | numeric | 是 |
| 10 | BIN8 | numeric | 是 |

## TBLWIPINVCOUNTDETAIL — 在制品库存盘点/计数明细

> 字段数：19 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | COUNTSERIAL | nvarchar(10) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | LOTSERIAL | nvarchar(55) | 否 |
| 4 | LOGGROUPSERIAL | nvarchar(50) | 是 |
| 5 | LOTSTAMP | numeric | 否 |
| 6 | OPNO | nvarchar(20) | 否 |
| 7 | STATUS | numeric | 否 |
| 8 | CURQTY | numeric | 否 |
| 9 | CURUNITNO | nvarchar(30) | 否 |
| 10 | MONO | nvarchar(50) | 否 |
| 11 | PRODUCTNO | nvarchar(50) | 否 |
| 12 | PRODUCTVERSION | nvarchar(5) | 否 |
| 13 | ADJUSTSTATE | numeric | 是 |
| 14 | ADJUSTQTY | numeric | 是 |
| 15 | ADJUSTUSERNO | nvarchar(10) | 是 |
| 16 | ADJUSTDATE | datetime | 是 |
| 17 | NEWCURQTY | numeric | 是 |
| 18 | DATATYPE | nvarchar(10) | 否 |
| 19 | INVENTORYNO | nvarchar(20) | 否 |

## TBLWIPINVCOUNTDETAIL_MTL — 在制品库存盘点/计数明细_物料简

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | COUNTSERIAL | nvarchar(10) | 否 |
| 2 | INVENTORYNO | nvarchar(20) | 否 |
| 3 | LOCATORNO | nvarchar(20) | 否 |
| 4 | MATERIALNO | nvarchar(50) | 否 |
| 5 | MATERIALLOTNO | nvarchar(50) | 否 |
| 6 | CURQTY | numeric | 否 |
| 7 | CURUNITNO | nvarchar(30) | 否 |
| 8 | ADJUSTSTATE | numeric | 是 |
| 9 | NEWCURQTY | numeric | 是 |
| 10 | ADJUSTQTY | numeric | 是 |
| 11 | ADJUSTUSERNO | nvarchar(10) | 是 |
| 12 | ADJUSTDATE | datetime | 是 |
| 13 | DATATYPE | nvarchar(10) | 否 |

## TBLWIPINVCOUNTDETAIL_PRD — 在制品库存盘点/计数明细_产品/工艺

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | COUNTSERIAL | nvarchar(10) | 否 |
| 2 | INVENTORYNO | nvarchar(20) | 否 |
| 3 | LOCATORNO | nvarchar(20) | 否 |
| 4 | PRODUCTNO | nvarchar(50) | 否 |
| 5 | LOTNO | nvarchar(50) | 否 |
| 6 | CURQTY | numeric | 否 |
| 7 | CURUNITNO | nvarchar(30) | 否 |
| 8 | ADJUSTSTATE | numeric | 是 |
| 9 | NEWCURQTY | numeric | 是 |
| 10 | ADJUSTQTY | numeric | 是 |
| 11 | ADJUSTUSERNO | nvarchar(10) | 是 |
| 12 | ADJUSTDATE | datetime | 是 |
| 13 | DATATYPE | nvarchar(10) | 否 |

## TBLWIPINVCOUNTSTATE — 在制品库存盘点/计数状态

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | COUNTSERIAL | nvarchar(10) | 否 |
| 2 | COUNTDATE | datetime | 否 |
| 3 | STATE | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | OPENUSERNO | nvarchar(10) | 是 |
| 7 | OPENDATE | datetime | 是 |
| 8 | CLOSEOPTION | numeric | 是 |
| 9 | CLOSEWIP | numeric | 否 |
| 10 | CLOSERAW | numeric | 否 |
| 11 | CLOSEFGD | numeric | 否 |
| 12 | CLOSESEMI | numeric | 否 |
| 13 | CLOSEMTLWIP | numeric | 否 |
| 14 | CLOSESEMIWIP | numeric | 否 |

## TBLWIPLAYOUT — 在制品布局

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LAYOUTID | uniqueidentifier | 是 |
| 2 | PAGEID | nvarchar(50) | 是 |
| 3 | DIVID | nvarchar(50) | 是 |
| 4 | VIEWDESC | nvarchar(-1) | 是 |
| 5 | CREATEUSERNO | nvarchar(255) | 是 |
| 6 | CREATEDATE | datetime | 是 |
| 7 | MODIFYUSERNO | nvarchar(255) | 是 |
| 8 | MODIFYDATE | datetime | 是 |

## TBLWIPLIMITEDTIMECONTROL — 在制品限定时间控制

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | BOUNDARY | nvarchar(5) | 否 |
| 3 | REFERENCENO | nvarchar(50) | 否 |
| 4 | REFERENCEVERSION | nvarchar(3) | 否 |
| 5 | FROMOPENDTIME | datetime | 否 |
| 6 | FROMOPNO | nvarchar(20) | 否 |
| 7 | TOOPNO | nvarchar(20) | 否 |
| 8 | MOTYPENO | numeric | 否 |

## TBLWIPLOTADJUSTBASIS — 在制品批调整主档

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | AdjustNo | nvarchar(50) | 否 |
| 2 | LotNo | nvarchar(50) | 否 |
| 3 | Qty | numeric | 否 |
| 4 | EventTime | datetime | 否 |
| 5 | UserNo | nvarchar(30) | 否 |

## TBLWIPLOTADJUSTDETAIL — 在制品批调整明细

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | AdjustNo | nvarchar(50) | 否 |
| 2 | NodeID | nvarchar(80) | 否 |
| 3 | OPNo | nvarchar(50) | 否 |
| 4 | OrgQty | numeric | 否 |
| 5 | NewQty | numeric | 否 |

## TBLWIPLOTECNATTRIB — 在制品批ECN属性

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | ECNNO | nvarchar(50) | 否 |
| 3 | ATTRIBNO | nvarchar(20) | 否 |
| 4 | ATTRIBVALUE | nvarchar(255) | 否 |
| 5 | ISSUESTATE | numeric | 否 |
| 6 | OPNO | nvarchar(20) | 否 |
| 7 | ATTRIBTYPE | numeric | 否 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |
| 9 | ACTIVESTARTDATE | datetime | 是 |
| 10 | ACTIVEENDDATE | datetime | 是 |

## TBLWIPLOTGPEQUIPMENT — 在制品批GP设备

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | EQUIPMENTNO | nvarchar(50) | 否 |

## TBLWIPLOTLOG_MODULE — 在制品批历程_工单DULE

> 字段数：20 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BASELOTNO | nvarchar(50) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | MODULESERIAL | nvarchar(50) | 否 |
| 4 | MODULENODEID | nvarchar(80) | 否 |
| 5 | MODULENO | nvarchar(50) | 否 |
| 6 | MODULEVERSION | nvarchar(3) | 否 |
| 7 | MODULESTAGENO | nvarchar(50) | 否 |
| 8 | MODULESEQUENCE | numeric | 否 |
| 9 | STATUS | numeric | 否 |
| 10 | ARRIVETIME | datetime | 否 |
| 11 | STARTTIME | datetime | 是 |
| 12 | ENDTIME | datetime | 是 |
| 13 | INPUTQTY | numeric | 是 |
| 14 | INPUTUNITNO | nvarchar(30) | 是 |
| 15 | GOODQTY | numeric | 是 |
| 16 | FAILQTY | numeric | 是 |
| 17 | GOODUNITNO | nvarchar(30) | 是 |
| 18 | COMPLETEFLAG | numeric | 否 |
| 19 | OPGROUPNO | nvarchar(20) | 是 |
| 20 | MONO | nvarchar(50) | 是 |

## TBLWIPLOTLOG_OPGROUPNO — 在制品批历程_工序群组编号

> 字段数：15 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |
| 3 | OPGROUPNO | nvarchar(20) | 否 |
| 4 | STARTTIME | datetime | 是 |
| 5 | ENDTIME | datetime | 是 |
| 6 | INPUTTIME | numeric | 是 |
| 7 | MONO | nvarchar(16) | 是 |
| 8 | SHIFTNO | nvarchar(6) | 是 |
| 9 | GOODQTY | numeric | 是 |
| 10 | FAILQTY | numeric | 是 |
| 11 | DESCRIPTION | nvarchar(255) | 是 |
| 12 | CREATOR | nvarchar(30) | 是 |
| 13 | CREATEDATE | datetime | 是 |
| 14 | TURNTOERPSTATE | numeric | 是 |
| 15 | ERPNO | nvarchar(16) | 是 |

## TBLWIPLOTNOTEXECUTEOP — 在制品批号TEXECUTE工序

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | OPNO | nvarchar(20) | 否 |

## TBLWIPLOTOPAREA — 在制品批工序区域

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | NODEID | nvarchar(80) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | AREANO | nvarchar(20) | 否 |
| 5 | LOTSERIAL | nvarchar(55) | 是 |

## TBLWIPLOTPHASELOG — 在制品批阶段历程

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | LOTSERIAL | nvarchar(50) | 否 |
| 3 | PHASENO | numeric | 否 |
| 4 | EVENTTIME | datetime | 否 |

## TBLWIPLOTPROCESS — 在制品批制程

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | PSNO | nvarchar(50) | 否 |
| 3 | PROCESSORDER | numeric | 否 |
| 4 | PROCESSNO | nvarchar(64) | 是 |
| 5 | OPNO | nvarchar(50) | 否 |
| 6 | NODEID | nvarchar(80) | 否 |
| 7 | PSORDER | numeric | 否 |
| 8 | HAVECOMPONENT | numeric | 否 |
| 9 | HAVELEVEL | numeric | 否 |
| 10 | LOTSERIAL | nvarchar(55) | 是 |
| 11 | PROCESSVERSION | nvarchar(3) | 否 |
| 12 | NODEVERSION | nvarchar(3) | 否 |
| 13 | STARTNODEID | nvarchar(80) | 否 |

## tblWIPLotProcessChangeLogDetail — 在制品批制程变更历程明细

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ID | nvarchar(64) | 否 |
| 2 | ParentId | nvarchar(64) | 否 |
| 3 | OpNo | nvarchar(64) | 否 |
| 4 | NodeId | nvarchar(80) | 否 |

## TBLWIPLOTPSLOG — 在制品批PS历程

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | PSSEQUENCE | numeric | 是 |
| 3 | PSNO | nvarchar(50) | 是 |
| 4 | BASELOTNO | nvarchar(50) | 是 |
| 5 | LOTSERIAL | nvarchar(55) | 是 |

## TBLWIPLOTQCLOG — 在制品批质量历程

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(50) | 否 |
| 2 | PRODUCTNO | nvarchar(50) | 是 |
| 3 | EQUIPMENTNO | nvarchar(50) | 是 |
| 4 | OPNO | nvarchar(30) | 是 |
| 5 | LOTNO | nvarchar(50) | 是 |
| 6 | QCMETHOD | numeric | 是 |
| 7 | GROUPID | nvarchar(100) | 是 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | CREATOR | nvarchar(30) | 是 |
| 10 | CREATEDATE | datetime | 是 |

## TBLWIPLOTSPCLOG_INPUTERROR — 在制品批SPC历程_投入错误

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | QCFORMNO | nvarchar(50) | 否 |
| 2 | SID | numeric | 否 |
| 3 | ERRORNO | nvarchar(20) | 否 |
| 4 | ERRORTYPE | numeric | 否 |
| 5 | ERRORQTY | numeric | 否 |

## TBLWIPLOTSTATE_BACKUP — 在制品批状态_备份

> 字段数：58 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

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

## tblWIPMOLinePackConfig — 在制品工单产线包装配置

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ComputerName | nvarchar(50) | 否 |
| 2 | PDLineNo | nvarchar(50) | 否 |
| 3 | MONo | nvarchar(50) | 否 |
| 4 | L1_PackFlag | numeric | 否 |
| 5 | L2_PackFlag | numeric | 否 |
| 6 | L3_PackFlag | numeric | 否 |
| 7 | L4_PackFlag | numeric | 否 |
| 8 | L5_PackFlag | numeric | 否 |
| 9 | L6_PackFlag | numeric | 否 |
| 10 | Creator | nvarchar(30) | 否 |
| 11 | CreateDate | datetime | 否 |

## tblWIPMOLinePackLabelPrinter — 在制品工单产线包装标签打印ER

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ComputerName | nvarchar(50) | 否 |
| 2 | PackingLevel | numeric | 否 |
| 3 | LabelType | nvarchar(5) | 否 |
| 4 | PrinterName | nvarchar(100) | 否 |

## tblWIPMOLinePackRelation — 在制品工单产线包装关系

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | From_PackingNo | nvarchar(50) | 否 |
| 2 | From_PackingLevel | numeric | 否 |
| 3 | To_PackingNo | nvarchar(50) | 否 |
| 4 | To_PackingLevel | numeric | 否 |

## TBLWIPMOPACKINGBASIS — 在制品工单包装进G主档

> 字段数：42 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALNAME | nvarchar(255) | 是 |
| 4 | CURRENTFLAG | numeric | 否 |
| 5 | MOCLOSEFLAG | numeric | 否 |
| 6 | STD_PCSQTY | numeric | 否 |
| 7 | STD_PALLETQTY | numeric | 否 |
| 8 | STD_CARTONQTY | numeric | 否 |
| 9 | STD_BOXQTY | numeric | 否 |
| 10 | TOTAL_PALLETQTY | numeric | 否 |
| 11 | TOTAL_CARTONQTY | numeric | 否 |
| 12 | TOTAL_BOXQTY | numeric | 否 |
| 13 | FULL_CARTONQTY | numeric | 否 |
| 14 | LAST_PCSQTY | numeric | 否 |
| 15 | PACK_PALLETQTY | numeric | 否 |
| 16 | PACK_CARTONQTY | numeric | 否 |
| 17 | PACK_BOXQTY | numeric | 否 |
| 18 | PACK_PCSQTY | numeric | 否 |
| 19 | LAST_PALLETNO | nvarchar(100) | 否 |
| 20 | LAST_CARTONNO | nvarchar(100) | 否 |
| 21 | LAST_BOXNO | nvarchar(100) | 否 |
| 22 | NEXT_PALLETQTY | numeric | 否 |
| 23 | NEXT_CARTONQTY | numeric | 否 |
| 24 | NEXT_BOXQTY | numeric | 否 |
| 25 | NEXT_PCSQTY | numeric | 否 |
| 26 | MAX_PALLETNOFN | numeric | 否 |
| 27 | MAX_CARTONNOFN | numeric | 否 |
| 28 | MAX_BOXNOFN | numeric | 否 |
| 29 | CREATEDATE | datetime | 否 |
| 30 | PACKTYPE | numeric | 否 |
| 31 | SN_P_FRONT | nvarchar(100) | 是 |
| 32 | SN_P_BACK | nvarchar(100) | 是 |
| 33 | SN_P_SERIALLENGTH | numeric | 否 |
| 34 | SN_P_DECIMALTYPE | numeric | 否 |
| 35 | SN_C_FRONT | nvarchar(100) | 是 |
| 36 | SN_C_BACK | nvarchar(100) | 是 |
| 37 | SN_C_SERIALLENGTH | numeric | 否 |
| 38 | SN_C_DECIMALTYPE | numeric | 否 |
| 39 | SN_B_FRONT | nvarchar(100) | 是 |
| 40 | SN_B_BACK | nvarchar(100) | 是 |
| 41 | SN_B_SERIALLENGTH | numeric | 否 |
| 42 | SN_B_DECIMALTYPE | numeric | 否 |

## TBLWIPMOPACKINGBOX — 在制品工单包装进GBOX

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | PALLETNO | nvarchar(100) | 否 |
| 4 | CARTONNO | nvarchar(100) | 否 |
| 5 | BOXNO | nvarchar(100) | 否 |
| 6 | NOFN | nvarchar(10) | 否 |
| 7 | FULLFLAG | numeric | 否 |
| 8 | QCCHECK | numeric | 否 |
| 9 | CANCELFALG | numeric | 否 |

## TBLWIPMOPACKINGBOXDETAIL — 在制品工单包装进GBOX明细

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | PALLETNO | nvarchar(100) | 否 |
| 4 | CARTONNO | nvarchar(100) | 否 |
| 5 | BOXNO | nvarchar(100) | 否 |
| 6 | SNNO | nvarchar(100) | 否 |
| 7 | PACKQTY | numeric | 否 |
| 8 | SPLITFLAG | numeric | 否 |
| 9 | MERGEFLAG | numeric | 否 |
| 10 | CREATEDATE | datetime | 是 |
| 11 | PACKTYPE | numeric | 否 |

## TBLWIPMOPACKINGCARTON — 在制品工单包装进GCAR至N

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | PALLETNO | nvarchar(100) | 否 |
| 4 | CARTONNO | nvarchar(100) | 否 |
| 5 | NOFN | nvarchar(10) | 否 |
| 6 | FULLFLAG | numeric | 否 |
| 7 | CANCELFALG | numeric | 否 |

## TBLWIPMOPACKINGPALLET — 在制品工单包装进GPALLET

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MONO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | PALLETNO | nvarchar(100) | 否 |
| 4 | NOFN | nvarchar(10) | 否 |
| 5 | CANCELFALG | numeric | 否 |

## TBLWIPMOPDLINESTATE_TEST — 在制品工单PD产线状态_TEST

> 字段数：13 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PDLINENO | nvarchar(50) | 否 |
| 2 | MONO | nvarchar(50) | 否 |
| 3 | MOQTY | numeric | 否 |
| 4 | MOReleaseQTY | numeric | 是 |
| 5 | PlanStartDate | datetime | 否 |
| 6 | PlanEndDate | datetime | 否 |
| 7 | ActualStartDate | datetime | 是 |
| 8 | ActualEndDate | datetime | 是 |
| 9 | GoodQTY | numeric | 是 |
| 10 | ScrapQTY | numeric | 是 |
| 11 | FinishRate | numeric | 是 |
| 12 | Status | numeric | 是 |
| 13 | ModifyDate | datetime | 是 |

## TBLWIPOPEVENT — 在制品工序EVENT

> 字段数：23 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | EVENTID | nvarchar(100) | 否 |
| 2 | LOTNO | nvarchar(100) | 否 |
| 3 | OPNO | nvarchar(40) | 否 |
| 4 | EVENTTYPE | nvarchar(40) | 否 |
| 5 | LOTSTATE | numeric | 否 |
| 6 | QTY | numeric | 否 |
| 7 | REWORKLOTNO | nvarchar(100) | 是 |
| 8 | END_NODEID | nvarchar(100) | 是 |
| 9 | EQUIPMENTNO | nvarchar(100) | 是 |
| 10 | CREATEBY | nvarchar(30) | 是 |
| 11 | EVENTTIME | datetime | 否 |
| 12 | ROLLBACKBY | nvarchar(30) | 是 |
| 13 | ROLLBACKTIME | datetime | 是 |
| 14 | ORGPROCESSNO | nvarchar(64) | 是 |
| 15 | ORGPROCESSVERSION | nvarchar(40) | 是 |
| 16 | TOPROCESSNO | nvarchar(64) | 是 |
| 17 | TOPROCESSVERSION | nvarchar(40) | 是 |
| 18 | EDITDATE | datetime | 是 |
| 19 | Creator | nvarchar(50) | 是 |
| 20 | CreateDate | datetime | 是 |
| 21 | EDITOR | nvarchar(50) | 是 |
| 22 | GUID | nvarchar(50) | 是 |
| 23 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPOPGROUPSTATE — 在制品工序群组状态

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | GROUPNO | nvarchar(30) | 否 |
| 3 | OPNO | nvarchar(20) | 否 |
| 4 | NODEID | nvarchar(80) | 否 |
| 5 | GROUPTYPE | numeric | 否 |
| 6 | EXECUTEFLAG | numeric | 否 |
| 7 | GROUPNODEID | nvarchar(80) | 否 |
| 8 | LOTSERIAL | nvarchar(55) | 是 |

## TBLWIPOPMATERIALSTATE — 在制品工序物料状态

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OPNO | nvarchar(20) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | UNITNO | nvarchar(30) | 否 |
| 5 | QTY | numeric | 否 |
| 6 | MATERIALTYPE | nvarchar(50) | 是 |
| 7 | INPUTDATE | datetime | 是 |

## TBLWIPOSDETAIL_COMPONENT — 在制品OS明细_COMPONENT

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OSNO | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | COMPONENTNO | nvarchar(30) | 否 |
| 4 | GOODQTY | numeric | 是 |
| 5 | SCRAPQTY | numeric | 是 |
| 6 | UNITNO | nvarchar(30) | 是 |
| 7 | STATUS | numeric | 否 |

## tblWIPOSPurchaseStockinLog — 在制品OSPURCHASE库存进历程

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | OsNo | nvarchar(20) | 否 |
| 2 | ERPNo | nvarchar(50) | 否 |
| 3 | EventTime | datetime | 否 |
| 4 | LotNo | nvarchar(50) | 否 |
| 5 | OpNo | nvarchar(20) | 否 |
| 6 | InputQty | numeric | 否 |
| 7 | ReceiptQty | numeric | 否 |
| 8 | ReturnQty | numeric | 否 |
| 9 | ScrapQty | numeric | 否 |
| 10 | DamageQty | numeric | 否 |

## tblWIPOSReturnGoodLog — 在制品OS退回良品历程

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | MESNO | nvarchar(20) | 否 |
| 2 | OSNO | nvarchar(20) | 否 |
| 3 | LotNO | nvarchar(50) | 否 |
| 4 | ToLoTNO | nvarchar(50) | 否 |
| 5 | OpNO | nvarchar(20) | 否 |
| 6 | Qty | numeric | 否 |
| 7 | Creator | nvarchar(30) | 否 |
| 8 | CreateDate | datetime | 否 |
| 9 | CancelDate | datetime | 是 |

## TBLWIPPACKINGBASIS — 在制品包装进G主档

> 字段数：9 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGNO | nvarchar(25) | 否 |
| 2 | CUSTOMERNO | nvarchar(50) | 否 |
| 3 | PRODUCTNO | nvarchar(50) | 否 |
| 4 | BOXQTY | numeric | 否 |
| 5 | LOTQTY | numeric | 否 |
| 6 | LOTUNITNO | nvarchar(30) | 否 |
| 7 | STATUS | numeric | 否 |
| 8 | CREATOR | nvarchar(30) | 否 |
| 9 | CREATEDATE | datetime | 否 |

## TBLWIPPACKINGBOXDETAIL — 在制品包装进GBOX明细

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGNO | nvarchar(25) | 否 |
| 2 | BOXNO | nvarchar(25) | 否 |
| 3 | LOTNO | nvarchar(50) | 否 |
| 4 | QTY | numeric | 否 |
| 5 | UNITNO | nvarchar(30) | 否 |
| 6 | BASELOTNO | nvarchar(50) | 否 |

## TBLWIPPACKINGLIST_BIN — 在制品包装进G清单_分箱/容器

> 字段数：24 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGLISTNO | nvarchar(20) | 否 |
| 2 | DATATYPE | numeric | 否 |
| 3 | INVENTORYNO | nvarchar(20) | 否 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | LOTSERIAL | nvarchar(55) | 否 |
| 6 | LOCATORNO | nvarchar(20) | 否 |
| 7 | OPNO | nvarchar(20) | 否 |
| 8 | UNITNO | nvarchar(30) | 否 |
| 9 | BIN1 | numeric | 是 |
| 10 | OBIN1 | numeric | 是 |
| 11 | BIN2 | numeric | 是 |
| 12 | OBIN2 | numeric | 是 |
| 13 | BIN3 | numeric | 是 |
| 14 | OBIN3 | numeric | 是 |
| 15 | BIN4 | numeric | 是 |
| 16 | OBIN4 | numeric | 是 |
| 17 | BIN5 | numeric | 是 |
| 18 | OBIN5 | numeric | 是 |
| 19 | BIN6 | numeric | 是 |
| 20 | OBIN6 | numeric | 是 |
| 21 | BIN7 | numeric | 是 |
| 22 | OBIN7 | numeric | 是 |
| 23 | BIN8 | numeric | 是 |
| 24 | OBIN8 | numeric | 是 |

## TBLWIPPACKINGLIST_COMPONENT — 在制品包装进G清单_COMPONENT

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGLISTNO | nvarchar(20) | 否 |
| 2 | DATATYPE | numeric | 否 |
| 3 | INVENTORYNO | nvarchar(20) | 否 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | LOTSERIAL | nvarchar(55) | 否 |
| 6 | LOCATORNO | nvarchar(20) | 否 |
| 7 | COMPONENTNO | nvarchar(30) | 否 |
| 8 | OPNO | nvarchar(20) | 否 |
| 9 | GOODQTY | numeric | 否 |
| 10 | SCRAPQTY | numeric | 否 |
| 11 | UNITNO | nvarchar(30) | 否 |

## TBLWIPPACKINGLIST_GENERAL — 在制品包装进G清单_GENERAL

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGLISTNO | nvarchar(20) | 否 |
| 2 | DATATYPE | numeric | 否 |
| 3 | INVENTORYNO | nvarchar(20) | 否 |
| 4 | LOTNO | nvarchar(50) | 否 |
| 5 | LOTSERIAL | nvarchar(55) | 否 |
| 6 | LOCATORNO | nvarchar(20) | 否 |
| 7 | OPNO | nvarchar(20) | 否 |
| 8 | OQTY | numeric | 否 |
| 9 | QTY | numeric | 否 |
| 10 | UNITNO | nvarchar(30) | 否 |

## TBLWIPPACKINGLISTBASIS — 在制品包装进G清单主档

> 字段数：8 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PACKINGLISTNO | nvarchar(20) | 否 |
| 2 | CUSTOMERNO | nvarchar(50) | 否 |
| 3 | STATUS | numeric | 否 |
| 4 | CREATOR | nvarchar(30) | 是 |
| 5 | CREATEDATE | datetime | 是 |
| 6 | PACKTYPE | numeric | 是 |
| 7 | PACKQTY | numeric | 否 |
| 8 | UNITNO | nvarchar(30) | 否 |

## tblWIPPDLinePositionState — 在制品PD产线位置状态

> 字段数：6 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | PDLineNo | nvarchar(50) | 否 |
| 2 | OPNo | nvarchar(20) | 否 |
| 3 | SubOPNo | nvarchar(50) | 否 |
| 4 | PositionNo | nvarchar(50) | 否 |
| 5 | Creator | nvarchar(30) | 否 |
| 6 | CreateDate | datetime | 否 |

## TBLWIPPNGROUP — 在制品PN群组

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | GROUPNO | nvarchar(30) | 否 |
| 2 | LOTNO | nvarchar(30) | 否 |
| 3 | FIRST | numeric | 是 |
| 4 | EXPSTATUS | numeric | 是 |

## TBLWIPRETURN_COMPONENT — 在制品退回_COMPONENT

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | RETURNNO | nvarchar(20) | 否 |
| 2 | COMPONENTNO | nvarchar(30) | 否 |
| 3 | GOODQTY | numeric | 否 |
| 4 | SCRAPQTY | numeric | 否 |
| 5 | UNITNO | nvarchar(30) | 否 |

## TBLWIPREVERSEBATCH — 在制品反向/冲销批次

> 字段数：4 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | BATCHSERIAL | nvarchar(20) | 否 |
| 2 | LOTNO | nvarchar(50) | 否 |
| 3 | REVERSEID | numeric | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 否 |

## TBLWIPREVERSEHISTORY — 在制品反向/冲销历史

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | REVERSEID | numeric | 否 |
| 3 | REVERSETYPE | numeric | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 否 |
| 5 | OPNO | nvarchar(20) | 否 |
| 6 | COMMITSTATE | numeric | 否 |
| 7 | ORGLOTNO | nvarchar(50) | 是 |
| 8 | DESCRIPTION | nvarchar(255) | 是 |
| 9 | CREATOR | nvarchar(30) | 是 |
| 10 | CREATEDATE | datetime | 是 |
| 11 | COMMITDESC | nvarchar(255) | 是 |

## TBLWIPREVERSELOG — 在制品反向/冲销历程

> 字段数：14 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | REVERSEID | numeric | 否 |
| 3 | REVERSETYPE | numeric | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 否 |
| 5 | OPNO | nvarchar(20) | 否 |
| 6 | ORGLOTNO | nvarchar(50) | 是 |
| 7 | DESCRIPTION | nvarchar(255) | 是 |
| 8 | CREATOR | nvarchar(30) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | EXECUTOR | nvarchar(10) | 否 |
| 11 | EXECUTEDATE | datetime | 否 |
| 12 | EXECUTEDESC | nvarchar(255) | 是 |
| 13 | REVERSEDESCRIPTION | nvarchar(255) | 是 |
| 14 | REVESEDESCRIPTION | nvarchar(255) | 是 |

## TBLWIPREVERSEUNCOMMIT — 在制品反向/冲销未提交

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTSERIAL | nvarchar(55) | 否 |
| 2 | CONDITIONSTRING | nvarchar(450) | 否 |

## TBLWIPRollBackLog — 在制品ROLLBACK历程

> 字段数：28 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LotNo | nvarchar(50) | 否 |
| 2 | EquipmentNo | nvarchar(50) | 是 |
| 3 | OPNo | nvarchar(20) | 是 |
| 4 | INVENTORYNO | nvarchar(20) | 是 |
| 5 | ToOPNo | nvarchar(20) | 否 |
| 6 | FromType | nvarchar(2) | 否 |
| 7 | ToType | nvarchar(2) | 否 |
| 8 | Type | nvarchar(2) | 否 |
| 9 | EventTime | datetime | 否 |
| 10 | UserNo | nvarchar(30) | 否 |
| 11 | RINVQty | numeric | 否 |
| 12 | RGoodQty | numeric | 否 |
| 13 | RScrapQty | numeric | 否 |
| 14 | RLackQty | numeric | 否 |
| 15 | RExcessQty | numeric | 否 |
| 16 | BINVQty | numeric | 否 |
| 17 | BFromQty | numeric | 否 |
| 18 | BToQty | numeric | 否 |
| 19 | INVQty | numeric | 否 |
| 20 | FromQty | numeric | 否 |
| 21 | ToQty | numeric | 否 |
| 22 | RollBackLog_GUID | nvarchar(50) | 否 |
| 23 | EDITDATE | datetime | 是 |
| 24 | Creator | nvarchar(50) | 是 |
| 25 | CreateDate | datetime | 是 |
| 26 | EDITOR | nvarchar(50) | 是 |
| 27 | GUID | nvarchar(50) | 是 |
| 28 | ORIGINGUID | nvarchar(50) | 是 |

## TBLWIPSHIPPINGBASIS — 在制品SHIPP进G主档

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SHIPPINGNO | nvarchar(20) | 否 |
| 2 | CUSTOMERNO | nvarchar(50) | 否 |
| 3 | STATUS | numeric | 否 |
| 4 | SHIPADDR | nvarchar(255) | 否 |
| 5 | TELNO | nvarchar(40) | 是 |
| 6 | CONTACTORNAME | nvarchar(25) | 否 |
| 7 | SHIPPINGDATE | datetime | 是 |
| 8 | CREATOR | nvarchar(30) | 是 |
| 9 | CREATEDATE | datetime | 是 |
| 10 | DESCRIPTION | nvarchar(255) | 是 |
| 11 | SHIPDEST | nvarchar(50) | 是 |
| 12 | FaxNo | nvarchar(40) | 是 |

## TBLWIPSHIPPINGPACKINGLIST — 在制品SHIPP进G包装进G清单

> 字段数：2 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | SHIPPINGNO | nvarchar(20) | 否 |
| 2 | PACKINGLISTNO | nvarchar(20) | 否 |

## TBLWIPSUM_MATERIAL — 在制品SUM_物料

> 字段数：12 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | MONO | nvarchar(50) | 否 |
| 3 | BASELOTNO | nvarchar(50) | 否 |
| 4 | MATERIALNO | nvarchar(50) | 否 |
| 5 | MATERIALLOTNO | nvarchar(50) | 否 |
| 6 | RESVALUE | numeric | 否 |
| 7 | STDVALUE | numeric | 否 |
| 8 | UNITNO | nvarchar(30) | 否 |
| 9 | USERNO | nvarchar(30) | 否 |
| 10 | EVENTTIME | datetime | 否 |
| 11 | MATERIALLEVEL | numeric | 否 |
| 12 | OPNO | nvarchar(20) | 否 |

## TBLWIPSUM_MATERIALSTATE — 在制品SUM_物料状态

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | MATERIALNO | nvarchar(50) | 否 |
| 3 | MATERIALLOTNO | nvarchar(50) | 否 |
| 4 | USEQTY | numeric | 否 |
| 5 | UNITNO | nvarchar(30) | 否 |
| 6 | MATERIALLEVEL | numeric | 否 |
| 7 | OPNO | nvarchar(20) | 否 |

## TBLWIPSUM_RESOURCE — 在制品SUM_资源

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | MONO | nvarchar(50) | 否 |
| 3 | BASELOTNO | nvarchar(50) | 否 |
| 4 | RESCLASS | numeric | 否 |
| 5 | RESTYPE | nvarchar(50) | 否 |
| 6 | RESVALUE | numeric | 否 |
| 7 | STDVALUE | numeric | 否 |
| 8 | INPUTQTY | numeric | 否 |
| 9 | USERNO | nvarchar(30) | 否 |
| 10 | EVENTTIME | datetime | 否 |
| 11 | OPNO | nvarchar(20) | 否 |

## TBLWIPTEMP_ATTRIB — 在制品临时/温度_属性

> 字段数：11 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | ATTRIBTYPE | numeric | 否 |
| 3 | ATTRIBNO | nvarchar(20) | 否 |
| 4 | ATTRIBVALUE | nvarchar(255) | 是 |
| 5 | ATTRIBSOURCE | numeric | 否 |
| 6 | ATTRIBPHASE | numeric | 否 |
| 7 | ATTRIBSEQUENCE | numeric | 否 |
| 8 | SAVETOLOTPROPERTYNO | nvarchar(20) | 是 |
| 9 | LOTSERIAL | nvarchar(55) | 是 |
| 10 | QCItemNo | nvarchar(25) | 是 |
| 11 | ORGATTRIBVALUE | nvarchar(255) | 是 |

## TBLWIPTEMP_COMPONENTATTRIB — 在制品临时/温度_COMPONENT属性

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | COMPONENTNO | nvarchar(30) | 否 |
| 3 | ATTRIBTYPE | numeric | 否 |
| 4 | ATTRIBNO | nvarchar(20) | 否 |
| 5 | ATTRIBVALUE | nvarchar(255) | 是 |
| 6 | ATTRIBSOURCE | numeric | 否 |
| 7 | ATTRIBPHASE | numeric | 否 |
| 8 | ATTRIBSEQUENCE | numeric | 否 |
| 9 | SAVETOLOTPROPERTYNO | nvarchar(20) | 是 |
| 10 | LOTSERIAL | nvarchar(55) | 是 |

## tblWIPTemp_DailyWR_DailyEmpOff — 在制品临时/温度_日WR_日EMPOFF

> 字段数：5 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | ReportDate | date | 否 |
| 2 | UserNo | nvarchar(50) | 否 |
| 3 | ST | datetime | 否 |
| 4 | ET | datetime | 是 |
| 5 | ShiftNo | nvarchar(50) | 是 |

## TBLWIPTEMP_QCITEM — 在制品临时/温度_质量ITEM

> 字段数：7 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 否 |
| 2 | QCITEMNO | nvarchar(25) | 否 |
| 3 | QCITEMTYPE | numeric | 否 |
| 4 | LOTSERIAL | nvarchar(55) | 是 |
| 5 | EXECUTEFLAG | numeric | 否 |
| 6 | EXECUTEORDER | numeric | 是 |
| 7 | REINSPWITH2NDINSPPLAN | numeric | 是 |

## TBLWIPTEMP_SAMPLEBIN — 在制品临时/温度_抽样/样本分箱/容器

> 字段数：10 ｜ 实测来源：INFORMATION_SCHEMA（2026-08-23）

| # | 列名 | 类型 | 可空 |
|---|------|------|:---:|
| 1 | LOTNO | nvarchar(50) | 是 |
| 2 | LOTSERIAL | nvarchar(55) | 是 |
| 3 | BIN1 | numeric | 是 |
| 4 | BIN2 | numeric | 是 |
| 5 | BIN3 | numeric | 是 |
| 6 | BIN4 | numeric | 是 |
| 7 | BIN5 | numeric | 是 |
| 8 | BIN6 | numeric | 是 |
| 9 | BIN7 | numeric | 是 |
| 10 | BIN8 | numeric | 是 |

