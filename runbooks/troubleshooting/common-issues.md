# 故障排查手册

> 汇总 AI-WAREHOUSE 平台常见问题及排查步骤

---

## 1. 服务不可用

### 1.1 容器 CrashLoopBackOff

```
现象: docker ps 显示服务状态 restarting / unhealthy

排查步骤:
  1. 查看日志:
     docker logs <container_name> --tail 100
  
  2. 检查资源限制:
     docker stats <container_name>
  
  3. 检查依赖服务是否就绪:
     - PostgreSQL → pg_isready
     - Redis → redis-cli ping
  
  4. 常见原因:
     - 数据库连接失败（检查连接串）
     - 端口冲突（netstat -tlnp | grep <port>）
     - 磁盘空间满（df -h）
     - OOM Kill（dmesg | grep -i oom）
```

### 1.2 服务启动超时

```
现象: 容器启动后很快退出，health check 失败

排查:
  1. 查看退出码:
     docker inspect <container> --format '{{.State.ExitCode}}'
     # 137 = OOM killed
     # 139 = SIGSEGV
     # 143 = SIGTERM
  
  2. 增加启动等待时间:
     docker compose.yml 中 healthcheck.start_period: 120s
```

---

## 2. GPU / AI 推理问题

### 2.1 推理速度慢

```
排查:
  1. GPU 利用率检查:
     nvidia-smi -l 1          # 查看 GPU util 和显存
     watch -n1 nvidia-smi
  
  2. 检查是否多进程共享 GPU:
     nvidia-smi pmon -c 1
  
  3. vLLM 内部指标:
     curl http://localhost:8000/metrics | grep vllm
  
  优化:
  - 增大 max_num_seqs（提高吞吐）
  - 开启 prefix caching
  - 使用 tensor_parallel 多卡并行
```

### 2.2 显存泄漏

```
现象: 长期运行后显存持续增长

排查:
  watch -n 10 nvidia-smi      # 监控显存趋势

解决:
  1. 重启服务:
     docker compose restart vllm
  
  2. 限制显存上限:
     gpu_memory_utilization: 0.85
  
  3. 升级 vLLM 版本（常有显存泄漏修复）
```

### 2.3 模型输出乱码 / 质量差

```
排查:
  1. 检查模型文件完整性:
     docker exec vllm ls -la /root/.cache/huggingface/
  
  2. 检查 temperature / top_p 参数是否合理
  
  3. 确认使用正确的模型 revision
```

---

## 3. 数据库问题

### 3.1 PostgreSQL 连接数满

```
症状: FATAL: sorry, too many clients already

解决:
  # 临时: 终止空闲连接
  SELECT pg_terminate_backend(pid)
  FROM pg_stat_activity
  WHERE state = 'idle' AND wait_event IS NULL;
  
  # 长期: 增加 max_connections
  # 修改 postgresql.conf
  max_connections = 200
```

### 3.2 Milvus 查询超时

```
排查:
  1. 检查段状态:
     curl http://localhost:9091/api/v1/segments
  
  2. 检查索引状态:
     show index from <collection>
  
  3. 磁盘 I/O:
     iostat -x 1
  
  优化:
  - 增大 maxQueryMemory
  - 确保索引已完成构建
  - 分区表按时间分片
```

---

## 4. 监控告警问题

### 4.1 Grafana 数据源无数据

```
排查:
  1. 检查 Prometheus target 状态:
     curl http://localhost:9090/api/v1/targets
  
  2. 检查 exporter 是否运行:
     docker ps | grep exporter
  
  3. 检查网络连通性:
     docker exec prometheus wget -qO- http://node-exporter:9100/metrics | head
```

### 4.2 告警未触发

```
排查:
  1. 检查 Alertmanager 状态:
     curl http://localhost:9093/-/healthy
  
  2. 检查告警规则:
     curl http://localhost:9090/api/v1/rules
  
  3. 手动触发测试:
     停止一个服务观察 5 分钟内是否有告警
```

---

## 5. 网络问题

### 5.1 容器间通信失败

```
排查:
  1. 检查网络:
     docker network ls
     docker network inspect ai-warehouse-net
  
  2. DNS 解析:
     docker exec <container> ping <target_container_name>
  
  3. 防火墙:
     iptables -L -n | grep <port>
```

### 5.2 SSL 证书过期

```
处理:
  1. 查看过期时间:
     openssl x509 -in /path/to/cert.crt -noout -dates
  
  2. 续期:
     certbot renew
     # 或手动替换 security/ssl/ 下证书文件
  
  3. 重载 Nginx:
     docker exec nginx nginx -s reload
```

---

## 6. 联系方式

| 级别 | 响应时间 | 联系人 |
|------|---------|--------|
| P0 (系统宕机) | 15分钟 | Ops On-Call |
| P1 (功能受损) | 1小时 | 值班工程师 |
| P2 (一般问题) | 4小时 | 运维团队 |
