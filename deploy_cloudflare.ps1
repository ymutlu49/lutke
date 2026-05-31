# LUTKE — Cloudflare Pages deploy scripti
# Kullanim: powershell -ExecutionPolicy Bypass -File deploy_cloudflare.ps1
#
# Onkosul (tek seferlik): wrangler login (tarayicinizda Cloudflare hesabini onaylar)
#
# Bu script:
# 1) flutter clean + pub get
# 2) flutter build web --base-href=/  (Cloudflare root domain icin)
# 3) wrangler pages deploy build/web --project-name=lutke --branch=main
#
# GH Pages icin deploy.ps1 ayri tutulur (oradaki base-href=/lutke/).
# Iki kanal paralel calisabilir.

$ErrorActionPreference = "Stop"

# ─── API Token ──────────────────────────────────────────────────
# Token User-scope env var olarak saklanir. Eger bu PS oturumunda
# yoksa, registry'den oku ve trim et (kullanici paste ederken
# bashlangic/bitis bosluklari olabilir).
if (-not $env:CLOUDFLARE_API_TOKEN) {
    $userToken = [Environment]::GetEnvironmentVariable('CLOUDFLARE_API_TOKEN', 'User')
    if ($userToken) {
        $env:CLOUDFLARE_API_TOKEN = $userToken.Trim()
    }
}
if (-not $env:CLOUDFLARE_API_TOKEN) {
    throw "CLOUDFLARE_API_TOKEN bulunamadi. Once token'i set et: [Environment]::SetEnvironmentVariable('CLOUDFLARE_API_TOKEN', 'TOKEN', 'User')"
}
Write-Host "API Token: $($env:CLOUDFLARE_API_TOKEN.Length) chars OK" -ForegroundColor DarkGray

$flutterBin = "C:\Users\yilma\development\flutter\bin"
if (-not ($env:Path -like "*$flutterBin*")) {
    $env:Path = "$flutterBin;$env:Path"
}

$projectRoot = "C:\Users\yilma\Desktop\Jimaro\Diskalkuli_Platform\Kurmanci\Lutke\LUTKE_v1\lutke_flutter_project"
Set-Location $projectRoot

# Cloudflare Pages projesi adi. Ilk deploy'da otomatik olusturulur (subdomain: <name>.pages.dev).
$projectName = "lutke"

# Cloudflare account ID — dashboard URL'inden alinmis.
# Token'da "User Details Read" izni yoksa /memberships endpoint'i basarisiz olur;
# direkt account ID gecmek bu sorgudan kacinir.
$env:CLOUDFLARE_ACCOUNT_ID = "0eec8b88e11ef882d9269249ad00e331"

Write-Host "== 1/4 Flutter clean ==" -ForegroundColor Cyan
flutter clean
if ($LASTEXITCODE -ne 0) { throw "flutter clean failed" }

Write-Host "== 2/4 Flutter pub get ==" -ForegroundColor Cyan
flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }

Write-Host "== 3/4 Flutter build web (base-href=/, root domain) ==" -ForegroundColor Cyan
flutter build web --base-href="/" --release --tree-shake-icons
if ($LASTEXITCODE -ne 0) { throw "flutter build failed" }

Write-Host "== 4/4 Cloudflare Pages deploy ==" -ForegroundColor Cyan
Write-Host "Proje adi: $projectName" -ForegroundColor Yellow

