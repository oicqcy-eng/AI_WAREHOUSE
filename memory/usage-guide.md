---
name: usage-guide
description: AI-WAREHOUSE 仓库的日常使用场景与操作方法
metadata:
  type: reference
---

# AI-WAREHOUSE 使用指南

## 仓库定位

这是一个**运维实施仓库**，不是软件开发仓库。它面向 AI + 智能制造复合平台的部署、监控、维护、灾备全生命周期管理。

## 日常使用场景

### 部署新模块
```bash
./cicd/scripts/deploy.sh manufacturing/quality dev
```

### 全平台健康检查
```bash
./cicd/scripts/health-check.sh
```

### 排查故障
1. 进对应模块目录，如 `manufacturing/quality/`
2. 看 `runbooks/troubleshoot.md` 按步骤排查
3. 看日志：`docker compose -f deploy/docker-compose.yml logs -f --tail=50`

### 日常巡检
- 查看 docker 容器状态
- 查看 GPU 状态：`nvidia-smi`
- 查看磁盘：`df -h`

### 添加告警规则
修改对应模块的 `monitor/prometheus-rules.yml`

### 数据库变更
在对应模块的 `database/migrations/` 下添加 SQL 迁移脚本

## 模块操作入口

每个模块的 README.md 是入口，包含：
- 模块说明与端口
- 快速操作命令
- 依赖关系

## 与 Claude Code 配合

在这个仓库目录下启动 Claude Code，它会自动读取 CLAUDE.md 和 MEMORY.md 了解仓库背景。

常用指令示例：
- "帮我部署 quality 模块到 dev 环境"
- "检查 equipment 模块状态"
- "给 GPU 加一条温度告警规则"
- "完善 master-data 模块的运维手册"
