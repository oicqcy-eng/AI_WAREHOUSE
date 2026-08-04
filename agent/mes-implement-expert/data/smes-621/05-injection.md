# 05 注塑 (INJ)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 10 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblINJEQPBasis](#tblinjeqpbasis) | 注塑设备基本数据 | 22 |
| [tblINJEQPRecipe](#tblinjeqprecipe) | 注塑设备Recipe | 45 |
| [tblINJLotRecipe](#tblinjlotrecipe) | 生产批绑定Recipe | 12 |
| [tblINJPhaseBasis](#tblinjphasebasis) | 自变量阶段定义档 | 29 |
| [tblINJRecipeBasis](#tblinjrecipebasis) | Recipe主档 | 19 |
| [tblINJRecipeCheckLog](#tblinjrecipechecklog) | Recipe自变量检核记录 | 17 |
| [tblINJRecipeCheckLogDetail](#tblinjrecipechecklogdetail) | Recipe自变量检核明细 | 20 |
| [tblINJRecipeDetail](#tblinjrecipedetail) | Recipe维护管理明细 | 21 |
| [tblINJRecipeQCLog](#tblinjrecipeqclog) | 检验Recipe记录 | 17 |
| [tblINJRecipeQCLogDetail](#tblinjrecipeqclogdetail) | 检验Recipe明细 | 224 |

---

### tblINJEQPBasis — 注塑设备基本数据（22 字段）
> 主键：EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号定义(不可与设备类别编号相同) |
| 2 | CheckType | numeric | (1,0) |  |  |  | √ | 0 | 自变量检核方式：0 不控卡 1 警告 2 控卡进站 |
| 3 | AlarmType | numeric | (1,0) |  |  |  | √ | 0 | 警讯提示方式：0 不提示 1 提示(强制弹窗) |
| 4 | CounterWay | numeric | (1,0) |  |  |  | √ | 0 | 计数器采集方式：0 覆盖 1 累加 |
| 5 | QCRecordParam | numeric | (1,0) |  |  |  | √ | 0 | 检验记录自变量履历：0 N 1 Y |
| 6 | OutCounterSet | numeric | (1,0) |  |  |  | √ | 0 | 出站模次归零：0 N 1 Y |
| 7 | OutCounterShow | numeric | (12,4) |  |  |  | √ |  | 带入计数量 |
| 8 | RunCounter | numeric | (12,4) |  |  |  | √ | 0 | 目前模次 |
| 9 | RunCounter_Pre | numeric | (12,4) |  |  |  | √ | 0 | 进站模次 |
| 10 | ProgramNo | nvarchar | (50) |  |  |  | √ |  | 程序编号 |
| 11 | CounterUpdateTime | datetime |  |  |  |  | √ |  | 计数器更新时间 |
| 12 | RecipeNo | char | (36) |  |  |  | √ |  | 目前的Recipe识别码 |
| 13 | ActualResult | numeric | (1,0) |  |  |  | √ |  | 实际检核状态：0 合格 1 不合格 |
| 14 | GoodNumberCavity | numeric | (6,0) |  |  |  | √ |  | 健康穴数 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 18 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 19 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblINJEQPRecipe — 注塑设备Recipe（45 字段）
> 主键：EquipmentNo, ParamNo, EXCEPTIONGUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | ParamNo | nvarchar | (500) | √ |  |  |  |  | 自变量编号：请见对照表 |
| 3 | ParamPhase | numeric | (10,0) |  |  |  |  |  | 阶段：00 标准 10 料管 20 关模 30 开模 40 射出 50 保压 60 储料 70 顶针 90 SPC 99 自定义 |
| 4 | ParamName | nvarchar | (100) |  |  |  | √ |  | 自变量名称 |
| 5 | ParamSection | numeric | (10,0) |  |  |  | √ |  | 段数：整数值 |
| 6 | StdValue | numeric | (12,4) |  |  |  |  | 0 | 标准值 |
| 7 | HighTolerance | numeric | (12,4) |  |  |  |  | 0 | 允差上限 |
| 8 | LowerTolerance | numeric | (12,4) |  |  |  |  | 0 | 允差下限 |
| 9 | ToleranceType | numeric | (5,0) |  |  |  |  | 0 | 允差型别：0 百分比 1 实际值 |
| 10 | NeedCheck | numeric | (5,0) |  |  |  |  | 1 | 需检核：0 N 1 Y |
| 11 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | ActualValue | numeric | (12,4) |  |  |  | √ |  | 实际值：目前记录的实际值 |
| 13 | ActualResult | numeric | (12,0) |  |  |  | √ |  | 实际检核状态：0 合格 1 不合格 |
| 14 | ActMinSpecValue | numeric | (12,4) |  |  |  | √ |  | 实际合格下限 |
| 15 | ActStardardValue | numeric | (12,4) |  |  |  | √ |  | 实际标准值 |
| 16 | ActMaxSpecValue | numeric | (12,4) |  |  |  | √ |  | 实际合格上限 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 20 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 21 | ParamCategoryName | nvarchar | (100) |  |  |  | √ |  | 自变量分类 |
| 22 | EQUIPMENTNAME | nvarchar | (255) |  |  |  | √ |  | 设备名称 |
| 23 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 24 | TBLINJEQPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 25 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 26 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 27 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 28 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | EXCEPTIONGUID | nvarchar | (100) | √ |  |  |  |  | 异常讯息识别码：动态生成的GUID |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号：设备编号 |
| 4 | EVENTTIME | datetime |  |  |  |  |  |  | 发生时间：对应检验进站时间 |
| 5 | EXCEPTIONCODE | nvarchar | (50) |  |  |  |  |  | 异常码：回传异常码 ExceptionType=1时1 超过上限 2 超过下限 |
| 6 | EXCEPTIONMSG | nvarchar | (500) |  |  |  |  |  | 异常讯息：回传之原始异常讯息 |
| 7 | SHOWMSG | nvarchar | (500) |  |  |  |  |  | 显示讯息：显示与画面上的讯息 |
| 8 | PARAMNO | nvarchar | (50) |  |  |  |  |  | 自变量编号：自变量编号 |
| 9 | ACTUALVALUE | nvarchar | (50) |  |  |  |  |  | 实际值：自变量现值 |
| 10 | EXCEPTIONTYPE | nvarchar | (50) |  |  |  |  |  | 异常型别：1 自变量超过界线 |
| 11 | REVISOR | nvarchar | (10) |  |  |  |  |  | 修改人 |
| 12 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblINJLotRecipe — 生产批绑定Recipe（12 字段）
> 主键：LotNo, OPNo, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号：生产批号 |
| 2 | OPNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 3 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 4 | RecipeNo | nvarchar | (100) |  |  |  |  |  | Recipe识别码：生产批目前系结的Recipe识别码（对应Recipe主档的识别码），生产批只会对应一笔Recipe识别码 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblINJPhaseBasis — 自变量阶段定义档（29 字段）
> 主键：ParamPhase, RECIPENO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ParamPhase | numeric | (10,0) | √ |  |  |  |  | 自变量阶段编号：自变量阶段唯一识别值 |
| 2 | PhaseName | nvarchar | (50) |  |  |  |  |  | 自变量名称 |
| 3 | Language_Text | nvarchar | (50) |  |  |  |  |  | 语系对照码：前端显示用的识别码 |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 8 | ReviseDate | datetime |  |  |  |  | √ |  | 修改时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据状态 |
| 10 | ParamCategoryName | nvarchar | (50) |  |  |  | √ |  | 分类 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | RECIPENO | nvarchar | (100) | √ |  |  |  |  | RECIPE识别码 |
| 2 | EQUIPMENTNO | nvarchar | (52) |  |  |  |  |  | 设备编号 |
| 3 | PRODUCTNO | nvarchar | (52) |  |  |  | √ |  | 产品编号 |
| 4 | ACCESSORYTYPE | nvarchar | (52) |  |  |  | √ |  | 模治具类别 |
| 5 | OPNO | nvarchar | (52) |  |  |  | √ |  | 作业站编号 |
| 6 | RECIPEVER | nvarchar | (30) |  |  |  |  | '1' | 版本 |
| 7 | PRODPHASE | numeric | (1,0) |  |  |  |  | 3 | 生产阶段 |
| 8 | PROGRAMNO | nvarchar | (52) |  |  |  | √ |  | 程序编号 |
| 9 | INVALID | numeric | (1,0) |  |  |  |  |  | 失效 |
| 10 | DESCRIPTION | nvarchar | (255) |  |  |  |  |  | 说明 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立日期 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 修改人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblINJRecipeBasis — Recipe主档（19 字段）
> 主键：RecipeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | RecipeNo | nvarchar | (50) | √ |  |  |  | ' ' | Recipe识别码：Recipe内部识别码，以GUID方式生成   SYS_GUID()   NEWID() |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号：请加索引 |
| 3 | ProductNo | nvarchar | (50) |  |  |  | √ |  | 产品编号：请加索引，可填入 表示忽略此条件 |
| 4 | AccessoryType | nvarchar | (50) |  |  |  | √ |  | 模治具类别：请加索引，可填入 表示忽略此条件 |
| 5 | OPNo | nvarchar | (50) |  |  |  | √ |  | 作业站编号：请加索引，可填入 表示忽略此条件 |
| 6 | RecipeVer | nvarchar | (10) |  |  |  |  | '1' | 版本：请加索引，默认01 |
| 7 | ProdPhase | numeric | (1,0) |  |  |  |  | 3 | 生产阶段：0 试模 1 试样 2 试产 3 量产 |
| 8 | ProgramNo | nvarchar | (50) |  |  |  | √ |  | 进程编号(模号) |
| 9 | Invalid | numeric | (1,0) |  |  |  |  | 0 | 无效：0 生效中 1 已失效 |
| 10 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 15 | OPNAME | nvarchar | (500) |  |  |  | √ | ' ' | 作业站名称 |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblINJRecipeCheckLog — Recipe自变量检核记录（17 字段）
> 主键：CheckGUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CheckGUID | nvarchar | (100) | √ |  |  |  |  | 检核识别码：动态生成的GUID |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：设备编号，请加索引 |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：生产批号，请加索引 |
| 4 | OPNo | nvarchar | (50) |  |  |  | √ |  | 作业站编号：作业站编号，请加索引 |
| 5 | EventTime | datetime |  |  |  |  | √ |  | 进站时间：对应PartialIn进站时间，请加索引 |
| 6 | RecipeNo | char | (36) |  |  |  | √ |  | Recipe识别码：LOT进站时系结的Recipe |
| 7 | CheckResult | numeric | (1,0) |  |  |  | √ |  | 检核结果：1 合格(所有自变量都合格) 0 不合格(一个以上检核自变量合格) |
| 8 | ActionResult | numeric | (1,0) |  |  |  | √ |  | 动作处置：0 未进站 1 进站 |
| 9 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblINJRecipeCheckLogDetail — Recipe自变量检核明细（20 字段）
> 主键：CheckGUID, ParamNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CheckGUID | nvarchar | (100) | √ |  |  |  |  | 检核识别码：动态生成的GUID |
| 2 | RecipeNo | nvarchar | (100) |  |  |  |  |  | Recipe识别码：检核时对应的Recipe识别码 |
| 3 | ParamNo | nvarchar | (255) | √ |  |  |  |  | 自变量编号：请见对照表 |
| 4 | ParamPhase | numeric | (10,0) |  |  |  |  |  | 阶段：00 标准 10 料管 20 关模 30 开模 40 射出 50 保压 60 储料 70 顶针 90 SPC 99 自定义 |
| 5 | ParamName | nvarchar | (50) |  |  |  |  |  | 自变量名称 |
| 6 | ParamSection | numeric | (10,0) |  |  |  | √ |  | 段数：整数值 |
| 7 | ActualValue | numeric | (12,4) |  |  |  | √ |  | 实际值：目前记录的实际值 |
| 8 | CheckResult | numeric | (1,0) |  |  |  | √ |  | 检核结果：0 合格 1 不合格 |
| 9 | MinValue | numeric | (12,4) |  |  |  | √ |  | 下限值 |
| 10 | StdValue | numeric | (12,4) |  |  |  | √ |  | 标准值 |
| 11 | MaxValue | numeric | (12,4) |  |  |  | √ |  | 上限值 |
| 12 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 16 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 17 | ParamCategoryName | nvarchar | (50) |  |  |  | √ |  | 自变量分类 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblINJRecipeDetail — Recipe维护管理明细（21 字段）
> 主键：RecipeNo, ParamNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | RecipeNo | nvarchar | (100) | √ |  |  |  |  | Recipe识别码：Recipe内部识别码，以GUID方式生成 |
| 2 | ParamNo | nvarchar | (255) | √ |  |  |  |  | 自变量编号：请见对照表 |
| 3 | ParamPhase | numeric | (10,0) |  |  |  |  |  | 阶段：00 标准 10 料管 20 关模 30 开模 40 射出 50 保压 60 储料 70 顶针 90 SPC 99 自定义 |
| 4 | ParamName | nvarchar | (50) |  |  |  | √ |  | 自变量名称 |
| 5 | ParamSection | numeric | (10,0) |  |  |  | √ |  | 段数：整数值 |
| 6 | StdValue | numeric | (12,4) |  |  |  |  | 0 | 标准值 |
| 7 | HighTolerance | numeric | (12,4) |  |  |  |  | 0 | 允差上限 |
| 8 | LowerTolerance | numeric | (12,4) |  |  |  |  | 0 | 允差下线 |
| 9 | ToleranceType | numeric | (1,0) |  |  |  |  | 0 | 允差型别：0 百分比 1 实际值 |
| 10 | MaxValue | numeric | (12,4) |  |  |  |  | 0 | 上限值：记录上限值，为标准值加上允差上限 |
| 11 | MinValue | numeric | (12,4) |  |  |  |  | 0 | 下限值：记录下限值，为标准值减去允差下限 |
| 12 | NeedCheck | numeric | (5,2) |  |  |  |  | 1 | 检核：0 N 1 Y |
| 13 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 17 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 18 | ParamCategoryName | nvarchar | (50) |  |  |  | √ |  | 自变量分类 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblINJRecipeQCLog — 检验Recipe记录（17 字段）
> 主键：CheckGUID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CheckGUID | nvarchar | (100) | √ |  |  |  |  | 检核识别码：动态生成的GUID |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号：设备编号 |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号：生产批号 |
| 4 | OPNo | nvarchar | (50) |  |  |  | √ |  | 作业站编号：作业站编号 |
| 5 | EventTime | datetime |  |  |  |  | √ |  | 检验时间：对应检验进站时间 |
| 6 | RecipeNo | char | (36) |  |  |  | √ |  | Recipe识别码：LOT进站时系结的Recipe |
| 7 | ActionType | numeric | (2,0) |  |  |  | √ |  | 动作类别：1 首检 2 巡检 |
| 8 | DocNo | nvarchar | (50) |  |  |  | √ |  | 对应单号：记录动作单号，动作类别为首检时记录检验编号、巡检时记录巡检单号 |
| 9 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 13 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblINJRecipeQCLogDetail — 检验Recipe明细（224 字段）
> 主键：CheckGUID, ParamNo, INVENTORYNO, PROPERTYNO, FGDINNO, FGDINNO, PRODUCTNO, PRODUCTVERSION, LOTNO, OPNo, FGDINNO, PRODUCTNO, PRODUCTVERSION, LOTNO, OPNO, FGDINNO, PCSNO, INVENTORYNO, LOTNO, LOCATORNO, FGDINNO, INVENTORYNO, INVENTORYNO, PROPERTYNO, INVENTORYNO, LOCATORNO, INVENTORYNO, PRODUCTNO, LOTNO, PRODUCTNO_QTY, MATERIAL_QTY, INPUTDATE, PRODUCTNO_UNITNO, OPNO, LOCATORNO, MATERIALNO, CONTENTJSON, MATERIALLOTNO, RESULT, MATERIAL_UNITNO, SCRINNO, SCRINNO, LOTSERIAL, INVENTORYNO, LOTSERIAL, INVENTORYNO, PRODUCTNO, LOTNO, UNITNO, QTY, INPUTDATE, PRODUCTVERSION, OPNO, LOCATORNO, ISGOOD, TYPE, CONTENTJSON, RESULT
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CheckGUID | nvarchar | (100) | √ |  |  |  |  | 检核识别码：动态生成的GUID |
| 2 | RecipeNo | nvarchar | (100) |  |  |  |  |  | Recipe识别码：检核时对应的Recipe识别码 |
| 3 | ParamNo | nvarchar | (255) | √ |  |  |  |  | 自变量编号：请见对照表 |
| 4 | ParamPhase | numeric | (10,0) |  |  |  |  |  | 阶段：00 标准 10 料管 20 关模 30 开模 40 射出 50 保压 60 储料 70 顶针 90 SPC 99 自定义 |
| 5 | ParamName | nvarchar | (50) |  |  |  |  |  | 自变量名称：  20200303 modi |
| 6 | ParamSection | numeric | (10,0) |  |  |  | √ |  | 段数：整数值 |
| 7 | ActualValue | numeric | (12,4) |  |  |  | √ |  | 实际值：目前记录的实际值 |
| 8 | MinValue | numeric | (12,4) |  |  |  | √ |  | 下限值：记录下限值，为标准值减去允差下限 |
| 9 | StdValue | numeric | (12,4) |  |  |  | √ |  | 标准值 |
| 10 | MaxValue | numeric | (12,4) |  |  |  | √ |  | 上限值：记录上限值，为标准值加上允差上限 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 14 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 15 | ParamCategoryName | nvarchar | (50) |  |  |  | √ |  | 分类：  20200303 add |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 仓库编号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 默认值 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  |  |  | 签核状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FGDINNO | nvarchar | (20) | √ |  |  |  |  | 成品入库单编号 |
| 2 | STATE | numeric | (1,0) |  |  |  |  | 0 | 状态 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：#94918 增加非制程完工识别Doflag=1 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | INVENTORYNO | nvarchar | (20) |  |  |  | √ |  | 库房编号 |
| 7 | INPUTDATE | datetime |  |  |  |  | √ |  | 输入日期 |
| 8 | SOURCE | numeric | (2,0) |  |  |  |  |  | 来源 |
| 9 | FROMINVENTORYNO | nvarchar | (20) |  |  |  | √ |  | 来源库房编号：固定N A |
| 10 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 11 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 12 | LocatorNo | nvarchar | (20) |  |  |  | √ |  | 位置编号 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FGDINNO | nvarchar | (20) | √ |  |  |  |  | 成品入库单编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 品号 |
| 3 | PRODUCTVERSION | nvarchar | (50) | √ |  |  |  |  | 产品版本 |
| 4 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 5 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 6 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 7 | LOCATORNO | nvarchar | (20) |  |  |  |  |  | 储位编号 |
| 8 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 基础批号 |
| 9 | StockLotNo | nvarchar | (50) |  |  |  | √ |  | 存货批号编号 |
| 10 | fromInventoryNo | nvarchar | (20) |  |  |  | √ |  | 线边舱编号：线边舱编号 |
| 11 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号：#89252，网状呆滞物料入库需填入，修改为NOT NULL并列为PK |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FGDINNO | nvarchar | (20) | √ |  |  |  |  | 成品入库单编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 品号 |
| 3 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 4 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 5 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 6 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FGDINNO | nvarchar | (20) | √ |  |  |  |  | 成品入库单编号 |
| 2 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 3 | QTY | numeric | (16,6) |  |  |  |  |  | 数量：入库为正数，取消入库为负数 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 库房编号 |
| 2 | PRODUCTNO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 3 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 4 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 5 | LOCATORNO | nvarchar | (20) | √ |  |  |  |  | 储位编号 |
| 6 | LOCQTY | numeric | (12,4) |  |  |  |  |  | 储位数量 |
| 7 | BELONGTOTYPE | numeric | (1,0) |  |  |  | √ | -1 | 所属类别 |
| 8 | BELONGTONO | nvarchar | (50) |  |  |  | √ |  | 所属编号 |
| 9 | INPUTDATE | datetime |  |  |  |  | √ |  | 输入日期 |
| 10 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 11 | FGDINNO | nvarchar | (50) | √ |  |  |  |  | 成品入库单编号 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 仓库编号 |
| 2 | INVENTORYNAME | nvarchar | (50) |  |  |  | √ |  | 仓库名称 |
| 3 | INVENTORYTYPE | numeric | (2,0) |  |  |  |  |  | 仓库类别：0：原物料仓 1：成品库 2：半成品库 3：废品库 4：不良品库 5 OrderInventory 6：在制品库 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 8 | ENGINEERGROUPNO | nvarchar | (20) |  |  |  | √ |  | 工程群组编号 |
| 9 | INVENTORYCLASS | numeric | (1,0) |  |  |  | √ | 0 | 仓库分类：0：系统自定义，1：用户自订 |
| 10 | FACTORYNO | nvarchar | (20) |  |  |  | √ |  | 工厂编号 |
| 11 | ERPNO | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 12 | FactoryName | nvarchar | (50) |  |  |  | √ |  | 工厂名称 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 仓库编号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 默认值 |
| 4 | PROPERTYSEQUENCE | numeric | (2,0) |  |  |  | √ |  | 属性次序 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 仓库编号 |
| 2 | LOCATORNO | nvarchar | (20) | √ |  |  |  |  | 储位编号 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | CAPACITY | numeric | (2,0) |  |  |  | √ | 0 | 批量限制：-1代表不限制。 |
| 8 | LOCATORNAME | nvarchar | (50) |  |  |  | √ |  | 储位名称 |
| 9 | ERPNO | nvarchar | (20) |  |  |  | √ |  | ERP单号：对应储位编号 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | INVENTORYNO | nvarchar | (50) | √ |  |  |  |  | 仓库编号 |
| 3 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 4 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 5 | PRODUCTNO_QTY | nvarchar | (50) | √ |  |  |  |  | 产品单位 |
| 6 | MATERIAL_QTY | nvarchar | (50) | √ |  |  |  |  | 物料数量 |
| 7 | INPUTDATE | datetime |  | √ |  |  |  |  | 创建时间 |
| 8 | PRODUCTNO_UNITNO | nvarchar | (50) | √ |  |  |  |  | 产品单位 |
| 9 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 10 | LOCATORNO | nvarchar | (50) | √ |  |  |  |  | 储位编号 |
| 11 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 12 | CONTENTJSON | nvarchar | (2000) | √ |  |  |  |  | JSON内容 |
| 13 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 14 | RESULT | nvarchar | (200) | √ |  |  |  |  | 结果 |
| 15 | MATERIAL_UNITNO | nvarchar | (50) | √ |  |  |  |  | 物料单位 |
| 16 | EVENTID | nvarchar | (50) |  |  |  |  |  | 事件ID |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 21 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SCRINNO | nvarchar | (20) | √ |  |  |  |  | 不良入库编号 |
| 2 | STATE | numeric | (1,0) |  |  |  |  |  | 状态 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | INVENTORYNO | nvarchar | (20) |  |  |  | √ |  | 仓库编号 |
| 7 | INPUTDATE | datetime |  |  |  |  | √ |  | 投入时间 |
| 8 | SOURCE | numeric | (2,0) |  |  |  |  |  | 来源 |
| 9 | FROMINVENTORYNO | nvarchar | (20) |  |  |  | √ |  | 来源仓库编号 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SCRINNO | nvarchar | (20) | √ |  |  |  |  | 不良入库编号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 3 | LOTSERIAL | nvarchar | (55) | √ |  |  |  |  | 批号序号 |
| 4 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站 |
| 5 | SCRAPQTY | numeric | (12,4) |  |  |  | √ | 0 | 不良数量 |
| 6 | LOSSQTY | numeric | (12,4) |  |  |  | √ | 0 | 遗失数量 |
| 7 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 8 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 基础批号 |
| 9 | DISPOSE_TYPE | nvarchar | (30) |  |  |  | √ |  | 入库类型：SCRAP_INV 报废入库 DEFECT_INV 不良品入库 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SCRINNO | nvarchar | (20) |  |  |  |  |  | 不良品入库单号 |
| 2 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (50) |  |  |  |  |  | 产品版本 |
| 4 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批批号 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | PCSNO | nvarchar | (50) |  |  |  |  |  | 成品序号 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | INVENTORYNO | nvarchar | (20) | √ |  |  |  |  | 仓库编号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 3 | LOTSERIAL | nvarchar | (55) | √ |  |  |  |  | 批号序号 |
| 4 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站 |
| 5 | SCRAPQTY | numeric | (12,4) |  |  |  | √ | 0 | 不良数 |
| 6 | LOSSQTY | numeric | (12,4) |  |  |  | √ | 0 | 遗失数 |
| 7 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 8 | INPUTDATE | datetime |  |  |  |  | √ |  | 投入日期 |
| 9 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 基础批号 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | INVENTORYNO | nvarchar | (50) | √ |  |  |  |  | 仓库编号 |
| 3 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 4 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号：0 正常生产，1 Pass模式 |
| 5 | UNITNO | nvarchar | (50) | √ |  |  |  |  | 单位编号 |
| 6 | QTY | nvarchar | (50) | √ |  |  |  |  | 数量 |
| 7 | INPUTDATE | datetime |  | √ |  |  |  |  | 创建时间 |
| 8 | PRODUCTVERSION | nvarchar | (50) | √ |  |  |  |  | 产品版本 |
| 9 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 10 | LOCATORNO | nvarchar | (50) | √ |  |  |  |  | 储位编号 |
| 11 | ISGOOD | numeric | (1,0) | √ |  |  |  |  | 是否良品：0：不良品 1：良品 |
| 12 | TYPE | numeric | (1,0) | √ |  |  |  |  | 类型：0：出站时自动入库 1：入库作业手动入库 |
| 13 | CONTENTJSON | nvarchar | (2000) | √ |  |  |  |  | JSON内容 |
| 14 | RESULT | nvarchar | (200) | √ |  |  |  |  | 结果 |
| 15 | EVENTID | nvarchar | (50) |  |  |  |  |  | 事件ID |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
