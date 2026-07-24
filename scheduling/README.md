# 排程管理模块 (APS)

> **模块说明**: 主生产计划(MPS)、物料需求计划(MRP)、高级排程(APS)、产能分析
> **服务端口**: 8073 (HTTP)
> **数据库**: scheduling_db

## 功能范围
- 主生产计划 (MPS) 编制
- 物料需求计划 (MRP) 运算
- 高级排程 (APS) 优化
- 产能负荷分析
- 排程甘特图
- 异常预警 (物料短缺/产能不足)

## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8073/health
```
