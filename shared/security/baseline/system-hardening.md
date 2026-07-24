# 系统安全基线

## SSH 加固
- 禁用 root 登录: PermitRootLogin no
- 仅密钥认证: PasswordAuthentication no
- 修改端口 (建议高位端口)
- 限制登录用户: AllowUsers ops

## Docker 安全
```json
{
  "icc": false,
  "live-restore": true,
  "no-new-privileges": true,
  "userns-remap": "default"
}
```

## 防火墙
- 默认策略: INPUT DROP, FORWARD DROP
- 仅开放: 80, 443, 22(管理网段), 内网服务端口
- Docker 内部网络使用 internal 模式

## 审计
- 监控 /etc/docker/daemon.json, /etc/nginx/nginx.conf, /etc/ssh/sshd_config 变更
- 记录所有 root 执行的命令
