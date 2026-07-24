# 共享基础设施 (shared/)

> **定位**: 跨所有层级模块的公共基础设施，提供数据库、网关、监控、安全与自动化能力
> **包含组件**: database, gateway, monitoring, security, automation
> **部署顺序**: 🥇 最先部署，所有模块依赖本层

本层不包含业务逻辑，提供平台运行所需的基础设施支撑。

| 组件 | 说明 | 端口 |
|------|------|------|
| database | PostgreSQL 16 + Redis 7 | 5432, 6379 |
| gateway | Nginx API 网关与负载均衡 | 80, 443 |
| monitoring | Prometheus + Grafana + Loki | 9090, 3000, 3100 |
| security | SSL证书管理、安全基线 | - |
| automation | Ansible 服务器初始化 | - |
