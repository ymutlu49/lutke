# Lutke kimlik uçlarının YEREL uçtan uca denemesi: sıfırdan kayıt -> doğrulama -> giriş ->
# şifre sıfırlama, hız sınırları, yetki. Canlıya dokunmaz; parola ve belirteç yazdırmaz.
#
# Kullanım (iki uçbirim):
#   1) npx wrangler d1 execute lutke_users --local --persist-to <DURUM> --file functions/schema.sql
#      npx wrangler pages dev dist --port 8788 --persist-to <DURUM> \
#          --binding JWT_SECRET=yerel-deneme --binding EMAIL_DRY_RUN=1 \
#          --binding PUBLIC_BASE_URL=http://localhost:8788
#   2) python tools/qa/kimlik_deneme.py <DURUM>
#
# <DURUM>: wrangler'ın yerel durum klasörü (deponun DIŞINDA bir geçici klasör seçin).
# EMAIL_DRY_RUN=1 e-postayı göndermez, metnini sunucu günlüğüne yazar (functions/lib/email.ts).
# Betik yerel veritabanındaki hız sınırı sayaçlarını sıfırlar ve deneme kullanıcıları ekler;
# yalnız atılabilir bir yerel veritabanına karşı çalıştırın.
import glob, json, os, secrets, sqlite3, sys, time, urllib.request, urllib.error

TABAN = os.environ.get('LUTKE_YEREL', 'http://localhost:8788')
if not TABAN.startswith(('http://localhost', 'http://127.0.0.1')):
    sys.exit('Bu betik yalnız yerel sunucuya karşı çalışır: ' + TABAN)
if len(sys.argv) < 2:
    sys.exit('Kullanım: python tools/qa/kimlik_deneme.py <wrangler durum klasörü>')
DURUM = sys.argv[1]
_adaylar = [p for p in glob.glob(os.path.join(DURUM, 'v3', 'd1', 'miniflare-D1DatabaseObject', '*.sqlite'))
            if not p.endswith('metadata.sqlite')]
if not _adaylar:
    sys.exit('Yerel D1 dosyası bulunamadı: ' + DURUM)
DB = _adaylar[0]

gecen, kalan, notlar = 0, 0, []


def istek(yol, govde=None, belirtec=None, yontem=None, yonlendirme=True):
    veri = None if govde is None else (govde if isinstance(govde, bytes) else json.dumps(govde).encode("utf-8"))
    r = urllib.request.Request(TABAN + yol, data=veri, method=yontem or ("POST" if veri is not None else "GET"))
    r.add_header("Content-Type", "application/json")
    if belirtec:
        r.add_header("Authorization", "Bearer " + belirtec)
    ac = urllib.request.build_opener() if yonlendirme else urllib.request.build_opener(YonlendirmeYok)
    try:
        y = ac.open(r, timeout=30)
        kod, ham, bas = y.status, y.read(), dict(y.headers)
    except urllib.error.HTTPError as e:
        kod, ham, bas = e.code, e.read(), dict(e.headers)
    try:
        j = json.loads(ham.decode("utf-8"))
    except Exception:
        j = {}
    return kod, j, bas


class YonlendirmeYok(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, *a, **k):
        return None


def sor(sql, par=()):
    b = sqlite3.connect("file:" + DB.replace(os.sep, "/") + "?mode=ro", uri=True, timeout=10)
    try:
        return b.execute(sql, par).fetchall()
    finally:
        b.close()


def yaz(sql, par=()):
    b = sqlite3.connect(DB, timeout=10)
    try:
        b.execute(sql, par)
        b.commit()
    finally:
        b.close()


def sinir_sifirla():
    yaz("DELETE FROM rate_limit")


def bak(ad, kosul, ayrinti=""):
    global gecen, kalan
    if kosul:
        gecen += 1
        print("  GEÇTİ  " + ad)
    else:
        kalan += 1
        print("  KALDI  " + ad + ("  -> " + str(ayrinti) if ayrinti != "" else ""))


def belirtec_al(kullanici, tur):
    for _ in range(30):
        s = sor("SELECT token FROM auth_tokens WHERE user_id=? AND type=? AND used_at IS NULL ORDER BY created_at DESC",
                (kullanici, tur))
        if s:
            return s[0][0]
        time.sleep(0.2)
    return None


def baslik(m):
    print()
    print("== " + m)


ek = secrets.token_hex(4)
EPOSTA = "deneme-" + ek + "@example.test"
P1, P2 = "Pp1-" + secrets.token_urlsafe(9), "Pp2-" + secrets.token_urlsafe(9)
sinir_sifirla()

