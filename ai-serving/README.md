# AI 推理服务模块

> **模块说明**: 大模型推理服务 (vLLM / Triton)，提供 OpenAI 兼容 API
> **服务端口**: 8000 (HTTP) / 8001 (Triton HTTP) / 8002 (Triton gRPC)
> **依赖**: GPU, HuggingFace Token

## 快速操作
```bash
# 部署 vLLM
docker compose -f deploy/docker-compose.yml up -d vllm

# 测试推理
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"Qwen/Qwen2.5-7B-Instruct","messages":[{"role":"user","content":"你好"}]}'

# 查看 GPU 使用
nvidia-smi
```

## 模型管理
- 模型缓存: /root/.cache/huggingface (容器内)
- 切换模型: 更新 docker-compose.yml 中 MODEL_NAME 环境变量
- 支持模型: Qwen2.5 / LLaMA 3.1 / DeepSeek V2
