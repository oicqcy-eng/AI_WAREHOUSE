# 制造平台部署手册

> **版本**: v1.0
> **依赖**: 数据库已就绪，AI 平台已部署（可选）

---

## 1. 系统架构

### 部署单元

| 服务 | 协议 | 端口 | 说明 |
|------|------|------|------|
| API 网关 | HTTP/gRPC | 80/443 | 统一入口 |
| 生产管理 | gRPC | 50051 | |
| 质量管理 | gRPC | 50052 | |
| 设备管理 | gRPC | 50053 | |
| 物料管理 | gRPC | 50054 | |
| IIoT 采集 | MQTT | 1883 | 边缘数据 |
| 看板大屏 | HTTP | 8080 | 实时展示 |

### 数据流

```
[边缘设备] → [IIoT 网关] → [消息队列] → [业务服务] → [数据库]
                                          ↓
                                    [缓存层] → [看板推送]
```

---

## 2. 部署步骤

### 2.1 数据库初始化

```bash
# 创建数据库
docker exec -i ai-warehouse-pg psql -U app_user <<EOF
CREATE DATABASE manufacturing;
\c manufacturing

# 执行各模块建表脚本
EOF

# 或使用迁移工具
# flyway -configFiles=database/flyway.conf migrate
```

### 2.2 启动服务

```bash
# 开发环境（Docker Compose）
docker compose -f orchestration/docker/docker-compose.yml up -d

# 生产环境（K8s）
kubectl apply -k orchestration/kubernetes/manufacturing/ --namespace manufacturing
```

### 2.3 配置 IIoT 边缘网关

```bash
# 边缘网关配置
docker run -d \
  --name iiots-gateway \
  --restart unless-stopped \
  -v /path/to/config.yml:/app/config.yml \
  -p 1883:1883 \
  iiots-gateway:latest
```

---

## 3. 验证

```bash
# API 健康检查
curl http://localhost/api/v1/health

# 数据库连接
docker exec ai-warehouse-pg pg_isready -U app_user

# 消息队列
docker exec ai-warehouse-redis redis-cli ping
```

---

## 4. 回滚

```bash
# Docker Compose 回滚
docker compose -f orchestration/docker/docker-compose.yml down
git checkout <上一版本>
docker compose -f orchestration/docker/docker-compose.yml up -d
```