baslik("A. Kayıt: girdi denetimi")
k, j, _ = istek("/api/auth/signup", b"bozuk{")
bak("bozuk gövde 400 invalid_body", k == 400 and j.get("code") == "invalid_body", (k, j))
k, j, _ = istek("/api/auth/signup", {"email": "eposta-degil", "password": P1})
bak("geçersiz e-posta 400 invalid_email", k == 400 and j.get("code") == "invalid_email", (k, j))
k, j, _ = istek("/api/auth/signup", {"email": EPOSTA, "password": "kisa123"})
bak("7 karakterlik şifre 400 weak_password", k == 400 and j.get("code") == "weak_password", (k, j))
k, j, _ = istek("/api/auth/signup", {"email": EPOSTA, "password": "x" * 129})
bak("129 karakterlik şifre 400 weak_password", k == 400 and j.get("code") == "weak_password", (k, j))
bak("reddedilen denemeler kullanıcı satırı oluşturmadı", sor("SELECT COUNT(*) FROM users")[0][0] == 0)

baslik("B. Kayıt: başarılı yol")
k, j, _ = istek("/api/auth/signup", {"email": "  " + EPOSTA.upper() + " ", "password": P1,
                                      "displayName": "Denek\u0007 Kullanıcı " + "x" * 80,
                                      "currentLevel": "z9", "dailyGoal": 99999})
bak("kayıt 201", k == 201, (k, j))
u = j.get("user", {})
T1 = j.get("token")
bak("yanıtta oturum belirteci var", bool(T1))
bak("e-posta küçük harfe ve boşluksuz biçime çevrildi", u.get("email") == EPOSTA, u.get("email"))
bak("emailVerified=false, isOwner=false", u.get("emailVerified") is False and u.get("isOwner") is False)
bak("emailSent=true (yerelde konsola yazıldı)", j.get("emailSent") is True, j.get("emailSent"))
bak("ad 60 karakterle sınırlı ve denetim karakteri temizlendi",
    len(u.get("displayName", "")) <= 60 and "\u0007" not in u.get("displayName", ""), u.get("displayName"))
UID = u.get("id")
s = sor("SELECT email_verified, is_owner, current_level, daily_goal, length(password_hash), length(password_salt) FROM users WHERE id=?", (UID,))[0]
bak("veritabanı: doğrulanmamış, sahip değil, düzey a1'e düştü, günlük hedef 200'e kırpıldı",
    s[0] == 0 and s[1] == 0 and s[2] == "a1" and s[3] == 200, s[:4])
bak("şifre düz metin değil (64 hex karma + 64 hex tuz)", s[4] == 64 and s[5] == 64, s[4:])
bak("şifre veritabanında hiçbir sütunda düz metin geçmiyor",
    not any(P1 in str(h) for h in sor("SELECT * FROM users WHERE id=?", (UID,))[0]))
V1 = belirtec_al(UID, "verify_email")
bak("doğrulama belirteci oluştu (64 hex)", bool(V1) and len(V1) == 64)
sure = sor("SELECT expires_at - created_at FROM auth_tokens WHERE token=?", (V1,))[0][0]
bak("doğrulama belirteci 24 saat geçerli", abs(sure - 24 * 3600 * 1000) < 5000, sure)
k, j, _ = istek("/api/auth/signup", {"email": EPOSTA.upper(), "password": P1})
bak("aynı e-postayla (büyük harfle) ikinci kayıt 409 email_taken", k == 409 and j.get("code") == "email_taken", (k, j))

baslik("C. Doğrulamadan önce")
k, j, _ = istek("/api/auth/me", belirtec=T1)
bak("kayıt belirteciyle /me 200, emailVerified=false", k == 200 and j.get("user", {}).get("emailVerified") is False, (k, j))
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": "yanlis-sifre-123"})
bak("yanlış şifre 401 invalid_credentials", k == 401 and j.get("code") == "invalid_credentials", (k, j))
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": P1})
bak("doğru şifre ama doğrulanmamış: 403 email_not_verified", k == 403 and j.get("code") == "email_not_verified", (k, j))
bak("403 yanıtında oturum belirteci YOK", "token" not in j, list(j))
notlar.append("403 email_not_verified yanıtı: " + json.dumps(j, ensure_ascii=False))

