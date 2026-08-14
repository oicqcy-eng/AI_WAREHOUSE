# IIOT 数采平台资产库（鼎华智能）

> 华纬重庆 **IIoT 工业互联网平台**（数采系统）—— 独立于 sMES 的采集/时序数据体系，与 `smes-621*`、`lims/`、`u9-sql/` 平级的独立系统。
> 探查建档：2026-08-14（由 `db.local.json` 新增 `iiot` profile 引发，实测网络与服务端口）。

## 体系边界（重要）

- **IIOT 平台 ≠ sMES 数据库**：数采实时数据（温度/压力/计数/能耗等）落在 **InfluxDB 时序库**（8086），**不落 sMES**；sMES 侧无线采表有数据（`TBLEQPDATACOLLECTION_*` 空模板、设备 COUNTERBY* 未启用，2026-08-14 实测）
- **数采链路**：设备 → MQTT（18083）→ IIOT 平台 → InfluxDB（8086，实时/历史时序）+ PostgreSQL（5432，疑似主库）+ Kestrel API（5000）
- MES 与数采**当前各自为政**：MES 报工数据（`TBLWIPCONT_EQUIPMENT`）来自报工操作，非数采自动；设备自动计数未启用（2026-08-14 实测）

## 服务器与端口（172.16.64.12 实测）

| 端口 | 服务 | 状态 | 说明 |
|------|------|:---:|------|
| 18800 | nginx / Web 前端 | ✅ HTTP 200 | 鼎华 IIoT v2.2.6.0（Vue SPA），**非数据库端口** |
| 8086 | InfluxDB v2.8.0 | ✅ 204 | 数采时序数据；需 token（无 token 401） |
| 5000 | Kestrel(.NET) API | ✅ 404(服务在) | 平台后端 API |
| 18083 | MQTT Broker | ✅ TCP | 设备采集上报入口 |
| 5341 | Seq 日志 | ✅ TCP | 平台日志 |
| 5432 | PostgreSQL(疑似) | ⚠️ TCP通/协议超时 | 疑似主库，未认证成功 |
| 1433 | SQL Server | ❌ | 本机无 SQL Server |

## 凭据现状

- `db.local.json` 含 `iiot` profile（`172.16.64.12:18800` + `sa`/`digihua@123`）——**该组合当前无法访问任何数据库**：
  - 18800 是 Web 端口非数据库
  - sa 为 SQL Server 风格账号，本机无 SQL Server
  - InfluxDB v2 用 token（非账号密码）
  - PostgreSQL 5432 连接超时
- **待用户提供其一才能搂数采数据**：① InfluxDB API token ② IIOT 平台登录账号（走 API 5000）③ 数据库实际类型/端口确认

## 关联

- sMES 重庆库：见 `delivery/projects/hw-spring-mes/input/c_q_mes/`（设备口径卡/报工查询/沟通日志）
- 数采专项任务：8-13 杨帅数采三问（呈现方式/报警/曲线图，见 c_q_mes 沟通日志 T-361450683b）
- 引用方式：回答数采/采集数据类问题时查 `[iiot]`
