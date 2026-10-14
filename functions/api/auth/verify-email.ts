// LÛTKE — Email verification endpoint.
//
// POST /api/auth/verify-email   Body: { token }
//   → Doğrulama mantığı burada. Frontend Dart bunu çağırır.
//
// GET  /api/auth/verify-email?token=...
//   → E-postada gelen tıklanabilir link. DB değişikliği yapmaz; sadece
//     token'ı koruyarak Flutter SPA route'una redirect eder.
//     Flutter ekranı kendisi POST eder ve sonucu UI'da gösterir.
//
// GÜVENLİK (Tem 2026):
//   - IP başına 30 deneme / 15 dk rate limit (token tarama koruması;
//     token 32-byte random olduğu için tarama zaten pratik değil).
//   - Owner terfisi: mailbox kanıtı burada gerçekleşir. Owner listesindeki
//     e-posta doğrulanınca is_owner=1 verilir (signup'ta verilmez —
//     bkz. signup.ts).

import {
  checkRateLimit,
  errorResponse,
  hashIp,
  getClientIp,
  isOwnerEmail,
  jsonResponse,
  readJson,
  type Env,
} from "../../lib/http";
import { findToken, findUserById, markEmailVerified, markTokenUsed } from "../../lib/db";

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const ipHash = await hashIp(getClientIp(request));
  if (!(await checkRateLimit(env.DB, `verify:${ipHash}`, 30, 15 * 60 * 1000))) {
    return errorResponse(
      "Çok fazla deneme. Biraz sonra tekrar dene.",
      429,
      "rate_limited",
    );
  }

  const body = await readJson<{ token: string }>(request);
  const token =
    typeof body?.token === "string" && body.token.length > 0 && body.token.length <= 128
      ? body.token
      : null;

  if (!token) {
    return errorResponse("Token eksik.", 400, "token_missing");
  }
  const row = await findToken(env.DB, token, "verify_email");
  if (!row) {
    // Aynı bağlantıya ikinci tıklama (ya da bağlantıyı önceden açan e-posta
    // tarayıcısı): belirteç kullanılmış ve hesap doğrulanmışsa bu bir hata
    // değildir. Eskiden "Token geçersiz" dönüyordu; kullanıcı hesabı
    // doğrulanmış olduğu hâlde "doğrulama başarısız" ekranını görüyordu.
    const used = await env.DB
      .prepare(
        `SELECT user_id FROM auth_tokens
         WHERE token = ? AND type = 'verify_email' AND used_at IS NOT NULL
         LIMIT 1`,
      )
      .bind(token)
      .first<{ user_id: string }>();
    if (used) {
      const owner = await findUserById(env.DB, used.user_id);
      if (owner && owner.email_verified === 1) {
        return jsonResponse({ ok: true, alreadyVerified: true });
      }
    }
    return errorResponse(
      "Token geçersiz veya süresi dolmuş.",
      400,
      "token_invalid",
    );
  }

  const user = await findUserById(env.DB, row.user_id);
  if (!user) {
    return errorResponse("Kullanıcı bulunamadı.", 404, "user_not_found");
  }

  await markEmailVerified(env.DB, row.user_id);
  await markTokenUsed(env.DB, token);

  // Owner terfisi — e-posta sahipliği kanıtlandı. (db.ts başka ajanın
  // dosyası olduğu için helper yerine inline SQL.)
  if (isOwnerEmail(user.email, env) && user.is_owner !== 1) {
    await env.DB
      .prepare("UPDATE users SET is_owner = 1, updated_at = ? WHERE id = ?")
      .bind(Date.now(), user.id)
      .run();
  }

  return jsonResponse({ ok: true, email: user.email });
};

export const onRequestGet: PagesFunction<Env> = async ({ request }) => {
  // GET = e-posta linkinden geliş. Token'ı SPA route'una taşı,
  // doğrulamayı Flutter EmailVerificationScreen yapsın.
  const url = new URL(request.url);
  const token = url.searchParams.get("token") ?? "";
  const target = token
    ? `${url.origin}/auth/verify-email?token=${encodeURIComponent(token)}`
    : `${url.origin}/auth/verify-email`;
  return Response.redirect(target, 302);
};
