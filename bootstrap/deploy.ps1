# deploy.ps1 — AI-WAREHOUSE 换机配置中枢
# ============================================================
# 作用: 在「仓库配置真值」与「Claude Code 实际读取位置」之间搬运。
#
#   -Deploy      (默认) bootstrap\settings.user.local.json  →  %USERPROFILE%\.claude\settings.json
#   -Capture            %USERPROFILE%\.claude\settings.json  →  bootstrap\settings.user.local.json
#   -CaptureFree        freellmapi .env + freeapi.db         →  bootstrap\freellmapi.local\
#   -DeployFree         bootstrap\freellmapi.local\          →  freellmapi 安装目录
#   -Verify             自检五项（模型配置/端点连通/DB 凭据/Node 依赖/FreeLLMAPI）
#
# 为什么需要它: Claude Code 只从固定路径读配置，不认仓库里的任意文件夹。
#              所以配置真值放仓库随 git/备份走，靠本脚本部署到正确位置。
#              开关可组合，如 -Capture -CaptureFree 一次抓全。
#
# 用法:
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1                  # 部署模型配置
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Capture         # 抓取模型配置回仓库
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -CaptureFree     # 抓取 FreeLLMAPI 凭据
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -DeployFree      # 还原 FreeLLMAPI 凭据
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Verify          # 自检
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -Capture -CaptureFree
#   powershell -ExecutionPolicy Bypass -File bootstrap\deploy.ps1 -DeployFree -FreellmapiPath D:\freellmapi
#
# 注意: 部署后必须【重开 Claude Code 窗口】—— env 在进程启动时读取一次，旧窗口无效。
#
# !! 本文件必须保存为 UTF-8 with BOM !!
#    PowerShell 5.1 对无 BOM 的 .ps1 按 GBK 解码，中文注释会乱码并引发
#    "Unexpected token" / "The string is missing the terminator" 语法错误。
#    编辑后若出现上述报错，补 BOM：
#      $c = Get-Content -Raw -Encoding UTF8 <本文件>
#      [System.IO.File]::WriteAllText(<本文件>, $c, (New-Object System.Text.UTF8Encoding($true)))
# ============================================================
param(
    [switch]$Capture,          # 抓取 ~/.claude/settings.json    → 仓库
    [switch]$CaptureFree,      # 抓取 freellmapi .env + db       → 仓库
    [switch]$Verify,           # 自检（只读）
    [switch]$DeployFree,       # 部署仓库 freellmapi 文件        → 本机
    [switch]$Force,            # 目标比源新时仍强制覆盖
    [string]$FreellmapiPath = "$env:USERPROFILE\freellmapi"   # 本机 FreeLLMAPI 安装位置
)

$ErrorActionPreference = 'Stop'

$Here   = $PSScriptRoot                                        # bootstrap\
$RepoRoot = Split-Path -Parent $Here                           # 仓库根
$Target = Join-Path $HOME '.claude\settings.json'              # Claude Code 实际读取位置
$Repo   = Join-Path $Here 'settings.user.local.json'           # 仓库配置真值
$FreeRepo = Join-Path $Here 'freellmapi.local'                 # FreeLLMAPI 真值（gitignore）
$Stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'

# ── 输出小工具 ────────────────────────────────────────────────
function Say-Ok  ([string]$t, [string]$d) { Write-Host "  [OK]   $t" -ForegroundColor Green;    if ($d) { Write-Host "         $d" -ForegroundColor DarkGray } }
function Say-Bad ([string]$t, [string]$d) { Write-Host "  [FAIL] $t" -ForegroundColor Red;      if ($d) { Write-Host "         $d" -ForegroundColor Yellow } }
function Say-Warn([string]$t, [string]$d) { Write-Host "  [WARN] $t" -ForegroundColor Yellow;   if ($d) { Write-Host "         $d" -ForegroundColor DarkGray } }

# ── 读写工具 ──────────────────────────────────────────────────
function Read-JsonFile([string]$path) {
    return (Get-Content $path -Raw -Encoding UTF8 | ConvertFrom-Json)
}

