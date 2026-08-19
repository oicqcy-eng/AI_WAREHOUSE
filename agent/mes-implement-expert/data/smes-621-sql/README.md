# smes-621 通用查询 SQL 资产库

> 鼎捷 sMES **通用查询 SQL** —— 产品自带/跨厂区通用，与 `data/smes-621/` 数据字典配套。
> 来源: 客户提供 SQL，2026-08 归档。原件保留在本地 `raw/` 原件区供追溯。

> ✅ **连通状态（2026-08-14 启用）**：本目录 SQL 已可在 **`sMES_Home_Prod`**（192.168.200.18，SQL Server 2019）上直接跑通。账号 `hwmes_read_user` 仅 `db_datareader`（CONNECT+SELECT，无写权限）；[不良原因-SQL.sql](不良原因-SQL.sql) 实测返回 10941 行真实数据。运行方式见 [`tools/query-mes.js`](../../tools/query-mes.js)（强制只读：仅 SELECT+行数封顶）。注：早期文档记录的 `sMES_Production_61100` 为鼎捷标准库命名，当前生产库实际名为 `sMES_Home_Prod`（该账号在服务器上可访问的唯一 sMES 库）。

> ⏰ **时区（2026-08-14 确认）**：sMES 库内时间戳为**北京时间**（服务器时区 UTC+8；`GETDATE()`/`GETUTCDATE()` 实测差 8 小时）。过滤日期直接 `CONVERT(CHAR(10), 时间字段, 120) = '2026-08-14'` 即可，无需时区换算。注意：mssql 驱动把 datetime 读回 JS 时可能显示成带 Z 的 UTC ISO 串（如 `2026-08-14T15:37:36.197Z`），那是驱动序列化假象，库内原始值仍是北京时间，以 SQL 端 `CONVERT` 输出为准。

> ⚠️ **体系边界**：本目录全部 SQL 均为**鼎捷 sMES**（现行系统）的查询，**与老 MES（玖坤）无关**。玖坤是华纬上一代旧系统，仓库中涉及玖坤的只有「设备点检表导出专项」（见 task T-970e6a2c96），两者不要混淆。

## 说明

- 本目录存放**通用查询**（无厂区/组织限定，纯按业务维度查询）
- **厂区限定**查询（绑定华纬某厂区）已分流到 `delivery/projects/hw-spring-mes/input/san-chang-xiao-huang/sql/`
- 每个 SQL 文件为独立查询，可直接复制执行；字段说明见文件内注释

## 连库沉淀策略（四类分层，2026-08-14 定版）

> 连库启用后，数据库资料**不一次性全库扫描沉淀**，按四类分层 + 用到即沉淀。
> 核心原则：**沉淀「资产」（表结构/模板/口径/链路知识），不沉淀「数据」（流水/明细/快照）**。

| 类别 | 例子 | 变化频率 | 策略 |
|------|------|:---:|------|
| ① 表结构/字典 | 表/字段/视图/存储过程 | 极慢 | **按需验证**（`INFORMATION_SCHEMA` 对照 `../smes-621/` 已有 189 表字典，差异补记）；不全量重扫 |
| ② 主数据/口径 | 设备前缀→厂区、工序、物料分类 | 低频 | **抽口径映射**（如 [`设备编号前缀-厂区映射.md`](设备编号前缀-厂区映射.md)）；⚠️ **2026-08-15 用户决策例外**：为对冲断连风险，设备/人员/工序三类主数据已**一次性全量快照**沉淀（[设备主数据清单.md](设备主数据清单.md)/[人员主数据清单.md](人员主数据清单.md)/[工序作业站字典.md](工序作业站字典.md)）；物料 3 万+ 不全量只抽口径 |
| ③ 业务流水 | 报工/工单/生产批/不良/点检 | 高频 | **坚决不沉淀**，用时现查、只出报表不落库 |
| ④ 查询知识 | 表关联链路/时区规则/字段取值口径 | 无 | **最高价值，必沉淀**（参数化模板 + 口径 + 链路注释，即本目录文件） |

**用到某模块时流程**：① `INFORMATION_SCHEMA` 验证表/字段 → ② 跑通查询、确认链路 → ③ 沉淀「怎么查」（参数化 SQL 模板）→ ④ 沉淀「怎么判」（口径映射）。流水数据只出报表，不写回本目录。

> 🔬 **口径验证方法**（2026-08-14 报工二轮审计提炼）：验证/审计口径时对照 [`docs/industry-knowledge/数据口径验证方法.md`](../../../../docs/industry-knowledge/数据口径验证方法.md)——四大高频坑（DISTINCT 合并漏算→GROUP BY 聚合、JOIN 侧时间未过滤→跨期污染、同名字段语义混淆→实测为准、验证结论过度泛化→带适用条件），报工 ⑤/⑥ 已按此修复。

