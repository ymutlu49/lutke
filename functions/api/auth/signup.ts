// LÛTKE — POST /api/auth/signup
//
// Body: { email, password, displayName?, isHeritage?, currentLevel?, targetLevel?, dailyGoal? }
// Returns: 201 { user, token }
//          400 / 409 / 429 / 500 with { error, code }
//
// Side effects:
//   - User row created with email_verified=0
//   - Verification token (24h) created
//   - Email sent via Resend (fallback: MailChannels) with verification link
//
// GÜVENLİK (Tem 2026):
//   - is_owner artık signup'ta VERİLMEZ. Owner bayrağı e-posta sahipliği
//     kanıtlanınca verilir (verify-email / reset-password / Google login).
//     Aksi hâlde owner e-postasını bilen biri, doğrulanmamış hesapla
//     login'deki owner muafiyeti üzerinden yönetici yetkisi kazanabilirdi.
//   - IP başına rate limit (10 kayıt/saat).
//   - currentLevel/targetLevel whitelist, displayName uzunluk sınırı,
//     dailyGoal aralık sınırı.

import {
  checkRateLimit,
  errorResponse,
  generateToken,
  generateUuid,
  getPublicBaseUrl,
  hashIp,
  getClientIp,
  isValidEmail,
  jsonResponse,
  passwordVersion,
  readJson,
  type Env,
} from "../../lib/http";
import {
  createToken,
  createUser,
  findUserByEmail,
  logLoginAttempt,
} from "../../lib/db";
import { hashPassword, validatePassword } from "../../lib/password";
import { sendEmail, verificationEmailTemplate } from "../../lib/email";
import { signJWT } from "../../lib/jwt";

interface SignupBody {
  email: string;
  password: string;
  displayName?: string;
  isHeritage?: boolean;
  currentLevel?: string;
  targetLevel?: string;
  dailyGoal?: number;
}

// CEFR seviyeleri dışındaki değerler DB'ye yazılmasın.
const ALLOWED_LEVELS = new Set(["a1", "a2", "b1", "b2", "c1", "c2"]);

function sanitizeLevel(raw: unknown, fallback: string): string {
  const v = (raw ?? "").toString().toLowerCase().trim();
  return ALLOWED_LEVELS.has(v) ? v : fallback;
}

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const body = await readJson<SignupBody>(request);
  if (!body)
    return errorResponse("Geçersiz istek gövdesi.", 400, "invalid_body");

  const email = (body.email ?? "").toString().toLowerCase().trim();
  const password = (body.password ?? "").toString();
  // displayName: kontrol karakterlerini temizle + 60 karakterle sınırla
  // (e-posta şablonuna ve UI'ya giriyor).
  const displayName =
    (body.displayName ?? "")
      .toString()
      .replace(/[\u0000-\u001F\u007F]/g, " ")
      .trim()
      .slice(0, 60) || email.split("@")[0];

  if (!isValidEmail(email))
    return errorResponse("Geçerli bir e-posta gir.", 400, "invalid_email");

  const pwErr = validatePassword(password);
  if (pwErr) return errorResponse(pwErr, 400, "weak_password");

  // Rate limit — IP başına 10 kayıt / saat (bot koruması).
  const ipHash = await hashIp(getClientIp(request));
  if (!(await checkRateLimit(env.DB, `signup:${ipHash}`, 10, 60 * 60 * 1000))) {
    return errorResponse(
      "Çok fazla kayıt denemesi. Biraz sonra tekrar dene.",
      429,
      "rate_limited",
    );
  }

  // Email zaten kayıtlı mı?
  const existing = await findUserByEmail(env.DB, email);
  if (existing) {
    return errorResponse(
      "Bu e-posta zaten kayıtlı. Giriş yapmayı dene.",
      409,
      "email_taken",
    );
  }

  // Hash + insert
  const { hash, salt } = await hashPassword(password);
  const userId = generateUuid();

  try {
    await createUser(env.DB, {
      id: userId,
      email,
      passwordHash: hash,
      passwordSalt: salt,
      displayName,
      isOwner: false, // owner terfisi mailbox kanıtından sonra (bkz. üst yorum)
      currentLevel: sanitizeLevel(body.currentLevel, "a1"),
      targetLevel: sanitizeLevel(body.targetLevel, "b1"),
      isHeritage: !!body.isHeritage,
      dailyGoal:
        typeof body.dailyGoal === "number" && Number.isFinite(body.dailyGoal)
          ? Math.min(200, Math.max(1, Math.round(body.dailyGoal)))
          : 10,
    });
  } catch (e) {
    // Yarış durumu: findUserByEmail ile INSERT arasında aynı e-posta
    // kaydolduysa UNIQUE constraint patlar → 500 değil 409 dön.
    const msg = e instanceof Error ? e.message : String(e);
    if (msg.toUpperCase().includes("UNIQUE")) {
      return errorResponse(
        "Bu e-posta zaten kayıtlı. Giriş yapmayı dene.",
        409,
        "email_taken",
      );
    }
    return errorResponse(
      "Kayıt sırasında veritabanı hatası.",
      500,
      "db_error",
    );
  }

  // Verification token + e-posta. Kullanıcı satırı oluştu; buradaki bir hata
  // signup'ı 500'e düşürmesin (aksi hâlde retry 409'a çarpar). Başarısızsa
  // emailSent=false döner, UI "tekrar gönder" sunar.
  let emailSent = false;
  try {
    const verifyToken = generateToken(32);
    const expiresAt = Date.now() + 24 * 60 * 60 * 1000; // 24h
    await createToken(env.DB, verifyToken, userId, "verify_email", expiresAt);

    // BUG FIX (Mayıs 2026): URL Flutter SPA route'una uymalı.
    // /verify-email Flutter'da yok; /auth/verify-email var (AppRoutes.emailVerification).
    const verifyUrl = `${getPublicBaseUrl(env, request)}/auth/verify-email?token=${verifyToken}`;
    const tpl = verificationEmailTemplate({ displayName, verifyUrl });
    const emailResult = await sendEmail(env, {
      to: email,
      subject: tpl.subject,
      htmlBody: tpl.html,
      textBody: tpl.text,
    });
    emailSent = emailResult.ok;
    if (!emailResult.ok) {
      console.error("Verification email failed:", emailResult.error);
    }
  } catch (e) {
    console.error("Verification token/email hatası:", e);
  }

  // Audit (signup success)
  await logLoginAttempt(
    env.DB,
    email,
    userId,
    true,
    "signup",
    ipHash,
    request.headers.get("User-Agent"),
  );

  // JWT döndür → kullanıcı hemen giriş yapabilir (verified=false durumunda
  // app banner gösterecek). isOwner=false: terfi doğrulamadan sonra.
  const token = await signJWT(
    {
      sub: userId,
      email,
      isOwner: false,
      emailVerified: false,
      pv: await passwordVersion(salt),
    },
    env.JWT_SECRET,
  );

  return jsonResponse(
    {
      user: {
        id: userId,
        email,
        displayName,
        emailVerified: false,
        isOwner: false,
      },
      token,
      emailSent,
    },
    201,
  );
};
