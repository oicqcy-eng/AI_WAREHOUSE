# restore-new-pc.ps1 — AI-WAREHOUSE 新电脑一键还原
# ============================================================
# 前提: 新电脑已安装 Node.js，已 git clone 本仓库（本脚本位于仓库 scripts/ 下），
#       且已安装备份 zip 中对应的依赖（_claude 用户级配置 + DB 凭据 + 客户资料）。
# 用途: 把 backup-portable.ps1 生成的 portable zip 解包，还原到正确位置。
#   [1] _claude/  → $HOME\.claude\projects\d--AI-WAREHOUSE\memory  + 用户级 settings.json
#   [2] _db/      → agent\mes-implement-expert\config\db.local.json
#   [3] 其余文件   → 按相对路径放回仓库（raw/、inbox/ 等被忽略资料）
# 用法:
#   powershell -ExecutionPolicy Bypass -File scripts\restore-new-pc.ps1 -ZipPath D:\AI-WAREHOUSE-portable-20260823.zip
#   （可选 -RepoRoot 指定仓库位置，默认取本脚本上一级）
# 验证: 还原后运行  node agent\mes-implement-expert\tools\query-mes.js <文件> --profile home 应能连库
# ============================================================
param(
    [Parameter(Mandatory=$true)][string]$ZipPath,   # backup-portable.ps1 生成的 zip
    [string]$RepoRoot = "",                          # 仓库根，默认 = 本脚本上一级
    [switch]$SkipRestore,                            # 只做环境预检，不还原文件
    [switch]$AutoInstall                             # 自动 winget 安装缺失的 git/node
)

$ErrorActionPreference = 'Stop'
if ($RepoRoot -eq '') { $RepoRoot = Split-Path -Parent $PSScriptRoot }
$TimeStamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$Staging = Join-Path $env:TEMP ('aiw-restore-' + $TimeStamp)

Write-Host '=== AI-WAREHOUSE 新电脑还原 ===' -ForegroundColor Cyan
Write-Host "仓库:   $RepoRoot"
Write-Host "备份:   $ZipPath"

# ════════════════════════════════════════════════════════════
# [0] 环境预检：git / node / npm / tmp 依赖（这是"傻瓜式"的关键）
# ════════════════════════════════════════════════════════════
function Test-Env([string]$name) {
    try { $v = (& $name --version 2>$null | Select-Object -First 1).Trim(); if ($v) { return $v } } catch {}
    return ''
}
$missing = @()
$gitV = Test-Env 'git';   if ($gitV)  { Write-Host "[0] git:      $gitV" -ForegroundColor Green }  else { $missing += 'git';   Write-Host '[0] git:      缺失' -ForegroundColor Red }
$nodeV = Test-Env 'node'; if ($nodeV) { Write-Host "[0] node.js:  $nodeV" -ForegroundColor Green } else { $missing += 'node'; Write-Host '[0] node.js:  缺失' -ForegroundColor Red }
$npmV = Test-Env 'npm';   if ($npmV)  { Write-Host "[0] npm:      $npmV" -ForegroundColor Green }  else { $missing += 'npm';  Write-Host '[0] npm:      缺失' -ForegroundColor Red }

# tmp/node_modules 是否有核心包（mssql 为 query-mes 必需）
$tmpPkg = Join-Path $RepoRoot 'tmp\node_modules'
if (Test-Path (Join-Path $tmpPkg 'mssql')) { Write-Host '[0] npm 依赖:  tmp/node_modules 已就绪' -ForegroundColor Green }
else { Write-Host '[0] npm 依赖:  未安装（还原后 cd tmp; npm install）' -ForegroundColor Yellow }

