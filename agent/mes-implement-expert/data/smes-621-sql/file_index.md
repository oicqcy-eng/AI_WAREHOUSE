# file_index — smes-621 通用查询 SQL

> 归档来源: `delivery/inbox/SQL/` · 归档日期: 2026-08-06 · 状态: 已归档（复制，原件保留 inbox）

## 通用查询（17 个）→ `data/smes-621-sql/`

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

## 厂区限定（3 个）→ `delivery/projects/san-chang-xiao-huang/input/sql/`

| # | 文件 | 类型 | 限定厂区 | 归档位置 | 状态 |
|---|------|------|---------|----------|:----:|
| 17 | 大簧生產批現況查詢-SQL.sql | SQL-厂区限定 | 华纬一厂大簧（设备前缀 101-01-DH / PROCESSTYPE=弹簧流程） | `projects/san-chang-xiao-huang/input/sql/` | ✓ |
| 18 | 稳定杆生產批現況查詢-SQL.sql | SQL-厂区限定 | 华纬稳定杆厂（PROCESSTYPE=稳定杆流程） | `projects/san-chang-xiao-huang/input/sql/` | ✓ |
| 19 | 金晟-生產批現況查詢-SQL.sql | SQL-厂区限定 | 华纬金晟厂（主要产品稳定杆 / PROCESSTYPE=金晟流程） | `projects/san-chang-xiao-huang/input/sql/` | ✓ |

## 备注

- 判定依据：文件名/注释/`PROCESSTYPE` 限定条件（弹簧/稳定杆/金晟流程）→ 厂区专属；其余按业务维度查询 → 通用
- 敏感信息检查：全部 20 个文件**无**连接串/账号/密码/IP/库名
