// LÛTKE — POST /api/auth/resend-verification
// Bearer token gerekir. Yeni verification token üretir + email gönderir.
// Eski kullanılmamış token'lar silinir.

import {
  checkRateLimit,
  errorResponse,
  generateToken,
  getAuthFromRequest,
  getPublicBaseUrl,
  jsonResponse,
  type Env,
} from "../../lib/http";
import { createToken, deleteOldTokensForUser, findUserById } from "../../lib/db";
import { sendEmail, verificationEmailTemplate } from "../../lib/email";

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth) return errorResponse("Oturum yok.", 401, "unauthorized");

  // Rate limit — kullanıcı başına 5 istek / 15 dk (mail kotası koruması).
  if (
    !(await checkRateLimit(env.DB, `resend:${auth.userId}`, 5, 15 * 60 * 1000))
  ) {
    return errorResponse(
      "Çok fazla istek. Biraz sonra tekrar dene.",
      429,
      "rate_limited",
    );
  }

  const user = await findUserById(env.DB, auth.userId);
  if (!user) return errorResponse("Kullanıcı bulunamadı.", 404, "not_found");

  if (user.email_verified === 1)
    return jsonResponse({ ok: true, alreadyVerified: true });

  // Eski token'ları temizle
  await deleteOldTokensForUser(env.DB, user.id, "verify_email");

  // Yeni token
  const token = generateToken(32);
  const expiresAt = Date.now() + 24 * 60 * 60 * 1000;
  await createToken(env.DB, token, user.id, "verify_email", expiresAt);

  // BUG FIX (Mayıs 2026): /api/auth/... API endpoint'i; kullanıcı linki
  // tıkladığında SPA route'una düşmesi lazım — /auth/verify-email.
  const verifyUrl = `${getPublicBaseUrl(env, request)}/auth/verify-email?token=${token}`;
  const tpl = verificationEmailTemplate({
    displayName: user.display_name ?? user.email.split("@")[0],
    verifyUrl,
  });

  const result = await sendEmail(env, {
    to: user.email,
    subject: tpl.subject,
    htmlBody: tpl.html,
    textBody: tpl.text,
  });

  if (!result.ok) {
    return errorResponse(
      "E-posta gönderilemedi. Daha sonra tekrar dene.",
      500,
      "email_failed",
    );
  }

  return jsonResponse({ ok: true });
};
