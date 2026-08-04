# BUILDING — AI-WAREHOUSE 建设历程

> **定位**: 完整记录本仓库从构想到当前形态的**建设过程与思路演进**。
> 供日后回顾"为什么仓库长成这样"，以及复盘每个关键决策的由来。
> 配套：架构决策速查见 `memory/design-evolution.md`，结构规范见 `memory/structure-conventions.md`。

---

## 📅 建设时间线总览

| 日期 | 阶段 | 关键动作 |
|------|------|----------|
| 07-24 | 初始建仓 | v1 → v2 → v3 → v4 四次重构，确立 5 层架构 |
| 07-24~28 | 补全文档 | README 全覆盖、设计记忆、使用指南、重庆SMES汇报 |
| 08-03 | 阶段1 | 重构 Agent 业务层为"按 Agent 自包含" |
| 08-03 | 阶段2 | Agent 工程化增强（版本/质量/知识分级） |
| 08-03 | 阶段3 | 交付物归档与边界明确 |
| 08-03 | 阶段4 | MES实施专家 = 首个完整标准模板 |
| 08-03 | 阶段5 | 融合交付执行构想（delivery/ + skills/） |
| 08-03 | 阶段6 | archive-learning 归档学习 Skill |
| 08-04 | 阶段7 | knowledge 三件套：对齐规划师 Input Rule |
| 08-04 | 阶段8 | 演练验证 archive-learning 真实跑通 |
| 08-04 | 阶段9 | 真实数据处置：华纬三厂名单（确认清理） |
| 08-04 | 阶段10 | 纯净版、回滚与标签（v-initial-complete / v-pure） |
| 08-04 | 阶段11 | 三厂小簧项目：确立"只提交 MD 文档"原则 |
| 08-04 | 阶段12 | .gitignore 踩坑修复（同一行多 pattern 无效） |
| 08-04 | 收尾 | BUILDING 动态更新(Stop hook) + create_History 底稿索引 |
| 08-04 | 阶段13 | 四件套优化(新增 delivery_notes) + 提炼 L1 编码规范 |

---

## 🏁 背景：仓库的定位初衷

**目标**（你的原话方向）：创建一个 AI 项目仓库，服务于**鼎华 SMES + AI + 制造业数字化**。

最初定位是"运维实施仓库"，经历 v1→v4 四轮演进后确立为：

> **按业务层级组织、模块自包含**的复合平台仓库，覆盖 SMES 全功能 + AI 智能层。

这四次重构的教训（详见 `memory/design-evolution.md`）：
- **v1 按运维能力组织** → 废弃：找质量模块要跨 5~6 个目录
- **v2 按功能模块组织** → 过渡：18 个模块平铺，看不出依赖
- **v3 对照鼎华SMES补全** → 过渡：23 个模块仍平铺
- **v4 按层级依赖组织** → ✅ 最终：base/manufacturing/operations/ai/shared 五层

**v4 的核心理念**：模块自包含（deploy/monitor/runbooks/database/config/tests 全在一模块内）+ 目录深度≤3 + 依赖方向清晰。

---

## 阶段 1：Agent 业务层重构 —— "按 Agent 自包含"

**触发**：你给了第一份 ChatGPT 建议，其中提出"12 阶段流水线"结构（01_Project…99_Common）。

**我的判断**：这 12 层是**按流水线阶段组织**——和 v1"按能力组织"是同一种病，只是换了标签。一个 Agent（如 MES实施专家）的 prompt 在 08、知识在 03、工具在 06，要跨 6 个目录翻找，正是 v4 花了 4 次重构逃出来的坑。

**决策**（你确认方案 A）：
```
agent/  ← 一个 Agent = 一个自包含目录
├── mes-implement-expert/   MES实施专家
├── mes-report-agent/       MES项目汇报
├── industrial-consultant/  工业数字化顾问
└── _shared/                跨 Agent 公共资产
```
- 12 层的内容一点不丢，只是换挂靠方式（prompt/→prompt/、knowledge/→knowledge/…）
- 生命周期（规划→运营闭环）写成**过程文档** `docs/agent-lifecycle.md`，不用目录表达
- 修掉 3 处硬伤：agent↔agents 命名、CLAUDE.md 缺层、未提交 git

