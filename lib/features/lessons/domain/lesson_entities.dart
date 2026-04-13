import '../../../core/utils/fsrs_algorithm.dart';

// ════════════════════════════════════════════════════════════════
// VOCABULARY CARD DOMAIN MODELİ
// ════════════════════════════════════════════════════════════════

class VocabularyCardModel {
  final String id;
  final String kurmanji;
  final String turkish;
  final String? english;
  final String? pronunciation;
  final String? audioUrl;
  final String gender; // masculine / feminine / neutral
  final KurmanjiCategory category;
  final int level; // 1=A1, 2=A2, 3=B1, 4=B2
  final List<String> sentencesHeritage;
  final List<String> sentencesGeneral;
  final double initialDifficulty;
  final List<String> tags;

  // FSRS verisi (kullanıcıya özel — DB'den join edilir)
  final FSRSCard? fsrsCard;

  const VocabularyCardModel({
    required this.id,
    required this.kurmanji,
    required this.turkish,
    this.english,
    this.pronunciation,
    this.audioUrl,
    this.gender = 'neutral',
    required this.category,
    required this.level,
    this.sentencesHeritage = const [],
    this.sentencesGeneral = const [],
    this.initialDifficulty = 5.0,
    this.tags = const [],
    this.fsrsCard,
  });

  bool get isDue =>
      fsrsCard == null || fsrsCard!.dueDate == null ||
      fsrsCard!.dueDate!.isBefore(DateTime.now());

  double get currentRetention =>
      fsrsCard != null ? LutkeScheduler.currentRetrievability(fsrsCard!) : 0.0;

  String get levelLabel => switch (level) {
        1 => 'A1',
        2 => 'A2',
        3 => 'B1',
        4 => 'B2',
        _ => 'A1',
      };

  @override
  String toString() => 'VocabularyCardModel($id: $kurmanji / $turkish)';
}

// ════════════════════════════════════════════════════════════════
// EGZERSİZ TİPLERİ
// ════════════════════════════════════════════════════════════════

enum ExerciseType {
  listenAndSelect,   // Ses dinle → 4 seçenekten seç
  multipleChoice,    // Oku → seç (ses olmadan)
  dragAndDrop,       // Kelimeleri sürükle-bırak sırala
  fillInBlank,       // Boşluk doldur
  speakingPractice,  // Dinle → kaydet → kendin değerlendir
  minimalPair,       // ker/kêr gibi fonemik çiftler
  culturalContent,   // Atasözü / türkü modülü
}

// ════════════════════════════════════════════════════════════════
// EGZERSİZ MODELİ
// ════════════════════════════════════════════════════════════════

class ExerciseModel {
  final String id;
  final ExerciseType type;
  final String kurmanjPrompt;      // Soru metni (Kurmancî)
  final String? turkishPrompt;     // Yardımcı Türkçe
  final String? audioAsset;        // Ses dosyası yolu
  final List<String> options;      // Seçenekler (Türkçe veya Kurmancî)
  final String correctAnswer;      // Doğru cevap
  final int? correctIndex;         // Çoktan seçmeli için indeks
  final String? grammarNote;       // Gramer açıklaması (isteğe bağlı)
  final String? culturalNote;      // Kültürel not
  final int xpReward;
  final String? cardId;            // İlişkili kelime kartı
  final String? sentenceHeritage;  // Heritage örnek cümle
  final String? sentenceGeneral;   // Genel örnek cümle
  final String? grammar;           // Gramer notu (= grammarNote alias)
  final String? prompt;            // Soru metni
  final String? correctOption;     // Doğru şık (çoktan seçmeli)
  final String? gender;            // Kelime cinsiyeti

  // Lesson_screen için getter'lar
  String get kurmanci => kurmanjPrompt;
  String get turkish => turkishPrompt ?? '';

  // Sürükle-bırak için
  final List<String>? wordPieces;  // Parçalar
  final String? targetSentence;    // Hedef cümle

  const ExerciseModel({
    required this.id,
    required this.type,
    required this.kurmanjPrompt,
    this.turkishPrompt,
    this.audioAsset,
    this.options = const [],
    required this.correctAnswer,
    this.correctIndex,
    this.grammarNote,
    this.culturalNote,
    this.xpReward = 10,
    this.cardId,
    this.sentenceHeritage,
    this.sentenceGeneral,
    this.grammar,
    this.prompt,
    this.correctOption,
    this.gender,
    this.wordPieces,
    this.targetSentence,
  });
}

