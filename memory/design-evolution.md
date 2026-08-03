---
name: design-evolution
description: AI-WAREHOUSE 仓库四次重构的设计演变历程与决策原因
metadata:
  type: reference
---

# AI-WAREHOUSE 设计演化历程

仓库从初始到最终共经历 4 次重构，记录了"运维实施仓库"从构思到落地的完整思路。

## v1 — 按运维能力组织（已废弃）

**提交**: `860e27a`

**思路**: 像传统 DevOps 仓库一样，按"运维能力"切分目录：
- `orchestration/` ← 所有编排（Docker/K8s）
- `monitoring/` ← 所有监控
- `runbooks/` ← 所有手册
- `ai-ops/` ← 所有AI相关
- `security/` ← 所有安全配置

**问题**: 运维人员要找一个模块（比如质量）的相关内容，需要跨 5~6 个目录翻找，不直观。

## v2 — 按功能模块组织（过渡版本）

**提交**: `03983da`

**思路**: 改为按业务功能模块组织，每个模块自包含：
- `quality/` ← 质量：deploy/ monitor/ runbooks/ database/ config/ 全在里面
- `equipment/` ← 设备：同样自包含
- ...

**问题**: 所有 18 个模块平铺在同一层，缺乏层级关系，看不出哪个依赖哪个。

## v3 — 对照鼎华SMES补全（过渡版本）

**提交**: `5da98c0`

**思路**: 用户提供了鼎华SMES的截图界面，逐个对比发现缺失了 5 个模块：
- 新增 `master-data/`（基础资料）、`warehouse/`（仓库）、`scheduling/`（排程）、`kanban/`（看板）、`mould/`（模具）、`barcode/`（条码）
- `notification/` 合并进 `system/`

**问题**: 仍未解决平铺问题，23 个模块全在根目录。

## v4 — 按层级依赖组织（最终版本 ✅）

**提交**: `90668ef`

**思路**: 按模块间的依赖关系分为 5 个层级组：

```
base/             基础层 ← 先部署，上层依赖它
  system/         系统管理（用户/角色/权限/审计/通知）
  master-data/    基础资料（编码/客户/供应商/员工/部门/工序）
  barcode/        条码/RFID

manufacturing/    制造执行层 ← MES 核心
  scheduling/     排程 → production/ 生产 → work-order/ 工单
  process/ 工艺 → andon/ 安灯 → quality/ 品质
  traceability/ 追溯 → equipment/ 设备 → mould/ 模具
  material/ 物料 → warehouse/ 仓库

operations/      运营管理层 ← 基于制造数据的可视化
  kanban/ 看板 → reporting/ 报表 → document/ 文档 → energy/ 能源 → iiot/ 采集

ai/              AI智能层 ← 独立能力，可与MES联动
  serving/ 推理 → gpu/ GPU → vector-db/ 向量 → training/ 训练

shared/          共享基础设施 ← 最先部署
  database/ → gateway/ → monitoring/ → security/ → automation/
```

**关键设计决策**:
1. **模块自包含**: 每个模块有 deploy/ monitor/ runbooks/ database/ config/ tests/
2. **目录深度 ≤ 3**: `manufacturing/quality/deploy/docker-compose.yml`
3. **依赖方向清晰**: base ← manufacturing ← operations，ai 和 shared 横切
4. **README 全覆盖**: 每个目录都有 README 说明定位

## v4.1 — 新增 Agent 业务层（按 Agent 自包含）

**思路**: 在 v4 五层之上增加 `agent/`（AI Agent 业务层），与 `ai/`（基础设施层）解耦。

**决策**: 曾尝试按「12 阶段流水线」组织（01_Project…11_Operation…99_Common），
与 v1「按能力组织」犯同类错误 —— 找一个 Agent 的物料要跨 6+ 目录。
最终改为**一个 Agent = 一个自包含目录**，延续 v4 模块内聚哲学：
`mes-implement-expert/`、`mes-report-agent/`、`industrial-consultant/`，跨 Agent 资产放 `_shared/`。
生命周期（规划→运营闭环）作为**过程文档**写入 `docs/agent-lifecycle.md`，不用目录表达。

## v4.2 — Agent 工程化增强（批判吸收外部建议）

**来源**: 参考 ChatGPT 对 v4.1 架构的评审建议。

**采纳**（工程化思想，不破坏自包含）:
1. Agent 作为一级资产（v4.1 已实现）
2. **版本管理**：语义化版本 + git tag，每 Agent `CHANGELOG.md`；拒绝"复制 versions/ 目录"（Git 本身即版本管理）
3. **质量体系**：evaluation/ 强化为 测试集 + 标准答案 + 评分（准确率/专业度/稳定性）
4. **知识资产分级**：L1 行业知识(`docs/industry-knowledge/`) → L2 通用(`_shared/`) → L3 Agent 专属(`knowledge/`)，向量在 `ai/vector-db/`
5. 生命周期文档补"版本发布"环节

**拒绝**（否则退回 v1 老路）:
1. 全局能力层结构（business/knowledge/tools/data/evaluation/operation 全部提到顶层）—— 正是 v1"按能力组织"的翻版，一个 Agent 的物料会散落 6+ 处
2. 大写下划线命名（`MES_Expert_Agent`）—— 违反仓库 kebab-case 规范
3. `agents/` 复数命名 —— 与其他单数层名(base/ ai/ shared/)不一致

**经验**: 外部建议常"批评与方案自相矛盾"——批判吸收其指出的**问题**，验证其推荐的**方案**是否自洽，再落地。

## v4.3 — 外部建议二次评审（交付物与边界明确）

**来源**: 第二轮 ChatGPT 架构评审。

**采纳**:
1. **交付物归档**：新建 `docs/deliverables/`（按客户/项目），明确"能力与成品分离"——agent/ 存可复用能力，deliverables/ 存一次性成品
2. **memory 边界**：`memory/README.md` 明确"存项目设计记忆，不存业务知识/运行时记忆"；Agent 运行时记忆(对话/画像)=动态数据不入库，由运行层承载

**拒绝**（破坏 v4 结构）:
1. **新增顶层 `applications/`**：交付物是一性成品应归档，生成能力已在 agent/workflow；顶层再加层会形成第三处"产出物"家，归属混乱
2. **`base` → `foundation` 改名**：纯重命名零新增价值，破坏全部引用；`base/` 语境语义清晰
3. **`manufacturing` 改知识库**：误解定位——manufacturing/ 是部署运维模块(deploy/monitor/runbooks)，非文档库；行业知识已由 `docs/industry-knowledge/` 承接
4. **`ai` 层改 llm/rag/embedding**：现状 serving/gpu/vector-db/training 已覆盖推理/GPU/向量/训练

**经验**: 外部评审常混淆"运维实施仓库"与"知识笔记仓库"——先确认对方对仓库定位的理解，再判断其建议是否适用。

## 经验总结

- 运维实施仓库 ≠ DevOps仓库：应按业务功能组织，而非按运维能力
- 平铺不利于理解依赖关系，必须分层
- 对照已有系统的模块清单（鼎华SMES）可以大幅减少遗漏
- 每个模块的运维物料内聚在一起，比分散到全局目录更实用
