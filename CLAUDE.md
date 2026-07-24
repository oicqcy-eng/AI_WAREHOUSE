# AI-WAREHOUSE — CLAUDE.md

## 仓库定位
AI + 智能制造复合平台的 **运维实施仓库**。
按业务功能模块组织（quality/、equipment/、ai-serving/ 等），每个模块包含：
- deploy/ — 部署配置
- monitor/ — 监控告警
- runbooks/ — 运维手册
- database/ — 数据库脚本
- config/ — 配置模板

## 命名规范
- 目录/文件: kebab-case
- 脚本: 动词开头 (deploy.sh, rollback.sh)
- 配置文件: 按组件命名 (prometheus-rules.yml, docker-compose.yml)

## 关键约定
- 不存放真实密钥 — 用 .example / .template 后缀
- 配置修改需同步更新对应模块的 runbooks/
- CI/CD 优先使用 GitHub Actions
