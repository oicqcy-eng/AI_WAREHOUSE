# AI-WAREHOUSE — CLAUDE.md

## 仓库定位
这是一个 **AI + 智能制造复合平台的运维实施仓库**，不是软件开发仓库。
所有工作围绕部署、监控、灾备、安全、自动化运维展开。

## 目录结构约定
- `environments/` — 按 dev/staging/prod 分目录的环境配置
- `orchestration/` — Docker Compose 和 Kubernetes 编排
- `ai-ops/` — AI 模型 Serving、GPU 管理、向量数据库运维
- `monitoring/` — Prometheus、Grafana、Loki 等监控组件
- `runbooks/` — 运维手册，markdown 格式
- `automation/` — Ansible 和 Terraform

## 命名规范
- 目录名：kebab-case（如 `model-serving`、`disaster-recovery`）
- 配置文件：按组件名称命名（如 `prometheus.yml`、`docker-compose.yml`）
- 脚本文件：动词开头（如 `deploy.sh`、`rollback.sh`、`health-check.sh`）

## 关键约定
- 仓库不存放真实密钥、密码、证书文件 — 用 `.example` 或 `.template` 后缀
- 所有配置修改需同步更新 runbook
- CI/CD 配置优先使用 GitHub Actions
