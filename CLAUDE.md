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
- 厂区子目录统一**全小写下划线**命名（如 `input/yi_chang_da_huang/`、`input/c_q_mes/`）；`san-chang-xiao-huang/` 为早期 kebab-case 历史遗留，暂不改名；新厂区在 input/ 下按厂区建子目录

## 系统体系与共享资产（2026-08-14 修正：服务器拓扑）
同一客户可能存在**多个系统**，资产按**系统体系**组织，不按厂区复制。**服务器拓扑（2026-08-14 用户确认）**：
- **sMES 共库**：除重庆/无锡泽根外的 sMES（三厂小簧/一厂大簧/二厂大簧等）共用 **192.168.200.18 的 `sMES_Home_Prod`** 一个库 → 通用资产（数据字典 `agent/mes-implement-expert/data/smes-621/`、通用查询 `data/smes-621-sql/`）**一份共享**，各厂区都不复制
- **独立 MES 服务器**：**重庆 sMES** 独立服务器/独立库，已接入 → 查询走 `--profile cq`；**无锡泽根 sMES** 独立服务器/独立库，**暂未建 profile（待接入）**（见 `config/db.local.json` profiles），资产按系统分库
- **厂区限定资产**（按厂区条件限定的 SQL/资料，如按设备前缀/PROCESSTYPE）→ `input/<厂区>/sql/`
- **独立系统**（LIMS/U9/老MES玖坤）→ 独立资产库 `data/<system>/`（如 `data/lims/`、`data/u9-sql/`），与 smes-621 平级，**不混入** sMES 资产；LIMS 为独立服务器，U9/玖坤另算

**归档铁律（2026-08-12 定版）**：后续所有提交的资料，**必须先判定归属**——属于**具体项目/厂区**（→ `delivery/projects/<客户>/input/<厂区>/`）还是**共用项目**（跨厂区通用资产 → `agent/mes-implement-expert/data/<system>/`）——**判定通过才进行下一步操作**（归档/沉淀/建任务/写入 worklog）。判不了 → 不硬猜不归错，列出现状与候选去向请用户判断；用户确认前不进行下一步。

## 命名规范
- 目录: kebab-case（厂区子目录特例用全小写下划线，见交付项目组织规则）; 脚本: 动词开头; 不存放真实密钥
