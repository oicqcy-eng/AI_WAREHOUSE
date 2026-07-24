# 看板管理模块

> **模块说明**: 生产看板、品质看板、设备看板、安灯看板、OEE看板、能源看板
> **服务端口**: 8074 (HTTP)
> **数据源**: 从各模块拉取实时数据

## 看板类型
| 看板 | 数据来源 | 刷新频率 | 适用场景 |
|------|---------|---------|---------|
| 生产看板 | production/ | 实时 | 车间大屏 |
| 品质看板 | quality/ | 实时 | 品质部大屏 |
| 设备看板 | equipment/ | 10s | 设备科 |
| OEE 看板 | equipment/ | 分钟级 | 管理层 |
| 安灯看板 | andon/ | 实时 | 车间 |
| 能源看板 | energy/ | 分钟级 | 能源管理 |

## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8074/health
```
