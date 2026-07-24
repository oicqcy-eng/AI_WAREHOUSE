# 系统配置 — 部署手册

## 前置条件
- PostgreSQL, Redis

## 初始化
```bash
# 创建数据库
psql -h localhost -U app_user -c "CREATE DATABASE system_db;"
psql -h localhost -U app_user -d system_db -f database/migrations/V1__init_system.sql

# 创建初始管理员 (安装后执行)
curl -X POST http://localhost:8083/api/v1/setup \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"<change_me>","email":"admin@example.com"}'
```

## 启动
```bash
docker compose -f deploy/docker-compose.yml up -d
```

## 验证
```bash
curl http://localhost:8083/health
curl -u admin:<password> http://localhost:8083/api/v1/users
```
