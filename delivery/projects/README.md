# projects — 客户交付项目

存放**客户交付项目**（每个项目一个自包含目录）。

## 何时创建

收到某客户项目资料时，按需创建：`delivery/projects/<客户项目>/`。

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
├── knowledge/        项目专属知识(三件套: file_index/knowledge_cards/pending_questions)
├── output/           交付物(方案/PPT/SOP/报表)
└── CHANGELOG.md      交付记录
```

> 目录规范详见 `memory/structure-conventions.md`；归档流程见 `skills/archive-learning/`。
