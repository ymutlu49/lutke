import 'lesson_entities.dart';
import 'a1_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// A1 — 20 DERS TANIMI
//
// Kaynak: Müfredat belgesi (Prof. Dr. Mutlu)
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
    // FIX 2026-04: 'c_001' CulturalReward.defaults'ta yoktu — sessizce null dönüyordu.
    culturalRewardId: 'proverb_1',
    estimatedMinutes: 6,
    exercises: [
      _listenSelect(
        id: 'a1_001_ex1',
        ku: 'ê',
        prompt: 'Bu ses Türkçede VAR mi?',
        // M&E fix (Nisan 2026): Eski distraktör "Hayır, 'a' sesi" mantıksal
        // tutarsızdı (Türkçede 'a' sesi vardır → "Hayır" + "a sesi" çelişki).
        // Yerine "Hayır, 'i' gibi söylenir" yerleştirildi — yaygın öğrenci
        // hatası (î ile e karışımı) test edilir.
        options: ['Evet, "e" ile aynı', 'Hayır, yok — uzun e sesi', 'Hayır, "i" gibi söylenir', 'Evet, tam aynı'],
        correctIndex: 1,
        audio: 'assets/audio/alfabe/e_uzun.mp3',
        grammarNote: '"ê" Türkçede yok — ağız biraz gülümser, Fransızca "été" gibi. "Dê" (anne), "mêr" (koca), "kêr" (bıçak)',
        xp: 12,
      ),
      _listenSelect(
        id: 'a1_002_ex1',
        ku: 'x',
        prompt: 'Bu ses nereden çıkar?',
        options: ['Dişten', 'Dudaktan', 'Gırtlaktan — boğazdan', 'Dilden'],
        correctIndex: 2,
        audio: 'assets/audio/alfabe/x_sesi.mp3',
        grammarNote: '"x" gırtlak sesi — Türkçede yok. "Xwarin" (yemek), "xweş" (güzel), "xwişk" (kız kardeş). Arapça "خ" gibi',
        xp: 12,
      ),
      _multiChoice(
        id: 'a1_003_ex1',
        ku: 'Tîpa "q" çawa tê xwendin?',
        tr: '"q" harfi nasıl okunur? Doğru açıklamayı seç.',
        options: [
          'Kalın k — gırtlaktan söylenir',
          'Türkçe ğ gibi',
          'Türkçe k gibi',
          'Okunmaz',
        ],
        correctIndex: 0,
        grammarNote: '"q" = kalın k. Türkçe "k"dan daha derin, boğazdan çıkar. "Qehwe" (kahve), "qad" (alan)',
      ),
      _listenSelect(
        id: 'a1_004_ex1',
        ku: 'î',
        prompt: 'Bu ses neye benzer?',
        options: ['Türkçe "i"nin uzunu', 'Türkçe "e"', 'Türkçe "ı"', 'Türkçe "ü"'],
        correctIndex: 0,
        audio: 'assets/audio/alfabe/i_uzun.mp3',
        grammarNote: '"î" = uzun i. "Spî" (beyaz), "kî" (kim), "nîvro" (öğle)',
      ),
      _listenSelect(
        id: 'a1_005_ex1',
        ku: 'û',
        prompt: 'Hangi kelimede "û" sesi var?',
        options: ['Mal', 'Dê', 'Bav', 'Hûn'],
        correctIndex: 3,
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
        options: ['At', 'Köpek', 'Bıçak', 'Eşek'],
        correctIndex: 3,
        audio: 'assets/audio/minimal/ker.mp3',
        grammarNote: '"ker" (kısa e) = eşek. "kêr" (uzun ê) = bıçak. Tek ses farkı — anlam tamamen değişir!',
      ),
      _listenSelect(
        id: 'keer_keer_ex1',
        ku: 'kêr',
        prompt: 'Ne anlama geliyor?',
        options: ['Eşek', 'At', 'Bıçak', 'Kedi'],
        correctIndex: 2,
        audio: 'assets/audio/minimal/keer.mp3',
      ),
      _multiChoice(
        id: 'bir_biir_ex1',
        ku: 'Ferqa "bir" û "bîr" çi ye?',
        tr: '"bir" ile "bîr" arasındaki fark nedir?',
        options: [
          'Aynı anlam, farklı yazım',
          '"bir" = kuyu, "bîr" = götürdü',
          '"bir" = götürdü, "bîr" = kuyu/hafıza',
          'İkisi de "bir sayısı" demek',
        ],
        correctIndex: 2,
        grammarNote: '"bir" (kısa i) = götürdü ("birin" fiilinin geçmiş kökü, ergatif). "bîr" (uzun î) = kuyu (su kuyusu) / hafıza. Ünlü uzunluğu anlamı değiştirir! "Kesmek" Kurmancî\'de "birîn" (uzun î).',
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
    // FIX 2026-04: 'selamlama' kategorisi kelime DB'sinde yok — doğru kategori 'silav'.
    // Önceki kod sessizce boş liste döndürüyordu, ders FSRS'e sıfır kart veriyordu.
    targetCardIds: _kartsFromKat(['silav']).take(8).toList(),
    culturalRewardId: 'proverb_1',
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(
        id: 'a1_010_ex1',
        ku: 'Silav',
        prompt: 'Ne anlama geliyor?',
        options: ['Merhaba', 'Hoşça kal', 'Teşekkür', 'Özür dilerim'],
        correctIndex: 0,
        audio: 'assets/audio/a1/silav.mp3',
      ),
      _listenSelect(
        id: 'a1_012_ex1',
        ku: 'Spas',
        prompt: 'Ne anlama geliyor?',
        options: ['Özür dilerim', 'Merhaba', 'Teşekkür ederim', 'Hoşça kal'],
        correctIndex: 2,
        audio: 'assets/audio/a1/spas.mp3',
      ),
      _multiChoice(
        id: 'a1_014_ex1',
        ku: '"Erê" ne demek?',
        tr: 'Doğru karşılığı bul',
        options: ['Belki', 'Bilmiyorum', 'Evet', 'Hayır'],
        correctIndex: 2,
      ),
      _multiChoice(
        id: 'a1_015_ex1',
        ku: '"Na" ne demek?',
        tr: 'Doğru karşılığı bul',
        options: ['Belki', 'Hayır', 'Evet', 'Tamam'],
        correctIndex: 1,
      ),
      _fillBlank(
        id: 'silav_fill_ex1',
        before: '',
        after: ', pîrê!',
        turkish: '___, büyükanne! (Selamlama)',
        options: ['Bibore', 'Spas', 'Na', 'Silav'],
        correctIndex: 3,
        grammarNote: 'Hitap ederken isim (bang) cümle sonuna gelir: "Silav, pîrê!" = Merhaba, büyükanne!',
      ),
      _listenSelect(
        id: 'a1_016_ex1',
        ku: 'Baş e',
        prompt: 'Ne anlama geliyor?',
        options: ['İyi / Tamam', 'Belki', 'Kötü', 'Değil'],
        correctIndex: 0,
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
    // FIX 2026-04: bkz. a1_l03 — 'selamlama' yerine 'silav'.
    targetCardIds: _kartsFromKat(['silav']).skip(4).take(8).toList(),
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(
        id: 'cawa_ex1',
        ku: 'Tu çawa yî?',
        prompt: 'Bu soru ne soruyor?',
        options: ['Ne yapıyorsun?', 'Nerelisin?', 'Adın ne?', 'Nasılsın?'],
        correctIndex: 3,
        audio: 'assets/audio/a1/cawa.mp3',
        grammarNote: '"Çawa" = nasıl. "yî" = sen-sin (bûn fiili 2.tekil). "Tu çawa yî?" = Nasılsın?',
      ),
      _listenSelect(
        id: 'bash_im_ex1',
        ku: 'Ez baş im',
        prompt: 'Bu cümle ne anlama gelir?',
        options: ['İyi değilim', 'İyisin', 'Çok iyiyim', 'İyiyim'],
        correctIndex: 3,
        audio: 'assets/audio/a1/ez_bash.mp3',
        grammarNote: '"Ez" = ben. "baş" = iyi. "im" = -im (bûn 1.tekil). SOV değil — isim cümlesi!',
      ),
      _fillBlank(
        id: 'ez_fill_ex1',
        before: 'Ez baş',
        after: '.',
        turkish: 'İyiyim.',
        options: ['î', 'e', 'im', 'in'],
        correctIndex: 2,
        grammarNote: 'Bûn çekimi: Ez … im / Tu … î / Ew … e / Em … in',
      ),
      _multiChoice(
        id: 'bextewar_ex1',
        ku: '"Bextewar" ne demek?',
        tr: 'Doğru karşılığı bul',
        options: ['Mutlu / Bahtiyar', 'Hasta', 'Üzgün', 'Yorgun'],
        correctIndex: 0,
        grammarNote: '"Bextewar" = mutlu/bahtiyar — Farsça kökenli ama Kurmancîde yerleşmiş',
      ),
      _listenSelect(
        id: 'xatirete_ex1',
        ku: 'Xatirê te',
        prompt: 'Bu ifade ne zaman söylenir?',
        options: ['Yemek yerken', 'Karşılaşırken', 'Uyurken', 'Ayrılırken'],
        correctIndex: 3,
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
        options: ['Adım … dır', 'Nasılsın?', 'Kaç yaşındasın?', 'Nerelisin?'],
        correctIndex: 0,
        audio: 'assets/audio/a1/nave_min.mp3',
        grammarNote: '"Nav" = ad/isim (eril). "Navê" = ezafe (-ê eril). "navê min" = benim adım',
      ),
      _multiChoice(
        id: 'tu_ki_ex1',
        ku: '"Tu kî yî?" sorusuna ne cevap verilir?',
        tr: 'Doğru cevabı seç',
        options: [
          'Ez li malê me',
          'Heftê sal in',
          'Ez baş im',
          'Navê min Narin e',
        ],
        correctIndex: 3,
        grammarNote: '"Tu kî yî?" = Sen kimsin? → "Navê min … e" ile cevap verilir',
      ),
      _fillBlank(
        id: 'bixer_fill_ex1',
        before: 'Bi xêr',
        after: '!',
        turkish: 'Hoş geldin! (tekil)',
        options: ['hatîn', 'hatim', 'hatî', 'hatî ye'],
        correctIndex: 2,
        grammarNote: '"Bi xêr hatî!" = hoş geldin (2.tekil). "Bi xêr hatin!" = hoş geldiniz (çoğul)',
      ),
      _listenSelect(
        id: 'bibore_ex1',
        ku: 'Bibore!',
        prompt: 'Bu kelime ne zaman kullanılır?',
        options: ['Selam verirken', 'Veda ederken', 'Teşekkür ederken', 'Özür dilerken'],
        correctIndex: 3,
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
    // FIX 2026-04: bkz. üstteki orphan ID notu.
    culturalRewardId: 'proverb_2',
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'yek_ex1', ku: 'Yek', prompt: 'Kaç?',
          options: ['İki', 'Üç', 'Bir', 'Dört'], correctIndex: 2,
          audio: 'assets/audio/a1/yek.mp3'),
      _listenSelect(id: 'du_ex1', ku: 'Du', prompt: 'Kaç?',
          options: ['Bir', 'İki', 'Üç', 'Dört'], correctIndex: 1,
          audio: 'assets/audio/a1/du.mp3'),
      _listenSelect(id: 'pênc_ex1', ku: 'Pênc', prompt: 'Kaç?',
          options: ['Altı', 'Yedi', 'Dört', 'Beş'], correctIndex: 3,
          audio: 'assets/audio/a1/penc.mp3'),
      _fillBlank(
        id: 'yek_fill_ex1',
        before: '',
        after: 'çay bide min, dêyê.',
        turkish: '___ çay ver bana, anneciğim.',
        options: ['Du', 'Sê', 'Yek', 'Çar'],
        correctIndex: 2,
        grammarNote: '"Yek çay" = bir çay. "Bide min" = ver bana (imperative)',
      ),
      _multiChoice(
        id: 'deh_ex1',
        ku: '"Deh" kaç eder?',
        tr: 'Doğru sayıyı seç',
        options: ['Beş', 'On', 'Yirmi', 'Dokuz'],
        correctIndex: 1,
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
          options: ['Kırk', 'On', 'Otuz', 'Yirmi'], correctIndex: 3,
          audio: 'assets/audio/a1/bist.mp3'),
      _listenSelect(id: 'sed_ex1', ku: 'Sed', prompt: 'Kaç?',
          options: ['Elli', 'On', 'Yüz', 'Bin'], correctIndex: 2,
          audio: 'assets/audio/a1/sed.mp3'),
      _multiChoice(
        id: 'hezar_ex1',
        ku: '"Gelek spas" içindeki "gelek" ne demek?',
        tr: 'Doğru anlamı bul',
        options: ['Çok', 'Az', 'Bazen', 'Hiç'],
        correctIndex: 0,
        grammarNote: '"Gelek" = çok. "Gelek spas" = çok teşekkürler. "Hezar spas" = bin teşekkürler',
      ),
      _fillBlank(
        id: 'sal_fill_ex1',
        before: 'Pîr bîst ',
        after: ' ye.',
        turkish: '20 yaşındadır — boşluğa hangi sıfat formu gelir? İPUCU: "X-î ye" yapısı (sayı + zaman birimi-î) = "X yaşında".',
        options: ['rojî', 'mehî', 'salî', 'demî'],
        correctIndex: 2,
        grammarNote: '"Pîr bîst salî ye" = Büyükanne 20 yaşında. Yaş bildirme yapısı: hejmar + sal + -î (bitişik sıfat eki). Şimdiki zamanda özne nominatif: "Pîr" (Pîrê DEĞİL).',
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
          options: ['Kırmızı', 'Siyah', 'Beyaz', 'Mavi'], correctIndex: 2,
          audio: 'assets/audio/a1/spi.mp3'),
      _listenSelect(id: 'reş_ex1', ku: 'Reş', prompt: 'Hangi renk?',
          options: ['Siyah', 'Yeşil', 'Beyaz', 'Sarı'], correctIndex: 0,
          audio: 'assets/audio/a1/res.mp3'),
      _listenSelect(id: 'kesk_ex1', ku: 'Kesk', prompt: 'Hangi renk?',
          options: ['Kırmızı', 'Sarı', 'Mavi', 'Yeşil'], correctIndex: 3,
          audio: 'assets/audio/a1/kesk.mp3',
          grammarNote: '"Kesk" = yeşil — Kürt bayrağının ortasındaki renk. Çiyayên kesk = yeşil dağlar'),
      _multiChoice(
        id: 'sin_uyari_ex1',
        ku: 'Peyva "Şîn" du wate hene. Kîjan in?',
        tr: '"Şîn" kelimesinin iki anlamı vardır. Doğru çifti seç.',
        options: [
          'Beyaz ve temiz',
          'Yeşil ve canlı',
          'Mavi ve üzgün',
          'Sarı ve solgun',
        ],
        correctIndex: 2,
        grammarNote: '⚠️ "Şîn" = hem mavi hem üzgün. "Ew şîn e" = o mavidir VEYA o üzgündür — bağlamdan anlaşılır!',
      ),
      _fillBlank(
        id: 'agir_renk_ex1',
        before: 'Agirê Newrozê',
        after: 'e.',
        turkish: 'Newroz ateşi ___ dir.',
        options: ['sor', 'şîn', 'kesk', 'spî'],
        correctIndex: 0,
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
    // FIX 2026-04: orphan → proverb_1 (aile teması için genel atasözü).
    culturalRewardId: 'proverb_1',
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(id: 'de_ex1', ku: 'Dê', prompt: 'Ne anlama geliyor?',
          options: ['Kız kardeş', 'Anne', 'Büyükanne', 'Baba'], correctIndex: 1,
          audio: 'assets/audio/a1/de.mp3',
          grammarNote: '"Dê" = anne (dişil, mê). Ezafe: "dêya min" = annemin. "Daya/Dayik" da kullanılır'),
      _listenSelect(id: 'bav_ex1', ku: 'Bav', prompt: 'Ne anlama geliyor?',
          options: ['Amca', 'Baba', 'Kardeş', 'Dede'], correctIndex: 1,
          audio: 'assets/audio/a1/bav.mp3',
          grammarNote: '"Bav" = baba (eril, nêr). Ezafe: "bavê min" = babamın'),
      _fillBlank(
        id: 'deya_fill_ex1',
        before: '',
        after: 'ya min baş e.',
        turkish: 'Aile üyem hakkında. İPUCU: "-ya" ezafe sesliyle biten DİŞİL bir aile üyesini ister.',
        options: ['Dê', 'Xwişk', 'Bira', 'Bav'],
        correctIndex: 0,
        grammarNote: '"Dêya min" = benim annem. Dişil (mê) ezafe: sonu sessizle biten → -a, sonu sesliyle biten → -ya. "Dê" sonu sesli → "dêya"',
      ),
      _multiChoice(
        id: 'bira_xwisk_ex1',
        ku: 'Ferqa peyvên "Bira" û "Xwişk" çi ye?',
        tr: '"Bira" ve "Xwişk" kelimelerindeki fark nedir? Doğru açıklamayı seç.',
        options: [
          '"Bira" büyük, "Xwişk" küçük kardeş',
          'İkisi de "kardeş" demek, fark yok',
          '"Bira" = kız kardeş, "Xwişk" = erkek kardeş',
          '"Bira" = erkek kardeş, "Xwişk" = kız kardeş',
        ],
        correctIndex: 3,
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
          options: ['Hala', 'Büyükbaba', 'Teyze', 'Büyükanne'], correctIndex: 3,
          audio: 'assets/audio/a1/piree.mp3',
          grammarNote: '"Dapîr" = büyükanne (dişil/mê). Ezafe: "dapîra min". "Pîrê" de kullanılır.'),
      _listenSelect(id: 'kal_ex1', ku: 'Kal', prompt: 'Ne anlama geliyor?',
          options: ['Amca (baba tarafı)', 'Dayı (anne tarafı)', 'Baba', 'Büyükbaba'], correctIndex: 3,
          audio: 'assets/audio/a1/kal.mp3',
          grammarNote: '"Kal" = büyükbaba (eril/nêr). Eşdeğer "Bapîr" de kullanılır.'),
      _fillBlank(
        id: 'pireya_fill_ex1',
        before: 'Ez ji',
        after: 'a xwe hez dikim.',
        turkish: 'Bir kadın aile üyesini seviyorum (yapı: ji ___a xwe hez dikim). İPUCU: "-a" ezafe → DİŞİL aile üyesi gerekli.',
        options: ['dapîr', 'bav', 'ap', 'kal'],
        correctIndex: 0,
        grammarNote: '"Ji … hez kirin" = -i sevmek. Dişil ezafe sessiz harfle biten kelimede -a: "dapîra xwe" = kendi büyükannem. Eril seçenekler (kal/bav/ap) "-a" ezafe alamaz.',
      ),
      _multiChoice(
        id: 'ap_xalti_ex1',
        ku: '"Ap" amê kîjan aliyî ye?',
        tr: '"Ap" kimin amcasıdır? Doğru açıklamayı bul.',
        options: [
          'Her iki taraftan amca',
          'Anne tarafı amca',
          'Dayı demek',
          'Baba tarafı amca',
        ],
        correctIndex: 3,
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
          options: ['O', 'Biz', 'Sen', 'Ben'], correctIndex: 3,
          audio: 'assets/audio/a1/ez.mp3'),
      _listenSelect(id: 'tu_ex1', ku: 'Tu', prompt: 'Hangi zamir?',
          options: ['Sen', 'Ben', 'Biz', 'Onlar'], correctIndex: 0,
          audio: 'assets/audio/a1/tu.mp3'),
      _listenSelect(id: 'em_ex1', ku: 'Em', prompt: 'Hangi zamir?',
          options: ['Onlar', 'Ben', 'Siz', 'Biz'], correctIndex: 3,
          audio: 'assets/audio/a1/em.mp3'),
      _fillBlank(
        id: 'bun_fill_ex1',
        before: '___ baş im.',
        after: '',
        turkish: '___ iyiyim.',
        options: ['Tu', 'Em', 'Ew', 'Ez'],
        correctIndex: 3,
        grammarNote: '"Im" eki 1.tekil — sadece "Ez" ile kullanılır. "Tu baş î" / "Ew baş e" / "Em baş in"',
      ),
      _multiChoice(
        id: 'hun_ex1',
        ku: 'Cînavka "Hûn" çawa tê bikaranîn?',
        tr: '"Hûn" zamiri nasıl kullanılır? Doğru açıklamayı seç.',
        options: [
          'Hiçbiri',
          'Sadece çoğul "siz" için',
          'Sadece saygı için tekile',
          'Hem çoğul "siz" hem saygı tekil',
        ],
        correctIndex: 3,
        grammarNote: '"Hûn" = siz (çoğul) VEYA saygılı tekil — büyüklere "Tu" değil "Hûn" denir',
      ),
    ],
  ),

  LessonModel(
    id: 'a1_l12',
    kurmanjTitle: 'Cînavkên Oblîk',
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
        ku: 'Çima di "Navê min" de "min" tê bikaranîn?',
        tr: '"Navê min" neden "min" kullanıyor? Doğru açıklamayı bul.',
        options: [
          'Rastgele seçim',
          '"Min" = "ez"nin saygılı formu',
          '"Min" = "ez"nin eğik/tamlama hali',
          'Yanlış — "navê ez" olmalı',
        ],
        correctIndex: 2,
        grammarNote: 'Kurmancîde tamlama/eğik hali: Ez→Min, Tu→Te, Ew→Wî/Wê, Em→Me. "Navê min" = benim adım',
      ),
      _fillBlank(
        id: 'spas_te_fill_ex1',
        before: 'Spas ji',
        after: 're!',
        turkish: 'Sana teşekkürler!',
        options: ['wî', 'ez', 'tu', 'te'],
        correctIndex: 3,
        grammarNote: '"Ji te re" = sana (yön). "Te" = "tu"nun eğik hali',
      ),
      _fillBlank(
        id: 'mala_fill_ex1',
        before: 'Mala',
        after: 'baş e.',
        turkish: '"Ev iyi" — ezafe ile sahibi gösteriliyor (1. tekil şahıs). İPUCU: tamlamada şahıs zamiri EĞİK halde olur.',
        options: ['min', 'ez', 'tu', 'me'],
        correctIndex: 0,
        grammarNote: '"Mala min" = benim evim. "min" = "ez"in eğik (oblîk) hali, sahiplik tamlamasında zorunlu. "ez" düz hal — burada doğru DEĞİL.',
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
          options: ['Polis', 'Doktor', 'Öğretmen', 'Öğrenci'], correctIndex: 2,
          audio: 'assets/audio/a1/mamosta.mp3'),
      _listenSelect(id: 'xwendekar_ex1', ku: 'Xwendekar', prompt: 'Ne anlama geliyor?',
          options: ['Çiftçi', 'Öğrenci', 'İşçi', 'Öğretmen'], correctIndex: 1,
          audio: 'assets/audio/a1/xwendekar.mp3',
          grammarNote: '"Xwend" = okudu + "-ekar" = yapan kişi. x sesi gırtlaktan!'),
      _listenSelect(id: 'bijisk_ex1', ku: 'Bijîşk', prompt: 'Ne anlama geliyor?',
          options: ['Mühendis', 'Doktor/Hekim', 'Öğretmen', 'Polis'], correctIndex: 1,
          audio: 'assets/audio/a1/bijisk.mp3',
          grammarNote: '"Bijîşk" saf Kurmancî kelime — "Doktor" da kullanılır ama "bijîşk" daha özgün'),
      _fillBlank(
        id: 'mamosta_fill_ex1',
        before: 'Bavê min',
        after: 'ye.',
        turkish: 'Babamın mesleği söyleniyor (okul ortamında çalışan biri). "ye" sessiz sonrası kopula. İPUCU: 4 meslekten hangisi okulda öğretir?',
        options: ['bijîşk', 'mamosta', 'karker', 'xwendekar'],
        correctIndex: 1,
        grammarNote: 'İsim cümlesi: özne + meslek + bûn. "Bavê min mamosta ye" — eril için "ye"',
      ),
      _multiChoice(
        id: 'dibistan_zanin_ex1',
        ku: 'Ferqa "Dibistan" û "Zanîngeh" çi ye?',
        tr: '"Dibistan" ve "Zanîngeh" arasındaki fark nedir? Doğru çifti seç.',
        options: [
          '"Dibistan" = okul, "Zanîngeh" = üniversite',
          '"Dibistan" = üniversite, "Zanîngeh" = okul',
          '"Dibistan" = kütüphane',
          'İkisi de "okul" demek',
        ],
        correctIndex: 0,
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
          options: ['Gece ve ay', 'Gün ve güneş', 'Gün ve gece', 'Sabah ve akşam'], correctIndex: 1,
          audio: 'assets/audio/a1/roj.mp3',
          grammarNote: '"Roj" = hem gün hem güneş (eril). "Newroz" = yeni gün (nû + roj)!'),
      _listenSelect(id: 'iro_duh_ex1', ku: 'Îro', prompt: 'Ne anlama geliyor?',
          options: ['Yarın', 'Bu hafta', 'Bugün', 'Dün'], correctIndex: 2,
          audio: 'assets/audio/a1/iro.mp3'),
      _multiChoice(
        id: 'sibe_ex1',
        ku: 'Peyva "Sibê" çend wate hene?',
        tr: '"Sibê" kelimesinin kaç anlamı var? Doğru cevabı seç.',
        options: ['Bir — sabah', 'Anlam yok', 'Üç', 'İki — sabah ve yarın'],
        correctIndex: 3,
        grammarNote: '"Sibê" = sabah vakti VEYA yarın. "Sibê têm" = yarın geliyorum. "Sibê baş!" = günaydın',
      ),
      _listenSelect(id: 'heft_roj_ex1', ku: 'Hefte', prompt: 'Ne anlama geliyor?',
          options: ['Gün', 'Ay', 'Yıl', 'Hafta'], correctIndex: 3,
          grammarNote: '"Hefte" (mê) = hafta. Ezafe: "hefteya min" = haftam. Oblique: "vê heftê" = bu hafta'),
      _fillBlank(
        id: 'duşem_fill_ex1',
        before: '',
        after: 'roja yekem a hefteyê ye.',
        turkish: '___ haftanın ilk günüdür. (Pazar)',
        options: ['Duşem', 'Înî', 'Şemî', 'Yekşem'],
        correctIndex: 3,
        grammarNote: '"Yekşem" = Pazar (yek "bir" + şem "akşam/nöbet" — Farsça kökenli) — haftanın ilk günü. "Duşem" = Pazartesi (du "iki" + şem). Kürt-İran takvim geleneğinde gün sayımı Pazardan başlar.',
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
    // FIX 2026-04: 'c_newroz' yerine mevcut 'newroz_1'.
    culturalRewardId: 'newroz_1',
    estimatedMinutes: 9,
    exercises: [
      _listenSelect(id: 'bihar_ex1', ku: 'Bihar', prompt: 'Hangi mevsim?',
          options: ['Yaz', 'Kış', 'İlkbahar', 'Sonbahar'], correctIndex: 2,
          audio: 'assets/audio/a1/bihar.mp3',
          grammarNote: '"Bihar" = ilkbahar — Newroz biharê tê! (Newroz ilkbaharda gelir)'),
      _listenSelect(id: 'zivistan_ex1', ku: 'Zivistan', prompt: 'Hangi mevsim?',
          options: ['Sonbahar', 'İlkbahar', 'Yaz', 'Kış'], correctIndex: 3,
          audio: 'assets/audio/a1/zivistan.mp3'),
      _fillBlank(
        id: 'newroz_fill_ex1',
        before: 'Newroz di',
        after: 'ê de tê.',
        turkish: 'Newroz ___ da gelir. (Mevsim adını ekle)',
        options: ['Havînê', 'Biharê', 'Zivistanê', 'Payîzê'],
        correctIndex: 1,
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
    // FIX 2026-04: orphan → proverb_2 (dil-kimlik teması).
    culturalRewardId: 'proverb_2',
    estimatedMinutes: 8,
    exercises: [
      _listenSelect(id: 'nan_ex1', ku: 'Nan', prompt: 'Ne anlama geliyor?',
          options: ['Süt', 'Ekmek', 'Et', 'Su'], correctIndex: 1,
          audio: 'assets/audio/a1/nan.mp3',
          grammarNote: '"Nan" = ekmek (eril). "Nan û xwê" = ekmek ve tuz — Kürt misafirperverliğinin simgesi!'),
      _listenSelect(id: 'av_ex1', ku: 'Av', prompt: 'Ne anlama geliyor?',
          options: ['Çay', 'Su', 'Süt', 'Ekmek'], correctIndex: 1,
          audio: 'assets/audio/a1/av.mp3',
          grammarNote: '"Av" = su (dişil). "Avê bide min" = su ver bana'),
      _listenSelect(id: 'cay_ex1', ku: 'Çay', prompt: 'Ne anlama geliyor?',
          options: ['Su', 'Süt', 'Çay', 'Kahve'], correctIndex: 2,
          audio: 'assets/audio/a1/cay.mp3',
          grammarNote: '"Çay" = çay (eril). Kürt kültüründe misafir çayı zorunlu gelenektir!'),
      _fillBlank(
        id: 'xwarin_fill_ex1',
        before: 'Ez nan',
        after: '.',
        turkish: 'Ekmekle ilgili bir eylem (yemek mi içmek mi?). İPUCU: "xwarin" (yemek) ↔ "vexwarin" (içmek) — şimdiki zaman 1.tekil.',
        options: ['dixwim', 'dikim', 'diçim', 'vedixwim'],
        correctIndex: 0,
        grammarNote: '"Dixwim" = yiyorum (di + xw + im). "Vedixwim" = içiyorum. "Diçim" = gidiyorum, "Dikim" = yapıyorum — bağlama uymaz.',
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
          options: ['Yoğurt', 'Tereyağı', 'Süt', 'Peynir'], correctIndex: 0,
          audio: 'assets/audio/a1/mast.mp3'),
      _multiChoice(
        id: 'nan_xwe_ex1',
        ku: 'Bêjeya "Nan û xwê" tê çi wateyê?',
        tr: '"Nan û xwê" ne anlama gelir? Kültürel anlamı bul.',
        options: [
          'Misafirperverliğin simgesi',
          'Kahvaltı menüsü',
          'Çorbaya katılanlar',
          'Sadece yiyecekler',
        ],
        correctIndex: 0,
        grammarNote: '"Nan û xwê bide mêvanê xwe" = Misafirine ekmek ve tuz sun — bağ kurmanın simgesi',
      ),
      _fillBlank(
        id: 'goşt_fill_ex1',
        before: 'Pîr ',
        after: ' dipijîne.',
        turkish: 'Büyükanne pişiriyor — ne pişirir? "Dipijîne" pişirme fiili gerektirir (su/yoğurt değil — ısıyla pişen yiyecek).',
        options: ['nan', 'goşt', 'mast', 'av'],
        correctIndex: 1,
        grammarNote: '"Pîr goşt dipijîne" = Büyükanne et pişiriyor. Şimdiki zaman özne NOMINATIF: "Pîr" (Pîrê DEĞİL — Pîrê oblikt). "Dipijîne" = pişiriyor. "Av" (su)/"mast" (yoğurt) pişirilmez.',
      ),
      _speaking(
        id: 'sofra_speak',
        ku: 'Xwarin xweş bû! Destê te xweş be.',
        tr: 'Yemek güzeldi! Elinize sağlık.',
      ),
      // ADD 2026-04: Bloom "uygulama/analiz" seviyesi — otantik Mitfaxa Dapîrê
      // sahnesi. Diaspora öğrenci için heritage bağlamı zorunlu (müfredat İlke 3).
      _multiChoice(
        id: 'mitfax_dapire_ex1',
        ku: 'Hevoka "Mitfaxa dapîrê" li ku û di kîjan rewşê de tê bikaranîn?',
        tr: '"Mitfaxa dapîrê" ifadesi nerede ve hangi bağlamda kullanılır? (Heritage)',
        options: [
          'Restoran reklamında',
          'Resmi mektupta',
          'Diaspora anısı, nineden öğrenilen yemek',
          'Çocuk yemek tarifinde',
        ],
        correctIndex: 2,
        grammarNote: '"Mitfax" = mutfak (-a ezafe). "Dapîr" = büyükanne.\n'
            'Kültürel ağırlık: asimile kuşak için büyükannenin mutfağı dil/kimlik mekânıdır.',
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
          options: ['El', 'Baş', 'Kulak', 'Göz'], correctIndex: 1,
          audio: 'assets/audio/a1/seri.mp3'),
      _listenSelect(id: 'çav_ex1', ku: 'Çav', prompt: 'Ne anlama geliyor?',
          options: ['Ağız', 'Burun', 'Kulak', 'Göz'], correctIndex: 3,
          audio: 'assets/audio/a1/cav.mp3'),
      _multiChoice(
        id: 'ziman_iki_anlam_ex1',
        ku: 'Peyva "Ziman" du wateyên wê hene. Kîjan in?',
        tr: '"Ziman" kelimesinin iki anlamı hangisi? Doğru çifti bul.',
        options: [
          'El ve kol',
          'Göz ve bakış',
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
        options: ['bextewar', 'birçî', 'nexweş', 'baş'],
        correctIndex: 2,
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
          options: ['Ev', 'Oda', 'Bahçe', 'Köy'], correctIndex: 0,
          audio: 'assets/audio/a1/mal.mp3',
          grammarNote: '"Mal" = ev/yurt (dişil). "Mala min" = benim evim. "Li malê" = evde'),
      _multiChoice(
        id: 'li_vir_ex1',
        ku: '"Li vir" ne anlama geliyor?',
        tr: 'Doğru çeviriyi bul',
        options: ['Yukarıda', 'Orada', 'Burada', 'Nerede'],
        correctIndex: 2,
        grammarNote: '"Li" = -de/-da (yer edatı). "Vir" = bura. "Li vir" = burada',
      ),
      _fillBlank(
        id: 'piree_li_fill_ex1',
        before: 'Pîrê li',
        after: 'ye.',
        turkish: 'Büyükanne bir yerde. Hangi mekân günlük ailevi bağlamda en olası? (şehir/dağ/köy değil — daha yakın iç mekân)',
        options: ['malê', 'bajêr', 'gundê', 'çiyayê'],
        correctIndex: 0,
        grammarNote: '"Li malê" = evde. "Malê" = "mal"in (mê) tewandî hali. Diğer seçenekler de yer ifade eder ama bağlam özel olarak ev içini gerektirir.',
      ),
      _listenSelect(id: 'nêzîk_dûr_ex1', ku: 'Nêzîk',
          prompt: 'Ne anlama geliyor?',
          options: ['Yukarı', 'Aşağı', 'Yakın', 'Uzak'], correctIndex: 2),
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
        ku: 'Gelo "Baş" û "Xerab" dijwate ne?',
        tr: '"Baş" ve "Xerab" zıt mı? Doğru çifti seç.',
        options: [
          'Hayır — ikisi de iyi demek',
          'Evet — iyi/kötü',
          'Evet — büyük/küçük',
          'Hayır — aynı anlam',
        ],
        correctIndex: 1,
        // DISLEKSI: 130+ kar. → 2 kısa chunk.
        grammarNote: 'Kurmancî sıfatlar DEĞİŞMEZ.\nMala baş = iyi ev · malên baş = iyi evler.',
      ),
      _fillBlank(
        id: 'germ_sar_fill_ex1',
        before: 'Çayê',
        after: 'vexwe!',
        turkish: '___ çay iç!',
        options: ['sar', 'biçûk', 'nû', 'germ'],
        correctIndex: 3,
        grammarNote: '"Germ" = sıcak. "Çayê germ" = sıcak çay. Sıfat isimden sonra geliyor!',
      ),
      _listenSelect(id: 'xwesh_ex1', ku: 'Xweş', prompt: 'Ne anlama geliyor?',
          options: ['Kötü', 'Büyük', 'Güzel/İyi', 'Hasta'], correctIndex: 2,
          audio: 'assets/audio/a1/xwesh.mp3',
          grammarNote: '"Xweş" çok kullanılan kelime: güzel, iyi, hoş. "Xweş bî!" = iyi ol!'),
      _multiChoice(
        id: 'gelek_ex1',
        ku: 'Peyva "Gelek" ji kîjan cureya peyvan e?',
        tr: '"Gelek" hangi tür kelimedir? Doğru tanımı bul.',
        options: ['Fiil', 'Zamir', 'Zarf — çok anlamı', 'Sıfat — büyük anlamı'],
        correctIndex: 2,
        grammarNote: '"Gelek" = çok (zarf). Sıfattan önce gelir: "gelek baş" = çok iyi',
      ),
      _speaking(
        id: 'a1_son_speak',
        ku: 'Ez Kurmancî dixwînim û kêfxweş im!',
        tr: 'Kurmancî öğreniyorum ve mutluyum!',
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