# 写无 BOM 的 UTF-8（Claude Code 对带 BOM 的 JSON 可能解析失败）
function Write-JsonFile([string]$path, $obj) {
    $json = $obj | ConvertTo-Json -Depth 10
    $enc  = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($path, $json, $enc)
}

# 剔除下划线开头的键（模板里的 _comment 说明文字，不得注入 env 变成环境变量）
function Remove-CommentKeys($obj) {
    $out = [ordered]@{}
    foreach ($p in $obj.PSObject.Properties) {
        if ($p.Name -like '_*') { continue }
        if ($p.Name -eq 'env') {
            $envOut = [ordered]@{}
            foreach ($e in $p.Value.PSObject.Properties) {
                if ($e.Name -like '_*') { continue }
                $envOut[$e.Name] = $e.Value
            }
            $out['env'] = [pscustomobject]$envOut
        } else {
            $out[$p.Name] = $p.Value
        }
    }
    return [pscustomobject]$out
}

$REQUIRED_ENV = @('ANTHROPIC_BASE_URL', 'ANTHROPIC_AUTH_TOKEN', 'ANTHROPIC_MODEL')

# ════════════════════════════════════════════════════════════
# 模式 1：-Capture  抓取本机生效配置回仓库
# ════════════════════════════════════════════════════════════
function Invoke-Capture {
    Write-Host '=== 抓取配置回仓库 ===' -ForegroundColor Cyan

    if (-not (Test-Path $Target)) {
        Write-Host "找不到生效配置: $Target" -ForegroundColor Red
        Write-Host '本机尚未配置模型接入，无法抓取。' -ForegroundColor Yellow
        exit 1
    }

    $src = Read-JsonFile $Target
    if (-not $src.env -or -not $src.env.ANTHROPIC_AUTH_TOKEN) {
        Write-Host "生效配置里没有 env.ANTHROPIC_AUTH_TOKEN，抓取无意义（可能未接入模型）。" -ForegroundColor Red
        exit 1
    }

    # 原样留存（不去注释键，保持忠实快照）
    Copy-Item $Target $Repo -Force

    Write-Host "  已抓取 -> $Repo" -ForegroundColor Green
    Write-Host "    BASE_URL : $($src.env.ANTHROPIC_BASE_URL)" -ForegroundColor DarkGray
    Write-Host "    MODEL    : $($src.env.ANTHROPIC_MODEL)" -ForegroundColor DarkGray
    Write-Host "    TOKEN    : 已存（$($src.env.ANTHROPIC_AUTH_TOKEN.Length) 字符，明文，已被 .gitignore 排除）" -ForegroundColor DarkGray
    Write-Host ''
    Write-Host '下一步: 跑一次 scripts\backup-portable.ps1 让备份 zip 带上最新配置。' -ForegroundColor Yellow
}

