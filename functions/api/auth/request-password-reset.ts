// LÛTKE — POST /api/auth/request-password-reset
// Body: { email }
// Always returns 200 (no email enumeration).
// If email exists: token + email gönderilir.
//
// GÜVENLİK (Tem 2026):
//   - Kullanıcı araması + token + e-posta gönderimi waitUntil ile arka
//     plana alındı: yanıt süresi hesabın var olup olmamasından bağımsız
//     (timing enumeration önlemi) ve istek hızlı döner.
//   - Rate limit: IP başına 15/saat + IP+e-posta başına 3/saat. Limit
//     aşımında da 200 {ok:true} döner (sözleşme ve enumeration koruması
//     aynen korunur; sadece iş yapılmaz).

import {
  checkRateLimit,
  generateToken,
  getPublicBaseUrl,
  hashIp,
  getClientIp,
  isValidEmail,
  jsonResponse,
  readJson,
  type Env,
} from "../../lib/http";
import {
  createToken,
  deleteOldTokensForUser,
  findUserByEmail,
} from "../../lib/db";
import { sendEmail, passwordResetEmailTemplate } from "../../lib/email";

export const onRequestPost: PagesFunction<Env> = async (context) => {
  const { request, env } = context;
  const body = await readJson<{ email: string }>(request);
  const email = (body?.email ?? "").toString().toLowerCase().trim();

  // Her durumda 200 dönüyoruz — email enumeration koruması.
  // (Hata durumunda da kullanıcıya "If account exists, email sent" mesajı.)
  if (!isValidEmail(email)) {
    return jsonResponse({ ok: true });
  }

  const ipHash = await hashIp(getClientIp(request));
  const ipOk = await checkRateLimit(
    env.DB,
    `pwreset-ip:${ipHash}`,
    15,
    60 * 60 * 1000,
  );
  const pairOk =
    ipOk &&
    (await checkRateLimit(
      env.DB,
      `pwreset:${ipHash}:${email}`,
      3,
      60 * 60 * 1000,
    ));
  if (!ipOk || !pairOk) {
    return jsonResponse({ ok: true }); // sessizce yut — sözleşme aynı
  }

  // Asıl iş arka planda — yanıt beklemez.
  context.waitUntil(
    (async () => {
      try {
        const user = await findUserByEmail(env.DB, email);
        if (!user) return;

        await deleteOldTokensForUser(env.DB, user.id, "reset_password");

        const token = generateToken(32);
        const expiresAt = Date.now() + 60 * 60 * 1000; // 1 hour
        await createToken(env.DB, token, user.id, "reset_password", expiresAt);

        const resetUrl = `${getPublicBaseUrl(env, request)}/reset-password?token=${token}`;
        const tpl = passwordResetEmailTemplate({
          displayName: user.display_name ?? user.email.split("@")[0],
          resetUrl,
        });

        const result = await sendEmail(env, {
          to: user.email,
          subject: tpl.subject,
          htmlBody: tpl.html,
          textBody: tpl.text,
        });
        if (!result.ok) {
          console.error("[pwreset] e-posta gönderilemedi:", result.error);
        }
      } catch (e) {
        console.error("[pwreset] arka plan hatası:", e);
      }
    })(),
  );

  return jsonResponse({ ok: true });
};
