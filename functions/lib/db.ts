// LÛTKE — D1 database helpers.

export interface UserRow {
  id: string;
  email: string;
  password_hash: string;
  password_salt: string;
  display_name: string | null;
  email_verified: number;
  is_owner: number;
  google_id: string | null;
  created_at: number;
  updated_at: number;
  last_login_at: number | null;
  deleted_at: number | null;
  current_level: string;
  target_level: string;
  is_heritage: number;
  daily_goal: number;
  placement_level: string | null; // NULL = Kurmancî düzey testi yapılmadı
  placement_level_en: string | null; // NULL = İngilizce düzey testi yapılmadı (track-bazlı test-once)
}

export interface AuthTokenRow {
  token: string;
  user_id: string;
  type: "verify_email" | "reset_password";
  expires_at: number;
  used_at: number | null;
  created_at: number;
}

// ─── Users ────────────────────────────────────────────────────

export async function findUserByEmail(
  db: D1Database,
  email: string,
): Promise<UserRow | null> {
  const stmt = db
    .prepare(
      "SELECT * FROM users WHERE email = ? AND deleted_at IS NULL LIMIT 1",
    )
    .bind(email.toLowerCase().trim());
  const row = await stmt.first<UserRow>();
  return row ?? null;
}

export async function findUserById(
  db: D1Database,
  id: string,
): Promise<UserRow | null> {
  const stmt = db
    .prepare("SELECT * FROM users WHERE id = ? AND deleted_at IS NULL LIMIT 1")
    .bind(id);
  return (await stmt.first<UserRow>()) ?? null;
}

export async function createUser(
  db: D1Database,
  user: {
    id: string;
    email: string;
    passwordHash: string;
    passwordSalt: string;
    displayName: string;
    isOwner: boolean;
    currentLevel: string;
    targetLevel: string;
    isHeritage: boolean;
    dailyGoal: number;
  },
): Promise<void> {
  const now = Date.now();
  await db
    .prepare(
      `INSERT INTO users (
        id, email, password_hash, password_salt, display_name,
        email_verified, is_owner, created_at, updated_at,
        current_level, target_level, is_heritage, daily_goal
      ) VALUES (?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?)`,
    )
    .bind(
      user.id,
      user.email.toLowerCase().trim(),
      user.passwordHash,
      user.passwordSalt,
      user.displayName,
      user.isOwner ? 1 : 0,
      now,
      now,
      user.currentLevel,
      user.targetLevel,
      user.isHeritage ? 1 : 0,
      user.dailyGoal,
    )
    .run();
}

/// Google OAuth — find existing user by Google subject ID.
export async function findUserByGoogleId(
  db: D1Database,
  googleId: string,
): Promise<UserRow | null> {
  const stmt = db
    .prepare(
      "SELECT * FROM users WHERE google_id = ? AND deleted_at IS NULL LIMIT 1",
    )
    .bind(googleId);
  return (await stmt.first<UserRow>()) ?? null;
}

/// Google OAuth — link an existing email-based user to a Google account.
export async function linkGoogleId(
  db: D1Database,
  userId: string,
  googleId: string,
): Promise<void> {
  await db
    .prepare(
      "UPDATE users SET google_id = ?, email_verified = 1, updated_at = ? WHERE id = ?",
    )
    .bind(googleId, Date.now(), userId)
    .run();
}

/// Google OAuth — create a brand-new user from Google ID token claims.
/// password_hash/salt set to dummy random values; user can set a password later
/// via the password reset flow if they want email/password login as well.
export async function createGoogleUser(
  db: D1Database,
  user: {
    id: string;
    email: string;
    googleId: string;
    displayName: string;
    isOwner: boolean;
    dummyPasswordHash: string;
    dummyPasswordSalt: string;
  },
): Promise<void> {
  const now = Date.now();
  await db
    .prepare(
      `INSERT INTO users (
        id, email, password_hash, password_salt, display_name,
        email_verified, is_owner, google_id, created_at, updated_at,
        current_level, target_level, is_heritage, daily_goal
      ) VALUES (?, ?, ?, ?, ?, 1, ?, ?, ?, ?, 'a1', 'b1', 0, 10)`,
    )
    .bind(
      user.id,
      user.email.toLowerCase().trim(),
      user.dummyPasswordHash,
      user.dummyPasswordSalt,
      user.displayName,
      user.isOwner ? 1 : 0,
      user.googleId,
      now,
      now,
    )
    .run();
}

export async function markEmailVerified(
  db: D1Database,
  userId: string,
): Promise<void> {
  await db
    .prepare(
      "UPDATE users SET email_verified = 1, updated_at = ? WHERE id = ?",
    )
    .bind(Date.now(), userId)
    .run();
}

export async function updateLastLogin(
  db: D1Database,
  userId: string,
): Promise<void> {
  const now = Date.now();
  await db
    .prepare(
      "UPDATE users SET last_login_at = ?, updated_at = ? WHERE id = ?",
    )
    .bind(now, now, userId)
    .run();
}

