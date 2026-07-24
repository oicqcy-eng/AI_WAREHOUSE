# 品质管理 — 部署手册
```bash
psql -h localhost -U app_user -c "CREATE DATABASE quality_db;"
psql -h localhost -U app_user -d quality_db -f database/migrations/V1__init_quality.sql
docker compose -f deploy/docker-compose.yml up -d
```
## 验证
```bash
curl http://localhost:8081/health
curl http://localhost:8081/api/v1/inspection/stats
```
