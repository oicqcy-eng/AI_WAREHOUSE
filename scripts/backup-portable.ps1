# backup-portable.ps1 — AI-WAREHOUSE 一键备份（换机迁移用）
# ============================================================
# 用途: 打包"git 管不到但工作必需"的仓库外依赖 + 被忽略的客户资料，
#       生成一个 portable zip，拷到新电脑后用 restore-new-pc.ps1 一键还原。
# 备份内容:
#   [1] _claude/       用户级 Claude 配置 + 本项目持久记忆(memory/)
#   [2] _db/           DB 连接凭据 db.local.json（gitignore，不入库）
#   [3] 仓库被忽略资料  各厂 raw/ 原件 + delivery/inbox/ 输入 + 被忽略快照
#        （自动用 git ls-files --ignored 枚举，排除 tmp/ 与 *.log）
# 用法:
#   powershell -ExecutionPolicy Bypass -File scripts\backup-portable.ps1
#   powershell -ExecutionPolicy Bypass -File scripts\backup-portable.ps1 -OutDir E:\迁移
#   powershell -ExecutionPolicy Bypass -File scripts\backup-portable.ps1 -Name backup-20260823
# 注意: 需要在仓库目录内执行（脚本用 $PSScriptRoot 定位仓库根，位置无关）
# ============================================================
param(
    [string]$OutDir = "",            # zip 输出目录，默认 = 仓库上一级
    [string]$Name   = ""             # zip 文件名(不带 .zip)，默认 AI-WAREHOUSE-portable-<时间戳>
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot          # scripts/.. = 仓库根
$TimeStamp = Get-Date -Format 'yyyyMMdd-HHmmss'
if ($OutDir -eq '') { $OutDir = Split-Path -Parent $RepoRoot }
if ($Name   -eq '') { $Name = "AI-WAREHOUSE-portable-$TimeStamp" }
$ZipPath = Join-Path $OutDir ($Name + '.zip')
$Staging = Join-Path $env:TEMP ('aiw-portable-' + $TimeStamp)
New-Item -ItemType Directory -Force -Path $Staging | Out-Null

Write-Host '=== AI-WAREHOUSE 一键备份 ===' -ForegroundColor Cyan
Write-Host "仓库根: $RepoRoot"
Write-Host "输出:   $ZipPath"

# ---- [1] 用户级 Claude 配置 + 本项目记忆 ----
$claudeBase = Join-Path $HOME '.claude'
$projMemory = Join-Path $claudeBase 'projects\d--AI-WAREHOUSE\memory'
if (Test-Path $projMemory) {
    Copy-Item $projMemory (Join-Path $Staging '_claude\memory') -Recurse -Force
    Write-Host "[1] Claude 记忆  → $((Get-ChildItem $projMemory -File).Count) 条"
} else {
    Write-Host '[1] ⚠ Claude 记忆目录未找到，跳过' -ForegroundColor Yellow
}
$usrSettings = Join-Path $claudeBase 'settings.json'
if (Test-Path $usrSettings) {
    $claudeDst = Join-Path $Staging '_claude'
    New-Item -ItemType Directory -Force -Path $claudeDst | Out-Null
    Copy-Item $usrSettings (Join-Path $claudeDst 'settings.json') -Force
    Write-Host '[1] 用户级 settings.json → 已备份'
}

# ---- [2] DB 凭据 ----
$dbLocal = Join-Path $RepoRoot 'agent\mes-implement-expert\config\db.local.json'
if (Test-Path $dbLocal) {
    $dbDst = Join-Path $Staging '_db'
    New-Item -ItemType Directory -Force -Path $dbDst | Out-Null
    Copy-Item $dbLocal (Join-Path $dbDst 'db.local.json') -Force
    Write-Host '[2] DB 凭据 db.local.json → 已备份'
} else {
    Write-Host '[2] ⚠ db.local.json 未找到（新电脑用 db.local.example.json 手工填）' -ForegroundColor Yellow
}

# ---- [3] 仓库被忽略资料（git 枚举，排除 tmp/ 临时与 *.log）----
$ignored = git -c core.quotepath=false -C $RepoRoot ls-files --others --ignored --exclude-standard 2>$null
$nCopied = 0
foreach ($f in $ignored) {
    $rel = $f.Trim('"')                                   # git 可能对特殊字符加引号
    if ($rel -eq '') { continue }
    if ($rel -like 'tmp/*') { continue }                  # 临时目录/依赖，不备份
    if ($rel -like '*.log') { continue }
    $src = Join-Path $RepoRoot $rel
    if (-not (Test-Path $src)) { continue }
    $dst = Join-Path $Staging $rel
    New-Item -ItemType Directory -Force -Path (Split-Path $dst -Parent) | Out-Null
    Copy-Item $src $dst -Force
    $nCopied++
}
Write-Host "[3] 被忽略资料（raw/原件+inbox/输入+快照）→ $nCopied 个文件"

# ---- manifest ----
$manifest = @"
AI-WAREHOUSE 便携备份清单
备份时间: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
仓库:     $RepoRoot
git HEAD: $(git -C $RepoRoot log -1 --format=%h 2>$null) ($(git -C $RepoRoot branch --show-current 2>$null))
还原:     新电脑 git clone 后运行  scripts\restore-new-pc.ps1 -ZipPath <本zip路径>
内容:     _claude/(用户级Claude配置+记忆)  _db/(DB凭据)  <仓库被忽略资料按相对路径>
"@
Set-Content -Path (Join-Path $Staging '_manifest.txt') -Value $manifest -Encoding UTF8

# ---- 打包 ----
Write-Host '打包中…' -ForegroundColor Cyan
Compress-Archive -Path (Join-Path $Staging '*') -DestinationPath $ZipPath -CompressionLevel Optimal
$size = [math]::Round((Get-Item $ZipPath).Length / 1MB, 1)
Remove-Item $Staging -Recurse -Force

Write-Host '' -ForegroundColor Cyan
Write-Host "✅ 备份完成 → $ZipPath ($size MB)" -ForegroundColor Green
Write-Host ''
Write-Host '下一步：把 zip 拷到新电脑，' -ForegroundColor Yellow
Write-Host '  1) git clone https://github.com/oicqcy-eng/AI_WAREHOUSE.git' -ForegroundColor Yellow
Write-Host "  2) powershell -ExecutionPolicy Bypass -File scripts\restore-new-pc.ps1 -ZipPath <zip>" -ForegroundColor Yellow
Write-Host '  3) cd tmp; npm install' -ForegroundColor Yellow
