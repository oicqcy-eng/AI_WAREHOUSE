# sMES 核心链路 · 表结构与断连排障手册

> **系统**：鼎捷 sMES 共库（`192.168.200.18/sMES_Home_Prod`，`--profile home`；重庆/无锡泽根独立库同名表 `--profile cq`）｜ **账号**：`hwmes_read_user`（db_datareader 只读）
> **定位**：断连对冲资产 —— **表结构 + 结果逻辑已固化，数据库连不上也能判断链路、定位排查环节**。表结构查 [../smes-621/](../smes-621/README.md) 189 表/12,866 字段完整字典，本手册只做**链路编排 + 判据 + 排障环节**。
> **编制日期**：2026-08-21（配合 U9C 侧 [U9C核心链路-表结构与排障.md](../../u9-sql/U9C核心链路-表结构与排障.md)，两册合看 = 跨系统全链路）

---

## 〇、五条核心链路总览（断连先看这张图）

```
① 报工链路  工单 MO → 生产批开立 → 设备进出站报工 → 日结/暂存 → 报工单抛转
② 权限链路  用户主档 → 群组关联 → 群组权限编号(PRIVTYPE) → 菜单/按钮渲染
③ 生产批链路 工单 → 生产批开立 → 进出站 → 暂停/分批/并批 → 完成（全程 TBLWIPLOTLOG_REPORT）
④ 点检链路  设备 → 点检项目清单 → 点检执行记录(QCRESULT) → 点检闭环
⑤ 发料/扫码 工单材料(需求vs已领) → 扫码上料状态 → 报工进站消耗（跨 U9C：MO_MOPickList→发料队列）
```

五条链路关键表如下（字段明细都在 `../smes-621/` 字典，此处只给链路语义）：

| 链路 | 关键表（字典模块） | 判读核心 |
|------|------------------|---------|
| 报工 | `TBLOEMOBASIS`(工单) → `TBLWIPLOTBASIS`(生产批) → `TBLWIPCONT_EQUIPMENT`(设备报工) + `TBLWIPLOTLOG_REPORT`(批日志) + `TBLWIPCont_Resource`(工时) + `TBLEQPEQUIPMENTBASIS`(设备) + `tblOPBasis`(工序) + `TBLPRDPRODUCTBASIS`(产品) + `TBLUSRUSERBASIS`(用户) | **进行中 = 日志 ENDTIME 空** |
| 权限 | `TBLUSRUSERBASIS` → `TBLUSRUSERGROUP` → `TBLUSRGROUPBASIS` → `TBLUSRGROUPPRIV` → `TBLUSRGROUPPRIVCONTROL` | **PRIVTYPE：9=菜单 / 0=平台 / 8=按钮** |
| 生产批 | `TBLWIPLOTBASIS` + `TBLWIPLOTSTATE` + `TBLWIPLOTLOG_REPORT` + `RPT_LotHistory_N`(历程视图) + `TBLWIPSPLITCONTENT`(分批) + `TBLWIPMERGECONTENT`(并批) + `TBLWIPWAITBASIS`(暂停) | **BASELOTNO = 工单号 + '-NNN'** |
| 点检 | `TBLEQPEQUIPMENTBASIS` → `tblWIPEQPQCListDetail`(项目明细) → `TBLWIPEQPQCLISTLOG`(执行记录) | **QCRESULT 0=OK/1=NG；QCTYPE 0标准值/1范围值/2显示信息/3输入数据** |
| 发料 | `Tbloemobasis` → `Tbloemomateriallist`(需求vs已领) → `TBLWIPEQPMATERIALSTATE`(扫码上料) → `TBLWIPCONT_MATERIAL`(进站消耗) | **REQUIREQTY>0 且 ORGMATERIALQTY=0 → 未发料** |

---

## 一、报工链路（今日报工/漏报排查）

### 环节与排障点

