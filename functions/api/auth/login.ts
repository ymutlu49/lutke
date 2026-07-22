// LÛTKE — POST /api/auth/login
//
// Body: { email, password }
// Returns: 200 { user, token } | 401 invalid_credentials | 429 rate_limited
//
// GÜVENLİK (Tem 2026):
//   - Kullanıcı bulunamadığında da PBKDF2 çalışır (dummy hash) — yanıt
//     süresi hesap var/yok bilgisini sızdırmasın (timing enumeration).
//   - Çift kova rate limit: IP+e-posta 20/15dk (hedefli bruteforce) +
//     IP-global 150/15dk (credential stuffing / yatay tarama).
//   - Owner muafiyeti korunur; is_owner bayrağı artık yalnız mailbox
//     kanıtından sonra verildiği için (bkz. signup.ts) muafiyet güvenlidir.

import {
  checkRateLimit,
  errorResponse,
  hashIp,
  getClientIp,
  isValidEmail,
  jsonResponse,
  readJson,
  type Env,
} from "../../lib/http";
import {
  findUserByEmail,
  logLoginAttempt,
  updateLastLogin,
} from "../../lib/db";
import { verifyPassword } from "../../lib/password";
import { signJWT } from "../../lib/jwt";

interface LoginBody {
  email: string;
  password: string;
}

// Timing eşitleme için sabit dummy hash/salt (64 hex karakter).
// verifyPassword bununla da tam bir PBKDF2 türetmesi yapar; sonuç her
// zaman false'tur ve yanıt "kullanıcı yok" yolunda da aynı sürede döner.
const DUMMY_HASH = "0".repeat(64);
const DUMMY_SALT = "f".repeat(64);

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const body = await readJson<LoginBody>(request);
  if (!body)
    return errorResponse("Geçersiz istek gövdesi.", 400, "invalid_body");

  const email = (body.email ?? "").toString().toLowerCase().trim();
  const password = (body.password ?? "").toString();

  if (!isValidEmail(email))
    return errorResponse("Geçerli bir e-posta gir.", 400, "invalid_email");

  const ipHash = await hashIp(getClientIp(request));
  const ua = request.headers.get("User-Agent");

  // Rate limit — çift kova (request-password-reset.ts ile aynı desen):
  //   1) IP-global 150/15dk: tek IP'nin FARKLI e-postalara yatay deneme
  //      yapmasını sınırlar (credential stuffing). IP+e-posta kovası tek
  //      başına bunu ENGELLEMİYORDU — her e-posta ayrı 20'lik bütçe açıyordu.
  //      Limit, NAT arkasındaki kampüs/okul Wi-Fi'ının aynı IP'den meşru
  //      yoğun girişini (ör. ders anında ~50 öğrenci) kesmeyecek kadar bol.
  //   2) IP+e-posta 20/15dk: hedefli bruteforce; saldırgan kendi IP'sinden
  //      kurbanın login'ini kilitleyemez.
  // Kısa devre: global kova dolduysa IP+e-posta kovası artırılmaz.
  const ipOk = await checkRateLimit(
    env.DB,
    `login-ip:${ipHash}`,
    150,
    15 * 60 * 1000,
  );
  const pairOk =
    ipOk &&
    (await checkRateLimit(
      env.DB,
      `login:${ipHash}:${email}`,
      20,
      15 * 60 * 1000,
    ));
  if (!pairOk) {
    await logLoginAttempt(env.DB, email, null, false, "rate_limited", ipHash, ua);
    return errorResponse(
      "Çok fazla deneme. Biraz bekleyip tekrar dene.",
      429,
      "rate_limited",
    );
  }

  // Look up
  const user = await findUserByEmail(env.DB, email);
  if (!user) {
    // Dummy PBKDF2 — süre farkından hesap varlığı anlaşılmasın.
    await verifyPassword(password, DUMMY_HASH, DUMMY_SALT);
    await logLoginAttempt(env.DB, email, null, false, "no_user", ipHash, ua);
    // Aynı mesaj — email enumeration'ı önlemek için.
    return errorResponse(
      "E-posta veya şifre hatalı.",
      401,
      "invalid_credentials",
    );
  }

  // Verify password
  const ok = await verifyPassword(password, user.password_hash, user.password_salt);
  if (!ok) {
    await logLoginAttempt(
      env.DB,
      email,
      user.id,
      false,
      "wrong_password",
      ipHash,
      ua,
    );
    return errorResponse(
      "E-posta veya şifre hatalı.",
      401,
      "invalid_credentials",
    );
  }

  // Email doğrulama gate'i — verified değilse giriş engellenir.
  // Owner hesapları muaf (admin'in app'e her zaman erişebilmesi için).
  // NOT: is_owner yalnız mailbox kanıtı sonrası verildiği için bu muafiyet
  // doğrulanmamış sahte "owner" hesaplarına uygulanamaz.
  if (user.email_verified !== 1 && user.is_owner !== 1) {
    await logLoginAttempt(env.DB, email, user.id, false, "unverified", ipHash, ua);
    return errorResponse(
      "E-postanı doğrulaman gerekiyor. Inboxa kontrol bike.",
      403,
      "email_not_verified",
    );
  }

  // Update last login + audit
  await updateLastLogin(env.DB, user.id);
  await logLoginAttempt(env.DB, email, user.id, true, "ok", ipHash, ua);

  // Issue JWT
  const token = await signJWT(
    {
      sub: user.id,
      email: user.email,
      isOwner: user.is_owner === 1,
      emailVerified: user.email_verified === 1,
    },
    env.JWT_SECRET,
  );

  return jsonResponse({
    user: {
      id: user.id,
      email: user.email,
      displayName: user.display_name,
      emailVerified: user.email_verified === 1,
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
