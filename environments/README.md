# 环境配置 (environments/)

> **定位**: 按环境管理的配置变量，所有模块共享
> **环境**: dev（开发）、staging（预发布）、prod（生产）

使用方式:
```bash
# 部署时自动加载对应环境的 .env
./cicd/scripts/deploy.sh manufacturing/quality dev
```