// ════════════════════════════════════════════════════════════════
// DERS MODELİ
// ════════════════════════════════════════════════════════════════

enum LessonPath {
  heritage, // Ev Yolu — Rêya Malê
  general,  // Yeni Yol — Rêya Nû
  cultural, // Kültür Yolu — Rêya Çandê
}

class LessonModel {
  final String id;
  final String kurmanjTitle;     // Kurmancî başlık — büyük, birincil
  final String turkishTitle;     // Türkçe başlık — küçük, ikincil
  final int unitNumber;
  final int lessonNumber;
  final int level;               // 1=A1, 2=A2, 3=B1, 4=B2
  final LessonPath path;
  final List<ExerciseModel> exercises;
  final String? culturalRewardId; // Ders sonunda gösterilecek kültürel içerik
  final List<String> targetCardIds; // Bu derste öğrenilecek kelimeler
  final int estimatedMinutes;
  final String? emoji;    // Ders ikonu

  const LessonModel({
    required this.id,
    required this.kurmanjTitle,
    required this.turkishTitle,
    required this.unitNumber,
    required this.lessonNumber,
    required this.level,
    required this.path,
    required this.exercises,
    this.culturalRewardId,
    this.targetCardIds = const [],
    this.estimatedMinutes = 8,
    this.emoji,
  });

  int get totalXP => exercises.fold(0, (sum, e) => sum + e.xpReward);

  // Kurmancî başlık — lesson_screen için
  String get titleKu => kurmanjTitle;
  String get titleTr => turkishTitle;
  String get kuTitle => kurmanjTitle;  // home_screen kısayolu
  String get trTitle => turkishTitle;  // home_screen kısayolu
  String? get icon => emoji;
  bool get hasHeritageContent =>
      exercises.any((e) => e.sentenceHeritage != null);
  int get xpReward => totalXP;

  // Kültürel ödül — ders sonunda (İlke 7.1)
  CulturalReward? get culturalReward => culturalRewardId != null
      ? CulturalReward.defaults[culturalRewardId]
      : null;

  // Alıştırmaları inşa et
  List<ExerciseModel> buildExercises() => exercises;
}

// ════════════════════════════════════════════════════════════════
// ROZET MODELİ
// ════════════════════════════════════════════════════════════════

class BadgeModel {
  final String id;
  final String kurmanjName;  // Kurmancî rozet adı
  final String turkishName;  // Türkçe ad
  final String description;
  final String iconAsset;
  final int xpRequired;      // Kazanmak için gereken XP (veya 0)
  final String? condition;   // Özel koşul açıklaması
  final String emoji;        // Rozet emojisi (asset yokken fallback)

  const BadgeModel({
    required this.id,
    required this.kurmanjName,
    required this.turkishName,
    required this.description,
    required this.iconAsset,
    this.xpRequired = 0,
    this.condition,
    this.emoji = '\u{1F3C5}', // default medal emoji
  });
}

