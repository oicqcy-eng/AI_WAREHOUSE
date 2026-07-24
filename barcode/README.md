# 条码/RFID 管理模块

> **模块说明**: 条码规则定义、条码打印、RFID 标签管理、扫描配置
> **服务端口**: 8076 (HTTP)

## 功能范围
- 条码规则 (编码/格式/校验)
- 条码打印 (标签模板/打印机)
- RFID 标签管理
- 扫描终端配置
- 条码追溯查询

## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8076/health
```
