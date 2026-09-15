# worklog 数据结构契约（SCHEMA）

> **用途**：报告/查询脚本与人工读数的字段契约。
> **枚举 / 字段清单 / 必填 / 缺省值的唯一真源是 `tools/worklog-schema.js`**（`OPTIONS` 等）。
> 本文档**只写「N 项」计数并指向它，不复制取值** —— 复制过的值都漂移过（本节旧版曾列出 9 个所属项目、
> 13 个结果类型，以及 `协同会/项目群` 两个从来不是合法值的选项）。
> 禁止的是"以枚举全集/清单形式出现"；**以具体取值为主语的业务规则**（如「`需求确认` 不进周报正文」）不在此列，应当保留。
> 改契约 → 改 `worklog-schema.js` → 跑一次 `validate` → 回来同步本文档的计数。
> 查当前取值：`node agent/mes-report-agent/tools/worklog-append.js schema`
> **读方**：`tools/export-range.js`（数据包）按此契约取字段；`tools/worklog-append.js` 按 `worklog-schema.js` 的 `LOG_REQUIRED/TASK_REQUIRED` 校验写入。

## 文件与顶层结构

| 数据 | 文件 | 结构 |
|------|------|------|
| 原始工作日志 | `logs/YYYY-MM.json`（按月） | 顶层 **list**，元素 dict |
| 任务池 | `task-pool.json` | 顶层 **list**，元素 dict |

当前条数用 `node agent/mes-report-agent/tools/worklog-append.js validate` 查（本文档不硬编码：条数每次写入都在变）。

日期一律 **字符串 `YYYY-MM-DD`**（无时分秒；空值 = `''`）。进度百分比可能存 **字符串或数字**。

## 日志字段（logs/*.json）

| 字段 | 类型 | 说明 |
|------|------|------|
| `记录日期` | str `YYYY-MM-DD` | 必填 |
| `所属项目` | str | 枚举 **7 项**（厂区/系统粒度；客户级、项目级的横切事务归入兜底值 `华纬其它项目`）—— 见 `OPTIONS.projects` |
| `工作内容` | str | 当日动作，写清量纲（当日X个/累计Y/N） |
| `结果类型` | str | 枚举 **8 项**，**必填且无缺省** —— 必须当场判定，判不了就问用户；不留空档兜底（旧版「未明时默认需求确认」曾吃掉 54.1% 的记录，把"没判断"伪装成"判断了"）。见 `OPTIONS.resultTypes` |
| `是否形成任务` | str | 枚举 **2 项** —— 见 `OPTIONS.yesNo` |
| `业务模块` | str | 枚举 **11 项**，**严格限定为 MES 功能模块**，不承载「工作性质」（项目管理/项目汇报）与非 MES 业务域（仓库运维/IT服务管理）。无缺省 —— 见 `OPTIONS.modules` |
| `项目阶段` | str | 枚举 **6 项**，**严格限定为实施方法论阶段**，不承载项目生命周期状态（模拟筹备/实施运行/系统运行/上线运行）。无缺省 —— 见 `OPTIONS.stages` |
| `责任人` `协作人` | str | 责任人常为 陈宇/姜皓翔/樊正毅 等 |
| `交付产出` | str | 可等于工作内容 |
| `关联任务` `附件` | str | 可选；`T-xxx` / 附件文件名 |
| `_id` | str | `L-xxx` |

## 任务字段（task-pool.json）

| 字段 | 类型 | 说明 |
|------|------|------|
| `_id` | str | `T-xxx` |
| `归集标题` | str | 常带 `【项目-模块-主题】` 前缀 |
| `对应项目` | str | 枚举同 `所属项目`（7 项） |
| `优先级` | str | 枚举 **4 项**（P1~P4）—— 见 `OPTIONS.priority` |
| `任务状态` | str | 枚举 **4 项**（待启动/进行中/暂缓/已闭环；无"已完成"态，闭环即 已闭环+实际闭环日期）—— 见 `OPTIONS.taskStatus` |
| `进度百分比` | str/number | 0~100；旧值可能带 `%` |
| `发现日期` `计划完成日期` `实际闭环日期` | str | 未闭环任务 `实际闭环日期=''` |
| `问题来源` | str | 枚举 **6 项**（暴露渠道维度）—— 见 `OPTIONS.sources`。注意：`问题管制表` 是**承载台账**不是渠道，**不是合法值** |
| `闭环判定标准` | str | 闭环判据 |
| `周报归集分类` | str | 枚举 **5 项** —— 见 `OPTIONS.weekCat` |
| `协调资源需求` | str | 需协调对象 |
| `卡点&问题描述` | str | 见下"更新纪律" |

## 卡点&问题描述 更新纪律（export-range 依赖）

- **新更新一律以标记前缀追加在卡点串最前**，最新在最前：
  - 常规 `【M-D更新】…`
  - 清单/协同会型 `【M-D待办清单更新】【M-D协同会更新】【8-20需求规格归档】` 等（标签自由，但**必须带 `M-D` 日期**且置于段首）
  - 同日多来源可复合：`【8-31/9-1更新】`
- export-range 的解析规则：
  - 从 `【…】` 标记提全部 `M-D` 日期（支持复合/斜杠/中划线）
  - 年份推断：`winY` 拼出且 ≤ 生成当天 → 今年；否则按去年。**局限**：去年 9 月前的旧任务若含今年同形未来标注会判错年 → 写标记时尽量带年份（`(2025-12-09)` 括号内全年份最稳）
- 段归属：每个标记其后的文本（至下一标记）即该次更新正文；报告取"最新一条 ≤ 窗口末"的段做原因/尾注

## 枚举真源与写入校验

**真源**：`tools/worklog-schema.js` 的 `OPTIONS`。本文档只给计数，取值请用命令查：

```bash
# 字段契约 + 全部枚举取值 + 缺省值
node agent/mes-report-agent/tools/worklog-append.js schema

# 全量契约校验（只读）：枚举成员性 / _id 规范性 / 关联任务引用存在性
node agent/mes-report-agent/tools/worklog-append.js validate --detail
node agent/mes-report-agent/tools/worklog-append.js validate --json     # 供程序消费
```

写入时（CLI 与录入页 HTTP 两条路径共用同一批函数）自动跑上述三类校验：

| 模式 | 行为 |
|------|------|
| `warn`（默认） | 打印告警但**照常写入**。`WORKLOG_ENUM_MODE=warn` |
| `strict` | **仅对 error 级**（`_id` 格式不符）抛错阻断。`WORKLOG_ENUM_MODE=strict`，或单次加 `--strict` |

- 已知枚举外值（见 `worklog-schema.js` 的 `OUTSIDERS`）在写入路径**不告警**，只在 `validate` 报告单独成桶（`legacy`）——
  否则录入页编辑一条历史记录就会刷屏。**切 strict 的判据 = legacy 桶清零**。
- **空值不算枚举违规**：留空是允许的，且优于填假值。
- 必填校验是硬不变量，任何模式下都阻断；`update-*` 只拦「本次把必填项改空」，不拦存量记录里本就为空的必填项。

## 配套工具速查

```bash
# 周报/月报数据包（默认蒸馏 ≈4-5K token；写周报前先跑这个，勿手工逐条探测）
node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04
node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04 --todos   # +未闭环全清单(P3/P4/待启动/暂缓)
node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04 --all      # 旧行为全量(含已闭环)回显
node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04 --project=三厂小簧sMES
```
