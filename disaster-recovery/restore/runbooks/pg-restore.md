# PostgreSQL 灾难恢复手册

> **版本**: v1.0
> **场景**: 数据库损坏 / 误删除 / 数据回滚
> **RTO**: 30分钟 | **RPO**: 24小时

---

## 1. 恢复方案选择

| 场景 | 方案 | 预期耗时 |
|------|------|---------|
| 误删数据（最近） | 基于时间点恢复（PITR） | 10-30分钟 |
| 表损坏/索引损坏 | 从备份恢复 | 10-20分钟 |
| 整个实例损坏 | 重建实例 + 恢复备份 | 30-60分钟 |
| 灾难级（机房故障） | 异地备份恢复 | 1-4小时 |

---

## 2. 从备份恢复

### 2.1 查找可用备份

```bash
# 列出所有备份
ls -lh /data/backup/postgresql/*.sql.gz

# 查看备份时间
ls -t /data/backup/postgresql/*.sql.gz | head -5
```

### 2.2 恢复步骤

```bash
# 1. 停止应用服务（避免写入）
docker compose stop manufacturing
docker compose stop vllm

# 2. 恢复数据库
gunzip -c /data/backup/postgresql/ai_warehouse_20260724_020000.sql.gz | \
  PGPASSWORD=$POSTGRES_PASSWORD \
  pg_restore \
    -h localhost \
    -p 5432 \
    -U app_user \
    -d ai_warehouse \
    --clean \
    --if-exists \
    --verbose

# 3. 验证恢复
PGPASSWORD=$POSTGRES_PASSWORD \
  psql -h localhost -U app_user -d ai_warehouse \
  -c "SELECT count(*) FROM information_schema.tables;"

# 4. 重建索引
PGPASSWORD=$POSTGRES_PASSWORD \
  reindexdb -h localhost -U app_user -d ai_warehouse

# 5. 启动应用
docker compose start manufacturing
docker compose start vllm

# 6. 验证业务
./cicd/scripts/health-check.sh
```

---

## 3. 基于时间点恢复（PITR）

### 3.1 前提条件

- 开启了 WAL 归档
- 有基础备份 + 连续的 WAL 日志

### 3.2 恢复步骤

```bash
# 1. 停止数据库
docker compose stop postgres

# 2. 清空数据目录
rm -rf /data/postgres/data/*
cp -r /data/backup/postgresql/base_backup/* /data/postgres/data/

# 3. 配置恢复目标
cat > /data/postgres/data/recovery.conf <<EOF
restore_command = 'cp /data/archive/%f %p'
recovery_target_time = '2026-07-24 14:30:00+08'
recovery_target_timeline = 'latest'
EOF

# 4. 启动数据库（自动进入恢复模式）
docker compose start postgres

# 5. 检查恢复状态
PGPASSWORD=$POSTGRES_PASSWORD \
  psql -h localhost -U app_user -d ai_warehouse \
  -c "SELECT pg_is_in_recovery();"
```

---

## 4. 恢复后验证

```sql
-- 检查表完整性
SELECT schemaname, tablename, n_live_tup, n_dead_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

-- 检查最近数据
SELECT * FROM <table_name> ORDER BY created_at DESC LIMIT 10;

-- 检查约束
SELECT conname, convalidated
FROM pg_constraint
WHERE convalidated = false;
```

---

## 5. 恢复失败处理

| 错误 | 原因 | 处理 |
|------|------|------|
| `role "app_user" does not exist` | 角色丢失 | `CREATE ROLE app_user LOGIN PASSWORD '...'` |
| `relation already exists` | 表冲突 | 使用 `--clean --if-exists` 参数 |
| WAL 段缺失 | WAL 未归档 | 切换到最近完整备份 |
| `FATAL: database files are incompatible with server` | 版本不匹配 | 使用 pg_upgrade 或同版本恢复 |
