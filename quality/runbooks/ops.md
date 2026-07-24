# 质量管理 — 日常运维

## 日常检查
```bash
# 服务状态
docker ps --filter name=aiw-quality

# 日志
docker compose -f deploy/docker-compose.yml logs -f --tail=50

# 数据库连接
psql -h localhost -U app_user -d quality_db -c "SELECT count(*) FROM pg_stat_activity;"

# 队列积压检查
curl http://localhost:8081/actuator/messaging
```

## 关键指标
| 指标 | 正常范围 | 告警阈值 |
|------|---------|---------|
| 处理延迟 | <500ms | >2s |
| 错误率 | <1% | >5% |
| 队列积压 | <100 | >1000 |
| NCR 超期 | 0 | >5 |

## 数据维护
```bash
# 归档旧数据 (180天前)
psql -h localhost -U app_user -d quality_db -c "
  DELETE FROM inspection_records WHERE created_at < now() - interval '180 days';
"

# 更新统计信息
psql -h localhost -U app_user -d quality_db -c "ANALYZE;"
```
