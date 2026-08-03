# CI/CD 脚本

> 跨模块的部署与健康检查脚本。由 `cicd/README.md` 统一管理。

## deploy.sh — 模块部署

通用模块部署脚本：按模块目录 + 环境部署对应的 docker-compose。

**用法**
```bash
./deploy.sh <group/module> <environment>
```

**示例**
```bash
./deploy.sh manufacturing/quality dev
./deploy.sh base/system dev
./deploy.sh ai/serving dev
```

**行为**
1. 加载 `environments/<env>/.env`（存在时）
2. 校验 `deploy/docker-compose.yml` 存在
3. `docker compose up -d`（项目名 `aiw-<模块名>`）
4. 若存在 `tests/smoke-test.sh` 则运行冒烟测试

## health-check.sh — 全平台健康检查

检查基础层/制造层/AI层/基础设施的容器状态、HTTP 端点与 GPU。

**用法**
```bash
./health-check.sh
```

**检查项**
- 容器：system/master-data/quality/equipment/warehouse/vllm/gpu-exporter/postgres/redis/prometheus/grafana
- HTTP：Quality(8081) / Equipment(8082) / System(8086) / vLLM(8000)
- GPU：`nvidia-smi`（未检测到 GPU 时跳过）
