# 系统管理 — 部署手册
## 初始化
```bash
psql -h localhost -U app_user -c "CREATE DATABASE system_db;"
psql -h localhost -U app_user -d system_db -f database/migrations/V1__init_system.sql
docker compose -f deploy/docker-compose.yml up -d
```
## 创建管理员
```bash
curl -X POST http://localhost:8086/api/v1/setup \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"<change_me>","email":"admin@example.com"}'
```
