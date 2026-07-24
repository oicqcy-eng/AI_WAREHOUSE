# 质量管理 — 故障排查

## 服务启动失败
```
现象: 容器退出码 137 (OOM)
排查: docker stats aiw-quality → 检查内存限制
解决: 增加 deploy/docker-compose.yml 中 memory limit

现象: 数据库连接失败
排查: docker logs aiw-quality --tail 20 | grep "connection refused"
解决: 确认 PostgreSQL 已启动，检查 DB_HOST/DB_PORT 配置
```

## 数据不一致
```
现象: 检验结果与工单状态不符
排查: 
  1. 检查最近同步日志: grep "sync" /var/log/quality-sync.log
  2. 检查消息队列是否有积压
  3. 数据库对比: 
     SELECT * FROM inspection_results WHERE order_id = 'xxx';
     SELECT status FROM work_orders WHERE id = 'xxx';
解决: 触发手动同步 API: POST /api/v1/quality/sync/{order_id}
```

## 性能慢
```
现象: 查询超时 (>5s)
排查: 
  EXPLAIN ANALYZE SELECT * FROM inspection_records WHERE ...;
  SELECT * FROM pg_stat_activity WHERE state = 'active';
解决:
  - 添加索引: CREATE INDEX CONCURRENTLY idx_inspection_date ON inspection_records(created_at);
  - 归档旧数据
  - 增加连接池: 调整 config/application.yml 中 spring.datasource.hikari.maximum-pool-size
```
