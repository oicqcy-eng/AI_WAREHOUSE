# cc-switch 模型接入配置说明（换机重建指引）

> 本机模型接入统一由 **cc-switch**（桌面版）管理：它存储多套 provider 配置，切换时把选中配置的 env 写入用户级 `C:\Users\<用户>\.claude\settings.json`。
> 本文件用于**换电脑 / 重装系统后快速重建**，只记录非敏感参数（API 地址 / 模型名），**API key 一律不入库**，手动填。

## 为什么不用项目级配置

- Claude Code 配置加载优先级：**项目级 > 用户级**。若在仓库 `.claude/settings.json` 里放模型 env，会**压住 cc-switch 的切换**，导致多 provider 切换失效。
- 因此模型接入配置**只放用户级**，仍是单一写入点。

## 但换机必须能恢复 → `bootstrap/`（2026-09-14 定版）

"仓库不参与"留下了缺口：用户级 `settings.json` 既不在 git、也不在便携备份 zip 里——**历次"换机启动不了"皆源于此**。
现由仓库 `bootstrap/` 补上这一层：**真值随仓库走，脚本部署到用户级**。

| 环节 | 位置 / 命令 |
|------|------------|
| 配置真值 | `bootstrap/settings.user.local.json`（含 key，gitignore，随便携 zip 传递） |
| 模板 | `bootstrap/settings.user.example.json`（脱敏，入库） |
| 部署到本机 | `bootstrap\deploy.ps1` |
| 抓取回仓库 | `bootstrap\deploy.ps1 -Capture`（**cc-switch 切换后必跑**） |
| 换机自检 | `bootstrap\deploy.ps1 -Verify`（配置 / 端点 / DB / 依赖 四项） |

**仍是用户级单一写入点，未改用项目级，所以 cc-switch 的切换不受影响。**
两者写同一个文件，别同时用：cc-switch 切换后跑 `-Capture` 存回仓库；`deploy.ps1` 部署后不要立刻在 cc-switch 点切换。
详见 `bootstrap/README.md`。

## 需要重建的 provider 清单

| provider | 类型 | API 地址 | API 格式 | 模型名（示例） | 备注 |
|----------|------|----------|----------|----------------|------|
| DeepSeek | claude | `https://api.deepseek.com/anthropic` | anthropic | `DeepSeek-V4-FLASH` | 备用 |
| **DouBaoSeed（火山）** | claude | `https://ark.cn-beijing.volces.com/api/compatible` | anthropic | **`doubao-seed-evolving`**（全小写） | 免费 550 万 token，主力。详见下方排障记录 |
| Claude Official | claude | 官方地址 | anthropic | Claude 5 系列 | 库中已有，env 空（key 未填） |
| 通义千问 Turbo | openclaw | `https://dashscope.aliyuncs.com/compatible-mode/v1` | openai-completions | 通义千问 Turbo | 阿里 |
| Kimi K2.5 | openclaw | `https://api.moonshot.cn/v1` | openai-completions | K2.5 | Moonshot |

> ⚠️ 库中另有 **DeepSeek_Sec** / **Zhipu GLM** 两个 provider，都指向 `api.scnet.cn`，2026-09-08 实测 **HTTP 401「用户未登录」已失效**，建议删除，勿切换。

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

## 排障记录（2026-09-08 火山 404 案例）

**症状**：切到 DouBaoSeed 后请求报 `HTTP 404 InvalidEndpointOrModel.NotFound`（日志：`~/.cc-switch/logs/cc-switch.log` 的 `[FWD-003]`）。

**根因（实测，非猜测）**：provider 里 9 处模型名填成了 **`Doubao-Seed-1.8`**——该模型已退役。文档/教程写的 `Doubao-Seed-Evolving`（驼峰）也是错的，**火山 Ark 模型名大小写敏感**，正确 id 是**全小写 `doubao-seed-evolving`**。

