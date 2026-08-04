# 03 SMT产线 (SMT/SMDPD)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 40 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblSMDPDLinePositionBasis](#tblsmdpdlinepositionbasis) | 工位基本数据表 | 40 |
| [tblSMTAreaBasis](#tblsmtareabasis) | SMT区域主档 | 12 |
| [tblSMTAreaEQP](#tblsmtareaeqp) | SMT设备现况（区域对应加工序） | 26 |
| [tblSMTAreaOnWork](#tblsmtareaonwork) | SMT区域上线状况 | 13 |
| [tblSMTAreaOnWorkDetail](#tblsmtareaonworkdetail) | SMT区域上线状况明细 | 16 |
| [tblSMTCMList](#tblsmtcmlist) | 点检维护表主档 | 12 |
| [tblSMTCMListDetail](#tblsmtcmlistdetail) | 点检维护表明细档 | 19 |
| [tblSMTCMListTool](#tblsmtcmlisttool) | 点检维护表对应工具 | 12 |
| [tblSMTCMResult](#tblsmtcmresult) | 工具点检维护结果 | 9 |
| [tblSMTCMResultDetail](#tblsmtcmresultdetail) | 工具点检维护结果明细 | 111 |
| [tblSMTEQPCheckProduct](#tblsmteqpcheckproduct) | 产品设备开机条件主档 | 12 |
| [tblSMTEQPCheckProductTool](#tblsmteqpcheckproducttool) | 设备开机条件明细档(设定需求工具) | 14 |
| [tblSMTEQPResource](#tblsmteqpresource) | 设备资源履历号 | 10 |
| [tblSMTEQPResourceDetail](#tblsmteqpresourcedetail) | 设备资源履历明细 | 14 |
| [tblSMTEQPSlot](#tblsmteqpslot) | 设备料站主档 | 17 |
| [tblSMTFeederBasis](#tblsmtfeederbasis) | Feeder主档 | 25 |
| [tblSMTFeederList](#tblsmtfeederlist) | 料站表主档 | 15 |
| [tblSMTFeederListEQP](#tblsmtfeederlisteqp) | 料站表对应设备 | 12 |
| [tblSMTFeederListEQPMat](#tblsmtfeederlisteqpmat) | 设备料站表明细档 | 18 |
| [tblSMTFeederListEQPMatS](#tblsmtfeederlisteqpmats) | 替代物料维护 | 26 |
| [tblSMTFeederType](#tblsmtfeedertype) | Feeder型号主档 | 14 |
| [tblSMTFeederTypeEQP](#tblsmtfeedertypeeqp) | Feeder型号对应设备 | 101 |
| [tblSMTMaintainBasis](#tblsmtmaintainbasis) | SMT维修单 | 27 |
| [tblSMTMaintainParts](#tblsmtmaintainparts) | SMT维修更换零件明细 | 15 |
| [tblSMTMaintainReason](#tblsmtmaintainreason) | SMT维修单原因明细 | 15 |
| [tblSMTMaterialChangeLog](#tblsmtmaterialchangelog) | 物料更换记录 | 20 |
| [tblSMTMFUBasis](#tblsmtmfubasis) | 台车主档 | 25 |
| [tblSMTMFUType](#tblsmtmfutype) | 台车型号主档 | 14 |
| [tblSMTMFUTypeEQP](#tblsmtmfutypeeqp) | 台车类别对应设备类别 | 360 |
| [tblSMTProcessBasis](#tblsmtprocessbasis) | SMT产品工序主档 | 15 |
| [tblSMTProcessDetail](#tblsmtprocessdetail) | SMT工序明细 | 68 |
| [tblSMTProductPostInLog](#tblsmtproductpostinlog) | 产品序号投入纪录档 | 18 |
| [tblSMTProductPostOutLog](#tblsmtproductpostoutlog) | 产品序号产出纪录档 | 42 |
| [tblSMTReasons](#tblsmtreasons) | 异常原因主档(工具、产品) | 25 |
| [tblSMTReelBasis](#tblsmtreelbasis) | 卷料主档 | 89 |
| [tblSMTResourceActionLog](#tblsmtresourceactionlog) | 资源动作纪录档 | 20 |
| [tblSMTResourceStateLog](#tblsmtresourcestatelog) | 资源状态记录(共享) | 18 |
| [tblSMTSlotAreaBasis](#tblsmtslotareabasis) | 料站区域主档 | 10 |
| [tblSMTToolBasis](#tblsmttoolbasis) | 工具主档 | 36 |
| [tblSMTToolType](#tblsmttooltype) | 工具型号主档 | 337 |

---

### tblSMDPDLinePositionBasis — 工位基本数据表（40 字段）
> 主键：PDLineNo, PositionNo, PDLINENO, POSITIONNO, SKILLNO, BASEAREANO, AREANO, EQUIPMENTNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PDLineNo | nvarchar | (50) | √ |  |  |  |  | 生产线别编号：区域编号 |
| 2 | PositionNo | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 3 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | SUBOPSEQUENCE | numeric | (4,0) |  |  |  |  | 0 | 工序次序 |
| 7 | QC_TEST | numeric | (1,0) |  |  |  | √ | 0 | 是否发送SPC |
| 8 | DEFAULTUSER | nvarchar | (30) |  |  |  | √ |  | 预设发起人员 |
| 9 | SKILLNO | nvarchar | (20) |  |  |  | √ |  | 技能编号 |
| 10 | GRADENO | nvarchar | (20) |  |  |  | √ |  | 等级编号 |
| 11 | AllowDuplicatePCSNo | numeric | (2,0) |  |  |  |  | 0 | 允许重复过帐 |
| 12 | NGCount | numeric | (2,0) |  |  |  |  | 1 | 工位设定的NG 次数：SMT使用 预设NG次数，系统自动完成送修 |
| 13 | ISINTEGRATEPASS | numeric | (2,0) |  |  |  |  | 0 | 集成MES自动过站：SMT使用 20210508 增加 启用时，不允许在工位机进行人工过站 |
| 14 | ISRETURNSEQ | numeric | (2,0) |  |  |  |  | 0 | 返工工序：SMT使用 20210623增加 启用时，判断当前工位是否为返工工位 |
| 15 | DUPLICATECOUNT | numeric | (4,0) |  |  |  |  | 0 | 允许重复过帐次数：SMT使用 20210915增加 0表示不限制 |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线别编号 |
| 2 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 3 | SKILLNO | nvarchar | (20) | √ |  |  |  |  | 技能编号 |
| 4 | GRADENO | nvarchar | (20) |  |  |  |  |  | 技能等级 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLSMDPDLINEPOSITIONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | BASEAREANO | nvarchar | (50) | √ |  |  |  |  | 基底区域 |
| 2 | AREANO | nvarchar | (50) | √ |  |  |  |  | 区域 |
| 3 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备代号 |
| 4 | EQPSEQUENCE | numeric | (11,0) |  |  |  | √ |  | 机台配置次序 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTAreaBasis — SMT区域主档（12 字段）
> 主键：AreaNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AreaNo | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 2 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 3 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 4 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 5 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 6 | SMTAreaType | numeric | (2,0) |  |  |  |  | 1 | SMT产线别：0  未指定 1 SMT线 2 测试线 3 DIP线 4 组装线 5 包装线 |
| 7 | SMTCheckOutControl | numeric | (2,0) |  |  |  | √ | 0 | SMT出站控卡：0 不控卡 1 整批出站 |
| 8 | AUTOPASS | numeric | (2,0) |  |  |  |  | 0 | SMT.TBLSMTAREABASIS.Column.AUTOPASS.displayText |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTAreaEQP — SMT设备现况（区域对应加工序）（26 字段）
> 主键：AreaNo, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AreaNo | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 2 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | Seq | numeric | (2,0) |  |  |  |  |  | 加工序：整数 |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 加工说明 |
| 5 | IsPlacementMachine | numeric | (1,0) |  |  |  |  | 0 | 是否为贴片机：0 No 1 Yes |
| 6 | TimeLimit | nvarchar | (5) |  |  |  | √ |  | 加工时间限制：格式固定为HH MM |
| 7 | ResourceState | nvarchar | (4) |  |  |  |  |  | 资源状态：90 SMT_IDLE;闲置，40 SMT_FEEDED;已上料 |
| 8 | LOTNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：若已上线，应有生产批号 |
| 9 | FeederListNo | nvarchar | (50) |  |  |  | √ |  | 料站表编号：若已上线，需记录料站表编号版号 |
| 10 | FeederListVer | nvarchar | (50) |  |  |  | √ |  | 料站表版号：若已上线，需记录料站表编号版号 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 15 | NeedPosting | numeric | (2,0) |  |  |  |  | 1 | 是否需要过帐：0：不需要 1：需要 |
| 16 | PostingSourceType | numeric | (2,0) |  |  |  |  | 1 | 过帐来源：1：PanelNo 2：PCSNo |
| 17 | AllowDuplicatePosting | numeric | (2,0) |  |  |  |  | 0 | 是否可重复过帐：0：不可 1：可 |
| 18 | IsPNSNCombineOP | numeric | (2,0) |  |  |  |  | 0 | 是否板号序号绑定站：0：否 1：是 |
| 19 | AllowOtherSNPosting | numeric | (2,0) |  |  |  |  | 0 | 是否启用过帐次序号：0：否 1：是 |
| 20 | PostingSourceUnit | numeric | (2,0) |  |  |  | √ |  | 过账单位：1：PanelNo 2：PCSNo |
| 21 | OperatingStationAttributes | numeric | (2,0) |  |  |  | √ |  | 作业站属性：用于SMT过站操作界面的判断： 1-- 一般作业站 2-- 印锡作业站 3-- 贴片作业站 4-- 检测作业站 |
| 22 | AutoPass | numeric | (2,0) |  |  |  |  | 0 | 自动过帐：0：否 1：是 |
| 23 | COMBINESNNUMBER | numeric | (2,0) |  |  |  |  | 0 | 是否需要绑定第多个序号：0：不需要 1~99：需额外绑定SN数 |
| 24 | NGREPAIR | numeric | (2,0) |  |  |  |  | 0 | NG是否送修：0：否  1：是 |
| 25 | BUCKLESEQ | numeric | (1,0) |  |  |  | √ |  | 扣料点工序：0：否，1：是 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTAreaOnWork — SMT区域上线状况（13 字段）
> 主键：AreaNo, LOTNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AreaNo | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 2 | LOTNo | nvarchar | (50) | √ |  |  |  |  | 生产批号：若已上线，应有生产批号 |
| 3 | FeederListNo | nvarchar | (50) |  |  |  | √ |  | 料站表编号：若已上线，需记录料站表编号版号 |
| 4 | FeederListVer | nvarchar | (50) |  |  |  | √ |  | 料站表版号：若已上线，需记录料站表编号版号 |
| 5 | OnWorkStatus | numeric | (1,0) |  |  |  | √ | 0 | 上线状态：0 未上线 1 部分上线 2 产在线所有设备开线所需资源都已上线完成（SMT方案包用） |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTAreaOnWorkDetail — SMT区域上线状况明细（16 字段）
> 主键：AreaNo, LOTNo, Seq, EquipmentNo, ResourceClass
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | AreaNo | nvarchar | (20) | √ |  |  |  |  | 区域编号：区域编号 |
| 2 | LOTNo | nvarchar | (50) | √ |  |  |  |  | 生产批号：上线生产批号 |
| 3 | Seq | numeric | (10,0) | √ |  |  |  |  | 序号：明细序号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | ResourceClass | numeric | (10,0) | √ |  |  |  |  | 需求资源类别：0        SMT_SOLDER_PASTE        锡膏 1        SMT_STENCILS        网板 2        SMT_SQUEEGEE        刮刀 3        SMT_ADHESIVE        红胶 4        SMT_OTHER        其他 8        SMT_SLOT          料站 |
| 6 | ResourceType | nvarchar | (50) |  |  |  | √ |  | 需求资源型号 料站号：ResourceClass=8(料站)时此值为料站编号，其他则为工具型号 |
| 7 | ResourceQty | numeric | (10,0) |  |  |  | √ |  | 需求数量：ResourceClass=8(料站)时此处记录单位用量，其他工具则记录工具需用量 |
| 8 | OnWorkQty | numeric | (10,0) |  |  |  | √ |  | 上线数量：已上线数量 |
| 9 | OnWorkStatus | numeric | (1,0) |  |  |  | √ |  | 上线状态：0 未上线 1 部分上线 2 已全部上线  ResourceClass=8(料站)时只要有物料上线就算已全部上线，其他工具若上线数量 需求数量则属于部分上线 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTCMList — 点检维护表主档（12 字段）
> 主键：CMListNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CMListNo | nvarchar | (100) | √ |  |  |  |  | 检核表编号 |
| 2 | CMListType | nvarchar | (1) |  |  |  |  | 'C' | 检核表类型：1 SMT_CKECKLIST;检测表 2 SMT_MAINTAINANCE_ORDER;保养表 |
| 3 | QCListName | nvarchar | (100) |  |  |  |  |  | 检核表名称 |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTCMListDetail — 点检维护表明细档（19 字段）
> 主键：CMListNo, CMItem
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CMListNo | nvarchar | (100) | √ |  |  |  |  | 检核表编号 |
| 2 | CMListType | nvarchar | (1) |  |  |  |  | 'C' | 表类型：1 SMT_CKECKLIST;检测表 2 SMT_MAINTAINANCE_ORDER;保养表 |
| 3 | CMOrder | numeric | (2,0) |  |  |  |  | 1 | 检核次序 |
| 4 | CMItem | nvarchar | (1000) | √ |  |  |  |  | 检核项目 |
| 5 | CMType | numeric | (1,0) |  |  |  |  |  | 检核方式：点检数据输入类型 0：Value (标准值) 1：数字Range (范围) 2： ON OFF (显示讯息) 3： 文本 InputData (输入数据) |
| 6 | STDValue | nvarchar | (12) |  |  |  | √ |  | 标准数量 |
| 7 | MaxValue | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 8 | MinValue | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 9 | InputDataCount | numeric | (2,0) |  |  |  | √ |  | 输入个数 |
| 10 | InspectionMethod | nvarchar | (100) |  |  |  | √ |  | 检查方法：20191004 remove |
| 11 | InspectionStandards | nvarchar | (100) |  |  |  | √ |  | 检查标准 |
| 12 | SOPFile | nvarchar | (255) |  |  |  | √ |  | SOP档名：20191004 add |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 16 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTCMListTool — 点检维护表对应工具（12 字段）
> 主键：CMListNo, ToolTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CMListNo | nvarchar | (100) | √ |  |  |  |  | 检核表编号 |
| 2 | CMListType | nvarchar | (1) |  |  |  | √ |  | 检核表类型：1C SMT_CKECKLIST;检测表2M SMT_MAINTAINANCE_ORDER;保养表 |
| 3 | ToolTypeNo | nvarchar | (50) | √ |  |  |  |  | 工具型号 |
| 4 | ToolClass | nvarchar | (1) |  |  |  |  | 'P' | 工具分类：工具分类：下拉选项，0 SMT_SOLDER_PASTE;锡膏、1 SMT_STENCILS;网板、2 SMT_SQUEEGEE;刮刀、3 SMT_ADHESIVE;红胶、4 SMT_OTHER;其他、5 SMT_FEEDER;飞达、6 SMT_MFU;台车 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTCMResult — 工具点检维护结果（9 字段）
> 主键：GUID, ToolTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | ToolNo | nvarchar | (50) |  |  |  |  |  | 工具编号 |
| 3 | CMListType | nvarchar | (1) |  |  |  | √ |  | SMT.TBLSMTCMRESULT.Column.CMLISTTYPE.displayText： 1 SMT_CKECKLIST;检测表 2 SMT_MAINTAINANCE_ORDER;保养表 C SMT_CKECKLIST;检测表 M SMT_MAINTAINANCE_ORDER;保养表 |
| 4 | ToolTypeNo | nvarchar | (50) | √ |  |  |  |  | 工具型号 |
| 5 | ToolClass | nvarchar | (1) |  |  |  |  | 'P' | 工具分类：工具分类：下拉选项，0 SMT_SOLDER_PASTE;锡膏、1 SMT_STENCILS;网板、2 SMT_SQUEEGEE;刮刀、3 SMT_ADHESIVE;红胶、4 SMT_OTHER;其他、 5 SMT_FEEDER;飞达、 6 SMT_MFU;台车 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |

---

### tblSMTCMResultDetail — 工具点检维护结果明细（111 字段）
> 主键：GUID, CMOrder, SID, SID, SEQ, SID, SEQ, SID, THICKNESS, TEMPERATURE, MSDLEVEL, MSDLEVEL, OPENTIME
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | CMOrder | numeric | (2,0) | √ |  |  |  | 1 | 检核次序 |
| 3 | CMItem | nvarchar | (1000) |  |  |  |  |  | 检核项目 |
| 4 | CMType | numeric | (1,0) |  |  |  |  |  | 检核方式：点检数据输入类型0：Value (标准值)1：数字Range (范围) 2： ON OFF (显示讯息) 3： 文本 InputData (输入数据) |
| 5 | STDValue | nvarchar | (12) |  |  |  | √ |  | 标准数量 |
| 6 | MaxValue | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 7 | MinValue | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 8 | InspectionStandards | nvarchar | (100) |  |  |  | √ |  | 检查标准 |
| 9 | InputValue | nvarchar | (50) |  |  |  | √ |  | 输入值：检核方式=1填数值，=2为0(off) 1(on)，=3为文本 |
| 10 | IsOK | numeric | (1,0) |  |  |  | √ |  | 输入验证结果：0  NG 1 OK （输入值判断的结果） |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码 |
| 2 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 3 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | 生产历进程号 |
| 4 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批编号 |
| 5 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 6 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 7 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 8 | ReworkSMTOPSeq | numeric | (4,0) |  |  |  | √ |  | 返工工序 |
| 9 | ReworkCount | nvarchar | (2) |  |  |  | √ | '0' | 返工次数 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 12 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 14 | UnitedSizes | numeric | (4,0) |  |  |  | √ |  | 连板数 |
| 15 | PCBREELNO | nvarchar | (50) |  |  |  |  | 'N/A' | PCB板批号 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码 |
| 2 | SEQ | nvarchar | (1) | √ |  |  |  |  | 流水号 |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批编号 |
| 4 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 5 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 6 | MappingNo | nvarchar | (50) |  |  |  | √ |  | 关联序号 |
| 7 | MappingType | nvarchar | (1) |  |  |  | √ |  | 关联类别：0 板号 1 产品序号 2 MAC 3 载具编号 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 10 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 11 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码 |
| 2 | SEQ | nvarchar | (1) | √ |  |  |  |  | 流水号 |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批编号 |
| 4 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 5 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 6 | MappingNo | nvarchar | (50) |  |  |  | √ |  | 关联序号 |
| 7 | MappingType | nvarchar | (1) |  |  |  | √ |  | 关联类别：0 板号 1 产品序号 2 MAC 3 载具编号 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 10 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 11 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码 |
| 2 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 3 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号 |
| 4 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批编号 |
| 5 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 6 | FileName | nvarchar | (50) |  |  |  | √ |  | 文档名称 |
| 7 | FileDate | datetime |  |  |  |  | √ |  | 档案日期时间 |
| 8 | TestDate | datetime |  |  |  |  | √ |  | 测试日期时间 |
| 9 | ResultCode | numeric | (1,0) |  |  |  | √ |  | 判断结果：0 NG 1 PASS |
| 10 | ErrorMsg | nvarchar | (500) |  |  |  | √ |  | 错误讯息 |
| 11 | ErrorFlag | numeric | (1,0) |  |  |  | √ |  | 错误码：0 无错误 1 解析错误 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | THICKNESS | numeric | (1,0) | √ |  |  |  |  | 物料组件器本体厚度层级 |
| 2 | TEMPERATURE | numeric | (3,0) | √ |  |  |  |  | 烘烤温度 |
| 3 | MSDLEVEL | nvarchar | (2) | √ |  |  |  |  | MSD等级 |
| 4 | TIME1 | numeric | (4,0) |  |  |  |  |  | 烘烤时间1（小时） |
| 5 | TIME2 | numeric | (4,0) |  |  |  |  |  | 烘烤时间2（小时） |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MNFPARTNO | nvarchar | (64) |  |  |  | √ | '*' | 制造商料号：默认为“ ” |
| 2 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料料号 |
| 3 | OPENTIME | numeric | (6,0) |  |  |  | √ |  | 开封底时间（分钟） |
| 4 | NUMDRYING | numeric | (1,0) |  |  |  | √ |  | 烘烤次数 |
| 5 | TIMEINOVEN | numeric | (6,0) |  |  |  | √ |  | 烘烤时间（分钟） |
| 6 | MSDLEVEL | nvarchar | (2) |  |  |  | √ |  | MSD等级 |
| 7 | THICKNESS | numeric | (1,0) |  |  |  | √ |  | 物料组件器本体厚度层级：1：小于1.4mm； 2 1.4mm~2.0mm之间 3 2.0mm~4.5mm 4：BGA大于17×17mm |
| 8 | DRYTEMP | numeric | (3,0) |  |  |  | √ |  | 烘烤温度 |
| 9 | PRIORITY | nvarchar | (50) |  |  |  | √ |  | 优先级 |
| 10 | MATERIALTYPE | nvarchar | (50) |  |  |  |  | 'N/A' | 物料类别 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MSDLEVEL | nvarchar | (2) | √ |  |  |  |  | MSD等级 |
| 2 | OPENTIME | nvarchar | (10) | √ |  |  |  |  | 开封时间 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTEQPCheckProduct — 产品设备开机条件主档（12 字段）
> 主键：EquipmentNo, ProductNo, ProductVer
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | ProductNo | nvarchar | (50) | √ |  |  |  | 'All' | 产品编号：ALL表示不分产品 |
| 3 | ProductVer | nvarchar | (5) | √ |  |  |  |  | 产品版本： 表示所有版本（产品编号为ALL时此值限制为 ） |
| 4 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTEQPCheckProductTool — 设备开机条件明细档(设定需求工具)（14 字段）
> 主键：EquipmentNo, ProductNo, ProductVer, ToolTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | ProductNo | nvarchar | (50) | √ |  |  |  | 'All' | 产品编号：ALL表示不分产品 |
| 3 | ProductVer | nvarchar | (5) | √ |  |  |  |  | 产品版本： 表示所有版本（产品编号为ALL时此值限制为 ） |
| 4 | ToolTypeNo | nvarchar | (50) | √ |  |  |  |  | 工具型号 |
| 5 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 6 | ToolQty | numeric | (10,0) |  |  |  |  | 0 | 需求数量：0表示不限制 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTEQPResource — 设备资源履历号（10 字段）
> 主键：GUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | FeederListNo | nvarchar | (50) |  |  |  | √ |  | 料站表编号：上料料站表编号 |
| 4 | FeederListVer | nvarchar | (5) |  |  |  | √ |  | 料站表版号：上料料站表版本 |
| 5 | CreateReason | nvarchar | (50) |  |  |  | √ |  | 履历生成原因 |
| 6 | IsCurrent | numeric | (1,0) |  |  |  | √ |  | 是否现况：0 No 1 Yes 一个设备应在此表中应至多有一笔为Y，若为0笔表示目前设备为未上料（或已下料未上料情况） |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |

---

### tblSMTEQPResourceDetail — 设备资源履历明细（14 字段）
> 主键：GUID, ResourceNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | ResourceNo | nvarchar | (50) | √ |  |  |  |  | 资源编号：台车、工具、卷料编号 |
| 3 | Qty | numeric | (16,6) |  |  |  | √ |  | 标准用量 |
| 4 | ResourceTypeNo | nvarchar | (50) |  |  |  | √ |  | 资源型号：记录台车或工具的型号 |
| 5 | ResourceClass | nvarchar | (1) |  |  |  |  |  | 资源分类：0 SMT_SOLDER_PASTE;锡膏 1 SMT_STENCILS;网板 2 SMT_SQUEEGEE;刮刀 3 SMT_ADHESIVE;红胶 4 SMT_OTHER;其他 5 SMT_FEEDER;Feeder 6 SMT_MFU;台车 R SMT_REEL;Reel |
| 6 | MaterialNo | nvarchar | (50) |  |  |  | √ |  | 物料编号：资源分类为R卷料时，在此记录物料编号 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | SLOTNO | nvarchar | (50) |  |  |  | √ |  | 料站编号：资源分类为R卷料时，在此记录物料编号 |
| 12 | PANELSIDE | numeric | (1,0) |  |  |  | √ |  | 板面 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |

---

### tblSMTEQPSlot — 设备料站主档（17 字段）
> 主键：EquipmentNo, SlotNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | SlotNo | nvarchar | (50) | √ |  |  |  |  | 料站编号 |
| 3 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 4 | SlotAreaNo | nvarchar | (50) |  |  |  | √ |  | 料站区域编号 |
| 5 | ResourceState | nvarchar | (4) |  |  |  | √ |  | 资源状态：0 SMT_IN_INV;在库、60 SMT_ON-WORK;已上线 |
| 6 | StateStartTime | datetime |  |  |  |  | √ |  | 状态开始时间：目前状态开始时间 |
| 7 | FeederListNo | nvarchar | (50) |  |  |  | √ |  | 料站表编号：若已上料，需记录料站表编号版号 |
| 8 | FeederListVer | nvarchar | (50) |  |  |  | √ |  | 料站表版号：若已上料，需记录料站表编号版号 |
| 9 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：若已上线记录生产批号 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTFeederBasis — Feeder主档（25 字段）
> 主键：FeederNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederNo | nvarchar | (50) | √ |  |  |  |  | Feeder编号 |
| 2 | FeederTypeNo | nvarchar | (50) |  |  |  | √ |  | Feeder型号 |
| 3 | CountType | nvarchar | (1) |  |  |  |  | 'C' | 计算方式：0 (C)过帐次数、1 (T)上线时间、2 (I)设备集成 |
| 4 | LifeCount | numeric | (10,1) |  |  |  | √ | 999999 | 寿命上限：寿命用罄不可使用，计算方式为时间时纪录总小时数(小数1位) |
| 5 | UsageCount | numeric | (10,1) |  |  |  | √ | 999999 | 使用上限：使用上限到需保养，计算方式为时间时纪录总小时数(小数1位) |
| 6 | WarningCount | numeric | (10,0) |  |  |  | √ | 95 | 警示上限(%)：整数值 |
| 7 | ActualCount | numeric | (10,5) |  |  |  | √ | 0 | 目前使用：维修后累积使用量，计算方式为时间时纪录总小时数(小数一位) |
| 8 | AccCount | numeric | (10,5) |  |  |  | √ | 0 | 累积使用：目前累积使用量，计算方式为时间时纪录总小时数 |
| 9 | ResourceState | nvarchar | (4) |  |  |  |  |  | 资源状态：0 SMT_IN_INV;在库 40 SMT_MAT_MOUNT;已上料 50 SMT_MFU_MOUNT;已上台车 60 SMT_ON_WORK;已上线 70 SMT_REPAIRE;维修 80 SMT_SCRAP;报废 |
| 10 | StateStartTime | datetime |  |  |  |  | √ |  | 状态开始时间：目前状态开始时间 |
| 11 | ResourceLocation | nvarchar | (50) |  |  |  | √ |  | 资源所在位置：目前该资源所在位置，若是先放在台车上，纪录台车编号，若直接上设备就纪录设备编号 |
| 12 | ResourceMode | nvarchar | (1) |  |  |  | √ |  | 资源模式：资源所在位置是   E 设备 M 台车 |
| 13 | MaterialNo | nvarchar | (50) |  |  |  | √ |  | 物料品号：已上的物料编号 |
| 14 | ReelNo | nvarchar | (50) |  |  |  | √ |  | 卷料编号：已上的卷料编号 |
| 15 | SlotNo | nvarchar | (50) |  |  |  | √ |  | 料站编号：已上料站编号(可能是设备或台车) |
| 16 | Invalid | numeric | (1,0) |  |  |  | √ | 0 | 作废：0 可用 1 报废 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 20 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 21 | PanelSide | numeric | (1,0) |  |  |  |  | 0 | 皮肤位置(板面)：1：正板，2：背板(板面) |
| 22 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTFeederList — 料站表主档（15 字段）
> 主键：FeederListNo, FeederListVer
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederListNo | nvarchar | (50) | √ |  |  |  |  | 料站表编号 |
| 2 | FeederListVer | nvarchar | (5) | √ |  |  |  |  | 料站表版号 |
| 3 | ProductNo | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 4 | ProductVer | nvarchar | (5) |  |  |  | √ |  | 产品版本 |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 料站表说明 |
| 6 | Invalid | numeric | (1,0) |  |  |  | √ | 0 | 作废：0 未作废 1 已作废 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | PROGRAMNO | nvarchar | (50) |  |  |  | √ |  | 进程编号：博泰客制，存设备发过来json里的FeederListVer，用于抛料接口关联FeederListNo |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTFeederListEQP — 料站表对应设备（12 字段）
> 主键：FeederListNo, FeederListVer, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederListNo | nvarchar | (50) | √ |  |  |  |  | 料站表编号 |
| 2 | FeederListVer | nvarchar | (50) | √ |  |  |  |  | 料站表版号 |
| 3 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 4 | AreaNo | nvarchar | (50) |  |  |  |  |  | 区域编号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTFeederListEQPMat — 设备料站表明细档（18 字段）
> 主键：FeederListNo, FeederListVer, EquipmentNo, SlotNo, MaterialNo, PanelSide
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederListNo | nvarchar | (50) | √ |  |  |  |  | 料站表编号 |
| 2 | FeederListVer | nvarchar | (50) | √ |  |  |  |  | 料站表版号 |
| 3 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 4 | SlotNo | nvarchar | (50) | √ |  |  |  |  | 料站口编号 |
| 5 | MaterialNo | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 6 | AreaNo | nvarchar | (50) |  |  |  |  |  | 区域编号 |
| 7 | UseQty | numeric | (10,0) |  |  |  | √ | 1 | 单位用量 |
| 8 | HaveSubstitute | numeric | (1,0) |  |  |  | √ | 0 | 有替代料否：1 有 0 没有 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 13 | PanelSide | numeric | (1,0) | √ |  |  |  | 1 | 皮肤位置：1：正板，2：背板 |
| 14 | POSITION | nvarchar | (256) |  |  |  | √ |  | PCB板上Ref位置 |
| 15 | REPAIR | numeric | (1,0) |  |  |  | √ |  | SMT.TBLSMTFEEDERLISTEQPMAT.Column.REPAIR.displayText：0 不可 1  可 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTFeederListEQPMatS — 替代物料维护（26 字段）
> 主键：FeederListNo, FeederListVer, EquipmentNo, SlotNo, SMaterialNo, FEEDERNO, EVENTTIME
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederListNo | nvarchar | (50) | √ |  |  |  |  | 料站表编号 |
| 2 | FeederListVer | nvarchar | (50) | √ |  |  |  |  | 料站表版号 |
| 3 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 4 | SlotNo | nvarchar | (50) | √ |  |  |  |  | 料站编号 |
| 5 | SMaterialNo | nvarchar | (50) | √ |  |  |  |  | 替代物料编号 |
| 6 | AreaNo | nvarchar | (50) |  |  |  |  |  | 区域编号 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | FEEDERNO | nvarchar | (50) | √ |  |  |  |  | Feeder编号 |
| 4 | EVENTTIME | datetime |  | √ |  |  |  |  | 状态开始时间：续料时间 |
| 5 | SPLICEREELNO | nvarchar | (50) |  |  |  | √ |  | 续料卷料编号：续料卷料编号 |
| 6 | MATERIALNO | nvarchar | (50) |  |  |  | √ |  | 续料品号：续料品号 |
| 7 | SPLICESTATUS | numeric | (1,0) |  |  |  | √ |  | 续料状态：0 未使用 1 已使用 2 未使用下料结案 |
| 8 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTFeederType — Feeder型号主档（14 字段）
> 主键：FeederTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederTypeNo | nvarchar | (50) | √ |  |  |  |  | Feeder型号 |
| 2 | FeederTypeName | nvarchar | (50) |  |  |  |  |  | 型号名称 |
| 3 | CountType | nvarchar | (1) |  |  |  |  | 'C' | 计算方式：0 (C)过帐次数、1 (T)上线时间、2 (I)设备集成 |
| 4 | LifeCount | numeric | (10,1) |  |  |  | √ | 999999 | 寿命上限：寿命用罄不可使用，计算方式为时间时纪录总小时数(小数1位) |
| 5 | UsageCount | numeric | (10,1) |  |  |  | √ | 999999 | 使用上限：使用上限到需保养，计算方式为时间时纪录总小时数(小数1位) |
| 6 | WarningCount | numeric | (10,0) |  |  |  | √ | 95 | 警示上限(%)：整数值 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTFeederTypeEQP — Feeder型号对应设备（101 字段）
> 主键：FeederTypeNo, EquipmentNo, REELNOOLD, LOTNO, OPNO, EVENTTIME, LOTNO, CREATETIME, LOTNOOLD, PCSNOOLD, LOTNONEW, PCSNONEW
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | FeederTypeNo | nvarchar | (50) | √ |  |  |  |  | Feeder型号 |
| 2 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 4 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 5 | PRODUCTVERSION | nvarchar | (5) |  |  |  | √ |  | 产品版本 |
| 6 | REELNOOLD | nvarchar | (50) | √ |  |  |  |  | 旧卷料编号 |
| 7 | MATERIALNOOLD | nvarchar | (50) |  |  |  |  |  | 旧物料编号 |
| 8 | MATERIALNONEW | nvarchar | (50) |  |  |  |  |  | 新物料编号 |
| 9 | BURNINGNO | nvarchar | (50) |  |  |  |  |  | 烧录进程 |
| 10 | MANUFACTURER | nvarchar | (64) |  |  |  |  |  | 制造商 |
| 11 | QUANTITY | numeric | (5,0) |  |  |  |  |  | 烧录数量 |
| 12 | VALUENO | nvarchar | (50) |  |  |  |  |  | 烧录进程检验码（版本） |
| 13 | ICFORMAT | nvarchar | (50) |  |  |  |  |  | IC规格 |
| 14 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EVENTTIME | datetime |  | √ |  |  |  |  | 创建时间 |
| 5 | USERNO | nvarchar | (10) |  |  |  |  |  | 用户编号 |
| 6 | AREANO | nvarchar | (20) |  |  |  |  |  | 区号 |
| 7 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 输入数量 |
| 8 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 9 | FEEDERLISTNO | nvarchar | (50) |  |  |  | √ |  | 料站表编号：上料料站表编号 |
| 10 | FEEDERLISTVER | nvarchar | (5) |  |  |  | √ |  | 料站表版号：上料料站表版本 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | PCSRESOURCEGUID | nvarchar | (64) |  |  |  |  |  | 资源履历识别码：用于关联tblSMTEQPResource.GUID |
| 5 | FEEDERLISTNO | nvarchar | (50) |  |  |  | √ |  | 料站表编号 |
| 6 | FEEDERLISTVER | nvarchar | (5) |  |  |  | √ |  | 料站表版号 |
| 7 | MATERIALNO | nvarchar | (50) |  |  |  | √ |  | 物料编号 |
| 8 | SLOTNO | nvarchar | (50) |  |  |  | √ |  | 料站编号 |
| 9 | PANELSIDE | numeric | (1,0) |  |  |  | √ |  | 板面 |
| 10 | CREATETIME | datetime |  | √ |  |  |  |  | 创建时间 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | LOTNOOLD | nvarchar | (50) | √ |  |  |  |  | 来源生产批号：产品解绑的生产批 |
| 3 | PCSNOOLD | nvarchar | (50) | √ |  |  |  |  | 来源成品序号：开窗且可以扫码：产品解绑的成品序号。开窗带出生产批 |
| 4 | LOTNONEW | nvarchar | (50) | √ |  |  |  |  | 目标生产批号：未生成成品序号的生产批（OpNo=lotcreat） |
| 5 | PCSNONEW | nvarchar | (50) | √ |  |  |  |  | 目标成品序号：可以扫码：默认=PCSNoOld的值 |
| 6 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | TRANSCODE | numeric | (2,0) |  |  |  |  |  | 转码类型：0：序号转码，1 包装处置返修，2：包装处置报废 |
| 8 | AREANO | nvarchar | (50) |  |  |  |  |  | 返修生产线编号 |
| 9 | OPNO | nvarchar | (50) |  |  |  |  |  | 返修作业站编号 |
| 10 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 返修工位 |
| 11 | REMARK | nvarchar | (255) |  |  |  |  |  | 说明：包装处置返修和报废时，写入说明 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号：抓不存在与包装资料中的成品序号 |
| 4 | STATUSCODE | nvarchar | (50) |  |  |  |  |  | 解绑判定：1 解绑；2 报废 ；3：撤销解绑 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明 |
| 6 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | REWORK | nvarchar | (1) |  |  |  |  |  | 维修返工：Y：选择；N 未选择 |
| 8 | REVOKER | nvarchar | (30) |  |  |  | √ |  | 撤销人 |
| 9 | REVOKEDATE | datetime |  |  |  |  | √ |  | 撤销日 |
| 10 | REVOKEDESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 撤销说明 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | FROMGUID | nvarchar | (64) |  |  |  |  |  | 主档guid |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | MATERIALUNITNO | nvarchar | (50) |  |  |  |  |  | 部件序号：抓成品序号对应的部件序号明细档（tblWIPCont_PCSMaterial） |
| 5 | STATUSCODE | nvarchar | (50) |  |  |  |  |  | 解绑判定：1 解绑；2 报废 |
| 6 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTMaintainBasis — SMT维修单（27 字段）
> 主键：SMTMaintainNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SMTMaintainNo | nvarchar | (50) | √ |  |  |  |  | 维修单号：内部产生的维护单号，工具维修单为TYYYYMMDDXXXX，产品修复单为PYYYYMMDDXXXX。YYMMDD为年月日(YYYY为公元年四码，MM为月份DD为日)，XXXX为流水号。 |
| 2 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：产品维修单必填 |
| 3 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号：产品维修单必填 |
| 4 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：若有此信息填上 |
| 5 | PCSPanelNo | nvarchar | (50) |  |  |  | √ |  | 成品或Panel序号：产品维修单必填 |
| 6 | SerialNoType | nvarchar | (1) |  |  |  | √ |  | 序号类型：C PcsNo, P PanelNo,以此值来决定PCSPanelNo序号是产品序号还是Panel序号 产品维修单必填 |
| 7 | ToolNo | nvarchar | (50) |  |  |  | √ |  | 工具编号：工具维修单必填 |
| 8 | MaintainClass | nvarchar | (1) |  |  |  |  |  | 维护对象类别：0 SMT_SOLDER_PASTE;锡膏、 1 SMT_STENCILS;网板、 2 SMT_SQUEEGEE;刮刀、 3 SMT_ADHESIVE;红胶、 4 SMT_OTHER;其他、 5 SMT_FEEDER;Feeder、 9 SMT_LOT;LOT L 序号保修 |
| 9 | Qty | numeric | (12,4) |  |  |  |  | 1 | 送修PCS数：若为Panel时，可能 1，工具时此处为1 |
| 10 | MaintainType | char | (1) |  |  |  |  | 'R' | 维修方式：M 维护 R：修复 |
| 11 | Disposed | numeric | (1,0) |  |  |  |  | 0 | 是否已处置：0 未处置 1 已处置 |
| 12 | DisposeResult | nvarchar | (1) |  |  |  |  | 'C' | 处置结果：1 SMT_CONTINUE_PRODUCE;继续生产 2 SMT_END_PRODUCTION;结束生产 3 SMT_SCRAP;报废 工具只能是1或3（报废） 9 维修误判 |
| 13 | DisposeUser | nvarchar | (30) |  |  |  | √ |  | 处置人员 |
| 14 | DisposeDate | datetime |  |  |  |  | √ |  | 处置时间 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 18 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 19 | SMTOPSeq | nvarchar | (4) |  |  |  |  |  | 工序：工具维修不需此栏位，因应ORACLE写入0 |
| 20 | ReworkSMTOPSeq | nvarchar | (4) |  |  |  |  |  | 返回工序：工具维修不需此栏位，因应ORACLE写入0 |
| 21 | AREAEQPGUID | nvarchar | (64) |  |  |  |  | 'N/A' | 工序设备识别码 |
| 22 | SOURCETYPE | nvarchar | (1) |  |  |  |  | '1' | 来源类型：1.送修；2.首检；3.巡检；4.过站; |
| 23 | SOURCEID | nvarchar | (50) |  |  |  |  | 'N/A' | 来源单号：‘’；检验单号(QcformNo)；检验单号(QcformNo)；tblSMTProductPostOutLog.GUID |
| 24 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTMaintainParts — SMT维修更换零件明细（15 字段）
> 主键：SMTMaintainNo, ReelNo, PCSNo, GroupNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SMTMaintainNo | nvarchar | (50) | √ |  |  |  |  | 维修单号 |
| 2 | ReelNo | nvarchar | (50) | √ |  |  |  |  | 卷料编号 |
| 3 | PCSNo | nvarchar | (50) | √ |  |  |  |  | 产品序号 |
| 4 | Qty | numeric | (16,6) |  |  |  | √ |  | 修改后数量 |
| 5 | IsNew | numeric | (1,0) |  |  |  |  | 0 | 是否更换品：0 否 1 是 是表示该项目是更换品（新的卷料编号），否则为原卷料编号 |
| 6 | Position | nvarchar | (4000) |  |  |  |  |  | 位置：用户自行输入 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | GroupNo | numeric | (1,0) | √ |  |  |  | 1 | 更换群组编号 |
| 12 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 更换备注 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTMaintainReason — SMT维修单原因明细（15 字段）
> 主键：SMTMaintainNo, ReasonNo, JUDGEREASONNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SMTMaintainNo | nvarchar | (50) | √ |  |  |  |  | 维修单号 |
| 2 | ReasonNo | nvarchar | (50) | √ |  |  |  |  | 不良现象原因编号 |
| 3 | ReasonName | nvarchar | (100) |  |  |  | √ |  | 不良现象原因名称：将原因名称复写到此 |
| 4 | DefectQty | numeric | (12,4) |  |  |  |  | 1 | 缺点数量 |
| 5 | DefectMemo | nvarchar | (255) |  |  |  | √ |  | 缺点说明（位置） |
| 6 | PanelizationLocation | nvarchar | (50) |  |  |  | √ |  | 连板位置 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | JUDGEREASONNO | nvarchar | (50) | √ |  |  |  |  | 不良原因编号 |
| 12 | JUDGEREASONNAME | nvarchar | (100) |  |  |  | √ |  | 不良原因名称：将原因名称复写到此 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTMaterialChangeLog — 物料更换记录（20 字段）
> 主键：GUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | FeederNo | nvarchar | (50) |  |  |  |  |  | Feeder编号 |
| 3 | ReelNo | nvarchar | (50) |  |  |  |  |  | 卷料编号 |
| 4 | Qty | numeric | (16,6) |  |  |  |  |  | 物料数量 |
| 5 | PostFeederNo | nvarchar | (50) |  |  |  |  |  | 更换后Feeder编号 |
| 6 | PostReelNo | nvarchar | (50) |  |  |  |  |  | 更换后卷料编号 |
| 7 | PostQty | numeric | (10,0) |  |  |  |  |  | 更换后物料数量 |
| 8 | ChangeType | nvarchar | (1) |  |  |  |  |  | 更换动作：R  更换卷料F   更换Feeder |
| 9 | MaterialNo | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 10 | ReasonNo | nvarchar | (50) |  |  |  | √ |  | 原因编号 |
| 11 | ReasonName | nvarchar | (50) |  |  |  | √ |  | 原因说明 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 16 | PCSResourceGUID | nvarchar | (64) |  |  |  |  |  | 资源履历识别码：用于关联tblSMTEQPResource.GUID |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | REMAINQTY | numeric | (10,0) |  |  |  |  | 0 | 剩余数量 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTMFUBasis — 台车主档（25 字段）
> 主键：MFUNo, PANELSIDE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MFUNo | nvarchar | (50) | √ |  |  |  |  | 台车编号 |
| 2 | MFUTypeNo | nvarchar | (50) |  |  |  |  |  | 台车型号 |
| 3 | CountType | nvarchar | (1) |  |  |  |  | '0' | 计算方式：0 SMT_Count;(C)过帐次数 1 SMT_Time;(T)上线时间 2 SMT_EQI;(I)设备集成 |
| 4 | LifeCount | numeric | (10,1) |  |  |  | √ | 999999 | 寿命上限：寿命用罄不可使用，计算方式为时间时纪录总小时数(小数1位) |
| 5 | UsageCount | numeric | (10,1) |  |  |  | √ | 999999 | 使用上限：使用上限到需保养，计算方式为时间时纪录总小时数(小数1位) |
| 6 | WarningCount | numeric | (10,0) |  |  |  | √ | 95 | 警示上限(%)：整数值 |
| 7 | ActualCount | numeric | (10,5) |  |  |  | √ | 0 | 目前使用：维修后累积使用量，计算方式为时间时纪录总小时数(小数一位) |
| 8 | AccCount | numeric | (10,5) |  |  |  | √ | 0 | 累积使用(分)：目前累积使用量，计算方式为时间时纪录总小时数 |
| 9 | SlotAreaNo | nvarchar | (50) |  |  |  | √ |  | 料站区域编号：台车对应的料站区域编号，台车一般只会满足某一部分的Feeder(一台贴片机可能用到多个台车)，可不填写，不填写时会认为此台车具有设备的所有料站 |
| 10 | ResourceState | nvarchar | (4) |  |  |  | √ |  | 资源状态：0 SMT_IN_INV;在库 40 SMT_MAT_MOUNT;已上料 60 SMT_ON_WORK;已上线 70 SMT_REPAIRE;维修 80 SMT_SCRAP;报废 |
| 11 | StateStartTime | datetime |  |  |  |  | √ |  | 状态开始时间：目前状态开始时间 |
| 12 | LOTNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：若已上料，应有生产批号 |
| 13 | FeederListNo | nvarchar | (50) |  |  |  | √ |  | 料站表编号：若已上料，需记录料站表编号版号 |
| 14 | FeederListVer | nvarchar | (50) |  |  |  | √ |  | 料站表版号：若已上料，需记录料站表编号版号 |
| 15 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：若已上线，记录设备编号 |
| 16 | Invalid | numeric | (1,0) |  |  |  | √ | 0 | 作废：0 NO;否 1 YES;是 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 20 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 21 | PANELSIDE | numeric | (1,0) | √ |  |  |  |  | 皮肤位置：0：台车未上线1：正板，2：背板 |
| 22 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTMFUType — 台车型号主档（14 字段）
> 主键：MFUTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MFUTypeNo | nvarchar | (50) | √ |  |  |  |  | Feeder型号 |
| 2 | MFUTypeName | nvarchar | (50) |  |  |  |  |  | 型号名称 |
| 3 | CountType | nvarchar | (1) |  |  |  |  | 'C' | 计算方式：0 (C)过帐次数、1 (T)上线时间、2 (I)设备集成 |
| 4 | LifeCount | numeric | (10,1) |  |  |  | √ | 999999 | 寿命上限：寿命用罄不可使用，计算方式为时间时纪录总小时数(小数1位) |
| 5 | UsageCount | numeric | (10,1) |  |  |  | √ | 999999 | 使用上限：使用上限到需保养，计算方式为时间时纪录总小时数(小数1位) |
| 6 | WarningCount | numeric | (10,0) |  |  |  | √ | 95 | 警示上限(%)：整数值 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTMFUTypeEQP — 台车类别对应设备类别（360 字段）
> 主键：MFUTypeNo, EquipmentNo, PRODUCTIONMODE, CONVEYORNAME, PRODUCTIONNAME, CYCLETIME, TABLENO, EQUIPMENTNO, BLOCKNO, PANELID, PRODUCTNO, PROJECTID, PANELTYPE, FEEDERLISTVER, PANELSIDE, PRODUCTIONMODE, CONVEYORNAME, PRODUCTIONNAME, CYCLETIME, TABLENO, EQUIPMENTNO, BLOCKNO, PANELID, PRODUCTNO, PROJECTID, PANELTYPE, FEEDERLISTVER, PANELSIDE, POSITIONNO, NOZZLEID, HOLDERNO, FEEDERID, PARTNUMBER, USEDPARTSCOUNT, PARTSPICKUPCOUNT, REJECT, NOPICKUP, REFERENCE, MODULENO, REENO, POSITIONNO, NOZZLEID, HOLDERNO, FEEDERID, PARTNUMBER, USEDPARTSCOUNT, PARTSPICKUPCOUNT, REJECT, NOPICKUP, REFERENCE, MODULENO, REENO, MATERIALNO, REELNO, STARTUSERNO, STARTTIME, ENDUSERNO, ENDTIME, STATUS, TYPE, LOTNO, MATERIALNO, REELNO, EVENTTIME, USERNO, LOTNO, OPNO, MATERIALNO, MATERIALLOTNO, QTY, LOTNO, OPNO, MATERIALNO, MATERIALLOTNO, STATE, OPSEQPROCESSNO, OPSEQPROCESSNO, SMTOPSEQ, PRODUCTNO, PRODUCTVERSION, AREANO, LOTNO, EQUIPMENTNO, REELNO, LotNo, SerialNo, LOTNOOLD, LOTNONEW, LOTNOOLD, LOTNONEW, LOTNO, PCSNO, MATERIALNO, REELNO, EVENTTIME, USERNO, LOTNO, OPNO, TOOLNO, TOOLNOSERIAL, SNNO, SNPOSITION, USERNO, QTY, INPUTDATE, LOTNO, OPNO, PDLINENO, PCSNO, PICKLISTID, PDLINENO, OPNO, POSITIONNO, SUBOPSEQUENCE, PRODUCTNO, PRODUCTVERSION, TOOLNO, STARTUSERNO, STARTDATE, ENDUSERNO, ENDDATE, STATE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MFUTypeNo | nvarchar | (50) | √ |  |  |  |  | 台车型号 |
| 2 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | AreaNo | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | PRODUCTIONMODE | numeric | (1,0) | √ |  |  |  |  | 生产模式：0 正常生产，1 Pass模式 |
| 3 | CONVEYORNAME | nvarchar | (50) | √ |  |  |  |  | 轨道名称 |
| 4 | PRODUCTIONNAME | nvarchar | (50) | √ |  |  |  |  | 生产进程名(料站表编号) |
| 5 | CYCLETIME | nvarchar | (50) | √ |  |  |  |  | 每块板的生产周期时间 |
| 6 | TABLENO | nvarchar | (50) | √ |  |  |  |  | 区域编号 |
| 7 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 8 | BLOCKNO | nvarchar | (50) | √ |  |  |  |  | PCB板序号 |
| 9 | PANELID | nvarchar | (50) | √ |  |  |  |  | PCB板条形码 |
| 10 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 11 | PROJECTID | nvarchar | (50) | √ |  |  |  |  | 项目编号 |
| 12 | PANELTYPE | nvarchar | (50) | √ |  |  |  |  | 板型 |
| 13 | FEEDERLISTVER | nvarchar | (50) | √ |  |  |  |  | 料站表版本 |
| 14 | PANELSIDE | numeric | (1,0) | √ |  |  |  |  | 面别：1：正面，2：背面 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | PRODUCTIONMODE | numeric | (1,0) | √ |  |  |  |  | 生产模式：0 正常生产，1 Pass模式 |
| 3 | CONVEYORNAME | nvarchar | (50) | √ |  |  |  |  | 轨道名称 |
| 4 | PRODUCTIONNAME | nvarchar | (50) | √ |  |  |  |  | 生产进程名(料站表编号) |
| 5 | CYCLETIME | nvarchar | (50) | √ |  |  |  |  | 每块板的生产周期时间 |
| 6 | TABLENO | nvarchar | (50) | √ |  |  |  |  | 区域编号 |
| 7 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 8 | BLOCKNO | nvarchar | (50) | √ |  |  |  |  | PCB板序号 |
| 9 | PANELID | nvarchar | (50) | √ |  |  |  |  | PCB板条形码 |
| 10 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 11 | PROJECTID | nvarchar | (50) | √ |  |  |  |  | 项目编号 |
| 12 | PANELTYPE | nvarchar | (50) | √ |  |  |  |  | 板型 |
| 13 | FEEDERLISTVER | nvarchar | (50) | √ |  |  |  |  | 料站表版本 |
| 14 | PANELSIDE | numeric | (1,0) | √ |  |  |  |  | 面别：1：正面，2：背面 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 站位 |
| 2 | NOZZLEID | nvarchar | (50) | √ |  |  |  |  | 吸嘴条形码 |
| 3 | HOLDERNO | nvarchar | (50) | √ |  |  |  |  | 贴片头 |
| 4 | FEEDERID | nvarchar | (50) | √ |  |  |  |  | 飞达信息 |
| 5 | PARTNUMBER | nvarchar | (50) | √ |  |  |  |  | 物料料号 |
| 6 | USEDPARTSCOUNT | numeric | (10,4) | √ |  |  |  |  | 物料用量 |
| 7 | PARTSPICKUPCOUNT | numeric | (10,4) | √ |  |  |  |  | 吸取数量 |
| 8 | REJECT | numeric | (10,4) | √ |  |  |  |  | 抛料数量 |
| 9 | NOPICKUP | numeric | (10,4) | √ |  |  |  |  | 没有吸取到物料的数量 |
| 10 | REFERENCE | nvarchar | (500) | √ |  |  |  |  | Ref位置 |
| 11 | MODULENO | nvarchar | (50) | √ |  |  |  |  | 模块编号 |
| 12 | REENO | nvarchar | (50) | √ |  |  |  |  | 卷边编号 |
| 13 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 站位 |
| 3 | NOZZLEID | nvarchar | (50) | √ |  |  |  |  | 吸嘴条形码 |
| 4 | HOLDERNO | nvarchar | (50) | √ |  |  |  |  | 贴片头 |
| 5 | FEEDERID | nvarchar | (50) | √ |  |  |  |  | 飞达信息 |
| 6 | PARTNUMBER | nvarchar | (50) | √ |  |  |  |  | 物料料号 |
| 7 | USEDPARTSCOUNT | numeric | (10,4) | √ |  |  |  |  | 物料用量 |
| 8 | PARTSPICKUPCOUNT | numeric | (10,4) | √ |  |  |  |  | 吸取数量 |
| 9 | REJECT | numeric | (10,4) | √ |  |  |  |  | 抛料数量 |
| 10 | NOPICKUP | numeric | (10,4) | √ |  |  |  |  | 没有吸取到物料的数量 |
| 11 | REFERENCE | nvarchar | (500) | √ |  |  |  |  | Ref位置 |
| 12 | MODULENO | nvarchar | (50) | √ |  |  |  |  | 模块编号 |
| 13 | REENO | nvarchar | (50) | √ |  |  |  |  | 卷边编号 |
| 14 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 3 | REELNO | nvarchar | (50) | √ |  |  |  |  | 卷料编号 |
| 4 | STARTUSERNO | nvarchar | (50) | √ |  |  |  |  | 开始人员 |
| 5 | STARTTIME | datetime |  | √ |  |  |  |  | 开始时间 |
| 6 | ENDUSERNO | nvarchar | (50) | √ |  |  |  |  | 结束人员 |
| 7 | ENDTIME | datetime |  | √ |  |  |  |  | 结束时间 |
| 8 | STATUS | numeric | (1,0) | √ |  |  |  |  | 状态：(0：进行中 1：已完成) |
| 9 | TYPE | numeric | (1,0) | √ |  |  |  |  | 类型：(0：干燥 1：烘烤) |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (64) | √ |  |  |  |  | 生产批号 |
| 3 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 料号 |
| 4 | REELNO | nvarchar | (64) | √ |  |  |  |  | 卷料编号 |
| 5 | EVENTTIME | datetime |  | √ |  |  |  |  | 操作时间 |
| 6 | USERNO | nvarchar | (64) | √ |  |  |  |  | 操作人员 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 5 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 6 | QTY | numeric | (12,4) | √ |  |  |  |  | 数量 |
| 7 | CREATETIME | datetime |  |  |  |  |  |  | 创建时间 |
| 8 | TYPE | numeric | (1,0) |  |  |  |  |  | 类型：0：自动调度发起，1：出站报工发起， 2：序号转码发起 |
| 9 | EVENTID | nvarchar | (50) |  |  |  |  |  | 事件ID |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 4 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 5 | PERIODUSEQTY | numeric | (12,4) |  |  |  |  |  | 期间使用量 |
| 6 | LASTPASSTIME | datetime |  |  |  |  |  |  | 上次过站时间 |
| 7 | STATE | numeric | (1,0) | √ |  |  |  |  | 状态：0：未抛转，1：抛转中 |
| 8 | TYPE | numeric | (1,0) |  |  |  |  |  | 类型：0：自动调度发起，1：出站报工发起 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OPSEQPROCESSNO | nvarchar | (50) | √ |  |  |  |  | 工序流程编号 |
| 2 | OPSEQPROCESSNAME | nvarchar | (50) |  |  |  |  |  | 工序流程名称 |
| 3 | AREANO | nvarchar | (20) |  |  |  |  |  | 生产线 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明 |
| 5 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 6 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OPSEQPROCESSNO | nvarchar | (50) | √ |  |  |  |  | 工序流程编号 |
| 2 | AREANO | nvarchar | (20) |  |  |  |  |  | 区域编号(生产线编号) |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | SMTOPSEQ | numeric | (2,0) | √ |  |  |  |  | 工序 |
| 5 | SMTOPNAME | nvarchar | (50) |  |  |  |  |  | 工序名称 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 工序说明 |
| 7 | SPOSTING_SEC | numeric | (6,2) |  |  |  | √ |  | 标准过帐秒数：Panel板经过设备所需时间 |
| 8 | PANELSIDE | numeric | (1,0) |  |  |  |  |  | 皮肤位置（板面）：1：正板，2：背板 |
| 9 | TIMEINTERVAL | numeric | (6,2) |  |  |  |  |  | 工序管控时间 |
| 10 | BEFOROPSEQ | numeric | (2,0) |  |  |  |  |  | 管控前工序 |
| 11 | OPERATINGSTATIONATTRIBUTES | numeric | (2,0) |  |  |  |  |  | 对应作业站属性：用于SMT过站操作界面的判断： 1-- 一般作业站 2-- 印锡作业站 3-- 贴片作业站 4-- 检测作业站 |
| 12 | BUCKLESEQ | numeric | (1,0) |  |  |  | √ |  | 扣料点工序：0：否，1：是 |
| 13 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 14 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 15 | AUTOCO | numeric | (1,0) |  |  |  |  |  | 自动出站：0：否，1：是 |
| 16 | AUTOCOCONTROL | numeric | (1,0) |  |  |  |  |  | 自动出站卡控：0：提示，1：警告 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OPSEQPROCESSNO | nvarchar | (50) |  |  |  |  |  | 工序流程编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 4 | AREANO | nvarchar | (20) | √ |  |  |  |  | 区域编号（生产线） |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | PRODUCTNO | nvarchar | (64) |  |  |  | √ |  | 产品号（预留） |
| 3 | FEEDERLISTNO | nvarchar | (64) |  |  |  | √ |  | 料站表编号 |
| 4 | FEEDERLISTVER | nvarchar | (5) |  |  |  |  | 'N/A' | 料站表版本 |
| 5 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 料号 |
| 6 | MANUFACTURER | nvarchar | (64) |  |  |  |  |  | 制造商 |
| 7 | MNFPARTNO | nvarchar | (64) |  |  |  | √ |  | 制造商料号 |
| 8 | LOTNO | nvarchar | (64) |  |  |  |  |  | 批次号 |
| 9 | MFGDATE | datetime |  |  |  |  |  |  | 制造日期 |
| 10 | PRIORITY | numeric | (4,0) |  |  |  |  |  | 优先级 |
| 11 | REELNO | nvarchar | (50) |  |  |  |  | 'N/A' | 卷料编号 |
| 12 | EFFECTSTATE | nvarchar | (1) |  |  |  |  | 'N' | 生效：Y：生效；N 失效 |
| 13 | SOURCESYS | nvarchar | (1) |  |  |  |  | '1' | 产生方式：1 MES创建；2.WMS创建 |
| 14 | EFFECTUSER | nvarchar | (64) |  |  |  |  | 'N/A' | 失效人员 |
| 15 | EFFECTREASON | nvarchar | (255) |  |  |  |  | 'N/A' | 失效原因 |
| 16 | EFFECTDATE | datetime |  |  |  |  |  |  | 失效时间 |
| 17 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 18 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 19 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 22 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 4 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | REELNO | nvarchar | (50) | √ |  |  |  |  | PCB版批号 |
| 6 | ONLINETIME | datetime |  |  |  |  |  |  | 上料时间 |
| 7 | ORIGQTY | numeric | (10,1) |  |  |  |  |  | 上料时原始数量 |
| 8 | ACTUALQTY | numeric | (10,1) |  |  |  |  |  | 目前数量 |
| 9 | WARNINGCOUNT | numeric | (10,0) |  |  |  | √ |  | 警示上限(%)：整数值 |
| 10 | ACTUALCOUNT | numeric | (10,5) |  |  |  | √ |  | 目前使用：维修后累积使用量，计算方式为时间时纪录总小时数(小数一位) |
| 11 | ACCCOUNT | numeric | (10,0) |  |  |  | √ |  | 累积使用：目前累积使用量，计算方式为时间时纪录总小时数 |
| 12 | RESOURCESTATE | numeric | (2,0) |  |  |  |  |  | 资源状态：0 SMT_IN_INV;在库 10 SMT_ISSUED;已领用 20 SMT_WARM_UP;回温开始  30 SMT_WARM_END;回温完成 40 SMT_MAT_MOUNT;已上料 50 SMT_MFU_MOUNT;已上台车 60 SMT_ON_WORK;已上线 70 SMT_REPAIRE;维修 80 SMT_SCRAP;报废 90 SMT_IDLE;闲置 21 SMT_CLEANING;清洗中 31 SMT_CLEANED;清洗完成 |
| 13 | STATESTARTTIME | datetime |  |  |  |  | √ |  | 状态开始时间：目前状态开始时间 |
| 14 | RESOURCELOCATION | nvarchar | (50) |  |  |  | √ |  | 资源所在位置：目前该资源所在位置，若是先放在台车上，纪录台车编号，若直接上设备就纪录设备编号 |
| 15 | RESOURCEMODE | nvarchar | (1) |  |  |  | √ |  | 资源模式：资源所在位置是   E 设备 M 台车 |
| 16 | MATERIALNO | nvarchar | (50) |  |  |  | √ |  | 物料品号：已上的物料编号 |
| 17 | SPLICEDREELNO | nvarchar | (50) |  |  |  | √ |  | 被续卷料编号：被续的卷料编号 |
| 18 | SLOTNO | nvarchar | (50) |  |  |  | √ |  | 料站编号：已上料站编号(可能是设备或台车) |
| 19 | ISONLINE | numeric | (1,0) |  |  |  |  |  | 上料状况：1 已上料中 0 已下料 |
| 20 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 25 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批编号 |
| 2 | SerialNo | nvarchar | (50) | √ |  |  |  |  | 序号或板号 |
| 3 | NoType | nvarchar | (1) |  |  |  | √ |  | 编号类别：0 板号 1 产品序号 |
| 4 | PrintLableNum | numeric | (2,0) |  |  |  | √ |  | 标签打印次数 |
| 5 | UnitedSizes | numeric | (4,0) |  |  |  | √ |  | 预设连板数：1 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 8 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | LOTNOOLD | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 4 | LOTNONEW | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 5 | SERIALNOTYPE | nvarchar | (1) |  |  |  |  |  | 序号类别：0 板号 1 产品序号 |
| 6 | SERIALNOCOUNT | numeric | (4,0) |  |  |  |  |  | 序号数量 |
| 7 | SERIALNOSTART | nvarchar | (50) |  |  |  |  |  | 序号开始 |
| 8 | SERIALNOEND | nvarchar | (50) |  |  |  |  |  | 序号结束 |
| 9 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | USERNO | nvarchar | (30) |  |  |  | √ |  | 解绑人 |
| 11 | EVENTTIME | datetime |  |  |  |  | √ |  | 解绑日 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | LOTNOOLD | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 4 | LOTNONEW | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 5 | SERIALNOTYPE | nvarchar | (1) |  |  |  |  |  | 序号类别：0 板号 1 产品序号 |
| 6 | SERIALNOCOUNT | numeric | (4,0) |  |  |  |  |  | 序号数量 |
| 7 | SERIALNOSTART | nvarchar | (50) |  |  |  |  |  | 序号开始 |
| 8 | SERIALNOEND | nvarchar | (50) |  |  |  |  |  | 序号结束 |
| 9 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (64) | √ |  |  |  |  | 生产批号 |
| 3 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 4 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 料号 |
| 5 | REELNO | nvarchar | (64) | √ |  |  |  |  | 卷料编号 |
| 6 | EVENTTIME | datetime |  | √ |  |  |  |  | 操作时间 |
| 7 | USERNO | nvarchar | (64) | √ |  |  |  |  | 操作人员 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | TOOLNO | nvarchar | (50) | √ |  |  |  |  | 工具编号 |
| 5 | TOOLNOSERIAL | nvarchar | (50) | √ |  |  |  |  | 工具编号流水号 |
| 6 | SNNO | nvarchar | (50) | √ |  |  |  |  | 产品条形码 |
| 7 | SNPOSITION | nvarchar | (10) | √ |  |  |  |  | 位置 |
| 8 | USERNO | nvarchar | (50) | √ |  |  |  |  | 人员 |
| 9 | QTY | numeric | (1,0) | √ |  |  |  |  | 数量 |
| 10 | INPUTDATE | datetime |  | √ |  |  |  |  | 创建时间 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线编号 |
| 4 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位编号 |
| 5 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 6 | TOOLNO | nvarchar | (50) |  |  |  |  |  | 工具编号 |
| 7 | USERNO | nvarchar | (50) |  |  |  |  |  | 人员 |
| 8 | EVENTTIME | datetime |  |  |  |  |  |  | 异动时间 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | PICKLISTID | nvarchar | (14) | √ |  |  |  |  | 需求订单号：yyyyMMddHHmmss |
| 3 | PICKLISTTYPE | nvarchar | (1) |  |  |  |  |  | 需求单类型：1 设备料站 2 生产需求 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 6 | FEEDERLISTNO | nvarchar | (50) |  |  |  |  |  | 料站表编号 |
| 7 | FEEDERLISTVER | nvarchar | (50) |  |  |  |  |  | 料站表版号 |
| 8 | MONO | nvarchar | (50) |  |  |  |  |  | 工单编号 |
| 9 | DISPOSED | numeric | (1,0) |  |  |  |  |  | 是否已处置：0 未处置 1 已处置 |
| 10 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注：强制关单说明 |
| 11 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | PICKLISTID | nvarchar | (14) |  |  |  |  |  | 需求订单号：yyyyMMddHHmmss |
| 3 | SLOTNO | nvarchar | (50) |  |  |  |  |  | 站位 |
| 4 | MATERIALNO | nvarchar | (50) |  |  |  | √ |  | 物料编号 |
| 5 | REELNO | nvarchar | (50) |  |  |  | √ |  | 卷料编号 |
| 6 | AMOUNT | numeric | (12,0) |  |  |  | √ |  | 实际数量 |
| 7 | AMOUNTNEED | numeric | (12,0) |  |  |  |  |  | 需求数量 |
| 8 | ISMSD | numeric | (1,0) |  |  |  |  |  | 是否为MSD：0-不是MSD物料 1-是MSD物料 |
| 9 | TIMESTAMP | datetime |  |  |  |  | √ |  | 取料扫描时间 |
| 10 | STATUS | numeric | (2,0) |  |  |  |  |  | 状态：10-生产的订单等待取料扫描 20-生产的订单已取料扫描 30-转产的订单等待取料扫描  40-转产的订单已取料扫描 99-卷料已上料或续料 |
| 11 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线编号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 工位 |
| 5 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序 |
| 6 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 7 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 8 | TOOLNO | nvarchar | (50) | √ |  |  |  |  | 工具编号 |
| 9 | STARTUSERNO | nvarchar | (50) | √ |  |  |  |  | 绑定人员 |
| 10 | STARTDATE | datetime |  | √ |  |  |  |  | 绑定时间 |
| 11 | ENDUSERNO | nvarchar | (50) | √ |  |  |  |  | 解绑人员 |
| 12 | ENDDATE | datetime |  | √ |  |  |  |  | 解绑时间 |
| 13 | STATE | numeric | (1,0) | √ |  |  |  |  | 状态 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTProcessBasis — SMT产品工序主档（15 字段）
> 主键：ProcessNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProcessNo | nvarchar | (64) | √ |  |  |  |  | 工序识别码：以GUID方式生成   SYS_GUID()   NEWID() |
| 2 | ProductNo | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 3 | ProducVersion | nvarchar | (5) |  |  |  | √ |  |  |
| 4 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  | '01' | 产品版本：请加索引，可填入 表示忽略此条件 |
| 11 | OPSEQPROCESSNO | nvarchar | (50) |  |  |  |  | 'N/A' | 工序流程编号 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTProcessDetail — SMT工序明细（68 字段）
> 主键：ProcessNo, SMTOPSeq, PROCESSNO, OPNO, PROCESSNO, SMTOPSEQ, PRODUCTNO, PRODUCTVERSION, PROCESSNO, OPNO, REASONNO, SMTOPSEQ
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProcessNo | nvarchar | (64) | √ |  |  |  |  | 工序识别码：等于主档的工序识别码 |
| 2 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号(生产线编号) |
| 3 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 4 | SMTOPSeq | nvarchar | (4) | √ |  |  |  |  | 工序 |
| 5 | SMTOPName | nvarchar | (50) |  |  |  |  |  | 工序名称 |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 工序说明 |
| 7 | SPosting_Sec | numeric | (6,2) |  |  |  | √ | 0 | 标准过帐秒数：Panel板经过设备所需时间 |
| 8 | PanelSide | numeric | (1,0) |  |  |  | √ |  | 皮肤位置（板面）：1：正板，2：背板 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 13 | TIMEINTERVAL | numeric | (6,2) |  |  |  |  | 0 | 工序管控时间 |
| 14 | BEFOROPSEQ | numeric | (2,0) |  |  |  |  | 0 | 管控前工序 |
| 15 | OPERATINGSTATIONATTRIBUTES | numeric | (2,0) |  |  |  |  | 0 | 对应作业站属性：用于SMT过站操作界面的判断： 1-- 一般作业站 2-- 印锡作业站 3-- 贴片作业站 4-- 检测作业站 |
| 16 | BUCKLESEQ | numeric | (1,0) |  |  |  | √ |  | 扣料点工序：0：否，1：是 |
| 17 | AUTOCO | numeric | (1,0) |  |  |  |  | 0 | 自动出站：0：否，1：是 |
| 18 | AUTOCOCONTROL | numeric | (1,0) |  |  |  |  | 0 | 自动出站卡控：0：提示，1：警告 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 工序识别码：tblSMTProcessLotBasis.ProcessNo |
| 2 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本：请加索引，可填入 表示忽略此条件 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | AREANO | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 6 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 7 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 8 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 工序识别码：以GUID方式生成   SYS_GUID()   NEWID() |
| 2 | AREANO | nvarchar | (20) |  |  |  |  |  | 区域编号(生产线编号) |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | SMTOPSEQ | numeric | (2,0) | √ |  |  |  |  | 工序 |
| 5 | SMTOPNAME | nvarchar | (50) |  |  |  |  |  | 工序名称 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 工序说明 |
| 7 | SPOSTING_SEC | numeric | (6,2) |  |  |  | √ |  | 标准过帐秒数：Panel板经过设备所需时间 |
| 8 | PANELSIDE | numeric | (1,0) |  |  |  |  |  | 皮肤位置（板面）：1：正板，2：背板 |
| 9 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 10 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 11 | TIMEINTERVAL | numeric | (6,2) |  |  |  |  |  | 工序管控时间 |
| 12 | BEFOROPSEQ | numeric | (2,0) |  |  |  |  |  | 管控前工序 |
| 13 | OPERATINGSTATIONATTRIBUTES | numeric | (2,0) |  |  |  |  |  | 对应作业站属性：用于SMT过站操作界面的判断： 1-- 一般作业站 2-- 印锡作业站 3-- 贴片作业站 4-- 检测作业站 |
| 14 | BUCKLESEQ | numeric | (1,0) |  |  |  | √ |  | 扣料点工序：0：否，1：是 |
| 15 | AUTOCO | numeric | (1,0) |  |  |  |  |  | 自动出站：0：否，1：是 |
| 16 | AUTOCOCONTROL | numeric | (1,0) |  |  |  |  |  | 自动出站卡控：0：提示，1：警告 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本：请加索引，可填入 表示忽略此条件 |
| 4 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 工序识别码：以GUID方式生成   SYS_GUID()   NEWID() |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 6 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 检验编号 |
| 7 | SMTOPSEQ | numeric | (2,0) | √ |  |  |  |  | 工序 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTProductPostInLog — 产品序号投入纪录档（18 字段）
> 主键：GUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 5 | PCSNo | nvarchar | (50) |  |  |  |  |  | 成品序号：20200606 bruce modi需允许板号过帐 |
| 6 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 7 | PostingResult | nvarchar | (50) |  |  |  | √ | '1' | 过帐状态：一律为 1 是 |
| 8 | PostingMemo | nvarchar | (255) |  |  |  | √ |  | 过帐说明 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 13 | SMTOPSeq | nvarchar | (4) |  |  |  |  | 'N/A' | 工序 |
| 14 | ReworkCount | nvarchar | (2) |  |  |  |  | '0' | 返工次数 |
| 15 | IsActive | numeric | (1,0) |  |  |  | √ | 1 | 目前状态：0 No 1 Yes 1表示该笔是目前过帐的最新记录 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTProductPostOutLog — 产品序号产出纪录档（42 字段）
> 主键：GUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | LotNo | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号：设备编码 |
| 5 | PCSNo | nvarchar | (50) |  |  |  | √ |  | 成品序号：20200606 bruce modi需允许板号过帐 |
| 6 | PanelNo | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 7 | PostingResult | nvarchar | (50) |  |  |  | √ |  | 过帐状态：P 合格 X 不合格 |
| 8 | PostingMemo | nvarchar | (255) |  |  |  | √ |  | 过帐说明 |
| 9 | PCSResourceGUID | nvarchar | (36) |  |  |  | √ |  | 设备资源履历号 |
| 10 | PCSResourceGUIDOrg | nvarchar | (36) |  |  |  | √ |  | 原始设备资源履历号：设备资源履历号与原始设备资源履历号初始值相同，若有维修后造成零件更换时，设备资源履历号会产生新的一组，所以此两值不同时表示该产品序号有过变更 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 15 | SMTOPSeq | nvarchar | (4) |  |  |  |  | 'N/A' | 工序 |
| 16 | ReworkCount | nvarchar | (2) |  |  |  |  | '0' | 返工次数 |
| 17 | IsActive | numeric | (1,0) |  |  |  | √ | 1 | 目前状态：0 No 1 Yes 1表示该笔是目前过帐的最新记录 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 6 | PCSNO | nvarchar | (50) |  |  |  | √ |  | 成品序号：20200606 bruce modi需允许板号过帐 |
| 7 | PANELNO | nvarchar | (50) |  |  |  | √ |  | Panel序号 |
| 8 | BEFOROPSEQ | numeric | (2,0) |  |  |  |  |  | 管控前工序 |
| 9 | TIMEINTERVAL | numeric | (6,2) |  |  |  |  |  | 工序管控时间 |
| 10 | SMTOPSEQ | numeric | (2,0) |  |  |  |  |  | 工序 |
| 11 | REWORKCOUNT | nvarchar | (2) |  |  |  |  |  | 返工次数 |
| 12 | REALTIMEINTERVAL | numeric | (6,2) |  |  |  |  |  | 实际工序过站时间 |
| 13 | PCSRESOURCEGUID | nvarchar | (36) |  |  |  | √ |  | 设备资源履历号 |
| 14 | REASONNO | nvarchar | (50) |  |  |  |  |  | 原因编号 |
| 15 | REASONNAME | nvarchar | (100) |  |  |  |  |  | 原因名称：将原因名称复写到此 |
| 16 | ISACTIVE | nvarchar | (1) |  |  |  | √ |  | 目前状态：W Wait待处理 P Pass通过 F Fail报废 AH 自动出站失败提示(暂订) AW 自动出站失败警告(暂订) |
| 17 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 22 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTReasons — 异常原因主档(工具、产品)（25 字段）
> 主键：ReasonType, ReasonNo, REASONTYPE, REASONNO, AREAEQPGUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReasonType | nvarchar | (50) | √ |  |  |  |  | 不良原因类别：表头的类别是用来过滤资料的，选项有：feeder_change 更换Feeder、scrap 报废、repaire 送修、maintain 维修、Product 产品不良现象;ProductReason 产品不良原因 |
| 2 | ReasonNo | nvarchar | (50) | √ |  |  |  |  | 原因编号 |
| 3 | ReasonName | nvarchar | (100) |  |  |  |  |  | 原因名称 |
| 4 | ReasonLevel | numeric | (1,0) |  |  |  |  | 0 | 原因等级：共有0~9级 |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | IsDefault | numeric | (1,0) |  |  |  |  | 0 | 预设原因：1=设定为某类别的预设原因,0=非预设原因 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | REASONTYPE | nvarchar | (50) | √ |  |  |  |  | 不良原因类别：表头的类别是用来过滤资料的，选项有：feeder_change 更换Feeder、scrap 报废、repaire 送修、maintain 维修、Product 产品不良现象;ProductReason 产品不良原因 |
| 3 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 原因编号 |
| 4 | AREAEQPGUID | nvarchar | (100) | √ |  |  |  |  | 对应工序GUID：tblSMTAreaEQP.GUID |
| 5 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTReelBasis — 卷料主档（89 字段）
> 主键：ReelNo, REELNO, OLDQTY, NEWQTY, TYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReelNo | nvarchar | (50) | √ |  |  |  |  | 卷料编号 |
| 2 | MaterialNo | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 3 | Qty | numeric | (12,4) |  |  |  |  | 0 | 数量 |
| 4 | ActualQty | numeric | (12,4) |  |  |  |  | 0 | 剩余量：目前剩余数量 |
| 5 | EXPDate | datetime |  |  |  |  | √ |  | 有效日期：物料过期日期 |
| 6 | MFGDate | datetime |  |  |  |  | √ |  | 生产日期：物料生产日期 |
| 7 | ResourceState | nvarchar | (4) |  |  |  |  |  | 资源状态：0 SMT_IN_INV;在库 10 SMT_DRYING;干燥 20 SMT_BAKING;烘干  40 SMT_FEEDED;已上料 60 SMT_ON-WORK;已上线 80 SMT_SCRAP;报废 |
| 8 | StateStartTime | datetime |  |  |  |  | √ |  | 状态开始时间：目前状态开始时间 |
| 9 | FeederNo | nvarchar | (50) |  |  |  | √ |  | Feeder编号：若已上料，需记录目前上料的Feeder编号 |
| 10 | Invalid | numeric | (1,0) |  |  |  | √ | 0 | 报废：0 可用 1 报废 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 15 | EXPOSURETIME | datetime |  |  |  |  |  |  | 曝露时间：MSD PCB拆包曝露开始时间 |
| 16 | MANUFACTURER | nvarchar | (64) |  |  |  | √ |  | 制造商 |
| 17 | MNFPARTNO | nvarchar | (64) |  |  |  | √ |  | 制造商料号 |
| 18 | MNFLOTNO | nvarchar | (128) |  |  |  | √ |  | 制造商批号 |
| 19 | NUMDRYLEFT | numeric | (2,0) |  |  |  | √ |  | MSD物料烘烤次数 |
| 20 | DRYTIMESTAMP | datetime |  |  |  |  | √ |  | 干燥、烘箱作业的时间 |
| 21 | STATUS | numeric | (2,0) |  |  |  | √ |  | 物料状态属性：默认为0物料注册进来 1-- 物料已使用过 2-- 物料在干燥 3-- 物料在烘烤 |
| 22 | LOTNO | nvarchar | (64) |  |  |  | √ |  | 生产批次号 |
| 23 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 24 | ICBURNIN | nvarchar | (36) |  |  |  | √ |  | IC烧录 |
| 25 | PERIODUSERQTY | numeric | (12,4) |  |  |  | √ |  | 期间使用量 |
| 26 | LASTPASSTIME | datetime |  |  |  |  | √ |  | 上次过站时间 |
| 27 | LASTSENDTIME | datetime |  |  |  |  | √ |  | 上次抛转时间 |
| 28 | DRYINGTIME | numeric | (5,0) |  |  |  | √ |  | 累计干燥时间(分钟) |
| 29 | OPENTIMESTAMP | datetime |  |  |  |  |  |  | 开封时间 |
| 30 | LASTRETURNTIME | datetime |  |  |  |  | √ |  | 上次退仓时间(电子仓) |
| 31 | RETURNTIME | numeric | (5,0) |  |  |  |  | 0 | 累计退仓时间(分钟) |
| 32 | PALLETNO | nvarchar | (100) |  |  |  | √ |  | 外箱号 |
| 33 | MANUFACTURERNO | nvarchar | (200) |  |  |  | √ |  | 制造商 |
| 34 | DATECODE | nvarchar | (50) |  |  |  | √ |  | D C编号 |
| 35 | PURCHASENO | nvarchar | (30) |  |  |  | √ |  | 采购订单号 |
| 36 | PURCHASESEQ | nvarchar | (5) |  |  |  | √ |  | 采购订单行号 |
| 37 | SOURCENO | nvarchar | (30) |  |  |  | √ |  | 来源单号 |
| 38 | SOURCESEQ | nvarchar | (5) |  |  |  | √ |  | 来源序号 |
| 39 | BARCODETYPE | nvarchar | (1) |  |  |  | √ |  | 条码类型：1.物料级  2.批次级 3.单箱级  4.单件级 |
| 40 | WAREHOUSENO | nvarchar | (50) |  |  |  | √ |  | 仓库编号 |
| 41 | STORAGESPACESNO | nvarchar | (50) |  |  |  | √ |  | 储位编号 |
| 42 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段01 |
| 43 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段02 |
| 44 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段03 |
| 45 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段04 |
| 46 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自定义字段05 |
| 47 | USER_DEFINED06 | numeric | (16,6) |  |  |  | √ |  | 用户自定义字段06 |
| 48 | USER_DEFINED07 | numeric | (16,6) |  |  |  | √ |  | 用户自定义字段07 |
| 49 | USER_DEFINED08 | numeric | (16,6) |  |  |  | √ |  | 用户自定义字段08 |
| 50 | USER_DEFINED09 | numeric | (16,6) |  |  |  | √ |  | 用户自定义字段09 |
| 51 | USER_DEFINED10 | numeric | (16,6) |  |  |  | √ |  | 用户自定义字段10 |
| 52 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 53 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 54 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 55 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 3 | SID | nvarchar | (50) |  |  |  |  |  | 识别码 |
| 4 | RECEIVEMODE | nvarchar | (50) |  |  |  |  |  | WMS发料模式：COMPONENT_RELEASE 工单发料 COMPONENT_BACK：工单退回 |
| 5 | REELNO | nvarchar | (50) |  |  |  |  |  | 卷料编号 |
| 6 | RESULT | char | (1) |  |  |  | √ |  | 结果：0 成功 1 失败 |
| 7 | MSG | nvarchar | (255) |  |  |  | √ |  | 异常讯息 |
| 8 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | ORIGREELNO | nvarchar | (50) |  |  |  |  |  | 原卷料编号：盘点卷料编号 |
| 3 | ORIGACTUALQTY | numeric | (12,4) |  |  |  |  |  | 剩余量 |
| 4 | FIXACTUALQTY | numeric | (12,4) |  |  |  |  |  | 盘点数量 |
| 5 | NEWREELNO | nvarchar | (50) |  |  |  |  |  | 退料卷料编号：WMS回传卷料编号 |
| 6 | RETURNQTY | numeric | (12,4) |  |  |  |  |  | 退料数量 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | REELNO | nvarchar | (50) | √ |  |  |  |  | 卷料编号 |
| 3 | OLDQTY | numeric | (10,4) | √ |  |  |  |  | 旧数量 |
| 4 | NEWQTY | numeric | (10,4) | √ |  |  |  |  | 新数量 |
| 5 | TYPE | numeric | (10,4) | √ |  |  |  |  | 类型：0 Feeder上料时更新 1 台车上料时更新 2：上料比对更新 3：续料作业更新 4.物料料批绑定 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTResourceActionLog — 资源动作纪录档（20 字段）
> 主键：GUID, PANELSIDE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：台车上料或设备上料时，需记录 |
| 3 | FeederNo | nvarchar | (50) |  |  |  | √ |  | Feeder编号：上料时必须填写 |
| 4 | MFUNo | nvarchar | (50) |  |  |  | √ |  | 台车编号：物料先上到台车或台车上线，此栏记录 |
| 5 | ToolNo | nvarchar | (50) |  |  |  | √ |  | 工具编号：工具上线时，记录工具编号 |
| 6 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：物料直接上到设备时，此栏需记录 |
| 7 | MaterialNo | nvarchar | (50) |  |  |  | √ |  | 物料编号：物料上料、上线、下料 线时必须记录 |
| 8 | ReelNo | nvarchar | (50) |  |  |  | √ |  | 卷料编号：物料上料、上线、下料 线时必须记录 |
| 9 | SlotNo | nvarchar | (50) |  |  |  | √ |  | 料站编号：物料上台车或上设备时，记录料站编号 |
| 10 | ResourceAction | nvarchar | (4) |  |  |  | √ |  | 执行动作：0 SMT_OFF_WORK;下线 下料  1 SMT_RETURN;归还  2 SMT_CHECK;检测  3 SMT_MAINTAIN;保养 维护 5 SMT_REPAIR_COMPLETED;维修完成  10 SMT_ISSUE;领用  20 SMT_WARM_UP;回温开始  30 SMT_WARM_END;回温结束  40 SMT_MAT_MOUNT;上料  50 SMT_MFU_MOUNT;上台车  60 SMT_ON_WORK;上线 上料比对  70 SMT_REPAIRE;送修  80 SMT_SCRAP;报废 21 SMT_CLEAN;清洗开始 31 SMT_CLEANED;清洗完成 91 续料时旧料下料 92 续料时新料上料 |
| 11 | FeederListNo | nvarchar | (50) |  |  |  | √ |  | 料站表编号：台车、设备上下料时需记录 |
| 12 | FeederListVer | nvarchar | (5) |  |  |  | √ |  | 料站表版号：台车、设备上下料时需记录 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 16 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | PANELSIDE | numeric | (1,0) | √ |  |  |  |  | 皮肤位置：1：正板，2：背板 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTResourceStateLog — 资源状态记录(共享)（18 字段）
> 主键：GUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 3 | ResourceNo | nvarchar | (50) |  |  |  |  |  | 资源编号：台车或工具编号 |
| 4 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 5 | ResourceTypeNo | nvarchar | (50) |  |  |  |  |  | 资源型号 |
| 6 | ResourceClass | nvarchar | (1) |  |  |  | √ |  | 资源分类：0 SMT_SOLDER_PASTE;锡膏 1 SMT_STENCILS;网板 2 SMT_SQUEEGEE;刮刀 3 SMT_ADHESIVE;红胶 4 SMT_OTHER;其他 5 SMT_FEEDER;Feeder？F SMT_FEEDER;Feeder 6 SMT_MFU;台车：M：SMT_MFU;台车 7 SMT_REEL;Reel：R：SMT_REEL;Reel |
| 7 | ResourceState | nvarchar | (4) |  |  |  |  |  | 资源状态：0 SMT_IN_INV;在库 10 SMT_ISSUED;已领用 20 SMT_WARM_UP;回温开始  30 SMT_WARM_END;回温完成 40 SMT_MAT_MOUNT;已上料 50 SMT_MFU_MOUNT;已上台车 60 SMT_ON_WORK;已上线 70 SMT_REPAIRE;维修 80 SMT_SCRAP;报废 90 SMT_IDLE;闲置 21 SMT_CLEANING;清洗中 31 SMT_CLEANED;清洗完成 |
| 8 | ResourceAction | nvarchar | (4) |  |  |  |  |  | 执行动作：0 SMT_OFF_WORK;下线 下料  1 SMT_RETURN;归还  2 SMT_CHECK;检测  3 SMT_MAINTAIN;保养 维护 5 SMT_REPAIR_COMPLETED;维修完成  10 SMT_ISSUE;领用  20 SMT_WARM_UP;回温开始  30 SMT_WARM_END;回温结束  40 SMT_MAT_MOUNT;上料  50 SMT_MFU_MOUNT;上台车  60 SMT_ON_WORK;上线 上料比对  70 SMT_REPAIRE;送修  80 SMT_SCRAP;报废 21 SMT_CLEAN;清洗开始 31 SMT_CLEANED;清洗完成 91 续料时旧料下料 92 续料时新料上料 |
| 9 | StartTime | datetime |  |  |  |  | √ |  | 开始时间：状态开始时间 |
| 10 | EndTime | datetime |  |  |  |  | √ |  | 结束时间：状态结束时间(状态改变时，将当时时间记录与此) |
| 11 | IsActive | numeric | (1,0) |  |  |  | √ |  | 目前状态：0 No  1 Yes 1表示该笔是目前进行中的状态记录 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSMTSlotAreaBasis — 料站区域主档（10 字段）
> 主键：SlotAreaNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SlotAreaNo | nvarchar | (50) | √ |  |  |  |  | 料站区域编号 |
| 2 | SlotAreaName | nvarchar | (50) |  |  |  |  |  | 料站区域名称 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 6 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTToolBasis — 工具主档（36 字段）
> 主键：ToolNo, MAINTENANCECONTROL
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ToolNo | nvarchar | (50) | √ |  |  |  |  | 工具编号 |
| 2 | ToolTypeNo | nvarchar | (50) |  |  |  |  |  | 工具型号 |
| 3 | ToolClass | nvarchar | (1) |  |  |  |  |  | 工具分类：工具分类：下拉选项， 0 SMT_SOLDER_PASTE;锡膏 1 SMT_STENCILS;网板 2 SMT_SQUEEGEE;刮刀 3 SMT_ADHESIVE;红胶 4 SMT_OTHER;其他 8 工装夹具 |
| 4 | CountType | nvarchar | (1) |  |  |  |  | 'C' | 计算方式：0 (C)过帐次数、1 (T)上线时间、2 (I)设备集成 |
| 5 | LifeCount | numeric | (10,1) |  |  |  | √ | 999999 | 寿命上限：寿命用罄不可使用，计算方式为时间时纪录总小时数(小数1位) |
| 6 | UsageCount | numeric | (10,1) |  |  |  | √ | 999999 | 使用上限：使用上限到需保养，计算方式为时间时纪录总小时数(小数1位) |
| 7 | WarningCount | numeric | (10,0) |  |  |  | √ | 95 | 警示上限(%)：整数值 |
| 8 | ActualCount | numeric | (10,5) |  |  |  | √ | 0 | 目前使用：保养后累积使用量(小数一位) |
| 9 | AccCount | numeric | (10,5) |  |  |  | √ | 0 | 累积使用：保养后累积使用量，计算方式为时间时纪录总小时数(小数一位) |
| 10 | WarmupTime | numeric | (10,1) |  |  |  | √ | 0 | 回温限制时数：目前累积使用量，计算方式为时间时纪录总小时数 |
| 11 | OpenedLimitTime | numeric | (10,1) |  |  |  | √ | 999999 | 开封后限制时数：小数一位 当工具分类为锡膏或红胶时，回温限制时数跟开封后限制时数可以填写 |
| 12 | ReturnForceClean | numeric | (1,0) |  |  |  | √ | 0 | 归还前强制清洗：0 No 1 Yes |
| 13 | OnworkForceCheck | numeric | (1,0) |  |  |  | √ | 0 | 上线前强制检测：0 No 1 Yes |
| 14 | ResourceState | nvarchar | (4) |  |  |  |  |  | 资源状态：0 SMT_IN_INV;在库 10 SMT_ISSUED;已领用 20 SMT_START_WARM_UP;回温开始  30 SMT_WARM-UP_FINISH;回温完成 21 SMT_CLEANING;清洗中 31 SMT_CLEANED;清洗完成 60 SMT_ON-WORK;已上线 70 SMT_REPAIRE;维修 80 SMT_SCRAP;报废 |
| 15 | StateStartTime | datetime |  |  |  |  | √ |  | 状态开始时间：目前状态开始时间 |
| 16 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：若已上线，需记录设备编号 |
| 17 | Invalid | numeric | (1,0) |  |  |  | √ | 0 | 作废：0 可用 1 报废 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 20 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 21 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 22 | SecondOpenedLimitTime | numeric | (10,1) |  |  |  |  | 999999 | 二次开封后限制时数：小数一位 当工具分类为锡膏或红胶时，回温限制时数跟开封后限制时数可以填写 |
| 23 | ReceiveForceCheck | numeric | (1,0) |  |  |  |  | 0 | 领用前强制检测：0 No 1 Yes |
| 24 | ReturnForceCheck | numeric | (1,0) |  |  |  |  | 0 | 归还前强制检测：0 No 1 Yes |
| 25 | FRIDGEDATE | datetime |  |  |  |  | √ |  | 冷藏日期：锡膏红胶冷藏日期 |
| 26 | MFGDATE | datetime |  |  |  |  | √ |  | 生产日期：物料生产日期 |
| 27 | FRIDGECOUNT | numeric | (1,0) |  |  |  | √ |  | 冷藏次数：锡膏红胶冷藏次数 |
| 28 | INVALIDDATE | datetime |  |  |  |  | √ |  | 失效日期：失效日期 |
| 29 | MAINTENANCECONTROL | numeric | (1,0) | √ |  |  |  |  | 保养管控模式：正整数 |
| 30 | MAINTENANCECYCLE | numeric | (10,0) |  |  |  | √ |  | 保养周期(天)：正整数 |
| 31 | MAINTENANCEWARNING | numeric | (10,0) |  |  |  | √ |  | 保养预警(天)：正整数 |
| 32 | POSITIONNUM | numeric | (10,0) |  |  |  | √ |  | 容量：正整数 |
| 33 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 34 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 35 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 36 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSMTToolType — 工具型号主档（337 字段）
> 主键：ToolTypeNo, MAINTENANCECONTROL, SPCSERIAL, SPCSERIAL, ERRORNO, AREATYPE, SPCSERIAL, VIOLATIONID, DISPLAYSETNO, VERSION, DISPLAYSETNO, VERSION, QCITEMNO, REPORTNO, FILEVERSION, ERFNO, ATTACHNAME, ERFNO, SERIALNO, ERFNO, HOLDITEMNO, REPORTNO, QCITEMNO, FACTORNO, PARETOREPORTNO, FACTORNO, FACTORSERIAL, FACTORSERIAL, SPCID, FACTORSERIAL, SPCID, STARTTIME, FACTORSERIAL, SPCID, RULENO, FACTORSERIAL, PARAMETERNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ToolTypeNo | nvarchar | (50) | √ |  |  |  |  | 工具型号 |
| 2 | ToolTypeName | nvarchar | (50) |  |  |  |  |  | 型号名称 |
| 3 | ToolClass | nvarchar | (1) |  |  |  |  |  | 工具分类：0 SMT_SOLDER_PASTE;锡膏 1 SMT_STENCILS;网板 2 SMT_SQUEEGEE;刮刀 3 SMT_ADHESIVE;红胶 4 SMT_OTHER;其他 5 SMT_FEEDER;Feeder 6 SMT_MFU;台车 7 铝板 8.工装夹具 |
| 4 | CountType | nvarchar | (20) |  |  |  | √ |  | 计算方式：0 SMT_Count;(C)过帐次数 1 SMT_Time;(T)上线时间 2 SMT_EQI;(I)设备集成 |
| 5 | LifeCount | numeric | (10,1) |  |  |  | √ | 999999 | 寿命上限：寿命用罄不可使用，计算方式为时间时纪录总小时数(小数1位) |
| 6 | UsageCount | numeric | (10,1) |  |  |  | √ | 999999 | 使用上限：使用上限到需保养，计算方式为时间时纪录总小时数(小数1位) |
| 7 | WarningCount | numeric | (10,0) |  |  |  | √ | 95 | 警示上限(%)：整数值 |
| 8 | WarmupTime | numeric | (10,1) |  |  |  | √ | 0 | 回温限制时数：小数一位 当工具分类为锡膏或红胶时，回温限制时数跟开封后限制时数才可以填写 |
| 9 | OpenedLimitTime | numeric | (10,1) |  |  |  | √ | 999999 | 开封后限制时数：小数一位 当工具分类为锡膏或红胶时，回温限制时数跟开封后限制时数可以填写 |
| 10 | ReturnForceClean | numeric | (1,0) |  |  |  | √ | 0 | 归还前强制清洗：0 No 1 Yes |
| 11 | OnworkForceCheck | numeric | (1,0) |  |  |  | √ | 0 | 上线前强制检测：0 No 1 Yes |
| 12 | ToolStatus | nvarchar | (4) |  |  |  | √ |  | 目前状况 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 16 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 17 | SecondOpenedLimitTime | numeric | (10,1) |  |  |  |  | 999999 | 二次开封后限制时数：小数一位 当工具分类为锡膏或红胶时，回温限制时数跟开封后限制时数可以填写 |
| 18 | ReceiveForceCheck | numeric | (1,0) |  |  |  |  | 0 | 领用前强制检测：0 No 1 Yes |
| 19 | ReturnForceCheck | numeric | (1,0) |  |  |  |  | 0 | 归还前强制检测：0 No 1 Yes |
| 20 | POSITIONNUM | numeric | (10,0) |  |  |  | √ |  | 容量：正整数 |
| 21 | MAINTENANCECONTROL | numeric | (1,0) | √ |  |  |  |  | 保养管控模式：正整数 |
| 22 | MAINTENANCECYCLE | numeric | (10,0) |  |  |  | √ |  | 保养周期(天)：正整数 |
| 23 | MAINTENANCEWARNING | numeric | (10,0) |  |  |  | √ |  | 保养预警(天)：正整数 |
| 24 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | QCATTSPSERIAL | nvarchar | (4000) |  |  |  | √ |  | QC Att Sp Serial |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 7 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 8 | RETESTLOTNO | nvarchar | (55) |  |  |  | √ |  | Retest Lot No |
| 9 | SAMPLEQTY | numeric | (12,4) |  |  |  | √ |  | 抽样数 |
| 10 | GOODQTY | numeric | (12,4) |  |  |  | √ |  | 良品数 |
| 11 | SCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 损坏数 |
| 12 | DEFECTQTY | numeric | (12,4) |  |  |  | √ |  | 缺点数 |
| 13 | RESULT | numeric | (1,0) |  |  |  | √ | 0 | 结果：0：合格  1：提示  3：异常  4：警告 |
| 14 | ERFNO | nvarchar | (20) |  |  |  | √ |  | 异常单编号 |
| 15 | EXCLUDED | numeric | (1,0) |  |  |  | √ | 0 | 排除 |
| 16 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 17 | RANK | nvarchar | (5) |  |  |  | √ |  | 等级 |
| 18 | RANKDETAIL | nvarchar | (10) |  |  |  | √ |  | 等级明细 |
| 19 | MO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 20 | Product | varchar | (50) |  |  |  | √ | '*' |  |
| 21 | QCCategory_PRD | varchar | (50) |  |  |  | √ | '*' |  |
| 22 | OP | nvarchar | (50) |  |  |  | √ | '*' |  |
| 23 | MATERIAL | nvarchar | (50) |  |  |  | √ | '*' |  |
| 24 | QCCATEGORY_MTL | nvarchar | (50) |  |  |  | √ | '*' |  |
| 25 | MTLVendor | varchar | (50) |  |  |  | √ | '*' |  |
| 26 | Employee | varchar | (50) |  |  |  | √ | '*' |  |
| 27 | Customer | varchar | (50) |  |  |  | √ | '*' |  |
| 28 | FACTOR1 | varchar | (50) |  |  |  | √ | '*' |  |
| 29 | MEMO | nvarchar | (300) |  |  |  | √ |  | 备注 |
| 30 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 31 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 32 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 33 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 34 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | QCATTSPSERIAL | nvarchar | (4000) |  |  |  | √ |  | QC Att Sp Serial |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | ERRORNO | nvarchar | (20) | √ |  |  |  |  | 不良原因编号 |
| 5 | ERRORQTY | numeric | (12,4) |  |  |  | √ |  | 不良数量 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 8 | AREATYPE | nvarchar | (10) | √ |  |  |  | '2' | 区域类别 |
| 9 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 10 | RANK1 | numeric | (12,4) |  |  |  | √ | 0 | 等级1数量 |
| 11 | RANK2 | numeric | (12,4) |  |  |  | √ | 0 | 等级2数量 |
| 12 | RANK3 | numeric | (12,4) |  |  |  | √ | 0 | 等级3数量 |
| 13 | RANK4 | numeric | (12,4) |  |  |  | √ | 0 | 等级4数量 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | VIOLATIONID | nvarchar | (100) | √ |  |  |  |  | 违反法则编号 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | DISPLAYSETNO | nvarchar | (50) | √ |  |  |  |  | 显示设置编号 |
| 2 | DISPLAYSETNAME | nvarchar | (50) |  |  |  |  |  | 显示设置名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 4 | ENABLED | numeric | (1,0) |  |  |  |  | 0 | 是否启用：0 不启用 1 启用 |
| 5 | VERSION | nvarchar | (50) | √ |  |  |  |  | 版本 |
| 6 | VERSIONCOMMENT | nvarchar | (100) |  |  |  | √ |  | 版本修改备注 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 11 | REPORTNO | nvarchar | (500) |  |  |  | √ |  | 检验报告范本编号 |
| 12 | ErrorReasonDetail | numeric | (1,0) |  |  |  | √ |  | 显示异常原因明细：0 否、1 是 |
| 13 | PageByQCFormNo | numeric | (1,0) |  |  |  | √ |  | 依检验单号分页显示：0 否、1 是 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | DISPLAYSETNO | nvarchar | (50) | √ |  |  |  |  | 显示设置编号 |
| 2 | VERSION | nvarchar | (50) | √ |  |  |  |  | 版本 |
| 3 | QCITEMTYPE | numeric | (1,0) |  |  |  |  |  | 品管项目类别：0：计数? 1：计量 |
| 4 | QCOBJECTTYPE | numeric | (1,0) |  |  |  |  |  | 检验标的类别 |
| 5 | QCITEMNO | nvarchar | (50) | √ |  |  |  |  | 品管项目编号 |
| 6 | REORDER | numeric | (3,0) |  |  |  | √ |  | 排序：可手动填写1~999 |
| 7 | PRINTING | numeric | (1,0) |  |  |  |  |  | 是否打印：0 不显示在检验报告 1 显示在检验报告 |
| 8 | SPECNAMECHANGE | nvarchar | (200) |  |  |  | √ |  | 规格显示替换 |
| 9 | RESULTCHANGE | numeric | (1,0) |  |  |  |  |  | 品管项目判定结果转换：0 不转换 1 转换,?合格或不合格内容依PASS、字段数据覆盖 |
| 10 | PASS | nvarchar | (50) |  |  |  | √ |  | 合格 |
| 11 | NG | nvarchar | (50) |  |  |  | √ |  | 不合格 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | REPORTNO | nvarchar | (50) | √ |  |  |  |  | 模板编号 |
| 2 | REPORTNAME | nvarchar | (50) |  |  |  |  |  | 模板名称 |
| 3 | REPORTTYPE | numeric | (1,0) |  |  |  |  |  | 模板类别：0：VAR+ATT(共用页面), 1 VAR+ATT(分开页面), 2 VAR, 3 ATT |
| 4 | REPORTCONTEXT_VAR | nvarchar | (-1) |  |  |  | √ |  | 计量报告样板格式 |
| 5 | REPORTCONTEXT_ATT | nvarchar | (-1) |  |  |  | √ |  | 计数报告样板格式 |
| 6 | FILEVERSION | numeric | (3,0) | √ |  |  |  |  | 版本 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 11 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 12 | VERSIONCOMMENT | nvarchar | (4000) |  |  |  | √ |  | 版本修改备注 |
| 13 | ReportType_SH | numeric | (1,0) |  |  |  | √ | NULL | 模板类别(直、横式)：0 直式 1 直式(数据最大最小值) 2 直式(实际数据) 3 横式(实际数据) |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | ERFNO | nvarchar | (20) | √ |  |  |  |  | 异常单编号 |
| 2 | ATTACHNAME | nvarchar | (50) | √ |  |  |  |  | 附档名称 |
| 3 | ATTACHBODY | varbinary | (-1) |  |  |  | √ |  | 附档 |
| 1 | ERFNO | nvarchar | (20) | √ |  |  |  |  | 异常单编号 |
| 2 | QCLOTNO | nvarchar | (4000) |  |  |  | √ |  | 检验批号 |
| 3 | STATUS | numeric | (2,0) |  |  |  | √ | 0 | 状态：0：新单开立  1：处理中  2：结案   3：取消   Before  4：转8D 99：结案中 After  5  结案中 |
| 4 | ERFSOURCE | numeric | (1,0) |  |  |  | √ | 1 | 异常单来源：1：SPC  2：MES  3：其他 |
| 5 | MCLASSNO | nvarchar | (30) |  |  |  |  |  | 主分类编号： |
| 6 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 7 | CUSTOMERNO | nvarchar | (4000) |  |  |  | √ |  | 客户编号 |
| 8 | VENDORNO | nvarchar | (20) |  |  |  | √ |  | 供应商编号 |
| 9 | UNIT | nvarchar | (30) |  |  |  | √ |  | 单位 |
| 10 | INVENTORYNO | nvarchar | (20) |  |  |  | √ |  | 仓库编号 |
| 11 | PROJECTNO | nvarchar | (4000) |  |  |  | √ |  | 项目代号 |
| 12 | PRODUCTSERIALNO | nvarchar | (4000) |  |  |  | √ |  | 成品序号 |
| 13 | MAINDEPARTMENT | nvarchar | (4000) |  |  |  | √ |  | 责任部门 |
| 14 | CREATEDEPARTMENTNO | nvarchar | (20) |  |  |  | √ |  | 创建部门 |
| 15 | SPEC | nvarchar | (500) |  |  |  | √ |  | 规格 |
| 16 | CREATOR | nvarchar | (100) |  |  |  | √ |  | 创建人员 |
| 17 | CURGROUPNO | nvarchar | (20) |  |  |  | √ |  | 目前群组编号 |
| 18 | FIRSTGROUP | nvarchar | (20) |  |  |  | √ |  | 第一处理群组 |
| 19 | FINALGROUP | nvarchar | (20) |  |  |  | √ |  | 最后处理群组 |
| 20 | PRODUCTNO | nvarchar | (4000) |  |  |  | √ |  | 产品编号 |
| 21 | EQUIPMENTNO | nvarchar | (4000) |  |  |  | √ |  | 设备编号 |
| 22 | HOLDTIME | numeric | (1,0) |  |  |  | √ |  | 处理时间 |
| 23 | DUTYDEPARTMENTNO | nvarchar | (20) |  |  |  | √ | 'N/A' | 责任部门 |
| 24 | INSPECTQTY | numeric | (12,4) |  |  |  | √ |  | 检验数量 |
| 25 | REJECTQTY | numeric | (12,4) |  |  |  | √ |  | 拒收数量 |
| 26 | SCRAPQTY | numeric | (12,4) |  |  |  | √ |  | 损坏数量 |
| 27 | RELEASER | nvarchar | (10) |  |  |  | √ |  | 结案人 |
| 28 | RONO | nvarchar | (4000) |  |  |  | √ |  | 订单编号 |
| 29 | MONO | nvarchar | (4000) |  |  |  | √ |  | 工单编号 |
| 30 | AREANO | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 31 | QCFORMTYPE | nvarchar | (4000) |  |  |  | √ |  | 检验单类型：1：IQC  2：PQC  3：FQC  4：OQC  99：其他 |
| 32 | PRIORITY | numeric | (1,0) |  |  |  | √ |  | 优先权 |
| 33 | SOURCEFORMNO | nvarchar | (50) |  |  |  | √ |  | 来源单号 |
| 34 | ERFOBJECT | numeric | (1,0) |  |  |  | √ |  | 异常标的：1 物料  2 产品  3 设备  4 作业站  5 部门   6 其他 |
| 35 | ERFOBJECTNO | nvarchar | (4000) |  |  |  | √ |  | 异常标的编号 |
| 36 | ITEMNO | nvarchar | (4000) |  |  |  | √ |  | 项目编号 |
| 37 | SITENO | nvarchar | (4000) |  |  |  | √ |  | 厂区编号 |
| 38 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 39 | DISPDESCRIPTION | nvarchar | (500) |  |  |  | √ |  | 处理说明 |
| 40 | RELEASEDESCRIPTION | nvarchar | (500) |  |  |  | √ |  | 结案综合描述 |
| 41 | HOLDDESCRIPTION | nvarchar | (-1) |  |  |  | √ |  | 异常说明 |
| 42 | MATERIALCOST | numeric | (12,4) |  |  |  | √ |  | 材料成本 |
| 43 | LABORCOST | numeric | (12,4) |  |  |  | √ |  | 人工成本 |
| 44 | OTHERCOST | numeric | (12,4) |  |  |  | √ |  | 其他成本 |
| 45 | EXTERNALFAILURECOST | numeric | (12,4) |  |  |  | √ |  | 外部失败成本 |
| 46 | EXTERNALFAILUREMEMO | nvarchar | (500) |  |  |  | √ |  | 外部成本注记 |
| 47 | TOTALCOST | numeric | (12,4) |  |  |  | √ |  | 总异常成本 |
| 48 | RELEASEMEMO | nvarchar | (500) |  |  |  | √ |  | 结案注记 |
| 49 | SUPPLEMENT | nvarchar | (500) |  |  |  | √ |  | 后记补述 |
| 50 | OPGROUPNO | nvarchar | (4000) |  |  |  | √ |  | 作业站群组编号 |
| 51 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 52 | RELEASEDATE | datetime |  |  |  |  | √ |  | 结案日期 |
| 53 | REVIEWABLE | numeric | (1,0) |  |  |  | √ |  | 已审查：0：尚未审查  1：审查完成 |
| 54 | REVIEWER | nvarchar | (10) |  |  |  | √ |  | 指定审查人员 |
| 55 | REVIEWDATE | datetime |  |  |  |  | √ |  | 审查日期 |
| 56 | DUTYOPNO | nvarchar | (4000) |  |  |  | √ |  | 责任站别 |
| 57 | DUTYEQUIPMENTNO | nvarchar | (4000) |  |  |  | √ |  | 责任机台 |
| 58 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 59 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 60 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 61 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SERIALNO | nvarchar | (50) | √ |  |  |  |  | 序号 |
| 2 | ERFNO | nvarchar | (20) |  |  |  |  |  | 异常单编号 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | DISPDESCRIPTION | nvarchar | (500) |  |  |  | √ |  | 处置说明 |
| 6 | DISPHOURS | numeric | (12,4) |  |  |  | √ |  | 工时 |
| 7 | MATERIALCHANGEMEMO | nvarchar | (500) |  |  |  | √ |  | 更换材料注记 |
| 8 | NEXTGROUPNO | nvarchar | (20) |  |  |  | √ |  | 下一个群组编号 |
| 9 | CHECKABLE | numeric | (1,0) |  |  |  | √ | 0 | 验证否：0：未验  1：已验 |
| 10 | DISPRESULT | numeric | (1,0) |  |  |  | √ |  | 处置结果：0：OK  1：NG |
| 11 | DISPRESULTDESCRIPTION | nvarchar | (500) |  |  |  | √ |  | 处置结果说明 |
| 12 | DISPOSEFINISHDATE | datetime |  |  |  |  | √ |  | 处置完成日 |
| 13 | VERIFYRESULT | numeric | (1,0) |  |  |  | √ |  | 验证结果：0：OK  1：NG |
| 14 | VERIFYRESULTDESCRIPTION | nvarchar | (500) |  |  |  | √ |  | 验证结果说明 |
| 15 | VERIFYHOURS | numeric | (12,4) |  |  |  | √ | 0 | 验证工时 |
| 16 | VERIFYFINISHDATE | datetime |  |  |  |  | √ |  | 验证完成日 |
| 17 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 18 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 19 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | UserId | nvarchar | (10) |  |  |  |  |  | 用户编号 |
| 2 | RECORDDATE | datetime |  |  |  |  |  |  | 记录时间 |
| 3 | ERFNO | nvarchar | (20) |  |  |  |  |  | 异常单编号 |
| 4 | DATALOG | nvarchar | (500) |  |  |  |  |  | 数据纪录 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 描述 |
| 1 | ERFNO | nvarchar | (20) | √ |  |  |  |  | 异常单编号 |
| 2 | HOLDITEMNO | nvarchar | (50) | √ |  |  |  |  | 异常原因编号 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | REPORTNO | nvarchar | (25) | √ |  |  |  |  | 月报表编码 |
| 2 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 3 | FACTORNO | nvarchar | (30) | √ |  |  |  |  | 要因编号 |
| 4 | FACTORVALUE | nvarchar | (1100) |  |  |  | √ |  | 要因值 |
| 5 | MAIN | nvarchar | (25) |  |  |  | √ |  | 主品管项目 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PARETOREPORTNO | nvarchar | (25) | √ |  |  |  |  | 柏拉图分析编号 |
| 2 | QCITEMNO | nvarchar | (500) |  |  |  |  |  | 品管项目编号 |
| 3 | QCITEMTYPE | nvarchar | (25) |  |  |  |  |  | 品管项目类别：0：计数 1：计量 |
| 4 | FACTORNO | nvarchar | (500) | √ |  |  |  |  | 要因编号 |
| 5 | FACTORVALUE | nvarchar | (1100) |  |  |  | √ |  | 要因值 |
| 6 | COUNTUNIT | nvarchar | (10) |  |  |  |  |  | 计算单位 |
| 7 | SCRAP | nvarchar | (10) |  |  |  |  |  | 损坏 |
| 8 | DEFECT | nvarchar | (10) |  |  |  |  |  | 验退 |
| 9 | NORMAL | nvarchar | (10) |  |  |  |  |  | 一般 |
| 10 | EXCLUDED | nvarchar | (10) |  |  |  |  |  | 排除 |
| 1 | FACTORSERIAL | nvarchar | (50) | √ |  |  |  |  | 因子序号 |
| 2 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | SAMPLESIZE | numeric | (5,0) |  |  |  |  |  | 样本数 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 7 | KEYNODE | nvarchar | (1) |  |  |  | √ | 'N' | Key Node |
| 8 | SPONSOR | nvarchar | (4000) |  |  |  | √ |  | 发起人 |
| 9 | CHARTTITLE | nvarchar | (4000) |  |  |  | √ |  | 管制图标题 |
| 10 | ISSHORTRUNCHART | numeric | (1,0) |  |  |  |  | 0 | ISSHORTRUNCHART |
| 11 | PLANNO | nvarchar | (100) |  |  |  | √ |  | 抽样计划编号 |
| 12 | CHARTUNIT | nvarchar | (30) |  |  |  | √ |  | 单位 |
| 13 | MO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 14 | PRODUCT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 15 | QCCATEGORY_PRD | nvarchar | (61) |  |  |  | √ | '*' |  |
| 16 | MATERIAL | nvarchar | (61) |  |  |  | √ | '*' |  |
| 17 | QCCATEGORY_MTL | nvarchar | (61) |  |  |  | √ | '*' |  |
| 18 | OP | nvarchar | (61) |  |  |  | √ | '*' |  |
| 19 | INVENTORYNO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 20 | EQUIPMENT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 21 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 22 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 23 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FACTORSERIAL | nvarchar | (50) | √ |  |  |  |  | 因子序号 |
| 2 | SPCID | numeric | (2,0) | √ |  |  |  |  | 管制图程式码：0  Trend 1 X-Bar 2  R 3 S 4  RM |
| 3 | US | nvarchar | (15) |  |  |  | √ |  | 规格上限 |
| 4 | LS | nvarchar | (15) |  |  |  | √ |  | 规格下限 |
| 5 | UCL | nvarchar | (15) |  |  |  | √ |  | 管制上限 |
| 6 | LCL | nvarchar | (15) |  |  |  | √ |  | 管制下限 |
| 7 | CL | nvarchar | (15) |  |  |  | √ |  | 管制中心 |
| 8 | TARGET | nvarchar | (10) |  |  |  | √ |  | 目标 |
| 9 | CPKGOAL | nvarchar | (10) |  |  |  | √ |  | CPK目标值 |
| 10 | YAXISFROM | nvarchar | (10) |  |  |  | √ |  | 管制图上显示之Y轴座标值范围下限 |
| 11 | YAXISTO | nvarchar | (10) |  |  |  | √ |  | 管制图上显示之Y轴座标值范围上限 |
| 12 | CS | nvarchar | (15) |  |  |  | √ |  | 规格中心值 |
| 13 | SPEC | nvarchar | (100) |  |  |  | √ |  | 检验规格 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 建立日期 |
| 16 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 17 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FACTORSERIAL | nvarchar | (50) | √ |  |  |  |  | 因子序号 |
| 2 | SPCID | nvarchar | (10) | √ |  |  |  |  | 管制图代码：0  Trend 1 X-Bar 2  R 3 S 4  RM |
| 3 | US | nvarchar | (15) |  |  |  | √ |  | 规格上限 |
| 4 | LS | nvarchar | (15) |  |  |  | √ |  | 规格下限 |
| 5 | UCL | nvarchar | (15) |  |  |  | √ |  | 管制上限 |
| 6 | LCL | nvarchar | (15) |  |  |  | √ |  | 管制下限 |
| 7 | CL | nvarchar | (15) |  |  |  | √ |  | 管制中心 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | STARTTIME | datetime |  | √ |  |  |  |  | 开始时间 |
| 10 | TARGET | nvarchar | (10) |  |  |  | √ |  | 目标 |
| 11 | CPKGOAL | nvarchar | (10) |  |  |  | √ |  | CPK目标值 |
| 12 | YAXISFROM | nvarchar | (10) |  |  |  | √ |  | 管制图上显示之Y轴坐标值范围下限 |
| 13 | YAXISTO | nvarchar | (10) |  |  |  | √ |  | 管制图上显示之Y轴坐标值范围上限 |
| 14 | CS | nvarchar | (15) |  |  |  | √ |  | 规格中心值 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 16 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 17 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | FACTORSERIAL | nvarchar | (50) | √ |  |  |  |  | 因子序号 |
| 2 | SPCID | nvarchar | (10) | √ |  |  |  |  | 管制图 |
| 3 | RULENO | nvarchar | (20) | √ |  |  |  |  | 法则编号 |
| 4 | ACTION | numeric | (1,0) |  |  |  |  |  | 动作 |
| 5 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  | √ |  | 设备状态 |
| 6 | ERFSTATE | numeric | (1,0) |  |  |  | √ |  | 异常单状态 |
| 7 | EMAILSTATE | numeric | (1,0) |  |  |  | √ |  | E-Mail状态 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FACTORSERIAL | nvarchar | (50) | √ |  |  |  |  | 因子序号 |
| 2 | PARAMETERNO | nvarchar | (20) | √ |  |  |  |  | 参数编号 |
| 3 | PARAMETERVALUE | nvarchar | (4000) |  |  |  | √ |  | 参数值 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
