# PostgreSQL 灾难恢复

## 恢复步骤
1. 停止应用: `docker compose stop <modules>`
2. 查找备份: `ls -lh /data/backup/postgresql/`
3. 恢复:
   ```bash
   gunzip -c /data/backup/postgresql/ai_warehouse_20260724.sql.gz | \
     pg_restore -h localhost -U app_user -d ai_warehouse --clean --if-exists
   ```
4. 重建索引: `reindexdb -h localhost -U app_user -d ai_warehouse`
5. 恢复应用: `docker compose start <modules>`
6. 验证: ./cicd/scripts/health-check.sh

## PITR (基于时间点恢复)
1. `recovery_target_time = '2026-07-24 14:30:00+08'`
2. 启动数据库进入恢复模式
3. 检查: `SELECT pg_is_in_recovery();`

## 恢复后验证
- 表完整性: `SELECT count(*) FROM information_schema.tables;`
- 约束验证: `SELECT conname FROM pg_constraint WHERE convalidated = false;`
