# 生产管理模块

> **所属层级**: 制造执行层 (manufacturing/)
> **说明**: 生产订单执行、派工报工、工时统计、在制品(WIP)跟踪、生产日报
> **端口**: 8083 (HTTP) | **数据库**: production_db
> **依赖**: base/system/（用户权限）、base/master-data/（基础资料）

## 目录结构
```
production/
├── deploy/          Docker Compose / K8s 部署
├── monitor/         Prometheus 告警规则
├── runbooks/        运维手册
├── database/        数据库迁移与种子数据
├── config/          配置模板
└── tests/           运维验证脚本
```
