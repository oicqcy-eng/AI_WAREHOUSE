# 项目：hw-spring-mes（华纬科技 MES）

> **状态**: 进行中 · **客户**: 华纬科技（杭州弹簧制造） · **开始**: 2026-06
> **组织规则**: 一个客户一个项目目录；厂区子域用 `input/<厂区>/`，跨厂区产出统一 `output/`（2026-08-12 定版，见 CLAUDE.md）

## 项目背景

华纬科技 MES 实施项目，覆盖**多个厂区子域**：三厂小簧、一厂大簧、重庆、实验室 Lims、无锡泽根、华纬其它。各厂区靠 worklog「所属项目」字段区分，周报/月报/dashboard 为**跨厂区单份产出**。

## 项目状态

| 阶段 | 状态 | 说明 |
|------|:----:|------|
| 现状调研 | 进行中 | 各厂区基础资料/需求收集（三厂小簧已归档资料） |
| 差距分析 | 进行中 | 数采部署、制样检验等核心阻塞识别 |
| 方案设计 | 进行中 | 硬件选型、接口对接方案 |
| 实施交付 | 进行中 | 数采部署 65/109、培训赋能、老MES点检替代 |

## 项目结构

```
hw-spring-mes/
├── input/
│   ├── requirements/          需求文档
│   ├── sql/                   通用查询 SQL(脱敏)
│   ├── report_ui/             报表/看板规格
│   ├── interfaces/            接口/集成规格
│   ├── meeting-minutes/       会议纪要(按 年-月 归档)
│   ├── devices/               设备基础资料(跨厂区共用,752台,设备编号前缀→厂区映射)
│   ├── san-chang-xiao-huang/  三厂小簧厂区专属资料(知识卡 K-001~007 + 厂区限定SQL)
│   └── lims_system/           LIMS 项目资料(独立系统: knowledge/提炼卡 + raw/原件区)
├── knowledge/                 项目专属知识/决策
├── output/
│   ├── reports/               跨厂区汇报(周报 W32/W33、月报、简报) md+docx
│   ├── san-chang-xiao-huang/  三厂小簧厂区交付物(整体汇报 md+docx)
│   ├── lims/                  实验室 LIMS 专属产出(IT总监汇报大纲→md+docx)
│   ├── c_q_mes/               重庆厂区交付物(重庆MES项目汇报 md+docx)
│   └── dashboard.html         仪表盘(跨厂区)
├── ops-knowledge/             运维排障知识库(报错截图→排障卡, 2026-08-15 建立)
└── CHANGELOG.md               交付记录
```

## 厂区/系统专属资料归属

| 厂区/系统 | 输入资料位置 | 交付物位置 |
|-----------|------------|-----------|
| 三厂小簧（sMES） | `input/san-chang-xiao-huang/`（知识卡 K-001~007 + 厂区限定 SQL） | `output/san-chang-xiao-huang/`（整体汇报） |
| 一厂大簧（sMES） | `input/yi_chang_da_huang/`（空目录，待归档） | 跨厂区周报统一在 `output/reports/` |
| 重庆（sMES） | `input/c_q_mes/`（空目录，待归档） | `output/c_q_mes/`（重庆MES项目汇报 2026-08-13） |
| 实验室 **LIMS**（独立系统） | `input/lims_system/`（2026-08-13 已归档 12 份原件 raw/ + 3 份提炼知识卡 knowledge/） | 同上 |

> **共库规则**：MES 三厂区共用一个鼎捷 sMES 库，通用资产（数据字典/通用查询）一份共享于 `agent/mes-implement-expert/data/smes-621*`，各厂区不复制；厂区限定 SQL 才进 `input/<厂区>/sql/`。**LIMS 是独立系统独立库**，资产沉淀到 `data/lims/`，不混入 sMES。详见 CLAUDE.md「系统体系与共享资产」。
> 厂区目录统一**全小写下划线**命名（如 `yi_chang_da_huang`、`c_q_mes`；`san-chang-xiao-huang` 为历史遗留）。未来新增厂区/系统在 `input/` 下建子目录，不另建项目目录。

## 关联能力

- 实施咨询能力: `agent/mes-implement-expert/`
- 汇报生成能力: `agent/mes-report-agent/`
- 行业知识: `docs/industry-knowledge/`
- 工作日志/任务池: `agent/mes-report-agent/data/worklog/`（权威数据源）
- 运维排障: `ops-knowledge/`（报错投喂入口 `delivery/inbox/日常运维报错截图/`）
