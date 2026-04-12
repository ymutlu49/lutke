import 'lesson_entities.dart';
import 'b2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// B2 — 20 DERS TANIMI (Navîn-Jor / Orta-Üst)
//
// B2 pedagoji odağı:
//   1. Ergatif anlaşma nüansları (3 ders)
//   2. Pasif tam sistem (3 ders)
//   3. Bileşik fiiller (2 ders)
//   4. Şartlı cümle ileri (2 ders)
//   5. Gazete ve resmi dil (3 ders)
//   6. Kürt edebiyatı derin okuma (3 ders)
//   7. Kimlik ve diaspora (2 ders)
//   8. Sentez ve çıktı (2 ders)
// ════════════════════════════════════════════════════════════════

List<String> _b2Cards(List<String> katlar) => kB2TamListe
    .where((k) => katlar.contains(k.kat))
    .map((k) => k.id)
    .toList();

ExerciseModel _mc({
  required String id, required String ku, required String tr,
  required List<String> opts, required int ci,
  String? note, int xp = 12,
}) => ExerciseModel(
  id: id, type: ExerciseType.multipleChoice,
  kurmanjPrompt: ku, turkishPrompt: tr,
  options: opts, correctAnswer: opts[ci], correctIndex: ci,
  grammarNote: note, xpReward: xp,
);

ExerciseModel _fill({
  required String id, required String before, required String after,
  required String tr, required List<String> opts, required int ci,
  String? note, int xp = 14,
}) => ExerciseModel(
  id: id, type: ExerciseType.fillInBlank,
  kurmanjPrompt: '$before ___ $after', turkishPrompt: tr,
  options: opts, correctAnswer: opts[ci], correctIndex: ci,
  grammarNote: note, xpReward: xp,
  wordPieces: [before.trim(), after.trim()],
);

ExerciseModel _ls({
  required String id, required String ku, required String tr,
  required List<String> opts, required int ci,
  String? audio, String? note, int xp = 12,
}) => ExerciseModel(
  id: id, type: ExerciseType.listenAndSelect,
  kurmanjPrompt: ku, turkishPrompt: tr,
  options: opts, correctAnswer: opts[ci], correctIndex: ci,
  audioAsset: audio, grammarNote: note, xpReward: xp,
);

ExerciseModel _speak({
  required String id, required String ku, required String tr,
  int xp = 18,
}) => ExerciseModel(
  id: id, type: ExerciseType.speakingPractice,
  kurmanjPrompt: ku, turkishPrompt: tr,
  options: ['Gelek baş', 'Nêzîk', 'Carek din'],
  correctAnswer: ku, xpReward: xp,
);

// ════════════════════════════════════════════════════════════════
// 20 DERS
// ════════════════════════════════════════════════════════════════

