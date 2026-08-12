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
| `worklog/` | **权威数据源（本地）**：任务池 `task-pool.json` + 日志按月 `logs/YYYY-MM.json` |
| `worklog-local.md` | 本地化工作日志规范（字段口径/缺省值/操作/踩坑）|
| `report-bitable-spec.md` | 汇报结构规范（字段口径/周报月报输出规范/本地化说明 §10）|
| `history-log-governance.md` | 历史日志归属校验清单（266 条治理，71 条变更，归档参考）|
| `task-pool-supplement.md` | 任务池补充清单（18 条 MES 主要问题，归档参考）|

> **2026-08-09 本地化**：飞书多维表已归档（config `feishu-tables.json` active=local），数据读写全走 `data/worklog/`。CSV（history-log-governance/task-pool-supplement）为飞书时代治理产物，仅作历史参考。

## 周报生成闭环（V1）

> 完整流程见 `workflow/weekly-report-v1.md`。

```
输入「生成2026年第XX周MES项目周报」
   ↓ ① 数据提取（本地权威源）
tools/export-range.js 2026-08-03 2026-08-09   （或 weekly-extract.js 预分组）
   ↓ 输出：区间日志 + 任务池全量 + P1/P2 未闭环风险
   ↓ ② AI 润色成稿（读素材 + prompt/weekly-report-v1.md）
输出：全项目汇总 或 单项目周报（本周完成/核心问题及风险/待办事项/下周重点计划）
```

| 文件 | 作用 |
|------|------|
| `tools/export-range.js` | 从本地 worklog 提取区间日志+任务池+风险（主数据流）|
| `tools/weekly-extract.js` | 周次解析 + 四模块预分组（兼容保留，需 CSV 输入）|
| `prompt/weekly-report-v1.md` | 周报生成 Prompt 模板（四模块 + 两种输出模式）|
| `workflow/weekly-report-v1.md` | 周报生成闭环流程文档 + 样例验证 |

## 使用

```bash
# 1. 提取数据（本地权威源，全项目；单项目在输出里按「所属项目」分组筛）
node agent/mes-report-agent/tools/export-range.js 2026-08-03 2026-08-09
# 2. 把数据 + prompt/weekly-report-v1.md 交给 Claude 生成周报
```

### 输出 docx（WPS 打开用）

汇报成稿后，md → docx 转换（排版样式见 `data/report-bitable-spec.md` §9）：

```bash
# 依赖：npm install docx（在脚本同目录或全局）
node agent/mes-report-agent/tools/md-to-docx.js [输出目录]
# 默认输出到 delivery/projects/hw-spring-mes/output/reports/
```

输出 md + docx 双份，docx 供 WPS/Office 打开。
