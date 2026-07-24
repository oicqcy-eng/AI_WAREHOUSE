# 品质管理 — 故障排查
- 服务启动失败: docker logs aiw-quality | grep error
- 数据库连接失败: 检查 DB_HOST, DB_PORT 环境变量
- 数据不一致: POST /api/v1/quality/sync/{order_id} 触发手动同步
- 查询超时: CREATE INDEX CONCURRENTLY idx_inspection_date ON inspection_records(created_at);
