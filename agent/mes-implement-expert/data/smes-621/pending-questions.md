# pending_questions — 待确认问题（smes-621）

> 来源: 《SMES_621数据库设计文档20250313.html》。问题编号 Q-621 起。

| 编号 | 问题 | 涉及对象 | 来源资料 | 日期 | 状态 |
|------|------|----------|----------|------|:----:|
| Q-621-01 | 正反追溯以哪张 PCS 序号表为准？`tblWIPCont_PCSNo` 标注「旧表格」，与 `tblWIPTEMPCont_PCSNo`/`tblWIPCont_PCSMTLLot` 关系 | PCS 序号体系 | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-02 | `_DailyWR_LotRealOn`(有效上线) 与 `_LotOn`(上线) 区间差异规则 | 日结暂存 | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-03 | SMT 序号追溯（`tblSMTProductPostIn/OutLog`）与通用 WIP 序号链路的衔接方式 | SMT | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-04 | 超大表用途：`tblEQPACCRepairItem`(675字段)、`tblEMSCombineACCLog`(251字段) | 模治具 | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-05 | Recipe 自变量检核的阶段规则（`tblINJPhaseBasis` 与 `tblINJRecipeCheckLog*` 联动） | 注塑 | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-06 | 双单位(`tblPRDDoubleUnitNoBasis`)与单位换算(`tblPRDOPUnitConversion`)的口径关系 | 产品 | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-07 | 工价核算与报工人时机时(`EMPTime_s`/`EQPTime_s`)的勾稽关系 | 工价 | SMES_621 | 2026-08-04 | 待确认 |
| Q-621-08 | 安灯等级/回应等级(`SLightLevel`/`ResponseLevel`)业务规则；ERP 报文重收机制 | 安灯/ERP | SMES_621 | 2026-08-04 | 待确认 |

## 规范

- 新增待确认项登记此表，确认后更新状态并注明结论
- 所有问题源于原文「说明」中的标注（旧表格/过多可删/口径不完整），不凭空推测
