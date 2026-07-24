# AI-WAREHOUSE — CLAUDE.md

## 仓库定位
复合AI平台运维实施仓库，覆盖鼎华SMES全部功能 + AI智能层。
按**业务功能模块**组织，每个模块自包含：
```
module/
├── deploy/     # Docker Compose / K8s
├── monitor/    # Prometheus 告警规则
├── runbooks/   # 运维手册 (部署/运维/故障排查)
├── database/   # 迁移脚本/查询/种子数据
├── config/     # 配置模板
└── tests/      # 运维验证
```

## 模块列表
- 基础数据: master-data, barcode
- 生产执行: production, work-order, scheduling, process, andon
- 制造支撑: quality, equipment, material, warehouse, mould, energy, traceability
- 运营管理: system, document, reporting, kanban, iiot
- AI智能: ai-serving, gpu, vector-db, training

## 命名规范
- 目录/文件: kebab-case
- 脚本: 动词开头 (deploy.sh, health-check.sh)
- 配置文件: 按组件命名

## 关键约定
- 不存放真实密钥 — 用 .example 后缀
- 配置修改同步更新对应模块的 runbooks/
- CI/CD 优先 GitHub Actions
