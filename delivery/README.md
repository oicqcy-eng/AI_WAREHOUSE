# 客户交付执行区 (delivery/)

> **定位**: 沉淀 Agent 交付过程中的**客户项目资料、项目知识、交付输出物**。
> 与能力资产层(base/manufacturing/ai/agent)分离 —— 这里是"执行现场"，能力层是"能力工厂"。

## 为什么单独一区

- **客户端数据必须隔离**: 项目资料、需求、SQL、报告 UI 属客户现场信息，不能混入可复用能力
- **项目自包含**: 一个客户项目一个目录，找某个项目的资料进一个门
- **可复用经验回哺**: 交付结束后，提炼可复用经验到 `knowledge/`、`agent/_shared/`、`skills/`

## 目录结构

```
delivery/
├── README.md           ← 本文件
├── inbox/              全局总入口：所有新客户资料先进这里，归类后转走
└── projects/           客户交付项目(自包含, 按需创建)
    └── <客户项目>/      项目结构见 projects/README.md
        ├── README.md   项目背景/目标/状态
        ├── input/      项目输入(脱敏)
        │   ├── inbox/         项目收件箱(已明确属本项目的待归类资料)
        │   ├── requirements/  需求文档
        │   ├── sql/           数据/查询脚本(脱敏)
        │   ├── report_ui/     报表/看板界面规格
        │   └── interfaces/    接口/集成规格
        ├── knowledge/  项目专属知识(三件套)
        ├── output/     交付物(方案/PPT/SOP/报表)
        └── CHANGELOG.md 交付记录
```

`archive-learning` 同时扫描 `delivery/inbox/` 与各项目 `input/inbox/`。

## 边界规则（硬性）

| 内容 | 放哪里 |
|------|--------|
| 客户项目资料/需求/数据 | `delivery/projects/<项目>/` |
| 新到的未归类资料 | `delivery/inbox/`（先进后转） |
| 跨项目可复用的行业知识 | `docs/industry-knowledge/` |
| 跨项目可复用的能力 | `agent/_shared/`、`skills/` |
| 客户交付物成品 | `delivery/projects/<项目>/output/` |

**核心规则**: 
1. **客户数据不进能力层**，只进 `delivery/`，且**脱敏**（客户名/人员/密钥一律替换）
2. **新资料先落 `inbox/`**，归类后移走，inbox 保持接近清空
3. **交付后回哺**: 提炼可复用经验 → `knowledge/`/`agent/_shared/`/`skills/`，然后才归档项目

## 生命周期

`inbox 接收 → 归档学习(archive-learning) → 归类到 projects/<name>/input → 交付 → output 产出 → 交付复核(delivery-review) → 经验回哺 → 项目归档`
详见 `docs/delivery-lifecycle.md`，归档与复核由 `skills/` 下的 Skill 驱动。
