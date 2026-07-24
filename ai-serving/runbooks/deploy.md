# AI 推理 — 部署手册

## 硬件要求
- GPU: 至少 1 块 (推荐 A100 80G 或 RTX 4090)
- 驱动: NVIDIA Driver ≥ 550, CUDA ≥ 12.4
- 显存: 根据模型选择（7B ~16GB, 13B ~28GB, 70B ~140GB）

## 部署
```bash
# 1. 配置环境变量
cp ../../environments/dev/.env.example environments/dev/.env
# 编辑 .env 填入 HF_TOKEN

# 2. 启动 vLLM
docker compose -f deploy/docker-compose.yml up -d vllm

# 3. 验证
curl http://localhost:8000/health
curl http://localhost:8000/v1/models
```

## 模型下载
```bash
# 预下载模型（可选，启动时会自动下载）
docker exec aiw-vllm python3 -c "
from huggingface_hub import snapshot_download
snapshot_download('Qwen/Qwen2.5-7B-Instruct')
"
```

## 切换模型
1. 停止服务: `docker compose -f deploy/docker-compose.yml down vllm`
2. 修改 MODEL_NAME 环境变量
3. 启动: `docker compose -f deploy/docker-compose.yml up -d vllm`
