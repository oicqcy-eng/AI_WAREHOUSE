# 知识卡片 — sMES_Production_61100 数据字典（K-621）

> 从 `SMES_621数据库设计文档20250313.html` 提炼，卡片编号 **K-621-01** 起（与三厂小簧项目 K-001~007 区分）。
> 五要素：业务对象 / 关键表 / 字段口径 / 接口规则 / 待确认项。所有字段以资料原文为准。

## K-621-01: 在制品/工单/报工（WIP）

- **业务对象**: 生产批(Lot)、工单(MO)、序号(PCS)、报工、包装、外包、处置、看板
- **关键表**: `tblWIPLot_Report_Offline`(报工作业)、`tblWIPCont_DailyWorkReport`(日结报工单)、`tblOEMOSource`(工单来源)、`tblWIPBarCode`(条码主档)、`tblWIPCont_PCSNo`(成品序号)、`tblWIPPCSDisposition*`(处置)、`tblWIPOS*`(外包)、`tblWIPMaterialDemandBoard`(叫料看板)
- **字段口径**:
  - 核心键：`LotNo`(批号)+`OPNo`(作业站)+`ReportDate`(日期)+`EquipmentNo`(设备)+`UserNo`(人员) 组合主键
  - 报工数：`GOODQTY`(良品数)/`FAILQTY`(不良数)，`STATUS`(状态 numeric)
  - 人时机时口径：`EMPTime_s`(人时秒)=EMPTimeSum_s−EMPLot_s−EMPLotSum_s；`EQPTime_s`(机时秒)同理
  - 条码：`BarCode`(标签号)+`BarcodeQty`(数量)，`ProductDate`(生产日期=出站日期)、`BarCodeVldDate`(有效日期=出站日期)
- **接口规则**: `tblWIPCont_DailyWorkReport_ERP`(日结报工单抛转历程)、`tblWIPCont_ERPMtlList`(倒扣料抛转) → 与 ERP 集成
- **待确认项**: PCS 序号体系存在多张新旧表（`tblWIPCont_PCSNo` 标注"旧表格"），正反追溯以哪张为准需确认

## K-621-02: 日结报工与暂存

- **业务对象**: 每日报工单、人员/设备/批次上下线区间暂存、人时机时成本分摊
- **关键表**: `tblWIPCont_DailyWorkReport`(报工单信息)、`tblWIPTemp_DailyWR_*`(每日暂存：EMPTime人时分摊/EQPTime机时分摊/LotOn批次区间/ReportQty数量)、`tblWIPCont_DailyWorkMESNO`(报工单号)
- **字段口径**: 每日暂存按 `生产批×设备×人员×日期` 切分，为工价/成本核算准备
- **待确认项**: 暂存表 `_DailyWR_LotRealOn`(有效上线) 与 `_LotOn`(上线) 的差异规则

## K-621-03: SMT 产线

- **业务对象**: SMT 区域/设备/料站/Feeder/台车/卷料/工具/点检维护/产品序号投产出
- **关键表**: `tblSMTProcessBasis`(产品工序主档)、`tblSMDPDLinePositionBasis`(工位)、`tblSMTFeederList*`(料站)、`tblSMTFeederBasis`(Feeder主档)、`tblSMTReelBasis`(卷料)、`tblSMTMFU*`(台车)、`tblSMTTool*`(工具)、`tblSMTMaintain*`(维修)、`tblSMTProductPostIn/OutLog`(序号投入/产出)
- **字段口径**: `ProcessNo` 以 GUID 生成(`SYS_GUID()`/`NEWID()`)，`ProductNo`+`ProductVersion`(默认`'01'`) 双键；`ISSUESTATE` 为数据状态
- **接口规则**: `tblSMTEQPResource*`(设备资源履历)、`tblSMTResourceActionLog`(资源动作)
- **待确认项**: SMT 与通用 WIP 的序号追溯链路衔接方式

## K-621-04: 模治具/设备/保养

- **业务对象**: 模治具(ACC)台账、定期保养(PM)、维修、寿命、备品；设备台账、点检、稼动原因
- **关键表**: `tblEQPEquipmentAccessoryMap`(设备-模治具对应)、`tblACCChangeTime`(换模时间)、`tblEMSACCLog_Repair`(维修历程)、`tblACCRegularPMPlanBasis/Detail`(保养计划)、`tblEMSACCRegularPMLog`(保养历程)、`tblEQPEquipmentCheckUpRate`(多频率点检)、`tblEQPEquipmentReason`(稼动原因)、`tblEMSACCSubstitutionUsed`(备品使用)
- **字段口径**: 复合主键 `EquipmentNo`+`AccessoryNo`+`AccessoryVersion`；换模时间含 `PrepareTime`(换模准备)/`LoadTime`(上模标准)/`UnloadTime`(下模标准)；模治具类别 `ACCESSORYTYPE`、版次 `AccessoryVersion`
- **待确认项**: `tblEQPACCRepairItem`(维修项目 675 字段)、`tblEMSCombineACCLog`(组合历程 251 字段) 超大表设计用途

## K-621-05: 注塑 Recipe

