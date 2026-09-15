---
name: contract-keeper
description: 架构质检员——检查仓库的数据格式、字段定义、工具接口、Agent约定是否被破坏。在修改仓库前后运行，发现契约违规时报告给人类。不要自动修复，只报告问题。
disable-model-invocation: true
allowed-tools: Bash(node scripts/validate-contract.js*)
---

# Contract Keeper — 架构质检员

**定位**：只读检查层，不修改任何文件，不自动修复，只报告问题。

## 何时使用

当用户说以下任一情况时触发：
- "检查契约"
- "运行质检"
- "validate contract"
- "修改前先检查"
- "修改后检查"

## 执行步骤

1. **运行全量检查**
   ```bash
   node scripts/validate-contract.js
   ```

2. **解析输出**
   - PASS: 通过项数
   - WARN: 警告项数（潜在风险）
   - FAIL: 失败项数（契约破坏）

3. **报告结果**
   - 如果有 FAIL：列出所有失败项，说明影响
   - 如果有 WARN：列出警告项，提示用户关注
   - 如果全 PASS：确认契约完好

4. **禁止事项**
   - 不要自动修复任何问题
   - 不要修改任何文件
   - 不要假设用户会自行处理

## 输出格式

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 AI-WAREHOUSE Contract Validation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[DATA] worklog-schema.js
  [OK] ENUM consistency: PASS
  [WARN] _id: ...
  [FAIL] 关联任务: ...

[TOOLS] worklog-append.js
  [OK] validate subcommand runs

[KNOWLEDGE] knowledge-index.json
  [OK] Structure valid

[SKILLS] reference integrity
  [OK] All referenced files exist

==============================
PASS: 5  WARN: 1  FAIL: 5
==============================
```

## 关键契约说明

### 数据契约 (Data Schema)
- **真源**: `agent/mes-report-agent/tools/worklog-schema.js`
- **检查**:
  - 枚举值完整性（7 项目 / 8 结果类型 / 11 模块等）
  - 必填字段存在性
  - `_id` 格式规范（L-/T- + 10 位十六进制）
  - 关联任务引用一致性

### 工具契约 (Tool Contract)
- **真源**: `agent/mes-report-agent/tools/worklog-append.js`
- **检查**:
  - CLI 子命令可用（log/task/update-log/update-task/delete-log/delete-task/validate）
  - JSON 参数解析正常
  - 返回值结构符合约定

### 知识索引契约 (Knowledge Index)
- **真源**: `knowledge-index.json`
- **检查**:
  - `version`: 字符串
  - `schemaVersion`: 字符串
  - `entries`: 数组

### Skill 引用契约 (Skill Reference)
- **真源**: `.claude/skills/*/SKILL.md`
- **检查**:
  - SKILL.md 可读
  - 引用的脚本/模板文件存在（.ps1/.sh/.html/.js）

## 错误分级

- **PASS**: 契约完好
- **WARN**: 潜在风险，不阻断工作流（如：历史遗留的 _id 格式不规范）
- **FAIL**: 契约破坏，需人工处理（如：关联任务引用了不存在的任务 ID）

## 后续行动

- **全 PASS**: 告知用户"契约完好，可以继续"
- **有 WARN**: 列出警告，询问用户是否需要关注
- **有 FAIL**: 列出失败项，**停止后续操作**，等待用户确认后再继续