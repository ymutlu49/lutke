# LÛTKE — Malper + App + Cloudflare (deploy notları)

**Tarih:** 2026-05-31 · **Mimari:** Tanıtım sitesi KÖKTE, Flutter app `/app/` altında, auth backend aynen korunur. **Canlı + doğrulandı.**

## Mimari özeti

```
lutke.app/                 → Kurmancî tanıtım sitesi (statik, website/ → dist/)
lutke.app/app/             → Flutter web app (build/web → dist/app, base-href=/app/)
lutke.app/api/*            → Pages Functions (functions/, DEĞİŞMEDİ) — auth backend
lutke.app/auth/verify-email→ KÖKTE statik sayfa (token'ı /api/auth/verify-email'e POST eder)
lutke.app/reset-password   → KÖKTE statik sayfa (token'ı /api/auth/reset-password'e POST eder)
lutke.app/oauth-callback   → build/web'den kopyalandı (redirect_uri = origin + /oauth-callback)
/home, /vocabulary, ...    → /app/... (301 redirect / fiziksel redirect sayfası)
```

### Neden bu yol? (en güvenli)
- **Yeniden derleme YOK**: `build/web` (bilinen-iyi artefakt) olduğu gibi `dist/app`'e kopyalanır; sadece `index.html`'de `<base href="/">` → `<base href="/app/">` (runtime DOM değeri, derleme gerektirmez).
  - Çalışma ağacında ~226 commit'siz değişiklik (lib/ +22k satır WIP) vardı → kaynaktan derleme canlı app'e bilinmeyen kod gönderirdi. Bu yüzden **mevcut build kullanıldı**.
- **Dart değişikliği YOK**: `_resolveInitialLocation()` ham `Uri.base.path` kullandığından app `/app/`'e taşınınca token deep-link'leri router-rebuild'de kırılırdı. Çözüm: token akışları (verify-email/reset-password) **uygulamadan ayrılıp kökte statik sayfalara** taşındı; bunlar mevcut `/api/*`'ı çağırır.
- **functions/ DEĞİŞMEDİ**: e-posta linkleri zaten `${PUBLIC_BASE_URL}/auth/verify-email` ve `/reset-password`'a gidiyor → kökteki statik sayfalar bunları karşılar.

## Build

```
node build-site.mjs            # sadece tanıtım sitesi (hızlı; mevcut dist/app korunur)
node build-site.mjs --with-app # build/web → dist/app kopyası dahil (ağır, ~1.3GB local; upload dedup'lı)
node tools/site/gen-og.mjs     # OG görselleri (headless Chrome, 1200×630, izole --user-data-dir)
```

## Deploy

```
powershell -ExecutionPolicy Bypass -File deploy_site.ps1            # production (main)
powershell -ExecutionPolicy Bypass -File deploy_site.ps1 -Branch test   # preview
powershell -ExecutionPolicy Bypass -File deploy_site.ps1 -RebuildApp     # app'i de yeniden derle (lib/ değiştiyse)
```
- `functions/` proje kökünde olduğundan `wrangler pages deploy dist` onu CWD'den bundle eder.
- `wrangler.toml` → `pages_build_output_dir = "dist"`.
- **`deploy_cloudflare.ps1` DEVRE DIŞI** (başına `throw` eklendi): app'i köke koyup tanıtım sitesini silerdi.
- Token: `C:\Users\yilma\cf_token.txt` (deploy_site.ps1 otomatik okur).

## Doğrulama (her deploy sonrası — apex'ten, *.pages.dev bu makineden TLS hatası verir)
- `curl -I https://lutke.app/` → 200 (tanıtım sitesi)
- `curl -I https://lutke.app/app/` → 200 (Flutter app, base-href=/app/)
- `curl https://lutke.app/api/public-config` → JSON
- `curl -I https://lutke.app/auth/verify-email` → 200 (statik sayfa)
- Auth E2E: kayıt → D1'den verify token oku → POST /api/auth/verify-email → D1'de `email_verified=1` doğrula.
  - **2026-05-31 test sonucu: GEÇTİ** (signup→gate→verify→login JWT zinciri çalışıyor).

## Rollback
Cloudflare Pages → Pages → lutke → Deployments → önceki **app-kökte** deployment (`0a8e4aec`, 2026-05-16) → "Rollback".

## Açık işler / notlar
- Mevcut PWA kurulumları (start_url="/") artık tanıtım sayfasını gösterir; kullanıcı "Sepanê veke" / "Têkeve" ile /app/'e gider. Yeni app manifesti /app/ scope'ludur.
- `info@lutke.app` (Têkilî sayfası) için Cloudflare Email Routing kurulması önerilir (yoksa mail bounce eder).
- Naverok sayfası gerçek DB'den (a1/a2/b1/c1_kelime_db.dart) 30 örnek kelime çeker; istenirse Dart export ile tam içerik gezgini eklenebilir.
- **Ortam tuzağı:** `*.lutke.pages.dev` bu makineden hem curl (schannel TLS) hem node fetch (ECONNRESET) ile erişilemez. Preview doğrulaması için farklı ağ/cihaz gerekir; ya da doğrudan prod + rollback güvencesi.
