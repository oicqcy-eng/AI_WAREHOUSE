# file_index — smes-621 通用查询 SQL

> 归档来源: `delivery/inbox/SQL/` + `delivery/inbox/`（2026-08-14 追加 2 份）· 归档日期: 2026-08-06 · 状态: 已归档（复制，原件保留 inbox）

## 通用查询（18 个）→ `data/smes-621-sql/`

| # | 文件 | 类型 | 归档位置 | 状态 |
|---|------|------|----------|:----:|
| 1 | 不良原因-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 2 | 员工-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 3 | 子作业上下工时查询-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 4 | 子作业人员现况查询-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 5 | 工单现况查询-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 6 | 成品序列号质量追溯-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 7 | 標準參數表查詢-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 8 | 模治具現況查詢-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 9 | 模治具維修歷程查詢-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 10 | 点检项目-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 11 | 物料-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 12 | 生产批历程查询-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 13 | 生产批操作历程-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 14 | 订单工单查询-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 15 | 设备-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 16 | 设备生产查询-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 17 | 模治具寿命管理历程-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |
| 18 | 物料-生产批使用历程-SQL.sql | SQL-通用 | `data/smes-621-sql/` | ✓ |

## 厂区限定（3 个）→ `delivery/projects/hw-spring-mes/input/san-chang-xiao-huang/sql/`

| # | 文件 | 类型 | 限定厂区 | 归档位置 | 状态 |
|---|------|------|---------|----------|:----:|
| 17 | 大簧生產批現況查詢-SQL.sql | SQL-厂区限定 | 华纬一厂大簧（设备前缀 101-01-DH / PROCESSTYPE=弹簧流程） | `projects/hw-spring-mes/input/san-chang-xiao-huang/sql/` | ✓ |
| 18 | 稳定杆生產批現況查詢-SQL.sql | SQL-厂区限定 | 华纬稳定杆厂（PROCESSTYPE=稳定杆流程） | `projects/hw-spring-mes/input/san-chang-xiao-huang/sql/` | ✓ |
| 19 | 金晟-生產批現況查詢-SQL.sql | SQL-厂区限定 | 华纬金晟厂（主要产品稳定杆 / PROCESSTYPE=金晟流程） | `projects/hw-spring-mes/input/san-chang-xiao-huang/sql/` | ✓ |

## 断连对冲沉淀（非 inbox 归档，AI 连库实测编制）

| 文件 | 类型 | 说明 |
|------|------|------|
| `sMES核心链路-表结构与排障.md` | 链路手册 | 五链路（报工/权限/生产批/点检/发料）编排 + 判据 + 排障环节；配合 `../smes-621/` 192 表字典 + 本目录查询模板，断连也能判断链路、定位环节（2026-08-21 编制） |
| `sMES全量表清单.md` + `.csv` | 表清单 | 1472 表断连地图 + 与 192 字典差异分析（1281 未覆盖 → 68 核心表已补录结构，其余按需沉淀）（2026-08-21 实测，2026-08-23 甄审表数口径修正） |
| `发料查询-SQL-SSMS直接执行.sql` | SSMS 手动版 | 发料问题查询的 SSMS 直接执行版（`@mono` 变量整段 F5），2026-08-21 找回生成，对应模板 `发料查询-SQL.sql`（8-16 三视角） |

## 备注

- 判定依据：文件名/注释/`PROCESSTYPE` 限定条件（弹簧/稳定杆/金晟流程）→ 厂区专属；其余按业务维度查询 → 通用
- 敏感信息检查：全部 25 个查询文件**无**连接串/账号/密码/IP/库名（08-21 检查时为 22，后续新增 3 个 SSMS/权限模板已复核）
- 2026-08-14 追加 2 份（源 `delivery/inbox/`，原件保留 inbox + raw/）：
  - `模治具寿命管理历程-SQL.sql` 查 `TBLEMSACCESSORYSTATELOG` 状态/寿命历程（含 AddLife/RealAddLife），与「模治具維修歷程查詢」（tblEMSACCLog_Repair 维修日志）**不同维度，新增**
  - `物料-生产批使用历程-SQL.sql` 为「物料-SQL.sql」的**带工序变体**（多 TBLOPBASIS 出 OPNO/OPNAME，轻量版）
- 2026-08-16 `发料查询-SQL.sql` 扩展为**三视角**（8-15 首版仅①发料核对；8-16 用户投喂 4 张截图 + 连库实测补②③）：
  - ①发料核对（`Tbloemomateriallist`+`Tbloemobasis`，U9 需求/已领/缺料）——「条码不存在 MES」主查
  - ②扫码上料状态（`TBLWIPEQPMATERIALSTATE`，17列，InputQty 已上料 vs Qty 需求、InputMaterialNo/MaterialLotNo/设备/OPNo=LOTCREATE）——上料数量对不上时查，排障卡 `ops-knowledge/2026-08-16_一厂大簧_sMES_扫码上料数量核对.md`
  - ③报工进站核对（`TBLWIPCONT_MATERIAL` 按 LOGGROUPSERIAL 前缀=生产批汇总 USEQTY，对比①需求/已领）——实际扣料 vs 理论需求闭环
