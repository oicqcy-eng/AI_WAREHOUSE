# sMES 共库全量表清单（断连地图）

> **系统**：鼎捷 sMES 共库（`192.168.200.18/sMES_Home_Prod`，`--profile home`）｜ **实测**：2026-08-21
> **定位**：生产库 **1472 张表**完整清单 + **与 189 表主字典的差异分析** —— 断连后的"地图"，并揭示字典覆盖缺口。

## 一、规模与分组分布

生产库实测 **1472 张表**，主要分组：

| 分组 | 表数 | 说明 |
|------|:----:|------|
| WIP | 198 | 生产批/报工/进出站（核心运营） |
| JDS 调度 | ~135 | 派工/调度（TBLJDS_*，含派工群组映射） |
| PRD | 93 | 产品/制程/工序 |
| SMT | 84 | SMT 产线 |
| SPC | 76 | 统计制程控制 |
| EQP | 73 | 设备 |
| QC | 72 | 检验 |
| INV | 66 | 库存 |
| SYS | 65 | 系统 |
| PM | 46 | 设备保养/维修 |
| OP | 34 | 工序/作业 |
| RPT | 33 | 报表 |
| EMS | 31 | 模治具 |
| BKT | 28 | 备份表（BKT 前缀，非业务依据） |
| USR | 27 | 用户/班别 |
| MSG | 19 | 消息 |
| OEM | 16 | 工单/材料 |
| MSA | 14 | 量测系统分析 |
| ISU | 14 | 工单派发 |
| ENT | 12 | 企业主数据（客户/供应商） |
| MTL | 9 | 物料 |
| 数采/二次开发 | 7+ | shucai*/JS_*/esb_iqc_receipt_outbox 等 |

> 全量清单见 [sMES全量表清单.csv](sMES全量表清单.csv)（1472 行，含估算行数）。

## 二、字典覆盖差异分析（关键发现，2026-08-21）

**[../smes-621/](../smes-621/README.md) 189 表主字典（源自设计文档 20250313）只覆盖生产库 ~13%**：

| 项 | 数量 | 说明 |
|----|:----:|------|
| 生产库表总数 | 1472 | 实测 INFORMATION_SCHEMA |
| 主字典已覆盖 | 189 | 设计文档解析（大小写不敏感比对） |
| **生产有/字典无** | **1284** | 主要缺口 |
| 字典有/生产无 | 1 | `tblemsacclog_adjustlife`（可能停用/改名） |

### 1284 张未覆盖表的处理分层

| 层 | 数量 | 处置 |
|----|:----:|------|
| **① 查询模板核心表** | **68** | **已补录全结构** → [../smes-621/09-core-ops-补录.md](../smes-621/09-core-ops-补录.md)（报工/权限/生产批/点检/发料/工单/设备/工序，1727 列） |
| ② 平台/主数据表 | ~1216 | SPC/QC/PM/MSA/MSG/SYS/RPT 等模块 + BKT 备份 → 按「用到即沉淀」按需补，不全量 |
| ③ 厂区二次开发 | 少数 | `shucai*`/`JS_*`/`esb_iqc_receipt_outbox`/`dingtalk_plan` 等华纬自定义 → 按需验证（esb_iqc_receipt_outbox 已沉淀 U9C 侧） |

### 为什么 68 张表最关键

22 个通用查询模板实际 `FROM/JOIN` 的表中，**68 张不在 189 字典** —— 即我们日常跑报表/排查依赖的核心表（`TBLWIPLOTBASIS`/`TBLWIPLOTLOG_REPORT`/`TBLWIPCONT_EQUIPMENT`/`TBLUSRUSERBASIS`/`TBLEQPEQUIPMENTBASIS`/`TBLOPBASIS`/`TBLWIPEQPQCLISTLOG` 等）结构此前**无文档**，断连即断。现已全部补录。

## 三、使用

1. **找表**：查本清单（grep CSV）确认表存在 → 查 [../smes-621/](../smes-621/README.md) 189 表字典 **或** [09-core-ops-补录.md](../smes-621/09-core-ops-补录.md) 68 表补录 → 都没有则按需连库验证
2. **断连期**：本清单 + 189 字典 + 68 补录 + [sMES核心链路-表结构与排障.md](sMES核心链路-表结构与排障.md) 四件套，覆盖核心链路离线判断
3. **重跑刷新**（连库可用时）：
```sql
SELECT t.name AS 表名, SUM(p.rows) AS 估算行数
FROM sys.tables t
LEFT JOIN sys.partitions p ON t.object_id = p.object_id AND p.index_id IN (0,1)
GROUP BY t.name ORDER BY 表名;
```
4. **注意**：`BKT` 前缀为备份表（非业务依据）；`temp`/`bak`/`Test_*` 为临时/测试表