// Tüm rozetler — Araştırma bulgularına göre kültürel kimlik odaklı
const kBadges = [
  // ── Temel rozetler (yeni gamification sistemi) ──────────────
  BadgeModel(
    id: 'destpeker',
    kurmanjName: 'Destpêk',
    turkishName: 'Başlangıç',
    description: 'İlk ders tamamlandı',
    iconAsset: 'assets/images/badges/destpeker.png',
    emoji: '\u{1F525}', // fire
  ),
  BadgeModel(
    id: 'zimanzan',
    kurmanjName: '100 Peyv',
    turkishName: '100 Kelime',
    description: '100 kelime öğrenildi',
    iconAsset: 'assets/images/badges/zimanzan.png',
    xpRequired: 0,
    condition: 'words_100',
    emoji: '\u{1F4DA}', // books
  ),
  BadgeModel(
    id: 'hefteya_temam',
    kurmanjName: 'Hefteya Temam',
    turkishName: 'Hafta Tamam',
    description: 'Haftalık hedef tamamlandı',
    iconAsset: 'assets/images/badges/hefteya_temam.png',
    condition: 'weekly_goal',
    emoji: '\u{1F3C6}', // trophy
  ),
  BadgeModel(
    id: 'a1_qediya',
    kurmanjName: 'A1 Qediya',
    turkishName: 'A1 Tamamlandı',
    description: 'A1 seviyesi tamamlandı',
    iconAsset: 'assets/images/badges/a1_qediya.png',
    xpRequired: 500,
    emoji: '\u{2B50}', // star
  ),
  BadgeModel(
    id: 'xp_500',
    kurmanjName: '500 XP',
    turkishName: '500 XP',
    description: '500 XP toplandı',
    iconAsset: 'assets/images/badges/xp_500.png',
    xpRequired: 500,
    emoji: '\u{1F48E}', // gem
  ),
  BadgeModel(
    id: 'rast_100',
    kurmanjName: 'Rast 100%',
    turkishName: 'Mükemmel Skor',
    description: 'Bir derste %100 doğruluk',
    iconAsset: 'assets/images/badges/rast_100.png',
    condition: 'perfect_score',
    emoji: '\u{1F3AF}', // target
  ),
  // ── Kültürel rozetler (orijinal) ────────────────────────────
  BadgeModel(
    id: 'malbatvan',
    kurmanjName: 'Malbatvan',
    turkishName: 'Aile İnsanı',
    description: '10 aile kelimesi öğrenildi',
    iconAsset: 'assets/images/badges/malbatvan.png',
    condition: 'family_words_10',
    emoji: '\u{1F46A}', // family
  ),
  BadgeModel(
    id: 'serbesti',
    kurmanjName: 'Serbestî',
    turkishName: 'Özgürlük',
    description: '4 hafta aktif kaldı',
    iconAsset: 'assets/images/badges/serbesti.png',
    condition: 'weeks_active_4',
    emoji: '\u{1F54A}', // dove
  ),
  BadgeModel(
    id: 'newrozvan',
    kurmanjName: 'Newrozvan',
    turkishName: 'Nevruz Kutlayanı',
    description: 'Newroz modülü tamamlandı',
    iconAsset: 'assets/images/badges/newrozvan.png',
    condition: 'newroz_module',
    emoji: '\u{1F525}', // fire
  ),
  BadgeModel(
    id: 'stranbej',
    kurmanjName: 'Stranbêj',
    turkishName: 'Türkücü',
    description: '50 dinleme egzersizi tamamlandı',
    iconAsset: 'assets/images/badges/stranbej.png',
    condition: 'listening_50',
    emoji: '\u{1F3B5}', // musical note
  ),
  BadgeModel(
    id: 'cirokvan',
    kurmanjName: 'Çîrokvan',
    turkishName: 'Hikayeci',
    description: 'B1 edebiyat modülü tamamlandı',
    iconAsset: 'assets/images/badges/cirokvan.png',
    condition: 'b1_literature',
    emoji: '\u{1F4D6}', // open book
  ),
];

// ════════════════════════════════════════════════════════════════
// A1 KELIME VERİSİ — İlk 30 Kelime (Seed Data)
// ════════════════════════════════════════════════════════════════

