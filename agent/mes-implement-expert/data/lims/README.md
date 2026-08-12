# LIMS（实验室信息管理系统）资产库

> 华纬 **LIMS**（Laboratory Information Management System，实验室信息管理系统）—— 独立于 sMES 的另一套系统，与 `data/smes-621/`（鼎捷 sMES 数据字典）、`data/smes-621-sql/`（sMES 查询）、`data/u9-sql/`（U9 ERP 查询）是**不同体系**。
> 资产来源: 待归档（客户提供的 LIMS 文档/字典/SQL/接口资料，原件先在 `delivery/projects/hw-spring-mes/input/lims_system/` 留档）。

## 体系边界（重要）

- **LIMS 与 sMES 是两个独立系统、独立数据库**，资料互不相通，**不得混入 smes-621\*** 资产库
- LIMS 与 MES 三厂区（三厂小簧/一厂大簧/重庆）的关系：MES 三厂区共用一个 sMES 库（共享 smes-621 资产），**LIMS 不在此列**，它服务实验室，是独立子域
- 区分口径：凡明确带「LIMS」「实验室」「检验数据管理系统」字样的资料 → 本库；其余 sMES 查询/字典 → `smes-621*`；U9 相关 → `u9-sql`

## 资产定位

| 类别 | 内容 | 状态 |
|------|------|:----:|
| 数据字典 | LIMS 库表/字段结构 | 待归档 |
| 查询 SQL | LIMS 侧查询（如检验记录/报告/样品流转） | 待归档 |
| 接口文档 | LIMS 与其他系统（MES/U9/检测设备）集成契约 | 待归档 |
| 业务知识卡 | 实验室业务流程/样品编号规则/检验项目口径 | 待归档 |

> 收到客户 LIMS 资料后，提炼沉淀到本目录，`file_index.md` 登记，原件保留在 `delivery/projects/hw-spring-mes/input/lims_system/`。

## 使用

- 查 LIMS 相关字典/查询/接口 → 本目录对应文件
- 查 sMES 数据库通用查询 → `../smes-621-sql/`；查 sMES 数据字典 → `../smes-621/`；查 U9 接口 → `../u9-sql/`
- 引用方式: 回答 LIMS 类问题时查 `[lims]`