- **业务对象**: 注塑设备、Recipe 主档/明细、生产阶段、自变量检核、QC
- **关键表**: `tblINJRecipeBasis`(Recipe主档)、`tblINJEQPRecipe`(设备Recipe)、`tblINJLotRecipe`(生产批绑定Recipe)、`tblINJPhaseBasis`(阶段定义)、`tblINJRecipeCheckLog*`(自变量检核)、`tblINJRecipeQCLog*`(检验Recipe)
- **字段口径**: `RecipeNo` GUID 主键；`ProdPhase`(生产阶段：0试模/1试样/2试产/3量产)；`Invalid`(0生效中/1已失效)；`RecipeVer` 版本(默认'1')；`ProductNo`/`AccessoryType`/`OPNo` 可填空=忽略条件并注明"请加索引"
- **待确认项**: Recipe 检核的自变量阶段规则细节

## K-621-06: 产品主档/工艺/包装

- **业务对象**: 产品属性、双单位、设备规格、包装规则、组合标签、NC 码、工段流程
- **关键表**: `tblPRDProperty`(产品属性)、`tblPRDDoubleUnitNoBasis`(双单位)、`tblPRDEquipmentSpec`(设备规格)、`tblPRDPackRule*`(包装规则)、`tblPRDGroupLabel*`/`tblPRDLabel_*`(组合标签)、`tblPRDNCCodeBasisNew`(NC程序码)、`tblPSSection*`(工段/流程节点)
- **字段口径**: 产品属性复合主键 `ProductNo`+`ProductVersion`+`PropertyNo`，另带 `PROCESSNO`+`PROCESSVERSION`+`OPNO` 扩展；包装规则 `主档-明细-产品对应-关联` 四表结构
- **待确认项**: 双单位(`tblPRDDoubleUnitNoBasis`)与单位换算(`tblPRDOPUnitConversion`)的口径关系

## K-621-07: 工价/作业站

- **业务对象**: 作业站/子作业/产品/设备工价、急件/返工价、暂停设定、人员改价记录
- **关键表**: `tblOPMOP`(作业站工价)、`tblOPMOPSUBOP`(子作业)、`tblOPMPRDOP`(产品作业站)、`tblOPMEQP`(设备工价)、`tblOPMUpdateLog`(改价记录)、`tblOPWait`(暂停设定)、`tblOPLeanProperty`(检验项目设定)
- **字段口径**: 工价六价 `Piece/Time × 标/急/返`(计件/计时 × 标价/急价/返价)；`PriceType`(工价类型 numeric)、`Isabled`(启用)、`EffectDate`(生效时间，组合主键)；价格精度 numeric(23,8)
- **待确认项**: 工价与报工(人时机时)的核算勾稽关系

## K-621-08: 安灯/系统/用户/ERP

- **业务对象**: 安灯(Andon)讯息/等级/设备状态、系统功能事件、用户班别群组、载具、ERP 集成、报表/SPC、工单BOM
- **关键表**: `tblSLightState`(安灯现况)、`tblSLightEQPState`(设备现况)、`tblSLightTypeBasis`(分类)、`tblSYSFunctionEvent`(系统功能事件)、`tblUSRCategoryBasis/Detail`(报工群组)、`tblUsrShiftGroup*`(班别)、`tblVEHVehicleBasis`(载具)、`tblERPTransactionXMLLog_Basis`(ERP数据接收)、`tblOEMOMaterialList_Unused`(工单BOM)、`tblRPTStatisticsCondition`(自定义报表)、`tblSPCQCForm`(检验单)
- **字段口径**:
  - 安灯：`SLightTypeNo` 分类代号(SLEquipment机台/SLQuality质量/SLMaterial物料/SLProd生产)；`SLightState`(0绿灭/1红闪/2紫闪)；`SLightLevel`(0未启用/1无记录/2需记录)；`ResponseLevel`(回应等级0/1/2/3)；接收/确认/结束时间三时间戳
  - 工单来源：`tblOEMOSource` 键 `MONO`+`RONO`+`ItemNo`，`MOSOURCE`(工单来源 numeric)
  - ERP 数据：`tblERPTransactionXMLLog_Basis` 为 XML 报文接收表，说明注明"过多可删"
- **待确认项**: 安灯等级与响应升级(`ResponseLevel`)的业务规则；ERP 报文重收机制

## 通用观察（跨模块，非事实勿引用）

- **主键风格**：多数主表用 GUID(`nvarchar(50)`/`(64)`) 或 业务组合键；`ProductNo+ProductVersion` 双键贯穿产品相关表
- **审计字段**：几乎每表含 `Creator/CreateDate/Editor/EditDate`，部分双份(大小写)重复定义
- **索引提示**：字段说明内嵌"请加索引""可填空=忽略此条件"等提示，是实施建索引的重要线索
- **待清理表**：标注「旧表格」「过多可删」的表勿作主数据依据

## 规范

- 卡片仅记录**资料原文已含**的表/字段，未编造
- 五要素缺项标「待确认」；原件存 `delivery/inbox/SMES_621数据库设计文档20250313.html`
- 字段级全量明细见同目录 `01~08-*.md`，本文件是领域视角的提炼
