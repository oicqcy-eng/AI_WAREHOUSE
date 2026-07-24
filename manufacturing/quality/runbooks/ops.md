# 品质管理 — 日常运维
## 检查
```bash
docker ps --filter name=aiw-quality
docker compose -f deploy/docker-compose.yml logs -f --tail=50
```
## 数据维护
```bash
psql -h localhost -U app_user -d quality_db -c "DELETE FROM inspection_records WHERE created_at < now() - interval '180 days';"
psql -h localhost -U app_user -d quality_db -c "ANALYZE;"
```
