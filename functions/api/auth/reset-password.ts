// LÛTKE — POST /api/auth/reset-password
// Body: { token, newPassword }
//
// GÜVENLİK (Tem 2026):
//   - IP başına 15 deneme / 15 dk rate limit.
//   - Başarılı reset sonrası kullanıcının diğer bekleyen reset token'ları
//     silinir (kullanılan token audit için used_at ile işaretli kalır).
//   - Reset linki e-posta kutusuna gittiği için başarı = mailbox kanıtı:
//     email_verified=1 yapılır. (Bu ayrıca "doğrulama mailini kaybeden
//     kullanıcı bir daha giremiyor" çıkmazını da çözer.)
//   - Owner listesindeki e-posta için owner terfisi (verify-email ile
//     aynı mantık — bkz. signup.ts).

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
import {
  deleteOldTokensForUser,
  findToken,
  findUserById,
  markEmailVerified,
  markTokenUsed,
  updatePassword,
} from "../../lib/db";
import { hashPassword, validatePassword } from "../../lib/password";

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const ipHash = await hashIp(getClientIp(request));
  if (
    !(await checkRateLimit(env.DB, `pwconfirm:${ipHash}`, 15, 15 * 60 * 1000))
  ) {
    return errorResponse(
      "Çok fazla deneme. Biraz sonra tekrar dene.",
      429,
      "rate_limited",
    );
  }

  const body = await readJson<{ token: string; newPassword: string }>(request);
  const token =
    typeof body?.token === "string" && body.token.length > 0 && body.token.length <= 128
      ? body.token
      : "";
  const newPassword = (body?.newPassword ?? "").toString();
  if (!token || !newPassword)
    return errorResponse("Token ve yeni şifre gerekli.", 400, "invalid_body");

  const pwErr = validatePassword(newPassword);
  if (pwErr) return errorResponse(pwErr, 400, "weak_password");

  const tokenRow = await findToken(env.DB, token, "reset_password");
  if (!tokenRow)
    return errorResponse(
      "Token geçersiz veya süresi dolmuş.",
      400,
      "invalid_token",
    );

  const user = await findUserById(env.DB, tokenRow.user_id);
  if (!user) return errorResponse("Kullanıcı bulunamadı.", 404, "not_found");

  const { hash, salt } = await hashPassword(newPassword);
  await updatePassword(env.DB, user.id, hash, salt);
  await markTokenUsed(env.DB, token);

  // Kalan kullanılmamış reset token'larını iptal et (tek geçerli link).
  await deleteOldTokensForUser(env.DB, user.id, "reset_password");

  // Mailbox kanıtı: reset linki e-postaya gitti → e-posta doğrulanmış say.
  if (user.email_verified !== 1) {
    await markEmailVerified(env.DB, user.id);
  }

  // Owner terfisi — e-posta sahipliği kanıtlandı. (db.ts başka ajanın
  // dosyası olduğu için helper yerine inline SQL.)
  if (isOwnerEmail(user.email, env) && user.is_owner !== 1) {
    await env.DB
      .prepare("UPDATE users SET is_owner = 1, updated_at = ? WHERE id = ?")
      .bind(Date.now(), user.id)
      .run();
  }

  return jsonResponse({ ok: true });
};
