# 系统配置模块

> **模块说明**: 用户管理、角色权限、组织架构、菜单配置、审计日志、系统参数
> **服务端口**: 50053 (gRPC) / 8083 (HTTP)
> **数据库**: system_db

## 目录结构
```
system/
├── deploy/          # 部署配置
├── monitor/         # 监控告警
├── runbooks/        # 运维手册
├── database/        # 数据库脚本
├── config/          # 配置模板
└── tests/           # 运维验证
```

## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8083/health
```

## 依赖
- PostgreSQL
- Redis
- LDAP (可选，企业认证集成)
