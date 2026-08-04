# 07 工价/作业站 (OPM/OP)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 10 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblOPLeanProperty](#tblopleanproperty) | 作业站检验项目设定 | 13 |
| [tblOPMEQP](#tblopmeqp) | 设备工价表 | 16 |
| [tblOPMOP](#tblopmop) | 作业站工价表 | 16 |
| [tblOPMOPSUBOP](#tblopmopsubop) | 作业站子作业工价表 | 18 |
| [tblOPMOtherReason](#tblopmotherreason) | 其他工价原因主档 | 11 |
| [tblOPMPRDOP](#tblopmprdop) | 产品作业站工价表 | 19 |
| [tblOPMPRDOPSUBOP](#tblopmprdopsubop) | 产品作业站子作业工价表 | 20 |
| [tblOPMSUBOP](#tblopmsubop) | 子作业工价表 | 17 |
| [tblOPMUpdateLog](#tblopmupdatelog) | 人员工价修改记录表 | 99 |
| [tblOPWait](#tblopwait) | 作业站暂停设定 | 576 |

---

### tblOPLeanProperty — 作业站检验项目设定（13 字段）
> 主键：OpNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OpNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 2 | WIP | numeric | (12,4) |  |  |  |  | 0 | 在制品浪费 |
| 3 | Wait | numeric | (12,4) |  |  |  |  | 0 | 等待浪费 |
| 4 | Defect | numeric | (12,4) |  |  |  |  | 0 | 缺陷浪费 |
| 5 | Excess | numeric | (12,4) |  |  |  |  | 0 | 多生产浪费 |
| 6 | QtyPrice | numeric | (12,4) |  |  |  |  | 0 | 数量单价 |
| 7 | TimePrice | numeric | (12,4) |  |  |  |  | 0 | 时间单价 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 13 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblOPMEQP — 设备工价表（16 字段）
> 主键：EquipmentNo, EffectDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型 |
| 3 | PieceUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计件急价 |
| 4 | PiecePrice | numeric | (23,8) |  |  |  | √ |  | 计件标价 |
| 5 | PieceRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计件返价 |
| 6 | TimeUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计时急价 |
| 7 | TimePrice | numeric | (23,8) |  |  |  | √ |  | 计时标价 |
| 8 | TimeRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计时返价 |
| 9 | Isabled | numeric | (1,0) |  |  |  |  | 1 | 是否启用 |
| 10 | EffectDate | datetime |  | √ |  |  |  |  | 生效时间 |
| 11 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMOP — 作业站工价表（16 字段）
> 主键：OpNo, EffectDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型 |
| 3 | PieceUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计件急价 |
| 4 | PiecePrice | numeric | (23,8) |  |  |  | √ |  | 计件标价 |
| 5 | PieceRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计件返价 |
| 6 | TimeUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计时急价 |
| 7 | TimePrice | numeric | (23,8) |  |  |  | √ |  | 计时标价 |
| 8 | TimeRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计时返价 |
| 9 | Isabled | numeric | (1,0) |  |  |  |  | 1 | 是否启用 |
| 10 | EffectDate | datetime |  | √ |  |  |  |  | 生效时间 |
| 11 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMOPSUBOP — 作业站子作业工价表（18 字段）
> 主键：OpNo, SUBOPNo, EffectDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | SUBOPNo | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 3 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型 |
| 4 | PieceUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计件急价 |
| 5 | PiecePrice | numeric | (23,8) |  |  |  | √ |  | 计件标价 |
| 6 | PieceRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计件返价 |
| 7 | TimeUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计时急价 |
| 8 | TimePrice | numeric | (23,8) |  |  |  | √ |  | 计时标价 |
| 9 | TimeRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计时返价 |
| 10 | Isabled | numeric | (1,0) |  |  |  |  | 1 | 是否启用 |
| 11 | EffectDate | datetime |  | √ |  |  |  |  | 生效时间 |
| 12 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMOtherReason — 其他工价原因主档（11 字段）
> 主键：OtherReasonNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OtherReasonNo | nvarchar | (255) | √ |  |  |  |  | 工价原因 |
| 2 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型：0：按数量 1：按时间 |
| 3 | UnitPrice | numeric | (23,8) |  |  |  | √ |  | 单价 |
| 4 | IsModify | numeric | (1,0) |  |  |  |  | 1 | 是否可修改 |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMPRDOP — 产品作业站工价表（19 字段）
> 主键：ProductNo, ProductVersion, OpNo, EffectDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型：0：计件 1：计时 2：两者都有 |
| 5 | PieceUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计件急价 |
| 6 | PiecePrice | numeric | (23,8) |  |  |  | √ |  | 计件标价 |
| 7 | PieceRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计件返价 |
| 8 | TimeUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计时急价 |
| 9 | TimePrice | numeric | (23,8) |  |  |  | √ |  | 计时标价 |
| 10 | TimeRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计时返价 |
| 11 | Isabled | numeric | (1,0) |  |  |  |  | 1 | 是否启用 |
| 12 | EffectDate | datetime |  | √ |  |  |  |  | 生效时间 |
| 13 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMPRDOPSUBOP — 产品作业站子作业工价表（20 字段）
> 主键：ProductNo, ProductVersion, OpNo, SUBOPNo, EffectDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | SUBOPNo | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 5 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型：0：计件 1：计时 2：两者都有 |
| 6 | PieceUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计件急价 |
| 7 | PiecePrice | numeric | (23,8) |  |  |  | √ |  | 计件标价 |
| 8 | PieceRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计件返价 |
| 9 | TimeUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计时急价 |
| 10 | TimePrice | numeric | (23,8) |  |  |  | √ |  | 计时标价 |
| 11 | TimeRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计时返价 |
| 12 | Isabled | numeric | (1,0) |  |  |  |  | 1 | 是否启用 |
| 13 | EffectDate | datetime |  | √ |  |  |  |  | 生效时间 |
| 14 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMSUBOP — 子作业工价表（17 字段）
> 主键：SUBOPNo, EffectDate
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SUBOPNo | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 2 | PriceType | numeric | (1,0) |  |  |  |  | 0 | 工价类型：0：计件 1：计时 2：两者都有 |
| 3 | PieceUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计件急价 |
| 4 | PiecePrice | numeric | (23,8) |  |  |  | √ |  | 计件标价 |
| 5 | PieceRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计件返价 |
| 6 | TimeUrgPrice | numeric | (23,8) |  |  |  | √ |  | 计时急价 |
| 7 | TimePrice | numeric | (23,8) |  |  |  | √ |  | 计时标价 |
| 8 | TimeRedoPrice | numeric | (23,8) |  |  |  | √ |  | 计时返价 |
| 9 | Isabled | numeric | (1,0) |  |  |  |  | 1 | 是否启用 |
| 10 | EffectDate | datetime |  | √ |  |  |  |  | 生效时间 |
| 11 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOPMUpdateLog — 人员工价修改记录表（99 字段）
> 主键：OPNO, PROPERTYNO, OPNO, REASONNO, ProductNo, ProductVersion, FailedReason, REASONNO, OPNO, SUBOPNO, OPTYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  |  |  | Log序号 |
| 2 | RESCLASS | numeric | (12,4) |  |  |  |  |  | 资源大分类 |
| 3 | RESVALUE | numeric | (12,4) |  |  |  |  |  | 人时 |
| 4 | INPUTQTY | numeric | (12,4) |  |  |  |  |  | 数量 |
| 5 | USERNO | nvarchar | (50) |  |  |  |  |  | 用户编号 |
| 6 | EVENTTIME | datetime |  |  |  |  | √ |  | 出站时间 |
| 7 | PriceType | numeric | (1,0) |  |  |  |  |  | 工价类型 |
| 8 | FromUnitPrice | numeric | (23,8) |  |  |  |  |  | 单价 |
| 9 | FromPriceRate | numeric | (23,8) |  |  |  |  |  | 职称工价系数 |
| 10 | ToPriceType | numeric | (1,0) |  |  |  |  |  | 新工价类型 |
| 11 | TounitPrice | numeric | (23,8) |  |  |  | √ |  | 新单价 |
| 12 | ToPriceRate | numeric | (23,8) |  |  |  | √ |  | 新职称工价系数 |
| 13 | CreateReason | nvarchar | (255) |  |  |  | √ |  | 修改原因 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号：属性编号设置时，开窗之数据源为「系统管理模块-特性设置」功能设置之数据 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 默认值 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  |  | 0 | 签核状态：0 Unfrozen(未签核)1 Pending(签核中) 2 Active(已签核)-1 Unused(不使用) |
| 7 | PrintCopies | numeric | (2,0) |  |  |  | √ |  | 打印份数：用于BarTenderInCo属性配置标签打印份数 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLOPTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 14 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 15 | TBLOPAREAGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 原因编号 |
| 3 | REASONNAME | nvarchar | (50) |  |  |  | √ |  | 原因名称 |
| 4 | REASONTYPE | numeric | (2,0) |  |  |  | √ |  | 原因型别：0：首检 1：巡检 3：自检 4：末检 5：自检&首检 6：自检&巡检 7：自检&末检 2：首检&巡检 8：首检&末检 9：巡检&末检 10：自检&首检&巡检 11：自检&首检&末检 12：自检&巡检&末检 13：首检&巡检&末检 14：自检&首检&巡检&末检 |
| 5 | REASONDESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 检验标准 |
| 6 | PICTUREPATH | nvarchar | (255) |  |  |  | √ |  | 图片 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | REASONMETHOD | nvarchar | (255) |  |  |  | √ |  | 检验方式 |
| 10 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号：#78487添加此栏位为主键之一 |
| 11 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本：#78487添加此栏位为主键之一 |
| 12 | CheckType | numeric | (1,0) |  |  |  |  | 0 | 检验型别 |
| 13 | MaxiValue | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 14 | MiniValue | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 15 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 16 | ISINPUTSCRAP | numeric | (1,0) |  |  |  | √ |  | 不合格是否需录入不良 |
| 17 | TBLQCREASONDETAILGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 18 | OPSEQ | nvarchar | (4) |  |  |  | √ |  | 工序 |
| 19 | OPSEQTPYE | nvarchar | (4) |  |  |  | √ |  | 工序型别：1 SMT工序;2 工位机工序 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 23 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 24 | TBLPRDPRODUCTPROCESSGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 2 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 3 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 4 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 5 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 6 | FailedReason | nvarchar | (50) | √ |  |  |  |  | 失败记录 |
| 7 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 检验编号 |
| 8 | REASONNAME | nvarchar | (50) |  |  |  | √ |  | 检验名称 |
| 9 | REASONMETHOD | nvarchar | (50) |  |  |  | √ |  | 检验方式 |
| 10 | PICTUREPATH | nvarchar | (255) |  |  |  | √ |  | 文档名称 |
| 11 | REASONTYPE | numeric | (2,0) |  |  |  | √ |  | 原因类别 |
| 12 | REASONDESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 检验标准 |
| 13 | CHECKTYPE | numeric | (1,0) |  |  |  |  |  | 检验类型 |
| 14 | MINIVALUE | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 15 | MAXIVALUE | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 16 | ISINPUTSCRAP | numeric | (1,0) |  |  |  | √ |  | 不合格是否需录不良 |
| 17 | DESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 描述 |
| 18 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 19 | PRODUCTNO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 20 | ImportNo | nvarchar | (50) |  |  |  | √ |  | 导入编号 |
| 21 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 自动签核 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | SUBOPNO | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 3 | SUBOPORDER | numeric | (6,0) |  |  |  |  | 0 | 显示顺序 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | PD102_TBLPRDSUBOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | GUID：GUID |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 11 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | OPTYPE | nvarchar | (20) | √ |  |  |  |  | 作业站类别 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |

---

### tblOPWait — 作业站暂停设定（576 字段）
> 主键：OpNo, WaitNo, ORDERNO, OPNO, PDLINENO, POSITIONNO, ERRORNO, BREAKDOWNNO, BREAKDOWNSERIALNO, BREAKDOWNNO, GUID, TASKNO, MAINTENANCEMANID, TASKNO, PMEQPSOPNO, EQUIPMENTNO, PMSERIALNO, PMEQPSOPNO, EQUIPMENTNO, PMSERIALNO, GUID, GUID, TASKNO, PMEQPSOPNO, TASKNO, MAINTENANCEMANID, EQUIPMENTNO, PMSOPNO, EQUIPMENTNO, PMSOPNO, FREQUENCYNO, PMJOBNO, PMITEMNO, MAINTAINNO, TASKNO, PMITEMNO, REPAIRNO, PMSOPNO, EQUIPMENTNO, PMSOPNO, PMSOPNO, PMITEMNO, SUBSTITUTIONNO, SUBSTITUTIONNO, TASKNO, SUBSTITUTIONNO, GROUPNO, GROUPNO, SUBSTITUTIONNO, SUBSTITUTIONTYPE, PMITEMNO, SUBSTITUTIONNO, VENDORNO, CONTACTORNAME, VENDORNO, SUBSTITUTIONNO, VENDORNO, PMITEMNO, TOOLNO, WONO, WONO, WONO, WOITEMNO, WONO, WOITEMNO, SID, PRODUCTNO, ACCESSORYTYPE, ACCESSORYNO, PRODUCTVERSION, OPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | WaitNo | nvarchar | (20) | √ |  |  |  |  | 暂停原因编号 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 9 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLQCREASONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ORDERNO | nvarchar | (50) | √ |  |  |  |  | 命令编号 |
| 2 | ORDERNAME | nvarchar | (50) |  |  |  |  |  | 命令名称 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线别编号：区域编号 |
| 3 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 4 | ERRORNO | nvarchar | (20) | √ |  |  |  |  | 不良原因编号：进行不良原因的选择 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | BREAKDOWNNO | nvarchar | (20) | √ |  |  |  |  | 故障编号：故障编号 |
| 2 | BREAKDOWNCAUSE | nvarchar | (50) |  |  |  |  |  | 故障原因 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQPSERIALNO | nvarchar | (20) |  |  |  |  |  | 设备序号：设备序号 |
| 2 | BREAKDOWNSERIALNO | nvarchar | (20) |  |  |  |  |  | 故障序号：故障序号 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号：设备编号 |
| 4 | BREAKDOWNSTARTTIME | datetime |  |  |  |  |  |  | 故障开始日期：故障开始日期 |
| 5 | BREAKDOWNENDTIME | datetime |  |  |  |  |  |  | 故障结束日期：故障结束日期 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQPSERIALNO | nvarchar | (20) |  |  |  |  |  | 设备序号：设备序号 |
| 2 | BREAKDOWNSERIALNO | nvarchar | (20) |  |  |  |  |  | 故障序号：故障序号 |
| 3 | BREAKDOWNNO | nvarchar | (20) |  |  |  |  |  | 故障编号：故障编号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | BREAKDOWNSERIALNO | nvarchar | (20) | √ |  |  |  |  | 故障序号：故障序号 |
| 2 | BREAKDOWNNO | nvarchar | (20) | √ |  |  |  |  | 故障编号：故障编号 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 自动生成GUID |
| 2 | TASKNO | nvarchar | (50) |  |  |  |  |  | 任务单编号 |
| 3 | DISPATCHERSID | nvarchar | (50) |  |  |  |  |  | 派工人员编号 |
| 4 | DISPATCHERS | nvarchar | (50) |  |  |  |  |  | 派工人 |
| 5 | DISPATCHTIME | datetime |  |  |  |  |  |  | 派工时间 |
| 6 | MAINTENANCEMANID | nvarchar | (50) |  |  |  |  |  | 维修保养人员编号 |
| 7 | MAINTENANCEMAN | nvarchar | (50) |  |  |  |  |  | 维修保养人 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 1 | TASKNO | nvarchar | (50) | √ |  |  |  |  | 任务单编号 |
| 2 | DISPATCHERSID | nvarchar | (50) |  |  |  |  |  | 派工人员编号 |
| 3 | DISPATCHERS | nvarchar | (50) |  |  |  |  |  | 派工人 |
| 4 | DISPATCHTIME | datetime |  |  |  |  |  |  | 派工时间 |
| 5 | MAINTENANCEMANID | nvarchar | (50) | √ |  |  |  |  | 维修保养人员编号 |
| 6 | MAINTENANCEMAN | nvarchar | (50) |  |  |  |  |  | 维修保养人 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | TASKNO | nvarchar | (50) | √ |  |  |  |  | 任务单编号 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | PHOTOGRAPH | nvarchar | (500) |  |  |  | √ |  | 照片 视频 |
| 4 | TASKTYPE | numeric | (1,0) |  |  |  |  |  | 任务单类型 |
| 5 | BREAKDOWNREASONNO | nvarchar | (50) |  |  |  | √ |  | 故障原因 |
| 6 | BREAKDOWNDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 故障描述 |
| 7 | REPAIRREASONNO | nvarchar | (50) |  |  |  | √ |  | 维修原因 |
| 8 | REPAIRDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 维修描述 |
| 9 | MAINTENANCEREASONNO | nvarchar | (50) |  |  |  | √ |  | 保养原因 |
| 10 | MAINTENANCEDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 保养描述 |
| 11 | HITS | numeric | (12,0) |  |  |  | √ |  | 点击量 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PMEQPSOPNO | nvarchar | (64) | √ |  |  |  |  | 设备保养标准作业进程编号：设备保养标准作业进程编号 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 3 | PMSERIALNO | numeric | (3,0) | √ |  |  |  |  | 设备保养序号：设备保养序号 |
| 4 | FREQUENCYNO | nvarchar | (64) |  |  |  |  |  | 频率编号：频率编号 |
| 5 | PMSOPNO | nvarchar | (64) |  |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 6 | PMESTDATETIME | datetime |  |  |  |  |  |  | 设备保养时间：设备保养时间 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人：修改人 |
| 10 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期：修改日期 |
| 11 | SERIALNO | nvarchar | (50) |  |  |  |  |  | 序号：序号 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLPMEQPTYPESOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PMEQPSOPNO | nvarchar | (64) | √ |  |  |  |  | 设备保养标准作业进程编号：设备保养标准作业进程编号 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 3 | PMSERIALNO | numeric | (3,0) | √ |  |  |  |  | 设备保养序号：设备保养序号 |
| 4 | FREQUENCYNO | nvarchar | (64) |  |  |  |  |  | 频率编号：频率编号 |
| 5 | PMSOPNO | nvarchar | (64) |  |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 6 | PMESTDATETIME | datetime |  |  |  |  |  |  | 设备保养时间：设备保养时间 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人：修改人 |
| 10 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期：修改日期 |
| 11 | PMWONO | nvarchar | (30) |  |  |  | √ |  | 工单号码：工单号码 |
| 12 | PMWOITEMNO | numeric | (3,0) |  |  |  | √ |  | 工单项次：工单项次 |
| 13 | WOCREATEDATE | datetime |  |  |  |  | √ |  | 保养工单开立日期：保养工单开立日期 |
| 14 | WORELEASEDATE | datetime |  |  |  |  | √ |  | 工单下线日期：工单下线日期 |
| 15 | WOFINISHEDDATE | datetime |  |  |  |  | √ |  | 工单结案日期：工单结案日期 |
| 16 | EXECUTESTATE | numeric | (1,0) |  |  |  | √ |  | 执行状态：执行状态 |
| 17 | LOGCREATOR | nvarchar | (30) |  |  |  | √ |  | 纪录创建人：记录创建人 |
| 18 | LOGCREATEDATE | datetime |  |  |  |  | √ |  | 记录创建日期：记录创建日期 |
| 19 | SERIALNO | nvarchar | (50) |  |  |  |  |  | 序号：序号 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 22 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | GUID | nvarchar | (50) | √ |  |  |  |  | 自动生成GUID |
| 2 | TASKNO | nvarchar | (50) |  |  |  |  |  | 任务单编号 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | PHOTOGRAPH | nvarchar | (500) |  |  |  | √ |  | 照片 视频 |
| 5 | TASKTYPE | numeric | (1,0) |  |  |  |  |  | 任务单类型 |
| 6 | BREAKDOWNREASONNO | nvarchar | (50) |  |  |  | √ |  | 故障原因 |
| 7 | BREAKDOWNDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 故障描述 |
| 8 | REPAIRREASONNO | nvarchar | (50) |  |  |  | √ |  | 维修原因 |
| 9 | REPAIRDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 维修描述 |
| 10 | MAINTENANCEREASONNO | nvarchar | (50) |  |  |  | √ |  | 保养原因 |
| 11 | MAINTENANCEDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 保养描述 |
| 12 | STATUS | numeric | (1,0) |  |  |  |  |  | 任务状态 |
| 13 | EARLIESTDISPATCHTIME | datetime |  |  |  |  | √ |  | 最早派工时间 |
| 14 | MAINTENANCESTARTTIME | datetime |  |  |  |  | √ |  | 开始维修 保养时间 |
| 15 | MAINTENANCEENDTIME | datetime |  |  |  |  | √ |  | 维修 保养完成时间 |
| 16 | ACCEPTANCETIME | datetime |  |  |  |  | √ |  | 验收时间 |
| 17 | CLOSINGTIME | datetime |  |  |  |  | √ |  | 归档时间 |
| 18 | EQPSERIALNO | nvarchar | (20) |  |  |  | √ |  | 设备序号 |
| 19 | REWORK | numeric | (1,0) |  |  |  |  |  | 是否返修 |
| 20 | REWORKTASKNO | nvarchar | (50) |  |  |  | √ |  | 返修原单号 |
| 21 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 22 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 1 | TASKNO | nvarchar | (50) | √ |  |  |  |  | 任务单编号 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | PHOTOGRAPH | nvarchar | (500) |  |  |  | √ |  | 照片 视频 |
| 4 | TASKTYPE | numeric | (1,0) |  |  |  |  |  | 任务单类型 |
| 5 | BREAKDOWNREASONNO | nvarchar | (50) |  |  |  | √ |  | 故障原因 |
| 6 | BREAKDOWNDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 故障描述 |
| 7 | REPAIRREASONNO | nvarchar | (50) |  |  |  | √ |  | 维修原因 |
| 8 | REPAIRDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 维修描述 |
| 9 | MAINTENANCEREASONNO | nvarchar | (50) |  |  |  | √ |  | 保养原因 |
| 10 | MAINTENANCEDESCRIBE | nvarchar | (4000) |  |  |  | √ |  | 保养描述 |
| 11 | STATUS | numeric | (1,0) |  |  |  |  |  | 任务状态 |
| 12 | EARLIESTDISPATCHTIME | datetime |  |  |  |  | √ |  | 最早派工时间 |
| 13 | MAINTENANCESTARTTIME | datetime |  |  |  |  | √ |  | 开始维修 保养时间 |
| 14 | MAINTENANCEENDTIME | datetime |  |  |  |  | √ |  | 维修 保养完成时间 |
| 15 | ACCEPTANCETIME | datetime |  |  |  |  | √ |  | 验收时间 |
| 16 | CLOSINGTIME | datetime |  |  |  |  | √ |  | 归档时间 |
| 17 | EQPSERIALNO | nvarchar | (20) |  |  |  | √ |  | 设备序号 |
| 18 | REWORK | numeric | (1,0) |  |  |  |  |  | 是否返修 |
| 19 | REWORKTASKNO | nvarchar | (50) |  |  |  | √ |  | 返修原单号 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 22 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 23 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | EQPSERIALNO | nvarchar | (20) |  |  |  |  |  | 设备序号：设备序号 |
| 2 | BREAKDOWNSERIALNO | nvarchar | (20) |  |  |  |  |  | 故障序号：故障序号 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号：设备编号 |
| 4 | BREAKDOWNSTARTTIME | datetime |  |  |  |  |  |  | 故障开始日期：故障开始日期 |
| 5 | REPAIRSERIALNO | nvarchar | (20) |  |  |  | √ |  | 维修序号：维修序号 |
| 6 | REPAIRSTARTTIME | datetime |  |  |  |  | √ |  | 维修开始时间：维修开始时间 |
| 7 | REPAIRENDTIME | datetime |  |  |  |  | √ |  | 维修结束时间：维修结束时间 |
| 8 | REPAIRUSERNO | nvarchar | (30) |  |  |  | √ |  | 维修人编号：维修人编号 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PMEQPSOPNO | nvarchar | (64) | √ |  |  |  |  | 设备保养标准作业进程编号：设备保养标准作业进程编号 |
| 2 | PMYEARNO | nvarchar | (50) |  |  |  | √ |  | 设备保养年编号：设备保养年编号 |
| 3 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  |  |  | 设备类别：设备类别 |
| 4 | FREQUENCYNO | nvarchar | (64) |  |  |  |  |  | 频率编号：频率编号 |
| 5 | PMSOPNO | nvarchar | (64) |  |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 6 | FREQUENCYNAME | nvarchar | (50) |  |  |  |  |  | 频率名称：频率名称 |
| 7 | PMSOPNAME | nvarchar | (50) |  |  |  |  |  | 标准作业进程名称：标准作业进程名称 |
| 8 | HURRYTIME | numeric | (6,2) |  |  |  | √ | 0 | 催签时间：催签时间 |
| 9 | OVERDUETIME | numeric | (6,2) |  |  |  | √ | 0 | 逾时：逾时 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人：修改人 |
| 13 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期：修改日期 |
| 14 | AUTOCREATEWO | numeric | (1,0) |  |  |  |  | 0 | 开立保养工单：开立保养工单， |
| 15 | TOLERANCEQTY | numeric | (8,2) |  |  |  |  | 0 | 宽限数量：宽限数量 |
| 16 | LOCKEQUIPMENT | numeric | (1,0) |  |  |  |  | 0 | 变更机台状态：变更机台状态， |
| 17 | AUTOEMAIL | numeric | (1,0) |  |  |  |  | 0 | 自动发送邮件：自动发送邮件， |
| 18 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  | √ |  | 设备状态：设备状态，设定时开窗之数据来源为「设备模块-设备设定-设备状态主档」功能设定之数据。 |
| 19 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TASKNO | nvarchar | (50) | √ |  |  |  |  | 任务单编号 |
| 2 | MAINTENANCEMAN | nvarchar | (50) |  |  |  |  |  | 维修保养人 |
| 3 | MAINTENANCEMANID | nvarchar | (50) | √ |  |  |  |  | 维修保养人员编号 |
| 4 | MAINTENANCESTARTTIME | datetime |  |  |  |  |  |  | 开始维修 保养时间 |
| 5 | MAINTENANCEENDTIME | datetime |  |  |  |  | √ |  | 维修 保养完成时间 |
| 6 | ESTIMATEDTIME | numeric | (3,1) |  |  |  |  |  | 预计维修时间（H） |
| 7 | REPAIRREASONNO | nvarchar | (50) |  |  |  | √ |  | 维修原因 |
| 8 | REPAIRDESCRIBE | nvarchar | (500) |  |  |  | √ |  | 维修描述 |
| 9 | MAINTENANCEREASONNO | nvarchar | (50) |  |  |  | √ |  | 保养原因 |
| 10 | MAINTENANCEDESCRIBE | nvarchar | (500) |  |  |  | √ |  | 保养描述 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 2 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  |  |  | 设备类别 |
| 3 | TYPECODE | numeric | (1,0) |  |  |  |  | 0 | 类别区别：区别设备类别与设备编号， |
| 4 | QUANTITY | numeric | (8,0) |  |  |  |  | 0 | 数量：数量 |
| 5 | TOLERANCEQTY | numeric | (8,0) |  |  |  | √ | 0 | 宽限数量：宽限数量 |
| 6 | UNITNO | nvarchar | (64) |  |  |  |  |  | 单位编号：单位编号 |
| 7 | AUTOCREATEWO | numeric | (1,0) |  |  |  | √ | 0 | 开立保养工单：开立保养工单， |
| 8 | LOCKEQUIPMENT | numeric | (1,0) |  |  |  | √ | 0 | 变更机台状态：变更机台状态， |
| 9 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  | √ |  | 设备状态：设备状态，设定时开窗之数据来源为「设备模块-设备设定-设备状态主档」功能设定之数据。 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人：修改人 |
| 13 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期：修改日期 |
| 14 | PMSOPNO | nvarchar | (64) | √ |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 15 | AUTOEMAIL | numeric | (1,0) |  |  |  |  | 0 | 自动发送邮件：自动发送邮件， |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 2 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  |  |  | 设备类别：设备类别 |
| 3 | TYPECODE | numeric | (1,0) |  |  |  |  | 0 | 类别区别：区别设备类别与设备编号， |
| 4 | QUANTITY | numeric | (8,0) |  |  |  |  | 0 | 数量：数量 |
| 5 | TOLERANCEQTY | numeric | (8,0) |  |  |  | √ | 0 | 宽限数量：宽限数量 |
| 6 | QTYTYPE | numeric | (2,0) |  |  |  | √ | 0 | 数量型态：数量型态， |
| 7 | AUTOCREATEWO | numeric | (1,0) |  |  |  | √ | 0 | 开立保养工单：开立保养工单， |
| 8 | LOCKEQUIPMENT | numeric | (1,0) |  |  |  | √ | 0 | 变更机台状态：变更机台状态， |
| 9 | EQUIPMENTSTATE | numeric | (2,0) |  |  |  | √ |  | 设备状态：设备状态，设定时开窗之数据来源为「设备模块-设备设定-设备状态主档」功能设定之数据。 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人：修改人 |
| 13 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期：修改日期 |
| 14 | PMSOPNO | nvarchar | (64) | √ |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 15 | AUTOEMAIL | numeric | (1,0) |  |  |  |  | 0 | 自动发送邮件：自动发送邮件， |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FREQUENCYNO | nvarchar | (50) | √ |  |  |  |  | 频率编号：频率编号 |
| 2 | FREQUENCYNAME | nvarchar | (50) |  |  |  |  |  | 频率名称：频率名称 |
| 3 | PERIOD | numeric | (3,0) |  |  |  | √ |  | 周期：周期 |
| 4 | PRIORITY | numeric | (2,0) |  |  |  |  | 1 | 优先权：优先权 |
| 5 | FIXEDTYPE | nvarchar | (20) |  |  |  | √ |  | 频率类别：频率类别 |
| 6 | FIXEDTYPEVALUE | nvarchar | (20) |  |  |  | √ |  | 频率类别值：频率类别值 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PMJOBNO | nvarchar | (20) | √ |  |  |  |  | 工作编号：工作编号 |
| 2 | PMJOBNAME | nvarchar | (50) |  |  |  |  |  | 工作名称：工作名称 |
| 3 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PMITEMNO | nvarchar | (20) | √ |  |  |  |  | 保养项目编号：保养项目编号 |
| 2 | PMITEMNAME | nvarchar | (50) |  |  |  |  |  | 保养项目名称：保养项目名称 |
| 3 | MAINTAINNO | nvarchar | (20) |  |  |  |  |  | 维护方式编号：维护方式编号 |
| 4 | PMJOBNO | nvarchar | (20) |  |  |  |  |  | 工作编号：工作编号 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | IMAGEREQUIREMENTS | numeric | (1,0) |  |  |  |  | 0 | 是否需要图片 |
| 13 | PMTYPE | numeric | (1,0) |  |  |  | √ |  | 保养类型 |
| 14 | MAXVALUE | nvarchar | (50) |  |  |  | √ |  | 范围上限 |
| 15 | MINVALUE | nvarchar | (50) |  |  |  | √ |  | 范围下限 |
| 1 | MAINTAINNO | nvarchar | (20) | √ |  |  |  |  | 维护方式编号：维护方式编号 |
| 2 | MAINTAINNAME | nvarchar | (50) |  |  |  |  |  | 维护方式名称：维护方式名称 |
| 3 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TASKNO | nvarchar | (50) | √ |  |  |  |  | 任务单号 |
| 2 | TASKTYPE | numeric | (1,0) |  |  |  |  |  | 任务单类别 |
| 3 | PMITEMNO | nvarchar | (20) | √ |  |  |  |  | 保养项目编号 |
| 4 | PMITEMNAME | nvarchar | (50) |  |  |  |  |  | 保养项目名称 |
| 5 | MAINTAINNO | nvarchar | (20) |  |  |  |  |  | 维护方式编号 |
| 6 | PMJOBNO | nvarchar | (20) |  |  |  |  |  | 工作编号 |
| 7 | MAINTENANCEPASSED | numeric | (1,0) |  |  |  |  |  | 是否保养通过 |
| 8 | PHOTOGRAPH | nvarchar | (150) |  |  |  | √ |  | 文件路径 |
| 9 | INPUTVALUE | nvarchar | (50) |  |  |  | √ |  | 保养结果值 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 13 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | REPAIRNO | nvarchar | (20) | √ |  |  |  |  | 维修编号：维修编号 |
| 2 | REPAIRNAME | nvarchar | (50) |  |  |  |  |  | 维修名称：维修名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PMSOPNO | nvarchar | (64) | √ |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 2 | PMSOPNAME | nvarchar | (50) |  |  |  |  |  | 标准作业进程名称：标准作业进程名称 |
| 3 | SOPFILEPATH | nvarchar | (100) |  |  |  | √ |  | 标准作业进程档案路径：标准作业进程档案路径 |
| 4 | ESTDONETIME | numeric | (6,2) |  |  |  |  | 0 | 预估完成时间：预估完成时间 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 9 | RESETFLAG | numeric | (1,0) |  |  |  |  | 0 | 执行后归零：1 是 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLPMWODETAILGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 2 | PMSOPNO | nvarchar | (64) | √ |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 3 | AccLotQty | numeric | (12,4) |  |  |  |  |  | 积累数量 |
| 4 | AccLotCount | numeric | (12,4) |  |  |  |  |  | 积累次数 |
| 5 | AccLotTime | numeric | (12,4) |  |  |  |  |  | 积累时间(分) |
| 6 | PMEQPSOPNO | nvarchar | (64) |  |  |  |  |  | 设备保养标准作业进程编号：设备保养标准作业进程编号 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLPMFIXEDQTYPMBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 14 | TBLPMFIXEDTIMESPMBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PMSOPNO | nvarchar | (64) | √ |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 2 | PMITEMNO | nvarchar | (20) | √ |  |  |  |  | 保养项目编号：保养项目编号 |
| 3 | PMSOPSERIALNO | numeric | (6,1) |  |  |  |  |  | 设备标准作业进程保养序号：设备标准作业进程保养序号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 9 | TBLPMSOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SUBSTITUTIONNO | nvarchar | (50) | √ |  |  |  |  | 备品编号 |
| 2 | SUBSTITUTIONNAME | nvarchar | (50) |  |  |  |  |  | 备品名称 |
| 3 | SUBSTITUTIONTYPE | nvarchar | (50) |  |  |  |  |  | 备品类别 |
| 4 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 5 | UNITTYPE | nvarchar | (64) |  |  |  | √ |  | 单位类别 |
| 6 | SAFEQTY | numeric | (12,4) |  |  |  | √ | 0 | 最低安全库存 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | SPEC | nvarchar | (100) |  |  |  | √ |  | 规格 |
| 15 | PHOTOGRAPH | varbinary | (-1) |  |  |  | √ |  | 图片 |
| 16 | MAXSAFEQTY | numeric | (12,4) |  |  |  | √ |  | 最高安全库存 |
| 17 | FILENAME | nvarchar | (150) |  |  |  | √ |  | 文件名称 |
| 1 | SUBSTITUTIONQTY | numeric | (12,4) |  |  |  |  |  | 备品数量 |
| 2 | UNITNO | nvarchar | (20) |  |  |  |  |  | 单位编号 |
| 3 | SUBSTITUTIONNO | nvarchar | (50) | √ |  |  |  |  | 备品编号 |
| 4 | TASKTYPE | nvarchar | (50) |  |  |  |  |  | 任务单类别 |
| 5 | TASKNO | nvarchar | (50) | √ |  |  |  |  | 任务单号 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SUBSTITUTIONNO | nvarchar | (50) | √ |  |  |  |  | 备品编号：备品编号 |
| 2 | SUBSTITUTIONNAME | nvarchar | (50) |  |  |  |  |  | 备品名称：备品名称 |
| 3 | SUBSTITUTIONTYPE | nvarchar | (50) |  |  |  |  |  | 备品类别：备品类别 |
| 4 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号：单位编号 |
| 5 | UNITTYPE | nvarchar | (30) |  |  |  | √ |  | 单位类别：单位类别 |
| 6 | SAFEQTY | numeric | (12,4) |  |  |  | √ |  | 最低安全库存：最低安全库存 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | GROUPNO | nvarchar | (50) | √ |  |  |  |  | 群组编号：群组编码 |
| 2 | SUBSTITUTIONTYPE | nvarchar | (50) |  |  |  |  |  | 备品类别：备品类别 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | GROUPNO | nvarchar | (50) | √ |  |  |  |  | 群组编号：群组编码 |
| 2 | SUBSTITUTIONNO | nvarchar | (50) | √ |  |  |  |  | 备品编号：备品编号 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SUBSTITUTIONTYPE | nvarchar | (50) | √ |  |  |  |  | 备品类别：备品类别 |
| 2 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 3 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PMITEMNO | nvarchar | (20) | √ |  |  |  |  | 保养项目编号：保养项目编号 |
| 2 | SUBSTITUTIONNO | nvarchar | (20) | √ |  |  |  |  | 备品编号：备品编号 |
| 3 | UNITNO | nvarchar | (20) |  |  |  |  |  | 单位编号：单位编号 |
| 4 | SUBSTITUTIONQTY | numeric | (12,4) |  |  |  | √ | 0 | 备品数量：备品数量 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | VENDORNO | nvarchar | (64) | √ |  |  |  |  | 供应商编号：供应商编号 |
| 2 | CONTACTORNAME | nvarchar | (50) | √ |  |  |  |  | 联络人名称：联络人名称 |
| 3 | TELNO | nvarchar | (40) |  |  |  | √ |  | 电话：电话 |
| 4 | FAXNO | nvarchar | (40) |  |  |  | √ |  | 传真：传真 |
| 5 | TITLE | nvarchar | (20) |  |  |  | √ |  | 职称：职称 |
| 6 | ADDRESS | nvarchar | (50) |  |  |  | √ |  | 地址：地址 |
| 7 | EMAIL | nvarchar | (255) |  |  |  | √ |  | 电子邮件：电子邮件 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 14 | TBLPMSUBSTITUTIONVENDORGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | VENDORNO | nvarchar | (64) | √ |  |  |  |  | 供应商编号：供应商编号 |
| 2 | VENDORNAME | nvarchar | (50) |  |  |  |  |  | 供应商名称：供应商名称 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SUBSTITUTIONNO | nvarchar | (50) | √ |  |  |  |  | 备品编号 |
| 2 | VENDORNO | nvarchar | (64) | √ |  |  |  |  | 供应商编号 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLPMSUBSTITUTIONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PMITEMNO | nvarchar | (20) | √ |  |  |  |  | 保养项目编号：保养项目编号 |
| 2 | TOOLNO | nvarchar | (20) | √ |  |  |  |  | 工具编号：工具编号 |
| 3 | TOOLQTY | numeric | (3,0) |  |  |  | √ | 0 | 工具数量：工具数量 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | WONO | nvarchar | (64) | √ |  |  |  |  | 工单号码：工单号码 |
| 2 | WOTYPE | numeric | (1,0) |  |  |  |  | 0 | 工单型态：工单型态， |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | PMTIME | numeric | (12,0) |  |  |  |  | 0 | 保养时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | WONO | nvarchar | (64) | √ |  |  |  |  | 工单号码：工单号码 |
| 2 | WOTYPE | numeric | (1,0) |  |  |  |  | 0 | 工单型态：工单型态 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  |  | 0 | 数据状态：数据目前状态 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | WONO | nvarchar | (64) | √ |  |  |  |  | 工单号码：工单编号 |
| 2 | WOITEMNO | numeric | (3,0) | √ |  |  |  |  | 工单项次：工单项次 |
| 3 | PMSERIALNO | numeric | (3,0) |  |  |  | √ |  | 设备保养序号：设备保养序号 |
| 4 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号：设备编号 |
| 5 | PMEQPSOPNO | nvarchar | (30) |  |  |  | √ |  | 设备保养标准作业进程编号：设备保养标准标准作业进程编号 |
| 6 | PMSOPNO | nvarchar | (64) |  |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 7 | PMESTDATETIME | datetime |  |  |  |  |  |  | 设备保养时间：设备保养时间 |
| 8 | RELEASEDATE | datetime |  |  |  |  | √ |  | 下线日期：下线日期 |
| 9 | FINISHEDDATE | datetime |  |  |  |  | √ |  | 完成时间：完成时间 |
| 10 | WOSTATUS | numeric | (1,0) |  |  |  | √ | 1 | 状态：状态，1 Prepare Materials (备料中) 2 Release (已下线) 3 Finished (已完成) 4 Phase Out (已淘汰) |
| 11 | EXECUTOR | nvarchar | (30) |  |  |  | √ |  | 回报人：回报人 |
| 12 | EXECUTEDESC | nvarchar | (255) |  |  |  | √ |  | 执行状况描述：执行状况描述 |
| 13 | SERIALNO | nvarchar | (50) |  |  |  | √ |  | 序号：序号 |
| 14 | EXECUTESTATUS | numeric | (1,0) |  |  |  |  | 0 | 执行状态：是否已执行完毕的暂存状态 1=执行完成 0=未执行 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | TBLPMWOBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | WONO | nvarchar | (64) | √ |  |  |  |  | 工单号码：工单编号 |
| 2 | WOITEMNO | numeric | (3,0) | √ |  |  |  |  | 工单项次：工单项次 |
| 3 | PMSERIALNO | numeric | (3,0) |  |  |  | √ |  | 设备保养序号：设备保养序号 |
| 4 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号：设备编号 |
| 5 | PMEQPSOPNO | nvarchar | (30) |  |  |  | √ |  | 设备保养标准作业进程编号：设备保养标准标准作业进程编号 |
| 6 | PMSOPNO | nvarchar | (64) |  |  |  |  |  | 标准作业进程编号：标准作业进程编号 |
| 7 | PMESTDATETIME | datetime |  |  |  |  |  |  | 设备保养时间：设备保养时间 |
| 8 | RELEASEDATE | datetime |  |  |  |  | √ |  | 下线日期：下线日期 |
| 9 | FINISHEDDATE | datetime |  |  |  |  | √ |  | 完成时间：完成时间 |
| 10 | WOSTATUS | numeric | (1,0) |  |  |  | √ | 1 | 状态：状态，1 Prepare Materials (备料中) 2 Release (已下线) 3 Finished (已完成) 4 Phase Out (已淘汰) |
| 11 | EXECUTOR | nvarchar | (30) |  |  |  | √ |  | 回报人：回报人 |
| 12 | EXECUTEDESC | nvarchar | (255) |  |  |  | √ |  | 执行状况描述：执行状况描述 |
| 13 | SERIALNO | nvarchar | (50) |  |  |  | √ |  | 序号：序号 |
| 14 | EXECUTESTATUS | numeric | (1,0) |  |  |  |  | 0 | 执行状态：是否已执行完毕的暂存状态 1=执行完成 0=未执行 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码：唯一识别吗 |
| 3 | WONO | nvarchar | (64) |  |  |  |  |  | 工单号码：工单编号 |
| 4 | WOITEMNO | numeric | (3,0) |  |  |  |  |  | 工单项次：工单项次 |
| 5 | PMESTDATETIME | datetime |  |  |  |  |  |  | 设备保养时间：设备保养时间 |
| 6 | ORG_PMESTDATETIME | datetime |  |  |  |  |  |  | 原设备保养时间：原设备保养时间 |
| 7 | CHANGETYPE | numeric | (2,0) |  |  |  |  |  | 异动类型：1 批次异动（3T) |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ACCESSORYTYPE | nvarchar | (50) | √ |  |  |  |  | 模治具类别：设定时，开窗之数据来源为模治具管理模块-模治具类别功能设定之数据。 |
| 3 | ACCESSORYNO | nvarchar | (50) | √ |  |  |  |  | 模治具编号 |
| 4 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  | '*' | 作业站编号 |
| 6 | AccessoryCategory | nvarchar | (50) |  |  |  |  |  | 模治具分类：设定时，开窗之数据来源为模治具管理模块-模治具分类功能设定之数据。 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 13 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 14 | ACCSTATUS | numeric | (1,0) |  |  |  | √ |  | 模治具状态：模治具状态 |
