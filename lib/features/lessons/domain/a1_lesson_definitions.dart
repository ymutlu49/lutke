import 'lesson_entities.dart';
import 'a1_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// A1 — 20 DERS TANIMI
//
// Kaynak: Müfredat belgesi (Prof. Dr. Mutlu & Aslanoğlu)
// İlkeler: Arizona Üniversitesi ders sırası + CEFR A1 standartları
//
// Ders yapısı:
//   Her ders = 5–8 egzersiz
//   Her birim = 1–3 ders
//   Her birim sonu = zorunlu kültürel içerik
//
// İki paralel yol:
//   Heritage (Ev Yolu / Rêya Malê): Aile diyalogları önce
//   Genel (Yeni Yol / Rêya Nû): Sıfırdan başlayan
// ════════════════════════════════════════════════════════════════

// ── Yardımcı: kategoriye göre kelime seç ─────────────────────────

List<String> _kartsFromKat(List<String> katList) {
  return kA1TamKelimeler
      .where((k) => katList.contains(k.kat))
      .map((k) => k.id)
      .toList();
}

// ── Temel egzersiz şablonları ─────────────────────────────────────

ExerciseModel _listenSelect({
  required String id,
  required String ku,
  required String prompt,
  required List<String> options,
  required int correctIndex,
  String? audio,
  String? grammarNote,
  int xp = 10,
}) => ExerciseModel(
      id: id,
      type: ExerciseType.listenAndSelect,
      kurmanjPrompt: ku,
      turkishPrompt: prompt,
      audioAsset: audio,
      options: options,
      correctAnswer: options[correctIndex],
      correctIndex: correctIndex,
      grammarNote: grammarNote,
      xpReward: xp,
      cardId: id.split('_ex')[0],
    );

ExerciseModel _multiChoice({
  required String id,
  required String ku,
  required String tr,
  required List<String> options,
  required int correctIndex,
  String? grammarNote,
  int xp = 10,
}) => ExerciseModel(
      id: id,
      type: ExerciseType.multipleChoice,
      kurmanjPrompt: ku,
      turkishPrompt: tr,
      options: options,
      correctAnswer: options[correctIndex],
      correctIndex: correctIndex,
      grammarNote: grammarNote,
      xpReward: xp,
      cardId: id.split('_ex')[0],
    );

ExerciseModel _fillBlank({
  required String id,
  required String before,
  required String after,
  required String turkish,
  required List<String> options,
  required int correctIndex,
  String? grammarNote,
  int xp = 12,
}) => ExerciseModel(
      id: id,
      type: ExerciseType.fillInBlank,
      kurmanjPrompt: '$before ___ $after',
      turkishPrompt: turkish,
      options: options,
      correctAnswer: options[correctIndex],
      correctIndex: correctIndex,
      grammarNote: grammarNote,
      xpReward: xp,
      wordPieces: [before.trim(), after.trim()],
    );

ExerciseModel _speaking({
  required String id,
  required String ku,
  required String tr,
  String? audio,
  int xp = 15,
}) => ExerciseModel(
      id: id,
      type: ExerciseType.speakingPractice,
      kurmanjPrompt: ku,
      turkishPrompt: tr,
      audioAsset: audio,
      options: ['Çok iyi', 'Yakın', 'Tekrar'],
      correctAnswer: ku,
      xpReward: xp,
      cardId: id.split('_ex')[0],
    );

// ════════════════════════════════════════════════════════════════
// 20 DERS LİSTESİ
// ════════════════════════════════════════════════════════════════