final kB2Lessons = <LessonModel>[

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 1 — Ergatif Nüanslar (3 ders)
  // [BH] §170–185 + [TH] §75–80
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l01',
    kurmanjTitle: 'Ergatif — Lehçe Varyantları',
    turkishTitle: 'Ergatif: Bölgesel Farklılıklar',
    unitNumber: 1, lessonNumber: 1, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['ergatif_b2']),
    estimatedMinutes: 14,
    exercises: [
      _mc(id:'b2_l01_e1',
        ku:'B2\'de ergatif anlaşmada nesne cinsiyeti neden önemli?',
        tr:'Doğru açıklamayı seç',
        opts:['Önemli değil','Bazı lehçelerde fiil nesnenin cinsiyetiyle uyum sağlar','Sadece çoğulda','Sadece dişilde'],
        ci:1, note:'[BH] §178: bazı ağızlarda "Min dit" (eril nesne) / "Min dît" (dişil nesne) ayrımı var. Standart Türkiye Kurmancîsinde zayıflamış.'),
      _mc(id:'b2_l01_e2',
        ku:'"Min pirtûk xwend" ile "Min pirtûka xwend" farkı nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Aynı cümle','Belirsiz (pirtûk) / Belirli (pirtûka) nesne farkı','Cinsiyet farkı','Zaman farkı'],
        ci:1, note:'"Pirtûk xwend" = bir kitap okudu (belirsiz). "Pirtûka xwend" = kitabı okudu (belirli — eğik nesne).'),
      _fill(id:'b2_l01_e3', before:'Min', after:'xwend.',
        tr:'Ben o kitabı okudum (belirli).',
        opts:['pirtûk','pirtûka','pirtûkek','pirtûkên'], ci:1,
        note:'Belirli nesne eğik hale girer: "pirtûk → pirtûka". Ergatif + belirli nesne eğik.'),
      _speak(id:'b2_l01_e4',
        ku:'Min nameya te xwend. Wê gotina te bîst. Wan hemî nivîsandiye.',
        tr:'Senin mektubunu okudum. O senin sözünü duydu. Onlar hepsini yazmış.'),
    ],
  ),

  LessonModel(
    id: 'b2_l02',
    kurmanjTitle: 'Şimdiki Mükemmel — İleri Kullanım',
    turkishTitle: 'Şimdiki Mükemmel: Gazete Dilinde',
    unitNumber: 1, lessonNumber: 2, level: 4,
    path: LessonPath.general,
    targetCardIds: [],
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l02_e1',
        ku:'Gazete dilinde "wî ragihandiye" cümlesinin işlevi nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Geçmiş haber','Şimdiki mükemmel: açıkladı (ve etkisi var)','Gelecek','Edilgen'],
        ci:1, note:'"Ragihandiye" = açıklamış/açıkladı (şimdiki mükemmel). Gazete dilinde haberin şimdiki önemi vurgulanır.'),
      _fill(id:'b2_l02_e2', before:'Serokmar', after:'ragihandiye.',
        tr:'Cumhurbaşkanı açıklamış/açıkladı (haberin etkisi var).',
        opts:['axivî','axiviye','diaxive','baxive'], ci:1,
        note:'"Axiviye" = konuşmuş (şimdiki mükemmel). "Serokmar" eğik değil — geçişsiz fiil!'),
      _mc(id:'b2_l02_e3',
        ku:'"Min nivîsandiye" vs "min nivîsand" — hangisi daha az kesin?',
        tr:'Doğru açıklamayı seç',
        opts:['Nivîsandiye daha az kesin — belirsiz geçmiş','Aynı anlam','Nivîsand daha az kesin','Hangisi olursa'],
        ci:0, note:'"Nivîsandiye" = yazmış (muhtemelen) — şimdiki mükemmel zaman daha belirsiz. "Nivîsand" = yazdı (kesin geçmiş).'),
      _speak(id:'b2_l02_e4',
        ku:'Wî gotiye ku pirsgirêk çêbûye. Me bîstiye û me fêm kiriye.',
        tr:'O sorunun çıktığını söylemiş. Biz duyduk ve anladık.'),
    ],
  ),

  LessonModel(
    id: 'b2_l03',
    kurmanjTitle: 'Geçmiş Mükemmel — Hikâye Anlatımı',
    turkishTitle: 'Geçmiş Mükemmel: Anlatı Dili',
    unitNumber: 1, lessonNumber: 3, level: 4,
    path: LessonPath.heritage,
    targetCardIds: [],
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l03_e1',
        ku:'"Ew çûbû, dema ku em hatim" — zaman ilişkisi nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Aynı anda','O gitmişti (daha önce), biz geldik (sonra)','Gelecek','Biz gitmişiz'],
        ci:1, note:'"Çûbû" = gitmiş bulunuyordu. Geçmişte daha önce olan eylem için "-ibû" eki.'),
      _fill(id:'b2_l03_e2', before:'Min pirtûk', after:', berî ku tu bêyî.',
        tr:'Sen gelmeden önce ben kitabı okumuştum.',
        opts:['xwend','xwendibû','dixwend','xwendiye'], ci:1,
        note:'"Xwendibû" = okumuş bulunuyordu (geçmiş mükemmel). Zaman dizisini netleştirir.'),
      _ls(id:'b2_l03_e3',
        ku:'Pîrê gotibû ku ziman jiyan e.',
        tr:'Bu cümle ne anlama gelir?',
        opts:['Büyükanne söyleyecek','Büyükanne söylemişti (önce)','Büyükanne söylüyor','Büyükanne söylemiş'],
        ci:1, audio:'assets/audio/b2/pire_gotibü.mp3',
        note:'"Gotibû" — ergatif (wê) zaten anlaşılıyor + geçmiş mükemmel.'),
      _speak(id:'b2_l03_e4',
        ku:'Ew gotibû ku bila em berdewam bikin. Me ew gotin bîstibû û şa bibûn.',
        tr:'O devam etmemiz gerektiğini söylemişti. Biz o sözü duymuştuk ve mutlu olmuştuk.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 2 — Pasif Yapı Tam Sistem (3 ders)
  // [BH] §193 + [TH] §82
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l04',
    kurmanjTitle: 'Tê Gotin — Pasif Şimdiki',
    turkishTitle: 'Edilgen Yapı: Üç Zaman',
    unitNumber: 2, lessonNumber: 1, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['pasif']),
    estimatedMinutes: 14,
    exercises: [
      _mc(id:'b2_l04_e1',
        ku:'Pasif yapının üç zamanı nedir?',
        tr:'Doğru sırayı seç',
        opts:['Geçmiş/şimdiki/gelecek','tê kirin / hate kirin / dê bête kirin','bê kirin / te kirin / hê kirin','Yalnızca şimdiki'],
        ci:1, note:'"Tê kirin" = yapılıyor, "hate kirin" = yapıldı, "dê bête kirin" = yapılacak. [TH] §82'),
      _fill(id:'b2_l04_e2', before:'Tê gotin ku', after:'xweş e.',
        tr:'Kürdistanın güzel olduğu söyleniyor.',
        opts:['Kurdistan','Kurdistanê','Kurdistana','ya Kurdistan'], ci:0,
        note:'"Tê gotin ku" = denilir ki. Pasif şimdiki. Özne "ku" bağlacıyla bağlı cümle.'),
      _fill(id:'b2_l04_e3', before:'Biryar', after:'hat standin.',
        tr:'Karar alındı.',
        opts:['hate','hat','tê','dê'], ci:1,
        note:'"Hat standin" = alındı (geçmiş pasif). "Standin" = almak.'),
      _fill(id:'b2_l04_e4', before:'Rêkxistina nû', after:'ava kirin.',
        tr:'Yeni örgüt kurulacak.',
        opts:['tê','hate','dê bête','bê'], ci:2,
        note:'"Dê bête ava kirin" = kurulacak (gelecek pasif).'),
      _speak(id:'b2_l04_e5',
        ku:'Tê gotin ku guhertin tê. Pirsgirêk hate dîtin û çaraser dê bête kirin.',
        tr:'Değişimin geleceği söyleniyor. Sorun görüldü ve çözüm yapılacak.'),
    ],
  ),

  LessonModel(
    id: 'b2_l05',
    kurmanjTitle: 'Wek Ku Tê Zanîn',
    turkishTitle: 'Bilindiği Gibi — Gazete Pasifi',
    unitNumber: 2, lessonNumber: 2, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['pasif', 'medya']).take(5).toList(),
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l05_e1',
        ku:'"Wek ku tê zanîn" ifadesi nerede kullanılır?',
        tr:'Doğru bağlamı seç',
        opts:['Selamlaşmada','Gazete girişi olarak — bilindiği gibi','Soru cümlesi','İstek kipi'],
        ci:1, note:'"Wek ku tê zanîn" = bilindiği gibi. Gazete ve resmi yazının açılış kalıbı.'),
      _fill(id:'b2_l05_e2', before:'Wek ku', after:', ziman bingeha çandê ye.',
        tr:'Bilindiği gibi, dil kültürün temelidir.',
        opts:['tê gotin','tê zanîn','hate gotin','dê bête gotin'], ci:1),
      _mc(id:'b2_l05_e3',
        ku:'"Hate ragihandin" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Açıklıyor','Açıklanacak','Açıklandı (geçmiş pasif)','Açıklanıyor'],
        ci:2, note:'"Hate" = hatin geçmiş 3.tekil → geçmiş pasif.'),
      _speak(id:'b2_l05_e4',
        ku:'Wek ku tê zanîn, zimanê kurdî qedîm e. Hate gotin ku em divê wî biparêzin.',
        tr:'Bilindiği gibi, Kürt dili kadimdir. Onu korumalıyız dendi.'),
    ],
  ),

  LessonModel(
    id: 'b2_l06',
    kurmanjTitle: 'Pasif û Têkçûn',
    turkishTitle: 'Pasif ve Asimilasyon',
    unitNumber: 2, lessonNumber: 3, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['pasif']).skip(2).toList(),
    estimatedMinutes: 12,
    exercises: [
      _fill(id:'b2_l06_e1', before:'Zimanê kurdî', after:'hate kirin.',
        tr:'Kürt dili yasaklandı (edilgen).',
        opts:['qedexe','qedexekirî','qedexe kirin','qedexe bû'], ci:0,
        note:'"Qedexe kirin" = yasaklamak. "Qedexe hate kirin" = yasaklandı (geçmiş pasif).'),
      _mc(id:'b2_l06_e2',
        ku:'"Têkçûn" pasif mi aktif mi?',
        tr:'Doğru analiz',
        opts:['Tamamen pasif','Tamamen aktif','Hem pasif hem aktif anlam taşıyabilir','Hiçbiri'],
        ci:2, note:'"Têkçûn" = asimilasyon: hem "erimek" (kendi iradesiyle — aktif) hem "eritilmek" (dışardan — pasif).'),
      _speak(id:'b2_l06_e3',
        ku:'Tê zanîn ku ziman hate qedexekirin. Lê niha bête guhistin — em vedigerin!',
        tr:'Dilin yasaklandığı bilinmektedir. Ama şimdi değiştirilecek — biz dönüyoruz!'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 3 — Bileşik Fiiller (2 ders)
  // [BH] §200–210 + [FB] compound verbs
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l07',
    kurmanjTitle: 'Li Ber Ketin — Bileşik Fiiller I',
    turkishTitle: 'Bileşik Fiiller: Çaba ve Başarı',
    unitNumber: 3, lessonNumber: 1, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['bileşik_leker']).take(4).toList(),
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l07_e1',
        ku:'"Li ber ketin" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Düşmek','Çalışmak/Uğraşmak','Kalkmak','Yatmak'],
        ci:1, note:'"Li ber" (karşısına) + "ketin" (düşmek) = üzerinde çalışmak/uğraşmak. [FB] compound.'),
      _mc(id:'b2_l07_e2',
        ku:'"Ser ketin" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Sırtüstü düşmek','Başarmak/Üstün gelmek','Yorulmak','Başlamak'],
        ci:1, note:'"Ser" (üst) + "ketin" (düşmek) = üstüne düşmek → başarmak.'),
      _fill(id:'b2_l07_e3', before:'Em li ber pirsgirêkê', after:'û ser dikevim.',
        tr:'Sorun üzerinde çalışıyoruz ve başarıyoruz.',
        opts:['dikevim','dikevin','ketin','ket'], ci:1,
        note:'"Dikevin" = çoğul şimdiki. "Li ber dikevin û ser dikevin."'),
      _speak(id:'b2_l07_e4',
        ku:'Em li ber zehmetiyê dikevim — lê em dê ser bikevin. Bila bijî!',
        tr:'Zorluğun üstesinden gelmeye çalışıyoruz — ama başaracağız. Yaşasın!'),
    ],
  ),

  LessonModel(
    id: 'b2_l08',
    kurmanjTitle: 'Dest Avêtin — Bileşik Fiiller II',
    turkishTitle: 'Bileşik Fiiller: Başlama ve Sessizlik',
    unitNumber: 3, lessonNumber: 2, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['bileşik_leker']).skip(3).toList(),
    estimatedMinutes: 12,
    exercises: [
      _mc(id:'b2_l08_e1',
        ku:'"Dest avêtin" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Elden bırakmak','Başlamak/Girişmek','Desteklemek','Tutmak'],
        ci:1, note:'"Dest" (el) + "avêtin" (atmak) = ele almak → başlamak. [BH] §200.'),
      _mc(id:'b2_l08_e2',
        ku:'"Ziman girtin" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Dil öğrenmek','Susup kalmak','Konuşmak','Söylemek'],
        ci:1, note:'"Ziman" (dil) + "girtin" (tutmak) = dilini tutmak → susmak.'),
      _fill(id:'b2_l08_e3', before:'Ji nû ve em', after:'xwendinê.',
        tr:'Yeniden öğrenmeye başladık.',
        opts:['dest avêtin','ser ketin','ziman girtin','bi xêr ketin'], ci:0),
      _speak(id:'b2_l08_e4',
        ku:'Em dest avêtin hînbûna Kurmancî. Ziman negirin — biaxivin!',
        tr:'Kurmancî öğrenmeye başladık. Susup kalmayın — konuşun!'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 4 — Şartlı Cümle İleri (2 ders)
  // [BH] §192 + [TH] §79
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l09',
    kurmanjTitle: 'Ger Bûya — Gerçekleşmemiş Şart',
    turkishTitle: 'Gerçekleşmemiş Koşul',
    unitNumber: 4, lessonNumber: 1, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['şart']).take(3).toList(),
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l09_e1',
        ku:'"Ger dizanibûm, nedigotim" yapısı nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Gelecek şart','Gerçekleşmiş şart','Gerçekleşmemiş geçmiş şart','Pasif şart'],
        ci:2, note:'"Ger … -ibûm, ne-di-…-im" = bilseydim söylemezdim. Hipotetik geçmiş. [BH] §192.'),
      _fill(id:'b2_l09_e2', before:'Ger pîrê', after:', em gelek şa dibûn.',
        tr:'Büyükanne olsaydı, çok mutlu olurduk.',
        opts:['hatibûya','hatibe','bête','hat'], ci:0,
        note:'"Hatibûya" = gelseydi (gerçekleşmemiş şart). "-ibûya" eki.'),
      _mc(id:'b2_l09_e3',
        ku:'"Heya ku" ile "ger" farkı nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Aynı anlam','Heya ku = sürece, ger = eğer (şart)','Tersine','İkisi de şart'],
        ci:1, note:'"Heya ku dijim" = yaşadığım sürece. "Ger bêyî" = gelirsen. Farklı işlevler.'),
      _speak(id:'b2_l09_e4',
        ku:'Ger min berê Kurmancî hîn kiribûya, îro baştir bidizanîm.',
        tr:'Kurmancîyi önce öğrenmiş olsaydım, bugün daha iyi bilirdim.'),
    ],
  ),

  LessonModel(
    id: 'b2_l10',
    kurmanjTitle: 'Çawa Ku — Karşılaştırma ve Analoji',
    turkishTitle: 'İleri Karşılaştırma Yapıları',
    unitNumber: 4, lessonNumber: 2, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['şart']).skip(2).toList(),
    estimatedMinutes: 12,
    exercises: [
      _mc(id:'b2_l10_e1',
        ku:'"Ji dema ku" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['O zaman','O zamandan beri','Eğer','Nasıl ki'],
        ci:1, note:'"Ji dema ku hatim" = geldiğimden beri. Süre başlangıcını gösterir.'),
      _fill(id:'b2_l10_e2', before:'Ji dema ku Kurmancî hîn dibim,', after:'baştir im.',
        tr:'Kurmancî öğrendiğimden beri daha iyiyim.',
        opts:['gelek','pir','her roj','car'], ci:2,
        note:'"Her roj baştir im" = her gün daha iyiyim. Süreç vurgusu.'),
      _speak(id:'b2_l10_e3',
        ku:'Ji dema ku ez dest bi xwendina Kurmancî kir, nasnameya xwe baştir fêm dikim.',
        tr:'Kurmancî okumaya başladığımdan beri kimliğimi daha iyi anlıyorum.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 5 — Gazete ve Resmi Dil (3 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l11',
    kurmanjTitle: 'Rojnameyê Dixwînim',
    turkishTitle: 'Gazete Okuyorum',
    unitNumber: 5, lessonNumber: 1, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['medya']),
    estimatedMinutes: 13,
    exercises: [
      _ls(id:'b2_l11_e1', ku:'Kovar',
        tr:'Ne anlama gelir?',
        opts:['Kitap','Dergi/Journal','Gazete','Roman'],
        ci:1, audio:'assets/audio/b2/kovar.mp3',
        note:'"Kovara Hawarê" (1932) = Bedir Han\'ın yayımladığı tarihî dergi.'),
      _mc(id:'b2_l11_e2',
        ku:'"Nûçegiran" kim?',
        tr:'Doğru tanımı seç',
        opts:['Okuyucu','Gazeteci/Muhabir','Yayıncı','Editör'],
        ci:1, note:'"Nûçe" (haber) + "giran" (önemli eden kişi).'),
      _fill(id:'b2_l11_e3', before:'', after:'nivîsand ku guhertin hatiye.',
        tr:'Gazeteci değişimin geldiğini yazdı.',
        opts:['Nûçegiran','Bijîşk','Mamosta','Bazirgan'], ci:0,
        note:'"Nûçegiran nivîsand" — geçişli ergatif: "nûçegiran" özne eğik değil çünkü isim.'),
      _speak(id:'b2_l11_e4',
        ku:'Ez rojname û kovarên kurdî dixwînim. Ragihandina kurdî mezin dibe.',
        tr:'Kürtçe gazete ve dergi okuyorum. Kürt medyası büyüyor.'),
    ],
  ),

  LessonModel(
    id: 'b2_l12',
    kurmanjTitle: 'Zimanê Fermî — Resmi Dil',
    turkishTitle: 'Resmi Dil Kalıpları',
    unitNumber: 5, lessonNumber: 2, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['soyut', 'zagon']).take(6).toList(),
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l12_e1',
        ku:'"Li gorî zagonê" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Kanuna rağmen','Kanuna göre','Kanun olmadan','Kanunu değiştirmek'],
        ci:1, note:'"Li gorî" = göre. "Zagon" = kanun. Resmi ve hukuki metinlerde sık.'),
      _fill(id:'b2_l12_e2', before:'Dadmendiyê', after:'ye.',
        tr:'Bu adaletin yükümlülüğüdür.',
        opts:['erkê','peywira','karê','daxwaza'], ci:1,
        note:'"Peywira dadmendiyê" = adaletin görevi/yükümlülüğü.'),
      _mc(id:'b2_l12_e3',
        ku:'"Nîqaş" kelimesi hangi bağlamda kullanılır?',
        tr:'Doğru bağlamı seç',
        opts:['Günlük selamlama','Resmi tartışma/müzakere','Yemek','Alışveriş'],
        ci:1, note:'"Nîqaş" = tartışma/müzakere. "Nîqaşa demokratîk" = demokratik tartışma.'),
      _speak(id:'b2_l12_e4',
        ku:'Li gorî dadmendiyê, mafê zimanê xwe hîn bûn mafê her kesî ye.',
        tr:'Adalet ilkesine göre, kendi dilini öğrenme hakkı herkesin hakkıdır.'),
    ],
  ),

  LessonModel(
    id: 'b2_l13',
    kurmanjTitle: 'Siyaset û Ziman',
    turkishTitle: 'Siyaset ve Dil',
    unitNumber: 5, lessonNumber: 3, level: 4,
    path: LessonPath.general,
    targetCardIds: _b2Cards(['zagon', 'soyut']).skip(4).toList(),
    estimatedMinutes: 12,
    exercises: [
      _mc(id:'b2_l13_e1',
        ku:'"Demokrasî" kelimesi Kurmancîde nasıl kullanılır?',
        tr:'Doğru açıklamayı seç',
        opts:['Hiç kullanılmaz','Dişil — "demokrasiya kurdî" = Kürt demokrasisi','Eril','Değişmez'],
        ci:1, note:'Uluslararası terimler genellikle dişil: "demokrasî" n.f.'),
      _fill(id:'b2_l13_e2', before:'Azadî û', after:'ji hev cuda nîne.',
        tr:'Özgürlük ve barış birbirinden ayrı değildir.',
        opts:['şer','aştî','maf','çand'], ci:1,
        note:'"Azadî û aştî" = özgürlük ve barış. Kürt siyasi söyleminin iki ana kavramı.'),
      _speak(id:'b2_l13_e3',
        ku:'Siyaset bê ziman nabe. Ziman siyaseta herî mezin e.',
        tr:'Siyaset dilsiz olmaz. Dil en büyük siyasettir.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 6 — Kürt Edebiyatı Derin Okuma (3 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l14',
    kurmanjTitle: 'Mem û Zîn — Derin Okuma',
    turkishTitle: 'Mem û Zîn: Edebi Analiz',
    unitNumber: 6, lessonNumber: 1, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['edebiyat']).take(4).toList(),
    culturalRewardId: 'c_011',
    estimatedMinutes: 15,
    exercises: [
      _ls(id:'b2_l14_e1',
        ku:'Mem û Zîn di sala 1695an de hate nivîsandin.',
        tr:'Bu cümleyi analiz et',
        opts:['Aktif cümle','Geçmiş pasif: yazıldı','Şimdiki pasif','Gelecek'],
        ci:1, audio:'assets/audio/b2/mem_zin.mp3',
        note:'"Hate nivîsandin" = yazıldı. Geçmiş pasif. "Di sala 1695an de" = 1695\'te.'),
      _mc(id:'b2_l14_e2',
        ku:'"Dilsoz" kelimesi Mem û Zîn\'de ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Dilli','Sadık/Vefakâr','Sevimli','Güçlü'],
        ci:1, note:'"Dil" (gönül) + "soz" (söz) → sadık/vefakâr. Mem\'in Zîn\'e bağlılığı.'),
      _fill(id:'b2_l14_e3', before:'Mem ji Zîn re', after:'bû.',
        tr:'Mem Zîn\'e sadık kaldı/oldu.',
        opts:['dilsoz','bengî','xerîb','wêrek'], ci:0),
      _mc(id:'b2_l14_e4',
        ku:'Xanî Mem û Zîn\'i neden yazdı?',
        tr:'Doğru açıklamayı seç',
        opts:['Sadece aşk hikâyesi','Kürt birliği için çağrı + Kürtçeyi belgelemek','Dini metin','Sözlük'],
        ci:1, note:'Xanî önsözde Kürtlerin birleşmesi için çağrı yapar — edebiyat + siyasi mesaj.'),
      _speak(id:'b2_l14_e5',
        ku:'Mem û Zîn ne tenê kilameke aşqê ye — dengê miletê kurd e.',
        tr:'Mem û Zîn sadece bir aşk hikâyesi değil — Kürt milletinin sesidir.'),
    ],
  ),

  LessonModel(
    id: 'b2_l15',
    kurmanjTitle: 'Cegerxwîn — Şiir Çözümlemesi',
    turkishTitle: 'Cegerxwîn: Şiir Analizi',
    unitNumber: 6, lessonNumber: 2, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['edebiyat']).skip(4).toList(),
    culturalRewardId: 'c_a2_001',
    estimatedMinutes: 14,
    exercises: [
      _mc(id:'b2_l15_e1',
        ku:'Cegerxwîn kimdir?',
        tr:'Doğru tanımı seç',
        opts:['Dilbilimci','Modern Kurmancî şiirinin öncüsü (1903–1984)','Dengbêj','Siyasetçi'],
        ci:1),
      _ls(id:'b2_l15_e2',
        ku:'Kurdistan welê min e, çiyayên wê çiyayên min in.',
        tr:'Bu dizede hangi dilbilgisi yapısı var?',
        opts:['Pasif yapı','İyelik + sıfat cümlesi','Ergatif','Subjunctive'],
        ci:1, audio:'assets/audio/b2/cegerxwin_dize.mp3',
        note:'"Wê" = onun (dişil iyelik). "Çiyayên wê" = onun dağları.'),
      _fill(id:'b2_l15_e3', before:'Zimanê min qedîm e,', after:'çiyayan hat gotin.',
        tr:'Dilim kadimdir, dağların tepesinde söylenmiştir.',
        opts:['li serê','di bin','li kêleka','di nava'], ci:0,
        note:'"Li serê çiyayan" = dağların tepesinde. "Hat gotin" = söylendi (pasif geçmiş).'),
      _speak(id:'b2_l15_e4',
        ku:'Wek Cegerxwîn gotiye: ziman û welat ji hev cuda nabin.',
        tr:'Cegerxwîn\'in dediği gibi: dil ve vatan birbirinden ayrılmaz.'),
    ],
  ),

  LessonModel(
    id: 'b2_l16',
    kurmanjTitle: 'Atasözleri — Derin Analiz',
    turkishTitle: 'Atasözleri: Dil ve Kültür',
    unitNumber: 6, lessonNumber: 3, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['pêşgotin']),
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l16_e1',
        ku:'"Erzan kirî, biha ferya dike" atasözü ne anlatır?',
        tr:'Doğru yorumu seç',
        opts:['Alışverişi reddet','Kalitesiz şeyler sonunda pahalıya mal olur','Her zaman ucuz al','Fiyat önemli değil'],
        ci:1, note:'"Ferya kirin" = feryat etmek/ağlamak. Kalite ve değer hakkında.'),
      _mc(id:'b2_l16_e2',
        ku:'"Gund bê bav weke mal bê xwe ye" — bu atasözündeki dilbilgisi?',
        tr:'Doğru analizi seç',
        opts:['Pasif yapı','Karşılaştırma: weke (gibi)','Ergatif','Subjunctive'],
        ci:1, note:'"Weke" = gibi. Karşılaştırma bağlacı. "Bav" = lider/baba burada.'),
      _ls(id:'b2_l16_e3',
        ku:'Cet di riya avê de dişkê.',
        tr:'Bu atasözünü tanı',
        opts:['Teşti su yolunda kırılır','Su kaynaktan akar','Taş suyun içinde','Yol uzundur'],
        ci:0, audio:'assets/audio/b2/peshgotin.mp3',
        note:'"Cet" = testi, "dişkê" = kırılır. "Herkes kendi yolunda hedefe ulaşır."'),
      _speak(id:'b2_l16_e4',
        ku:'Pêşgotinên kurdî pirtûkên tarîxê ne — her yekê pêşgotinek jiyanê ye.',
        tr:'Kürt atasözleri tarih kitaplarıdır — her biri bir hayat dersidir.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 7 — Kimlik ve Diaspora (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l17',
    kurmanjTitle: 'Nasnameya Diasporayê',
    turkishTitle: 'Diaspora Kimliği',
    unitNumber: 7, lessonNumber: 1, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['soyut']).take(5).toList(),
    estimatedMinutes: 13,
    exercises: [
      _mc(id:'b2_l17_e1',
        ku:'"Nasname" kelimesinin kökeni nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Arapça','nas (tanıma) + name (belge/yazı) — Kurmancî özgün','Farsça','İngilizce'],
        ci:1, note:'"Nas" = tanımak + "name" = belge. Kimlik belgesi → kimlik.'),
      _fill(id:'b2_l17_e2', before:'Nasnameya kurdî li', after:'û welatên din tê jiyandin.',
        tr:'Kürt kimliği diasporada ve diğer ülkelerde yaşanıyor.',
        opts:['gurbetê','bajêr','gundê','dibistanê'], ci:0,
        note:'"Gurbet" = gurbet/diaspora. "Li gurbetê" = gurbette.'),
      _mc(id:'b2_l17_e3',
        ku:'"Nasnameya cot" heritage öğrenici için ne anlama gelir?',
        tr:'Doğru açıklamayı seç',
        opts:['Çift pasaport','Hem Kürt hem başka ülkenin kültüründe yaşamak','İki dil','İki ülke'],
        ci:1, note:'"Nasnameya cot" = çift kimlik. Diaspora Kürtlerinin günlük gerçekliği.'),
      _speak(id:'b2_l17_e4',
        ku:'Ez li du cîhanan dijim — nasnameya min cot e. Lê zimanê min yek e: Kurmancî.',
        tr:'İki dünyada yaşıyorum — kimliğim çift. Ama dilim tektir: Kurmancî.'),
    ],
  ),

  LessonModel(
    id: 'b2_l18',
    kurmanjTitle: 'Gurbet û Bîranîn',
    turkishTitle: 'Gurbet ve Hatıra',
    unitNumber: 7, lessonNumber: 2, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['edebiyat']).skip(2).toList(),
    estimatedMinutes: 12,
    exercises: [
      _mc(id:'b2_l18_e1',
        ku:'"Gurbet" ve "koçberî" farkı nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Aynı anlam','Gurbet = yurt dışı hissi, koçberî = fiziksel göç süreci','Tersine','Her ikisi de fiziksel'],
        ci:1, note:'"Gurbet" duygusal/psikolojik — yabancılık hissi. "Koçberî" hareket/göç süreci.'),
      _fill(id:'b2_l18_e2', before:'Bîranînên min', after:'li welatê xwe dimînin.',
        tr:'Hatıralarım daima vatanımda kalır.',
        opts:['timî','caran','kêm','zêde'], ci:0),
      _speak(id:'b2_l18_e3',
        ku:'Em xerîb in, lê em jibîr nakin. Bîranîn û ziman bi hev re welatê me yê duyem in.',
        tr:'Garip olsak da unutmayız. Hatıralar ve dil birlikte ikinci vatanımızdır.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // ÜNİTE 8 — Sentez ve Çıktı (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'b2_l19',
    kurmanjTitle: 'Bi Kurmancî Biaxivin!',
    turkishTitle: 'Kurmancî Konuşuyorum — İleri Pratik',
    unitNumber: 8, lessonNumber: 1, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['bileşik_leker', 'deyim']).take(6).toList(),
    estimatedMinutes: 15,
    exercises: [
      _mc(id:'b2_l19_e1',
        ku:'B2\'de öğrenilen en önemli yapılar neler?',
        tr:'Doğru listeyi seç',
        opts:['Sadece kelimeler','Pasif sistem, bileşik fiiller, şartlı cümle, ergatif nüanslar','Yalnızca gramer','Yalnızca kültür'],
        ci:1),
      _fill(id:'b2_l19_e2', before:'Tê zanîn ku ziman', after:'e û em divê wî biparêzin.',
        tr:'Bilindiği gibi dil değerlidir ve onu korumalıyız.',
        opts:['biha','girîng','zehmet','hêz'], ci:1),
      _speak(id:'b2_l19_e3',
        ku:'Wek ku tê zanîn, zimanê kurdî li ber zehmetiyên mezin ser ketiye. Em berdewam dikin!',
        tr:'Bilindiği gibi, Kürt dili büyük zorluklara rağmen başardı. Devam ediyoruz!'),
    ],
  ),

  LessonModel(
    id: 'b2_l20',
    kurmanjTitle: 'Ziman Jiyan e — B2 Dawî',
    turkishTitle: 'Dil Hayattır — B2 Finali',
    unitNumber: 8, lessonNumber: 2, level: 4,
    path: LessonPath.heritage,
    targetCardIds: _b2Cards(['soyut', 'edebiyat']).take(6).toList(),
    estimatedMinutes: 15,
    exercises: [
      _mc(id:'b2_l20_e1',
        ku:'A1\'den B2\'ye öğrenme yolculuğunda en kritik kavramlar?',
        tr:'Doğru özeti seç',
        opts:['Yalnızca kelimeler','Ergatif + pasif + bileşik fiil + kimlik + edebiyat','Yalnızca kültür','Yalnızca gramer'],
        ci:1),
      _ls(id:'b2_l20_e2',
        ku:'Ziman mirov e, mirov ziman e.',
        tr:'Bu söz kimin?',
        opts:['Bedir Han','Cegerxwîn — modern Kurmancî şiiri','Ehmedê Xanî','Dengbêj Şakiro'],
        ci:1, audio:'assets/audio/b2/ziman_mirov.mp3'),
      _fill(id:'b2_l20_e3', before:'Ji dema ku min Kurmancî hîn kir,', after:'me dizanim.',
        tr:'Kurmancî öğrendiğimden beri kimin olduğumuzu biliyoruz.',
        opts:['kî','çi','kû','çawa'], ci:0,
        note:'"Kî em in" = kim olduğumuzu. Kimlik sorusu — B2 sonunda cevap.'),
      _speak(id:'b2_l20_e4',
        ku:'Wî gotiye, wê got, me bîst û em fêm kirin: ziman jiyan e. Bila bijî Kurmancî!',
        tr:'O dedi, o söyledi, biz duyduk ve anladık: dil hayattır. Yaşasın Kurmancî!'),
      _speak(id:'b2_l20_e5',
        ku:'Ez serbilind im. Nasnameya min dewlemend e. Zimanê min xweş e. Ez kurd im!',
        tr:'Gururluyum. Kimliğim zengindir. Dilim güzeldir. Ben Kürdüm!'),
    ],
  ),

]; // kB2Lessons son

