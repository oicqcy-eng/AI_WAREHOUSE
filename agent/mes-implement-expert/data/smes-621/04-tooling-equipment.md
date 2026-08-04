# 04 模治具/设备/保养 (ACC/EMS/EQP)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 22 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblACCChangeTime](#tblaccchangetime) | 模治具换模时间 | 64 |
| [tblACCRegularPMPlanBasis](#tblaccregularpmplanbasis) | 模治具定期保养计划设置 (与类别设置共享) | 17 |
| [tblACCRegularPMPlanDetail](#tblaccregularpmplandetail) | 模治具定期保养计划项目 (与类别设定共享) | 86 |
| [tblAreaCommissioner](#tblareacommissioner) | 区域负责人 | 296 |
| [tblEMSACCContent_Repair](#tblemsacccontent_repair) | 模治具执行维修项目历程 | 58 |
| [tblEMSAccessoryStateReason](#tblemsaccessorystatereason) | 模治具现况原因 | 11 |
| [tblEMSACCLog_ADjustLife](#tblemsacclog_adjustlife) | 模治具寿命调整表 | 25 |
| [tblEMSACCLog_Repair](#tblemsacclog_repair) | 模治具执行维修历程 | 22 |
| [tblEMSACCRegularPMLog](#tblemsaccregularpmlog) | 模治具定期保养计划历程 | 23 |
| [tblEMSACCRegularPMLogDetail](#tblemsaccregularpmlogdetail) | 模治具定期保养计划项目历程 | 10 |
| [tblEMSACCRegularPMState](#tblemsaccregularpmstate) | 模治具定期保养计划产生 | 13 |
| [tblEMSACCSubstitutionUsed](#tblemsaccsubstitutionused) | 备品使用历程 | 15 |
| [tblEMSCombineACCLog](#tblemscombineacclog) | 模治具组合历程 | 251 |
| [tblEQPAccessoryBasisLog](#tbleqpaccessorybasislog) | 模治具基本数据历程 | 29 |
| [tblEQPAccessoryBasisLogReason](#tbleqpaccessorybasislogreason) | 模治具基本数据历程原因 | 76 |
| [tblEQPACCRepairItem](#tbleqpaccrepairitem) | 模治具维修项目 | 675 |
| [tblEQPEquipmentAccessoryMap](#tbleqpequipmentaccessorymap) | 设备与模治具对应 | 80 |
| [tblEQPEquipmentCheckUpRate](#tbleqpequipmentcheckuprate) | 设备多频率点检基础档 | 25 |
| [tblEQPEquipmentReason](#tbleqpequipmentreason) | 设备稼动原因设定 | 48 |
| [tblEQPEquipmentTypeACCCategory](#tbleqpequipmenttypeacccategory) | 设备模治具分类 | 193 |
| [tblOEMOAccessoryCombineLog](#tbloemoaccessorycombinelog) | 工单模治具绑定历程 | 11 |
| [tblOEMOAccessoryCombineState](#tbloemoaccessorycombinestate) | 工单模治具绑定 | 347 |

---

### tblACCChangeTime — 模治具换模时间（64 字段）
> 主键：AccessoryNo, AccessoryVersion, PMITEMNO, ACCESSORYTYPE, PMPLANNO, ACCESSORYTYPE, PMPLANNO, PMITEMNO, REASONNO, ReasonType
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryNo | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 2 | AccessoryVersion | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 3 | PrepareTime | numeric | (4,0) |  |  |  |  | 0 | 换模准备时间 |
| 4 | LoadTime | numeric | (4,0) |  |  |  |  | 0 | 上模标准时间 |
| 5 | UnloadTime | numeric | (4,0) |  |  |  |  | 0 | 下模标准时间 |
| 6 | PreparetTools | nvarchar | (51) |  |  |  | √ |  | 转载工具 |
| 7 | LoadTools | nvarchar | (51) |  |  |  | √ |  | 上模工具 |
| 8 | UnloadTools | nvarchar | (52) |  |  |  | √ |  | 下模工具 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | TBLEQPACCESSORYBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PMITEMNO | nvarchar | (50) | √ |  |  |  |  | 保养项目编号 |
| 2 | PMMODE | nvarchar | (50) |  |  |  | √ |  | 保养性质 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 6 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 7 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 8 | REVISERDATE | datetime |  |  |  |  | √ |  |  |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORYTYPE | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | PMPLANNO | nvarchar | (50) | √ |  |  |  |  | 保养计划 |
| 3 | PMCYCLE | numeric | (15,4) |  |  |  |  |  | 保养周期 |
| 4 | LIFEMANAGE | numeric | (1,0) |  |  |  |  |  | 寿命管理 |
| 5 | WARNINGRATE | numeric | (5,2) |  |  |  |  | 100 | 警示比例 |
| 6 | CURTIMES | numeric | (8,0) |  |  |  |  | 0 | 目前使用次数 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CREATEDATE | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 10 | TBLEQPACCESSORYTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 11 | ISADDLIFE | numeric | (1,0) |  |  |  | √ |  | 是否延长寿命：0 否 1 是 |
| 12 | ADDLIFETYPE | numeric | (2,0) |  |  |  | √ |  | 延长寿命方式：1：延长至固定% 2：延长至固定数值 3：延长固定% 4：延长固定数值 5：手工 |
| 13 | ADDLIFE | numeric | (16,0) |  |  |  | √ |  | 延长寿命量 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORYTYPE | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | PMPLANNO | nvarchar | (50) | √ |  |  |  |  | 保养计划 |
| 3 | PMITEMNO | nvarchar | (50) | √ |  |  |  |  | 保养项目 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | TBLACCPMPLANBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLACCPMITEMGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REASONNO | nvarchar | (20) | √ |  |  |  |  | 原因编号 |
| 2 | REASONNAME | nvarchar | (100) |  |  |  |  |  | 原因名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 7 | ReasonType | numeric | (1,0) | √ |  |  |  | 0 | 原因类型：因为后续加入的PK，添加栏位Default 0，在改变PK 0：不良 1：叫修 2：维修 3：保养 4：穴数调整 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | PLANPROCESSTIME | numeric | (2,0) |  |  |  | √ |  | 预计处理时间 |

---

### tblACCRegularPMPlanBasis — 模治具定期保养计划设置 (与类别设置共享)（17 字段）
> 主键：AccessoryType, PMPlanNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryType | nvarchar | (50) | √ |  |  |  |  | 模治具类别：模治具类别 |
| 2 | PMPlanNo | nvarchar | (50) | √ |  |  |  |  | 保养计划编号：保养计划 |
| 3 | RegularType | numeric | (2,0) |  |  |  | √ |  | 定期类型：1：月 2：日 |
| 4 | RegularCycle | numeric | (6,0) |  |  |  | √ |  | 定期频率：定期频率 |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人：修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期：修改日期 |
| 10 | TBLEQPACCESSORYTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值：父键值 |
| 11 | ISADDLIFE | numeric | (1,0) |  |  |  | √ |  | 是否延长寿命：0 否 1 是 |
| 12 | ADDLIFETYPE | numeric | (2,0) |  |  |  | √ |  | 延长寿命方式：1：延长至固定% 2：延长至固定数值 3：延长固定% 4：延长固定数值 5：手工 |
| 13 | ADDLIFE | numeric | (16,0) |  |  |  | √ |  | 延长寿命量：延长寿命量 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：1 |

---

### tblACCRegularPMPlanDetail — 模治具定期保养计划项目 (与类别设定共享)（86 字段）
> 主键：AccessoryType, PMPlanNo, PMItemNo, REPAIRITEMNO, FREQUENCYNO, SID, MONO, OPNO, MONOSEQ, MONO, PLANSTARTDATE, PROCESSNO, PROCESSVERSION, OPNO, EQUIPMENTNO, EQUIPMENTNO, STARTDATE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryType | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | PMPlanNo | nvarchar | (50) | √ |  |  |  |  | 保养计划 |
| 3 | PMItemNo | nvarchar | (50) | √ |  |  |  |  | 保养项目 |
| 4 | SerialNo | numeric | (4,0) |  |  |  |  |  | 序号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLACCREGULARPMPLANBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：1 |
| 11 | TBLACCPMITEMGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REPAIRITEMNO | nvarchar | (100) | √ |  |  |  |  | 维修项目编号 |
| 2 | REPAIRITEMNAME | nvarchar | (100) |  |  |  |  |  | 维修项目名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明：备注 |
| 4 | REVISER | nvarchar | (50) |  |  |  |  |  | 修改人 |
| 5 | REVISERDATE | datetime |  |  |  |  |  |  | 修改日 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 2 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 3 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 4 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 5 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 6 | FREQUENCYNO | nvarchar | (50) | √ |  |  |  |  | 维护编号 |
| 7 | FREQUENCYNAME | nvarchar | (50) |  |  |  |  |  | 维护名称 |
| 8 | CHECKITEM | nvarchar | (500) |  |  |  |  |  | 检查内容 |
| 9 | PERIOD | numeric | (2,0) |  |  |  |  | 0 | 维护频率 |
| 10 | FREQUENCYDATE | datetime |  |  |  |  | √ |  | 上次维护时间 |
| 11 | AGVNO | nvarchar | (20) |  |  |  |  |  | 设备编号 |
| 12 | TBLAGVBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码：子表的独立编号 |
| 2 | MASTER_SID | nvarchar | (50) |  |  |  |  |  | 母表识别码：与母表关联用 tblAPSDispatchStateData |
| 3 | ACCESSORYNO | nvarchar | (50) |  |  |  |  |  | 模治具编号：模治具编号 |
| 4 | QTY | numeric | (12,4) |  |  |  |  |  | 派工数量：模治具的派工数量 |
| 5 | STARTTIME | datetime |  |  |  |  |  |  | 模治具规划开始使用时间：格式(日期+时间) |
| 6 | ENDTIME | datetime |  |  |  |  |  |  | 模治具规划结束使用时间：格式(日期+时间) |
| 7 | REVISEDATE | datetime |  |  |  |  |  |  | 修改时间：APS填入、异动时就更新 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | STARTTIME | datetime |  |  |  |  |  |  | 预计开始时间：日期+时间 |
| 4 | ENDTIME | datetime |  |  |  |  |  |  | 预计完成时间：日期+时间 |
| 5 | FIXLOADING | numeric | (12,0) |  |  |  |  |  | 使用固定产能(秒) |
| 6 | VARLOADING | numeric | (12,0) |  |  |  |  |  | 使用变动产能(秒) |
| 7 | PROCESSNO | nvarchar | (50) |  |  |  |  |  | 流程编号 |
| 8 | PROCESSVERSION | nvarchar | (5) |  |  |  |  |  | 流程版本 |
| 9 | NODEID | nvarchar | (50) |  |  |  |  |  | 节点ID |
| 10 | QTY | numeric | (12,4) |  |  |  |  |  | 派工数量 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | MONOSEQ | numeric | (4,0) | √ |  |  |  |  | 工单顺序 |
| 2 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 3 | PLANSTARTDATE | datetime |  | √ |  |  |  |  | APS计划日期：格式(日期、无时间） |
| 4 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 5 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 6 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 7 | NODEID | nvarchar | (100) |  |  |  |  |  | 节点ID |
| 8 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 9 | QTY | numeric | (12,4) |  |  |  |  |  | 派工数量 |
| 10 | REVISEDATE | datetime |  |  |  |  | √ |  | 添加时间 |
| 11 | STARTTIME | datetime |  |  |  |  | √ |  | APS作业站计划开始时间：格式(日期+时间) 工单、作业站的起时间 |
| 12 | ENDTIME | datetime |  |  |  |  | √ |  | APS作业站计划结束时间：格式(日期+时间) 工单、作业站的迄时间 |
| 13 | FIXLOADING | numeric | (12,0) |  |  |  | √ |  | 使用固定产能(秒) |
| 14 | VARLOADING | numeric | (12,0) |  |  |  | √ |  | 使用变动产能(秒) |
| 15 | EQPSTARTTIME | datetime |  |  |  |  | √ |  | 设备规划开始生产时间：#88245 格式(日期+时间) 工单、作业站、设备的起时间 |
| 16 | EQPENDTIME | datetime |  |  |  |  | √ |  | 设备规划结束生产时间：#88245 格式(日期+时间) 工单、作业站、设备的迄时间 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 2 | STARTDATE | datetime |  | √ |  |  |  |  | 开始时间 |
| 3 | ENDDATE | datetime |  |  |  |  |  |  | 完成时间 |
| 4 | OFFTYPE | numeric | (2,0) |  |  |  |  |  | 关机型别：1 维修 2 保养 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |

---

### tblAreaCommissioner — 区域负责人（296 字段）
> 主键：AREANO, COMMISSIONERNO, COLUMN_NAME, SID, SID, SID, SID, JOBNAME, EQUIPMENTNO, SUPPLIERCODE, STANDARDVERSION, INFOTYPECODE, RUNINGSTATE, RUNINGTIME, DOWNTIME, STANDARDRUNINGTIME, STANDARDDOWNTIME, CONCLUSION, DBIP, DBType, MESTableName, EIPTableName, EIPTABLESORT, ACCESSORYNO, PMPLANNO, FREQUENCY, PMITEM
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AREANO | nvarchar | (100) | √ |  |  |  |  | 区域编号 |
| 2 | COMMISSIONERNO | nvarchar | (100) | √ |  |  |  |  | 区域负责人 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | COLUMN_NAME | nvarchar | (50) | √ |  |  |  |  | 片段数据 |
| 2 | Name | nvarchar | (50) |  |  |  |  |  | 片段名称 |
| 3 | traditional | nvarchar | (50) |  |  |  |  |  | 繁体名称 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 建立日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 标识码 |
| 3 | EQPTYPE | nvarchar | (50) |  |  |  |  |  | 设备类型 |
| 4 | FILENAME | nvarchar | (255) |  |  |  |  |  | 文档名 |
| 5 | SAVEPATH | nvarchar | (255) |  |  |  |  |  | 转存路径 |
| 6 | PCSNO | nvarchar | (50) |  |  |  |  |  | SN码 |
| 7 | TESTRESULT | nvarchar | (50) |  |  |  |  |  | 测试结果 |
| 8 | TESTDATE | datetime |  |  |  |  |  |  | 测试时间 |
| 9 | PANELSIDE | nvarchar | (50) |  |  |  |  |  | 板面 B T |
| 10 | EQPNO | nvarchar | (50) |  |  |  |  |  | 设备号 |
| 11 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线 |
| 12 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站 |
| 13 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 14 | SUBOPSEQUENCE | nvarchar | (50) |  |  |  |  |  | 工序 |
| 15 | COLLECTRESULT | nvarchar | (2000) |  |  |  |  |  | 采集结果 |
| 16 | USERDEFINED1 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位1 |
| 17 | USERDEFINED2 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位2 |
| 18 | USERDEFINED3 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位3 |
| 19 | USERDEFINED4 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位4 |
| 20 | USERDEFINED5 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位5 |
| 21 | USERDEFINED6 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位6 |
| 22 | USERDEFINED7 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位7 |
| 23 | USERDEFINED8 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位8 |
| 24 | USERDEFINED9 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位9 |
| 25 | USERDEFINED10 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位10 |
| 26 | USERDEFINED11 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位11 |
| 27 | USERDEFINED12 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位12 |
| 28 | USERDEFINED13 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位13 |
| 29 | USERDEFINED14 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位14 |
| 30 | USERDEFINED15 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位15 |
| 31 | USERDEFINED16 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位16 |
| 32 | USERDEFINED17 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位17 |
| 33 | USERDEFINED18 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位18 |
| 34 | USERDEFINED19 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位19 |
| 35 | USERDEFINED20 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位20 |
| 36 | USERDEFINED21 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位21 |
| 37 | USERDEFINED22 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位22 |
| 38 | USERDEFINED23 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位23 |
| 39 | USERDEFINED24 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位24 |
| 40 | USERDEFINED25 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位25 |
| 41 | USERDEFINED26 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位26 |
| 42 | USERDEFINED27 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位27 |
| 43 | USERDEFINED28 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位28 |
| 44 | USERDEFINED29 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位29 |
| 45 | USERDEFINED30 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位30 |
| 46 | USERDEFINED31 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位31 |
| 47 | USERDEFINED32 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位32 |
| 48 | USERDEFINED33 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位33 |
| 49 | USERDEFINED34 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位34 |
| 50 | USERDEFINED35 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位35 |
| 51 | USERDEFINED36 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位36 |
| 52 | USERDEFINED37 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位37 |
| 53 | USERDEFINED38 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位38 |
| 54 | USERDEFINED39 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位39 |
| 55 | USERDEFINED40 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位40 |
| 56 | USERDEFINED41 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位41 |
| 57 | USERDEFINED42 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位42 |
| 58 | USERDEFINED43 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位43 |
| 59 | USERDEFINED44 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位44 |
| 60 | USERDEFINED45 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位45 |
| 61 | USERDEFINED46 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位46 |
| 62 | USERDEFINED47 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位47 |
| 63 | USERDEFINED48 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位48 |
| 64 | USERDEFINED49 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位49 |
| 65 | USERDEFINED50 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位50 |
| 66 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 67 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 68 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 69 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 70 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 标识码 |
| 3 | EQPTYPE | nvarchar | (50) |  |  |  |  |  | 设备类型 |
| 4 | FILENAME | nvarchar | (255) |  |  |  |  |  | 文档名 |
| 5 | SAVEPATH | nvarchar | (255) |  |  |  |  |  | 转存路径 |
| 6 | PCSNO | nvarchar | (50) |  |  |  |  |  | SN码 |
| 7 | TESTRESULT | nvarchar | (50) |  |  |  |  |  | 测试结果 |
| 8 | TESTDATE | datetime |  |  |  |  |  |  | 测试时间 |
| 9 | PANELSIDE | nvarchar | (50) |  |  |  |  |  | 板面 B T |
| 10 | EQPNO | nvarchar | (50) |  |  |  |  |  | 设备号 |
| 11 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线 |
| 12 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站 |
| 13 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 14 | SUBOPSEQUENCE | nvarchar | (50) |  |  |  |  |  | 工序 |
| 15 | COLLECTRESULT | nvarchar | (2000) |  |  |  |  |  | 采集结果 |
| 16 | USERDEFINED1 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位1 |
| 17 | USERDEFINED2 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位2 |
| 18 | USERDEFINED3 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位3 |
| 19 | USERDEFINED4 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位4 |
| 20 | USERDEFINED5 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位5 |
| 21 | USERDEFINED6 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位6 |
| 22 | USERDEFINED7 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位7 |
| 23 | USERDEFINED8 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位8 |
| 24 | USERDEFINED9 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位9 |
| 25 | USERDEFINED10 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位10 |
| 26 | USERDEFINED11 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位11 |
| 27 | USERDEFINED12 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位12 |
| 28 | USERDEFINED13 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位13 |
| 29 | USERDEFINED14 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位14 |
| 30 | USERDEFINED15 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位15 |
| 31 | USERDEFINED16 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位16 |
| 32 | USERDEFINED17 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位17 |
| 33 | USERDEFINED18 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位18 |
| 34 | USERDEFINED19 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位19 |
| 35 | USERDEFINED20 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位20 |
| 36 | USERDEFINED21 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位21 |
| 37 | USERDEFINED22 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位22 |
| 38 | USERDEFINED23 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位23 |
| 39 | USERDEFINED24 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位24 |
| 40 | USERDEFINED25 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位25 |
| 41 | USERDEFINED26 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位26 |
| 42 | USERDEFINED27 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位27 |
| 43 | USERDEFINED28 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位28 |
| 44 | USERDEFINED29 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位29 |
| 45 | USERDEFINED30 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位30 |
| 46 | USERDEFINED31 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位31 |
| 47 | USERDEFINED32 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位32 |
| 48 | USERDEFINED33 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位33 |
| 49 | USERDEFINED34 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位34 |
| 50 | USERDEFINED35 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位35 |
| 51 | USERDEFINED36 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位36 |
| 52 | USERDEFINED37 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位37 |
| 53 | USERDEFINED38 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位38 |
| 54 | USERDEFINED39 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位39 |
| 55 | USERDEFINED40 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位40 |
| 56 | USERDEFINED41 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位41 |
| 57 | USERDEFINED42 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位42 |
| 58 | USERDEFINED43 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位43 |
| 59 | USERDEFINED44 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位44 |
| 60 | USERDEFINED45 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位45 |
| 61 | USERDEFINED46 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位46 |
| 62 | USERDEFINED47 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位47 |
| 63 | USERDEFINED48 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位48 |
| 64 | USERDEFINED49 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位49 |
| 65 | USERDEFINED50 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位50 |
| 66 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 67 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 68 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 69 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 70 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 标识码 |
| 3 | ROWINDEX | nvarchar | (50) |  |  |  |  |  | 聚合型文档 采集行 |
| 4 | FILENAME | nvarchar | (255) |  |  |  |  |  | 文档名 |
| 5 | PCSNO | nvarchar | (50) |  |  |  |  |  | SN码 |
| 6 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线 |
| 7 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站 |
| 8 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 9 | SUBOPSEQUENCE | nvarchar | (50) |  |  |  |  |  | 工序 |
| 10 | EQPNO | nvarchar | (50) |  |  |  |  |  | 设备号 |
| 11 | COLLECTDATE | datetime |  |  |  |  |  |  | 本次采集时间 |
| 12 | COLLECTRESULT | nvarchar | (2000) |  |  |  |  |  | 本次采集结果 |
| 13 | LASTCOLLECTDATE | datetime |  |  |  |  |  |  | 上次采集时间 |
| 14 | LASTCOLLECTRESULT | nvarchar | (2000) |  |  |  |  |  | 上次采集结果 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 标识码 |
| 3 | EQPTYPE | nvarchar | (50) |  |  |  |  |  | 设备类型 |
| 4 | FILENAME | nvarchar | (255) |  |  |  |  |  | 文档名 |
| 5 | SAVEPATH | nvarchar | (255) |  |  |  |  |  | 转存路径 |
| 6 | PCSNO | nvarchar | (50) |  |  |  |  |  | SN码 |
| 7 | TESTRESULT | nvarchar | (50) |  |  |  |  |  | 测试结果 |
| 8 | TESTDATE | datetime |  |  |  |  |  |  | 测试时间 |
| 9 | PANELSIDE | nvarchar | (50) |  |  |  |  |  | 板面 B T |
| 10 | EQPNO | nvarchar | (50) |  |  |  |  |  | 设备号 |
| 11 | PDLINENO | nvarchar | (50) |  |  |  |  |  | 生产线 |
| 12 | OPNO | nvarchar | (50) |  |  |  |  |  | 作业站 |
| 13 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位 |
| 14 | SUBOPSEQUENCE | nvarchar | (50) |  |  |  |  |  | 工序 |
| 15 | COLLECTRESULT | nvarchar | (2000) |  |  |  |  |  | 采集结果 |
| 16 | USERDEFINED1 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位1 |
| 17 | USERDEFINED2 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位2 |
| 18 | USERDEFINED3 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位3 |
| 19 | USERDEFINED4 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位4 |
| 20 | USERDEFINED5 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位5 |
| 21 | USERDEFINED6 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位6 |
| 22 | USERDEFINED7 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位7 |
| 23 | USERDEFINED8 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位8 |
| 24 | USERDEFINED9 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位9 |
| 25 | USERDEFINED10 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位10 |
| 26 | USERDEFINED11 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位11 |
| 27 | USERDEFINED12 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位12 |
| 28 | USERDEFINED13 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位13 |
| 29 | USERDEFINED14 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位14 |
| 30 | USERDEFINED15 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位15 |
| 31 | USERDEFINED16 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位16 |
| 32 | USERDEFINED17 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位17 |
| 33 | USERDEFINED18 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位18 |
| 34 | USERDEFINED19 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位19 |
| 35 | USERDEFINED20 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位20 |
| 36 | USERDEFINED21 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位21 |
| 37 | USERDEFINED22 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位22 |
| 38 | USERDEFINED23 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位23 |
| 39 | USERDEFINED24 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位24 |
| 40 | USERDEFINED25 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位25 |
| 41 | USERDEFINED26 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位26 |
| 42 | USERDEFINED27 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位27 |
| 43 | USERDEFINED28 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位28 |
| 44 | USERDEFINED29 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位29 |
| 45 | USERDEFINED30 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位30 |
| 46 | USERDEFINED31 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位31 |
| 47 | USERDEFINED32 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位32 |
| 48 | USERDEFINED33 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位33 |
| 49 | USERDEFINED34 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位34 |
| 50 | USERDEFINED35 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位35 |
| 51 | USERDEFINED36 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位36 |
| 52 | USERDEFINED37 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位37 |
| 53 | USERDEFINED38 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位38 |
| 54 | USERDEFINED39 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位39 |
| 55 | USERDEFINED40 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位40 |
| 56 | USERDEFINED41 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位41 |
| 57 | USERDEFINED42 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位42 |
| 58 | USERDEFINED43 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位43 |
| 59 | USERDEFINED44 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位44 |
| 60 | USERDEFINED45 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位45 |
| 61 | USERDEFINED46 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位46 |
| 62 | USERDEFINED47 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位47 |
| 63 | USERDEFINED48 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位48 |
| 64 | USERDEFINED49 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位49 |
| 65 | USERDEFINED50 | nvarchar | (100) |  |  |  |  |  | 自定义采集栏位50 |
| 66 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 67 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 68 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 69 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 70 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | JOBNAME | nvarchar | (100) | √ |  |  |  |  | 工作名称：目前写死：('tblEqpDataCollection_1003','tblEqpDataCollection_1019','tblEqpDataCollection_1021','tblEqpDataCollection_1022') 写入对应的表名称 |
| 3 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 4 | SUPPLIERCODE | nvarchar | (50) | √ |  |  |  |  | 供应商编号 |
| 5 | STANDARDVERSION | nvarchar | (50) | √ |  |  |  |  | 采集规范版本号 |
| 6 | INFOTYPECODE | nvarchar | (50) | √ |  |  |  |  | 工序编码 |
| 7 | RUNINGSTATE | nvarchar | (50) | √ |  |  |  |  | 运行状态是否正常：0 否；1 是 |
| 8 | RUNINGTIME | numeric | (10,4) | √ |  |  |  |  | 累计运行时间：运行状态正常时autorun执行时+标准运行时间 |
| 9 | DOWNTIME | numeric | (10,4) | √ |  |  |  |  | 累计故障时间：运行状态不正常时autorun执行时+标准故障时间 |
| 10 | STANDARDRUNINGTIME | numeric | (10,4) | √ |  |  |  |  | 标准运行时间 |
| 11 | STANDARDDOWNTIME | numeric | (10,4) | √ |  |  |  |  | 标准故障时间 |
| 12 | CONCLUSION | numeric | (10,4) | √ |  |  |  |  | 检测结论：0 合格；1 不合格 |
| 13 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | DBIP | nvarchar | (20) | √ |  |  |  |  | EIP服务的ip地址 |
| 2 | DBName | nvarchar | (50) |  |  |  | √ |  | 数据库名称 |
| 3 | DBSID | nvarchar | (50) |  |  |  | √ |  | 数据库sid |
| 4 | DBAcc | nvarchar | (50) |  |  |  |  | 'N/A' | 访问账号 |
| 5 | DBPW | nvarchar | (50) |  |  |  |  | 'N/A' | 访问密码 |
| 6 | DBType | numeric | (2,0) | √ |  |  |  |  | 数据库类型 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 1 | MESTableName | nvarchar | (50) | √ |  |  |  |  | MES表名称：ex.：('tblEqpDataCollection_1003','tblEqpDataCollection_1019','tblEqpDataCollection_1021','tblEqpDataCollection_1022') 写入对应的表名称。如果不维护，则同步所有的字段 |
| 2 | EIPTableName | nvarchar | (50) | √ |  |  |  |  | EIP表名称 |
| 3 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 4 | EIPTABLESORT | nvarchar | (50) | √ |  |  |  |  | 同步栏位：ex.supplierCode,standardVersion,PRODUCTION_ORDER_ID |
| 5 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 2 | PMPLANNO | nvarchar | (50) | √ |  |  |  |  | 保养计划编号 |
| 3 | FREQUENCY | numeric | (8,0) | √ |  |  |  |  | 频率 |
| 4 | PMITEM | nvarchar | (50) | √ |  |  |  |  | 保养项目 |
| 5 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEMSACCContent_Repair — 模治具执行维修项目历程（58 字段）
> 主键：ACCSerialNo, RepairItemNo, ACCESSORYNO, ACCESSORYVERSION, ACCSERIALNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ACCSerialNo | nvarchar | (20) | √ |  |  |  |  | 模治具序号：流水号，用变更状态前的tblEMSAccessoryState.ACCSerialNo填入 |
| 2 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 4 | RepairItemNo | nvarchar | (100) | √ |  |  |  |  | 维修项目编号 |
| 5 | RepairItemName | nvarchar | (100) |  |  |  | √ |  | 维修项目名称 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ACCSERIALNO | nvarchar | (20) |  |  |  | √ |  | 模治具序号 |
| 2 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 3 | ACCESSORYVERSION | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 4 | ACCESSORYSTATE | numeric | (2,0) |  |  |  |  |  | 模治具状态：0 (在库) 1 (在线) 2(上机) 3 (维修) 4 (报废) 5 (保养) 6 (外包) |
| 5 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 6 | STARTTIME | datetime |  |  |  |  |  |  | 开始时间 |
| 7 | USERNO | nvarchar | (30) |  |  |  | √ |  | 用户编号 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | APPLYTIME | datetime |  |  |  |  | √ |  | 套用时间 |
| 10 | ACCUMULATEQTY | numeric | (12,4) |  |  |  | √ | 0 | 累计数量 |
| 11 | ACCSPAREQTY | numeric | (8,0) |  |  |  | √ | 0 | 模治具备品数量 |
| 12 | ACCTOTALUSEDQTY | numeric | (12,4) |  |  |  | √ | 0 | 目前累计总使用次数 |
| 13 | ACCREPAIRQTY | numeric | (8,0) |  |  |  | √ | 0 | 目前累计维修次数 |
| 14 | LocatorNo | nvarchar | (20) |  |  |  | √ | 'N/A' | 储位编号 |
| 15 | ExpectRepairFinishDate | datetime |  |  |  |  | √ |  | 预期维修完成时间：维修完毕清空 |
| 16 | PlanRepairFinishDate | datetime |  |  |  |  | √ |  | 计划维修完成时间：维修完毕清空 |
| 17 | PlanRepairer | nvarchar | (30) |  |  |  | √ |  | 计划维修人员：维修完毕清空 |
| 18 | SubcontractorNo | nvarchar | (20) |  |  |  | √ |  | 外包商编号：维修完毕清空 |
| 19 | ACLoadTime | numeric | (4,0) |  |  |  | √ |  | 实际上模时间 |
| 20 | ACUnLoadTime | numeric | (4,0) |  |  |  | √ |  | 实际下模时间 |
| 21 | TempLocatorNo | nvarchar | (20) |  |  |  | √ |  | 临时储位 |
| 22 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 23 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCSERIALNO | nvarchar | (20) | √ |  |  |  |  | 模治具序号 |
| 2 | ACCESSORYNO | nvarchar | (50) |  |  |  | √ |  | 模治具编号 |
| 3 | ACCESSORYVERSION | nvarchar | (5) |  |  |  | √ |  | 模治具版次 |
| 4 | ACCESSORYSTATE | numeric | (2,0) |  |  |  |  |  | 模治具状态：1：下模(可上模)，2：上模(可下模)，0 异常 0 (在库) 1 (在线) 2(上机) 3 (维修) 4 (报废) 5 (保养) |
| 5 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 6 | STARTTIME | datetime |  |  |  |  |  |  | 开始时间 |
| 7 | ENDTIME | datetime |  |  |  |  |  |  | 结束时间 |
| 8 | USERNO | nvarchar | (30) |  |  |  | √ |  | 用户编号 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | APPLYTIME | datetime |  |  |  |  | √ |  | 套用时间 |
| 11 | ACCUMULATEQTY | numeric | (12,4) |  |  |  | √ | 0 | 累计数量 |
| 12 | LocatorNo | nvarchar | (20) |  |  |  | √ | 'N/A' | 储位编号 |
| 13 | AddLifeType | numeric | (2,0) |  |  |  | √ |  | 延长寿命方式：1：延长至固定% 2：延长至固定数值 3：延长固定% 4：延长固定数值 5：手工 |
| 14 | AddLife | numeric | (16,0) |  |  |  | √ |  | 延长寿命量 |
| 15 | RealAddLife | numeric | (16,0) |  |  |  | √ |  | 实际延长寿命数 |
| 16 | CHANGETTOOLTIME | numeric | (4,0) |  |  |  | √ |  |  |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | CHANGETOOLTIME | numeric | (4,0) |  |  |  | √ |  | 上下具时间 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEMSAccessoryStateReason — 模治具现况原因（11 字段）
> 主键：ACCSerialNo, ReasonType, ReasonNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ACCSerialNo | nvarchar | (20) | √ |  |  |  |  | 模治具序号：流水号，用变更状态前的tblEMSAccessoryState.ACCSerialNo填入 |
| 2 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 4 | ORGACCState | numeric | (2,0) |  |  |  |  |  | 原模治具状态：0 (在库) 1 (在线) 2(上机) 3 (维修) 4 (报废) 5 (保养) |
| 5 | NewACCState | numeric | (2,0) |  |  |  |  |  | 新模治具状态：0 (在库) 1 (在线) 2(上机) 3 (维修) 4 (报废) 5 (保养) |
| 6 | ReasonType | numeric | (1,0) | √ |  |  |  | 0 | 原因类型：0：不良 1：叫修 2：维修 3：保养 4：穴数调整 |
| 7 | ReasonNo | nvarchar | (20) | √ |  |  |  |  | 原因编号 |
| 8 | ReasonName | nvarchar | (100) |  |  |  |  |  | 原因名称 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblEMSACCLog_ADjustLife — 模治具寿命调整表（25 字段）
> 主键：ACCESSORYNO, PMPLANNO, FREQUENCY
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 2 | AccessoryVersion | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 3 | Adjuster | nvarchar | (100) |  |  |  | √ |  | 调整人员 |
| 4 | AdjustItemName | datetime |  |  |  |  | √ |  | 调整日期 |
| 5 | ReasonType | nvarchar | (50) |  |  |  | √ |  | 原因类型 |
| 6 | AdjustIllustrate | nvarchar | (4000) |  |  |  | √ |  | 调整说明 |
| 7 | TBLEQPACCESSORYBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 8 | Adjustbefore | numeric | (10,4) |  |  |  | √ |  | 寿命调整前 |
| 9 | Adjustafter | numeric | (10,4) |  |  |  | √ |  | 寿命调整后 |
| 10 | ReasonNo | nvarchar | (20) |  |  |  |  |  | 原因编号 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | Automatically generate GUID |
| 1 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 2 | PMPLANNO | nvarchar | (50) | √ |  |  |  |  | 保养计划编号 |
| 3 | FREQUENCY | numeric | (8,0) | √ |  |  |  |  | 频率 |
| 4 | MAINTAINDATE | datetime |  |  |  |  | √ |  | 保养日期 |
| 5 | MAINTAINUSER | nvarchar | (30) |  |  |  | √ |  | 保养人员 |
| 6 | MFINISHDATE | datetime |  |  |  |  | √ |  | 结束保养日期 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 签核状态 |
| 8 | MaintainTime | numeric | (15,4) |  |  |  | √ |  | 保养工时 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEMSACCLog_Repair — 模治具执行维修历程（22 字段）
> 主键：ACCSerialNo, ACCESSORYNO, PMPLANNO, FREQUENCY
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ACCSerialNo | nvarchar | (20) | √ |  |  |  |  | 模治具序号：流水号，用变更状态前的tblEMSAccessoryState.ACCSerialNo填入 |
| 2 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 4 | Repairer | nvarchar | (100) |  |  |  | √ |  | 维修人员 |
| 5 | RepairTime | numeric | (15,4) |  |  |  | √ |  | 维修工时 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Description | nvarchar | (-1) |  |  |  | √ |  | 维修说明 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 2 | PMPLANNO | nvarchar | (50) | √ |  |  |  |  | 保养计划编号 |
| 3 | FREQUENCY | numeric | (8,0) | √ |  |  |  |  | 频率 |
| 4 | STATUS | numeric | (1,0) |  |  |  |  | 0 | 模治具状态：0 ： 没有做保养. 1   已保养 |
| 5 | PlanMaintainUser | nvarchar | (30) |  |  |  | √ |  | 计划保养人员 |
| 6 | PlanMaintainDate | datetime |  |  |  |  | √ |  | 计划保养日期 |
| 7 | PMQTY | numeric | (8,0) |  |  |  | √ |  | 保养单生成计数 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblEMSACCRegularPMLog — 模治具定期保养计划历程（23 字段）
> 主键：AccessoryType, AccessoryNo, AccessoryVersion, PMPlanNo, PMSerialNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryType | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | AccessoryNo | nvarchar | (50) | √ |  |  |  |  | 模治具编号：开始保养，保养计划产生带入 |
| 3 | AccessoryVersion | nvarchar | (5) | √ |  |  |  |  | 模治具版次：开始保养，保养计划产生带入 |
| 4 | PMPlanNo | nvarchar | (50) | √ |  |  |  |  | 保养计划编号：开始保养，保养计划产生带入 |
| 5 | PMSerialNo | nvarchar | (15) | √ |  |  |  |  | 保养单号：开始保养，保养计划产生带入 |
| 6 | RegularType | numeric | (2,0) |  |  |  | √ |  | 定期类型：开始保养，保养计划产生带入 |
| 7 | RegularCycle | numeric | (6,0) |  |  |  | √ |  | 定期频率：开始保养，保养计划产生带入 |
| 8 | PMStatus | numeric | (2,0) |  |  |  |  |  | 保养状态：1：保养中 2：保养完毕 |
| 9 | PlanIntervalStartDate | datetime |  |  |  |  | √ |  | 计划起始日期：开始保养，保养计划产生带入 |
| 10 | PlanIntervalEndDate | datetime |  |  |  |  | √ |  | 计划结束日期：开始保养，保养计划产生带入 |
| 11 | PlanMaintainUser | nvarchar | (30) |  |  |  | √ |  | 计划保养人员：开始保养，保养计划产生带入 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 14 | StartPMDate | datetime |  |  |  |  | √ |  | 开始保养时间：开始保养时填入 |
| 15 | StartPMUser | nvarchar | (30) |  |  |  | √ |  | 开始保养人员：开始保养时填入 |
| 16 | EndPMDate | datetime |  |  |  |  | √ |  | 结束保养时间：结束保养时填入 |
| 17 | EndPMUser | nvarchar | (30) |  |  |  | √ |  | 结束保养人员：结束保养时填入 |
| 18 | MaintainTime | numeric | (15,4) |  |  |  | √ |  | 保养工时：结束保养时填入 |
| 19 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明：执行保养时输入的说明 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEMSACCRegularPMLogDetail — 模治具定期保养计划项目历程（10 字段）
> 主键：AccessoryNo, AccessoryVersion, PMPlanNo, PMSerialNo, PMItemNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryNo | nvarchar | (50) | √ |  |  |  |  | 模治具编号：结束保养时填入 |
| 2 | AccessoryVersion | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 3 | PMPlanNo | nvarchar | (50) | √ |  |  |  |  | 保养计划编号：结束保养时填入 |
| 4 | PMSerialNo | nvarchar | (15) | √ |  |  |  |  | 保养单号：结束保养时填入 |
| 5 | PMItemNo | nvarchar | (50) | √ |  |  |  |  | 保养项目：结束保养时填入 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblEMSACCRegularPMState — 模治具定期保养计划产生（13 字段）
> 主键：AccessoryType, AccessoryNo, AccessoryVersion, PMPlanNo, PMSerialNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryType | nvarchar | (50) | √ |  |  |  |  | 模治具类别：模治具类别 |
| 2 | AccessoryNo | nvarchar | (50) | √ |  |  |  |  | 模治具编号：模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 4 | PMPlanNo | nvarchar | (50) | √ |  |  |  |  | 保养计划编号 |
| 5 | PMSerialNo | nvarchar | (15) | √ |  |  |  |  | 保养单号：格式：YYMMDDnnnnnn YY：公元后两码 MM：月 DD：日 nnnnnn：依据YYMMDD产生流水号，从1开始 |
| 6 | RegularType | numeric | (2,0) |  |  |  | √ |  | 定期类型：1：月 2：日 |
| 7 | RegularCycle | numeric | (6,0) |  |  |  | √ |  | 定期频率 |
| 8 | PlanIntervalStartDate | datetime |  |  |  |  | √ |  | 计划起始日期：保养计划产生填入 |
| 9 | PlanIntervalEndDate | datetime |  |  |  |  | √ |  | 计划结束日期：保养计划产生填入 |
| 10 | PlanMaintainUser | nvarchar | (30) |  |  |  | √ |  | 计划保养人员：保养计划产生填入 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |

---

### tblEMSACCSubstitutionUsed — 备品使用历程（15 字段）
> 主键：ACCSerialNo, PlanNo, Frequency, PMSerialNo, SubstitutionNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ACCSerialNo | nvarchar | (20) | √ |  |  |  |  | 模治具序号：流水号，用变更状态前的tblEMSAccessoryState.ACCSerialNo填入 |
| 2 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 4 | UseMode | numeric | (2,0) |  |  |  |  |  | 使用模式：1：维修 2：定期保养 3：定量保养 |
| 5 | PlanNo | nvarchar | (50) | √ |  |  |  |  | 计划编号：维修：固定N A 定量保养：保养计划编号 定期保养：保养计划编号 |
| 6 | Frequency | numeric | (8,0) | √ |  |  |  |  | 频率：维修：0 定量保养：保养频率 定期保养：0 |
| 7 | PMSerialNo | nvarchar | (15) | √ |  |  |  |  | 保养单号：维修：N A 定量保养：N A 定期保养：保养流水号 |
| 8 | SubstitutionNo | nvarchar | (100) | √ |  |  |  |  | 备品编号 |
| 9 | UseQTY | numeric | (12,4) |  |  |  | √ |  | 使用数量 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEMSCombineACCLog — 模治具组合历程（251 字段）
> 主键：COMBINEACCNO, ACCESSORYNO, ACCESSORYNO, ACCSERIALNO, EQUIPMENTNO, INSTRUMENTNO, INSTRUMENTNO, EQUIPMENTNO, INSTRUMENTNO, PARAMETERNO, PARAMETERNO, CUSTOMERNO, SUBCONTRACTORNO, SUBID, ACCESSORYNO, ACCESSORYVERSION
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CombineACCCategory | nvarchar | (50) |  |  |  |  |  | 组合模治具分类 |
| 2 | CombineACCType | nvarchar | (50) |  |  |  |  |  | 组合模治具类别 |
| 3 | CombineACCNo | nvarchar | (50) |  |  |  |  |  | 组合模治具编号 |
| 4 | CombinePosition | numeric | (2,0) |  |  |  | √ |  | 组合模治具位置 |
| 5 | AccessoryCategory | nvarchar | (50) |  |  |  |  |  | 模治具分类 |
| 6 | AccessoryType | nvarchar | (50) |  |  |  |  |  | 模治具类别 |
| 7 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | Revisor | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 11 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | COMBINEACCCATEGORY | nvarchar | (50) |  |  |  |  |  | 组合模治具分类 |
| 2 | COMBINEACCTYPE | nvarchar | (50) |  |  |  |  |  | 组合模治具类别 |
| 3 | COMBINEACCNO | nvarchar | (50) | √ |  |  |  |  | 组合模治具编号 |
| 4 | COMBINEPOSITION | decimal | (2,0) |  |  |  | √ |  | 组合模治具位置 |
| 5 | ACCESSORYCATEGORY | nvarchar | (50) |  |  |  |  |  | 模治具分类 |
| 6 | ACCESSORYTYPE | nvarchar | (50) |  |  |  |  |  | 模治具类别 |
| 7 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLEMSACCESSORYSTATEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 4 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 5 | USERNO | nvarchar | (30) |  |  |  | √ |  | 组合人员 |
| 6 | STARTTIME | datetime |  |  |  |  | √ |  | 组合日期 |
| 7 | ACCESSORYVERSION | nvarchar | (5) |  |  |  | √ |  | 模治具版次 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCSERIALNO | nvarchar | (20) | √ |  |  |  |  | 模治具序号：流水号，用变更状态前的tblEMSAccessoryState.ACCSerialNo填入 |
| 2 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 4 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 5 | ACCESSORYNO | nvarchar | (50) |  |  |  | √ |  | 模治具编号 |
| 6 | ACCESSORYVERSION | nvarchar | (5) |  |  |  | √ |  | 模治具版次 |
| 7 | USERNO | nvarchar | (30) |  |  |  | √ |  | 组合人员 |
| 8 | STARTTIME | datetime |  |  |  |  | √ |  | 组合日期 |
| 9 | ENDTIME | datetime |  |  |  |  | √ |  | 拆解日期 |
| 10 | ACUnLoadTime | numeric | (4,0) |  |  |  | √ |  | 实际下模时间 |
| 11 | ACLoadTime | numeric | (4,0) |  |  |  | √ |  | 实际上模时间 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQPSERIALNO | nvarchar | (20) |  |  |  | √ |  | 设备序号 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 3 | REASONNO | nvarchar | (50) |  |  |  | √ |  | 原因编号 |
| 4 | REASONNAME | nvarchar | (100) |  |  |  | √ |  | 原因名称 |
| 5 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQPSERIALNO | nvarchar | (20) |  |  |  | √ |  | 设备序号 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  |  |  | 设备状态：闲置  0 加工  1 故障  2 维修  3 保养  4 暂停  5 设置  6 关机  7 待机  8 (IIoT计数器超过X时 ) |
| 4 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 5 | STARTTIME | datetime |  |  |  |  |  |  | 开始时间 |
| 6 | USERNO | nvarchar | (30) |  |  |  | √ |  | 用户编号 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 8 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 9 | HandleUserNo | nvarchar | (30) |  |  |  | √ |  | 处理人员 |
| 10 | PlanStartTime | datetime |  |  |  |  | √ |  | 预计处理时间 |
| 11 | Remarks | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 12 | PLANENDTIME | datetime |  |  |  |  | √ |  | 预计完成时间 |
| 13 | REPAIRTYPE | numeric | (2,0) |  |  |  | √ |  | 维修类型：1 厂内 2 厂外 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQPSERIALNO | nvarchar | (20) |  |  |  |  | 'N/A' | 设备序号 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 3 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  |  |  | 设备状态：闲置  0 加工  1 故障  2 维修  3 保养  4 暂停  5 设置  6 关机  7 |
| 4 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 5 | STARTTIME | datetime |  |  |  |  |  |  | 开始时间 |
| 6 | ENDTIME | datetime |  |  |  |  |  |  | 结束时间 |
| 7 | USERNO | nvarchar | (30) |  |  |  | √ |  | 用户编号 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 10 | HandleUserNo | nvarchar | (30) |  |  |  | √ |  | 处理人员 |
| 11 | PlanStartTime | datetime |  |  |  |  | √ |  | 预计处理时间 |
| 12 | ActualEndTime | datetime |  |  |  |  | √ |  | 实际完成时间 |
| 13 | Remarks | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人员 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 16 | AdjustORGEquipmentState | numeric | (2,0) |  |  |  | √ |  | 原始设备状态 |
| 17 | AdjustPREEquipmentState | numeric | (2,0) |  |  |  | √ |  | 调整前设备状态 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | PLANENDTIME | datetime |  |  |  |  | √ |  | 预计完成时间 |
| 20 | REPAIRTYPE | numeric | (2,0) |  |  |  | √ |  | 维修类型：1 厂内 2 厂外 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 25 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | INSTRUMENTNO | nvarchar | (50) | √ |  |  |  |  | 仪表编号 |
| 2 | INSTRUMENTNAME | nvarchar | (50) |  |  |  |  |  | 仪表名称 |
| 3 | INSTRUMENTTYPE | nvarchar | (2) |  |  |  |  |  | 仪表类型：1-电表 2-水表 3-气表 |
| 4 | ISSYSTEM | nvarchar | (1) |  |  |  |  | '0' | 区域是否系统：0-否 1-是 是：区域由人员自行输入维护 否：选择区域编号时会加载系统内的区域信息 |
| 5 | AREANO | nvarchar | (50) |  |  |  |  |  | 区域编号 |
| 6 | AREANAME | nvarchar | (50) |  |  |  |  |  | 区域名称 |
| 7 | EQPMATCHMODE | nvarchar | (1) |  |  |  |  | '0' | 设备匹配模式：预留-目前只开放2 0-代表包含该区域下全设备 该模式下区域+仪表类型只能维护一个仪表 1-代表只包含该区域下一台设备 2-代表只包含该区域下部分设备 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CREATETIME | datetime |  |  |  |  |  |  | 创建日期 |
| 12 | MODIFIER | nvarchar | (10) |  |  |  |  |  | 更新人员 |
| 13 | MODITIME | datetime |  |  |  |  |  |  | 更新日期 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INSTRUMENTNO | nvarchar | (50) | √ |  |  |  |  | 仪表编号 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATETIME | datetime |  |  |  |  |  |  | 创建日期 |
| 5 | MODIFIER | nvarchar | (10) |  |  |  |  |  | 更新人员 |
| 6 | MODITIME | datetime |  |  |  |  |  |  | 更新日期 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INSTRUMENTNO | nvarchar | (50) | √ |  |  |  |  | 仪表编号 |
| 2 | PARAMETERNO | nvarchar | (50) | √ |  |  |  |  | 参数编号 |
| 3 | IIOTPOINT | nvarchar | (50) |  |  |  |  | 'N/A' | IIoT点位：预留 |
| 4 | WARNLOWER | numeric | (20,6) |  |  |  |  | 0 | 预警下限 |
| 5 | WARNUPPER | numeric | (20,6) |  |  |  |  | 0 | 预警上限 |
| 6 | ERRORLOWER | numeric | (20,6) |  |  |  |  | 0 | 边界下限 |
| 7 | ERRORUPPER | numeric | (20,6) |  |  |  |  | 0 | 边界上限 |
| 8 | WARNRULE | numeric | (2,0) |  |  |  |  | 0 | 预警规则：0-不预警 1-超出预警上下限预警 2-超出边界上下限预警 3-.... |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CREATETIME | datetime |  |  |  |  |  |  | 创建日期 |
| 11 | MODIFIER | nvarchar | (10) |  |  |  |  |  | 更新人员 |
| 12 | MODITIME | datetime |  |  |  |  |  |  | 更新日期 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PARAMETERNO | nvarchar | (50) | √ |  |  |  |  | 参数编号 |
| 2 | PARAMETERNAME | nvarchar | (50) |  |  |  |  |  | 参数名称 |
| 3 | INSTRUMENTTYPE | nvarchar | (2) |  |  |  |  |  | 仪表类型：1-电表 2-水表 3-气表 |
| 4 | UNITNAME | nvarchar | (64) |  |  |  |  |  | 单位 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATETIME | datetime |  |  |  |  |  |  | 创建日期 |
| 7 | MODIFIER | nvarchar | (10) |  |  |  |  |  | 更新人员 |
| 8 | MODITIME | datetime |  |  |  |  |  |  | 更新日期 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | CUSTOMERNO | nvarchar | (50) | √ |  |  |  |  | 客户编号 |
| 2 | CUSTOMERNAME | nvarchar | (255) |  |  |  | √ |  | 客户名称 |
| 3 | CUSTOMERSNAME | nvarchar | (255) |  |  |  | √ |  | 客户简称 |
| 4 | TELNO | nvarchar | (40) |  |  |  | √ |  | 电话 |
| 5 | FAXNO | nvarchar | (40) |  |  |  | √ |  | 传真 |
| 6 | WWW | nvarchar | (50) |  |  |  | √ |  | 网址 |
| 7 | TAXCODE | nvarchar | (40) |  |  |  | √ |  | 统一编号 |
| 8 | ADDRESS | nvarchar | (255) |  |  |  | √ |  | 地址 |
| 9 | DIRECTOR | nvarchar | (50) |  |  |  | √ |  | 负责人 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 14 | ADDRESS2 | nvarchar | (255) |  |  |  | √ |  | 地址2 |
| 15 | COUNTRY | nvarchar | (50) |  |  |  | √ |  | 国家 |
| 16 | STATUS | nvarchar | (5) |  |  |  | √ |  | 状态：0 有效  1 失效  2 呆账  3 暂停 |
| 17 | CURRENCY | nvarchar | (6) |  |  |  | √ |  | 收款币别 |
| 18 | INVTYPENO | nvarchar | (1) |  |  |  | √ |  | 发票开立方式 |
| 19 | INVADDR | nvarchar | (255) |  |  |  | √ |  | 发票地址：0 内销  1 外销 |
| 20 | INVADDR2 | nvarchar | (255) |  |  |  | √ |  | 发票地址2 |
| 21 | INVCUSTNO | nvarchar | (20) |  |  |  | √ |  | 发票开立对象 |
| 22 | INVREMARK | nvarchar | (100) |  |  |  | √ |  | 发票备注 |
| 23 | CUSTTYPE | nvarchar | (1) |  |  |  | √ |  | 客户类型：0 国内  1 国外 |
| 24 | ARTYPE | nvarchar | (1) |  |  |  | √ |  | 计价方式：0 入库计价  1 出货计价 |
| 25 | FREIGHTTERMS | nvarchar | (20) |  |  |  | √ |  | 运费条件 |
| 26 | PAYMENTTERMS | nvarchar | (20) |  |  |  | √ |  | 付款方式 |
| 27 | ACCTNO | nvarchar | (50) |  |  |  | √ |  | 账户编号 |
| 28 | DELIVERYTERM | nvarchar | (50) |  |  |  | √ |  | 运送 |
| 29 | FORWARDERASSIGNED | nvarchar | (50) |  |  |  | √ |  | 货运行指定 |
| 30 | BROKERASSIGNED | nvarchar | (50) |  |  |  | √ |  | 报关 |
| 31 | INSURANCECOVERAGE | nvarchar | (50) |  |  |  | √ |  | 保险 |
| 32 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 33 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 34 | CUSTOMERENAME | nvarchar | (50) |  |  |  | √ |  | 客户英文名称 |
| 35 | ERPNo | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 36 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 37 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 38 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | SUBCONTRACTORNO | nvarchar | (20) | √ |  |  |  |  | 外包商编号 |
| 2 | SUBCONTRACTORNAME | nvarchar | (255) |  |  |  | √ |  | 外包商名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | ERPNo | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 8 | MAXOUTPUTQTY | numeric | (10,1) |  |  |  | √ |  | 最大产能 |
| 9 | OUTPUTTYPE | varchar | (1) |  |  |  | √ |  | 单位 |
| 10 | ECINTEGRATION | numeric | (2,0) |  |  |  | √ |  | 外包商是否集成EC：#103385 0：不检核(不需要EC回报) 1：需检核(需要EC回报) |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | SUBCONTRACTORNO | nvarchar | (20) |  |  |  |  |  | 外包商编号 |
| 2 | CONTACTORNAME | nvarchar | (50) |  |  |  |  |  | 联络人名称 |
| 3 | TELNO | nvarchar | (40) |  |  |  | √ |  | 电话 |
| 4 | FAXNO | nvarchar | (40) |  |  |  | √ |  | 传真 |
| 5 | TITLE | nvarchar | (20) |  |  |  | √ |  | 职称 |
| 6 | ADDRESS | nvarchar | (255) |  |  |  | √ |  | 地址 |
| 7 | EMAIL | nvarchar | (255) |  |  |  | √ |  | 电子邮件 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | SUBID | nvarchar | (50) | √ |  |  |  | 'N/A' | 说明 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | TBLENTSUBCONTRACTORGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 2 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 3 | VENDORNO | nvarchar | (50) |  |  |  | √ |  | 供应商编号 |
| 4 | MODELNO | nvarchar | (50) |  |  |  | √ |  | 型号 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 9 | ASSETNO | nvarchar | (50) |  |  |  | √ |  | 财产编号 |
| 10 | ACCESSORYVERSION | nvarchar | (5) | √ |  |  |  | '01' | 模治具版次：目前没使用，系统默认都01，现行都是隐藏 |
| 11 | CURVERSION | numeric | (1,0) |  |  |  |  | 1 | 目前版本 |
| 12 | ACCESSORYCATEGORY | nvarchar | (50) |  |  |  | √ |  | 模治具分类 |
| 13 | ERPNO | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 14 | LocatorNo | nvarchar | (20) |  |  |  | √ | 'N/A' | 储位编号 |
| 15 | AccessoryName | nvarchar | (50) |  |  |  | √ |  | 模治具名称 |
| 16 | STDNumberCavity | numeric | (6,0) |  |  |  | √ | 1 | 标准穴数 |
| 17 | GoodNumberCavity | numeric | (6,0) |  |  |  | √ | 1 | 健康穴数 |
| 18 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 19 | ReviseDate | datetime |  |  |  |  | √ | getdate | 修改日期 |
| 20 | Priority | numeric | (2,0) |  |  |  | √ |  | 优先权 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 23 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 24 | C_REMAININGLIFE | numeric | (10,4) |  |  |  | √ |  | 更新后寿命 |

---

### tblEQPAccessoryBasisLog — 模治具基本数据历程（29 字段）
> 主键：SerialNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SerialNo | nvarchar | (50) | √ |  |  |  |  | 流水号：组成：YYMMDDXXXX YY：公元后两码 MM：月 DD：日 XXXX：依据YYMMDD编码，从1~9999 |
| 2 | ACCESSORYNO | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 3 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 4 | VENDORNO | nvarchar | (50) |  |  |  | √ |  | 供应商编号 |
| 5 | MODELNO | nvarchar | (50) |  |  |  | √ |  | 型号 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  |  | 2 | 签核状态：-1：Unused(不使用) 0：Unfrozen(未签核) 1：Pending(签核中) 2：Active(已签核) |
| 10 | ASSETNO | nvarchar | (50) |  |  |  | √ |  | 财产编号 |
| 11 | ACCESSORYVERSION | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 12 | CURVERSION | numeric | (1,0) |  |  |  |  | 0 | 目前版本 |
| 13 | ACCESSORYCATEGORY | nvarchar | (50) |  |  |  | √ |  | 模治具分类 |
| 14 | ERPNO | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 15 | LocatorNo | nvarchar | (20) |  |  |  | √ | 'N/A' | 储位编号 |
| 16 | AccessoryName | nvarchar | (50) |  |  |  | √ |  | 模治具名称 |
| 17 | STDNumberCavity | numeric | (6,0) |  |  |  | √ |  | 标准穴数 |
| 18 | GoodNumberCavity | numeric | (6,0) |  |  |  | √ |  | 健康穴数 |
| 19 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 20 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 21 | Priority | numeric | (2,0) |  |  |  | √ |  | 优先权 |
| 22 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 23 | ACCESSORYCATEGROY | nvarchar | (50) |  |  |  | √ |  | 模治具分类：模治具分类 |
| 24 | REVISETYPE | numeric | (1,0) |  |  |  |  | 0 | 变更类型：0 配置中心 1 批次进站 2 工单治具修改(生产中LOT) 3 工单治具修改(其他LOT) #91611  ADD |
| 25 | NEWSTDNUMBERCAVITY | numeric | (6,0) |  |  |  | √ |  | 新标准穴数：如果穴数调整产生的Log，将调整后的数量记录在此 #92618 |
| 26 | NEWGOODNUMBERCAVITY | numeric | (6,0) |  |  |  | √ |  | 新健康穴数：如果穴数调整产生的Log，将调整后的数量记录在此 #92618 |
| 27 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 28 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 29 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEQPAccessoryBasisLogReason — 模治具基本数据历程原因（76 字段）
> 主键：SerialNo, ReasonType, ReasonNo, ACCESSORYCATEGORY, ACCESSORY, ACCESSORY, PROPERTYNO, ACCESSORYVERSION, ACCESSORYTYPE, REPAIRPLANNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SerialNo | nvarchar | (50) | √ |  |  |  |  | 流水号：组成：YYMMDDXXXX YY：公元后两码 MM：月 DD：日 XXXX：依据YYMMDD编码，从1~9999 |
| 2 | ReasonType | numeric | (1,0) | √ |  |  |  | 0 | 原因类型：0：不良 1：叫修 2：维修 3：保养 4：穴数调整 |
| 3 | ReasonNo | nvarchar | (20) | √ |  |  |  |  | 原因编号：原因编号，若为CheckIn即为注塑包的进站调整(#91611) |
| 4 | ReasonName | nvarchar | (100) |  |  |  |  |  | 原因名称：原因名称，若为CheckIn即为注塑包的进站调整(#91611) |
| 5 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ACCESSORYCATEGORY | nvarchar | (50) | √ |  |  |  |  | 模治具分类 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 6 | CombineACC | numeric | (1,0) |  |  |  |  | 0 | 组合式模治具：0 否；1：是 |
| 7 | PositionQty | numeric | (2,0) |  |  |  |  | -1 | 位置数 |
| 8 | DESCROPTION | nvarchar | (255) |  |  |  | √ |  |  |
| 9 | STOCKSTATUS | numeric | (2,0) |  |  |  |  | 0 | 库存状态：0 (在库) 1 (在线) |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORY | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | LIFEMANAGE | numeric | (2,0) |  |  |  |  | 0 | 寿命管理：0：否，1：是 |
| 3 | LIFESCRIPT | nvarchar | (200) |  |  |  | √ |  | 寿命计算公式：利用DefineScript设置寿命计算公式 系统以自定计算式的方式，提供各模治具类别，计算每批的使用次数。如： Sample1：1批算一次，则定义1。 Sample2：若以各批批量来看，则可设置为#LA( CurQty )。 目前系统提供之标准函数： #LA  Lot Attrib，生产批作业站参数 #PP  Product Property，产品属性 #AP  Accessory Property，模治具属性 |
| 4 | REPAIRABLE | numeric | (2,0) |  |  |  | √ |  | 是否可维修：是否可维修 超过寿命后可否维修 |
| 5 | REPAIRCYCLE | numeric | (8,0) |  |  |  | √ |  | 寿命上限：使用 n 次需维修 若允许维修，则使用几次后需维修 |
| 6 | SCRAPTYPE | numeric | (2,0) |  |  |  | √ |  | 报废判断方式：选取此模治具之报废判断方式 使用几次后必须报废 0 Total Repair Times (累计维修次数) 1 Total Used Times (总使用次数) |
| 7 | SCRAPLIFE | numeric | (8,0) |  |  |  | √ |  | 报废寿命上限：总使用次数超过 n 次需报废 依  报废判断方式 决定报废时机 |
| 8 | LIFETOLERANCE | numeric | (2,0) |  |  |  | √ |  | 预计超过寿命是否仍可加工：0：否，1：是 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 12 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 13 | CountMode | numeric | (1,0) |  |  |  | √ |  | 寿命计算方式：0： 依据批量计算，1：依据批数计算，2：依据比例计算 |
| 14 | QTYRate | numeric | (9,4) |  |  |  | √ |  | 比例 |
| 15 | NoticeCycle | numeric | (8,0) |  |  |  | √ |  | 警示上限 |
| 16 | NoticeLife | numeric | (8,0) |  |  |  | √ |  | 寿命计算结果：结果只在数据表中显示 |
| 17 | source | numeric | (2,0) |  |  |  | √ | 1 | 资源：0：模治具分类设置 1：模治具类别设置 2：模治具机基本数据设置 |
| 18 | TBLEQPACCESSORYTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 19 | ACCESSORYVERSION | nvarchar | (5) |  |  |  |  | '1' | 模治具版次 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORY | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 2 | PROPERTYNO | nvarchar | (50) | √ |  |  |  |  | 属性编号 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 有效数据 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 签核状态：0 Unfrozen(未签核)1 Pending(签核中) 2 Active(已签核)-1 Unused(不使用) |
| 7 | ACCESSORYVERSION | nvarchar | (5) | √ |  |  |  | '-1' | 模治具版本 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORYTYPE | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 6 | ACCESSORYCATEGORY | nvarchar | (50) |  |  |  | √ |  | 模治具分类 |
| 7 | STDNumberCavity | numeric | (6,0) |  |  |  | √ | 1 | 标准穴数 |
| 8 | COMBINEACC | numeric | (1,0) |  |  |  |  |  | 组合式模治具：0 否；1：是 |
| 9 | STOCKSTATUS | numeric | (2,0) |  |  |  |  | 0 | 库存状态：0 (在库) 1 (在线) |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REPAIRPLANNO | nvarchar | (50) | √ |  |  |  |  | 维修计划编号 |
| 2 | DECSRIPTION | nvarchar | (255) |  |  |  |  |  | 说明 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblEQPACCRepairItem — 模治具维修项目（675 字段）
> 主键：AccessoryType, RepairItemNo, REPAIRPLANNO, ACCESSORYSTATE, CONTROLTYPE, CONTROLNO, SID, SID, SEQ, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, SID, ENGINEERGROUPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AccessoryType | nvarchar | (50) | √ |  |  |  |  | 模治具类别 |
| 2 | RepairItemNo | nvarchar | (100) | √ |  |  |  |  | 维修项目编号 |
| 3 | RepairItemName | nvarchar | (100) |  |  |  |  |  | 维修项目名称 |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | TBLEQPACCESSORYTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 8 | REPAIRPLANNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 维修计划编号：(未开发，未加入) |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ACCESSORYSTATE | numeric | (2,0) | √ |  |  |  |  | 模具状态 |
| 2 | STATETYPE | numeric | (2,0) |  |  |  |  | 1 | 状态类型 |
| 3 | STATENAME | nvarchar | (50) |  |  |  | √ |  | 状态名称 |
| 4 | STATECOLOR | numeric | (11,0) |  |  |  |  |  | 状态颜色 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | CONTROLTYPE | nvarchar | (50) | √ |  |  |  |  | 控制项类型 |
| 2 | CONTROLNO | nvarchar | (50) | √ |  |  |  |  | 控制项编号 |
| 3 | ACCESSORYSTATE | numeric | (2,0) |  |  |  |  |  | 模治具状态 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (64) | √ |  |  |  |  | 识别码 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | STATUS | numeric | (1,0) |  |  |  |  |  | 处置结果：0 未处置 1 人员处置 2 系统处置 |
| 5 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 6 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (64) | √ |  |  |  |  | 识别码 |
| 2 | SEQ | numeric | (3,0) | √ |  |  |  |  | 次序 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | PARTNO | nvarchar | (50) |  |  |  |  |  | 警告部件编号 |
| 5 | LEVELCODE | nvarchar | (250) |  |  |  |  |  | 警告层级 |
| 6 | ERRORCODE | nvarchar | (255) |  |  |  |  |  | 错误码 |
| 7 | ERRORMSG | nvarchar | (255) |  |  |  |  |  | 错误信息 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | PCB_CODE | nvarchar | (50) |  |  |  |  |  | 电路板编号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | AOI检测结论 |
| 20 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 21 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 22 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 23 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 18 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 19 | CHECK_DURATION | nvarchar | (10) |  |  |  |  |  | 检测时长 |
| 20 | TESTING_VOLTAGE | nvarchar | (10) |  |  |  |  |  | 试验电压值 |
| 21 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 22 | TEST_NAME | nvarchar | (50) |  |  |  |  |  | 试验名称 |
| 23 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 24 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 25 | LEAKAGE_CURRENT | numeric | (10,3) |  |  |  |  |  | 漏电流值 |
| 26 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 27 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 28 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 29 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 30 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | PCB_CODE | nvarchar | (50) |  |  |  |  |  | 电路板编号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | FCT检测结论 |
| 20 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 21 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 22 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 23 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 18 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 19 | ALLOWABLE_ERROR | nvarchar | (10) |  |  |  |  |  | 允许误差 |
| 20 | REAL_ERROR | numeric | (10,3) |  |  |  |  |  | 实际误差 |
| 21 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 22 | TEST_NAME | nvarchar | (50) |  |  |  |  |  | 试验名称 |
| 23 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 24 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 25 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 26 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 27 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 28 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 29 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | nvarchar | (-1) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 18 | CURRENT_VALUE | numeric | (32,3) |  |  |  |  |  | 电流实测值 |
| 19 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 20 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 21 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 22 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 18 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 基本误差检测结论 |
| 19 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 20 | TEST_NAME | nvarchar | (50) |  |  |  |  |  | 试验名称 |
| 21 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 22 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 18 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 19 | AVERAGE_ERROR | nvarchar | (10) |  |  |  |  |  | 平均误差 |
| 20 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 21 | TEST_NAME | nvarchar | (50) |  |  |  |  |  | 试验名称 |
| 22 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 23 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 24 | AVERAGE_ERROR_TYPE | nvarchar | (5) |  |  |  |  |  | 类型 |
| 25 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 26 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 27 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 28 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 29 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 17 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 18 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 19 | PLANT_CODE | nvarchar | (32) |  |  |  |  |  | 厂内编号 |
| 20 | SOFTWARE_VERSION | nvarchar | (50) |  |  |  |  |  | 软件版本号软件备案号 |
| 21 | NAMEPLATE_CODE | nvarchar | (50) |  |  |  |  |  | 局编号 下铭牌号 |
| 22 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 23 | TEST_NAME | nvarchar | (50) |  |  |  |  |  | 试验名称 |
| 24 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 25 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 26 | TABLE_NO | nvarchar | (50) |  |  |  |  |  | 表号 |
| 27 | TABLE_ADDRESS | nvarchar | (50) |  |  |  |  |  | 表地址 |
| 28 | ASSET_MANAGEMENT_NO | nvarchar | (50) |  |  |  |  |  | 资产管理编码 |
| 29 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 30 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 10 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 11 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 生产工单编号 |
| 12 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 13 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 14 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 15 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 16 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 17 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 18 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 19 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 20 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 21 | WARMING_ZONE | numeric | (10,1) |  |  |  |  |  | 升温区 |
| 22 | CONSTANT_TEMPERATURE_ZONE | numeric | (10,1) |  |  |  |  |  | 恒温区 |
| 23 | WELDING_ZONE | numeric | (10,1) |  |  |  |  |  | 焊接区 |
| 24 | COOLING_ZONE | numeric | (10,1) |  |  |  |  |  | 冷却区 |
| 25 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 26 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 27 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 28 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 29 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 10 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 11 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 生产工单编号 |
| 12 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 13 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 14 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 15 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 16 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 17 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 18 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 19 | PCB_CODE | nvarchar | (32) |  |  |  |  |  | 电路板编号 |
| 20 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 21 | PREHEATING_AREA | numeric | (10,1) |  |  |  |  |  | 预热区 |
| 22 | WELDING_ZONE | numeric | (10,1) |  |  |  |  |  | 焊接区 |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 10 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 11 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 生产工单编号 |
| 12 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 13 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 14 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 15 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 16 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 17 | AGINGROOM_TEMPERATURE | numeric | (10,1) |  |  |  |  |  | 实际温度 |
| 18 | STANDARD_TEMPERATURE | numeric | (10,1) |  |  |  |  |  | 标准温度 |
| 19 | DEVICE_NO | nvarchar | (50) |  |  |  |  |  | 设备编码 |
| 20 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 25 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | VARISTOR_VOLTAGE | numeric | (10,1) |  |  |  |  |  | 压敏电压实测值 |
| 20 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 压敏电阻测试结论检测结论 |
| 21 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 22 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 23 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 24 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 25 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 26 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 27 | ERROR_VALUE | numeric | (10,3) |  |  |  |  |  | 压敏电压误差值 |
| 28 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 29 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 30 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 31 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 32 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 33 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 34 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | RATIO_VALUE | numeric | (10,1) |  |  |  |  |  | 传输比实测值 |
| 20 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 光电耦合测试结论检测结论 |
| 21 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 22 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 23 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 24 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 25 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 26 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 27 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 28 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 29 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 30 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | FREQUENCY_VALUE | numeric | (10,1) |  |  |  |  |  | 频差实测值标称频差 |
| 20 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 晶体谐振器检测结论检测结论 |
| 21 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 22 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 23 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 24 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 25 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 26 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 27 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 28 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 29 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 30 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | LEAKAGE_CURRENT | numeric | (10,3) |  |  |  |  |  | 漏电流实测值 |
| 20 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 瞬变二极管检测结论检测结论 |
| 21 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 22 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 23 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 24 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 25 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 26 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 27 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 28 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 29 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 30 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | nvarchar | (-1) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | VOLTAGE_VALUES | numeric | (10,3) |  |  |  |  |  | 电压值标称电压 |
| 20 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 瞬变二极管检测结论检测结论 |
| 21 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 22 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 23 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 24 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 25 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 26 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 27 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 28 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 29 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 30 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 显示结论测试结论 |
| 20 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 21 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 22 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 23 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 24 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 25 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 26 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 27 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 28 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 29 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 30 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 31 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 32 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | SUPPLIERCODE | nvarchar | (20) |  |  |  |  |  | 供应商编号 |
| 10 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 11 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 12 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 工单编号生产工单编号 |
| 13 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 检验数据编号 |
| 14 | CHECK_TIME | datetime |  |  |  |  |  |  | 检验时间 |
| 15 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 16 | MATERIAL_SUPPLIER | nvarchar | (100) |  |  |  |  |  | 原材料制造商 |
| 17 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 18 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 19 | CONTRAST_VALUE | numeric | (10,3) |  |  |  |  |  | 比差值 |
| 20 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 电流互感器检测结论检测结论 |
| 21 | MATERIAL_CHECK_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料检验批次号 |
| 22 | MATERIAL_BATCH | nvarchar | (50) |  |  |  |  |  | 原材料批次号 |
| 23 | MATERIAL_BRAND | nvarchar | (100) |  |  |  |  |  | 原材料品牌 |
| 24 | MATERIAL_LEAVE_TIME | nvarchar | (10) |  |  |  |  |  | 原材料出厂日期 |
| 25 | INCOMING_CHECK_TIME | nvarchar | (10) |  |  |  |  |  | 来料检验日期 |
| 26 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 27 | INCOMING_INSPCTION_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 来料检测报告 |
| 28 | MATERIAL_SUPPLIER_REPORT_ID | nvarchar | (255) |  |  |  | √ |  | 生产商检测报告 |
| 29 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 30 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 10 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 11 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 生产工单编号 |
| 12 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 流水号 |
| 13 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 14 | MODEL_CODE | nvarchar | (150) |  |  |  |  |  | 规格型号 |
| 15 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 16 | CONCLUSION | numeric | (1,0) |  |  |  |  |  | 检测结论 |
| 17 | UNIT | nvarchar | (10) |  |  |  |  |  | 计量单位 |
| 18 | STORAGE_TIME | nvarchar | (10) |  |  |  |  |  | 入库时间 |
| 19 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 20 | NUMBER | numeric | (1,0) |  |  |  |  |  | 数量 |
| 21 | NAMEPLATE_CODE | nvarchar | (50) |  |  |  |  |  | 局编号 下铭牌号 实物ID |
| 22 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 23 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 26 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (4000) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | STANDARDVERSION | numeric | (1,0) |  |  |  |  |  | 采集规范版本号 |
| 10 | PRODUCTION_ORDER_ID | nvarchar | (32) |  |  |  |  |  | 生产订单编号 |
| 11 | WORK_ORDER_CODE | nvarchar | (32) |  |  |  |  |  | 生产工单编号 |
| 12 | TEST_CODE | nvarchar | (32) |  |  |  |  |  | 流水号 |
| 13 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 14 | MODEL_CODE | nvarchar | (50) |  |  |  |  |  | 规格型号 |
| 15 | INFO_TYPE_CODE | nvarchar | (10) |  |  |  |  |  | 工序编码 |
| 16 | DELIVER_STATUS | nvarchar | (1) |  |  |  |  |  | 发货状态 |
| 17 | UNIT | nvarchar | (10) |  |  |  |  |  | 计量单位 |
| 18 | DELIVER_TIME | nvarchar | (10) |  |  |  |  |  | 发货时间 |
| 19 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 20 | NUMBER | numeric | (1,0) |  |  |  |  |  | 数量 |
| 21 | NAMEPLATE_CODE_START | nvarchar | (50) |  |  |  |  |  | 局编号 下铭牌号（始号） |
| 22 | NAMEPLATE_CODE_FINAL | nvarchar | (50) |  |  |  |  |  | 局编号 下铭牌号（终号） |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 27 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (40) | √ |  |  |  |  | 主键 |
| 3 | IS_SEND | char | (1) |  |  |  |  |  | 是否已抛转过 |
| 4 | MODIFY_DATE | datetime |  |  |  |  | √ |  | 抛转日期 |
| 5 | CREATE_DATE | datetime |  |  |  |  |  |  | 创建日期 |
| 6 | STATUS | numeric | (1,0) |  |  |  |  |  | 成功标识 |
| 7 | MESSAGE | nvarchar | (100) |  |  |  |  |  | 提示消息, 成功标识失败时填写 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据是否核准, 数值2才会上抛EAI |
| 9 | PRODUCTIONORDERNO | nvarchar | (50) |  |  |  |  |  | 生产订单号 |
| 10 | PRODUCTIONWORKNO | nvarchar | (50) |  |  |  | √ |  | 生产工单号 |
| 11 | PROCEDURECODE | nvarchar | (50) |  |  |  |  |  | 工序编码 |
| 12 | FILEARRAY | nvarchar | (-1) |  |  |  |  |  | 档数组 |
| 13 | TEST_CODE | nvarchar | (50) |  |  |  |  |  | 档流水号 |
| 14 | CREATE_TIME | datetime |  |  |  |  |  |  | 创建时间 抓取时间 |
| 15 | UPLOAD_TIME | nvarchar | (19) |  |  |  |  |  | 上传时间 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ENGINEERGROUPNO | nvarchar | (20) | √ |  |  |  |  | 管理群组：后端显示列名为manage group |
| 2 | ENGINEERGROUPNAME | nvarchar | (50) |  |  |  | √ |  | 工程组名：可选择群组用户：用户设置是在人员管理-用户基本数据 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblEQPEquipmentAccessoryMap — 设备与模治具对应（80 字段）
> 主键：EquipmentNo, AccessoryNo, AccessoryVersion, EQUIPMENTNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | AccessoryNo | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | ACCESSORYTYPE | nvarchar | (50) |  |  |  | √ |  | 模治具类别 |
| 7 | VENDORNO | nvarchar | (20) |  |  |  | √ |  | 供货商编号：供货商编号定义 (必须唯一) |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号定义(不可与设备类别编号相同) |
| 2 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 3 | CAPACITY | numeric | (8,0) |  |  |  | √ | -1 | 批量限制 |
| 4 | VENDORNO | nvarchar | (50) |  |  |  | √ |  | 供应商编号 |
| 5 | MODELNO | nvarchar | (50) |  |  |  | √ |  | 型号 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态：数据目前状态 |
| 10 | ENGINEERGROUPNO | nvarchar | (20) |  |  |  | √ |  | 工程群组编号：指定负责此设备的设备工程师群组，当设备发生异常时，系统可发送e-mail通知给这个群组中的成员。系统会带出设备类别之工程群组编号作为预设值。 |
| 11 | ASSETNO | nvarchar | (50) |  |  |  | √ |  | 财产编号 |
| 12 | EQUIPMENTCLASS | nvarchar | (50) |  |  |  | √ |  | 设备分类：设备分类包含：GENERAL、LINE、DUMMY三类 GENERAL：一般设备 LINE   ：产线设备 DUMMY  ：虚拟设备 |
| 13 | LOADPORT | numeric | (2,0) |  |  |  | √ | 0 | 上货区数量：此设备同时可加工批数. 必须搭配WIP模块内「生产批执行_设备」的机台过帐界面使用. |
| 14 | AUTOFLAG | numeric | (1,0) |  |  |  | √ | 1 | 自动机台：是否为自动化设备 |
| 15 | EACONTROLLER | nvarchar | (200) |  |  |  | √ |  | 控制器名称：机台控制器名称(机台连线时备注栏比特). 可直接标注控制器名称或设定为「N A」 |
| 16 | EQPRECIPE | numeric | (1,0) |  |  |  | √ | 0 | 设备参数 |
| 17 | QCLISTNO | nvarchar | (50) |  |  |  | √ |  | 点检表编号 |
| 18 | MaxTime | numeric | (6,2) |  |  |  | √ |  | 预设产能 |
| 19 | FixEqpTime | numeric | (15,4) |  |  |  | √ | 0 | 固定机时 |
| 20 | VarEqpTime | numeric | (15,4) |  |  |  | √ | 0 | 变动机时 |
| 21 | CountEqpUnitQty | numeric | (6,0) |  |  |  | √ | 1 | 机时单位批量 |
| 22 | COUNTER | numeric | (12,4) |  |  |  | √ |  | 当前设备的计数器：当前LOT的设备计数产量(已乘倍数)L1 生产批 自第一次进站 到目前的 累计产出量 (出站不清0，进站为不同LOT时清0) 83905  型别应能写入浮点数，NUMERIC(5, 0)改为 NUMERIC(12, 4) |
| 23 | ERPNO | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 24 | EquipmentName | nvarchar | (255) |  |  |  | √ |  | 设备名称 |
| 25 | PRODUCTIONINF | numeric | (1,0) |  |  |  |  | 0 | 生产信息收集 |
| 26 | ALLOWMULTIWORK | numeric | (1,0) |  |  |  |  | 1 | 允许是否可多人加工：10 25 哲玮比对后添加 |
| 27 | SETUPIGNOREMACHINE | numeric | (1,0) |  |  |  | √ | 0 | 设置状态时忽略机台连接信号 |
| 28 | SPC_PQC | numeric | (2,0) |  |  |  | √ | 0 | SPC_PQC |
| 29 | EQUIPMENTCHECKUP | nvarchar | (1) |  |  |  |  | '0' | 点检控管：10 25 哲玮比对后添加 |
| 30 | EQUIPMENTCHECKUPRATE | nvarchar | (1) |  |  |  |  | '2' | 检查频率 |
| 31 | EQUIPMENTCHECKUPTIME | datetime |  |  |  |  | √ | getdate | 检查时间 |
| 32 | Counter_Pre | numeric | (12,4) |  |  |  | √ |  | 上次出站计数值：当前LOT累积已出站数量当前LOT可出站机器产量=Counter-Counter_Pre |
| 33 | OutUserOption | numeric | (2,0) |  |  |  |  | 0 | 报工人员认定 |
| 34 | OutLaberTimeOption | numeric | (2,0) |  |  |  |  | 0 | 人时分摊方式 |
| 35 | OutLaberExclusive | numeric | (2,0) |  |  |  |  | 0 | 人时除外时间 |
| 36 | OutMachineExclusive | numeric | (2,0) |  |  |  |  | 0 | 机时除外时间 |
| 37 | OutQtyDefinition | numeric | (2,0) |  |  |  |  | 0 | 出站数量认定 |
| 38 | OutQtyOption | numeric | (2,0) |  |  |  |  | 0 | 数量分摊方式 |
| 39 | OutQtyAllowZero | numeric | (2,0) |  |  |  |  | 0 | 出站数量可为零 |
| 40 | CounterUpdateTime | datetime |  |  |  |  | √ |  | 计数器更新时间 |
| 41 | CounterEQTime | datetime |  |  |  |  | √ |  | 计数器设备回传时间 |
| 42 | SPC_PQC2 | varchar | (10) |  |  |  | √ |  | 首 巡检制程检验 |
| 43 | RecordTimeOutDate | datetime |  |  |  |  | √ |  | 定时出站时间 |
| 44 | StdTimeOut | numeric | (12,4) |  |  |  |  | 0 | 定时出站(分) |
| 45 | StdTimeOutQty | numeric | (12,4) |  |  |  |  | 0 | 定量出站 |
| 46 | LotBinding | numeric | (2,0) |  |  |  |  | 0 | 生产批绑定：0 不绑定  1 需绑定#78543 |
| 47 | LineInventoryNo | nvarchar | (20) |  |  |  | √ |  | 线边仓编号：#82275 20201223 朱煜轲 |
| 48 | COUNTERBYLOT | numeric | (12,4) |  |  |  |  | 0 | 当前生产批累计计数数：生产批 自第一次进站 到目前的 累计计数量 (出站不清0，进站为不同LOT时清0) |
| 49 | COUNTERBYCHECKOUT | numeric | (12,4) |  |  |  |  | 0 | 最近出站计数量：最近出站计数量 |
| 50 | COUNTERBYCHECKIN | numeric | (12,4) |  |  |  |  | 0 | 最近进站计数量：最近进站计数量 |
| 51 | COUNTER_PRECHECKIN | numeric | (12,4) |  |  |  |  | 0 | 当前生产批本周期累计生产数：生产批 自上一进站后 到目前的 累计产出量 |
| 52 | COUNTERBYWAIT | numeric | (12,4) |  |  |  |  | 0 | 生产批开始暂停生产数量：生产批 暂停开始时计数器 |
| 53 | COUNTERBYRELEASEWAIT | numeric | (12,4) |  |  |  |  | 0 | 生产批解除暂停生产数量：生产批 解除暂停时计数器 |
| 54 | COUNTERMULTIPLE | numeric | (12,4) |  |  |  |  | 1 | 计数器加乘倍数：计数器加乘倍数 |
| 55 | COUNTERBYCHECKOUTWAIT | numeric | (12,4) |  |  |  |  | 0 | 最后出站之后的暂停数量：最后出站之后的累积暂停数量 |
| 56 | COUNTERBYLOTWAIT | numeric | (12,4) |  |  |  |  | 0 | 生产批的累积暂停数量：生产批的累积暂停数量 |
| 57 | ISAUTOCINEXTEQ | numeric | (1,0) |  |  |  |  | 0 | 是否指定下站自动进站：1 指定下站自动进站  0 不指定 #79733 |
| 58 | CINEXTEQ | nvarchar | (50) |  |  |  | √ |  | 下站进站设备 产线编号：下站进站设备 产线编号 #79733 |
| 59 | ACCESSORYASSIGN | numeric | (1,0) |  |  |  | √ | 0 | 派工指定模治具：0 不指定  1 需指定#79359 |
| 60 | COUNTER_LASTCOUNT | numeric | (12,4) |  |  |  |  | 0 | 上次计数器数值：注塑产量部份用计数器 #91511 |
| 61 | EQPAUTOCHECKOUTFLAG | nvarchar | (1) |  |  |  |  | '0' | 设备自动出站模式：0 手动出站  1 半自动出站  2 全自动出站  #91613 |
| 62 | STDTIMEOUTNONAUTOCOUNT | numeric | (12,4) |  |  |  |  | -1 | 自动出站保留数量：有设定自动出站时(定时或定量出站 0)，最后至少需保留多少数量不能自动出站，需手动处理。此值=-1时表示一律不自动出站但会警示、=0时表示一律会自动出站， =1时会检查保留数量，若出站后超过保留数量则自动出站而是触发手动出站通知 |
| 63 | COUNTDIFFOUTLIER | numeric | (12,4) |  |  |  |  | 999 | 计数器差异异常值：计数器前后差异异常值 |
| 64 | STDTIMEOUTNONAUTORATIO | numeric | (12,4) |  |  |  |  | 0 | 自动出站保留比例%：0表示本参数不生效，全看自动出站保留数量， 0时则一律取用本数值计算保留量，保留量=LOT数量 比例 |
| 65 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 66 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 67 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID：数据键值 |
| 68 | SetUpignoreStateTO | numeric | (2,0) |  |  |  | √ | 1 | [设备故障后不再自动开启忽略机联 |

---

### tblEQPEquipmentCheckUpRate — 设备多频率点检基础档（25 字段）
> 主键：EquipmentNo, EquipmentCheckUpRate, EQUIPMENT, PROPERTYNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | EquipmentCheckUp | nvarchar | (1) |  |  |  |  |  | 点检控管 |
| 3 | EquipmentCheckUpRate | nvarchar | (1) | √ |  |  |  |  | 点检频率 |
| 4 | QcListNo | nvarchar | (50) |  |  |  | √ |  | 点检表编号 |
| 5 | IsEnabled | numeric | (1,0) |  |  |  |  |  | 是否启用 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQUIPMENT | nvarchar | (50) | √ |  |  |  |  | 设备 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 默认值 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 签核状态：0  Unfrozen (未签核) 1  Pending (签核中) 2  Active (已签核) -1  Unused (不使用) |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLEQPEQUIPMENTTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 13 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblEQPEquipmentReason — 设备稼动原因设定（48 字段）
> 主键：Equipment, Source, ReasonNo, EQUIPMENTNO, SKILLNO, EQUIPMENTTYPE, PICTURENAME
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | Equipment | nvarchar | (64) | √ |  |  |  |  | 设备编号 类别 |
| 2 | Source | numeric | (2,0) | √ |  |  |  | 0 | 稼动类别：如故障 保养 关机 |
| 3 | ReasonNo | nvarchar | (20) | √ |  |  |  |  | 原因编号 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLEQPEQUIPMENTTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLQCREASONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | SKILLNO | nvarchar | (20) | √ |  |  |  |  | 技能编号 |
| 3 | GRADENO | nvarchar | (50) |  |  |  |  |  | 技能等级：技能等级 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQUIPMENTTYPE | nvarchar | (50) | √ |  |  |  |  | 设备类别：设备类别编号，不可与设备基本数据的设备编号相同 |
| 2 | CAPACITY | numeric | (8,0) |  |  |  | √ | -1 | 容量 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 7 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | PICTURENAME | nvarchar | (50) |  |  |  | √ |  | 图片名称：指定设备类别的图片。图片选取或档案添加。 |
| 10 | ENGINEERGROUPNO | nvarchar | (20) |  |  |  | √ |  | 管理群组：工程群组编号选取。指定负责此设备类别的设备工程师群组，当设备发生异常时，系统可发送e-mail通知给这个群组中的成员。 |
| 11 | EQUIPMENTCLASS | nvarchar | (50) |  |  |  | √ |  | 设备分类 |
| 12 | STDUNITEMPTIME | numeric | (6,2) |  |  |  |  | 0 | 标准单位工时 |
| 13 | STDUNITEQPTIME | numeric | (6,2) |  |  |  |  | 0 | 标准单位机时 |
| 14 | COUNTEQPUNITQTY | numeric | (6,0) |  |  |  |  | 1 | 计时基本数量 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 18 | EQUIPMENTPICTURE | varbinary | (-1) |  |  |  | √ |  | 设备图片 |
| 1 | PICTURENAME | nvarchar | (50) | √ |  |  |  |  | 图片名称 |
| 2 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 8 | PICTUREBODY | varbinary | (-1) |  |  |  | √ |  | 图片内容：图片内容 |

---

### tblEQPEquipmentTypeACCCategory — 设备模治具分类（193 字段）
> 主键：EquipmentType, AccessoryCategory, EQUIPMENTGROUP, EQPGROUPNO, EQUIPMENTGROUP, EQUIPMENTNO, EQPGROUPNO, EQUIPMENTNO, EQUIPMENTNO, LOTNO, OPNO, EQUIPMENTNO, PARTNO, EQUIPMENTNO, PARTNO, QCLISTNO, QCLISTNO, QCORDER, QCITEM, EQUIPMENTSTATE, CONTROLTYPE, CONTROLNO, VENDORNO, DOCTYPENO, ID, ID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentType | nvarchar | (50) | √ |  |  |  |  | 设备类别 |
| 2 | AccessoryCategory | nvarchar | (50) | √ |  |  |  |  | 模治具分类：可在：模治具管理-模治具分类设置 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | TBLEQPEQUIPMENTTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLEQPACCESSORYCATEGORYGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTGROUP | nvarchar | (50) | √ |  |  |  |  | 设备群组 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQPGROUPNO | nvarchar | (50) | √ |  |  |  |  | 设备群组 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTGROUP | nvarchar | (50) | √ |  |  |  |  | 设备群组 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | TBLEQPGROUPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQPGROUPNO | nvarchar | (50) | √ |  |  |  |  | 设备群组 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 更新时间 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批编号 |
| 4 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 5 | LOTTOTALQTY | numeric | (12,4) |  |  |  |  | 0 | 预计产量：该LOT应生产数量 |
| 6 | ACCQTY | numeric | (12,4) |  |  |  |  | 0 | 累积产量：LOT已出站+LOT可出站的数量 |
| 7 | ACCINPUTQTY | numeric | (12,4) |  |  |  |  | 0 | 累积已进站量：只算已进站(R)的数量 |
| 8 | ACCOUTPUTQTY | numeric | (12,4) |  |  |  |  | 0 | 累积已出站量：只算已出站(C)的数量 |
| 9 | ALTERCHECKOUT | numeric | (1,0) |  |  |  |  | 0 | 手动出站提示：0 无提示 1 手动出站 2 已完成出站 |
| 10 | CHECKOUTQTY | numeric | (12,4) |  |  |  |  | 0 | 出站数量 |
| 11 | ALTERDATE | datetime |  |  |  |  | √ |  | 提示时间 |
| 12 | CHECKOUTDATE | datetime |  |  |  |  | √ |  | 操作出站时间 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | PARTNO | nvarchar | (50) | √ |  |  |  |  | 部件编号 |
| 3 | PARTNAME | nvarchar | (50) |  |  |  |  |  | 部件名称 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明 |
| 5 | REVISOR | nvarchar | (10) |  |  |  |  |  | 修改人 |
| 6 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | PARTNO | nvarchar | (50) | √ |  |  |  |  | 部件编号 |
| 3 | STATUSCODE | nvarchar | (50) |  |  |  |  |  | 部件状况码：保留栏位暂无用处 |
| 4 | PARTEAR | numeric | (12,4) |  |  |  |  |  | 妥善百分比：预设为100% |
| 5 | PARTERT | numeric | (12,4) |  |  |  |  |  | 维保剩余时间(天)：预设为0天 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | QCLISTNO | nvarchar | (100) | √ |  |  |  |  | 点检表编号 |
| 2 | QCLISTNAME | nvarchar | (100) |  |  |  | √ |  | 点检表名称 |
| 3 | QCTYPE | numeric | (2,0) |  |  |  |  | 2 | 点检方式：点检方式定义 0：Check In (开始生产时点检) 2：Manual (手动点检) |
| 4 | UNVALIDACTION | numeric | (2,0) |  |  |  | √ | -1 | 不合理值反应：若有点检项目不通过时，该设备应做出的反应 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | ValidDate | numeric | (8,0) |  |  |  | √ | -1 | 有效时间 |
| 9 | ValidLot | numeric | (8,0) |  |  |  | √ | -1 | 有效批数 |
| 10 | ValidQTY | numeric | (8,0) |  |  |  | √ | -1 | 有效批量 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | QCLISTNO | nvarchar | (100) | √ |  |  |  |  | 点检表编号 |
| 2 | QCORDER | numeric | (2,0) | √ |  |  |  |  | 点检次序 |
| 3 | QCITEM | nvarchar | (1000) | √ |  |  |  |  | 品管项目：点检项目 |
| 4 | QCTYPE | numeric | (1,0) |  |  |  |  |  | 点检方式：点检数据输入类型 0：Value (标准值-目前无作用) 1：Range (数字范围) 2：Message (显示讯息-on off) 3：InputData (输入数据-一般文本) |
| 5 | STDVALUE | nvarchar | (12) |  |  |  | √ |  | 标准用量 |
| 6 | MAXIVALUE | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 7 | MINIVALUE | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 8 | INPUTDATACOUNT | numeric | (2,0) |  |  |  |  | 1 | 输入个数 |
| 9 | INSPECTIONMETHOD | nvarchar | (100) |  |  |  | √ |  | 检查方法 |
| 10 | INSPECTIONSTANDARDS | nvarchar | (100) |  |  |  | √ |  | 检查标准 |
| 11 | DataitemNO | nvarchar | (50) |  |  |  | √ |  | 数据项编号 |
| 12 | AutoDataQuery | numeric | (1,0) |  |  |  | √ | 0 | 下询数据项：0 N 1 Y 预设0 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据目前状态 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | TBLEQPQCLISTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 20 | ISUPLOADFILE | numeric | (1,0) |  |  |  |  | 0 | 是否上传文件：0：是 1：否 |
| 1 | EQUIPMENTSTATE | numeric | (2,0) | √ |  |  |  |  | 设备状态编号 |
| 2 | STATETYPE | numeric | (2,0) |  |  |  |  | 1 | 状态类型 |
| 3 | STATENAME | nvarchar | (50) |  |  |  | √ |  | 状态名称 |
| 4 | STATECOLOR | numeric | (11,0) |  |  |  |  |  | 状态颜色 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | ENGINEERGROUPNO | nvarchar | (20) |  |  |  | √ |  | 管理群组编号 |
| 7 | UTILIZATIONTYPE | numeric | (1,0) |  |  |  |  | 1 | 使用类型 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | CONTROLTYPE | nvarchar | (50) | √ |  |  |  |  | 控制类型 |
| 2 | CONTROLNO | nvarchar | (50) | √ |  |  |  |  | 控制编号 |
| 3 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  |  |  | 设备状态编号 |
| 4 | STATENAME | nvarchar | (50) |  |  |  | √ |  | 状态名称 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | VENDORNO | nvarchar | (20) | √ |  |  |  |  | 供货商编号：供货商编号定义 (必须唯一) |
| 2 | VENDORNAME | nvarchar | (255) |  |  |  | √ |  | 供货商名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | ERPNo | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | VENDORNO | nvarchar | (20) |  |  |  |  |  | 供货商编号 |
| 2 | CONTACTORNAME | nvarchar | (50) |  |  |  |  |  | 联络人名称 |
| 3 | TELNO | nvarchar | (40) |  |  |  | √ |  | 电话 |
| 4 | FAXNO | nvarchar | (40) |  |  |  | √ |  | 传真 |
| 5 | TITLE | nvarchar | (20) |  |  |  | √ |  | 职称 |
| 6 | ADDRESS | nvarchar | (255) |  |  |  | √ |  | 地址 |
| 7 | EMAIL | nvarchar | (255) |  |  |  | √ |  | 电子邮件 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | TBLEQPVENDORGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | DOCTYPENO | nvarchar | (50) | √ |  |  |  |  | 单别编号 |
| 2 | DOCTYPENAME | nvarchar | (50) |  |  |  | √ |  | 单别名称 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ID | nvarchar | (64) | √ |  |  |  |  | ID |
| 2 | TRANSACTIONID | nvarchar | (50) |  |  |  | √ |  | 交易编号 |
| 3 | MODULEID | nvarchar | (20) |  |  |  | √ |  | 模块ID |
| 4 | FUNCTIONID | nvarchar | (50) |  |  |  | √ |  | 功能ID |
| 5 | COMPUTERNAME | nvarchar | (50) |  |  |  | √ |  | 计算机名称 |
| 6 | CURUSERNO | nvarchar | (20) |  |  |  | √ |  | 目前用户编号 |
| 7 | SENDTIME | datetime |  |  |  |  | √ |  | 传送时间 |
| 8 | RESULT | nvarchar | (30) |  |  |  | √ |  | 结果：fail：失败 success：成功 |
| 9 | KEYVALUE | nvarchar | (50) |  |  |  | √ |  | 值 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ID | nvarchar | (64) | √ |  |  |  |  | ID |
| 2 | MESSAGEXML | nvarchar | (-1) |  |  |  | √ |  | 讯息XML |
| 3 | EXCEPTIONXML | nvarchar | (-1) |  |  |  | √ |  | 例外讯息XML |
| 4 | INXML | nvarchar | (-1) |  |  |  | √ |  | 传入XML |
| 5 | OUTXML | nvarchar | (-1) |  |  |  | √ |  | 传出XML |
| 6 | EXCEPTIONFUN | nvarchar | (50) |  |  |  | √ |  | 执行功能编号 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblOEMOAccessoryCombineLog — 工单模治具绑定历程（11 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MONo | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 2 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) |  |  |  |  |  | 模治具版次 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 6 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | ReviseDate | datetime |  |  |  |  | √ | getdate | 修改日期 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblOEMOAccessoryCombineState — 工单模治具绑定（347 字段）
> 主键：MONo, AccessoryNo, AccessoryVersion, MONO, MONO, COMPONENTNO, MONO, MATERIALNO, OPNO, SUBSTITUTEMATERIALNO, PositionNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MONo | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | AccessoryNo | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 3 | AccessoryVersion | nvarchar | (5) | √ |  |  |  |  | 模治具版次 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 6 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 7 | TBLOEMOBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | RONO | nvarchar | (25) |  |  |  |  |  | 订单编号：当工单开立的来源依据为订单或参考订单时用以记录订单编号。 |
| 3 | ITEMNO | numeric | (6,0) |  |  |  |  |  | 项次：当工单开立的来源依据为订单或参考订单时会用以记录订单编号使用的订单项次。 |
| 4 | MOSTATE | numeric | (2,0) |  |  |  |  |  | 工单状态：0 Unconfirm(未确认，未签核) 1 Pending(确认中，签核中) 2 Confirm(已确认，已签核) 3 Release(允许开立生产批) 6 已在客托仓或退货仓的工单(允许开立生产批) 99 Close(工单结案) |
| 5 | MOQTY | numeric | (12,4) |  |  |  |  |  | 工单数量 |
| 6 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 7 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 8 | PRIORITY | numeric | (2,0) |  |  |  |  | 0 | 优先权：工单优先权的设置内容会继承到工单开立的生产批上但开立生产批时仍然可以利用系统功能画面调整生产批的优先权设置值，优先权的设置与设备派工有关连性。 |
| 9 | PLANFINISHDATE | datetime |  |  |  |  | √ |  | 预定完成日 |
| 10 | BELONGTOMONO | nvarchar | (50) |  |  |  | √ |  | 所属工单编号 |
| 11 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | UNRELEASELOTQTY | numeric | (12,4) |  |  |  |  |  | 未下线数量 |
| 16 | MOUNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 17 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 18 | MOTYPENO | numeric | (2,0) |  |  |  |  |  | 工单类别编号：0 一般工单 1 重工工单 2 预测工单 3 委外工单 |
| 19 | MOSOURCE | numeric | (2,0) |  |  |  | √ |  | 工单来源：0：From RO(订单) 1：From RMA(退货单) 2：None(无) 3：Reference RO(参考订单) |
| 20 | ENGNO | nvarchar | (64) |  |  |  |  | 'N/A' | 工程编号 |
| 21 | ENGVERSION | nvarchar | (5) |  |  |  |  | 'N/A' | 工程版本 |
| 22 | CUSTOMERNO | nvarchar | (50) |  |  |  | √ |  | 客户编号 |
| 23 | INCOMINGKEY | nvarchar | (55) |  |  |  | √ |  | 收料Key |
| 24 | CUSTOMERLOTNO | nvarchar | (50) |  |  |  | √ |  | 客户批号 |
| 25 | COMPONENTFROMINV | numeric | (1,0) |  |  |  | √ | 0 | 组件来源_库房：-1 未定或没有组件(Component) 0 自动产生 1 库房挑片 |
| 26 | FACTORYNO | nvarchar | (20) |  |  |  |  |  | 工厂编号 |
| 27 | RETURNNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 退货单号 |
| 28 | ORGMOSTATE | numeric | (2,0) |  |  |  | √ |  | 工单原始状态 |
| 29 | MOCLOSEDATE | datetime |  |  |  |  | √ |  | 工单结案日 |
| 30 | PlanStartDate | datetime |  |  |  |  | √ |  | 预计生产日 |
| 31 | StockInLotNo | nvarchar | (50) |  |  |  | √ |  | ERP入库批号：ERP 仓储批的批号 |
| 32 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段01 |
| 33 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段02 |
| 34 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段03 |
| 35 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段04 |
| 36 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段05 |
| 37 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段06 |
| 38 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段07 |
| 39 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段08 |
| 40 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段09 |
| 41 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段10 |
| 42 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段11 |
| 43 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段12 |
| 44 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段13 |
| 45 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段14 |
| 46 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段15 |
| 47 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段16 |
| 48 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段17 |
| 49 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段18 |
| 50 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段19 |
| 51 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段20 |
| 52 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自定义字段21 |
| 53 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自定义字段22 |
| 54 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自定义字段23 |
| 55 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自定义字段24 |
| 56 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自定义字段25 |
| 57 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自定义字段26 |
| 58 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自定义字段27 |
| 59 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自定义字段28 |
| 60 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自定义字段29 |
| 61 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自定义字段30 |
| 62 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段31 |
| 63 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段32 |
| 64 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段33 |
| 65 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段34 |
| 66 | STORAGE_SPACES_NO | nvarchar | (50) |  |  |  | √ |  | 库位编号 |
| 67 | WAREHOUSE_NO | nvarchar | (50) |  |  |  | √ |  | 仓库编号 |
| 68 | ACTUALSTARTDATE | datetime |  |  |  |  | √ |  | 实际生产日 |
| 69 | ACTUALFINISHDATE | datetime |  |  |  |  | √ |  | 实际完工日 |
| 70 | ERPMOLineNo | nvarchar | (50) |  |  |  | √ |  | ERP工单生产线别 |
| 71 | PreMOState | numeric | (2,0) |  |  |  | √ |  | 前次工单状态 |
| 72 | AutoRunERPMOCloseSyncFlag | numeric | (1,0) |  |  |  | √ | 0 | 同步ERP工单结案标示 |
| 73 | PREMONO | nvarchar | (50) |  |  |  | √ |  | 上阶工单 |
| 74 | MOCLASS | nvarchar | (50) |  |  |  | √ |  | 工单阶次：可以在TBLSYSMOCLASS里自行定义，初始值 0：默认值，未维护（核准时会卡控，不要修改） 1 SMT 2 DIP 3 组测 |
| 75 | MATERIALPRE | nvarchar | (1) |  |  |  | √ |  | 是否产生备料计划：提供wms判断卡控不允许备料和申请领料同时进行 |
| 76 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 77 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 78 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 79 | PCSNOTOLOG | numeric | (2,0) |  |  |  |  | 0 | 序号封存：DEFAULT  0, 2 已封存, 1  封存中, 0  未封存(预设) |
| 80 | OSNO | nvarchar | (50) |  |  |  | √ |  | 外包单编号 |
| 1 | FilePath | nvarchar | (51) |  |  |  | √ |  | 文档路径 |
| 2 | Total | numeric | (8,0) |  |  |  | √ | 0 | 总计 |
| 3 | SuccessCount | numeric | (8,0) |  |  |  | √ | 0 | 成功数量 |
| 4 | FailedCount | numeric | (8,0) |  |  |  | √ | 0 | 失败数量 |
| 5 | BELONGMODULE | nvarchar | (51) |  |  |  | √ |  | 所属模块 |
| 6 | ImportNo | nvarchar | (51) |  |  |  | √ |  | 导入编号 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MONO | nvarchar | (51) |  |  |  | √ |  | 工单编号 |
| 2 | PRODUCTNO | nvarchar | (51) |  |  |  | √ |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (51) |  |  |  | √ |  | 产品版本 |
| 4 | MOQTY | numeric | (8,0) |  |  |  | √ |  | 工单数量 |
| 5 | UNRELEASELOTQTY | numeric | (8,0) |  |  |  | √ |  | 未下线数量 |
| 6 | FACTORYNO | nvarchar | (51) |  |  |  | √ |  | 工厂编号 |
| 7 | PLANFINISHDATE | datetime |  |  |  |  | √ |  | 预计完成日期 |
| 8 | MOTYPENO | nvarchar | (51) |  |  |  | √ |  | 工单类别编号 |
| 9 | RONO | nvarchar | (51) |  |  |  | √ |  | 订单编号 |
| 10 | ITEMNO | numeric | (8,0) |  |  |  | √ |  | 项次 |
| 11 | MOSTATE | nvarchar | (51) |  |  |  | √ |  | 工单状态 |
| 12 | ENGNO | nvarchar | (51) |  |  |  | √ |  | 工程编号 |
| 13 | ENGVERSION | nvarchar | (51) |  |  |  | √ |  | 工程版本 |
| 14 | CUSTOMERNO | nvarchar | (51) |  |  |  | √ |  | 客户编号 |
| 15 | TBLOEMOBASISIMPORTGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 16 | FailedReason | nvarchar | (2000) |  |  |  | √ |  | 失败原因 |
| 17 | LotNo | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 18 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 19 | SYSQTY | numeric | (10,4) |  |  |  | √ |  | 系统数量 |
| 20 | INPUTQTY | numeric | (8,0) |  |  |  | √ |  | 数量 |
| 21 | LOTSEQUENCE | nvarchar | (51) |  |  |  | √ |  | 生产批序号 |
| 22 | OSNO | nvarchar | (51) |  |  |  | √ |  | 外包单号 |
| 23 | DispStartTime | datetime |  |  |  |  | √ |  | 预计出货日期 |
| 24 | DispEndTime | datetime |  |  |  |  | √ |  | 预计回货日期 |
| 25 | SUBCONTRACTORNO | nvarchar | (51) |  |  |  | √ |  | 外包商编号 |
| 26 | ERPDOCType | nvarchar | (51) |  |  |  | √ |  | 入库单别 |
| 27 | S_Warehouse_No | nvarchar | (51) |  |  |  | √ |  | 库房 |
| 28 | S_Storage_Spaces_No | nvarchar | (51) |  |  |  | √ |  | 储位 |
| 29 | ImportNo | nvarchar | (51) |  |  |  | √ |  | 导入编号 |
| 30 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 31 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 32 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 33 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 34 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 35 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 36 | RETURNNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 退货单号 |
| 37 | PLANSTARTDATE | datetime |  |  |  |  | √ |  | 预计生产日 |
| 38 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段01 |
| 39 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段02 |
| 40 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段03 |
| 41 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段04 |
| 42 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段05 |
| 43 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段06 |
| 44 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段07 |
| 45 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段08 |
| 46 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段09 |
| 47 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段10 |
| 48 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段11 |
| 49 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段12 |
| 50 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段13 |
| 51 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段14 |
| 52 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段15 |
| 53 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段16 |
| 54 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段17 |
| 55 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段18 |
| 56 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段19 |
| 57 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段20 |
| 58 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自定义字段21 |
| 59 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自定义字段22 |
| 60 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自定义字段23 |
| 61 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自定义字段24 |
| 62 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自定义字段25 |
| 63 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自定义字段26 |
| 64 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自定义字段27 |
| 65 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自定义字段28 |
| 66 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自定义字段29 |
| 67 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自定义字段30 |
| 68 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段31 |
| 69 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段32 |
| 70 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段33 |
| 71 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自定义字段34 |
| 72 | WAREHOUSE_NO | nvarchar | (50) |  |  |  | √ |  | 仓库编号 |
| 73 | STORAGE_SPACES_NO | nvarchar | (50) |  |  |  | √ |  | 库位编号 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | COMPONENTNO | nvarchar | (30) | √ |  |  |  |  | 组件编号 |
| 3 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 4 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 5 | RELEASESTATE | numeric | (1,0) |  |  |  |  | 0 | 下线状态 |
| 6 | EX_MOCOMP1 | nvarchar | (50) |  |  |  | √ |  | 延伸字段1 |
| 7 | EX_MOCOMP2 | nvarchar | (50) |  |  |  | √ |  | 延伸字段2 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 2 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 3 | MATERIALLOTNO | nvarchar | (50) |  |  |  |  |  | 物料批号 |
| 4 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 5 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 6 | MATERIALLEVEL | numeric | (1,0) |  |  |  |  |  | 物料／半成品 |
| 7 | MATERIALTYPE | nvarchar | (50) |  |  |  | √ |  | 物料类别 |
| 8 | INPUTDATE | datetime |  |  |  |  | √ |  | 输入日期 |
| 9 | SUBSTITUTEMATERIALNO | nvarchar | (50) |  |  |  |  | 'N/A' | 替代料编号：N A' |
| 10 | MATERIALINNO | nvarchar | (50) |  |  |  |  | 'N/A' | 进料单编号：N A' |
| 11 | STATE | numeric | (1,0) |  |  |  |  |  | 状态：1 发料 2 发料还原 3 退料 4 退料还原 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 3 | MATERIALLEVEL | numeric | (1,0) |  |  |  | √ |  | 物料等级：0：Material(物料)。 1：Product(产品)。 |
| 4 | STDQTY | numeric | (14,6) |  |  |  | √ |  | 单位标准用量 |
| 5 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 6 | DECREASERATE | numeric | (3,2) |  |  |  |  |  | 耗损率：#103925 |
| 7 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 8 | SPECIFIED | numeric | (1,0) |  |  |  | √ | 0 | 指定：0：NO，非指定用料可使用替代料。 1：YES，指定用料不可使用替代料。 |
| 9 | PUTINPLACETYPE | numeric | (1,0) |  |  |  | √ |  | 投料点类别：2：WIP INV(Raw)，线边仓。 3：MO，工单。 4：WIP INV(SEMI)，线边仓。 5：倒扣料 |
| 10 | MOFLAG | numeric | (1,0) |  |  |  | √ | 1 | MoFlag |
| 11 | MATERIALMONO | nvarchar | (50) |  |  |  |  | 'N/A' | 物料工单编号 |
| 12 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别：定义此物料所属之类别 |
| 13 | COUNTWAY | numeric | (1,0) |  |  |  |  |  | 计量方法：计量方法包括Standard和Real两种方法 0：Standard，表示以标准用量计算物料使用量 1：Real，表示以用户输入之实际物料使用量为扣量标准 |
| 14 | CHECKLOTNO | numeric | (1,0) |  |  |  |  |  | 是否检查批号：此选项控制了库存、生产报工等作业方式： 0：False，不管控物料批号，系统将视物料批号为N A。 1：True，管控物料批号，所有之进料、退料、扣料动作都必须输入物料批号。 |
| 15 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 16 | ORGMATERIALNO | nvarchar | (50) |  |  |  | √ |  | 原始料号：目前与MaterialNo相同 |
| 17 | EX_MTLLIST1 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList1 |
| 18 | EX_MTLLIST2 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList2 |
| 19 | MATERIALVERSION | nvarchar | (5) |  |  |  | √ | 'N/A' | 版本：当生产用料为半成品时记录半成品的产品版本，物料时记录N A。 |
| 20 | ORGMATERIALQTY | numeric | (14,6) |  |  |  | √ | 0 | 原始发料数：ERP发料时，数量会累加上去，出站扣减不影响 |
| 21 | SUBSTITUTEMATERIALNO | nvarchar | (50) | √ |  |  |  |  | 替代料编号 |
| 22 | SUBSTITUTEMATERIALLEVEL | numeric | (1,0) |  |  |  | √ | 0 | 替代料等级：0：Material(物料)。 1：Product(产品)。 |
| 23 | REQUIREQTY | numeric | (16,6) |  |  |  |  | 0 | 工单数量 |
| 24 | SUBSTITUTESTDQTY | numeric | (16,6) |  |  |  |  | 0 | 替代料标准数量 |
| 25 | QPAMolecular | numeric | (20,6) |  |  |  | √ |  | QPA分子 |
| 26 | QPADenominator | numeric | (20,6) |  |  |  | √ |  | QPA分母 |
| 27 | SubstituteQPAMolecular | numeric | (20,6) |  |  |  | √ |  | 替代料QPA分子 |
| 28 | SubstituteQPADenominator | numeric | (20,6) |  |  |  | √ |  | 替代料QPA分母 |
| 29 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自定义01 |
| 30 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自定义02 |
| 31 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自定义03 |
| 32 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自定义04 |
| 33 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自定义05 |
| 34 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自定义06 |
| 35 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自定义07 |
| 36 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自定义08 |
| 37 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自定义09 |
| 38 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自定义10 |
| 39 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自定义11 |
| 40 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自定义12 |
| 41 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自定义13 |
| 42 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自定义14 |
| 43 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自定义15 |
| 44 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自定义16 |
| 45 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自定义17 |
| 46 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自定义18 |
| 47 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自定义19 |
| 48 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自定义20 |
| 49 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自定义21 |
| 50 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自定义22 |
| 51 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自定义23 |
| 52 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自定义24 |
| 53 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自定义25 |
| 54 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自定义26 |
| 55 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自定义27 |
| 56 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自定义28 |
| 57 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自定义29 |
| 58 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自定义30 |
| 59 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自定义31 |
| 60 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自定义32 |
| 61 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自定义33 |
| 62 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自定义34 |
| 63 | DICIMALDIGIT | numeric | (5,0) |  |  |  |  | -1 | 小数位数：20200204 add by Dustdusk IMES用的, 算用料的小数位数 |
| 64 | PositionNo | nvarchar | (50) | √ |  |  |  | 'N/A' | 工位编号 |
| 65 | MTLSyncMode | numeric | (2,0) |  |  |  | √ | 1 | 叫料模式：1：手动,   2：自动 |
| 66 | MINStockQTY | numeric | (14,6) |  |  |  | √ |  | 最低存量 |
| 67 | SOURCEOFINFO | numeric | (2,0) |  |  |  |  | 0 | 数据来源：0：预设,  1：调整,  2：添加 |
| 68 | REQUIREQTY_Used | numeric | (16,6) |  |  |  |  | 0 | 物料已经使用量：只有出站倒扣料会累加，用于跟RequireQTY做比对，确认倒扣料已经使用量，来决定出站时要预显的使用量 |
| 69 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 70 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 71 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 72 | TBLOEMOBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | KeyMaterials | numeric | (1,0) |  |  |  | √ |  | 是否为关键用料 |
| 2 | ReceiveDate | datetime |  |  |  |  |  |  | 接收日期：ERP每次抛传所记录的日期 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 5 | MATERIALLEVEL | numeric | (1,0) |  |  |  | √ |  | 物料等级：0：Material(物料)。 1：Product(产品)。 |
| 6 | STDQTY | numeric | (14,6) |  |  |  | √ |  | 单位标准用量 |
| 7 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 8 | DECREASERATE | numeric | (3,2) |  |  |  | √ |  | 耗损率 |
| 9 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 10 | SPECIFIED | numeric | (1,0) |  |  |  | √ | 0 | 指定：0：NO，非指定用料可使用替代料。 1：YES，指定用料不可使用替代料。 |
| 11 | PUTINPLACETYPE | numeric | (2,0) |  |  |  | √ |  | 投料点类别：2：WIP INV(Raw)，线边仓。 3：MO，工单。 4：WIP INV(SEMI)，线边仓。 5：倒扣料 |
| 12 | MOFLAG | numeric | (1,0) |  |  |  | √ | 1 | MoFlag |
| 13 | MATERIALMONO | nvarchar | (50) |  |  |  |  |  | 物料工单编号 |
| 14 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 15 | COUNTWAY | numeric | (1,0) |  |  |  |  |  | 计量方法：0：Standard，标准用量，即以标准用量计算物料使用量。 1：Real，实际用量，即以用户输入的实际物料使用量为扣量标准。 2：Average，平均用量，即以批量作基准平摊物料使用量，此选项必须搭配客制企业逻辑才可达成，非标准系统功能。 |
| 16 | CHECKLOTNO | numeric | (1,0) |  |  |  |  |  | 是否检查批号：0：False，不管控物料批号，系统将视物料批号为N A。 1：True，管控物料料号，扣料时必须输入物料批号。 |
| 17 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 18 | ORGMATERIALNO | nvarchar | (50) |  |  |  | √ |  | 原始料号 |
| 19 | EX_MTLLIST1 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList1 |
| 20 | EX_MTLLIST2 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList2 |
| 21 | MATERIALVERSION | nvarchar | (5) |  |  |  | √ |  | 版本：当生产用料为半成品时记录半成品的产品版本，物料时记录N A。 |
| 22 | ORGMATERIALQTY | numeric | (14,6) |  |  |  | √ | 0 | 原始发料数 |
| 23 | SUBSTITUTEMATERIALNO | nvarchar | (50) |  |  |  |  | 'N/A' | 替代料编号 |
| 24 | SUBSTITUTEMATERIALLEVEL | numeric | (1,0) |  |  |  | √ | 0 | 替代料等级：0：Material(物料)。 1：Product(产品)。 |
| 25 | REQUIREQTY | numeric | (16,6) |  |  |  |  | 0 | 需求数 |
| 26 | SUBSTITUTESTDQTY | numeric | (16,6) |  |  |  |  | 0 | 替代料标准数量 |
| 27 | QPAMolecular | numeric | (20,6) |  |  |  | √ |  | QPA分子 |
| 28 | QPADenominator | numeric | (20,6) |  |  |  | √ |  | QPA分母 |
| 29 | SubstituteQPAMolecular | numeric | (20,6) |  |  |  | √ |  | 替代料QPA分子 |
| 30 | SubstituteQPADenominator | numeric | (20,6) |  |  |  | √ |  | 替代料QPA分母 |
| 31 | DICIMALDIGIT | numeric | (5,0) |  |  |  |  | -1 | 小数位数：20200204 add by Dustdusk IMES用的, 算用料的小数位数 |
| 32 | PositionNo | nvarchar | (50) |  |  |  |  | 'N/A' | 工位编号 |
| 33 | MTLSyncMode | numeric | (2,0) |  |  |  | √ | 1 | 叫料模式：1：手动,   2：自动 |
| 34 | MINStockQTY | numeric | (14,6) |  |  |  | √ |  | 最低存量 |
| 35 | SOURCEOFINFO | numeric | (2,0) |  |  |  |  | 0 | 资料来源：0：预设,  1：调整,  2：添加 |
| 36 | REQUIREQTY_Used | numeric | (16,6) |  |  |  |  | 0 | OE.TBLOEMOMATERIALLIST_ERP.Column.REQUIREQTY_USED.displayText |
| 37 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自定义01 |
| 38 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自定义02 |
| 39 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自定义03 |
| 40 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自定义04 |
| 41 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自定义05 |
| 42 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自定义06 |
| 43 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自定义07 |
| 44 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自定义08 |
| 45 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自定义09 |
| 46 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自定义10 |
| 47 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自定义11 |
| 48 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自定义12 |
| 49 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自定义13 |
| 50 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自定义14 |
| 51 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自定义15 |
| 52 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自定义16 |
| 53 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自定义17 |
| 54 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自定义18 |
| 55 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自定义19 |
| 56 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自定义20 |
| 57 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自定义21 |
| 58 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自定义22 |
| 59 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自定义23 |
| 60 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自定义24 |
| 61 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自定义25 |
| 62 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自定义26 |
| 63 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自定义27 |
| 64 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自定义28 |
| 65 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自定义29 |
| 66 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自定义30 |
| 67 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自定义31 |
| 68 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自定义32 |
| 69 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自定义33 |
| 70 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自定义34 |
| 71 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 72 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 73 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
