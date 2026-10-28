# Lütke Kurmancî içeriği · kaynak kitaplarla karşılaştırma (2026-10-24)

Kullanıcı isteği: "Lütke'nin Kürtçe içerik ve etkinliklerini Jimaro'daki kaynak Kürtçe kitaplar
bağlamında gözden geçir, varsa ihtiyaç iyileştir."

## Kaynaklar

Ortak korpusta metne çevrilmiş kitaplar (`Kurmanci/Ziman/korpus/`):

| Sınıf | Kitap | Bu denetimdeki işlevi |
|---|---|---|
| Öğretim kitabı | *Fêrkera Kurdî* (Asta Destpêkê, 14 ders) | sıra, tema, sözcük, alıştırma türü |
| Öğretim kitabı | *Kurmanji Complete* (Thackston) | dilbilgisi kuralı, sıra |
| Öğretim | Aslanoğlu, *Kürtçe dil kartları*; *Türkçe İzahlı Kürtçe Grameri* | temel söz varlığı |
| Program | MEB, *Yaşayan Diller ve Lehçeler – Kürtçe* öğretim programı | A1 temaları, dört beceri |
| Başvuru dilbilgisi | Samî Tan, *Rêzimana Kurmancî*; Selîm Biçûk; Celadet Bedirxan | kural ve terim |
| Tanık korpusu | çağdaş edebiyat, halk anlatısı, klasikler (1 milyon sözcük) | biçim ve eşdizim sayımı (`Ziman/araclar/ara.py`) |

## 1. Dilbilgisi ipuçları ekranı (`lib/features/grammar/grammar_tips_screen.dart`)

10 konu, hepsi A1–A2. Kaynaklarla karşılaştırınca bulunan ve **düzeltilen** hatalar:

