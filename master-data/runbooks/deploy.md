# 基础数据 — 部署手册

## 初始化
```bash
# 创建数据库
psql -h localhost -U app_user -c "CREATE DATABASE master_db;"

# 执行迁移
psql -h localhost -U app_user -d master_db -f database/migrations/V1__init_master_data.sql

# 部署服务
docker compose -f deploy/docker-compose.yml up -d
```

## 初始数据导入
```bash
# 导入基础编码规则
psql -h localhost -U app_user -d master_db -f database/seed/01_code_rules.sql

# 导入默认部门结构
psql -h localhost -U app_user -d master_db -f database/seed/02_departments.sql
```

## 日常运维
```bash
# 数据一致性检查
curl http://localhost:8071/api/v1/check-consistency

# 导出全量主数据
curl http://localhost:8071/api/v1/export -o master_data_backup.json
```
