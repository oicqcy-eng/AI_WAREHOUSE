# output — 交付物

本项目交付的成品输出物。

## 存放内容

- 方案文档、蓝图
- 汇报材料（PPT/周报/月报）→ 历史汇报归档在 `reports/` 子目录
- SOP、培训资料
- 报表模板

## 汇报归档（reports/）

`reports/` 存放华纬 MES 项目实施汇报（周报/月报/简报），由飞书多维表格数据生成、**md + docx 双份**存档：

```
reports/
├── 2026-08-08_周报_W32.md/.docx      ← 项目经理周报（全项目汇总）
├── 2026-08-08_月报_7月.md/.docx      ← 月度项目复盘
└── 2026-08-08_简报.md/.docx          ← 高层一页纸简报
```

- **md**：留档、进 git、便于对比
- **docx**：WPS/Office 打开用，排版样式（微软雅黑/8pt表格/实黑框线/彩色状态）见 `agent/mes-report-agent/data/report-bitable-spec.md` §9
- 转换：`agent/mes-report-agent/tools/md-to-docx.js`
- 命名：`<YYYY-MM-DD>_<周报|月报|简报>_<口径>.md/.docx`，不改名覆盖
- **不写来源信息**：汇报内不标注生成日期/数据源等内部字样

## 厂区专属汇报

各厂区专项汇报按厂区建子目录（**一个厂区一个目录**，跨厂区整体汇报放 `reports/`）：

```
output/
├── reports/                 ← 全项目周报/月报/简报
├── san-chang-xiao-huang/    ← 三厂小簧专项汇报
├── yi_chang_da_huang/       ← 一厂大簧专项汇报（含 2026-08-14 起「今日报工报表」）
├── c_q_mes/                 ← 重庆 MES 专项汇报
└── lims/                    ← 实验室 LIMS 专项汇报
```

厂区数据类报表（如 `2026-08-14_一厂大簧今日报工报表.md/.docx`）来自 sMES 生产库实时查询（`agent/mes-implement-expert/tools/query-mes.js`），同样 md + docx 双份。

## 命名规范

`<主题>_v<版本>_<YYYYMMDD>.<ext>`，例如 `MES蓝图_v1.0_20260801.docx`。不改名覆盖。

## 规范

1. **交付物跟项目走**: 本项目成品只放这里，不散落到能力层
2. **敏感信息脱敏**: 客户名/人员/数据脱敏后才入库
3. **成品不入资产流**: 交付物是输出，可复用经验提炼到 `knowledge/`（本目录上级）或共享层
4. 交付物按项目归档，全局归档由 `delivery/` 区统一承接
