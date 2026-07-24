# AI推理服务模块
> **所属层级**: AI智能层 (ai/)
> **说明**: 大模型推理服务 (vLLM/Triton)，提供 OpenAI 兼容 API
> **端口**: 8000 (vLLM), 8001 (Triton HTTP), 8002 (Triton gRPC)
> **依赖**: GPU, HuggingFace Token
## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d vllm
curl http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -d '{"model":"Qwen/Qwen2.5-7B-Instruct","messages":[{"role":"user","content":"你好"}]}'
nvidia-smi
```
