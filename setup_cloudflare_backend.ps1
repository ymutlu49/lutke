# LUTKE - Cloudflare backend kurulum scripti (BIR DEFA calistirilir)
# Kullanim: powershell -ExecutionPolicy Bypass -File setup_cloudflare_backend.ps1
#
# Yaptigi isler (tum adimlar idempotent):
#   1) D1 database 'lutke_users' yaratir (varsa atlar)
#   2) wrangler.toml icindeki database_id'yi gunceller
#   3) schema.sql'i remote D1'e uygular
#   4) JWT_SECRET olarak rastgele bir secret uretir, Pages secret olarak yazar
#   5) DNS hatirlatici basar
#
# Bu scripti calistirdiktan sonra deploy_cloudflare.ps1'i calistir.

# Wrangler stderr'a uyari basinca ErrorActionPreference="Stop" durduruyor.
# Continue ile manuel $LASTEXITCODE kontrolu yapacagiz.
$ErrorActionPreference = "Continue"

# --- 0a. wrangler bulunmasi (PATH'te yoksa npm global'den ekle) ---
function Resolve-WranglerPath {
    # 1) PATH'te?
    try {
        $cmd = Get-Command wrangler -ErrorAction SilentlyContinue
        if ($cmd -and $cmd.Source) { return $cmd.Source }
    } catch {}

    # 2) Tipik Windows npm global yollari
    $userProfile = $env:USERPROFILE
    if (-not $userProfile) {
        $userProfile = [Environment]::GetFolderPath('UserProfile')
    }
    $candidates = @(
        "$userProfile\AppData\Roaming\npm\wrangler.cmd",
        "$env:APPDATA\npm\wrangler.cmd",
        "$env:LOCALAPPDATA\npm\wrangler.cmd",
        "$env:ProgramFiles\nodejs\wrangler.cmd"
    )
    foreach ($p in $candidates) {
        if ($p -and (Test-Path $p)) { return $p }
    }

    # 3) npm config get prefix
    try {
        $npmPrefixRaw = & npm config get prefix 2>$null
        if ($npmPrefixRaw) {
            $npmPrefix = (($npmPrefixRaw -join "") -replace "[`r`n]+", "").Trim()
            if ($npmPrefix) {
                $cand = Join-Path $npmPrefix "wrangler.cmd"
                if (Test-Path $cand) { return $cand }
            }
        }
    } catch {}

    return $null
}

$wranglerPath = Resolve-WranglerPath
if (-not $wranglerPath) {
    Write-Host "DEBUG bilgi:" -ForegroundColor Yellow
    Write-Host "  USERPROFILE = $env:USERPROFILE" -ForegroundColor Yellow
    Write-Host "  APPDATA     = $env:APPDATA" -ForegroundColor Yellow
    throw "wrangler bulunamadi. Once 'npm install -g wrangler' calistir."
}
$wranglerDir = Split-Path $wranglerPath -Parent
if (-not (($env:Path -split ";") -contains $wranglerDir)) {
    $env:Path = "$wranglerDir;$env:Path"
}
Write-Host "wrangler: $wranglerPath" -ForegroundColor DarkGray

# --- 0. API Token --------------------------------------------------
if (-not $env:CLOUDFLARE_API_TOKEN) {
    $userToken = [Environment]::GetEnvironmentVariable('CLOUDFLARE_API_TOKEN', 'User')
    if ($userToken) { $env:CLOUDFLARE_API_TOKEN = $userToken.Trim() }
}
if (-not $env:CLOUDFLARE_API_TOKEN) {
    throw "CLOUDFLARE_API_TOKEN bulunamadi. Once token'i set et."
}
$accId = "0eec8b88e11ef882d9269249ad00e331"
$env:CLOUDFLARE_ACCOUNT_ID = $accId

# Proje kökü = bu skriptin bulunduğu klasör (taşınmaya dayanıklı).
$projectRoot = $PSScriptRoot
Set-Location $projectRoot

$projectName = "lutke"
$dbName = "lutke_users"
$uuidRegex = '([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})'

Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  LUTKE - Cloudflare backend kurulum" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host ""

# --- 1. D1 database yarat veya bul --------------------------------
Write-Host "== 1/4 D1 database (lutke_users) ==" -ForegroundColor Cyan
$dbId = $null

# wrangler.toml'da zaten gercek bir ID varsa onu kullan
$tomlPath = Join-Path $projectRoot "wrangler.toml"
$toml = Get-Content $tomlPath -Raw
if ($toml -match 'database_id\s*=\s*"([a-f0-9-]{36})"') {
    $dbId = $matches[1]
    Write-Host "  [OK] wrangler.toml'da kayitli: $dbId" -ForegroundColor Green
} else {
    # Once create dene; varsa hata verir, ID'yi info'dan al.
    $createOut = & wrangler d1 create $dbName *>&1 | Out-String
    Write-Host $createOut -ForegroundColor DarkGray

    if ($createOut -match 'database_id\s*=\s*"([a-f0-9-]+)"') {
        $dbId = $matches[1]
        Write-Host "  [OK] Yaratildi: $dbName (id: $dbId)" -ForegroundColor Green
    } else {
        Write-Host "  Var olabilir, info ile aliniyor..." -ForegroundColor DarkGray
        $infoOut = & wrangler d1 info $dbName *>&1 | Out-String
        if ($infoOut -match $uuidRegex) {
            $dbId = $matches[1]
            Write-Host "  [OK] Mevcut D1 bulundu: $dbName (id: $dbId)" -ForegroundColor Green
        } else {
            Write-Host $infoOut -ForegroundColor DarkGray
            Write-Host "D1 yaratilamadi/bulunamadi. Yukaridaki ciktiya bak." -ForegroundColor Red
            exit 1
        }
    }
}

