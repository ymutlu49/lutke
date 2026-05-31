# LÛTKE — Tanıtım sitesi (kök) + Flutter app (/app/) + Functions deploy
# ---------------------------------------------------------------------------
# Kullanım:
#   powershell -ExecutionPolicy Bypass -File deploy_site.ps1                # production (main)
#   powershell -ExecutionPolicy Bypass -File deploy_site.ps1 -Branch test   # preview deploy
#   powershell -ExecutionPolicy Bypass -File deploy_site.ps1 -RebuildApp    # önce flutter build web (RİSKLİ: çalışma ağacını derler)
#
# Mimari:
#   - website/ -> dist/ (Kurmancî tanıtım sitesi, KÖK)
#   - build/web -> dist/app/ (Flutter app, base-href /app/ — DERLEME GEREKMEZ, sadece kopya + base-href swap)
#   - functions/ KÖKTE kalır -> /api/* + auth backend AYNEN korunur
#   - /auth/verify-email + /reset-password = kökte STATİK sayfalar (mevcut /api/* çağırır)
#
# NOT: Eski deploy_cloudflare.ps1 app'i KÖKE koyuyordu; artık DEVRE DIŞI. Bunu kullan.

param(
  [string]$Branch = "main",
  [switch]$RebuildApp
)

$ErrorActionPreference = "Stop"
$projectRoot = "C:\Users\yilma\Desktop\Jimaro\Diskalkuli_Platform\Kurmanci\Lutke\LUTKE_v1\lutke_flutter_project"
Set-Location $projectRoot

# ─── API Token ───────────────────────────────────────────────────
if (-not $env:CLOUDFLARE_API_TOKEN) {
  $tokenFiles = @("$env:USERPROFILE\cf_token.txt", "$env:USERPROFILE\.cf_token", "C:\Users\yilma\cf_token.txt")
  foreach ($tf in $tokenFiles) {
    if (Test-Path $tf) { $env:CLOUDFLARE_API_TOKEN = (Get-Content $tf -Raw).Trim(); break }
  }
}
if (-not $env:CLOUDFLARE_API_TOKEN) {
  $userToken = [Environment]::GetEnvironmentVariable('CLOUDFLARE_API_TOKEN', 'User')
  if ($userToken) { $env:CLOUDFLARE_API_TOKEN = $userToken.Trim() }
}
if (-not $env:CLOUDFLARE_API_TOKEN) {
  throw "CLOUDFLARE_API_TOKEN bulunamadi. cf_token.txt olustur veya env var set et."
}
$env:CLOUDFLARE_ACCOUNT_ID = "0eec8b88e11ef882d9269249ad00e331"
Write-Host "API Token: $($env:CLOUDFLARE_API_TOKEN.Length) chars OK" -ForegroundColor DarkGray

# ─── (opsiyonel) Flutter app yeniden derle ───────────────────────
if ($RebuildApp) {
  $flutterBin = "C:\Users\yilma\development\flutter\bin"
  if (-not ($env:Path -like "*$flutterBin*")) { $env:Path = "$flutterBin;$env:Path" }
  Write-Host "== Flutter build web (base-href=/app/) ==" -ForegroundColor Cyan
  flutter build web --base-href="/app/" --release --tree-shake-icons
  if ($LASTEXITCODE -ne 0) { throw "flutter build failed" }
}

# ─── İçerik JSON'unu Dart'tan dışa aktar (peyv/ders/diyalog) ─────
# website/data/content.json git'te tracked; içerik DB'leri değiştiyse tazele.
$flutterBin2 = "C:\Users\yilma\development\flutter\bin"
if (-not ($env:Path -like "*$flutterBin2*")) { $env:Path = "$flutterBin2;$env:Path" }
Write-Host "== export_content.dart (content.json tazeleniyor) ==" -ForegroundColor Cyan
dart run tool/export_content.dart
if ($LASTEXITCODE -ne 0) { Write-Host "[UYARI] export_content basarisiz — mevcut content.json kullanilacak" -ForegroundColor Yellow }

# ─── Site + app derle (dist) ─────────────────────────────────────
Write-Host "== build-site.mjs --with-app (dist olusturuluyor) ==" -ForegroundColor Cyan
node build-site.mjs --with-app
if ($LASTEXITCODE -ne 0) { throw "build-site failed" }

# ─── Wrangler deploy (functions/ CWD'den bundle edilir) ──────────
Write-Host "== Cloudflare Pages deploy (branch: $Branch) ==" -ForegroundColor Cyan
$wrangler = "$env:APPDATA\npm\wrangler.cmd"
if (Test-Path $wrangler) {
  cmd /c "`"$wrangler`" pages deploy dist --project-name=lutke --branch=$Branch --commit-dirty=true"
} else {
  cmd /c "npx --yes wrangler pages deploy dist --project-name=lutke --branch=$Branch --commit-dirty=true"
}
if ($LASTEXITCODE -ne 0) { throw "wrangler pages deploy failed" }

Write-Host ""
Write-Host "== DEPLOY DONE ==" -ForegroundColor Green
if ($Branch -eq "main") {
  Write-Host "Production: https://lutke.app/  (site)  +  https://lutke.app/app/  (app)" -ForegroundColor Green
  Write-Host "Dogrulama: curl -I https://lutke.app/ ; https://lutke.app/app/ ; https://lutke.app/api/public-config" -ForegroundColor DarkGray
} else {
  Write-Host "Preview branch '$Branch' deploy edildi — URL wrangler ciktisinda (alias: https://$Branch.lutke.pages.dev)." -ForegroundColor Yellow
  Write-Host "NOT: *.pages.dev bu makineden TLS hatasi verebilir; dogrulama icin baska ag/cihaz kullan." -ForegroundColor Yellow
}