# ════════════════════════════════════════════════════════════
# 模式 2：-Verify  自检四项
# ════════════════════════════════════════════════════════════
function Invoke-Verify {
    Write-Host '=== 换机环境自检 ===' -ForegroundColor Cyan
    Write-Host "  读取位置: $Target" -ForegroundColor DarkGray
    Write-Host ''

    $fail = 0

    # ── [1] 模型配置 ──
    Write-Host '[1] 模型接入配置' -ForegroundColor White
    if (-not (Test-Path $Target)) {
        Say-Bad '配置文件不存在' "跑 bootstrap\deploy.ps1 部署"
        $fail++
    } else {
        $t = Read-JsonFile $Target
        $miss = @($REQUIRED_ENV | Where-Object { -not $t.env.$_ })
        if ($miss.Count -eq 0) {
            Say-Ok '配置完整' "BASE_URL=$($t.env.ANTHROPIC_BASE_URL)"
            Write-Host "         MODEL=$($t.env.ANTHROPIC_MODEL)  TOKEN=已设($($t.env.ANTHROPIC_AUTH_TOKEN.Length)字符)" -ForegroundColor DarkGray
        } else {
            Say-Bad "缺少: $($miss -join ', ')" '跑 bootstrap\deploy.ps1 部署'
            $fail++
        }
    }
    Write-Host ''

    # ── [2] 端点连通性 ──
    Write-Host '[2] 模型端点连通性' -ForegroundColor White
    $baseUrl = $null
    if (Test-Path $Target) { $baseUrl = (Read-JsonFile $Target).env.ANTHROPIC_BASE_URL }
    if (-not $baseUrl) {
        Say-Warn '跳过' '配置缺失，无法判断端点'
    } else {
        try {
            $u = [Uri]$baseUrl
            $port = 443
            if ($u.Scheme -eq 'http') { $port = 80 }
            if ($u.Port -gt 0) { $port = $u.Port }

            # DNS 解析（识别代理 fake-ip：198.18.0.0/15 是 RFC2544 保留段）
            $ips = @()
            try { $ips = [System.Net.Dns]::GetHostAddresses($u.Host) | ForEach-Object { $_.IPAddressToString } } catch {}
            $fakeIp = @($ips | Where-Object { $_ -like '198.18.*' -or $_ -like '198.19.*' })

            # TCP 连接
            $cli = New-Object System.Net.Sockets.TcpClient
            $iar = $cli.BeginConnect($u.Host, $port, $null, $null)
            $connected = $iar.AsyncWaitHandle.WaitOne(5000, $false)
            if ($connected) { try { $cli.EndConnect($iar) } catch { $connected = $false } }
            $cli.Close()

            if ($connected) {
                Say-Ok "TCP $($u.Host):$port 可达" "解析: $($ips -join ', ')"
            } else {
                Say-Bad "TCP $($u.Host):$port 不可达" '检查网络 / 代理是否开启'
                $fail++
            }
            if ($fakeIp.Count -gt 0) {
                Say-Warn '当前走代理 fake-ip 模式' "解析到 $($fakeIp -join ', ')（保留网段）—— 换到未开代理的网络会直接解析失败"
            }
        } catch {
            Say-Bad "BASE_URL 无法解析: $baseUrl" '格式应为 http(s)://主机[:端口]'
            $fail++
        }
    }
    Write-Host ''

    # ── [3] DB 凭据 ──
    Write-Host '[3] MES 数据库凭据' -ForegroundColor White
    $dbLocal = Join-Path $RepoRoot 'agent\mes-implement-expert\config\db.local.json'
    $dbExample = Join-Path $RepoRoot 'agent\mes-implement-expert\config\db.local.example.json'
    if (Test-Path $dbLocal) {
        $db = Read-JsonFile $dbLocal
        $profs = @($db.profiles.PSObject.Properties.Name)
        Say-Ok 'db.local.json 存在' "profiles: $($profs -join ', ')"
        Write-Host '         验证连库: node agent\mes-implement-expert\tools\query-mes.js -q "SELECT 1" --profile home' -ForegroundColor DarkGray
        Write-Host '         （需在客户现场 192.168.200.x 网段，否则连不上属正常）' -ForegroundColor DarkGray
    } else {
        Say-Bad 'db.local.json 缺失' "从便携备份还原，或按 $dbExample 手工填"
        $fail++
    }
    Write-Host ''

    # ── [4] Node 运行时依赖 ──
    Write-Host '[4] Node 运行时依赖 (tmp\node_modules)' -ForegroundColor White
    $mods = Join-Path $RepoRoot 'tmp\node_modules'
    $need = @('mssql', 'xlsx', 'docx', 'jszip')
    $missing = @($need | Where-Object { -not (Test-Path (Join-Path $mods $_)) })
    if ($missing.Count -eq 0) {
        Say-Ok '四个核心包齐备' ($need -join ', ')
    } else {
        Say-Bad "缺失: $($missing -join ', ')" 'cd tmp; npm install'
        $fail++
    }
    Write-Host ''

    # ── [5] FreeLLMAPI ──
    Write-Host '[5] FreeLLMAPI 本地聚合网关' -ForegroundColor White
    $freeEnv = Join-Path $FreellmapiPath '.env'
    $freeDb  = Join-Path $FreellmapiPath 'server\data\freeapi.db'
    if (-not (Test-Path $FreellmapiPath)) {
        Say-Warn '本机未安装 FreeLLMAPI' "预期位置: $FreellmapiPath（不用它可忽略此项）"
    } else {
        $freeMiss = @()
        if (-not (Test-Path $freeEnv)) { $freeMiss += '.env' }
        if (-not (Test-Path $freeDb))  { $freeMiss += 'server\data\freeapi.db' }
        if ($freeMiss.Count -eq 0) {
            Say-Ok '凭据与数据库齐备' "$FreellmapiPath"
        } else {
            Say-Bad "缺少: $($freeMiss -join ', ')" '从便携备份还原后跑 -DeployFree'
            $fail++
        }
        # 服务是否在跑（面板/API 打不开的头号原因是服务没启动，不是配置问题）
        $listening = netstat -ano | Select-String ':3001\s+.*LISTENING' | Select-Object -First 1
        if ($listening) {
            Say-Ok '服务在运行（端口 3001 监听中）' '面板 http://localhost:5173'
        } else {
            Say-Warn '服务未运行（端口 3001 无监听）' "启动: cd $FreellmapiPath; npm run dev（前台进程，关窗口即停）"
        }
    }
    Write-Host ''

    # ── 汇总 ──
    if ($fail -eq 0) {
        Write-Host '自检通过：环境可正常启动。' -ForegroundColor Green
        Write-Host '提示：若刚改过配置，请【重开 Claude Code 窗口】—— env 在启动时读取一次。' -ForegroundColor Yellow
    } else {
        Write-Host "自检发现 $fail 项问题，见上方 [FAIL] 行。" -ForegroundColor Red
        exit 1
    }
}