**拒绝**：12 层流水线（阶段化陷阱）、`agents/` 复数命名。

> **commit**: `e013be0`

---

## 阶段 2：Agent 工程化增强 —— 批判吸收 ChatGPT

**触发**：第二份 ChatGPT 建议，核心是"把知识/工具/数据/评估全提到全局共享层"。

**我的判断**：它的"推荐最终架构"本质是 v1 老路翻版——但它**批评背后的工程化思想是金子**：Agent 要版本化、要有质量体系、知识要分级。

**决策**（吸收工程化，拒绝结构破坏）：
| 吸收 | 落地 |
|------|------|
| Agent 是一级资产 | ✅ 已实现 |
| 版本管理 | 每 Agent `CHANGELOG.md` + 语义化版本 + `git tag agent/<name>/vX.Y.Z`（**拒绝** `versions/` 目录快照——Git 即版本管理） |
| 质量体系 | evaluation/ = 测试集 + 标准答案 + 评分（准确率/专业度/稳定性），发布前必须过评估 |
| 知识分级 | L1 行业知识 `docs/industry-knowledge/` → L2 通用 `agent/_shared/` → L3 Agent 专属 `knowledge/`；向量在 `ai/vector-db/` |

**拒绝**：全局能力层（business/knowledge/tools…全提到顶层）、大写下划线命名、agents/ 复数。

> **经验**：外部建议常"批评与方案自相矛盾"——吸收它指出的**问题**，验证它推荐的**方案**是否自洽再落地。
> **commit**: `538a18e`

---

## 阶段 3：交付物与边界明确 —— 第二轮外部评审

**触发**：第三份 ChatGPT 建议，提出"manufacturing→agent→应用"资产流，建议加 applications/ 层。

**我的判断**：方向感对（制造知识→Agent 能力→交付产出），但它把 `manufacturing/` 理解成"知识库"是**根本性误解**（manufacturing/ 是部署运维模块，非文档库）。

**决策**：
- ✅ 新增 `docs/deliverables/`（交付物归档，能力与成品分离）——后在本阶段5并入 delivery/
- ✅ `memory/README.md` 明确边界：存项目记忆，不存业务知识/运行时记忆
- ❌ 拒绝：顶层 `applications/`（交付物应归档非参与资产流）、`base`→`foundation`（纯重命名）、manufacturing 改知识库

> **commit**: `538a18e`（与阶段2 同批）

---

## 阶段 4：MES实施专家 —— 首个完整标准模板

**触发**：你接受建议，把第一个 Agent 填成**可复制的完整样板**。

**产出**：`agent/mes-implement-expert/` 从骨架升级为 v0.2.0，8 个子目录全部有真实内容：
- `config/agent.yaml`：模型双档、检索阈值防幻觉、工具白名单、发布门槛
- `prompt/system.md`：15 年专家角色 + `few-shot.md` 三场景（调研/方案/推广）
- `knowledge/`：引用索引 ID + FAQ + 5 天调研 SOP + 脱敏案例
- `tools/query-templates.sql`：4 类只读查询模板
- `workflow/`：实施咨询四阶段 + 状态机
- `data/`：数据字典 + 脱敏样本
- `evaluation/test-cases.md`：6 题测试集（K/S/B）+ 评分规范
- `runbooks/`：deploy/ops/troubleshoot 三手册

**意义**：成为 `mes-report-agent/`、`industrial-consultant/` 的扩展基准。

> **commit**: `ac0ac36`

---

## 阶段 5：融合交付执行构想 —— delivery/ + skills/

**触发**：你给出最初的 **agent-delivery-repo** 构想（input/project/knowledge/output/skill 五主目录），随后明确"**不建新仓库，融合进 AI_WAREHOUSE**"。

**我的判断**：构想里有三个亮点（inbox 收件箱、项目自包含、input 分类法），但顶层 input/output 阶段目录是**阶段化陷阱**——"这份 SQL 放通用还是项目"会漂移。

