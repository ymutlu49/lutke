# LUTKE — Web build + GitHub Pages deploy scripti (GUVENLI)
# Kullanim: powershell -ExecutionPolicy Bypass -File deploy.ps1
#
# v2 (Nisan 2026): git worktree kullanir.
# Main branch dokunulmaz — gh-pages ayri bir gecici dizinde islenir.
# Eski cekirdek (`git checkout gh-pages` + `find rm`) main dosyalarini
# silebiliyordu. Bu surum guvenli.

$ErrorActionPreference = "Stop"

$flutterBin = "C:\Users\yilma\development\flutter\bin"
if (-not ($env:Path -like "*$flutterBin*")) {
    $env:Path = "$flutterBin;$env:Path"
}

$projectRoot = "C:\Users\yilma\Desktop\Jimaro\Diskalkuli_Platform\Lutke\LUTKE_v1\lutke_flutter_project"
Set-Location $projectRoot

Write-Host "== 1/4 Flutter clean ==" -ForegroundColor Cyan
flutter clean
if ($LASTEXITCODE -ne 0) { throw "flutter clean failed" }

Write-Host "== 2/4 Flutter pub get ==" -ForegroundColor Cyan
flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }

Write-Host "== 3/4 Flutter build web (base-href=/lutke/) ==" -ForegroundColor Cyan
flutter build web --base-href="/lutke/" --release
if ($LASTEXITCODE -ne 0) { throw "flutter build failed" }

Write-Host "== 4/4 Deploy to gh-pages (worktree) ==" -ForegroundColor Cyan

$worktree = Join-Path $env:TEMP "lutke_ghpages_$(Get-Random)"

# git worktree ayri bir dizinde gh-pages branch'ini cikartir.
# Main branch ana dizinde ETKILENMEZ.
git worktree add $worktree gh-pages
if ($LASTEXITCODE -ne 0) { throw "worktree add failed" }

try {
    Push-Location $worktree

    # Remote'a senkronize
    git fetch origin gh-pages
    git reset --hard origin/gh-pages

    # Eski dosyalari sil (bu dizin ayri — main etkilenmez)
    Get-ChildItem -Path . -Exclude ".git" -Force | Remove-Item -Recurse -Force

    # Yeni build'i kopyala
    Copy-Item -Path "$projectRoot\build\web\*" -Destination . -Recurse -Force
    New-Item -ItemType File -Path ".nojekyll" -Force | Out-Null

    git add -A
    $commitMsg = "deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git commit -m $commitMsg
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Commit yapilmadi (degisiklik yok mu?)" -ForegroundColor Yellow
    }

    git push origin gh-pages
    if ($LASTEXITCODE -ne 0) { throw "push failed" }

    Pop-Location
}
finally {
    # Worktree'yi temizle (main branch'e zarar vermez)
    git worktree remove --force $worktree 2>&1 | Out-Null
}

Write-Host "`n== DONE ==" -ForegroundColor Green
Write-Host "Canli URL: https://ymutlu49.github.io/lutke/" -ForegroundColor Yellow
Write-Host "1-2 dakika sonra degisiklikler canliya yansir." -ForegroundColor Yellow
Write-Host "(Tarayicida Ctrl+Shift+R ile cache temizle)" -ForegroundColor Yellow