# ════════════════════════════════════════════════════════════
# 模式 3：-Deploy（默认）部署到 Claude Code 读取位置
# ════════════════════════════════════════════════════════════
function Invoke-Deploy {
    Write-Host '=== 部署配置到 Claude Code ===' -ForegroundColor Cyan

    if (-not (Test-Path $Repo)) {
        Write-Host "仓库内没有配置真值: $Repo" -ForegroundColor Red
        Write-Host '两种情况二选一：' -ForegroundColor Yellow
        Write-Host '  a) 本机已配好模型 -> 先跑 -Capture 抓取一次' -ForegroundColor Yellow
        Write-Host '  b) 全新机器       -> 复制 settings.user.example.json 为 settings.user.local.json，填入 API key' -ForegroundColor Yellow
        exit 1
    }

    # 源文件合法性 + 必需项
    try { $src = Read-JsonFile $Repo }
    catch { Write-Host "源文件不是合法 JSON: $Repo" -ForegroundColor Red; exit 1 }

    $miss = @($REQUIRED_ENV | Where-Object { -not $src.env.$_ })
    if ($miss.Count -gt 0) {
        Write-Host "源配置缺少 env 项: $($miss -join ', ')" -ForegroundColor Red
        exit 1
    }

    Write-Host "  源   : $Repo" -ForegroundColor DarkGray
    Write-Host "  目标 : $Target" -ForegroundColor DarkGray
    Write-Host "  BASE_URL = $($src.env.ANTHROPIC_BASE_URL)" -ForegroundColor DarkGray
    Write-Host "  MODEL    = $($src.env.ANTHROPIC_MODEL)" -ForegroundColor DarkGray
    Write-Host ''

    # 覆盖前备份
    if (Test-Path $Target) {
        $bak = "$Target.bak-$Stamp"
        Copy-Item $Target $bak -Force
        Write-Host "  已备份原配置 -> $bak" -ForegroundColor DarkGray
    } else {
        New-Item -ItemType Directory -Force -Path (Split-Path $Target -Parent) | Out-Null
        Write-Host '  目标不存在，将新建' -ForegroundColor DarkGray
    }

    # 去注释键后写入（避免 _comment 变成环境变量）
    $clean = Remove-CommentKeys $src
    Write-JsonFile $Target $clean

    Write-Host ''
    Write-Host '  部署完成。' -ForegroundColor Green
    Write-Host ''
    Write-Host '必须【重开 Claude Code 窗口】才生效（env 在进程启动时读取一次）。' -ForegroundColor Yellow
    Write-Host '提示：若 cc-switch 正在运行，不要再点它的切换，否则会覆写本次部署。' -ForegroundColor Yellow
    Write-Host '      用 cc-switch 切换过 provider 后，记得跑 -Capture 存回仓库。' -ForegroundColor DarkGray
}

