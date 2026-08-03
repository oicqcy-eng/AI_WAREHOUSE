# MES实施专家 Agent

> **版本**: v0.2.0 · **状态**: 标准模板（首个完整样板） · **入口**: [prompt/system.md](prompt/system.md)

## 能力定义

基于 15 年+ 离散制造（汽配优先）实施经验 + 鼎华SMES业务模型，提供 **MES 实施全生命周期咨询**：

| 能力 | 说明 |
|------|------|
| 现状调研 | 访谈/走线/数据收集 → 差距分析（SOP 标准5天） |
| 差距分析 | 痛点排序、P0/P1/P2 优先级 |
| 方案设计 | 模块规划、分步实施路径、收益/成本/风险 |
| 蓝图输出 | 可评审蓝图 + 分阶段验收标准 |
| 推广运营 | 试点样板、培训、防回退方案 |

**输入**: 客户背景/规模/痛点/目标 → **输出**: 差距分析报告、蓝图方案、实施路线图

## 边界（不做）

- ❌ 不编造价格/合同条款/客户未提供数据（未确认信息标注「待核实」）
- ❌ 不回答厂商内部信息与价格谈判
- ❌ 不提供线上数据写操作（工具全只读）

## 依赖

| 依赖 | 指向 |
|------|------|
| 业务数据 | `base/master-data/`、`manufacturing/*/`、`operations/*/` |
| 模型推理 | `ai/serving/` |
| 知识检索 | `ai/vector-db/`（collection: mes-knowledge），`knowledge/` 存引用清单 |
| 交付物输出 | `delivery/projects/<项目>/output/`（成品归档） |

## 目录说明

| 目录 | 内容 | 核心文件 |
|------|------|----------|
| `config/` | Agent 配置（模型/检索/工具白名单） | `agent.yaml` |
| `prompt/` | System Prompt + few-shot + 优化记录 | `system.md` `few-shot.md` |
| `knowledge/` | 知识引用清单 / FAQ / SOP / 案例 | `index.md` `faq.md` |
| `tools/` | 工具清单 / 只读 SQL 模板 | `query-templates.sql` |
| `workflow/` | 实施咨询四阶段流程 | `README.md` |
| `data/` | 数据字典 / 脱敏样本 | `dictionary.md` |
| `evaluation/` | 测试问题库 / 评分规范 / 记录 | `test-cases.md` `scorecard.md` |
| `runbooks/` | 部署 / 运维 / 故障手册 | `deploy.md` `ops.md` |

## 版本状态

- **v0.2.0**（当前）: 标准模板完整落盘 —— 覆盖 config/prompt/knowledge/tools/workflow/data/evaluation/runbooks 全链路
- 变更记录见 `CHANGELOG.md`；发布流程见 `runbooks/ops.md`

## 使用

```
1. 接入运行: 按 runbooks/deploy.md 完成配置与验证
2. 触发场景:
   - 「我要上MES」 → 现状调研 → 方案（workflow 01→04）
   - 「分析下现状」 → 差距分析（01→02）
3. 质量验证: 跑 evaluation/test-cases.md → scorecard.md
```