**判定方法（关键）**：别信文档，直接连 key 实测——
```bash
# 1) 列出该 key 真实可用模型（找 status 非 Shutdown/Retiring，模型名全是小写）
curl "https://ark.cn-beijing.volces.com/api/v3/models" -H "Authorization: Bearer <ark-key>"
# 2) 用想用的模型发最小请求验证（Anthropic 兼容端点）
curl "https://ark.cn-beijing.volces.com/api/compatible/v1/messages" \
  -H "Authorization: Bearer <ark-key>" -H "Content-Type: application/json" -H "anthropic-version: 2023-06-01" \
  -d '{"model":"doubao-seed-evolving","max_tokens":8,"messages":[{"role":"user","content":"hi"}]}'
```
- 200 → 可用；404 `InvalidEndpointOrModel` / `ModelNotOpen` → 模型名错或未开通。
- key 无效会 401（鉴权），base 写错会连接失败——**404 恰好说明 key 和地址都对，只差模型名**。

**改库要点（直接改 SQLite 时）**：cc-switch 的 provider 在 `cc-switch.db` 的 `providers` 表，配置存 `settings_config` 列（JSON）。改法：
1. **先完全退出 cc-switch.exe**（运行中会写回覆盖改动），再备份 `cc-switch.db`；
2. `UPDATE providers SET settings_config=replace(settings_config,'旧名','doubao-seed-evolving') WHERE id='<provider-id>';`
3. 设 current：`UPDATE providers SET is_current=0 WHERE app_type='claude'; UPDATE providers SET is_current=1 WHERE id='<provider-id>';`，并同步 `~/.cc-switch/settings.json` 的 `currentProviderClaude`。
4. 改完重启 cc-switch 应用切换 → **重开 Claude Code 窗口**（旧窗口 env 不生效）。

**base URL 备忘**：火山 Ark Anthropic 兼容端点 = `https://ark.cn-beijing.volces.com/api/compatible`（Claude Code 会拼 `/v1/messages`）；`/api/v3` 是 OpenAI 兼容的 `chat/completions` 路径，两者别混。当前 DouBaoSeed 的 base URL 本身正确，无需改。

### ⚠️ 关键教训：直接改 `cc-switch.db` 会被 GUI 覆盖（2026-09-08 二次踩坑）

只改数据库 **不够、且会被抹掉**：cc-switch 启动 / 在 GUI 点切换时，会以**当前生效的 `~/.claude/settings.json`** 为准回写 provider 记录——若生效文件还是旧 provider（DeepSeek），它会把旧 env **覆盖进你刚改好的 provider 行**，导致库里 DouBaoSeed 变回 DeepSeek，切换后依然是 DeepSeek。

**可靠做法（代理模式关闭时，`proxy_config.proxy_enabled=0`）**：Claude Code 直读 `~/.claude/settings.json`，cc-switch 不做转发，所以**直接改这个生效文件即可一步到位**，不必依赖 GUI：
1. 先**完全退出 cc-switch.exe**（防止它回写）；
2. 直接编辑 `C:\Users\<用户>\.claude\settings.json` 的 `env`：token=`ark-…`、base=`https://ark.cn-beijing.volces.com/api/compatible`、4 个模型字段全填 `doubao-seed-evolving`；
3. （可选但建议）同步把 `cc-switch.db` 里 DouBaoSeed 行的 `settings_config` 改成同样火山 env、`is_current=1`，让库与生效文件一致——**否则下次在 GUI 点 DouBaoSeed 又会写回旧值**；
4. **重开 Claude Code 窗口**：旧窗口 env 在启动时已固定，改文件对它无效（这是"改了没变"的另一常见原因）。

**验证命令（端到端，别只看文件）**：
```bash
curl "https://ark.cn-beijing.volces.com/api/compatible/v1/messages" \
  -H "Authorization: Bearer <ark-key>" -H "Content-Type: application/json" \
  -H "anthropic-version: 2023-06-01" \
  -d '{"model":"doubao-seed-evolving","max_tokens":16,"messages":[{"role":"user","content":"reply with: OK"}]}'
# HTTP 200 且 content 返回 OK = 整条链路通
```

