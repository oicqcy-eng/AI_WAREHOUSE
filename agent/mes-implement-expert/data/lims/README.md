# LIMS（实验室信息管理系统）资产库

> 华纬 **LIMS**（Laboratory Information Management System，实验室信息管理系统）—— 独立于 sMES 的另一套系统，与 `data/smes-621/`（鼎捷 sMES 数据字典）、`data/smes-621-sql/`（sMES 查询）、`data/u9-sql/`（U9 ERP 查询）是**不同体系**。
> 资产来源: `delivery/projects/hw-spring-mes/input/lims_system/`（客户提供的 LIMS 资料；原件在项目侧 `raw/` 留档，知识提炼在项目侧 `knowledge/`）。2026-08-13 已归档。

## 体系边界（重要）

- **LIMS 与 sMES 是两个独立系统、独立数据库**，资料互不相通，**不得混入 smes-621\*** 资产库
- LIMS 与 MES 三厂区（三厂小簧/一厂大簧/重庆）的关系：MES 三厂区共用一个 sMES 库（共享 smes-621 资产），**LIMS 不在此列**，它服务实验室，是独立子域
- 区分口径：凡明确带「LIMS」「实验室」「检验数据管理系统」字样的资料 → 本库；其余 sMES 查询/字典 → `smes-621*`；U9 相关 → `u9-sql`

## 资产定位

| 类别 | 内容 | 状态 |
|------|------|:----:|
| 数据字典 | LIMS 库表/字段结构 | ⏳ 待归档（当前无 LIMS 库/字典资料） |
| 查询 SQL | LIMS 侧查询（如检验记录/报告/样品流转） | ⏳ 待归档 |
| 接口文档 | LIMS 与其他系统（MES/U9/检测设备）集成契约 | ⏳ 待归档 |
| 业务知识卡 | 实验室业务流程/样品编号规则/检验项目口径 | ✅ 已沉淀（见项目侧 knowledge/ 索引） |

> 客户 LIMS 资料的**知识提炼**沉淀在 `delivery/projects/hw-spring-mes/input/lims_system/knowledge/`（需求调研分析/方案评估与部署确认/基础资料画像三份），`file_index.md` 登记入口；通用部署手册存本目录 `raw/`。

## 使用

- 查 LIMS 相关字典/查询/接口 → 本目录对应文件
- 查 sMES 数据库通用查询 → `../smes-621-sql/`；查 sMES 数据字典 → `../smes-621/`；查 U9 接口 → `../u9-sql/`
- 引用方式: 回答 LIMS 类问题时查 `[lims]`
