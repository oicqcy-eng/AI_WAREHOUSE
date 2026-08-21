# file_index — U9 ERP 接口查询 SQL

> 归档来源: `delivery/inbox/SQL/U9_ERP发料查询SQL.docx` · 归档日期: 2026-08-10 · 状态: 已归档（复制，原件保留 inbox）

## U9 接口查询（3 个）→ `data/u9-sql/`

| # | 文件 | 类型 | 归档位置 | 状态 |
|---|------|------|----------|:----:|
| 1 | U9_ERP发料查询-SQL.sql | SQL-U9接口 | `data/u9-sql/` | ✓ |
| 2 | U9C_IQC到货单查询-SQL.sql | SQL-U9C接口 | `data/u9-sql/` | ✓ |
| 3 | U9C数据库字典-基础.md | U9C字典 | `data/u9-sql/` | ✓ |
| 4 | U9C核心链路-表结构与排障.md | U9C链路手册（断连对冲） | `data/u9-sql/` | ✓ |

## 备注

- U9（用友 ERP）与 sMES（鼎捷）是两套不同数据库体系，查询分目录存放
- 敏感信息检查：查询文件无连接串/账号/密码/IP；含跨库库名（`MES`/`sMES_Home_Prod`），仅作表定位用，无连接凭据
- **2026-08-21 U9C 连库启用**：服务器 192.168.200.16/HWAWAYU9CDB（SQL Server 2019），连接走 `--profile u9c`（凭据在 `config/db.local.json`，gitignore 不入库）；首次实测发现 `esb_iqc_receipt_outbox` IQC 到货单同步队列（含 8-21 测试单 TEST-IQC-20260821-001）
- 后续 U9 侧新增查询（如领料/入库/条码相关接口）追加到本目录
