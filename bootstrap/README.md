# bootstrap — 换机配置中枢

> **一句话**：Claude Code 只从固定路径读配置（`~/.claude/settings.json`），不认仓库里的任意文件夹。
> 所以本目录存放**配置真值**，由 `deploy.ps1` 一键部署到 Claude Code 实际读取的位置。
> 换机后跑一次脚本，智能体即可正常启动。

## 为什么需要这个目录

智能体能"跑起来"依赖四层，其中三层在仓库外、换机必丢：

| 层 | 位置 | 换机后果 | 本目录覆盖 |
|----|------|---------|-----------|
| ① 模型接入 | `~/.claude/settings.json` | 无 BASE_URL/token → 启动即失败 | ✅ `deploy.ps1` |
| ② 网络出口 | 代理软件 TUN/fake-ip | DNS 解析不到模型端点 | ⚠️ 靠人（见排障） |
| ③ 本地凭据 | `agent/mes-implement-expert/config/db.local.json` | MES 库连不上 | 已在 `backup-portable.ps1` |
| ④ 运行时依赖 | `tmp/node_modules`（mssql/xlsx/docx/jszip） | 工具链断裂 | `cd tmp; npm install` |
| ⑤ FreeLLMAPI | `~\freellmapi\.env` + `server\data\freeapi.db` | **provider key 全部解不开** | ✅ `-CaptureFree` / `-DeployFree` |

**2026-09-14 定版**：① 和 ⑤ 是历次"换机能启动不了"的主因——它们既不在 git，也不在备份 zip 里。

## 换机三步

```powershell
# 1) 克隆仓库
git clone https://github.com/oicqcy-eng/AI_WAREHOUSE.git D:\AI_WAREHOUSE

# 2) 还原便携备份（含本目录的 settings.user.local.json + db.local.json）
powershell -ExecutionPolicy Bypass -File scripts\restore-new-pc.ps1 -ZipPath <备份zip>

# 3) 部署模型配置到 Claude Code 读取位置 + 自检
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Verify

# 4) 若用 FreeLLMAPI：还原其凭据与数据库（须先 git clone + npm install）
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -DeployFree
```

跑完 3) 后**重开 Claude Code 窗口**（env 在进程启动时读取一次，旧窗口改文件无效）。

> 注意 4) 的前提：FreeLLMAPI 本机已装（`git clone` + `npm install`）。它是独立项目，不随本仓库走。

## 文件说明

| 文件 | 入库 | 说明 |
|------|:----:|------|
| `README.md` | ✅ | 本文件 |
| `deploy.ps1` | ✅ | 部署 / 抓取 / 自检（模型配置 + FreeLLMAPI 两套） |
| `settings.user.example.json` | ✅ | 脱敏模板，结构参考，**不含真实 token** |
| `settings.user.local.json` | ❌ gitignore | **真实配置**（含 API key），由 `deploy.ps1 -Capture` 生成 |
| `freellmapi.local/` | ❌ gitignore | FreeLLMAPI 的 `.env` + `freeapi.db` 三件套，由 `-CaptureFree` 生成 |
| `proxies.local.md` | ❌ gitignore | 代理/网络环境备忘（如需要） |

> ⚠️ 上述 ❌ 的文件都含明文凭据。
> 它们**被 `.gitignore` 排除，绝不入库**，但**会被 `scripts/backup-portable.ps1` 收进便携 zip**（zip 是本地文件，不上传）。
> 这是刻意的：**换机恢复靠 zip，不是靠 git**。

## 日常操作

### 抓取当前配置回仓库（换机前 / 切换 provider 后）

```powershell
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Capture
```

把当前生效的 `~/.claude/settings.json` 原样存回 `bootstrap/settings.user.local.json`，
下次备份 zip 就会带上最新版本。

> 用 cc-switch 切换 provider 后，**记得跑一次 `-Capture`**，否则仓库里留的是旧 provider 配置。

### 部署仓库配置到本机

```powershell
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1
```

覆盖前会自动备份目标文件为 `settings.json.bak-<时间戳>`，可随时回退。

### 自检（换机后 / 排查启动不了）

```powershell
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Verify
```

依次检查五项：模型配置 → 端点连通性 → DB 凭据 → Node 依赖 → FreeLLMAPI，每项给出 ✅/❌ 与修复提示。

### 抓取 / 还原 FreeLLMAPI 凭据

```powershell
# 旧机器：把 .env + freeapi.db 存回仓库（跑前先停服务，避免拷到半写状态）
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -CaptureFree

# 新机器：从仓库装回 freellmapi 安装目录
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -DeployFree

# 装在非默认位置时指定路径
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -DeployFree -FreellmapiPath D:\freellmapi
```