| # | Sorun | Kanıt | Düzeltme |
|---|---|---|---|
| 1 | **Çoğul yanlış öğretiliyordu**: "navdêr + -an = pirjimar", "zarok → zarokan = çocuklar" | Samî Tan: yalın durumdaki çoğulun eki yoktur, *-an* çoğul adın eğik durumudur (korpus satır 2307, 2529). Yanlış kural "*Zarokan hatin*" hatasına götürür | Kural, örnekler ve ipucu yeniden yazıldı (*Zarok hatin* / *ji zarokan re*); bir soru "Çocuklar geldi → Zarok hatin" oldu |
| 2 | *roj* eril örneklerin arasındaydı | *roja* 532, *rojeke/rojekê* 316, *rojekî* 4 geçiş: dişil | listeden çıkarıldı |
| 3 | Durum terimleri tanıksız: "rewşa rast / berz", "navokî" | korpusta 0; Samî Tan "rewşa xwerû / tewandî" | kaynağın terimleri |
| 4 | "kerdox" (özne) tanıksız | 0; *kirde* 242 geçiş, 8 kaynak (*biker* yalnız Fêrkera'da 18) | *kirde* |
| 5 | "veguhêzî / neveguhêzî" (geçişli/geçişsiz) | 2 / 0; *gerguhêz / negerguhêz* 233 / 115 | *gerguhêz / negerguhêz* |
| 6 | "Cinavk", "fermankar" | *cînavk* 112 / *cinavk* 1; *fermanî* 76 / *fermankar* 0 | *Cînavk*, *raweya fermanî* |
| 7 | Ergatifte fiilin **nesneyle** uyuştuğu anlatılmıyordu (kaynakların ve REBER'in 1 numaralı noktası) | Samî Tan: "lêker li gorî bireserê tê kişandin"; *Min ew dît* 7, *Min tu dîtî* 5 geçiş | kural ve iki örnek eklendi |
| 8 | Soru "*Min ew ___*" iki doğru cevaplıydı (*ew* tekil/çoğul: *dît* / *dîtin*) | — | "(onu gördüm)" eklendi |
| 9 | Doğru şık "*Ez başim, spas.*" bitişik | kuralın kendisi "baş im" | ayrı yazıldı |
| 10 | Veda örneği "*Xatirê te! Sibê bibînim.*" (editör listesindeydi) | Fêrkera 1. ders: *Bi xatirê te — Oxir be* (18 / 14 geçiş); "Sibê bibînim" tanıksız | "*Bi xatirê te! — Oxir be!*" |
| 11 | İzafe kuralı yalnız "ad + zamir" diyordu, *cinavkan* yazımıyla | — | ad + zamir / ad / sıfat; *mala min, mala bavê min, mala mezin* |

Doğrulanıp **değiştirilmeyenler**: olumsuz emirde *me-* ve *ne-* ikisi de yaygın (*meke* 130 / *neke* 134;
Fêrkera "Qet deng neke"); dişil/eril örneklerin geri kalanı; *girêdide / girê dide* ikisi de var.

## 2. Alıştırmalar

Ders kitaplarının temel alıştırma türü çekim tablosu ve dönüştürmedir (olumluyu olumsuza, şimdikini
geçmişe). Lütke'de veriden üretilen biçim alıştırması yalnız izafe ve ergatif içindi.

**Eklendi** (`bicim_alistirma.dart`, veri `cekim_db.dart`, üreteç `tools/qa/cekim.py`):

- **Dema niha** (A1–A2): özneye göre kişi eki — *Tu dixwî / dixwim / dixwe*.
- **Neyînî** (A2–B1): *Ez diçim → Ez naçim* (yanlış şıklar dilbilgisine aykırı: *nediçim, nadiçim*).

Hiçbir biçim yalnız kuraldan yazılmadı: 1. tekil biçimden türetilen her biçim korpusta sayıldı, tabloya
yalnız tanıklı olan girdi. Kural tek başına yanlış biçim üretiyordu: ünlüyle başlayan kökte *naavêjim*
(korpusta 0; doğrusu *navêjim*), *nanêrim, nabezim* (0). Sonuç: 25 fiilin dört biçimi, 17 fiilin
olumsuzu. Dışarıda: *kişandin, vegerandin, şandin* ("tu" biçimi tanıksız).

**Önerilen sonraki alıştırmalar** (aynı desen, veri hazır):
emir (`fiil_db.dart` → `emir`: *bibêje, bixwe*), geçmişte nesneyle uyum (*Min ew dît / dîtin*),
eğik zamir (*min / ez* şimdiki ve geçmişte).

## 3. Konu kapsaması: kaynakların öğretip Lütke ipuçlarının anlatmadığı

Fêrkera Kurdî ilk 14 derste şu sırayla ilerliyor: selamlaşma → ad cümlesi (*-e, -ye, -in, -ne*) →
ad cümlesinin olumsuzu ve soru (*ne, nîne; ma, gelo*) → sayılar ve *çend?* → saat → gün/ay/mevsim →
seslenme ekleri (*-o, -ê, -ino*) → kişi zamirleri ve *bûn* → işaret zamirleri (*ev/ew, vê/vî/van*) →
cinsiyet ve eğik durum ekleri (*-î / -ê*) → izafe türleri.

Lütke ipuçlarında **olmayan** A1–A2 konuları (öneri, editör turu gerekir):

1. Ad cümlesi ve olumsuzu: *Ew mamoste ye / Ew ne mamoste ye*, *nîne / nînin*
2. Sayılar ve saat: *çend?*, *Saet çend e?*, *nîv, çaryek*
3. Seslenme: *-o* (eril), *-ê* (dişil), *-ino* (çoğul)
4. İşaret zamirleri ve eğik biçimleri: *ev, ew; vê, vî, van; wê, wî, wan*
5. Tekil eğik durum: dişil *-ê*, eril *-î* (*di malê de*)
6. Gelecek zaman (*dê / ê* + *bi-*), emir (*bi-* + kök), dilek kipi, kiplik (*divê, dikarim*)
7. İyelik *min … heye / hene*
8. Soru sözcükleri (*çi, kî, kengî, li ku, çawa, çima, çend*), MEB A1 kazanımı

Üstünlük için: Lütke B1 11. ders *-tirîn*'i ada sonradan ekliyor (korpus: sonradan 5, önden 19,
*herî X* 28). Kurmanji Complete *-tirîn*'in adın önüne geldiğini öğretiyor ("Mezintirîn nav…");
*herî mezin* 48 geçiş / 13 kaynak. Öneri: dersi *herî X* + öne gelen *Xtirîn* olarak yeniden yazmak.

## 4. Söz varlığı

Fêrkera Kurdî'nin ilk 14 dersinde öğretilip Lütke'de **kendi kaydı olmayan** sözcükler (bir kısmı
örnek cümlelerde onlarca kez geçiyor): *heval* (39 geçiş), *ders* (39), *pîroz* (34), *pênûs, aferîn,
nexêr, zilam, çûk, mih, berx, kevok, karik, golik, mehîn, werdek, kîvroşk, çarşî, serdan*.

Kitaplarda başlangıçta öğretilip Lütke'de B1 ve sonrasında ilk kez kaydı olanlar: *dîtin, birin, anîn,
girtin, welat, pir, mam, birazî, betlane, destpêkirin, rojname, amadekirin, derxistin, kişandin,
dawî, eger*. Bunlar A1–A2 metinlerinde geçtiği hâlde öğrenen kaydını ancak B1'de görüyor.

Bu, Faz 4.1'deki çekirdek söz varlığı açığının (Karar 24) kaynak kitaplarla doğrulanmasıdır. Yeni kayıt
cinsiyet kanıtı, örnek cümle ve ses gerektirir; liste editör onayıyla eklenmeli.

## 5. MEB temaları

A1 kategorileri dokuz temanın çoğunu karşılıyor (selam, aile, beden, yiyecek, zaman/mevsim, ev, okul,
sayı, renk, giysi, sağlık, meslek; A2'de seyahat ve spor). Eksik tema: **oyunlar ve masallar**
(tekerleme, çocuk oyunları, masal). Halk anlatısı derlemeleri korpusta var (*30 Çîrokên Bijare*,
*Çîrokên Gelêrî*), ama metinleri telifli basımlardan; özgün metin yazımı editör turu ister.

## 2026-10-28: kullanıcının "devam et ve yayınla" onayıyla uygulananlar

- **§3'teki sekiz konu eklendi** (`grammar_tips_screen.dart`, 10 → 18 konu): Hevokên Navdêrî, Cînavên Nîşanê,
  Peyvên Pirsê, Jimar û Saet, Hebûn (A1); Tewang, Banglêkirin, Dema Bê û Fermanî (A2). Her örnek ve doğru
  cevap tanık korpusunda sayıldı (`kalip_say.py`); tanıksız çıkanların yerine Fêrkera Kurdî'nin kendi örnekleri
  kondu (*Şîlan mamoste nîne*, *Saet heft û nîv e*, *Saet didu kêm deh deqîqe ye*). Açıklama cümlelerindeki
  tanıksız deyişler kaynakların deyişleriyle değiştirildi (*Qertafên rewşa banglêkirinê*, *tewanga navîn*,
  *awarte*, *bi daçekan*). Yanlış şıklar korpusta doğru olarak geçmeyecek biçimde seçildi (*di mal de* 4,
  *bihê* 15 geçtiği için çıkarıldı; *pêncdeh* 0).
- **B1 11. ders**: "herî" + sıfat öğreten bir soru eklendi (*tiştê herî girîng*, 5 geçiş), not güncellendi.
  Konuşma cümlesi (*helbestvanê mezintirîn*) değiştirilmedi: arkadan gelen *-tirîn* seyrek ama tanıklı
  (ad + -tirîn 55), sesi var.
- **Dil kapısı**: *saet* için muafiyet (`ziman_muaf.tsv`, öteki beş genel dil / matematik terimi muafiyetiyle aynı
  gerekçe). Kapı: yeni işaret 0.
- **Söz varlığı**: *Heval* (a1_fk_23) ve *Pîroz* (a1_fk_24) eklendi; örnekleri Lütke'nin denetlenmiş ve
  seslendirilmiş mevcut cümleleri. Yeni ses yalnız madde başı *Pîroz* (3 kredi).
- Soru sözcüklerinde *li ku / ji ku* yazıldı: Fêrkera Kurdî ve MEB programı kısa *ku* kullanıyor (gramer
  kaynaklarında *li ku* 8 / *li kû* 18 — çoğu tek bir OCR kaynağından).

## 2026-10-28 (2. tur): kullanıcının "bekleyen cümleleri de yaz ve ekle" isteğiyle uygulananlar

- **Altı kayıt eklendi** (`a1_kelime_db.dart`, a1_fk_25, 27–31): *Ders, Zilam, Mih, Kevok, Aferîn, Nexêr*;
  *Pênûs* yeni kayıt olmadı, düzeltilen a1_500'e katıldı (aşağıda *pênûsk*).
  Uydurma cümle yazılmadı: 28 örneğin hepsi kaynaklardan; çoğu Fêrkera Kurdî'nin 1.–4. ve 10. derslerinden
  (*Ew pênûsa bapîrî ye*, *Ev zilam kî ye?*, *Çend mihên we hene?*, *Nexêr, kurê min, ew ne şîn e, kesk e*).
  Fêrkera'da örneği olmayanlar öteki kaynaklardan: *Ev dersa yekem e* ve *Aferîn ji we re* (Kurmanji Complete),
  *Kî dersê dide te?* (Halil Aktug), *Ev zilam ne qenc bû* (Samî Tan), *Aferîn, kurê min* (Qedrî Can),
  *Aferîn, lawê min* (Firat Cewerî), *Du kevokên spî difirin* ve *Kevok weke pembû spî ne* (Mehmed Uzun).
  Değişiklik yalnız yan cümleyi atmak (*Du kevokên spî, li her du aliyên wî, difirin*) ya da virgül koymak
  oldu. Tanıksız diye elenenler: *Ez bi pênûsê dinivîsim* (kaynakta *dinivîsînim*), *Kevok firî*, *Erê an nexêr*.
- **Cinsiyet**: dördü dişil, *zilam* eril; `cins_kanit.py` hepsini doğruladı (Wîkîferheng; *ders* ve *pênûs*'ta
  Farqînî de). `cins_kanit_db.dart` yeniden üretildi; *ders, pênûs, zilam, mih, kevok* izafe alıştırmasına girdi.
- **Heval izafe alıştırmasından çıkarıldı** (`kOrtakCinsliAdlar`): kanıt listesi yeniden üretilince *Heval* de
  girmişti; ortak cinsli olduğu için *hevala min* de doğru, soru iki doğru cevaplı olurdu. Canlı sürümde bu
  soru yoktu (liste geçen yayında yeniden üretilmemişti). Sınama eklendi.
- **Dinleme alıştırması**: anlam sorusunun çeldiricileri rastgele seçiliyor, eşanlamlılar elenmiyordu.
  *Mî / Mih* (Koyun), *Na / Nexêr* (Hayır), *Wane / Ders* gibi çiftler, ayrıca A1'deki 18 eski çift
  (*Sinif / Pol*, *Dew / Mastaw*…), aynı soruda iki doğru seçenek üretebilirdi. Ana sınavdaki kural
  (`quiz_screen.dart`: Türkçe karşılığın '/'-parçalarından biri bile çakışan kelime elenir) buraya da kondu.
- **Dil kapısı**: kayıt sonrası tek yeni işaret, kültür içeriğindeki özel ad *Mîr Mihê Beg* (izafe sanıldı),
  muaf tutuldu. Kapı: yeni işaret 0.
- **Pênûsk → pênûs** (kullanıcı onayıyla): Lütke "kalem" için *pênûsk* yazıyordu; bu biçim korpusta ve
  sözlüklerde **hiç** geçmiyor (*pênûs* 80, *pênûsa* 34, *pênûsek* 22; Fêrkera, Îzolî, Farqînî hep *pênûs*).
  Notlardaki "*pênûska hibrî*" örneği bile Farqînî'nin *pênûs* maddesinden. 59 geçiş düzeltildi: a1_500,
  a1_756, b1_1355, z_a1_061, çocuk dersi soruları, a2_1965 cümlesi, İngilizce bölümün Kurmancî cümleleri.
  a1_500'ün örnekleri Fêrkera'nınkilerle değişti (sesi zaten yenilenecekti; yeni a1_fk_26 üçüncü kopya
  olmasın diye buraya katıldı). *Lênûsk* (defter) değiştirilmedi.
- **Ses**: 25 yeni metin (6 madde başı + 19 mîrateyî cümle), Sarah / eleven_v4. Gerçek harcama, abonelik
  bakiyesiyle ölçüldü: **195 kredi** (1.545 → 1.350; karakter başına 0,44). Kalite denetiminde şüpheli yok.

## Kararınızı bekleyenler (güncel)

1. **Mîr Mihê Beg** (`kurdish_architecture_db.dart`, Kelha Dimdimê): korpusta Dimdim destanının kahramanı
   *Xanê Lepzêrîn* (Mehmed Uzun, *Hawara Dîcleyê*); *Mihê Beg* 0. Kültür alıntı denetimindeki (K1–K6)
   uydurma ad bulgularıyla aynı türden görünüyor.
2. *çûk*'un cinsi karışık (4 / 3); Lütke'de A1'de *Çûçik* (Kuş) var, ayrı kayıt gerekmeyebilir.
3. *Lênûsk* (defter, 3 kayıt) tanıklı ama seyrek (*lênûsk* 2, *lênûska* 4; şiir ve Aslanoğlu dil kartları),
   *defter* 36 / *deftera* 54. Yanlış değil; *defter*'in de kayıt olarak öğretilmesi düşünülebilir. Dokunulmadı.
4. Temel fiiller (*dîtin, birin, anîn, girtin*) B1'de kayıtlı; A1–A2'ye taşımak kimlik değişikliği ister
   (ilerleme kayıtları kimliğe bağlı) ya da `kA1CekirdekFiil` gibi ikinci kayıt — karar.

## İlk denetimdeki karar listesi (2026-10-24)

1. §3'teki sekiz ipucu konusunun taslağı (her örnek korpusta sınanarak) yazılsın mı?
2. §4'teki sözcükler A1–A2'ye kayıt olarak eklensin mi? (ses: ElevenLabs Sarah ile birkaç yüz kredi)
3. B1 üstünlük dersi *herî X* / öne gelen *-tirîn* olarak yeniden yazılsın mı?
4. Dil kapısı (`ziman_denetim.py --kapi`) bu denetimden bağımsız olarak 38 yeni `terim` işareti
   veriyor: ortak `terim.tsv`'deki *DEMJIMÊR* (matematik, ölçü birimi "saat") günlük *saet*'i işaretliyor.
   Korpus *saet* 451 / 22 kaynak, *demjimêr* 12 / 5; Fêrkera "Saet çend e?" öğretiyor. Öneri: Lütke'de
   günlük *saet* için muafiyet (ya da terim kuralının yalnız matematik metinlerine uygulanması).
5. Önceki listeden açık kalanlar: "Nûş be" (korpus 0, "noşî can" 1 — kaynaklar yetersiz),
   *li kû / li ku* tutarlılığı, *çay*'ın cinsi.
