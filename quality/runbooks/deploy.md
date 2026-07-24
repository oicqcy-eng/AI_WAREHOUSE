# 质量管理 — 部署手册

## 前置条件
- PostgreSQL 已就绪 (shared/database)
- Redis 已就绪 (shared/database)

## 部署步骤

### 1. 初始化数据库
```bash
# 创建数据库
psql -h localhost -U app_user -c "CREATE DATABASE quality_db;"

# 执行迁移
psql -h localhost -U app_user -d quality_db -f database/migrations/V1__init_quality.sql
```

### 2. 启动服务
```bash
# Docker Compose
docker compose -f deploy/docker-compose.yml up -d

# 验证
curl http://localhost:8081/health
```

### 3. K8s 部署
```bash
kubectl apply -k deploy/k8s/ --namespace manufacturing
```

## 回滚
```bash
docker compose -f deploy/docker-compose.yml down
docker compose -f deploy/docker-compose.yml up -d <previous-version>
```
