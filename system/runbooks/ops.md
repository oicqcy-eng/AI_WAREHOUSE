# 系统配置 — 日常运维

## 用户管理
```bash
# 列出所有用户
curl http://localhost:8083/api/v1/users

# 锁定用户
curl -X PUT http://localhost:8083/api/v1/users/{id}/lock

# 重置密码
curl -X PUT http://localhost:8083/api/v1/users/{id}/password -d '{"password":"new_pass"}'
```

## 审计日志
```bash
# 查询最近审计日志
curl "http://localhost:8083/api/v1/audit-logs?limit=50"

# 归档 (保留90天)
psql -h localhost -U app_user -d system_db \
  -c "DELETE FROM audit_logs WHERE created_at < now() - interval '90 days';"
```

## 系统参数
```bash
# 查看参数
curl http://localhost:8083/api/v1/params

# 更新参数
curl -X PUT http://localhost:8083/api/v1/params/{key} -d '{"value":"new_value"}'
```
