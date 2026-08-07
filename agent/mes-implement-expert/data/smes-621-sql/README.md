# smes-621 通用查询 SQL 资产库

> 鼎捷 sMES（sMES_Production_61100）**通用查询 SQL** —— 产品自带/跨厂区通用，与 `data/smes-621/` 数据字典配套。
> 来源: `delivery/inbox/SQL/` 归档（2026-08）。原件保留在 inbox 供追溯。

## 说明

- 本目录存放**通用查询**（无厂区/组织限定，纯按业务维度查询）
- **厂区限定**查询（绑定华纬某厂区）已分流到 `delivery/projects/san-chang-xiao-huang/input/sql/`
- 每个 SQL 文件为独立查询，可直接复制执行；字段说明见文件内注释

## 查询清单（17 个）

| 文件 | 查询内容 | 涉及核心表 |
|------|---------|-----------|
| [不良原因-SQL.sql](不良原因-SQL.sql) | 不良原因/例外分类汇总 | tblQCReasonBasis, tblWIPCont_Error, V_Q05 |
| [员工-SQL.sql](员工-SQL.sql) | 员工/设备工时统计 | tblWIPCont_Resource, TBLEQPEQUIPMENTBASIS |
| [子作业上下工时查询-SQL.sql](子作业上下工时查询-SQL.sql) | 子作业上下工时 | TBLWIPOPERATORLOG, TBLWIPLOTBASIS 等 |
| [子作业人员现况查询-SQL.sql](子作业人员现况查询-SQL.sql) | 子作业人员现况 | TBLWIPOPERATORSTATE, TBLWIPLOTSTATE 等 |
| [工单现况查询-SQL.sql](工单现况查询-SQL.sql) | 工单(MO)现况 | TBLOEMOBASIS, TBLWIPLOTBASIS, TBLWIPLOTSTATE |
| [成品序列号质量追溯-SQL.sql](成品序列号质量追溯-SQL.sql) | PCS 序号质量追溯 | TBLWIPCONT_PCSNO, TBLWIPFIRSTCHECK 等 |
| [標準參數表查詢-SQL.sql](標準參數表查詢-SQL.sql) | 注塑 Recipe 标准参数 | tblINJPhaseBasis, tblINJRecipeBasis |
| [模治具現況查詢-SQL.sql](模治具現況查詢-SQL.sql) | 模治具现状 | tblEQPAccessoryBasis, tblEMSAccessoryState |
| [模治具維修歷程查詢-SQL.sql](模治具維修歷程查詢-SQL.sql) | 模治具维修历程 | tblEMSACCLog_Repair, TBLEMSACCESSORYSTATE |
| [点检项目-SQL.sql](点检项目-SQL.sql) | 点检项目/清单 | tblWIPEQPQCListDetail, TBLWIPEQPQCLISTLOG |
| [物料-SQL.sql](物料-SQL.sql) | 物料耗用查询 | tblWIPCont_Material, tblWIPCont_MaterialLot |
| [生产批历程查询-SQL.sql](生产批历程查询-SQL.sql) | 生产批完整历程(报工/工序) | RPT_LotHistory_N, TBLWIPLOTLOG_REPORT 等 |
| [生产批操作历程-SQL.sql](生产批操作历程-SQL.sql) | 生产批操作履历(开批/进出站/外包) | TBLWIPLOTBASIS, tblWIPCont_Partialin 等 |
| [订单工单查询-SQL.sql](订单工单查询-SQL.sql) | 订单/工单(RO/MO) | TBLOEROBASIS, TBLOEMOBASIS, TBLWIPLOTBASIS |
| [设备-SQL.sql](设备-SQL.sql) | 设备工时/数量统计 | tblWIPCont_Resource, TBLEQPEQUIPMENTBASIS |
| [设备生产查询-SQL.sql](设备生产查询-SQL.sql) | 设备生产情况(含 SMT 区域) | TBLWIPCONT_EQUIPMENT, TBLSMDAREABASIS 等 |

## 使用

- 查表结构/字段口径 → `../smes-621/` 数据字典
- 查可直接跑的查询 → 本目录对应文件
- 引用方式: 回答查询类问题时查 `[smes-621-sql]`