# Backend kurulum durum kontrolu
$tomlContent = Get-Content (Join-Path $projectRoot "wrangler.toml") -Raw
if ($tomlContent -match "PLACEHOLDER_REPLACE_AFTER_CREATE") {
    Write-Host "" -ForegroundColor Yellow
    Write-Host "[UYARI] wrangler.toml'da database_id yer tutucu. " -ForegroundColor Yellow
    Write-Host "Once `"setup_cloudflare_backend.ps1`" calistirip D1 yarat ve secret'lari ayarla." -ForegroundColor Yellow
    Write-Host "Bu uyariya ragmen devam ediliyor (frontend test deploy)..." -ForegroundColor Yellow
    Write-Host "" -ForegroundColor Yellow
}

# Proje var mi kontrol et — yoksa olustur
Write-Host "Proje varlik kontrolu..." -ForegroundColor DarkGray
$projectListOutput = wrangler pages project list 2>&1 | Out-String
if ($projectListOutput -notmatch [regex]::Escape($projectName)) {
    Write-Host "Proje bulunamadi, olusturuluyor..." -ForegroundColor Yellow
    wrangler pages project create $projectName --production-branch=main 2>&1 | Out-Host
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Proje olusturulamadi." -ForegroundColor Red
        throw "wrangler pages project create failed"
    }
    Write-Host "Proje olusturuldu: $projectName" -ForegroundColor Green
} else {
    Write-Host "Proje zaten mevcut: $projectName" -ForegroundColor DarkGray
}

# wrangler pages deploy
# --project-name      : Cloudflare Pages projesi
# --branch            : production branch (main = production deploy, diger = preview)
# --commit-dirty      : yerel commit'lenmemis degisikliklere izin ver
#
# NOT: functions/ klasoru proje koku altinda olunca wrangler otomatik
# bundle eder (Pages Functions). wrangler.toml'daki D1 binding'i de
# functions runtime'a baglanir.
wrangler pages deploy build/web `
    --project-name=$projectName `
    --branch=main `
    --commit-dirty=true

if ($LASTEXITCODE -ne 0) {
    Write-Host "" -ForegroundColor Red
    Write-Host "Cloudflare deploy basarisiz. Olasi nedenler:" -ForegroundColor Red
    Write-Host "  1. Auth eksik. Bir kez `"wrangler login`" calistir (tarayici acilir, hesabi onayla)." -ForegroundColor Yellow
    Write-Host "  2. Proje adi cakisi. Cloudflare dashboard'unda farkli bir isim al." -ForegroundColor Yellow
    Write-Host "  3. Internet/firewall." -ForegroundColor Yellow
    throw "wrangler pages deploy failed"
}

Write-Host "" -ForegroundColor Green
Write-Host "== DEPLOY DONE ==" -ForegroundColor Green
Write-Host "Pages URL: https://$projectName.pages.dev/" -ForegroundColor Green
Write-Host ""

# Custom domain bind — yalnizca ilk deploy'da gerekli, sonrakilerde no-op.
# Iki domain baglanir: apex (lutke.app) + www (www.lutke.app)
$customDomains = @("lutke.app", "www.lutke.app")
$customDomain = $customDomains[0]  # gosterim icin
Write-Host "== Custom domain baglanti kontrolu (API) ==" -ForegroundColor Cyan
# wrangler 4.x'de `pages domain` komutu kaldirildi.
# Direkt Cloudflare API kullanilir.
$apiBase = "https://api.cloudflare.com/client/v4/accounts/$($env:CLOUDFLARE_ACCOUNT_ID)/pages/projects/$projectName/domains"
$headers = @{
    'Authorization' = "Bearer $($env:CLOUDFLARE_API_TOKEN)"
    'Content-Type'  = 'application/json'
}

# Mevcut bagli domainleri cek
try {
    $existing = Invoke-RestMethod -Uri $apiBase -Headers $headers -Method Get
    $existingNames = $existing.result | ForEach-Object { $_.name }
} catch {
    $existingNames = @()
}

foreach ($domain in $customDomains) {
    if ($existingNames -contains $domain) {
        Write-Host "  [OK] Bagli: $domain" -ForegroundColor Green
    } else {
        Write-Host "  Baglaniyor: $domain ..." -ForegroundColor Yellow
        try {
            $body = @{ name = $domain } | ConvertTo-Json -Compress
            $resp = Invoke-RestMethod -Uri $apiBase -Headers $headers -Method Post -Body $body
            if ($resp.success) {
                Write-Host "  [OK] $domain eklendi (status: $($resp.result.status))" -ForegroundColor Green
            } else {
                Write-Host "  [WARN] $domain eklenirken hata: $($resp.errors | ConvertTo-Json -Compress)" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "  [WARN] $domain API hatasi: $($_.Exception.Message)" -ForegroundColor Yellow
            Write-Host "    Manuel ekle: Dashboard > Pages > $projectName > Custom domains > Add" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "== ALL DONE ==" -ForegroundColor Green
Write-Host "Apex:       https://lutke.app/        (1-2 dk SSL)" -ForegroundColor Green
Write-Host "WWW:        https://www.lutke.app/    (1-2 dk SSL)" -ForegroundColor Green
Write-Host "Pages URL:  https://$projectName.pages.dev/" -ForegroundColor Green
