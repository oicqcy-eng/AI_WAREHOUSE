# Contract Validation Baseline — V1r3 基线（含工作日志深层校验）

> **基线日期**：2026-09-15
> **版本**：V1r3（合并 worklog-append.js validate 深层校验结果）
> **生成命令**：`node scripts/validate-contract.js --json` + `node agent/mes-report-agent/tools/worklog-append.js validate --json`
> **状态**：已确认，进入观察期

---

## 一、架构质检层（scripts/validate-contract.js）已知 FAIL

| # | 维度 | 字段 | 问题描述 | 来源文件 |
|---|------|------|---------|---------|
| 1 | Data Schema | 关联任务 | Task ID "V6.1培训后续模块学习沉淀" 在任务池中不存在 | logs/2026-08.json |
| 2 | Data Schema | 关联任务 | Task ID "T-xxxx" 在任务池中不存在 | logs/2026-09.json |
| 3 | Data Schema | 关联任务 | Task ID "T-20260910a" 在任务池中不存在 | logs/2026-09.json |
| 4 | Data Schema | 关联任务 | Task ID "T-20260910b" 在任务池中不存在 | logs/2026-09.json |
| 5 | Data Schema | 关联任务 | Task ID "T-20260910c" 在任务池中不存在 | logs/2026-09.json |

**性质**：历史存量数据问题（日志中的 `关联任务` 字段引用了不存在的任务 ID）。
**处理**：纳入存量治理，**不修改 Contract Validator 以适应脏数据**。

---

## 二、架构质检层已知 WARN

| # | 维度 | 字段 | 问题描述 | 级别 |
|---|------|------|---------|------|
| 1 | Data Schema | _id | `_id "L-"` 不符合规范（应为 L- + 10 位十六进制） | WARN |

**性质**：历史数据格式问题。
**当前等级**：WARN（不阻断工作流）。
**后续处理**：存量治理完成后，评估是否升级为 FAIL。

---

## 三、工作日志深层校验（worklog-append.js validate）全景

> 以下由 `worklog-append.js validate --json` 输出，包含枚举成员性、`_id` 规范性、关联任务引用、必填字段四类校验。

### 3.1 统计总览

| 指标 | 数量 |
|------|------|
| 扫描日志文件 | 9 个 |
| 扫描日志条数 | 498 条 |
| 扫描任务条数 | 222 条 |
| **legacy（已知外值）** | **172 条** |
| **error（硬错误）** | **8 条** |
| **warn（格式/引用警告）** | **14 条** |
| **info（信息提示）** | **8 条** |

### 3.2 legacy（已知外值，待存量治理）

**所属项目/对应项目 越界（4 条）**：
- `华纬MES项目` × 3（建议归入 `华纬其它项目`）
- `共用项目-华纬MES实施运维` × 1（建议归入 `华纬其它项目`）

**结果类型 越界（含"会议纪要""知识沉淀""数据完善"等，约 21 条）**：
- 旧版枚举未覆盖的语义项，建议留空或映射到最近似项

**业务模块 越界（约 27 条）**：
- 旧枚举未收录的模块名称，需逐条确认是否应加入 OPTIONS.modules

**项目阶段 越界（约 41 条）**：
- 旧枚举未覆盖的阶段描述，需逐条确认

**问题来源 越界（约 5 条）**：
- 非 6 项标准渠道的填写，需确认是否属于 `现场反馈` 等近似项

**周报归集分类 越界（1 条）**

### 3.3 error（硬错误，写入路径会拦截）

- `_id` 格式不符（`L-` 后不足 10 位十六进制）
- 关联任务引用不存在于 task-pool（5 条，同架构质检层 FAIL）

### 3.4 warn（格式警告，不拦截写入）

- `_id` 格式不规范（如 `L-` 空后缀）
- 其他格式边缘情况

---

## 四、基线原则

1. **不因历史问题降低检查标准** — 已知的 FAIL/WARN/legacy 是存量治理清单，不是修改检查器的理由。
2. **不为消除 FAIL 修改检查器规则** — 保持契约的严肃性，问题在数据层解决。
3. **新产生的问题不得自动视为"已知问题"** — 基线只记录首次运行时的存量问题，后续运行新增的问题需单独处理。
4. **后续运行应能区分"基线问题"和"新增问题"** — 每次运行后对比基线，新出现的 FAIL/WARN/legacy 需要人工确认。

