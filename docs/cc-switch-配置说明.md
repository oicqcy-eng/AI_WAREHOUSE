# cc-switch 模型接入配置说明（换机重建指引）

> 本机模型接入统一由 **cc-switch**（桌面版）管理：它存储多套 provider 配置，切换时把选中配置的 env 写入用户级 `C:\Users\<用户>\.claude\settings.json`。
> 本文件用于**换电脑 / 重装系统后快速重建**，只记录非敏感参数（API 地址 / 模型名），**API key 一律不入库**，手动填。

## 为什么不用项目级配置

- Claude Code 配置加载优先级：**项目级 > 用户级**。若在仓库 `.claude/settings.json` 里放模型 env，会**压住 cc-switch 的切换**，导致多 provider 切换失效。
- 因此模型接入配置**只放用户级，由 cc-switch 管理**；仓库不参与。换机重建靠本说明 + cc-switch 导出/备份。

## 需要重建的 provider 清单

| provider | 类型 | API 地址 | API 格式 | 模型名（示例） | 备注 |
|----------|------|----------|----------|----------------|------|
| DeepSeek | claude | `https://api.deepseek.com/anthropic` | anthropic | `DeepSeek-V4-FLASH` | 当前默认启用 |
| Claude Official | claude | 官方地址 | anthropic | Claude 5 系列 | 库中已有，env 空（key 未填） |
| 通义千问 Turbo | openclaw | `https://dashscope.aliyuncs.com/compatible-mode/v1` | openai-completions | 通义千问 Turbo | 阿里 |
| Kimi K2.5 | openclaw | `https://api.moonshot.cn/v1` | openai-completions | K2.5 | Moonshot |

## 换机 / 重装重建步骤

1. 安装 cc-switch 桌面版，安装 Claude Code CLI。
2. 在 cc-switch 里逐个**添加 provider**，按上表填：名称、API 地址、API 格式、**API key（手动粘贴）**、模型名。
3. 点 **启用/切换** 到目标 provider —— cc-switch 会自动把 env 写入用户级 `settings.json`。
4. 新开一个 Claude Code 窗口验证（配置对当前已开的窗口不生效，需重启）。
5. 可选：在 cc-switch 里多建几个 provider（如 DeepSeek 各档位模型），日常用 `cc-switch` 一键切换。

## 备份建议

- cc-switch 的 provider 配置存在 `C:\Users\<用户>\.cc-switch\cc-switch.db`（含 key，**不要拷进仓库**）。
- 换机前可手动复制该 db 或 cc-switch 内导出功能，换机后导入；不想导入就按上面步骤手填，5 分钟的事。
- 本仓库 git 历史中曾有把配置迁到项目级又被回滚的记录（0d4850d / eb1ee38），**不要再把模型 env 放回项目级**，否则 cc-switch 切换会失效。
