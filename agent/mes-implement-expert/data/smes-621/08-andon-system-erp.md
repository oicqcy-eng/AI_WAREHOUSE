# 08 安灯/系统/用户/ERP (SLight/SYS/USR/VEH/ERP/OEMO)

> 数据字典模块分组 · 来源: `SMES_621数据库设计文档20250313.html` (sMES_Production_61100)

本模块 23 张表：

| 表名 | 说明 | 字段数 |
|------|------|:------:|
| [tblERPTransactionXMLLog_Basis](#tblerptransactionxmllog_basis) | ERP数据重新接收表 (过多可删) | 294 |
| [tblOEMOMaterialList_Unused](#tbloemomateriallist_unused) | 工单用料清单(工单BOM) | 161 |
| [tblOEMOMtlBrAndReLog](#tbloemomtlbrandrelog) | 工单物料借还记录表 | 59 |
| [tblOEMOSource](#tbloemosource) | 工单来源资料表 | 182 |
| [tblRPTStatisticsCondition](#tblrptstatisticscondition) | 自定义报表统计基础配置 | 198 |
| [tblSlightColourBasis](#tblslightcolourbasis) | 安灯颜色基础数据 | 12 |
| [tblSLightEQPState](#tblslighteqpstate) | 安灯设备现况表 | 26 |
| [tblSLightEQPStateLog](#tblslighteqpstatelog) | 安灯设备现况日志表 | 31 |
| [tblSLightMeasureBasis](#tblslightmeasurebasis) | 安灯对策基础数据 | 22 |
| [tblSLightReceiveLog](#tblslightreceivelog) | 安灯任务接受日志 | 11 |
| [tblSLightState](#tblslightstate) | 安灯现况表 | 17 |
| [tblSLightTypeBasis](#tblslighttypebasis) | 安灯分类基础数据 | 123 |
| [tblSPCQCForm](#tblspcqcform) | 检验单主表 | 530 |
| [tblSYSFavouriteHomepage](#tblsysfavouritehomepage) | 我的最爱首页表 | 71 |
| [tblSYSFunctionEvent](#tblsysfunctionevent) | 系统功能事件表 | 280 |
| [tblSYSSyncCrossProdList](#tblsyssynccrossprodlist) | Cross注册产品回传 | 56 |
| [tblUsrCalendarBasis](#tblusrcalendarbasis) | 循环行事历主档 | 53 |
| [tblUSRCategoryBasis](#tblusrcategorybasis) | 报工群组主档 | 10 |
| [tblUSRCategoryDetail](#tblusrcategorydetail) | 报工群组明细 | 76 |
| [tblUsrShiftGroup](#tblusrshiftgroup) | 班别组成 | 9 |
| [tblUsrShiftGroupLine](#tblusrshiftgroupline) | 班别组成单身 | 110 |
| [tblVEHTypeBasis](#tblvehtypebasis) | 载具类别基本数据主档 | 9 |
| [tblVEHVehicleBasis](#tblvehvehiclebasis) | 载具基本数据主档 | 29 |

---

### tblERPTransactionXMLLog_Basis — ERP数据重新接收表 (过多可删)（294 字段）
> 主键：ID, EquipmentNO, EQUIPMENTNO, PRODUCTNO, OPNO, EquipmentNO, DataitemNO, EquipmentNO, DataitemNO, StandardValue, EquipmentNO, EventTime, LotNO, OPNO, DataitemNO, EquipmentNO, DataitemNO, ProductNO, DataitemNO, EventTime, DataitemNO, EquipmentNO, EventTime, DataitemNO, ParamNO, GUID, EquipmentNO, EventID, LotNO, OPNO, ESOPNO, ESOPNO, PRODUCTNO, PRODUCTVERSION, OPNO, SUBOPSEQUENCE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (50) | √ |  |  |  |  | ID |
| 2 | BatchID | nvarchar | (50) |  |  |  |  |  | 批次ID |
| 3 | ServiceName | nvarchar | (50) |  |  |  |  |  | 服务名称 |
| 4 | ERP2MESXML | nvarchar | (-1) |  |  |  | √ |  | Response XML |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ERPTransactionDate | datetime |  |  |  |  | √ |  | ERP传回的抛转最后日期 |
| 7 | Status | numeric | (1,0) |  |  |  | √ |  | 状态 |
| 8 | ProcessResult | nvarchar | (4000) |  |  |  | √ |  | 处理结果 错误信息 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TRANSACTIONID | nvarchar | (50) |  |  |  |  |  | 交易ID：每次请求到回复的所有步骤，交易ID都一样. |
| 2 | STATUSCODE | nvarchar | (10) |  |  |  |  |  | 状态码：像中台的 000、014、015、019 |
| 3 | EXECUTEDATETIME | datetime |  |  |  |  |  |  | 运行时间：运行时间 |
| 4 | EXECUTERESULT | numeric | (1,0) |  |  |  |  | 0 | 运行结果：0失败 ; 1成功 |
| 5 | HOSTREQUESTDATETIME | datetime |  |  |  |  |  |  | 发起时间：发起端发起时间. |
| 6 | HOSTNAME | nvarchar | (50) |  |  |  | √ |  | 发起端名称 |
| 7 | HOSTVERSION | nvarchar | (5) |  |  |  | √ |  | 发起端版本 |
| 8 | HOSTIP | nvarchar | (20) |  |  |  | √ |  | 发起端IP |
| 9 | HOSTID | nvarchar | (20) |  |  |  | √ |  | 发起端ID |
| 10 | HOSTACCOUNT | nvarchar | (20) |  |  |  | √ |  | 发起端账号 |
| 11 | HOSTLANGUAGE | nvarchar | (20) |  |  |  | √ |  | 发起端语系 |
| 12 | PRODUCTNAME | nvarchar | (50) |  |  |  |  |  | 产品名称 |
| 13 | PRODUCTVERSION | nvarchar | (5) |  |  |  |  |  | 产品版本 |
| 14 | SERVICENAME | nvarchar | (50) |  |  |  |  |  | 服务名称 |
| 15 | SERVICEVERSION | nvarchar | (5) |  |  |  |  |  | 服务版本 |
| 16 | Creator | nvarchar | (50) |  |  |  |  |  | 创建人员 |
| 17 | CreateDate | datetime |  |  |  |  |  |  | 创建日期 |
| 18 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 19 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 20 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | Creator | nvarchar | (50) |  |  |  |  |  | 创建人员 |
| 2 | CreateDate | datetime |  |  |  |  |  |  | 创建日期 |
| 3 | TBLESBTRANSACTIONLOGDETAILGUID | nvarchar | (50) |  |  |  |  |  | 主档GUID：TBLESBTRANSACTIONLOGDETAIL的GUID |
| 4 | ORIGINCONTENT | nvarchar | (-1) |  |  |  |  |  | 原始内容 |
| 5 | CONVERTEDCONTENT | nvarchar | (-1) |  |  |  | √ |  | 转换内容 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | Creator | nvarchar | (50) |  |  |  |  |  | 创建人员 |
| 2 | CreateDate | datetime |  |  |  |  |  |  | 创建日期 |
| 3 | TBLESBTRANSACTIONLOGGUID | nvarchar | (50) |  |  |  |  |  | 主档GUID：主档GUID |
| 4 | CONVERTTYPE | nvarchar | (10) |  |  |  |  |  | 转换类型：Format  格式 Content  内容 |
| 5 | EXECUTEDATETIME | datetime |  |  |  |  |  |  | 运行时间 |
| 6 | EXECUTERESULT | numeric | (1,0) |  |  |  |  | 0 | 运行结果：0失败 ; 1成功 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号 |
| 2 | ERP_NAME | nvarchar | (30) |  |  |  | √ |  | 集成站台：若该设备站台与预设不同，可在此指定 预设null |
| 3 | CounterWay | nvarchar | (1) |  |  |  | √ | 'O' | 计数值采集方式：O 覆写 A 累计 预设O |
| 4 | SendFrequency | nvarchar | (1) |  |  |  | √ | 'N' | 采集频率：N 不指定 T 间隔秒数 Q 间隔数量 预设N |
| 5 | SendPeriod | numeric | (12,4) |  |  |  | √ |  | 采集间隔：采集频率=T时本栏位为几秒,=Q时本栏位为多少数量 预设T |
| 6 | ParamCheck | nvarchar | (1) |  |  |  | √ | 'N' | 进站参数检核：N 不检核 W 警告 X 控卡进站 预设N |
| 7 | InParamQuery | numeric | (1,0) |  |  |  | √ | 0 | 进站下询参数：0 No 1 Yes 预设 0 |
| 8 | InParamSet | numeric | (1,0) |  |  |  | √ | 0 | 进站下发参数：0 No 1 Yes 预设 0 |
| 9 | InDataQuery | numeric | (1,0) |  |  |  | √ | 0 | 进站下询数据：0 No 1 Yes 预设 0 |
| 10 | InDataSet | numeric | (1,0) |  |  |  | √ | 0 | 进站下发数据：0 No 1 Yes预设0 |
| 11 | OutParamQuery | numeric | (1,0) |  |  |  | √ | 0 | 出站下询参数：0 No 1 Yes 预设 0 |
| 12 | OutDataQuery | numeric | (1,0) |  |  |  | √ | 0 | 出站下询数据：0 No 1 Yes 预设 0 |
| 13 | OutCounterQuery | numeric | (1,0) |  |  |  | √ | 0 | 出站下询计数器：0 No 1 Yes 预设 0 |
| 14 | OutCounterSet | numeric | (1,0) |  |  |  | √ | 0 | 出站计数器归零：0 No 1 Yes 预设 0 |
| 15 | OutCounterShow | numeric | (1,0) |  |  |  | √ | 0 | 出站带入计数器：0 No 1 Yes 预设 0 |
| 16 | EQPIIOTENABLEFLAG | numeric | (1,0) |  |  |  |  | 0 | 启动机联网应用功能：以下为L1机联网用参数 |
| 17 | EQPIIOTCOLLECTIONCYCLETIME | numeric | (10,1) |  |  |  |  | 30 | 信息回报周期时间：无 (0.0 ~ 999.0) |
| 18 | EQPSTARTCONTROLFLAG | numeric | (1,0) |  |  |  |  | 0 | 启动按钮管控功能 |
| 19 | EQPAUTOSTOPFLAG | numeric | (1,0) |  |  |  |  | 0 | 自动停机管控功能 |
| 20 | EQPPRODUCTIONQTYFLAG | numeric | (1,0) |  |  |  |  | 0 | 启动产出量计算功能 |
| 21 | EQPPRODUCTIONQTYCONVERTYPE | numeric | (1,0) |  |  |  |  | 0 | 产出量转换计算模式：[0] 固定转换倍数 模式 [1] 依照模具设定, 直接参照 模具主档设定之 模穴数 |
| 22 | EQPPRODUCTIONQTYCONVERRATE | numeric | (12,2) |  |  |  |  | 0 | 产出量固定转换倍数：[0] 固定转换倍数(预设), 实数 0.01 ~ 999.00, 预设 1.0 |
| 23 | EQPLOTSTATUSAUTOCHANGEFLAG | numeric | (1,0) |  |  |  |  | 0 | 启用设备停机- 自动任务暂停功能 |
| 24 | EQPAUTOCHECKOUTFLAG | numeric | (1,0) |  |  |  |  | 0 | 启动任务自动出站功能：1 启动 0 不启动 |
| 25 | EQPAUTOCHECKOUTMODE | numeric | (1,0) |  |  |  |  | 0 | 任务自动出站模式：[0] 自动处理模式 (预设选项) [1] 半自动确认模式 |
| 26 | EQPQTYPHASEPERCENT | numeric | (10,0) |  |  |  |  | 0 | 阶段性产量比例：比例值，0~100 |
| 27 | EQPIIOTCONTROLWAITLOT | numeric | (1,0) |  |  |  | √ | 0 | 进站控卡暂停生产批：L1机联网用参数 |
| 28 | ACCLIFEDISCOUNTMETHOD | numeric | (1,0) |  |  |  |  | 0 | 模具寿命扣抵方式：0：一般出站扣抵(本表格中未设定该设备，也跑此方法) 1：机联模次扣抵 |
| 29 | AUTOCHECKOUTAND | numeric | (1,0) |  |  |  |  | 0 | 定时定量关系：自动出站定时定量关联 1 同时成立 0 某一条件成立 |
| 30 | QTYIDLESECONDS | numeric | (12,0) |  |  |  |  | 0 | 切换闲置秒数：完工预告分钟 |
| 31 | ESTRUNFINISHMIN | numeric | (6,0) |  |  |  |  | 0 | 完工预告分钟：集成设备生产批X标工 完工预告时间，显示 |
| 32 | AUTOCHECKOUTRES | numeric | (1,0) |  |  |  |  | 0 | 自动出站保留：0：并用以比例为主， 1：保留比例， 2：保留数 |
| 33 | AUTOCHECKOUTHIN | numeric | (1,0) |  |  |  |  | 0 | 集成出站模式：0 出站通知 1 自动出站 |
| 34 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据状态 |
| 35 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 36 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 37 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 38 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 39 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：设备编号，必填 |
| 3 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号：产品编号，必填 |
| 4 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号：作业站编号，必填但允许 表示所有OP都用此设定 |
| 5 | STDTIMEOUT | numeric | (12,4) |  |  |  |  |  | 定时出站(分) |
| 6 | STDTIMEOUTQTY | numeric | (12,4) |  |  |  |  |  | 定量出站 |
| 7 | STDTIMEOUTNONAUTOCOUNT | numeric | (12,4) |  |  |  |  |  | 自动出站保留数量：有设定自动出站时(定时或定量出站 0)，最后至少需保留多少数量不能自动出站，需手动处理。此值=-1时表示一律不自动出站但会警示、=0时表示一律会自动出站， =1时会检查保留数量，若出站后超过保留数量则自动出站而是触发手动出站通知 |
| 8 | STDTIMEOUTNONAUTORATIO | numeric | (12,4) |  |  |  |  |  | 自动出站保留比例%：0表示本参数不生效，全看自动出站保留数量， 0时则一律取用本数值计算保留量，保留量=LOT数量 比例 |
| 9 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | DataitemNO | nvarchar | (50) | √ |  |  |  |  | 数据项编号 |
| 3 | DataNO | nvarchar | (4) |  |  |  | √ |  | 顺序：预设为01,02,03,04.... |
| 4 | ActualValue | nvarchar | (50) |  |  |  | √ |  | 实际值：目前记录的实际值 |
| 5 | ActualTime | datetime |  |  |  |  | √ |  | 实际值更新时间 |
| 6 | ActualEQTime | datetime |  |  |  |  | √ |  | 实际值设备回传时间 |
| 7 | TBLESIEQPCONFIGGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | DataitemNO | nvarchar | (50) | √ |  |  |  |  | 数据项编号 |
| 3 | ParamNO | nvarchar | (4) |  |  |  | √ |  | 顺序：预设为01,02,03,04.... |
| 4 | MeterType | nvarchar | (1) |  |  |  | √ | 'T' | 仪表类型：N 无 G 压力表式 T 号志灯 预设T G时至少要填写合格下限、标准值、合格上限 |
| 5 | MinSpecValue | numeric | (12,4) |  |  |  | √ |  | 合格下限 |
| 6 | MinWarnValue | numeric | (12,4) |  |  |  | √ |  | 警戒下限 |
| 7 | StandardValue | numeric | (12,4) | √ |  |  |  | 0 | 标准值 |
| 8 | MaxWarnValue | numeric | (12,4) |  |  |  | √ |  | 警戒上限 |
| 9 | MaxSpecValue | numeric | (12,4) |  |  |  | √ |  | 合格上限 |
| 10 | ActualValue | nvarchar | (50) |  |  |  | √ |  | 实际值：目前记录的实际值 |
| 11 | ActualResult | nvarchar | (1) |  |  |  | √ |  | 实际检核状态：G 合格 W 警告 X 不合格 |
| 12 | ActMinSpecValue | numeric | (12,4) |  |  |  | √ |  | 实际合格下限 |
| 13 | ActMinWarnValue | numeric | (12,4) |  |  |  | √ |  | 实际警戒下限 |
| 14 | ActStardardValue | numeric | (12,4) |  |  |  | √ |  | 实际标准值 |
| 15 | ActMaxWarnValue | numeric | (12,4) |  |  |  | √ |  | 实际警戒上限 |
| 16 | ActMaxSpecValue | numeric | (12,4) |  |  |  | √ |  | 实际合格上限 |
| 17 | ActualTime | datetime |  |  |  |  | √ |  | 实际值更新时间 |
| 18 | ActualEQTime | datetime |  |  |  |  | √ |  | 实际值设备回传时间 |
| 19 | TBLESIEQPCONFIGGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 22 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | EventTime | datetime |  | √ |  |  |  |  | 检核时间 |
| 3 | LotNO | nvarchar | (50) | √ |  |  |  |  | 生产批号 |
| 4 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号 |
| 5 | DataitemNO | nvarchar | (50) | √ |  |  |  |  | 数据项编号 |
| 6 | ParamNO | char | (4) |  |  |  |  |  | 顺序：预设为01,02,03,04.... |
| 7 | ActualValue | numeric | (12,4) |  |  |  | √ |  | 实际值：目前记录的实际值 |
| 8 | ActualResult | nvarchar | (1) |  |  |  | √ |  | 实际检核状态：G 合格 W 警告 X 不合格 |
| 9 | ActMinSpecValue | numeric | (12,4) |  |  |  | √ |  | 实际合格下限 |
| 10 | ActMinWarnValue | numeric | (12,4) |  |  |  | √ |  | 实际警戒下限 |
| 11 | ActStandardValue | numeric | (12,4) |  |  |  | √ |  | 实际标准值 |
| 12 | ActMaxWarnValue | numeric | (12,4) |  |  |  | √ |  | 实际警戒上限 |
| 13 | ActMaxSpecValue | numeric | (12,4) |  |  |  | √ |  | 实际合格上限 |
| 14 | AllPass | numeric | (1,0) |  |  |  | √ |  | 全部合格否：1 所有检核项目通过 0 有部分不通过 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | DataitemNO | nvarchar | (50) | √ |  |  |  |  | 数据项编号 |
| 3 | ProductNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 4 | MinSpecValue | numeric | (12,4) |  |  |  | √ |  | 合格下限 |
| 5 | MinWarnValue | numeric | (12,4) |  |  |  | √ |  | 警戒下限 |
| 6 | StandardValue | numeric | (12,4) |  |  |  |  | 0 | 标准值 |
| 7 | MaxWarnValue | numeric | (12,4) |  |  |  | √ |  | 警戒上限 |
| 8 | MaxSpecValue | numeric | (12,4) |  |  |  | √ |  | 合格上限 |
| 9 | ProductName | nvarchar | (255) |  |  |  | √ |  | 产品名称 |
| 10 | TBLESIEQPPARAMGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | EQUIPMENTNO | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | STARTCOUNT | nvarchar | (50) |  |  |  |  |  | 起使计数 |
| 5 | ENDCOUNT | nvarchar | (50) |  |  |  | √ |  | 迄止计数 |
| 6 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 7 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | DataitemNO | nvarchar | (50) | √ |  |  |  |  | 数据项编号 |
| 2 | DataitemName | nvarchar | (50) |  |  |  |  |  | 数据项名称 |
| 3 | DataType | nvarchar | (1) |  |  |  | √ | 'N' | 数据型态：N number S string D datatime |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EventTime | datetime |  | √ |  |  |  |  | 记录时间：若采集项有变动时，会将更新时间记录于此，以此时间记录变更前的采集项信息 |
| 2 | DataitemNO | nvarchar | (50) | √ |  |  |  |  | 数据项编号 |
| 3 | DataitemName | nvarchar | (50) |  |  |  |  |  | 数据项名称 |
| 4 | DataType | nvarchar | (1) |  |  |  | √ | 'N' | 数据型态：N umber S string D datatime |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 数据项说明 |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 2 | EventTime | datetime |  | √ |  |  |  |  | 采集时间 |
| 3 | ReportTime | datetime |  |  |  |  | √ |  | 设备回传时间 |
| 4 | EventID | nvarchar | (64) |  |  |  |  |  | 采集批次编号：GUID,若为中台取req_id标签的值 |
| 5 | DataitemNO | nvarchar | (255) | √ |  |  |  |  | 数据项编号：若为生产参数此栏位一开始为空，需跑ESIDAACOMPAREPROCESS自动执行进程才会补上采集项编号。 01 表示为计数器的数量 |
| 6 | ParamNO | nvarchar | (50) | √ |  |  |  |  | 顺序：若为生产参数，记录当时顺序 |
| 7 | SourceType | nvarchar | (1) |  |  |  |  |  | 来源类型：P 生产参数 D 生产数据 |
| 8 | ProcessFlag | nvarchar | (1) |  |  |  | √ | 'N' | 数据处理旗标：N 未处理 P 处理中 S 处理完成 X 异常 （跑ESIDAACOMPAREPROCESS自动执行进程状态记录 N表示没跑过该进程） |
| 9 | ProcessTime | datetime |  |  |  |  | √ |  | 处理时间：最近跑 ESIDAACOMPAREPROCESS自动执行进程时间 |
| 10 | Memo | nvarchar | (200) |  |  |  | √ |  | 备注：记录处理异常信息(ESIDAACOMPAREPROCESS自动执行) |
| 11 | LotNO | nvarchar | (50) |  |  |  | √ |  | 生产批号：若传入讯息中有LOTNO会记录于此，如果没有传入则为空值，待执行ESIDAACOMPAREPROCESS后会补上接讯息当时最早进站的LOTNO |
| 12 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 13 | OPNO | nvarchar | (50) |  |  |  | √ |  | 作业站编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 14 | OPName | nvarchar | (50) |  |  |  | √ |  | 作业站名称：执行ESIDAACOMPAREPROCESS后补上数据 |
| 15 | ProductNO | nvarchar | (50) |  |  |  | √ |  | 产品编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 16 | ProductVersion | nvarchar | (50) |  |  |  | √ |  | 产品版本：执行ESIDAACOMPAREPROCESS后补上数据 |
| 17 | ProductName | nvarchar | (50) |  |  |  | √ |  | 产品名称：执行ESIDAACOMPAREPROCESS后补上数据 |
| 18 | ProductSpec | nvarchar | (50) |  |  |  | √ |  | 产品规格：执行ESIDAACOMPAREPROCESS后补上数据 |
| 19 | LotQty | numeric | (12,4) |  |  |  | √ |  | 生产批开立数：执行ESIDAACOMPAREPROCESS后补上数据 |
| 20 | OPQty | numeric | (12,4) |  |  |  | √ |  | 生产中数量：执行ESIDAACOMPAREPROCESS后补上数据 |
| 21 | UnitNO | nvarchar | (50) |  |  |  | √ |  | 单位：执行ESIDAACOMPAREPROCESS后补上数据 |
| 22 | RONO | nvarchar | (50) |  |  |  | √ |  | 订单编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 23 | ITEMNO | nvarchar | (50) |  |  |  | √ |  | 订单项次：执行ESIDAACOMPAREPROCESS后补上数据 |
| 24 | EquipmentName | nvarchar | (50) |  |  |  | √ |  | 设备名称：执行ESIDAACOMPAREPROCESS后补上数据 |
| 25 | ProcessCount | numeric | (12,4) |  |  |  | √ | 0 | 处理次数：执行ESIDAACOMPAREPROCESS被处理的次数 |
| 26 | DataType | nvarchar | (2) |  |  |  | √ | 'N' | 数据型态 |
| 27 | ActualValue | nvarchar | (50) |  |  |  |  |  | 实际值：采集项的数值 |
| 28 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 29 | ACTUALNUMBER | nvarchar | (12) |  |  |  | √ |  | 实际值（数量,注塑包用)：暂无使用 |
| 30 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 31 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 32 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 33 | GUID | nvarchar | (50) | √ |  |  |  |  | 数据键值 |
| 34 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EquipmentNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：对应tblESIItemLogLot的同名栏位 |
| 2 | EventID | nvarchar | (64) | √ |  |  |  |  | 采集批次编号：对应tblESIItemLogLot的同名栏位 |
| 3 | LotNO | nvarchar | (50) | √ |  |  |  |  | 生产批号：记录收到讯息时设备上的LOTNO |
| 4 | MaxInTime | datetime |  |  |  |  | √ |  | 最近进站时间：LOTNO该生产批的最近进站时间 |
| 5 | SEQ | numeric | (12,4) |  |  |  | √ |  | 顺序：LOTNO的顺序，最近进站时间越早的序号越小 |
| 6 | MONO | nvarchar | (50) |  |  |  | √ |  | 工单编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 7 | OPNO | nvarchar | (50) | √ |  |  |  |  | 作业站编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 8 | OPName | nvarchar | (50) |  |  |  | √ |  | 作业站名称：执行ESIDAACOMPAREPROCESS后补上数据 |
| 9 | ProductNO | nvarchar | (50) |  |  |  | √ |  | 产品编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 10 | ProductVersion | nvarchar | (50) |  |  |  | √ |  | 产品版本：执行ESIDAACOMPAREPROCESS后补上数据 |
| 11 | ProductName | nvarchar | (50) |  |  |  | √ |  | 产品名称：执行ESIDAACOMPAREPROCESS后补上数据 |
| 12 | ProductSpec | nvarchar | (50) |  |  |  | √ |  | 产品规格：执行ESIDAACOMPAREPROCESS后补上数据 |
| 13 | LotQty | numeric | (12,4) |  |  |  | √ |  | 生产批开立数：执行ESIDAACOMPAREPROCESS后补上数据 |
| 14 | OPQty | numeric | (12,4) |  |  |  | √ |  | 生产中数量：执行ESIDAACOMPAREPROCESS后补上数据 |
| 15 | UnitNO | nvarchar | (50) |  |  |  | √ |  | 单位：执行ESIDAACOMPAREPROCESS后补上数据 |
| 16 | RONO | nvarchar | (50) |  |  |  | √ |  | 订单编号：执行ESIDAACOMPAREPROCESS后补上数据 |
| 17 | ITEMNO | nvarchar | (50) |  |  |  | √ |  | 订单项次：执行ESIDAACOMPAREPROCESS后补上数据 |
| 18 | EquipmentName | nvarchar | (50) |  |  |  | √ |  | 设备名称：执行ESIDAACOMPAREPROCESS后补上数据 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 21 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 22 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 23 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 24 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 25 | DATATYPE | nvarchar | (2) |  |  |  | √ |  | 数据型态 |
| 1 | ESOPNO | nvarchar | (20) | √ |  |  |  |  | eSOP编号 |
| 2 | FILENAME | nvarchar | (50) |  |  |  |  |  | 文档名 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明 |
| 4 | DOCFILENAME | nvarchar | (60) |  |  |  |  |  | 文档档案名称 |
| 5 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 6 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | ESOPNO | nvarchar | (20) | √ |  |  |  |  | eSOP编号 |
| 2 | PRODUCTNO | nvarchar | (50) | √ |  |  |  |  | 产品编号 |
| 3 | PRODUCTVERSION | nvarchar | (5) | √ |  |  |  |  | 产品版本 |
| 4 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 5 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序 |
| 6 | SEQ | numeric | (4,0) |  |  |  |  |  | 序号 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明 |
| 8 | REVISOR | nvarchar | (30) |  |  |  |  |  | 修改人 |
| 9 | REVISEDATE | datetime |  |  |  |  |  |  | 修改日 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOEMOMaterialList_Unused — 工单用料清单(工单BOM)（161 字段）
> 主键：MONO, MATERIALNO, OPNO, SUBSTITUTEMATERIALNO, PositionNo, SID, MONO, MATERIALNO, OPNO, SUBSTITUTEMATERIALNO, PositionNo, MONO, MATERIALNO, MATERIALLOTNO, SUBSTITUTEMATERIALNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 3 | MATERIALLEVEL | numeric | (1,0) |  |  |  | √ |  | 物料等级：0：Material(物料)。 1：Product(产品)。 |
| 4 | STDQTY | numeric | (14,6) |  |  |  | √ |  | 单位标准用量 |
| 5 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 6 | DECREASERATE | numeric | (3,2) |  |  |  | √ |  | 耗损率 |
| 7 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 8 | SPECIFIED | numeric | (1,0) |  |  |  | √ | 0 | 指定：0：NO，非指定用料可使用替代料。 1：YES，指定用料不可使用替代料。 |
| 9 | PUTINPLACETYPE | numeric | (2,0) |  |  |  | √ |  | 投料点类别：2：WIP INV(Raw)，线边仓。 3：MO，工单。 4：WIP INV(SEMI)，线边仓。 5：倒扣料 99：ERP不发料，SMES可依据此表来作现场物料的查核 |
| 10 | MOFLAG | numeric | (1,0) |  |  |  | √ | 1 | MoFlag |
| 11 | MATERIALMONO | nvarchar | (50) |  |  |  |  |  | 物料工单编号 |
| 12 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 13 | COUNTWAY | numeric | (1,0) |  |  |  |  |  | 计量方法：0：Standard，标准用量，即以标准用量计算物料使用量。 1：Real，实际用量，即以用户输入的实际物料使用量为扣量标准。 2：Average，平均用量，即以批量作基准平摊物料使用量，此选项必须搭配客制企业逻辑才可达成，非标准系统功能。 |
| 14 | CHECKLOTNO | numeric | (1,0) |  |  |  |  |  | 是否检查批号：0：False，不管控物料批号，系统将视物料批号为N A。 1：True，管控物料料号，扣料时必须输入物料批号。 |
| 15 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 16 | ORGMATERIALNO | nvarchar | (50) |  |  |  | √ |  | 原始料号 |
| 17 | EX_MTLLIST1 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList1 |
| 18 | EX_MTLLIST2 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList2 |
| 19 | MATERIALVERSION | nvarchar | (5) |  |  |  | √ |  | 版本：当生产用料为半成品时记录半成品的产品版本，物料时记录N A。 |
| 20 | ORGMATERIALQTY | numeric | (14,6) |  |  |  | √ | 0 | 原始发料数 |
| 21 | SUBSTITUTEMATERIALNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 替代料编号 |
| 22 | SUBSTITUTEMATERIALLEVEL | numeric | (1,0) |  |  |  | √ | 0 | 替代料等级：0：Material(物料)。 1：Product(产品)。 |
| 23 | REQUIREQTY | numeric | (16,6) |  |  |  |  | 0 | 需求数 |
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
| 63 | DICIMALDIGIT | numeric | (5,0) |  |  |  |  | -1 | 小数位数：20200204 add by Dustdusk IMES用的 算用料的小数位数 |
| 64 | PositionNo | nvarchar | (50) | √ |  |  |  | 'N/A' | 工位编号 |
| 65 | MTLSyncMode | numeric | (2,0) |  |  |  | √ | 1 | 叫料模式：1：手动 2：自动 |
| 66 | MINStockQTY | numeric | (14,6) |  |  |  | √ |  | 最低存量 |
| 67 | SOURCEOFINFO | numeric | (2,0) |  |  |  |  | 0 | 资料来源：0：预设 1：调整 2：添加 |
| 68 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 69 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 70 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SID | nvarchar | (50) | √ |  |  |  |  | 识别码：YYYYMMDDHHmmssfff |
| 2 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 3 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 4 | MATERIALLEVEL | numeric | (1,0) |  |  |  | √ |  | 物料等级：0：Material(物料)。 1：Product(产品)。 |
| 5 | STDQTY | numeric | (14,6) |  |  |  | √ |  | 单位标准用量 |
| 6 | UNITNO | nvarchar | (30) |  |  |  | √ |  | 单位编号 |
| 7 | DECREASERATE | numeric | (3,2) |  |  |  | √ |  | 耗损率 |
| 8 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 9 | SPECIFIED | numeric | (1,0) |  |  |  | √ | 0 | 指定：0：NO，非指定用料可使用替代料。 1：YES，指定用料不可使用替代料。 |
| 10 | PUTINPLACETYPE | numeric | (1,0) |  |  |  | √ |  | 投料点类别：2：WIP INV(Raw)，线边仓。 3：MO，工单。 4：WIP INV(SEMI)，线边仓。 5：倒扣料 |
| 11 | MOFLAG | numeric | (1,0) |  |  |  | √ | 1 | MoFlag |
| 12 | MATERIALMONO | nvarchar | (50) |  |  |  |  |  | 物料工单编号 |
| 13 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 14 | COUNTWAY | numeric | (1,0) |  |  |  |  |  | 计量方法：0：Standard，标准用量，即以标准用量计算物料使用量。 1：Real，实际用量，即以用户输入的实际物料使用量为扣量标准。 2：Average，平均用量，即以批量作基准平摊物料使用量，此选项必须搭配客制企业逻辑才可达成，非标准系统功能。 |
| 15 | CHECKLOTNO | numeric | (1,0) |  |  |  |  |  | 是否检查批号：0：False，不管控物料批号，系统将视物料批号为N A。 1：True，管控物料料号，扣料时必须输入物料批号。 |
| 16 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 17 | ORGMATERIALNO | nvarchar | (50) |  |  |  | √ |  | 原始料号 |
| 18 | EX_MTLLIST1 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList1 |
| 19 | EX_MTLLIST2 | nvarchar | (20) |  |  |  | √ |  | Ex_MTLList2 |
| 20 | MATERIALVERSION | nvarchar | (5) |  |  |  | √ |  | 版本：当生产用料为半成品时记录半成品的产品版本，物料时记录N A。 |
| 21 | ORGMATERIALQTY | numeric | (14,6) |  |  |  | √ | 0 | 原始发料数 |
| 22 | SUBSTITUTEMATERIALNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 替代料编号 |
| 23 | SUBSTITUTEMATERIALLEVEL | numeric | (1,0) |  |  |  | √ | 0 | 替代料等级：0：Material(物料)。 1：Product(产品)。 |
| 24 | REQUIREQTY | numeric | (16,6) |  |  |  |  | 0 | 需求数 |
| 25 | SUBSTITUTESTDQTY | numeric | (16,6) |  |  |  |  | 0 | 替代料标准数量 |
| 26 | QPAMolecular | numeric | (20,6) |  |  |  | √ |  | QPA分子 |
| 27 | QPADenominator | numeric | (20,6) |  |  |  | √ |  | QPA分母 |
| 28 | SubstituteQPAMolecular | numeric | (20,6) |  |  |  | √ |  | 替代料QPA分子 |
| 29 | SubstituteQPADenominator | numeric | (20,6) |  |  |  | √ |  | 替代料QPA分母 |
| 30 | USER_DEFINED01 | nvarchar | (255) |  |  |  | √ |  | 用户自定义01 |
| 31 | USER_DEFINED02 | nvarchar | (255) |  |  |  | √ |  | 用户自定义02 |
| 32 | USER_DEFINED03 | nvarchar | (255) |  |  |  | √ |  | 用户自定义03 |
| 33 | USER_DEFINED04 | nvarchar | (255) |  |  |  | √ |  | 用户自定义04 |
| 34 | USER_DEFINED05 | nvarchar | (255) |  |  |  | √ |  | 用户自定义05 |
| 35 | USER_DEFINED06 | nvarchar | (255) |  |  |  | √ |  | 用户自定义06 |
| 36 | USER_DEFINED07 | nvarchar | (255) |  |  |  | √ |  | 用户自定义07 |
| 37 | USER_DEFINED08 | nvarchar | (255) |  |  |  | √ |  | 用户自定义08 |
| 38 | USER_DEFINED09 | nvarchar | (255) |  |  |  | √ |  | 用户自定义09 |
| 39 | USER_DEFINED10 | nvarchar | (255) |  |  |  | √ |  | 用户自定义10 |
| 40 | USER_DEFINED11 | numeric | (23,8) |  |  |  | √ |  | 用户自定义11 |
| 41 | USER_DEFINED12 | numeric | (23,8) |  |  |  | √ |  | 用户自定义12 |
| 42 | USER_DEFINED13 | numeric | (23,8) |  |  |  | √ |  | 用户自定义13 |
| 43 | USER_DEFINED14 | numeric | (23,8) |  |  |  | √ |  | 用户自定义14 |
| 44 | USER_DEFINED15 | numeric | (23,8) |  |  |  | √ |  | 用户自定义15 |
| 45 | USER_DEFINED16 | numeric | (23,8) |  |  |  | √ |  | 用户自定义16 |
| 46 | USER_DEFINED17 | numeric | (23,8) |  |  |  | √ |  | 用户自定义17 |
| 47 | USER_DEFINED18 | numeric | (23,8) |  |  |  | √ |  | 用户自定义18 |
| 48 | USER_DEFINED19 | numeric | (23,8) |  |  |  | √ |  | 用户自定义19 |
| 49 | USER_DEFINED20 | numeric | (23,8) |  |  |  | √ |  | 用户自定义20 |
| 50 | USER_DEFINED21 | datetime |  |  |  |  | √ |  | 用户自定义21 |
| 51 | USER_DEFINED22 | datetime |  |  |  |  | √ |  | 用户自定义22 |
| 52 | USER_DEFINED23 | datetime |  |  |  |  | √ |  | 用户自定义23 |
| 53 | USER_DEFINED24 | datetime |  |  |  |  | √ |  | 用户自定义24 |
| 54 | USER_DEFINED25 | datetime |  |  |  |  | √ |  | 用户自定义25 |
| 55 | USER_DEFINED26 | datetime |  |  |  |  | √ |  | 用户自定义26 |
| 56 | USER_DEFINED27 | datetime |  |  |  |  | √ |  | 用户自定义27 |
| 57 | USER_DEFINED28 | datetime |  |  |  |  | √ |  | 用户自定义28 |
| 58 | USER_DEFINED29 | datetime |  |  |  |  | √ |  | 用户自定义29 |
| 59 | USER_DEFINED30 | datetime |  |  |  |  | √ |  | 用户自定义30 |
| 60 | USER_DEFINED31 | nvarchar | (255) |  |  |  | √ |  | 用户自定义31 |
| 61 | USER_DEFINED32 | nvarchar | (255) |  |  |  | √ |  | 用户自定义32 |
| 62 | USER_DEFINED33 | numeric | (23,8) |  |  |  | √ |  | 用户自定义33 |
| 63 | USER_DEFINED34 | numeric | (23,8) |  |  |  | √ |  | 用户自定义34 |
| 64 | DICIMALDIGIT | numeric | (5,0) |  |  |  |  | -1 | 小数位数：20200204 add by Dustdusk IMES用的, 算用料的小数位数 |
| 65 | PositionNo | nvarchar | (50) | √ |  |  |  | 'N/A' | 工位编号 |
| 66 | MTLSyncMode | numeric | (2,0) |  |  |  | √ | 1 | 叫料模式：1：手动 2：自动 |
| 67 | MINStockQTY | numeric | (14,6) |  |  |  | √ |  | 最低存量 |
| 68 | SourceOfInfo | numeric | (2,0) |  |  |  |  | 0 | 资料来源：0：预设 1：调整 2：添加 |
| 69 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人员 |
| 70 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日期：异动记录日期 |
| 71 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 72 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 73 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 74 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 75 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 76 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | MATERIALNO | nvarchar | (50) | √ |  |  |  |  | 物料编号 |
| 3 | MATERIALLOTNO | nvarchar | (50) | √ |  |  |  |  | 物料批号 |
| 4 | UNITNO | nvarchar | (30) |  |  |  |  |  | 单位编号 |
| 5 | QTY | numeric | (16,6) |  |  |  |  |  | 数量 |
| 6 | MATERIALLEVEL | numeric | (1,0) |  |  |  |  |  | 物料等级：0：Material(物料)。 1：Product(产品)。 |
| 7 | MATERIALTYPE | nvarchar | (50) |  |  |  | √ |  | 物料类别 |
| 8 | INPUTDATE | datetime |  |  |  |  | √ |  | 输入日期 |
| 9 | SUBSTITUTEMATERIALNO | nvarchar | (50) | √ |  |  |  | 'N/A' | 替代料编号 |
| 10 | SUBSTITUTEMATERIALLEVEL | numeric | (1,0) |  |  |  | √ | 0 | 替代料等级：0：Material(物料)。 1：Product(产品)。 |
| 11 | SubstituteMaterialQty | numeric | (14,6) |  |  |  | √ |  | 替代料数量 |
| 12 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 13 | DeliverMode | numeric | (1,0) |  |  |  |  | 0 | 发料模式：0 ?有发料 1 ?无发料 |
| 14 | ExpiryDate | datetime |  |  |  |  | √ |  | 物料有效日期：#83902 20201210 朱煜轲 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblOEMOMtlBrAndReLog — 工单物料借还记录表（59 字段）
> 主键：ID, MONO, PROCESSORDER, MONO, PROPERTYNO, MONO, PROPERTYNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (50) | √ |  |  |  |  | ID |
| 2 | OperateType | numeric | (1,0) |  |  |  |  |  | 操作类型：1-借 2-还 |
| 3 | Status | numeric | (1,0) |  |  |  |  |  | 状态：1-待还 2-完成 |
| 4 | ToEquipmentNo | nvarchar | (50) |  |  |  | √ |  | 设备编号 |
| 5 | ToOpNo | nvarchar | (20) |  |  |  | √ |  | 作业站 |
| 6 | ToMoNo | nvarchar | (50) |  |  |  |  |  | 工单号 |
| 7 | ToPositionNo | nvarchar | (50) |  |  |  | √ |  | 位置编号 |
| 8 | MaterialNo | nvarchar | (50) |  |  |  |  |  | 物料编号 |
| 9 | MaterialLotNo | nvarchar | (50) |  |  |  |  | 'N/A' | 物料批号编号 |
| 10 | Qty | numeric | (16,6) |  |  |  |  |  | 数量 |
| 11 | WaitQty | numeric | (16,6) |  |  |  |  |  | 待还数量 |
| 12 | SubstituteMaterialNo | nvarchar | (50) |  |  |  |  | 'N/A' | 替代料编号 |
| 13 | OrgMoNo | nvarchar | (50) |  |  |  |  |  | 原工单号 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | Updater | nvarchar | (20) |  |  |  |  |  | 更新人 |
| 17 | UpdateDate | datetime |  |  |  |  |  |  | 更新时间 |
| 18 | BorrowId | nvarchar | (50) |  |  |  | √ |  | 借出ID |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 22 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | PSNO | nvarchar | (50) |  |  |  |  |  | 区段编号 |
| 3 | PROCESSORDER | numeric | (2,0) | √ |  |  |  |  | 流程次序 |
| 4 | PROCESSNO | nvarchar | (64) |  |  |  | √ |  | 流程编号 |
| 5 | OPNO | nvarchar | (20) |  |  |  |  |  | 作业站编号 |
| 6 | NODEID | nvarchar | (100) |  |  |  |  |  | 节点编号 |
| 7 | PSORDER | numeric | (2,0) |  |  |  |  |  | 区段次序：是区段间先后次序的标注字段，区段次序的设定影响了集成性制程的连结性，系统规定在设定多区段时区段必须连续,在即区段A完成后接区段B时,区段A、B必须连续。 |
| 8 | HAVECOMPONENT | numeric | (1,0) |  |  |  |  |  | 是否有组件：0：否，本区段内的生产制程以生产批为单位 1：是，本区段内的生产制程其生产批带有组件的信息 |
| 9 | HAVELEVEL | numeric | (1,0) |  |  |  |  |  | 是否有Bin分布：0：否，生产批数量无等级分布 1：是，生产批数量有等级分布 |
| 10 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 11 | PROCESSVERSION | nvarchar | (5) |  |  |  | √ |  | 流程版本 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 14 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 18 | TBLOEMOBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | PROPERTYVALUE | nvarchar | (255) |  |  |  | √ |  | 属性值 |
| 4 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 3 | PROPERTYVALUE | nvarchar | (255) |  |  |  | √ |  | 属性值 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLOEMOBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblOEMOSource — 工单来源资料表（182 字段）
> 主键：MONO, RONO, ItemNo, RONO, OPNO, AREANO, OPNO, OPNO, FROMNODE, TONODE, LINKNAME, OPNO, EQUIPMENTTYPE, OPNO, ERRORNO, OPGROUPNO, OPGROUPNO, OPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MONO | nvarchar | (50) | √ |  |  |  |  | 工单编号 |
| 2 | MOSOURCE | numeric | (2,0) |  |  |  | √ |  | 工单来源 |
| 3 | RONO | nvarchar | (25) | √ |  |  |  |  | 订单编号 |
| 4 | ItemNo | numeric | (6,0) | √ |  |  |  |  | 项目编号 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | RONO | nvarchar | (25) | √ |  |  |  |  | 订单编号 |
| 2 | CUSTOMERNO | nvarchar | (50) |  |  |  |  |  | 客户编号 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 8 | ROSTATE | numeric | (2,0) |  |  |  |  | 0 | 订单状态 |
| 9 | DueDate | datetime |  |  |  |  | √ |  | 到期日 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | RONO | nvarchar | (25) |  |  |  |  |  | 订单编号 |
| 2 | ITEMNO | numeric | (6,0) |  |  |  |  |  | 客户编号 |
| 3 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 4 | ORDERQTY | numeric | (12,4) |  |  |  |  |  | 订单数量 |
| 5 | UNRELEASEQTY | numeric | (12,4) |  |  |  |  |  | 未下线数量 |
| 6 | STATE | numeric | (2,0) |  |  |  |  | 0 | 状态 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | ROUNITNO | nvarchar | (64) |  |  |  |  |  | 订单单位编号 |
| 11 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 12 | CUSTOMERNO | nvarchar | (50) |  |  |  | √ |  | 客户编号 |
| 13 | ORDERTYPE | nvarchar | (30) |  |  |  | √ |  | 订单类型 |
| 14 | SHIPQTY | numeric | (12,4) |  |  |  |  | 0 | 发货数量 |
| 15 | PRIORITY | numeric | (2,0) |  |  |  |  | 9 | 优先权 |
| 16 | BOOKINGFLAG | numeric | (1,0) |  |  |  |  | 1 | 是否预定 |
| 17 | SHIPPINGFLAG | numeric | (1,0) |  |  |  |  | 1 | 是否发货 |
| 18 | UNITPRICE | numeric | (8,2) |  |  |  | √ | 0 | 单价 |
| 19 | UNITMEASURE | nvarchar | (30) |  |  |  | √ |  | 单量 |
| 20 | CURRENCY | nvarchar | (30) |  |  |  | √ |  | 货币 |
| 21 | ORDERDATE | datetime |  |  |  |  | √ |  | 订单日 |
| 22 | REVISER | nvarchar | (50) |  |  |  | √ |  | 编辑人 |
| 23 | REVISEDATE | datetime |  |  |  |  | √ |  | 编辑日 |
| 24 | CUSTOMERNAME | nvarchar | (100) |  |  |  | √ |  | 客户名称 |
| 25 | DueDate | datetime |  |  |  |  | √ |  | 到期日 |
| 26 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 27 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 28 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | AREANO | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 3 | DEFAULTAREA | numeric | (1,0) |  |  |  | √ | 0 | 预设区域：0：不是预设区域1：是预设区域 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | OPNAME | nvarchar | (500) |  |  |  | √ |  | 作业站名称 |
| 3 | OPTYPE | nvarchar | (20) |  |  |  |  |  | 作业站类别 |
| 4 | OPCLASS | numeric | (1,0) |  |  |  |  | 0 | 作业站分类：0：General OP(一般作业站) 1：QC(QC作业站) 2：Other OP(其他作业站) |
| 5 | OPSHORTNAME | nvarchar | (500) |  |  |  | √ |  | 作业站简称 |
| 6 | OPORDER | numeric | (6,0) |  |  |  | √ | 0 | 显示顺序 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 作业站说明：说明 |
| 8 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 9 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 11 | RULEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  | RULEXMLSTRING：企业逻辑之XML字符串数 |
| 12 | PSNO | nvarchar | (50) |  |  |  | √ |  | 区段编号 |
| 13 | PRINTOUTONRUNCARD | numeric | (1,0) |  |  |  | √ |  | 流程卡显示：0：否 1：是 |
| 14 | STDUNITRUNTIME | numeric | (6,2) |  |  |  |  | 0 | 标准作业时间 |
| 15 | COUNTOPUNITQTY | numeric | (6,0) |  |  |  |  | 1 | 计时单位 |
| 16 | STDQUEUETIME | numeric | (6,2) |  |  |  |  | 0 | 标准等待时间 |
| 17 | PARTIALMODE | numeric | (1,0) |  |  |  | √ |  | 分量模式 |
| 18 | MaterialOption | numeric | (1,0) |  |  |  |  | 0 | 用料选项：用料选项包含发料点、设备、产线三个选项 0：发料点 1：设备 2：产线 |
| 19 | MULTIOPERATORMODE | numeric | (1,0) |  |  |  | √ | 0 | 多人加工模式：多人加工模式包含设备和产线两种模式 2：设备 3：产线 |
| 20 | ERPNO | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 21 | OSOPTION | decimal | (1,0) |  |  |  |  | 0 | 外包选项：外包选项包含自制、外包、自制+外包三个选项 0：自制 1：外包 2：自制+外包 |
| 22 | OSNO | nvarchar | (40) |  |  |  | √ |  | QCI.TBLOPBASIS.Column.OSNO.displayText：10 25 哲玮比对后添加 |
| 23 | NEEDFIRSTCHECKOK | numeric | (1,0) |  |  |  | √ | 0 | 是否查核需做首检：0：否 1：是 勾选框勾选为是，未勾选为否 |
| 24 | SPC_PQC | numeric | (2,0) |  |  |  | √ | 0 | 制程检验：0：否 1：是 勾选框勾选为是，未勾选为否 |
| 25 | AUTOCI | numeric | (1,0) |  |  |  | √ | 0 | 自动进站：0：否 1：是 |
| 26 | DEFAULTEQPNO | nvarchar | (50) |  |  |  | √ | '0' | 自动进站设备 |
| 27 | OUTPUTRATE | numeric | (5,2) |  |  |  |  | 0 | 完工比率 |
| 28 | QC_Control | numeric | (2,0) |  |  |  |  | 1 | 制程卡控出站检验 |
| 29 | ISCHECKSTARTINGCHECKLIST | nvarchar | (1) |  |  |  | √ | '0' | 是否始业点检：0：否 1：是 |
| 30 | SPC_PQC2 | varchar | (10) |  |  |  | √ |  | 首 巡检制程检验 |
| 31 | QC_Control2 | varchar | (10) |  |  |  | √ |  | 首 巡检制程卡控 |
| 32 | QCCheckRate | numeric | (1,0) |  |  |  |  | 0 | 首检频率：0：作业站+生产批;1：作业站+工单;2：作业站+产品;3：作业站+生产批+班别;4：作业站+生产批+日;5：作业站+生产批+设备;6：作业站+生产批+设备+日;7：作业站+生产批+设备+班别 |
| 33 | PQCCheckRate | numeric | (2,0) |  |  |  |  | 0 | 巡检频率：0：作业站+生产批;1：作业站+工单;2：作业站+产品;3：作业站+生产批+班别;4：作业站+生产批+日;5：作业站+生产批+设备;6：作业站+生产批+设备+日;7：作业站+生产批+设备+班别 |
| 34 | NeedPQCheckOK | numeric | (1,0) |  |  |  |  | 0 | 是否查核需做巡检：0：否 1：是 勾选框勾选为是，未勾选为否 |
| 35 | PlugInUnit | numeric | (2,0) |  |  |  |  | 0 | 工艺插件：0   无 1   热处理 2：包装 3：冲压  4 钣金   5 CNC |
| 36 | PlugIn | numeric | (2,0) |  |  |  |  | 0 | 工艺插件：0   无 1   热处理 2：包装 3：冲压  4 钣金   5 CNC |
| 37 | CHECKOUTSTDQTY | numeric | (10,2) |  |  |  |  | 0 | 出站标准批量 |
| 38 | AUTOSPLITLOT | numeric | (2,0) |  |  |  |  | 0 | 出站是否自动分批：0：否 1：是 |
| 39 | AutoDispCallMtl | numeric | (1,0) |  |  |  |  | 0 | 派工自动叫料：0：否 1：是    #82338 20201120 朱煜轲 |
| 40 | NeedSelfCheckOK | numeric | (1,0) |  |  |  |  | 0 | 是否查核需做自检：0：否 1：是 勾选框勾选为是，未勾选为否 |
| 41 | SelfCheckRate | numeric | (1,0) |  |  |  |  | 0 | 自检频率：0：作业站+生产批;1：作业站+工单;2：作业站+产品;3：作业站+生产批+班别;4：作业站+生产批+日;5：作业站+生产批+设备;6：作业站+生产批+设备+日;7：作业站+生产批+设备+班别 |
| 42 | NeedEndCheckOK | numeric | (1,0) |  |  |  |  | 0 | 是否查核需做末检：0：否 1：是 勾选框勾选为是，未勾选为否 |
| 43 | EndCheckRate | numeric | (1,0) |  |  |  |  | 0 | 末检频率：0：作业站+生产批;1：作业站+工单;2：作业站+产品;3：作业站+生产批+班别;4：作业站+生产批+日;5：作业站+生产批+设备;6：作业站+生产批+设备+日;7：作业站+生产批+设备+班别 |
| 44 | DefaultOSReturnQCFlag | numeric | (1,0) |  |  |  |  | 0 | 回货检验默认：0：sMES检验 1：ERP检验 |
| 45 | DEFAULTOSOUTERPDOCTYPE | nvarchar | (50) |  |  |  | √ |  | 出货ERP单别默认：#82385 添加 |
| 46 | PANELSIDE | numeric | (1,0) |  |  |  |  | 0 | 板面：1：TOP面，2：BOT面 |
| 47 | STARTINGCHECKMODE | numeric | (1,0) |  |  |  | √ |  | 始业点检 |
| 48 | CONTROLPASS | nvarchar | (1) |  |  |  |  | '0' | 管控末道工序过站：1 管控；0 不管控 |
| 49 | NeedSN | numeric | (4,0) |  |  |  |  | 1 | 序列号管理设定：NeedSN=1 不带序列号界面 NeedSN in (2,3)  带序列号界面 |
| 50 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 51 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 52 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID：数据键值 |
| 53 | PQCCHECKTIME | numeric | (4,0) |  |  |  | √ |  | 巡检时间 |
| 1 | BRNO | nvarchar | (20) |  |  |  |  |  | 企业逻辑编号 |
| 2 | BRNAME | nvarchar | (50) |  |  |  |  |  | 企业逻辑名称 |
| 3 | INTERFACENAME | nvarchar | (50) |  |  |  | √ |  | 接口名称：接口名称下拉式选单数据，系统自动撷取winWIP.exe执行文件中的在线数据输入接口名称 |
| 4 | FUNCTIONNAME | nvarchar | (50) |  |  |  | √ |  | 函式名称：函式名称与接口名称仅可设定其中一项，“函式名称”下拉式选单数据，系统自动撷取tcWIP_IC.dll组件中的函式名称 |
| 5 | INTERFACEURL | nvarchar | (100) |  |  |  | √ |  | 接口网址：接口网址，用户输入远程执行URL，此数据在WEB Form使用时才需要设定 |
| 6 | RULETYPE | numeric | (1,0) |  |  |  | √ |  | 企业逻辑类型：0 System，系统提供，指系统预先设定好的企业逻辑。1 Customer，客制提供，指客户自行设定的企业逻辑 |
| 7 | RULEMETHOD | numeric | (1,0) |  |  |  | √ |  | 企业逻辑方法：0 Automatic，自动，无接口显示，系统自动执行此BR。1 Manual，手动，必须由用户输入适当信息。2 DT，数据收集，设定其剧本编号 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | DESCRIPTION | nvarchar | (255) |  |  |  | √ | 'N/A' | 备注 |
| 12 | KernelModule | nvarchar | (100) |  |  |  | √ |  | 企业逻辑对应之实体Dll文件名：企业逻辑对应之实体Dll文件名，应用于平版等装置过账使用之云端服务(MESws_Cloud) |
| 13 | KernelFunctionName | nvarchar | (100) |  |  |  | √ |  | 企业逻辑对应之函式名称：企业逻辑对应之函式名称，应用于平版等装置过账使用之云端服务(MESws_Cloud) |
| 14 | EXECUTIONFILE | nvarchar | (50) |  |  |  | √ |  | EXECUTIONFILE |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | FROMNODE | nvarchar | (20) | √ |  |  |  |  | 起始节点编号 |
| 3 | TONODE | nvarchar | (20) | √ |  |  |  |  | 目地节点编号 |
| 4 | LINKNAME | nvarchar | (20) | √ |  |  |  |  | 执行结果 |
| 5 | PHASENO | numeric | (2,0) |  |  |  |  |  | 阶段编号 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态 |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号：作业站编号 |
| 2 | EQUIPMENTTYPE | nvarchar | (50) | √ |  |  |  |  | 设备类别：设备类别 |
| 3 | DESCRIPTION | nvarchar | (255) |  |  |  | √ |  | 说明：说明 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 建立人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 建立日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 2 | ERRORNO | nvarchar | (20) | √ |  |  |  |  | 不良原因编号：进行不良原因的选择 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据状态：数据键值 |
| 9 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLQCREASONBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | OPGROUPNO | nvarchar | (20) | √ |  |  |  |  | 作业站群组编号 |
| 2 | OPGROUPNAME | nvarchar | (100) |  |  |  | √ |  | 作业站组名 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 6 | PSNO | nvarchar | (50) |  |  |  | √ |  | 区段编号 |
| 7 | OPGROUPORDER | numeric | (6,0) |  |  |  | √ | 0 | 作业站群组次序 |
| 8 | ERPNO | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | OPGROUPNO | nvarchar | (20) | √ |  |  |  |  | 作业站群组编号 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | OPROLEFLAG | numeric | (1,0) |  |  |  |  | 0 | 作业站角色：0：General(一般) 1：EntryOP(进入点) 2：ExitOP(离开点) |
| 4 | WEIGHTRATE | numeric | (5,2) |  |  |  |  | 0 | 权重率 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 10 | TBLOPGROUPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblRPTStatisticsCondition — 自定义报表统计基础配置（198 字段）
> 主键：REPORTID, ITEMNO, SUBSCRIPTIONID, SUBSCRIPTIONID, ITEMNO, SUBSCRIPTIONID, ITEMNO, TIMESTEPNO, JOBNO, JOBNO, PCSCOLLNO, PCSCOLLNO, OPNO, SUBOPSEQUENCE, EQUIPMENTNO, PCSCOLLNO, OPNO, SUBOPSEQUENCE, UNITNAME, EQUIPMENTNO, PRODUCTTYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | REPORTID | nvarchar | (50) | √ |  |  |  |  | 报表编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 统计属性顺序 |
| 3 | CONDFIELDTYPE | numeric | (2,0) |  |  |  |  |  | 统计方式 |
| 4 | CONDFIELD | nvarchar | (50) |  |  |  |  |  | 统计字段：统计用栏位(此处无别名) |
| 5 | CONDDESC | nvarchar | (50) |  |  |  | √ |  | 说明 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATETIME | datetime |  |  |  |  | √ |  | 创建时间 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | TBLRPTREPORTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SUBSCRIPTIONID | nvarchar | (50) | √ |  |  |  |  | 订阅编号 |
| 2 | SUBSCRIPTIONNAME | nvarchar | (255) |  |  |  |  |  | 订阅名称 |
| 3 | USERNO | nvarchar | (30) |  |  |  |  |  | 使用者编号 |
| 4 | REPORTID | nvarchar | (50) |  |  |  |  |  | 报表编号 |
| 5 | FILETYPE | nvarchar | (50) |  |  |  |  |  | 文件类型 |
| 6 | RUNFREQUENT | nvarchar | (12) |  |  |  |  |  | 运行频率 |
| 7 | RUNMIN | nvarchar | (2) |  |  |  | √ |  | 分钟 |
| 8 | RUNHOUR | nvarchar | (2) |  |  |  | √ |  | 小时 |
| 9 | RUNWEEK | nvarchar | (10) |  |  |  | √ |  | 周 |
| 10 | RUNDAY | nvarchar | (2) |  |  |  | √ |  | 日 |
| 11 | RUNMONTH | nvarchar | (2) |  |  |  | √ |  | 月 |
| 12 | RUNYEAR | nvarchar | (4) |  |  |  | √ |  | 年 |
| 13 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | LASTRUNTIME | datetime |  |  |  |  | √ |  | 最近运行时间 |
| 15 | NEXTRUNTIME | datetime |  |  |  |  | √ |  | 下次运行时间 |
| 16 | EMAILCC | nvarchar | (500) |  |  |  | √ |  | 电子邮件副本 |
| 17 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 19 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 20 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SUBSCRIPTIONID | nvarchar | (50) | √ |  |  |  |  | 订阅编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 项次 |
| 3 | CONDFIELD | nvarchar | (50) |  |  |  |  |  | 条件字段 |
| 4 | CONDDESC | nvarchar | (50) |  |  |  | √ |  | 字段说明 |
| 5 | CONDDATATYPE | numeric | (1,0) |  |  |  |  |  | 条件资料类型 |
| 6 | CONDOPERAND | nvarchar | (10) |  |  |  |  |  | 条件操作类型 |
| 7 | DEFAULTVALUE | nvarchar | (55) |  |  |  |  |  | 默认值 |
| 8 | INSERTNAME | nvarchar | (50) |  |  |  | √ |  | 建立者 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SUBSCRIPTIONID | nvarchar | (50) | √ |  |  |  |  | 订阅编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 项次 |
| 3 | CONDFIELD | nvarchar | (50) |  |  |  |  |  | 条件字段 |
| 4 | CONDDESC | nvarchar | (50) |  |  |  | √ |  | 字段说明 |
| 5 | DATETIMEPERIODTYPE | nvarchar | (20) |  |  |  |  |  | 日期时间周期类型 |
| 6 | FROMDAYS | numeric | (3,0) |  |  |  | √ | 0 | 起始日 |
| 7 | FROMTIME | nvarchar | (8) |  |  |  | √ |  | 起始时间 |
| 8 | TODAYS | numeric | (3,0) |  |  |  | √ | 0 | 结束日 |
| 9 | TOTIME | nvarchar | (8) |  |  |  | √ |  | 结束时间 |
| 10 | INSERTNAME | nvarchar | (50) |  |  |  | √ |  | 建立者 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 13 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 14 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | TIMESTEPNO | nvarchar | (20) | √ |  |  |  |  | 数据键值 |
| 2 | TIMESTEPNAME | nvarchar | (50) |  |  |  |  |  | 创建者 |
| 3 | FROMTIME | datetime |  |  |  |  |  |  | 数据创建人员 |
| 4 | TOTIME | datetime |  |  |  |  |  |  | 创建时间 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 数据创建时间 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | JOBNO | nvarchar | (25) | √ |  |  |  |  | 工作编号 |
| 2 | ENABLE | nvarchar | (5) |  |  |  | √ |  | 启用：True：启用  False：停用 |
| 3 | SERVERNAME | nvarchar | (50) |  |  |  | √ |  | 服务器名称 |
| 4 | EMAILADDRESS | nvarchar | (255) |  |  |  | √ |  | 电子邮件地址 |
| 5 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 6 | JOBNAME | nvarchar | (100) |  |  |  |  |  | 工作名称：CreateWOWorkReportData_TP：创建工单生产报工单数据 ReplicationDB：将现况事务数据转入报表数据库 DataArchiveByMO：依据工单封存资料 DataArchiveByDate：依据日期封存资料 DataDeleteByDate：依据日期删除资料 SubscriptionReport：订阅报表派送 StartSyncing ShareEQPTime ShareEMPTime MESToJDS_OPOutputDealyMsg MESToJDS_PreOPOutputMsg CreateWOWWorkReportData_T100 CreateWOWWorkReportData_EAI CreateWOWWorkReportData_EAI_Offline OEESummary CreateWOWWorkReportData_WF MESCallERPPRDMTLBasis MESCallERPVendorBasis MESCallERPMaterialVendorMAPBasis MESCallERPEquipmentBasis MESCallERPCustmerBasis MESCallERPInventoryBasis MESCallERPLocatorBasis MESCallERPDepartmentBasis MESCallERPDocumentTypeData MESCallERPShiftBasis MESCallERPOPBasis MESCallERPOPGroupBasis MESCallERPEquipmentProductivity MESCallERPAccessoryBasis MESCallERPUserBasis MESCallERPDeleteLogData AutomaticExpansion CleanLogs |
| 7 | LASTRUNTIME | datetime |  |  |  |  | √ |  | 最近运行时间 |
| 8 | RUNFREQUENT | nvarchar | (12) |  |  |  | √ |  | 执行频率：OnlyOnce：只执行一次 EveryYear：每年一次 EveryMonth：每月一次 EveryWeek：每周一次 EveryDay：每日一次 EveryHour：每小时一次 Every10Min：每10分钟一次 Every5Min：每5分钟一次 Every3Min：每3分钟一次 Every1Min：每1分钟一次 |
| 9 | RUNHOUR | nvarchar | (2) |  |  |  | √ | '0' | 小时 |
| 10 | RUNWEEK | nvarchar | (30) |  |  |  | √ |  | 周 |
| 11 | RUNDAY | nvarchar | (2) |  |  |  | √ | '1' | 日：1~31 & EM (EndOfMonth) |
| 12 | RUNMONTH | nvarchar | (2) |  |  |  | √ | '1' | 月 |
| 13 | RUNYEAR | nvarchar | (4) |  |  |  | √ | '1900' | 年 |
| 14 | PARAMETER01 | nvarchar | (100) |  |  |  | √ |  | 参数 01 |
| 15 | PARAMETER02 | nvarchar | (100) |  |  |  | √ |  | 参数 02 |
| 16 | PARAMETER03 | nvarchar | (100) |  |  |  | √ |  | 参数 03 |
| 17 | PARAMETER04 | nvarchar | (100) |  |  |  | √ |  | 参数 04 |
| 18 | PARAMETER05 | nvarchar | (100) |  |  |  | √ |  | 参数 05 |
| 19 | PARAMETER06 | nvarchar | (100) |  |  |  | √ |  | 参数 06 |
| 20 | PARAMETER07 | nvarchar | (100) |  |  |  | √ |  | 参数 07 |
| 21 | PARAMETER08 | nvarchar | (100) |  |  |  | √ |  | 参数 08 |
| 22 | PARAMETER09 | nvarchar | (100) |  |  |  | √ |  | 参数 09 |
| 23 | PARAMETER10 | nvarchar | (100) |  |  |  | √ |  | 参数 10 |
| 24 | RUNMIN | nvarchar | (2) |  |  |  | √ |  | 分 |
| 25 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 26 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 27 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 28 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 29 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 30 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 31 | TBLMSGMODELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | JOBNO | nvarchar | (25) |  |  |  | √ |  | 工作编号 |
| 3 | STATUS | nvarchar | (10) |  |  |  | √ |  | 状态：Success：成功 Fail：失败 |
| 4 | RETURNMSG | nvarchar | (4000) |  |  |  | √ |  | 回传讯息 |
| 5 | SERVERNAME | nvarchar | (127) |  |  |  | √ |  | 服务器名称 |
| 6 | STARTTIME | datetime |  |  |  |  | √ |  | 开始时间 |
| 7 | ENDTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 8 | RUNTIME | numeric | (20,0) |  |  |  | √ |  | 作业时间 |
| 9 | MEMO | nvarchar | (-1) |  |  |  | √ |  | 备注 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 15 | TBLMSGMODELBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | JOBNO | nvarchar | (25) | √ |  |  |  |  | 工作编号 |
| 2 | STATUS | nvarchar | (20) |  |  |  |  |  | 状态：Success：成功 Fail：失败 |
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
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | PCSCOLLNO | nvarchar | (50) | √ |  |  |  |  | 规则编号 |
| 3 | PCSCOLLNAME | nvarchar | (50) |  |  |  |  |  | 规则名称 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 规则说明 |
| 5 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PCSCOLLNO | nvarchar | (50) | √ |  |  |  |  | 规则编号 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序次序 |
| 4 | COLLECTTYPE | numeric | (1,0) |  |  |  |  |  | 收集类别：收集类别有三种 0：显示eSOP 1：刷成品序号 2：刷成品序号或部件序号 3：刷部件序号 (#74227 add bruce) 4 ? 刷成品序号(添加PCBA序号未预先产生在工位第一次收集) |
| 5 | AUTOCO | numeric | (1,0) |  |  |  |  |  | 自动出站：0：否 1：是 勾选框勾选为是，不勾选为否 |
| 6 | PRINTLABEL | numeric | (1,0) |  |  |  |  |  | 打印标签：0：否 1：是 勾选框勾选为是，不勾选为否 |
| 7 | LABELTYPE | nvarchar | (50) |  |  |  |  |  | 标签类型：可选择标签类型 |
| 8 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 9 | AREANO | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 10 | TIMECONTROL | numeric | (1,0) |  |  |  |  |  | 超时卡控：0：不启用1：权限放行2：强制卡控 |
| 11 | TCBEFORESUBOPSEQ | numeric | (4,0) |  |  |  | √ |  | 超时卡控-前工序 |
| 12 | TCTIMEINTERVAL | numeric | (12,4) |  |  |  | √ |  | 超时卡控-卡控时间 |
| 13 | TCUSERGROUP | nvarchar | (30) |  |  |  | √ |  | 超时卡控-放行人员群组 |
| 14 | TIMELIMIT | numeric | (1,0) |  |  |  |  |  | 限时卡控：0：不启用1：权限放行2：强制卡控 |
| 15 | TLBEFORESUBOPSEQ | numeric | (4,0) |  |  |  | √ |  | 限时卡控-前工序 |
| 16 | TLTIMEINTERVAL | numeric | (12,4) |  |  |  | √ |  | 限时卡控-卡控时间 |
| 17 | TLUSERGROUP | nvarchar | (30) |  |  |  | √ |  | 限时卡控-放行人员群组 |
| 18 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 19 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 20 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 21 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PCSCOLLNO | nvarchar | (50) | √ |  |  |  |  | 规则编号 |
| 2 | OPNO | nvarchar | (20) | √ |  |  |  |  | 作业站编号 |
| 3 | SUBOPSEQUENCE | numeric | (4,0) | √ |  |  |  |  | 工序次序 |
| 4 | UNITNAME | nvarchar | (50) | √ |  |  |  |  | 部件名称 |
| 5 | MATERIALTYPE | nvarchar | (50) |  |  |  |  |  | 物料类别 |
| 6 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号 |
| 7 | NEEDCOLLECT | numeric | (1,0) |  |  |  |  |  | 工位机部件序号 强制收集：1：是 0：否 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PCSCOLLNO | nvarchar | (50) |  |  |  |  |  | 规则编号 |
| 2 | PRODUCTTYPE | nvarchar | (50) | √ |  |  |  |  | 产品类别 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 2 | LOTNO | nvarchar | (50) |  |  |  |  |  | 生产批号 |
| 3 | PCSNO | nvarchar | (20) |  |  |  |  |  | 产品序号 |
| 4 | FROMOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 来源工序 |
| 5 | TOOPSEQUENCE | numeric | (4,0) |  |  |  |  |  | 目的工序 |
| 6 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号 |
| 7 | PRODUCTVERSION | nvarchar | (10) |  |  |  |  |  | 产品版本 |
| 8 | PRODUCTNAME | nvarchar | (50) |  |  |  |  |  | 产品名称 |
| 9 | MODIUSER | nvarchar | (50) |  |  |  |  |  | 修改人 |
| 10 | MODIDATE | datetime |  |  |  |  |  |  | 修改日期 |
| 11 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSlightColourBasis — 安灯颜色基础数据（12 字段）
> 主键：ID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (50) | √ |  |  |  |  | ID |
| 2 | SLightTypeNo | nvarchar | (50) |  |  |  |  |  | 安灯分类编号 |
| 3 | SLightState | nvarchar | (50) |  |  |  |  |  | 安灯现况状态：0-正常 1-安灯 2-任务接受 3-开始处理 4-处理完成 |
| 4 | SLightColour | nvarchar | (50) |  |  |  |  |  | 安灯颜色码：示例 #db4d3e |
| 5 | Enable | numeric | (1,0) |  |  |  |  |  | 是否启用：0-禁用 1-启用 |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSLightEQPState — 安灯设备现况表（26 字段）
> 主键：ID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (40) | √ |  |  |  |  | ID |
| 2 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 3 | SLightTypeNo | nvarchar | (100) |  |  |  |  |  | 安灯分类编号：来自tblSLightTypeBasis |
| 4 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 5 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 6 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 7 | MaterialNo | nvarchar | (50) |  |  |  | √ |  | 物料编号 |
| 8 | SLightReasonNo | nvarchar | (20) |  |  |  | √ |  | 原因编号：ex. 001：紧急事故, ABC：料件故障，来至 SLightReasonBasis |
| 9 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 10 | SLightState | numeric | (2,0) |  |  |  | √ |  | 安灯现况：1-安灯 2-任务接受 3-开始处理 4-处理完成 99-确认 |
| 11 | ResponseLevel | numeric | (1,0) |  |  |  | √ |  | 回应等级：1-一级回应 2-二级回应 3-三级回应 目前处于的回应等级 |
| 12 | Grade | numeric | (1,0) |  |  |  | √ |  | 紧急度：1 普通，2：中等，3：紧急 |
| 13 | AndonTime | datetime |  |  |  |  |  |  | 安灯时间 |
| 14 | Andoner | nvarchar | (30) |  |  |  | √ |  | 安灯人 |
| 15 | ReceiveTime | datetime |  |  |  |  | √ |  | 任务接受时间 |
| 16 | Receiver | nvarchar | (30) |  |  |  | √ |  | 接受任务人员编号 |
| 17 | StartTime | datetime |  |  |  |  | √ |  | 任务处理开始时间 |
| 18 | Starter | nvarchar | (30) |  |  |  | √ |  | 任务开始记录人 |
| 19 | FinishTime | datetime |  |  |  |  | √ |  | 任务处理结束时间 |
| 20 | Finisher | nvarchar | (30) |  |  |  | √ |  | 任务结束记录人 |
| 21 | ConfromTime | datetime |  |  |  |  | √ |  | 操作人员确认时间 |
| 22 | Confromer | nvarchar | (30) |  |  |  | √ |  | 确认正常记录人 |
| 23 | Measure | nvarchar | (50) |  |  |  | √ |  | 安灯处理对策 |
| 24 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 25 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSLightEQPStateLog — 安灯设备现况日志表（31 字段）
> 主键：ID
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (40) | √ |  |  |  |  | ID |
| 2 | SLightEQPStateId | nvarchar | (40) |  |  |  |  |  | 安灯设备现况ID：安灯结束-4 99状态会将数据转移到此表 |
| 3 | EquipmentNo | nvarchar | (50) |  |  |  |  |  | 设备编号 |
| 4 | SLightTypeNo | nvarchar | (100) |  |  |  |  |  | 安灯分类编号：来自tblSLightTypeBasis |
| 5 | AreaNo | nvarchar | (20) |  |  |  | √ |  | 区域编号 |
| 6 | LotNo | nvarchar | (50) |  |  |  | √ |  | 生产批号 |
| 7 | OPNo | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 8 | MaterialNo | nvarchar | (50) |  |  |  | √ |  | 物料编号 |
| 9 | SLightReasonNo | nvarchar | (20) |  |  |  | √ |  | 原因编号：ex.001：紧急事故, ABC：料件故障，来至SLightReasonBasis |
| 10 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 11 | SLightState | numeric | (2,0) |  |  |  | √ |  | 安灯现况：1-安灯；2-任务接受；3-开始处理；4-处理完成；99-确认 |
| 12 | ResponseLevel | numeric | (1,0) |  |  |  | √ |  | 回应等级：1-一级回应；2-二级回应；3-三级回应；目前处于的回应等级 |
| 13 | Grade | numeric | (1,0) |  |  |  | √ |  | 紧急度：1 普通，2：中等，3：紧急 |
| 14 | AndonTime | datetime |  |  |  |  |  |  | 安灯时间 |
| 15 | Andoner | nvarchar | (30) |  |  |  | √ |  | 安灯人 |
| 16 | ReceiveTime | datetime |  |  |  |  | √ |  | 任务接受时间 |
| 17 | Receiver | nvarchar | (30) |  |  |  | √ |  | 接受任务人员编号 |
| 18 | StartTime | datetime |  |  |  |  | √ |  | 任务处理开始时间 |
| 19 | Starter | nvarchar | (30) |  |  |  | √ |  | 任务开始记录人 |
| 20 | FinishTime | datetime |  |  |  |  | √ |  | 任务处理结束时间 |
| 21 | Finisher | nvarchar | (30) |  |  |  | √ |  | 任务结束记录人 |
| 22 | ConfromTime | datetime |  |  |  |  | √ |  | 操作人员确认时间 |
| 23 | Confromer | nvarchar | (30) |  |  |  | √ |  | 确认正常记录人 |
| 24 | Measure | nvarchar | (50) |  |  |  | √ |  | 安灯处理对策 |
| 25 | Evaluate | numeric | (1,0) |  |  |  |  | 0 | 评价：最终确认任务为处理人员打分1-5，若未打分为0 |
| 26 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 27 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 28 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 29 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 30 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 31 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSLightMeasureBasis — 安灯对策基础数据（22 字段）
> 主键：ID, SLightReasonNo, SLightTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ID | nvarchar | (50) | √ |  |  |  |  | ID |
| 2 | SLightTypeNo | nvarchar | (50) |  |  |  |  |  | 安灯分类编号 |
| 3 | SLightMeasureNo | nvarchar | (50) |  |  |  |  |  | 安灯对策编号 |
| 4 | SLightMeasureName | nvarchar | (50) |  |  |  |  |  | 安灯对策名称 |
| 5 | Enable | numeric | (1,0) |  |  |  |  |  | 是否启用：0-禁用 1-启用 |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SLightReasonNo | nvarchar | (20) | √ |  |  |  |  | 安灯原因编号 |
| 2 | REASONNAME | nvarchar | (100) |  |  |  | √ |  | 原因名称 |
| 3 | SLightTypeNo | nvarchar | (100) | √ |  |  |  |  | 安灯分类代号 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSLightReceiveLog — 安灯任务接受日志（11 字段）
> 主键：MSGNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MSGNo | nvarchar | (64) | √ |  |  |  |  | 讯息编号：guid，来自MSGDetail |
| 2 | MSGReceiveNo | nvarchar | (10) |  |  |  |  |  | 接受任务人员编号：记录接受安灯任务的人员 |
| 3 | CreateTime | datetime |  |  |  |  |  |  | 操作时间 |
| 4 | OperateType | numeric | (1,0) |  |  |  |  |  | 操作类型：1 任务接受 2：任务释放 |
| 5 | SLightEQPStateId | nvarchar | (40) |  |  |  | √ |  | 安灯设备现况ID：安灯设备现况ID |
| 6 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSLightState — 安灯现况表（17 字段）
> 主键：MSGNo, MSGCategoryNo, MSGEmployeeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | MSGNo | nvarchar | (64) | √ |  |  |  |  | 讯息编号：guid，来自MSGDetail |
| 2 | MSGCategoryNo | nvarchar | (64) | √ |  |  |  | 'N/A' | 分类编号：来至于CategoryManagers或CategoryEmployees |
| 3 | MSGEmployeeNo | nvarchar | (10) | √ |  |  |  | 'N/A' | 人员编号：来至于CategoryManagers或CategoryEmployees |
| 4 | SLightTypeNo | nvarchar | (100) |  |  |  | √ |  | 安灯分类代号：SLEquipment：机台, SLQuality：质量, SLMaterial：物料, SLProd：生产 后端显示代号时会做多国语转换。 来自MSGSendSLightType + MSGModelSend |
| 5 | SLightReasonNo | nvarchar | (20) |  |  |  | √ |  | 原因编号：ex. 001：紧急事故, ABC：料件故障，来至 SLightReasonBasis |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 7 | SLightState | numeric | (1,0) |  |  |  | √ |  | 灯号纪录现况：0：绿   灭, 1：红闪, 2：紫闪 Insert时，与安灯等级相同，随后以减一的方式循环 |
| 8 | SLightLevel | numeric | (1,0) |  |  |  | √ |  | 安灯等级：0：未启用安灯，1：无记录，2：需记录 |
| 9 | StartTime | datetime |  |  |  |  | √ |  | 接收时间：与ModelSend表中CreateDate相同 |
| 10 | ConfromTime | datetime |  |  |  |  | √ |  | 确认时间：红闪：确认时间＝结束时间，紫闪：确认时间 |
| 11 | FinishTime | datetime |  |  |  |  | √ |  | 结束时间：红闪：确认时间＝结束时间，紫闪：不写入 |
| 12 | MSGReceiveNo | nvarchar | (10) |  |  |  |  | 'N/A' | 接受任务人员编号：记录接受安灯任务的人员 |
| 13 | SLightEQPStateId | nvarchar | (40) |  |  |  | √ |  | 安灯设备现况ID：安灯设备现况ID |
| 14 | ResponseLevel | numeric | (1,0) |  |  |  | √ | 0 | 回应等级：安灯模块新优化数值为1 2 3 原有的插入为0 |
| 15 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 16 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSLightTypeBasis — 安灯分类基础数据（123 字段）
> 主键：SLightTypeNo, AREANO, AREANO, INVENTORYNO, BASEAREANO, PARENTAREANO, CHILDAREANO, BASEAREANO, OBJECTNO, AREANO, LOCATIONCODE, FACTORYNO, PDLINENO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SLightTypeNo | nvarchar | (50) | √ |  |  |  |  | 安灯分类编号 |
| 2 | SLightTypeName | nvarchar | (100) |  |  |  |  |  | 安灯分类名称 |
| 3 | SysType | numeric | (5,0) |  |  |  |  |  | 系统类型：1-系统 2-定制 |
| 4 | Enable | numeric | (5,0) |  |  |  |  | 1 | 是否启用 |
| 5 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | WriteInfo | numeric | (5,0) |  |  |  |  | 1 | 安灯是否录入信息：0-直接安灯 1-录入相关信息后安灯 |
| 9 | ResponseLevel | numeric | (5,0) |  |  |  |  | 1 | 回应层级：1-开启一级回应 2-开启二级回应 3-开启三级回应 |
| 10 | ReceiveProject | numeric | (5,0) |  |  |  |  | 0 | 是否必须接受任务：0-否 1-是 回应人员是否必须接受任务后才能开始处理安灯任务 |
| 11 | CompareRcAndPc | numeric | (5,0) |  |  |  |  | 0 | 处理人与接收人是否必须一致：0-否 1-是 任务处理人与任务接受人必须为同一人 |
| 12 | ComparePcIn | numeric | (5,0) |  |  |  |  | 0 | 处理人范围：0-否 1-是 处理人是否必须为安灯信息接收人之一 |
| 13 | WriteStart | numeric | (5,0) |  |  |  |  | 0 | 记录处理开始时间：0-否 1-是 是否处理任务开始时间 |
| 14 | ComparePcAndFs | numeric | (5,0) |  |  |  |  | 1 | 完成人范围：0-否 1-是 任务处理完成人是否与任务开始处理人一致 |
| 15 | WriteConfirm | numeric | (5,0) |  |  |  |  | 1 | 是否确认完成：0-否 1-是 是否需要操作人员确认安灯结束 |
| 16 | CompareCrAndCf | numeric | (5,0) |  |  |  |  | 0 | 确认人员范围：0-否 1-是 确认安灯结束人员是否必须为安灯发起人 |
| 17 | ChangeEQPStatus | numeric | (5,0) |  |  |  |  | 0 | 是否设备稼动联动：0-否 1-是 安灯时是否同步改变设备状态 |
| 18 | EQPStatus | numeric | (2,0) |  |  |  | √ |  | 设定设备状态：tblEMSEquipmentState表EquipmentState字段    闲置  0加工  1故障  2维修  3保养  4暂停  5设置  6 关机  7                   ChangeEQPStatus-1时此字段才有效 |
| 19 | EQPProcessStatus | numeric | (2,0) |  |  |  | √ |  | 开始处理设备状态：tblEMSEquipmentState表EquipmentState字段     闲置0 加工1 故障2 维修3 保养4 暂停5 设置6 关机7 ChangeEQPStatus=1时此字段才有效 用于安灯开始处理后设备状态联动修改 |
| 20 | EQPStatusBack | numeric | (5,0) |  |  |  |  | 0 | 设备状态是否还原：0-否 1-是 安灯处理流程结束后是否自动将设备状态还原至安灯前 ChangeEQPStatus-1时此字段才有效 |
| 21 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 数据状态：数据目前状态 |
| 22 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 23 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 24 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | AREANO | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 2 | AREANAME | nvarchar | (50) |  |  |  |  |  | 区域名称 |
| 3 | AREATYPE | numeric | (1,0) |  |  |  |  | 0 | 区域类别：分为下述三种类型，目前使用于 作业站-资源 设置时的筛选条件 0 OP Area(一般区域型之作业区) 1 Production Line(生产线类型之作业区) 2 Other(其他) |
| 4 | AREACLASS | numeric | (1,0) |  |  |  |  | 0 | 区域分类：区域分类 0 General Class(一般区域) 1 Basis Class(基底区域) |
| 5 | BASEAREANO | nvarchar | (20) |  |  |  | √ |  | 基底区域编号 |
| 6 | FACTORYNO | nvarchar | (20) |  |  |  |  |  | 工厂编号 |
| 7 | DEPARTMENTNO | nvarchar | (20) |  |  |  | √ |  | 部门编号 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | AREACOMPOSE | numeric | (1,0) |  |  |  |  | 0 | 区域设备配置：0 Functional (指Job Shop形式工厂设备配置) 1 Line ( 指接续式生产加工模式) |
| 13 | DISPATCHBYMACHINE_C | numeric | (1,0) |  |  |  |  | 0 | DISPATCHBYMACHINE_C |
| 14 | CALENDARID | nvarchar | (20) |  |  |  | √ |  | 行事历编号 |
| 15 | WIPEQPCheckMode | nvarchar | (2) |  |  |  |  | '1' | 报工设备状态检查：1：不检查  2：检查 |
| 16 | SMTAREATYPE | numeric | (2,0) |  |  |  |  | 0 | 生产线产线别：0  未指定 1 SMT线 2 测试线 3 DIP线 4 组装线 5 包装线 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | BACKGROUNDIMAGE | varbinary | (-1) |  |  |  | √ |  | 基底区域背景：基底区域背景图文档信息 |
| 1 | AREANO | nvarchar | (50) | √ |  |  |  |  | 区域 |
| 2 | INVENTORYNO | nvarchar | (50) | √ |  |  |  |  | 仓库编号 |
| 3 | BASEAREANO | nvarchar | (50) |  |  |  |  |  | 基底区域 |
| 4 | DEFAULTINV | numeric | (1,0) |  |  |  |  | 0 | 预设仓库 |
| 5 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 1 | BASEAREANO | nvarchar | (50) | √ |  |  |  |  | 基底区域编号 |
| 2 | PARENTAREANO | nvarchar | (50) | √ |  |  |  |  | 父区域编号 |
| 3 | CHILDAREANO | nvarchar | (50) | √ |  |  |  |  | 子区域编号 |
| 4 | PARENTAREATYPE | numeric | (11,0) |  |  |  |  |  | 父区域类型 |
| 5 | CHILDAREATYPE | numeric | (11,0) |  |  |  |  |  | 子区域类型 |
| 6 | TOPPDLINEAREANO | nvarchar | (50) |  |  |  | √ |  | 生产线别区域编号 |
| 7 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 1 | BASEAREANO | nvarchar | (50) | √ |  |  |  |  | 基底区域编号 |
| 2 | CONTAINAREANO | nvarchar | (50) |  |  |  |  |  | 区域编号：对象所属之区域编号，若有多层区域，指的为最内层区域编号。 |
| 3 | OBJECTNO | nvarchar | (50) | √ |  |  |  |  | 对象编号：对象编号 |
| 4 | OBJECTTYPE | numeric | (1,0) |  |  |  |  |  | 对象类型：对象类型 0：Area，区域对象 1：INV，线边仓库房对象 2：EQP，设备编号对象 4：EQPGroup，设备群组对象 |
| 5 | OBJECTTEXT | nvarchar | (50) |  |  |  |  |  | 对象显示文本：对象显示文本 |
| 6 | OBJECTX | numeric | (11,0) |  |  |  |  |  | 对象X轴位置：对象X轴位置 |
| 7 | OBJECTY | numeric | (11,0) |  |  |  |  |  | 对象Y轴位置：对象Y轴位置 |
| 8 | OBJECTLENGTH | numeric | (11,0) |  |  |  |  |  | 对象长度：对象长度 |
| 9 | OBJECTWIDTH | numeric | (11,0) |  |  |  |  |  | 对象宽度：对象宽度 |
| 10 | OBJECTCOLOR | numeric | (11,0) |  |  |  |  |  | 对象颜色：对象颜色 |
| 11 | OBJECTSEQUENCE | numeric | (11,0) |  |  |  | √ |  | 对象次序 |
| 12 | OBJECTAREATYPE | numeric | (11,0) |  |  |  | √ |  | 对象区域类别：对象区域类别定义0 离散1 产线 |
| 13 | BORDERCOLOR | numeric | (11,0) |  |  |  | √ |  | 边框颜色 |
| 14 | BORDERSTYLE | numeric | (1,0) |  |  |  | √ |  | 边框样式 |
| 15 | TEXTCOLOR | numeric | (11,0) |  |  |  | √ |  | 文本颜色 |
| 16 | OBJECTSQUENCE | numeric | (11,0) |  |  |  | √ |  |  |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 22 | TBLOPAREAGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 23 | TBLSMDAREABASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 2 | AREANO | nvarchar | (20) | √ |  |  |  |  | 区域编号 |
| 3 | LOCATIONCODE | nvarchar | (20) | √ |  |  |  |  | 位置编号 |
| 4 | LOCATIONNAME | nvarchar | (50) |  |  |  |  |  | 位置名称 |
| 5 | ADMINUSERNO | nvarchar | (30) |  |  |  | √ |  | 负责人 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 7 | REVISOR | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FACTORYNO | nvarchar | (20) | √ |  |  |  |  | 工厂编号 |
| 2 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | FABCODE | nvarchar | (30) |  |  |  | √ |  | FAB编号 |
| 7 | FactoryName | nvarchar | (50) |  |  |  | √ |  | 工厂名称 |
| 8 | PRIVNOSTATE | nvarchar | (1) |  |  |  |  | '1' | 我的最爱：#46732 我的最爱控制参数 #2.1.0版，修改为系统参数控制，故此栏位已不使用 |
| 9 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PDLINENO | nvarchar | (50) | √ |  |  |  |  | 生产线编号 |
| 2 | PDLINENAME | nvarchar | (50) |  |  |  |  |  | 生产线名称 |
| 3 | PDLINESTATUS | numeric | (1,0) |  |  |  |  | 1 | 生产线状态 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 描述 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSPCQCForm — 检验单主表（530 字段）
> 主键：SITENO, QCformTYPE, QCFORMNO, QCformTYPE, QCFORMNO, PCSNO, SITENO, QCformTYPE, QCFORMNO, QCITEMNO, SITENO, QCFORMTYPE, QCFORMNO, QCITEMNO, ATTACHNAME, QCFORMNO, QCMERGEFORMNO, QCFORMNO, QCSPLITFORMNO, SPCSERIAL, SERIALNO, SPCSERIAL, SERIALNO, SPCSERIAL, SPCSERIAL, SPCSERIAL, SPCID, SPCSERIAL, SPCSERIAL, SPCID, SERIALNO, VIOLATIONID, BINNO, CAPTION, GUID, PROD_NAME, ELEMENTNO, TransID, ERP_NAME, MASTERNO, MASTERTYPE, EQUIPMENTNO, MASTERNO, MASTERTYPE, OBJECTNO, OBJECTTYPE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SITENO | nvarchar | (50) | √ |  |  |  |  | 公司别 |
| 2 | QCformTYPE | nvarchar | (2) | √ |  |  |  |  | 检验单类别：1：IQC  2：PQC  3：FQC  4：OQC |
| 3 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 4 | ITEMNO | nvarchar | (4000) |  |  |  | √ |  | 品号 |
| 5 | ITEMTYPE | numeric | (1,0) |  |  |  | √ |  | 品号类型：0：产品  1：物料 |
| 6 | SourceType | numeric | (1,0) |  |  |  | √ |  | 资料来源：1：一般  2：托外  3：手开 |
| 7 | VENDORNO | nvarchar | (20) |  |  |  | √ |  | 供应商编号 |
| 8 | ORIVENDOR | nvarchar | (4000) |  |  |  | √ |  | 原厂制造商 |
| 9 | ORIVENLOT | nvarchar | (4000) |  |  |  | √ |  | 原厂批号 |
| 10 | ITEMLOTNO | nvarchar | (4000) |  |  |  | √ |  | 料批 |
| 11 | INSPDOCLINK | nvarchar | (100) |  |  |  | √ |  | 检验报告书路径 |
| 12 | QTY | numeric | (14,6) |  |  |  | √ |  | 数量 |
| 13 | ACCEPTQTY | numeric | (14,6) |  |  |  | √ |  | 验收数量 |
| 14 | REJECTQTY | numeric | (14,6) |  |  |  | √ |  | 验退数量 |
| 15 | REWORKQTY | numeric | (14,6) |  |  |  | √ |  | 重工数量 |
| 16 | SCRAPQTY | numeric | (14,6) |  |  |  | √ |  | 损坏数量 |
| 17 | UNKNOWQTY | numeric | (14,6) |  |  |  | √ |  | 未知数量 |
| 18 | SURPLUSQTY | numeric | (14,6) |  |  |  | √ |  | 剩余数量 |
| 19 | MONO | nvarchar | (4000) |  |  |  | √ |  | 工单编号 |
| 20 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 21 | CUSTOMERNO | nvarchar | (4000) |  |  |  | √ |  | 客户编号 |
| 22 | RONO | nvarchar | (25) |  |  |  | √ |  | 订单编号 |
| 23 | INSPTIME | datetime |  |  |  |  | √ |  | 检验时间 |
| 24 | EMPLOYEENO | nvarchar | (10) |  |  |  | √ |  | 员工编号：检验人员 |
| 25 | STATUS | numeric | (1,0) |  |  |  | √ |  | 状态：-1：未确认 0：待验 1：暂不判定 2：合格 3：不良 4：特采 5：检验中   9：作废  6：h5已检验    20220215 add by KunYuan for #0107287 |
| 26 | DEFAULTEMPLOYEENO1 | nvarchar | (10) |  |  |  | √ |  | 检验人员1 |
| 27 | DEFAULTEMPLOYEENO2 | nvarchar | (10) |  |  |  | √ |  | 检验人员2 |
| 28 | DEFAULTEMPLOYEENO3 | nvarchar | (10) |  |  |  | √ |  | 检验人员3 |
| 29 | EMERGENCY | nvarchar | (20) |  |  |  | √ |  | 紧急：Y：紧急  N：不紧急 |
| 30 | INVENTORYNO | nvarchar | (20) |  |  |  | √ |  | 仓库编号 |
| 31 | PLANINSPTIME | datetime |  |  |  |  | √ |  | 预计检验日 |
| 32 | UNIT | nvarchar | (30) |  |  |  | √ |  | 单位 |
| 33 | QCCATEGORY | nvarchar | (4000) |  |  |  | √ |  | 品管类别 |
| 34 | REFFORMNO | nvarchar | (4000) |  |  |  | √ |  | 参考单号 |
| 35 | SORCETYPE | nvarchar | (2) |  |  |  | √ |  | 来源类别 |
| 36 | INSPDESCRIPTION | nvarchar | (200) |  |  |  | √ |  | 检验注记 |
| 37 | ERFNO | nvarchar | (20) |  |  |  | √ |  | 异常单编号 |
| 38 | EXPORTSTATUS | nvarchar | (2) |  |  |  | √ |  | 汇出状态：0：未抛转  1：已验未抛转  2：已抛转 |
| 39 | EXPORTTIME | datetime |  |  |  |  | √ |  | 汇出时间 |
| 40 | TRANSORDERNO | nvarchar | (4000) |  |  |  | √ |  | QCI.TBLSPCQCFORM.Column.TRANSORDERNO.displayText |
| 41 | OPSEQUENCE | nvarchar | (4000) |  |  |  | √ |  | 工序 |
| 42 | AREANO | nvarchar | (4000) |  |  |  | √ |  | 区域编号 |
| 43 | EQUIPMENTNO | nvarchar | (4000) |  |  |  | √ |  | 设备编号 |
| 44 | OPERATOR | nvarchar | (10) |  |  |  | √ |  | 作业人员 |
| 45 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 46 | SPEC | nvarchar | (255) |  |  |  | √ |  | 规格 |
| 47 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 48 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 49 | NeedResultCallBack | numeric | (1,0) |  |  |  | √ |  | 是否回抛检验单结果：0：否 1：是 |
| 50 | OPGROUPNO | nvarchar | (4000) |  |  |  | √ |  | 作业站群组编号 |
| 51 | QCLOTNO | nvarchar | (100) |  |  |  | √ |  | 检验批号 |
| 52 | INSPTYPE | nvarchar | (10) |  |  |  | √ |  | 检验类型：0：未指定  1：出站检验   2：首检  3：巡检  4：工位检 5：成品检验(FQC) 6：在库检验(WQC) |
| 53 | SCRAPREASON | nvarchar | (500) |  |  |  | √ |  | 损坏原因 |
| 54 | REJECTREASON | nvarchar | (500) |  |  |  | √ |  | 验退原因 |
| 55 | ARTICLENO | nvarchar | (4000) |  |  |  | √ |  | 货号 |
| 56 | PLOTNO | nvarchar | (100) |  |  |  | √ |  | 生产批号 |
| 57 | OSNO | nvarchar | (4000) |  |  |  | √ |  | 外包单编号 |
| 58 | FACTORTEMPVALUE | nvarchar | (4000) |  |  |  | √ |  | 因子暂存值 |
| 59 | FACTOR1 | nvarchar | (4000) |  |  |  | √ |  | 因子1 |
| 60 | FACTOR2 | nvarchar | (4000) |  |  |  | √ |  | 因子2 |
| 61 | ParentLot | nvarchar | (20) |  |  |  | √ |  | 母批：Y：是  N：否 |
| 62 | PDLineNo | nvarchar | (4000) |  |  |  | √ |  | 生产线编号 |
| 63 | PositionNo | nvarchar | (4000) |  |  |  | √ |  | 工位编号 |
| 64 | SSONO | nvarchar | (4000) |  |  |  | √ |  | 销货单编号 |
| 65 | ERPItemNo | nvarchar | (4000) |  |  |  | √ |  | ERP品号 |
| 66 | ERPNO | nvarchar | (30) |  |  |  | √ |  | ERP单号 |
| 67 | LOCATOR | nvarchar | (10) |  |  |  | √ |  | 储位 |
| 68 | ERPSourceNo | nvarchar | (4000) |  |  |  | √ |  | ERP来源单单号：IQC为收货单号；PQC FQC OQC则依各ERP对应单据而定 |
| 69 | ERPSourceSeq | nvarchar | (10) |  |  |  | √ |  | ERP来源单项次 |
| 70 | USEPCSNO | numeric | (1,0) |  |  |  |  | 0 | 有串行号：0 否 1 是 |
| 71 | PackFrom | nvarchar | (255) |  |  |  | √ |  | 起始箱号 |
| 72 | PackEnd | nvarchar | (255) |  |  |  | √ |  | 终止箱号 |
| 73 | STOCKINLOTNO | nvarchar | (4000) |  |  |  | √ |  | 入库批号 |
| 74 | QCING | numeric | (1,0) |  |  |  | √ | 0 | 检验数据填写进行中：0：否、1：是 |
| 75 | HOLDDESCRIPTION | nvarchar | (2000) |  |  |  | √ |  | 异常明细 |
| 76 | ERPSOURCENOID | nvarchar | (20) |  |  |  | √ |  | 单头ID |
| 77 | ERPSOURCESEQID | nvarchar | (20) |  |  |  | √ |  | 单身ID |
| 78 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 79 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 80 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间 |
| 81 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SameITEMNO | nvarchar | (10) |  |  |  | √ |  |  |
| 2 | SameSIP | nvarchar | (10) |  |  |  | √ |  | 相同检验标准：0：IQC、1：PQC、2：FQC、3：OQC |
| 3 | SameORIVENLOT | numeric | (1,0) |  |  |  |  | 0 | 相同原厂批号：0：不勾选、1：勾选 |
| 4 | SamePLOTNO | numeric | (1,0) |  |  |  |  | 0 | 相同生产批号：0：不勾选、1：勾选 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCformTYPE | nvarchar | (2) | √ |  |  |  |  | 检验单类别：1：IQC  2：PQC  3：FQC  4：OQC |
| 2 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 3 | PCSNO | nvarchar | (50) | √ |  |  |  |  | 序列号 |
| 4 | Sample | nvarchar | (1) |  |  |  |  |  | 是否为有检验数据的样本：Y：是  N：否 |
| 5 | Createtime | datetime |  |  |  |  | √ |  | 创建时间 |
| 6 | Updatetime | datetime |  |  |  |  | √ |  | 修改时间 |
| 7 | Creator | nvarchar | (30) |  |  |  | √ |  |  |
| 8 | Updateuser | nvarchar | (4000) |  |  |  | √ |  | 修改人 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 11 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 12 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SITENO | nvarchar | (50) | √ |  |  |  |  | 公司别 |
| 2 | QCformTYPE | nvarchar | (2) | √ |  |  |  |  | 检验单类别：1：IQC  2：PQC  3：FQC  4：OQC |
| 3 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 4 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 5 | QCITEMNAME | nvarchar | (4000) |  |  |  | √ |  | 品管项目名称 |
| 6 | QCITEMTYPE | numeric | (1,0) |  |  |  |  |  | 品管项目类别：0：计数  1：计量 |
| 7 | STATUS | numeric | (1,0) |  |  |  |  |  | 状态：0：未验  1：已验 |
| 8 | RESULT | numeric | (1,0) |  |  |  | √ |  | 结果：0：合格  1：不合格 计数品管项目, (0：合格 1：提示 3：异常 4：警告) (与 tblSPCAttbasisLog 的 Result 栏位值相同) 计量品管项目, (0 合格 1 异常 3 警告 4 提示) (与 tblSPCVarfactorLog 的 Result 栏位值相同) |
| 9 | SPCSERIAL | nvarchar | (4000) |  |  |  | √ |  | 检验序号 |
| 10 | QCTEMPVALUE | nvarchar | (4000) |  |  |  | √ |  | 暂存值 |
| 11 | Revisor | nvarchar | (30) |  |  |  | √ |  | 修改人 |
| 12 | ReviseDate | datetime |  |  |  |  | √ |  | 修改日 |
| 13 | INSPECTOR | nvarchar | (10) |  |  |  | √ |  | 检验人员：统计品管画面中挑选检验人员,若未挑选系统填为登录者 |
| 14 | PCSTEMPVALUE | varchar | (-1) |  |  |  | √ |  | 串行号暂存数据 |
| 15 | PLANNO | nvarchar | (100) |  |  |  | √ |  | 计划编号 |
| 16 | INSPECTIONTOOLS | nvarchar | (4000) |  |  |  | √ |  | 检验工具 |
| 17 | EXECUTEORDER | numeric | (6,0) |  |  |  | √ |  | 执行顺序 |
| 18 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 20 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 21 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 22 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 23 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SITENO | nvarchar | (50) | √ |  |  |  |  | 公司别 |
| 2 | QCFORMTYPE | nvarchar | (2) | √ |  |  |  |  | 检验单类别：1：IQC  2：PQC  3：FQC  4：OQC |
| 3 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 4 | QCITEMNO | nvarchar | (25) | √ |  |  |  |  | 品管项目编号 |
| 5 | ATTACHNAME | nvarchar | (50) | √ |  |  |  |  | 附件名称 |
| 6 | ATTACHBODY | varbinary | (-1) |  |  |  | √ |  | 附件内容 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 2 | QCMERGEFORMNO | nvarchar | (30) | √ |  |  |  |  | 合并单号 |
| 3 | QTY | numeric | (14,6) |  |  |  | √ |  | 合并数量 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCFORMNO | nvarchar | (30) | √ |  |  |  |  | 检验单号 |
| 2 | QCSPLITFORMNO | nvarchar | (30) | √ |  |  |  |  | 合并单号 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 5 | ERFMsg | nvarchar | (-1) |  |  |  | √ |  | 异常讯息 |
| 6 | ERFExecuteSPCSerial | nvarchar | (4000) |  |  |  | √ |  | 异常讯息SPC序号 |
| 7 | ERFMCassSet | nvarchar | (4000) |  |  |  | √ |  | 异常主分类 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 用户编号 |
| 2 | USERNO | nvarchar | (30) |  |  |  |  |  | 品管项目编号 |
| 3 | RECORDDATE | datetime |  |  |  |  |  |  | 发生日期 |
| 4 | MO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 5 | PRODUCT | nvarchar | (50) |  |  |  | √ | '*' |  |
| 6 | QCCATEGORY_PRD | nvarchar | (50) |  |  |  | √ | '*' |  |
| 7 | MATERIAL | nvarchar | (50) |  |  |  | √ | '*' |  |
| 8 | QCCATEGORY_MTL | nvarchar | (50) |  |  |  | √ | '*' |  |
| 9 | MTLVENDOR | nvarchar | (50) |  |  |  | √ | '*' |  |
| 10 | EMPLOYEE | nvarchar | (61) |  |  |  | √ | '*' |  |
| 11 | CUSTOMER | nvarchar | (50) |  |  |  | √ | '*' |  |
| 12 | OP | nvarchar | (61) |  |  |  | √ | '*' |  |
| 13 | EQUIPMENT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 14 | INVENTORYNO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 15 | FACTOR1 | nvarchar | (50) |  |  |  | √ | '*' |  |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 19 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 20 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | FACTORSERIAL | nvarchar | (4000) |  |  |  | √ |  | 因子序号 |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | SERIALNO | numeric | (5,0) | √ |  |  |  |  | 序号 |
| 5 | TESTVALUE | numeric | (38,20) |  |  |  |  |  | 量测值 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 8 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 9 | COMPONENTNO | nvarchar | (4000) |  |  |  | √ |  | 组件编号 |
| 10 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 11 | X | nvarchar | (10) |  |  |  | √ |  | 量测值X位置 |
| 12 | Y | nvarchar | (10) |  |  |  | √ |  | 量测值Y位置 |
| 13 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | FACTORSERIAL | nvarchar | (4000) |  |  |  | √ |  | 因子序号 |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | SERIALNO | numeric | (5,0) | √ |  |  |  |  | 序号 |
| 5 | TESTVALUE | numeric | (38,20) |  |  |  | √ |  | 量测值 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 8 | MEMO | nvarchar | (255) |  |  |  | √ |  | 备注 |
| 9 | COMPONENTNO | nvarchar | (4000) |  |  |  | √ |  | 组件编号 |
| 10 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 11 | X | nvarchar | (10) |  |  |  | √ |  | 量测值X位置 |
| 12 | Y | nvarchar | (10) |  |  |  | √ |  | 量测值Y位置 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 15 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 16 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 17 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | FACTORSERIAL | nvarchar | (4000) |  |  |  | √ |  | 因子序号 |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | LOTNO | nvarchar | (4000) |  |  |  | √ |  | 生产批号 |
| 5 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 6 | RETESTLOTNO | nvarchar | (55) |  |  |  | √ |  | Retest Lot No |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | RESULT | numeric | (1,0) |  |  |  | √ | 0 | 结果：0 合格 1 异常 3 警告 4 提示,  （需注意与计数不同） |
| 10 | ERFNO | nvarchar | (20) |  |  |  | √ |  | 异常单编号 |
| 11 | EXCLUDED | numeric | (1,0) |  |  |  | √ | 0 | 排除 |
| 12 | GROUPNO | nvarchar | (25) |  |  |  | √ |  | 群组编号 |
| 13 | GSPCSERIAL | nvarchar | (4000) |  |  |  | √ |  | Gspc Serial |
| 14 | SHORTRUNSERIAL | nvarchar | (4000) |  |  |  | √ |  | Short Run Serial |
| 15 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 16 | MEMO | nvarchar | (300) |  |  |  | √ |  | 备注 |
| 17 | MEMOCOLOR | numeric | (2,0) |  |  |  | √ | 0 | 备注颜色 |
| 18 | MO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 19 | PRODUCT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 20 | QCCATEGORY_PRD | nvarchar | (61) |  |  |  | √ | '*' |  |
| 21 | OP | nvarchar | (61) |  |  |  | √ | '*' |  |
| 22 | MATERIAL | nvarchar | (61) |  |  |  | √ | '*' |  |
| 23 | QCCATEGORY_MTL | nvarchar | (61) |  |  |  | √ | '*' |  |
| 24 | MTLVENDOR | nvarchar | (61) |  |  |  | √ | '*' |  |
| 25 | EMPLOYEE | nvarchar | (61) |  |  |  | √ | '*' |  |
| 26 | CUSTOMER | nvarchar | (61) |  |  |  | √ | '*' |  |
| 27 | EQUIPMENT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 28 | INVENTORYNO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 29 | FACTOR1 | nvarchar | (61) |  |  |  | √ | '*' |  |
| 30 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 31 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 33 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | FACTORSERIAL | nvarchar | (4000) |  |  |  | √ |  | 因子序号 |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  |  |  | 品管项目编号 |
| 4 | LOTNO | nvarchar | (4000) |  |  |  | √ |  | 生产批号 |
| 5 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批序号 |
| 6 | RETESTLOTNO | nvarchar | (55) |  |  |  | √ |  | Retest Lot No |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | RESULT | numeric | (1,0) |  |  |  | √ | 0 | 结果：0 合格 1 异常 3 警告 4 提示,  （需注意与计数不同） |
| 10 | ERFNO | nvarchar | (20) |  |  |  | √ |  | 异常单编号 |
| 11 | EXCLUDED | numeric | (1,0) |  |  |  | √ | 0 | 排除 |
| 12 | GROUPNO | nvarchar | (25) |  |  |  | √ |  | 群组编号 |
| 13 | GSPCSERIAL | nvarchar | (4000) |  |  |  | √ |  | Gspc Serial |
| 14 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 15 | SHORTRUNSERIAL | nvarchar | (50) |  |  |  | √ |  | Short Run Serial |
| 16 | MEMO | nvarchar | (300) |  |  |  | √ |  | 备注 |
| 17 | MEMOCOLOR | numeric | (2,0) |  |  |  | √ | 0 | 备注颜色 |
| 18 | MO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 19 | PRODUCT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 20 | QCCATEGORY_PRD | nvarchar | (61) |  |  |  | √ | '*' |  |
| 21 | MATERIAL | nvarchar | (61) |  |  |  | √ | '*' |  |
| 22 | QCCATEGORY_MTL | nvarchar | (61) |  |  |  | √ | '*' |  |
| 23 | MTLVENDOR | nvarchar | (61) |  |  |  | √ | '*' |  |
| 24 | EMPLOYEE | nvarchar | (61) |  |  |  | √ | '*' |  |
| 25 | CUSTOMER | nvarchar | (61) |  |  |  | √ | '*' |  |
| 26 | OP | nvarchar | (61) |  |  |  | √ | '*' |  |
| 27 | EQUIPMENT | nvarchar | (61) |  |  |  | √ | '*' |  |
| 28 | INVENTORYNO | nvarchar | (61) |  |  |  | √ | '*' |  |
| 29 | FACTOR1 | nvarchar | (61) |  |  |  | √ | '*' |  |
| 30 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 31 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 32 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 33 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | SPCID | nvarchar | (10) | √ |  |  |  |  | 管制图代码：0：Trend Chart 1：Xbar 2：Xbar-R 3：Xbar-S 4：X-Rm |
| 3 | US | nvarchar | (15) |  |  |  | √ |  | 规格上限 |
| 4 | LS | nvarchar | (15) |  |  |  | √ |  | 规格下限 |
| 5 | UCL | nvarchar | (15) |  |  |  | √ |  | 管制上限 |
| 6 | LCL | nvarchar | (15) |  |  |  | √ |  | 管制下限 |
| 7 | CL | nvarchar | (15) |  |  |  | √ |  | 管制中心 |
| 8 | TARGET | nvarchar | (10) |  |  |  | √ |  | 目标 |
| 9 | CPKGOAL | nvarchar | (10) |  |  |  | √ |  | CPK目标值 |
| 10 | CS | nvarchar | (15) |  |  |  | √ |  | 规格中心值 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | FACTORSERIAL | nvarchar | (4000) |  |  |  | √ |  | 因子序号 |
| 3 | QCITEMNO | nvarchar | (25) |  |  |  | √ |  | 品管项目编号 |
| 4 | SAMPLESIZE | numeric | (5,0) |  |  |  | √ |  | 样本数 |
| 5 | MEANVALUE | numeric | (38,20) |  |  |  | √ |  | 平均值 |
| 6 | MAXVALUE | numeric | (38,20) |  |  |  | √ |  | 最大值 |
| 7 | MINVALUE | numeric | (38,20) |  |  |  | √ |  | 最小值 |
| 8 | SDVALUE | numeric | (38,20) |  |  |  | √ |  | 标准差 |
| 9 | SUMVALUE | numeric | (38,20) |  |  |  | √ |  | 总计 |
| 10 | RANGEVALUE | numeric | (38,20) |  |  |  | √ |  | 全距 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | LOTNO | nvarchar | (4000) |  |  |  | √ |  | 生产批号 |
| 13 | LOTSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批序号 |
| 14 | CP | nvarchar | (30) |  |  |  | √ |  | CP：制程精密度(Capability of Process , Cp) |
| 15 | CPK | nvarchar | (30) |  |  |  | √ |  | CPK：制程能力指数(Cpk) |
| 16 | LOGGROUPSERIAL | nvarchar | (4000) |  |  |  | √ |  | 生产批在作业站的LOG序号 |
| 17 | CA | nvarchar | (4000) |  |  |  | √ |  | CA |
| 18 | SQUARESUMVALUE | nvarchar | (4000) |  |  |  | √ |  | 平方和值 |
| 19 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 20 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 21 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 22 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 23 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | SPCSERIAL | nvarchar | (50) | √ |  |  |  |  | 检验序号 |
| 2 | SPCID | nvarchar | (10) | √ |  |  |  |  | 管制图代码：0：Trend Chart 1：Xbar 2：Xbar-R 3：Xbar-S 4：X-Rm |
| 3 | SERIALNO | numeric | (5,0) | √ |  |  |  |  | 量测值序号 |
| 4 | VIOLATIONID | nvarchar | (20) | √ |  |  |  |  | 违反法则编号 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FilePath | nvarchar | (255) |  |  |  | √ |  | 文档路径 |
| 2 | Total | numeric | (8,0) |  |  |  | √ |  | 总计 |
| 3 | SuccessCount | numeric | (8,0) |  |  |  |  |  | 成功数量 |
| 4 | FailedCount | numeric | (8,0) |  |  |  | √ |  | 失败数量 |
| 5 | ImportNo | nvarchar | (50) |  |  |  |  |  | 导入编号 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 10 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 11 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | PRODUCTNO | nvarchar | (50) |  |  |  | √ |  | 产品编号 |
| 2 | PRODUCTNAME | nvarchar | (100) |  |  |  | √ |  | 产品名称 |
| 3 | FailedReason | nvarchar | (2000) |  |  |  |  |  | 失败原因 |
| 4 | PRODUCTVERSION | nvarchar | (51) |  |  |  | √ |  | 产品版本 |
| 5 | PROCESSTYPE | nvarchar | (51) |  |  |  | √ |  | 流程类别 |
| 6 | PROCESSNO | nvarchar | (51) |  |  |  | √ |  | 流程编号 |
| 7 | PSNO | nvarchar | (51) |  |  |  | √ |  | 区段编号 |
| 8 | PROCESSNAME | nvarchar | (100) |  |  |  | √ |  | 流程名称 |
| 9 | OPSEQ | nvarchar | (51) |  |  |  | √ |  | 作业站次序 |
| 10 | OPNO | nvarchar | (51) |  |  |  | √ |  | 作业站编号 |
| 11 | FixEQPTime | nvarchar | (51) |  |  |  | √ |  | 固定机时(分) |
| 12 | VarEQPTime | nvarchar | (51) |  |  |  | √ |  | 变动机时(分) |
| 13 | CountEQPUnitQty | nvarchar | (51) |  |  |  | √ |  | 机时单位批量 |
| 14 | FixEMPTime | nvarchar | (51) |  |  |  | √ |  | 固定人时(分) |
| 15 | VarEMPTime | nvarchar | (51) |  |  |  | √ |  | 变动人时(分) |
| 16 | CountOPUnitQty | nvarchar | (51) |  |  |  | √ |  | 人时单位批量 |
| 17 | PROCESSVERSION | nvarchar | (51) |  |  |  | √ |  | 流程版本 |
| 18 | AREANO | nvarchar | (51) |  |  |  | √ |  | 区域编号 |
| 19 | EQUIPMENTTYPE | nvarchar | (51) |  |  |  | √ |  | 设备类别 |
| 20 | EQUIPMENTNO | nvarchar | (51) |  |  |  | √ |  | 设备编号 |
| 21 | ImportNo | nvarchar | (50) |  |  |  |  |  | 导入编号 |
| 22 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 23 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 24 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 25 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | BINNO | nvarchar | (10) | √ |  |  |  |  | BIN编号 |
| 2 | BINORDER | numeric | (3,0) |  |  |  | √ | 99 | BIN顺序 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | CAPTION | nvarchar | (50) | √ |  |  |  |  | 标题 |
| 2 | CONTENT | nvarchar | (4000) |  |  |  | √ |  | 内容 |
| 3 | STARTDATE | datetime |  |  |  |  | √ |  | 开始日期 |
| 4 | ENDDATE | datetime |  |  |  |  | √ |  | 结束日期 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 8 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 9 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) | √ |  |  |  |  | 自动生成GUID |
| 1 | SID | numeric | (8,0) |  |  |  | √ |  | SID |
| 2 | PROD_NAME | nvarchar | (50) | √ |  |  |  |  | 产品名称 |
| 3 | VER | nvarchar | (20) |  |  |  | √ |  | 产品版本 |
| 4 | IP | nvarchar | (25) |  |  |  | √ |  | IP位置 |
| 5 | PROD_ID | nvarchar | (50) |  |  |  | √ |  | 产品ID |
| 6 | WSDL | nvarchar | (500) |  |  |  | √ |  | 接口 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 10 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 11 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | ELEMENTNO | nvarchar | (20) | √ |  |  |  |  | 特性编号 |
| 2 | ELEMENTNAME | nvarchar | (50) |  |  |  | √ |  | 特性名称 |
| 3 | ELEMENTTYPE | numeric | (2,0) |  |  |  | √ | 0 | 特性类别：0  ?公用(Common) 1  ?设备(Equipment) 2  ?原料(Material) 3  ?作业站(OP) 4  ?流程(Process) 5  ?产品(Product) 6  ?作业站属性(OP Attrib） 7  ?品管项目参数(QCItem Parameter) 8  ?库房(Inventory) 9  ?设备参数(Recipe) 10  工程(ENG) |
| 4 | DATATYPE | numeric | (1,0) |  |  |  | √ |  | 数据类别：0  ?数值(NUMERIC) 1  ?字符串(String) 2  ?百分比(Percent) 3  ?日期(Date Time) 4  ?布尔值(Boolean) |
| 5 | TRANSFERTYPE | numeric | (1,0) |  |  |  | √ | 0 | 转换方式：0  ?不转换(Not Change) 1  ?转换成大写(Upper Case) 2  ?转换成小写(Low Case) |
| 6 | VALUETYPE | numeric | (1,0) |  |  |  | √ | 0 | 有效性检查：0  ?没有限制(Not Limit) 1  ?直接设置(Assign Valid Value) 2  ?最大最小值(Min Max) 3  ?参考系统参数(Reference MES Parameter) |
| 7 | VALIDLIST | nvarchar | (2000) |  |  |  | √ |  | 有效数据 |
| 8 | DEFAULTVALUE | nvarchar | (255) |  |  |  | √ |  | 默认值 |
| 9 | FORMATSTRING | nvarchar | (4000) |  |  |  | √ |  | 格式字符串 |
| 10 | ELEMENTSEQUENCE | numeric | (12,0) |  |  |  | √ | 0 | 特性次序 |
| 11 | UNIT | numeric | (1,0) |  |  |  | √ |  | 单位 |
| 12 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 14 | CONTROLLED | numeric | (1,0) |  |  |  | √ | 0 | 属性控管方式：0  ?不控管(Not Control) 1  ?检查(Check) 2  ?纪录(Note) |
| 15 | INPUTTYPE | numeric | (1,0) |  |  |  | √ | 0 | 输入类型：0  ?直接输入(Key In) 1  ?清单(Select List) |
| 16 | ALLOWNULL | numeric | (1,0) |  |  |  | √ | 0 | 是否允许为空值：0  ?不允许为空值(Not Null) 1  ?为空值(Null) |
| 17 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 18 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 19 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 20 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 21 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TransID | nvarchar | (50) | √ |  |  |  |  | 交易编号 |
| 2 | DocumentType | numeric | (18,0) |  |  |  |  |  | 单别：1：工单发料 2：工单退料 3：报工单 4：成品入库 5：不良品入库 6：外包出货 7：外包回货 8：MES发料 9：ERP外包回货 10：当站下线入库 12   退货单 13   SMT包装处置   --20210408  jinghuang |
| 3 | MESNo | nvarchar | (50) |  |  |  | √ |  | MES单号：如果是外包单号时，需截去后缀两码才会是实际外包单单号 |
| 4 | ERPNo | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ReturnDate | datetime |  |  |  |  | √ |  | 还原日期 |
| 7 | ReturnUserNo | nvarchar | (30) |  |  |  | √ |  | 还原人员 |
| 8 | RELATIONERPNO | nvarchar | (50) |  |  |  | √ |  | ERP关联单号 |
| 9 | SENDID | nvarchar | (20) |  |  |  | √ |  | 送件ID |
| 10 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 11 | RETURNRESPONSEREQID | nvarchar | (50) |  |  |  | √ |  | ReturnREQID：Response XML中的 reqid |
| 12 | RETURNRESPONSEMSG | nvarchar | (255) |  |  |  | √ |  | 还原消息：Response XML的description内容 |
| 13 | RETURNSTATUS | numeric | (2,0) |  |  |  |  | 0 | 还原状态：0 Default 1 Success 2 Fail |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 17 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ERP_NAME | nvarchar | (10) | √ |  |  |  |  | ERP名称：Workflow Workflow ERP TIPTOP TIPTOP ERP T100 T100 ERP HMI HMI ERP APS APS ERP SFT SFT ERP eSOP E10 E10 ERP WFGP：WFGP ERP YIFEI：YIFEI ERP Equipment |
| 2 | ERP_ORG | nvarchar | (20) |  |  |  |  | 'N/A' | 营运中心代码 |
| 3 | ERP_WSURL | nvarchar | (255) |  |  |  |  |  | ERP Web服务网址 |
| 4 | ERP_USER | nvarchar | (20) |  |  |  |  |  | ERP用户名称 |
| 5 | ERP_PWD | nvarchar | (50) |  |  |  | √ |  | ERP密码 |
| 6 | ERP_LANG | nvarchar | (30) |  |  |  | √ |  | ERP语系：en_US   英文 zh_CN   简体中文 zh_TW   繁体中文 |
| 7 | ERP_VERSION | nvarchar | (20) |  |  |  | √ | 'N/A' | ERP版本 |
| 8 | MESPRODUCTNAME | nvarchar | (50) |  |  |  | √ |  | MES产品名称 |
| 9 | MESPRODUCTVER | nvarchar | (20) |  |  |  | √ |  | MES产品版本 |
| 10 | MESIP | nvarchar | (255) |  |  |  | √ |  | MESIP位置 |
| 11 | MESID | nvarchar | (20) |  |  |  | √ |  | MES标识符 |
| 12 | CALLEDPRODUCTNAME | nvarchar | (50) |  |  |  | √ |  | 被调用端产品名称 |
| 13 | CALLEDPRODUCTVER | nvarchar | (20) |  |  |  | √ |  | 被调用端产品版本 |
| 14 | CALLEDIP | nvarchar | (255) |  |  |  | √ |  | 被调用端IP位置 |
| 15 | CALLEDID | nvarchar | (20) |  |  |  | √ |  | 被调用端标识符 |
| 16 | ERP_ENTID | nvarchar | (50) |  |  |  | √ |  | 企业编号 |
| 17 | CALLEDSRVVER | nvarchar | (5) |  |  |  | √ |  | 指定服务版本 |
| 18 | EAI_TYPE | numeric | (2,0) |  |  |  | √ | 0 | 集成类型：0：使用各别产品集成接口 1：使用中台集成接口 3：设备集成接口 |
| 19 | SPCPRODUCTNAME | nvarchar | (50) |  |  |  | √ |  | SPC产品名称 |
| 20 | SPCPRODUCTVER | nvarchar | (30) |  |  |  | √ |  | SPC产品版本 |
| 21 | SPCIP | nvarchar | (255) |  |  |  | √ |  | SPCIP位置 |
| 22 | SPCID | nvarchar | (20) |  |  |  | √ |  | SPC标识符 |
| 23 | ESIDefault | numeric | (1,0) |  |  |  |  | 0 | 预设设备集成月台：0 N 1 Y |
| 24 | CALLECPRODUCTNAME | nvarchar | (50) |  |  |  | √ |  | 被调用端EC产品名称 |
| 25 | CALLECPRODUCTVER | nvarchar | (30) |  |  |  | √ |  | 被调用端EC产品版本 |
| 26 | CALLECIP | nvarchar | (255) |  |  |  | √ |  | 被调用端ECIP位置 |
| 27 | CALLECID | nvarchar | (20) |  |  |  | √ |  | 被调用端EC标识符 |
| 28 | CALLECVER | nvarchar | (20) |  |  |  | √ |  | 被调用端EC指定服务版本 |
| 29 | ERP_RETN_SEC | numeric | (4,0) |  |  |  | √ |  | 等待ERP返回秒数 |
| 30 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 31 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 32 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 33 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 34 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 35 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | USERID | nvarchar | (10) |  |  |  |  |  | 用户ID |
| 2 | RECORDDATE | datetime |  |  |  |  |  |  | 发生日期 |
| 3 | SERVICENAME | nvarchar | (64) |  |  |  |  |  | 服务名称 |
| 4 | DESCRIPTION | nvarchar | (-1) |  |  |  | √ |  | 说明 |
| 5 | KEYFIELD | nvarchar | (1000) |  |  |  | √ |  | 栏位 |
| 6 | KEYVALUE | nvarchar | (1000) |  |  |  | √ |  | 值 |
| 7 | COMPUTERNAME | nvarchar | (50) |  |  |  | √ |  | 电脑名称 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间：数据修改时间 |
| 9 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 10 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员：数据修改人员 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 13 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | GUID |
| 1 | USERID | nvarchar | (50) |  |  |  |  |  | 用户ID |
| 2 | RECORDDATE | datetime |  |  |  |  |  |  | 发生日期 |
| 3 | SERVICENAME | nvarchar | (255) |  |  |  |  |  | 服务名称 |
| 4 | DESCRIPTION | nvarchar | (-1) |  |  |  | √ |  | 说明 |
| 5 | KEYFIELD | nvarchar | (1000) |  |  |  | √ |  | 字段 |
| 6 | KEYVALUE | nvarchar | (4000) |  |  |  | √ |  | 值 |
| 7 | COMPUTERNAME | nvarchar | (50) |  |  |  | √ |  | 计算机名称 |
| 8 | RESULT | nvarchar | (4000) |  |  |  | √ |  | 运行纪录 |
| 9 | Exception | nvarchar | (4000) |  |  |  | √ |  | 例外纪录 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | USERID | nvarchar | (50) |  |  |  |  |  | 用户ID |
| 2 | RECORDDATE | datetime |  |  |  |  |  |  | 发生日期 |
| 3 | TRANSACTIONKEY | nvarchar | (50) |  |  |  |  |  | 操作id |
| 4 | EXETYPE | nvarchar | (10) |  |  |  |  |  | 执行类型 |
| 5 | DATATABLE | nvarchar | (30) |  |  |  | √ |  | 表名 |
| 6 | CONTENTGUID | nvarchar | (50) |  |  |  | √ |  | 内容GUID |
| 7 | CONTENT | nvarchar | (-1) |  |  |  | √ |  | 异动内容json格式 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MASTERNO | nvarchar | (50) | √ |  |  |  |  | 控制编号：我的最爱区分维度，可能记录作业区编号或用户编号 MasterType=7 记录用户 MasterType=10 记录作业区 |
| 2 | MASTERTYPE | numeric | (3,0) | √ |  |  |  |  | 控制类型：5-检验作业清单 6-子作业平台清单 7-菜单清单 #82968 20201130 朱煜轲 10-设备妥善率看板   20210512 mantis #92456 bruce 4-派工区域 |
| 3 | EQUIPMENTNO | nvarchar | (50) | √ |  |  |  |  | 设备编号：7-functionkey |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | USERNO | nvarchar | (30) |  |  |  | √ |  | 用户编号 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MASTERNO | nvarchar | (50) | √ |  |  |  |  | 控制编号：MasterType=R55时，记录作业区 |
| 2 | MASTERTYPE | nvarchar | (50) | √ |  |  |  |  | 控制类型：R55 设备妥善率看板 |
| 3 | OBJECTNO | nvarchar | (50) | √ |  |  |  |  | 最爱对象编号：ObjectType=EquipmentNo时记录设备编号 ObjectType=PartNo时记录部件编号 |
| 4 | OBJECTTYPE | nvarchar | (50) | √ |  |  |  |  | 最爱对象类型：EquipmentNo 设备 PartNo 设备部件 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  |  |  | 说明 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSYSFavouriteHomepage — 我的最爱首页表（71 字段）
> 主键：UserNo, FLOWNO, NODEID, FLOWNO, FUNCTIONNO, USERNO, FUNCTIONNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | UserNo | nvarchar | (30) | √ |  |  |  |  | 使用者编号 |
| 2 | FavouriteList | nvarchar | (1000) |  |  |  | √ |  | 我的最爱清单 |
| 3 | DefaultProgram | nvarchar | (20) |  |  |  | √ |  | 预设开启作业 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FLOWNO | nvarchar | (64) | √ |  |  |  |  | 建模流程编号 |
| 2 | FLOWNAME | nvarchar | (50) |  |  |  |  |  | 建模流程名称 |
| 3 | FlOWORDER | numeric | (2,0) |  |  |  |  |  | 建模流程次序 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FLOWNO | nvarchar | (64) |  |  |  |  |  | 建模流程编号 |
| 2 | NODEID | nvarchar | (100) | √ |  |  |  |  | 节点编号 |
| 3 | NODENAME | nvarchar | (50) |  |  |  |  |  | 节点名称 |
| 4 | NODETYPE | numeric | (1,0) |  |  |  |  |  | 节点类型 |
| 5 | FUNCTIONNO | nvarchar | (50) |  |  |  |  |  | 功能编号 |
| 6 | GROUPNO | nvarchar | (30) |  |  |  | √ |  | 群组编号 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | OPNO | nvarchar | (20) |  |  |  | √ |  | 作业站编号 |
| 11 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FLOWNO | nvarchar | (64) | √ |  |  |  |  | 建模流程编号 |
| 2 | NODEXMLSTRING | nvarchar | (-1) |  |  |  | √ |  | 节点XML |
| 3 | NODEXMLSTRING_EN | nvarchar | (-1) |  |  |  | √ |  | 节点XML(英) |
| 4 | NODEXMLSTRING_CHS | nvarchar | (-1) |  |  |  | √ |  | 节点XML(简中) |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FUNCTIONNO | nvarchar | (50) | √ |  |  |  |  | 功能编号：0 |
| 2 | FUNCTIONNAME | nvarchar | (50) |  |  |  |  |  | 功能名称：0 |
| 3 | FUNCTIONORDER | numeric | (6,1) |  |  |  |  |  | 功能顺序：0 |
| 4 | MODULENO | nvarchar | (10) |  |  |  |  |  | 模块编号：0 |
| 5 | FORMNAME | nvarchar | (50) |  |  |  | √ |  | 表单名称：0 |
| 6 | WEBURL | nvarchar | (100) |  |  |  | √ |  | 网址：0 |
| 7 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 9 | PRIVOPTION | numeric | (1,0) |  |  |  | √ | 0 | 权限选项：0 |
| 10 | ISSUEOPTION | numeric | (1,0) |  |  |  | √ | 0 | 签核选项：0 |
| 11 | ISSUETABLE | nvarchar | (50) |  |  |  | √ |  | 签核表：0 |
| 12 | EXECUTIONFILE | nvarchar | (50) |  |  |  | √ |  | 运行文档：0 |
| 13 | FUNCTIONKEY | nvarchar | (30) |  |  |  | √ |  | 功能键：0 |
| 14 | ExecutionMode | numeric | (1,0) |  |  |  |  | 0 | 运行模式：0 |
| 15 | H5FUNCTIONKEY | nvarchar | (50) |  |  |  | √ |  | H5功能键：0 |
| 16 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：0 |
| 1 | USERNO | nvarchar | (64) | √ |  |  |  |  | 人员编号 |
| 2 | FUNCTIONORDER | numeric | (3,0) |  |  |  |  |  | 功能顺序 |
| 3 | FUNCTIONNO | nvarchar | (50) | √ |  |  |  |  | 功能编号 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblSYSFunctionEvent — 系统功能事件表（280 字段）
> 主键：ServiceType, ServiceNo, FunctionNo, FORMNAME, Creator, PARAMETERNO, PARAMETERNAME, GUID, MODULENO, SERVICETYPE, MODULENAME, GROUPNAME, SERVICENAME, PROPERTYNO, MOTYPENO, PAGEMODE, PARAMETERTYPE, PARAMETERNO, SERIALTYPE, RULEBASE, ITEMNO, SENDID, SENDID, SERIALTYPE, SERIALTYPE, SERIALSTRING, SERIALLENGTH, DECIMALTYPE, FUNCTIONNAME, SERIALTYPE, SERIALTYPENO, SERIALTYPE, ITEMNO, SERIALTYPENO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | ServiceType | nvarchar | (50) | √ |  |  |  |  | 服务类型 |
| 2 | ServiceNo | nvarchar | (200) | √ |  |  |  |  | 服务编号 |
| 3 | ServiceName | nvarchar | (200) |  |  |  |  |  | 服务名称 |
| 4 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | IsLog | numeric | (1,0) |  |  |  | √ | 0 | 是否纪录历程 |
| 6 | AlertType | nvarchar | (20) |  |  |  | √ |  | 警报类型 |
| 7 | AlertTime | numeric | (12,0) |  |  |  | √ |  | 警报时间 |
| 8 | FunctionNo | nvarchar | (50) | √ |  |  |  |  | 功能代号 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 10 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 11 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 12 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 13 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FORMNAME | nvarchar | (200) | √ |  |  |  |  | 建模设计编号 |
| 2 | SETTING | nvarchar | (-1) |  |  |  | √ |  | 字段设置 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态 |
| 4 | Creator | nvarchar | (50) | √ |  |  |  |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | ERRORCONTENT | nvarchar | (255) |  |  |  | √ |  | 错误消息：错误消息 |
| 2 | PROCESSTYPE | nvarchar | (64) |  |  |  |  |  | 流程类别：流程类别 |
| 3 | CHECKRESULT | numeric | (1,0) |  |  |  |  | 0 | 检查成功：检查成功 |
| 4 | PROCESSNO | nvarchar | (64) |  |  |  |  |  | 流程编号：流程编号 |
| 5 | MeshProcess | numeric | (1,0) |  |  |  |  | 0 | 网状制程：网状制程 |
| 6 | PROCESSVERSION | nvarchar | (5) |  |  |  |  |  | 流程版本：流程版本 |
| 7 | ForceApprove | numeric | (1,0) |  |  |  |  | 1 | 强制核准：强制核准 |
| 8 | PROCESSNAME | nvarchar | (255) |  |  |  |  |  | 流程名称：流程名称 |
| 9 | SetDefaultProcess | numeric | (1,0) |  |  |  |  | 0 | 设为默认流程：设为默认流程 |
| 10 | PSNO | nvarchar | (50) |  |  |  |  |  | 生产区段：生产区段 |
| 11 | SetCurrentVer | numeric | (1,0) |  |  |  |  | 1 | 设为当前版本：设为当前版本 |
| 12 | MEMO | nvarchar | (255) |  |  |  |  |  | 描述：描述 |
| 13 | ProductBinding | numeric | (1,0) |  |  |  |  | 0 | 产品绑定：产品绑定 |
| 14 | NODESEQUENCE | varchar | (10) |  |  |  |  |  | 流程节点顺序：流程节点顺序 |
| 15 | OverWriteOPTime | numeric | (1,0) |  |  |  |  | 0 | 覆写作业站时间：覆写作业站时间 |
| 16 | FROMNODENO | nvarchar | (20) |  |  |  |  |  | 起始作业站编号：起始作业站编号 |
| 17 | TONODENO | nvarchar | (20) |  |  |  | √ |  | 目的作业站编号：目的作业站编号 |
| 18 | PRODUCTNO | nvarchar | (50) |  |  |  |  |  | 产品编号：产品编号 |
| 19 | PRODUCTVERSION | nvarchar | (50) |  |  |  |  |  | 产品版本：产品版本 |
| 20 | STDEMPTIME | numeric | (12,4) |  |  |  |  |  | 固定人时：固定人时 |
| 21 | VAREMPTIME | numeric | (12,4) |  |  |  |  |  | 变动人时：变动人时 |
| 22 | STDEQPTIME | numeric | (12,4) |  |  |  |  |  | 固定机时：固定机时 |
| 23 | VAREQPTIME | numeric | (12,4) |  |  |  |  |  | 变动机时：变动机时 |
| 24 | WORKTIMEQTY | numeric | (12,4) |  |  |  |  |  | 工时批量：工时批量 |
| 25 | BATCHQTY | numeric | (12,4) |  |  |  |  |  | 批次加工量：批次加工量 |
| 26 | PRICE | numeric | (12,4) |  |  |  |  |  | 单价：单价 |
| 27 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 28 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 29 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 30 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 31 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 32 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PARAMETERNO | nvarchar | (64) | √ |  |  |  |  | 要因参数编号 |
| 2 | PARAMETERNAME | nvarchar | (50) | √ |  |  |  |  | 要因参数名称 |
| 3 | TABLENAME | nvarchar | (4000) |  |  |  | √ |  | 数据表名称 |
| 4 | FIELDNAME | nvarchar | (4000) |  |  |  | √ |  | 参考字段名称：0：不可见 1：可见 |
| 5 | CONDITION | nvarchar | (4000) |  |  |  | √ |  | 条件 |
| 6 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 签核状态 |
| 8 | PARAMETERTYPE | numeric | (1,0) |  |  |  |  |  | 参数类别：0   数据表(Table) 2   无(None) |
| 9 | FUNCTIONNAME | nvarchar | (4000) |  |  |  | √ |  | 函数名称 |
| 10 | PARAMETERCLASS | numeric | (1,0) |  |  |  | √ |  | 参数类别：0   MES 1   SPC |
| 11 | SHOWNAME | nvarchar | (4000) |  |  |  | √ |  | 显示名称：附加字段：质检报告、检验历程查找使用 |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | MODELNO | nvarchar | (50) |  |  |  |  | 'defaultValue' | 数据模型编号 |
| 2 | SYNCTYPE | numeric | (1,0) |  |  |  |  | 0 | 同步类型：0 一般同步 1 强制同步 |
| 3 | ISSYNC | nvarchar | (10) |  |  |  |  | 'Fail' | 同步状态：Success 成功 Fail 失败 |
| 4 | MEMO | nvarchar | (4000) |  |  |  | √ |  | 备注 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  |  | 'DS' | 同步人员 |
| 7 | CreateDate | datetime |  |  |  |  |  | '1900-1-1' | 同步日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) | √ |  |  |  | '1' | 自动生成GUID |
| 1 | MODULENO | nvarchar | (10) | √ |  |  |  |  | 模块编号 |
| 2 | MODULEORDER | numeric | (6,1) |  |  |  |  |  | 模块顺序 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SERVICETYPE | nvarchar | (20) | √ |  |  |  |  | 服务类别 |
| 2 | MODULENAME | nvarchar | (60) | √ |  |  |  |  | 模块名称 |
| 3 | GROUPNAME | nvarchar | (60) | √ |  |  |  |  | 群组名称 |
| 4 | SERVICENAME | nvarchar | (60) | √ |  |  |  |  | 服务名称 |
| 5 | SEQ | numeric | (12,0) |  |  |  |  | 0 | 顺序 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | PROPERTYNO | nvarchar | (20) | √ |  |  |  |  | 属性编号 |
| 2 | PROPERTYNAME | nvarchar | (50) |  |  |  | √ |  | 属性名称 |
| 3 | DATATYPE | numeric | (1,0) |  |  |  |  |  | 数据类别：0   数值(NUMERIC) 1   字符串(String) 2   百分比(Percent) 3   日期(Date Time) 4   布尔值(Boolean) |
| 4 | TRANSFERTYPE | numeric | (1,0) |  |  |  |  | 0 | 转换方式：0   不转换(Not Change) 1   转换成大写(Upper Case) 2   转换成小写(Low Case) |
| 5 | TABLETYPE | numeric | (1,0) |  |  |  |  |  | 数据表类别：0   系统数据表(System table) 1   其他数据表(Other table) |
| 6 | TABLENAME | nvarchar | (50) |  |  |  | √ |  | 数据表名称 |
| 7 | FIELDNAME | nvarchar | (50) |  |  |  | √ |  | 域名 |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | UPDATETYPE | numeric | (1,0) |  |  |  | √ | 0 | 更新方式：0    覆盖(Override) 1    附加(Accumulate) |
| 11 | CONTROLLED | numeric | (1,0) |  |  |  | √ | 0 | 属性控管方式：0   不控管(Not Control) 1   检查(Check) 2   纪录(Note) |
| 12 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 13 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | MOTYPENO | numeric | (2,0) | √ |  |  |  |  | 工单类别编号：工单型别 |
| 2 | MOTYPENAME | nvarchar | (20) |  |  |  |  |  | MOTYPENAME：MOTYPENAME |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | MOTYPECODE | nvarchar | (30) |  |  |  | √ |  | 工单类别简码：工单类别简码 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：GUID |
| 1 | PAGEMODE | nvarchar | (50) | √ |  |  |  |  | 页面模式 |
| 2 | PAGESCRIPT | nvarchar | (-1) |  |  |  | √ |  | 查询语法：透过{{条件名称}}会自动代换成andxxx= 透过{{where}}可以指定查询条件会塞到哪个地方 都没设定{{}}时，会自动找出塞入where条件的地方 |
| 3 | ACTIVE | nvarchar | (30) |  |  |  | √ |  | 是否启用：0 停用 1 启用 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 查询说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | MODIFY | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 8 | MODIFYDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | PAGENO | nvarchar | (50) |  |  |  | √ |  | 页面模式_新 |
| 1 | PARAMETERTYPE | nvarchar | (50) | √ |  |  |  |  | 参数类别：PrivType   权限 SysInfo   系统信息 SMTPInfo   SMTP信息 |
| 2 | PARAMETERNO | nvarchar | (50) | √ |  |  |  |  | 参数编号：SMTOPFeederListControl 进站检查贴片机物料 SMTOPToolControl 进站检查印刷机开机条件 SMTAPAIEW 锡膏报废预警天数（Invalid Early warning） SMTMSDControl MSD物料管控是否启用(DB已删除) SMTAPAMag 锡膏、红胶是否执行领用与归还管理 SMTFeederMFUControl Feeder与台车(MFU)上线前是否强制检测 SMTFixScanner 是否启用Fixed scanner集成接口 SMTMATCount  SMTModuleID：是否启用SMT模组（值为1时启用） SMTMToolControl  SMTPAlias  SMTPartDisableControl：禁用物料管控是否启用 SMTPCSNoMapping  SMTReelByLotNo  SMTSQMag 网板、刮刀是否执行领用与归还管理 SMTToolControl 工具上线前是否强制检测 SMTXMag 其他类型工具是否执行领用与归还管理 SMTXNGAutoRepair  SMTPPassword  SMTPPort  SMTPServer  SMTPSSL  SMTPUser  SPCERFNeedReview  SPCOPPriv  SubOPCollectSNOrder  SubOPMandatoryCollection  SYSEMail  SYSPriv  TPERPProcessCost  TPERPUseMESUserNo  UCBModule  UltraGridIssueControl  UserDefineAQL  USRSkillEnabled  WarehouseShowERPNo  WFERPOutSouring  WIP  WIPChkPassword  WMSEnabled  WriteTransactionLog  WrongNum  YieldContainDefect  AllowCheckOutWithOutOperator  AllowExcessPurchase  AllowExecuteLot  ALLOWINV2ERP  AllowLotProductChange  AllowReverseAlone  AllowsJDS  AllowWIPLotReverse  ArchiveDBConnectionIP  ArchiveDBInitCatalog  ArchiveDBPassword  ArchiveDBProvider  ArchiveDBType  ArchiveDBUserId  AutoLotCreate  AutoMOApprove  AutoMORelease  AutoReworkMaterialProcess  BackLotWhenMachineStatusChange  CalculateQty  CheckQC  CheckUNDispatch  CIMTLDBCheck  CLOCKIN_AUTOCLOCKOUT  CORPID  CORPSECRET  CreateLotQty  DailyWorkReportExclusiveRestTime  DeductionOfStock  DefaultMOAccessoryCombine  DefaultSTDFeeding  DispMaterialAutoCallingOption  ECEnabled  EmployeeWorkReason  EnterpriseNo  EQPACCINVAutoInOut  EQPChangeExceptTime  EQX_URL  ERPImportProcessStdTime  ERPWOWORKREPORTDATA  ERPWOWorkReportReCalResource  ESIDBConString  ESIMessageVersion  eSOPFilePath  ExecuteAPS  ExternalQCFormDelete_FQC  ExternalQCFormDelete_IQC  ExternalQCFormDelete_OQC  ExternalQCFormDelete_PQC  FasteningPackage  FileSizeLimit  FlowChartFilePath  ForceOSMOClose  ForceWIPINVMOClose  FRURL  HiAirPassword  HiAirServer  HiAirUser  IIoT_Activate_Flag  IQCRESULTBACKTOERP  IsInjectionMolding  IssueWeb  JDSEnabled  JDSWebService  JudgeAfterProcessERF  KillIdleUser  LabelExe  LabelPath  LeanModule  LINETOKE  LotCreateDeductMaterial  LotFinishMsg  LOTRESVALUE  ManyMaterialLotnoRule  MaterialCountMethod  MaterialFeedingOption 系统上料叫料开关 MaterialInGenerateQCForm  MESIssueMTLToERPDocType  MOCloseDate  MOFinishMsg  MSD  MultiOperator  MULTIOPERATOR_COLIMIT  NewDataImporter  Numberofdecimals  OEEExceptTime  OEEWorkTime  OPEquipmentQC  OPM  OPSTDTIME  OSBackNotAllowedExceed  OSerp_type  OSReturnerp_type  OutSourcingFlag  PCS_BY_MO  PCSMaterialNoRepeat  PCSMaterialRepaireClear  PhotoEditor1  PlatFormEarlyWarningDays  PlatFormOverdueDays  PLMWebService  PrintRepairOrderModel  PrintRunCardModel  PrintShipmentModel  PrivnoStateControlByAdmin  ProductPriv  ProductSCode  PSPriv  QCFOMRSPLIT  QCFormiSPCCallBackService  QCFormMESCallBackService  QCFormWFCallBackService  RTDServiceIP  RTDServicePort  SelectAllAreaEQP  SendERFRequestToERP  SessionTimeOut  SIPValidateMode  SiteNo  SITEPriv  SlightModule  ControlTheMaterialOfMONO：用料清单预检 MaterialFeedingOptionByMES：MES系统上料叫料 PCSNoTransBuckle 序号转码是否发起WMS线边仓扣料 |
| 3 | PARAMETERVALUE | nvarchar | (255) |  |  |  | √ |  | 参数值：0：不管控 1：管控 |
| 4 | PARAMETERVISABLE | numeric | (1,0) |  |  |  | √ | 0 | 参数可见：0：不可见 1：可见 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 签核状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 异动人员：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 异动时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SERIALTYPE | nvarchar | (50) | √ |  |  |  |  | SYS.TBLSYSSCANSERIALRULE.Column.SERIALTYPE.displayText |
| 2 | RULEBASE | nvarchar | (50) | √ |  |  |  |  | 规则基础 |
| 3 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 项次 |
| 4 | RULETYPE | numeric | (1,0) |  |  |  |  | 1 | 法则类别 |
| 5 | SERIALLENGTH | numeric | (2,0) |  |  |  | √ |  | SYS.TBLSYSSCANSERIALRULE.Column.SERIALLENGTH.displayText |
| 6 | STARTINDEX | numeric | (2,0) |  |  |  | √ |  | 起始位置 |
| 7 | CONTAINSTRING | nvarchar | (50) |  |  |  | √ |  | 包含字符串 |
| 8 | FIRSTSTRING | nvarchar | (50) |  |  |  | √ |  | 字符串前n码 |
| 9 | LASTSTRING | nvarchar | (50) |  |  |  | √ |  | 字符串后n码 |
| 10 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 11 | CREATEDATE | datetime |  |  |  |  | √ | getdate | 创建时间：数据创建时间 |
| 12 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 13 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 14 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 15 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 16 | TBLPRDTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 17 | TBLMTLMATERIALTYPEGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | ExecuteType | numeric | (1,0) |  |  |  | √ |  | 执行类型 |
| 2 | JobName | nvarchar | (-1) |  |  |  | √ |  | 任务名称 |
| 3 | JobType | numeric | (1,0) |  |  |  | √ |  | 任务类型 |
| 4 | JobTarget | nvarchar | (50) |  |  |  | √ |  | 任务目标 |
| 5 | ScheduleName | nvarchar | (50) |  |  |  | √ |  | 调度名称 |
| 6 | Request | nvarchar | (4000) |  |  |  | √ |  | 请求 |
| 7 | Result | nvarchar | (4000) |  |  |  | √ |  | 返回 |
| 8 | Exception | nvarchar | (4000) |  |  |  | √ |  | 异常信息 |
| 9 | StartTime | datetime |  |  |  |  | √ |  | 开始时间 |
| 10 | TimeConsuming | numeric | (12,0) |  |  |  | √ |  | 耗时 |
| 11 | EndTime | datetime |  |  |  |  | √ |  | 结束时间 |
| 12 | NextTime | datetime |  |  |  |  | √ |  | 下一次执行时间 |
| 13 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 16 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 17 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | SENDID | nvarchar | (20) | √ |  |  |  |  | 发送ID |
| 2 | SENDTO | nvarchar | (10) |  |  |  |  |  | ERP名称 |
| 3 | SERVICENAME | nvarchar | (255) |  |  |  |  |  | 服务名称 |
| 4 | SERVICEVERSION | nvarchar | (30) |  |  |  | √ |  | 服务版本 |
| 5 | FAILNEEDSTOP | numeric | (1,0) |  |  |  |  | 0 | 失败次数 |
| 6 | PAYLOAD | nvarchar | (-1) |  |  |  | √ |  | 发送讯息 |
| 7 | SENDCOUNT | numeric | (3,0) |  |  |  |  |  | 发送次数 |
| 8 | EXCEPTION | nvarchar | (-1) |  |  |  | √ |  | 回传讯息 |
| 9 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 10 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 11 | RELATIONERPNO | nvarchar | (50) |  |  |  | √ |  | ERP关联单单号 |
| 12 | LOTSERIAL | nvarchar | (50) |  |  |  | √ |  | 生产批序号 |
| 13 | MESNO | nvarchar | (50) |  |  |  | √ |  | MES单号 |
| 14 | RELATIONMESNO | nvarchar | (50) |  |  |  | √ |  | MES关联单单号 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | RUNRESULT | nvarchar | (50) |  |  |  | √ |  | 运行结果 |
| 17 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SENDID | nvarchar | (20) | √ |  |  |  |  | 发送ID |
| 2 | SENDTO | nvarchar | (10) |  |  |  |  |  | ERP名称 |
| 3 | SERVICENAME | nvarchar | (255) |  |  |  |  |  | 服务名称 |
| 4 | SERVICEVERSION | nvarchar | (30) |  |  |  | √ |  | 服务版本：null |
| 5 | SENDCONTENT | nvarchar | (-1) |  |  |  | √ |  | 发送内容 |
| 6 | SENDCOUNT | numeric | (3,0) |  |  |  |  |  | 发送次数 |
| 7 | RETURNINFO | nvarchar | (-1) |  |  |  | √ |  | 返回讯息 |
| 8 | RUNRESULT | nvarchar | (50) |  |  |  |  |  | 执行结果 |
| 9 | EXCEPTION | nvarchar | (-1) |  |  |  | √ |  | 回传讯息 |
| 10 | NOTIFYMAN | nvarchar | (255) |  |  |  | √ |  | 通知人员 |
| 11 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 12 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 13 | RELATIONERPNO | nvarchar | (50) |  |  |  | √ |  | 关联单单号 |
| 14 | LOTSERIAL | nvarchar | (50) |  |  |  | √ |  | 生产批序号 |
| 15 | MESNO | nvarchar | (50) |  |  |  | √ |  | MES单号 |
| 16 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 17 | RELATIONMESNO | nvarchar | (50) |  |  |  | √ |  | MES关联单单号 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 20 | ORIGINGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SERIALTYPE | nvarchar | (50) | √ |  |  |  |  | 序号类型 |
| 2 | SERIALMODE | numeric | (1,0) |  |  |  |  | 1 | 序号模式 |
| 3 | DEFAULTSERIALTYPENO | nvarchar | (50) |  |  |  | √ |  | 默认序号类型 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SERIALTYPE | nvarchar | (50) | √ |  |  |  |  | 序号类别 |
| 2 | SERIALSTRING | nvarchar | (50) | √ |  |  |  |  | 序号字符 |
| 3 | SERIALLENGTH | numeric | (2,0) | √ |  |  |  |  | 序号长度 |
| 4 | DECIMALTYPE | numeric | (1,0) | √ |  |  |  |  | 进位类型 |
| 5 | MAXSERIALNO | numeric | (19,0) |  |  |  | √ |  | SYS.TBLSYSSERIALCREATEMAX.Column.MAXSERIALNO.displayText |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | FUNCTIONNAME | nvarchar | (20) | √ |  |  |  |  | 函数名称 |
| 2 | SERIALNO | numeric | (12,0) |  |  |  |  |  | 序号编号 |
| 3 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 7 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SERIALTYPE | nvarchar | (50) | √ |  |  |  |  | 序号类别：LOTNO  ?生产批编号 COMPONENTNO  ?生产批编号 ERFNO  ?异常单编号 MONO  ?工单编号 INCOMINGQCFORMNO  ?进料检验单编号 FQCFORMNO  ?终检检验单编号 IPQCFORMNO   IPQC检验单编号 OQCFORMNO  ?出货检验单编号 MATERIALINNO  ?进料单编号 MATERIALADJUSTNO  ?库存调整单编号 PREORDERNO  ?预订单编号 MATERIALRETURNNO  ?退料单编号 MATERIALOUTNO  ?领料单编号 SEMIINNO  ?半成品入库单编号 SEMIOUTNO  ?半成品出库单编号 FGDINNO  ?成品入库单编号 PCSNO 产品序号 PANELNO SMT Panel序号(SMT方案) FeederNo Feeder ,MFUNo 台车, SolderNo 锡膏,StencilNo 网板, SqueegeeNo 刮刀,AdhensiveNo 红胶,Other 其他工具(SMT方案包)INJRecipeNo 注塑Recipe编号, PACK 包装 |
| 2 | ENABLE | numeric | (1,0) |  |  |  |  | 0 | 启用：0  ?不启用 1  ?启用 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | REVISER | nvarchar | (50) |  |  |  | √ |  | 修改人 |
| 6 | REVISEDATE | datetime |  |  |  |  | √ |  | 修改日期 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 8 | SERIALTYPENO | nvarchar | (50) | √ |  |  |  |  | 序号类别编号 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | SEPARATOR | nvarchar | (5) |  |  |  | √ |  | 使用分隔符 |
| 1 | SERIALTYPE | nvarchar | (50) | √ |  |  |  |  | 序号类别：LOTNO   生产批编号 COMPONENTNO   生产批编号 ERFNO   异常单编号 MONO   工单编号 INCOMINGQCFORMNO   进料检验单编号 FQCFORMNO   终检检验单编号 IPQCFORMNO   IPQC检验单编号 OQCFORMNO   出货检验单编号 MATERIALINNO   进料单编号 MATERIALADJUSTNO   库存调整单编号 PREORDERNO   预订单编号 MATERIALRETURNNO   退料单编号 MATERIALOUTNO   领料单编号 SEMIINNO   半成品入库单编号 SEMIOUTNO   半成品出库单编号 FGDINNO   成品入库单编号 ACCESSORYREPAIRNO：模治具维修单编号 GRRNO：GR＆R单编号 LINEARNO：线性分析单编号 BIASNO：偏差分析单编号 STABILITYNO：稳定性分析单编号 PCSNO 产品序号 PANELNO SMT Panel序号(SMT方案) FeederNo Feeder ,MFUNo 台车, SolderNo 锡膏,StencilNo 网板, SqueegeeNo 刮刀,AdhensiveNo 红胶,Other 其他工具(SMT方案包) INJRecipeNo 注疏Recipe编号 |
| 2 | ITEMNO | numeric | (2,0) | √ |  |  |  |  | 项次 |
| 3 | SOURCETYPE | nvarchar | (50) |  |  |  |  |  | 资料来源：UD   用户自定义 SN   流水号编码 Y1   公元年末一码 Y2   公元年末二码  Y4   公元年四码 M1   数字月份一码 M2   数字月份二码 M3   英文月份前三码 D1   日期一码, 0~9 显示数字, 10以后以英文本母A.B.C依序排列 (10 A, 11 B, 12 C…, 30 U, 31 V) D2   日期数字二码 W2   周次 MO   工单编号，数据源为工单管理的工单主档 FC    FAB 编号，数据源为区域模块的工厂主文档 MTC   工单类别代码，数据源为系统模块的工单类别设定 PN   产品编号，数据源为产品模块的产品设定 PC   产品简码，数据源为产品模块的产品设定 PTC   产品类别代码，数据源为产品模块的产品类别 FeederTypeNo Feeder型号（SMT方案） MFUTypeNo 台车型号（SMT方案） EQPNo 设备编号、EQPType 设备类别、AccessoryNo 模具编号、AccessoryType 模具类别、OPNo 作业站编号、OPType 作业站类别、RecipeVer 版本(以上专属注塑编号用) |
| 4 | SERIALLENGTH | numeric | (2,0) |  |  |  |  |  | 长度：撷取数据源后的总长度 |
| 5 | SEARCHSTART | numeric | (2,0) |  |  |  |  |  | 撷取码数(起)：撷取数据源的起始码数 |
| 6 | DECIMALTYPE | numeric | (1,0) |  |  |  | √ | 0 | 进位类型：1   10进制  2   16进制  3   36进制 |
| 7 | USERDEFINE | nvarchar | (50) |  |  |  | √ |  | 用户自定义 |
| 8 | SERIALCODEFLAG | numeric | (1,0) |  |  |  | √ |  | 序号编码项目：0   否 1   是 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | SERIALTYPENO | nvarchar | (50) | √ |  |  |  | 'DEFAULT' | 序号类别编号 |
| 11 | GETDATA | numeric | (1,0) |  |  |  | √ | 0 | 撷取：0   左方开始撷取字符 1   取得所有字符 2   右方开始撷取字符 |
| 12 | FUNCTIONNAME | nvarchar | (100) |  |  |  | √ |  | 函数名称 |
| 13 | PadLeft | numeric | (1,0) |  |  |  |  | 1 | 自动补零 |
| 14 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 15 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 16 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 17 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 18 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 19 | TBLSYSSERIALRULEBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |

---

### tblSYSSyncCrossProdList — Cross注册产品回传（56 字段）
> 主键：UNITNO, TABLENAME, COLUMNNAME, COLUMNVALUE, YEARNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CrossIP | nvarchar | (15) |  |  |  |  |  | CrossIP：0 |
| 2 | CrossVersion | nvarchar | (20) |  |  |  |  |  | Cross版本：0 |
| 3 | CrossWSDL | nvarchar | (255) |  |  |  |  |  | CrossWSDL：0 |
| 4 | CrossSoapPort | nvarchar | (255) |  |  |  |  |  | CrossSoapPort：0 |
| 5 | CrossRPCWSDL | nvarchar | (255) |  |  |  |  |  | CrossRPCWSDL：0 |
| 6 | CrossRPCSoapPort | nvarchar | (255) |  |  |  |  |  | CrossRPCSoapPort：0 |
| 7 | CrossRestURL | nvarchar | (255) |  |  |  |  |  | CrossRestURL：0 |
| 8 | ProductName | nvarchar | (64) |  |  |  |  |  | 产品名称：产品名称 |
| 9 | ProductVersion | nvarchar | (20) |  |  |  |  |  | 产品版本：0 |
| 10 | ProductIP | nvarchar | (15) |  |  |  |  |  | Cross产品IP：0 |
| 11 | ProductID | nvarchar | (20) |  |  |  | √ |  | Cross产品ID：0 |
| 12 | ProductUID | nvarchar | (20) |  |  |  | √ |  | Cross产品UID：产品主机唯一识别码，同产品在同一集成环境中的uid 不可重复。若host 讯息中有指定uid，则EAI会优先以产品名称和uid 做为辨认主机的条件。 |
| 13 | ProductWSDL | nvarchar | (255) |  |  |  | √ |  | Cross产品WSDL：0 |
| 14 | ProductRestURL | nvarchar | (255) |  |  |  | √ |  | Cross产品RestURL：0 |
| 15 | SyncDate | datetime |  |  |  |  | √ | getdate | 同步日期：0 |
| 16 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 17 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 18 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 19 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 20 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：0 |
| 1 | UNITNO | nvarchar | (30) | √ |  |  |  |  | 单位编号 |
| 2 | UNITTYPE | nvarchar | (64) |  |  |  |  |  | 单位类别：单位所属类别，如长度，重量 |
| 3 | TRANSFERRATE | numeric | (12,4) |  |  |  | √ | 0 | 转换比率 |
| 4 | TRANSFERFUNCTION | nvarchar | (50) |  |  |  | √ |  | 转换函数：若单位转换非简单之转换比率可运算时，可选取转换函数 |
| 5 | SYSTEMUNIT | nvarchar | (64) |  |  |  |  | 'N/A' | 系统单位 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 9 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 10 | ERPNo | nvarchar | (255) |  |  |  | √ |  | ERP单号：ERP抛转 |
| 11 | DecimalType | nvarchar | (1) |  |  |  | √ |  | 小数类型 |
| 12 | DecimalPlaces | numeric | (1,0) |  |  |  | √ |  | 小数位数 |
| 13 | UNITNAME2 | nvarchar | (500) |  |  |  | √ |  | 单位名称 |
| 14 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 15 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 16 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | TABLENAME | nvarchar | (36) | √ |  |  |  |  | 表格名称 |
| 2 | COLUMNNAME | nvarchar | (20) | √ |  |  |  |  | 字段名称 |
| 3 | COLUMNVALUE | numeric | (10,0) | √ |  |  |  |  | 字段值 |
| 4 | DISPLAYTEXT | nvarchar | (50) |  |  |  |  |  | 显示正文 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 8 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 9 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | YEARNO | numeric | (4,0) | √ |  |  |  |  | 年度：民国年 |
| 2 | STARTDATE | datetime |  |  |  |  |  |  | 开始日期：年度开始日期 |
| 3 | ENDDATE | datetime |  |  |  |  |  |  | 结束日期：年度节入日期 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：备注 |
| 5 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 6 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblUsrCalendarBasis — 循环行事历主档（53 字段）
> 主键：CALENDARID, YEAR, CALENDARID, CALENDARDAY, CALENDARID, CALENDARDAY, SHIFTGROUPNO, SHIFTNO, SEQUENCE
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 2 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 3 | MODIFIER | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 4 | MODIDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 5 | CALENDARID | nvarchar | (20) | √ |  |  |  |  | 行事历编号 |
| 6 | YEAR | char | (4) | √ |  |  |  |  | 年份：公元年 |
| 7 | DEF | char | (1) |  |  |  |  | 'N' | 是否预设：Y N |
| 8 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 9 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 10 | WEEKDAY0 | numeric | (8,0) |  |  |  |  |  | 周日产能(分) |
| 11 | WEEKDAY1 | numeric | (8,0) |  |  |  |  |  | 周一产能(分) |
| 12 | WEEKDAY2 | numeric | (8,0) |  |  |  |  |  | 周二产能(分) |
| 13 | WEEKDAY3 | numeric | (8,0) |  |  |  |  |  | 周三产能(分) |
| 14 | WEEKDAY4 | numeric | (8,0) |  |  |  |  |  | 周四产能(分) |
| 15 | WEEKDAY5 | numeric | (8,0) |  |  |  |  |  | 周五产能(分) |
| 16 | WEEKDAY6 | numeric | (8,0) |  |  |  |  |  | 周六产能(分) |
| 17 | WEEKDAY0S | nvarchar | (20) |  |  |  |  |  | 周日班别组成编号 |
| 18 | WEEKDAY1S | nvarchar | (20) |  |  |  |  |  | 周一班别组成编号 |
| 19 | WEEKDAY2S | nvarchar | (20) |  |  |  |  |  | 周二班别组成编号 |
| 20 | WEEKDAY3S | nvarchar | (20) |  |  |  |  |  | 周三班别组成编号 |
| 21 | WEEKDAY4S | nvarchar | (20) |  |  |  |  |  | 周四班别组成编号 |
| 22 | WEEKDAY5S | nvarchar | (20) |  |  |  |  |  | 周五班别组成编号 |
| 23 | WEEKDAY6S | nvarchar | (20) |  |  |  |  |  | 周六班别组成编号 |
| 24 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 25 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 26 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 2 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 3 | MODIFIER | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 4 | MODIDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 5 | CALENDARID | nvarchar | (20) | √ |  |  |  |  | 行事历编号 |
| 6 | YEAR | char | (4) |  |  |  |  |  | 年份：公元年 |
| 7 | CALENDARDAY | char | (8) | √ |  |  |  |  | 日期 |
| 8 | CAPACITY | numeric | (8,0) |  |  |  |  |  | 日期产能(分) |
| 9 | SHIFTGROUPNO | nvarchar | (20) |  |  |  |  |  | 班别组成编号 |
| 10 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 11 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 12 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 13 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 2 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 3 | MODIFIER | nvarchar | (30) |  |  |  | √ |  | 修改者 |
| 4 | MODIDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 5 | CALENDARID | nvarchar | (20) | √ |  |  |  |  | 行事历编号 |
| 6 | CALENDARDAY | char | (8) | √ |  |  |  |  | 日期 |
| 7 | SHIFTGROUPNO | nvarchar | (20) | √ |  |  |  |  | 班别组成编号 |
| 8 | SHIFTNO | nvarchar | (20) | √ |  |  |  |  | 班别编号 |
| 9 | SEQUENCE | numeric | (12,0) | √ |  |  |  |  | 顺序 |
| 10 | STARTTIME | datetime |  |  |  |  |  |  | 休息开始时间 |
| 11 | ENDTIME | datetime |  |  |  |  |  |  | 休息结束时间 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblUSRCategoryBasis — 报工群组主档（10 字段）
> 主键：CategoryNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CategoryNo | nvarchar | (50) | √ |  |  |  |  | 群组编号 |
| 2 | CategoryName | nvarchar | (255) |  |  |  |  |  | 群组名称 |
| 3 | CategoryLeaderNo | nvarchar | (10) |  |  |  |  | '0' | 群组领导人编号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblUSRCategoryDetail — 报工群组明细（76 字段）
> 主键：CategoryNo, UserNo, DEPARTMENTNO, UserNo, MenuName, GROUPNO, GROUPNO, PRIVTYPE, PRIVNO, REASONNO, REASONTYPE, DEPARTMENTNO, SHIFTNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | CategoryNo | nvarchar | (50) | √ |  |  |  |  | 群组编号 |
| 2 | UserNo | nvarchar | (30) | √ |  |  |  |  | 用户编号 |
| 3 | ParameterValue | numeric | (8,2) |  |  |  | √ | 0 | 分摊系数 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 7 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 8 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 9 | TBLUSRCATEGORYBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | DEPARTMENTNO | nvarchar | (20) | √ |  |  |  |  | 部门编号 |
| 2 | DEPARTMENTNAME | nvarchar | (500) |  |  |  | √ |  | 部门名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | DEPARTMENTSNAME | nvarchar | (500) |  |  |  | √ |  | 部门简称 |
| 8 | COSTCENTER | nvarchar | (30) |  |  |  | √ |  | 成本中心 |
| 9 | ERPNO | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | UserNo | nvarchar | (50) | √ |  |  |  |  | 用户编号 |
| 2 | MenuName | nvarchar | (50) | √ |  |  |  |  | 菜单编号 |
| 3 | Platform | nvarchar | (50) |  |  |  |  |  | 所属平台 |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 2 | 签核状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 7 | Editor | nvarchar | (50) |  |  |  | √ |  | 异动人员 |
| 8 | EditDate | datetime |  |  |  |  | √ |  | 异动时间 |
| 1 | GROUPNO | nvarchar | (50) | √ |  |  |  |  | 群组编号 |
| 2 | GROUPNAME | nvarchar | (50) |  |  |  |  |  | 群组名称 |
| 3 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | GROUPLEADER | nvarchar | (50) |  |  |  | √ |  | 群组领导人：群组领导人之用户等级必须为Administrator或Group Leader |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 1 | GROUPNO | nvarchar | (50) | √ |  |  |  |  | 群组编号 |
| 2 | PRIVTYPE | numeric | (1,0) | √ |  |  |  |  | 权限类别：0：功能编号 1：作业站编号 2：区段编号 |
| 3 | PRIVNO | nvarchar | (50) | √ |  |  |  |  | 权限编号：PrivType = 0, PrivNo：功能编号 PrivType = 1, PrivNo：作业站编号 PrivType = 2, PrivNo：区段编号 |
| 4 | CONTROLPRIV | numeric | (1,0) |  |  |  |  | 0 | 按钮控管 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLUSRGROUPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLOPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 12 | TBLEQPGROUPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 13 | PRIVISSUE | numeric | (1,0) |  |  |  |  | 1 | 签核权限 |
| 1 | REASONNO | nvarchar | (20) | √ |  |  |  |  | 原因编号 |
| 2 | REASONNAME | nvarchar | (100) |  |  |  | √ |  | 原因名称 |
| 3 | REASONTYPE | numeric | (2,0) | √ |  |  |  |  | 原因类型：0 上工1 下工 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | DEPARTMENTNO | nvarchar | (20) | √ |  |  |  | '*' | 部门编号 |
| 2 | SHIFTNO | nvarchar | (20) | √ |  |  |  |  | 班别编号 |
| 3 | SHIFTNAME | nvarchar | (50) |  |  |  |  |  | 班别名称 |
| 4 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 8 | FROMTIME | datetime |  |  |  |  | √ |  | 起始时间 |
| 9 | TOTIME | datetime |  |  |  |  | √ |  | 结束时间 |
| 10 | ERPNO | nvarchar | (20) |  |  |  | √ |  | ERP单号 |
| 11 | SHOWNAME | nvarchar | (2) |  |  |  | √ |  | 简码：显示于智派工的班别简码 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblUsrShiftGroup — 班别组成（9 字段）
> 主键：SHIFTGROUPNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SHIFTGROUPNO | nvarchar | (20) | √ |  |  |  |  | 班别组成编号 |
| 2 | SHIFTGROUPNAME | nvarchar | (64) |  |  |  |  |  | 班别组成名称 |
| 3 | TOTALCAPACITY | numeric | (8,0) |  |  |  |  |  | 产能总和(分) |
| 4 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblUsrShiftGroupLine — 班别组成单身（110 字段）
> 主键：SHIFTGROUPNO, SHIFTNO, SHIFTNO, STARTTIME, SKILLNO, SKILLNO, GRADENO, TITLENO, USERNO, USERNO, GROUPNO, GROUPTYPE, AGENTOF, USERNO, SKILLNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | SHIFTGROUPNO | nvarchar | (20) | √ |  |  |  |  | 班别组成编号 |
| 2 | SHIFTNO | nvarchar | (20) | √ |  |  |  |  | 班别编号 |
| 3 | STARTTIME | datetime |  |  |  |  | √ |  | 班别开始时间：智派工用，记录一天开始起算时间的分钟数，如4800表示8 00 |
| 4 | ENDTIME | datetime |  |  |  |  | √ |  | 班别结束时间：智派工用，记录一天结束时间的分钟数，如1200表示20 00 |
| 5 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 10 | TBLUSRSHIFTGROUPGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 11 | TBLUSRSHIFTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 2 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 3 | MODEIFIER | nvarchar | (50) |  |  |  | √ |  | 修改者 |
| 4 | MODIDATE | datetime |  |  |  |  | √ |  | 修改时间 |
| 5 | SHIFTNO | nvarchar | (20) | √ |  |  |  |  | 班别编号 |
| 6 | SEQUENCE | numeric | (12,0) |  |  |  |  |  | 顺序 |
| 7 | STARTTIME | char | (4) | √ |  |  |  |  | 休息开始时间：格式：HHMM |
| 8 | ENDTIME | char | (4) |  |  |  |  |  | 休息结束时间：格式：HHMM |
| 9 | JDS_STARTTIME | numeric | (12,0) |  |  |  |  |  | 智派工休息开始时间：智派工用，记录一天开始起算时间的分钟数，如4800表示8 00 |
| 10 | JDS_ENDTIME | numeric | (12,0) |  |  |  |  |  | 智派工休息结束时间：智派工用，记录一天结束时间的分钟数，如1200表示20 00 |
| 11 | PRESEQ | numeric | (12,0) |  |  |  |  |  | 前段时间顺序：暂无作用 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | TBLUSRSHIFTBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | SKILLNO | nvarchar | (20) | √ |  |  |  |  | 技能编号 |
| 2 | SKILLNAME | nvarchar | (50) |  |  |  |  |  | 技能名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | SKILLNO | nvarchar | (20) | √ |  |  |  |  | 技能编号 |
| 2 | GRADESEQ | numeric | (10,0) |  |  |  |  |  | 序号 |
| 3 | GRADENO | nvarchar | (20) | √ |  |  |  |  | 技能等级 |
| 4 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 5 | REQUIREDQTY | numeric | (10,0) |  |  |  |  | 0 | 需求人数 |
| 6 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 7 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 11 | TBLUSRSKILLBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 1 | TITLENO | nvarchar | (20) | √ |  |  |  |  | 职称编号 |
| 2 | TITLENAME | nvarchar | (50) |  |  |  |  |  | 职称名称 |
| 3 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 4 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 5 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 6 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 7 | PriceRate | numeric | (23,8) |  |  |  | √ |  | 工价系数 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | USERNO | nvarchar | (50) | √ |  |  |  |  | 用户编号：使用者编号 |
| 2 | USERNAME | nvarchar | (50) |  |  |  |  |  | 用户名称 |
| 3 | USERLEVEL | numeric | (1,0) |  |  |  |  |  | 用户等级：0：Administrator(系统管理者权限)，不需设置任何权限便可直接使用系统所有的功能。 1：Group Leader(群组管理者)，可管理系统之功能权限群组，其权限仅限于所属之群组，但可以将其他用户加入其群组中。 2：End User(一般用户)，其权限仅限于所属之群组。 3：Anonymous(未列管之用户)，无法使用任何受到管理之功能权限，仅能使用未列管之权限。 |
| 4 | PASSWORD | nvarchar | (50) |  |  |  |  |  | 密码 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | DESCRIPTION | nvarchar | (4000) |  |  |  | √ |  | 说明：说明 |
| 8 | ISSUESTATE | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 9 | USERTYPE | numeric | (1,0) |  |  |  |  | 0 | 用户类别：0 Employee 1 Customer 2 Other |
| 10 | DEPARTMENTNO | nvarchar | (50) |  |  |  | √ |  | 部门编号 |
| 11 | CUSTOMERNO | nvarchar | (50) |  |  |  | √ |  | 客户编号 |
| 12 | EMAILADDRESS | nvarchar | (255) |  |  |  | √ |  | 邮箱地址 |
| 13 | CHANGEDATE | datetime |  |  |  |  | √ | getdate | 变更日期 |
| 14 | SHIFTNO | nvarchar | (50) |  |  |  | √ |  | 班别编号 |
| 15 | MOBILENO | nvarchar | (50) |  |  |  | √ |  | 手机号码 |
| 16 | RESETPASSWORD | numeric | (1,0) |  |  |  |  | 0 | 重设密码：设置用户下次登录后是否须变更密码 0  不须变更密码 1  须变更密码 |
| 17 | ERPNo | nvarchar | (50) |  |  |  | √ |  | ERP单号 |
| 18 | RESIGNATIONDATE | datetime |  |  |  |  | √ | '3099-01-01' | 离职日期 |
| 19 | TITLENO | nvarchar | (50) |  |  |  | √ |  | 职称编号：人员技能模块添加201907 |
| 20 | COMEDAY | datetime |  |  |  |  | √ |  | 入职日期：人员技能模块添加201907 |
| 21 | LineId | nvarchar | (50) |  |  |  | √ |  | Line的编号 |
| 22 | WeChatId | nvarchar | (50) |  |  |  | √ |  | 微信的编号 |
| 23 | WatchId | nvarchar | (50) |  |  |  | √ |  | 手环编号 |
| 24 | ICCard | nvarchar | (50) |  |  |  | √ |  | IC卡 |
| 25 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 26 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 27 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 28 | USERGENDER | nvarchar | (5) |  |  |  | √ |  | 用户性别 |
| 29 | HOMEADDRE | nvarchar | (100) |  |  |  | √ |  | 家庭地址 |
| 1 | USERNO | nvarchar | (50) | √ |  |  |  |  | 人员编号：用户编号 |
| 2 | GROUPNO | nvarchar | (50) | √ |  |  |  |  | 群组编号 |
| 3 | GROUPTYPE | numeric | (1,0) | √ |  |  |  | 0 | 群组类型 |
| 4 | AGENTOF | nvarchar | (50) | √ |  |  |  | 'N/A' | 代理人 |
| 5 | AGENTDATE | datetime |  |  |  |  | √ |  | 代理日 |
| 6 | AGENTCREATEDATE | datetime |  |  |  |  | √ |  | 代理开始日期：数据创建时间 |
| 7 | ISSUESTATE | numeric | (1,0) |  |  |  | √ |  | 数据状态：数据目前状态 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 11 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 12 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值：数据键值 |
| 13 | TBLUSRGROUPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 14 | TBLUSRUSERBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 15 | TBLEQPENGINEERGROUPBASISGUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | USERNO | nvarchar | (30) | √ |  |  |  |  | 用户编号 |
| 2 | SKILLNO | nvarchar | (20) | √ |  |  |  |  | 技能编号 |
| 3 | GRADENO | nvarchar | (20) |  |  |  |  |  | 技能等级 |
| 4 | EXPERHOUR | numeric | (10,2) |  |  |  |  |  | 经验时数：两位小数 |
| 5 | CREATOR | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 6 | CREATEDATE | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 7 | TBLUSRUSERBASISGUID | nvarchar | (50) |  |  |  | √ |  | 父键值 |
| 8 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 9 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 10 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblVEHTypeBasis — 载具类别基本数据主档（9 字段）
> 主键：VehicleTypeNo
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | VehicleTypeNo | nvarchar | (50) | √ |  |  |  |  | 载具类别编号 |
| 2 | VehicleTypeName | nvarchar | (255) |  |  |  | √ |  | 载具类别名称 |
| 3 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 4 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 5 | IssueState | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 6 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 7 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 8 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |

---

### tblVEHVehicleBasis — 载具基本数据主档（29 字段）
> 主键：VehicleNo, USERNO, FROMLOTNO
| 序号 | 列名 | 类型 | 长度 | 主键 | 业务主键 | 自增 | 允许空值 | 默认值 | 说明 |
|------|------|------|------|:----:|:--------:|:----:|:-------:|--------|------|
| 1 | VehicleTypeNo | nvarchar | (50) |  |  |  |  |  | 载具类别编号 |
| 2 | VehicleNo | nvarchar | (50) | √ |  |  |  |  | 载具编号 |
| 3 | VehicleName | nvarchar | (255) |  |  |  | √ |  | 载具名称 |
| 4 | VehicleWeight | nvarchar | (10) |  |  |  |  |  | 载具重量 |
| 5 | VehicleUnitNo | nvarchar | (64) |  |  |  |  |  | 载具单位 |
| 6 | VehicleCapacity | numeric | (12,4) |  |  |  |  | 0 | 载具最大容量 |
| 7 | CapacityRules | numeric | (1,0) |  |  |  |  |  | 载容量规则：0：不限制1：仅提示2：不允许 |
| 8 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建者：数据创建人员 |
| 9 | CreateDate | datetime |  |  |  |  | √ |  | 创建时间：数据创建时间 |
| 10 | IssueState | numeric | (1,0) |  |  |  | √ | 0 | 数据状态：数据目前状态 |
| 11 | Description | nvarchar | (4000) |  |  |  | √ |  | 说明 |
| 12 | EDITOR | nvarchar | (50) |  |  |  | √ |  | 修改者：数据修改人员 |
| 13 | EDITDATE | datetime |  |  |  |  | √ |  | 修改时间：数据修改时间 |
| 14 | GUID | nvarchar | (50) |  |  |  | √ |  | 数据键值 |
| 1 | AREANO | nvarchar | (20) |  |  |  |  |  | 区域编号 |
| 2 | DEPARTMENTNO | nvarchar | (20) |  |  |  |  |  | 部门编号 |
| 3 | SHIFTNO | nvarchar | (20) |  |  |  |  |  | 班别编号 |
| 4 | USERNO | nvarchar | (30) | √ |  |  |  |  | 使用者编号 |
| 5 | LOGINCOMMENT | nvarchar | (255) |  |  |  | √ |  | 登入信息 |
| 6 | LOGINTIME | datetime |  |  |  |  |  |  | 登入时间 |
| 7 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 8 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 9 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
| 1 | FROMLOTNO | nvarchar | (50) | √ |  |  |  |  | 来源生产批号 |
| 2 | TOLOTNO | nvarchar | (50) |  |  |  |  |  | 目的生产批号 |
| 3 | LOTSERIAL | nvarchar | (55) |  |  |  | √ |  | 生产批流水号 |
| 4 | Creator | nvarchar | (50) |  |  |  | √ |  | 创建人员 |
| 5 | CreateDate | datetime |  |  |  |  | √ |  | 创建日期 |
| 6 | GUID | nvarchar | (50) |  |  |  | √ |  | 自动生成GUID |