/// Uygulamanın ilk açılışında SQLite'a yüklenen A1 kelime listesi.
/// Kaynak: Osman Aslanoğlu Dil Kartları + Bedir Han & Lescot
/// Birim başlıkları Nisan 2026 düzeltmesiyle güncellenmiştir.
const kA1SeedCards = [
  // ── Birim 2: Silavdan û Pêşkêşkirin (Selamlama ve Tanışma) ──
  (
    id: 'a1_001',
    kurmanji: 'Silav',
    turkish: 'Merhaba',
    category: 'greeting',
    difficulty: 0.85,
    audioUrl: 'assets/audio/a1/silav.mp3',
    sentencesHeritage: ['Silav, dê!', 'Silav, pîrê!'],
    sentencesGeneral: ['Silav, heval!', 'Silav û spas.'],
  ),
  (
    id: 'a1_002',
    kurmanji: 'Spas',
    turkish: 'Teşekkür ederim',
    category: 'greeting',
    difficulty: 0.85,
    audioUrl: 'assets/audio/a1/spas.mp3',
    sentencesHeritage: ['Spas, dayê!', 'Gelek spas.'],
    sentencesGeneral: ['Spas ji te re.', 'Spas û sipas.'],
  ),
  (
    id: 'a1_003',
    kurmanji: 'Baş e',
    turkish: 'İyi / Tamam',
    category: 'greeting',
    difficulty: 0.83,
    audioUrl: 'assets/audio/a1/base.mp3',
    sentencesHeritage: ['Ez baş im, dayê.', 'Tu çawa yî? Baş im.'],
    sentencesGeneral: ['Baş e, spas.', 'Ev baş e.'],
  ),
  (
    id: 'a1_004',
    kurmanji: 'Erê',
    turkish: 'Evet',
    category: 'greeting',
    difficulty: 0.88,
    audioUrl: 'assets/audio/a1/ere.mp3',
    sentencesHeritage: ['Erê, dayê!', 'Erê, ez hatim.'],
    sentencesGeneral: ['Erê, baş e.', 'Erê, ez dizanim.'],
  ),
  (
    id: 'a1_005',
    kurmanji: 'Na',
    turkish: 'Hayır',
    category: 'greeting',
    difficulty: 0.88,
    audioUrl: 'assets/audio/a1/na.mp3',
    sentencesHeritage: ['Na, dê, ez neçûm.', 'Na, ez nexweş im.'],
    sentencesGeneral: ['Na, spas.', 'Na, ez nizanim.'],
  ),
  // ── Birim 5: Malbat (Aile Üyeleri) ─────────────────────────
  (
    id: 'a1_010',
    kurmanji: 'Dê',
    turkish: 'Anne',
    category: 'family',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/de.mp3',
    sentencesHeritage: ['Dêya min baş e.', 'Silav ji dêya min re!'],
    sentencesGeneral: ['Dê û bav', 'Dêya wî'],
  ),
  (
    id: 'a1_011',
    kurmanji: 'Bav',
    turkish: 'Baba',
    category: 'family',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/bav.mp3',
    sentencesHeritage: ['Bavê min li kar e.', 'Silav ji bavê min re!'],
    sentencesGeneral: ['Bav û dê', 'Bavê wî'],
  ),
  (
    id: 'a1_012',
    kurmanji: 'Bira',
    turkish: 'Erkek kardeş',
    category: 'family',
    difficulty: 0.80,
    audioUrl: 'assets/audio/a1/bira.mp3',
    sentencesHeritage: ['Birê min mezin e.', 'Birê te çawa ye?'],
    sentencesGeneral: ['Birê min û min', 'Birê wî'],
  ),
  (
    id: 'a1_013',
    kurmanji: 'Xwişk',
    turkish: 'Kız kardeş',
    category: 'family',
    difficulty: 0.80,
    audioUrl: 'assets/audio/a1/xwisk.mp3',
    sentencesHeritage: ['Xwişka min li dibistanê ye.', 'Xwişka te çawa ye?'],
    sentencesGeneral: ['Xwişk û bira', 'Xwişka wê'],
  ),
  (
    id: 'a1_014',
    kurmanji: 'Pîrê',
    turkish: 'Büyükanne',
    category: 'family',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/piree.mp3',
    sentencesHeritage: ['Pîrêya min Kurmancî dizane.', 'Ez ji pîrêya xwe hez dikim.'],
    sentencesGeneral: ['Pîrêya wî', 'Pîrêya min baş e.'],
  ),
  (
    id: 'a1_015',
    kurmanji: 'Bapîr',
    turkish: 'Büyükbaba / Dede',
    category: 'family',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/bapir.mp3',
    sentencesHeritage: ['Bapîrê min li gundê ye.', 'Ez bapîrê xwe dixwazim bibînim.'],
    sentencesGeneral: ['Bapîrê wî', 'Bapîr û pîrê'],
  ),
  // ── Birim 11: Mal û Cih (Ev ve Mekan) ──────────────────────
  (
    id: 'a1_020',
    kurmanji: 'Mal',
    turkish: 'Ev',
    category: 'daily',
    difficulty: 0.80,
    audioUrl: 'assets/audio/a1/mal.mp3',
    sentencesHeritage: ['Ez hatim malê.', 'Mala me mezin e.'],
    sentencesGeneral: ['Mala min', 'Ez li malê me.'],
  ),
  (
    id: 'a1_021',
    kurmanji: 'Nan',
    turkish: 'Ekmek',
    category: 'food',
    difficulty: 0.80,
    audioUrl: 'assets/audio/a1/nan.mp3',
    sentencesHeritage: ['Dêya min nan dipijîne.', 'Nan bixwe!'],
    sentencesGeneral: ['Ez nan dixwim.', 'Nan xweş e.'],
  ),
  (
    id: 'a1_022',
    kurmanji: 'Av',
    turkish: 'Su',
    category: 'food',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/av.mp3',
    sentencesHeritage: ['Dêyê, av bide min!', 'Av sar e.'],
    sentencesGeneral: ['Ez av dixwim.', 'Av lazim e.'],
  ),
  (
    id: 'a1_023',
    kurmanji: 'Çay',
    turkish: 'Çay',
    category: 'food',
    difficulty: 0.88,
    audioUrl: 'assets/audio/a1/cay.mp3',
    sentencesHeritage: ['Pîrêya min çay dide min.', 'Çay bikeve!'],
    sentencesGeneral: ['Ez çay vedixwim.', 'Çay germ e.'],
  ),
  // ── Birim 3: Jimar (Sayılar) ─────────────────────────────────
  (
    id: 'a1_030',
    kurmanji: 'Yek',
    turkish: 'Bir',
    category: 'numbers',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/yek.mp3',
    sentencesHeritage: ['Yek çay', 'Yek birê min heye.'],
    sentencesGeneral: ['Yek, du, sê', 'Yek kilo'],
  ),
  (
    id: 'a1_031',
    kurmanji: 'Du',
    turkish: 'İki',
    category: 'numbers',
    difficulty: 0.82,
    audioUrl: 'assets/audio/a1/du.mp3',
    sentencesHeritage: ['Du xwişk', 'Du çay bixwe.'],
    sentencesGeneral: ['Du saet', 'Du kilo nan'],
  ),
  (
    id: 'a1_032',
    kurmanji: 'Sê',
    turkish: 'Üç',
    category: 'numbers',
    difficulty: 0.80,
    audioUrl: 'assets/audio/a1/se.mp3',
    sentencesHeritage: ['Sê kurd', 'Sê roj'],
    sentencesGeneral: ['Sê saet', 'Em sê in.'],
  ),
];