**两个安全设计**：
- `-CaptureFree` 检测到 node 进程在跑会**拒绝执行**（写库时复制会拿到不一致快照），确认无碍加 `-Force`
- `-DeployFree` 发现目标 `freeapi.db` 比仓库里的**更新**会**拒绝覆盖**（防丢本机新数据），确认要覆盖加 `-Force`

## FreeLLMAPI

本地 LLM 聚合网关（[github](https://github.com/tashfeenahmed/freellmapi)），把多个供应商聚合成一个统一端点。**独立项目，不随本仓库走。**

| 项 | 值 |
|---|---|
| 安装位置 | `%USERPROFILE%\freellmapi`（默认，可用 `-FreellmapiPath` 改） |
| 服务 | `http://localhost:3001` |
| 面板 | `http://localhost:5173` |
| 启动 | `cd %USERPROFILE%\freellmapi; npm run dev` |
| 统一 key | 存在 `freeapi.db` 的 settings 表，**重启不变**（不是每次重新生成） |

### 它和 Claude Code 的关系

**两者是独立的**。Claude Code 用不用它，只看 `~/.claude/settings.json` 的 `ANTHROPIC_BASE_URL`：

| BASE_URL | 走哪 |
|---|---|
| `http://localhost:3001` | FreeLLMAPI（`model=auto` 自动路由到有 quota 的上游） |
| `https://api.deepseek.com/anthropic` | 直连 DeepSeek，**与 FreeLLMAPI 无关** |

> ⚠️ 最常见的误解："FreeLLMAPI 面板打不开" 和 "Claude Code 配置不生效" 是**两件事**。
> 面板打不开 = 服务没启动（前台进程，关窗口/重启即停，**无自启动**）；
> 配置不生效 = BASE_URL 压根没指向它。先跑 `-Verify` 分清是哪一种。

### 换机为什么要带它

`freeapi.db` 里存着**所有 provider 的加密 key**，而解密的唯一钥匙是 `.env` 里的 `ENCRYPTION_KEY`。

```
只拷 freeapi.db、丢了 .env  →  库里所有 key 全部解不开，等于全废
```

所以 `-CaptureFree` **两个一起拷**。`node_modules` 不拷（可 `npm install` 重建）。

## 排障：启动不了怎么查

按顺序排除，**从上往下**，第一项失败就是根因：

```
1) 配置在不在     type %USERPROFILE%\.claude\settings.json
                  → 看有没有 ANTHROPIC_BASE_URL / ANTHROPIC_AUTH_TOKEN / ANTHROPIC_MODEL
                  → 没有就跑 deploy.ps1

2) 端点通不通     nslookup api.deepseek.com
                  → 正常应解析到真实公网 IP
                  → 若解析到 198.18.x.x，说明当前走了代理 TUN/fake-ip 模式
                    （这本身没错，但代理没开时就解析不到 → 启动失败）

3) 改完生效没     重开 Claude Code 窗口
                  → env 是进程启动时读一次的，旧窗口改文件无效
                  → 这正是"切了 provider 反而不能工作"的原因

4) 库连不连得上   node agent\mes-implement-expert\tools\query-mes.js -q "SELECT 1" --profile home
                  → 需在客户现场 192.168.200.x 网段（或挂 VPN）
                  → 不在该网段时模型能用、但报表类任务全挂

5) 依赖装没装     dir tmp\node_modules\mssql
                  → 缺失就 cd tmp; npm install

6) FreeLLMAPI     netstat -ano | findstr ":3001"
   面板/接口打不开 → 无监听 = 服务没启动 → cd %USERPROFILE%\freellmapi; npm run dev
                  → 有监听还打不开 = 看 BASE_URL 是否真指向 localhost:3001
```

> 一条命令代替上面全部：`bootstrap\deploy.ps1 -Verify`

## 与 cc-switch 的关系

| | cc-switch | 本目录 |
|---|---|---|
| 定位 | GUI 多 provider 管理 + 一键切换 | 配置真值存档 + 换机一键恢复 |
| 写入 | `~/.claude/settings.json` | 同一文件（部署时） |
| 换机 | 需重装并手填各 provider 的 key | `deploy.ps1` 一条命令 |

**两者写同一个文件，别同时用**：

- 用 cc-switch 切换后 → 跑 `deploy.ps1 -Capture` 把新配置存回仓库
- 用 `deploy.ps1` 部署后 → 不要立刻在 cc-switch 里点切换，否则被覆写

想把切换能力也搬进仓库（不再依赖 cc-switch）见 `docs/cc-switch-配置说明.md`。

## 相关文档

- `docs/cc-switch-配置说明.md` — provider 清单、排障记录、base URL 备忘、FreeLLMAPI 详解
- `scripts/换机迁移操作教程.md` — 完整换机流程
- `scripts/backup-portable.ps1` / `restore-new-pc.ps1` — 便携备份与还原
- FreeLLMAPI 上游项目 — https://github.com/tashfeenahmed/freellmapi
