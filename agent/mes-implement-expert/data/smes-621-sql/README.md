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
| ② 主数据/口径 | 设备前缀→厂区、工序、物料分类 | 低频 | **抽口径映射**（如 [`设备编号前缀-厂区映射.md`](设备编号前缀-厂区映射.md)），不存全量快照 |
| ③ 业务流水 | 报工/工单/生产批/不良/点检 | 高频 | **坚决不沉淀**，用时现查、只出报表不落库 |
| ④ 查询知识 | 表关联链路/时区规则/字段取值口径 | 无 | **最高价值，必沉淀**（参数化模板 + 口径 + 链路注释，即本目录文件） |

**用到某模块时流程**：① `INFORMATION_SCHEMA` 验证表/字段 → ② 跑通查询、确认链路 → ③ 沉淀「怎么查」（参数化 SQL 模板）→ ④ 沉淀「怎么判」（口径映射）。流水数据只出报表，不写回本目录。

**系统/厂区资产归属（独立系统不混入 Home 通用资产）**：重庆/无锡泽根 sMES 为独立服务器，其**主数据/流程口径单独沉淀**（重庆 → `delivery/projects/hw-spring-mes/input/c_q_mes/`），不并入本目录；`设备编号前缀-厂区映射.md` 是跨厂区**判定总表**，各厂区前缀行（含重庆 `EQ-CQSPR-*`）作为判定依据保留在其中，与详细主数据分开。

## 查询清单（18 个通用）

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
| [生产批历程查询-SQL.sql](生产批历程查询-SQL.sql) | 生产批完整历程(报工/工序) | RPT_LotHistory_N, TBLWIPLOTLOG_REPORT 等 |
| [生产批操作历程-SQL.sql](生产批操作历程-SQL.sql) | 生产批操作履历(开批/进出站/外包) | TBLWIPLOTBASIS, tblWIPCont_Partialin 等 |
| [订单工单查询-SQL.sql](订单工单查询-SQL.sql) | 订单/工单(RO/MO) | TBLOEROBASIS, TBLOEMOBASIS, TBLWIPLOTBASIS |
| [设备-SQL.sql](设备-SQL.sql) | 设备工时/数量统计 | tblWIPCont_Resource, TBLEQPEQUIPMENTBASIS |
| [设备生产查询-SQL.sql](设备生产查询-SQL.sql) | 设备生产情况(含 SMT 区域) | TBLWIPCONT_EQUIPMENT, TBLSMDAREABASIS 等 |
| [模治具寿命管理历程-SQL.sql](模治具寿命管理历程-SQL.sql) | 模治具寿命管理/状态历程(含寿命延长 AddLife/RealAddLife) | TBLEMSACCESSORYSTATELOG, TBLEQPACCSTATEBASIS, tblEQPAccessoryBasis, tblEQPAccessoryCategory |
| [物料-生产批使用历程-SQL.sql](物料-生产批使用历程-SQL.sql) | 物料耗用明细(生产批+工序 OPNO/OPNAME) | TBLWIPCONT_MATERIAL, TBLWIPCONT_MATERIALLOT, TBLWIPLOTLOG_REPORT, TBLOPBASIS |
| [今日设备报工查询-SQL.sql](今日设备报工查询-SQL.sql) | 按厂区设备前缀+日期查当日报工(汇总/明细/按工单3视角, `-p prefix=101-01-DH -p date=2026-08-14`) | TBLWIPCONT_EQUIPMENT, TBLWIPLOTLOG_REPORT, TBLEQPEQUIPMENTBASIS, tblOPBasis, TBLPRDPRODUCTBASIS |

## 使用

- 查表结构/字段口径 → `../smes-621/` 数据字典
- 查可直接跑的查询 → 本目录对应文件
- 判设备归属厂区 → [`设备编号前缀-厂区映射.md`](设备编号前缀-厂区映射.md)（华纬全厂设备，752 台，2026-08-12 提炼）
- 引用方式: 回答查询类问题时查 `[smes-621-sql]`