LessonModel? getB2LessonById(String id) {
  try { return kB2Lessons.firstWhere((l) => l.id == id); }
  catch (_) { return null; }
}

  // ── ÜNİTE 3: EDEBİYAT VE KÜLTÜR (7 ders) ────────────────────

  LessonModel(
    id: 'b2_l21', level: 4, unitNumber: 3, lessonNumber: 1,
    kurmanjTitle: 'Mem û Zîn — Analîza Metnê',
    turkishTitle: 'Mem û Zîn — Metin Analizi',
    description: 'Xanî\'nin başyapıtının edebi çözümlemesi',
    vocabulary: ['b2_t05','b2_t01','b2_t02','b2_t03','c1_040','c1_044'],
    grammarNote: 'Analiz kaliplar B2: "Metnê nîşan dide ku..." "Nivîskar destnîşan dike..." "Ji dîtina min..." Referans: "Li gorî Xanî (1695)..." Pasif yapılar: "Hatîye nivîsandin ku..."',
    culturalNote: 'Mem û Zîn 1695 yılinda yazildi. Kürdistan\'in Romeo ve Juliet\'i ama siyasi mesaji daha derin: "Kurd neden birleşmiyor?" sorusu.',
    exercises: [
      LessonExercise(id:'b2_l21_e1', type:ExerciseType.translate,
        content:'Xanî bu eserinde Kürt birliğini savundu.',
        correctAnswer:'Xanî di vê berhemê de yekîtîya kurdî parast.', options:[]),
      LessonExercise(id:'b2_l21_e2', type:ExerciseType.speak,
        content:'Mem û Zîn çima girîng e?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l22', level: 4, unitNumber: 3, lessonNumber: 2,
    kurmanjTitle: 'Dengbêjî û Hafizaya Gelêrî',
    turkishTitle: 'Dengbêjlik ve Halk Hafızası',
    description: 'Dengbêj geleneği — kolektif hafıza aracı',
    vocabulary: ['b1_ed01','b1_ed02','b2_551','b2_552'],
    grammarNote: 'B2 pasif yapisi: "Dengbêjî wek miras hatîye parastin." "Kilamên dîrokî di bîranîna gelê kurd de cihê xwe girtîye." Dilbilgisel zaman: hatîye + sıfat fiil yapısı.',
    culturalNote: 'Dengbêjlik UNESCO korumasinda (2022). Kars, Sirnak, Yerevan\'da yasayan örnekler.',
    exercises: [
      LessonExercise(id:'b2_l22_e1', type:ExerciseType.speak,
        content:'Dengbêjî hafizaya gelê kurd çawa diparêze?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l23', level: 4, unitNumber: 3, lessonNumber: 3,
    kurmanjTitle: 'Wêjeya Nûjen a Kurdî',
    turkishTitle: 'Modern Kürt Edebiyatı',
    description: '20. yüzyıl Kürt edebiyatı — Cegerxwîn, Cigerxwîn, Kawa',
    vocabulary: ['b2_t04','b2_t03','c1_043'],
    grammarNote: 'Edebi metin dili B2: dolaysilik (inferential) kullanimi: "Helbet ev wusa nîne..." Tartisma kaliplar: "Ji aliyek ve... ji aliyê din ve..."',
    culturalNote: 'Cegerxwîn, Cigerxwîn farkli kisi — Cegerxwîn (1903-1984) siyas, Cigerxwîn ayri sanatci.',
    exercises: [
      LessonExercise(id:'b2_l23_e1', type:ExerciseType.speak,
        content:'Wêjeya nûjen a kurdî çi taybetî hene?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l24', level: 4, unitNumber: 3, lessonNumber: 4,
    kurmanjTitle: 'Sînema û Hunerên Dîtbarî',
    turkishTitle: 'Sinema ve Görsel Sanatlar',
    description: 'Kürt sineması ve görsel sanatlar',
    vocabulary: ['b2_321','b2_322','b2_t11','b2_t12'],
    grammarNote: 'Sinema kritik dili: "Filim nîşan dide ku..." "Derhêner armanc dike ku..." "Xweşbnasîya wêneyî" (görsel estetik).',
    culturalNote: 'Yilmaz Güney (Yol, 1982), Bahman Ghobadi (Kaplumbaglalar da Uçabilir). Kürt sinemasi dünya standartinda.',
    exercises: [
      LessonExercise(id:'b2_l24_e1', type:ExerciseType.speak,
        content:'Sînemaya kurdî çawa mezin dibe?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l25', level: 4, unitNumber: 3, lessonNumber: 5,
    kurmanjTitle: 'Atasözleri û Deyimên Kurdî',
    turkishTitle: 'Kürt Atasözleri ve Deyimler',
    description: 'Kürtçe atasözleri — anlam, kültürel bağlam, kullanım',
    vocabulary: ['b2_t16','b2_t17'],
    grammarNote: 'Atasözü yapisi: "Dilê tirsok sînga gewre nabîne" = ürkek gönül ak göğsü göremez. [BH ✓] Kalip: "Weke pêşgotinekê tê gotin ku..."',
    culturalNote: 'Kürt atasözleri halkin tarihsel hafizasini tasir. Her atasözü bir kültürel kod.',
    exercises: [
      LessonExercise(id:'b2_l25_e1', type:ExerciseType.fillBlank,
        content:'Dilê ___ sînga gewre nabîne.',
        correctAnswer:'tirsok', options:['tirsok','mêrxas','jîr','dilgerm']),
      LessonExercise(id:'b2_l25_e2', type:ExerciseType.speak,
        content:'Pêşgotinên kurdî yên ku tu dizanî bibêje.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l26', level: 4, unitNumber: 3, lessonNumber: 6,
    kurmanjTitle: 'Newroz — Çanda û Dîroka',
    turkishTitle: 'Newroz — Kültür ve Tarihi',
    description: 'Newroz\'un tarihsel kökeni ve kültürel önemi',
    vocabulary: ['b2_t04','b1_862'],
    grammarNote: 'B2 tarih dili: "Di dîrokê de tê gotin ku..." "Weke sembola azadiyê hatîye qebûlkirin." "Li gorî efsaneyê..."',
    culturalNote: 'Newroz = Kürdün Yeni Yil bayramı. Kürdistan\'da siyasi sembol. 21 Mart UNESCO tarafindan tescillendi.',
    exercises: [
      LessonExercise(id:'b2_l26_e1', type:ExerciseType.speak,
        content:'Newroz ji bo Kurdan çi wateyê dide?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l27', level: 4, unitNumber: 3, lessonNumber: 7,
    kurmanjTitle: 'Muzîka Kurdî',
    turkishTitle: 'Kürt Müziği',
    description: 'Kürt müziğinin çeşitleri — dengbêj, govend, klasik',
    vocabulary: ['b1_851','b1_852','b1_853','b1_850'],
    grammarNote: 'Müzik terminolojisi: kilam (türkü), stran (şarkı), govend (halay), dengbêj (aşık), bilûr (kaval), dawil (davul), zurna. Ayrıca: "Muzîk di çanda kurdî de rolekî bingehîn dilîze."',
    culturalNote: 'Aynur Doğan, Şivan Perwer, Ciwan Haco — diasporada Kürt müziği.',
    exercises: [
      LessonExercise(id:'b2_l27_e1', type:ExerciseType.speak,
        content:'Muzîka kurdî çi cûre heye?', correctAnswer:'', options:[]),
    ],
  ),

  // ── ÜNİTE 4: SİYASET VE HUKUK (4 ders) ────────────────────

  LessonModel(
    id: 'b2_l28', level: 4, unitNumber: 4, lessonNumber: 1,
    kurmanjTitle: 'Mafên Mirovî û Kurd',
    turkishTitle: 'İnsan Hakları ve Kürtler',
    description: 'Kürt hakları uluslararası hukuk çerçevesinde',
    vocabulary: ['b2_t19','b2_530','b2_531','b2_533'],
    grammarNote: 'Hukuk dili B2: "Li gorî maddeya ... ê peymana navnetewî..." "Ev maf hatîye qebûlkirin ku..." Pasif: "Maf hatin binpêkirin" = haklar ihlal edildi.',
    culturalNote: 'BM 1992 Azinlik Haklari Bildirgesi, ICCPR madde 27 — Kürt haklarinin hukuki dayanagi.',
    exercises: [
      LessonExercise(id:'b2_l28_e1', type:ExerciseType.translate,
        content:'Kürtçe eğitim hakkı uluslararası hukukta tanınmıştır.',
        correctAnswer:'Mafê perwerdeya kurdî di hiqûqê navnetewî de hatîye qebûlkirin.', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l29', level: 4, unitNumber: 4, lessonNumber: 2,
    kurmanjTitle: 'Siyaseta Zimanî',
    turkishTitle: 'Dil Politikası',
    description: 'Kürt dil politikaları — tarihsel süreç ve bugün',
    vocabulary: ['b2_t09','b2_t10','b2_083'],
    grammarNote: 'Siyasi dil B2: "Siyaseta zimanî ya Kurdistanê..." "Di bernameya siyasî de..." Karşitlama: "Berê... — niha..." Kaynak gösterme: "Li gorî raportê..."',
    culturalNote: '1991 öncesi Türkiye\'de Kürtçe yasak, 2003 kismen serbest, 2012 özel okullarda serbest. Kismî bir süreç.',
    exercises: [
      LessonExercise(id:'b2_l29_e1', type:ExerciseType.speak,
        content:'Siyaseta zimanî ya Kurdistanê çawa ye?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l30', level: 4, unitNumber: 4, lessonNumber: 3,
    kurmanjTitle: 'Pirsgirêka Kurdî û Çareserî',
    turkishTitle: 'Kürt Sorunu ve Çözüm',
    description: 'Farklı çözüm önerileri — eleştirel değerlendirme',
    vocabulary: ['b2_t06','b2_t07','b2_t08','b2_t09','b2_t10'],
    grammarNote: 'Tartisma dili B2: "Hin pirsên bingehîn hene..." "Ji aliyê din ve..." "Çareserîya herî baş..." "Lê pirsgirêk ev e ku..." Sonuç: "Weke encamekê..."',
    culturalNote: 'Farkli çözüm önerileri: federalizm, özerklik, kültürel haklar, tam bagimsizlik — her biri tartismalı.',
    exercises: [
      LessonExercise(id:'b2_l30_e1', type:ExerciseType.speak,
        content:'Pirsgirêka kurdî çi ye û çareserî çi dibe?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l31', level: 4, unitNumber: 4, lessonNumber: 4,
    kurmanjTitle: 'Parastina Mafên Zimanî',
    turkishTitle: 'Dil Haklarının Korunması',
    description: 'Dil hakları savunuculuğu — pratik ve teorik',
    vocabulary: ['b2_t19','b2_541','b2_542'],
    grammarNote: 'Savunuculuk dili: "Divê em..." "Em daxwaz dikin ku..." "Heta niha nehatîye kirin..." Dilekçe dili: "Bi hêvî ku..."',
    culturalNote: 'Dil haklari için örnek örgütler: Kurdish Human Rights Project, Heyva Sor a Kurdistanê.',
    exercises: [
      LessonExercise(id:'b2_l31_e1', type:ExerciseType.speak,
        content:'Mafên zimanî çawa têne parastin?', correctAnswer:'', options:[]),
    ],
  ),

  // ── ÜNİTE 5: DİL GELİŞİMİ (4 ders) ─────────────────────────

  LessonModel(
    id: 'b2_l32', level: 4, unitNumber: 5, lessonNumber: 1,
    kurmanjTitle: 'Standardkirina Zimanê Kurdî',
    turkishTitle: 'Kürtçenin Standardizasyonu',
    description: 'Hawar alfabesi, standart Kurmancî — tarih ve bugün',
    vocabulary: ['b2_521','b2_572'],
    grammarNote: 'Standartizasyon tarihi: 1932 Hawar dergisi, Bedir Han alfabesi. Tartisma: Kuzey vs. Güney dialekt farki. "Di warê standardkirinê de nakokî hene."',
    culturalNote: '1932 Hawar = Kürtçe için devrim. Latin alfabesi Bedir Han tarafindan getirildi.',
    exercises: [
      LessonExercise(id:'b2_l32_e1', type:ExerciseType.speak,
        content:'Standardkirina zimanê kurdî çima girîng e?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l33', level: 4, unitNumber: 5, lessonNumber: 2,
    kurmanjTitle: 'Teknolojî û Zimanê Kurdî',
    turkishTitle: 'Teknoloji ve Kürtçe',
    description: 'Kürtçenin dijital dünyada varlığı',
    vocabulary: ['b2_543','b2_542'],
    grammarNote: 'Teknoloji dili: "Di warê dîjîtal de ziman..." "Rûpelan bi kurdî hatine amadekirin." "Bernameyan bi kurdî tên bikaranîn."',
    culturalNote: 'Wikipedia Kürtçe, Google Translate Kürtçe, iOS/Android Kürtçe — gelisen ama eksik dijital varlik.',
    exercises: [
      LessonExercise(id:'b2_l33_e1', type:ExerciseType.speak,
        content:'Zimanê kurdî di teknolojiyê de cihê xwe çawa digire?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l34', level: 4, unitNumber: 5, lessonNumber: 3,
    kurmanjTitle: 'Peyvsazîya Kurdî',
    turkishTitle: 'Kürtçe Kelime Türetme',
    description: 'Yeni Kürtçe kelimeler türetme yöntemleri',
    vocabulary: ['b2_572','b2_571','b2_570'],
    grammarNote: 'Türetme ekleri [BH §270-275]: -vanî (meslek), -zan (bilen), -dar (sahip), -geh (yer), -name (yazı), -î (soyut), -ak, -ên, -tî. Örnek: Kompîtur + vanî = Kompîturvanî. Kural: Önce Kurmancî, yoksa uluslararası.',
    culturalNote: 'Peyvsazî = dil üretimi. Her yeni kelime dilin gücünü artiriyor.',
    exercises: [
      LessonExercise(id:'b2_l34_e1', type:ExerciseType.speak,
        content:'Bi paşgira "-vanî"yê peyvek çêke.', correctAnswer:'', options:[]),
      LessonExercise(id:'b2_l34_e2', type:ExerciseType.speak,
        content:'Ji bo "smartphone" peyveke kurdî çêke.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'b2_l35', level: 4, unitNumber: 5, lessonNumber: 4,
    kurmanjTitle: 'Zimanê Pêşerojê',
    turkishTitle: 'Geleceğin Dili',
    description: 'Kürtçenin geleceği — umutlar ve tehditler',
    vocabulary: ['b2_082','b2_083'],
    grammarNote: 'Gelecek zaman dili: "Ê bê" + şimdiki zaman. "Zimanê kurdî ê mezin bibe." İfade: "Em hêvî dikin ku..." "Li gorî lêkolînan..."',
    culturalNote: 'Welsh, Ibranice, Maori başarili canlanma örnekleri. Kürtçe için umut var. Diaspora gençliği anahtar rol.',
    exercises: [
      LessonExercise(id:'b2_l35_e1', type:ExerciseType.speak,
        content:'Zimanê kurdî di pêşerojê de çawa dibe?', correctAnswer:'', options:[]),
      LessonExercise(id:'b2_l35_e2', type:ExerciseType.speak,
        content:'Tu çi dikî ku zimanê xwe biparêzî?', correctAnswer:'', options:[]),
    ],
  ),

];

];