# ════════════════════════════════════════════════════════════
# 模式 4：-CaptureFree  抓取 FreeLLMAPI 凭据与数据库回仓库
# ════════════════════════════════════════════════════════════
$FREE_FILES = @('.env', 'freeapi.db', 'freeapi.db-wal', 'freeapi.db-shm')

function Invoke-CaptureFree {
    Write-Host '=== 抓取 FreeLLMAPI 凭据回仓库 ===' -ForegroundColor Cyan

    if (-not (Test-Path $FreellmapiPath)) {
        Write-Host "找不到 FreeLLMAPI 安装目录: $FreellmapiPath" -ForegroundColor Red
        Write-Host '用 -FreellmapiPath <路径> 指定实际位置。' -ForegroundColor Yellow
        exit 1
    }

    $envFile = Join-Path $FreellmapiPath '.env'
    $dbFile  = Join-Path $FreellmapiPath 'server\data\freeapi.db'
    if (-not (Test-Path $envFile)) { Write-Host "缺少 .env: $envFile" -ForegroundColor Red; exit 1 }
    if (-not (Test-Path $dbFile))  { Write-Host "缺少 freeapi.db: $dbFile" -ForegroundColor Red; exit 1 }

    # db 在写的时候复制会拿到不一致快照
    $proc = Get-Process node -ErrorAction SilentlyContinue
    if ($proc) {
        Write-Host 'FreeLLMAPI 似乎正在运行（检测到 node 进程）。' -ForegroundColor Yellow
        Write-Host '服务在写库时复制可能拿到不一致的 db —— 建议先停服务再抓取。' -ForegroundColor Yellow
        if (-not $Force) {
            Write-Host '确认要继续请加 -Force。' -ForegroundColor Yellow
            exit 1
        }
        Write-Host '（-Force 已指定，继续）' -ForegroundColor DarkGray
    }

    New-Item -ItemType Directory -Force -Path $FreeRepo | Out-Null
    Copy-Item $envFile (Join-Path $FreeRepo '.env') -Force
    foreach ($f in $FREE_FILES | Where-Object { $_ -ne '.env' }) {
        $s = Join-Path $FreellmapiPath "server\data\$f"
        if (Test-Path $s) { Copy-Item $s (Join-Path $FreeRepo $f) -Force }
    }

    $dbSize = [math]::Round((Get-Item (Join-Path $FreeRepo 'freeapi.db')).Length / 1MB, 1)
    Write-Host "  已抓取 -> $FreeRepo" -ForegroundColor Green
    Write-Host "    .env        含 ENCRYPTION_KEY（解密 freeapi.db 全部 provider key 的主密钥）" -ForegroundColor DarkGray
    Write-Host "    freeapi.db  $dbSize MB" -ForegroundColor DarkGray
    Write-Host "    已排除 node_modules（换机用 npm install 重建）" -ForegroundColor DarkGray
    Write-Host ''
    Write-Host '下一步: 跑 scripts\backup-portable.ps1 让备份 zip 带上这些文件。' -ForegroundColor Yellow
}

