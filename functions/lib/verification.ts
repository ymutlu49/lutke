// LÛTKE — Doğrulama e-postası üretimi (ortak yardımcı).
//
// Yeni bir verify_email belirteci üretir ve doğrulama e-postasını gönderir.
// Var olan belirteçlere dokunmaz: kullanıcının elindeki eski bağlantı da
// (süresi dolmadıysa) çalışmaya devam eder.

import { generateToken, getPublicBaseUrl, type Env } from "./http";
import { createToken, type UserRow } from "./db";
import { sendEmail, verificationEmailTemplate } from "./email";

const VERIFY_TTL_MS = 24 * 60 * 60 * 1000; // 24 saat

export async function sendVerificationEmail(
  env: Env,
  request: Request,
  user: Pick<UserRow, "id" | "email" | "display_name">,
): Promise<{ ok: boolean; error?: string }> {
  const token = generateToken(32);
  await createToken(
    env.DB,
    token,
    user.id,
    "verify_email",
    Date.now() + VERIFY_TTL_MS,
  );
  const verifyUrl = `${getPublicBaseUrl(env, request)}/auth/verify-email?token=${token}`;
  const tpl = verificationEmailTemplate({
    displayName: user.display_name ?? user.email.split("@")[0],
    verifyUrl,
  });
  return sendEmail(env, {
    to: user.email,
    subject: tpl.subject,
    htmlBody: tpl.html,
    textBody: tpl.text,
  });
}
