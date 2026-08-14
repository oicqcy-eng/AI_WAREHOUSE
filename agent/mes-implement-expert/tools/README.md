# tools — 工具能力

**MES实施专家** 可调用的外部工具清单。工具是 Agent 的「手」：查询真实数据、生成交付物。

## 工具清单

| 工具ID | 类型 | 用途 | 依赖/指向 |
|--------|------|------|-----------|
| `mes_query` | 只读查询 | 查询鼎华SMES业务数据（工单/报工/质量） | MES 数据库只读账号 |
| `sql_query` | 只读SQL | 通用只读 SQL 查询 | `shared/database/` 只读连接 |
| `report_generate` | 文档生成 | 生成方案/蓝图/差距分析文档 | `delivery/projects/<项目>/output/` 输出 |
| `excel_export` | 导出 | 交付物导出 Excel | 生成后落 `delivery/projects/<项目>/output/` |
| `checklist_check` | 内部 | 实施就绪度清单校验 | 关联 `knowledge/sop.md` |

## 权限与审计

- **最小权限**: 默认全部只读；写操作（生成/导出）只落 `delivery/projects/<项目>/output/`
- **审计**: 每次工具调用记录 工具ID + 入参摘要 + 时间（入运营日志 `docs/` 或运行层）
- **禁止**: 不提供删除/覆盖线上数据能力；不接触客户密钥

## SQL 查询模板

预置只读查询模板见 `query-templates.sql`，供 `sql_query`/`mes_query` 使用。

## MES 只读查询运行器（query-mes.js）

`query-mes.js` 是 sMES（SQL Server）库的**只读**查询入口，硬约束：
- **仅允许 `SELECT`**：首关键字非 SELECT、或全文含写关键字（INSERT/UPDATE/DELETE/DROP/ALTER/EXEC/TRUNCATE 等）一律在连库前拒绝
- **行数封顶**：默认只显示前 100 行，防止大表拉爆
- **凭据不入库**：连接配置读 `config/db.local.json`（gitignore）或环境变量 `MES_DB_*`

用法：
```bash
node tools/query-mes.js <file.sql>                 # 跑 smes-621-sql/ 下的 SQL 模板
node tools/query-mes.js -q "SELECT TOP 10 * FROM tblQCReasonBasis"
node tools/query-mes.js <file.sql> --limit 500 -p schema=dbo -p start_date=2026-08-01
node tools/query-mes.js <file.sql> --out result.csv   # 导出 CSV
```

## 维护规范

1. 新增工具在 `config/agent.yaml` 的 `tools_enabled` 白名单中登记
2. 工具变更需在 `runbooks/` 中同步维护文档
3. SQL 模板统一只读（`SELECT`），含 `LIMIT` 防大表扫描
