# 质量管理模块

> **模块说明**: 来料检验(IQC)、过程检验(IPQC)、出货检验(OQC)、不合格品处理(NCR)、SPC 分析
> **服务端口**: 50051 (gRPC) / 8081 (HTTP)
> **数据库**: quality_db

---

## 目录结构

```
quality/
├── deploy/          # 部署配置 (Docker / K8s)
├── monitor/         # 监控告警 (Prometheus / Grafana)
├── runbooks/        # 运维手册
├── database/        # 数据库脚本
├── config/          # 配置模板
└── tests/           # 运维验证
```

## 快速操作

```bash
# 部署
docker compose -f deploy/docker-compose.yml up -d

# 查看日志
docker compose -f deploy/docker-compose.yml logs -f --tail=50

# 健康检查
./tests/smoke-test.sh
```

## 依赖服务
- PostgreSQL (shared/database)
- Redis (shared/database)
