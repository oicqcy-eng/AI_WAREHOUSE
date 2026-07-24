---
name: structure-conventions
description: AI-WAREHOUSE 目录结构规范、模块模板、命名约定
metadata:
  type: reference
---

# 仓库结构规范

## 5 层架构

```
base/              基础层 — 所有模块依赖的基础服务
manufacturing/     制造执行层 — MES 核心业务
operations/        运营管理层 — 基于制造数据的可视化
ai/                AI智能层 — 独立 AI 能力
shared/            共享基础设施 — 横切所有层
```

依赖顺序：shared → base → manufacturing → operations，ai 可独立部署。

## 模块模板

每个模块遵循统一内部结构：

```
module/
├── deploy/         部署配置
│   ├── docker-compose.yml   Docker Compose 本地部署
│   └── k8s/                  K8s 资源清单
├── monitor/        监控告警
│   └── prometheus-rules.yml  Prometheus 告警规则
├── runbooks/       运维手册
│   ├── deploy.md            部署步骤
│   ├── ops.md               日常运维
│   └── troubleshoot.md      故障排查
├── database/       数据库
│   ├── migrations/          DDL 迁移脚本
│   ├── queries/             常用查询模板
│   └── seed/                种子数据
├── config/         配置模板
└── tests/          运维验证
    └── smoke-test.sh        冒烟测试
```

## 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 目录名 | kebab-case | `master-data/`, `work-order/` |
| 脚本文件 | 动词开头 | `deploy.sh`, `health-check.sh` |
| 配置文件 | 组件命名 | `prometheus-rules.yml`, `docker-compose.yml` |
| README | 每个目录一个 | `README.md` |

## 关键约定

1. **不存放真实密钥**: 配置文件用 `.example` 后缀，`.env` 在 .gitignore 中
2. **配置与手册同步**: 修改 deploy/ 或 config/ 必须更新对应 runbooks/
3. **模块可独立部署**: 每个模块的 docker-compose.yml 可单独启动
4. **监控规则随模块走**: 告警规则放在模块的 monitor/ 下，由 Prometheus 统一加载
