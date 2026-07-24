# 设备管理模块

> **模块说明**: 设备台账、保养计划、维修工单、备件管理、OEE 计算、校准管理
> **服务端口**: 50052 (gRPC) / 8082 (HTTP)
> **数据库**: equipment_db

---

## 目录结构

```
equipment/
├── deploy/          # 部署配置
├── monitor/         # 监控告警
├── runbooks/        # 运维手册
├── database/        # 数据库脚本
├── config/          # 配置模板
└── tests/           # 运维验证
```

## 快速操作
```bash
# 部署
docker compose -f deploy/docker-compose.yml up -d

# 健康检查
curl http://localhost:8082/health

# 查看 OEE 指标
curl http://localhost:8082/api/v1/oee/summary?period=today
```

## 依赖
- PostgreSQL
- Redis
- IIoT 模块 (设备实时数据)
