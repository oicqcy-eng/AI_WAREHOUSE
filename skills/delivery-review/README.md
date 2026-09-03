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

## 脱敏扫描脚本（合规检查机器兜底）

```bash
# 扫通用敏感模式（密钥/token/手机号/邮箱/IP/明文口令）
bash skills/delivery-review/scripts/scan-sensitive.sh <交付物文件或目录>

# 追加客户敏感词表（真实客户名/人员名/真实编码，每行一个）
bash skills/delivery-review/scripts/scan-sensitive.sh <路径> --extra <词表.txt>
```

命中即逐条打印 `文件:行:内容` 并 exit 1（需人工复核是否误报）；无命中 exit 0。
文本扫描范围：md/txt/html/csv/json/xml/sql/yml/sh/py。

详见 `SKILL.md`。
