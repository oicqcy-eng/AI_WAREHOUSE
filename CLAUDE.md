# AI-WAREHOUSE — CLAUDE.md

## 层级结构
仓库按业务层级分为7组，每组内模块平级：

| 层级 | 目录 | 包含模块 |
|------|------|---------|
| 基础层 | base/ | system, master-data, barcode |
| 制造执行层 | manufacturing/ | scheduling, production, work-order, process, andon, quality, traceability, equipment, mould, material, warehouse |
| 运营管理层 | operations/ | kanban, reporting, document, energy, iiot |
| AI智能层 | ai/ | serving, gpu, vector-db, training |
| AI Agent业务层 | agent/ | mes-implement-expert, mes-report-agent, industrial-consultant, _shared |
| 客户交付执行层 | delivery/ | inbox, projects/<客户项目> |
| 共享基础设施 | shared/ | database, gateway, monitoring, security, automation |

辅助区：`skills/`（可复用 Claude Skills）、`docs/`（规范与行业知识）、`memory/`（项目设计记忆）、`cicd/` `environments/` `scripts/`。

依赖方向：`shared → base → manufacturing → operations`；`ai/` 横切；`agent/` 使用 ai/ 的推理与向量库及业务层数据；`delivery/` 客户端项目，交付后回哺 knowledge/skills。

## 模块结构
每个业务模块: deploy/ monitor/ runbooks/ database/ config/ tests/
每个 Agent 模块(agent/ 下): config/ prompt/ knowledge/ tools/ workflow/ data/ evaluation/ runbooks/
每个项目模块(delivery/projects/ 下): input/ knowledge/ output/

## 交付项目组织规则（2026-08-12 定版）
**一个客户一个项目目录**（`delivery/projects/<客户>/`），如 `hw-spring-mes` = 华纬科技 MES 项目。
- 客户下的**厂区/子域**（如三厂小簧/一厂大簧/重庆/LIMS）不另建项目目录，靠 worklog「所属项目」字段区分
- 厂区专属**输入资料**（客户提供：知识卡/SQL/基础资料/纪要）→ `input/<厂区>/` 子目录
- 跨厂区**产出**（周报/月报/整体汇报/dashboard）→ `output/` 统一放总目录根级
- 厂区子目录用 kebab-case 命名（如 `input/san-chang-xiao-huang/`），新厂区在 input/ 下按厂区建子目录

## 命名规范
- 目录: kebab-case; 脚本: 动词开头; 不存放真实密钥
