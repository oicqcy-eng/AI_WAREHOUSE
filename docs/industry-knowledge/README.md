# 行业业务知识（Industry Knowledge）

> **定位**: 跨 Agent 共享的**领域业务知识**（L1），是制造业数字化专家能力的沉淀。
> 与各 Agent 的 `knowledge/`（L3 专属引用清单）分离 —— 此处存知识与索引，Agent 侧存引用。

## 为什么单独放这里

- MES 实施专家、项目汇报、数字化顾问等 Agent 会**复用同一份行业知识**
- 知识内容与 Agent 解耦，一处维护、多处引用，避免多份拷贝漂移
- 大文件/版权资料（软件手册、行业报告）不入库，放 `ai/vector-db/` 或外部存储，此处存**索引与要点**

## 目录规划

```
docs/industry-knowledge/
├── README.md            ← 本文件(索引入口)
├── mes/                 MES 领域知识（鼎华SMES 等）
├── erp/                 ERP 领域知识（鼎捷U9 等）
├── automotive/          汽配行业知识与案例
├── lean/                精益生产/改善方法论
└── methodology/         数字化咨询/实施方法论
```

（子目录按需创建，每个子目录一份 README 说明内容与来源）

## 内容规范

1. **每条知识标注来源与日期**，可追溯
2. **与 Agent 的关系**：Agent 的 `knowledge/` 引用此处（如 `docs/industry-knowledge/mes/鼎华SMES要点.md`）
3. **向量化**：检索类知识向量化后进 `ai/vector-db/`，此处保留可读索引
4. **不存机密**：客户现场数据、密钥不入库，只存方法论与脱敏案例

## 现有关联

- 汇报案例：[docs/changelogs/chongqing-smes-report.md](../changelogs/chongqing-smes-report.md)
- 业务模块数据源：`base/`、`manufacturing/`、`operations/`（此处为"经验/方法论"，非模块配置）
