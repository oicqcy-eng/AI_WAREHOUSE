# GPU — 日常运维

## 检查 GPU 状态
```bash
# 基本信息
nvidia-smi

# 详细指标
nvidia-smi --query-gpu=index,name,temperature.gpu,utilization.gpu,memory.used,memory.total,power.draw --format=csv

# 实时监控
watch -n 1 nvidia-smi
```

## GPU 问题排查
| 症状 | 排查 | 解决 |
|------|------|------|
| GPU 不可见 | nvidia-smi 报错 | 检查驱动: `nvidia-driver` |
| OOM | 进程被杀 | 减小 batch size 或切换小模型 |
| 性能低 | GPU util < 50% | 检查 CPU 瓶颈、数据加载 |
| 温度高 | >85°C | 清理散热、降低功耗限制 |

## DCGM Exporter 部署验证
```bash
# 检查 Exporter
curl -s http://localhost:9400/metrics | grep -c "DCGM_FI_DEV_GPU_UTIL"

# 检查容器
docker ps --filter name=gpu-exporter

# 查看日志
docker logs aiw-gpu-exporter --tail 20
```
