// LÛTKE — POST /api/auth/google
//
// Body: { idToken }
// Returns: 200 { user, token }
//          400/401 with { error, code }
//
// Flow:
//   1. Frontend gets ID token from Google Identity Services (GIS)
//   2. POSTs it here
//   3. We verify via Google's tokeninfo endpoint (validates sig + audience)
//   4. Find user by google_id → login. Else by email → link Google to existing.
//      Else create a new Google-native user (email_verified=1).
//   5. Issue JWT.

import {
  errorResponse,
  generateToken,
  generateUuid,
  hashIp,
  getClientIp,
  isOwnerEmail,
  jsonResponse,
  readJson,
  type Env,
} from "../../lib/http";
import {
  createGoogleUser,
  findUserByEmail,
  findUserByGoogleId,
  linkGoogleId,
  logLoginAttempt,
  updateLastLogin,
} from "../../lib/db";
import { hashPassword } from "../../lib/password";
import { signJWT } from "../../lib/jwt";

interface GoogleBody {
  idToken: string;
}

interface GoogleTokenInfo {
  // https://developers.google.com/identity/sign-in/web/backend-auth
  iss: string;       // "https://accounts.google.com" or "accounts.google.com"
  aud: string;       // OAuth client ID — must match GOOGLE_CLIENT_ID
  sub: string;       // Stable Google user ID
  email: string;
  email_verified: string | boolean;
  name?: string;
  given_name?: string;
  family_name?: string;
  picture?: string;
  exp: string | number;
}

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  if (!env.GOOGLE_CLIENT_ID) {
    return errorResponse(
      "Google Sign-In yapılandırılmamış (GOOGLE_CLIENT_ID env yok).",
      500,
      "google_not_configured",
    );
  }

  const body = await readJson<GoogleBody>(request);
  if (!body?.idToken) {
    return errorResponse("ID token gerekli.", 400, "invalid_body");
  }

  // ─── Verify ID token via Google tokeninfo endpoint ───────
  // Google validates signature + expiry; we still must verify aud + iss + exp.
  let info: GoogleTokenInfo;
  try {
    const r = await fetch(
      `https://oauth2.googleapis.com/tokeninfo?id_token=${encodeURIComponent(body.idToken)}`,
    );
    if (!r.ok) {
      return errorResponse(
        "Google token doğrulanamadı.",
        401,
        "invalid_id_token",
      );
    }
    info = (await r.json()) as GoogleTokenInfo;
  } catch (_e) {
    return errorResponse(
      "Google ile bağlantı kurulamadı.",
      502,
      "google_unreachable",
    );
  }

  // Audience: must match our client ID exactly (CSRF protection).
  if (info.aud !== env.GOOGLE_CLIENT_ID) {
    return errorResponse(
      "Token bu uygulamaya ait değil.",
      401,
      "wrong_audience",
    );
  }
  // Issuer must be Google.
  if (info.iss !== "https://accounts.google.com" && info.iss !== "accounts.google.com") {
    return errorResponse(
      "Geçersiz token kaynağı.",
      401,
      "wrong_issuer",
    );
  }
  // Not expired.
  const expSec = typeof info.exp === "string" ? parseInt(info.exp, 10) : info.exp;
  if (!expSec || expSec * 1000 < Date.now()) {
    return errorResponse("Token süresi dolmuş.", 401, "id_token_expired");
  }
  // Email must be verified by Google.
  const emailVerified =
    info.email_verified === true || info.email_verified === "true";
  if (!emailVerified) {
    return errorResponse(
      "Google hesabının e-postası doğrulanmamış.",
      401,
      "google_email_unverified",
    );
  }
  if (!info.email || !info.sub) {
    return errorResponse("Eksik token verisi.", 401, "incomplete_token");
  }

  const email = info.email.toLowerCase().trim();
  const googleId = info.sub;
  const displayName =
    (info.name?.trim()) ||
    info.given_name?.trim() ||
    email.split("@")[0];
  const isOwner = isOwnerEmail(email, env);
  const ipHash = await hashIp(getClientIp(request));
  const ua = request.headers.get("User-Agent");

  // ─── 1) Existing user with this google_id? Just log them in. ───
  let user = await findUserByGoogleId(env.DB, googleId);

  // ─── 2) Otherwise, find by email and link Google to that account ──
  if (!user) {
    const byEmail = await findUserByEmail(env.DB, email);
    if (byEmail) {
      await linkGoogleId(env.DB, byEmail.id, googleId);
      user = { ...byEmail, google_id: googleId, email_verified: 1 };
    }
  }

  // ─── 3) New user — provision a Google-native account ──────
  if (!user) {
    const dummyPassword = generateToken(32); // 64 hex chars, never used for login
    const { hash, salt } = await hashPassword(dummyPassword);
    const userId = generateUuid();
    try {
      await createGoogleUser(env.DB, {
        id: userId,
        email,
        googleId,
        displayName,
        isOwner,
        dummyPasswordHash: hash,
        dummyPasswordSalt: salt,
      });
    } catch (_e) {
      return errorResponse(
        "Kayıt sırasında veritabanı hatası.",
        500,
        "db_error",
      );
    }
    // Re-read so we have the full row.
    user = await findUserByGoogleId(env.DB, googleId);
    if (!user) {
      return errorResponse("Kayıt oluşturuldu ama okunamadı.", 500, "db_error");
    }
  }

  // ─── Owner terfisi ───────────────────────────────────────
  // Google e-postayı doğruladı (mailbox kanıtı). Owner listesinde olup
  // bayrağı henüz verilmemiş hesabı burada terfi ettir. (Signup artık
  // is_owner'ı hemen set etmiyor — bkz. signup.ts. db.ts başka ajanın
  // dosyası olduğu için helper yerine inline SQL.)
  if (isOwner && user.is_owner !== 1) {
    await env.DB
      .prepare("UPDATE users SET is_owner = 1, updated_at = ? WHERE id = ?")
      .bind(Date.now(), user.id)
      .run();
    user = { ...user, is_owner: 1 };
  }

  // ─── Login bookkeeping + JWT ─────────────────────────────
  await updateLastLogin(env.DB, user.id);
  await logLoginAttempt(env.DB, email, user.id, true, "google_ok", ipHash, ua);

  const token = await signJWT(
    {
      sub: user.id,
      email: user.email,
      isOwner: user.is_owner === 1,
      emailVerified: true,
    },
    env.JWT_SECRET,
  );

  return jsonResponse({
    user: {
      id: user.id,
      email: user.email,
      displayName: user.display_name,
      emailVerified: true,
      isOwner: user.is_owner === 1,
      currentLevel: user.current_level,
      targetLevel: user.target_level,
      isHeritage: user.is_heritage === 1,
      dailyGoal: user.daily_goal,
      placementLevel: user.placement_level,
    },
    token,
  });
};
