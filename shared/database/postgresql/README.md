# PostgreSQL 运维

## 连接信息
- 主机: localhost (dev) / pg-rw.internal (prod)
- 端口: 5432
- 库名: ai_warehouse
- 用户: app_user

## 备份策略
- 全量备份: 每日凌晨 2:00 (pg_dump custom 格式)
- WAL 归档: 持续
- 保留: 7 天本地 + 30 天异地

## 复制架构 (生产)
- 主库: pg-01 (读写)
- 从库: pg-02, pg-03 (只读/报表)
- 故障转移: Patroni + etcd
