# 工具脚本 (scripts/)

> **定位**: 项目级辅助工具脚本
> **目录**: setup/（初始化脚本）、utils/（工具函数）

模块相关的部署脚本请参见 cicd/scripts/。

## 换机迁移（backup-portable / restore-new-pc）

本仓库大部分内容靠 **git + GitHub** 随仓库走（`git clone` 即得，含全部历史）。
但下面 3 类"工作必需"资产在 git 之外，换新电脑时需单独备份还原：

| 资产 | 位置 | 说明 |
|------|------|------|
| Claude 记忆 + 用户配置 | `~/.claude/projects/d--AI-WAREHOUSE/memory/` + `~/.claude/settings.json` | 工作规则/口径铁律（不备份则新电脑上助手不认你的习惯） |
| DB 凭据 | `agent/mes-implement-expert/config/db.local.json`（gitignore） | 三个 MES 库连接信息，不入库 |
| 客户原始资料 | 各厂 `raw/`、`delivery/inbox/`（gitignore） | 原件/截图/输入窗口纪要 |

### 旧电脑——一键备份

```powershell
powershell -ExecutionPolicy Bypass -File scripts\backup-portable.ps1
# 可选: -OutDir 指定zip输出目录; -Name 指定文件名
```

生成 `AI-WAREHOUSE-portable-<时间戳>.zip`（约 80MB，含记忆/凭据/被忽略资料）。

### 新电脑——三步还原

```powershell
# 1. 拉仓库（含历史）
git clone https://github.com/oicqcy-eng/AI_WAREHOUSE.git
cd AI_WAREHOUSE

# 2. 还原记忆/凭据/客户资料（含环境预检）
powershell -ExecutionPolicy Bypass -File scripts\restore-new-pc.ps1 -ZipPath <zip路径>

# 3. 重建 Node 依赖 + 验证连库
cd tmp; npm install
node agent/mes-implement-expert/tools/query-mes.js -q "SELECT 1" --profile home
```

**环境预检**（还原脚本内置，2026-08-23 增强）：脚本开头自动检测 `git / node / npm / tmp依赖` 四项，缺什么打印 winget 安装命令；加 `-AutoInstall` 可自动装；只想检测不还原用 `-SkipRestore`。

> ⚠️ 环境要求：新电脑需安装 **Node.js**（工具脚本依赖）；MES/U9/LIMS 库需在能访问的**内网**。
> ⚠️ zip 包含 DB 凭据，拷贝/存放注意保密（勿上传公共网盘）。
> ⚠️ 装软件/内网不通等需要判断的场景，最省事是在新电脑上**直接开 Claude Code 会话**，让 AI 全程辅助检测、安装、验证。
> 详细场景见 [BUILDING.md 换机迁移章节](../BUILDING.md#换机迁移指南)。

### 详细操作教程（保存起来，换电脑照着做）

**《[换机迁移操作教程.md](换机迁移操作教程.md)》** 已沉淀在 scripts/ 下，包含：旧电脑准备 → 新电脑装环境 → 还原 → 判断还原成功（**不靠连库**）→ 换成新公司/新项目数据库怎么改（`db.local.json` profiles）→ 常见问题。换机前把这份教程 + zip 一起拷走即可。

### ⚠️ 模型接入层（换机启动不了的头号原因）

上面两个脚本**不覆盖模型接入配置**——它由 cc-switch 写入用户级 `~/.claude/settings.json`，既不在 git、也不在 zip 里，换机必丢 → Claude Code 回落官方 API、无有效 key → **启动失败**。

这一层由仓库 **`bootstrap/`** 补齐：

```powershell
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Verify   # 还原后自检四项
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1           # 部署配置
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Capture  # cc-switch 切换后存回仓库
```

详见 [bootstrap/README.md](../bootstrap/README.md)。**换机完整顺序：clone → restore-new-pc.ps1 → bootstrap\deploy.ps1 -Verify → 重开 Claude Code 窗口。**
