// LÛTKE — Transactional email.
//
// Mayıs 2026: MailChannels 2024 ortasında Cloudflare Workers free tier'ını
// kapattı (artık API key + ücretli plan istiyor — 401 Unauthorized).
//
// Yeni primary: Resend (https://resend.com) — 3.000 mail/ay ücretsiz.
//   - RESEND_API_KEY env var setlenirse Resend kullanılır
//   - Setlenmemişse MailChannels fallback (legacy)
//
// Resend setup:
//   1. resend.com'da hesap aç + lutke.app domain ekle
//   2. Resend verdiği 3 TXT kaydı (SPF/DKIM/return-path) DNS'e ekle
//   3. "Verify Domain" → durumu Verified
//   4. API key oluştur → wrangler pages secret put RESEND_API_KEY

interface EmailOptions {
  to: string;
  subject: string;
  htmlBody: string;
  textBody: string;
}

interface EmailEnv {
  EMAIL_FROM: string; // e.g. "no-reply@lutke.app"
  EMAIL_FROM_NAME?: string; // e.g. "LÛTKE"
  // Resend (öncelikli)
  RESEND_API_KEY?: string;
  // MailChannels (legacy fallback — DKIM gerekir)
  MAILCHANNELS_DKIM_DOMAIN?: string;
  MAILCHANNELS_DKIM_SELECTOR?: string;
  MAILCHANNELS_DKIM_PRIVATE_KEY?: string;
  // Yerel geliştirme anahtarı (üretimde TANIMLI DEĞİL):
  //   "1"    → e-posta gönderilmez, metin gövdesi konsola yazılır (ok)
  //   "fail" → gönderim başarısız sayılır (hata yollarını denemek için)
  // Kullanım: wrangler pages dev dist --binding EMAIL_DRY_RUN=1
  EMAIL_DRY_RUN?: string;
}

export async function sendEmail(
  env: EmailEnv,
  opts: EmailOptions,
): Promise<{ ok: boolean; error?: string }> {
  const fromEmail = env.EMAIL_FROM ?? "no-reply@lutke.app";
  const fromName = env.EMAIL_FROM_NAME ?? "LÛTKE";

  if (env.EMAIL_DRY_RUN === "1") {
    console.log(
      `[mail/dry-run] -> ${opts.to} subject="${opts.subject}"\n${opts.textBody}`,
    );
    return { ok: true };
  }
  if (env.EMAIL_DRY_RUN === "fail") {
    console.log(`[mail/dry-run] FAIL -> ${opts.to} subject="${opts.subject}"`);
    return { ok: false, error: "EMAIL_DRY_RUN=fail" };
  }

  // Önce Resend dene (varsa)
  if (env.RESEND_API_KEY) {
    return sendViaResend(env.RESEND_API_KEY, fromEmail, fromName, opts);
  }

  // Fallback: MailChannels (DKIM şart)
  return sendViaMailChannels(env, fromEmail, fromName, opts);
}

/// RFC 2047: header'da non-ASCII karakter varsa encoded-word formatı kullan.
/// "LÛTKE" → "=?UTF-8?B?TMOOVEtF?=" — bu format tüm modern email client'lar
/// (Gmail, Outlook, Apple Mail, Thunderbird) tarafından düzgün decode edilir.
/// ASCII-only string'ler dokunulmadan döner.
function encodeMimeHeader(str: string): string {
  if (/^[\x00-\x7F]*$/.test(str)) return str;
  const utf8 = new TextEncoder().encode(str);
  let binary = "";
  for (let i = 0; i < utf8.length; i++) {
    binary += String.fromCharCode(utf8[i]);
  }
  return `=?UTF-8?B?${btoa(binary)}?=`;
}

async function sendViaResend(
  apiKey: string,
  fromEmail: string,
  fromName: string,
  opts: EmailOptions,
): Promise<{ ok: boolean; error?: string }> {
  console.log(`[mail/resend] -> ${opts.to} subject="${opts.subject}"`);
  try {
    const resp = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${apiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        from: `${encodeMimeHeader(fromName)} <${fromEmail}>`,
        to: [opts.to],
        subject: encodeMimeHeader(opts.subject),
        html: opts.htmlBody,
        text: opts.textBody,
      }),
    });
    if (!resp.ok) {
      const text = await resp.text();
      console.error(
        `[mail/resend] FAIL status=${resp.status} body=${text.slice(0, 500)}`,
      );
      return { ok: false, error: `Resend ${resp.status}: ${text}` };
    }
    console.log(`[mail/resend] OK status=${resp.status}`);
    return { ok: true };
  } catch (e) {
    console.error(`[mail/resend] EXCEPTION ${e}`);
    return { ok: false, error: `Resend network error: ${e}` };
  }
}

