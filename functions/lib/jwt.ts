// LÛTKE — JWT signing/verification using HMAC-SHA256.
//
// Stateless session tokens. Stored client-side (localStorage on Flutter web).
// Secret: env.JWT_SECRET (set via `wrangler pages secret put JWT_SECRET`).

const enc = new TextEncoder();

interface JWTPayload {
  sub: string; // user id
  email: string;
  isOwner?: boolean;
  emailVerified?: boolean;
  /// Şifre sürümü — bkz. http.ts passwordVersion. Ekim 2026 öncesi
  /// belirteçlerde yoktur (süreleri dolana dek geçerli sayılır).
  pv?: string;
  iat: number; // issued at (sec)
  exp: number; // expires at (sec)
}

function base64UrlEncode(bytes: Uint8Array | string): string {
  const b = typeof bytes === "string" ? enc.encode(bytes) : bytes;
  let str = "";
  b.forEach((byte) => {
    str += String.fromCharCode(byte);
  });
  return btoa(str)
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

function base64UrlDecode(str: string): Uint8Array {
  const padded =
    str.replace(/-/g, "+").replace(/_/g, "/") +
    "=".repeat((4 - (str.length % 4)) % 4);
  const bin = atob(padded);
  const bytes = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
  return bytes;
}

async function getKey(secret: string): Promise<CryptoKey> {
  return await crypto.subtle.importKey(
    "raw",
    enc.encode(secret),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign", "verify"],
  );
}

/**
 * Sign a JWT (HS256). `secret` must be a stable random string set as env var.
 * `payloadIn` must NOT include iat/exp — we set them.
 */
export async function signJWT(
  payloadIn: Omit<JWTPayload, "iat" | "exp">,
  secret: string,
  expiresInSec: number = 60 * 60 * 24 * 30, // 30 days
): Promise<string> {
  // GÜVENLİK: secret yoksa TextEncoder "undefined" string'ini encode eder
  // ve token tahmin edilebilir bir anahtarla imzalanırdı. Açıkça patlat.
  if (!secret) throw new Error("JWT_SECRET tanımlı değil.");
  const now = Math.floor(Date.now() / 1000);
  const payload: JWTPayload = {
    ...payloadIn,
    iat: now,
    exp: now + expiresInSec,
  };

  const header = { alg: "HS256", typ: "JWT" };
  const encHeader = base64UrlEncode(JSON.stringify(header));
  const encPayload = base64UrlEncode(JSON.stringify(payload));
  const data = `${encHeader}.${encPayload}`;

  const key = await getKey(secret);
  const sig = await crypto.subtle.sign("HMAC", key, enc.encode(data));
  const encSig = base64UrlEncode(new Uint8Array(sig));

  return `${data}.${encSig}`;
}

/**
 * Verify and decode a JWT. Returns payload if valid, null otherwise.
 */
export async function verifyJWT(
  token: string,
  secret: string,
): Promise<JWTPayload | null> {
  try {
    if (!secret || !token) return null;
    const parts = token.split(".");
    if (parts.length !== 3) return null;
    const [encHeader, encPayload, encSig] = parts;

    // Header'ı doğrula: yalnızca HS256 kabul edilir (alg-confusion önlemi;
    // imza zaten hep HMAC ile doğrulanıyor ama erken red daha ucuz + net).
    const header = JSON.parse(
      new TextDecoder().decode(base64UrlDecode(encHeader)),
    ) as { alg?: string };
    if (header.alg !== "HS256") return null;

    const data = `${encHeader}.${encPayload}`;
    const key = await getKey(secret);
    const sig = base64UrlDecode(encSig);
    // Cast Uint8Array to BufferSource via .buffer
    const sigBuf = sig.buffer.slice(
      sig.byteOffset,
      sig.byteOffset + sig.byteLength,
    ) as ArrayBuffer;
    const valid = await crypto.subtle.verify(
      "HMAC",
      key,
      sigBuf,
      enc.encode(data),
    );
    if (!valid) return null;

    const payloadJson = new TextDecoder().decode(base64UrlDecode(encPayload));
    const payload = JSON.parse(payloadJson) as JWTPayload;

    if (typeof payload.exp !== "number") return null;
    if (payload.exp < Math.floor(Date.now() / 1000)) return null;
    if (typeof payload.sub !== "string" || payload.sub.length === 0) return null;

    return payload;
  } catch {
    return null;
  }
}

export type { JWTPayload };
