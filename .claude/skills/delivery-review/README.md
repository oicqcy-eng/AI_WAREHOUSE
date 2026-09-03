# skill: delivery-review

**交付物质量复核** —— 检查项目交付物是否完整、合规、脱敏，达到交付标准。

## 用途

- 每个客户项目交付物（方案/PPT/SOP/报表）交付前做质量复核
- 对齐 `delivery/projects/<name>/output/` 的交付标准

## 用法

```bash
# 通过 Claude Code 调用（配置到 .claude/skills/ 后）
/skill delivery-review <delivery_item_path>
```

或读取本 skill 的 `SKILL.md` 手动执行复核清单。

## 清单核心

1. 完整性：交付物是否覆盖需求要点（P0 全覆盖）
2. 合规性：是否脱敏（客户名/人员/密钥/真实编码）
3. 质量：结构清晰、术语准确、有量化依据
4. 归属：成品是否落在 `delivery/projects/<name>/output/`
5. 沉淀：是否有可复用经验提炼到共享层

详见 `SKILL.md`。