| 环节 | 关键表 | 数据怎么走 | 断连排查点 |
|------|--------|-----------|----------|
| ① 工单建立 | `TBLOEMOBASIS`（MO 主档，08-andon 模块） | 工单 → 生产批开立 | 工单/生产批查得到吗？ |
| ② 生产批开立 | `TBLWIPLOTBASIS`（批主档，01-wip 模块）+ `TBLWIPLOTSTATE` | BASELOTNO=MONO+'-NNN' | 批号前缀=工单号？ |
| ③ 设备报工 | `TBLWIPCONT_EQUIPMENT`（设备报工组/记录） | 进站→出站报工，写设备报工记录 | **主查**：报工记录有没有？ |
| ④ 批日志落库 | `TBLWIPLOTLOG_REPORT`（批日志，含进出站事件） | 每动作一条日志，ENDTIME=出站时间 | **进行中判据 = ENDTIME 空**（漏出站=还停在工序上） |
| ⑤ 资源/产品/人员归集 | `TBLWIPCont_Resource`(工时) + `TBLPRDPRODUCTBASIS`(产品) + `tblOPBasis`(工序) + `TBLUSRUSERBASIS`(人员) | 报工绑定设备/产品/工序/人员维度 | 报工行缺维度 → 报表归集不到 |
| ⑥ 日结/抛转 | 02-wip-daily 模块（日结报工/每日暂存/报工单抛转） | 日结后转成本/ERP | 日结差异（人员/机时/批次区间） |

### 判据与工具
- **进行中**：`TBLWIPLOTLOG_REPORT.ENDTIME IS NULL`（报工完成度模板 [报工完成度与漏报分析-SQL.sql](报工完成度与漏报分析-SQL.sql)）
- **报工取数**：[今日设备报工查询-SQL.sql](今日设备报工查询-SQL.sql)（6 视角：累计/按天/明细/工单/人员/设备；`-p prefix=<厂区设备前缀> -p date=YYYY-MM-DD`，date='' 全量；**按人员必须限定 LOGGROUPSERIAL ∈ 厂区报工组**，共库多厂区并存）
- **厂区限定**：按 `设备编号前缀-厂区映射.md` 判厂区（一厂大簧 `101-01-DH`、三厂小簧等）；厂区专属查询在 `input/<厂区>/sql/`
- **口径验证**：见 [数据口径验证方法.md](../../../../docs/industry-knowledge/数据口径验证方法.md)（GROUP BY 防 DISTINCT 漏算 / JOIN 双侧时间过滤）

## 二、权限链路（H5 看不到功能/派工无按钮）

### 环节与排障点

| 环节 | 关键表 | 数据怎么走 | 断连排查点 |
|------|--------|-----------|----------|
| ① 用户主档 | `TBLUSRUSERBASIS` | 用户在系统存在 | 用户存在吗？状态正常？ |
| ② 群组关联 | `TBLUSRUSERGROUP` | 用户挂在作业群组 | 关联群组了吗？ |
| ③ 群组权限编号 | `TBLUSRGROUPPRIV` | 群组配了哪些权限编号 | **主查**：权限编号配全了吗？缺哪个 PRIVTYPE？ |
| ④ 菜单/按钮渲染 | `TBLUSRGROUPPRIVCONTROL`(控件禁用) + H5 端映射 | 权限编号 → 前端菜单/按钮 | 控件被禁用了？ |

### 判据与工具
- **PRIVTYPE**：`9=菜单 / 0=平台 / 8=按钮`（[用户权限查询-SQL.sql](用户权限查询-SQL.sql) ③群组权限明细视角）
- **排障结论（2026-08-21 三厂小簧实测归纳，HW0396 对照根因）**：`SCXH-PLN001` 只配了平台权限编号（PRIVTYPE=0），**缺 A 系列菜单权限编号（PRIVTYPE=9，A07 派工作业等全缺）→ H5 派工调度中心不渲染**。修正=补齐菜单权限编号，**不是刷新问题**（早前「刷新没出来」结论作废）。模板 SQL 注释已同步（见 [用户权限查询-SQL.sql](用户权限查询-SQL.sql) 头部）
- **权限编号速查**：[../smes-621/h5-作业群组权限清单.md](../smes-621/h5-作业群组权限清单.md)（13 模块 277 项 + 手机报工 38 项，菜单权限编号 ↔ 在线报工平台权限编号映射）