/// Düzey belirleme testi sonucunu hesaba yazar (account + TRACK bazlı test-once).
/// track = "ku" (varsayılan): placement_level + current_level güncellenir
///   (current_level = Kurmancî aktif çalışma seviyesi — eski davranış korunur).
/// track = "en": yalnız placement_level_en güncellenir; current_level'a
///   DOKUNULMAZ (o Kurmancî seviyesidir, EN testi onu bozmamalı).
export async function setPlacementLevel(
  db: D1Database,
  userId: string,
  level: string,
  track: "ku" | "en" = "ku",
): Promise<void> {
  const now = Date.now();
  if (track === "en") {
    await db
      .prepare(
        "UPDATE users SET placement_level_en = ?, updated_at = ? WHERE id = ?",
      )
      .bind(level, now, userId)
      .run();
    return;
  }
  await db
    .prepare(
      "UPDATE users SET placement_level = ?, current_level = ?, updated_at = ? WHERE id = ?",
    )
    .bind(level, level, now, userId)
    .run();
}

export async function updatePassword(
  db: D1Database,
  userId: string,
  passwordHash: string,
  passwordSalt: string,
): Promise<void> {
  await db
    .prepare(
      `UPDATE users SET password_hash = ?, password_salt = ?, updated_at = ?
       WHERE id = ?`,
    )
    .bind(passwordHash, passwordSalt, Date.now(), userId)
    .run();
}

// ─── Tokens ───────────────────────────────────────────────────

export async function createToken(
  db: D1Database,
  token: string,
  userId: string,
  type: "verify_email" | "reset_password",
  expiresAt: number,
): Promise<void> {
  await db
    .prepare(
      `INSERT INTO auth_tokens (token, user_id, type, expires_at, created_at)
       VALUES (?, ?, ?, ?, ?)`,
    )
    .bind(token, userId, type, expiresAt, Date.now())
    .run();
}

export async function findToken(
  db: D1Database,
  token: string,
  type: "verify_email" | "reset_password",
): Promise<AuthTokenRow | null> {
  const row = await db
    .prepare(
      `SELECT * FROM auth_tokens
       WHERE token = ? AND type = ? AND used_at IS NULL
         AND expires_at > ?
       LIMIT 1`,
    )
    .bind(token, type, Date.now())
    .first<AuthTokenRow>();
  return row ?? null;
}

export async function markTokenUsed(
  db: D1Database,
  token: string,
): Promise<void> {
  await db
    .prepare("UPDATE auth_tokens SET used_at = ? WHERE token = ?")
    .bind(Date.now(), token)
    .run();
}

export async function deleteOldTokensForUser(
  db: D1Database,
  userId: string,
  type: "verify_email" | "reset_password",
): Promise<void> {
  // Sadece kullanılmamış token'ları temizle (kullanılanları audit için tut).
  await db
    .prepare(
      "DELETE FROM auth_tokens WHERE user_id = ? AND type = ? AND used_at IS NULL",
    )
    .bind(userId, type)
    .run();
}

// ─── Audit ────────────────────────────────────────────────────

export async function logLoginAttempt(
  db: D1Database,
  email: string,
  userId: string | null,
  success: boolean,
  reason: string | null,
  ip: string | null,
  userAgent: string | null,
): Promise<void> {
  await db
    .prepare(
      `INSERT INTO login_audit (email, user_id, success, reason, ip, user_agent, created_at)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
    )
    .bind(
      email.toLowerCase().trim(),
      userId,
      success ? 1 : 0,
      reason,
      ip,
      userAgent,
      Date.now(),
    )
    .run();
}

// ─── Stats (admin) ────────────────────────────────────────────

export interface UserStats {
  total: number;
  verified: number;
  unverified: number;
  registeredLast24h: number;
  registeredLast7d: number;
  activeLast30d: number;
}

export async function getUserStats(db: D1Database): Promise<UserStats> {
  const now = Date.now();
  const day = 24 * 60 * 60 * 1000;
  const ago24h = now - day;
  const ago7d = now - 7 * day;
  const ago30d = now - 30 * day;

  const result = await db
    .prepare(
      `SELECT
        SUM(1) AS total,
        SUM(CASE WHEN email_verified = 1 THEN 1 ELSE 0 END) AS verified,
        SUM(CASE WHEN email_verified = 0 THEN 1 ELSE 0 END) AS unverified,
        SUM(CASE WHEN created_at > ? THEN 1 ELSE 0 END) AS registered_last_24h,
        SUM(CASE WHEN created_at > ? THEN 1 ELSE 0 END) AS registered_last_7d,
        SUM(CASE WHEN last_login_at > ? THEN 1 ELSE 0 END) AS active_last_30d
       FROM users WHERE deleted_at IS NULL`,
    )
    .bind(ago24h, ago7d, ago30d)
    .first<{
      total: number;
      verified: number;
      unverified: number;
      registered_last_24h: number;
      registered_last_7d: number;
      active_last_30d: number;
    }>();

  return {
    total: result?.total ?? 0,
    verified: result?.verified ?? 0,
    unverified: result?.unverified ?? 0,
    registeredLast24h: result?.registered_last_24h ?? 0,
    registeredLast7d: result?.registered_last_7d ?? 0,
    activeLast30d: result?.active_last_30d ?? 0,
  };
}
