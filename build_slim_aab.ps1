# LUTKE - Ince AAB derlemesi: assets/audio/words (1.3GB) gecici olarak
# proje disina tasinir, pubspec'ten cikartilir, gradle bundleRelease kosulur,
# sonra HER DURUMDA geri yuklenir (finally). Web build'i etkilenmez.
$ErrorActionPreference = "Stop"
$proj = $PSScriptRoot
$words = Join-Path $proj "assets\audio\words"
$stash = "C:\Users\yilma\lutke_words_stash"
$pubspec = Join-Path $proj "pubspec.yaml"
$backup = Join-Path $proj "pubspec.yaml.slimbak"

Copy-Item $pubspec $backup -Force
try {
    # pubspec'ten words satirini cikar
    (Get-Content $pubspec) | Where-Object { $_ -notmatch "assets/audio/words/" } | Set-Content $pubspec -Encoding utf8
    # klasoru disari tasi
    if (Test-Path $words) { Move-Item $words $stash -Force }

    Set-Location (Join-Path $proj "android")
    $env:Path = "C:\Users\yilma\development\flutter\bin;$env:Path"
    .\gradlew.bat bundleRelease
    if ($LASTEXITCODE -ne 0) { throw "gradle bundleRelease failed" }
}
finally {
    Set-Location $proj
    if (Test-Path $stash) { Move-Item $stash $words -Force }
    Move-Item $backup $pubspec -Force
}
$aab = Join-Path $proj "build\app\outputs\bundle\release\app-release.aab"
"AAB: $((Get-Item $aab).Length) bayt"