final kA1Lessons = <LessonModel>[

  // ─────────────────────────────────────────────────────────────
  // BİRİM 1 — Alfabe û Dengên Kurmancî (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l01',
    kurmanjTitle: 'Dengên Taybetî',
    turkishTitle: 'Özel Sesler',
    unitNumber: 1,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['alfabe']),
    culturalRewardId: 'c_001',
    estimatedMinutes: 6,
    exercises: [
      _listenSelect(
        id: 'a1_001_ex1',
        ku: 'ê',
        prompt: 'Bu ses Türkçede VAR mi?',
        options: ['Evet, tam aynı', 'Hayır, yok — uzun e sesi', 'Evet, "e" ile aynı', 'Bilmiyorum'],
        correctIndex: 1,
        audio: 'assets/audio/alfabe/e_uzun.mp3',
        grammarNote: '"ê" Türkçede yok — ağız biraz gülümser, Fransızca "été" gibi. "Dê" (anne), "mêr" (koca), "kêr" (bıçak)',
        xp: 12,
      ),
      _listenSelect(
        id: 'a1_002_ex1',
        ku: 'x',
        prompt: 'Bu ses nereden çıkar?',
        options: ['Dudaktan', 'Dişten', 'Gırtlaktan — boğazdan', 'Dilden'],
        correctIndex: 2,
        audio: 'assets/audio/alfabe/x_sesi.mp3',
        grammarNote: '"x" gırtlak sesi — Türkçede yok. "Xwarin" (yemek), "xweş" (güzel), "xwişk" (kız kardeş). Arapça "خ" gibi',
        xp: 12,
      ),
      _multiChoice(
        id: 'a1_003_ex1',
        ku: '"q" harfi nasıl okunur?',
        tr: 'Hangi açıklama doğru?',
        options: [
          'Türkçe k gibi',
          'Kalın k — gırtlaktan söylenir',
          'Türkçe ğ gibi',
          'Okunmaz',
        ],
        correctIndex: 1,
        grammarNote: '"q" = kalın k. Türkçe "k"dan daha derin, boğazdan çıkar. "Qehwe" (kahve), "qad" (alan)',
      ),
      _listenSelect(
        id: 'a1_004_ex1',
        ku: 'î',
        prompt: 'Bu ses neye benzer?',
        options: ['Türkçe "ı"', 'Türkçe "i"nin uzunu', 'Türkçe "e"', 'Türkçe "ü"'],
        correctIndex: 1,
        audio: 'assets/audio/alfabe/i_uzun.mp3',
        grammarNote: '"î" = uzun i. "Spî" (beyaz), "kî" (kim), "nîvro" (öğle)',
      ),
      _listenSelect(
        id: 'a1_005_ex1',
        ku: 'û',
        prompt: 'Hangi kelimede "û" sesi var?',
        options: ['Hûn', 'Bav', 'Dê', 'Mal'],
        correctIndex: 0,
        audio: 'assets/audio/alfabe/u_uzun.mp3',
        grammarNote: '"û" = uzun u. "Hûn" (siz), "û" (ve), "dûr" (uzak)',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l02',
    kurmanjTitle: 'Wateya Dengan',
    turkishTitle: 'Seslerin Anlamı',
    unitNumber: 1,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['alfabe']),
    estimatedMinutes: 7,
    exercises: [
      _listenSelect(
        id: 'ker_keer_ex1',
        ku: 'ker',
        prompt: 'Ne anlama geliyor?',
        options: ['Bıçak', 'Eşek', 'At', 'Köpek'],
        correctIndex: 1,
        audio: 'assets/audio/minimal/ker.mp3',
        grammarNote: '"ker" (kısa e) = eşek. "kêr" (uzun ê) = bıçak. Tek ses farkı — anlam tamamen değişir!',
      ),
      _listenSelect(
        id: 'keer_keer_ex1',
        ku: 'kêr',
        prompt: 'Ne anlama geliyor?',
        options: ['Eşek', 'Kedi', 'Bıçak', 'At'],
        correctIndex: 2,
        audio: 'assets/audio/minimal/keer.mp3',
      ),
      _multiChoice(
        id: 'bir_biir_ex1',
        ku: '"bir" ile "bîr" arasındaki fark nedir?',
        tr: 'Hangisi doğru?',
        options: [
          'Aynı anlam, farklı yazım',
          '"bir" = kesmek, "bîr" = kuyu',
          '"bir" = kuyu, "bîr" = kesmek',
          'İkisi de "bir sayısı" demek',
        ],
        correctIndex: 1,
        grammarNote: '"bir" (kısa i) = kesmek fiili. "bîr" (uzun î) = kuyu (su kuyusu). Ünlü uzunluğu anlam değiştiriyor!',
      ),
      _speaking(
        id: 'silav_speak_ex1',
        ku: 'Silav',
        tr: 'Merhaba',
        audio: 'assets/audio/a1/silav.mp3',
      ),
      _speaking(
        id: 'spas_speak_ex1',
        ku: 'Spas',
        tr: 'Teşekkür ederim',
        audio: 'assets/audio/a1/spas.mp3',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 2 — Silavdan û Pêşkêşkirin (3 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l03',
    kurmanjTitle: 'Silav û Spas',
    turkishTitle: 'Merhaba ve Teşekkür',
    unitNumber: 2,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: _kartsFromKat(['selamlama']).take(8).toList(),
    culturalRewardId: 'c_002',
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(
        id: 'a1_010_ex1',
        ku: 'Silav',
        prompt: 'Ne anlama geliyor?',
        options: ['Hoşça kal', 'Merhaba', 'Teşekkür', 'Özür dilerim'],
        correctIndex: 1,
        audio: 'assets/audio/a1/silav.mp3',
      ),
      _listenSelect(
        id: 'a1_012_ex1',
        ku: 'Spas',
        prompt: 'Ne anlama geliyor?',
        options: ['Merhaba', 'Özür dilerim', 'Teşekkür ederim', 'Hoşça kal'],
        correctIndex: 2,
        audio: 'assets/audio/a1/spas.mp3',
      ),
      _multiChoice(
        id: 'a1_014_ex1',
        ku: '"Erê" ne demek?',
        tr: 'Doğru karşılığı bul',
        options: ['Hayır', 'Belki', 'Evet', 'Bilmiyorum'],
        correctIndex: 2,
      ),
      _multiChoice(
        id: 'a1_015_ex1',
        ku: '"Na" ne demek?',
        tr: 'Doğru karşılığı bul',
        options: ['Evet', 'Belki', 'Tamam', 'Hayır'],
        correctIndex: 3,
      ),
      _fillBlank(
        id: 'silav_fill_ex1',
        before: '___',
        after: ', pîrê!',
        turkish: '___, büyükanne! (Selamlama)',
        options: ['Spas', 'Silav', 'Bibore', 'Na'],
        correctIndex: 1,
        grammarNote: 'Hitap ederken isim cümle sonuna gelir: "Silav, pîrê!" = Merhaba, büyükanne!',
      ),
      _listenSelect(
        id: 'a1_016_ex1',
        ku: 'Baş e',
        prompt: 'Ne anlama geliyor?',
        options: ['Kötü', 'Belki', 'İyi / Tamam', 'Değil'],
        correctIndex: 2,
        audio: 'assets/audio/a1/base.mp3',
        grammarNote: '"Baş" = iyi (sıfat). "e" = bûn fiili 3.tekil. "Baş e" = iyidir/tamam',
      ),
      _speaking(
        id: 'silav_speak2',
        ku: 'Silav, baş î?',
        tr: 'Merhaba, iyi misin?',
        audio: 'assets/audio/a1/silav_bash.mp3',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l04',
    kurmanjTitle: 'Tu çawa yî?',
    turkishTitle: 'Nasılsın?',
    unitNumber: 2,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: _kartsFromKat(['selamlama']).skip(4).take(8).toList(),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(
        id: 'cawa_ex1',
        ku: 'Tu çawa yî?',
        prompt: 'Bu soru ne soruyor?',
        options: ['Adın ne?', 'Nerelisin?', 'Nasılsın?', 'Ne yapıyorsun?'],
        correctIndex: 2,
        audio: 'assets/audio/a1/cawa.mp3',
        grammarNote: '"Çawa" = nasıl. "yî" = sen-sin (bûn fiili 2.tekil). "Tu çawa yî?" = Nasılsın?',
      ),
      _listenSelect(
        id: 'bash_im_ex1',
        ku: 'Ez baş im',
        prompt: 'Bu cümle ne anlama gelir?',
        options: ['İyisin', 'İyiyim', 'İyi değilim', 'Çok iyiyim'],
        correctIndex: 1,
        audio: 'assets/audio/a1/ez_bash.mp3',
        grammarNote: '"Ez" = ben. "baş" = iyi. "im" = -im (bûn 1.tekil). SOV değil — isim cümlesi!',
      ),
      _fillBlank(
        id: 'ez_fill_ex1',
        before: 'Ez baş',
        after: '.',
        turkish: 'İyiyim.',
        options: ['e', 'î', 'im', 'in'],
        correctIndex: 2,
        grammarNote: 'Bûn çekimi: Ez … im / Tu … î / Ew … e / Em … in',
      ),
      _multiChoice(
        id: 'bextewar_ex1',
        ku: '"Bextewar" ne demek?',
        tr: 'Doğru karşılığı bul',
        options: ['Üzgün', 'Mutlu / Bahtiyar', 'Yorgun', 'Hasta'],
        correctIndex: 1,
        grammarNote: '"Bextewar" = mutlu/bahtiyar — Farsça kökenli ama Kurmancîde yerleşmiş',
      ),
      _listenSelect(
        id: 'xwesh_ex1',
        ku: 'Xatirê te',
        prompt: 'Bu ifade ne zaman söylenir?',
        options: ['Karşılaşırken', 'Ayrılırken', 'Yemek yerken', 'Uyurken'],
        correctIndex: 1,
        audio: 'assets/audio/a1/xatire.mp3',
        grammarNote: '"Xatir" = hatır. "Xatirê te" = senin hatırın — ayrılık selamıdır',
      ),
      _speaking(
        id: 'cawa_speak',
        ku: 'Tu çawa yî? — Ez baş im!',
        tr: 'Nasılsın? — İyiyim!',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l05',
    kurmanjTitle: 'Navê min … e',
    turkishTitle: 'Adım … dır',
    unitNumber: 2,
    lessonNumber: 3,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: ['a1_019', 'a1_020', 'a1_021', 'a1_022', 'a1_023', 'a1_024'],
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(
        id: 'nave_min_ex1',
        ku: 'Navê min … e',
        prompt: 'Bu cümle ne anlatır?',
        options: ['Nerelisin?', 'Nasılsın?', 'Adım … dır', 'Kaç yaşındasın?'],
        correctIndex: 2,
        audio: 'assets/audio/a1/nave_min.mp3',
        grammarNote: '"Nav" = ad/isim (eril). "Navê" = ezafe (-ê eril). "navê min" = benim adım',
      ),
      _multiChoice(
        id: 'tu_ki_ex1',
        ku: '"Tu kî yî?" sorusuna ne cevap verilir?',
        tr: 'Doğru cevabı seç',
        options: [
          'Ez baş im',
          'Navê min Narin e',
          'Ez li malê me',
          'Heftê sal in',
        ],
        correctIndex: 1,
        grammarNote: '"Tu kî yî?" = Sen kimsin? → "Navê min … e" ile cevap verilir',
      ),
      _fillBlank(
        id: 'bixer_fill_ex1',
        before: 'Bi xêr',
        after: '', 
        turkish: 'Hoş geldiniz!',
        options: ['hatim', 'hatî', 'hatîn', 'hatî ye'],
        correctIndex: 1,
        grammarNote: '"Bi xêr hatî" = hoş geldiniz (tekil). "Bi xêr hatîn" = hoş geldiniz (çoğul)',
      ),
      _listenSelect(
        id: 'bibore_ex1',
        ku: 'Bibore!',
        prompt: 'Bu kelime ne zaman kullanılır?',
        options: ['Teşekkür ederken', 'Selam verirken', 'Özür dilerken', 'Veda ederken'],
        correctIndex: 2,
        audio: 'assets/audio/a1/bibore.mp3',
      ),
      _speaking(
        id: 'tanitim_speak',
        ku: 'Silav! Navê min … e. Tu kî yî?',
        tr: 'Merhaba! Adım … dır. Sen kimsin?',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 3 — Jimar (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l06',
    kurmanjTitle: 'Jimar 1–20',
    turkishTitle: 'Sayılar 1–20',
    unitNumber: 3,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['jimar']).take(12).toList(),
    culturalRewardId: 'c_005',
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'yek_ex1', ku: 'Yek', prompt: 'Kaç?',
          options: ['İki', 'Bir', 'Üç', 'Dört'], correctIndex: 1,
          audio: 'assets/audio/a1/yek.mp3'),
      _listenSelect(id: 'du_ex1', ku: 'Du', prompt: 'Kaç?',
          options: ['Bir', 'Üç', 'İki', 'Dört'], correctIndex: 2,
          audio: 'assets/audio/a1/du.mp3'),
      _listenSelect(id: 'pênc_ex1', ku: 'Pênc', prompt: 'Kaç?',
          options: ['Altı', 'Dört', 'Yedi', 'Beş'], correctIndex: 3,
          audio: 'assets/audio/a1/penc.mp3'),
      _fillBlank(
        id: 'yek_fill_ex1',
        before: '___',
        after: 'çay bide min, dêyê.',
        turkish: '___ çay ver bana, anneciğim.',
        options: ['Du', 'Sê', 'Yek', 'Çar'],
        correctIndex: 2,
      ),
      _multiChoice(
        id: 'deh_ex1',
        ku: '"Deh" kaç eder?',
        tr: 'Doğru sayıyı seç',
        options: ['Beş', 'Dokuz', 'On', 'Yirmi'],
        correctIndex: 2,
      ),
      _speaking(id: 'jimar_speak', ku: 'Yek, du, sê, çar, pênc',
          tr: 'Bir, iki, üç, dört, beş'),
    ],
  ),

  LessonModel(
    id: 'a1_l07',
    kurmanjTitle: 'Jimar 20–1000',
    turkishTitle: 'Sayılar 20–1000',
    unitNumber: 3,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['jimar']).skip(10).toList(),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'bist_ex1', ku: 'Bîst', prompt: 'Kaç?',
          options: ['On', 'Otuz', 'Yirmi', 'Kırk'], correctIndex: 2,
          audio: 'assets/audio/a1/bist.mp3'),
      _listenSelect(id: 'sed_ex1', ku: 'Sed', prompt: 'Kaç?',
          options: ['On', 'Elli', 'Bin', 'Yüz'], correctIndex: 3,
          audio: 'assets/audio/a1/sed.mp3'),
      _multiChoice(
        id: 'hezar_ex1',
        ku: '"Gelek spas" içindeki "gelek" ne demek?',
        tr: 'Doğru anlamı bul',
        options: ['Az', 'Çok', 'Hiç', 'Bazen'],
        correctIndex: 1,
        grammarNote: '"Gelek" = çok. "Gelek spas" = çok teşekkürler. "Hezar spas" = bin teşekkürler',
      ),
      _fillBlank(
        id: 'sal_fill_ex1',
        before: 'Pîrê bîst',
        after: 'in.',
        turkish: 'Büyükanne yirmi ___ yaşında. (Yıl kelimesini ekle)',
        options: ['dem', 'roj', 'sal', 'meh'],
        correctIndex: 2,
        grammarNote: '"Tu çend salî yî?" = Kaç yaşındasın? "Sal" = yıl (dişil, mê)',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 4 — Reng (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l08',
    kurmanjTitle: 'Rengên Kurdî',
    turkishTitle: 'Kürtçe Renkler',
    unitNumber: 4,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['reng']),
    estimatedMinutes: 7,
    exercises: [
      _listenSelect(id: 'spî_ex1', ku: 'Spî', prompt: 'Hangi renk?',
          options: ['Siyah', 'Kırmızı', 'Beyaz', 'Mavi'], correctIndex: 2,
          audio: 'assets/audio/a1/spi.mp3'),
      _listenSelect(id: 'reş_ex1', ku: 'Reş', prompt: 'Hangi renk?',
          options: ['Beyaz', 'Siyah', 'Yeşil', 'Sarı'], correctIndex: 1,
          audio: 'assets/audio/a1/res.mp3'),
      _listenSelect(id: 'kesk_ex1', ku: 'Kesk', prompt: 'Hangi renk?',
          options: ['Mavi', 'Kırmızı', 'Sarı', 'Yeşil'], correctIndex: 3,
          audio: 'assets/audio/a1/kesk.mp3',
          grammarNote: '"Kesk" = yeşil — Kürt bayrağının ortasındaki renk. Çiyayên kesk = yeşil dağlar'),
      _multiChoice(
        id: 'sin_uyari_ex1',
        ku: '"Şîn" kelimesinin iki anlamı vardır. Hangisi?',
        tr: 'Doğru çifti seç',
        options: [
          'Beyaz ve temiz',
          'Mavi ve üzgün',
          'Yeşil ve canlı',
          'Sarı ve solgun',
        ],
        correctIndex: 1,
        grammarNote: '⚠️ "Şîn" = hem mavi hem üzgün. "Ew şîn e" = o mavidir VEYA o üzgündür — bağlamdan anlaşılır!',
      ),
      _fillBlank(
        id: 'agir_renk_ex1',
        before: 'Agirê Newrozê',
        after: 'e.',
        turkish: 'Newroz ateşi ___ dir.',
        options: ['şîn', 'kesk', 'sor', 'spî'],
        correctIndex: 2,
        grammarNote: '"Agir" = ateş (eril). "Sor" = kırmızı. Newroz ateşi kızıldır!',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 5 — Malbat (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l09',
    kurmanjTitle: 'Dê û Bav',
    turkishTitle: 'Anne ve Baba',
    unitNumber: 5,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: ['a1_080', 'a1_081', 'a1_082', 'a1_083', 'a1_092'],
    culturalRewardId: 'c_003',
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(id: 'de_ex1', ku: 'Dê', prompt: 'Ne anlama geliyor?',
          options: ['Baba', 'Anne', 'Kız kardeş', 'Büyükanne'], correctIndex: 1,
          audio: 'assets/audio/a1/de.mp3',
          grammarNote: '"Dê" = anne (dişil, mê). Ezafe: "dêya min" = annemin. "Daya/Dayik" da kullanılır'),
      _listenSelect(id: 'bav_ex1', ku: 'Bav', prompt: 'Ne anlama geliyor?',
          options: ['Amca', 'Kardeş', 'Baba', 'Dede'], correctIndex: 2,
          audio: 'assets/audio/a1/bav.mp3',
          grammarNote: '"Bav" = baba (eril, nêr). Ezafe: "bavê min" = babamın'),
      _fillBlank(
        id: 'deya_fill_ex1',
        before: '___ya min baş e.',
        after: '',
        turkish: 'Annem iyi.',
        options: ['Bav', 'Bira', 'Dê', 'Xwişk'],
        correctIndex: 2,
        grammarNote: '"Dêya min" = annemin/annem. Dişil ezafe: -ya eki',
      ),
      _multiChoice(
        id: 'bira_xwisk_ex1',
        ku: '"Bira" ve "Xwişk" kelimelerindeki fark nedir?',
        tr: 'Doğru açıklamayı seç',
        options: [
          '"Bira" = kız kardeş, "Xwişk" = erkek kardeş',
          '"Bira" = erkek kardeş, "Xwişk" = kız kardeş',
          'İkisi de "kardeş" demek, fark yok',
          '"Bira" büyük, "Xwişk" küçük kardeş',
        ],
        correctIndex: 1,
        grammarNote: '"Bira" (eril/nêr) = erkek kardeş — "birê min". "Xwişk" (dişil/mê) = kız kardeş — "xwişka min"',
      ),
      _speaking(
        id: 'malbat_speak',
        ku: 'Malbata min: dê, bav, bira û xwişk.',
        tr: 'Ailem: anne, baba, erkek ve kız kardeş.',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l10',
    kurmanjTitle: 'Dapîr û Bapîr',
    turkishTitle: 'Büyükanne ve Büyükbaba',
    unitNumber: 5,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: ['a1_084', 'a1_085', 'a1_086', 'a1_087', 'a1_088', 'a1_089'],
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(id: 'piree_ex1', ku: 'Dapîr', prompt: 'Ne anlama geliyor?',
          options: ['Büyükbaba', 'Teyze', 'Büyükanne', 'Hala'], correctIndex: 2,
          audio: 'assets/audio/a1/piree.mp3',
          grammarNote: '"Dapîr" = büyükanne (dişil/mê). Ezafe: "dapîra min". "Pîrê" de kullanılır.'),
      _listenSelect(id: 'kal_ex1', ku: 'Kal', prompt: 'Ne anlama geliyor?',
          options: ['Baba', 'Dede/Büyükbaba', 'Amca', 'Dayı'], correctIndex: 1,
          audio: 'assets/audio/a1/kal.mp3',
          grammarNote: '"Kal" = büyükbaba (eril/nêr). "Bapîr" de kullanılır'),
      _fillBlank(
        id: 'pireya_fill_ex1',
        before: 'Ez ji',
        after: 'ya xwe hez dikim.',
        turkish: 'Büyükannemden çok seviyorum.',
        options: ['kal', 'bav', 'dapîr', 'ap'],
        correctIndex: 2,
        grammarNote: '"Ji … hez kirin" = sevmek. "Dapîra xwe" = kendi büyükannem',
      ),
      _multiChoice(
        id: 'ap_xalti_ex1',
        ku: '"Ap" kimin amcasıdır?',
        tr: 'Doğru açıklamayı bul',
        options: [
          'Anne tarafı amca',
          'Baba tarafı amca',
          'Her iki taraftan amca',
          'Dayı demek',
        ],
        correctIndex: 1,
        grammarNote: '"Ap" = baba tarafı amca (eril). "Xaltî" = teyze — anne tarafı. Kürtçede akrabalık hassas!',
      ),
      _speaking(
        id: 'piree_speak',
        ku: 'Dapîra min Kurmancî dizane.',
        tr: 'Büyükannem Kurmancî biliyor.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 6 — Cînavk (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l11',
    kurmanjTitle: 'Cînavkên Serbixwe',
    turkishTitle: 'Bağımsız Zamirler',
    unitNumber: 6,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: ['a1_100', 'a1_101', 'a1_102', 'a1_103', 'a1_104'],
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'ez_ex1', ku: 'Ez', prompt: 'Hangi zamir?',
          options: ['Sen', 'O', 'Biz', 'Ben'], correctIndex: 3,
          audio: 'assets/audio/a1/ez.mp3'),
      _listenSelect(id: 'tu_ex1', ku: 'Tu', prompt: 'Hangi zamir?',
          options: ['Ben', 'Biz', 'Sen', 'Onlar'], correctIndex: 2,
          audio: 'assets/audio/a1/tu.mp3'),
      _listenSelect(id: 'em_ex1', ku: 'Em', prompt: 'Hangi zamir?',
          options: ['Ben', 'Siz', 'Onlar', 'Biz'], correctIndex: 3,
          audio: 'assets/audio/a1/em.mp3'),
      _fillBlank(
        id: 'bun_fill_ex1',
        before: '___ baş im.',
        after: '',
        turkish: '___ iyiyim.',
        options: ['Tu', 'Ew', 'Ez', 'Em'],
        correctIndex: 2,
        grammarNote: '"Im" eki 1.tekil — sadece "Ez" ile kullanılır. "Tu baş î" / "Ew baş e" / "Em baş in"',
      ),
      _multiChoice(
        id: 'hun_ex1',
        ku: '"Hûn" zamiri nasıl kullanılır?',
        tr: 'Doğru açıklamayı seç',
        options: [
          'Sadece çoğul "siz" için',
          'Sadece saygı için tekile',
          'Hem çoğul "siz" hem saygı tekil',
          'Hiçbiri',
        ],
        correctIndex: 2,
        grammarNote: '"Hûn" = siz (çoğul) VEYA saygılı tekil — büyüklere "Tu" değil "Hûn" denir',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l12',
    kurmanjTitle: 'Cînavkên Eğik',
    turkishTitle: 'Eğik Zamirler (Min, Te…)',
    unitNumber: 6,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.general,
    targetCardIds: ['a1_105', 'a1_106', 'a1_107'],
    estimatedMinutes: 9,
    exercises: [
      _multiChoice(
        id: 'min_te_ex1',
        ku: '"Navê min" neden "min" kullanıyor?',
        tr: 'Doğru açıklamayı bul',
        options: [
          '"Min" = "ez"nin saygılı formu',
          '"Min" = "ez"nin eğik/tamlama hali',
          'Yanlış — "navê ez" olmalı',
          'Rastgele seçim',
        ],
        correctIndex: 1,
        grammarNote: 'Kurmancîde tamlama/eğik hali: Ez→Min, Tu→Te, Ew→Wî/Wê, Em→Me. "Navê min" = benim adım',
      ),
      _fillBlank(
        id: 'spas_te_fill_ex1',
        before: 'Spas ji',
        after: 're!',
        turkish: 'Sana teşekkürler!',
        options: ['ez', 'tu', 'te', 'wî'],
        correctIndex: 2,
        grammarNote: '"Ji te re" = sana (yön). "Te" = "tu"nun eğik hali',
      ),
      _fillBlank(
        id: 'mala_fill_ex1',
        before: 'Mala',
        after: 'baş e.',
        turkish: 'Benim evim güzel.',
        options: ['ez', 'tu', 'me', 'min'],
        correctIndex: 3,
        grammarNote: '"Mala min" = benim evim. "min" = eğik hal tamlama için',
      ),
      _speaking(
        id: 'zamir_speak',
        ku: 'Navê min … e. Mala min li … ye.',
        tr: 'Adım … dır. Evim … dadır.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 7 — Pîşe û Perwerdehî (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l13',
    kurmanjTitle: 'Pîşe û Xwendin',
    turkishTitle: 'Meslek ve Eğitim',
    unitNumber: 7,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['pîşe', 'perwerde']),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'mamosta_ex1', ku: 'Mamosta', prompt: 'Ne anlama geliyor?',
          options: ['Öğrenci', 'Doktor', 'Öğretmen', 'Polis'], correctIndex: 2,
          audio: 'assets/audio/a1/mamosta.mp3'),
      _listenSelect(id: 'xwendekar_ex1', ku: 'Xwendekar', prompt: 'Ne anlama geliyor?',
          options: ['Çiftçi', 'Öğrenci', 'Öğretmen', 'İşçi'], correctIndex: 1,
          audio: 'assets/audio/a1/xwendekar.mp3',
          grammarNote: '"Xwend" = okudu + "-ekar" = yapan kişi. x sesi gırtlaktan!'),
      _listenSelect(id: 'bijisk_ex1', ku: 'Bijîşk', prompt: 'Ne anlama geliyor?',
          options: ['Polis', 'Öğretmen', 'Doktor/Hekim', 'Mühendis'], correctIndex: 2,
          audio: 'assets/audio/a1/bijisk.mp3',
          grammarNote: '"Bijîşk" saf Kurmancî kelime — "Doktor" da kullanılır ama "bijîşk" daha özgün'),
      _fillBlank(
        id: 'mamosta_fill_ex1',
        before: 'Bavê min',
        after: 'ye.',
        turkish: 'Babam öğretmen.',
        options: ['xwendekar', 'bijîşk', 'mamosta', 'karker'],
        correctIndex: 2,
        grammarNote: 'İsim cümlesi: özne + meslek + bûn. "Bavê min mamosta ye" — eril için "ye"',
      ),
      _multiChoice(
        id: 'dibistan_zanin_ex1',
        ku: '"Dibistan" ve "Zanîngeh" arasındaki fark nedir?',
        tr: 'Doğru çifti seç',
        options: [
          'İkisi de "okul" demek',
          '"Dibistan" = okul, "Zanîngeh" = üniversite',
          '"Dibistan" = üniversite, "Zanîngeh" = okul',
          '"Dibistan" = kütüphane',
        ],
        correctIndex: 1,
        grammarNote: '"Zanîngeh" = bilgi-yer. "Zanîn" (bilmek) + "-geh" (yer eki) = üniversite',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 8 — Dem û Rojen (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l14',
    kurmanjTitle: 'Rojen û Dem',
    turkishTitle: 'Günler ve Zaman',
    unitNumber: 8,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['roj', 'dem']),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'roj_ex1', ku: 'Roj', prompt: 'İki anlamı var — hangisi doğru?',
          options: ['Gün ve gece', 'Gün ve güneş', 'Gece ve ay', 'Sabah ve akşam'], correctIndex: 1,
          audio: 'assets/audio/a1/roj.mp3',
          grammarNote: '"Roj" = hem gün hem güneş (eril). "Newroz" = yeni gün (nû + roj)!'),
      _listenSelect(id: 'iro_duh_ex1', ku: 'Îro', prompt: 'Ne anlama geliyor?',
          options: ['Dün', 'Yarın', 'Bugün', 'Bu hafta'], correctIndex: 2,
          audio: 'assets/audio/a1/iro.mp3'),
      _multiChoice(
        id: 'sibe_ex1',
        ku: '"Sibê" kelimesinin kaç anlamı var?',
        tr: 'Doğru cevabı seç',
        options: ['Bir — sabah', 'İki — sabah ve yarın', 'Üç', 'Anlam yok'],
        correctIndex: 1,
        grammarNote: '"Sibê" = sabah vakti VEYA yarın. "Sibê têm" = yarın geliyorum. "Sibê baş!" = günaydın',
      ),
      _listenSelect(id: 'heft_roj_ex1', ku: 'Hefta', prompt: 'Ne anlama geliyor?',
          options: ['Ay', 'Gün', 'Yıl', 'Hafta'], correctIndex: 3),
      _fillBlank(
        id: 'duşem_fill_ex1',
        before: '___',
        after: 'roja yekem a hefteyê ye.',
        turkish: '___ haftanın ilk günüdür.',
        options: ['Yekşem', 'Şemî', 'Duşem', 'Înî'],
        correctIndex: 2,
        grammarNote: '"Duşem" = Pazartesi (du + şem = iki cumartesi). Haftanın ilk günü.',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l15',
    kurmanjTitle: 'Demsal û Meh',
    turkishTitle: 'Mevsimler ve Aylar',
    unitNumber: 8,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: _kartsFromKat(['demsal']),
    culturalRewardId: 'c_newroz',
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(id: 'bihar_ex1', ku: 'Bihar', prompt: 'Hangi mevsim?',
          options: ['Yaz', 'Kış', 'Sonbahar', 'İlkbahar'], correctIndex: 3,
          audio: 'assets/audio/a1/bihar.mp3',
          grammarNote: '"Bihar" = ilkbahar — Newroz biharê tê! (Newroz ilkbaharda gelir)'),
      _listenSelect(id: 'zivistan_ex1', ku: 'Zivistan', prompt: 'Hangi mevsim?',
          options: ['İlkbahar', 'Kış', 'Yaz', 'Sonbahar'], correctIndex: 1,
          audio: 'assets/audio/a1/zivistan.mp3'),
      _fillBlank(
        id: 'newroz_fill_ex1',
        before: 'Newroz di',
        after: 'ê de tê.',
        turkish: 'Newroz ___ da gelir. (Mevsim adını ekle)',
        options: ['Zivistanê', 'Havînê', 'Payîzê', 'Biharê'],
        correctIndex: 3,
        grammarNote: 'Newroz = 21 Mart = ilkbaharda. "Biharê" = ilkbaharda (zaman hali)',
      ),
      _speaking(
        id: 'newroz_speak',
        ku: 'Newroz pîroz be! Biharê xweş e.',
        tr: 'Newroz kutlu olsun! İlkbahar güzel.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 9 — Xwarin û Vexwarin (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l16',
    kurmanjTitle: 'Nan û Av',
    turkishTitle: 'Ekmek ve Su',
    unitNumber: 9,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: _kartsFromKat(['xwarin', 'vexwarin']).take(8).toList(),
    culturalRewardId: 'c_004',
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'nan_ex1', ku: 'Nan', prompt: 'Ne anlama geliyor?',
          options: ['Su', 'Et', 'Süt', 'Ekmek'], correctIndex: 3,
          audio: 'assets/audio/a1/nan.mp3',
          grammarNote: '"Nan" = ekmek (eril). "Nan û xwê" = ekmek ve tuz — Kürt misafirperverliğinin simgesi!'),
      _listenSelect(id: 'av_ex1', ku: 'Av', prompt: 'Ne anlama geliyor?',
          options: ['Ekmek', 'Çay', 'Su', 'Süt'], correctIndex: 2,
          audio: 'assets/audio/a1/av.mp3',
          grammarNote: '"Av" = su (dişil). "Avê bide min" = su ver bana'),
      _listenSelect(id: 'cay_ex1', ku: 'Çay', prompt: 'Ne anlama geliyor?',
          options: ['Kahve', 'Su', 'Süt', 'Çay'], correctIndex: 3,
          audio: 'assets/audio/a1/cay.mp3',
          grammarNote: '"Çay" = çay (eril). Kürt kültüründe misafir çayı zorunlu gelenektir!'),
      _fillBlank(
        id: 'xwarin_fill_ex1',
        before: 'Ez nan',
        after: '.',
        turkish: 'Ben ekmek yiyorum.',
        options: ['vedixwim', 'diçim', 'dixwim', 'dikim'],
        correctIndex: 2,
        grammarNote: '"Dixwim" = yiyorum (di + xw + im). "Vedixwim" = içiyorum (içmek için)',
      ),
      _speaking(
        id: 'destê_speak',
        ku: 'Destê te xweş be!',
        tr: 'Elinize sağlık!',
        audio: 'assets/audio/a1/deste.mp3',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l17',
    kurmanjTitle: 'Li Sifrê',
    turkishTitle: 'Sofrada',
    unitNumber: 9,
    lessonNumber: 2,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: _kartsFromKat(['xwarin', 'mêwe']).skip(4).toList(),
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(id: 'mast_ex1', ku: 'Mast', prompt: 'Ne anlama geliyor?',
          options: ['Yoğurt', 'Süt', 'Peynir', 'Tereyağı'], correctIndex: 0,
          audio: 'assets/audio/a1/mast.mp3'),
      _multiChoice(
        id: 'nan_xwe_ex1',
        ku: '"Nan û xwê" ne anlama gelir?',
        tr: 'Kültürel anlamı bul',
        options: [
          'Sadece yiyecekler',
          'Misafirperverliğin simgesi',
          'Kahvaltı menüsü',
          'Çorbaya katılanlar',
        ],
        correctIndex: 1,
        grammarNote: '"Nan û xwê bide mêvanê xwe" = Misafirine ekmek ve tuz sun — bağ kurmanın simgesi',
      ),
      _fillBlank(
        id: 'goşt_fill_ex1',
        before: 'Pîrê',
        after: 'dipijîne.',
        turkish: 'Büyükanne et pişiriyor.',
        options: ['av', 'nan', 'goşt', 'mast'],
        correctIndex: 2,
        grammarNote: '"Dipijîne" = pişiriyor (di + pijîn + e). Heritage cümlesi: gerçek Kürt günlük hayatı',
      ),
      _speaking(
        id: 'sofra_speak',
        ku: 'Xwarin xweş bû! Destê te xweş be.',
        tr: 'Yemek güzeldi! Elinize sağlık.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 10 — Endamên Bedenê û Tenduristî (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l18',
    kurmanjTitle: 'Beden û Tenduristî',
    turkishTitle: 'Beden ve Sağlık',
    unitNumber: 10,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: _kartsFromKat(['beden', 'tendurist']),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'serî_ex1', ku: 'Serî', prompt: 'Vücudun neresine denir?',
          options: ['El', 'Göz', 'Baş', 'Kulak'], correctIndex: 2,
          audio: 'assets/audio/a1/seri.mp3'),
      _listenSelect(id: 'çav_ex1', ku: 'Çav', prompt: 'Ne anlama geliyor?',
          options: ['Burun', 'Göz', 'Ağız', 'Kulak'], correctIndex: 1,
          audio: 'assets/audio/a1/cav.mp3'),
      _multiChoice(
        id: 'ziman_iki_anlam_ex1',
        ku: '"Ziman" kelimesinin iki anlamı hangisi?',
        tr: 'Doğru çifti bul',
        options: [
          'Göz ve bakış',
          'El ve kol',
          'Dil (organ) ve dil (lisan)',
          'Ağız ve ses',
        ],
        correctIndex: 2,
        grammarNote: '"Ziman" = hem dil organı hem lisan/dil. "Zimanê Kurdî" = Kürt dili. "Ziman dermanê dilê mirov e"',
      ),
      _fillBlank(
        id: 'nexwes_fill_ex1',
        before: 'Ez',
        after: 'im.',
        turkish: 'Ben hastayım.',
        options: ['baş', 'nexweş', 'bextewar', 'birçî'],
        correctIndex: 1,
        grammarNote: '"Nexweş" = ne + xweş = güzel değil = hasta. "Ez nexweş im" = hastayım',
      ),
      _speaking(
        id: 'tendurist_speak',
        ku: 'Serê min êş dike. Ez nexweş im.',
        tr: 'Başım ağrıyor. Ben hastayım.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 11 — Mal û Cih (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l19',
    kurmanjTitle: 'Li Malê',
    turkishTitle: 'Evde',
    unitNumber: 11,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.heritage,
    targetCardIds: _kartsFromKat(['mal', 'cih']),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'mal_ex1', ku: 'Mal', prompt: 'Ne anlama geliyor?',
          options: ['Bahçe', 'Oda', 'Ev', 'Köy'], correctIndex: 2,
          audio: 'assets/audio/a1/mal.mp3',
          grammarNote: '"Mal" = ev/yurt (dişil). "Mala min" = benim evim. "Li malê" = evde'),
      _multiChoice(
        id: 'li_vir_ex1',
        ku: '"Li vir" ne anlama geliyor?',
        tr: 'Doğru çeviriyi bul',
        options: ['Orada', 'Burada', 'Nerede', 'Yukarıda'],
        correctIndex: 1,
        grammarNote: '"Li" = -de/-da (yer edatı). "Vir" = bura. "Li vir" = burada',
      ),
      _fillBlank(
        id: 'piree_li_fill_ex1',
        before: 'Pîrê li',
        after: 'ye.',
        turkish: 'Büyükanne evde.',
        options: ['bajêr', 'çiyayê', 'malê', 'gundê'],
        correctIndex: 2,
        grammarNote: '"Li malê" = evde. "Malê" = evin (yön hali)',
      ),
      _listenSelect(id: 'nêzîk_dûr_ex1', ku: 'Nêzîk',
          prompt: 'Ne anlama geliyor?',
          options: ['Uzak', 'Yukarı', 'Yakın', 'Aşağı'], correctIndex: 2),
      _speaking(
        id: 'li_malê_speak',
        ku: 'Ez li malê me. Pîrê jî li malê ye.',
        tr: 'Ben evdeyim. Büyükanne de evde.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // BİRİM 12 — Rengdêr û Peyvên Bingehîn (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a1_l20',
    kurmanjTitle: 'Rengdêr û Lêker',
    turkishTitle: 'Sıfatlar ve Fiiller',
    unitNumber: 12,
    lessonNumber: 1,
    level: 1,
    path: LessonPath.general,
    targetCardIds: [..._kartsFromKat(['rengder']), ..._kartsFromKat(['leker']).take(5).toList()],
    estimatedMinutes: 10,
    exercises: [
      _multiChoice(
        id: 'baş_xerab_ex1',
        ku: '"Baş" ve "Xerab" zıt mı?',
        tr: 'Doğru çifti seç',
        options: [
          'Evet — iyi/kötü',
          'Hayır — ikisi de iyi demek',
          'Evet — büyük/küçük',
          'Hayır — aynı anlam',
        ],
        correctIndex: 0,
        grammarNote: 'Kurmancî sıfatlar değişmez — isimle cinsiyet/sayı uyumu YOK. "Mala baş" = iyi ev, "malên baş" = iyi evler — sıfat aynı kalır!',
      ),
      _fillBlank(
        id: 'germ_sar_fill_ex1',
        before: 'Çayê',
        after: 'vexwe!',
        turkish: '___ çay iç!',
        options: ['sar', 'germ', 'nû', 'biçûk'],
        correctIndex: 1,
        grammarNote: '"Germ" = sıcak. "Çayê germ" = sıcak çay. Sıfat isimden sonra geliyor!',
      ),
      _listenSelect(id: 'xwesh_ex1', ku: 'Xweş', prompt: 'Ne anlama geliyor?',
          options: ['Kötü', 'Hasta', 'Güzel/İyi', 'Büyük'], correctIndex: 2,
          audio: 'assets/audio/a1/xwesh.mp3',
          grammarNote: '"Xweş" çok kullanılan kelime: güzel, iyi, hoş. "Xweş bî!" = iyi ol!'),
      _multiChoice(
        id: 'gelek_ex1',
        ku: '"Gelek" hangi tür kelimedir?',
        tr: 'Doğru tanımı bul',
        options: ['Sıfat — büyük anlamı', 'Zarf — çok anlamı', 'Fiil', 'Zamir'],
        correctIndex: 1,
        grammarNote: '"Gelek" = çok (zarf). Sıfattan önce gelir: "gelek baş" = çok iyi',
      ),
      _speaking(
        id: 'a1_son_speak',
        ku: 'Ez Kurmancî dixwînim û keyf xweş im!',
        tr: 'Kurmancî öğreniyorum ve keyfim yerinde!',
      ),
    ],
  ),

]; // kA1Lessons son

// ── Ders ID'ye göre getir ─────────────────────────────────────────
LessonModel? getLessonById(String id) {
  try {
    return kA1Lessons.firstWhere((l) => l.id == id);
  } catch (_) {
    return null;
  }
}

// ── Birime göre dersleri getir ────────────────────────────────────
List<LessonModel> getLessonsForUnit(int unitNumber) =>
    kA1Lessons.where((l) => l.unitNumber == unitNumber).toList();
