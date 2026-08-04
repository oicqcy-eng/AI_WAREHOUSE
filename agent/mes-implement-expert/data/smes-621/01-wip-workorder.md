# 01 在制品/工单/报工 (WIP)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 46 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblFASCont_Partialin](#tblfascont_partialin) | 双单位进站表 | 17 |
| [tblFASCont_PartialOut](#tblfascont_partialout) | 双单位出站表 | 17 |
| [tblINVWIP_ScarpCancelLog](#tblinvwip_scarpcancellog) | 不良品判定入库还原表 | 581 |
| [tblWIPBarCode](#tblwipbarcode) | 条形码标签主档 | 21 |
| [tblWIPBarCodeDetail](#tblwipbarcodedetail) | 条形码标签明细 | 11 |
| [tblWIPBoxPacking](#tblwipboxpacking) | 包装档 | 16 |
| [tblWIPBoxPackingMatrix](#tblwipboxpackingmatrix) | 包装档矩阵明细 | 16 |
| [tblWIPBoxPackingOpenLog](#tblwipboxpackingopenlog) | 拆包履历 | 36 |
| [tblWIPCont_ERPMtlList](#tblwipcont_erpmtllist) | 倒扣料抛转明细表 | 163 |
| [tblWIPCont_PartialInOut](#tblwipcont_partialinout) | 日结生产批进出站历程表 | 63 |
| [tblWIPCont_PCSError](#tblwipcont_pcserror) | 序号不良 | 18 |
| [tblWIPCont_PCSErrorChangeLog](#tblwipcont_pcserrorchangelog) | 序号不良变更纪录 | 19 |
| [tblWIPCont_PCSMaterial](#tblwipcont_pcsmaterial) | 部件序号 | 44 |
| [tblWIPCont_PCSMTLLot](#tblwipcont_pcsmtllot) | 成品与物料批号绑定 | 15 |
| [tblWIPCont_PCSNo](#tblwipcont_pcsno) | 序号对应生产批的关系表成品序号（旧表格） | 47 |
| [tblWIPCONT_PCSNoChangeLog](#tblwipcont_pcsnochangelog) | 成品序号更新记录 | 61 |
| [tblWIPCont_SubProductLog](#tblwipcont_subproductlog) | 副产品产出纪录 | 17 |
| [tblWIPCountPartialinWaitLog](#tblwipcountpartialinwaitlog) | 进站等候时间历程表 | 242 |
| [tblWIPLeanDataAcquisition](#tblwipleandataacquisition) | 精实生产资料 | 8 |
| [tblWIPLeanDataAcquisitionLog](#tblwipleandataacquisitionlog) | 精实生产资料历程 | 8 |
| [tblWIPLot_Report_Offline](#tblwiplot_report_offline) | 报工作业 | 194 |
| [tblWIPLotNetProcessLog](#tblwiplotnetprocesslog) | 生产批网状呆滞数据处理记录表 | 86 |
| [tblWIPLotProcessChangeLog](#tblwiplotprocesschangelog) | 生产批流程变更记录 | 14 |
| [tblWIPLotProcessChangeLog_D](#tblwiplotprocesschangelog_d) | 生产批流程变更记录明细 | 147 |
| [tblWIPLotStateNetLog](#tblwiplotstatenetlog) | 生产批网状制程出站现况变化记录 | 103 |
| [tblWIPMaterialDemandBoard](#tblwipmaterialdemandboard) | 叫料看板 | 20 |
| [tblWIPMaterialDemandBoardLog](#tblwipmaterialdemandboardlog) | 叫料看板处理纪录 | 20 |
| [tblWIPMaterialOfflineBoard](#tblwipmaterialofflineboard) | 下料看板 | 17 |
| [tblWIPMaterialOfflineBoardLog](#tblwipmaterialofflineboardlog) | 下料看板处理纪录 | 99 |
| [tblWipOperatorLotLog](#tblwipoperatorlotlog) | 人员操作生产批记录表 | 50 |
| [tblWIPOPMOtherReason](#tblwipopmotherreason) | 其他工价报工记录表 | 142 |
| [tblWIPOSDetailAlterLog](#tblwiposdetailalterlog) | 外包出货变更表 | 9 |
| [tblWIPOSPurchaseStockin](#tblwipospurchasestockin) | 外包回货入库表 | 25 |
| [tblWIPOSReturnLog](#tblwiposreturnlog) | 外包回货记录表 | 99 |
| [tblWIPPCSDisposition](#tblwippcsdisposition) | 处置纪录 | 19 |
| [tblWIPPCSDispositionClearLog](#tblwippcsdispositionclearlog) | 处置记录解绑记录 | 16 |
| [tblWIPPCSDispositionDetail](#tblwippcsdispositiondetail) | 处置记录明细 | 9 |
| [tblWIPPCSDispositionExchange](#tblwippcsdispositionexchange) | 处置纪录置换表 | 70 |
| [tblWIPPCSNoPacking](#tblwippcsnopacking) | 序号包装档 | 80 |
| [tblWIPPositionCollectMLotLog](#tblwippositioncollectmlotlog) | 产品属性 | 15 |
| [tblWIPPositionCollectMLotSet](#tblwippositioncollectmlotset) | 物料批号绑定 | 15 |
| [tblWIPPositionCollectMTLLog](#tblwippositioncollectmtllog) | 物料名称修改纪录 | 12 |
| [tblWIPPositionCollectMTLSet](#tblwippositioncollectmtlset) | 物料名称设定 | 177 |
| [tblWIPStartingChecklistLog](#tblwipstartingchecklistlog) | 始业点检历程表 | 18 |
| [tblWIPStartingChecklistResult](#tblwipstartingchecklistresult) | 始业点检结果 | 87 |
| [tblWIPTEMPCont_PCSNo](#tblwiptempcont_pcsno) | 成品序号 | 76 |

---

### tblFASCont_Partialin — 双单位进站表（17 字段）
> 主键：LotNo, OpNo, LogGroupSerial, EventTime
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | LogGroupSerial | nvarchar | (50) | √ |  |  |  |  | log序号 |
| 4 | EventTime | datetime |  | √ |  |  |  |  | 创建时间 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | VehicleNo | nvarchar | (50) |  |  |  | √ |  | 载具编号 |
| 7 | VehicleQty | numeric | (16,4) |  |  |  |  |  | 转换后数量 |
| 8 | DoubleUnitQty | numeric | (16,4) |  |  |  |  |  | 双单位数量 |
| 9 | EquipmentNo | nvarchar | (50) |  |  |  |  | 'N/A' | 设备编号 |
| 10 | Molecule | numeric | (16,4) |  |  |  | √ |  | 转换分子：20211208 #104049 修改字段数据类型支持小数 |
| 11 | Denominator | numeric | (16,4) |  |  |  | √ |  | 转换分母：20211208 #104049 修改字段数据类型支持小数 |
| 12 | OSNO | nvarchar | (50) |  |  |  |  | 'N/A' | 外包单号 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblFASCont_PartialOut — 双单位出站表（17 字段）
> 主键：LotNo, OpNo, LogGroupSerial, EventTime, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | LogGroupSerial | nvarchar | (50) | √ |  |  |  |  | log序号 |
| 4 | EventTime | datetime |  | √ |  |  |  |  | 创建时间 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | VehicleNo | nvarchar | (50) |  |  |  | √ |  | 载具编号 |
| 7 | VehicleQty | numeric | (16,4) |  |  |  |  |  | 转换后数量 |
| 8 | DoubleUnitQty | numeric | (16,4) |  |  |  |  |  | 双单位数量 |
| 9 | EquipmentNo | nvarchar | (50) | √ |  |  |  | 'N/A' | 设备编号 |
| 10 | Molecule | numeric | (16,4) |  |  |  | √ | 0 | 转换分子：20211208 #104049 修改字段数据类型支持小数 |
| 11 | Denominator | numeric | (16,4) |  |  |  | √ | 0 | 转换分母：20211208 #104049 修改字段数据类型支持小数 |
| 12 | OSNO | nvarchar | (50) |  |  |  |  | 'N/A' | 外包单号 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblINVWIP_ScarpCancelLog — 不良品判定入库还原表（581 字段）
> 主键：SID, INVENTORYNO, LOTSERIAL, INVENTORYNO, MATERIALNO, MATERIALLOTNO, INVENTORYNO, PRODUCTNO, LOTNO, PRODUCTVERSION, DoFlag, OPNo, INVENTORYNO, PRODUCTNO, LOTNO, PRODUCTVERSION, DOFLAG, OPNO, INVENTORYNO, PRODUCTNO, LOTNO, INPUTDATE, PRODUCTVERSION, OPNO, DoFlag, SESSIONID, JOBNO, JOBNO, MSGCategoryNo, MSGCategoryNo, MSGEmployeeNo, MSGNo, MSGNo, MSGSeq, MSGNo, MSGTarget, PipeNo, MSGNo, MSGTypeNo, Guid, MSGModelNo, MSGMODELNO, FIELDNO, MSGModelNo, ITEMNO, MSGModelSendNo, MSGModelSendNo, ParameterNo, MSGModelSendNo, SendPipeNo, MSGModelSendNo, SendTypeNo, MSGSeq, PipeNo, TriggerType, TriggerService, TypeNo, MSGUserNo, MSGSeq, MATERIALNO, MATERIAL, PROPERTYNO, MATERIALTYPE, VENDORNO, MATERIALNO, VENDORNO, LANGKEY, LANGVALUE, LANGTYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | SID |
| 2 | LotSerial | nvarchar | (50) |  |  |  |  |  | 生产批流水号 |
| 3 | Inventory | nvarchar | (20) |  |  |  |  |  | 仓库编号 |
| 4 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 5 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 6 | ScrapQty | numeric | (12,4) |  |  |  | √ |  | 不良品数量 |
| 7 | CancelQty | numeric | (12,4) |  |  |  | √ |  | 还原数量 |
| 8 | Revisor | nvarchar | (50) |  |  |  |  |  | 修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 仓库编号 |
| 2 | LOTSERIAL | nvarchar | (55) | √ |  |  |  |  | 批号序号 |
| 3 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站 |
| 5 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位 |
| 6 | SCRAPQTY | numeric | (12,4) |  |  |  | √ | 0 | 不良数 |
| 7 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 基础批号 |
| 8 | LOSSQTY | numeric | (12,4) |  |  |  | √ | 0 | 遗失数 |
| 9 | INPUTDATE | datetime |  |  |  |  | √ |  | 投入日期 |
| 10 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | log序号 |
| 11 | BOOKINGFLAG | numeric | (1,0) |  |  |  |  | 0 | 已开立工单 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 2 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站 |
| 3 | ERRORNO | nvarchar | (20) |  |  |  |  |  | 不良编号 |
| 4 | SCRAPQTY | numeric | (12,4) |  |  |  |  |  | 不良数 |
| 5 | EventTime | datetime |  |  |  |  |  |  | 创建时间 |
| 6 | EventUserNo | nvarchar | (10) |  |  |  |  |  | 创建者 |
| 7 | REJUDGETIME | datetime |  |  |  |  |  |  | 误判时间 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批流水号 |
| 2 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | Log序号 |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | ERRORNO | nvarchar | (20) |  |  |  |  |  | 不良原因编号 |
| 6 | SECOND_ERRORNO | nvarchar | (20) |  |  |  |  |  | 重判不良原因编号：ACC：不良品让步良品 |
| 7 | ERRORQTY | numeric | (12,4) |  |  |  |  |  | 不良数量 |
| 8 | TBLWIPCONTERROR_EVENTTIME | datetime |  |  |  |  |  |  | 出站时间 |
| 9 | USERNO | nvarchar | (30) |  |  |  | √ |  | 用户 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修订人 |
| 12 | REVISEDATE | datetime |  |  |  |  | √ |  | 修订日期 |
| 13 | ERPINVENTORYNO | nvarchar | (20) |  |  |  | √ |  | ERP仓库编号 |
| 14 | ERPLOCATORNO | nvarchar | (20) |  |  |  | √ |  | ERP储位编号 |
| 15 | DOC_TYPE | nvarchar | (50) |  |  |  | √ |  | 集成方式 |
| 16 | ERPNO | nvarchar | (50) |  |  |  | √ |  | ERP编号 |
| 17 | SCRINNO | nvarchar | (20) |  |  |  | √ |  | 凭证编号 |
| 18 | WIPINVENTORYNO | nvarchar | (20) |  |  |  |  |  | 线边库别 |
| 19 | EVENTID | nvarchar | (100) |  |  |  | √ |  | 异常事件ID |
| 20 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | DISPOSE_TYPE | nvarchar | (30) |  |  |  | √ |  | 处置类型：REWORK_OP 不良判定重工(作业站) REWORK_PROCESS 不良判定重工(跳流程) CONCESSION 让步 MISJUDGMENT 误判 SCRAP_INV 不良品入库 DEFECT_INV 报废品入库 |
| 23 | PCSNO | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 24 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 库房编号 |
| 2 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 3 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号编号 |
| 4 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 5 | QTY | numeric | (14,6) |  |  |  |  |  | 数量 |
| 6 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料型别 |
| 7 | INPUTDATE | datetime |  |  |  |  | √ |  | 输入日期 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 库房编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 4 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 5 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 6 | INPUTDATE | datetime |  |  |  |  | √ |  | 输入日期 |
| 7 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 8 | BOUGHTEN | numeric | (1,0) |  |  |  |  | 0 | 外购 |
| 9 | BOOKINGFLAG | numeric | (1,0) |  |  |  |  | 0 | 已开立工单 |
| 10 | PRODUCTVERSION | nvarchar | (50) | √ |  |  |  |  | 产品版本 |
| 11 | DoFlag | numeric | (1,0) | √ |  |  |  | 0 | 制程完工标识：0 完工 ; 1 未完工 2  副产品  3  SMT-包装 |
| 12 | ConcessionFlag | numeric | (1,0) |  |  |  | √ |  | 不良品让步 |
| 13 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 14 | QCQTY | numeric | (16,6) |  |  |  |  | 0 | 送验数量 |
| 15 | FinalQTY | numeric | (16,6) |  |  |  |  | 0 | 最终数量 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 库房编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 4 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 5 | DOFLAG | numeric | (1,0) | √ |  |  |  |  | 制程完工标识 |
| 6 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 7 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 8 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 9 | INPUTDATE | datetime |  |  |  |  |  |  | 输入日期 |
| 10 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 主批号 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 库房编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 4 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 5 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 6 | INPUTDATE | datetime |  | √ |  |  |  |  | 输入日期 |
| 7 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 8 | PRODUCTVERSION | nvarchar | (50) | √ |  |  |  |  | 产品版本 |
| 9 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 10 | ConcessionFlag | numeric | (1,0) |  |  |  | √ |  | 不良品让步 |
| 11 | DoFlag | numeric | (1,0) | √ |  |  |  | 0 | 制程完工标识：0 完工 ; 1 未完工 2  副产品  3  SMT-包装 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SENDID | nvarchar | (20) |  |  |  |  |  | 发送ID：原有入库作业，调用一次，产生一个SendID |
| 2 | SYNCSTATUS | numeric | (2,0) |  |  |  |  |  | 同步状态：0：初始 99：失效(已成功被抛转或是被还原) |
| 3 | SYNCTYPE | numeric | (1,0) |  |  |  |  |  | 同步类型(入库类型)：0：良品入库 1：不良品入库-报废 2：不良品入库-不良 3：当站下线 |
| 4 | STOCKINTYPE | numeric | (2,0) |  |  |  |  |  | 入库性质：1 一般 2 联产品 3 多产出主件 4 拆件式入库 5 副产品 回收料 |
| 5 | FACTORYNO | nvarchar | (20) |  |  |  |  |  | 工厂编号 |
| 6 | OPGROUPNO | nvarchar | (20) |  |  |  |  |  | 作业站群组：对应到ERP的WorkStation |
| 7 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站 |
| 8 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 9 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 10 | INVINNO | nvarchar | (20) |  |  |  |  |  | sMES入库单号：良品 FGDInNo 不良 SCRInNo |
| 11 | SHIFTNO | nvarchar | (20) |  |  |  |  |  | 班别编号 |
| 12 | DOC_TYPE | nvarchar | (50) |  |  |  |  |  | ERP单别：ERP入库时的单别 |
| 13 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人：入库时空，有透过界面修改时填入修改人员 |
| 14 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日期：入库时空，有透过界面修改时填入修改日期 |
| 15 | LASTRESENDUSER | nvarchar | (10) |  |  |  |  |  | 最后执行重送人员：入库时空，有透过界面按下重送时，纪录重送人员 |
| 16 | LASTRESENDDATE | datetime |  |  |  |  |  |  | 最后执行重送日期：入库时空，有透过界面按下重送时，纪录重送日期 |
| 17 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SENDID | nvarchar | (20) |  |  |  |  |  | 发送ID：原有入库作业，调用一次，产生一个SendID |
| 3 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 4 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 5 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 6 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 7 | ERPLOTNO | nvarchar | (50) |  |  |  |  |  | 入库批：入库时，将生产批号做修改变成入库批号，没修改时，存与LotNo生产批号相同 |
| 8 | QTY | numeric | (12,4) |  |  |  |  |  | 数量 |
| 9 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位 |
| 10 | DOFLAG | numeric | (1,0) |  |  |  |  |  | 制程完工标识 |
| 11 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站 |
| 12 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 13 | WIPINVENTORYNO | nvarchar | (20) |  |  |  |  |  | 库房编号：入库时sMES线边仓 |
| 14 | ERPINVENTORYNO | nvarchar | (20) |  |  |  |  |  | ERP仓库编号：ERP入库时的仓库 |
| 15 | ERPLOCATORNO | nvarchar | (20) |  |  |  |  |  | ERP储位编号：ERP入库时的仓库除未 |
| 16 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人：入库时空，有透过界面修改时填入修改人员 |
| 17 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日期：入库时空，有透过界面修改时填入修改日期 |
| 18 | DATAID | nvarchar | (100) |  |  |  |  |  | 数据识别码：储存数据的为一识别码 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | FUNCTIONKEY | varchar | (50) |  |  |  |  |  | 作业编号 |
| 3 | CONTITIONSTR | varchar | (255) |  |  |  |  |  | 打印条件 |
| 4 | CMDLINE | varchar | (255) |  |  |  |  |  | Cmd |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SESSIONID | nvarchar | (255) | √ |  |  |  |  | Session ID：用户登录系统所产生的一组ID，用以记录登录状态 |
| 2 | USERNO | nvarchar | (50) |  |  |  | √ |  | 用户编号 |
| 3 | COMPUTERNAME | nvarchar | (255) |  |  |  | √ |  | 计算机名称 |
| 4 | LOGINTIME | datetime |  |  |  |  | √ |  | 登录时间 |
| 5 | R_IDLETIME | datetime |  |  |  |  | √ |  | 空闲时间：空闲时间 |
| 6 | MAC | nvarchar | (100) |  |  |  | √ |  | MAC Address |
| 7 | LOGINTYPE | nvarchar | (100) |  |  |  | √ |  | 登录者类型 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | JOBNO | nvarchar | (25) | √ |  |  |  |  | 工作编号 |
| 2 | JOBNAME | nvarchar | (100) |  |  |  | √ |  | 工作名称：CreateWOWorkReportData_TP：创建工单生产报工单数据 ReplicationDB：将现况事务数据转入报表数据库 DataArchiveByMO：依据工单封存资料 DataArchiveByDate：依据日期封存资料 DataDeleteByDate：依据日期删除资料 SubscriptionReport：订阅报表派送 StartSyncing ShareEQPTime ShareEMPTime MESToJDS_OPOutputDealyMsg MESToJDS_PreOPOutputMsg CreateWOWWorkReportData_T100 CreateWOWWorkReportData_EAI CreateWOWWorkReportData_EAI_Offline OEESummary CreateWOWWorkReportData_WF MESCallERPPRDMTLBasis MESCallERPVendorBasis MESCallERPMaterialVendorMAPBasis MESCallERPEquipmentBasis MESCallERPCustmerBasis MESCallERPInventoryBasis MESCallERPLocatorBasis MESCallERPDepartmentBasis MESCallERPDocumentTypeData MESCallERPShiftBasis MESCallERPOPBasis MESCallERPOPGroupBasis MESCallERPEquipmentProductivity MESCallERPAccessoryBasis MESCallERPUserBasis MESCallERPDeleteLogData AutomaticExpansion CleanLogs |
| 3 | ENABLE | nvarchar | (5) |  |  |  | √ |  | 启用：True：启用  False：停用 |
| 4 | LASTRUNTIME | datetime |  |  |  |  | √ |  | 最近运行时间 |
| 5 | RUNFREQUENT | nvarchar | (12) |  |  |  | √ |  | 执行频率：OnlyOnce：只执行一次 EveryYear：每年一次 EveryMonth：每月一次 EveryWeek：每周一次 EveryDay：每日一次 EveryHour：每小时一次 Every10Min：每10分钟一次 Every5Min：每5分钟一次 Every3Min：每3分钟一次 Every1Min：每1分钟一次 |
| 6 | RUNMIN | nvarchar | (2) |  |  |  | √ |  | 分 |
| 7 | RUNHOUR | nvarchar | (2) |  |  |  | √ | '0' | 小时 |
| 8 | RUNWEEK | nvarchar | (30) |  |  |  | √ |  | 周 |
| 9 | RUNDAY | nvarchar | (2) |  |  |  | √ | '1' | 日：1~31 & EM (EndOfMonth) |
| 10 | RUNMONTH | nvarchar | (2) |  |  |  | √ | '1' | 月 |
| 11 | RUNYEAR | nvarchar | (4) |  |  |  | √ | '1900' | 年 |
| 12 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | EMAILADDRESS | nvarchar | (255) |  |  |  | √ |  | 电子邮件地址 |
| 15 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 16 | PARAMETER01 | nvarchar | (100) |  |  |  | √ |  | 参数 01 |
| 17 | PARAMETER02 | nvarchar | (100) |  |  |  | √ |  | 参数 02 |
| 18 | PARAMETER03 | nvarchar | (100) |  |  |  | √ |  | 参数 03 |
| 19 | PARAMETER04 | nvarchar | (100) |  |  |  | √ |  | 参数 04 |
| 20 | PARAMETER05 | nvarchar | (100) |  |  |  | √ |  | 参数 05 |
| 21 | SERVERNAME | nvarchar | (50) |  |  |  | √ |  | 服务器名称 |
| 22 | PARAMETER06 | nvarchar | (100) |  |  |  | √ |  | 参数 06 |
| 23 | PARAMETER07 | nvarchar | (100) |  |  |  | √ |  | 参数 07 |
| 24 | PARAMETER08 | nvarchar | (100) |  |  |  | √ |  | 参数 08 |
| 25 | PARAMETER09 | nvarchar | (100) |  |  |  | √ |  | 参数 09 |
| 26 | PARAMETER10 | nvarchar | (100) |  |  |  | √ |  | 参数 10 |
| 27 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 28 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 29 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 30 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 31 | TBLMSGMODELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | JOBNO | nvarchar | (25) |  |  |  | √ |  | 工作编号 |
| 2 | STATUS | nvarchar | (16) |  |  |  | √ |  | 状态：Success：成功 Fail：失败 |
| 3 | RETURNMSG | nvarchar | (-1) |  |  |  | √ |  | 回传消息 |
| 4 | SERVERNAME | nvarchar | (127) |  |  |  | √ |  | 服务器名称 |
| 5 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 6 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 7 | RUNTIME | numeric | (20,0) |  |  |  | √ |  | 作业时间 |
| 8 | MEMO | nvarchar | (-1) |  |  |  | √ |  | 备注 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值：0 |
| 15 | TBLMSGMODELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值：0 |
| 1 | JOBNO | nvarchar | (25) | √ |  |  |  |  | 工作编号 |
| 2 | STATUS | nvarchar | (20) |  |  |  | √ |  | 状态：Success：成功 Fail：失败 |
| 3 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 4 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 5 | SERVERNAME | nvarchar | (127) |  |  |  | √ |  | 服务器名称 |
| 6 | JOBNAME | nvarchar | (100) |  |  |  | √ |  | 工作名称 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGCategoryNo | nvarchar | (50) | √ |  |  |  |  | 分类编号：guid |
| 2 | MSGCategory | numeric | (2,0) |  |  |  |  |  | 接收者分类：1.区域，2.区段，3.流程，4.作业站，5.设备 |
| 3 | CategoryValue | nvarchar | (200) |  |  |  |  |  | 分类值：具体值 |
| 4 | TriggerType | numeric | (4,0) |  |  |  |  | -1 | 驱动：1 autorun，工单下线，开立生产批，出站，情景ppt的时机， |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | MODIFY | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 8 | MODIFYDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 9 | MSGModelSendNo | nvarchar | (50) |  |  |  | √ |  | 发送编号：发送编号 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGCategoryNo | nvarchar | (64) | √ |  |  |  |  | 分类编号 |
| 2 | MSGEmployeeNo | nvarchar | (50) | √ |  |  |  |  | 人员编号 |
| 3 | MSGRunDays | numeric | (10,0) |  |  |  | √ | 0 | 运行日期 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | TBLMSGCATEGORYGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 10 | TBLUSRUSERBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGNo | nvarchar | (64) | √ |  |  |  |  | 讯息编号：guid |
| 2 | MSGContent | nvarchar | (-1) |  |  |  |  |  | 讯息内容 |
| 3 | MSGTitle | nvarchar | (100) |  |  |  | √ |  | 标题：ex.紧急工单 |
| 4 | MSGModelSendNo | nvarchar | (36) |  |  |  | √ |  | 模板发送编号 |
| 5 | MSGTypeNos | nvarchar | (400) |  |  |  | √ |  | 标签字符串 |
| 6 | MSGFilePaths | nvarchar | (-1) |  |  |  | √ |  | 档案位置字符串 |
| 7 | Grade | numeric | (1,0) |  |  |  |  | 1 | 紧急度：1 普通，2：中等，3：紧急 |
| 8 | Creater | nvarchar | (50) |  |  |  |  |  | 创建者 发送者 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | LinkProgram | nvarchar | (30) |  |  |  | √ |  | 关联作业：超链接目标代号A01：派工 |
| 11 | LinkParameter | nvarchar | (100) |  |  |  | √ |  | 关联作业传入的参数：超链接参数值。Json字符串。ex.{MoNo：‘MO90421001’} |
| 12 | SendKey | nvarchar | (200) |  |  |  | √ |  | 发送主键：发送的值和本栏位的值一样时不发送。 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGNo | nvarchar | (64) | √ |  |  |  |  | 讯息编号：guid |
| 2 | MSGFileName | nvarchar | (60) |  |  |  |  |  | 讯息附件名称：abc.pdf |
| 3 | MSGFilePath | nvarchar | (60) |  |  |  |  |  | 讯息附件路径：ex.Std MSG Audio 201904 xxxxxx.pdf |
| 4 | MSGSeq | nvarchar | (36) | √ |  |  |  |  | 序号：自增 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGNo | nvarchar | (64) | √ |  |  |  |  | 讯息编号：guid |
| 2 | MSGTarget | nvarchar | (50) | √ |  |  |  |  | 接收者 |
| 3 | SendStatus | nvarchar | (1) |  |  |  |  |  | 讯息状态：N：未发送，S：发送中，Y：发送成功，R：已经阅读，E：发送异常。点击关闭跑马灯时更新为：R已阅读 |
| 4 | IsKeep | nvarchar | (1) |  |  |  |  |  | 保存等级：S：封存，N：一般，D：删除。S：封存后，不会被删除掉 |
| 5 | PipeNo | nvarchar | (10) | √ |  |  |  |  | 途径代号：媒介的代号：系统（Sys），邮件(Mail)，手环(Watch)，微信(WeChat)， Line，BIQS（质量管理模块），跑马灯（Lamp） |
| 6 | SendDescription | nvarchar | (-1) |  |  |  | √ |  | 发送描述：异常讯息的说明 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGNo | nvarchar | (64) | √ |  |  |  |  | 讯息编号：guid |
| 2 | MSGTypeNo | nvarchar | (100) | √ |  |  |  |  | 讯息标签 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | Guid | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | TriggerTarget | nvarchar | (200) |  |  |  |  |  | 触发对象：时间驱动：模板编号的值；事件驱动：服务代号 |
| 3 | Request | nvarchar | (-1) |  |  |  | √ |  | 请求 |
| 4 | Response | nvarchar | (-1) |  |  |  | √ |  | 回复 |
| 5 | Status | nvarchar | (4) |  |  |  |  |  | 对列状态：I：等待处理，R 处理中 |
| 6 | ExceptionMSG | nvarchar | (500) |  |  |  | √ |  | 异常信息 |
| 7 | EventType | numeric | (1,0) |  |  |  |  |  | 事件状态：0 autorun 1 Service |
| 8 | Creater | nvarchar | (50) |  |  |  |  |  | 事件创建者 |
| 9 | CreateTime | datetime |  |  |  |  |  |  | 事件创建时间 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 1 | MSGType | numeric | (1,0) |  |  |  |  |  | 模板类型：1.系统模板;2.定制模板;3.自定模板 |
| 2 | MSGModelNo | nvarchar | (10) | √ |  |  |  |  | 模板编号：组成为：模板类型+2模块码+3位流水码 |
| 3 | MSGModelName | nvarchar | (50) |  |  |  | √ |  | 模板名称 |
| 4 | MSGModelScript | nvarchar | (-1) |  |  |  | √ |  | 自定义查询语句 |
| 5 | TriggerType | numeric | (4,0) |  |  |  |  |  | 驱动：1.时间 2.工单下线 3.开立生产批（分并批） 4.出站 5.设备稼动 6.模具下模 7，模具叫修 |
| 6 | TriggerService | nvarchar | (200) |  |  |  |  | 'N/A' | 驱动代号 |
| 7 | TriggerWhere | nvarchar | (1) |  |  |  |  |  | 触发条件：Y：查询有值触发，N：查询无 值触发 |
| 8 | SendContent | nvarchar | (-1) |  |  |  |  |  | 发送内容模板：工单：{MoNo} 已经下线，请派工。 |
| 9 | ModelDllNo | nvarchar | (100) |  |  |  |  | 'ServicesSTD.Module_MSG.evt_user_custom_check' | dll代号：对应模板的处理逻辑的dll代号 |
| 10 | MSGDescription | nvarchar | (-1) |  |  |  | √ |  | 备注 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Modify | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 14 | ModifyDate | datetime |  |  |  |  | √ |  | 修改时间 |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGMODELNO | nvarchar | (10) | √ |  |  |  |  | 模板编号 |
| 2 | FIELDNO | nvarchar | (50) | √ |  |  |  |  | 占位符代号 |
| 3 | FIELDNAME | nvarchar | (100) |  |  |  | √ |  | 占位符名称 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGModelNo | nvarchar | (10) | √ |  |  |  |  | 模板编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 序号 |
| 3 | CONDFIELD | nvarchar | (50) |  |  |  | √ |  | 查询栏位代号 |
| 4 | CONDDESC | nvarchar | (50) |  |  |  | √ |  | 查询栏位名称 |
| 5 | CONDDATATYPE | numeric | (1,0) |  |  |  | √ |  | 查询栏位类型：1  字符串 2  日期 3  下拉选单 4  数字 5  checkbox 6  日期(起讫) |
| 6 | CONDOPERAND | nvarchar | (30) |  |  |  | √ |  | 预设查询条件 |
| 7 | CONDHINT | nvarchar | (50) |  |  |  |  |  | 查询示意代号 |
| 8 | DEFAULTVALUE | nvarchar | (55) |  |  |  |  |  | 查询预设值 |
| 9 | DATASOURCE | nvarchar | (4000) |  |  |  |  |  | 查询数据来源 |
| 10 | CHECKNECESSARY | nvarchar | (1) |  |  |  |  | 'N' | 检验必需品 |
| 11 | INSERTNAME | nvarchar | (50) |  |  |  |  |  | 插入点名称 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGModelSendNo | nvarchar | (50) | √ |  |  |  |  | 模板发送编号：guid |
| 2 | MSGModelNo | nvarchar | (10) |  |  |  |  |  | 模板编号：组成为：模板类型+5位流水码 |
| 3 | SendTargetType | numeric | (2,0) |  |  |  |  |  | 接收者分类：1.区域，2.区段，3.流程，4.作业站，5.设备，6.人员 |
| 4 | SendTargetValue | nvarchar | (50) |  |  |  |  |  | 发送分类值：区域，区段，流程，作业站，设备，人员，的占位符(变量值)，或者具体值 |
| 5 | Grade | numeric | (1,0) |  |  |  |  |  | 紧急度：1 一般，2：中等，3：紧急 |
| 6 | SendContent | nvarchar | (-1) |  |  |  |  |  | 发送内容模板：工单：{MoNo} 已经下线，请派工。 |
| 7 | LinkProgram | nvarchar | (30) |  |  |  | √ |  | 关联作业：A01：派工。超链接目标代号 |
| 8 | SendKey | nvarchar | (200) |  |  |  | √ |  | 发送主键：发送的值和本栏位的值一样时不发送。 |
| 9 | MSGDescription | nvarchar | (-1) |  |  |  | √ |  | 备注 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Modify | nvarchar | (50) |  |  |  | √ |  | 修改者 |
| 14 | ModifyDate | datetime |  |  |  |  | √ |  | 修改时间 |
| 15 | SLightLevel | numeric | (1,0) |  |  |  | √ | 0 | 灯号级别：0 未启用安灯 1 无记录 2 需记录 |
| 16 | SLightTypeNo | nvarchar | (100) |  |  |  | √ |  | 灯号类型编号：SLEquipment：机台, SLQuality：质量, SLMaterial：物料, SLProd：生产 |
| 17 | ReportId | nvarchar | (50) |  |  |  | √ |  | 回复ID |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | TBLMSGMODELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MSGModelSendNo | nvarchar | (36) | √ |  |  |  |  | 模板发送编号 |
| 2 | ParameterNo | nvarchar | (50) | √ |  |  |  |  | 参数代号 |
| 3 | ParameterValue | nvarchar | (50) |  |  |  |  |  | 参数值 |
| 4 | Relation | nvarchar | (10) |  |  |  |  |  | 运算符：'=，  , , =, , =,like |
| 5 | JsonParameterNo | nvarchar | (255) |  |  |  | √ |  | 数据参数编号 |
| 6 | MSGMODELNO | nvarchar | (10) |  |  |  |  |  | 模板编号：组成为：模板类型+5位流水码 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLMSGMODELSENDGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLMSGMODELBASISPARAMETERSGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGModelSendNo | nvarchar | (36) | √ |  |  |  |  | 发送编号 |
| 2 | SendPipeNo | nvarchar | (50) | √ |  |  |  |  | 途径代号 |
| 3 | TBLMSGMODELSENDGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGModelSendNo | nvarchar | (36) | √ |  |  |  |  | 发送编号 |
| 2 | SendTypeNo | nvarchar | (100) | √ |  |  |  |  | 标签代号 |
| 3 | TBLMSGMODELSENDGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGSeq | numeric | (16,0) | √ |  |  |  |  | 序号 |
| 2 | MSGPhrase | nvarchar | (-1) |  |  |  |  |  | 词组内容 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PipeNo | nvarchar | (10) | √ |  |  |  |  | 途径编号 |
| 2 | PipeName | nvarchar | (50) |  |  |  | √ |  | 途径名称 |
| 3 | DllPath | nvarchar | (200) |  |  |  | √ |  | dll路径和名称 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TriggerType | numeric | (4,0) | √ |  |  |  |  | 驱动：驱动类别 |
| 2 | TriggerService | nvarchar | (200) | √ |  |  |  |  | 驱动代号：驱动服务 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TypeNo | nvarchar | (100) | √ |  |  |  |  | 标签编号 |
| 2 | TypeName | nvarchar | (100) |  |  |  | √ |  | 标签说明 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSGUserNo | nvarchar | (10) | √ |  |  |  |  | 登录者 |
| 2 | MSGSeq | numeric | (16,0) | √ |  |  |  |  | 序号 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号：原物料编号，系统中所指之物料编号仅包括原物料，不含成品、半成品等编号。 |
| 2 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别：定义此物料所属之类别 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 7 | MATERIALNAME | nvarchar | (255) |  |  |  | √ |  | 物料名称：原物料之名称 |
| 8 | MATERIALSPEC | nvarchar | (255) |  |  |  | √ |  | 物料规格：描述此物料的特性与规格 |
| 9 | PUTINPLACE | numeric | (1,0) |  |  |  | √ | 3 | 投料点：2(WIP INV)：此物料放置于线边仓上，使用物料前必须先开立领料单将物料领至指定线边仓，生产批在进站的时间点会自动检查此线边仓是否有足够之物料使用。 3(MO)：此物料是随工单一同作业，一般而言开立工单时物料清单便会随之开立，但此时并不需实际作备料，而是在用料作业站进入时才检查此工单存料现况中是否有足够之物料使用。 |
| 10 | COUNTWAY | numeric | (1,0) |  |  |  | √ | 0 | 计量方法：计量方法包括Standard和Real两种方法 0：Standard，表示以标准用量计算物料使用量 1：Real，表示以用户输入之实际物料使用量为扣量标准 |
| 11 | CHECKLOTNO | numeric | (1,0) |  |  |  | √ | 0 | 是否检查批号：此选项控制了库存、生产报工等作业方式： 0：False，不管控物料批号，系统将视物料批号为N A。 1：True，管控物料批号，所有之进料、退料、扣料动作都必须输入物料批号。 |
| 12 | UNITTYPE | nvarchar | (64) |  |  |  |  |  | 单位类别：选取系统模块所定义之单位别 (如：重量、长度) |
| 13 | SAFEQTY | numeric | (12,4) |  |  |  | √ | 0 | 安全存量：此信息为此物料的安全存量标准，在原物料仓中此数量将作为库房之标准用量依据，低于安全存量的物料系统将发出Email通知库房管理群组。（注：需搭配AUT模块的设置 |
| 14 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号：选取单位类别定义下的单位编号(如：cm、kg) |
| 15 | EX_MTLBASIS1 | nvarchar | (20) |  |  |  | √ |  | EX_MTLBASIS1：延伸字段1 |
| 16 | KEYMATERIALS | numeric | (1,0) |  |  |  | √ | 0 | 是否关键用料：0：是 1：否 |
| 17 | ERPNo | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 18 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段01 |
| 19 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段02 |
| 20 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段03 |
| 21 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段04 |
| 22 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段05 |
| 23 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段06 |
| 24 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段07 |
| 25 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段08 |
| 26 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段09 |
| 27 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段10 |
| 28 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段11 |
| 29 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段12 |
| 30 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段13 |
| 31 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段14 |
| 32 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段15 |
| 33 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段16 |
| 34 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段17 |
| 35 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段18 |
| 36 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段19 |
| 37 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段20 |
| 38 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自订字段21 |
| 39 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自订字段22 |
| 40 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自订字段23 |
| 41 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自订字段24 |
| 42 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自订字段25 |
| 43 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自订字段26 |
| 44 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自订字段27 |
| 45 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自订字段28 |
| 46 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自订字段29 |
| 47 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自订字段30 |
| 48 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段31 |
| 49 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自订字段32 |
| 50 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段33 |
| 51 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自订字段34 |
| 52 | GraphNo | nvarchar | (255) |  |  |  | √ |  | 图号 |
| 53 | QCCategory | nvarchar | (50) |  |  |  | √ | 'N/A' | 品管类别 |
| 54 | ARTICLENO | nvarchar | (50) |  |  |  | √ |  | 货号 |
| 55 | ShelfLife | numeric | (15,6) |  |  |  | √ |  | 保质期：#83902 20201211 朱煜轲 |
| 56 | CheckValidity | numeric | (1,0) |  |  |  | √ | 0 | 是否检验料批有效期：#83902 20201211 朱煜轲 0-否 1-是 |
| 57 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 58 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 59 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MATERIAL | nvarchar | (50) | √ |  |  |  |  | 物料 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 预设值 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  |  | 0 | 签核状态：0 Unfrozen(未签核)1 Pending(签核中) 2 Active(已签核)-1 Unused(不使用) |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLMTLMATERIALBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 13 | TBLMTLMATERIALTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MATERIALTYPE | nvarchar | (50) | √ |  |  |  |  | 物料类别 |
| 2 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态：数据目前状态 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | MaterialTypeName | nvarchar | (50) |  |  |  | √ |  | 物料类别名称 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID：数据键值 |
| 1 | VENDORNO | nvarchar | (20) | √ |  |  |  |  | 供应商编号：此厂商的公司名称 |
| 2 | VENDORNAME | nvarchar | (255) |  |  |  | √ |  | 供应商名称：此厂商的公司名称 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态：数据目前状态 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 7 | ERPNo | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID：数据键值 |
| 1 | VENDORNO | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 2 | CONTACTORNAME | nvarchar | (50) |  |  |  |  |  | 联络人名称 |
| 3 | TELNO | nvarchar | (40) |  |  |  | √ |  | 电话 |
| 4 | FAXNO | nvarchar | (40) |  |  |  | √ |  | 传真 |
| 5 | TITLE | nvarchar | (20) |  |  |  | √ |  | 职称 |
| 6 | ADDRESS | nvarchar | (255) |  |  |  | √ |  | 地址 |
| 7 | EMAIL | nvarchar | (255) |  |  |  | √ |  | 电子邮件 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 14 | TBLMTLMATERIALVENDORGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号：可供应此物料的厂商编号 |
| 2 | VENDORNO | nvarchar | (20) | √ |  |  |  |  | 供货商编号：可供应此物料的厂商编号 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 10 | TBLMTLMATERIALBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LANGKEY | nvarchar | (100) | √ |  |  |  |  | 语系键值 |
| 2 | LANGVALUE | nvarchar | (100) | √ |  |  |  |  | 语系名称 |
| 3 | LANGTYPE | nvarchar | (100) | √ |  |  |  |  | 多国语类型 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPBarCode — 条形码标签主档（21 字段）
> 主键：BarCode
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | BarCode | nvarchar | (50) | √ |  |  |  |  | 条形码标签号 |
| 2 | BarcodeQty | numeric | (23,8) |  |  |  | √ |  | 数量 |
| 3 | MoNo | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | ProductNo | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 5 | ProductVersion | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 9 | BarCodeNo | nvarchar | (50) |  |  |  |  |  | 库存条形码 |
| 10 | LotDate | datetime |  |  |  |  |  |  | 批次日期：条形码打印日期 |
| 11 | ProductDate | datetime |  |  |  |  |  |  | 生产日期：出站日期 |
| 12 | BarCodeVldDate | datetime |  |  |  |  |  |  | 有效日期：出站日期 |
| 13 | CombinationLotNo | nvarchar | (50) |  |  |  | √ |  | 批次号 |
| 14 | LotDesc | nvarchar | (255) |  |  |  | √ |  | 批次补充说明 |
| 15 | CustomerNo | nvarchar | (50) |  |  |  | √ |  | 客户编号 |
| 16 | InState | numeric | (1,0) |  |  |  |  | 0 | 是否已标签入库：0-否 1-是 20201104 朱煜轲 #81109 |
| 17 | OPNo | nvarchar | (50) |  |  |  | √ |  | 作业站编号：20201104 朱煜轲 #81108 |
| 18 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPBarCodeDetail — 条形码标签明细（11 字段）
> 主键：BarCode, LotNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | BarCode | nvarchar | (50) | √ |  |  |  |  | 箱号 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | LotQty | numeric | (23,8) |  |  |  |  |  | 数量 |
| 4 | LotProductDate | datetime |  |  |  |  |  |  | 生产日期 |
| 5 | EventTime | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPBoxPacking — 包装档（16 字段）
> 主键：BoxNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | BoxNo | nvarchar | (50) | √ |  |  |  |  | 包装序号 |
| 2 | ProductNo | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 3 | ProductVersion | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 4 | BoxQty | numeric | (10,0) |  |  |  |  | 0 | 满包数量 |
| 5 | ActualQty | numeric | (10,0) |  |  |  |  | 0 | 实际数量 |
| 6 | BoxLevel | numeric | (1,0) |  |  |  |  |  | 包装阶层：1 2 3 4 5 6 六层 |
| 7 | GroupLabelNO | nvarchar | (50) |  |  |  |  |  | 组合标签 |
| 8 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 9 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 10 | PackDate | datetime |  |  |  |  |  | getdate | 包装日期 |
| 11 | PackUser | nvarchar | (10) |  |  |  |  |  | 人员 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPBoxPackingMatrix — 包装档矩阵明细（16 字段）
> 主键：L1_PackingSN, Seq, InputNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | L1_PackingSN | nvarchar | (50) | √ |  |  |  |  | L1包装箱号 |
| 2 | Seq | numeric | (10,0) | √ |  |  |  |  | 顺序 |
| 3 | InputNo | nvarchar | (50) | √ |  |  |  |  | 投入序号：成品序号;生产批 |
| 4 | InputSource | numeric | (1,0) |  |  |  |  |  | 投入来源：0 成品序号 ;1 生产批号; |
| 5 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 6 | L1_PackingQty | numeric | (10,0) |  |  |  |  | 1 | L1包装数量 |
| 7 | L2_PackingSN | nvarchar | (50) |  |  |  | √ |  | L2包装箱号 |
| 8 | L3_PackingSN | nvarchar | (50) |  |  |  | √ |  | L3包装箱号 |
| 9 | L4_PackingSN | nvarchar | (50) |  |  |  | √ |  | L4包装箱号 |
| 10 | L5_PackingSN | nvarchar | (50) |  |  |  | √ |  | L5包装箱号 |
| 11 | L6_PackingSN | nvarchar | (50) |  |  |  | √ |  | L6包装箱号 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPBoxPackingOpenLog — 拆包履历（36 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | BoxNo | nvarchar | (50) |  |  |  |  |  | 包装序号 |
| 2 | ProductNo | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 3 | ProductVersion | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 4 | BoxQty | numeric | (10,4) |  |  |  | √ | 0 | 满包数量 |
| 5 | ActualQty | numeric | (10,0) |  |  |  | √ | 0 | 实际数量 |
| 6 | BoxLevel | numeric | (1,0) |  |  |  | √ |  | 包装阶层：1 2 3 4 5 6 六层 |
| 7 | GroupLabelNO | nvarchar | (50) |  |  |  |  |  | 组合标签 |
| 8 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 9 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 10 | PackDate | datetime |  |  |  |  | √ |  | 包装日期 |
| 11 | PackUser | nvarchar | (30) |  |  |  | √ |  | 人员 |
| 12 | InputSource | numeric | (1,0) |  |  |  | √ | 1 | 投入来源：0 成品序号 ;1 生产批号; 2 包装序号 |
| 13 | InputQty | numeric | (10,0) |  |  |  | √ | 0 | 投入数量 |
| 14 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 15 | InputNo | nvarchar | (50) |  |  |  |  |  | 投入序号：成品序号;生产批号 |
| 16 | InputBoxNo | nvarchar | (50) |  |  |  | √ |  | 投入BoxNo |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 22 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTSERIAL | nvarchar | (50) |  |  |  | √ |  | 生产批序号 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 3 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 4 | ACCESSORYNO | nvarchar | (50) |  |  |  | √ |  | 模治具编号 |
| 5 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 6 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 7 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 8 | USEQTY | numeric | (12,4) |  |  |  | √ | 0 | 使用数量 |
| 9 | NEXTDAY | datetime |  |  |  |  | √ | getdate | 下一天 |
| 10 | REASONNO | nvarchar | (20) |  |  |  | √ |  | 原因编号 |
| 11 | STATE | nvarchar | (1) |  |  |  | √ |  | 状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPCont_ERPMtlList — 倒扣料抛转明细表（163 字段）
> 主键：ID, SN, LotNo, OPNo, EventTime, EQUIPMENTNO, LotNo, OpNo, PCSNo, EventTime, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (50) | √ |  |  |  |  | ID |
| 2 | SENDID | nvarchar | (50) |  |  |  |  |  | 送件ID |
| 3 | ENTERPRISE_NO | nvarchar | (50) |  |  |  | √ |  | 企业编号 |
| 4 | SITE_NO | nvarchar | (50) |  |  |  | √ |  | 公司编号 |
| 5 | DOC_NO | nvarchar | (50) |  |  |  | √ |  | 文档编号 |
| 6 | DOC_TYPE_NO | nvarchar | (50) |  |  |  | √ |  | 文档类型编号 |
| 7 | CREATE_DATE | nvarchar | (50) |  |  |  | √ |  | 创建时间 |
| 8 | STATUS | nvarchar | (50) |  |  |  | √ |  | 状态 |
| 9 | APPLICANT_NO | nvarchar | (50) |  |  |  | √ |  | 申请人编号 |
| 10 | WORKSTATION_NO | nvarchar | (50) |  |  |  | √ |  | 区域编号 |
| 11 | SEQ | nvarchar | (50) |  |  |  |  |  | 序号 |
| 12 | WO_NO | nvarchar | (50) |  |  |  | √ |  | 工单号 |
| 13 | ITEM_NO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 14 | QTY | nvarchar | (50) |  |  |  | √ |  | 可派工数量 |
| 15 | UNIT_NO | nvarchar | (50) |  |  |  | √ |  | 单位编号 |
| 16 | ITEM_TYPE | nvarchar | (50) |  |  |  | √ |  | 规格类型 |
| 17 | INPUT_DATETIME | nvarchar | (50) |  |  |  | √ |  | 产出时间 |
| 18 | WAREHOUSE_NO | nvarchar | (50) |  |  |  | √ |  | 仓库编号 |
| 19 | LOCATION_NO | nvarchar | (50) |  |  |  | √ |  | 位置编号 |
| 20 | LOT_NO | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 21 | ITEM_FEATURE_NO | nvarchar | (50) |  |  |  | √ |  | 规格功能编号 |
| 22 | REMARK | nvarchar | (50) |  |  |  | √ |  | 备注 |
| 23 | POSITIVE_NEGATIVE | nvarchar | (50) |  |  |  | √ |  | 正版_反版 |
| 24 | REPLACED_ITEM_NO | nvarchar | (50) |  |  |  | √ |  | 替代规格编号 |
| 25 | REPLACED_QTY | nvarchar | (50) |  |  |  | √ |  | 替代料数量 |
| 26 | REPLACED_TYPE | nvarchar | (50) |  |  |  | √ |  | 替代料类别 |
| 27 | ISSUE_TO_TYPE | nvarchar | (50) |  |  |  | √ |  | 数据类型 |
| 28 | SUB_TYPE | nvarchar | (50) |  |  |  | √ |  | 子类型 |
| 29 | REPLACED_ITEM_FEATURE_NO | nvarchar | (50) |  |  |  | √ |  | 替代规格特征编号 |
| 30 | EXPIRY_DATE | nvarchar | (50) |  |  |  | √ |  | 物料有效日期 |
| 31 | OP_NO | nvarchar | (50) |  |  |  | √ |  | 作业站编号 |
| 32 | QPA_MOLECULAR | nvarchar | (50) |  |  |  | √ |  | QPA分子 |
| 33 | QPA_DENOMINATOR | nvarchar | (50) |  |  |  | √ |  | QPA分母 |
| 34 | STD_QTY | nvarchar | (50) |  |  |  | √ |  | 标准批量： |
| 35 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 36 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 37 | UPDATEDATE | datetime |  |  |  |  | √ |  | 更新时间 |
| 38 | UPDATER | nvarchar | (50) |  |  |  | √ |  | 更新人 |
| 39 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 2 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 3 | ERRORNO | nvarchar | (20) |  |  |  | √ |  | 不良原因编号 |
| 4 | ERRORLEVEL | numeric | (1,0) |  |  |  | √ |  | 不良原因等级 |
| 5 | ERRORQTY | numeric | (12,4) |  |  |  | √ |  | 不良数量 |
| 6 | COMPONENTNO | nvarchar | (30) |  |  |  | √ |  | 元件编号 |
| 7 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 8 | REASONTYPE | numeric | (2,0) |  |  |  | √ | 0 | 原因类别：  0：Scrap phenomenon 1：Defect  phenomenon 2： Release (暂停) 3： Bonus (暂停) 4： Mo (暂停) 5：Adjust 6：设备故障、设备维修 7：报废 8 ： 生产暂停 9 ： 重工 10：序号变更  11：Excess 多余  12：Lack 短少   13：缺点   14：让步  15：制造损失(报废)    目前有作用者 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | SCRAPFLAG | numeric | (1,0) |  |  |  |  | 0 | 不良标志：0  未回ERP,1  已回ERP, 整批数量 |
| 11 | EVENTTIME | datetime |  |  |  |  |  | getdate | 结束时间 |
| 12 | DET_ERRORQTY | numeric | (12,4) |  |  |  |  |  | 详细不良数 |
| 13 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 14 | InventoryNo | nvarchar | (20) |  |  |  | √ |  | 线边仓编号：#81223因应不良扣线边库存添加 |
| 15 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 16 | OSNO | nvarchar | (50) |  |  |  | √ |  | 外包单号 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 3 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 4 | ERRORNO | nvarchar | (20) |  |  |  | √ |  | 不良原因编号 |
| 5 | ERRORLEVEL | numeric | (1,0) |  |  |  | √ |  | 不良原因等级 |
| 6 | ERRORQTY | numeric | (12,4) |  |  |  | √ |  | 不良数量 |
| 7 | COMPONENTNO | nvarchar | (30) |  |  |  | √ |  | 元件编号 |
| 8 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 9 | REASONTYPE | numeric | (2,0) |  |  |  | √ |  | 原因类别：  0：Scrap phenomenon 1：Defect phenomenon 2： Release (暂停) 3： Bonus (暂停) 4： Mo (暂停) 5：Adjust 6：设备故障、设备维修 7：报废 8 ： 生产暂停 9 ： 重工 10：序号变更  11：Excess 多余  12：Lack 短少   13：缺点   14：让步  15：制造损失(报废)   目前有作用者 |
| 10 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 11 | SCRAPFLAG | numeric | (1,0) |  |  |  |  |  | 不良标志：0  未回ERP,1  已回ERP, 整批数量 |
| 12 | EVENTTIME | datetime |  |  |  |  |  |  | 结束时间 |
| 13 | DET_ERRORQTY | numeric | (12,4) |  |  |  |  |  | 详细不良数 |
| 14 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 15 | DISPOSETYPE | nvarchar | (20) |  |  |  |  |  | 处置类别：MISJUDGMENT' 误判 'CONCESSION' 让步 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 主批号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批流水号 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | LOTRECORD | nvarchar | (255) |  |  |  | √ | 'N/A' | 生产批纪录 |
| 6 | USERNO | nvarchar | (30) |  |  |  | √ |  | 使用者编号 |
| 7 | EVENTTIME | datetime |  |  |  |  |  |  | 建立时间 |
| 8 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | LOG序号 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SN | nvarchar | (50) | √ |  |  |  |  | SN |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | PCSNO | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 4 | REMARK | nvarchar | (50) |  |  |  | √ |  | 备注 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTSERIAL | nvarchar | (50) |  |  |  |  |  | 生产批序号 |
| 2 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 3 | MATERIALLEVEL | numeric | (1,0) |  |  |  |  |  | 物料／半成品 |
| 4 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 5 | USEQTY | numeric | (16,6) |  |  |  |  |  | 使用数量 |
| 6 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 8 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 9 | UNDISTRIBUTEQTY | numeric | (14,6) |  |  |  | √ |  | 未分配数量 |
| 10 | MESNO | nvarchar | (50) |  |  |  | √ |  | MES编号 |
| 11 | EventTime | datetime |  |  |  |  | √ |  | 到达时间 |
| 12 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 13 | MaterialOption | numeric | (1,0) |  |  |  | √ |  | 物料选项 |
| 14 | ID | nvarchar | (50) |  |  |  | √ |  | 识别ID：#82348 朱煜轲 20201129 |
| 15 | UPDATER | nvarchar | (50) |  |  |  | √ |  | 更新人：#82348 朱煜轲 20201129 |
| 16 | UPDATEDATE | datetime |  |  |  |  | √ |  | 更新时间：#82348 朱煜轲 20201129 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTSERIAL | nvarchar | (50) |  |  |  |  |  | 生产批序号 |
| 2 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 3 | MATERIALLOTNO | nvarchar | (50) |  |  |  |  |  | 物料批号编号 |
| 4 | LOTQTY | numeric | (16,6) |  |  |  |  |  | 批数量 |
| 5 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 6 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | Log序号 |
| 7 | UNDISTRIBUTEQTY | numeric | (14,6) |  |  |  | √ |  | 未分配数量 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EX_MATERIALLOT1 | nvarchar | (20) |  |  |  | √ |  | Ex_MaterialLot1 |
| 10 | EX_MATERIALLOT2 | nvarchar | (20) |  |  |  | √ |  | Ex_MaterialLot2 |
| 11 | EX_MATERIALLOT3 | nvarchar | (20) |  |  |  | √ |  | Ex_MaterialLot3 |
| 12 | Remarks | nvarchar | (255) |  |  |  | √ |  | 备注：OPNo+PutInPlaceType |
| 13 | MainId | nvarchar | (50) |  |  |  | √ |  | ID：tblWIPCont_Material的ID栏位值 #82348 朱煜轲 20201129 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | log序号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EventTime | datetime |  | √ |  |  |  |  | 创建时间 |
| 5 | UserNo | nvarchar | (30) |  |  |  |  |  | 用户编号：使用者编号 |
| 6 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区号 |
| 7 | InputQty | numeric | (12,4) |  |  |  |  |  | 输入数量 |
| 8 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 9 | CHECKINTIME | datetime |  |  |  |  | √ |  | 上工时间 |
| 10 | LotSerial | nvarchar | (55) |  |  |  | √ |  | 批号序号 |
| 11 | NCFileName | nvarchar | (50) |  |  |  | √ |  | NC代码文档 |
| 12 | NCFileVersion | numeric | (4,0) |  |  |  | √ |  | NC代码版本 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | PCSNo | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 4 | EventTime | datetime |  | √ |  |  |  |  | 进站时间 |
| 5 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 6 | SNSTATE | numeric | (1,0) |  |  |  |  | 0 | 序号状态：0-未出站 1-已出站（不在此设备加工状态都算已出站） |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPCont_PartialInOut — 日结生产批进出站历程表（63 字段）
> 主键：EquipmentNo, LotNo, OpNo, InEventTime, IsCurrent, LotNo, OPNo, EventTime, LotNo, OpNo, PCSNo, EventTime, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OpNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | LOG序号 |
| 5 | InEventTime | datetime |  | √ |  |  |  |  | 进站时间 |
| 6 | OutEventTime | datetime |  |  |  |  | √ |  | 出站时间 |
| 7 | IsCurrent | numeric | (1,0) | √ |  |  |  |  | 是否现况记录 |
| 8 | RemainQty | numeric | (16,4) |  |  |  | √ |  | 设备未出数量 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | LastTime | datetime |  |  |  |  | √ |  | 最后参数时间 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 3 | OPNo | nvarchar | (50) | √ |  |  |  |  | 作业站 |
| 4 | EventTime | datetime |  | √ |  |  |  |  | 结束时间 |
| 5 | UserNo | nvarchar | (30) |  |  |  |  |  | 用户：使用者编号 |
| 6 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域 |
| 7 | InputQty | numeric | (12,4) |  |  |  |  |  | 投入量：出站量=良品+报废+短少-多余 |
| 8 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数：出站+多余-报废-短少 |
| 9 | SCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 不良数：报废 |
| 10 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备号：设备编号 |
| 11 | RWOMESNO | nvarchar | (50) |  |  |  |  | 'N/A' | 分量报工标识：给值为「N A」时表示此单据不进行回抛 |
| 12 | LotSerial | nvarchar | (55) |  |  |  | √ |  | 批号序号 |
| 13 | SPLITLOTLOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | 分批生产历程序号：tblWIPLotLog.LogGroupSerial  如果出站拆批此栏位会存值 关联的是拆批后的生产批 |
| 14 | QCFormNo | nvarchar | (30) |  |  |  | √ |  | 检验单单号 |
| 15 | NETGUID | nvarchar | (36) |  |  |  | √ |  | NETGUID |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | HISTORYTYPE | numeric | (1,0) |  |  |  |  | 0 |  |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 22 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 23 | SHIFTNO | nvarchar | (50) |  |  |  | √ |  | 班别 |
| 24 | WORKTIME | numeric | (10,4) |  |  |  | √ |  | 工作时间 |
| 25 | CalendarDay | nvarchar | (50) |  |  |  | √ |  |  |
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | OpNo | nvarchar | (50) | √ |  |  |  |  | 作业站 |
| 3 | PCSNo | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 4 | EventTime | datetime |  | √ |  |  |  |  | 结束时间 |
| 5 | GoodQty | numeric | (12,4) |  |  |  | √ |  | 良品数：出站+多余-报废-短少 |
| 6 | ScrapQty | nvarchar | (12) |  |  |  | √ |  | 不良数：报废 |
| 7 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备号 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 2 | SID | nvarchar | (50) |  |  |  |  |  | SID |
| 3 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPCont_PCSError — 序号不良（18 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | Master_SID | nvarchar | (50) |  |  |  |  |  | 成品不良识别码 |
| 2 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 3 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 4 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 5 | SubOPSequence | numeric | (4,0) |  |  |  |  |  | 工序 |
| 6 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 7 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 8 | PCSNo | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 9 | ReasonNo | nvarchar | (20) |  |  |  |  |  | 原因编号 |
| 10 | StatusCode | nvarchar | (2) |  |  |  |  | '0' | 状态码：0：Default 1：置换处置 2：维修处置 3：报废处置 4    单次维修 9：纯粹记录，不处置 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 15 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 16 | SOURCETYPE | nvarchar | (1) |  |  |  |  | '1' | 来源型别：1.序号收集；2.首检；3.巡检; |
| 17 | SOURCEID | nvarchar | (50) |  |  |  | √ |  | 来源单号：‘’；检验单号(QcformNo)；检验单号(QcformNo) |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPCont_PCSErrorChangeLog — 序号不良变更纪录（19 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | Master_SID | nvarchar | (50) |  |  |  | √ |  | 成品不良识别码 |
| 2 | PDLineNo | nvarchar | (50) |  |  |  | √ |  | 生产线编号 |
| 3 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 4 | PositionNo | nvarchar | (50) |  |  |  | √ |  | 工位编号 |
| 5 | SubOPSequence | numeric | (4,0) |  |  |  | √ |  | 工序 |
| 6 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | 生产历程序号 |
| 7 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批编号 |
| 8 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 9 | ReasonNo | nvarchar | (20) |  |  |  | √ |  | 原因编号 |
| 10 | EventTime | datetime |  |  |  |  | √ |  | 建立时间 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 15 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPCont_PCSMaterial — 部件序号（44 字段）
> 主键：Master_SID, SID, MASTER_SID, SID, EQUIPMENTNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | Master_SID | nvarchar | (50) | √ |  |  |  |  | 成品不良识别码 |
| 2 | SID | nvarchar | (50) | √ |  |  |  |  | SID |
| 3 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 4 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 5 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | PCSNo | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 7 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 8 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位 |
| 9 | SubOPSequence | numeric | (4,0) |  |  |  |  |  | 工序 |
| 10 | MaterialType | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 11 | UnitName | nvarchar | (50) |  |  |  |  |  | 部件型别名称 |
| 12 | MaterialUnitNo | nvarchar | (50) |  |  |  |  |  | 部件序号 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 16 | CollectMaterialOnly | numeric | (1,0) |  |  |  | √ | 0 | 只搜集部件：工位机搜集序号用，1表示此次搜集只扫描部件未扫产品序号，产品序号预设为第一个部件的序号 |
| 17 | ORGPCSNO | nvarchar | (50) |  |  |  | √ |  | 原始成品序号：工位机搜集序号用，若只搜集部件时，这边会记录原始刷入序号（等于第一笔部件序号） |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | TBLWIPCONT_PCSNOGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | MASTER_SID | nvarchar | (50) | √ |  |  |  |  | 成品不良识别码 |
| 3 | SID | nvarchar | (50) | √ |  |  |  |  | SID |
| 4 | BACKUPTYPE | nvarchar | (1) |  |  |  |  |  | 备份型别：1 成品解绑；2 序号处置解绑 |
| 5 | BACKUPFROMGUID | nvarchar | (64) |  |  |  |  |  | 备份来源GUID |
| 6 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 7 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 8 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 9 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 10 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 11 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 12 | SUBOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 工序 |
| 13 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料型别 |
| 14 | UNITNAME | nvarchar | (50) |  |  |  |  |  | 部件型别名称 |
| 15 | MATERIALUNITNO | nvarchar | (50) |  |  |  |  |  | 部件序号 |
| 16 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 17 | COLLECTMATERIALONLY | numeric | (1,0) |  |  |  |  |  | 只搜集部件：工位机搜集序号用，1表示此次搜集只扫描部件未扫产品序号，产品序号预设为第一个部件的序号 |
| 18 | ORGPCSNO | nvarchar | (50) |  |  |  | √ |  | 原始成品序号：工位机搜集序号用，若只搜集部件时，这边会记录原始刷入序号（等于第一笔部件序号） |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPCont_PCSMTLLot — 成品与物料批号绑定（15 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | Master_SID | nvarchar | (50) |  |  |  |  |  | 成品不良识别码 |
| 2 | SID | nvarchar | (50) |  |  |  |  |  | 识别码 |
| 3 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 4 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 5 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | PCSNo | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 7 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 8 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 9 | SubOPSequence | numeric | (4,0) |  |  |  |  |  | 工序 |
| 10 | MaterialName | nvarchar | (255) |  |  |  |  |  | 物料名称 |
| 11 | MaterialLotNo | nvarchar | (255) |  |  |  |  |  | 物料批号：20210111：Tim将长度由50加长到255，以配合MaterialName的长度。 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 14 | MaterialNo | nvarchar | (50) |  |  |  |  | '' |  |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPCont_PCSNo — 序号对应生产批的关系表成品序号（旧表格）（47 字段）
> 主键：SID, SID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码 |
| 2 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产历进程号 |
| 3 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 4 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | PCSNo | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 6 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 7 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 8 | SubOPSequence | numeric | (4,0) |  |  |  |  |  | 工序 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | PRINTLABELNUM | numeric | (2,0) |  |  |  | √ |  | 打印标签数量：-1为外来条形码绑定、mes生产成为0，打印一次加1 |
| 12 | PCSStatus | nvarchar | (1) |  |  |  | √ | 'N' | 序号状态：N 正常 R 送修中、C 继续生产、 F 结束生产、S 报废 |
| 13 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 14 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：记录最近一次进出站的设备编号 |
| 15 | SMTMaintainNo | nvarchar | (50) |  |  |  | √ |  | 维修单号：最近一次维修单号 内部产生的维护单号产品修复单为PYYYYMMDDXXXX |
| 16 | DisposeResult | nvarchar | (1) |  |  |  | √ |  | 处置编号：C 继续生产、F 结束生产、S 报废 |
| 17 | Reported | numeric | (1,0) |  |  |  | √ |  | 已出站：0 未报工 1 已报工 出站后将该LOT的序号标为已报工 考虑到性能问题，改为单独表记录（tblWIPPCSNoPartialOut） |
| 18 | OrgPCSNo | nvarchar | (50) |  |  |  | √ |  | 原始成品序号 |
| 19 | IsActive | numeric | (1,0) |  |  |  |  | 1 | 目前状态：0 No 1 Yes 1表示该笔是最新记录 |
| 20 | PRINTLABLENUM | numeric | (2,0) |  |  |  | √ |  |  |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (50) | √ |  |  |  |  | 流水号 |
| 3 | BACKUPTYPE | nvarchar | (1) |  |  |  |  |  | 备份型别：1 成品解绑；2 序号处置解绑 |
| 4 | BACKUPFROMGUID | nvarchar | (64) |  |  |  |  |  | 备份来源GUID |
| 5 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | 生产批历程流程号 |
| 6 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 7 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 8 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 9 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 10 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 11 | SUBOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 工序 |
| 12 | PRINTLABELNUM | numeric | (2,0) |  |  |  |  |  | 打印次数：打印次数 |
| 13 | PCSSTATUS | nvarchar | (1) |  |  |  | √ |  | 序号状态：N 正常R 送修中 |
| 14 | PANELNO | nvarchar | (50) |  |  |  | √ |  | Panel编号：SMT基板序号(Panel) |
| 15 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号：记录最近一次进出站的设备编号 |
| 16 | SMTMAINTAINNO | nvarchar | (50) |  |  |  | √ |  | 维修单号：最近一次维修单号 内部产生的维护单号产品修复单为PYYYYMMDDXXXX |
| 17 | DISPOSERESULT | nvarchar | (1) |  |  |  | √ |  | 处置结果：C 继续生产、F 结束生产、S 报废 |
| 18 | REPORTED | numeric | (1,0) |  |  |  | √ |  | 已出站：0 未报工1 已报工 2 已入库 出站后将该LOT的序号标为已报工，入库后把序列号标志为已入库 |
| 19 | ORGPCSNO | nvarchar | (50) |  |  |  | √ |  | 原始成品序号：工位机搜集序号用，若只搜集部件时，这边会记录原始刷入序号（等于第一笔部件序号） |
| 20 | ISACTIVE | numeric | (1,0) |  |  |  |  |  | 最新序号：0  旧的  1 新的 |
| 21 | ISBARCODE | numeric | (1,0) |  |  |  | √ |  | 已取号：0：镭雕机未取号 1：镭雕机已取号  （华鹏个案使用） |
| 22 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 23 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPCONT_PCSNoChangeLog — 成品序号更新记录（61 字段）
> 主键：SID, LOGGROUPSERIAL, RESITEM, USERNO, EVENTTIME
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码 |
| 2 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | PCSNo_SID | nvarchar | (50) |  |  |  |  |  | 产品序号主档识别码 |
| 4 | OldPCSNo | nvarchar | (50) |  |  |  |  |  | 原产品序号 |
| 5 | NewPCSNo | nvarchar | (50) |  |  |  | √ |  | 部件编号 |
| 6 | UnitName | nvarchar | (50) |  |  |  | √ |  | 部件编号 |
| 7 | MaterialUnitNo | nvarchar | (50) |  |  |  | √ |  | 部件序号 |
| 8 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 4 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 5 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 6 | SUBOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 工序 |
| 7 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 8 | RELEASETYPE | numeric | (1,0) |  |  |  |  |  | 放行类别：0：限时放行1：超时放行 |
| 9 | BEFOROPSEQ | numeric | (4,0) |  |  |  |  |  | 前工序 |
| 10 | TIMEINTERVAL | numeric | (12,4) |  |  |  |  |  | 工序管控时间 |
| 11 | REALTIMEINTERVAL | numeric | (12,4) |  |  |  |  |  | 实际工序过站时间 |
| 12 | REMARK | nvarchar | (255) |  |  |  |  |  | 备注 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 2 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 3 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 主批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | LOGGROUPSERIAL | nvarchar | (50) | √ |  |  |  |  | Log序号 |
| 6 | RESCLASS | numeric | (2,0) |  |  |  |  |  | 资源大分类：0 EMP（工时） 1 EQP（机时） 2 OS（外包） 3 MTL（物料） 4 报工群组自变量 |
| 7 | RESTYPE | nvarchar | (50) |  |  |  |  |  | 资源类别：依据资源主分类记录不同数据 EMP：EMP EQP：设备类别 OS：OS MTL：物料编号 |
| 8 | RESITEM | nvarchar | (50) | √ |  |  |  |  | RES Item：依据资源主分类记录不同数据 EMP：EMP EQP：设备编号 OS：OS MTL：物料批号 |
| 9 | RESVALUE | numeric | (15,4) |  |  |  | √ |  | 实际用量：RESTYPE=EMP时 记录人时(UI可修改 单位分钟) RESTYPE=EQP时 记录机时(UI可修改 单位分钟) |
| 10 | STDVALUE | numeric | (10,2) |  |  |  |  |  | 标准用量：保留栏位 无作用 |
| 11 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 输入数量：RESTYPE=EMP时  记录报工数量(预设为良品数，UI可修改) RESTYPE=EQP时  记录出站数量(=出站画面上的出站数量，不可修改) 良品数=出站数量-报废-短少+多余 |
| 12 | USERNO | nvarchar | (30) | √ |  |  |  |  | 使用者ID：RESTYPE=EMP时 人时归属者 RESTYPE=EQP时 报工者（操作报工的人员账号） |
| 13 | EVENTTIME | datetime |  | √ |  |  |  |  | 建立日期：报工时间，对应TBLWIPCONT_PARTIALOUT的同名栏位 |
| 14 | RWOMESNO | nvarchar | (50) |  |  |  |  | 'N/A' | MES报工单单号：T100 使用（对于 T100 ERP其单据特性，所以单号由 SUBRWOMESNO 为主要的 MES 单号 若出站属于多人的情况需针对各人分别产生对应的报工单） |
| 15 | SUBRWOMESNO | nvarchar | (50) |  |  |  | √ |  | MES子报工单单号 |
| 16 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型 |
| 17 | UnitPrice | numeric | (23,8) |  |  |  |  | 0 | 单价 |
| 18 | PriceRate | numeric | (23,8) |  |  |  |  | 0 | 工价系数 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (50) |  |  |  | √ |  | SID |
| 2 | MASTER_SID | nvarchar | (50) |  |  |  | √ |  | 单头Sid：对应tblWIPLot_Report_Offline.Sid |
| 3 | RESCLASS | numeric | (2,0) |  |  |  | √ |  | 资源大分类：0 EMP（工时） 1 EQP（机时） 2 OS（外包） 3 MTL（物料） 4 报工群组自变量 |
| 4 | RESTYPE | nvarchar | (50) |  |  |  | √ |  | 资源类别：依据资源主分类记录不同数据 EMP：EMP EQP：设备编号 |
| 5 | RESITEM | nvarchar | (50) |  |  |  | √ |  | 资源项目：依据资源主分类记录不同数据 EMP：EMP EQP：设备编号 |
| 6 | RESVALUE | numeric | (15,4) |  |  |  | √ |  | 实际用量：如果是人、机时，其单位为分钟 |
| 7 | USERNO | nvarchar | (30) |  |  |  | √ |  | 使用者ID：报工人员编号 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPCont_SubProductLog — 副产品产出纪录（17 字段）
> 主键：BaseLotNo, SubLotNo, OPNo, EquipmentNo, EventTime
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | BaseLotNo | nvarchar | (50) | √ |  |  |  |  | 主批号 |
| 2 | SubLotNo | nvarchar | (50) | √ |  |  |  |  | 副产品批号 |
| 3 | OPNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | EventTime | datetime |  | √ |  |  |  |  | 产出时间 |
| 6 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产批序号 |
| 7 | UserNo | nvarchar | (30) |  |  |  |  |  | 使用者编号 |
| 8 | Qty | numeric | (12,4) |  |  |  |  |  | 副产品数量 |
| 9 | ProductNo | nvarchar | (50) |  |  |  | √ |  | 品号 |
| 10 | ProductVersion | nvarchar | (50) |  |  |  | √ |  | 产品版本 |
| 11 | MaterialNo | nvarchar | (50) |  |  |  | √ |  | 物料编号 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPCountPartialinWaitLog — 进站等候时间历程表（242 字段）
> 主键：LotNo, OPNo, LogGroupSerial, EquipmentNo, EventTime, WaitNo, BASELOTNO, EQUIPMENTNO, LOTNO, OPNO, WORKDATE, EQUIPMENTNO, EQUIPMENTNO, LOTNO, OPNO, WORKDATE, EQUIPMENTNO, LOTNO, OPNO, WORKDATE, SERIALNO, SID, EquipmentNo, MaterialNo, MONo, InputMaterialNo, MaterialLotNo, OPNo, PositionNo, QCLISTSERIAL, QCITEM, QCLISTSERIAL, QCFORMNO, QCFormNo, PCSNo, QCFormNo, REASONNO, ItemType
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | LogGroupSerial | nvarchar | (50) | √ |  |  |  |  | LOG序号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | EventTime | datetime |  | √ |  |  |  |  | 进站时间 |
| 6 | WaitNo | nvarchar | (20) | √ |  |  |  |  | 等待编号 |
| 7 | WaitTime | numeric | (12,4) |  |  |  |  |  | 等待时间(分) |
| 8 | Invalidity | numeric | (1,0) |  |  |  |  |  | 是否有效 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | BASELOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 开批数量 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | USERNO | nvarchar | (10) |  |  |  |  |  | 删除人员：使用者编号 |
| 6 | CLIENTNAME | nvarchar | (100) |  |  |  |  | 'N/A' | 客户端名称 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | EVENTTIME | datetime |  |  |  |  |  |  | 删除时间 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | WORKDATE | datetime |  | √ |  |  |  |  | 工作日期 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | AREANO | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 3 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 4 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 5 | REVISDATE | datetime |  |  |  |  | √ |  |  |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | QTY | numeric | (12,4) |  |  |  |  |  | 派工数量 |
| 5 | WORKDATE | datetime |  | √ |  |  |  |  | 工作日期 |
| 6 | SEQ | numeric | (6,0) |  |  |  |  |  | 序号 |
| 7 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 8 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 9 | DispEndTime | datetime |  |  |  |  | √ |  | 派工结束时间：（智派工或MES推算) |
| 10 | QcLotFlag | numeric | (1,0) |  |  |  | √ |  | 派工区域编号：（全流程用，标准版无作用） |
| 11 | DispQCLot | numeric | (1,0) |  |  |  | √ |  | 是否需检验标志：（全流程用，标准版无作用） |
| 12 | DispStartTime | datetime |  |  |  |  | √ |  | 派工开始时间：（智派工或MES推算) |
| 13 | DispAreaNo | nvarchar | (20) |  |  |  | √ |  | 派工号：（智派工) |
| 14 | ShiftNO | nvarchar | (20) |  |  |  | √ |  | 班别：(智派工使用) |
| 15 | StdDispStartTime | datetime |  |  |  |  | √ |  | 预推开工日：（开批时依照OP标工推算，与手动派工无关） |
| 16 | StdDispEndTime | datetime |  |  |  |  | √ |  | 预推完工日：（开批时依照OP标工推算，与手动派工无关） |
| 17 | CombinedTag | nvarchar | (40) |  |  |  | √ |  | 合并标记：（智派工) |
| 18 | ChildProcessNo | nvarchar | (64) |  |  |  |  | 'N/A' | 子流程编号 |
| 19 | ChildProcessVersion | nvarchar | (5) |  |  |  |  | 'N/A' | 子流程版本 |
| 20 | REVISDATE | datetime |  |  |  |  | √ |  |  |
| 21 | DISPSTARTTIMEPRE | datetime |  |  |  |  | √ |  | 上次派工开始时间：记录变动前日期用于比对(记录前一次的日期) |
| 22 | DISPENDTIMEPRE | datetime |  |  |  |  | √ |  | 上次派工结束时间：记录变动前日期用于比对(记录前一次的日期) |
| 23 | APSEQPSTARTTIME | datetime |  |  |  |  | √ |  | APS设备规划开始生产时间：#88245  由派工底稿表带入，无APS为Null |
| 24 | APSEQPENDTIME | datetime |  |  |  |  | √ |  | APS设备规划结束生产时间：#88245  由派工底稿表带入，无APS为Null |
| 25 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 26 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 最后更新日期 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | QTY | numeric | (12,4) |  |  |  |  |  | 派工数量 |
| 6 | WORKDATE | datetime |  | √ |  |  |  |  | 派工工作日 |
| 7 | SERIALNO | nvarchar | (20) | √ |  |  |  |  | 流水编号：#0104292 设备可以用多个模治具，PK从AccessoryNo改为SerialNo，依据EquipmentNo、LotNo、OPNo、WorkDate从1开始编 |
| 8 | ACCESSORYNO | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 9 | REVISOR | nvarchar | (20) |  |  |  | √ |  | 最后更新人员 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (4000) | √ |  |  |  |  | 识别码 |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | MaterialNo | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 4 | CheckLotNo | numeric | (1,0) |  |  |  |  | 0 | 是否检查批号 |
| 5 | MONo | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 6 | InputMaterialNo | nvarchar | (50) |  |  |  |  | 'N/A' | 输入物料编号 |
| 7 | MaterialLotNo | nvarchar | (50) |  |  |  |  |  | 物料批号 |
| 8 | Seq | numeric | (6,0) |  |  |  |  |  | 序列号 |
| 9 | InputQty | numeric | (16,6) |  |  |  |  |  | 投料数量 |
| 10 | Qty | numeric | (16,6) |  |  |  |  |  | 数量 |
| 11 | Reviser | nvarchar | (50) |  |  |  |  |  | 修改人员 |
| 12 | ReviseDate | datetime |  |  |  |  |  |  | 修改日期 |
| 13 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 14 | PositionNo | nvarchar | (50) |  |  |  | √ |  | 工位编号 |
| 15 | ORGMONo | nvarchar | (50) |  |  |  | √ |  | 原始工单编号 |
| 16 | Mode | numeric | (14,6) |  |  |  | √ |  | 模式：0 上料 1 下料 2 移转 |
| 17 | RecordDate | datetime |  |  |  |  | √ |  | 记录日期：异动时间纪录 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | MaterialNo | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 3 | CheckLotNo | numeric | (1,0) |  |  |  |  | 0 | 是否检查批号 |
| 4 | MONo | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 5 | InputMaterialNo | nvarchar | (50) | √ |  |  |  | 'N/A' | 输入物料编号 |
| 6 | MaterialLotNo | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 7 | Seq | numeric | (6,0) |  |  |  |  |  | 序列号 |
| 8 | InputQty | numeric | (16,6) |  |  |  |  |  | 输入数量 |
| 9 | Qty | numeric | (16,6) |  |  |  |  |  | 数量 |
| 10 | Reviser | nvarchar | (50) |  |  |  |  |  | 修改人员 |
| 11 | ReviseDate | datetime |  |  |  |  |  |  | 修改日期 |
| 12 | OPNo | nvarchar | (20) | √ |  |  |  | 'N/A' | 作业站编号 |
| 13 | PositionNo | nvarchar | (50) | √ |  |  |  | 'N/A' | 工位编号 |
| 14 | ORGMONo | nvarchar | (50) |  |  |  |  | 'N/A' | 原始工单编号 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | QCLISTSERIAL | nvarchar | (120) | √ |  |  |  |  | 点检序号 |
| 2 | QCITEM | nvarchar | (1000) | √ |  |  |  |  | 品管项目 |
| 3 | QCRESULT | numeric | (1,0) |  |  |  |  |  | 结果：0：通过 1：不通过 |
| 4 | INPUTVALUE | nvarchar | (50) |  |  |  | √ |  | 输入值 |
| 5 | STDVALUE | nvarchar | (12) |  |  |  | √ |  | 标准用量 |
| 6 | MAXIVALUE | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 7 | MINIVALUE | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 8 | INPUTDATACOUNT | numeric | (2,0) |  |  |  |  | 1 | 输入个数 |
| 9 | D01 | nvarchar | (50) |  |  |  | √ |  | D01 |
| 10 | D02 | nvarchar | (50) |  |  |  | √ |  | D02 |
| 11 | D03 | nvarchar | (50) |  |  |  | √ |  | D03 |
| 12 | D04 | nvarchar | (50) |  |  |  | √ |  | D04 |
| 13 | D05 | nvarchar | (50) |  |  |  | √ |  | D05 |
| 14 | D06 | nvarchar | (50) |  |  |  | √ |  | D06 |
| 15 | D07 | nvarchar | (50) |  |  |  | √ |  | D07 |
| 16 | D08 | nvarchar | (50) |  |  |  | √ |  | D08 |
| 17 | D09 | nvarchar | (50) |  |  |  | √ |  | D09 |
| 18 | D10 | nvarchar | (50) |  |  |  | √ |  | D10 |
| 19 | QCORDER | numeric | (2,0) |  |  |  |  | -99 | 点检次序 |
| 20 | QCTYPE | numeric | (1,0) |  |  |  | √ |  | 点检型别：1：范围  2：On Off  3：讯息 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | FILENAME | nvarchar | (500) |  |  |  | √ |  | 文件名称 |
| 1 | QCLISTSERIAL | nvarchar | (100) | √ |  |  |  |  | 点检序号 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | QCLISTNO | nvarchar | (100) |  |  |  |  |  | 点检表编号 |
| 4 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 5 | LOGGROUPSERIAL | nvarchar | (55) |  |  |  | √ |  | Log序号 |
| 6 | QCRESULT | numeric | (1,0) |  |  |  |  |  | 结果：1：通过  2：不通过 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改者 |
| 11 | REVISEDATE | datetime |  |  |  |  | √ |  | 数据修改人员 |
| 12 | EquipmentCheckUpRate | nvarchar | (1) |  |  |  |  |  | 点检频率：0：月 1：周 2：日 3：班别 4：小时 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 17 | STAGING | numeric | (1,0) |  |  |  |  | 0 | 暂存标记 |
| 1 | QCFORMNO | nvarchar | (50) | √ |  |  |  |  | 检验规则编号 |
| 2 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | USERNO | nvarchar | (50) |  |  |  |  |  | 使用者编号：画面检验人员 |
| 5 | AREANO | nvarchar | (50) |  |  |  |  |  | 区号 |
| 6 | CHECKQTY | numeric | (12,4) |  |  |  |  |  | 检查数量：首检为1 巡检为工单数量 |
| 7 | DEFECTQTY | numeric | (12,4) |  |  |  |  |  | 不良数量 |
| 8 | CHECKTIME | datetime |  |  |  |  |  |  | 检查时间 |
| 9 | QCRESULT | nvarchar | (50) |  |  |  |  |  | 检验结果：Y：通过，N：不通过, I：送验SPC中 |
| 10 | QCTYPE | nvarchar | (50) |  |  |  |  |  | 检验型别：2：首检，3：巡检，4：末检，5：自检，6：复检，7重新自检 |
| 11 | CheckOutTime | datetime |  |  |  |  | √ |  | 登出时间 |
| 12 | PCSNO | nvarchar | (50) |  |  |  | √ |  | 序号 |
| 13 | QCItemResult | nvarchar | (50) |  |  |  | √ |  | 检验项目结果：Y：通过，N：不通过, I：送验SPC中 |
| 14 | PanelNo | nvarchar | (50) |  |  |  | √ |  | 板号 |
| 15 | SMTOPSeq | nvarchar | (4) |  |  |  | √ |  | SMT工序 |
| 16 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 17 | PositionNo | nvarchar | (50) |  |  |  | √ |  | 工位 |
| 18 | ApplyQcType | nvarchar | (50) |  |  |  | √ |  | 申请类别：2 首检申请，4 末检申请，5 重新自检申请，6 复检申请 |
| 19 | ApplyQcFormNo | nvarchar | (50) |  |  |  | √ |  | 申请单号 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | QCFormNo | nvarchar | (50) | √ |  |  |  |  | 检验规则编号：检验规则编号 |
| 2 | ReasonNo | nvarchar | (50) |  |  |  | √ |  | 原因编号：原因编号 |
| 3 | PCSNo | nvarchar | (50) | √ |  |  |  |  | 成品序号：成品序号 |
| 4 | QCPCSResult | nvarchar | (50) |  |  |  | √ |  | 序号检验结果：Y：通过，N：不通过, I：送检QMS中 |
| 5 | Available_Qty | numeric | (12,4) |  |  |  | √ |  | 可用数量：出站时会带入在例外处理中，如果有当不良数出站的话，会扣除Available_Qty |
| 6 | CANCELFLAG | numeric | (1,0) |  |  |  | √ |  | 取消识别码：0 未取消 1 已取消(单据还原) |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCFormNo | nvarchar | (50) | √ |  |  |  |  | 检验规则编号 |
| 2 | ITEMNO | numeric | (3,0) |  |  |  | √ |  | 项目编号 |
| 3 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 原因编号 |
| 4 | QTY | numeric | (12,4) |  |  |  |  |  | 数量 |
| 5 | ItemType | numeric | (2,0) | √ |  |  |  | 0 | 项目型别 |
| 6 | Available_QTY | numeric | (12,4) |  |  |  |  | 0 | 可用数量：出站时会带入在例外处理中，如果有当不良数出站的话，会扣除Available_Qty |
| 7 | CheckType | numeric | (1,0) |  |  |  |  | 0 | 检验型别 |
| 8 | MaxiValue | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 9 | MiniValue | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 10 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述：说明 |
| 11 | InputValue | nvarchar | (50) |  |  |  | √ |  | 投入值 |
| 12 | ReasonDescription | nvarchar | (4000) |  |  |  | √ |  | 原因描述 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | QCFORMNO | nvarchar | (50) |  |  |  |  |  | 检验规则编号 |
| 2 | ITEMNO | numeric | (3,0) |  |  |  | √ |  | 项目编号 |
| 3 | FILETYPE | nvarchar | (50) |  |  |  | √ |  | 档型别 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | FILEBODY | varbinary | (-1) |  |  |  | √ |  | 档内容 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站编号：开批时记为LOTCREATE |
| 4 | DISPATCHDATE | datetime |  |  |  |  |  |  | 派工时间 |
| 5 | USERNO | nvarchar | (50) |  |  |  |  |  | 派工人员 |
| 6 | REQUIREQTY | numeric | (16,6) |  |  |  |  |  | 本次需求数 |
| 7 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 8 | MTLREQUIREQTY | numeric | (16,6) |  |  |  |  |  | 物料需求量 |
| 9 | AVAILABLEQTY | numeric | (16,6) |  |  |  |  |  | 物料可用量 |
| 10 | SHORTAGEQTY | numeric | (16,6) |  |  |  |  |  | 欠料量 |
| 11 | ONWAYQTY | numeric | (16,6) |  |  |  |  |  | 采购在途量 |
| 12 | RESPONSEQTY | numeric | (16,6) |  |  |  |  |  | 供应商回覆 |
| 13 | SUGGESTION | nvarchar | (255) |  |  |  |  |  | 建议 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPLeanDataAcquisition — 精实生产资料（8 字段）
> 主键：LotNo, OPNo, EventTime
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | WaitCount | numeric | (12,4) |  |  |  |  | 0 | 等待数量 |
| 4 | QueueCount | numeric | (12,4) |  |  |  |  | 0 | 队列数量 |
| 5 | EventTime | datetime |  | √ |  |  |  |  | 创建时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPLeanDataAcquisitionLog — 精实生产资料历程（8 字段）
> 主键：LotNo, OPNo, EventTime
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | WaitCount | numeric | (12,4) |  |  |  |  | 0 | 等待数量 |
| 4 | QueueCount | numeric | (12,4) |  |  |  |  | 0 | 队列数量 |
| 5 | EventTime | datetime |  | √ |  |  |  |  | 建立时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPLot_Report_Offline — 报工作业（194 字段）
> 主键：BASELOTNO, LOTSERIAL, LOGGROUPSERIAL, SID, LOTNO, OPNO, USERNO, CHECKINTIME, LOGINPLACENO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (50) |  |  |  | √ |  | Sid |
| 2 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 3 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 4 | FAILQTY | numeric | (12,4) |  |  |  | √ |  | 不良数 |
| 5 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 基础批号 |
| 6 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 7 | OPNO | nvarchar | (50) |  |  |  | √ |  | 作业站编号 |
| 8 | STATUS | numeric | (2,0) |  |  |  | √ |  | 状态 |
| 9 | COMPLETEDATE | datetime |  |  |  |  | √ |  | 完成日期 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | BASELOTNO | nvarchar | (50) | √ |  |  |  |  | 主批号 |
| 2 | ORGLOTNO | nvarchar | (50) |  |  |  |  |  | 原始批号 |
| 3 | LOTSTATE | numeric | (3,0) |  |  |  |  |  | 生产批状态：0 Unconfirm(未下线) 1 Confirm(已下线) 99 转库结批 100 分批结批 101 并批结批 |
| 4 | RONO | nvarchar | (25) |  |  |  |  |  | 订单编号：来自工单 |
| 5 | ITEMNO | numeric | (6,0) |  |  |  |  |  | 项次：来自工单 |
| 6 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号：来自工单 |
| 7 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号：来自工单 |
| 8 | PRODUCTVERSION | nvarchar | (5) |  |  |  | √ |  | 产品版本：来自工单 |
| 9 | CUSTOMERLOTNO | nvarchar | (50) |  |  |  | √ |  | 客户批号：来自工单 |
| 10 | CUSTOMERNO | nvarchar | (50) |  |  |  | √ |  | 客户编号：来自工单 |
| 11 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 输入数量 |
| 12 | INPUTUNITNO | nvarchar | (64) |  |  |  |  |  | 输入单位编号：来自工单 |
| 13 | PRIORITY | numeric | (2,0) |  |  |  | √ | 99 | 优先权：此生产批之优先等级 来自工单，生产批开立时可修改 需确认目前用途 |
| 14 | HOTLOT | numeric | (2,0) |  |  |  | √ | 0 | 紧急批：0：no1 yes |
| 15 | WIPDATE | datetime |  |  |  |  | √ |  | 生产批开立日 下线日 |
| 16 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 17 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 20 | ENGNO | nvarchar | (64) |  |  |  |  | 'N/A' | 工程编号：来自工单 需确认目前用途 |
| 21 | ENGVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 工程版本：来自工单 需确认目前用途 |
| 22 | DEVICENO | nvarchar | (50) |  |  |  | √ |  | 客户料号：需确认目前用途 |
| 23 | EX_LOTBASIS1 | nvarchar | (20) |  |  |  | √ |  | 延伸字段1：延伸字段1 |
| 24 | EX_LOTBASIS2 | nvarchar | (20) |  |  |  | √ |  | 延伸字段2 |
| 25 | EX_LOTBASIS3 | nvarchar | (20) |  |  |  | √ |  | 延伸字段3 |
| 26 | PLANFINISHDATE | datetime |  |  |  |  | √ |  | 预定完成日：来自工单 |
| 27 | RETURNNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 退货单号 |
| 28 | DISPNO | nvarchar | (50) |  |  |  | √ |  | 派工号 |
| 29 | DISPSEQ | nvarchar | (30) |  |  |  | √ |  | 派工次序 |
| 30 | PLANSTARTDATE | datetime |  |  |  |  | √ |  | 计划开始日期 |
| 31 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 计价类型：0-计件 1-计时 |
| 32 | BaseProcessNo | nvarchar | (64) |  |  |  |  | 'N/A' | 流程编号：一批只会对应到一各流程，当生产批有分量时，必须先集中到同一站才能跳流程 |
| 33 | BaseProcessVersion | nvarchar | (5) |  |  |  |  | 'N/A' | 流程版本：一批只会对应到一各流程，当生产批有分量时，必须先集中到同一站才能跳流程 |
| 34 | ChildProcessNo | nvarchar | (64) |  |  |  |  | 'N/A' | 子流程编号：#77171 |
| 35 | ChildProcessVersion | nvarchar | (5) |  |  |  |  | 'N/A' | 子流程版本：#77171 |
| 36 | LotNoType | numeric | (2,0) |  |  |  |  | 1 | 批次类型：1-常规批次 2-重工批次 #77171 |
| 37 | ChildProcessType | numeric | (1,0) |  |  |  | √ |  | 子流程类型：0-标准流程 1-自定义流程#77171 |
| 38 | OperateType | numeric | (18,0) |  |  |  | √ |  |  |
| 39 | OperateOPno | nvarchar | (64) |  |  |  | √ |  | 操作站点：#77171 |
| 40 | ChildEndOperate | numeric | (1,0) |  |  |  | √ | 1 | 子流程结束操作：1-直接入库 2-返回重工站点#77171 |
| 41 | CURLOTSTATUS | numeric | (2,0) |  |  |  | √ |  | 重工时生产批所处状态：0,1,2,12同tblWIPLotBasis-Status#77171 |
| 42 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 43 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 44 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 45 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOGSERIAL | nvarchar | (64) |  |  |  |  |  | 变更记录序号 |
| 2 | LOTNO | nvarchar | (64) |  |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 4 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批序号 |
| 5 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | Log序号 |
| 6 | FROMEQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 变更前初始设备编号 |
| 7 | TOEQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 变更后设备编号 |
| 8 | MOVEDATE | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | MOVEQTY | numeric | (16,6) |  |  |  |  |  | 异动数量 |
| 10 | FROMBEFOREQTY | numeric | (16,6) |  |  |  |  |  | 初始设备原数量 |
| 11 | FROMAFTERQTY | numeric | (16,6) |  |  |  |  |  | 初始设备变更后数量 |
| 12 | TOBEFOREQTY | numeric | (16,6) |  |  |  |  |  | 现设备原数量 |
| 13 | TOAFTERQTY | numeric | (16,6) |  |  |  |  |  | 现设备变更后数量 |
| 14 | USERNO | nvarchar | (64) |  |  |  |  |  | 变更人员 |
| 15 | AREANO | nvarchar | (30) |  |  |  | √ |  | 区域编号 |
| 16 | FROMEQUIPMENTSTATE | numeric | (10,0) |  |  |  | √ |  | 变更前设备状态 |
| 17 | TOEQUIPMENTSTATE | numeric | (10,0) |  |  |  | √ |  | 变更后设备状态 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTSERIAL | nvarchar | (55) | √ |  |  |  |  | 生产批序号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 3 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 4 | STATUS | numeric | (1,0) |  |  |  | √ | 0 | 状态 |
| 5 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 6 | SCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 损坏数 |
| 7 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 8 | NODEID | nvarchar | (100) |  |  |  | √ |  | 节点识别符号(Id) |
| 9 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 10 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 11 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 12 | PREOPENDTIME | datetime |  |  |  |  | √ |  | 前序站结束时间 |
| 13 | AREANO | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 14 | MODULENO | nvarchar | (50) |  |  |  | √ |  | 模块编号 |
| 15 | MODULEVERSION | nvarchar | (5) |  |  |  | √ |  | 模块版次 |
| 16 | INPUTQTY | numeric | (12,4) |  |  |  | √ |  | 输入数量 |
| 17 | INPUTUNITNO | nvarchar | (30) |  |  |  | √ |  | 输入单位编号 |
| 18 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 19 | OPGROUPNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 作业站群组编号 |
| 20 | PDLINENO | nvarchar | (50) |  |  |  | √ | 'N/A' | 产线编号 |
| 21 | DefectQTY | numeric | (12,4) |  |  |  |  | 0 | 不良数量 |
| 22 | EVENTID | nvarchar | (100) |  |  |  | √ |  | 采集批次编号 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 25 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 26 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 28 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOGGROUPSERIAL | nvarchar | (50) | √ |  |  |  |  | Log序号 |
| 2 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 3 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 5 | STATUS | numeric | (1,0) |  |  |  | √ |  | 状态 |
| 6 | PREOPENDTIME | datetime |  |  |  |  | √ |  | 前序作业站结束时间 |
| 7 | ARRIVETIME | datetime |  |  |  |  | √ |  | 到达时间 |
| 8 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 9 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 10 | INPUTQTY | numeric | (12,4) |  |  |  | √ |  | 输入数量 |
| 11 | INPUTUNITNO | nvarchar | (30) |  |  |  | √ |  | 输入单位编号 |
| 12 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 13 | FAILQTY | numeric | (12,4) |  |  |  | √ |  | 不良数 |
| 14 | GOODUNITNO | nvarchar | (30) |  |  |  | √ |  | 良品数之单位编号 |
| 15 | ENGNO | nvarchar | (64) |  |  |  |  | 'N/A' | 工程编号 |
| 16 | ENGVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 工程版本 |
| 17 | RECIPENO | nvarchar | (300) |  |  |  |  | 'N/A' | 自变量编号 |
| 18 | RECIPEVERSION | nvarchar | (15) |  |  |  |  | 'N/A' | 自变量版本 |
| 19 | RECIPESQL | nvarchar | (400) |  |  |  |  | 'N/A' | Recipe SQL |
| 20 | NODEID | nvarchar | (100) |  |  |  |  | 'N/A' | 节点id |
| 21 | FACTORYNO | nvarchar | (20) |  |  |  |  | 'N/A' | 工程编号 |
| 22 | MODULESERIAL | nvarchar | (50) |  |  |  |  | 'N/A' | 模块序号 |
| 23 | MODULENO | nvarchar | (50) |  |  |  |  | 'N/A' | 模块编号 |
| 24 | MODULEVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 模块版次 |
| 25 | PRODUCTNO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 26 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 27 | CUSTOMERLOTNO | nvarchar | (50) |  |  |  | √ |  | 客户批号 |
| 28 | DEVICENO | nvarchar | (50) |  |  |  | √ |  | 客户料号 |
| 29 | AREANO | nvarchar | (20) |  |  |  |  | 'N/A' | 区域编号 |
| 30 | LOSSQTY | numeric | (12,4) |  |  |  | √ |  | 遗失数 |
| 31 | COMPLETEFLAG | numeric | (1,0) |  |  |  |  | 0 | 完成标记 |
| 32 | CHECKINTIME | datetime |  |  |  |  | √ |  | 登入时间 |
| 33 | CHECKOUTTIME | datetime |  |  |  |  | √ |  | 登出时间 |
| 34 | OPGROUPNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 作业站群组编号 |
| 35 | SERIALNO | nvarchar | (50) |  |  |  | √ |  | 序号 |
| 36 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 37 | PDLINENO | nvarchar | (50) |  |  |  | √ | 'N/A' | 生产线别编号 |
| 38 | ERPNo | nvarchar | (50) |  |  |  | √ |  | ERP编号 |
| 39 | DefectQTY | numeric | (12,4) |  |  |  |  | 0 | 不良数量 |
| 40 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 41 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 42 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 43 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 44 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 45 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (36) | √ |  |  |  |  | SID |
| 2 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | LOG序号 |
| 3 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 5 | ORGGOODQTY | numeric | (12,4) |  |  |  | √ |  | 原始良品数 |
| 6 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 7 | ORGFAILQTY | numeric | (12,4) |  |  |  | √ |  | 原始不良数 |
| 8 | FAILQTY | numeric | (12,4) |  |  |  | √ |  | 不良数 |
| 9 | ORGLABORHOURS | numeric | (12,2) |  |  |  | √ |  | 原始人时 |
| 10 | LABORHOURS | numeric | (12,2) |  |  |  | √ |  | 人时 |
| 11 | ORGMACHINEHOURS | numeric | (12,2) |  |  |  | √ |  | 原始机时 |
| 12 | MACHINEHOURS | numeric | (12,2) |  |  |  | √ |  | 机时 |
| 13 | ORGREVISOR | nvarchar | (10) |  |  |  | √ |  | 原始修改人 |
| 14 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | PREVREVISEDATE | datetime |  |  |  |  | √ |  | 原始修改时间 |
| 16 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | DATATYPE | numeric | (1,0) |  |  |  |  |  | 数据型别 |
| 2 | DATASOURCE | numeric | (1,0) |  |  |  |  |  | 数据来源 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 4 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 来源批号 |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站 |
| 6 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | 序号 |
| 7 | USERNO | nvarchar | (30) | √ |  |  |  |  | 使用者编号 |
| 8 | USERNAME | nvarchar | (50) |  |  |  |  |  | 使用者名称称 |
| 9 | CHECKINTIME | datetime |  | √ |  |  |  |  | 上工时间 |
| 10 | CICREATOR | nvarchar | (10) |  |  |  |  |  | 上工人员 |
| 11 | CICREATEDATE | datetime |  |  |  |  |  |  | 上工建立日期 |
| 12 | CHECKOUTTIME | datetime |  |  |  |  | √ |  | 下工时间 |
| 13 | COCREATOR | nvarchar | (30) |  |  |  | √ |  | 下工人员 |
| 14 | COCREATEDATE | datetime |  |  |  |  | √ |  | 下工建立日期 |
| 15 | LOGINPLACENO | nvarchar | (50) | √ |  |  |  | 'N/A' | 登入地编号 |
| 16 | MULTIOPERATORMODE | numeric | (1,0) |  |  |  |  | 0 | 多人操作 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPLotNetProcessLog — 生产批网状呆滞数据处理记录表（86 字段）
> 主键：Id, LOTNO, OPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | Id | nvarchar | (50) | √ |  |  |  |  | Id |
| 2 | GroupId | nvarchar | (50) |  |  |  | √ |  | GroupId |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 4 | BaseLotNo | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 5 | OrgLotNo | nvarchar | (50) |  |  |  | √ |  | 原始批号 |
| 6 | LotSerial | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 7 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 8 | PsNo | nvarchar | (50) |  |  |  | √ |  | 区段编号 |
| 9 | ProcessNo | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 10 | OpNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 11 | NodeId | nvarchar | (100) |  |  |  | √ |  | 节点识别符号(Id) |
| 12 | CurQty | numeric | (12,4) |  |  |  | √ |  | 目前数量 |
| 13 | CurUnitNo | nvarchar | (64) |  |  |  | √ |  | 目前单位编号 |
| 14 | SysQty | numeric | (12,4) |  |  |  | √ |  | 系统数量 |
| 15 | SysUnitNo | nvarchar | (64) |  |  |  | √ |  | 系统单位编号 |
| 16 | BrNo | nvarchar | (20) |  |  |  | √ |  | 企业逻辑编号 |
| 17 | PhaseNo | numeric | (2,0) |  |  |  | √ |  | 阶段编号 |
| 18 | HaveComponent | numeric | (1,0) |  |  |  | √ |  | 是否有元件 |
| 19 | HaveLevel | numeric | (1,0) |  |  |  | √ |  | 是否有Bin分布 |
| 20 | PsOrder | numeric | (2,0) |  |  |  | √ |  | 区段次序 |
| 21 | LinkName | nvarchar | (20) |  |  |  | √ |  | 连结名称 |
| 22 | ReverseId | numeric | (6,0) |  |  |  | √ |  | 还原编号 |
| 23 | EventTime | datetime |  |  |  |  | √ |  | 建立日期 |
| 24 | Lotstamp | numeric | (11,0) |  |  |  | √ |  | 生产批执行标记 |
| 25 | GoStatus | numeric | (2,0) |  |  |  | √ |  | 进站状态：1进站 0待进站 |
| 26 | ProcessVersion | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 27 | NodeVersion | nvarchar | (5) |  |  |  | √ |  | 节点版本 |
| 28 | ModuleNo | nvarchar | (50) |  |  |  | √ |  | 模块编号 |
| 29 | ModuleVersion | nvarchar | (5) |  |  |  | √ |  | 模块版次 |
| 30 | OpReference | numeric | (1,0) |  |  |  | √ |  | 作业参考 |
| 31 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 32 | PreOpEndTime | datetime |  |  |  |  | √ |  | 前序站结束时间 |
| 33 | ArriveTime | datetime |  |  |  |  | √ |  | 到达时间 |
| 34 | OpStatus | numeric | (1,0) |  |  |  | √ |  | 作业站状态 |
| 35 | EngNo | nvarchar | (64) |  |  |  | √ |  | 工程编号 |
| 36 | EngVersion | nvarchar | (5) |  |  |  | √ |  | 工程版本 |
| 37 | RecipeNo | nvarchar | (300) |  |  |  | √ |  | 自变量编号 |
| 38 | RecipeVersion | nvarchar | (15) |  |  |  | √ |  | 自变量版本 |
| 39 | RecipeSql | nvarchar | (400) |  |  |  | √ |  | Recipe SQL |
| 40 | BatchSerial | nvarchar | (50) |  |  |  | √ |  | 批次执行序号 |
| 41 | ModuleSerial | nvarchar | (50) |  |  |  | √ |  | 模块序号 |
| 42 | ModuleNodeId | nvarchar | (100) |  |  |  | √ |  | 模块节点ID |
| 43 | ModuleStageNo | nvarchar | (50) |  |  |  | √ |  | 制造层别 |
| 44 | ModuleSequence | numeric | (4,0) |  |  |  | √ |  | 模块顺序 |
| 45 | MainProcessNo | nvarchar | (64) |  |  |  | √ |  | 主流程 |
| 46 | MainProcessVersion | nvarchar | (5) |  |  |  | √ |  | 主流程版本 |
| 47 | EventUserNo | nvarchar | (30) |  |  |  | √ |  | 操作人员编号 |
| 48 | EventDescription | nvarchar | (255) |  |  |  | √ |  | 事件描述 |
| 49 | Ex_LotState1 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE1 |
| 50 | Ex_LotState2 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE2 |
| 51 | Ex_LotState3 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE3 |
| 52 | FactoryNo | nvarchar | (20) |  |  |  | √ |  | 工厂编号 |
| 53 | OpGroupNo | nvarchar | (20) |  |  |  | √ |  | 作业站群组编号 |
| 54 | GoLinkName | nvarchar | (20) |  |  |  | √ |  | GOLINKNAME |
| 55 | PdLineNo | nvarchar | (50) |  |  |  | √ |  | 生产线别编号 |
| 56 | OperateType | numeric | (2,0) |  |  |  | √ | 1 | 现况操作型别：1-正常 2-重工 |
| 57 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 58 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 59 | Status | numeric | (2,0) |  |  |  | √ |  | 状态：0：一般; 1-还原 |
| 60 | ProcessType | numeric | (2,0) |  |  |  | √ |  | 呆滞数据处理型别：0-入库；1-合并扣减；2-合并添加 3-删除 |
| 61 | FGDInNo | nvarchar | (20) |  |  |  | √ |  | 入库单号 |
| 62 | ReturnDate | datetime |  |  |  |  | √ |  | 还原日期 |
| 63 | Returner | nvarchar | (30) |  |  |  | √ |  | 还原人 |
| 64 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 65 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 66 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 67 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | USER_DEFINED01 | nvarchar | (20) |  |  |  | √ |  | 自定义1 |
| 5 | USER_DEFINED02 | nvarchar | (20) |  |  |  | √ |  | 自定义2 |
| 6 | USER_DEFINED03 | nvarchar | (20) |  |  |  | √ |  | 自定义3 |
| 7 | USER_DEFINED04 | nvarchar | (20) |  |  |  | √ |  | 自定义4 |
| 8 | USER_DEFINED05 | nvarchar | (20) |  |  |  | √ |  | 自定义5 |
| 9 | USER_DEFINED06 | nvarchar | (20) |  |  |  | √ |  | 自定义6 |
| 10 | USER_DEFINED07 | nvarchar | (20) |  |  |  | √ |  | 自定义7 |
| 11 | USER_DEFINED08 | nvarchar | (20) |  |  |  | √ |  | 自定义8 |
| 12 | USER_DEFINED09 | nvarchar | (20) |  |  |  | √ |  | 自定义9 |
| 13 | USER_DEFINED10 | nvarchar | (20) |  |  |  | √ |  | 自定义10 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 17 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 18 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPLotProcessChangeLog — 生产批流程变更记录（14 字段）
> 主键：ID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (64) | √ |  |  |  |  | ID |
| 2 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 6 | BaseProcessNo | nvarchar | (64) |  |  |  |  |  | 原流程编号 |
| 7 | BaseProcessVersion | nvarchar | (5) |  |  |  |  |  | 原流程版本 |
| 8 | NewProcessNo | nvarchar | (64) |  |  |  |  |  | 新流程编号 |
| 9 | NewProcessVersion | nvarchar | (5) |  |  |  |  |  | 新流程版本 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 14 | TBLWIPLOTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPLotProcessChangeLog_D — 生产批流程变更记录明细（147 字段）
> 主键：ID, LOTNO, PROPERTYNO, BASELOTNO, PROPERTYNO, SID, QCFORMNO, LOTNO, STATUS, OPNO, SID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (64) | √ |  |  |  |  | ID |
| 2 | ParentId | nvarchar | (64) |  |  |  |  |  | 单头ID |
| 3 | OpNo | nvarchar | (64) |  |  |  |  |  | 作业站编号 |
| 4 | NodeId | nvarchar | (100) |  |  |  |  |  | 节点ID |
| 5 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | PROPERTYVALUE | nvarchar | (255) |  |  |  | √ |  | 属性值 |
| 4 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批流水号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | BASELOTNO | nvarchar | (50) | √ |  |  |  |  | 主批号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | PROPERTYVALUE | nvarchar | (255) |  |  |  | √ |  | 属性值 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SID | nvarchar | (4000) | √ |  |  |  |  | SID |
| 2 | MONo | nvarchar | (50) |  |  |  |  |  | 工单号 |
| 3 | BaseLotNo | nvarchar | (50) |  |  |  |  |  | 生产批批号 |
| 4 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批批号 |
| 5 | NodeID | nvarchar | (100) |  |  |  |  |  | 作业站节点ID |
| 6 | OPNo | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 7 | ORGInputQTY | numeric | (12,4) |  |  |  |  |  | 原始的生产批数量 |
| 8 | NewInputQTY | numeric | (12,4) |  |  |  |  |  | 修正后的生产批数量 |
| 9 | EventTime | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | UserNo | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批流水号 |
| 4 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | 历程流水号 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 7 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 8 | QCQTY | numeric | (14,6) |  |  |  |  |  | 送验数量 |
| 9 | OKQTY | numeric | (14,6) |  |  |  | √ |  | 验收数量 |
| 10 | RETURNQTY | numeric | (14,6) |  |  |  | √ |  | 验退数量 |
| 11 | SCRAPQTY | numeric | (14,6) |  |  |  | √ |  | 报废数量 |
| 12 | QCACTION | numeric | (2,0) |  |  |  | √ |  | 检验行为：1：取消? 2：添加? 3：更新单据信息 |
| 13 | QCRESULTTYPE | numeric | (2,0) |  |  |  | √ |  | 检验结果：2：合格? 3：不良? 4：特采 |
| 14 | QCDATE | datetime |  |  |  |  | √ |  | 检验时间 |
| 15 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位 |
| 16 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 17 | OPGroupNo | nvarchar | (20) |  |  |  | √ |  | 作业站群组编号 |
| 18 | USERNO | nvarchar | (30) |  |  |  |  |  | 用户 |
| 19 | RECORDDATE | datetime |  |  |  |  |  |  | 送验时间 |
| 20 | RESULTDATE | datetime |  |  |  |  | √ |  | 回送时间 |
| 21 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 22 | QCFormType | nvarchar | (2) |  |  |  | √ |  | 检验单类别 |
| 23 | ProductVersion | nvarchar | (5) |  |  |  | √ |  | 产品版本 |
| 24 | InventoryNo | nvarchar | (20) |  |  |  | √ |  | 库房编号 |
| 25 | INV_DoFlag | numeric | (1,0) |  |  |  | √ |  | 制程完工标识 |
| 26 | QCUserNo | nvarchar | (10) |  |  |  | √ |  | 检验人员 |
| 27 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 28 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 29 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 30 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 31 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 32 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 主批号 |
| 3 | ORGLOTNO | nvarchar | (50) |  |  |  |  |  | 原始批号 |
| 4 | STATUS | numeric | (2,0) | √ |  |  |  |  | 状态：0 Queue  1 Running 2 Wait 暂停  5 OS(外包)   6 网状工艺等待移到下作业站状态 9 SPC检验单 22  制程检验 回货检验 #81352、#83518 11 良品线边仓  12  不良品线边仓  15 网状制程暂存区（未汇合到下站） 16 直接报废制造损失记录(#78545)  20 外包指定结案(ERP将外包采购单结案#63700) 21 整批撤销-结束生产不入库(益睿先行个案) |
| 5 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批序号：生产批序号 |
| 6 | AREANO | nvarchar | (20) |  |  |  |  |  | 区域编号：仅供参考，请勿以此栏位判断所在区域 |
| 7 | PSNO | nvarchar | (50) |  |  |  |  |  | 区段编号 |
| 8 | PROCESSNO | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 9 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 10 | NODEID | nvarchar | (100) |  |  |  |  |  | 节点标识符(Id) |
| 11 | CURQTY | numeric | (12,4) |  |  |  |  |  | 目前数量 |
| 12 | CURUNITNO | nvarchar | (64) |  |  |  |  |  | 目前单位编号 |
| 13 | SYSQTY | numeric | (12,4) |  |  |  |  |  | 系统数量 |
| 14 | SYSUNITNO | nvarchar | (64) |  |  |  |  |  | 系统单位编号 |
| 15 | BRNO | nvarchar | (20) |  |  |  |  |  | 企业逻辑编号 |
| 16 | PHASENO | numeric | (2,0) |  |  |  |  | 0 | 阶段编号 |
| 17 | HAVECOMPONENT | numeric | (1,0) |  |  |  |  |  | 是否有组件 |
| 18 | HAVELEVEL | numeric | (1,0) |  |  |  |  |  | 是否有Bin分布 |
| 19 | PSORDER | numeric | (2,0) |  |  |  |  |  | 区段次序 |
| 20 | LINKNAME | nvarchar | (20) |  |  |  | √ |  | 连结名称 |
| 21 | REVERSEID | numeric | (6,0) |  |  |  | √ |  | 还原编号 |
| 22 | EVENTTIME | datetime |  |  |  |  | √ |  | 创建日期 |
| 23 | LOTSTAMP | numeric | (11,0) |  |  |  |  | 0 | 生产批执行标记 |
| 24 | GOSTATUS | numeric | (2,0) |  |  |  | √ |  | 目的地状态：1进站（解除暂停后为R） 0待进站(解除暂停后为Q) |
| 25 | PROCESSVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 流程版本 |
| 26 | NODEVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 节点版本 |
| 27 | MODULENO | nvarchar | (50) |  |  |  |  | 'N/A' | 模块编号 |
| 28 | MODULEVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 模块版次 |
| 29 | OPREFERENCE | numeric | (1,0) |  |  |  |  | 0 | 作业参考 |
| 30 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 31 | PREOPENDTIME | datetime |  |  |  |  | √ |  | 前站结束时间 |
| 32 | ARRIVETIME | datetime |  |  |  |  | √ |  | 到达时间 |
| 33 | OPSTATUS | numeric | (1,0) |  |  |  | √ |  | 作业站状态 |
| 34 | ENGNO | nvarchar | (64) |  |  |  |  | 'N/A' | 工程编号 |
| 35 | ENGVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 工程版本 |
| 36 | RECIPENO | nvarchar | (300) |  |  |  |  | 'N/A' | 参数编号 |
| 37 | RECIPEVERSION | nvarchar | (15) |  |  |  |  | 'N/A' | 参数版本 |
| 38 | RECIPESQL | nvarchar | (400) |  |  |  |  | 'N/A' | Recipe SQL |
| 39 | BATCHSERIAL | nvarchar | (50) |  |  |  | √ |  | 批次执行序号 |
| 40 | MODULESERIAL | nvarchar | (50) |  |  |  |  | 'N/A' | 模块序号 |
| 41 | MODULENODEID | nvarchar | (100) |  |  |  |  | 'N/A' | 模块节点ID |
| 42 | MODULESTAGENO | nvarchar | (50) |  |  |  |  | 'N/A' | 制造层别 |
| 43 | MODULESEQUENCE | numeric | (4,0) |  |  |  |  | 0 | 模块顺序 |
| 44 | MAINPROCESSNO | nvarchar | (64) |  |  |  | √ |  | 主流程 |
| 45 | MAINPROCESSVERSION | nvarchar | (5) |  |  |  | √ |  | 主流程版本 |
| 46 | EVENTUSERNO | nvarchar | (30) |  |  |  | √ |  | 操作人员编号 |
| 47 | EVENTDESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 事件描述 |
| 48 | EX_LOTSTATE1 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE1 |
| 49 | EX_LOTSTATE2 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE2 |
| 50 | EX_LOTSTATE3 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE3 |
| 51 | FACTORYNO | nvarchar | (20) |  |  |  |  | 'N/A' | 工厂编号 |
| 52 | OPGROUPNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 作业站群组编号 |
| 53 | GOLINKNAME | nvarchar | (20) |  |  |  | √ |  | GOLINKNAME |
| 54 | PDLINENO | nvarchar | (50) |  |  |  | √ |  | 生产线别编号 |
| 55 | OPERATETYPE | numeric | (2,0) |  |  |  | √ | 1 | OPERATETYPE |
| 56 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 57 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 58 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (64) | √ |  |  |  |  | 流水序号 |
| 2 | MONo | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 3 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | OPNo | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 5 | OrgQty | numeric | (12,4) |  |  |  |  |  | 调帐前数量 |
| 6 | Qty | numeric | (12,4) |  |  |  |  |  | 调帐数量 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 调帐人员 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 调帐日期 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPLotStateNetLog — 生产批网状制程出站现况变化记录（103 字段）
> 主键：BaseLotNo, Status, NETGUID, ChangeType, OpNo, TIMEFLAG, SID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) |  |  |  |  |  | 批号 |
| 2 | BaseLotNo | nvarchar | (50) | √ |  |  |  |  | 主批号 |
| 3 | OrgLotNo | nvarchar | (50) |  |  |  |  |  | 原始批号 |
| 4 | Status | numeric | (2,0) | √ |  |  |  |  | 状态：0 Queue  1 Running 2 Wait 暂停  5 OS(外包)   6 网状工艺等待移到下作业站状态 9 SPC检验单 22  制程检验 回货检验 #81352、#83518 11 良品线边仓  12  不良品线边仓  15 网状制程暂存区（未汇合到下站） 16 直接报废制造损失记录(#78545)  20 外包指定结案(ERP将外包采购单结案#63700) 21 整批撤销(益睿先行个案) |
| 5 | NETGUID | nvarchar | (50) | √ |  |  |  |  | NETGUID |
| 6 | ChangeType | numeric | (1,0) | √ |  |  |  |  | 变化型别：0-增加 1-减少 |
| 7 | ChangeQty | numeric | (12,4) |  |  |  |  |  | 变化数量 |
| 8 | ChangeSeqNo | numeric | (3,0) |  |  |  |  |  | 变化顺序号：同一次出站按数据变化的顺序依次记录1，2，3，4。。。 |
| 9 | LotSerial | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 10 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号：仅供参考，请勿以此栏位判断所在区域 |
| 11 | PsNo | nvarchar | (50) |  |  |  | √ |  | 区段编号 |
| 12 | ProcessNo | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 13 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 14 | NodeId | nvarchar | (100) |  |  |  | √ |  | 节点识别符号(Id) |
| 15 | CurUnitNo | nvarchar | (30) |  |  |  | √ |  | 目前单位编号 |
| 16 | SysUnitNo | nvarchar | (30) |  |  |  | √ |  | 系统单位编号 |
| 17 | BrNo | nvarchar | (20) |  |  |  | √ |  | 企业逻辑编号 |
| 18 | PhaseNo | numeric | (2,0) |  |  |  | √ |  | 阶段编号 |
| 19 | HaveComponent | numeric | (1,0) |  |  |  | √ |  | 是否有元件 |
| 20 | HaveLevel | numeric | (1,0) |  |  |  | √ |  | 是否有Bin分布 |
| 21 | PsOrder | numeric | (2,0) |  |  |  | √ |  | 区段次序 |
| 22 | LinkName | nvarchar | (20) |  |  |  | √ |  | 连结名称 |
| 23 | ReverseId | numeric | (6,0) |  |  |  | √ |  | 还原编号 |
| 24 | EventTime | datetime |  |  |  |  | √ |  | 结束时间 |
| 25 | Lotstamp | numeric | (11,0) |  |  |  | √ |  | 生产批执行标记 |
| 26 | GoStatus | numeric | (2,0) |  |  |  | √ |  | 进站状态：1进站（解除暂停后为R） 0待进站(解除暂停后为Q) |
| 27 | ProcessVersion | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 28 | NodeVersion | nvarchar | (5) |  |  |  | √ |  | 节点版本 |
| 29 | ModuleNo | nvarchar | (50) |  |  |  | √ |  | 模块编号 |
| 30 | ModuleVersion | nvarchar | (5) |  |  |  | √ |  | 模块版次 |
| 31 | OpReference | numeric | (1,0) |  |  |  | √ |  | 作业参考 |
| 32 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | log序号 |
| 33 | PreOpEndTime | datetime |  |  |  |  | √ |  | 前站结束时间 |
| 34 | ArriveTime | datetime |  |  |  |  | √ |  | 到达时间 |
| 35 | OpStatus | numeric | (1,0) |  |  |  | √ |  | 作业站状态 |
| 36 | EngNo | nvarchar | (30) |  |  |  | √ |  | 工程编号 |
| 37 | EngVersion | nvarchar | (5) |  |  |  | √ |  | 工程版本 |
| 38 | RecipeNo | nvarchar | (300) |  |  |  | √ |  | 自变量编号 |
| 39 | RecipeVersion | nvarchar | (15) |  |  |  | √ |  | 自变量版本 |
| 40 | RecipeSql | nvarchar | (400) |  |  |  | √ |  | Recipe SQL |
| 41 | BatchSerial | nvarchar | (50) |  |  |  | √ |  | 批次执行序号 |
| 42 | ModuleSerial | nvarchar | (50) |  |  |  | √ |  | 模块序号 |
| 43 | ModuleNodeId | nvarchar | (100) |  |  |  | √ |  | 模块节点ID |
| 44 | ModuleStageNo | nvarchar | (50) |  |  |  | √ |  | 制造层别 |
| 45 | ModuleSequence | numeric | (4,0) |  |  |  | √ |  | 模块顺序 |
| 46 | MainProcessNo | nvarchar | (30) |  |  |  | √ |  | 主流程 |
| 47 | MainProcessVersion | nvarchar | (5) |  |  |  | √ |  | 主流程版本 |
| 48 | EventUserNo | nvarchar | (30) |  |  |  | √ |  | 操作人员编号 |
| 49 | EventDescription | nvarchar | (255) |  |  |  | √ |  | 事件描述 |
| 50 | Ex_LotState1 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE1 |
| 51 | Ex_LotState2 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE2 |
| 52 | Ex_LotState3 | nvarchar | (20) |  |  |  | √ |  | EX_LOTSTATE3 |
| 53 | FactoryNo | nvarchar | (20) |  |  |  | √ |  | 工厂编号 |
| 54 | OpGroupNo | nvarchar | (20) |  |  |  | √ |  | 作业站群组编号 |
| 55 | GoLinkName | nvarchar | (20) |  |  |  | √ |  | GOLINKNAME |
| 56 | PdLineNo | nvarchar | (50) |  |  |  | √ |  | 生产线别编号 |
| 57 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 58 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 59 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 60 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 61 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 62 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | TIMEFLAG | nvarchar | (50) | √ |  |  |  |  | 时间戳 |
| 3 | AEARNO | nvarchar | (50) |  |  |  |  |  | 区域 |
| 4 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 5 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站 |
| 6 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 7 | UNITNO | nvarchar | (50) |  |  |  |  |  | 单位 |
| 8 | EVENTTIME | datetime |  |  |  |  |  |  | 结束时间 |
| 9 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 10 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 11 | QTY | numeric | (12,4) |  |  |  |  | 0 | 数量 |
| 12 | TANSFEROPERATOR | nvarchar | (30) |  |  |  | √ |  | 移转人 |
| 13 | TANSFERDATE | datetime |  |  |  |  | √ |  | 移转时间 |
| 14 | RECIEVEOPERATOR | nvarchar | (30) |  |  |  | √ |  | 接收人 |
| 15 | RECIEVEDATE | datetime |  |  |  |  | √ |  | 接收时间 |
| 16 | TOAEARNO | nvarchar | (50) |  |  |  | √ |  | 目标区域 |
| 17 | TOOPNO | nvarchar | (50) |  |  |  | √ |  | 目标作业站 |
| 18 | TOEQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 目标设备 |
| 19 | STATUS | numeric | (1,0) |  |  |  | √ | 0 | 状态：0 待移转  1 移转中  2 已接收 |
| 20 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 23 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 识别码：随机生成GUID |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 5 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 6 | REASONNO | nvarchar | (50) |  |  |  |  |  | 退回原因编号 |
| 7 | REASONNAME | nvarchar | (100) |  |  |  |  |  | 退回原因名称：将原因名称复写到此 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 退回说明 |
| 9 | QTY | numeric | (12,4) |  |  |  |  |  | 退回数量 |
| 10 | STATETYPE | numeric | (1,0) |  |  |  |  |  | 退回前生产批状态：0 待出站(R) 1 暂停中(W) |
| 11 | WAITNO | nvarchar | (50) |  |  |  |  |  | 暂停编号：若是由暂停状态退回，需记录暂停编号 |
| 12 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 13 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPMaterialDemandBoard — 叫料看板（20 字段）
> 主键：SID, SEQNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (4000) | √ |  |  |  |  | 识别码：YYYYMMDDHHmmssfff |
| 2 | SEQNo | numeric | (4,0) | √ |  |  |  |  | 顺序 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 5 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 7 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 8 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 9 | QTY | numeric | (16,6) |  |  |  |  |  | 需求数量 |
| 10 | Status | numeric | (2,0) |  |  |  |  |  | 叫料来源：0 手动叫料触发(非设定) 1 自动叫料触发(非设定) |
| 11 | PutInPlaceType | numeric | (2,0) |  |  |  |  |  | 扣料点：3：工单 4：线边仓 5：工单消耗性料件(倒扣料) |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | RequireDate | datetime |  |  |  |  | √ |  | 要求发料日期：yyyy-MM-dd #82338 20201120 朱煜轲 用于派工作业叫料记录展示派工日期 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 19 | InfoType | numeric | (2,0) |  |  |  | √ |  |  |
| 20 | StartStutas | numeric | (2,0) |  |  |  | √ |  |  |

---

### tblWIPMaterialDemandBoardLog — 叫料看板处理纪录（20 字段）
> 主键：SID, SEQNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (4000) | √ |  |  |  |  | 识别码：YYYYMMDDHHmmssfff |
| 2 | SEQNo | numeric | (5,0) | √ |  |  |  |  | 顺序 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 5 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 7 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 8 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 9 | QTY | numeric | (16,6) |  |  |  |  |  | 需求数量 |
| 10 | Status | numeric | (5,0) |  |  |  |  |  | 叫料来源：0 手动叫料触发(非设定) 1 自动叫料触发(非设定) |
| 11 | PutInPlaceType | numeric | (5,0) |  |  |  |  |  | 扣料点：3：工单 4：线边仓 5：工单消耗性料件(倒扣料) |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人员：处理人员 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期：处理日期 |
| 16 | Mode | numeric | (5,0) |  |  |  | √ |  | 模式：0 已处理 1 删除 (目前暂无) |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPMaterialOfflineBoard — 下料看板（17 字段）
> 主键：SID, SEQNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (4000) | √ |  |  |  |  | 识别码：YYYYMMDDHHmmssfff |
| 2 | SEQNo | numeric | (4,0) | √ |  |  |  |  | 顺序 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 5 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 7 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 8 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 9 | MATERIALLOTNO | nvarchar | (50) |  |  |  |  |  | 物料批号 |
| 10 | PutInPlaceType | numeric | (1,0) |  |  |  |  |  | 扣料点：3：工单 4：线边仓 5：工单消耗性料件(倒扣料) |
| 11 | QTY | numeric | (16,6) |  |  |  |  |  | 下线数量 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPMaterialOfflineBoardLog — 下料看板处理纪录（99 字段）
> 主键：SID, SEQNo, LOTNO, OPNO, MATERIALNO, MATERIALLOTNO, QTY, LOTNO, OPNO, MATERIALNO, MATERIALLOTNO, STATE, SID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (4000) | √ |  |  |  |  | 识别码：YYYYMMDDHHmmssfff |
| 2 | SEQNo | numeric | (4,0) | √ |  |  |  |  | 顺序 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 5 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 7 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 8 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 9 | MATERIALLOTNO | nvarchar | (50) |  |  |  |  |  | 物料批号 |
| 10 | PutInPlaceType | numeric | (1,0) |  |  |  |  |  | 扣料点：3：工单 4：线边仓 5：工单消耗性料件(倒扣料) |
| 11 | QTY | numeric | (16,6) |  |  |  |  |  | 下线数量 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人员 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 16 | Mode | numeric | (2,0) |  |  |  | √ |  | 模式：0 已处理 1 删除 (目前暂无) |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | FROMLOTNO | nvarchar | (50) |  |  |  |  |  | 来源生产编号 |
| 2 | FROMLOTSERIAL | nvarchar | (55) |  |  |  |  |  | 来源生产批号 |
| 3 | FROMREVERSEID | numeric | (6,0) |  |  |  |  |  | 来源还原编号 |
| 4 | TOLOTNO | nvarchar | (50) |  |  |  |  |  | to批号：正常情况与RefLotNo相同 如果个案需求并批后批号要产生新的批号，就存并批后的新批号，RefLotNo存原来母批批号 |
| 5 | TOLOTSERIAL | nvarchar | (55) |  |  |  |  |  | to生产批号 |
| 6 | TOREVERSEID | numeric | (6,0) |  |  |  |  |  | to还原编号 |
| 7 | MERGETYPE | numeric | (2,0) |  |  |  |  |  | 并批型别：SMES固定0 0：手动分批 1：自动分批 |
| 8 | FROMLOTQTY | numeric | (12,4) |  |  |  | √ |  | 来源数量 |
| 9 | FROMSCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 来源损坏数：SMES固定0 |
| 10 | FROMOTHERQTY | numeric | (12,4) |  |  |  | √ |  | 来源其他数量：SMES固定0 |
| 11 | TOLOTQTY | numeric | (12,4) |  |  |  | √ |  | to数量 |
| 12 | TOSCRAPQTY | numeric | (12,4) |  |  |  | √ |  | to损坏数：SMES固定0 |
| 13 | TOOTHERQTY | numeric | (12,4) |  |  |  | √ |  | to其他数量：SMES固定0 |
| 14 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 15 | USERNO | nvarchar | (30) |  |  |  | √ |  | 使用者编号 |
| 16 | EVENTTIME | datetime |  |  |  |  | √ |  | 建立日期 |
| 17 | REFLOTNO | nvarchar | (50) |  |  |  | √ |  | 参考批号：画面所选的母批批号(画面最上方) |
| 18 | FROMBASELOTNO | nvarchar | (50) |  |  |  | √ |  | 来源主批号 |
| 19 | TOBASELOTNO | nvarchar | (50) |  |  |  | √ |  | to主批号 |
| 20 | FROMMONO | nvarchar | (50) |  |  |  | √ |  | 来源工单编号：SMES限制相同工单并批，目前都会一样 |
| 21 | TOMONO | nvarchar | (50) |  |  |  | √ |  | to工单编号：SMES限制相同工单并批，目前都会一样 |
| 22 | LotStatus | numeric | (2,0) |  |  |  | √ |  | 状态：与tblWIPLotState代表意义相同，填入并批当下，生产批状态 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 25 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 26 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 28 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 5 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 6 | QTY | numeric | (12,4) | √ |  |  |  |  | 数量 |
| 7 | CREATETIME | datetime |  |  |  |  |  |  | 建立时间 |
| 8 | EVENTID | nvarchar | (50) |  |  |  |  |  | 事件ID |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 4 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 5 | PERIODUSERQTY | numeric | (12,4) |  |  |  |  |  | 期间使用量 |
| 6 | LASTPASSTIME | datetime |  |  |  |  |  |  | 上次过站时间 |
| 7 | STATE | numeric | (1,0) | √ |  |  |  |  | 状态：0：未抛转，1：抛转中 |
| 8 | TYPE | numeric | (1,0) |  |  |  |  |  | 型别：0：原料，1：半成品 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (64) | √ |  |  |  |  | 识别符号 |
| 2 | USERNO | nvarchar | (30) |  |  |  |  |  | 使用者编号 |
| 3 | SHIFTNO | nvarchar | (20) |  |  |  |  |  | 班别 |
| 4 | LOGINDATE | datetime |  |  |  |  |  |  | 登入日期 |
| 5 | LOGOUTDATE | datetime |  |  |  |  |  |  | 登出日期 |
| 6 | EXCEPTIONTIME | numeric | (10,2) |  |  |  |  | 0 | 异常时间 |
| 7 | WORKTIME | numeric | (10,2) |  |  |  |  | 0 | 工作时间 |
| 8 | REALWORKTIME | numeric | (10,2) |  |  |  |  | 0 | 实际工作时间 |
| 9 | STDWORKTIME | numeric | (10,2) |  |  |  |  | 0 | 标准工作时间 |
| 10 | QTY | numeric | (16,6) |  |  |  |  | 0 | 数量 |
| 11 | WORKDATE | datetime |  |  |  |  |  |  | 工作日历 |
| 12 | OPNO | nvarchar | (20) |  |  |  |  | 'N/A' | 作业站编号 |
| 13 | MULTIOPERATORMODE | numeric | (1,0) |  |  |  |  | 0 | 多人操作 |
| 14 | LOGINPLACENO | nvarchar | (50) |  |  |  |  |  | 登入地编号 |
| 15 | EVENTTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 16 | POSITIONNO | nvarchar | (50) |  |  |  |  | 'N/A' | 工位 |
| 17 | SUBOPNO | nvarchar | (20) |  |  |  |  | 'N/A' | 子作业编号 |
| 18 | EW001 | nvarchar | (20) |  |  |  | √ |  | EW001 |
| 19 | EW002 | nvarchar | (20) |  |  |  | √ |  | EW002 |
| 20 | EW003 | numeric | (8,0) |  |  |  | √ |  | EW003 |
| 21 | ParameterValue | numeric | (8,2) |  |  |  | √ |  | 参数值 |
| 22 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWipOperatorLotLog — 人员操作生产批记录表（50 字段）
> 主键：UserNo, LoginDate, LotNo, OpNo, LoginPlaceType, LoginPlaceNo, SID, USERNO, MULTIOPERATORMODE, LOGINPLACENO, POSITIONNO, SUBOPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | UserNo | nvarchar | (30) | √ |  |  |  |  | 使用者编号 |
| 2 | ShiftNo | nvarchar | (20) |  |  |  |  |  | 班别 |
| 3 | LoginDate | datetime |  | √ |  |  |  |  | 登入日期 |
| 4 | LogoutDate | datetime |  |  |  |  | √ |  | 登出日期 |
| 5 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 6 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 7 | WorkTime | numeric | (10,2) |  |  |  | √ |  | 工作时间：单位 分 |
| 8 | WorkDate | datetime |  |  |  |  |  |  | 工作日历 |
| 9 | LoginPlaceType | numeric | (1,0) | √ |  |  |  |  | 登入地类别：2 设备 3 产线 4 子作业 |
| 10 | LoginPlaceNo | nvarchar | (50) | √ |  |  |  |  | 登入地编号 |
| 11 | EventTime | datetime |  |  |  |  | √ |  | 结束时间 |
| 12 | PositionNo | nvarchar | (50) |  |  |  | √ |  | 工位 |
| 13 | SubOpNo | nvarchar | (20) |  |  |  | √ |  | 子作业编号 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 16 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人员 |
| 17 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (64) |  |  |  |  |  | 序号 |
| 2 | REASONTYPE | numeric | (2,0) |  |  |  |  |  | 原因型别：0  上工 1 下工 |
| 3 | REASONNO | nvarchar | (20) |  |  |  |  |  | 原因编号 |
| 4 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (64) | √ |  |  |  |  | 序号 |
| 2 | SKILLRESULT | numeric | (1,0) |  |  |  |  |  | 技能结果：0 强制上工 1 正常上工 |
| 3 | DONORUSERNO | nvarchar | (10) |  |  |  |  |  | 授权使用者 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 6 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | USERNO | nvarchar | (30) | √ |  |  |  |  | 使用者编号 |
| 2 | SHIFTNO | nvarchar | (20) |  |  |  |  |  | 班别 |
| 3 | LOGINDATE | datetime |  |  |  |  |  |  | 登入日期 |
| 4 | WORKDATE | datetime |  |  |  |  |  |  | 工作日历 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  | 'N/A' | 作业站编号 |
| 6 | MULTIOPERATORMODE | numeric | (1,0) | √ |  |  |  | 0 | 多人操作：2 设备 3 产线 4 子作业 |
| 7 | LOGINPLACENO | nvarchar | (50) | √ |  |  |  |  | 登入地编号 |
| 8 | POSITIONNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 状态编号 |
| 9 | SUBOPNO | nvarchar | (20) | √ |  |  |  | 'N/A' | 替代作业站 |
| 10 | SID | nvarchar | (64) |  |  |  |  | 'N/A' | 识别符号 |
| 11 | ParameterValue | numeric | (8,2) |  |  |  | √ | 0 | 参数值 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPOPMOtherReason — 其他工价报工记录表（142 字段）
> 主键：GUID, OSNO, OSNO, LOTNO, OSNO, LOTNO, ACCESSORYNO, ACCESSORYVERSION, delivery_no, LOTNO, OPNO, os_no, CreateDate, delivery_out_no, delivery_no, lot_no, op_no, CreateDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | UserNo | nvarchar | (64) |  |  |  |  |  | 作业人员 |
| 3 | OtherReasonNo | nvarchar | (255) |  |  |  |  |  | 报工原因 |
| 4 | PriceType | numeric | (1,0) |  |  |  |  |  | 工价型别 |
| 5 | StartTime | datetime |  |  |  |  | √ |  | 开始时间 |
| 6 | EndTime | datetime |  |  |  |  | √ |  | 结束时间 |
| 7 | Qty | numeric | (23,8) |  |  |  |  |  | 数量 |
| 8 | UnitPrice | numeric | (23,8) |  |  |  |  |  | 单价 |
| 9 | IsCut | numeric | (1,0) |  |  |  |  |  | 是否扣减 |
| 10 | ProductNo | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 11 | ProductVersion | nvarchar | (5) |  |  |  | √ |  | 产品版本 |
| 12 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 13 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 14 | OPNO | nvarchar | (50) |  |  |  | √ |  | 作业站编号 |
| 15 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 18 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 1 | OSNO | nvarchar | (20) | √ |  |  |  |  | 外包单号 |
| 2 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 3 | PREPARENAME | nvarchar | (30) |  |  |  | √ |  | 登入人员 |
| 4 | NEEDBYDATE | datetime |  |  |  |  | √ |  | 委外回货日期 |
| 5 | OSQTY | numeric | (12,4) |  |  |  |  |  | 外包单总数量 |
| 6 | STATUS | numeric | (2,0) |  |  |  |  |  | 状态：0 待出货 1 已出货 10 部分回货 11 全部回货 -1 Abort 20 ERP采购单结案(益睿客户使用) |
| 7 | SHPDATE | datetime |  |  |  |  | √ |  | 出货日期 |
| 8 | CLOSEDATE | datetime |  |  |  |  | √ |  | 结案日期 |
| 9 | PRICE | numeric | (12,4) |  |  |  | √ |  | 价格 |
| 10 | SUBCONTRACTORNO | nvarchar | (20) |  |  |  | √ |  | 外包商编号 |
| 11 | NODEID | nvarchar | (100) |  |  |  | √ |  | 节点识别码 |
| 12 | OSITEMNO | nvarchar | (2) |  |  |  | √ |  | 外包项目编号 |
| 13 | RETURNOPNO | nvarchar | (20) |  |  |  | √ |  | 回指定站 |
| 14 | RETURNNODEID | nvarchar | (100) |  |  |  | √ |  | 回货节点识别码 |
| 15 | SHPUSERNO | nvarchar | (30) |  |  |  | √ |  | 出货人员 |
| 16 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 17 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 18 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 19 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 20 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 21 | OSTYPE | numeric | (1,0) |  |  |  | √ |  | 外包类别：1 固定外包 2 临时外包 |
| 22 | ERPDOCType | nvarchar | (50) |  |  |  | √ |  | ERP整合型别 |
| 23 | S_Warehouse_No | nvarchar | (50) |  |  |  | √ |  | 库房 |
| 24 | S_Storage_Spaces_No | nvarchar | (50) |  |  |  | √ |  | 库房 |
| 25 | DispStartTime | datetime |  |  |  |  | √ |  | 派工预计开始时间 |
| 26 | DispEndTime | datetime |  |  |  |  | √ |  | 派工预计完工时间 |
| 27 | ModifyCount | numeric | (4,0) |  |  |  |  | 0 | 抛转次数 |
| 28 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 29 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 30 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 31 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OSNO | nvarchar | (20) | √ |  |  |  |  | 外包单号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | RCVDATE | datetime |  |  |  |  | √ |  | 回货日期 |
| 4 | STATUS | numeric | (2,0) |  |  |  |  |  | 状态：0 外包中 10 全数外包回货 20 采购单结案(益睿需求) |
| 5 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 输入数量 |
| 6 | INPUTUNITNO | nvarchar | (30) |  |  |  | √ |  | 输入单位编号 |
| 7 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 8 | SCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 损坏数 |
| 9 | OTHERQTY | numeric | (12,4) |  |  |  | √ |  | 其他数量 |
| 10 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 11 | UNITPRICE | numeric | (12,4) |  |  |  | √ |  | 单价 |
| 12 | RETURNUNITNO | nvarchar | (30) |  |  |  | √ |  | 回货单位编号 |
| 13 | RCVUSERNO | nvarchar | (30) |  |  |  | √ |  | 回货人员 |
| 14 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | LOG序号：生产批在作业站的LOG序号 |
| 15 | LOTSEQUENCE | numeric | (4,0) |  |  |  |  | 0 | 批号序号：外包中每个生产批的顺序 |
| 16 | SPC_OK | nvarchar | (1) |  |  |  | √ |  | SPC检验完成否 |
| 17 | SPCQTY | numeric | (12,4) |  |  |  | √ |  | SPC送验数 |
| 18 | TEMPINPUTERRQTY | numeric | (12,4) |  |  |  | √ |  | 暂存输入不良数：启用SPC整合时，送验SPC时，若有输入不良，则写入此栏位，待后续SPC判定回写在加总此栏位值回写至SCRAPQTY |
| 19 | BACKQTY | numeric | (12,4) |  |  |  |  | 0 | 验退 |
| 20 | TapeoutQTY | numeric | (12,4) |  |  |  | √ | 0 | T100 当站下线数量：不进行转移到下道制程 |
| 21 | ExcessQTY | numeric | (12,4) |  |  |  |  | 0 | 多余数量 |
| 22 | LOSSQTY | numeric | (12,4) |  |  |  |  | 0 | 短少数量 |
| 23 | IssueDefectQTY | numeric | (12,4) |  |  |  |  | 0 | 发料不良量：此数量会包含在计价数量中，此栏位单纯纪录用 |
| 24 | ValuationQTY | numeric | (12,4) |  |  |  |  | 0 | 计价数量：出货时，人员输入，进货时预带，进货确认时扣减，扣到0，不允许进货是在计价 |
| 25 | TURNBACKQTY | numeric | (12,4) |  |  |  | √ |  | 退回数量：不进行转移到下道制程 |
| 26 | DAMAGEQTY | numeric | (12,4) |  |  |  | √ |  | 破坏数量：不进行转移到下道制程 |
| 27 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 28 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 29 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 30 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 31 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 32 | OPNO | nvarchar | (200) |  |  |  | √ |  | 连续委外作业站 |
| 1 | OSNO | nvarchar | (50) | √ |  |  |  |  | 外包单号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 4 | ACCESSORYVERSION | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 5 | ACCUMULATEUSEDQTY | numeric | (12,4) |  |  |  |  |  | 累计使用数量：刚外包出去都是0，此为累计量 |
| 6 | ACCOSSTATUS | numeric | (2,0) |  |  |  |  |  | 治具外包状态：刚外包出去都是0 0：外包中 1：已回厂 |
| 7 | FROMACCSERIALNO | nvarchar | (20) |  |  |  |  |  | 模治具历程流水号：外包出货还原用到 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | supplier_no | nvarchar | (20) |  |  |  | √ |  | 供应商编号 |
| 2 | delivery_no | nvarchar | (20) | √ |  |  |  |  | 进站单号 |
| 3 | doc_type_no | numeric | (2,0) |  |  |  | √ |  | 工单类别 |
| 4 | wo_no | nvarchar | (50) |  |  |  | √ |  | 工单号 |
| 5 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 6 | process_no | nvarchar | (50) |  |  |  | √ |  | 流程编号 |
| 7 | process_ver | numeric | (2,0) |  |  |  | √ |  | 流程版本 |
| 8 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 9 | check_in_qty | numeric | (12,4) |  |  |  |  |  | 进站数量 |
| 10 | loggroupserial | nvarchar | (50) |  |  |  | √ |  | 生产批序号 |
| 11 | eventtime | datetime |  |  |  |  | √ |  | 作业时间 |
| 12 | os_no | nvarchar | (20) | √ |  |  |  |  | 外包单号 |
| 13 | CreateDate | datetime |  | √ |  |  |  |  | 创建时间：数据创建时间 |
| 14 | reply_start_date | datetime |  |  |  |  | √ |  | 交期开始 |
| 15 | reply_duedate | datetime |  |  |  |  | √ |  | 交期结束 |
| 16 | ec_os_no | nvarchar | (20) |  |  |  | √ |  | EC产生外包单号 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | delivery_out_no | nvarchar | (20) | √ |  |  |  |  | 出站单号 |
| 2 | supplier_no | nvarchar | (20) |  |  |  | √ |  | 供应商编号 |
| 3 | seq | nvarchar | (5) |  |  |  | √ |  | 序号 |
| 4 | delivery_no | nvarchar | (20) | √ |  |  |  |  | 进站单号 |
| 5 | doc_type_no | numeric | (2,0) |  |  |  | √ |  | 工单类别 |
| 6 | wo_no | nvarchar | (50) |  |  |  | √ |  | 工单号 |
| 7 | lot_no | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 8 | process_no | nvarchar | (50) |  |  |  | √ |  | 流程编号 |
| 9 | process_ver | numeric | (2,0) |  |  |  | √ |  | 流程版本 |
| 10 | op_no | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 11 | check_out_qty | numeric | (12,4) |  |  |  |  |  | 出站数量 |
| 12 | defect_qty | numeric | (12,4) |  |  |  |  |  | 不良数量 |
| 13 | defect_reason | nvarchar | (50) |  |  |  | √ |  | 不良描述 |
| 14 | next_op_no | nvarchar | (20) |  |  |  |  |  | 下一站编号 |
| 15 | next_workstation_no | nvarchar | (20) |  |  |  |  |  | 下一站区域 |
| 16 | loggroupserial | nvarchar | (50) |  |  |  | √ |  | 生产批序号 |
| 17 | eventtime | datetime |  |  |  |  | √ |  | 作业时间 |
| 18 | CreateDate | datetime |  | √ |  |  |  |  | 创建时间：数据创建时间 |
| 19 | is_back_fac | nvarchar | (30) |  |  |  | √ |  | 是否回厂 |
| 20 | MESNO | nvarchar | (50) |  |  |  | √ |  | EC产生外包单号 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | RETURNFLAG | numeric | (2,0) |  |  |  | √ |  | 是否已回sMES：#103453 Null：未回(未选择) 0：未回(未选择) 1：已经回(以选择) |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPOSDetailAlterLog — 外包出货变更表（9 字段）
> 主键：LotNo, EventTime
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | LOG序号 |
| 3 | OriQty | numeric | (12,4) |  |  |  |  |  | 原始数量 |
| 4 | ModifyQty | numeric | (12,4) |  |  |  |  |  | 变更数量 |
| 5 | EventTime | datetime |  | √ |  |  |  |  | 变更时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | LOTSEQUENCE | numeric | (4,0) |  |  |  |  |  | 生产批次序 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPOSPurchaseStockin — 外包回货入库表（25 字段）
> 主键：FROMOSNO, TOOSNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OsNo | nvarchar | (20) |  |  |  |  |  | 外包单号 |
| 2 | ERPNo | nvarchar | (50) |  |  |  |  |  | ERP单号 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | EventTime | datetime |  |  |  |  |  |  | 建立时间 |
| 6 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 7 | OpNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 8 | InputQty | numeric | (12,4) |  |  |  |  |  | 输入数量 |
| 9 | DefectQty | numeric | (12,4) |  |  |  |  |  | 缺陷数量 |
| 10 | ReceiptQty | numeric | (12,4) |  |  |  |  |  | 良品数量 |
| 11 | ReturnQty | numeric | (12,4) |  |  |  | √ |  | 验退数量 |
| 12 | ScrapQty | numeric | (12,4) |  |  |  | √ |  | 不良数量 |
| 13 | DamageQty | numeric | (12,4) |  |  |  | √ |  | 破坏数量 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | ORGOSNO | nvarchar | (20) |  |  |  |  |  | 原外包单号：连续外包时，出货作业最初的外包单号 |
| 2 | FROMOSNO | nvarchar | (20) | √ |  |  |  |  | 来源外包单号 |
| 3 | TOOSNO | nvarchar | (20) | √ |  |  |  |  | 目的外包单号 |
| 4 | TOOSSEQ | numeric | (2,0) |  |  |  |  |  | 单号顺序 |
| 5 | OSSTATUS | numeric | (2,0) |  |  |  |  |  | 外包状态：0：等待出货(连续外包) 1：出货完毕 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPOSReturnLog — 外包回货记录表（99 字段）
> 主键：PACKINGNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OSNO | nvarchar | (20) |  |  |  |  |  | 外包单号 |
| 2 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | ReturnQty | numeric | (12,4) |  |  |  |  |  | 回货良品数量 |
| 4 | ERPNo | nvarchar | (50) |  |  |  |  |  | ERP单号 |
| 5 | ReturnDate | datetime |  |  |  |  |  |  | 回货日期 |
| 6 | UserNo | nvarchar | (64) |  |  |  |  |  | 回货人员 |
| 7 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 8 | Stockin_MESNo | nvarchar | (50) |  |  |  | √ |  | MES入库单号 |
| 9 | Stockin_ERPNo | nvarchar | (50) |  |  |  | √ |  | MES入库单号 |
| 10 | CANCELFLAG | numeric | (1,0) |  |  |  |  | 0 | 取消识别码：0 未取消 1 已取消(单据还原) 2 SPC检验后回货 |
| 11 | OSReturnNo | nvarchar | (50) |  |  |  | √ |  | 回货单号 |
| 12 | Revisor | nvarchar | (30) |  |  |  | √ |  | 取消人员 |
| 13 | ReviseDate | datetime |  |  |  |  | √ | getdate | 修改日 |
| 14 | TurnBackQTY | numeric | (12,4) |  |  |  |  | 0 | 验退数量：3.4启用 验退数量 |
| 15 | ScrapQTY | numeric | (12,4) |  |  |  |  | 0 | 不良数量 |
| 16 | DamageQTY | numeric | (12,4) |  |  |  |  | 0 | SPC检验损坏数量 |
| 17 | ExcessQTY | numeric | (12,4) |  |  |  |  | 0 | 多余数量 |
| 18 | BACKQTY | numeric | (12,4) |  |  |  |  | 0 | 验退数量：暂停使用 |
| 19 | TapeoutQTY | numeric | (12,4) |  |  |  | √ | 0 | 验退数量(T100)：T100端回货同步MES使用 |
| 20 | QCFormNo | nvarchar | (30) |  |  |  | √ |  | 检验单号：回货集成SPC，对应SPC检验单号 |
| 21 | OSReturnQCFlag | numeric | (1,0) |  |  |  |  | 0 | 检验方式 |
| 22 | LOSSQTY | numeric | (12,4) |  |  |  |  | 0 | 短少数量 |
| 23 | IssueDefectQTY | numeric | (12,4) |  |  |  |  | 0 | 发料不良量：此数量会包含在计价数量中，此栏位单纯纪录用 |
| 24 | ValuationQTY | numeric | (12,4) |  |  |  |  | 0 | 计价数量：出货时，人员输入，进货时预带，进货确认时扣减，扣到0，不允许进货是在计价 |
| 25 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 26 | NEWLOTNO | nvarchar | (50) |  |  |  | √ |  | 新生产批号：回货时，分量回的数量变成一个新批号 |
| 27 | ECDELIVERYOUTNOSTRING | nvarchar | (4000) |  |  |  | √ |  | 对应EC出货单信息：#103453 会将EC出货单以分号的方式储存 出货单号1;出货单号2;出货单号3 |
| 28 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 29 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 30 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 31 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 32 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | OSNO | nvarchar | (50) |  |  |  |  |  | 外包单号 |
| 3 | ERPNO | nvarchar | (50) |  |  |  |  |  | ERP单号：如果没有ERP填N A |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 5 | ACCESSORYNO | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 6 | ACCESSORYVERSION | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 7 | USEDQTY | numeric | (12,4) |  |  |  |  |  | 使用数量：外包回货系统预带数量，使用者可以改变，依据改变值来填入 |
| 8 | ACCOSSTATUS | numeric | (2,0) |  |  |  |  |  | 治具外包状态：0：外包中 1：已回厂 |
| 9 | FROMACCSERIALNO | nvarchar | (20) |  |  |  |  |  | 模治具历程流水号 |
| 10 | RETURNDATE | datetime |  |  |  |  |  |  | 回货时间 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SENDID | nvarchar | (20) |  |  |  |  |  | 传送ID：原有外包作业，呼叫一次，产生一个SendID |
| 2 | SYNCSTATUS | numeric | (2,0) |  |  |  |  |  | 同步状态：0：初始 99：失效(已成功被抛转或是被还原) |
| 3 | SYNCTYPE | numeric | (1,0) |  |  |  |  |  | 同步型别(外包型别)：0：外包出货 1：外包回货 |
| 4 | OSNO | nvarchar | (20) |  |  |  |  |  | 外包单号 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | SUBCONTRACTORNO | nvarchar | (20) |  |  |  |  |  | 外包商编号 |
| 7 | DOC_TYPE | nvarchar | (50) |  |  |  |  |  | ERP单别：ERP外包时的采购单别 |
| 8 | SOURCENO | nvarchar | (50) |  |  |  |  |  | 外包单号(流水号)：会等同当初外包单回货时加的2码流水码，存的值为当初抛ERP时source_no栏位信息 |
| 9 | ISPQC | numeric | (2,0) |  |  |  |  |  | 是否PQC：出货用，中台有注记的栏位 进货用，中台没有注记的栏位 |
| 10 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人：外包时空，有透过界面修改时填入修改人员 |
| 11 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日期：外包时空，有透过界面修改时填入修改日期 |
| 12 | LASTRESENDUSER | nvarchar | (10) |  |  |  |  |  | 最后执行重送人员：外包时空，有透过界面按下重送时，纪录重送人员 |
| 13 | LASTRESENDDATE | datetime |  |  |  |  |  |  | 最后执行重送日期：外包时空，有透过界面按下重送时，纪录重送日期 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SENDID | nvarchar | (20) |  |  |  |  |  | 传送ID：原有外包作业，呼叫一次，产生一个SendID |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 5 | LOTSEQUENCE | numeric | (4,0) |  |  |  |  |  | 批号序号：外包中每个生产批的顺序 |
| 6 | QTY | numeric | (12,4) |  |  |  |  |  | 数量 |
| 7 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位 |
| 8 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站 |
| 9 | ISPQC | numeric | (2,0) |  |  |  |  |  | 是否PQC：出货用，中台有注记的栏位 进货用，中台没有注记的栏位 |
| 10 | QCFLAG | numeric | (2,0) |  |  |  |  |  | 回货QC：回货用，中台没有注记的栏位 |
| 11 | FACTORYNO | nvarchar | (20) |  |  |  |  |  | 工厂编号 |
| 12 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 13 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 14 | RETURNQTY | numeric | (12,4) |  |  |  |  |  | 回货数量：良品数 对应XML，receipt_qty |
| 15 | BACKQTY | numeric | (12,4) |  |  |  |  |  | 验退数量：对应XML，return_qty |
| 16 | SCRAPQTY | numeric | (12,4) |  |  |  |  |  | 报废数量：对应XML，scrap_qty |
| 17 | DAMAGEQTY | numeric | (12,4) |  |  |  |  |  | 破坏数量：对应XML，damage_qty |
| 18 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人：外包时空，有透过界面修改时填入修改人员 |
| 19 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日期：外包时空，有透过界面修改时填入修改日期 |
| 20 | DATAID | nvarchar | (100) |  |  |  |  |  | 数据识别码：储存数据的为一识别码 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 25 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PACKINGNO | nvarchar | (50) | √ |  |  |  |  | 箱号 |
| 2 | PROPERTYNO | nvarchar | (20) |  |  |  |  |  | 属性编号 |
| 3 | PROPERTYVALUE | nvarchar | (255) |  |  |  | √ |  | 属性值 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPPCSDisposition — 处置纪录（19 字段）
> 主键：DispNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | DispNo | nvarchar | (50) | √ |  |  |  |  | 处置编号 |
| 2 | Master_SID | nvarchar | (50) |  |  |  |  |  | 成品不良识别码：成品不良识别码 |
| 3 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 4 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 6 | SubOPSequence | numeric | (4,0) |  |  |  |  |  | 工序 |
| 7 | LogGroupSerial | nvarchar | (50) |  |  |  |  |  | 生产历程序号 |
| 8 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 9 | PCSNo | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 10 | StatusCode | nvarchar | (2) |  |  |  |  | '0' | 状态码：1：置换处置 2：维修处置(批次维修) 3：报废处置 4：解绑处置(单次维修) |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 13 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | REWORKSUBOPSEQ | numeric | (2,0) |  |  |  |  | 0 | 返回工序 |
| 16 | REWORKSUBOPSEQNAME | nvarchar | (50) |  |  |  | √ |  | 返回工序名称 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPCSDispositionClearLog — 处置记录解绑记录（16 字段）
> 主键：SID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 唯一识别码 |
| 2 | DispNo | nvarchar | (50) |  |  |  | √ |  | 处置识别码 |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 4 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 5 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 6 | PDLineNo | nvarchar | (50) |  |  |  | √ |  | 生产线编号 |
| 7 | PositionNo | nvarchar | (50) |  |  |  | √ |  | 工位 |
| 8 | SubOPSequence | numeric | (4,0) |  |  |  | √ |  | 工序 |
| 9 | UnitName | nvarchar | (50) |  |  |  | √ |  | 部件型别名称 |
| 10 | MaterialUnitNo | nvarchar | (50) |  |  |  | √ |  | 部件序号 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPCSDispositionDetail — 处置记录明细（9 字段）
> 主键：DispNo, ReasonNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | DispNo | nvarchar | (50) | √ |  |  |  |  | 处置编号 |
| 2 | DispTypeCode | nvarchar | (2) |  |  |  |  |  | 处置型别码：1：置换处置  2：维修处置(批次维修)  3：报废处置  4：解绑处置(单次维修) |
| 3 | ReasonNo | nvarchar | (20) | √ |  |  |  |  | 原因编号 |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPPCSDispositionExchange — 处置纪录置换表（70 字段）
> 主键：DispNo, NewSerial, L1_PACKINGSN, SEQ, L1_PACKINGSN, SEQ
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | DispNo | nvarchar | (50) | √ |  |  |  |  | 处置编号 |
| 2 | SerialTypeCode | nvarchar | (2) |  |  |  |  |  | 序号型别：1：成品序号 2.：部件序号 |
| 3 | OldSerial | nvarchar | (50) |  |  |  |  |  | 旧序号 |
| 4 | NewSerial | nvarchar | (255) | √ |  |  |  |  | 新序号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (50) |  |  |  |  |  | 流水号：与tblWIPPCSModifyReason.SID相同且对应 |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号：目前调整的生产批编号，会与tblWIPPCSModifyReason.LotNo相同 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号：目前调整的作业站编号 |
| 5 | SUBOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 工序：目前调整的工序 |
| 6 | ACTIONFLAG | numeric | (2,0) |  |  |  |  |  | 动作：0：添加，从无值变成有值 1：修改，从A值变成B值 2：删除，点选画面的删除，或是从有值变成无值 |
| 7 | SERIALTYPE | numeric | (2,0) |  |  |  |  |  | 序号型别：0：成品序号 1：部件序号 |
| 8 | ORGNO | nvarchar | (50) |  |  |  |  |  | 原序号：目前调整的序号 如果ActionFlag=0，是补成品 部件序号，此栏位为空 如果ActionFlag=1，填入修改前的成品 部件序号 如果ActionFlag=2，填入删除的成品 部件序号 |
| 9 | NEWNO | nvarchar | (50) |  |  |  |  |  | 新序号：目前调整后的序号 如果ActionFlag=0，是补成品 部件序号，此栏位为新的成品 部件序号 如果ActionFlag=1，填入修改后的成品 部件序号 如果ActionFlag=2，此栏位为空 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (50) |  |  |  |  |  | 流水号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 3 | REASONNO | nvarchar | (20) |  |  |  |  |  | 原因编号 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | L1_PACKINGSN | nvarchar | (50) | √ |  |  |  |  | L1包装箱号 |
| 2 | SEQ | numeric | (10,0) | √ |  |  |  |  | 顺序 |
| 3 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 5 | L1_PACKINGQTY | numeric | (10,0) |  |  |  |  |  | L1包装数量 |
| 6 | L2_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L2包装箱号 |
| 7 | L3_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L3包装箱号 |
| 8 | L4_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L4包装箱号 |
| 9 | L5_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L5包装箱号 |
| 10 | L6_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L6包装箱号 |
| 11 | BOXSTATES | numeric | (2,0) |  |  |  |  |  | 箱状态： 1  待检验 2  已检验 |
| 12 | ORDERNUMBER | nvarchar | (20) |  |  |  |  |  | 检验序号 |
| 13 | REMARK | nvarchar | (255) |  |  |  |  |  | 注记 |
| 14 | ISSTOCKIN | numeric | (2,0) |  |  |  |  |  | 已存在WMS：0 无 1 .有回到wms |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | L1_PACKINGSN | nvarchar | (50) | √ |  |  |  |  | L1包装箱号 |
| 3 | SEQ | numeric | (10,0) | √ |  |  |  |  | 顺序 |
| 4 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 5 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 6 | L1_PACKINGQTY | numeric | (10,0) |  |  |  |  |  | L1包装数量 |
| 7 | L2_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L2包装箱号 |
| 8 | L3_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L3包装箱号 |
| 9 | L4_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L4包装箱号 |
| 10 | L5_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L5包装箱号 |
| 11 | L6_PACKINGSN | nvarchar | (50) |  |  |  |  |  | L6包装箱号 |
| 12 | BOXSTATES | numeric | (2,0) |  |  |  |  |  | 箱状态： 1  待检验 2  已检验 |
| 13 | ORDERNUMBER | nvarchar | (20) |  |  |  |  |  | 检验序号 |
| 14 | REMARK | nvarchar | (255) |  |  |  |  |  | 注记 |
| 15 | ISSTOCKIN | numeric | (2,0) |  |  |  |  |  | 已存在WMS：0 无 1 .有回到wms |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPCSNoPacking — 序号包装档（80 字段）
> 主键：L1_PackingSN, Seq, ORDERNUMBER, SEQ, LOTNO, PCSNO, OPNO, SID, SID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | L1_PackingSN | nvarchar | (50) | √ |  |  |  |  | L1包装箱号 |
| 2 | Seq | numeric | (10,0) | √ |  |  |  |  | 顺序 |
| 3 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 4 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批编号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | L2_PackingSN | nvarchar | (50) |  |  |  | √ |  | L2包装箱号 |
| 10 | L3_PackingSN | nvarchar | (50) |  |  |  | √ |  | L3包装箱号 |
| 11 | L4_PackingSN | nvarchar | (50) |  |  |  | √ |  | L4包装箱号 |
| 12 | L5_PackingSN | nvarchar | (50) |  |  |  | √ |  | L5包装箱号 |
| 13 | Qty | numeric | (10,0) |  |  |  | √ |  | 装箱数量 |
| 14 | L1_PackingQty | numeric | (10,0) |  |  |  | √ |  | L1包装数量 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | L1_OPNO | nvarchar | (20) |  |  |  |  | '' | L1_作业站编号 |
| 17 | L1_EQUIPMENTNO | nvarchar | (50) |  |  |  |  | '' | L1设备代号 |
| 18 | L6_PACKINGSN | nvarchar | (50) |  |  |  | √ |  | L6包装箱号 |
| 19 | BOXSTATES | numeric | (2,0) |  |  |  |  | 0 | 箱状态：-1  已失效 0  生效 1  待检验 2  已检验 |
| 20 | ORDERNUMBER | nvarchar | (20) |  |  |  |  | '' | 检验序号 |
| 21 | WMS_PACKINGSN | nvarchar | (50) |  |  |  |  | '' | WMS条形码编号：相同箱号，不同生产批批号，需拆解回传给wms |
| 22 | PCSNOSTATUS | numeric | (2,0) |  |  |  |  | 0 | 成品序号状态：0：未包装处置 1：包装处置已返修 2：包装处置已报废 |
| 23 | BOXTYPE | numeric | (2,0) |  |  |  |  | 0 | 箱型别：0：包装作业产生 1：外包装箱号生成打印(批次级)生成 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | ORDERNUMBER | nvarchar | (20) | √ |  |  |  |  | 检验序号 |
| 3 | SEQ | numeric | (10,0) | √ |  |  |  |  | 顺序 |
| 4 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 包装序号 |
| 5 | LEVEL | numeric | (2,0) |  |  |  |  |  | 阶级 |
| 6 | TESTCODE | numeric | (2,0) |  |  |  |  |  | 结果：0 NG 1 OK |
| 7 | DESCRIBE | nvarchar | (255) |  |  |  |  |  | 描述 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | PANELNO | nvarchar | (50) |  |  |  |  |  | 板号 |
| 5 | PARTIALOUTGUID | nvarchar | (64) |  |  |  |  |  | 出站guid：出站guid |
| 6 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 7 | SUBOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 工序 |
| 8 | REWORKSTATE | nvarchar | (1) |  |  |  |  |  | 返工状态：1：出站；2：解绑返工；3；解绑生产完成。 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 唯一识别码 |
| 3 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 5 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 6 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 产线编号 |
| 7 | MACHINENO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 8 | SUBOPSEQUENCE | nvarchar | (10) |  |  |  |  |  | 工序 |
| 9 | EVENTTIME | datetime |  |  |  |  |  |  | 过站时间 |
| 10 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 唯一识别码 |
| 3 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 5 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站编号 |
| 6 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 产线编号 |
| 7 | MACHINENO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 8 | SUBOPSEQUENCE | nvarchar | (10) |  |  |  |  |  | 工序 |
| 9 | EVENTTIME | datetime |  |  |  |  |  |  | 过站时间 |
| 10 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 11 | PARTIALOUTTIME | datetime |  |  |  |  |  |  | 出站时间 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPositionCollectMLotLog — 产品属性（15 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 2 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 3 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 4 | MaterialName | nvarchar | (255) |  |  |  |  |  | 物料名称 |
| 5 | MaterialLotNo | nvarchar | (500) |  |  |  | √ |  | 物料批号 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 8 | ModifyUser | nvarchar | (30) |  |  |  | √ |  | 修改人员 |
| 9 | ModifyDate | datetime |  |  |  |  | √ | getdate | 修改日期 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | LOTNO | nvarchar | (50) |  |  |  |  | '' |  |
| 12 | MATERIALNO | nvarchar | (50) |  |  |  |  | '' |  |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPositionCollectMLotSet — 物料批号绑定（15 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 生产线编号 |
| 2 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 3 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号：Ｎ A |
| 4 | MaterialName | nvarchar | (255) |  |  |  |  |  | 物料名称 |
| 5 | MaterialLotNo | nvarchar | (50) |  |  |  | √ |  | 物料批号 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ | getdate | 建立时间：数据建立时间 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | LOTNO | nvarchar | (50) |  |  |  |  | '' |  |
| 11 | MATERIALNO | nvarchar | (50) |  |  |  |  | '' |  |
| 12 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPositionCollectMTLLog — 物料名称修改纪录（12 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PDLineNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 2 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 3 | PositionNo | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 4 | MaterialName | nvarchar | (255) |  |  |  |  |  | 物料名称 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 7 | ModifyUser | nvarchar | (30) |  |  |  | √ |  | 修改人员 |
| 8 | ModifyDate | datetime |  |  |  |  | √ | getdate | 修改日期 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPPositionCollectMTLSet — 物料名称设定（177 字段）
> 主键：PDLineNo, OPNo, PositionNo, MaterialName, ID, RETURNNO, LOTNO, REWORKLOTNO, REASONNO, RollBackLog_GUID, SID, SID, LOTNO, FROMLOTNO, TOLOTNO, EVENTTIME
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PDLineNo | nvarchar | (50) | √ |  |  |  |  | 产线编号 |
| 2 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | PositionNo | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 4 | MaterialName | nvarchar | (255) | √ |  |  |  |  | 物料名称 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：导出 |
| 6 | CreateDate | datetime |  |  |  |  | √ | getdate | 数据键值：创建者 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据创建人员：创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 数据创建时间：数据状态 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 数据目前状态：修改者 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 子作业工时结算明细表 |
| 1 | ID | nvarchar | (64) | √ |  |  |  |  | ID |
| 2 | PRINTTYPE | nvarchar | (8) |  |  |  |  |  | 打印型别：1-批次流程卡 3-标签打印 4-外包单列印 5-模具维修单列印' 6-包装序号 2暂时作废 |
| 3 | PRINTNO | nvarchar | (50) |  |  |  |  |  | 打印编码：1-生产批号 3-BARCODE 4-外包单号 5-模治具维修单号 6-BoxNo |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | RETURNNO | nvarchar | (20) | √ |  |  |  |  | 还原编号 |
| 2 | SHIPPINGNO | nvarchar | (20) |  |  |  |  |  | 发货编号 |
| 3 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 5 | QTY | numeric | (12,4) |  |  |  |  |  | 数量 |
| 6 | RETURNREASON | nvarchar | (255) |  |  |  | √ |  | 还原原因 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 9 | PACKINGLISTNO | nvarchar | (20) |  |  |  |  |  | 装箱单编号 |
| 10 | UNRELEASEQTY | numeric | (12,4) |  |  |  | √ |  | 未释出数量 |
| 11 | CUSTOMERNO | nvarchar | (50) |  |  |  |  |  | 客户编号 |
| 12 | STATE | numeric | (2,0) |  |  |  | √ | 0 | 状态 |
| 13 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批流水号 |
| 2 | UPDATESQL | nvarchar | (-1) |  |  |  | √ |  | 更新SQL语句 |
| 3 | REVERSEORDER | numeric | (8,0) |  |  |  |  |  | 还原次序 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | REWORKLOTNO | nvarchar | (50) | √ |  |  |  |  | 重工编号 |
| 3 | REASONNO | nvarchar | (20) | √ |  |  |  |  | 原因编号 |
| 4 | EVENTTIME | datetime |  |  |  |  |  |  | 建立日期 |
| 5 | OpNo | nvarchar | (50) |  |  |  |  | 'N/A' | 作业站 |
| 6 | ReworkOpNo | nvarchar | (50) |  |  |  |  | 'N/A' | 重工至作业站 |
| 7 | EquipmentNo | nvarchar | (50) |  |  |  |  | 'N/A' | 设备编号 |
| 8 | LotState | numeric | (3,0) |  |  |  |  | 0 | 生产批状态 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LotNo | nvarchar | (50) |  |  |  |  |  | 批号 |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设别编号 |
| 3 | OPNo | nvarchar | (20) |  |  |  | √ |  | from作业站 |
| 4 | INVENTORYNO | nvarchar | (20) |  |  |  | √ |  | from仓库编号 |
| 5 | ToOPNo | nvarchar | (20) |  |  |  |  |  | to作业站 |
| 6 | FromType | nvarchar | (2) |  |  |  |  |  | from状态 |
| 7 | ToType | nvarchar | (2) |  |  |  |  |  | to状态 |
| 8 | Type | nvarchar | (2) |  |  |  |  |  | 处理型别 |
| 9 | EventTime | datetime |  |  |  |  |  |  | 建立时间 |
| 10 | UserNo | nvarchar | (30) |  |  |  |  |  | 使用者 |
| 11 | RINVQty | numeric | (12,4) |  |  |  |  |  | 还原仓库量 |
| 12 | RGoodQty | numeric | (12,4) |  |  |  |  |  | 还原良品数 |
| 13 | RScrapQty | numeric | (12,4) |  |  |  |  |  | 还原废品数 |
| 14 | RLackQty | numeric | (12,4) |  |  |  |  |  | 还原短少数 |
| 15 | RExcessQty | numeric | (12,4) |  |  |  |  |  | 还原多余数 |
| 16 | BINVQty | numeric | (12,4) |  |  |  |  |  | 还原前库存量 |
| 17 | BFromQty | numeric | (12,4) |  |  |  |  |  | 还原前from状态数量 |
| 18 | BToQty | numeric | (12,4) |  |  |  |  |  | 还原前to状态数量 |
| 19 | INVQty | numeric | (12,4) |  |  |  |  |  | 还原后仓库量 |
| 20 | FromQty | numeric | (12,4) |  |  |  |  |  | 还原后from状态量 |
| 21 | ToQty | numeric | (12,4) |  |  |  |  |  | 还原后to状态量 |
| 22 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 28 | RollBackLog_GUID | nvarchar | (50) | √ |  |  |  |  | 还原编号 |
| 1 | SID | numeric | (8,0) | √ |  | √ |  |  | 流水号 |
| 2 | NCRNO | nvarchar | (50) |  |  |  |  |  | 不良品判定记录序号 |
| 3 | HEADSID | numeric | (8,0) |  |  |  |  |  | 主信息流水号 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批次号 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站点 |
| 6 | REASONNO | nvarchar | (20) |  |  |  | √ |  | 不良原因 |
| 7 | EVENTID | nvarchar | (100) |  |  |  | √ |  | 异常事件ID |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | numeric | (8,0) | √ |  | √ |  |  | 流水号 |
| 2 | NCRNO | nvarchar | (50) |  |  |  |  |  | 不良品判定记录序号 |
| 3 | OPERATIONTYPE | numeric | (1,0) |  |  |  |  |  | 异常判定：0-重工 1-让步 2-误判 3-报废入库 4-不良品入库 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | EVENTID | nvarchar | (100) |  |  |  | √ |  | 异常事件ID |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | FROMLOTNO | nvarchar | (50) | √ |  |  |  |  | 来源生产编号 |
| 3 | FROMBASELOTNO | nvarchar | (50) |  |  |  |  |  | 来源主编号 |
| 4 | FROMLOTSERIAL | nvarchar | (55) |  |  |  |  |  | 来源生产批流水号 |
| 5 | FROMLOTQTY | numeric | (12,4) |  |  |  |  |  | 来源数量 |
| 6 | FROMSCRAPQTY | numeric | (12,4) |  |  |  |  |  | 来源损坏数 |
| 7 | FROMOTHERQTY | numeric | (12,4) |  |  |  |  |  | 来源其他数量 |
| 8 | TOLOTNO | nvarchar | (50) | √ |  |  |  |  | 目的生产编号 |
| 9 | TOBASELOTNO | nvarchar | (50) |  |  |  |  |  | 目的主编号 |
| 10 | TOLOTSERIAL | nvarchar | (55) |  |  |  |  |  | 目的生产批流水号 |
| 11 | TOLOTQTY | numeric | (12,4) |  |  |  |  |  | 目的数量 |
| 12 | TOSCRAPQTY | numeric | (12,4) |  |  |  |  |  | 目的损坏数 |
| 13 | TOOTHERQTY | numeric | (12,4) |  |  |  |  |  | 目的其他数量 |
| 14 | REFLOTNO | nvarchar | (50) |  |  |  |  |  | 参考批号 |
| 15 | MAJORLOT | numeric | (1,0) |  |  |  |  |  | 主要批 |
| 16 | SMTYPE | numeric | (2,0) |  |  |  |  |  | 分并批类型 |
| 17 | EVENTTIME | datetime |  | √ |  |  |  |  | 建立时间 |
| 18 | ERPFLAG | numeric | (1,0) |  |  |  |  |  | ERP标示 |
| 19 | CLOSEFLAG | numeric | (1,0) |  |  |  | √ |  | 关闭标示 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 2 | FROMLOTNO | nvarchar | (50) |  |  |  |  |  | 来源生产编号 |
| 3 | FROMBASELOTNO | nvarchar | (50) |  |  |  |  |  | 来源主编号 |
| 4 | FROMLOTSERIAL | nvarchar | (55) |  |  |  |  |  | 来源生产批流水号 |
| 5 | FROMLOTQTY | numeric | (12,4) |  |  |  |  |  | 来源数量 |
| 6 | FROMSCRAPQTY | numeric | (12,4) |  |  |  |  |  | 来源损坏数 |
| 7 | FROMOTHERQTY | numeric | (12,4) |  |  |  |  |  | 来源其他数量 |
| 8 | TOLOTNO | nvarchar | (50) |  |  |  |  |  | 目的生产编号 |
| 9 | TOBASELOTNO | nvarchar | (50) |  |  |  |  |  | 目的主编号 |
| 10 | TOLOTSERIAL | nvarchar | (55) |  |  |  |  |  | 目的生产批流水号 |
| 11 | TOLOTQTY | numeric | (12,4) |  |  |  |  |  | 目的数量 |
| 12 | TOSCRAPQTY | numeric | (12,4) |  |  |  |  |  | 目的损坏数 |
| 13 | TOOTHERQTY | numeric | (12,4) |  |  |  |  |  | 目的其他数量 |
| 14 | REFLOTNO | nvarchar | (50) |  |  |  |  |  | 参考批号 |
| 15 | MAJORLOT | numeric | (1,0) |  |  |  |  |  | 主要批 |
| 16 | SMTYPE | numeric | (2,0) |  |  |  |  |  | 分并批类型 |
| 17 | EVENTTIME | datetime |  |  |  |  |  |  | 建立时间 |
| 18 | ERPFLAG | numeric | (1,0) |  |  |  |  |  | ERP标示 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FROMLOTNO | nvarchar | (50) |  |  |  |  |  | 来源生产编号 |
| 2 | FROMLOTSERIAL | nvarchar | (55) |  |  |  |  |  | 来源生产批号 |
| 3 | FROMREVERSEID | numeric | (6,0) |  |  |  |  |  | 来源还原编号 |
| 4 | TOLOTNO | nvarchar | (50) |  |  |  |  |  | to批号 |
| 5 | TOLOTSERIAL | nvarchar | (55) |  |  |  |  |  | to生产批序号 |
| 6 | TOREVERSEID | numeric | (6,0) |  |  |  |  |  | to还原编号 |
| 7 | SPLITTYPE | numeric | (2,0) |  |  |  |  |  | 分批方式 |
| 8 | MAJORLOT | numeric | (1,0) |  |  |  |  | 0 | 主要批 |
| 9 | FROMLOTQTY | numeric | (12,4) |  |  |  | √ |  | 来源数量 |
| 10 | FROMSCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 来源损坏数 |
| 11 | FROMOTHERQTY | numeric | (12,4) |  |  |  | √ |  | 来源其他数量 |
| 12 | TOLOTQTY | numeric | (12,4) |  |  |  | √ |  | to批量 |
| 13 | TOSCRAPQTY | numeric | (12,4) |  |  |  | √ |  | to损坏数 |
| 14 | TOOTHERQTY | numeric | (12,4) |  |  |  | √ |  | to其他数量 |
| 15 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 16 | USERNO | nvarchar | (30) |  |  |  | √ |  | 使用者编号 |
| 17 | EVENTTIME | datetime |  |  |  |  | √ |  | 建立日期 |
| 18 | FROMBASELOTNO | nvarchar | (50) |  |  |  | √ |  | 来源主批号 |
| 19 | TOBASELOTNO | nvarchar | (50) |  |  |  | √ |  | to主批号 |
| 20 | FROMMONO | nvarchar | (50) |  |  |  | √ |  | 来源工单编号 |
| 21 | TOMONO | nvarchar | (50) |  |  |  | √ |  | to工单编号 |
| 22 | LotStatus | numeric | (2,0) |  |  |  | √ |  | 状态：与tblWIPLotState代表意义相同，填入并批当下，生产批状态 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 25 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 26 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 28 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPStartingChecklistLog — 始业点检历程表（18 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SEQ | nvarchar | (100) |  |  |  |  |  | 序号 |
| 2 | AREANO | nvarchar | (100) |  |  |  |  |  | 区域编号 |
| 3 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 4 | PRODUCTNO | nvarchar | (100) |  |  |  |  |  | 产品编号 |
| 5 | INSPECTIONNO | nvarchar | (100) |  |  |  |  |  | 检验编号 |
| 6 | INSPECTIONNAME | nvarchar | (255) |  |  |  | √ |  | 检验名称 |
| 7 | INSPECTIONRESULT | numeric | (1,0) |  |  |  |  |  | 检验结果 |
| 8 | INSPECTIONTYPE | numeric | (1,0) |  |  |  | √ |  | 检验类型 |
| 9 | INPUTVALUE | nvarchar | (50) |  |  |  | √ |  | 输入值 |
| 10 | STDVALUE | nvarchar | (12) |  |  |  | √ |  | 标准值 |
| 11 | MAXIVALUE | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 12 | MINIVALUE | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 13 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 14 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 15 | STATUS | numeric | (1,0) |  |  |  | √ | 0 | 状态 |
| 16 | INSPECTIONMETHOD | nvarchar | (100) |  |  |  | √ |  | 检验方法 |
| 17 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPStartingChecklistResult — 始业点检结果（87 字段）
> 主键：PRODUCTNO, INSPECTIONNO, AREANO, POSITIONNO, LOTNO, OPNO, SUBOPNO, EVENTTIME, LOTNO, OPNO, SUBOPNO, EVENTTIME, RESITEM, USERNO, LOTNO, OPNO, SUBOPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PRODUCTNO | nvarchar | (100) | √ |  |  |  |  | 产品编号 |
| 2 | INSPECTIONNO | nvarchar | (100) | √ |  |  |  |  | 检验编号 |
| 3 | AREANO | nvarchar | (50) | √ |  |  |  |  | 区域编号 |
| 4 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 5 | INSPECTIONRESULT | numeric | (1,0) |  |  |  |  |  | 检验结果 |
| 6 | INPUTVALUE | nvarchar | (50) |  |  |  | √ |  | 投入值 |
| 7 | STATUS | numeric | (1,0) |  |  |  | √ | 0 | 状态 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 9 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 10 | MODIFIER | nvarchar | (30) |  |  |  | √ |  | 更新人员 |
| 11 | MODIDATE | datetime |  |  |  |  | √ |  | 更新人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | log序号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 3 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 4 | SUBOPNO | nvarchar | (20) |  |  |  |  |  | 子作业站 |
| 5 | EVENTTIME | datetime |  |  |  |  |  |  | 产出时间 |
| 6 | REASONTYPE | numeric | (2,0) |  |  |  |  |  | 原因型别 |
| 7 | ERRORNO | nvarchar | (20) |  |  |  |  |  | 不良编号 |
| 8 | ERRORLEVEL | numeric | (1,0) |  |  |  |  | 0 | 不良等级 |
| 9 | ERRORQTY | numeric | (12,4) |  |  |  |  |  | 不良数 |
| 10 | COMPONENTNO | nvarchar | (30) |  |  |  | √ |  | 组成编号 |
| 11 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 12 | FLAG | numeric | (1,0) |  |  |  |  | 0 | 标识 |
| 13 | FLAGTIME | datetime |  |  |  |  | √ |  | 标识时间 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | SUBOPNO | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 5 | EVENTTIME | datetime |  | √ |  |  |  |  | 建立时间 |
| 6 | USERNO | nvarchar | (30) |  |  |  |  |  | 使用者 |
| 7 | INPUTOTY | numeric | (12,4) |  |  |  |  |  | 投入量 |
| 8 | GOODQTY | numeric | (12,4) |  |  |  |  |  | 良品数 |
| 9 | SCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 不良数 |
| 10 | EXCESSQTY | numeric | (12,4) |  |  |  | √ |  | 多余数 |
| 11 | LACKQTY | numeric | (12,4) |  |  |  | √ |  | 短少数 |
| 12 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备 |
| 13 | FLAG | numeric | (1,0) |  |  |  |  | 0 | 标志：生产批出站报工流程，汇总数据用。 报工还原需要更新为0。 0  未结算 1  出站流程已取用过的数据。 |
| 14 | FLAGTIME | datetime |  |  |  |  | √ |  | 标志时间：报工还原时，mapping数据的判断栏位。 被结算的数据列，会写入生产批check out 的evnttime， 所以在执行生产批报工还原时，须将此栏位压成回空值。 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | SUBOPNO | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 5 | EVENTTIME | datetime |  | √ |  |  |  |  | 写入时间：子作业报完工的时间 tblWIPSubOPCont_Resource、tblWIPSubOPCont_Partialout、tblWIPSubOPCont_Error 这三个table的evnttime必须相同 |
| 6 | RESCLASS | numeric | (12,4) |  |  |  |  |  | 资源大分类：0 EMP（人时） 1 EQP（机时） |
| 7 | RESITEM | nvarchar | (50) | √ |  |  |  |  | 设备编号：依据资源主分类记录不同数据 EMP：EMP EQP：设备编号 |
| 8 | RESVALUE | numeric | (12,4) |  |  |  |  |  | 使用者ID：多人产量登入的人员代号 当此笔数据是机时类别时，写入的人员代号为登入系统的账号数据。 |
| 9 | STDVALUE | numeric | (12,4) |  |  |  |  | 0 | 输入数量：多人产量登入的人员各自回报的数量 当此笔数据是机时类别时，写入的数量为系统操作时的完工数量。 |
| 10 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 实际用量：结算出来的工时数据，单位是分钟 |
| 11 | USERNO | nvarchar | (50) | √ |  |  |  |  | 标准用量：暂不用 |
| 12 | FLAG | numeric | (1,0) |  |  |  |  | 0 | 生产批出站结算：生产批出站报工流程，汇总数据用。 报工还原需要更新为0。 0  未结算 1  出站流程已取用过的数据。 |
| 13 | FLAGTIME | datetime |  |  |  |  | √ |  | 结算时间：报工还原时，mapping数据的判断栏位。 被结算的数据列，会写入生产批check out 的evnttime， 所以在执行生产批报工还原时，须将此栏位压成回空值。 |
| 14 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价型别 |
| 15 | UnitPrice | numeric | (23,8) |  |  |  |  | 0 | 工价 |
| 16 | PriceRate | numeric | (23,8) |  |  |  |  | 0 | 工价比率 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | SUBOPNO | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 5 | STATUS | numeric | (1,0) |  |  |  |  | 0 | 状态 |
| 6 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 7 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 8 | GOODQTY | numeric | (12,4) |  |  |  |  |  | 良品数 |
| 9 | SCRAPQTY | numeric | (12,4) |  |  |  |  |  | 不良数 |
| 10 | EXCESSQTY | numeric | (12,4) |  |  |  |  |  | 多余数 |
| 11 | LACKQTY | numeric | (12,4) |  |  |  |  |  | 短少数 |
| 12 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblWIPTEMPCont_PCSNo — 成品序号（76 字段）
> 主键：EquipmentNo, LotNo, OPNo, PCSNo, CollectionType, WAITNO, WAITNO, REASONNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | PCSNo | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 5 | CollectionType | numeric | (1,0) | √ |  |  |  | 1 | 收集方式：0 进站收集  1出站收集 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | WAITNO | nvarchar | (20) | √ |  |  |  |  | 等待编号 |
| 2 | BASELOTNO | nvarchar | (50) |  |  |  |  |  | 基础批 |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 4 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 批序号 |
| 5 | WAITSOURCE | numeric | (1,0) |  |  |  |  |  | 等待原因：0 WIP（WIP开立的异常单） 1 SPC（纯SPC开立的异常单） |
| 6 | WAITTYPE | numeric | (1,0) |  |  |  |  |  | 型别：0 BR Wait (由企业逻辑产生等待单) 1 Rule Wait (由法则检查产生等待单) 2 Immediate Wait (立即异常设定产生等待单) 3 Future Wait (预先异常设定产生等待单) 4 Component Wait (由元件产生等待单) 5 Queue Wait(等待暂停、外包出货暂停) 6 Run Wait(生产暂停) |
| 7 | WAITTIME | numeric | (1,0) |  |  |  | √ |  | 时间 |
| 8 | STATUS | numeric | (2,0) |  |  |  |  |  | 状态：状态 0 未解除 21 已解除 |
| 9 | LOTISVALID | numeric | (1,0) |  |  |  |  |  | 批号有效性：0：No(不执行批号有效性检查)  1：Yes(执行批号有效性检查) |
| 10 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 11 | CREATEQTY | numeric | (12,4) |  |  |  |  |  | 开立数量 |
| 12 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 13 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | CUSTOMERNO | nvarchar | (50) |  |  |  | √ |  | 客户编号 |
| 16 | PRODUCTNO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 17 | CREATEDEPARTMENTNO | nvarchar | (20) |  |  |  | √ |  | 建立部门编号 |
| 18 | RULENO | nvarchar | (20) |  |  |  | √ |  | 法则编号 |
| 19 | WAITDESCRIPTION | nvarchar | (3000) |  |  |  | √ |  | 等待说明 |
| 20 | MODULESERIAL | nvarchar | (50) |  |  |  |  | 'N/A' | 模块序号 |
| 21 | MODULENO | nvarchar | (50) |  |  |  |  | 'N/A' | 模块编号 |
| 22 | MODULEVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 模块版次 |
| 23 | MODULENODEID | nvarchar | (100) |  |  |  |  | 'N/A' | 模块节点ID |
| 24 | MODULESTAGENO | nvarchar | (50) |  |  |  |  | 'N/A' | 制造层别 |
| 25 | RELEASEQTY | numeric | (12,4) |  |  |  | √ |  | 下线数量 |
| 26 | RELEASER | nvarchar | (30) |  |  |  | √ |  | Releaser |
| 27 | RELEASEDATE | datetime |  |  |  |  | √ |  | 下线日期 |
| 28 | CONTLOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Cont LogGroup Serial |
| 29 | BATCHWAITNO | nvarchar | (20) |  |  |  | √ |  | 批次等待(Wait)编号 |
| 30 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 31 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 32 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备型别 |
| 33 | ReworkFlag | numeric | (2,0) |  |  |  |  | 0 | 重工标志：0：Default  1：需重工 |
| 34 | WAITCOUNTERORG | numeric | (12,4) |  |  |  |  | 0 | 暂停期间计数器产量 |
| 35 | WAITCOUNTERCOMMIT | numeric | (12,4) |  |  |  |  | 0 | 取消暂停计数器认定产量 |
| 36 | WAITLOTSTATUS | numeric | (2,0) |  |  |  |  | 0 | 暂停时生产批状态：#86921、#78035 0：Queue暂停 1：Run暂停 5：OS暂停 |
| 37 | INVROLLBACKFLAG | numeric | (2,0) |  |  |  |  | 0 | 库房还原旗标：#86921、#78035 0：未还原 1：已还原 |
| 38 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 39 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 40 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 41 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | WAITNO | nvarchar | (20) |  |  |  |  |  | 暂停编号 |
| 2 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批序号 |
| 3 | LOTDISPTYPE | numeric | (2,0) |  |  |  |  |  | 处置型别：0 Go(续Go) 1 Jump OP(跳站、重工、让步) 2 Jump Process(跳流程) 3 Inventory(入库)，入WIP半成品库 4 Process Turning(流程调整) 5 Change ENGNo(变更工程码) 6 Jump Module(跳模块) 7 Scrap Invebtory(入不良品库)，入WIP损坏库 8 Jump Main(跳主流程)，主流程即下线时之流程 12 Split(分批) 13 Merge(并批) 14 整批撤销(益睿先行个案) |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | NODEID | nvarchar | (100) |  |  |  | √ |  | 节点识别符号(Id) |
| 8 | INVENTORYNO | nvarchar | (50) |  |  |  | √ |  | 库房编号 |
| 9 | RETURNTYPE | numeric | (1,0) |  |  |  | √ |  | 回原流程型态 |
| 10 | RETURNNODEID | nvarchar | (100) |  |  |  | √ |  | 返回节点标识符 |
| 11 | MODULENO | nvarchar | (50) |  |  |  | √ |  | 模块编号 |
| 12 | MODULEVERSION | nvarchar | (5) |  |  |  | √ |  | 模块版次 |
| 13 | STARTNODEID | nvarchar | (100) |  |  |  | √ |  | 开始节点标识符 |
| 14 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 15 | EVENTID | nvarchar | (100) |  |  |  | √ |  | 采集批次编号 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | WAITNO | nvarchar | (50) | √ |  |  |  |  | 暂停编号 |
| 2 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 暂停原因 |
| 3 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 8 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
