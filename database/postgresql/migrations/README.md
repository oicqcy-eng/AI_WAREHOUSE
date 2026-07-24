# 数据库迁移脚本

> 按业务域分目录管理数据库迁移

## 目录规范

```
migrations/
├── system/           # 系统管理相关
├── production/       # 生产管理
├── quality/          # 质量管理
├── equipment/        # 设备管理
├── material/         # 物料管理
├── work-order/       # 工单管理
├── andon/            # 安灯模块
├── iiot/             # IIoT 采集
└── ai/               # AI 平台（向量存储、推理日志等）
```

## 命名规范

```
YYYYMMDD_HHMMSS_description.sql
示例: 20260724_120000_create_users_table.sql
```

## 迁移工具推荐

| 场景 | 工具 |
|------|------|
| PostgreSQL | Sqitch / Flyway |
| 通用 | golang-migrate |
| K8s 原生 | SchemaHero |

## 执行迁移

### 手动

```bash
# 使用 psql 执行
PGPASSWORD=$POSTGRES_PASSWORD \
  psql -h localhost -U app_user -d ai_warehouse \
  -f migrations/system/V1__init_schema.sql
```

### 自动（启动时）

Docker Compose 已挂载 `migrations/` 到 PostgreSQL 的 `docker-entrypoint-initdb.d/`，
首次启动时自动执行。

> 注意: 生产环境不应依赖容器启动时自动迁移，
> 应使用专门的 CI/CD 步骤或迁移工具管理版本。
