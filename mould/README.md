# 模具管理模块

> **模块说明**: 模具台账、寿命追踪、保养计划、维修管理
> **服务端口**: 8075 (HTTP)
> **数据库**: mould_db

## 功能范围
- 模具台账 (基本信息/参数)
- 模具寿命管理 (冲次/模次追踪)
- 模具保养计划
- 模具维修记录
- 模具库存与领用
- 模具报废管理

## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8075/health
```
