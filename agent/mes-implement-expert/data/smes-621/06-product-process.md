# 06 产品主档/工艺/包装 (PRD/PS)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 23 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblPRDACCLifeDeductionRate](#tblprdacclifedeductionrate) | 产品模治具寿命扣减比例设定 | 46 |
| [tblPRDDoubleUnitNoBasis](#tblprddoubleunitnobasis) | 产品双单位主档 | 19 |
| [tblPRDEquipmentSpec](#tblprdequipmentspec) | 产品设备规格设定 | 29 |
| [tblPRDGroupLabelBasis](#tblprdgrouplabelbasis) | 组合标签基本档 | 9 |
| [tblPRDGroupLabelMAP](#tblprdgrouplabelmap) | 组合标签明细 | 14 |
| [tblPRDLabel_OP](#tblprdlabel_op) | 作业站组合标签表 | 14 |
| [tblPRDLabel_PRD](#tblprdlabel_prd) | 产品组合标签表 | 13 |
| [tblPRDLabel_PRDOP](#tblprdlabel_prdop) | 产品作业站组合标签表 | 54 |
| [tblPRDNCCodeBasisNew](#tblprdnccodebasisnew) | 产品NC程序码设定 | 119 |
| [tblPRDOPUnitConversion](#tblprdopunitconversion) | 单位转换设定表 | 21 |
| [tblPRDPackRuleBasis](#tblprdpackrulebasis) | 包装规则主档 | 11 |
| [tblPRDPackRuleDetail](#tblprdpackruledetail) | 包装规则明细 | 14 |
| [tblPRDPackRuleMap](#tblprdpackrulemap) | 产品包装规则对应 | 12 |
| [tblPRDPackRuleRelation](#tblprdpackrulerelation) | 包装规则关联 | 137 |
| [tblPRDProductIoninfGroup](#tblprdproductioninfgroup) | 生产讯息群组 | 76 |
| [tblPRDProperty](#tblprdproperty) | 产品属性 | 148 |
| [tblPRDStartInspection](#tblprdstartinspection) | 始业点检设定 | 256 |
| [tblPSSectionBasis](#tblpssectionbasis) | 工段基本设定 | 9 |
| [tblPSSectionBasisDetail](#tblpssectionbasisdetail) | 工段明细设定 | 8 |
| [tblPSSectionNodeBasis](#tblpssectionnodebasis) | 工段流程节点设定 | 12 |
| [tblPSSectionProcessBasis](#tblpssectionprocessbasis) | 工段流程设置 | 10 |
| [tblPSUserTemplateBasis](#tblpsusertemplatebasis) | 模板记录 | 11 |
| [tblPSUserTemplateSort](#tblpsusertemplatesort) | 模板排序 | 740 |

---

### tblPRDACCLifeDeductionRate — 产品模治具寿命扣减比例设定（46 字段）
> 主键：ID, PRODUCTNO, PRODUCTVERSION, NODENO, OPNO, POSITIONNO, PRODUCTNO, PRODUCTVERSION, NODENO, OPNO, MATERIALNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 3 | AccessoryNo | nvarchar | (50) |  |  |  |  |  | 模治具编号 |
| 4 | DeductionRate | numeric | (12,2) |  |  |  |  | 1 | 扣减比例 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ID | nvarchar | (50) | √ |  |  |  |  | ID |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品名称：产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (10) | √ |  |  |  |  | 产品版本：产品版本 |
| 3 | NODENO | nvarchar | (50) | √ |  |  |  |  | 节点编号：节点编号 |
| 4 | NODETYPE | numeric | (2,0) |  |  |  |  |  | 节点型别：0 物料1 产品 |
| 5 | STDQTY | numeric | (14,6) |  |  |  |  |  | 标准用量：标准用量 |
| 6 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号：单位编号 |
| 7 | DECREASERATE | numeric | (6,2) |  |  |  |  |  | 损耗率：百分比 |
| 8 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号：作业站编号 |
| 9 | SPECIFIED | numeric | (2,0) |  |  |  |  | 0 | 指定用料：0 非指定用料1 指定用料 |
| 10 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 11 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | NODEVERSION | nvarchar | (5) |  |  |  |  |  | 节点编号：节点编号 |
| 14 | PUTINPLACETYPE | numeric | (1,0) |  |  |  |  |  | 投料点：3 工单4 线边仓5 工单消耗性料件(倒扣料) |
| 15 | PlugPosition | nvarchar | (255) |  |  |  | √ |  | 外挂位置：外挂位置 |
| 16 | POSITIONNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 工位编号：工位编号 |
| 17 | MTLSYNCMODE | numeric | (12,4) |  |  |  |  | 1 | 叫料模式：1 手动叫料2 自动叫料 |
| 18 | MINSTOCKQTY | numeric | (14,6) |  |  |  | √ |  | 最低存量：最低存量 |
| 19 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态：GUID |
| 23 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值：父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品名称 |
| 2 | PRODUCTVERSION | nvarchar | (50) | √ |  |  |  |  | 产品版本 |
| 3 | NODENO | nvarchar | (50) | √ |  |  |  |  | 节点编号 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 6 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 7 | TBLPRDBOMGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |

---

### tblPRDDoubleUnitNoBasis — 产品双单位主档（19 字段）
> 主键：ProductNo, ProductVersion, OpNo, actiontype
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (50) | √ |  |  |  |  | 产品版本 |
| 3 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | Molecule | numeric | (16,4) |  |  |  | √ |  | 转换分子：20211208 #104049 修改栏位数据型别支援小数 |
| 5 | Denominator | numeric | (16,4) |  |  |  | √ |  | 转换分母：20211208 #104049 修改栏位数据型别支援小数 |
| 6 | ConversionRules | numeric | (1,0) |  |  |  |  |  | 转换方式：0：无条件进位 1：无条件舍位 3：四舍五入 |
| 7 | Accuracy | numeric | (1,0) |  |  |  |  |  | 精准度：0：整数 1：小数1位 2：小数2位 3：小数3位 4：小数4位 |
| 8 | DoubleUnitRules | numeric | (1,0) |  |  |  |  |  | 双单转换规则：0：自动转换最大值 1：自动转换多余 3：不允许 4：数量超出自动转换最大 5：数量不足自动转换最大值 6：数量超出卡控 7：数量不足取实际 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | NeedVehicle | numeric | (1,0) |  |  |  |  |  | 是需维护载具：0：无 1：警告 2：必须 |
| 12 | DefaultVehicleNo | nvarchar | (50) |  |  |  | √ |  | 预设载具编号 |
| 13 | ismodied | numeric | (1,0) |  |  |  |  | 0 | 转换是否可修改：0：否 1：是 |
| 14 | actiontype | numeric | (1,0) | √ |  |  |  |  | 双单型别：1：进站；2出站 |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 19 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblPRDEquipmentSpec — 产品设备规格设定（29 字段）
> 主键：ProductNo, ProductVersion, EquipmentNo, ParameterNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 4 | ParameterNo | nvarchar | (20) | √ |  |  |  |  | 自变量编号 |
| 5 | MinValue | numeric | (16,6) |  |  |  |  |  | 最小值 |
| 6 | MaxValue | numeric | (16,6) |  |  |  |  |  | 最大值 |
| 7 | guideline_1 | numeric | (16,6) |  |  |  |  |  | GUIDELINE_1 |
| 8 | guideline_2 | numeric | (16,6) |  |  |  |  |  | GUIDELINE_2 |
| 9 | REVISER | nvarchar | (50) |  |  |  |  |  | 修改人 |
| 10 | REVISEDATE | datetime |  |  |  |  |  |  | 修改时间 |
| 11 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 1 | OPERATOR | nvarchar | (100) |  |  |  | √ |  | 操作人 |
| 2 | OPERATORTIME | datetime |  |  |  |  | √ |  | 操作日期 |
| 3 | STATE | numeric | (1,0) |  |  |  | √ |  | 状态 |
| 4 | IMPORTTYPE | nvarchar | (10) |  |  |  | √ |  | 导入类型 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 11 | OPERATEGUID | nvarchar | (50) |  |  |  |  | 'N/A' | 操作唯一码 |
| 12 | ERRORMESSAGE | nvarchar | (500) |  |  |  | √ |  | 错误信息 |

---

### tblPRDGroupLabelBasis — 组合标签基本档（9 字段）
> 主键：GroupLabelNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GroupLabelNO | nvarchar | (50) | √ |  |  |  |  | 组合标签编号 |
| 2 | GroupType | numeric | (1,0) |  |  |  |  |  | 组合类别 |
| 3 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |

---

### tblPRDGroupLabelMAP — 组合标签明细（14 字段）
> 主键：GroupLabelNO, LabelNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GroupLabelNO | nvarchar | (50) | √ |  |  |  |  | 组合标签编号 |
| 2 | LabelNO | nvarchar | (50) | √ |  |  |  |  | 标签编号 |
| 3 | LevelName | nvarchar | (20) |  |  |  | √ |  | 阶层名称 |
| 4 | LevelDesc | nvarchar | (20) |  |  |  | √ |  | 阶层描述 |
| 5 | LevelQty | numeric | (4,0) |  |  |  | √ |  | 阶层数量 |
| 6 | PackLevelSeq | nvarchar | (4) |  |  |  | √ |  | 包装阶层序号 |
| 7 | SerialTypeNo | nvarchar | (50) |  |  |  | √ |  | 包装序号规则 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 14 | TBLPRDGROUPLABELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblPRDLabel_OP — 作业站组合标签表（14 字段）
> 主键：OpNo, CustomerNo, MoTypeNo, GroupType
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | CustomerNo | nvarchar | (50) | √ |  |  |  | '*' | 客户编号 |
| 3 | MoTypeNo | nvarchar | (2) | √ |  |  |  | '*' | 工单型别 |
| 4 | LabelNO | nvarchar | (50) |  |  |  |  |  | 标签编号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | IsGroup | numeric | (2,0) |  |  |  |  |  | 是否组合：是否组合 |
| 8 | GroupType | numeric | (2,0) | √ |  |  |  |  | 是否包装 |
| 9 | Copies | numeric | (2,0) |  |  |  |  | 1 | 预设打印份数 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 14 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblPRDLabel_PRD — 产品组合标签表（13 字段）
> 主键：ProductNo, ProductVersion, CustomerNo, MoTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (50) | √ |  |  |  |  | 产品版本：产品版本 |
| 3 | CustomerNo | nvarchar | (50) | √ |  |  |  |  | 客户编号 |
| 4 | MoTypeNo | nvarchar | (2) | √ |  |  |  |  | 工单类别 |
| 5 | LabelNO | nvarchar | (50) |  |  |  |  |  | 标签编号：标签编号设定于：生产模型管理-标签数据 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | IsGroup | numeric | (2,0) |  |  |  |  | 0 | 是否组合：是否组合 |
| 9 | Copies | numeric | (6,0) |  |  |  |  | 1 | 预设打印份数：预设打印份数 #80273 朱煜轲 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |

---

### tblPRDLabel_PRDOP — 产品作业站组合标签表（54 字段）
> 主键：ProductNo, ProductVersion, OpNo, CustomerNo, MoTypeNo, GroupType, LABELNO, LABELNO, POSITION, PIECE, PRODUCTNO, LABELTYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | CustomerNo | nvarchar | (50) | √ |  |  |  |  | 客户编号 |
| 5 | MoTypeNo | nvarchar | (2) | √ |  |  |  | '*' | 工单型别 |
| 6 | LabelNO | nvarchar | (50) |  |  |  |  |  | 标签编号 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | IsGroup | numeric | (2,0) |  |  |  |  |  | 是否组合：ISGROUP |
| 10 | GroupType | numeric | (1,0) | √ |  |  |  |  | 组合类别 |
| 11 | Copies | numeric | (2,0) |  |  |  |  | 1 | 预设打印份数 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 16 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LABELTYPE | nvarchar | (64) |  |  |  |  |  | 标签类别 |
| 2 | LABELNO | nvarchar | (50) | √ |  |  |  |  | 标签编号 |
| 3 | FORMATFILENAME | nvarchar | (100) |  |  |  | √ |  | 格式档名 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 7 | DefaultPrinter | nvarchar | (255) |  |  |  | √ |  | 默认打印机 |
| 8 | UDSQL | nvarchar | (-1) |  |  |  | √ |  | 自定义数据来源 (SQL) |
| 9 | FORMATFILETYPE | nvarchar | (50) |  |  |  |  | 'bartender' | 格式类别：PDF;bartender |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态：数据键值 |
| 1 | LABELNO | nvarchar | (50) | √ |  |  |  |  | 标签编号 |
| 2 | POSITION | numeric | (2,0) | √ |  |  |  |  | 位置 |
| 3 | PIECE | numeric | (2,0) | √ |  |  |  | 1 | 片 |
| 4 | PIECESOURCE | nvarchar | (10) |  |  |  |  |  | 片段来源：LP：LotProperty(生产批属性) LS：LotState(生产批状态) LB：LotBasis(生产批主档) MP：MOProperty(工单属性) MB：MOBasis(工单主档) PP：ProductProperty(产品属性) PB：ProductBasis(产品基本数据) MM：MOMaterial(工单用料) ML：MaterialLot(物料批号) CP：ComponentProperty(元件属性) CS：ComponentState(元件状态) WK：WeekCode(周码) UD：UserDefine(使用者定义) SC：ScriptFunction(描述语言函式) PS：产品序号 PL：PANEL序号(SMT模块用) BP  Box Packing(包装档) |
| 5 | PIECEDATA | nvarchar | (50) |  |  |  |  |  | 片段数据：来源为PS时对应SID 来源为PL时对应PanelNo |
| 6 | DIRECTION | numeric | (2,0) |  |  |  |  |  | 方向：0：All 1：Left 2：Right |
| 7 | STARTINDEX | numeric | (2,0) |  |  |  | √ |  | 起始位置 |
| 8 | PIECELENGTH | numeric | (2,0) |  |  |  | √ |  | 片段长度 |
| 9 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 15 | TBLPRDLABELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | LABELTYPE | nvarchar | (50) | √ |  |  |  |  | 标签类别：打印成品序号时，需对应 PCSTYPE 的标签类 |
| 3 | LABELNO | nvarchar | (50) |  |  |  | √ |  | 标签编号：标签编号设定于：生产模型管理-标签数据 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | Copies | numeric | (6,0) |  |  |  |  | 1 | 预设打印份数：预设打印份数 #80273 朱煜轲 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |

---

### tblPRDNCCodeBasisNew — 产品NC程序码设定（119 字段）
> 主键：ProductNo, ProductVersion, OPNO, EquipmentNo, SubOPSequence, FileName, FileVersion, SERIALNO, PRODUCTNO, PRODUCTVERSION, OPNO, AREANO, PRODUCTNO, PRODUCTVERSION, OPNO, PRODUCTNO, PRODUCTVERSION, OPNO, FROMNODE, TONODE, LINKNAME, PRODUCTNO, PRODUCTVERSION, OPNO, PRODUCTNO, PRODUCTVERSION, OPNO, PRODUCTNO, PRODUCTVERSION, OPNO, SUBOPSEQUENCE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (100) | √ |  |  |  |  | 设备编号 |
| 5 | SubOPSequence | numeric | (4,0) | √ |  |  |  | 0 | 工序 |
| 6 | FileName | nvarchar | (50) | √ |  |  |  |  | 文件名：使用者可选取档 |
| 7 | FileVersion | numeric | (4,0) | √ |  |  |  | 1 | 程序码版本 |
| 8 | FileSuffix | nvarchar | (50) |  |  |  | √ |  | 程序码格式 |
| 9 | DocFileName | nvarchar | (100) |  |  |  | √ |  | 档文件名称 |
| 10 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | CREATORDATE | datetime |  |  |  |  | √ |  | 建立日 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SERIALNO | nvarchar | (50) | √ |  |  |  |  | 序号 |
| 2 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | NODEID | nvarchar | (100) |  |  |  | √ |  | 节点ID |
| 6 | OPSCRIPT | nvarchar | (3000) |  |  |  | √ |  | 作业站语法 |
| 7 | PSNO | nvarchar | (50) |  |  |  |  |  | 区段编号 |
| 8 | OPORDER | numeric | (6,0) |  |  |  |  |  | 作业站次序 |
| 9 | SPC_PQC | numeric | (2,0) |  |  |  |  | 0 | 制程检验 |
| 10 | QC_Control | numeric | (2,0) |  |  |  |  | 0 | 制程卡控 |
| 11 | OS_SPC_PQC | numeric | (2,0) |  |  |  |  | 0 | 外包回货检验 |
| 12 | OS_QC_Control | numeric | (2,0) |  |  |  |  | 0 | 外包回货卡控 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | AREANO | nvarchar | (20) | √ |  |  |  |  | 区域编号：区域编号 |
| 5 | DEFAULTAREA | numeric | (1,0) |  |  |  | √ |  | 预设区域：0： No，非预设区域1： Yes，预设区域 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 13 | TBLPRDPRODUCTPROCESSGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | RULEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  | 规则XML字符串 |
| 5 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | FROMNODE | nvarchar | (20) | √ |  |  |  |  | 起始节点编号 |
| 5 | TONODE | nvarchar | (20) | √ |  |  |  |  | 目地节点编号 |
| 6 | LINKNAME | nvarchar | (20) | √ |  |  |  |  | 执行结果 |
| 7 | PHASENO | numeric | (2,0) |  |  |  |  |  | 阶段编号 |
| 8 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号：选取作业站编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号：选取作业站编号 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | Remark | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SERIALNO | nvarchar | (50) |  |  |  |  |  | 序号编号 |
| 2 | RULETYPE | numeric | (1,0) |  |  |  |  |  | 规则类型 |
| 3 | RULENO | nvarchar | (20) |  |  |  |  |  | 规则编号 |
| 4 | RULESEQUENCE | numeric | (2,0) |  |  |  | √ |  | 规则次序 |
| 5 | RULEPHASE | numeric | (2,0) |  |  |  | √ |  | 规则周期 |
| 6 | RULESCRIPT | nvarchar | (3000) |  |  |  | √ |  | 规则操作序列 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | IssueState |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | Creator |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | Creation Date |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | Change personnel |
| 11 | EditDate | datetime |  |  |  |  | √ |  | Change time |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | Automatically generate GUID |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | RULEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  | RULEXMLSTRING |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序 |
| 5 | SUBOPNO | nvarchar | (20) |  |  |  |  |  | 工序编号 |
| 6 | SUBOPNAME | nvarchar | (100) |  |  |  |  |  | 工序名称 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | Creator |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | Creation Date |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | IssueState |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | Change personnel |
| 11 | EditDate | datetime |  |  |  |  | √ |  | Change time |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | Automatically generate GUID |

---

### tblPRDOPUnitConversion — 单位转换设定表（21 字段）
> 主键：PRODUCTNO, PRODUCTVERSION, PROCESSNO, PROCESSVERSION, OPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 4 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 6 | UNITNO | nvarchar | (64) |  |  |  |  |  | 单位编号 |
| 7 | C_Numerator | numeric | (12,0) |  |  |  |  | 1 | 转换分子 |
| 8 | C_Denominator | numeric | (12,0) |  |  |  |  | 1 | 转换分母 |
| 9 | C_Action | numeric | (2,0) |  |  |  |  | 99 | 转换时机：0：After Lot Create1：After Check In2：After Check Oute99：N A |
| 10 | C_Mode | numeric | (2,0) |  |  |  |  | 0 | 转换方式：0：无条件进位1：无条件舍去 |
| 11 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期 |
| 13 | C_Accuracy | numeric | (2,0) |  |  |  |  | 0 | 精确度：0：整数 (小数第1位处理)1：小数第1位 (第2位处理)2：小数第2位 (第3位处理)3：小数第3位 (第4位处理)4：小数第4位 (第5位处理)5：小数第5位 (第6位处理)6：小数第6位 (第7位处理) |
| 14 | Product_C_Rate | numeric | (16,6) |  |  |  |  | 1 | 转换率 |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | TBLPRDPRODUCTPROCESSGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblPRDPackRuleBasis — 包装规则主档（11 字段）
> 主键：PackRuleNo, PackRuleVersion
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PackRuleNo | nvarchar | (20) | √ |  |  |  |  | 包装规则编号 |
| 2 | PackRuleVersion | nvarchar | (20) | √ |  |  |  |  | 包装规则版本 |
| 3 | IssueState | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | PackSource | numeric | (1,0) |  |  |  |  |  | 包装来源：0 产品序号 1 生产批编号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPRDPackRuleDetail — 包装规则明细（14 字段）
> 主键：PackRuleNo, PackRuleVersion, PackLevelSeq
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PackRuleNo | nvarchar | (20) | √ |  |  |  |  | 包装规则编号 |
| 2 | PackRuleVersion | nvarchar | (20) | √ |  |  |  |  | 包装规则版本 |
| 3 | PackLevelSeq | nvarchar | (4) | √ |  |  |  |  | 包装层序号 |
| 4 | LevelName | nvarchar | (20) |  |  |  |  |  | 包装层名称 |
| 5 | LevelQty | numeric | (3,0) |  |  |  |  |  | 包装层数量 |
| 6 | LevelDescription | nvarchar | (255) |  |  |  | √ |  | 包装层说明 |
| 7 | PackLevelGUID | nvarchar | (50) |  |  |  |  |  | 包装层识别码：产生全域识别码 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 数据状态：创建者 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 数据创建人员：创建时间 |
| 10 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 11 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 数据创建时间：修改者 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 数据修改人员：修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPRDPackRuleMap — 产品包装规则对应（12 字段）
> 主键：ProductNo, ProductVersion, PackRuleNo, PackRuleVersion
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PackRuleNo | nvarchar | (20) | √ |  |  |  |  | 包装规则编号 |
| 4 | PackRuleVersion | nvarchar | (20) | √ |  |  |  |  | 包装规则版本 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPRDPackRuleRelation — 包装规则关联（137 字段）
> 主键：PackLevelGUID, RelationType, RelationNO, PICTURENAME, PRODUCTNO, PRODUCTVERSION, PRODUCTIONINFCODE, PRODUCTTYPE, EQUIPMENTNO, EQUIPMENTNO, PRODUCTIONINFCODE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PackLevelGUID | nvarchar | (64) | √ |  |  |  |  | 包装层识别码：产生全域识别码 |
| 2 | RelationType | nvarchar | (1) | √ |  |  |  |  | 关联类别：0：包装序号规则 1：包装标签 |
| 3 | RelationNO | nvarchar | (50) | √ |  |  |  |  | 关联序号：RelationType=0，包装规则编号；RelationType=1，包装标签编号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 7 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PICTURENAME | nvarchar | (50) | √ |  |  |  |  | 图片名称 |
| 2 | PICTUREBODY | varbinary | (-1) |  |  |  |  |  | 图片 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号：产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (10) | √ |  |  |  |  | 产品版本：产品版本 |
| 3 | PRODUCTNAME | nvarchar | (255) |  |  |  | √ |  | 产品名称：产品名称 |
| 4 | PRODUCTTYPE | nvarchar | (50) |  |  |  |  |  | 产品类别：产品类别 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 9 | CURVERSION | numeric | (1,0) |  |  |  |  | 0 | 目前版本：0：No，否 1：Yes，是 |
| 10 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号：单位编号 |
| 11 | UNITTYPE | nvarchar | (30) |  |  |  | √ |  | 单位类别：单位类别 |
| 12 | SPECNO | nvarchar | (120) |  |  |  |  | 'N/A' | 规格书编号：规格书编号 |
| 13 | CARTONQTY | numeric | (8,0) |  |  |  |  | 0 | 大箱装箱数：设定方式：一个大箱要放几个小箱，如：若5小箱装1大箱，则在大箱装箱数输入5 |
| 14 | PALLETQTY | numeric | (8,0) |  |  |  |  | 0 | 栈板装箱数：设定方式：一个栈板要放几个大箱，如：若每个栈板要放2个大箱数，则在栈板装箱数输入2。 |
| 15 | PACKOIPATH | nvarchar | (500) |  |  |  | √ |  | 指导书路径与文档名：User自行设定指导书路径与文档名 |
| 16 | BOXQTY | numeric | (10,4) |  |  |  | √ | 0 | 小箱装箱数：大箱装箱数 |
| 17 | PRODUCTCODE | nvarchar | (30) |  |  |  | √ |  | 产品简码：产品简码 |
| 18 | SERIALTYPENO_LOT | nvarchar | (50) |  |  |  | √ |  | 批号序号规则：生产批编号使用的编码规则。 设定时，开窗之资料来源为 系统管理模块-批号规则设定功能设定之资料。 空白代表使用 DEFAULT 之编码规则。 |
| 19 | SERIALTYPENO_COMP | nvarchar | (50) |  |  |  | √ |  | 组件编号序号规则：组件编号使用之编码规则。 设定时，开窗之资料来源为 系统管理模块-批号规则设定功能设定之资料。 空白代表使用 DEFAULT 之编码规则。 |
| 20 | PictureName | nvarchar | (50) |  |  |  | √ |  | 图片名称：点击汇入，选择图片 |
| 21 | LOTSTDQTY | numeric | (12,4) |  |  |  | √ | 0 | 标准批量：.0000： 不设定标准批量 X.0000：X为自己设定的标准批量值 |
| 22 | ERPNo | nvarchar | (50) |  |  |  | √ |  | ERP单号：ERP单号 |
| 23 | ItemSpec | nvarchar | (255) |  |  |  | √ |  | 项目规格：用户可自定义 |
| 24 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位01：用户自定义字段01 |
| 25 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位02：用户自定义字段02 |
| 26 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位03：用户自定义字段03 |
| 27 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位04：用户自定义字段04 |
| 28 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位05：用户自定义字段05 |
| 29 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位06：用户自定义字段06 |
| 30 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位07：用户自定义字段07 |
| 31 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位08：用户自定义字段08 |
| 32 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位09：用户自定义字段09 |
| 33 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位10：用户自定义字段10 |
| 34 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位11：用户自定义字段11 |
| 35 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位12：用户自定义字段12 |
| 36 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位13：用户自定义字段13 |
| 37 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位14：用户自定义字段14 |
| 38 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位15：用户自定义字段15 |
| 39 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位16：用户自定义字段16 |
| 40 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位17：用户自定义字段17 |
| 41 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位18：用户自定义字段18 |
| 42 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位19：用户自定义字段19 |
| 43 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位20：用户自定义字段20 |
| 44 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自订栏位21：用户自定义字段21 |
| 45 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自订栏位22：用户自定义字段22 |
| 46 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自订栏位23：用户自定义字段23 |
| 47 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自订栏位24：用户自定义字段24 |
| 48 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自订栏位25：用户自定义字段25 |
| 49 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自订栏位26：用户自定义字段26 |
| 50 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自订栏位27：用户自定义字段27 |
| 51 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自订栏位28：用户自定义字段28 |
| 52 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自订栏位29：用户自定义字段29 |
| 53 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自订栏位30：用户自定义字段30 |
| 54 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位31：用户自定义字段31 |
| 55 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自订栏位32：用户自定义字段32 |
| 56 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位33：用户自定义字段33 |
| 57 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自订栏位34：用户自定义字段34 |
| 58 | GraphNo | nvarchar | (255) |  |  |  | √ |  | 图号：图号 |
| 59 | QCCategory | nvarchar | (50) |  |  |  | √ | 'N/A' | 品管类别：用户可自订 |
| 60 | ARTICLENO | nvarchar | (51) |  |  |  | √ |  | 货号：10 25 哲玮比对后添加 |
| 61 | STOCKLOTNO | numeric | (1,0) |  |  |  |  | 0 | 入库批次号管理：入库批次号管理 |
| 62 | ProductPCSNo | numeric | (1,0) |  |  |  |  | 0 | 启用序列号管理 |
| 63 | OSerp_type | nvarchar | (20) |  |  |  | √ |  | 外包出货单ERP单别 |
| 64 | OSReturnerp_type | nvarchar | (20) |  |  |  | √ |  | 外包回货单ERP单别 |
| 65 | MPQty | numeric | (6,0) |  |  |  | √ |  | 最小包装数：最小包装数 |
| 66 | MPCount | numeric | (1,0) |  |  |  | √ | 0 | 计算打印份数管理：0 无 1 相同标签编号  2：不同标签编号  自动出站使用最小包装自动计算打印份数 |
| 67 | ISPRODUCTPCSNO | numeric | (1,0) |  |  |  | √ |  | 启用串行号管理：0 无 1 启用 |
| 68 | PCBTIMECONTROLMODE | numeric | (1,0) |  |  |  | √ |  | PCB开封超时管控模式：0 不检查，1 仅提醒，2 强制控制 |
| 69 | PCBTIMELIMIT | numeric | (5,0) |  |  |  | √ |  | PCB管控时间上限(h)：PCB管控时间上限(h) |
| 70 | SINGLEBOARDTIME | numeric | (6,0) |  |  |  | √ |  | 单板工时：单位 秒 |
| 71 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 72 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 73 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID：数据键值 |
| 74 | Runcardno | nvarchar | (50) |  |  |  |  | 'Runcard' | 流程卡编号：流程卡编号 |
| 1 | PRODUCTIONINFCODE | nvarchar | (50) | √ |  |  |  |  | 生产信息编号 |
| 2 | PRODUCTIONINFNAME | nvarchar | (50) |  |  |  | √ |  | 生产信息名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 收集方式 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 2 | PRODUCTIONINFCODE | nvarchar | (50) | √ |  |  |  |  | 生产信息编号 |
| 3 | COLLECTMETHOD | nvarchar | (5) |  |  |  | √ |  | 收集方式：1 文本 2 是(GOOD) 否(NG) 3 数值 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | HAVEPRODTYPE | numeric | (1,0) |  |  |  |  | 0 | 产品类别：0 否 1 是 |
| 7 | GroupNo | nvarchar | (50) |  |  |  | √ |  | 群组编号 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 12 | TBLEQPEQUIPMENTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 13 | TBLOPBASIS_EQUIPMENTNOGUID | nvarchar | (50) |  |  |  | √ |  | 父键值：设备编号 |
| 14 | SERIAL | numeric | (4,0) |  |  |  | √ |  | 序号：数据排序使用 (上移、下移) |
| 1 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 2 | QTY | numeric | (12,4) |  |  |  | √ |  | 数量 |
| 3 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 4 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | PRODUCTIONINFCODE | nvarchar | (50) |  |  |  | √ |  | 生产信息编号 |
| 7 | PRODUCTIONINFVALUE | nvarchar | (500) |  |  |  | √ |  | 生产信息值 |
| 8 | GroupNo | nvarchar | (50) |  |  |  | √ |  | 群组编号 |
| 9 | LotSerial | nvarchar | (55) |  |  |  | √ |  | 生产批流水号 |
| 10 | DonorUserNo | nvarchar | (10) |  |  |  | √ |  | 操作者编号 |
| 11 | DonorRemark | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblPRDProductIoninfGroup — 生产讯息群组（76 字段）
> 主键：GroupNo, PlugIn, PRODUCT, PDLINENO, SID, PRODUCTNO, PRODUCTVERSION, PROCESSNO, MOTYPENO, PROCESSVERSION, PRODUCTNO, PRODUCTVERSION, PROPERTYNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GroupNo | nvarchar | (50) | √ |  |  |  |  | 群组编号 |
| 2 | GroupName | nvarchar | (255) |  |  |  | √ |  | 群组名称 |
| 3 | PlugIn | numeric | (2,0) | √ |  |  |  | 0 | 作业站属性 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCT | nvarchar | (50) | √ |  |  |  |  | 产品 |
| 2 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线别单号 |
| 3 | STDOPNUMBER | numeric | (2,0) |  |  |  |  |  | 标准人数 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | numeric | (8,0) | √ |  | √ |  |  | SID |
| 2 | ENABLE | numeric | (1,0) |  |  |  |  |  | 启用 |
| 3 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 4 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | RULENO | nvarchar | (50) |  |  |  |  |  | 规则编号：RULE_SCRAP  废品规则RULE_YIELD_LS 低良率规则RULE_YIELD_LCL 异常良率RULE_OutputRate 完工比例RULE_OVERSTEPRATE 超出比例限制OUTBOUND_PRINT_LABEL 自动出站打印标签RULE_COOLDOWNTIME 上道作业站冷却时间RULE_SIMILARITY_FLAG  连批标识 |
| 7 | TRIGGERTIME | nvarchar | (20) |  |  |  |  |  | 触发时机：CHECK_OUT |
| 8 | VERIFYINFO | nvarchar | (500) |  |  |  |  |  | 设定值 |
| 9 | PRIORITY | numeric | (4,0) |  |  |  |  |  | 优先权 |
| 10 | CREATETIME | datetime |  |  |  |  | √ |  | 建立日 |
| 11 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 13 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 14 | CHECKVALUE | numeric | (4,0) |  |  |  |  | 0 | 输入值 |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PSNO | nvarchar | (50) |  |  |  |  |  | 区段编号：设定时，开窗之数据来源为生产模型管理模块-生产区段功能设定之数据。 |
| 4 | PSORDER | numeric | (2,0) |  |  |  |  |  | 区段次序：依据User选取的区段编号，系统自区段主数据撷取区段次序。设定时，User可自行设定区段次序。 |
| 5 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号：设定时，开窗之数据来源为生产模型管理模块-产品流程管理功能设定之数据。 |
| 6 | DEFAULTPROCESS | numeric | (1,0) |  |  |  | √ | 0 | 预设流程：User指定此流程是否为该区段的预设流程1：是，区段内预设流程0：否，非该区段的预设流程 |
| 7 | HAVECOMPONENT | numeric | (1,0) |  |  |  |  |  | 是否有组件：0  否1  是 |
| 8 | HAVELEVEL | numeric | (1,0) |  |  |  |  |  | 是否有Bin分布：0  否1  是 |
| 9 | MOTYPENO | numeric | (2,0) | √ |  |  |  |  | 工单类别编号：设定时，开窗之数据来源为工单管理模块-工单基本数据功能设定之数据。 |
| 10 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本：系统之流程是有版本的机制，于生产批下线或换区段时，系统会依设定来决定使用流程之目前版本或某一指定版本。 ：目前版本，为流程数据内目前版本为Yes之流程。一般来说，目前版本代表为此流程之最新版本。非 ：指定版本。 |
| 11 | EquipmentGroup | nvarchar | (50) |  |  |  | √ |  | 设备群组 |
| 12 | APSFixEQPTime | numeric | (8,0) |  |  |  | √ |  | APS固定机时 |
| 13 | APSVarEQPTime | numeric | (8,0) |  |  |  | √ |  | APS变动机时 |
| 14 | STDWorkTimeQty | numeric | (8,0) |  |  |  | √ |  | 标准工时 |
| 15 | TransferQty | numeric | (8,0) |  |  |  | √ |  | 转换数量 |
| 16 | LotRearTime | numeric | (8,0) |  |  |  | √ |  | 生产批后制工时 |
| 17 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 23 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号：设定时，开窗之数据来源为系统管理模块-特性设定功能设定之数据。 |
| 4 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 预设值 |
| 5 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  |  | 0 | 签核状态：0 Unfrozen(未签核)1 Pending(签核中) 2 Active(已签核)-1 Unused(不使用) |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblPRDProperty — 产品属性（148 字段）
> 主键：ProductNo, ProductVersion, PropertyNo, PROCESSNO, PROCESSVERSION, MOTYPENO, OPNO, NODEID, PROCESSNO, PROCESSVERSION, MOTYPENO, OPNO, NODEID, EQUIPMENTNO, PRODUCTNO, PRODUCTVERSION, PROCESSNO, PROCESSVERSION, MOTYPENO, OPNO, NODEID, PRODUCTNO, PRODUCTVERSION, PROCESSNO, PROCESSVERSION, MOTYPENO, OPNO, NODEID, EQUIPMENTNO, PRODUCTNO, PRODUCTVERSION, OPNO, EQUIPMENTNO, PRODUCTNO, PRODUCTVERSION, AREANO, OPNO, EQUIPMENTNO, EQUIPMENTTYPE, PRODUCTNO, PRODUCTVERSION, TOOLTYPENO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ProductNo | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | ProductVersion | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PropertyNo | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 4 | PropertyValue | nvarchar | (255) |  |  |  | √ |  | 属性值 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 2 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 3 | MOTYPENO | numeric | (2,0) | √ |  |  |  |  | 工单型别编号 |
| 4 | OPNO | nvarchar | (25) | √ |  |  |  |  | 作业站编号 |
| 5 | NODEID | nvarchar | (100) | √ |  |  |  |  | 作业站ID |
| 6 | EQUIPMENTGROUP | nvarchar | (50) |  |  |  | √ |  | 资源群组：APS整合使用 |
| 7 | SCHEDULE | numeric | (1,0) |  |  |  | √ |  | 排程：APS整合使用(0 否；1 是) |
| 8 | SUBCONTRACTORNO | nvarchar | (30) |  |  |  | √ |  | 供应商：APS整合使用 |
| 9 | APSFIXEQPTIME | numeric | (8,0) |  |  |  | √ |  | APS固定机时：APS整合使用 |
| 10 | APSVAREQPTIME | numeric | (8,0) |  |  |  | √ |  | APS变动机时：APS整合使用 |
| 11 | STDWORKTIMEQTY | numeric | (8,0) |  |  |  | √ |  | 工时基准数量：APS整合使用 |
| 12 | TRANSFERQTY | numeric | (8,0) |  |  |  | √ |  | 移转数量：APS整合使用 |
| 13 | LOTREARTIME | numeric | (8,0) |  |  |  | √ |  | 批量后置时间：APS整合使用 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | TBLPRSPROCESSPROPERTYGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 20 | TBLPRSPROCESSBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 2 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 3 | MOTYPENO | numeric | (2,0) | √ |  |  |  | -1 | 工单型别编号 |
| 4 | OPNO | nvarchar | (25) | √ |  |  |  |  | 作业站编号 |
| 5 | NODEID | nvarchar | (100) | √ |  |  |  |  | 作业站ID |
| 6 | EQUIPMENTGROUP | nvarchar | (50) |  |  |  | √ |  | 资源群组：APS整合使用 |
| 7 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 资源编号：APS整合使用 |
| 8 | APSFIXEQPTIME | numeric | (8,0) |  |  |  | √ |  | APS固定机时：APS整合使用 |
| 9 | APSVAREQPTIME | numeric | (8,0) |  |  |  | √ |  | APS变动机时：APS整合使用 |
| 10 | STDWORKTIMEQTY | numeric | (8,0) |  |  |  | √ |  | 工时基准数量：APS整合使用 |
| 11 | TRANSFERQTY | numeric | (8,0) |  |  |  | √ |  | 移转数量：APS整合使用 |
| 12 | LOTREARTIME | numeric | (8,0) |  |  |  | √ |  | 批量后置时间：APS整合使用 |
| 13 | SCHEDULE | numeric | (1,0) |  |  |  | √ |  | 排程：APS整合使用(0 否；1 是) |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | TBLPRDPRSOPAPSBASEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (64) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 4 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 5 | MOTYPENO | numeric | (2,0) | √ |  |  |  |  | 工单型别编号 |
| 6 | OPNO | nvarchar | (25) | √ |  |  |  |  | 作业站编号 |
| 7 | NODEID | nvarchar | (100) | √ |  |  |  |  | 节点识别符号(ID) |
| 8 | EQUIPMENTGROUP | nvarchar | (50) |  |  |  | √ |  | 资源群组：APS整合使用 |
| 9 | APSFIXEQPTIME | numeric | (8,0) |  |  |  | √ |  | APS固定机时：APS整合使用 |
| 10 | APSVAREQPTIME | numeric | (8,0) |  |  |  | √ |  | APS变动机时：APS整合使用 |
| 11 | STDWORKTIMEQTY | numeric | (8,0) |  |  |  | √ |  | 工时基准数量：APS整合使用 |
| 12 | TRANSFERQTY | numeric | (8,0) |  |  |  | √ |  | 移转数量：APS整合使用 |
| 13 | LOTREARTIME | numeric | (8,0) |  |  |  | √ |  | 批量后置时间：APS整合使用 |
| 14 | SUBCONTRACTORNO | nvarchar | (30) |  |  |  | √ |  | 供应商：APS整合使用 |
| 15 | SCHEDULE | numeric | (1,0) |  |  |  | √ |  | 排程：APS整合使用(0 否；1 是) |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 22 | TBLPRDPRODUCTPROCESSGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (64) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 4 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 5 | MOTYPENO | numeric | (2,0) | √ |  |  |  |  | 工单型别编号 |
| 6 | OPNO | nvarchar | (25) | √ |  |  |  |  | 作业站编号 |
| 7 | NODEID | nvarchar | (100) | √ |  |  |  |  | 作业站ID |
| 8 | EQUIPMENTGROUP | nvarchar | (50) |  |  |  | √ |  | 资源群组：APS整合使用 |
| 9 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 资源编号：APS整合使用 |
| 10 | APSFIXEQPTIME | numeric | (8,0) |  |  |  | √ |  | APS固定机时：APS整合使用 |
| 11 | APSVAREQPTIME | numeric | (8,0) |  |  |  | √ |  | APS变动机时：APS整合使用 |
| 12 | STDWORKTIMEQTY | numeric | (8,0) |  |  |  | √ |  | 工时基准数量：APS整合使用 |
| 13 | TRANSFERQTY | numeric | (8,0) |  |  |  | √ |  | 移转数量：APS整合使用 |
| 14 | LOTREARTIME | numeric | (8,0) |  |  |  | √ |  | 批量后置时间：APS整合使用 |
| 15 | SCHEDULE | numeric | (1,0) |  |  |  | √ |  | 排程：APS整合使用(0 否；1 是) |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | TBLPRDPRSOPAPSSETUPGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 6 | VAREQPTIME | numeric | (15,4) |  |  |  | √ |  | 变动机时(分) |
| 7 | COUNTEQPUNITQTY | numeric | (6,0) |  |  |  | √ |  | 计时基本数量(机时) |
| 8 | STATUS | numeric | (1,0) |  |  |  |  |  | 处理状态：0 未处理 1 已更新 2 已作废 |
| 9 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 10 | REPORTER | nvarchar | (30) |  |  |  | √ |  | 回报人 |
| 11 | REPORTDATE | datetime |  |  |  |  | √ |  | 回报日 |
| 12 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 3 | AREANO | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 设备编号 |
| 6 | EQUIPMENTTYPE | nvarchar | (50) | √ |  |  |  | 'N/A' | 设备类别 |
| 7 | STDUNITEMPTIME | numeric | (6,2) |  |  |  |  | 0 | 标准单位工时 |
| 8 | STDUNITEQPTIME | numeric | (6,2) |  |  |  |  | 0 | 标准单位机时 |
| 9 | COUNTEQPUNITQTY | numeric | (6,0) |  |  |  |  | 1 | 计时基本数量(机时) |
| 10 | STDUNITRUNTIME | numeric | (6,2) |  |  |  |  | 0 | 标准作业时间 |
| 11 | COUNTOPUNITQTY | numeric | (6,0) |  |  |  |  | 1 | 计时基本数量(人时) |
| 12 | STDQUEUETIME | numeric | (6,2) |  |  |  |  | 0 | 标准等待时间 |
| 13 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | FIXEMPTIMEA | numeric | (15,4) |  |  |  | √ | 0 | 固定人时(分) |
| 16 | VAREMPTIME | numeric | (15,4) |  |  |  | √ | 0 | 变动人时(分) |
| 17 | FIXEQPTIME | numeric | (15,4) |  |  |  | √ | 0 | 固定机时(分) |
| 18 | VAREQPTIME | numeric | (15,4) |  |  |  | √ | 0 | 变动机时(分) |
| 19 | FIXEMPTIME | numeric | (15,4) |  |  |  | √ | 0 | 固定人时(分)：修改 |
| 20 | WorkPriceType | numeric | (1,0) |  |  |  | √ | 1 | 工资型别 |
| 21 | WorkPrice | numeric | (23,8) |  |  |  | √ |  | 工价 |
| 22 | EquivalentRatio | numeric | (10,4) |  |  |  |  | 1 | 约当比 |
| 23 | StampingSpeed | numeric | (15,4) |  |  |  |  | 0 | 约当比 |
| 24 | EQPTYPESYN | numeric | (1,0) |  |  |  | √ | 1 | 是否同步设备类别 |
| 25 | STDNUMBERCAVITY | numeric | (6,0) |  |  |  |  | 0 | 标准穴数 |
| 26 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 27 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 28 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 29 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 30 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 31 | TBLPRDOPAREAGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 2 | PRODUCTVERSION | nvarchar | (10) | √ |  |  |  |  | 产品版本 |
| 3 | TOOLTYPENO | nvarchar | (50) | √ |  |  |  |  | 工具型号 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPRDStartInspection — 始业点检设定（256 字段）
> 主键：PRODUCTNO, INSPECTIONSEQ, SUBOPNO, PSNO, PRODUCTTYPE, OPNO, SUBOPSEQUENCE, EQUIPMENTNO, PRODUCTTYPE, OPNO, SUBOPSEQUENCE, UNITNAME, EQUIPMENTNO, PRODUCTTYPE, OPNO, SUBOPSEQUENCE, REASONNO, PRODUCTTYPE, PRODUCTTYPE, TOOLTYPENO, NODEID, NODEID, NODEID, PROCESSNO, PROCESSVERSION, FROMNODEID, TONODEID, LINKNAME, FROMNODEID, TONODEID, LINKNAME, PROCESSNO, PROCESSVERSION, PROCESSNO, PROCESSVERSION, PROCESSNO, PROPERTYNO, PROCESSVERSION, PSNO, PROCESSTYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PRODUCTNO | nvarchar | (100) | √ |  |  |  |  | 产品编号：产品编号 |
| 2 | INSPECTIONNO | nvarchar | (100) |  |  |  |  |  | 检验编号：检验编号 |
| 3 | INSPECTIONSEQ | numeric | (2,0) | √ |  |  |  |  | 检验顺序：检验顺序 |
| 4 | INSPECTIONNAME | nvarchar | (255) |  |  |  | √ |  | 检验名称：检验名称 |
| 5 | AREANO | nvarchar | (50) |  |  |  |  |  | 区域编号：区域编号 |
| 6 | POSITIONNO | nvarchar | (50) |  |  |  |  |  | 工位编号：工位编号 |
| 7 | INSPECTIONTYPE | numeric | (1,0) |  |  |  |  |  | 检验类型：检验类型 |
| 8 | MAXIVALUE | nvarchar | (12) |  |  |  | √ |  | 最大值：最大值 |
| 9 | MINIVALUE | nvarchar | (12) |  |  |  | √ |  | 最小值：最小值 |
| 10 | INSPECTIONSTANDARD | nvarchar | (255) |  |  |  | √ |  | 检验标准：检验标准 |
| 11 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | INSPECTIONMETHOD | nvarchar | (100) |  |  |  | √ |  | 检验方法：检验方法 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 18 | TBLPRDPRODUCTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值：父键值 |
| 1 | SUBOPNO | nvarchar | (20) | √ |  |  |  |  | 子作业编号 |
| 2 | SUBOPNAME | nvarchar | (255) |  |  |  |  |  | 子作业名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 子作业说明 |
| 4 | PSNO | nvarchar | (50) | √ |  |  |  |  | 区段编号 |
| 5 | SUBOPORDER | numeric | (6,0) |  |  |  |  | 0 | 显示顺序 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | FIXEMPTIME | numeric | (6,2) |  |  |  |  | 0 | 固定人时 |
| 8 | VAREMPTIME | numeric | (6,2) |  |  |  |  | 0 | 变动人时 |
| 9 | FIXEQPTIME | numeric | (6,2) |  |  |  |  | 0 | 固定机时 |
| 10 | VAREQPTIME | numeric | (6,2) |  |  |  |  | 0 | 变动机时 |
| 11 | COUNTUNITQTY | numeric | (6,0) |  |  |  |  | 1 | 计时单位 |
| 12 | NEEDREPORT | numeric | (1,0) |  |  |  |  | 1 | 是否强制报工：0：否 1：是 |
| 13 | AUTOCO | numeric | (1,0) |  |  |  |  | 0 | 是否自动出站：0：否 1：是 |
| 14 | CONFIRMLOTSTATE | numeric | (1,0) |  |  |  |  | 1 | 生产批已进站方能报工：0：否 1：是 |
| 15 | RECORDEQP | numeric | (1,0) |  |  |  |  | 0 | 是否纪录生产设备及机时：0：否 1：是 |
| 16 | PRINTOUT | numeric | (1,0) |  |  |  |  | 0 | 是否打印：0：否 1：是 |
| 17 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序次序 |
| 4 | COLLECTTYPE | numeric | (1,0) |  |  |  |  |  | 收集类别：收集类别有三种0：显示eSOP1：刷成品序号2：刷成品序号或部件序号3：刷部件序号 (#74227 add bruce)4   刷成品序号(添加PCBA序号未预先产生在工位第一次收集) |
| 5 | AUTOCO | numeric | (1,0) |  |  |  |  | 0 | 自动出站：0：否1：是勾选框勾选为是，不勾选为否 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | PRINTLABEL | numeric | (1,0) |  |  |  |  | 0 | 打印标签：0：否1：是勾选框勾选为是，不勾选为否 |
| 9 | LABELTYPE | nvarchar | (50) |  |  |  | √ |  | 标签型别：可选择标签型别 |
| 10 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 设备编号 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | TBLPRDTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序次序 |
| 4 | UNITNAME | nvarchar | (50) | √ |  |  |  |  | 物料类别名称 |
| 5 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 6 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 设备编号 |
| 7 | COLLECTIONCCOUNT | numeric | (4,0) |  |  |  |  | 0 | 部件个数 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | TBLPRDSUBOPCOLLECTIONGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序次序 |
| 4 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 检验编号 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别：产品类别定义 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 6 | EX_PRDTYPE1 | nvarchar | (20) |  |  |  | √ |  | 产品类别延伸栏位1：产品类别延伸栏位1 |
| 7 | EX_PRDTYPE2 | nvarchar | (20) |  |  |  | √ |  | 产品类别延伸栏位2：产品类别延伸栏位2 |
| 8 | PRODUCTTYPECODE | nvarchar | (30) |  |  |  | √ |  | 产品类别代码 |
| 9 | ISCOLLECTION | nvarchar | (1) |  |  |  |  | '0' | 收集序号：1 收集；0 不搜集 |
| 10 | CONTROLPASS | nvarchar | (1) |  |  |  | √ |  | 管控末道工序过站：1 管控；0 不管控 |
| 11 | BYSTDQTY | numeric | (1,0) |  |  |  |  | 1 | 扣料依据：0 未勾选 1 标准用量(料站表设定) 2 实际用量(整合贴片机) |
| 12 | BYTIME | numeric | (1,0) |  |  |  |  | 1 | 扣料时机：0 未勾选 1 出站 2 扣料点工序过站 |
| 13 | BYPIECE | numeric | (1,0) |  |  |  |  | 1 | 扣料方式：0 未勾选 1 批量扣料 2 单片扣料 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别 |
| 2 | TOOLTYPENO | nvarchar | (50) | √ |  |  |  |  | 工具型号 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | NODEID | nvarchar | (100) | √ |  |  |  |  | 节点标识符(ID) |
| 2 | NODENO | nvarchar | (50) |  |  |  |  |  | 节点编号 |
| 3 | NODETYPE | numeric | (1,0) |  |  |  |  | 0 | 节点类别：0 OP 1 SubProcess 6 AndGroup 7 OrGroup 8 Start 9 End |
| 4 | PROCESSNO | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 5 | GROUPNO | nvarchar | (30) |  |  |  | √ |  | 群组编号 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | PROCESSVERSION | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 10 | NODEVERSION | nvarchar | (5) |  |  |  | √ | 'N/A' | 节点版本 |
| 11 | STAGENO | nvarchar | (50) |  |  |  | √ |  | 制造层别编号：Stage编号 |
| 12 | SEQUENCE | numeric | (4,0) |  |  |  | √ |  | 次序 |
| 13 | OPSeq | nvarchar | (4) |  |  |  | √ |  | 作业站顺序：流程创建后由系统依照前后顺序计算 |
| 14 | Remark | nvarchar | (255) |  |  |  | √ |  | 备注(from ERP) |
| 15 | CONFLUENCE | numeric | (1,0) |  |  |  |  | 0 | 汇入节点制造类型：标明此汇入节点的前序作业站是何种生产模式，0默认，1平行制程，2组装制程 #90396 朱煜轲 |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | TBLPRDPRODUCTPROCESSGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | NODEID | nvarchar | (100) | √ |  |  |  |  | 节点ID |
| 2 | NODENO | nvarchar | (50) |  |  |  |  |  | 节点编号 |
| 3 | NODETYPE | numeric | (1,0) |  |  |  |  | 0 | 节点类别：0 OP 1 SubProcess 6 AndGroup 7 OrGroup 8 Start 9 End |
| 4 | PROCESSNO | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 5 | GROUPNO | nvarchar | (30) |  |  |  | √ |  | 群组编号 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | PROCESSVERSION | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 10 | NODEVERSION | nvarchar | (5) |  |  |  | √ | 'N/A' | 节点版本 |
| 11 | STAGENO | nvarchar | (50) |  |  |  | √ |  | 制造层别编号：Stage编号 |
| 12 | SEQUENCE | numeric | (4,0) |  |  |  | √ |  | 次序 |
| 13 | OPSeq | nvarchar | (4) |  |  |  | √ |  | 作业站顺序 |
| 14 | Remark | nvarchar | (255) |  |  |  | √ |  | 备注(from ERP) |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | NODEID | nvarchar | (50) | √ |  |  |  |  | 节点标识符(ID) |
| 2 | NODENO | nvarchar | (50) |  |  |  |  |  | 节点编号 |
| 3 | PROCESSNO | nvarchar | (30) | √ |  |  |  |  | 流程编号 |
| 4 | GROUPNO | nvarchar | (30) |  |  |  | √ |  | 群组编号 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FROMNODEID | nvarchar | (100) | √ |  |  |  |  | 起始节点编号：起始节点编号 |
| 2 | TONODEID | nvarchar | (100) | √ |  |  |  |  | 目地节点编号：目地节点编号 |
| 3 | LINKNAME | nvarchar | (64) | √ |  |  |  |  | 链接名称：执行结果 |
| 4 | FROMNODENO | nvarchar | (50) |  |  |  | √ |  | 起始节点作业站编号：起始节点作业站编号 |
| 5 | TONODENO | nvarchar | (50) |  |  |  | √ |  | 目地节点作业站编号：目地节点作业站编号 |
| 6 | PROCESSNO | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 7 | PROCESSVERSION | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 14 | TBLPRDPRODUCTPROCESSGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 15 | TBLWIPLOTSTATEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | FROMNODEID | nvarchar | (100) | √ |  |  |  |  | 起始节点编号 |
| 2 | TONODEID | nvarchar | (100) | √ |  |  |  |  | 目地节点编号 |
| 3 | LINKNAME | nvarchar | (64) | √ |  |  |  |  | 运行结果 |
| 4 | FROMNODENO | nvarchar | (50) |  |  |  | √ |  | 起始节点作业站编号 |
| 5 | TONODENO | nvarchar | (50) |  |  |  | √ |  | 目地节点作业站编号 |
| 6 | PROCESSNO | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 7 | PROCESSVERSION | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 2 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 3 | NODEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  | 节点XML字符串 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 2 | PROCESSCLASS | numeric | (2,0) |  |  |  |  | 0 | 流程分类：0 Production(一般流程) 3 OS(外包虚拟流程)，于设定外包项目时必须选择一条虚拟流程，由虚拟流程可看出是单站外包或多站外包。另外，若外包项目选择 不回原流程 ，则外包回货后，会将Lot转至外包流程之下一站，若无下一站，则直接入库。4：重工流程.9-自定义流程(临时选择生成) |
| 3 | PSNO | nvarchar | (50) |  |  |  |  |  | 区段编号：制程型态的划分，一个流程只能归属于一个区段，不同区段的作业站，无法建置于同一流程上。 区段的分法： 1.一种产品型态一个区段，如：半导体的CP、FT或LED的EPI、CHIP、PACKAGE 2.一个事业处一个区段 3.若不知道如何划分，也可单纯的就定义一个生产区段 |
| 4 | PROCESSTYPE | nvarchar | (20) |  |  |  |  |  | 流程类别：User选取先前所设定的数据 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | NODEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  | 节点XML字符串：节点之XML字符串 |
| 10 | TUNINGPROCESS | numeric | (1,0) |  |  |  | √ | 0 | TUNINGPROCESS：0 否 1 是 |
| 11 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  |  | 流程版本 |
| 12 | CURVERSION | numeric | (1,0) |  |  |  |  | 0 | 目前版本：0：No，否 1：Yes，是 |
| 13 | RUNCARDNODEXML | nvarchar | (-1) |  |  |  | √ |  | 运行卡节点XML |
| 14 | PartialType | numeric | (1,0) |  |  |  | √ | 0 | 部分类型 |
| 15 | IsAutoStockIn | numeric | (1,0) |  |  |  | √ |  | 自动入库 |
| 16 | IsStockIn2ERP | numeric | (1,0) |  |  |  | √ |  | 入库产生ERP生产入库单 |
| 17 | IsSendDPM2ERP | numeric | (1,0) |  |  |  | √ |  | 入库产生DPM报工单 |
| 18 | ERPDocType | nvarchar | (50) |  |  |  | √ |  | ERP整合型别 |
| 19 | ProcessName | nvarchar | (255) |  |  |  | √ |  | 流程名称 |
| 20 | process_item | nvarchar | (50) |  |  |  | √ |  | 途程品号(from ERP) |
| 21 | process_erpno | nvarchar | (50) |  |  |  | √ |  | 途程代号(from ERP) |
| 22 | ERPCurrent | numeric | (1,0) |  |  |  | √ |  | 是否ERP最新途程：0 否 1 是 |
| 23 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 24 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 25 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSNO | nvarchar | (64) | √ |  |  |  |  | 流程编号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号：系统加载,User选取 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 默认值 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 签核状态：0 Unfrozen(未签核)1 Pending(签核中) 2 Active(已签核)-1 Unused(不使用) |
| 7 | PROCESSVERSION | nvarchar | (5) | √ |  |  |  | '-1' | 流程版本 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | TBLPRSTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 14 | TBLPRSPROCESSBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | PSNO | nvarchar | (50) | √ |  |  |  |  | 区段编号：数据修改时间 |
| 2 | PSNAME | nvarchar | (50) |  |  |  |  |  | 区段名称：数据修改时间 |
| 3 | PSORDER | numeric | (2,0) |  |  |  |  | 0 | 区段次序：是区段间先后次序的标注字段，区段次序的设定影响了集成性制程的连结性，系统规定在设定多区段时区段必须连续,在即区段A完成后接区段B时,区段A、B必须连续。 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  |  |  | 创建时间：数据创建时间 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：是区段间先后次序的标注字段，区段次序的设定影响了集成性制程的连结性，系统规定在设定多区段时区段必须连续,在即区段A完成后接区段B时,区段A、B必须连续。 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | HAVECOMPONENT | numeric | (1,0) |  |  |  |  | 0 | 是否有组件：0：否，本区段内的生产制程以生产批为单位 1：是，本区段内的生产制程其生产批带有组件的信息 |
| 9 | HAVELEVEL | numeric | (1,0) |  |  |  |  | 0 | 是否有Bin分布：0：否，生产批数量无等级分布 1：是，生产批数量有等级分布 |
| 10 | SERIALTYPENO_LOT | nvarchar | (50) |  |  |  | √ |  | 批号序号规则：生产批序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 11 | SERIALTYPENO_COMP | nvarchar | (50) |  |  |  | √ |  | 组件编号序号规则：组件序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 12 | ISPARTIAL | numeric | (1,0) |  |  |  |  | 0 | 批号序号规则：生产批序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 13 | IsNetFlow | numeric | (1,0) |  |  |  | √ | 0 | 批号序号规则：生产批序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 14 | IsAutoStockIn | numeric | (1,0) |  |  |  | √ | 0 | 自动入库：组件序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 15 | IsStockIn2ERP | numeric | (1,0) |  |  |  | √ | 1 | 入库产生ERP生产入库单：组件序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 16 | IsSendDPM2ERP | numeric | (1,0) |  |  |  | √ | 0 | 入库产生DPM报工单：组件序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 17 | ERPDocType | nvarchar | (50) |  |  |  | √ |  | ERP单别：组件序号类别编码使用，可至系统管理模块= 批号规则设定，使用此功能设定编码。 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROCESSTYPE | nvarchar | (20) | √ |  |  |  |  | 流程类别 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblPSSectionBasis — 工段基本设定（9 字段）
> 主键：PsSectionNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PsSectionNo | nvarchar | (10) | √ |  |  |  |  | 工段编号 |
| 2 | PSSectionName | nvarchar | (50) |  |  |  | √ |  | 工段名称 |
| 3 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPSSectionBasisDetail — 工段明细设定（8 字段）
> 主键：PsSectionNo, OpNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | PsSectionNo | nvarchar | (10) | √ |  |  |  |  | 工段编号 |
| 2 | OpNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 8 | TBLPSSECTIONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblPSSectionNodeBasis — 工段流程节点设定（12 字段）
> 主键：NodeID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SectionProcessNo | nvarchar | (64) |  |  |  | √ |  | 工段流程编号 |
| 2 | NodeID | nvarchar | (100) | √ |  |  |  |  | 节点ID |
| 3 | PsSectionNo | nvarchar | (10) |  |  |  |  |  | 区段编号 |
| 4 | NodeType | numeric | (1,0) |  |  |  |  | 0 | 节点类型 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 8 | PsSectionNoSeq | numeric | (2,0) |  |  |  | √ |  | 节点顺序 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPSSectionProcessBasis — 工段流程设置（10 字段）
> 主键：SectionProcessNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SectionProcessNo | nvarchar | (64) | √ |  |  |  |  | 工段流程编号 |
| 2 | SectionProcessName | nvarchar | (50) |  |  |  | √ |  | 工段流程名称 |
| 3 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | NodeXMLString | nvarchar | (-1) |  |  |  | √ |  | 流程图资料 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPSUserTemplateBasis — 模板记录（11 字段）
> 主键：ModelNo, ModelName, ModelUserAcc
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ModelNo | numeric | (1,0) | √ |  |  |  | 0 | 模板分类：1 正向追溯 2 生产追溯正 3 逆向追溯  4 生产追溯逆 |
| 2 | ModelName | nvarchar | (50) | √ |  |  |  | '' | 模板名称 |
| 3 | ModelSetting | nvarchar | (1000) |  |  |  | √ |  | 模板配置 |
| 4 | ModelUserAcc | nvarchar | (50) | √ |  |  |  | '' | 人员 |
| 5 | CreateTime | datetime |  |  |  |  |  | getdate | 创建日 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblPSUserTemplateSort — 模板排序（740 字段）
> 主键：ModelNo, ModelName, ModelSheet, ModelUserAcc, RULENO, RULENO, ACTION, REASONTYPE, REASONLEVEL, QCITEMNO, QCCATEGORY, MCLASSNO, OPNO, MCLASSNO, OPNO, HOLDDESCRIPTIONID, GROUPNO, HOLDITEMNO, LOTNO, OPNO, QCITEMNO, ITEMNO, INSPDRIVERNO, INSPMACHINENO, INSPMACHINETYPE, QCITEMNO, FACTORNO, QCITEMNO, QCITEMNO, QCITEMNO, PARAMETERNO, QCITEMNO, REASONNO, MCLASSNO, QCOBJECTTYPE, QCOBJECTNO, OPNO, QCOBJECTTYPE, QCOBJECTNO, OPNO, SERIALNO, QCOBJECTTYPE, QCOBJECTNO, QCITEMNO, QCITEMTYPE, OPNO, QCOPPORTUNITY, QCOBJECTTYPE, QCOBJECTTYPE, QCOBJECTNO, OPNO, QCOBJECTTYPE, QCOBJECTNO, OPNO, VERSION, QCOPPORTUNITY, REASONNO, REASONNO, REASONSUBTYPE, RULESERIAL, RULENO, QCITEMNO, OLDSAMPLEPLAN, ACCLOTQTY, REJLOTQTY, LOTRANGE, SAMPLINGTYPE, MINNUM, MAXNUM, SLEVEL, PLANNO, PARAMETERNO, PLANNO, SAMPLINGTABLE, MINNUM, MAXNUM, SCLASSNO, QTRREPORTNO, QTRREPORTNO, CONDFIELD, DATAUSEFOR, QTRREPORTNO, REPORTHEADID, CONDFIELD, REPORTLEVEL, PARAMETERNO, QTRREPORTNO, REPORTID, ITEMNO, REPORTID, LABEL, ITEMNO, REPORTID, LABEL, REPORTID, ITEMNO, REPORTID, RELATEREPORTID, ITEMNO, REPORTNAME, REPORTID, REPORTGROUPNO, REPORTID, RPTLOGSERIAL, REPORTID, ITEMNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ModelNo | numeric | (1,0) | √ |  |  |  | 1 | 模板分类：1 正向追溯 2 生产追溯正 3 逆向追溯  4 生产追溯逆 |
| 2 | ModelName | nvarchar | (50) | √ |  |  |  |  | 模板名称 |
| 3 | ModelSheet | nvarchar | (300) | √ |  |  |  |  | 模板项 |
| 4 | ModelUserAcc | nvarchar | (50) | √ |  |  |  |  | 人员 |
| 5 | Seq | numeric | (2,0) |  |  |  | √ | 1 | 排序 |
| 6 | CreateTime | datetime |  |  |  |  | √ |  | 创建日 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | RULENO | nvarchar | (20) | √ |  |  |  |  | 法则编号 |
| 2 | COMPONENTCOLLECT | numeric | (1,0) |  |  |  |  | 0 |  |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 建立人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 建立日期 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | RULENO | nvarchar | (20) | √ |  |  |  |  | 法则编号 |
| 2 | ACTION | numeric | (1,0) | √ |  |  |  |  | 动作：0：提示  2：异常  3：警告 |
| 3 | REASONTYPE | numeric | (1,0) | √ |  |  |  | 0 | 原因类别：0：Scrap(损坏)  1：Defect(缺点) |
| 4 | REASONLEVEL | numeric | (3,0) | √ |  |  |  |  | 原因等级：原因等级可以设定-1~9级 |
| 5 | REJECTNUM | numeric | (14,4) |  |  |  | √ |  | 拒收数 |
| 6 | RULETYPE | numeric | (1,0) |  |  |  | √ |  | 法则类别：0：Reject Num(拒收数) 1：Rate(比率) 2：By AQL RejectNum(根据AQL拒收数) |
| 7 | RATE | nvarchar | (10) |  |  |  | √ |  | 比率(%) |
| 8 | CHANGEAQL | nvarchar | (30) |  |  |  | √ |  | 更换AQL |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 13 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 2 | SCRIPT | nvarchar | (255) |  |  |  | √ |  | 显示描述语言 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCCATEGORY | nvarchar | (50) | √ |  |  |  |  | 品管类别 |
| 2 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 3 | QCCATEGORYNAME | nvarchar | (4000) |  |  |  | √ |  | 品管类别名称 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | QCCATEGORYTYPE | numeric | (1,0) |  |  |  | √ |  | 检验标的：0：物料 1：产品 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MCLASSNO | nvarchar | (30) | √ |  |  |  |  | 异常主分类编号 |
| 2 | OPNO | nvarchar | (100) | √ |  |  |  |  | 作业站编号 |
| 3 | GROUPNO | nvarchar | (20) |  |  |  |  |  | 群组编号 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MCLASSNO | nvarchar | (30) | √ |  |  |  |  | 异常主分类编号 |
| 2 | OPNO | nvarchar | (100) | √ |  |  |  |  | 作业站编号 |
| 3 | GROUPNO | nvarchar | (20) |  |  |  |  |  | 群组编号 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MCLASSNO | nvarchar | (100) |  |  |  |  |  | 主分类编号 |
| 2 | HOLDDESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 异常说明 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 7 | HOLDDESCRIPTIONID | nvarchar | (50) | √ |  |  |  |  | 异常说明序号 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | GROUPNO | nvarchar | (20) | √ |  |  |  |  | 群组编号 |
| 2 | GROUPNAME | nvarchar | (100) |  |  |  |  |  | 群组名称 |
| 3 | DEPARTMENTNO | nvarchar | (1000) |  |  |  | √ |  | 部门编号 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MCLASSNO | nvarchar | (100) |  |  |  |  |  | 主分类编号 |
| 2 | SCLASSNO | nvarchar | (100) |  |  |  |  |  | 次分类编号 |
| 3 | HOLDITEMNO | nvarchar | (50) | √ |  |  |  |  | 异常原因编号 |
| 4 | HOLDITEMNAME | nvarchar | (100) |  |  |  |  |  | 异常原因名称 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 9 | CREATEERF | numeric | (1,0) |  |  |  | √ | 1 | 开立异常单：0：Not Create(不开立异常单) 1：Create(开立异常单) 【IMES使用】 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FLAG | nvarchar | (1) |  |  |  |  |  | 数据导入旗标：N 待导入 Y 已完成导入 F 暂停导入或失败 |
| 2 | EXECUTEMESSAGE | nvarchar | (1000) |  |  |  | √ |  | 导入消息：导入完成 显示完成 导入失败 显示错误消息 |
| 3 | IMPORTDATE | datetime |  |  |  |  | √ |  | 导入时间：导入完成时间，由 sQMS填写 |
| 4 | LOTNO | nvarchar | (30) | √ |  |  |  |  | 检验批编号：因中继表导入数据时， sQMS系统中无对应的检验单主档，故用此编号查询检验历程记录，可自行编码或使用流水号 |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号：作业站编号 |
| 6 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号：品管项目编号 |
| 7 | ITEMNO | nvarchar | (50) | √ |  |  |  |  | 品号：产品编号或物料编号 |
| 8 | EQUIPMENTNO | nvarchar | (4000) |  |  |  | √ |  | 设备编号：可作为收集要因 |
| 9 | SAMPLEQTY | numeric | (5,0) |  |  |  | √ |  | 抽样数：大于0的正整数，未填写则系统由TESTVALUE拆逗号取得几个值写入 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | TESTVALUE | nvarchar | (2000) |  |  |  | √ |  | 量测值：值之间逗号分割。例如：98,45,89,78,89 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INSPDRIVERNO | nvarchar | (25) | √ |  |  |  |  | 联机程序编号 |
| 2 | FUNCTIONNAME | nvarchar | (50) |  |  |  | √ |  | 函数名称 |
| 3 | DESCRIPTION | nvarchar | (500) |  |  |  |  |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INSPMACHINENO | nvarchar | (50) | √ |  |  |  |  | 检测仪器编号 |
| 2 | INSPMACHINETYPE | nvarchar | (4000) |  |  |  | √ |  | 检测机台类别 |
| 3 | INSPTYPE | nvarchar | (10) |  |  |  |  |  | 检验类型 |
| 4 | BAUDRATE | numeric | (16,0) |  |  |  | √ |  | 传输数律 |
| 5 | PARITYBIT | nvarchar | (10) |  |  |  | √ |  | 同位比特 |
| 6 | DATABIT | numeric | (2,0) |  |  |  | √ |  | 资料比特 |
| 7 | STOPBIT | numeric | (2,0) |  |  |  | √ |  | 停止比特 |
| 8 | ENDCODE | nvarchar | (6) |  |  |  | √ |  | 结束代码 |
| 9 | FORMAT1 | nvarchar | (4000) |  |  |  | √ |  | 格式1 |
| 10 | FORMAT2 | nvarchar | (4000) |  |  |  | √ |  | 格式2 |
| 11 | CHNO | nvarchar | (3) |  |  |  |  |  | 信道编号 |
| 12 | INSPDRIVERNO | nvarchar | (25) |  |  |  | √ |  | INSPDRIVERNO |
| 13 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 14 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 15 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 17 | InspMachineName | nvarchar | (4000) |  |  |  | √ |  | 检测仪器名称 |
| 18 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 19 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INSPMACHINETYPE | nvarchar | (50) | √ |  |  |  |  | 检测机台类别 |
| 2 | INSPTYPE | numeric | (1,0) |  |  |  |  |  | 检测类型：0：RS232 1：User Define(用户自订) |
| 3 | BAUDRATE | numeric | (16,0) |  |  |  | √ |  | 传输速率 |
| 4 | PARITYBIT | nvarchar | (10) |  |  |  | √ |  | 同位位 |
| 5 | DATABIT | numeric | (1,0) |  |  |  | √ |  | 数据比特 |
| 6 | STOPBIT | numeric | (1,0) |  |  |  | √ |  | 停止位 |
| 7 | ENDCODE | nvarchar | (6) |  |  |  | √ |  | 结束代码 |
| 8 | FORMAT1 | nvarchar | (4000) |  |  |  | √ |  | 仪器接收资料格式 |
| 9 | FORMAT2 | nvarchar | (4000) |  |  |  | √ |  | 仪器接收资料格式 |
| 10 | CHNO | nvarchar | (3) |  |  |  | √ |  | 信道编号：在仪器有接连接盒时才需设定 |
| 11 | INSPDRIVERNO | nvarchar | (25) |  |  |  | √ |  | 检测机台类别 |
| 12 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 13 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 14 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 15 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 16 | INSPMACHINETYPENAME | nvarchar | (4000) |  |  |  | √ |  | 检测仪器类别名称 |
| 17 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 18 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (100) | √ |  |  |  |  | 品管项目编号 |
| 2 | FACTORNO | nvarchar | (30) | √ |  |  |  |  | 要因编号 |
| 3 | FACTORONLINE | nvarchar | (1) |  |  |  |  |  | 是否为在线管制要因： N：否 Y：是 |
| 4 | FACTORSPEC | nvarchar | (1) |  |  |  |  |  | 是否为规格要因： N：否 Y：是 |
| 5 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 6 | TABLENAME | nvarchar | (60) |  |  |  | √ |  | 非当站要因子据来源数据表 |
| 7 | FIELDNAME | nvarchar | (30) |  |  |  | √ |  | 域名 |
| 8 | FACTORSHORTRUN | nvarchar | (20) |  |  |  | √ |  | 是否为Short Run要因： N：否 Y：是 【IMES使用】 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 13 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 15 | TBLQCITEMFORATTRIBUTESGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 16 | TBLSYSMESPARAMETERGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 17 | TBLQCITEMFORVARIABLESGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (100) | √ |  |  |  |  | 品管项目编号 |
| 2 | QCITEMNAME | nvarchar | (4000) |  |  |  |  |  | 品管项目名称 |
| 3 | LOTISVALID | numeric | (1,0) |  |  |  | √ | 0 | 批号有效性：0：No(不运行批号有效性检查) 1：Yes(运行批号有效性检查) 【IMES使用】 |
| 4 | PLANNO | nvarchar | (100) |  |  |  | √ |  | 计划编号 |
| 5 | RULENO | nvarchar | (20) |  |  |  | √ |  | 法则编号 |
| 6 | FORMNAME | nvarchar | (4000) |  |  |  | √ |  | 特殊收集界面的表单名称：【IMES使用】 |
| 7 | WEBURL | nvarchar | (100) |  |  |  | √ |  | 网址 |
| 8 | ERRORREPORTNAME | nvarchar | (4000) |  |  |  | √ |  | 错误模板名称 |
| 9 | NOTICEREPORTNAME | nvarchar | (4000) |  |  |  | √ |  | 通知模板名称 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 11 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | SAMPLESIZE | numeric | (12,4) |  |  |  | √ |  | 样本数 |
| 15 | LIMITLOTNUM | numeric | (5,0) |  |  |  | √ | 0 | 控制在线管制图所呈现数据点的数量 |
| 16 | COMPONENTCOLLECT | numeric | (1,0) |  |  |  | √ | 0 | 组件收集：0：No(否)  1：Yes(是) 【IMES使用】 |
| 17 | QCCLASS | nvarchar | (30) |  |  |  | √ |  | ERP品管项目 |
| 18 | MCLASSNO | nvarchar | (30) |  |  |  | √ |  | 异常主分类编号 |
| 19 | ISSAMPLESIZEINTEGER | numeric | (1,0) |  |  |  | √ | 0 | 确认抽样数是否要为整数：0：YES(是)  1：No(否) |
| 20 | EXECUTIONFILE | nvarchar | (4000) |  |  |  | √ |  | 运行文档 |
| 21 | QCAreaNo | nvarchar | (50) |  |  |  | √ |  |  |
| 22 | InsFixMinute | numeric | (12,0) |  |  |  |  | 0 |  |
| 23 | InsVarMinute | numeric | (12,0) |  |  |  |  | 0 |  |
| 24 | InsVarQty | numeric | (12,0) |  |  |  |  | 1 |  |
| 25 | ATT_CTRL | numeric | (1,0) |  |  |  | √ | 0 | 检验附件控制：0：No(否)  1：YES(是) |
| 26 | GROUPNO | nvarchar | (25) |  |  |  | √ |  | 群组编号 |
| 27 | INSPECTIONTOOLS | nvarchar | (50) |  |  |  | √ |  | 检验工具 |
| 28 | ItemType | numeric | (1,0) |  |  |  |  |  | 检验标的类别 |
| 29 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 30 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 31 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 2 | QCITEMNAME | nvarchar | (50) |  |  |  |  |  | 品管项目名称 |
| 3 | LOTISVALID | numeric | (1,0) |  |  |  |  | 0 | 批号有效性 |
| 4 | PLANNO | nvarchar | (100) |  |  |  |  |  | 计划编号 |
| 5 | FORMNAME | nvarchar | (4000) |  |  |  | √ |  | 特殊收集界面的表单名称：【IMES使用】 |
| 6 | WEBURL | nvarchar | (255) |  |  |  | √ |  | 网址：【IMES使用】 |
| 7 | ERRORREPORTNAME | nvarchar | (4000) |  |  |  | √ |  | 错误模板名称：【IMES使用】 |
| 8 | NOTICEREPORTNAME | nvarchar | (4000) |  |  |  | √ |  | 通知模板名称：【IMES使用】 |
| 9 | CHARTCONTROL | numeric | (1,0) |  |  |  | √ | 0 | 立即视图在线管制图：0：No(否) 1：Yes(是)  【IMES使用】 |
| 10 | CHARTTYPE | numeric | (1,0) |  |  |  | √ |  | 管制图类别：0：Xbar-R(平均值与全距管制图) 1：Xbar-S(平均值标准差管制图) 2：X-Rm (个别值与移动全距管制图) |
| 11 | SPECLINETYPE | numeric | (1,0) |  |  |  | √ |  | 规格线类别：0：Upper Lower Control(双边管制) 1：Upper Control(上限单边管制) 2：Lower Control(下限单边管制) 3：Not Control(无管制) |
| 12 | COLLECTTYPE | numeric | (1,0) |  |  |  | √ | 0 | 收集类别：0：Manual(手动) 1：Automatic(自动) |
| 13 | LIMITLOTNUM | numeric | (5,0) |  |  |  | √ | 0 | 数据点的数量 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 15 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 16 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 17 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 18 | SAMPLESIZE | numeric | (5,0) |  |  |  | √ |  | 样本数 |
| 19 | MINVALUE | numeric | (12,4) |  |  |  |  | 0 | 最小值 |
| 20 | MAXVALUE | numeric | (12,4) |  |  |  |  | 0 | 最大值 |
| 21 | COMPONENTCOLLECT | numeric | (1,0) |  |  |  | √ | 0 | 组件收集：0：No(否)  1：Yes(是) 【IMES使用】 |
| 22 | QCCLASS | nvarchar | (30) |  |  |  | √ |  | ERP品管项目 |
| 23 | QCDATATYPE | numeric | (1,0) |  |  |  | √ | 0 | 品管项目分类：0：Particle  1：Inline  2：offline  【IMES使用】 |
| 24 | CALTYPE | numeric | (1,0) |  |  |  | √ | 0 | 组件收集的汇整方式：0：By Lot(依生产批) 1：By Component(依组件) 【IMES使用】 |
| 25 | UNIT | nvarchar | (30) |  |  |  | √ |  | 单位 |
| 26 | MCLASSNO | nvarchar | (30) |  |  |  | √ |  | 异常主分类编号 |
| 27 | EXECUTIONFILE | nvarchar | (4000) |  |  |  | √ |  | 运行文档：【IMES使用】 |
| 28 | InsFixMinute | numeric | (12,0) |  |  |  |  | 0 |  |
| 29 | InsVarMinute | numeric | (12,0) |  |  |  |  | 0 |  |
| 30 | InsVarQty | numeric | (12,0) |  |  |  |  | 1 |  |
| 31 | QCAreaNo | nvarchar | (50) |  |  |  | √ |  |  |
| 32 | ATT_CTRL | numeric | (1,0) |  |  |  | √ | 0 | 检验附件控制：0：No(否)  1：YES(是) |
| 33 | GROUPNO | nvarchar | (25) |  |  |  | √ |  | 群组编号 |
| 34 | ItemType | numeric | (1,0) |  |  |  |  |  | 检验标的类别 |
| 35 | INSPECTIONTOOLS | nvarchar | (50) |  |  |  | √ |  | 检验工具 |
| 36 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 37 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 38 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 2 | PARAMETERNO | nvarchar | (20) | √ |  |  |  |  | 抽样计划参数编号 |
| 3 | PARAMETERVALUE | nvarchar | (255) |  |  |  | √ |  | 抽样计划参数值 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 10 | TBLQCITEMFORVARIABLESGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 11 | TBLQCSAMPLINGPARAMETERGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (100) | √ |  |  |  |  | 品管项目编号 |
| 2 | REASONNO | nvarchar | (30) | √ |  |  |  |  | 原因编号 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 6 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 11 | TBLQCITEMFORATTRIBUTESGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 12 | TBLQCREASONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MCLASSNO | nvarchar | (100) | √ |  |  |  |  | 主分类编号 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (50) | √ |  |  |  |  | 检验标的类别：0：产品品管类别 1：产品 2：物料品管类别 3：物料 |
| 2 | QCOBJECTNO | nvarchar | (50) | √ |  |  |  |  | 检验标的编号 |
| 3 | QCOBJECTNAME | nvarchar | (255) |  |  |  | √ |  | 检验标的名称 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | BACKGROUNDIMAGE | varbinary | (-1) |  |  |  | √ |  |  |
| 9 | NODEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  |  |
| 10 | VERSION | numeric | (5,0) |  |  |  | √ | 1 | 版本 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (50) | √ |  |  |  |  | 检验标的类别：0：产品品管类别 1：产品 2：物料品管类别 3：物料 |
| 2 | QCOBJECTNO | nvarchar | (50) | √ |  |  |  |  | 检验标的编号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | SERIALNO | numeric | (5,0) | √ |  |  |  |  | 序号 |
| 5 | FILENAME | nvarchar | (100) |  |  |  | √ |  | 档名 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 建立日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (50) | √ |  |  |  |  | 检验标的类别：0：产品品管类别 1：产品 2：物料品管类别 3：物料 |
| 2 | QCOBJECTNO | nvarchar | (50) | √ |  |  |  |  | 检验标的编号 |
| 3 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 4 | QCITEMTYPE | numeric | (1,0) | √ |  |  |  |  | 品管项目类别：0：计数 1：计量 |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 6 | QCOPPORTUNITY | nvarchar | (20) | √ |  |  |  |  | 检验时机 |
| 7 | EXECUTEORDER | numeric | (6,0) |  |  |  | √ |  | 执行顺序 |
| 8 | PQC | numeric | (1,0) |  |  |  | √ |  | 出站检验：0：否 1：是 |
| 9 | FIRSTINSP | numeric | (1,0) |  |  |  | √ |  | 首检：0：否 1：是 |
| 10 | INSPECT | numeric | (1,0) |  |  |  | √ |  | 巡检：0：否 1：是 |
| 11 | CursorMode | numeric | (1,0) |  |  |  | √ |  | 指标模式：0：光标往下 1：光标往右 |
| 12 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 13 | MClassNo | nvarchar | (30) |  |  |  | √ |  | 主分类编号：异常单主分类编号 |
| 14 | SELFINSP | numeric | (1,0) |  |  |  | √ |  | 自检：0：否 1：是 |
| 15 | LASTINSP | numeric | (1,0) |  |  |  | √ |  | 末检：0：否 1：是 |
| 16 | INSPECTIONTOOLS | nvarchar | (50) |  |  |  | √ |  | 检验工具 |
| 17 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 20 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 21 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (50) |  |  |  |  |  | 检验标的类别 |
| 2 | QCOBJECTNO | nvarchar | (50) |  |  |  |  |  | 检验标的编号 |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | SCRIPT | nvarchar | (255) |  |  |  | √ |  | 描述语言 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | STATUS | numeric | (1,0) |  |  |  | √ |  | 状态 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (4000) |  |  |  | √ |  | 检验标的类别：0：产品品管类别 1：产品 2：物料品管类别 3：物料 |
| 2 | QCOBJECTNO | nvarchar | (4000) |  |  |  | √ |  | 检验标的编号 |
| 3 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 4 | QCItemNo | nvarchar | (4000) |  |  |  | √ |  | 品管项目编号 |
| 5 | QCItemName | nvarchar | (255) |  |  |  | √ |  | 品管项目名称 |
| 6 | UserInput | nvarchar | (4000) |  |  |  | √ |  | 自订名称 |
| 7 | NodeName | nvarchar | (4000) |  |  |  | √ |  | 节点名称 |
| 8 | NodeColor | nvarchar | (4000) |  |  |  | √ |  | 节点背景颜色 |
| 9 | NodeTag | nvarchar | (100) |  |  |  | √ |  | 节点标签 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (10) | √ |  |  |  |  | 检验标的类别 |
| 2 | QCOBJECTTYPENAME | nvarchar | (50) |  |  |  |  |  | 检验标的类别名称 |
| 3 | SPECFACTOR | nvarchar | (50) |  |  |  |  |  | 规格要因 |
| 4 | CONTROLFACTOR | nvarchar | (50) |  |  |  |  |  | 管制要因 |
| 5 | FATHERTYPE | nvarchar | (10) |  |  |  | √ |  | 父类别 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (50) | √ |  |  |  |  | 检验标的类别 |
| 2 | QCOBJECTNO | nvarchar | (50) | √ |  |  |  |  | 检验标的编号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EmployeeNo1 | nvarchar | (10) |  |  |  | √ |  | 预设检验员编号1 |
| 5 | EmployeeNo2 | nvarchar | (10) |  |  |  | √ |  | 预设检验员编号2 |
| 6 | EmployeeNo3 | nvarchar | (10) |  |  |  | √ |  | 预设检验员编号3 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOBJECTTYPE | nvarchar | (50) | √ |  |  |  |  | 检验标的类别：0：产品品管类别 1：产品 2：物料品管类别 3：物料 |
| 2 | QCOBJECTNO | nvarchar | (50) | √ |  |  |  |  | 检验标的编号 |
| 3 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | VERSION | numeric | (5,0) | √ |  |  |  |  | 版本 |
| 5 | UPDATEDESCRIPTION | nvarchar | (255) |  |  |  |  |  | 更新说明 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCOPPORTUNITY | nvarchar | (50) | √ |  |  |  |  | 检验时机编号 |
| 2 | QCOPPORTUNITYNAME | nvarchar | (50) |  |  |  |  |  | 检验时机名称 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | REASONNO | nvarchar | (100) | √ |  |  |  |  | 原因编号 |
| 2 | REASONNAME | nvarchar | (100) |  |  |  |  |  | 原因名称 |
| 3 | REASONTYPE | numeric | (2,0) |  |  |  | √ |  | 原因类别：0：Scrap 1：Defect |
| 4 | REASONLEVEL | numeric | (1,0) |  |  |  |  |  | 原因等级：共有0~9级 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | REASONSUBTYPE | nvarchar | (50) |  |  |  | √ |  | 原因子类别：不良类别为6时：REPAIR：维修 DOWN：故障 SETUP：设定 MAINTAIN：保养 SUSPEND：暂停 |
| 10 | EFFECTIVE | numeric | (1,0) |  |  |  | √ | 0 | 是否纳入稼动：【SMES计算人时机时使用】 |
| 11 | Invalidity | numeric | (1,0) |  |  |  | √ | 0 | 无效 |
| 12 | PLANPROCESSTIME | numeric | (2,0) |  |  |  | √ |  | 预计处理时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID：数据键值 |
| 1 | REASONNO | nvarchar | (50) | √ |  |  |  |  | 检验编号 |
| 2 | REASONNAME | nvarchar | (50) |  |  |  | √ |  | 检验名称 |
| 3 | REASONTYPE | numeric | (2,0) |  |  |  |  |  | 检验类别：【0：首检 1：巡检 3：自检 4：末检 5：自检&首检 6：自检&巡检 7：自检&末检 2：首检&巡检 8：首检&末检 9：巡检&末检 10：自检&首检&巡检 11：自检&首检&末检 12：自检&巡检&末检 13：首检&巡检&末检 14：自检&首检&巡检&末检】 |
| 4 | REASONDESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 检验描述 |
| 5 | PICTUREPATH | nvarchar | (255) |  |  |  | √ |  | 图片名称 |
| 6 | CREATEDATE | datetime |  |  |  |  |  |  | 创建时间：数据创建时间 |
| 7 | CREATEOR | nvarchar | (50) |  |  |  |  |  | 创建者 |
| 8 | REASONMETHOD | nvarchar | (255) |  |  |  | √ |  | 检验类型 |
| 9 | CheckType | numeric | (1,0) |  |  |  |  | 0 | 检验方式 |
| 10 | MaxiValue | nvarchar | (12) |  |  |  | √ |  | 最大值 |
| 11 | MiniValue | nvarchar | (12) |  |  |  | √ |  | 最小值 |
| 12 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 13 | ISINPUTSCRAP | numeric | (1,0) |  |  |  |  | 0 | 不合格是否需录不良：0 否1 是 |
| 14 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 数据状态：0 Unfrozen(未签核)1 Pending(签核中) 2 Active(已签核)-1 Unused(不使用) |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REASONTYPE | numeric | (2,0) |  |  |  |  |  | 原因类别：0：Scrap  1：Defect |
| 2 | REASONSUBTYPE | nvarchar | (50) | √ |  |  |  |  | 原因子类别 |
| 3 | REASONSUBTYPENAME | nvarchar | (4000) |  |  |  |  |  | 原因子类别名称 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | RULESERIAL | nvarchar | (20) | √ |  |  |  |  | 法则序号 |
| 2 | RULENO | nvarchar | (20) | √ |  |  |  |  | 法则编号 |
| 3 | RULENAME | nvarchar | (50) |  |  |  |  |  | 法则名称 |
| 4 | FUNCTIONNAME | nvarchar | (4000) |  |  |  | √ | 'N/A' | 功能名称 |
| 5 | RULETYPE | numeric | (1,0) |  |  |  | √ |  | 法则类别：0：System(系统) 1：User Define(用户自订) |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | RULEOPTION | numeric | (1,0) |  |  |  | √ |  | 法则选项：0：Value(值) 1：Value Range(值的范围) 2：Sigma(标准差) 3：Line(管制线) 4：Sigma Range(标准差范围) 5：Other(其它) 6：Special Value(特殊值) 7：Rank(等级) |
| 11 | TESTOUTOF | numeric | (2,0) |  |  |  | √ | 1 | 连续M点中 |
| 12 | TESTCOUNT | numeric | (2,0) |  |  |  | √ |  | 有N点 |
| 13 | COMPAREVALUE1 | nvarchar | (10) |  |  |  | √ |  | 参考值1 |
| 14 | COMPAREVALUE2 | nvarchar | (10) |  |  |  | √ |  | 参考值2 |
| 15 | RELATION | nvarchar | (10) |  |  |  | √ |  | 关系 |
| 16 | WETYPE | numeric | (1,0) |  |  |  | √ | 0 | 西屋法则项次 |
| 17 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 18 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 2 | OLDSAMPLEPLAN | nvarchar | (100) | √ |  |  |  |  | 转换前抽样计划 |
| 3 | ACCLOTQTY | numeric | (3,0) | √ |  |  |  | -1 | 允收批数 |
| 4 | REJLOTQTY | numeric | (3,0) | √ |  |  |  | -1 | 拒收数 |
| 5 | NEWSAMPLEPLAN | nvarchar | (100) |  |  |  |  |  | 转换后抽样计划 |
| 6 | FACTORNO | nvarchar | (100) |  |  |  |  |  | 要因编号 |
| 7 | LOTRANGE | numeric | (3,0) | √ |  |  |  | -1 | 批量范围设定 |
| 8 | AQLCHKFORSPLANCHG | numeric | (1,0) |  |  |  |  | 0 | AQL检查抽样计划变更：0：False(否) 1：True(是) |
| 9 | QCITEMTYPE | numeric | (1,0) |  |  |  | √ | 0 | 品管项目类别：0：计数  1：计量 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SAMPLINGTYPE | nvarchar | (25) | √ |  |  |  |  | 输入方式：0：Attributes(计数型)，由来货以随机抽样的方式将产品抽出检验，所有产品皆为0收1退，若没发现不合格品时则可予以允收。  1：Variables(计量型)，先决条件为确定送样批量分布为常态分配且批量间为独立关系，则可适用于计量值检验。若随机抽样之结果都在规格中，同时也符合K值、F值时判定允收。 |
| 2 | MINNUM | numeric | (8,0) | √ |  |  |  |  | 最小值 |
| 3 | MAXNUM | numeric | (8,0) | √ |  |  |  |  | 最大值 |
| 4 | SLEVEL | nvarchar | (6) | √ |  |  |  |  | 检验水准 |
| 5 | SAMPLENUM | numeric | (6,0) |  |  |  |  |  | 抽样数 |
| 6 | REJECTNUM | numeric | (6,0) |  |  |  |  |  | 拒收数 |
| 7 | KVALUE | numeric | (10,3) |  |  |  | √ |  | K值：利用不良率估计法；在单边或双边规格符合公式时，则可判定允收。 |
| 8 | FVALUE | numeric | (10,3) |  |  |  | √ |  | F值：适用于双边规格产出的产品，以变异与公差之比值决定是否符合，若符合则可判定允收 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 12 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 13 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PLANNO | nvarchar | (100) | √ |  |  |  |  | 抽样计划编号 |
| 2 | PARAMETERNO | nvarchar | (20) | √ |  |  |  |  | 抽样计划参数编号 |
| 3 | PARAMETERVALUE | nvarchar | (255) |  |  |  | √ |  | 抽样计划参数值 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PLANNO | nvarchar | (100) | √ |  |  |  |  | 计划编号 |
| 2 | PLANNAME | nvarchar | (100) |  |  |  |  |  | 计划名称 |
| 3 | PLANTYPE | numeric | (1,0) |  |  |  |  |  | 计划类别：0：固定抽样数量 1：固定抽样比率 2：MIL-STD-105E(抽样数依箭头) 5：抽样表格 6：MIL-STD-1916 7：自定义AQL 8  MIL-STD-105E(抽样数不依箭头) |
| 4 | FUNCTIONNAME | nvarchar | (4000) |  |  |  | √ |  | 函数名称：【IMES系统使用】 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 9 | SQTYCANBBIGGERTHENPQTY | numeric | (1,0) |  |  |  |  | 0 | 抽样数可以比母体数大：0：N(否) 1：Y(是) |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SAMPLINGTABLE | nvarchar | (25) | √ |  |  |  |  | 抽样表格编号 |
| 2 | MINNUM | numeric | (12,4) | √ |  |  |  |  | 最小值 |
| 3 | MAXNUM | numeric | (12,4) | √ |  |  |  |  | 最大值 |
| 4 | SAMPLENUM | numeric | (12,4) |  |  |  |  |  | 抽样数 |
| 5 | REJECTNUM | numeric | (12,4) |  |  |  | √ |  | 验退数 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SCLASSNO | nvarchar | (100) | √ |  |  |  |  | 次分类编号 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 6 | MCLASSNO | nvarchar | (30) |  |  |  | √ |  | 主分类编号 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | DBIP | nvarchar | (20) |  |  |  |  |  | 数据库IP |
| 2 | DBName | nvarchar | (50) |  |  |  | √ |  | 数据库名称 |
| 3 | DBSID | nvarchar | (50) |  |  |  | √ |  | SID |
| 4 | DBAcc | nvarchar | (50) |  |  |  |  |  | 数据库帐号 |
| 5 | DBPW | nvarchar | (50) |  |  |  |  |  | 数据库密码 |
| 6 | DBType | numeric | (2,0) |  |  |  |  | 0 | 数据库类别 |
| 7 | ERPENT | nvarchar | (50) |  |  |  |  |  | ERP公司别 |
| 8 | ERPSITE | nvarchar | (50) |  |  |  |  |  | ERP工厂 |
| 9 | ERPType | nvarchar | (50) |  |  |  |  | '4' | ERP类型 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QTRREPORTNO | nvarchar | (50) | √ |  |  |  |  | 质量追溯作业编号：质量追溯可以进行自定义配置的作业 |
| 2 | QTRREPORTNAME | nvarchar | (50) |  |  |  |  |  | 质量追溯作业名称 |
| 3 | REPORTTYPE | nvarchar | (2) |  |  |  |  | '1' | 表格类型：1-主表 2-分支表（预留占位） |
| 4 | CONDITIONQTY | nvarchar | (50) |  |  |  |  |  | 当前追溯条件字段数量统计：统计质量追溯作业具有多少追溯条件 |
| 5 | RESULTQTY | nvarchar | (50) |  |  |  |  |  | 当前追溯结果字段数量统计：统计质量追溯作业有多少追溯结果字段 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QTRREPORTNO | nvarchar | (50) | √ |  |  |  |  | 质量追溯作业编号 |
| 2 | CONDFIELD | nvarchar | (50) | √ |  |  |  |  | 字段名称 |
| 3 | CONDNAME | nvarchar | (50) |  |  |  |  |  | 显示名称 |
| 4 | DATAUSEFOR | numeric | (1,0) | √ |  |  |  |  | 字段用途：1-追溯结果主键 2-追溯结果字段 3-追溯条件字段 4-通用主键 5-通用字段 |
| 5 | ITEMNO | numeric | (2,0) |  |  |  |  |  | 显示顺序 |
| 6 | DATASOURCE | numeric | (1,0) |  |  |  |  |  | 字段来源：1-系统标准 2-自定义字段 |
| 7 | DATATYPE | numeric | (1,0) |  |  |  |  |  | 字段类型：1-字符串 2-数字 3-时间 4-时间区间 |
| 8 | SHOWLENGTH | numeric | (3,0) |  |  |  | √ |  | 显示长度：空为不限制长度 |
| 9 | SHOWDECIMAL | numeric | (1,0) |  |  |  | √ |  | 小数位数：DATATYPE=2时, 0-整数 1-小数点后一位 2-小数点后二位 3-小数点后三位 4-小数点后四位 DATATYPE等于其他值时,此字段为空 |
| 10 | CONDSCRIPT | nvarchar | (-1) |  |  |  | √ |  | 字段语法 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QTRREPORTNO | nvarchar | (50) | √ |  |  |  |  | 质量追溯报表编号 |
| 2 | REPORTHEADID | nvarchar | (50) | √ |  |  |  |  | 单头表编号：REPORTLEVEL=1时 REPORTHEADID=QTRREPORTNO |
| 3 | CONDFIELD | nvarchar | (50) | √ |  |  |  |  | 绑定字段名称 |
| 4 | REPORTLEVEL | nvarchar | (2) | √ |  |  |  |  | 绑定层阶：1-第一阶报表 2-第二阶报表 |
| 5 | LEFTITEMNO | numeric | (2,0) |  |  |  |  | 99 | 左起显示顺序：REPORTLEVEL=2时LEFTITEMNO=99 |
| 6 | REPORTBODYID | nvarchar | (50) |  |  |  | √ |  | 单身表编号 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PARAMETERNO | nvarchar | (50) | √ |  |  |  |  | 参数编号：QTRCHOSEDATETIME 查询条件可选择日期 QTRCONDITIONOPEN 允许主表扩展追溯条件与结果  QTRMUTIREPORTOPEN 主表可多阶挂载报表 QTRLINKREPORTOPEN 允许在查询结果点击字段跳转到明细表 |
| 2 | QTRREPORTNO | nvarchar | (50) | √ |  |  |  |  | 质量追溯作业编号 |
| 3 | PARAMETERVALUE | numeric | (1,0) |  |  |  |  |  | 参数值：0：否（不管控） 1：是（管控） |
| 4 | PARAMETERVISABLE | numeric | (1,0) |  |  |  |  | 1 | 参数可见：0：不可见 1：可见 |
| 5 | PARAMETERTYPE | nvarchar | (50) |  |  |  | √ | 'SYSINFO' | 参数类别 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 序号 |
| 3 | LABEL | nvarchar | (50) |  |  |  |  |  | 图表标签名称 |
| 4 | TYPE | nvarchar | (20) |  |  |  |  |  | 图表型别：line 折线 bar 长条图 |
| 5 | COLOR | nvarchar | (20) |  |  |  | √ |  | 图表颜色：#xxxxxx |
| 6 | XAXIS | nvarchar | (50) |  |  |  | √ |  | X轴栏位代号 |
| 7 | YAXIS | nvarchar | (50) |  |  |  | √ |  | Y轴栏位代号：须为数字 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CREATETIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | TBLRPTREPORTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | LABEL | nvarchar | (50) | √ |  |  |  |  | 栏位编号 |
| 3 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 序号 |
| 4 | ConditionType | nvarchar | (20) |  |  |  |  |  | 判断方式 |
| 5 | ConditionValue | nvarchar | (20) |  |  |  | √ |  | 判断用值 |
| 6 | MainColor | nvarchar | (20) |  |  |  | √ |  | 主要颜色 |
| 7 | FontColor | nvarchar | (20) |  |  |  | √ |  | 字型颜色 |
| 8 | BGColor | nvarchar | (20) |  |  |  | √ |  | 背景颜色 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CREATETIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | TBLRPTCOLUMNSETTINGGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | LABEL | nvarchar | (50) | √ |  |  |  |  | 字段编号 |
| 3 | LABELDESC | nvarchar | (255) |  |  |  | √ |  | 说明：描述 |
| 4 | COLUMNTYPE | nvarchar | (20) |  |  |  |  |  | 字段类型 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATETIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | TBLRPTREPORTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  | 0 | 序号 |
| 3 | CONDFIELD | nvarchar | (50) |  |  |  |  |  | 查询栏位代号：透过此栏位进行程序的groupby |
| 4 | CONDDESC | nvarchar | (50) |  |  |  |  |  | 查询栏位名称 |
| 5 | INSERTNAME | nvarchar | (50) |  |  |  | √ |  | 插入点名称 |
| 6 | CREATETIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLRPTREPORTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | RELATEREPORTID | nvarchar | (50) | √ |  |  |  |  | 单身的报表ID |
| 3 | ITEMNO | numeric | (2,0) | √ |  |  |  | 1 | 序号 |
| 4 | CONDFIELD | nvarchar | (50) |  |  |  |  |  | 单头报表内的栏位代号：透过此栏位取得要进行查询的值 |
| 5 | CONDDESC | nvarchar | (50) |  |  |  |  |  | 单头报表内的栏位说明 |
| 6 | RELATECONDFIELD | nvarchar | (50) |  |  |  |  |  | 单身报表内的栏位代号：透过此栏位组出单身的where 条件 |
| 7 | RELATECONDDESC | nvarchar | (50) |  |  |  |  |  | 单身报表内的栏位说明 |
| 8 | CREATETIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | MAPPINGCONDITION | nvarchar | (5) |  |  |  | √ |  | 条件 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | TBLRPTREPORTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SID | numeric | (8,0) |  |  | √ |  |  | 标示码 |
| 2 | REPORTNAME | nvarchar | (50) | √ |  |  |  |  | 模板编号 |
| 3 | MODULENAME | nvarchar | (20) |  |  |  | √ |  | 模块名称 |
| 4 | REPORTCONTEXT | nvarchar | (-1) |  |  |  | √ |  | 报表内容 |
| 5 | FILEVERSION | numeric | (19,0) |  |  |  | √ |  | 文档版本 |
| 6 | CREATETIME | datetime |  |  |  |  | √ |  | 创建日 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | REVISEDATE | datetime |  |  |  |  | √ |  | 更新日 |
| 9 | REVISER | nvarchar | (50) |  |  |  | √ |  | 更新人 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | REPORTNAME_REAL | nvarchar | (50) |  |  |  | √ |  | 模板名称：实际的报表名称 |
| 16 | REMARK | nvarchar | (300) |  |  |  | √ |  | 备注 |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | REPORTTYPE | numeric | (1,0) |  |  |  |  | 2 | 报表型别：固定2 |
| 3 | SUBSCRIBETYPE | numeric | (1,0) |  |  |  |  | 1 | 订阅型别：待确定 |
| 4 | TABLENAME | nvarchar | (50) |  |  |  | √ |  | 表格名称：待确定 |
| 5 | FUNCTIONNAME | nvarchar | (50) |  |  |  | √ |  | 权限编号：待确定 |
| 6 | GROUPBYMETHOD | nvarchar | (30) |  |  |  | √ |  | 群组方式：待确定 |
| 7 | ORDERBYMETHOD | nvarchar | (30) |  |  |  | √ |  | 排序方式：待确定 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 报表说明 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | CATCHTABLEXML | nvarchar | (-1) |  |  |  | √ |  | CATCHTABLEXML：待确定 |
| 12 | REPORTNAME | nvarchar | (100) |  |  |  |  |  | 报表名称 |
| 13 | REPORTLEVEL | numeric | (1,0) |  |  |  |  | 0 | 格式档等级：待确定 |
| 14 | REPORTSCRIPT | nvarchar | (-1) |  |  |  | √ |  | 报表语法：透过{{条件名称}}会自动代换成andxxx= 透过{{where}}可以指定查询条件会塞到哪个地方 都没设定{{}}时，会自动找出塞入where条件的地方 |
| 15 | REPORTDBTYPE | numeric | (1,0) |  |  |  |  | 0 | 格式档类别：固定0 |
| 16 | DISPLAYTYPE | numeric | (1,0) |  |  |  |  | 0 | 报表型别：0  VB使用 1  H5使用 2 管理看板 9 系统报表 |
| 17 | REPORTURLLINK | nvarchar | (-1) |  |  |  | √ |  | 外部报表连结 |
| 18 | CHARTTITLE | nvarchar | (50) |  |  |  | √ |  | 图表标题：可搭配{{变量名称}}进行取代，当有设定TBLRPTChartCondition时才有用 |
| 19 | STACKSERIES | nvarchar | (1) |  |  |  | √ | 'N' | 叠加长条图 |
| 20 | DBLink | nvarchar | (255) |  |  |  | √ |  | 数据库连结 |
| 21 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 22 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REPORTGROUPNO | nvarchar | (20) | √ |  |  |  |  | 报表群组编号 |
| 2 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 3 | FILENAME | nvarchar | (50) |  |  |  | √ |  | 文件名称 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | RPTLOGSERIAL | nvarchar | (20) | √ |  |  |  |  | 报表LOG序号 |
| 2 | REPORTID | nvarchar | (50) |  |  |  |  |  | 报表编号 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | DBSTARTTIME | datetime |  |  |  |  |  |  | 数据库开始时间 |
| 6 | DBENDTIME | datetime |  |  |  |  |  |  | 数据库结束时间 |
| 7 | CLIENTSTARTTIME | datetime |  |  |  |  |  |  | 客户端开始时间 |
| 8 | CLIENTENDTIME | datetime |  |  |  |  | √ |  | 客户端结束时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 序号 |
| 3 | CONDFIELD | nvarchar | (60) |  |  |  |  |  | 查询栏位代号：此代号为组成where条件时所使用 |
| 4 | CONDDESC | nvarchar | (50) |  |  |  |  |  | 查询栏位名称 |
| 5 | CONDDATATYPE | numeric | (1,0) |  |  |  |  |  | 查询栏位型别：1 字符串 2 日期 3 下拉选单 4 数字 5 checkbox 6 日期(起讫) |
| 6 | CONDOPERAND | nvarchar | (10) |  |  |  |  |  | 预设查询条件 |
| 7 | CONDHINT | nvarchar | (50) |  |  |  | √ |  | 输入提示 |
| 8 | DEFAULTVALUE | nvarchar | (55) |  |  |  | √ |  | 查询预设值 |
| 9 | DATASOURCE | nvarchar | (4000) |  |  |  | √ |  | 查询数据来源：此栏位为SQL语法，透过设定此栏位，可以让前端使用下拉选单 |
| 10 | CHECKNECESSARY | numeric | (1,0) |  |  |  | √ | 0 | 必选条件 |
| 11 | INSERTNAME | nvarchar | (50) |  |  |  | √ |  | 插入点名称：插入点名称 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 17 | TBLRPTREPORTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
