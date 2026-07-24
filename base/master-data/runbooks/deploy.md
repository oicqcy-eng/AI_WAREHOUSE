# 基础资料 — 部署手册
```bash
psql -h localhost -U app_user -c "CREATE DATABASE master_db;"
psql -h localhost -U app_user -d master_db -f database/migrations/V1__init_master.sql
docker compose -f deploy/docker-compose.yml up -d
psql -h localhost -U app_user -d master_db -f database/seed/01_code_rules.sql
```
