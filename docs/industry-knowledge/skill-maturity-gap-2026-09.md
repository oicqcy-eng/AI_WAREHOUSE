# 仓库 Skills 成熟度差距诊断（2026-09-03）

> 定位：自我批判文档——对照世界级技能（Anthropic 官方 skill-creator 元技能 + docx 生产级技能）解剖本仓库 3 个自研技能（archive-learning / delivery-review / report-board）的差距。
> 目的：不只是记录"不够好"，而是给出一条从「流程说明文档」走向「可评测能力包」的升级路径。
> 状态：2026-09-03 首次诊断；后续升级按 P0→P2 顺序落地，本文随进展更新。

## 对照基准

- **skill-creator**（官方元技能）：如何创建/改进/评测 skill 的方法论。核心：description 是主要触发机制、渐进式披露、可程序化断言写成脚本、with/baseline 双跑评测、触发词评测选最优描述。
- **docx**（官方生产级技能）：任务→工具对照表 + 脚本化（soffice 渲染验证）+ 依赖声明。SKILL.md 是"地图"不是"疆土"。

## 总体判断

**已通过"格式体检"，但仍停留在"流程说明文档"阶段；世界级技能已是"可评测、可执行、自包含的能力包"。** 差距不在写作质量，而在三个认知断层：没有验证闭环、没有评测文化、依赖倒挂。

## 差距分级表

| 维度 | 官方参照 | 仓库现状 | 差距 |
|---|---|---|---|
| 渐进式披露 | SKILL.md 只做调度，逻辑进 `scripts/`、深知识进 `references/` | 逻辑+知识全塞 SKILL.md 正文 | 🔴 大 |
| 验证闭环 | docx 有 "Verify the output"（渲染成图人眼复核） | 仅文本检查清单，零程序化验证 | 🔴 大 |
| 评测文化 | with/baseline 双跑 + 触发词评测 + benchmark | 从未被评测过 | 🔴 大（认知断层） |
| description 负例 | 明写 "Do NOT use for..." 防误触发 | 只有正向 Use when，无负例排除 | 🟡 中 |
| 自包含性 | 依赖随技能走（自带脚本+依赖声明） | 依赖外挂 `agent/mes-report-agent/tools/` | 🟡 中 |
| 复用性 | 通用、跨项目 | 正文硬编码华纬路径结构 | 🟡 设计权衡 |
| 格式硬规则 | frontmatter、<500 行、kebab-case | 已达标 ✓ | 🟢 已过 |

## 差距详解

### 🔴 1. 渐进式披露缺失

**官方**：docx 的 SKILL.md 只有 ~6 个 H2（创建 gotcha/验证/编辑/依赖…），重活全在 `scripts/office/validate.py`、`scripts/merge_runs.py` 等可执行文件；skill-creator 明说"被引用大文件(>300行)须拆独立 reference，带目录"。

**我们**：archive-learning 142 行正文把判断流程、类型表、四件套规范、沉淀清单全挤一个文件，但调用 `worklog-append.js`（在 mes-report-agent/tools/）只一句话带过——没给调用方式、返回结构、失败处理。

### 🔴 2. 零程序化验证

**官方**：docx 有 "Verify the output" 独立章节，渲染成 PDF→JPEG→人眼逐页 Read；skill-creator 铁律"可程序化检查的断言写成脚本而非目测"。

**我们**：三技能全凭模型自我感觉。report-board 自检"无残留【】、日期全 .mono"本可写成 grep 脚本却没人写；delivery-review 复核完没有机器兜底扫脱敏关键词。

### 🔴 3. 从未被评测（认知断层）

**官方**：skill 是要测性能的东西——with vs baseline 同轮双跑比质量；description 跑 ~20 条触发 queries（应触发+近失配不应触发）；记 timing 出 benchmark。

**我们**：三技能上线后一次 eval 没跑过，无数据支撑"确实比裸奔强"。

### 🟡 4. description 缺负例排除

**官方 docx**：枚举正向触发后明写 "Do NOT use for PDFs, spreadsheets..." 防误触发。

**我们**：description 全只写正向，delivery-review 的"复核/检查"可能与通用 code-review 抢活、archive-learning 的"投喂"可能吞掉正常请求。

### 🟡 5. 依赖倒挂

三技能隐含依赖 `agent/mes-report-agent/tools/`（另一模块的私有资产）。按边界 agent 工具是"Agent 专属"、skills/ 是"跨项目复用"——可复用能力包依赖绑死在某 agent 肚子，agent 重构则技能断粮。

## 升级行动（按优先级）

| 优先级 | 行动 | 状态 |
|---|---|---|
| P0 | 三技能 description 补触发负例（Do NOT use when） | ✅ 2026-09-03 |
| P0 | report-board 自检脚本 + delivery-review 脱敏扫描脚本 | ✅ 2026-09-03 |
| P1 | archive-learning 拆 `references/tools.md`（worklog 调用契约） | ⬜ |
| P2 | 跑一次正式 eval（with/baseline 对比）建立评测文化 | ⬜ |

## 值得肯定的（不自我否定到失真）

- 格式硬规则全达标：frontmatter 双字段、正文 <500 行、kebab-case、SKILL.md 大小写、无 XML 尖括号
- archive-learning 的知识 vs 动作分流、防幻觉来源标注不落伍
- report-board 模板独立成 `templates/`（已是渐进式披露雏形），三者中最接近官方形态
