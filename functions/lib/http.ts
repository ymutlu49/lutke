// LÛTKE — HTTP helpers for Pages Functions.

export interface Env {
  DB: D1Database;
  JWT_SECRET: string;
  EMAIL_FROM: string;
  EMAIL_FROM_NAME?: string;
  RESEND_API_KEY?: string; // Resend (öncelikli mail sağlayıcı) — secret
  EMAIL_DRY_RUN?: string; // yalnız yerel geliştirme — bkz. lib/email.ts
  MAILCHANNELS_DKIM_DOMAIN?: string;
  MAILCHANNELS_DKIM_SELECTOR?: string;
  MAILCHANNELS_DKIM_PRIVATE_KEY?: string;
  OWNER_EMAILS?: string; // virgülle ayrılmış owner email listesi
  OWNER_EMAIL?: string; // legacy: tek owner (geriye uyumlu)
  TURNSTILE_SECRET?: string; // optional bot protection
  PUBLIC_BASE_URL?: string; // override e.g. 'https://lutke.app'
  GOOGLE_CLIENT_ID?: string; // Google OAuth — sign-in with Google
}

export function jsonResponse(
  data: unknown,
  status: number = 200,
  extraHeaders: Record<string, string> = {},
): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Cache-Control": "no-store",
      ...extraHeaders,
    },
  });
}

export function errorResponse(
  message: string,
  status: number = 400,
  code?: string,
): Response {
  return jsonResponse({ error: message, code }, status);
}

// Gövde boyutu üst sınırı — auth istekleri küçüktür; dev gövdelerle
// CPU/bellek harcatmayı engelle.
const MAX_BODY_BYTES = 64 * 1024;

export async function readJson<T = Record<string, unknown>>(
  request: Request,
): Promise<T | null> {
  try {
    const text = await request.text();
    if (!text || text.length > MAX_BODY_BYTES) return null;
    return JSON.parse(text) as T;
  } catch {
    return null;
  }
}

/**
 * Hash an IP for privacy (not for security — just to avoid storing raw IPs).
 * Uses SHA-256 truncated to 12 bytes (24 hex chars).
 */
