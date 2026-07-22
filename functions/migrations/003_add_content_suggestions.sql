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
