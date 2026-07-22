# LÛTKE — Gizlilik Politikası

**Son güncelleme:** 25 Nisan 2026
**Yürürlük tarihi:** [Yayın tarihi — TBD]

LÛTKE ("biz", "uygulama", "hizmet") olarak gizliliğinize değer veriyoruz. Bu politika, uygulamayı kullandığınızda hangi bilgileri topladığımızı, nasıl kullandığımızı ve haklarınızı açıklar.

## 1. Veri Sorumlusu

**LÛTKE — Zimanê Kurdî**
Yayıncı: Prof. Dr. Yılmaz Mutlu
İletişim: info@lutke.app
Adres: [POSTAL ADRES EKLENMELİ — KVKK 6698 sayılı kanun gereği]

## 2. Topladığımız Veriler

### 2.1. Otomatik Toplanan Veriler
- **Cihaz bilgisi:** Cihaz modeli, işletim sistemi sürümü (Android/iOS), uygulama sürümü
- **Kullanım verileri:** Açtığınız dersler, çözdüğünüz egzersizler, doğru/yanlış istatistikleri (yalnızca öğrenme algoritması — FSRS — için, kişisel tanımlama yapılmadan)
- **Çökme raporları:** Uygulama çökerse Firebase Crashlytics'e gönderilen anonim hata izi (kullanıcı bilgisi içermez)

### 2.2. Hesap Oluşturursanız Topladıklarımız
- **E-posta adresi** (kayıt için zorunlu)
- **Görünen ad** (profilde gösterilir)
- **Şifre** (Firebase tarafından şifrelenmiş olarak saklanır — biz ham parolaya erişemeyiz)
- **Öğrenme ilerlemesi:** Tamamlanan dersler, XP, streak, başarı seviyesi (CEFR)

### 2.3. Konuşma Pratiği
- **Mikrofon kaydı:** Konuşma alıştırmalarında telaffuz değerlendirmesi için mikrofonu kullanırız.
- **ÖNEMLİ:** Mikrofon ses kaydı **cihazınızda işlenir** ve sunucularımıza yalnızca anonim eşleşme skoru gönderilir. Ham ses verisi saklanmaz.

### 2.4. Çocuk Modu (8-12 yaş için)
- Çocuk modu için **veli onayı** ve **veli PIN kodu** zorunludur.
- Çocuk modunda **sadece yaş aralığı** (7-10) toplanır, kişisel ad/e-posta/iletişim bilgisi **toplanmaz**.
- COPPA (ABD) ve KVKK (TR) uyumlu: 13 yaş altı kullanıcılar için **veli onayı zorunludur**.

## 3. Verileri Nasıl Kullanırız?

| Veri | Amaç | Yasal Dayanak (KVKK m.5) |
|------|------|---------------------------|
| Hesap bilgileri | Hesabınızı yönetmek | Sözleşmenin ifası |
| Öğrenme ilerlemesi | Kişiselleştirilmiş ders sırası, FSRS algoritması | Meşru menfaat |
| Cihaz bilgisi | Hata ayıklama, performans analizi | Meşru menfaat |
| Mikrofon | Telaffuz değerlendirme (lokal işleme) | Açık rıza |

## 4. Üçüncü Taraf Servisler

LÛTKE şu servisleri kullanır:
- **Firebase (Google LLC):** Authentication, Firestore (veri saklama), Crashlytics (hata raporlama). [Firebase Privacy](https://firebase.google.com/support/privacy)
- **HuggingFace Spaces:** Kurmancî TTS (metin-konuşma) ve ASR (konuşma tanıma). Yalnızca dönüştürülecek metin gönderilir, kullanıcı kimliği gönderilmez.
- **Google Fonts:** Yazı tipi yüklenmesi (kullanıcı IP'sini görür ama veri saklamaz).

## 5. Veri Saklama Süresi

- **Aktif hesap:** Hesabınız aktif olduğu sürece.
- **Hesap silme:** Hesabınızı silmenizden sonra 30 gün içinde tüm verileriniz Firebase'den kalıcı olarak silinir.
- **Anonim kullanım istatistikleri:** Kişiyle ilişkilendirilemeyen toplu istatistikler 24 ay saklanabilir.

## 6. Haklarınız (KVKK m.11 / GDPR Art. 15-22)

Aşağıdaki haklara sahipsiniz:
1. ✅ **Erişim:** Hangi verilerinizin işlendiğini öğrenme
2. ✅ **Düzeltme:** Yanlış verileri düzeltme
3. ✅ **Silme:** Hesabınızı ve tüm verilerinizi silme (uygulama içi → Profil → Hesabı Sil)
4. ✅ **Kısıtlama:** Veri işlemenin kısıtlanmasını isteme
5. ✅ **Taşınabilirlik:** Verilerinizin makine okunabilir formatta verilmesi (JSON export)
6. ✅ **İtiraz:** Meşru menfaate dayalı işlemeye itiraz
7. ✅ **Şikayet:** KVKK Kurulu'na şikayette bulunma

Talepler için: [E-POSTA EKLENMELİ]

## 7. Çocukların Gizliliği

13 yaş altı kullanıcılar için:
- Çocuk modu sadece **veli/vasi onayıyla** etkinleştirilebilir (PIN korumalı)
- Çocuk hesabında **kişisel veri toplanmaz** (yalnızca yaş aralığı)
- Reklam **gösterilmez**, üçüncü taraf izleme **yapılmaz**
- Veli, herhangi bir zamanda veriyi silmeyi talep edebilir

## 8. Veri Güvenliği

- Tüm veri transferleri TLS/HTTPS ile şifrelenir.
- Firebase verileri Google'ın ISO 27001/27017/27018 sertifikalı altyapısında tutulur.
- Şifreler hash'lenmiş olarak saklanır (Firebase Auth — Argon2/PBKDF2).
- Yerel cihaz veritabanı (Drift/SQLite) cihaz şifrelemesi altında tutulur.

## 9. Çerez ve Analitik

- Uygulama içinde **çerez kullanılmaz**.
- Firebase Analytics yalnızca **anonim** kullanım istatistikleri toplar (cihaz tipi, ekran görünümü).
- **Kapatma seçeneği:** Profil → Mîheng → Analitik (varsayılan: kapalı).

## 10. Reklam ve Pazarlama

- LÛTKE içinde **reklam yoktur**.
- Pazarlama amacıyla **veri satılmaz**.
- E-posta pazarlamayı sadece açık onay verirseniz yaparız (varsayılan: kapalı).

## 11. Politika Değişiklikleri

Bu politikayı güncelleyebiliriz. Önemli değişiklikler için uygulama içinde 30 gün öncesinden bildirilir. Son güncelleme tarihini her zaman bu sayfanın başında bulabilirsiniz.

## 12. İletişim

Sorularınız için:
- **E-posta:** [E-POSTA EKLENMELİ]
- **Veri Koruma Görevlisi (DPO):** [İSİM/E-POSTA — KVKK 100.000+ kullanıcı eşiği için]

---

**KVKK Kanun Numarası:** 6698 (Kişisel Verilerin Korunması Kanunu)
**GDPR Referansı:** Regulation (EU) 2016/679
**COPPA Referansı:** Children's Online Privacy Protection Act (1998)
