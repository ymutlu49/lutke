# LÛTKE — Cloudflare Backend Kurulum

Bu dosya, Cloudflare-native auth sisteminin (D1 + Pages Functions + MailChannels)
kurulumu için tek seferlik adımları açıklar.

> **Neden Cloudflare-native?** Domain (`lutke.app`) zaten Cloudflare hesabında
> (`0eec8b88e11ef882d9269249ad00e331`). Firebase yerine D1 + Workers + MailChannels
> kullanmak: tek sağlayıcı, sıfır vendor lock-in, free tier yeterli, edge'de hızlı.

---

## Mimari özet

```
[Flutter Web SPA]
    │
    │  POST /api/auth/signup, /login, /verify-email, ...
    ▼
[Cloudflare Pages Functions]  (functions/ dizini)
    │
    ├──► [D1 SQLite]            (users, auth_tokens, login_audit, rate_limit)
    │
    └──► [MailChannels SMTP]    (verification + password reset emails)
            ▲
            │ DNS: SPF + _mailchannels TXT + (opsiyonel) DKIM
```

---

## Tek seferlik kurulum

### 1) PowerShell'de scripti çalıştır

```powershell
cd C:\Users\yilma\Desktop\Jimaro\Diskalkuli_Platform\Kurmanci\Lutke\LUTKE_v1\lutke_flutter_project
powershell -ExecutionPolicy Bypass -File setup_cloudflare_backend.ps1
```

Bu otomatik olarak:

- `lutke_users` D1 database'i yaratır (varsa atlar)
- `wrangler.toml` içindeki `database_id` placeholder'ını gerçek ID ile değiştirir
- `functions/schema.sql`'i remote D1'e uygular
- 64-byte rastgele JWT_SECRET üretip Pages secret olarak yazar

### 2) DNS kayıtlarını manuel ekle

**Cloudflare DNS panel** → `lutke.app` zone:

#### a) SPF (zorunlu — mail spoof koruması)

| Type | Name | Content |
|------|------|---------|
| TXT  | `@`  | `v=spf1 a mx include:relay.mailchannels.net ~all` |

#### b) MailChannels hesap güvenliği (zorunlu — başkası senin domaininden mail atmasın)

| Type | Name | Content |
|------|------|---------|
| TXT  | `_mailchannels` | `v=mc1 cfid=0eec8b88e11ef882d9269249ad00e331` |

#### c) DKIM (opsiyonel — daha iyi inbox teslimi)

```bash
# Bash veya WSL'de:
openssl genrsa 2048 > dkim_private.pem
openssl rsa -in dkim_private.pem -pubout -outform DER | openssl base64 -A > dkim_public.txt
```

- `dkim_public.txt` içeriğini DNS'e ekle:

| Type | Name | Content |
|------|------|---------|
| TXT  | `mailchannels._domainkey` | `v=DKIM1; p=<dkim_public.txt içeriği>` |

- `dkim_private.pem` içeriğini Pages secret olarak yaz:

```powershell
Get-Content dkim_private.pem | wrangler pages secret put MAILCHANNELS_DKIM_PRIVATE_KEY --project-name=lutke
```

> **Not:** DKIM olmadan da mail çalışır ama spam'a düşme riski yüksek olabilir.
> Üretim için ekle.

### 3) Deploy

```powershell
powershell -ExecutionPolicy Bypass -File deploy_cloudflare.ps1
```

Bu Flutter web build + Pages Functions deploy yapar. `functions/` dizini
otomatik olarak Worker'a bundle edilir, D1 binding `wrangler.toml`'dan okunur.

---

## Test akışı

1. **Kayıt**: `https://lutke.app/auth/register` → form doldur → submit
2. Mailbox'ı kontrol et → "LÛTKE — E-nava xwe piştrast bike" konulu mail gelmeli
3. Maildeki linke tıkla → `/api/auth/verify-email?token=...` → otomatik
   `/auth/verify-email?token=...` Flutter ekranına yönlenir → token doğrulanır
4. Profile → Mîheng tab → "Tenê ji bo Rêveberê" altında **kullanıcı sayısı kartı**
   görünmeli (sadece owner email ile giriş yapmışsa)

---

## Test verisini sıfırla

```powershell
# Tek kullanıcı sil
wrangler d1 execute lutke_users --remote --command="DELETE FROM users WHERE email='test@example.com';"

# Tum tablolari sıfırla (DİKKAT — production'da bunu yapma)
wrangler d1 execute lutke_users --remote --command="DELETE FROM login_audit;"
wrangler d1 execute lutke_users --remote --command="DELETE FROM auth_tokens;"
wrangler d1 execute lutke_users --remote --command="DELETE FROM users;"
```

---

## API endpoint listesi

| Method | Path | Auth | Açıklama |
|--------|------|------|----------|
| POST | `/api/auth/signup` | — | Yeni hesap + verification mail |
| POST | `/api/auth/login` | — | E-mail + password → JWT |
| POST | `/api/auth/verify-email` | — | `{ token }` → email_verified=1 |
| GET  | `/api/auth/verify-email?token=...` | — | Mail link redirect → `/auth/verify-email?token=...` |
| POST | `/api/auth/resend-verification` | Bearer | Yeni doğrulama linki yolla |
| POST | `/api/auth/request-password-reset` | — | `{ email }` → reset linki yolla (her zaman 200) |
| POST | `/api/auth/reset-password` | — | `{ token, newPassword }` |
| GET  | `/api/auth/me` | Bearer | Profil bilgisi |
| GET  | `/api/admin/stats` | Bearer (owner) | Kullanıcı sayısı + breakdown |

---

## Sorun giderme

**"D1 binding bulunamadı" hatası:**
- `wrangler.toml`'daki `database_id` doğru mu?
- `setup_cloudflare_backend.ps1`'i tekrar çalıştır.

**"JWT_SECRET undefined" hatası:**
- `wrangler pages secret list --project-name=lutke` ile kontrol et.
- Yoksa elle yaz: `wrangler pages secret put JWT_SECRET --project-name=lutke`

**Doğrulama maili gelmiyor:**
- DNS: SPF ve `_mailchannels` TXT kayıtları yayıldı mı? (`dig +short TXT lutke.app`)
- Cloudflare dashboard → Pages → lutke → Functions → Logs (real-time tail).
- Spam klasörünü kontrol et.

**"Unauthorized" hatası `/api/admin/stats`'ta:**
- JWT token'in `isOwner: true` claim'i var mı? (signup/login zamanında
  email `OWNER_EMAIL` env var ile eşleşmeli — wrangler.toml'da set edilmiş.)
