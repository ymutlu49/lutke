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

$flutterBin = "C:\Users\yilma\development\flutter\bin"
if (-not ($env:Path -like "*$flutterBin*")) {
    $env:Path = "$flutterBin;$env:Path"
}

$projectRoot = "C:\Users\yilma\Desktop\Jimaro\Diskalkuli_Platform\Kurmanci\Lutke\LUTKE_v1\lutke_flutter_project"
Set-Location $projectRoot

# Cloudflare Pages projesi adi. Ilk deploy'da otomatik olusturulur (subdomain: <name>.pages.dev).
$projectName = "lutke"

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

# wrangler pages deploy
# --project-name : Cloudflare Pages projesi (yok ise olusturur)
# --branch       : production branch (main = production deploy, diger = preview)
# --commit-dirty : yerel commit'lenmemis degisikliklere izin ver
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
Write-Host "== Custom domain baglanti kontrolu ==" -ForegroundColor Cyan

$existingDomains = wrangler pages domain list --project-name=$projectName 2>&1
foreach ($domain in $customDomains) {
    if ($existingDomains -match [regex]::Escape($domain)) {
        Write-Host "  [OK] Bagli: $domain" -ForegroundColor Green
    } else {
        Write-Host "  Baglaniyor: $domain ..." -ForegroundColor Yellow
        wrangler pages domain add $domain --project-name=$projectName
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  [OK] Bagi tamam: $domain" -ForegroundColor Green
        } else {
            Write-Host "  [WARN] $domain baglanamadi. Manuel ekle:" -ForegroundColor Yellow
            Write-Host "    Dashboard > Pages > $projectName > Custom domains > Add" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "== ALL DONE ==" -ForegroundColor Green
Write-Host "Apex:       https://lutke.app/        (1-2 dk SSL)" -ForegroundColor Green
Write-Host "WWW:        https://www.lutke.app/    (1-2 dk SSL)" -ForegroundColor Green
Write-Host "Pages URL:  https://$projectName.pages.dev/" -ForegroundColor Green
