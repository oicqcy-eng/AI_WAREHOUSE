# interfaces — 接口/集成规格

项目涉及的系统接口与集成方案。

## 存放内容

- 与 ERP/设备/SCADA 的接口清单
- 集成方案（数据流、协议、触发方式）
- API 规格说明

## 规范

- **不存密钥/token**: 只存接口结构与参数说明，连接凭据走环境变量/密钥管理
- 通用集成模式沉淀到 `agent/_shared/` 或 `docs/industry-knowledge/`
