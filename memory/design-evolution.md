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

## 经验总结

- 运维实施仓库 ≠ DevOps仓库：应按业务功能组织，而非按运维能力
- 平铺不利于理解依赖关系，必须分层
- 对照已有系统的模块清单（鼎华SMES）可以大幅减少遗漏
- 每个模块的运维物料内聚在一起，比分散到全局目录更实用
