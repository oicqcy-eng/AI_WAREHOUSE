# projects — 客户交付项目

存放**客户交付项目**（每个项目一个自包含目录）。

## 何时创建

收到某客户项目资料时，按需创建：`delivery/projects/<客户项目>/`。

> **一个客户一个项目目录**（2026-08-12 定版）：客户下的厂区/子域（如华纬的三厂小簧/一厂大簧/重庆）**不另建项目目录**，靠 worklog「所属项目」字段区分；厂区专属资料放 `input/<厂区>/`，跨厂区产出统一 `output/`。详见 CLAUDE.md「交付项目组织规则」。

## 项目结构（模板）

```
delivery/projects/<客户项目>/
├── README.md         项目背景/目标/状态
├── input/            项目输入(脱敏)
│   ├── inbox/         项目收件箱(已明确属本项目的待归类资料)
│   ├── requirements/  需求文档
│   ├── sql/           数据/查询脚本(脱敏)
│   ├── report_ui/     报表/看板界面规格
│   └── interfaces/    接口/集成规格
├── knowledge/        项目专属知识(四件套)
│   ├── file_index.md        资料索引(来源/去向/要点)
│   ├── knowledge_cards.md   知识卡片(业务对象/字段口径/接口规则/页面/待确认)
│   ├── pending_questions.md 待确认问题
│   └── delivery_notes.md    交付建议/注意事项/可复用标签 ★
├── output/           交付物(方案/PPT/SOP/报表)
└── CHANGELOG.md      交付记录
```

> ★ `delivery_notes.md` 沉淀"经验"（交付建议/坑/可复用标签），区别于索引(事实)与卡片(知识)。
> 目录规范详见 `memory/structure-conventions.md`；归档流程见 `skills/archive-learning/`。