**决策**（保留亮点、修正结构）：
```
delivery/          ★ 客户交付执行区
├── inbox/          统一收件箱（新资料先进再归类）
└── projects/
    └── hw-spring-mes/  示例项目（input/{requirements,sql,report_ui,interfaces} + knowledge + output）

skills/            ★ 可复用 Claude Skills（SKILL.md 格式）
└── delivery-review/  交付物复核
```
- `docs/deliverables/` **并入** `delivery/projects/<name>/output/`（交付物跟项目走）
- 客户端数据只进 delivery/（脱敏）；可复用经验交付后回哺
- CLAUDE.md 更新为 7 层结构

> **经验**：用户初始构想常"方向对、结构错"——保留资产分类思想，套用已验证的结构原则落地。
> **commit**: `8ffee1d`

---

## 阶段 6：archive-learning —— 归档学习 Skill

**触发**：你分享了一位开发架构师写的 skill01 设计——一套**"归档学习 Skill 的行为规范"**。

**我的判断**：这段文字给的不是目录结构，而是**处理 inbox 的行为规范**——恰好补上 delivery/ 区最缺的一环：谁来处理 inbox、按什么规则归档。

**决策**：新增 `skills/archive-learning/`，吸收架构师 8 条规范，适配仓库结构：
| 架构师规范 | 落地 |
|-----------|------|
| 判断放哪里 | 归属判定：项目专属→projects/；通用→L1/L2；无法判断→**待确认** |
| 分门归类 | 需求/SQL/报表/接口/复盘/输出 → 对应 input 分类 |
| 复制归档保留原件 | 复制不删 inbox 原件（可回滚） |
| 提炼知识 | 五要素：业务对象/字段口径/接口规则/页面要求/待确认项 |
| 更新知识库 | 通用→L1/L2；项目独有→projects/<name>/knowledge |
| 标注来源 + 不捏造 | 结论带来源；不捏造表名/字段/接口/客户结论 |

