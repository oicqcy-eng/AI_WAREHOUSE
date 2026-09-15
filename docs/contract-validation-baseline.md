# Contract Validation Baseline — V1r2 首次运行基线

> **基线日期**：2026-09-15
> **版本**：V1r2
> **生成命令**：`node scripts/validate-contract.js --json`
> **状态**：已确认，进入观察期

---

## 一、已知 FAIL（存量问题清单）

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

## 二、已知 WARN（潜在风险，暂不阻断）

| # | 维度 | 字段 | 问题描述 | 级别 |
|---|------|------|---------|------|
| 1 | Data Schema | _id | `_id "L-"` 不符合规范（应为 L- + 10 位十六进制） | WARN |

**性质**：历史数据格式问题。
**当前等级**：WARN（不阻断工作流）。
**后续处理**：存量治理完成后，评估是否升级为 FAIL。

---

## 三、基线原则

1. **不因历史问题降低检查标准** — 已知的 FAIL/WARN 是存量治理清单，不是修改检查器的理由。
2. **不为消除 FAIL 修改检查器规则** — 保持契约的严肃性，问题在数据层解决。
3. **新产生的问题不得自动视为"已知问题"** — 基线只记录 V1 首次运行时的存量问题，后续运行新增的问题需单独处理。
4. **后续运行应能区分"基线问题"和"新增问题"** — 每次运行后对比基线，新出现的 FAIL/WARN 需要人工确认。

---

## 四、基线通过标准

| 检查维度 | 状态 | 说明 |
|---------|------|------|
| [DATA] worklog-schema.js | ⚠️ 有已知问题 | 5 个 FAIL（关联任务引用）+ 1 个 WARN（_id 格式） |
| [TOOLS] worklog-append.js | ✅ PASS | CLI validate 子命令正常 |
| [KNOWLEDGE] knowledge-index.json | ✅ PASS | 结构合法 |
| [SKILLS] reference integrity | ✅ PASS | 所有引用文件存在 |

---

## 五、观察期（2026-09-15 ~ 2026-09-29）

### 观察指标

| 指标 | 目标 | 判断方法 |
|------|------|---------|
| 误报率 | < 5% | 每次运行后人工抽查 FAIL/WARN 是否为真实问题 |
| 新增问题 | 可控 | 记录每次运行与基线的差异，确认是新增还是存量重复 |
| 稳定性 | 100% | 相同操作下结果一致，不因环境变化而波动 |

### 期间不做的 4 件事

- ❌ 不接 `PostToolUse` Hook
- ❌ 不接 `pre-commit` Hook
- ❌ 不把 WARN 升级 FAIL（尤其是 `_id`）
- ❌ 不为了清零 FAIL 修改 Validator

### 阶段 2 启动条件

当同时满足以下条件时，方可进入阶段 2（自动拦截）：
1. 观察期 ≥ 1 周
2. 误报率 < 5%
3. 新增问题已逐一确认并处理完毕
4. 用户明确确认「可以接入 pre-commit」

---

## 六、后续操作指引

### 存量治理（用户主导）

针对基线中的 5 个 FAIL，用户可以选择：
1. **修正日志中的 关联任务 引用** — 删除错误或补齐任务池
2. **补充缺失的任务记录** — 将 T-xxxx / T-20260910a/b/c 等补入 task-pool.json
3. **保留现状并标记为"已知问题"** — 如果这些引用本身是合理的（如自由文本），可考虑在 checker 中增加例外规则（需谨慎）

### 观察期使用方式

```bash
# 每次需要时手动运行（不要自动触发）
node scripts/validate-contract.js

# 或只看某个维度
node scripts/validate-contract.js --phase schema
node scripts/validate-contract.js --phase skills

# 对比基线：比较本次输出与 docs/contract-validation-baseline.md
```

### 阶段 2 升级流程（未来）

1. 观察期结束后，召开一次契约治理 review
2. 确认存量问题已清零或已接受
3. 决定是否将 WARN 升级为 FAIL
4. 决定是否接入 pre-commit / PostToolUse hook
5. 更新本基线文件，记录升级决策

---

## 七、文件定位

- **本文件**：`docs/contract-validation-baseline.md` — 契约质检的基线记录，版本化存储，随 git 历史可追溯
- **契约定义**：`agent/mes-report-agent/tools/worklog-schema.js` — 数据契约真源
- **检查器代码**：`scripts/` — 四大检查器实现
- **Skill 入口**：`.claude/skills/contract-keeper/SKILL.md` — Claude Code 交互入口

---

> **最后更新**：2026-09-15（V1r2 首次运行）
> **下次审查**：2026-09-29（观察期结束，评估是否进入阶段 2）