**系统/厂区资产归属（独立系统不混入 Home 通用资产）**：重庆/无锡泽根 sMES 为独立服务器，其**主数据/流程口径单独沉淀**（重庆 → `delivery/projects/hw-spring-mes/input/c_q_mes/`），不并入本目录；`设备编号前缀-厂区映射.md` 是跨厂区**判定总表**，各厂区前缀行（含重庆 `EQ-CQSPR-*`）作为判定依据保留在其中，与详细主数据分开。

## 查询清单（21 个通用）

| 文件 | 查询内容 | 涉及核心表 |
|------|---------|-----------|
| [不良原因-SQL.sql](不良原因-SQL.sql) | 不良原因/例外分类汇总 | tblQCReasonBasis, tblWIPCont_Error, V_Q05 |
| [员工-SQL.sql](员工-SQL.sql) | 员工/设备工时统计 | tblWIPCont_Resource, TBLEQPEQUIPMENTBASIS |
| [子作业上下工时查询-SQL.sql](子作业上下工时查询-SQL.sql) | 子作业上下工时 | TBLWIPOPERATORLOG, TBLWIPLOTBASIS 等 |
| [子作业人员现况查询-SQL.sql](子作业人员现况查询-SQL.sql) | 子作业人员现况 | TBLWIPOPERATORSTATE, TBLWIPLOTSTATE 等 |
| [工单现况查询-SQL.sql](工单现况查询-SQL.sql) | 工单(MO)现况 | TBLOEMOBASIS, TBLWIPLOTBASIS, TBLWIPLOTSTATE |
| [成品序列号质量追溯-SQL.sql](成品序列号质量追溯-SQL.sql) | PCS 序号质量追溯 | TBLWIPCONT_PCSNO, TBLWIPFIRSTCHECK 等 |
| [標準參數表查詢-SQL.sql](標準參數表查詢-SQL.sql) | 注塑 Recipe 标准参数 | tblINJPhaseBasis, tblINJRecipeBasis |
| [模治具現況查詢-SQL.sql](模治具現況查詢-SQL.sql) | 模治具现状 | tblEQPAccessoryBasis, tblEMSAccessoryState |
| [模治具維修歷程查詢-SQL.sql](模治具維修歷程查詢-SQL.sql) | 模治具维修历程 | tblEMSACCLog_Repair, TBLEMSACCESSORYSTATE |
| [点检项目-SQL.sql](点检项目-SQL.sql) | 点检项目/清单 | tblWIPEQPQCListDetail, TBLWIPEQPQCLISTLOG |
| [物料-SQL.sql](物料-SQL.sql) | 物料耗用查询 | tblWIPCont_Material, tblWIPCont_MaterialLot |
| [生产批历程查询-SQL.sql](生产批历程查询-SQL.sql) | 生产批完整历程/过程追溯(开立/报工/暂停/分批/并批，**2026-08-19 参数化**: `-p lotno=MO1012608050057-001` 一条命令出全程; 客户原版在 raw/) | RPT_LotHistory_N, TBLWIPLOTLOG_REPORT, TBLWIPWAITBASIS, TBLWIPSPLITCONTENT, TBLWIPMERGECONTENT 等 |
| [生产批历程查询-SSMS直接执行.sql](生产批历程查询-SSMS直接执行.sql) | 同一查询的 **SSMS 手动版**(2026-08-19): 改文件顶部 `@lotno` 变量值即查任意批号，不依赖 AI 工具/命令行，直接整段 F5 执行 | 同左 |
| [生产批操作历程-SQL.sql](生产批操作历程-SQL.sql) | 生产批操作履历(开批/进出站/外包) | TBLWIPLOTBASIS, tblWIPCont_Partialin 等 |
| [订单工单查询-SQL.sql](订单工单查询-SQL.sql) | 订单/工单(RO/MO) | TBLOEROBASIS, TBLOEMOBASIS, TBLWIPLOTBASIS |
| [设备-SQL.sql](设备-SQL.sql) | 设备工时/数量统计 | tblWIPCont_Resource, TBLEQPEQUIPMENTBASIS |
| [设备生产查询-SQL.sql](设备生产查询-SQL.sql) | 设备生产情况(含 SMT 区域) | TBLWIPCONT_EQUIPMENT, TBLSMDAREABASIS 等 |
| [模治具寿命管理历程-SQL.sql](模治具寿命管理历程-SQL.sql) | 模治具寿命管理/状态历程(含寿命延长 AddLife/RealAddLife) | TBLEMSACCESSORYSTATELOG, TBLEQPACCSTATEBASIS, tblEQPAccessoryBasis, tblEQPAccessoryCategory |
| [物料-生产批使用历程-SQL.sql](物料-生产批使用历程-SQL.sql) | 物料耗用明细(生产批+工序 OPNO/OPNAME) | TBLWIPCONT_MATERIAL, TBLWIPCONT_MATERIALLOT, TBLWIPLOTLOG_REPORT, TBLOPBASIS |
| [今日设备报工查询-SQL.sql](今日设备报工查询-SQL.sql) | 按厂区设备前缀+日期查报工(**6 视角**：①累计 ②按天 ③明细 ④工单 ⑤人员 ⑥设备, 2026-08-14 重庆模式通用化; `-p prefix=101-01-DH -p date=2026-08-14`; date='' 全量) | TBLWIPCONT_EQUIPMENT, TBLWIPLOTLOG_REPORT, TBLWIPCont_Resource, TBLEQPEQUIPMENTBASIS, tblOPBasis, TBLPRDPRODUCTBASIS, TBLUSRUSERBASIS |
| [报工完成度与漏报分析-SQL.sql](报工完成度与漏报分析-SQL.sql) | 报工流程完成度/漏出站(**6 视角**：①完成度总览 ②当日未完结明细 ③滞留清单 ④按设备 ⑤按工序 ⑥按天趋势; 进行中判据=L.ENDTIME 空, `-p prefix= -p date=`; 一厂 8-14 对账 27条/80,244) | TBLWIPCONT_EQUIPMENT, TBLWIPLOTLOG_REPORT, TBLEQPEQUIPMENTBASIS, tblOPBasis |
| [点检记录查询-SQL.sql](点检记录查询-SQL.sql) | 设备点检执行情况(**6 视角**：①概览 ②按设备 ③记录明细 ④项目明细 ⑤NG清单 ⑥按天趋势; QCRESULT 0=OK/1=NG, QCTYPE 0标准值/1范围值/2显示信息/3输入数据, `-p prefix= -p date=`; 替换客户旧「点检项目-SQL.sql」) | TBLWIPEQPQCLISTLOG, tblWIPEQPQCListDetail, TBLEQPEQUIPMENTBASIS |
| [发料查询-SQL.sql](发料查询-SQL.sql) | 工单材料领料/缺料核对(标准用量×工单数=理论领料, U9需求REQUIREQTY vs 已领ORGMATERIALQTY, `-p mono=`; 首站扫码上料报"条码不存在MES"排查核心, 用户提供) | Tbloemomateriallist, Tbloemobasis |

