# GPU 资源管理模块

> **模块说明**: GPU 集群管理、监控、调度策略
> **端口**: 9400 (DCGM Exporter)

## 目录结构
```
gpu/
├── deploy/          # NVIDIA Operator / DCGM Exporter
├── monitor/         # GPU 监控与告警
├── runbooks/        # 运维手册
├── config/          # GPU 调度配置
└── tests/           # 验证脚本
```

## 快速操作
```bash
# 查看 GPU 状态
nvidia-smi

# 部署 GPU Exporter
docker compose -f deploy/docker-compose.yml up -d

# 查看 GPU 指标
curl http://localhost:9400/metrics | head -20
```
