# 可复用 Skills (.claude/skills/)

> **定位**: 跨 Agent / 跨项目复用的 **Claude Skills**（SKILL.md 格式）。
> 一个 skill = 一个可重复调用的能力包，供交付过程与 Agent 使用。
> **单一来源**：本目录为唯一维护源，由 Claude Code 自动加载，无需同步其他位置。

## 与相邻目录的边界

| 目录 | 内容 | 区别 |
|------|------|------|
| `.claude/skills/`（本目录） | 可复用 Claude Skills | 标准化 SKILL.md，被 Claude Code 自动加载调用 |
| `agent/<name>/tools/` | 某 Agent 专属工具 | 绑定的 Agent 专属 |
| `agent/_shared/` | 跨 Agent 通用资产 | 非 SKILL.md 格式的模板/脚本 |
| `delivery/` | 客户项目执行 | 项目专属，不在此 |

## 目录结构

```
.claude/skills/
├── README.md           ← 本文件
├── archive-learning/   ⭐ 归档学习(进口)：inbox → 判断归属 → 归档 → 提炼知识
├── delivery-review/    交付物复核(出口)：交付物 → 质量/合规/完整性检查
├── report-board/       控制台风汇报板：模块化 HTML 汇报版面(投影)，模板+生成指引
├── defuddle/           Web 页面内容提取
├── book-to-skill/      文档转 Skill
└── <skill-name>/       ← kebab-case
    └── SKILL.md         标准 Skill 定义(frontmatter + 指令)
```

`archive-learning` 与 `delivery-review` 构成 delivery 区"进口/出口"闭环。

## 加载方式

- 本目录为**唯一来源**，Claude Code 启动时自动加载其中的 SKILL.md（下次会话生效）
- description 已按官方 best practice 写触发条件（Use when:…），一经挂载会常驻每会话 system prompt（约 100 token/个），故 description 需精炼
- 新增 skill：直接在 `.claude/skills/<name>/SKILL.md` 创建，无需同步到其他位置

## 规范

1. **SKILL.md 格式**: frontmatter 含 `name`、`description`，正文为执行指令/清单
2. **可复用才放**: 只收 2 个及以上场景会用的能力；项目专属放 `delivery/`
3. **脱敏**: skill 内容不得含客户敏感数据
4. **技能随交付沉淀**: 交付中总结出的可复用方法 → 提炼为 skill