# ════════════════════════════════════════════════════════════
# 模式 5：-DeployFree  把仓库里的 FreeLLMAPI 文件装回本机
# ════════════════════════════════════════════════════════════
function Invoke-DeployFree {
    Write-Host '=== 部署 FreeLLMAPI 凭据到本机 ===' -ForegroundColor Cyan

    if (-not (Test-Path (Join-Path $FreeRepo 'freeapi.db'))) {
        Write-Host "仓库内没有 FreeLLMAPI 真值: $FreeRepo" -ForegroundColor Red
        Write-Host '先在旧机器上跑 -CaptureFree，或从便携备份 zip 还原。' -ForegroundColor Yellow
        exit 1
    }
    if (-not (Test-Path $FreellmapiPath)) {
        Write-Host "本机还没有 FreeLLMAPI: $FreellmapiPath" -ForegroundColor Red
        Write-Host '先克隆并安装：' -ForegroundColor Yellow
        Write-Host '  git clone https://github.com/tashfeenahmed/freellmapi  ' + $FreellmapiPath -ForegroundColor Yellow
        Write-Host '  cd ' + $FreellmapiPath + '; npm install' -ForegroundColor Yellow
        Write-Host '（node_modules 不入库，必须在新机器重建）' -ForegroundColor DarkGray
        exit 1
    }

    $srcDb = Join-Path $FreeRepo 'freeapi.db'
    $dstDb = Join-Path $FreellmapiPath 'server\data\freeapi.db'

    # 防误覆盖：目标库比源新，说明本机已有更新的数据
    if ((Test-Path $dstDb) -and (-not $Force)) {
        $sTime = (Get-Item $srcDb).LastWriteTime
        $dTime = (Get-Item $dstDb).LastWriteTime
        if ($dTime -gt $sTime) {
            Write-Host '目标 freeapi.db 比仓库里的更新 —— 覆盖会丢失本机较新的数据。' -ForegroundColor Red
            Write-Host "  仓库: $sTime" -ForegroundColor DarkGray
            Write-Host "  本机: $dTime" -ForegroundColor DarkGray
            Write-Host '确认要覆盖请加 -Force（或先跑 -CaptureFree 把本机版本存回仓库）。' -ForegroundColor Yellow
            exit 1
        }
    }

    $dstDir = Join-Path $FreellmapiPath 'server\data'
    New-Item -ItemType Directory -Force -Path $dstDir | Out-Null

    # 覆盖前备份
    foreach ($f in $FREE_FILES) {
        $d = Join-Path $dstDir $f
        if ($f -eq '.env') { $d = Join-Path $FreellmapiPath '.env' }
        if (Test-Path $d) {
            Copy-Item $d "$d.bak-$Stamp" -Force
            Write-Host "  已备份 -> $d.bak-$Stamp" -ForegroundColor DarkGray
        }
    }

    Copy-Item (Join-Path $FreeRepo '.env') (Join-Path $FreellmapiPath '.env') -Force
    Write-Output '  .env 已还原'
    foreach ($f in $FREE_FILES | Where-Object { $_ -ne '.env' }) {
        $s = Join-Path $FreeRepo $f
        if (Test-Path $s) {
            Copy-Item $s (Join-Path $dstDir $f) -Force
            Write-Output "  $f 已还原"
        }
    }

    Write-Host ''
    Write-Host '  部署完成。' -ForegroundColor Green
    Write-Host '启动服务: cd ' + $FreellmapiPath + '; npm run dev' -ForegroundColor Yellow
    Write-Host '注意：服务是前台进程，关窗口即停，无自启动（见 README「FreeLLMAPI」节）。' -ForegroundColor DarkGray
}

# ════════════════════════════════════════════════════════════
# 分发
# ════════════════════════════════════════════════════════════
$did = $false
if ($Capture)     { Invoke-Capture;     $did = $true }
if ($CaptureFree) { Invoke-CaptureFree; $did = $true }
if ($Verify)      { Invoke-Verify;      $did = $true }
if ($DeployFree)  { Invoke-DeployFree;  $did = $true }
if (-not $did)    { Invoke-Deploy }
