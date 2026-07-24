# 系统管理模块

> **所属层级**: 基础层 (base/)
> **说明**: 用户管理、角色权限、组织架构、菜单配置、审计日志、通知服务
> **端口**: 8086 (HTTP)
> **数据库**: system_db

## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8086/health
```

## 依赖
- PostgreSQL, Redis (shared/database)