# --- 2. wrangler.toml'a database_id yaz ---------------------------
Write-Host ""
Write-Host "== 2/4 wrangler.toml database_id ==" -ForegroundColor Cyan
$tomlPath = Join-Path $projectRoot "wrangler.toml"
# CRITICAL: Get-Content default'u Latin-1/cp1254 ile UTF-8 dosyayi yanlis
# yorumluyor (LÛTKE -> LÃ›TKE). UTF-8 explicit belirt.
$toml = Get-Content $tomlPath -Raw -Encoding UTF8
if ($toml -match 'PLACEHOLDER_REPLACE_AFTER_CREATE') {
    $toml = $toml -replace 'PLACEHOLDER_REPLACE_AFTER_CREATE', $dbId
    # UTF-8 without BOM (PowerShell 5.1 BOM ekler -Encoding utf8 ile —
    # .NET API ile BOM'suz yaz).
    [System.IO.File]::WriteAllText(
        $tomlPath,
        $toml,
        (New-Object System.Text.UTF8Encoding $false)
    )
    Write-Host "  [OK] database_id yazildi: $dbId" -ForegroundColor Green
} else {
    Write-Host "  [OK] wrangler.toml zaten guncel (placeholder yok)" -ForegroundColor Green
}

# --- 3. Schema uygula ---------------------------------------------
Write-Host ""
Write-Host "== 3/4 D1 schema (remote) ==" -ForegroundColor Cyan
$schemaPath = "functions\schema.sql"
if (-not (Test-Path $schemaPath)) {
    Write-Host "Schema bulunamadi: $schemaPath" -ForegroundColor Red
    exit 1
}
# --yes ile interactive confirmation atla
& wrangler d1 execute $dbName --file=$schemaPath --remote --yes
$schemaExit = $LASTEXITCODE
if ($schemaExit -ne 0) {
    Write-Host "  [WARN] Schema exit code: $schemaExit. CREATE TABLE IF NOT EXISTS oldugu icin idempotent. Devam." -ForegroundColor Yellow
} else {
    Write-Host "  [OK] Schema uygulandi" -ForegroundColor Green
}

# --- 4. JWT_SECRET ------------------------------------------------
Write-Host ""
Write-Host "== 4/4 JWT_SECRET ==" -ForegroundColor Cyan
$secretList = & wrangler pages secret list --project-name=$projectName *>&1 | Out-String
if ($secretList -match "JWT_SECRET") {
    Write-Host "  [OK] JWT_SECRET zaten ayarli" -ForegroundColor Green
} else {
    Write-Host "  Yeni JWT_SECRET olusturuluyor (64 byte hex)..." -ForegroundColor Yellow
    $bytes = New-Object byte[] 64
    [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    $hex = New-Object System.Text.StringBuilder
    foreach ($b in $bytes) { [void]$hex.Append($b.ToString("x2")) }
    $secret = $hex.ToString()

    Write-Host "  Pages secret olarak yaziliyor..." -ForegroundColor Yellow
    # Stdin pipe ile sifresiz yaz
    $secret | & wrangler pages secret put JWT_SECRET --project-name=$projectName
    $secretExit = $LASTEXITCODE
    if ($secretExit -ne 0) {
        Write-Host ""
        Write-Host "  [WARN] Otomatik yazma basarisiz (exit: $secretExit). Manuel:" -ForegroundColor Yellow
        Write-Host "    wrangler pages secret put JWT_SECRET --project-name=$projectName" -ForegroundColor White
        Write-Host "    (Sonra istendiginde su degeri yapistir:)" -ForegroundColor White
        Write-Host "    $secret" -ForegroundColor Cyan
    } else {
        Write-Host "  [OK] JWT_SECRET ayarlandi" -ForegroundColor Green
    }
}

# --- DNS hatirlatici ----------------------------------------------
Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "  DNS KAYITLARI (Cloudflare panelinde manuel ekle):" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  https://dash.cloudflare.com/$accId/lutke.app/dns/records" -ForegroundColor White
Write-Host ""
Write-Host "  Kayit 1) SPF" -ForegroundColor Yellow
Write-Host "    Type:    TXT" -ForegroundColor White
Write-Host "    Name:    @" -ForegroundColor White
Write-Host "    Content: v=spf1 a mx include:relay.mailchannels.net ~all" -ForegroundColor White
Write-Host ""
Write-Host "  Kayit 2) MailChannels" -ForegroundColor Yellow
Write-Host "    Type:    TXT" -ForegroundColor White
Write-Host "    Name:    _mailchannels" -ForegroundColor White
Write-Host "    Content: v=mc1 cfid=$accId" -ForegroundColor White
Write-Host ""
Write-Host "===========================================================" -ForegroundColor Green
Write-Host "  KURULUM TAMAM. Simdi:" -ForegroundColor Green
Write-Host "  1) DNS kayitlarini ekle" -ForegroundColor Green
Write-Host "  2) deploy_cloudflare.ps1 calistir" -ForegroundColor Green
Write-Host "===========================================================" -ForegroundColor Green