**关键适配**：架构师的"通用 input"**不建顶层 input/**——通用 vs 项目的判断交给 skill 规则，而非目录结构，避免歧义。

**闭环成型**：`archive-learning`（进口）→ `delivery`（执行）→ `delivery-review`（出口）。

> **commit**: `00c0ced`

---

## 阶段 7：knowledge 三件套 —— 对齐规划师 Input Rule

**触发**：规划师原版"Input Rule"一节，提出知识库用三个文件承载整理产出：`file_index.md`（索引+来源）、`knowledge_cards.md`（提炼卡片）、`pending_questions.md`（待确认问题）。

**我的判断**：我们 archive-learning 说"生成知识索引、卡片、待确认问题"，但**没说产出落在哪个文件**——产出会飘。规划师把它钉死成三个文件，正好补上闭环缺口。

**决策**：
- 每个项目 knowledge/ 用三件套承载归档学习产出
- archive-learning 产出写入三件套；归属判定以"**以后谁会用**"为第一问（多项目用→共享池，单项目用→projects/）
- 拒绝"顶层 input/ 模板池"——通用资产已有 agent/_shared + tools 落点，不制造第三处家

> **commit**: `f1e4ffd`

---

## 阶段 8：演练验证 archive-learning —— 真实跑通

**触发**：你问"SKILL.md 没学习过，怎么知道怎么归档"，以及"下一步具体怎么做没头绪"。

**我的判断**：最好的解释不是讲，而是用规划师的例子**真实演练一遍**，让你看到"输入 → 处理后"的完整过程。

**决策**：
- 用两则样例（通用 SQL 规范 + 项目看板需求）跑通 archive-learning 全流程：读规则 → 判断归属 → 归档 → 提炼 → 登记三件套 → 输出摘要
- 澄清机制：SKILL.md 是"作业指导书"不是"训练文件"，读了就会执行

**演练后清理**：演练产生的假资料全部清除，恢复干净模板。

---

## 阶段 9：真实数据处置 —— 华纬三厂名单

**触发**：你放入真实客户人员名单 `华纬三厂小簧人员名单.xlsx`，并一度确认归档。

**我的判断**：真实个人隐私数据进 git 历史后**无法删除**（需重写历史），SKILL.md 规定"不确定先问"。我停下来与你确认。

**决策**：
- 你最终决定**清理**：删除归档副本、删除 inbox 原件、恢复三件套，回到干净状态
- 确立认知：**客户原始数据（尤其个人隐私）不应进入 git 历史**

> 后经确认无提交，未留下任何历史痕迹。

---

## 阶段 10：纯净版、回滚与标签

**触发**：你要"纯净版仓库可还原"，随后又"撤回保留示例项目"。

**判断**：已推送的提交用 `git revert`（保留历史）而非 `git reset`（重写历史）——符合"完整保留思路"诉求。

**决策**：
- `4be8c55` 纯净版（移除 hw-spring-mes 示例）
- `e13c536` revert 恢复示例（= 147d92e + knowledge 三件套）
- 打标签：`v-initial-complete`（完整版 e13c536）、`v-pure`（纯净版 4be8c55），推送到远程

---

## 阶段 11：三厂小簧项目 —— 确立"只提交 MD 文档"原则

**触发**：你在 inbox 放入 7 份三厂小簧真实资料（20MB PPT、人员名单、设备台账等）。

**判断**：客户敏感数据 + 大文件一旦 commit 进历史删不掉；仓库应沉淀整理成果而非原始资料。

**决策**：
- 新建 `delivery/projects/san-chang-xiao-huang/` 项目，登记 7 份资料索引（file_index）
- **确立硬性原则：客户原始文件不入库，只提交 MD 文档**（原件留本地 inbox）
- 人员名单经你确认入库，但遵循"原件不入库、索引入库"原则

---

## 阶段 13：四件套优化 —— 对齐规划师 Knowledge Output

**触发**：规划师"Knowledge Output"一节提出第四件套 `delivery_notes.md`（交付建议/注意事项/可复用标签），以及"结论不要停在聊天窗口，能写回 knowledge 才方便复用"。

**我的判断**：我们有 file_index/knowledge_cards/pending_questions 三件套，但缺 **delivery_notes**（沉淀"经验"而非"事实/知识"）；且跨项目可复用知识（工序编码/群组体系）还没提炼到 L1 共享层。

**决策**（在模板/规范层做，不动真实数据与历史）：
- 项目 knowledge 三件套 → **四件套**（新增 delivery_notes.md）
- 更新 archive-learning SKILL.md / structure-conventions / projects 模板
- 提炼三厂小簧 K-004 工序编码、K-005 群组体系 → `docs/industry-knowledge/mes-coding-standards.md`（L1 跨项目复用）
- 打新标签 `v-four-sets` 作为四件套基准

**原则**：结构规范独立于具体客户数据演进；真实项目数据（三厂小簧）只是模板的实例，不参与结构演进。

---

## 阶段 12：.gitignore 踩坑 —— 同一行多个 pattern 无效

**触发**：配置排除客户原始文件时，`git status` 仍显示未忽略文件。

**判断**：`.gitignore` **不支持同一行多个 pattern 空格分隔**（`*.xlsx *.pptx` 是无效写法，会被当作一个整体模式），必须每行一个。

**决策**：
- 修正 .gitignore：每个扩展名独立一行
- 验证 `git check-ignore` 生效，客户原件全部忽略
- 仓库只提交 MD 文档，体积轻量、无敏感数据

---

## 🧭 沉淀的核心原则

1. **模块/Agent/项目自包含**：找一件事的所有物料进一个门
2. **拒绝阶段化目录**：生命周期/流程是过程，用文档表达，不用目录表达
3. **能力与成品分离**：agent/ 存可复用能力，delivery/ 存一次性成品
4. **客户端数据隔离**：只进 delivery/，且脱敏；可复用经验交付后回哺
5. **不捏造、有来源**：知识、结论必须可追溯，禁止脑补表名/字段/接口
6. **版本与评估**：Agent 变更走 CHANGELOG + git tag + 质量评估
7. **客户原始资料不入库**：只提交整理成果(MD 文档)，原件留本地（敏感数据+大文件）
8. **可回滚的版本管理**：已推送的改动用 revert 保留历史，不 reset 重写；标签标注关键节点
9. **四件套沉淀知识**：项目 knowledge 用四件套承载（索引=事实 / 卡片=知识 / 待确认=问题 / **delivery_notes=经验**），结论不停在聊天窗口，写回文件才可复用
10. **经验提炼回哺**：可复用的跨项目知识（编码体系/方法论）及时提炼到 L1 共享层，不只留在单项目内

---

## 🔄 如何持续维护本文件

每次仓库有**结构性决策**（新增/合并/重构目录、引入新 Skill），在对应阶段追加一条记录：

```markdown
### [日期] 标题
**触发**: 为什么做
**判断**: 权衡了什么
**决策**: 做了什么（含拒绝什么）
**commit**: xxx
```

建议每季度回看一次 `design-evolution.md` 与本文件，校验"沉淀的原则"是否仍被遵守。

---

## 🗒️ 自动会话日志

### 2026-08-04 19:55 (session: unknown)
本次会话相关提交（最近5条）:
```
    ab84b49 🧩 SMES 数据字典: 解析入库 sMES_Production_61100 (189表/12866字段, 8模块MD + K-621卡片)
    6c77029 🧠 archive-learning 新增沉淀判断清单(6.5)
    4be7999 📖 BUILDING 沉淀原则补四件套与经验回哺
    47be075 🧩 四件套优化: 新增 delivery_notes + 提炼 L1 编码规范
    827689b 🧠 三厂小簧: 提炼 7 份资料为知识卡片(K-001~007)
```

### 2026-08-04 19:53 (session: unknown)
本次会话相关提交（最近5条）:
```
    6c77029 🧠 archive-learning 新增沉淀判断清单(6.5)
    4be7999 📖 BUILDING 沉淀原则补四件套与经验回哺
    47be075 🧩 四件套优化: 新增 delivery_notes + 提炼 L1 编码规范
    827689b 🧠 三厂小簧: 提炼 7 份资料为知识卡片(K-001~007)
    3c551d3 📖 BUILDING 补全阶段7~12 + Stop hook 自动记录 + 底稿索引
```

### 2026-08-04 19:49 (session: unknown)
本次会话相关提交（最近5条）:
```
    6c77029 🧠 archive-learning 新增沉淀判断清单(6.5)
    4be7999 📖 BUILDING 沉淀原则补四件套与经验回哺
    47be075 🧩 四件套优化: 新增 delivery_notes + 提炼 L1 编码规范
    827689b 🧠 三厂小簧: 提炼 7 份资料为知识卡片(K-001~007)
    3c551d3 📖 BUILDING 补全阶段7~12 + Stop hook 自动记录 + 底稿索引
```

### 2026-08-04 16:31 (session: unknown)
本次会话相关提交（最近5条）:
```
    6c77029 🧠 archive-learning 新增沉淀判断清单(6.5)
    4be7999 📖 BUILDING 沉淀原则补四件套与经验回哺
    47be075 🧩 四件套优化: 新增 delivery_notes + 提炼 L1 编码规范
    827689b 🧠 三厂小簧: 提炼 7 份资料为知识卡片(K-001~007)
    3c551d3 📖 BUILDING 补全阶段7~12 + Stop hook 自动记录 + 底稿索引
```

### 2026-08-04 16:26 (session: unknown)
本次会话相关提交（最近5条）:
```
    6c77029 🧠 archive-learning 新增沉淀判断清单(6.5)
    4be7999 📖 BUILDING 沉淀原则补四件套与经验回哺
    47be075 🧩 四件套优化: 新增 delivery_notes + 提炼 L1 编码规范
    827689b 🧠 三厂小簧: 提炼 7 份资料为知识卡片(K-001~007)
    3c551d3 📖 BUILDING 补全阶段7~12 + Stop hook 自动记录 + 底稿索引
```