baslik("D. Doğrulama bağlantısı")
k, j, bas = istek("/api/auth/verify-email?token=" + V1, yontem="GET", yonlendirme=False)
bak("GET /api/auth/verify-email?token= -> 302 /auth/verify-email?token=", k == 302 and
    (bas.get("Location") or bas.get("location") or "").endswith("/auth/verify-email?token=" + V1), (k, bas.get("Location")))
bak("GET doğrulamayı TÜKETMEDİ (hâlâ doğrulanmamış)", sor("SELECT email_verified FROM users WHERE id=?", (UID,))[0][0] == 0)
k, j, _ = istek("/api/auth/resend-verification", {})
bak("oturumsuz yeniden gönderme 401", k == 401, (k, j))
k, j, _ = istek("/api/auth/resend-verification", {}, belirtec=T1)
bak("oturumla yeniden gönderme 200", k == 200 and j.get("ok") is True, (k, j))
V2 = belirtec_al(UID, "verify_email")
bak("yeni belirteç üretildi, eskisi silindi", bool(V2) and V2 != V1 and not sor("SELECT 1 FROM auth_tokens WHERE token=?", (V1,)))
k, j, _ = istek("/api/auth/verify-email", {"token": V1})
bak("eski bağlantı artık geçersiz: 400 token_invalid", k == 400 and j.get("code") == "token_invalid", (k, j))
k, j, _ = istek("/api/auth/verify-email", {"token": "0" * 64})
bak("uydurma belirteç 400 token_invalid", k == 400 and j.get("code") == "token_invalid", (k, j))
k, j, _ = istek("/api/auth/verify-email", {})
bak("belirteçsiz 400 token_missing", k == 400 and j.get("code") == "token_missing", (k, j))
k, j, _ = istek("/api/auth/verify-email", {"token": V2})
bak("geçerli bağlantı 200 ok", k == 200 and j.get("ok") is True, (k, j))
bak("veritabanı: email_verified=1", sor("SELECT email_verified FROM users WHERE id=?", (UID,))[0][0] == 1)
k, j, _ = istek("/api/auth/verify-email", {"token": V2})
notlar.append("aynı doğrulama bağlantısına ikinci tıklama: " + str(k) + " " + json.dumps(j, ensure_ascii=False))
bak("aynı bağlantıya İKİNCİ tıklama hata vermiyor (hesap zaten doğrulanmış)", k == 200, (k, j))
k, j, _ = istek("/api/auth/resend-verification", {}, belirtec=T1)
bak("doğrulanmış hesapta yeniden gönderme: alreadyVerified", k == 200 and j.get("alreadyVerified") is True, (k, j))

baslik("E. Giriş")
k, j, _ = istek("/api/auth/login", {"email": " " + EPOSTA.upper() + " ", "password": P1})
bak("giriş 200 (e-posta büyük harf/boşlukla yazılsa da)", k == 200 and bool(j.get("token")), (k, j.get("code")))
T2 = j.get("token")
bak("kullanıcı alanları dolu (emailVerified=true)", j.get("user", {}).get("emailVerified") is True and j.get("user", {}).get("email") == EPOSTA)
k, j, _ = istek("/api/auth/me", belirtec=T2)
bak("/me 200", k == 200 and j.get("user", {}).get("id") == UID)
k, j, _ = istek("/api/auth/me", belirtec=T2[:-3] + "abc")
bak("imzası bozuk belirteç 401", k == 401, k)
k, j, _ = istek("/api/profile/placement", belirtec=T2)
bak("yerleştirme ucu oturumla 200", k == 200, (k, j))
bak("giriş denetim kaydı yazıldı (ok)", sor("SELECT COUNT(*) FROM login_audit WHERE user_id=? AND reason='ok'", (UID,))[0][0] >= 1)

baslik("F. Şifremi unuttum")
sinir_sifirla()
k, j, _ = istek("/api/auth/request-password-reset", {"email": "yok-" + ek + "@example.test"})
bak("kayıtlı olmayan e-posta: 200 ok (hesap var/yok sızmıyor)", k == 200 and j == {"ok": True}, (k, j))
bak("kayıtlı olmayan e-posta için belirteç oluşmadı", sor("SELECT COUNT(*) FROM auth_tokens WHERE type='reset_password'")[0][0] == 0)
k, j, _ = istek("/api/auth/request-password-reset", {"email": EPOSTA.upper()})
bak("kayıtlı e-posta: 200 ok", k == 200 and j == {"ok": True}, (k, j))
R1 = belirtec_al(UID, "reset_password")
bak("sıfırlama belirteci oluştu", bool(R1) and len(R1) == 64)
sure = sor("SELECT expires_at - created_at FROM auth_tokens WHERE token=?", (R1,))[0][0]
bak("sıfırlama belirteci 1 saat geçerli", abs(sure - 3600 * 1000) < 5000, sure)
k, j, _ = istek("/api/auth/request-password-reset", {"email": EPOSTA})
R2 = None
for _ in range(30):
    R2 = belirtec_al(UID, "reset_password")
    if R2 and R2 != R1:
        break
    time.sleep(0.2)
