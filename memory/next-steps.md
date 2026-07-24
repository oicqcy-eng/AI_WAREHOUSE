---
name: next-steps
description: 仓库创建完成后推荐做的后续任务清单
metadata:
  type: project
---

# 后续任务清单

仓库已创建并推送到 GitHub，以下是推荐继续完成的工作。

## 📋 本周优先

1. **填写真实资产信息**
   - 修改 `shared/asset/servers/inventory.yml` → 填你的真实服务器清单
   - 修改 `shared/asset/gpu-nodes/inventory.yml` → 填你的真实 GPU 清单
   - 修改 `shared/network/network-topology.md` → 填你的真实网络拓扑
   - 这些是运维的"家底"，填完仓库才有实际意义

2. **选择 2~3 个最关心的模块，让 Claude Code 完善内容**
   - 目前 quality/ 最完整（有 deploy/monitor/runbooks/troubleshoot）
   - 其他模块只有骨架，需要填充 runbooks 和监控规则

3. **尝试部署基础设施验证可用性**
   ```bash
   cp environments/dev/.env.example environments/dev/.env
   docker compose -f shared/database/docker-compose.yml up -d
   docker compose -f shared/monitoring/docker-compose.yml up -d
   ```

## 📌 中期规划

- 配置 CI/CD（GitHub Actions）自动部署到服务器
- 填充所有剩余模块的 deploy/monitor/runbooks
- 配置 PostgreSQL 定时备份
- 编写 Ansible Playbook 服务器初始化剧本
- 制作 Grafana 监控面板 JSON

## 💡 使用技巧

- 在仓库目录启动 Claude Code，它会自动加载仓库背景
- 想要查看仓库设计思路：看 `memory/design-evolution.md`
- 想要查看模块覆盖情况：看 `memory/smes-coverage.md`
- 想要了解结构规范：看 `memory/structure-conventions.md`