// ════════════════════════════════════════════════════════════════
// KÜLTÜREL ÖDÜL — İlke 7.1: Zorunlu kültürel içerik
// ════════════════════════════════════════════════════════════════

enum CulturalContentType { proverb, poem, song, story }

class CulturalReward {
  final String id;
  final String textKu;        // Kurmancî metin
  final String textTr;        // Türkçe çeviri
  final String? source;       // Kaynak (şair, kitap vb.)
  final CulturalContentType type;

  const CulturalReward({
    required this.id,
    required this.textKu,
    required this.textTr,
    this.source,
    required this.type,
  });

  // Ders ID'sine göre sabit kültürel içerik
  static const Map<String, CulturalReward> defaults = {
    'proverb_1': CulturalReward(
      id: 'proverb_1',
      textKu: 'Ziman dermanê dilê mirov e.',
      textTr: 'Dil, insanın kalbinin ilacıdır.',
      type: CulturalContentType.proverb,
    ),
    'proverb_2': CulturalReward(
      id: 'proverb_2',
      textKu: 'Zimanê xwe ji bîr neke, ma tu xwe ji bîr dikî?',
      textTr: 'Dilini unutma, kendini mi unutacaksın?',
      type: CulturalContentType.proverb,
    ),
    'xani_1': CulturalReward(
      id: 'xani_1',
      textKu: 'Kurd in û Kurdistan heye,',
      textTr: 'Kürtler var ve Kürdistan var,',
      source: 'Ehmedê Xanî, Mem û Zîn (1695)',
      type: CulturalContentType.poem,
    ),
    'cegerxwin_1': CulturalReward(
      id: 'cegerxwin_1',
      textKu: 'Ez Kurdim, Kurdistanê min heye.',
      textTr: 'Ben Kürdüm, Kürdistanım var.',
      source: 'Cegerxwîn',
      type: CulturalContentType.poem,
    ),
    'newroz_1': CulturalReward(
      id: 'newroz_1',
      textKu: 'Newroz pîroz be! Sal û rojbaş!',
      textTr: 'Nevruz kutlu olsun! Mutlu yıllar!',
      type: CulturalContentType.story,
    ),
  };

  /// Ders ID'sine göre kültürel içerik ata
  static CulturalReward? forLesson(String lessonId) {
    if (lessonId.contains('a1')) return defaults['proverb_1'];
    if (lessonId.contains('a2')) return defaults['proverb_2'];
    if (lessonId.contains('b1')) return defaults['xani_1'];
    if (lessonId.contains('b2')) return defaults['cegerxwin_1'];
    return defaults['newroz_1'];
  }
}
