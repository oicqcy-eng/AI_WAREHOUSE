# Contract Validation Layer — 执行计划（V1）

> 来源：用户 + ChatGPT 建议融合，2026-09-15 定版

---

## 一、总体架构（不做大系统，只做分层契约校验层）

```
contract-keeper          ← Claude Code Skill（入口，用户可 /contract-keeper 调用）
        │
        └── scripts/validate-contract.js   ← 真正的质检仪器（CLI 工具）
                │
                ├── check-worklog-schema.js    （数据格式 / 字段定义）
                ├── check-tool-contracts.js    （工具接口）
                ├── check-knowledge-index.js   （知识索引）
                └── check-skill-contracts.js   （Agent/Skill 约定）
```

**核心原则**：Skill 只是调度层，真正干活的是 `scripts/*.js`；每个检查器独立、可单独调用、输出 PASS/WARN/FAIL。

---

## 二、V1 覆盖范围（只检真实存在的契约，不凭空创造）

| 契约类型 | 真源文件 | V1 检查内容 |
|---------|---------|------------|
| **Data Schema** | `agent/mes-report-agent/tools/worklog-schema.js` | 枚举完整性、日志/任务必填字段、_id 格式、关联任务引用一致性 |
| **Tool Contract** | `agent/mes-report-agent/tools/worklog-append.js` | CLI 子命令签名、参数 JSON 格式、返回值结构 |
| **Knowledge Index** | `knowledge-index.json` | schemaVersion 匹配、entries 数组结构、domain 合法值 |
| **Skill/Agent** | `.claude/skills/*/SKILL.md` | frontmatter 必填字段（name/description）、引用的脚本文件存在性 |

> `knowledge-index.json` 当前 entries 为空（0 条），V1 只校验结构合法，不校验数据内容。

---

## 三、错误等级定义

| 等级 | 含义 | 行为 |
|-----|------|-----|
| **PASS** | 契约完好 | 正常 |
| **WARN** | 潜在风险但不阻断 | 打印告警，不退出非零 |
| **FAIL** | 契约被破坏 | 退出码 1，CI/Hook 可据此拦截 |

---

## 四、执行步骤（按阶段）

### 阶段 1：搭建基础设施（本阶段）

**1.1 创建目录结构**

```
scripts/
  validate-contract.js       ← 主入口
  check-worklog-schema.js    ← 数据契约检查
  check-tool-contracts.js    ← 工具契约检查
  check-knowledge-index.js   ← 知识索引检查
  check-skill-contracts.js   ← Skill 契约检查
.claude/skills/
  contract-keeper/
    SKILL.md
```

**1.2 `scripts/validate-contract.js` 主入口**

```bash
# 用法
node scripts/validate-contract.js                     # 全量检查
node scripts/validate-contract.js --phase schema      # 只跑数据契约
node scripts/validate-contract.js --phase tools       # 只跑工具契约
node scripts/validate-contract.js --json              # JSON 输出（供 CI）
```

输出格式：
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 AI-WAREHOUSE Contract Validation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[DATA] worklog-schema
  ✓ projects enum: 7 items
  ✓ resultTypes enum: 8 items
  ✓ log required fields: 5/5
  ✓ task required fields: 4/4
  ⚠ T-918bed83183c _id format non-standard (12 chars, expected 10)

[TOOLS] worklog-append.js
  ✓ CLI signature: log|task|update-log|update-task|delete-log|delete-task|validate
  ✓ JSON arg parsing

[KNOWLEDGE] knowledge-index.json
  ✓ version: 2.0.0 matches schemaVersion
  ✓ entries: 0 (empty, structural only)

[SKILLS] .claude/skills/
  ✓ archive-learning: frontmatter valid, scripts/ocr.ps1 exists
  ✓ defuddle: frontmatter valid
  ✓ delivery-review: frontmatter valid, scripts/scan-sensitive.sh exists
  ✓ report-board: frontmatter valid, templates/control-board-template.html exists
  ⚠ book-to-skill: no frontmatter found (plain markdown, may be intentional)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PASS: 14  WARN: 2  FAIL: 0
Exit code: 0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**1.3 创建 `contract-keeper` Skill**

`SKILL.md` 内容要点：
- `description`: "契约质检员——在修改仓库前后检查数据格式、字段定义、工具接口、Agent约定是否被破坏"
- `disable-model-invocation: true`（只有用户主动调用，Claude 不自动触发）
- 调用方式：`/contract-keeper` 或 `node scripts/validate-contract.js`

---

### 阶段 2：稳态后加 Hook（未来）

当 V1 稳定运行 1-2 周、误报率低之后，再考虑：

```
.git/hooks/pre-commit → node scripts/validate-contract.js --phase schema
```

**暂不做**：
- PreToolUse Hook（风险：还没验证过 Validator，误判会锁死工作流）
- PostToolUse Hook（同上）
- Git pre-commit（同上）

---

## 五、文件清单

| 文件 | 操作 | 说明 |
|------|------|------|
| `scripts/validate-contract.js` | **新建** | 主入口，调度各检查器 |
| `scripts/check-worklog-schema.js` | **新建** | 读 worklog-schema.js，校验枚举/字段 |
| `scripts/check-tool-contracts.js` | **新建** | 解析 worklog-append.js CLI 签名 |
| `scripts/check-knowledge-index.js` | **新建** | 校验 knowledge-index.json 结构 |
| `scripts/check-skill-contracts.js` | **新建** | 扫描 .claude/skills/*/SKILL.md |
| `.claude/skills/contract-keeper/SKILL.md` | **新建** | Skill 入口 |
| `docs/contract-validation-plan.md` | **新建** | 本文档 |

---

## 六、验收标准

阶段 1 完成后，以下命令均能正常执行并给出合理输出：

```bash
# 全量检查
node scripts/validate-contract.js

# 只看数据契约
node scripts/validate-contract.js --phase schema

# JSON 输出（供将来接入 CI）
node scripts/validate-contract.js --json

# Skill 调用
/contract-keeper
```

---

## 七、风险与注意事项

1. **不修改任何现有文件**（worklog-schema.js / worklog-append.js / knowledge-index.json）——只读检查
2. **WARN 不阻断**——存量历史数据（如 _id 格式不规范）不强制修复，只告警
3. **knowledge-index.json entries 为空**——V1 只校验结构，不报"没有条目"的错
4. **book-to-skill 和 defuddle 没有 frontmatter**——作为 WARN 而非 FAIL，允许 plain markdown skill 存在

---

## 八、决策点

请确认以下事项后我开始执行：

- [ ] 阶段 1 范围确认（4 个检查器，只读，不改动现有文件）
- [ ] 输出格式确认（PASS/WARN/FAIL 分级，文本 + JSON 双模式）
- [ ] 是否现在执行，还是先进一步讨论细节？