## 报工报表规范（2026-08-14 定版，重庆模式通用化）

各 sMES 厂区「报工查询 → 报表」按 [`厂区报工报表规范.md`](厂区报工报表规范.md) 输出：**分层**（通用模板/厂区实例/厂区报表）+ **7 节板块**（元数据头/累计/按天/明细/人员/工单/观察）+ 厂区定制维度（重庆按产线、一厂大簧按设备）。实例见一厂大簧报表 `delivery/projects/hw-spring-mes/output/yi_chang_da_huang/2026-08-14_一厂大簧报工数据报表.md`。

## 主数据沉淀（2026-08-15，断连对冲）

用户决策：连库可能断，低频主数据**全量沉淀**为离线清单。断连后照常查设备/人员/工序/部门/作业流程（产品→流程）。

| 资产 | 内容 | 规模 |
|------|------|:---:|
| [设备主数据清单.md](设备主数据清单.md) | 设备全量按厂区类别分节（本部 756 台 + 重庆 98 台） | 854 |
| [人员主数据清单.md](人员主数据清单.md) | 工号/姓名/部门/状态（本部 2984 + 重庆 516） | 3500 |
| [工序作业站字典.md](工序作业站字典.md) | 工序码/名/工艺类型（本部 139 + 重庆 22） | 161 |
| [部门主数据清单.md](部门主数据清单.md) | 部门层级解码表（本部 441 + 重庆 529，ERP 同步） | 970 |
| [作业流程字典.md](作业流程字典.md) | 作业流程主档（本部 153 当前版+重庆 7）+ 产品→流程绑定（5432+52）+ 工序区域映射（173+26） | 5835 |
| [主数据画像总览.md](主数据画像总览.md) | 规模表 + 物料编码规则口径（前缀/类型/单位解码，**物料不全量**）+ 重跑刷新方法 + 审计遗漏评估 | — |
| [连库手册.md](连库手册.md) | 服务器拓扑/账号/工具/断连排查/重建步骤（密码不入库） | — |

## 使用

- 查表结构/字段口径 → `../smes-621/` 数据字典
- 查可直接跑的查询 → 本目录对应文件
- 判设备归属厂区 → [`设备编号前缀-厂区映射.md`](设备编号前缀-厂区映射.md)（前缀维度）+ [`设备主数据清单.md`](设备主数据清单.md)（EQUIPMENTTYPE 厂区类别维度，**2026-08-15 库内实测 756 台**，2026-08-12 Excel 台账 752 台以库内为准）
- 断连后查主数据 → 上表「主数据沉淀」五件套
- 厂区报工报表 → 通用模板 + [`厂区报工报表规范.md`](厂区报工报表规范.md)（见上）
- 引用方式: 回答查询类问题时查 `[smes-621-sql]`
