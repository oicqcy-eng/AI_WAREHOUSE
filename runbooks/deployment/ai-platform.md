# AI 平台部署手册

> **版本**: v1.0
> **适用**: dev / staging / prod
> **维护人**: Ops Team

---

## 1. 系统概览

### 1.1 组件清单

| 组件 | 版本 | 端口 | 依赖 |
|------|------|------|------|
| vLLM | ≥0.6 | 8000 | GPU, HuggingFace Token |
| Triton Server | 24.08 | 8001, 8002 | GPU, 模型仓库 |
| Milvus | 2.4 | 19530, 9091 | 磁盘 (≥100GB) |
| PostgreSQL | 16 | 5432 | 磁盘 (≥50GB) |
| Redis | 7 | 6379 | 内存 (≥4GB) |
| MinIO | latest | 9000, 9001 | 磁盘 (≥200GB) |

### 1.2 环境规划

| 环境 | 服务器 | GPU | 用途 |
|------|--------|-----|------|
| dev | 1台 / 4C16G | 1×RTX4090 | 开发测试 |
| staging | 2台 / 8C32G | 1×A100 40G | 预发布验证 |
| prod | 4台 / 16C64G | 2×A100 80G | 生产服务 |

---

## 2. 前置条件

### 2.1 硬件检查

```bash
# GPU 检查
nvidia-smi
# 预期: 显示 GPU 型号、驱动版本、显存

# 磁盘空间
df -h /data
# 要求: ≥200GB 可用

# 内存
free -g
# 要求: ≥16GB (无 GPU) / ≥32GB (有 GPU)
```

### 2.2 软件依赖

```bash
# Docker
docker --version                 # ≥ 24.0
docker compose version           # ≥ 2.20

# NVIDIA 容器工具包
nvidia-ctk --version
nvidia-container-runtime --version
```

### 2.3 网络端口

确保以下端口未被占用：

```
8000  (vLLM / Triton HTTP)
8002  (Triton Metrics)
19530 (Milvus)
3000  (Grafana)
9090  (Prometheus)
5432  (PostgreSQL)
6379  (Redis)
```

---

## 3. 部署步骤

### 3.1 快速部署（Docker Compose）

```bash
# 1. 克隆仓库
git clone <repo-url>
cd AI-WAREHOUSE

# 2. 配置环境变量
cp environments/dev/.env.example environments/dev/.env
# 编辑 .env 填入真实值

# 3. 启动基础服务
docker compose \
  -f orchestration/docker/docker-compose.yml up -d

# 4. 启动 AI 服务
docker compose \
  -f orchestration/docker/docker-compose.yml \
  -f orchestration/docker/docker-compose.ai.yml \
  --profile gpu up -d

# 5. 启动监控
docker compose \
  -f orchestration/docker/docker-compose.yml \
  -f orchestration/docker/docker-compose.monitor.yml up -d
```

### 3.2 部署后验证

```bash
# 健康检查
./cicd/scripts/health-check.sh

# 各服务端点测试
curl http://localhost:8000/health           # vLLM
curl http://localhost:8001/v2/health/ready  # Triton
curl http://localhost:9091/health           # Milvus
curl http://localhost:9090/-/healthy        # Prometheus
curl http://localhost:3000/api/health       # Grafana
```

### 3.3 模型下载与加载

```bash
# vLLM 首次启动会自动下载模型
# 若需预下载:
docker exec ai-warehouse-vllm \
  python -c "from huggingface_hub import snapshot_download; \
  snapshot_download('Qwen/Qwen2.5-7B-Instruct')"
```

---

## 4. 部署回滚

```bash
# 回滚指定服务到上一版本
./cicd/scripts/rollback.sh vllm staging

# 指定版本回滚
./cicd/scripts/rollback.sh vllm staging v2.0.0

# 全栈重启
docker compose -f orchestration/docker/docker-compose.yml down
docker compose -f orchestration/docker/docker-compose.yml up -d
```

---

## 5. 常见问题

### 5.1 GPU 不可用

```
症状: vLLM 报 "CUDA error: no kernel image is available"
排查:
  nvidia-smi                    # 驱动是否正常
  nvidia-ctk system info       # 容器运行时是否配置
  docker run --rm --gpus all nvidia/cuda:12.4-base nvidia-smi  # 验证 GPU 穿透
解决:
  # 安装 NVIDIA 容器工具包
  sudo apt install nvidia-container-toolkit
  sudo systemctl restart docker
```

### 5.2 显存不足

```
症状: vLLM 报 "CUDA out of memory"
解决:
  1. 减少 max_model_len（如 8192 → 4096）
  2. 降低 gpu_memory_utilization（0.95 → 0.85）
  3. 增加 tensor_parallel_size（多 GPU）
  4. 切换更小的模型
```

### 5.3 模型下载慢

```
症状: 拉取 HuggingFace 模型超时
解决:
  1. 设置 HF_ENDPOINT=https://hf-mirror.com
  2. 使用预下载的模型缓存
  3. 配置 HF_TOKEN 绕过限速
```

---

## 6. 日常运维

| 任务 | 频率 | 操作 |
|------|------|------|
| 检查 GPU 温度 | 每日 | `nvidia-smi --query-gpu=temperature.gpu --format=csv` |
| 检查磁盘使用 | 每日 | `df -h` |
| 查看服务日志 | 按需 | `docker compose logs -f --tail=100 <service>` |
| 更新模型 | 按需 | 更新 docker-compose.ai.yml 中 MODEL_NAME |
| 备份数据库 | 每日 | 见 `database/postgresql/backup/pg-backup.sh` |