export async function hashIp(ip: string): Promise<string> {
  const data = new TextEncoder().encode(ip);
  const buf = await crypto.subtle.digest("SHA-256", data);
  const arr = new Uint8Array(buf);
  return Array.from(arr.slice(0, 12))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

export function getClientIp(request: Request): string {
  return (
    request.headers.get("CF-Connecting-IP") ??
    request.headers.get("X-Forwarded-For")?.split(",")[0].trim() ??
    "unknown"
  );
}

/**
 * Generate cryptographically random token (hex string).
 * Default: 32 bytes → 64-char hex.
 */
export function generateToken(byteLen: number = 32): string {
  const bytes = crypto.getRandomValues(new Uint8Array(byteLen));
  return Array.from(bytes)
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

/**
 * Generate a UUID v4.
 */
export function generateUuid(): string {
  // Cloudflare Workers expose crypto.randomUUID()
  if (typeof crypto.randomUUID === "function") {
    return crypto.randomUUID();
  }
  // Fallback: build manually
  const bytes = crypto.getRandomValues(new Uint8Array(16));
  bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
  bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant
  const hex = Array.from(bytes)
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
  return `${hex.slice(0, 8)}-${hex.slice(8, 12)}-${hex.slice(12, 16)}-${hex.slice(16, 20)}-${hex.slice(20, 32)}`;
}

// ─── Email validation ────────────────────────────────────────

/** RFC-5322 lite — common case validation. */
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export function isValidEmail(email: string): boolean {
  const t = email.trim();
  // RFC 5321: adres toplamda 254 karakteri aşamaz.
  return t.length <= 254 && EMAIL_RE.test(t);
}

// ─── Rate limit (D1 `rate_limit` tablosu) ────────────────────
// Sabit pencere sayacı. Bucket örn: "login:<ipHash>:<email>".
// Tek UPSERT ile atomik: pencere dolduysa sayaç sıfırlanır.
// Hata durumunda FAIL-OPEN (izin ver) — rate limit, auth'u
// kullanılamaz hâle getirmemeli.

export async function checkRateLimit(
  db: D1Database,
  bucket: string,
  limit: number,
  windowMs: number,
): Promise<boolean> {
  try {
    const now = Date.now();
    const row = await db
      .prepare(
        `INSERT INTO rate_limit (bucket, count, reset_at) VALUES (?1, 1, ?2)
         ON CONFLICT(bucket) DO UPDATE SET
           count    = CASE WHEN rate_limit.reset_at <= ?3 THEN 1 ELSE rate_limit.count + 1 END,
           reset_at = CASE WHEN rate_limit.reset_at <= ?3 THEN ?2 ELSE rate_limit.reset_at END
         RETURNING count`,
      )
      .bind(bucket, now + windowMs, now)
      .first<{ count: number }>();

    // Fırsatçı temizlik: süresi geçmiş bucket'ları ara sıra sil.
    if (Math.random() < 0.02) {
      await db
        .prepare("DELETE FROM rate_limit WHERE reset_at <= ?")
        .bind(now)
        .run();
    }

    if (!row) return true; // beklenmedik — fail-open
    return row.count <= limit;
  } catch (e) {
    console.error("[rate-limit] hata (fail-open):", e);
    return true;
  }
}

// ─── Owner check ─────────────────────────────────────────────
// Yönetici: y.mutlu@alparslan.edu.tr
// Override: env.OWNER_EMAILS (virgüllü liste). Legacy env.OWNER_EMAIL hala desteklenir.

const DEFAULT_OWNER_EMAILS = [
  "y.mutlu@alparslan.edu.tr",
];

export function getOwnerEmails(env: Env): string[] {
  const raw = env.OWNER_EMAILS ?? env.OWNER_EMAIL ?? "";
  const list = raw
    .split(",")
    .map((e) => e.toLowerCase().trim())
    .filter((e) => e.length > 0 && e.includes("@"));
  return list.length > 0 ? list : DEFAULT_OWNER_EMAILS;
}

export function isOwnerEmail(email: string, env: Env): boolean {
  const normalized = email.toLowerCase().trim();
  return getOwnerEmails(env).includes(normalized);
}

// ─── Auth from Bearer header ─────────────────────────────────

/**
 * Şifre sürümü: tuzun SHA-256 özetinin ilk 16 hanesi. Tuz her şifre
 * değişikliğinde (hashPassword) yeniden üretildiği için, şifre sıfırlanınca
 * sürüm değişir ve eski belirteçler geçersiz kalır. Tuzun kendisi
 * belirtece yazılmaz.
 */
export async function passwordVersion(salt: string): Promise<string> {
  const buf = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(salt));
  return Array.from(new Uint8Array(buf).slice(0, 8))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

/**
 * Bearer belirtecini doğrular ve oturumu veritabanındaki GÜNCEL satıra bağlar
 * (Ekim 2026):
 *   - hesap silinmişse oturum yoktur;
 *   - belirteçteki şifre sürümü satırdakiyle uyuşmuyorsa (şifre sıfırlandı)
 *     oturum yoktur — eskiden çalınan bir oturum şifre değişse de 30 gün
 *     geçerli kalıyordu;
 *   - sahip yetkisi belirteçteki iddiadan değil satırdaki is_owner'dan okunur;
 *     kaldırılan yetki hemen düşer.
 * Veritabanı hatasında oturum verilmez (kapalı başarısızlık).
 */
export async function getAuthFromRequest(
  request: Request,
  env: Env,
): Promise<{ userId: string; email: string; isOwner: boolean } | null> {
  const auth = request.headers.get("Authorization");
  if (!auth || !auth.startsWith("Bearer ")) return null;
  const token = auth.substring(7).trim();
  if (!token) return null;

  const { verifyJWT } = await import("./jwt");
  const payload = await verifyJWT(token, env.JWT_SECRET);
  if (!payload) return null;

  try {
    const row = await env.DB
      .prepare(
        "SELECT id, email, is_owner, password_salt FROM users WHERE id = ? AND deleted_at IS NULL LIMIT 1",
      )
      .bind(payload.sub)
      .first<{ id: string; email: string; is_owner: number; password_salt: string }>();
    if (!row) return null;
    if (payload.pv !== undefined && payload.pv !== (await passwordVersion(row.password_salt))) {
      return null;
    }
    return { userId: row.id, email: row.email, isOwner: row.is_owner === 1 };
  } catch (e) {
    console.error("[auth] oturum satırı okunamadı:", e);
    return null;
  }
}

// ─── Public base URL (for verification links) ────────────────

export function getPublicBaseUrl(env: Env, request: Request): string {
  if (env.PUBLIC_BASE_URL) return env.PUBLIC_BASE_URL.replace(/\/$/, "");
  // Fall back to request origin
  const url = new URL(request.url);
  return `${url.protocol}//${url.host}`;
}