if ($missing.Count -gt 0) {
    Write-Host ''
    Write-Host "⚠ 缺失环境: $($missing -join ', ')" -ForegroundColor Red
    if ($AutoInstall) {
        Write-Host '→ 正在用 winget 自动安装…' -ForegroundColor Cyan
        foreach ($m in $missing) {
            $id = switch ($m) { 'git' { 'Git.Git' } 'node' { 'OpenJS.NodeJS.LTS' } 'npm' { 'OpenJS.NodeJS.LTS' } }
            if ($id) { winget install --id $id -e --accept-package-agreements --accept-source-agreements 2>&1 | Out-Host }
        }
        Write-Host '→ 安装完成，请开新终端再跑一次本脚本（PATH 需刷新）' -ForegroundColor Green
    } else {
        Write-Host '安装命令（新终端执行后重跑本脚本）：' -ForegroundColor Cyan
        if ($missing -contains 'git')  { Write-Host '  winget install --id Git.Git -e' -ForegroundColor Yellow }
        if ($missing -contains 'node') { Write-Host '  winget install --id OpenJS.NodeJS.LTS -e' -ForegroundColor Yellow }
        if ($missing -contains 'npm')  { Write-Host '  （装完 Node 自带 npm）' -ForegroundColor Yellow }
        Write-Host '  或用 -AutoInstall 自动装：restore-new-pc.ps1 -ZipPath <zip> -AutoInstall' -ForegroundColor Yellow
    }
    if ($SkipRestore) { exit 1 } else { Write-Host '' }
}

if ($SkipRestore) { Write-Host '✅ 环境预检完成（-SkipRestore，未还原文件）'; exit 0 }

# ════════════════════════════════════════════════════════════
# 还原文件（原逻辑）
# ════════════════════════════════════════════════════════════
if (-not (Test-Path $ZipPath)) { Write-Host "❌ 找不到备份 zip: $ZipPath" -ForegroundColor Red; exit 1 }
Expand-Archive -Path $ZipPath -DestinationPath $Staging -Force

# ---- [1] Claude 配置 + 记忆 ----
$claudeProjDir = Join-Path $HOME '.claude\projects\d--AI-WAREHOUSE'
if (Test-Path (Join-Path $Staging '_claude\memory')) {
    New-Item -ItemType Directory -Force -Path $claudeProjDir | Out-Null
    Copy-Item (Join-Path $Staging '_claude\memory') $claudeProjDir -Recurse -Force
    Write-Host '[1] Claude 记忆还原 →' (Join-Path $claudeProjDir 'memory')
}
if (Test-Path (Join-Path $Staging '_claude\settings.json')) {
    Copy-Item (Join-Path $Staging '_claude\settings.json') (Join-Path $HOME '.claude\settings.json') -Force
    Write-Host '[1] 用户级 settings.json 还原 →' (Join-Path $HOME '.claude\settings.json')
}

# ---- [2] DB 凭据 ----
if (Test-Path (Join-Path $Staging '_db\db.local.json')) {
    $dbDstDir = Join-Path $RepoRoot 'agent\mes-implement-expert\config'
    New-Item -ItemType Directory -Force -Path $dbDstDir | Out-Null
    Copy-Item (Join-Path $Staging '_db\db.local.json') (Join-Path $dbDstDir 'db.local.json') -Force
    Write-Host '[2] DB 凭据还原 →' (Join-Path $dbDstDir 'db.local.json')
}

# ---- [3] 仓库内被忽略资料（raw/、inbox/ 等）按相对路径放回 ----
$nRestored = 0
Get-ChildItem $Staging -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($Staging.Length).TrimStart('\','/')
    if ($rel -like '_claude*' -or $rel -like '_db*' -or $rel -eq '_manifest.txt') { return }
    $dst = Join-Path $RepoRoot $rel
    New-Item -ItemType Directory -Force -Path (Split-Path $dst -Parent) | Out-Null
    Copy-Item $_.FullName $dst -Force
    $nRestored++
}
Write-Host "[3] 被忽略资料还原 → $nRestored 个文件"

Remove-Item $Staging -Recurse -Force

Write-Host '' -ForegroundColor Cyan
Write-Host '✅ 还原完成。剩余步骤：' -ForegroundColor Green
Write-Host '  1) cd tmp; npm install                    # 重建 Node 依赖（md-to-docx 等）' -ForegroundColor Yellow
Write-Host '  2) 数据库连接【可选】——还原成功与连库无关！' -ForegroundColor Yellow
Write-Host '     继续用旧库:  node agent/mes-implement-expert/tools/query-mes.js -q "SELECT 1" --profile home' -ForegroundColor Yellow
Write-Host '     换新公司/新库: 改 agent\mes-implement-expert\config\db.local.json 的 profiles（server/port/database/user/password）' -ForegroundColor Yellow
Write-Host '  3) 若仍需装软件：git/node 用 winget；Claude Code 等 AI 会话内我全程辅助' -ForegroundColor Yellow
Write-Host '  详细教程见 scripts\换机迁移操作教程.md' -ForegroundColor Yellow
