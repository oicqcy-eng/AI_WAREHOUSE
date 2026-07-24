# 系统架构总览

## 部署架构图

```
[用户/API客户端]
      |
[ Nginx API 网关 ]  ← SSL/TLS
      |
      ├── [ AI 域 ]
      │   ├── ai-serving (vLLM/Triton)   端口 8000
      │   ├── gpu (DCGM Exporter)        端口 9400
      │   └── vector-db (Milvus)         端口 19530
      │
      ├── [ 制造域 ]
      │   ├── quality                    端口 8081
      │   ├── equipment                  端口 8082
      │   ├── production                 端口 8083
      │   ├── material                   端口 8084
      │   ├── work-order                 端口 8085
      │   ├── system                     端口 8086
      │   ├── process                    端口 8087
      │   ├── andon                      端口 8088
      │   ├── energy                     端口 8089
      │   ├── iiot                       端口 8090
      │   ├── reporting                  端口 8091
      │   ├── notification               端口 8092
      │   ├── document                   端口 8093
      │   └── traceability               端口 8094
      │
      └── [ 基础设施 ]
          ├── PostgreSQL / Redis
          ├── Prometheus / Grafana / Loki
          └── MinIO (对象存储)
```

## 环境规划

| 环境 | 部署方式 | GPU | 用途 |
|------|---------|-----|------|
| dev | Docker Compose | 1×RTX4090 | 开发调试 |
| staging | Docker Compose | 1×A100 40G | 预发布验证 |
| prod | K8s 集群 | 2×A100 80G | 生产服务 |

## 高可用设计
- **数据库**: PostgreSQL 主从复制 + Patroni
- **缓存**: Redis Sentinel / Cluster
- **AI 推理**: 多副本 + 负载均衡
- **监控**: Prometheus + Alertmanager 集群
