# 02 日结报工与暂存 (DailyWork/WIPTemp)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 15 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblWIPCont_DailyWorkEditLog](#tblwipcont_dailyworkeditlog) | 日结报工单调整历程 | 18 |
| [tblWIPCont_DailyWorkKeyValue](#tblwipcont_dailyworkkeyvalue) | 日结报工参数表 | 7 |
| [tblWIPCont_DailyWorkMESNO](#tblwipcont_dailyworkmesno) | 日结报工单号 | 11 |
| [tblWIPCont_DailyWorkReport](#tblwipcont_dailyworkreport) | 日结报工单信息 | 33 |
| [tblWIPCont_DailyWorkReport_ERP](#tblwipcont_dailyworkreport_erp) | 日结报工单抛转历程表 | 28 |
| [tblWIPCont_DailyWorkReportLog](#tblwipcont_dailyworkreportlog) | 日结报工生成记录 | 72 |
| [tblWIPTemp_DailyWR_DailyEmp](#tblwiptemp_dailywr_dailyemp) | 日结暂存_每日人员上线区间 | 13 |
| [tblWIPTemp_DailyWR_EMPTime](#tblwiptemp_dailywr_emptime) | 日结暂存_人时分摊(生产批) | 19 |
| [tblWIPTemp_DailyWR_EQPEmp](#tblwiptemp_dailywr_eqpemp) | 日结暂存_设备人员上线区间 | 14 |
| [tblWIPTemp_DailyWR_EQPOn](#tblwiptemp_dailywr_eqpon) | 日结暂存_设备稼动区间 | 10 |
| [tblWIPTemp_DailyWR_EQPTime](#tblwiptemp_dailywr_eqptime) | 日结暂存_机时分摊(生产批) | 14 |
| [tblWIPTemp_DailyWR_LotOn](#tblwiptemp_dailywr_loton) | 日结暂存_生产批上线区间 | 12 |
| [tblWIPTemp_DailyWR_LotRealOn](#tblwiptemp_dailywr_lotrealon) | 日结暂存_生产批有效上线区间 | 12 |
| [tblWIPTemp_DailyWR_LotUnWait](#tblwiptemp_dailywr_lotunwait) | 日结暂存_生产批未暂停区间 | 12 |
| [tblWIPTemp_DailyWR_ReportQty](#tblwiptemp_dailywr_reportqty) | 日结暂存_每日报工数量 | 93 |

---

### tblWIPCont_DailyWorkEditLog — 日结报工单调整历程（18 字段）
> 主键：GUID, LotNo, OPNo, ReportDate, EquipmentNo, UserNo, ReportType
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | GUID | char | (36) | √ |  |  |  |  | GUID |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 5 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 6 | UserNo | nvarchar | (30) | √ |  |  |  |  | 报工人员编号 |
| 7 | EMPTime_s | numeric | (16,2) |  |  |  | √ |  | 人时(秒) |
| 8 | EQPTime_s | numeric | (16,2) |  |  |  | √ |  | 机时(秒) |
| 9 | RWOMESNO | nvarchar | (50) |  |  |  | √ |  | 报工单号 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | ReportType | nvarchar | (30) | √ |  |  |  |  | 报工类型 |
| 13 | MONo | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 14 | EditType | numeric | (1,0) |  |  |  |  |  | 修改类型 |
| 15 | Qty | numeric | (16,4) |  |  |  | √ |  | 数量 |
| 16 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 17 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 18 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPCont_DailyWorkKeyValue — 日结报工参数表（7 字段）
> 主键：DailyKey
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | DailyKey | nvarchar | (50) | √ |  |  |  |  | Key |
| 2 | DailyValue | nvarchar | (50) |  |  |  |  |  | Value |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 6 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPCont_DailyWorkMESNO — 日结报工单号（11 字段）
> 主键：RWOMESNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | RWOMESNO | nvarchar | (50) | √ |  |  |  |  | MES报工单单号 |
| 2 | ReportDate | date |  |  |  |  | √ |  | 日期 |
| 3 | LotNo | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 4 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 5 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |

---

### tblWIPCont_DailyWorkReport — 日结报工单信息（33 字段）
> 主键：LotNo, OPNo, ReportDate, EquipmentNo, UserNo, ReportType
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | LotNo | nvarchar | (50) | √ |  |  |  |  | 批号 |
| 2 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | ReportDate | datetime |  | √ |  |  |  |  | 日期 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | UserNo | nvarchar | (30) | √ |  |  |  |  | 报工人员编号 |
| 6 | MONo | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 7 | RONO | nvarchar | (50) |  |  |  | √ |  | 订单编号 |
| 8 | EMPTime_s | numeric | (16,2) |  |  |  | √ |  | 人时(秒)：EMPTime_s=EMPTimeSum_s EMPLot_s EMPLotSum_s |
| 9 | EQPTime_s | numeric | (16,2) |  |  |  | √ |  | 机时(秒)：EQPTime_s=EQPTimeSum_s EQPLot_s EQPLotSum_s |
| 10 | Qty | numeric | (16,6) |  |  |  | √ |  | 数量 |
| 11 | RWOMESNO | nvarchar | (50) |  |  |  | √ |  | MES报工单单号 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 15 | ReviseDate | datetime |  |  |  |  | √ | getdate | 修改日 |
| 16 | EMPTimeOn_s | numeric | (16,2) |  |  |  | √ |  | 日上工时间(秒) |
| 17 | EMPTimeOff_s | numeric | (16,2) |  |  |  | √ |  | 日休息时间(秒) |
| 18 | EMPTimeSum_s | numeric | (16,2) |  |  |  | √ |  | 日加总人时(秒) |
| 19 | EMPLot_s | numeric | (16,2) |  |  |  | √ |  | 人时分摊分子(秒) |
| 20 | EMPLotSum_s | numeric | (16,2) |  |  |  | √ |  | 人时分摊分母(秒) |
| 21 | EQPTimeSum_s | numeric | (16,2) |  |  |  | √ |  | 日加总机时(秒) |
| 22 | EQPLot_s | numeric | (16,2) |  |  |  | √ |  | 机时分摊分子(秒) |
| 23 | EQPLotSum_s | numeric | (16,2) |  |  |  | √ |  | 机时分摊分母(秒) |
| 24 | EMPST | datetime |  |  |  |  | √ |  | 人员上工起始时间 |
| 25 | EMPET | datetime |  |  |  |  | √ |  | 人员上工结束时间 |
| 26 | LOTST | datetime |  |  |  |  | √ |  | 生产批上机起始时间 |
| 27 | LOTET | datetime |  |  |  |  | √ |  | 生产批下机结束时间 |
| 28 | EMPCount | numeric | (10,0) |  |  |  | √ |  | 报工人员数量 |
| 29 | ReportType | numeric | (1,0) | √ |  |  |  |  | 报工型别：0 人时 1 机时 |
| 30 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 31 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 32 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 33 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPCont_DailyWorkReport_ERP — 日结报工单抛转历程表（28 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | source_no | nvarchar | (50) |  |  |  |  |  | 来源单号 |
| 2 | erp_no | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 3 | wo_no | nvarchar | (50) |  |  |  | √ |  | 工单号 |
| 4 | doc_type_no | nvarchar | (20) |  |  |  | √ |  | 类型号 |
| 5 | op_seq | nvarchar | (20) |  |  |  | √ |  | 作业站序号 |
| 6 | machine_no | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 7 | complete_date | nvarchar | (20) |  |  |  | √ |  | 完成日 |
| 8 | number_of_operators | nvarchar | (20) |  |  |  | √ |  | 报工人数 |
| 9 | reporter | nvarchar | (20) |  |  |  | √ |  | 记录人 |
| 10 | unit_no | nvarchar | (20) |  |  |  | √ |  | 单位编号 |
| 11 | tot_machine_hours | nvarchar | (20) |  |  |  | √ |  | 总机时 |
| 12 | tot_labor_hours | nvarchar | (20) |  |  |  | √ |  | 总人时 |
| 13 | op_no | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 14 | tot_qty | nvarchar | (20) |  |  |  | √ |  | 总数量 |
| 15 | plot_no | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 16 | shift_no | nvarchar | (20) |  |  |  | √ |  | 班别编号 |
| 17 | factory_no | nvarchar | (20) |  |  |  | √ |  | 工厂编号 |
| 18 | remark | nvarchar | (200) |  |  |  | √ |  | 备注 |
| 19 | workstation_no | nvarchar | (20) |  |  |  | √ |  | 工作站编号 |
| 20 | create_date | nvarchar | (20) |  |  |  | √ |  | 创建日 |
| 21 | SENDID | nvarchar | (30) |  |  |  | √ |  | 抛转ID |
| 22 | RETURNINFO | nvarchar | (500) |  |  |  | √ |  | 回传信息 |
| 23 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 24 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 25 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 26 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 28 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPCont_DailyWorkReportLog — 日结报工生成记录（72 字段）
> 主键：ReportDate, LOGGROUPSERIAL, USERNO, CHECKINTIME, LOGINPLACENO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | SettleResult | numeric | (1,0) |  |  |  | √ |  | 结算结果 |
| 3 | SendResult | numeric | (1,0) |  |  |  | √ |  | 抛转结果 |
| 4 | SendTime | datetime |  |  |  |  | √ |  | 抛转时间 |
| 5 | ReviseCount | numeric | (10,0) |  |  |  | √ |  | 修改次数 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ | getdate | 创建日期 |
| 8 | Revisor | nvarchar | (36) |  |  |  | √ |  | 修改人 |
| 9 | ReviseDate | datetime |  |  |  |  | √ | getdate | 修改日 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批序号 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 批号 |
| 3 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 4 | BRNO | nvarchar | (20) |  |  |  |  |  | 企业逻辑编号 |
| 5 | USERNO | nvarchar | (30) |  |  |  |  |  | 使用者编号 |
| 6 | EVENTTIME | datetime |  |  |  |  |  |  | 建立日期 |
| 7 | FUNCTIONNAME | nvarchar | (100) |  |  |  | √ |  | 函式名称 |
| 8 | SHIFTNO | nvarchar | (20) |  |  |  | √ |  | 班别编号 |
| 9 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号 |
| 10 | LINKNAME | nvarchar | (50) |  |  |  | √ |  | 连结名称 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立者：数据建立人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 建立时间：数据建立时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | LOGGROUPSERIAL | nvarchar | (50) | √ |  |  |  |  | LOG序号 |
| 2 | LOTSERIAL | nvarchar | (55) |  |  |  |  |  | 生产批流水号 |
| 3 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 4 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 5 | USERNO | nvarchar | (30) | √ |  |  |  |  | 使用者编号 |
| 6 | CHECKINTIME | datetime |  | √ |  |  |  |  | 登入时间 |
| 7 | CHECKOUTTIME | datetime |  |  |  |  |  |  | 登出时间 |
| 8 | DURATION | numeric | (10,2) |  |  |  |  |  | 登入期间 |
| 9 | CICREATOR | nvarchar | (10) |  |  |  |  |  | 上工人员 |
| 10 | CICREATEDATE | datetime |  |  |  |  |  |  | 上工建立日期 |
| 11 | COCREATOR | nvarchar | (10) |  |  |  |  |  | 下工人员 |
| 12 | COCREATEDATE | datetime |  |  |  |  |  |  | 下工建立日期 |
| 13 | EVENTTIME | datetime |  |  |  |  |  |  | 建立时间 |
| 14 | DESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 说明 |
| 15 | Qty | numeric | (12,4) |  |  |  | √ | 0 | 数量 |
| 16 | MULTIOPERATORMODE | numeric | (1,0) |  |  |  | √ |  | 多人加工模式 |
| 17 | LOGINPLACENO | nvarchar | (50) | √ |  |  |  | 'N/A' | 登入地编号 |
| 18 | FROMLOTNO | nvarchar | (50) |  |  |  | √ |  | 来源生产批号 |
| 19 | FROMLOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | 来源LOG序号 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | LOTSERIAL | nvarchar | (50) |  |  |  | √ |  | 生产批序号：请勿使用 |
| 2 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 4 | RECIPEGROUP | nvarchar | (50) |  |  |  | √ |  | 参数群组 |
| 5 | RECIPEVERSION | numeric | (2,0) |  |  |  | √ |  | 参数版本 |
| 6 | EQUIPMENTCLASS | nvarchar | (50) |  |  |  | √ |  | 设备分类 |
| 7 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 8 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间：进站时为空；出站时显示 |
| 9 | LOADPORT | numeric | (2,0) |  |  |  | √ |  | 上货区数量 |
| 10 | LOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | Log序号：生产批在作业站的LOG序号 生产批的key |
| 11 | InputQty | numeric | (12,4) |  |  |  | √ | 0 | 输入数量 |
| 12 | OutputQty | numeric | (12,4) |  |  |  | √ | 0 | 输出数量 |
| 13 | EVENTTIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 14 | FROMLOTNO | nvarchar | (50) |  |  |  | √ |  | 来源生产批号 |
| 15 | FROMLOGGROUPSERIAL | nvarchar | (50) |  |  |  | √ |  | 来源LOG序号 |
| 16 | STATUS | numeric | (2,0) |  |  |  |  | 0 | 状态：生产批是否暂停 0 ： 否 1 ：是 |
| 17 | ORGInputQTY | numeric | (12,4) |  |  |  |  | 0 | 原始输入数量 |
| 18 | TransferOutputQTY | numeric | (12,4) |  |  |  |  | 0 | 转移输出数量 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblWIPTemp_DailyWR_DailyEmp — 日结暂存_每日人员上线区间（13 字段）
> 主键：ReportDate, UserNo, ST
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | UserNo | nvarchar | (50) | √ |  |  |  |  | 人员编号 |
| 3 | ST | datetime |  | √ |  |  |  |  | 开始时间 |
| 4 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 5 | ShiftNo | nvarchar | (50) |  |  |  | √ |  | 班别 |
| 6 | EmpOffSum_s | numeric | (16,0) |  |  |  | √ |  | 休息时间加总(秒) |
| 7 | EmpOnSum_s | numeric | (16,0) |  |  |  | √ |  | 上线时间(秒) |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_EMPTime — 日结暂存_人时分摊(生产批)（19 字段）
> 主键：ReportDate, LotNo, OPNo, EquipmentNo, UserNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | UserNo | nvarchar | (50) | √ |  |  |  |  | 人员编号 |
| 6 | ST | datetime |  |  |  |  | √ |  | 开始时间 |
| 7 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 8 | EmpOnSum_s | numeric | (16,2) |  |  |  | √ |  | 人员上线时间(秒) |
| 9 | EmpOffSum_s | numeric | (16,2) |  |  |  | √ |  | 人员休息时间(秒) |
| 10 | EmpSum_s | numeric | (16,2) |  |  |  | √ |  | 有效人时(秒) |
| 11 | Lot_s | numeric | (16,2) |  |  |  | √ |  | 生产批有效时间(秒) |
| 12 | LotSum_s | numeric | (16,2) |  |  |  | √ |  | 生产批有效时间加总(秒) |
| 13 | EmpLot_s | numeric | (16,2) |  |  |  | √ |  | 生产批分摊人时(秒) |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 16 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 17 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_EQPEmp — 日结暂存_设备人员上线区间（14 字段）
> 主键：ReportDate, EquipmentNo, UserNo, ST, LotNo, OpNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | UserNo | nvarchar | (50) | √ |  |  |  |  | 人员编号 |
| 4 | ST | datetime |  | √ |  |  |  |  | 开始时间 |
| 5 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 6 | ShiftNo | nvarchar | (50) |  |  |  | √ |  | 班别 |
| 7 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 8 | OpNo | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_EQPOn — 日结暂存_设备稼动区间（10 字段）
> 主键：ReportDate, EquipmentNo, ST
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 3 | ST | datetime |  | √ |  |  |  |  | 开始时间 |
| 4 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 10 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_EQPTime — 日结暂存_机时分摊(生产批)（14 字段）
> 主键：ReportDate, LotNo, OPNo, EquipmentNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | EQPSum_s | numeric | (16,2) |  |  |  | √ |  | 有效机时(秒) |
| 6 | Lot_s | numeric | (16,2) |  |  |  | √ |  | 生产批有效时间(秒) |
| 7 | LotSum_s | numeric | (16,2) |  |  |  | √ |  | 生产批有效时间加总(秒) |
| 8 | EQP_s | numeric | (16,2) |  |  |  | √ |  | 生产批分摊时间(秒) |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_LotOn — 日结暂存_生产批上线区间（12 字段）
> 主键：ReportDate, LotNo, OPNo, EquipmentNo, ST
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | ST | datetime |  | √ |  |  |  |  | 开始时间 |
| 6 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_LotRealOn — 日结暂存_生产批有效上线区间（12 字段）
> 主键：ReportDate, LotNo, OPNo, EquipmentNo, ST
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | ST | datetime |  | √ |  |  |  |  | 开始时间 |
| 6 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_LotUnWait — 日结暂存_生产批未暂停区间（12 字段）
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  |  |  |  | √ |  | 日期 |
| 2 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 5 | ST | datetime |  |  |  |  | √ |  | 开始时间 |
| 6 | ET | datetime |  |  |  |  | √ |  | 结束时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |

---

### tblWIPTemp_DailyWR_ReportQty — 日结暂存_每日报工数量（93 字段）
> 主键：ReportDate, LotNo, OPNo, EquipmentNo, UserNo, QtyType, LOTNO, PDLINENO, OPNO, POSITIONNO, PCSNO, UNITNAME, SEQ, LOTNO, PDLINENO, OPNO, POSITIONNO, SUBOPSEQUENCE, PCSNO, UNCOLLECTEDNO, UNCOLLECTEDTYPE, SEQ
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ReportDate | date |  | √ |  |  |  |  | 日期 |
| 2 | LotNo | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 3 | OPNo | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 4 | EquipmentNo | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 5 | UserNo | nvarchar | (50) | √ |  |  |  |  | 人员编号 |
| 6 | ReportQty | numeric | (16,4) |  |  |  | √ |  | 报工数量 |
| 7 | QtyType | numeric | (1,0) | √ |  |  |  |  | 报工数量类型 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | LOTNO | nvarchar | (50) |  |  |  | √ |  | 批号 |
| 2 | EQUIPMENTTYPE | nvarchar | (50) |  |  |  | √ |  | 设备类别 |
| 3 | EQUIPMENTNO | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 4 | RECIPEGROUP | nvarchar | (50) |  |  |  | √ |  | 自变量群组 |
| 5 | RECIPEVERSION | numeric | (2,0) |  |  |  | √ |  | 自变量版本 |
| 6 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 7 | EQUIPMENTCLASS | nvarchar | (50) |  |  |  | √ |  | 设备分类 |
| 8 | LOADPORT | numeric | (2,0) |  |  |  | √ |  | 上货区数量 |
| 9 | LogGroupSerial | nvarchar | (50) |  |  |  | √ |  | log序号 |
| 10 | InputQty | numeric | (12,4) |  |  |  | √ | 0 | 输入数量 |
| 11 | OPNo | nvarchar | (50) |  |  |  | √ |  | 作业站编号 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 2 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 3 | INVENTORYNO | nvarchar | (50) |  |  |  | √ |  | 仓库编号 |
| 4 | CURQTY | numeric | (12,4) |  |  |  | √ |  | 目前数量 |
| 5 | CURUNITNO | nvarchar | (30) |  |  |  | √ |  | 目前单位编号 |
| 6 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号 |
| 7 | LOTSERIAL | nvarchar | (50) |  |  |  | √ |  | 生产批流水号 |
| 8 | PRODUCTNO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 9 | PRODUCTVERSION | nvarchar | (10) |  |  |  |  |  | 产品版本 |
| 10 | PHASENO | numeric | (2,0) |  |  |  | √ |  | 阶段编号 |
| 11 | REVERSEID | numeric | (6,0) |  |  |  | √ |  | 还原编号 |
| 12 | SERIALNO | nvarchar | (50) |  |  |  | √ |  | 序号 |
| 13 | BASELOTNO | nvarchar | (50) |  |  |  | √ |  | 主批号 |
| 14 | MODULENO | nvarchar | (50) |  |  |  |  | 'N/A' | 模块编号 |
| 15 | MODULEVERSION | nvarchar | (3) |  |  |  |  | 'N/A' | 模块版次 |
| 16 | OPREFERENCE | numeric | (1,0) |  |  |  |  | 0 | 作业参考 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批编号 |
| 2 | MATERIALNO | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 3 | STDQTY | numeric | (14,6) |  |  |  |  |  | 标准用量 |
| 4 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 5 | DECREASERATE | numeric | (3,2) |  |  |  |  |  | 标准损耗率 |
| 6 | SPECIFIED | numeric | (1,0) |  |  |  |  |  | 指定物料 |
| 7 | PUTINPLACETYPE | numeric | (1,0) |  |  |  |  |  | 投料点类别 |
| 8 | MATERIALLEVEL | numeric | (1,0) |  |  |  |  |  | 物料／半成品 |
| 9 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 10 | COUNTWAY | numeric | (1,0) |  |  |  |  |  | 计量方法 |
| 11 | CHECKLOTNO | numeric | (1,0) |  |  |  |  |  | 批号管制 |
| 12 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 13 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 14 | OPNo | nvarchar | (50) |  |  |  | √ |  | 作业站编号 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线编号 |
| 3 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 5 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 6 | UNITNAME | nvarchar | (50) | √ |  |  |  |  | 部件型别名称 |
| 7 | MATERIALUNITNO | nvarchar | (50) |  |  |  |  |  | 部件序号 |
| 8 | USERNO | nvarchar | (50) |  |  |  |  |  | 部件收集人员 |
| 9 | EVENTTIME | datetime |  |  |  |  |  |  | 部件收集时间 |
| 10 | ISCOLLECT | nvarchar | (1) |  |  |  |  |  | 是否收集完成 |
| 11 | SEQ | numeric | (10,0) | √ |  |  |  |  | 序号 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | LOTNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 2 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线编号 |
| 3 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 4 | POSITIONNO | nvarchar | (50) | √ |  |  |  |  | 工位编号 |
| 5 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序 |
| 6 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 成品序号 |
| 7 | UNCOLLECTEDNO | nvarchar | (50) | √ |  |  |  |  | 部件名称 物料编号 |
| 8 | UNCOLLECTEDTYPE | numeric | (1,0) | √ |  |  |  |  | 类别：0：部件名称 1：物料编号 |
| 9 | EVENTTIME | datetime |  |  |  |  |  |  | 成品序号过站时间 |
| 10 | USERNO | nvarchar | (50) |  |  |  |  |  | 序号收集人员 |
| 11 | COLLECTTIME | datetime |  |  |  |  |  |  | 补刷时间 |
| 12 | COLLECTOR | nvarchar | (50) |  |  |  |  |  | 补刷人员 |
| 13 | ISCOLLECT | numeric | (1,0) |  |  |  |  |  | 是否补收集：0：未收集 1：已收集 |
| 14 | STDQTY | numeric | (12,4) |  |  |  |  |  | 标准用量 |
| 15 | SEQ | numeric | (10,0) | √ |  |  |  |  | 序号 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
