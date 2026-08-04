# inbox — 项目收件箱

本项目的**待归类资料暂存区**。属于本项目的资料先落这里，再由 `archive-learning` 归档到对应分类。

## 与顶层 inbox 的关系

| 收件箱 | 定位 |
|--------|------|
| `delivery/inbox/` | 全局总入口：所有新到资料先进这里 |
| `delivery/projects/<项目>/input/inbox/` | **项目分流区**：已明确属于本项目的资料，直接落这里，归档时不必再判断归属 |

## 使用

- 已明确归属本项目的资料 → 直接放本目录
- 归属不确定的资料 → 放顶层 `delivery/inbox/`，由 archive-learning 判断
- archive-learning 同时扫描**两处 inbox**，处理后按类型归档到本项目的 `requirements/sql/report_ui/interfaces`

## 规范

- **复制归档，保留原件**：归档后本目录文件保留（供追溯），定期由人确认后清理
- 脱敏：客户敏感数据入库前替换
