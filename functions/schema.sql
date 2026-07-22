-- LÛTKE — D1 (SQLite) database schema
--
-- Cloudflare Pages Functions ile birlikte kullanılır.
-- İlk kurulum:
--   wrangler d1 create lutke_users
--   wrangler d1 execute lutke_users --file=functions/schema.sql --remote

-- ─── users ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id              TEXT PRIMARY KEY,         -- UUID v4
  email           TEXT UNIQUE NOT NULL,
  password_hash   TEXT NOT NULL,            -- PBKDF2 hash (Google users: dummy hash)
  password_salt   TEXT NOT NULL,            -- random salt (hex)
  display_name    TEXT,
  email_verified  INTEGER NOT NULL DEFAULT 0,  -- 0/1
  is_owner        INTEGER NOT NULL DEFAULT 0,  -- admin flag
  google_id       TEXT,                     -- Google OAuth subject ID (NULL for local-only users)
  created_at      INTEGER NOT NULL,         -- unix ms
  updated_at      INTEGER NOT NULL,
  last_login_at   INTEGER,
  deleted_at      INTEGER,
  -- Profile
  current_level   TEXT DEFAULT 'a1',
  target_level    TEXT DEFAULT 'b1',
  is_heritage     INTEGER NOT NULL DEFAULT 0,
  daily_goal      INTEGER NOT NULL DEFAULT 10,
  -- placement_level: NULL = Kurmancî düzey testi henüz yapılmadı; 'a1'..'c2' = yapıldı.
  -- Hesap-bazlı test-once sinyali (cihaz/origin bağımsız). current_level
  -- signup'ta 'a1' default olduğu için tek başına "test yapıldı mı" ayırt edemez.
  placement_level TEXT,
  -- placement_level_en: İngilizce track için AYRI test-once sinyali.
  -- Track-bazlı ayrım: KU testi yapan kullanıcı EN tarafında yerleşmiş sayılmaz
  -- (bkz. migrations/002_add_placement_level_en.sql).
  placement_level_en TEXT
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_created ON users(created_at);
CREATE INDEX IF NOT EXISTS idx_users_google_id ON users(google_id);

-- Migration helper (idempotent): for existing DBs that don't have google_id yet.
-- Run this once with: wrangler d1 execute lutke_users --file=functions/schema.sql --remote
-- The ALTER will silently fail if column already exists, which is fine.
-- (D1 doesn't support IF NOT EXISTS on ADD COLUMN as of 2026; use migrations/001_*.sql.)

-- ─── auth_tokens ────────────────────────────────────────────────
-- Tek-kullanımlık token'lar: email verification, password reset.
CREATE TABLE IF NOT EXISTS auth_tokens (
  token         TEXT PRIMARY KEY,           -- 32-byte random hex
  user_id       TEXT NOT NULL,
  type          TEXT NOT NULL,              -- 'verify_email' | 'reset_password'
  expires_at    INTEGER NOT NULL,           -- unix ms
  used_at       INTEGER,                    -- null = unused
  created_at    INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_tokens_user ON auth_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_tokens_expires ON auth_tokens(expires_at);

-- ─── login_audit ────────────────────────────────────────────────
-- Güvenlik logu — başarılı/başarısız girişler.
CREATE TABLE IF NOT EXISTS login_audit (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  email         TEXT NOT NULL,
  user_id       TEXT,                       -- null if email not found
  success       INTEGER NOT NULL,           -- 0/1
  reason        TEXT,                       -- 'wrong_password' | 'unverified' | ...
  ip            TEXT,                       -- hashed for privacy
  user_agent    TEXT,
  created_at    INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_audit_email ON login_audit(email, created_at);
CREATE INDEX IF NOT EXISTS idx_audit_user ON login_audit(user_id, created_at);

-- ─── rate_limit ─────────────────────────────────────────────────
-- IP/email başına rate limit sayacı (anti-bruteforce).
CREATE TABLE IF NOT EXISTS rate_limit (
  bucket        TEXT PRIMARY KEY,           -- "<scope>:<key>" e.g. "login:user@x.com"
  count         INTEGER NOT NULL DEFAULT 0,
  reset_at      INTEGER NOT NULL            -- window expires unix ms
);
-- 003 — content_suggestions tablosu (kullanıcı düzeltme önerileri)
--
-- Kullanıcılar uygulamadan içerik hatası/düzeltme önerisi gönderir
-- (POST /api/suggestions — herkese açık, rate-limitli). Yönetici panelindeki
-- "Pêşniyar" sekmesi listeler (GET — owner) ve durum günceller
-- (POST /api/suggestions/update — owner).
--
-- Mevcut (production) DB'ye uygulamak için TEK SEFER:
--   wrangler d1 execute lutke_users --file=functions/migrations/003_add_content_suggestions.sql --remote
CREATE TABLE IF NOT EXISTS content_suggestions (
  id            TEXT PRIMARY KEY,           -- UUID v4
  user_id       TEXT,                       -- oturum varsa users.id, yoksa NULL
  email         TEXT,                       -- iletişim (opsiyonel, kullanıcı girdiyse)
  item_type     TEXT NOT NULL,              -- 'peyv' | 'hevok' | 'werger' | 'deng' | 'din'
  item_id       TEXT,                       -- ör. kelime id'si (a1_025) — opsiyonel
  item_text     TEXT,                       -- ilgili içerik metni (ör. kelimenin kendisi)
  message       TEXT NOT NULL,              -- sorunun tarifi
  suggestion    TEXT,                       -- önerilen düzeltme (opsiyonel)
  route         TEXT,                       -- formun açıldığı ekran (teşhis için)
  status        TEXT NOT NULL DEFAULT 'open', -- 'open' | 'accepted' | 'rejected'
  created_at    INTEGER NOT NULL,
  updated_at    INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_suggestions_status
  ON content_suggestions(status, created_at);