## 三、生产批链路（历程/追溯）

### 环节与排障点

| 环节 | 关键表 | 数据怎么走 | 断连排查点 |
|------|--------|-----------|----------|
| ① 开立 | `TBLWIPLOTBASIS` + `RPT_LotHistory_N` | 工单拆生产批，BASELOTNO=MONO+'-NNN' | 批号在哪？BASELOTNO 前缀=工单号？ |
| ② 进出站 | `TBLWIPLOTSTATE` + `TBLWIPLOTLOG_REPORT` | 每站进出记日志 | 缺哪一站日志 = 那站没报工 |
| ③ 暂停/等待 | `TBLWIPWAITBASIS` | 暂停原因/时段 | 卡在暂停？等待原因？ |
| ④ 分批 | `TBLWIPSPLITCONTENT` | 拆分子批 | 分批量与原批对得上？ |
| ⑤ 并批 | `TBLWIPMERGECONTENT` | 合并批 | 合并后追溯还连得上？ |
| ⑥ 完成 | `TBLWIPLOTSTATE` 状态流转 | 完工/结案 | 状态停在哪个环节？ |

### 判据与工具
- **一条命令出全程**：[生产批历程查询-SQL.sql](生产批历程查询-SQL.sql)（`-p lotno=MO1012608050057-001`，开立/报工/暂停/分批/并批全历程）
- **SSMS 手动版**：[生产批历程查询-SSMS直接执行.sql](生产批历程查询-SSMS直接执行.sql)（改顶部 `@lotno` 整段 F5，不依赖工具）
- **补充**：[生产批操作历程-SQL.sql](生产批操作历程-SQL.sql)（进出站/外包）、[工单现况查询-SQL.sql](工单现况查询-SQL.sql)、[订单工单查询-SQL.sql](订单工单查询-SQL.sql)、[物料-生产批使用历程-SQL.sql](物料-生产批使用历程-SQL.sql)（带工序的物料耗用）

## 四、点检链路（设备点检闭环）

### 环节与排障点

| 环节 | 关键表 | 数据怎么走 | 断连排查点 |
|------|--------|-----------|----------|
| ① 点检项目配置 | `tblWIPEQPQCListDetail` | 设备→点检项目/清单 | 项目配置了吗？（空=没配点检项） |
| ② 点检执行 | `TBLWIPEQPQCLISTLOG` | 执行点检，记 QCRESULT | 记录存在吗？QCRESULT 是否 NG？ |
| ③ 闭环判定 | QCTYPE + QCRESULT | 标准值/范围值判定 OK/NG | NG 项有无处置？点检表是否闭环 |

### 判据与工具
- **QCRESULT**：`0=OK / 1=NG`；**QCTYPE**：`0标准值 / 1范围值 / 2显示信息 / 3输入数据`（[点检记录查询-SQL.sql](点检记录查询-SQL.sql)）
- **6 视角**：①概览 ②按设备 ③记录明细 ④项目明细 ⑤NG 清单 ⑥按天趋势（`-p prefix= -p date=`）
- **注意**：本模板**替换**客户旧「点检项目-SQL.sql」（旧版仅项目清单，无执行记录视角）
- 相关任务 T-970e6a2c96（点检表 8-19 闭环）——点检闭环进度查任务池

## 五、发料 / 扫码上料链路（首站报「条码不存在 MES」排查核心）