---

## FreeLLMAPI 本地聚合网关（2026-09-10 新增）

> **用途**：本地部署的 API 聚合服务，将多个免费/付费 LLM 供应商聚合为一个 OpenAI/Anthropic 兼容端点。
> **GitHub**: https://github.com/tashfeenahmed/freellmapi (25.2k stars)

### 为什么需要 FreeLLMAPI + CC-Switch 双工具

两者解决不同问题，互补而非替代：

| 工具 | 解决什么问题 | 核心价值 |
|------|------------|---------|
| **FreeLLMAPI** | 多个上游供应商的 key 管理 + 自动路由 | 聚合：一个统一 key 访问 283 个模型，自动选有 quota 的上游 |
| **CC-Switch** | 多 provider 配置管理 + 一键切换 | 切换：在 DeepSeek/火山/智谱等不同 provider 之间快速切换 |

**当前实际架构**（2026-09-10 验证）：
- Claude Code **直连 FreeLLMAPI**（`localhost:3001`），不经过 CC-Switch
- CC-Switch 进程在运行，但本地代理（15721）未启用，未参与请求链路
- 两者可以共存：FreeLLMAPI 管路由，CC-Switch 管 provider 配置备份/切换

### 当前实际请求链路（已验证）

```
VSCode / Claude Code CLI
    ↓
ANTHROPIC_BASE_URL = http://localhost:3001
ANTHROPIC_AUTH_TOKEN = freellmapi-<hex>（统一 key，启动时自动生成）
ANTHROPIC_MODEL = auto
    ↓
FreeLLMAPI (localhost:3001)
    ↓ 根据 model=auto 自动选择有 quota 的上游
智谱 GLM / NVIDIA / DeepSeek 官方 / 其他已配置供应商
```

**关键事实**：
- Claude Code **直接**指向 FreeLLMAPI，不经过 CC-Switch
- CC-Switch 进程在运行，但本地代理端口 15721 未监听，**未参与当前请求链路**
- CC-Switch 中选为"当前"的 DeepSeek provider **未被使用**，其 token 不消耗
- 费用消耗的是 FreeLLMAPI 里已配置 key 的上游供应商（nvidia/智谱等）

### FreeLLMAPI 配置要点

1. **安装**：`git clone https://github.com/tashfeenahmed/freellmapi` → `npm install` → 复制 `.env.example` 为 `.env`
2. **环境变量**：
   ```
   ENCRYPTION_KEY=<64位hex>  # 用于加密存储的 provider keys（自行生成）
   PORT=3001
   ```
3. **启动**：`npm run dev`（同时启动 server:3001 + dashboard:5173）
4. **统一 key**：格式 `freellmapi-<hex>`，**生成一次后持久化在 `freeapi.db` 的 settings 表**（源码 `server/src/db/index.ts` 的 `getUnifiedApiKey` / `regenerateUnifiedKey`），**重启不变**——不存在"每次启动换 key 导致配置失效"的问题。取用后写入 `~/.claude/settings.json` 的 `ANTHROPIC_AUTH_TOKEN`
5. **添加供应商**：打开 `http://localhost:5173`，在 Keys 页添加各供应商的 API key（nvidia/智谱/DeepSeek 官方等）
6. **验证**：`curl -H "Authorization: Bearer <统一key>" http://localhost:3001/v1/models` 应返回模型列表
7. **换机迁移**（2026-09-14 新增）：`.env` + `server\data\freeapi.db` 由 `bootstrap\deploy.ps1 -CaptureFree` / `-DeployFree` 随便携备份走。
   ⚠️ **`.env` 里的 `ENCRYPTION_KEY` 是解密 `freeapi.db` 全部 provider key 的唯一钥匙——只拷 db 不拷 .env = 所有 key 全废。**
   详见 `bootstrap/README.md`。

