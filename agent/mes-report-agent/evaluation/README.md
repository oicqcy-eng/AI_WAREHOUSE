# Evaluation — mes-report-agent 测试与基线

## 定位

Tier 2 评测目录。存放：
- **Baseline**：数据快照与契约状态的不可变记录
- **Test Cases**：可回归的输入→预期输出对照

## 文件清单

| 文件 | 用途 | 触发时机 |
|------|------|----------|
| `baseline.json` | 当前数据状态 + 契约版本 + 观察项 | 每次契约变更时更新 |
| `enum-validation.json` | 枚举成员性校验用例 | 新增/修改枚举时补充 |
| `task-search.json` | 关键词搜任务用例 | 修改 search-task 逻辑时补充 |
| `worklog-append.json` | 写入路径校验用例 | 修改 append/update 逻辑时补充 |
| `weekly-report.json` | 周报生成用例 | 修改报告生成逻辑时补充 |

## 运行方式

```bash
# 跑全量校验，输出与 baseline 对拍
node tools/worklog-append.js validate --json | diff - baseline.json

# 跑 schema dump，检查枚举计数
node tools/worklog-append.js schema
```

## Baseline 解读

`baseline.json` 分三块：

1. **`contract`** — 契约定义（枚举计数、必填集、有效模式）
2. **`data`** — 数据状态（各字段 present/empty 计数）
3. **`issues`** — validate 输出聚合（按 level/class/field 分组）

**Contract baseline** 回答：当前规则是什么？有没有人偷偷改规则？
**Data baseline** 回答：数据治理有没有变好？

## 决策状态

- **Frozen（已冻结）**：C1～C4，不再重新讨论，除非走变更流程
- **Observation（观察中）**：O1/O2，达到触发条件才进入决策
