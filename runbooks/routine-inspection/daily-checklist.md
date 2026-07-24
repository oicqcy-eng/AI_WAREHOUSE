# 日常巡检清单

> **执行**: 每日上午 10:00
> **耗时**: 约 15 分钟
> **工具**: `./cicd/scripts/health-check.sh`

---

## □ 1. 服务状态检查

```bash
# 快速健康检查
./cicd/scripts/health-check.sh

# 检查所有容器状态
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

**预期结果**: 所有服务状态为 `Up` 或 `healthy`

| 服务 | 状态 | 备注 |
|------|------|------|
| PostgreSQL | `Up` | |
| Redis | `Up` | |
| Milvus | `Up` | |
| vLLM / Triton | `Up` | GPU 服务 |
| Prometheus | `Up` | |
| Grafana | `Up` | |
| Nginx | `Up` | |

---

## □ 2. GPU 状态检查

```bash
# GPU 基本信息
nvidia-smi

# GPU 详细指标
nvidia-smi --query-gpu=index,name,temperature.gpu,utilization.gpu,memory.used,memory.total,power.draw --format=csv
```

**阈值**:
| 指标 | 正常 | 警告 | 严重 |
|------|------|------|------|
| GPU 温度 | <75°C | 75-85°C | >85°C |
| GPU 利用率 | - | >95% 持续 | - |
| 显存使用 | <90% | 90-95% | >95% |
| 功耗 | <80% TDP | 80-95% TDP | >95% TDP |

---

## □ 3. 磁盘与内存

```bash
# 磁盘使用
df -h | grep -E '(data|/)'

# 内存使用
free -h

# 大文件检查
du -sh /data/* | sort -rh | head -10
```

**阈值**:
- 磁盘使用率 < 80% ✅ / > 85% ⚠️ / > 95% 🛑
- 内存使用率 < 85% ✅ / > 90% ⚠️

---

## □ 4. 日志检查

```bash
# 检查异常日志
docker compose -f orchestration/docker/docker-compose.yml logs --tail=50 --since=24h | grep -iE "(error|exception|fail|oom|killed|panic)" | grep -v "health check"
```

---

## □ 5. 数据库检查

```bash
# PostgreSQL 连接数
docker exec ai-warehouse-pg psql -U app_user -d ai_warehouse -c "SELECT count(*) FROM pg_stat_activity;"

# 数据库大小
docker exec ai-warehouse-pg psql -U app_user -d ai_warehouse -c "SELECT pg_database_size('ai_warehouse')/1073741824 || ' GB' AS db_size;"

# Redis 内存
docker exec ai-warehouse-redis redis-cli -a $REDIS_PASSWORD INFO memory | grep used_memory_human
```

---

## □ 6. 备份验证

```bash
# 检查最近备份
ls -lh database/postgresql/backup/*.sql.gz | tail -3

# 验证备份完整性
for f in $(ls -t database/postgresql/backup/*.sql.gz | head -3); do
    gunzip -t "$f" && echo "✅ $f" || echo "❌ $f"
done
```

---

## □ 7. 安全巡检

- [ ] SSL 证书是否在 30 天内过期？
  ```bash
  openssl x509 -in security/ssl/certs/*.crt -noout -enddate
  ```
- [ ] 防火墙规则是否完整？
- [ ] 是否有异常登录记录？

---

## 巡检日志

```markdown
日期: 2026-07-24
巡检人: 
结果: ✅ 正常 / ⚠️ 异常
异常说明: 
处理结果: 
```
