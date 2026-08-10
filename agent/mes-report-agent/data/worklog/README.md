# 本地工作日志（worklog）

> **用途**: 原始工作日志 + 任务问题归集池的**权威数据源**（2026-08-09 起本地化，替代飞书多维表）。
> **优势**: 本地读写毫秒级、零网络失败、git 可追溯；无需飞书 token/权限/选项ID 等摩擦。
> **飞书表**: 已迁移并归档为历史只读（291 日志 + 40 任务），不再更新。

## 目录结构

```
worklog/
├── logs/           # 日志按月归档（跨项目全量流水）
│   └── 2026-MM.json
└── task-pool.json  # 任务池全量（任务跨月跟踪，单文件）
```

## 操作方式

| 操作 | 命令 |
|------|------|
| **打开录入页**（日常直接录入/编辑） | **双击 `start-worklog.bat`** → 浏览器自动打开 → 保存直接写 worklog；最近记录【编辑】可覆盖修改 |
| 追加日志 | `node agent/mes-report-agent/tools/worklog-append.js log '<json>'` |
| 追加任务 | `node agent/mes-report-agent/tools/worklog-append.js task '<json>'` |
| 更新日志 | `node agent/mes-report-agent/tools/worklog-append.js update-log '{"_id":"L-xxx",...完整记录}'` |
| 更新任务 | `node agent/mes-report-agent/tools/worklog-append.js update-task '{"_id":"T-xxx",...完整记录}'` |
| 提取区间数据 | `node agent/mes-report-agent/tools/export-range.js <起> <止>`（如 `2026-08-03 2026-08-09`）|
| 生成仪表盘 | `node agent/mes-report-agent/tools/generate-dashboard.js` → 浏览器打开 `delivery/projects/hw-spring-mes/output/dashboard.html` |
| 导出 Excel | `node agent/mes-report-agent/tools/export-excel.js log\|task\|all [--project=X] [--month=YYYY-MM]` |

## 字段口径（与飞书表一致，中文字段名）

**日志**（必填 5 项）：`记录日期`(YYYY-MM-DD) `所属项目` `工作内容` `结果类型` `是否形成任务`
可选：`业务模块` `项目阶段` `责任人` `协作人` `交付产出`

**任务**（必填 4 项）：`归集标题` `对应项目` `问题来源` `优先级`
可选：`发现日期` `计划完成日期` `实际闭环日期` `任务状态` `进度百分比` `闭环判定标准` `周报归集分类` `协调资源需求` `卡点&问题描述`

**缺省值策略**（用户未明确时取最低档，见 report-bitable-spec.md §4.4）：
结果类型=需求确认 · 优先级=P4 · 任务状态=待启动 · 是否形成任务=否 · 业务模块=系统管理 · 项目阶段=需求调研 · 日期=处理当天

**选项枚举**：见 `agent/mes-report-agent/data/report-bitable-spec.md` §1/§2（所属项目 7 项、结果类型 8 项、优先级 P1-P4、任务状态 4 项、周报归集分类 5 项、问题来源 6 项、业务模块 10 项、项目阶段 6 项）。

## 规则

- **任务池准入**：停线风险/跨部门协调/系统BUG/需求变更/领导关注/审厂要求 → 进 task-pool；普通会议/日常测试/简单配置 → 只记日志
- **稳定 `_id`**：每条记录带 `_id`（`L-xxx` 日志 / `T-xxx` 任务，基于日期+内容+序号哈希，确定性生成）。录入页编辑、update-log/update-task 都按它精确匹配；修改日期跨月时自动移到新月份文件
- 输入来源：`delivery/inbox/日常工作数据输入窗口/` 纪要文件 + 对话框口述
- 汇报生成：export-range.js 提取 → Claude 组织 md → md-to-docx.js 出 docx
