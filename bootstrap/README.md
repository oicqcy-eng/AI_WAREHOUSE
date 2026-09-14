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

**2026-09-14 定版**：① 是历次"换机能启动不了"的主因——它既不在 git，也不在备份 zip 里。

## 换机三步

```powershell
# 1) 克隆仓库
git clone https://github.com/oicqcy-eng/AI_WAREHOUSE.git D:\AI_WAREHOUSE

# 2) 还原便携备份（含本目录的 settings.user.local.json + db.local.json）
powershell -ExecutionPolicy Bypass -File scripts\restore-new-pc.ps1 -ZipPath <备份zip>

# 3) 部署模型配置到 Claude Code 读取位置 + 自检
powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Verify
```

跑完 3) 后**重开 Claude Code 窗口**（env 在进程启动时读取一次，旧窗口改文件无效）。

## 文件说明

| 文件 | 入库 | 说明 |
|------|:----:|------|
| `README.md` | ✅ | 本文件 |
| `deploy.ps1` | ✅ | 部署 / 抓取 / 自检 |
| `settings.user.example.json` | ✅ | 脱敏模板，结构参考，**不含真实 token** |
| `settings.user.local.json` | ❌ gitignore | **真实配置**（含 API key），由 `deploy.ps1 -Capture` 生成 |
| `proxies.local.md` | ❌ gitignore | 代理/网络环境备忘（如需要） |

> ⚠️ `settings.user.local.json` 含明文 API key。
> 它**被 `.gitignore` 排除，绝不入库**，但**会被 `scripts/backup-portable.ps1` 收进便携 zip**（zip 是本地文件，不上传）。
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

依次检查：模型配置三项 → 端点连通性 → DB 凭据 → Node 依赖，每项给出 ✅/❌ 与修复提示。

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
```

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

- `docs/cc-switch-配置说明.md` — provider 清单、排障记录、base URL 备忘
- `scripts/换机迁移操作教程.md` — 完整换机流程
- `scripts/backup-portable.ps1` / `restore-new-pc.ps1` — 便携备份与还原
