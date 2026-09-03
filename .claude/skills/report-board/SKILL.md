---
name: report-board
description: 用「控制台风汇报板」模板生成模块化 HTML 汇报页——深墨蓝底+青绿信号+琥珀警示+等宽日期，6 标准区块按需拼装，浏览器投影。Use when: 要出 HTML 汇报/投影版(协同会/周例会/专项汇报)、用户说"汇报版""主持人版""生成汇报页"。勿用于纯 MD 汇报或强交互数据看板（该用 dataviz）。
---

# 控制台风汇报板（report-board）

生成**模块化 HTML 汇报版面**，浏览器直接打开可投影。风格：工业控制台——深墨蓝底、青绿信号色、琥珀警示、等宽字体日期/编号（如仪表读数）。

## 模板位置

`skills/report-board/templates/control-board-template.html`（**固定版本 v1.0**，不要改模板结构；新增变体另存新文件）。

生成方法：**复制模板为 `<主题>.html`，只替换内容**，不改动 `<style>` 里的结构。参考实例见 `delivery/projects/hw-spring-mes/output/san-chang-xiao-huang/2026-08-19_三厂小簧9-7模拟筹备进展汇报_主持人版.html`。

## 模块清单（按需拼装）

模板里每个 `<section class="sec">` 是一个独立模块，**只用需要的，删掉其余**：

| 模块 | 类名 | 用途 | 典型数据源 |
|------|------|------|-----------|
| 01 核心结论 | `.concl` | 3-5 条定调结论，`.wide` 占整行 | 会议决议/项目结论 |
| 02 时间线 | `.tl-row` | 节点对表，`.milestone`里程碑/`.hot`卡点/`.done`完成 | 项目计划/里程碑 |
| 03 重点卡点 | `.p1` | 每个卡点含"现状/为什么卡/闭环要求/追问谁"，**主持人版核心** | 风险清单/卡点任务 |
| 04 行动清单 | `table` | 责任方/要交付/时间，`.when.hot` 标紧迫 | 任务池 |
| 05 当场拍板 | `.verdict` | 需会议拍板事项 | 待决策项 |
| 06 就绪度一页纸 | `.readiness` | 维度状态一览，`.dot ok/hot/run/plan` | 状态总览 |
| 收尾 | `.closer` | 三句话带走 | 总结 |

**主持人版三要素**（对齐汇报的主持人需求，缺一即补）：开场定调（01 核心结论）、卡点追问（03 含"追问谁"）、收尾三句话（`.closer`）。

## 设计 tokens（换主题只改这里）

| token | 默认 | 语义 |
|-------|------|------|
| `--bg` | `#0d1624` | 深墨蓝控制台底 |
| `--surface` | `#152238` | 卡片面 |
| `--signal` | `#4fd1c5` | 青绿信号色：强调/里程碑/编号 |
| `--warn` | `#ffb454` | 琥珀：P1 卡点/待办 |
| `--danger` | `#ff6b5e` | 红橙：受阻 |
| `--ok` | `#5acb7c` | 绿：完成 |
| `--mono` | IBM Plex Mono | 日期/编号/数值（仪表读数感） |
| `--sans` | Noto Sans SC | 正文/标题 |

- 浅色模式已内置（`prefers-color-scheme: light` 冷调蓝灰），不需要单独处理
- **换主题** = 改 `:root` 的 `--signal/--warn/--danger/--ok` 四色，勿动结构
- 状态点语义：`ok`完成 / `hot`受阻 / `run`推进中 / `plan`待启动——**不要用 emoji 代替色点**

## 生成流程

1. **定内容**：明确场合（协同会/周例会/专项）、主持人还是纯汇报、核心结论几条
2. **选模块**：主持人版必含 01/03/收尾；简单汇报可用 01+02+06+收尾
3. **复制模板 → 替换内容**：
   - 所有 `【】` 占位符替换为真实内容
   - 日期格式统一 `MM-DD`（如 `08-28`），用 `.mono` 等宽
   - `.chips` 只留 3-5 个关键数据
4. **倒计时可选**：需要则改 script 里 `new Date('YYYY-MM-DD...')` 与 hero 对应 chip，不需要则删两者
5. **自检（机器兜底，勿纯目测）**：跑 `bash skills/report-board/scripts/self-check.sh <产出.html>`——自动查残留【】占位符/title/TODO/未闭合属性引号/文件体积；全部 PASS 才可交付。脚本每项检查含义见 [README.md](README.md)
6. **通知用户**：md+docx 版可同内容另出（`agent/mes-report-agent/tools/md-to-docx.js`），HTML 用于投影

## 交付惯例

- HTML 命名：`<YYYY-MM-DD>_<主题>_主持人版.html`（或 `_汇报版.html`）
- 同内容 md+docx 并存（docx 由 gitignore 排除，仅本地）；md 进 git 留档
- 落盘位置：`delivery/projects/<客户>/output/<厂区或主题>/`；纯内部模板不占 output

## 边界

- **不套用**在需要强交互/大量数据可视化的场景（该用 dashboard/图表工具）
- **不新增变体**改模板：新风格另存 `templates/<name>-template.html` 并在此登记
