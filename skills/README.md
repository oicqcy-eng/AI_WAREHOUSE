# 可复用 Skills (skills/)

> **定位**: 跨 Agent / 跨项目复用的 **Claude Skills**（SKILL.md 格式）。
> 一个 skill = 一个可重复调用的能力包，供交付过程与 Agent 使用。

## 与相邻目录的边界

| 目录 | 内容 | 区别 |
|------|------|------|
| `skills/`（本目录） | 可复用 Claude Skills | 标准化 SKILL.md，可被 Claude Code 加载调用 |
| `agent/<name>/tools/` | 某 Agent 专属工具 | 绑定的 Agent 专属 |
| `agent/_shared/` | 跨 Agent 通用资产 | 非 SKILL.md 格式的模板/脚本 |
| `delivery/` | 客户项目执行 | 项目专属，不在此 |

## 目录结构

```
skills/
├── README.md           ← 本文件
└── <skill-name>/       ← kebab-case
    ├── README.md        说明：用途/用法
    └── SKILL.md         标准 Skill 定义(frontmatter + 指令)
```

## 加载方式

- 顶层 `skills/` 便于人阅读与维护
- 需要时软链/复制到 `.claude/skills/` 供 Claude Code 自动加载

## 规范

1. **SKILL.md 格式**: frontmatter 含 `name`、`description`，正文为执行指令/清单
2. **可复用才放**: 只收 2 个及以上场景会用的能力；项目专属放 `delivery/`
3. **脱敏**: skill 内容不得含客户敏感数据
4. **技能随交付沉淀**: 交付中总结出的可复用方法 → 提炼为 skill