bak("ikinci istek yeni bağlantı üretti, ilki iptal oldu", bool(R2) and R2 != R1 and not sor("SELECT 1 FROM auth_tokens WHERE token=?", (R1,)))
k, j, _ = istek("/api/auth/reset-password", {"token": R1, "newPassword": P2})
bak("iptal edilen ilk bağlantı 400 invalid_token", k == 400 and j.get("code") == "invalid_token", (k, j))
k, j, _ = istek("/api/auth/reset-password", {"token": R2, "newPassword": "kisa"})
bak("kısa yeni şifre 400 weak_password", k == 400 and j.get("code") == "weak_password", (k, j))
k, j, _ = istek("/api/auth/reset-password", {"token": R2})
bak("şifresiz istek 400 invalid_body", k == 400 and j.get("code") == "invalid_body", (k, j))
k, j, _ = istek("/api/auth/reset-password", {"token": R2, "newPassword": P2})
bak("geçerli bağlantı + yeni şifre 200 ok", k == 200 and j.get("ok") is True, (k, j))
k, j, _ = istek("/api/auth/reset-password", {"token": R2, "newPassword": P1})
bak("aynı bağlantı ikinci kez kullanılamıyor (400 invalid_token)", k == 400 and j.get("code") == "invalid_token", (k, j))
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": P1})
bak("ESKİ şifreyle giriş artık 401", k == 401, (k, j))
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": P2})
bak("YENİ şifreyle giriş 200", k == 200 and bool(j.get("token")), (k, j.get("code")))
T3 = j.get("token")
k, j, _ = istek("/api/auth/me", belirtec=T2)
bak("şifre sıfırlanınca ESKİ oturum belirteci geçersiz (401)", k == 401, k)
k, j, _ = istek("/api/auth/me", belirtec=T1)
bak("kayıt anındaki belirteç de geçersiz (401)", k == 401, k)
k, j, _ = istek("/api/profile/placement", belirtec=T2)
bak("eski belirteçle hesaba yazılan uçlar da kapalı (401)", k == 401, k)
k, j, _ = istek("/api/auth/me", belirtec=T3)
bak("yeni şifreyle alınan belirteç geçerli (200)", k == 200, k)

baslik("G. Süresi dolmuş bağlantılar")
sinir_sifirla()
istek("/api/auth/request-password-reset", {"email": EPOSTA})
R3 = belirtec_al(UID, "reset_password")
yaz("UPDATE auth_tokens SET expires_at=? WHERE token=?", (int(time.time() * 1000) - 1000, R3))
k, j, _ = istek("/api/auth/reset-password", {"token": R3, "newPassword": P1})
bak("süresi dolmuş sıfırlama bağlantısı 400 invalid_token", k == 400 and j.get("code") == "invalid_token", (k, j))
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": P2})
bak("süresi dolmuş bağlantı şifreyi değiştirmedi", k == 200)

baslik("H. Doğrulama e-postasını kaybeden kullanıcı (başka cihaz, oturum yok)")
sinir_sifirla()
E2 = "kayip-" + ek + "@example.test"
k, j, _ = istek("/api/auth/signup", {"email": E2, "password": P1, "displayName": "Kayıp"})
UID2 = j.get("user", {}).get("id")
VK = belirtec_al(UID2, "verify_email")
yaz("UPDATE auth_tokens SET expires_at=? WHERE token=?", (int(time.time() * 1000) - 1000, VK))
k, j, _ = istek("/api/auth/verify-email", {"token": VK})
bak("süresi dolmuş doğrulama bağlantısı 400", k == 400, (k, j))
k, j, _ = istek("/api/auth/login", {"email": E2, "password": P1})
bak("oturumsuz cihazdan giriş: 403 email_not_verified", k == 403 and j.get("code") == "email_not_verified", (k, j))
yeni = belirtec_al(UID2, "verify_email")
bak("...ve sunucu bu girişte YENİ doğrulama bağlantısı gönderdi (çıkmaz yok)",
    bool(yeni) and yeni != VK and j.get("verificationSent") is True, (bool(yeni) and yeni != VK, j.get("verificationSent")))
