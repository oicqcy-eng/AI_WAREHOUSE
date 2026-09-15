# 本地工作日志（worklog）

> **用途**: 原始工作日志 + 任务问题归集池的**权威数据源**（2026-08-09 起本地化，替代飞书多维表）。
> **优势**: 本地读写毫秒级、零网络失败、git 可追溯；无需飞书 token/权限/选项ID 等摩擦。
> **飞书表**: 已迁移并归档为历史只读（291 日志 + 40 任务），不再更新。

## 目录结构

```
worklog/
├── logs/           # 日志按月归档（跨项目全量流水）
│   └── 2026-MM.json
├── attachments/    # 附件文件（聊天记录/截图/表格等，日志任务挂'附件'字段引用）
└── task-pool.json  # 任务池全量（任务跨月跟踪，单文件）
```

**附件**：日志/任务可带可选 `附件` 字段（文件名），文件放 `attachments/` 下。录入页填文件名→最近记录显示 📎 可点击打开；Excel 导出带附件列。

**字段与枚举契约**：**取值真源是 `agent/mes-report-agent/tools/worklog-schema.js`**（`OPTIONS`）；**[SCHEMA.md](SCHEMA.md)** 记结构与纪律（日期格式/卡点更新纪律）并只写枚举计数。改契约改 `worklog-schema.js`。

## 操作方式

| 操作 | 命令 |
|------|------|
| **打开录入页**（日常直接录入/编辑） | **双击 `start-worklog.bat`** → 浏览器自动打开 → 保存直接写 worklog；最近记录【编辑】可覆盖修改 |
| 追加日志 | `node agent/mes-report-agent/tools/worklog-append.js log '<json>'` |
| 追加任务 | `node agent/mes-report-agent/tools/worklog-append.js task '<json>'` |
| 更新日志 | `node agent/mes-report-agent/tools/worklog-append.js update-log '{"_id":"L-xxx",...要改的字段}'` |
| 更新任务 | `node agent/mes-report-agent/tools/worklog-append.js update-task '{"_id":"T-xxx",...要改的字段}'` |
| **周报/月报数据包** | `node agent/mes-report-agent/tools/export-range.js <起> <止>`（蒸馏包：区间日志+窗口任务变化+项目快照+P1/P2风险；`--todos` 追加未闭环清单、`--all` 全量）|
| 生成仪表盘 | `node agent/mes-report-agent/tools/generate-dashboard.js` → 浏览器打开 `delivery/projects/hw-spring-mes/output/dashboard.html` |
| 导出 Excel | `node agent/mes-report-agent/tools/export-excel.js log\|task\|all [--project=X] [--month=YYYY-MM]` |

## 字段口径（与飞书表一致，中文字段名）

**日志**（必填 5 项）：`记录日期`(YYYY-MM-DD) `所属项目` `工作内容` `结果类型` `是否形成任务`
可选：`业务模块` `项目阶段` `责任人` `协作人` `交付产出`

**任务**（必填 4 项）：`归集标题` `对应项目` `问题来源` `优先级`
可选：`发现日期` `计划完成日期` `实际闭环日期` `任务状态` `进度百分比` `闭环判定标准` `周报归集分类` `协调资源需求` `卡点&问题描述`

**缺省值策略**（只在「字段解读优先级」第④步——确实无信息时——才用）：

- **保留兜底（只给非必填字段）**：任务 `任务状态=待启动` · `周报归集分类=长期跟踪` · `发现日期=当天`；日志 `责任人=陈宇`（单人仓库，声明式兜底）
- **无兜底，必须当场判定**：**结果类型 · 业务模块 · 项目阶段** —— 判不了就问用户，**留空优于填假值**
  （旧版曾默认 `结果类型=需求确认` / `业务模块=系统管理` / `项目阶段=需求调研`，实测分别吃掉 54.1% / 46.5% 的记录，把"我没判断"伪装成"我判断了"；2026-09-11 拍板废除，`结果类型` 仍保持必填）
- **必填字段一律不配兜底**（2026-09-12）：`是否形成任务`、`问题来源` 原有的 `否`/`会议决策` 两条是**死代码**——必填校验在前，兜底永不触发；已删除。`优先级` 从来就没有兜底（必填），"最低档 P4"是人的取值策略、不是程序兜底。

**选项枚举**：**真源是 `agent/mes-report-agent/tools/worklog-schema.js` 的 `OPTIONS`**，本文档只记计数、不复制取值。
当前计数：所属项目 7 · 结果类型 8 · 业务模块 11 · 项目阶段 6 · 优先级 4 · 任务状态 4 · 问题来源 6 · 周报归集分类 5。
查取值 → `node agent/mes-report-agent/tools/worklog-append.js schema`；查存量越界值 → 同命令 `validate --detail`。

## 规则

- **任务池准入**：停线风险/跨部门协调/系统BUG/需求变更/领导关注/审厂要求 → 进 task-pool；普通会议/日常测试/简单配置 → 只记日志
- **稳定 `_id`**：每条记录带 `_id`（`L-xxx` 日志 / `T-xxx` 任务，基于日期+内容+序号哈希，确定性生成）。录入页编辑、update-log/update-task 都按它精确匹配；修改日期跨月时自动移到新月份文件
- **update-log/update-task 是部分字段更新**：只传要改的字段，未传字段保留原值（原记录+patch 合并）。踩坑清单见 `data/worklog-local.md` §10
- 输入来源：`delivery/inbox/日常工作数据输入窗口/` 纪要文件 + 对话框口述
- 汇报生成：export-range.js 提取 → Claude 组织 md → md-to-docx.js 出 docx
