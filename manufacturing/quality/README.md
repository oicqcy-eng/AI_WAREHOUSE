# 品质管理模块
> **所属层级**: 制造执行层 (manufacturing/)
> **说明**: IQC来料检验、IPQC过程检验、OQC出货检验、SPC分析、NCR不合格品处理
> **端口**: 8081 (HTTP); **数据库**: quality_db
## 快速操作
```bash
docker compose -f deploy/docker-compose.yml up -d
curl http://localhost:8081/health
```