---

## 五、基线通过标准

| 检查维度 | 状态 | 说明 |
|---------|------|------|
| [DATA] worklog-schema.js（架构质检层） | ⚠️ 有已知问题 | 5 个 FAIL（关联任务引用）+ 1 个 WARN（_id 格式） |
| [DATA] worklog-append.js validate（深层校验） | ⚠️ legacy 172 / error 8 / warn 14 | 均为存量问题，不阻断写入 |
| [TOOLS] worklog-append.js CLI | ✅ PASS | validate 子命令正常 |
| [KNOWLEDGE] knowledge-index.json | ✅ PASS | 结构合法 |
| [SKILLS] reference integrity | ✅ PASS | 所有引用文件存在 |

---

## 六、观察期（2026-09-15 ~ 2026-09-29）

### 观察指标

| 指标 | 目标 | 判断方法 |
|------|------|---------|
| 误报率 | < 5% | 每次运行后人工抽查 FAIL/WARN/legacy 是否为真实问题 |
| 新增问题 | 可控 | 记录每次运行与基线的差异，确认是新增还是存量重复 |
| 稳定性 | 100% | 相同操作下结果一致，不因环境变化而波动 |
| legacy 收敛趋势 | 逐周下降 | 存量治理推进后 legacy 数量应逐步减少 |

### 期间不做的 4 件事

- ❌ 不接 `PostToolUse` Hook
- ❌ 不接 `pre-commit` Hook
- ❌ 不把 WARN/legacy 升级 FAIL（尤其是 `_id` 和枚举外值）
- ❌ 不为了清零 FAIL/legacy 修改 Validator

### 阶段 2 启动条件

当同时满足以下条件时，方可进入阶段 2（自动拦截）：
1. 观察期 ≥ 1 周
2. 误报率 < 5%
3. legacy 存量治理进度 > 50%（或用户确认接受现状）
4. 用户明确确认「可以接入 pre-commit」

---

## 七、后续操作指引

### 存量治理（用户主导）

针对 legacy 172 条和 error 8 条，用户可以选择：
1. **修正数据** — 逐条修正日志/任务中的越界值
2. **扩展枚举** — 若某类外值频繁出现且合理，更新 `worklog-schema.js` 的 `OPTIONS` 并同步文档计数
3. **保留现状并标记为"已知问题"** — 完成治理前维持当前状态

### 日常使用方式

```bash
# 架构质检（四大维度）
node scripts/validate-contract.js

# 工作日志深层校验（含 legacy 统计）
node agent/mes-report-agent/tools/worklog-append.js validate
node agent/mes-report-agent/tools/worklog-append.js validate --json
node agent/mes-report-agent/tools/worklog-append.js validate --detail

# 查看当前枚举真源
node agent/mes-report-agent/tools/worklog-append.js schema
```

### 阶段 2 升级流程（未来）

1. 观察期结束后，召开一次契约治理 review
2. 确认 legacy 治理进度或决定接受现状
3. 决定是否将 WARN 升级为 FAIL
4. 决定是否接入 pre-commit / PostToolUse hook
5. 更新本基线文件，记录升级决策

---

## 八、文件定位

- **本文件**：`docs/contract-validation-baseline.md` — 契约质检的基线记录，版本化存储，随 git 历史可追溯
- **契约定义**：`agent/mes-report-agent/tools/worklog-schema.js` — 数据契约真源
- **检查器代码**：
  - `scripts/validate-contract.js` — 架构质检层（4 维度）
  - `scripts/check-worklog-schema.js` — 数据 schema 子检查器
  - `scripts/check-tool-contracts.js` — 工具契约子检查器
  - `scripts/knowledge-index-check.js` — 知识库索引子检查器
  - `scripts/refs-check.js` — Skills 引用完整性子检查器
  - `agent/mes-report-agent/tools/worklog-append.js` — 工作日志深层校验（CLI validate）
- **Skill 入口**：`.claude/skills/contract-keeper/SKILL.md` — Claude Code 交互入口

---

> **最后更新**：2026-09-15（V1r3，合并 worklog-append.js validate 深层校验）
> **下次审查**：2026-09-29（观察期结束，评估是否进入阶段 2）
