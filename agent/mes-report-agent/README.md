# MES项目汇报 Agent

## 能力定义
- 汇总实施进展、模块状态、风险与待办，生成项目汇报
- 引用 `docs/changelogs/`、各模块 runbooks 与监控数据
- 输出周报/月报/里程碑报告（含图表）

## 依赖
- 数据: `operations/reporting/`、`operations/kanban/`、各模块 `monitor/`
- 文档: `docs/changelogs/`
- 模型推理: `ai/serving/`

## 目录说明
| 目录 | 内容 |
|------|------|
| config/ | Agent 配置(模型/参数/路由) |
| prompt/ | 汇报类 prompt + few-shot |
| knowledge/ | 汇报规范 / 模板 / 案例 |
| tools/ | 报表查询 / 图表生成 / 文档导出脚本 |
| workflow/ | 汇报生成流程定义 |
| data/ | 汇报数据字典 / 样例 / 数据治理成果 |
| evaluation/ | 汇报质量测试集 / 标准答案 |
| runbooks/ | 使用 / 维护 / 故障手册 |

## 数据资产（data/）

| 文件 | 内容 |
|------|------|
| `report-bitable-spec.md` | 飞书多维表格结构规范（表1日志 + 表2任务池 + 仪表盘 + 填报规则）|
| `history-log-governance.md` | 历史日志归属校验清单（266 条治理，71 条变更）|
| `history-log-governance.csv` | 266 行记录ID→目标项目映射（可导入飞书核对）|
| `task-pool-supplement.md` | 任务池补充清单（18 条 MES 主要问题）|
| `task-pool-supplement.csv` | 18 条任务池补充字段表（含 option ID，可导入）|

## 周报生成闭环（V1）

> 完整流程见 `workflow/weekly-report-v1.md`。

```
输入「生成2026年第XX周MES项目周报」
   ↓ ① 数据提取
tools/weekly-extract.js --year 2026 --week 32 [--project 三厂小簧sMES]
   ↓ 输出 tmp/weekly-input-2026-W32.md（四模块预分组素材）
   ↓ ② AI 润色成稿（读素材 + prompt/weekly-report-v1.md）
输出：全项目汇总 或 单项目周报（本周完成/核心问题及风险/待办事项/下周重点计划）
```

| 文件 | 作用 |
|------|------|
| `tools/weekly-extract.js` | 周次解析 + 任务池/日志按周/项目过滤，输出四模块素材 |
| `prompt/weekly-report-v1.md` | 周报生成 Prompt 模板（四模块 + 两种输出模式）|
| `workflow/weekly-report-v1.md` | 周报生成闭环流程文档 + 样例验证 |

## 使用

```bash
# 1. 生成素材（全项目汇总）
node agent/mes-report-agent/tools/weekly-extract.js --year 2026 --week 32
# 2. 单项目
node agent/mes-report-agent/tools/weekly-extract.js --year 2026 --week 32 --project 三厂小簧sMES
# 3. 把素材 + prompt/weekly-report-v1.md 交给 Claude 生成周报
```
