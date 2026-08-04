# create_History — 建设历程底稿索引

> **定位**: 本目录存放 AI-WAREHOUSE **建设过程**的原始底稿索引。
> 原始会话记录是逐字逐句的完整底稿，供追溯"每一步聊了什么、为什么这么决策"。

## 原始会话底稿（Claude Code 自动记录）

完整对话记录由 Claude Code 自动保存在：

```
C:\Users\Administrator\.claude\projects\d--AI-WAREHOUSE\
```

### 会话文件清单

| 文件 | 会话 | 说明 |
|------|------|------|
| `b92f0cbc-….jsonl` | 2026-08-03 起（当前主会话） | 覆盖 Agent 重构、工程化、delivery 融合、Skills、三厂小簧等 |
| `c707d477-….jsonl` | 2026-07-24 | 初始建仓 v1→v4、README 补全 |
| `d612cc65-….jsonl` | 2026-07-24 | 设计文档、使用指南 |

### 文件格式说明

- `.jsonl` = JSON Lines（每行一条事件记录），包含：用户消息、助手回复、工具调用、时间戳
- **适合机器读取/检索**，人直接阅读较困难（含工具内部数据）
- 如需人读的连贯叙述 → 看 [BUILDING.md](../BUILDING.md)（提炼版）
- 架构决策速查 → [memory/design-evolution.md](../memory/design-evolution.md)

## 如何查看原始记录

方法1（命令行查看某段）：
```bash
# 查看 b92f0cbc 会话的开头
head -50 "C:\Users\Administrator\.claude\projects\d--AI-WAREHOUSE\b92f0cbc-2743-4790-bb15-cbd5bdc81162.jsonl"

# 搜索关键词（如"三厂小簧"）
grep "三厂小簧" "C:\Users\Administrator\.claude\projects\d--AI-WAREHOUSE\b92f0cbc-2743-4790-bb15-cbd5bdc81162.jsonl"
```

方法2（结构化查看）：用支持 JSONL 的工具或脚本解析。

## 说明

- 原始底稿**只在本机**，不入 git（避免把对话内部数据推送到远程）
- 本目录只放**索引与指引**，供后续回顾时知道去哪找原始记录
- 三份对照：原始底稿（jsonl，本机）↔ 叙述版（BUILDING.md，入库）↔ 决策速查（design-evolution.md，入库）