### 环节与排障点（sMES 侧；U9C 侧见 [U9C手册](../../u9-sql/U9C核心链路-表结构与排障.md) 三）

| 环节 | 关键表 | 数据怎么走 | 断连排查点 |
|------|--------|-----------|----------|
| ① 工单材料需求 | `Tbloemobasis`(工单) → `Tbloemomateriallist`(材料清单) | U9C 发料需求 → sMES 材料表 | `REQUIREQTY`(U9需求) 有没有？ |
| ② 领料 | `Tbloemomateriallist.ORGMATERIALQTY` | 已领料数量 | **主查**：REQUIREQTY>0 且 ORGMATERIALQTY=0 → 未发料/未同步（报「条码不存在」） |
| ③ 扫码上料 | `TBLWIPEQPMATERIALSTATE` | 首站扫码，写已上料 InputQty | 上料差异 (InputQty−Qty)≠0 → 数量/绑定对不上 |
| ④ 报工进站消耗 | `TBLWIPCONT_MATERIAL` | 进站实际扣料 USEQTY | 消耗 < 需求 → 上料未执行或绑定异常 |

### 判据与工具
- **⚠️ 别用 `TBLOEMOMATERIALINBASIS_ERP` 查发料**（另一链路表，会误导「0 条=没同步」）——发料核对走 `Tbloemomateriallist`（[发料查询-SQL.sql](发料查询-SQL.sql) ①，`-p mono=工单号`）
- **TBLWIPEQPMATERIALSTATE 注意**：一条原料批次按设备各一行（同批分多设备），勿用 COUNT 当批次数；时间线看 `ReviseDate`（CreateDate 多为 NULL）
- **TBLWIPCONT_MATERIAL 注意**：`LOTSERIAL`=原料批次序列号（**非生产批**）；生产批号在 `LOGGROUPSERIAL` 前缀，`LOGGROUPSERIAL LIKE BASELOTNO+'%'` 汇总
- **三视角闭环**：①需求/已领 → ②扫码上料 → ③进站消耗；排障卡 `delivery/projects/hw-spring-mes/ops-knowledge/`（首站扫码上料 8-15「条码不存在」/ 8-16 上料量核对）

---

## 六、通用排障套路（断连也能用）

1. **先判链路段**：报工/权限/生产批/点检/发料五链路，每段一个表，按环节表逐段排除——先看数据有没有、再看状态卡在哪、最后看口径对不对
2. **判据优先于枚举**：任何链路先对照本手册「判读核心」（ENDTIME 空=进行中、REQUIREQTY>0 且 ORGMATERIALQTY=0=未发料、PRIVTYPE=9 缺=菜单不渲染、QCRESULT=1=NG），一列即定位
3. **字段口径**：BASELOTNO=MONO+'-NNN'、LOGGROUPSERIAL 是生产批组（非批号）、LOTSERIAL 是原料批次——串错字段就是全链路查不出
4. **断连期**：表结构查 `../smes-621/` 189 表字典，链路/判据查本手册，查询模板参数化命令可离线推演；实时确认需 DBA 提供当时数据快照

## 关联资产

- 表结构字典：[../smes-621/README.md](../smes-621/README.md)（189 表/8 模块/12,866 字段）｜ 权限清单：[../smes-621/h5-作业群组权限清单.md](../smes-621/h5-作业群组权限清单.md)
- 查询模板：本目录 `README.md`「查询清单」22 个（本文已逐链路指路）｜ 主数据断连五件套：设备/人员/工序/部门/作业流程（见本目录 README「主数据沉淀」）
- 跨系统：U9C 侧 [U9C核心链路-表结构与排障.md](../../u9-sql/U9C核心链路-表结构与排障.md)｜ 连库本身：[连库手册.md](连库手册.md)
- 待验证项：日结/抛转链路（02-wip-daily 表）、点检 QCTYPE 各取值实际数据、生产批并批追溯完整性
