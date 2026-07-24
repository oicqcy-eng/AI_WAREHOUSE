# 网络拓扑文档

> **更新**: 2026-07-24
> **维护**: Ops Team

---

## 1. 网络架构图

```
                            [ Internet ]
                                |
                            [ Firewall ]
                            /          \
                    [ DMZ 网段 ]    [ 内网 网段 ]
                        |                |
                    [ Nginx LB ]     [ VPN Gateway ]
                       |                  |
                ┌──────┼──────┐           |
            [AI API]  [监控]  [管理]     [运维通道]
                |        |       |
         ┌──────┴──┐  [Grafana]  [SSH]
     [vLLM]  [Triton]    |
                    [Prometheus]
```

## 2. 网段划分

| 网段 | 用途 | VLAN | 网关 |
|------|------|------|------|
| 10.0.1.0/24 | 管理面 (Mgmt) | 100 | 10.0.1.1 |
| 10.0.2.0/24 | AI 服务面 | 200 | 10.0.2.1 |
| 10.0.3.0/24 | 制造服务面 | 300 | 10.0.3.1 |
| 10.0.10.0/24 | 存储面 | 1000 | 10.0.10.1 |
| 172.20.0.0/16 | Docker 内部网络 | - | - |

## 3. 防火墙规则

| 来源 | 目标 | 端口 | 协议 | 说明 |
|------|------|------|------|------|
| Internet | Nginx | 80/443 | TCP | 公网访问入口 |
| Nginx | vLLM | 8000 | TCP | API 代理 |
| Nginx | Triton | 8001 | TCP | 推理代理 |
| Nginx | Grafana | 3000 | TCP | 监控面板 |
| VPN | 所有 | 22 | TCP | SSH 运维通道 |
| Prometheus | 各 Exporter | 9100,9400,9187 | TCP | 指标采集 |
| Grafana | Prometheus | 9090 | TCP | 数据源 |
| 所有节点 | PostgreSQL | 5432 | TCP | 仅内网 |
| 所有节点 | Redis | 6379 | TCP | 仅内网 |

## 4. DNS 记录

| 域名 | 记录类型 | 值 | TTL |
|------|---------|-----|-----|
| api.ai-warehouse.local | A | 10.0.1.10 | 300 |
| *.ai-warehouse.local | A | 10.0.1.10 | 300 |
| grafana.ai-warehouse.local | CNAME | api.ai-warehouse.local | 300 |
| prometheus.ai-warehouse.local | CNAME | api.ai-warehouse.local | 300 |

## 5. 负载均衡

```
Nginx (10.0.1.10:443)
  ├── /v1/* → vLLM (10.0.2.10:8000)
  ├── /triton/* → Triton (10.0.2.11:8001)
  └── /grafana/* → Grafana (10.0.1.20:3000)
```

## 6. 证书管理

| 域名 | 证书类型 | 签发机构 | 过期时间 | 自动续期 |
|------|---------|---------|---------|---------|
| *.ai-warehouse.local | 自签名 | Internal CA | 2027-07 | 否 |
| api.example.com | Let's Encrypt | EAB | 2026-10 | certbot |
