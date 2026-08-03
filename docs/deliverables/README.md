# 交付物归档（Deliverables）

> **定位**: 客户交付物与项目产出物的**归档区**（一次性成品：方案、汇报、PPT、SOP 等）。
> 与 `agent/`（可复用能力）分离 —— 这里存"生成的成品"，Agent 目录存"生成的能力"。

## 与相邻目录的边界

| 目录 | 存什么 | 不存什么 |
|------|--------|----------|
| `agent/<name>/workflow` + `tools/` | 生成交付物的**能力** | 具体成品 |
| `docs/changelogs/` | 项目变更记录 | 交付物本身 |
| `docs/industry-knowledge/` | 方法论 / 行业知识 | 一次性交付物 |
| `docs/deliverables/`（本目录） | **具体交付成品** | 可复用能力 / 知识 |

## 组织方式

按 **客户/项目** 归档，含日期与版本：

```
docs/deliverables/
└── <客户或项目>/          ← 如 chongqing-smes/
    └── README.md           索引 + 时间线
    └── MES应用成熟度评估_v1.0.docx
    └── 董事长汇报_v1.2.pptx
```

## 规范

1. **命名含日期/版本**：`<主题>_v<版本>_<YYYYMMDD>.ext`，不改名覆盖
2. **敏感数据脱敏**：客户现场数据、人员信息脱敏后入库；原始机密不入库
3. **成品不参与资产流**：交付物是输出，不回流为 Agent 能力；可复用经验沉淀到 `docs/industry-knowledge/`
4. 每个项目一个 README，记录产出时间线

## 现有相关

- 汇报成品：[docs/changelogs/chongqing-smes-report.md](../changelogs/chongqing-smes-report.md)
- 生成能力：`agent/mes-report-agent/`
