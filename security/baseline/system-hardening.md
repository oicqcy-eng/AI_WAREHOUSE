# 系统安全基线

> **版本**: v1.0
> **适用范围**: 所有 AI-WAREHOUSE 管理节点

---

## 1. 操作系统安全

### 1.1 账户与认证

```bash
# 禁用 root 直接 SSH 登录
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# 使用密钥认证
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# 创建运维账户
sudo useradd -m -s /bin/bash ops
sudo usermod -aG docker ops
```

### 1.2 SSH 加固

```bash
# /etc/ssh/sshd_config 安全配置
Port 22                            # 建议修改为高位端口
Protocol 2
MaxAuthTries 3
MaxSessions 5
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers ops                    # 仅允许运维账户登录
```

### 1.3 系统更新

```bash
# 开启自动安全更新
sudo apt install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# 定期重启策略（内核更新后）
sudo sed -i 's/^Unattended-Upgrade::Automatic-Reboot "false"/Unattended-Upgrade::Automatic-Reboot "true"/' /etc/apt/apt.conf.d/50unattended-upgrades
```

---

## 2. Docker 安全

### 2.1 Docker 守护进程

```json
// /etc/docker/daemon.json
{
  "icc": false,
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "5"
  },
  "live-restore": true,
  "userland-proxy": false,
  "userns-remap": "default",
  "no-new-privileges": true
}
```

### 2.2 容器安全

```dockerfile
# Dockerfile 最佳实践
FROM alpine:3.20
RUN adduser -D -u 1001 appuser
USER appuser
```

### 2.3 镜像安全

```bash
# 定期扫描镜像漏洞
docker scout quick <image>
trivy image <image>

# 仅使用 signed 镜像
export DOCKER_CONTENT_TRUST=1
```

---

## 3. 网络安全

### 3.1 防火墙规则 (iptables/nftables)

```bash
# 默认策略: 拒绝所有入站
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# 允许回环
iptables -A INPUT -i lo -j ACCEPT

# 允许已建立的连接
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 允许 SSH
iptables -A INPUT -p tcp --dport 22 -s <管理网段> -j ACCEPT

# 允许 HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# 允许内网服务端口
iptables -A INPUT -p tcp --dport 5432 -s 10.0.0.0/8 -j ACCEPT  # PostgreSQL
iptables -A INPUT -p tcp --dport 6379 -s 10.0.0.0/8 -j ACCEPT  # Redis
iptables -A INPUT -p tcp --dport 9090 -s 10.0.0.0/8 -j ACCEPT  # Prometheus
iptables -A INPUT -p tcp --dport 3000 -s 10.0.0.0/8 -j ACCEPT  # Grafana
```

### 3.2 容器网络隔离

```yaml
# Docker Compose 网络隔离
networks:
  frontend:
    driver: bridge
    internal: false     # 可访问公网
  backend:
    driver: bridge
    internal: true      # 无公网访问
  storage:
    driver: bridge
    internal: true
```

---

## 4. 密钥与凭证管理

### 4.1 密钥轮转策略

| 密钥类型 | 轮转周期 | 存储方式 |
|---------|---------|---------|
| 数据库密码 | 90 天 | Vault / 环境变量 |
| API Key | 90 天 | Vault |
| SSL 证书 | 90 天 (Let's Encrypt) | 文件系统 |
| SSH 密钥 | 180 天 | Vault / 硬件 Token |
| Docker 认证 | 180 天 | Docker config |

### 4.2 最小权限原则

```bash
# 数据库
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;
REVOKE ALL ON pg_catalog.pg_authid FROM app_user;

# 对象存储
# MinIO Policy: 仅允许特定路径的读写
# 使用 Access Key + Secret Key 而非 root 凭证
```

---

## 5. 审计日志

### 5.1 审计事件

| 事件类型 | 采集方式 | 保留周期 |
|---------|---------|---------|
| SSH 登录 | /var/log/auth.log | 180 天 |
| Docker 操作 | /var/log/docker.log | 90 天 |
| 数据库查询 | pg_audit | 90 天 |
| API 请求 | Nginx access log | 30 天 |
| 容器日志 | Docker json-file | 7 天 |

### 5.2 审计规则

```bash
# 安装审计工具
sudo apt install auditd audispd-plugins

# 审计规则: /etc/audit/rules.d/ai-warehouse.rules
-w /etc/docker/daemon.json -p wa -k docker-config
-w /etc/nginx/nginx.conf -p wa -k nginx-config
-w /etc/ssh/sshd_config -p wa -k ssh-config
-a exit,always -S execve -F euid=0 -k root-exec
-w /usr/bin/docker -p x -k docker-exec
```
