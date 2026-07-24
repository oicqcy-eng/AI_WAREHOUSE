# 新环境接入清单

> **用于**: 新的 dev/staging/prod 环境初始化

---

## □ 1. 基础环境

- [ ] 操作系统安装（Ubuntu 22.04 LTS）
- [ ] 网络配置（IP/DNS/路由）
- [ ] SSH 密钥配置
- [ ] 系统更新和安全补丁
- [ ] 安装基础工具（docker, make, git, jq 等）
- [ ] 时区设置（Asia/Shanghai）
- [ ] NTP 时间同步

## □ 2. Docker 环境

- [ ] Docker Engine 安装 (≥24.0)
- [ ] Docker Compose 安装 (≥2.20)
- [ ] NVIDIA Container Toolkit 安装
- [ ] Docker daemon.json 安全配置
- [ ] Docker 网络规划
- [ ] 配置镜像加速/私有仓库

## □ 3. 存储

- [ ] 数据目录创建 (/data)
- [ ] 磁盘挂载与分区
- [ ] NFS / 共享存储配置（如需要）
- [ ] 备份存储挂载

## □ 4. 安全

- [ ] 防火墙规则配置
- [ ] SSL 证书生成/申请
- [ ] 密钥分发
- [ ] 运维账户创建
- [ ] 审计日志开启

## □ 5. 监控

- [ ] Node Exporter 部署
- [ ] GPU Exporter 部署（如适用）
- [ ] Prometheus target 配置
- [ ] Grafana 数据源配置
- [ ] 日志采集配置
- [ ] 告警通知渠道配置

## □ 6. 部署验证

- [ ] `./cicd/scripts/health-check.sh` 通过
- [ ] 各服务健康检查通过
- [ ] 模型推理测试通过
- [ ] 端到端业务流程测试