### 排障：面板打不开 ≠ 配置不生效

最常见的误判。两者根因完全不同：

| 症状 | 根因 | 处理 |
|------|------|------|
| `localhost:5173` / `:3001` 打不开 | **服务没在跑**（前台 `npm run dev`，关窗口/重启即停，**无自启动**） | `cd %USERPROFILE%\freellmapi; npm run dev` |
| Claude Code 不走 FreeLLMAPI | `~/.claude/settings.json` 的 `ANTHROPIC_BASE_URL` **压根没指向它** | 改 BASE_URL 为 `http://localhost:3001` 并重开窗口 |

先跑 `bootstrap\deploy.ps1 -Verify`，它的第 [5] 项会直接告诉你是哪一种。

### 常见误解澄清（基于 2026-09-10 千问文档修正）

| 误解 | 正确理解 |
|------|----------|
| "CC-Switch 做协议转换" | CC-Switch 当前未参与链路。FreeLLMAPI 本身也做协议转换（Anthropic↔OpenAI），不是 CC-Switch 独占 |
| "选 DeepSeek 就走 DeepSeek" | model=auto 由 FreeLLMAPI 决定路由到哪个有 quota 的供应商，与 CC-Switch 选谁无关 |
| "15721 端口是 CC-Switch 代理" | 当前 15721 未监听——CC-Switch 的本地代理是**可选功能**，默认可能未启用，需在 GUI 确认 |
| "FreeLLMAPI 只支持 nvidia/agnes" | 支持 283 个模型，来自 nvidia/智谱/DeepSeek 官方/Moonshot/阿里等**多个供应商** |
| "CC-Switch 和 FreeLLMAPI 二选一" | 两者互补：FreeLLMAPI 管"路由到谁"（聚合），CC-Switch 管"provider 配置切换"（备份/管理） |

### 如何让 CC-Switch 代理生效（如需切换）

CC-Switch 的本地代理是**可选功能**，当前未启用。如需通过 CC-Switch 转发请求：

1. **确认代理已启用**：在 CC-Switch GUI 中检查 `enableLocalProxy` 设置，确保本地代理端口 15721 在监听（`netstat -ano | findstr 15721`）
2. **修改 Claude Code 配置**：
   ```json
   "ANTHROPIC_BASE_URL": "http://127.0.0.1:15721",
   "ANTHROPIC_AUTH_TOKEN": "任意值（会被 CC-Switch 忽略）",
   "ANTHROPIC_MODEL": "deepseek-v4-pro"
   ```
3. **重开 Claude Code 窗口**使新配置生效
4. **注意**：启用 CC-Switch 代理后，请求走 `CC-Switch → 选中的 provider`，不再经过 FreeLLMAPI。如果想同时用 FreeLLMAPI 的聚合能力，保持当前直连 `localhost:3001` 的配置即可

### FreeLLMAPI vs CC-Switch 对比

| 特性 | FreeLLMAPI | CC-Switch |
|------|------------|-----------|
| 核心功能 | 多上游聚合 + 自动路由 | 多 provider 配置管理 + 切换 |
| 请求聚合 | ✅ 一个统一 key 访问 283+ 模型 | ❌ 一次只走一个 provider |
| 路由策略 | ✅ model=auto 自动选有 quota 的上游 | ❌ 需手动选择 provider |
| 费用管理 | ✅ 统一管理各上游 quota | ❌ 各 provider 独立计费 |
| 协议转换 | ✅ Anthropic ↔ OpenAI 自动转换 | ✅ 可做（需启用本地代理） |
| GUI | ✅ Web dashboard (:5173) | ✅ 桌面应用 |
| 定位 | **运行时路由层** | **配置管理层** |
| 互补关系 | 管"请求发到哪里" | 管" provider 配置是什么" |