istek("/api/auth/request-password-reset", {"email": E2})
RK = belirtec_al(UID2, "reset_password")
k, j, _ = istek("/api/auth/reset-password", {"token": RK, "newPassword": P2})
bak("çıkış yolu: şifre sıfırlama hesabı doğrulanmış sayıyor", k == 200 and
    sor("SELECT email_verified FROM users WHERE id=?", (UID2,))[0][0] == 1, (k, j))
k, j, _ = istek("/api/auth/login", {"email": E2, "password": P2})
bak("sıfırlamadan sonra giriş 200", k == 200, (k, j.get("code")))

baslik("I. Sahip e-postasıyla yetki yükseltme denemesi")
sinir_sifirla()
SAHIP = "y.mutlu@alparslan.edu.tr"
k, j, _ = istek("/api/auth/signup", {"email": SAHIP, "password": P1})
UID3 = j.get("user", {}).get("id")
bak("sahip e-postasıyla kayıt: isOwner=false (posta kutusu kanıtı yok)", k == 201 and j.get("user", {}).get("isOwner") is False, (k, j.get("user")))
k, j, _ = istek("/api/admin/stats", belirtec=j.get("token"))
bak("doğrulanmamış 'sahip' yönetici istatistiğine erişemiyor", k in (401, 403), (k, j))
k, j, _ = istek("/api/auth/login", {"email": SAHIP, "password": P1})
bak("doğrulanmamış 'sahip' girişte muafiyet alamıyor (403)", k == 403, (k, j.get("code")))
VS = belirtec_al(UID3, "verify_email")
istek("/api/auth/verify-email", {"token": VS})
k, j, _ = istek("/api/auth/login", {"email": SAHIP, "password": P1})
bak("posta kutusu kanıtından sonra isOwner=true", k == 200 and j.get("user", {}).get("isOwner") is True, (k, j.get("user")))
# Sahip listesinde OLMAYAN bir hesaba elle verilmiş yetki (üretimdeki eski satır gibi):
# yetki veritabanından kaldırılınca aynı belirteçle erişim hemen kapanmalı.
yaz("UPDATE users SET is_owner = 1 WHERE id = ?", (UID,))
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": P2})
TS = j.get("token")
k, j, _ = istek("/api/admin/stats", belirtec=TS)
bak("yetkili hesap yönetici ucuna erişir", k == 200, k)
yaz("UPDATE users SET is_owner = 0 WHERE id = ?", (UID,))
k, j, _ = istek("/api/admin/stats", belirtec=TS)
bak("yetki veritabanından kaldırılınca AYNI belirteçle erişim kapanır", k == 403, k)
k, j, _ = istek("/api/suggestions", belirtec=TS)
bak("öneri yönetimi de kapanır", k == 403, k)

baslik("J. Hız sınırları")
sinir_sifirla()
kodlar = [istek("/api/auth/login", {"email": EPOSTA, "password": "yanlis-" + str(i)})[0] for i in range(21)]
bak("aynı e-postaya 20 yanlış denemeden sonra 21.si 429", kodlar[:20] == [401] * 20 and kodlar[20] == 429, kodlar)
k, j, _ = istek("/api/auth/login", {"email": EPOSTA, "password": P2})
bak("kilit sürerken doğru şifre de 429 (kaba kuvvet koruması)", k == 429, k)
sinir_sifirla()
once = sor("SELECT COUNT(*) FROM auth_tokens WHERE type='reset_password' AND user_id=?", (UID,))[0][0]
for i in range(4):
    istek("/api/auth/request-password-reset", {"email": EPOSTA})
    time.sleep(0.4)
uretilen = sor("SELECT COUNT(*) FROM rate_limit WHERE bucket LIKE 'pwreset:%' AND count=4")[0][0]
bak("aynı e-postaya saatte 3 sıfırlama; 4.sü sessizce yutuluyor (yanıt yine 200)", uretilen == 1, uretilen)
sinir_sifirla()
kodlar = [istek("/api/auth/signup", {"email": "toplu-" + ek + "-" + str(i) + "@example.test", "password": P1})[0] for i in range(11)]
bak("aynı IP'den saatte 10 kayıt; 11.si 429", kodlar[:10] == [201] * 10 and kodlar[10] == 429, kodlar)
sinir_sifirla()

print()
print("SONUÇ: %d geçti, %d kaldı" % (gecen, kalan))
for n in notlar:
    print("NOT: " + n)
sys.exit(1 if kalan else 0)