async function sendViaMailChannels(
  env: EmailEnv,
  fromEmail: string,
  fromName: string,
  opts: EmailOptions,
): Promise<{ ok: boolean; error?: string }> {
  const personalizations: Record<string, unknown>[] = [
    {
      to: [{ email: opts.to }],
      ...(env.MAILCHANNELS_DKIM_DOMAIN &&
      env.MAILCHANNELS_DKIM_SELECTOR &&
      env.MAILCHANNELS_DKIM_PRIVATE_KEY
        ? {
            dkim_domain: env.MAILCHANNELS_DKIM_DOMAIN,
            dkim_selector: env.MAILCHANNELS_DKIM_SELECTOR,
            dkim_private_key: env.MAILCHANNELS_DKIM_PRIVATE_KEY,
          }
        : {}),
    },
  ];

  const body = {
    personalizations,
    from: { email: fromEmail, name: fromName },
    subject: opts.subject,
    content: [
      { type: "text/plain", value: opts.textBody },
      { type: "text/html", value: opts.htmlBody },
    ],
  };

  console.log(`[mail/mc] -> ${opts.to} subject="${opts.subject}"`);
  try {
    const resp = await fetch("https://api.mailchannels.net/tx/v1/send", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    if (!resp.ok) {
      const text = await resp.text();
      console.error(
        `[mail/mc] FAIL status=${resp.status} body=${text.slice(0, 500)}`,
      );
      return { ok: false, error: `MailChannels ${resp.status}: ${text}` };
    }
    return { ok: true };
  } catch (e) {
    console.error(`[mail/mc] EXCEPTION ${e}`);
    return { ok: false, error: `Network error: ${e}` };
  }
}

// ═══ Email templates ═══

/// HTML injection önlemi: displayName kullanıcı girdisidir; HTML gövdeye
/// gömülmeden önce entity'lere çevrilir. (Metin gövdede escape gerekmez.)
function escapeHtml(s: string): string {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

export function verificationEmailTemplate(opts: {
  displayName: string;
  verifyUrl: string;
}): { html: string; text: string; subject: string } {
  const { displayName, verifyUrl } = opts;
  const safeName = escapeHtml(displayName);
  const subject = "LÛTKE — E-nava xwe piştrast bike · E-postanı doğrula";

  const html = `<!DOCTYPE html>
<html lang="ku">
<head><meta charset="utf-8"></head>
<body style="font-family: -apple-system, Segoe UI, Roboto, sans-serif; max-width: 560px; margin: 32px auto; color: #1A1A1A; line-height: 1.6;">
  <div style="background: linear-gradient(135deg, #1A7B6B, #0C5247); padding: 32px; text-align: center; border-radius: 12px 12px 0 0;">
    <h1 style="color: white; margin: 0; font-size: 28px; letter-spacing: 4px;">LÛTKE</h1>
    <p style="color: rgba(255,255,255,0.9); margin: 8px 0 0; font-style: italic;">Ji peyvekê heya welatekî</p>
  </div>
  <div style="background: white; padding: 32px; border-radius: 0 0 12px 12px; border: 1px solid #e5e5e5; border-top: none;">
    <h2 style="margin-top: 0;">Silav ${safeName},</h2>
    <p>Spas ku tu beşdarî LÛTKE bûyî. Ji bo ku hesabê te çalak bibe, ji kerema xwe li ser bişkoka jêrîn bitikîne:</p>
    <p style="font-size: 14px; color: #555;">LÛTKE'ye katıldığın için teşekkürler. Hesabını etkinleştirmek için aşağıdaki düğmeye tıkla:</p>
    <p style="text-align: center; margin: 32px 0;">
      <a href="${verifyUrl}" style="background: #1A7B6B; color: white; padding: 14px 28px; text-decoration: none; border-radius: 8px; font-weight: 700;">E-nava xwe piştrast bike · E-postanı doğrula</a>
    </p>
    <p style="font-size: 13px; color: #666;">An jî vê lînkê di geroka xwe de veke:<br><a href="${verifyUrl}" style="color: #1A7B6B; word-break: break-all;">${verifyUrl}</a></p>
    <hr style="border: none; border-top: 1px solid #e5e5e5; margin: 24px 0;">
    <p style="font-size: 13px; color: #999;">Lînk ji bo 24 saetan derbasdar e. · Bağlantı 24 saat geçerlidir.</p>
    <p style="font-size: 13px; color: #999;">Heke te tomar nekiriye, vê e-nameyê paşguh bike — hesab nayê çêkirin.<br>Kayıt olmadıysan bu e-postayı yok sayabilirsin.</p>
    <p style="font-size: 13px; color: #999;">Bi silav,<br>LÛTKE · <a href="https://lutke.app" style="color: #1A7B6B;">lutke.app</a></p>
  </div>
</body>
</html>`;

  const text = `Silav ${displayName},

Spas ku tu beşdarî LÛTKE bûyî. Ji bo ku hesabê te çalak bibe, ji kerema xwe vê lînkê veke:
(LÛTKE'ye katıldığın için teşekkürler. Hesabını etkinleştirmek için bu bağlantıyı aç:)

${verifyUrl}

Lînk ji bo 24 saetan derbasdar e. (Bağlantı 24 saat geçerlidir.)

Heke te tomar nekiriye, vê e-nameyê paşguh bike — hesab nayê çêkirin.
(Kayıt olmadıysan bu e-postayı yok sayabilirsin.)

Bi silav,
LÛTKE · lutke.app`;

  return { html, text, subject };
}

export function passwordResetEmailTemplate(opts: {
  displayName: string;
  resetUrl: string;
}): { html: string; text: string; subject: string } {
  const { displayName, resetUrl } = opts;
  const safeName = escapeHtml(displayName);
  const subject = "LÛTKE — Sazkirina şîfreyê · Şifre sıfırlama";

  const html = `<!DOCTYPE html>
<html lang="ku">
<head><meta charset="utf-8"></head>
<body style="font-family: -apple-system, Segoe UI, Roboto, sans-serif; max-width: 560px; margin: 32px auto; color: #1A1A1A; line-height: 1.6;">
  <div style="background: linear-gradient(135deg, #1A7B6B, #0C5247); padding: 32px; text-align: center; border-radius: 12px 12px 0 0;">
    <h1 style="color: white; margin: 0; font-size: 28px; letter-spacing: 4px;">LÛTKE</h1>
  </div>
  <div style="background: white; padding: 32px; border-radius: 0 0 12px 12px; border: 1px solid #e5e5e5; border-top: none;">
    <h2 style="margin-top: 0;">Silav ${safeName},</h2>
    <p>Me daxwaza guhertina şîfreya hesabê te wergirt. Ji bo ku şîfreyeke nû binivîsî, ji kerema xwe li ser bişkoka jêrîn bitikîne:</p>
    <p style="font-size: 14px; color: #555;">Hesabının şifresini değiştirme isteği aldık. Yeni bir şifre belirlemek için aşağıdaki düğmeye tıkla:</p>
    <p style="text-align: center; margin: 32px 0;">
      <a href="${resetUrl}" style="background: #1A7B6B; color: white; padding: 14px 28px; text-decoration: none; border-radius: 8px; font-weight: 700;">Şîfreyê biguherîne · Şifreyi değiştir</a>
    </p>
    <p style="font-size: 13px; color: #666;">An jî vê lînkê di geroka xwe de veke:<br><a href="${resetUrl}" style="color: #1A7B6B; word-break: break-all;">${resetUrl}</a></p>
    <hr style="border: none; border-top: 1px solid #e5e5e5; margin: 24px 0;">
    <p style="font-size: 13px; color: #999;">Lînk ji bo saetekê derbasdar e. · Bağlantı 1 saat geçerlidir.</p>
    <p style="font-size: 13px; color: #999;"><strong>Heke te ev daxwaz nekiriye</strong>, vê e-nameyê paşguh bike — şîfreya te dê neyê guhertin.<br>Bu isteği sen yapmadıysan bu e-postayı yok say; şifren değişmez.</p>
    <p style="font-size: 13px; color: #999;">Bi silav,<br>LÛTKE · <a href="https://lutke.app" style="color: #1A7B6B;">lutke.app</a></p>
  </div>
</body>
</html>`;

  const text = `Silav ${displayName},

Me daxwaza guhertina şîfreya hesabê te wergirt. Ji bo ku şîfreyeke nû binivîsî, ji kerema xwe vê lînkê veke:
(Hesabının şifresini değiştirme isteği aldık. Yeni bir şifre belirlemek için bu bağlantıyı aç:)

${resetUrl}

Lînk ji bo saetekê derbasdar e. (Bağlantı 1 saat geçerlidir.)

Heke te ev daxwaz nekiriye, vê e-nameyê paşguh bike — şîfreya te dê neyê guhertin.
(Bu isteği sen yapmadıysan bu e-postayı yok say; şifren değişmez.)

Bi silav,
LÛTKE · lutke.app`;

  return { html, text, subject };
}
