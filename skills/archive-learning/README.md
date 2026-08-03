# skill: archive-learning

**归档学习** —— 处理 inbox 新资料：判断归属、分门归类、提炼知识、更新知识库。

> 本 skill 不承担复杂开发，专注做好一件事：**让每一份新资料都有明确、正确、可追溯的归宿**。

## 定位：delivery 区"进口"

与 [delivery-review](../delivery-review/README.md)（出口：交付物复核）构成闭环：

```
archive-learning (进口)                        delivery-review (出口)
  inbox → 判断归属 → 归档 → 提炼知识             交付物 → 复核质量/合规/完整性
  不删原件 · 待确认容错 · 标注来源               需求覆盖 · 脱敏 · 沉淀
```

## 核心行为（源自架构师 skill01 设计）

1. 读取 `delivery/inbox/` 下的新资料
2. 判断归属：通用 vs 项目专属；无法判断 → 标记**待确认**
3. 判断类型：需求 / SQL / 报表页面 / 接口 / 问题复盘 / 交付输出
4. **复制归档，保留 inbox 原始文件**（不直接删除，可回滚）
5. 学习分析：生成知识索引、知识卡片、待确认问题
6. 通用经验 → 共享知识库；项目经验 → `delivery/projects/<项目>/knowledge/`
7. 所有结论**注明来源文件**；不确定内容标记**待确认**
8. **不捏造**表名、字段、接口、客户结论

## 知识分层映射（衔接现有结构）

| 架构师说法 | 本仓库落点 |
|-----------|-----------|
| 通用 knowledge | L1 `docs/industry-knowledge/`、L2 `agent/_shared/` |
| 项目 knowledge | `delivery/projects/<项目>/knowledge/` |
| 通用 input | 可复用资产（模板/脚本）→ 共享池 |
| project input | `delivery/projects/<项目>/input/{requirements,sql,report_ui,interfaces}` |

> 适配差异：本仓库**不建顶层 input/**（避免"通用 vs 项目"目录歧义），通用与项目的判断由 skill 规则决定，而非目录结构。

详见 `SKILL.md`。
