import 'entities/exercise.dart';
import 'entities/lesson.dart';
import 'entities/vocabulary_card.dart';

/// LÛTKE ZAROK — A2 Çocuk Ders Tanımları
///
/// 7-10 yaş. A1 sonrası seviye. Her ders kısa (5-7dk),
/// 4-5 alıştırma. Nisan 2026: TypingExercise'lar kaldırıldı —
/// Piaget'nin somut-işlem evresi (7-11 yaş) için orthographic
/// production çok erken; seçim-tabanlı (FillInBlank, PictureMatch,
/// MemoryMatch) scaffolding kullanılır.

const _kChildA2Lessons = <Lesson>[

  // ── Ders 1: Laşê min (Vücudum) ──────────────────────────
  Lesson(
    id: 'child_a2_01',
    titleKu: 'Laşê min',
    titleTr: 'Vücudum',
    unitNumber: 1,
    lessonNumber: 1,
    level: CEFRLevel.a2,
    path: LessonPath.general,
    emoji: '🧠',
    estimatedMinutes: 6,
    targetCardIds: ['z_a2_001', 'z_a2_002', 'z_a2_003', 'z_a2_004', 'z_a2_005'],
    exercises: [
      ListenAndSelectExercise(
        id: 'ch_a2_ex_001',
        kurmanjiText: 'Ser',
        audioAsset: null,
        options: ['Baş', 'Göz', 'El', 'Ağız'],
        correctIndex: 0,
      ),
      PictureMatchExercise(
        id: 'ch_a2_ex_002',
        pairs: [
          PictureWordPair(emoji: '👁️', word: 'Çav', translation: 'Göz'),
          PictureWordPair(emoji: '👂', word: 'Guh', translation: 'Kulak'),
          PictureWordPair(emoji: '👄', word: 'Dev', translation: 'Ağız'),
          PictureWordPair(emoji: '✋', word: 'Dest', translation: 'El'),
        ],
      ),
      MultipleChoiceExercise(
        id: 'ch_a2_ex_003',
        prompt: '"Çav" ne demek?',
        options: ['Ağız', 'Göz', 'Kulak', 'El'],
        correctIndex: 1,
      ),
      FillInBlankExercise(
        id: 'ch_a2_ex_004',
        sentenceWithBlank: 'Ez bi ___ dinivîsim.',
        correctWord: 'dest',
        options: ['dest', 'ling', 'çav'],
      ),
      CulturalContentExercise(
        id: 'ch_a2_ex_005',
        contentKu: 'Çav çirayên laş in!',
        contentTr: 'Gözler vücudun lambalarıdır!',
        contentType: CulturalType.proverb,
      ),
    ],
  ),

  // ── Ders 2: Hestên min (Duygularım) ──────────────────────
  Lesson(
    id: 'child_a2_02',
    titleKu: 'Hestên min',
    titleTr: 'Duygularım',
    unitNumber: 2,
    lessonNumber: 1,
    level: CEFRLevel.a2,
    path: LessonPath.heritage,
    emoji: '😊',
    estimatedMinutes: 6,
    targetCardIds: ['z_a2_010', 'z_a2_011', 'z_a2_012', 'z_a2_013'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_a2_ex_010',
        prompt: '😊 Bu duygu Kurmancî\'de ne?',
        options: ['Xemgîn', 'Kêfxweş', 'Birçî', 'Tî'],
        correctIndex: 1,
      ),
      MultipleChoiceExercise(
        id: 'ch_a2_ex_011',
        prompt: '"Xemgîn" ne demek?',
        options: ['Mutlu', 'Üzgün', 'Aç', 'Susuz'],
        correctIndex: 1,
      ),
      MemoryMatchExercise(
        id: 'ch_a2_ex_012',
        pairs: [
          PictureWordPair(emoji: '😊', word: 'Kêfxweş', translation: 'Mutlu'),
          PictureWordPair(emoji: '😢', word: 'Xemgîn', translation: 'Üzgün'),
          PictureWordPair(emoji: '😋', word: 'Birçî', translation: 'Aç'),
          PictureWordPair(emoji: '🥤', word: 'Tî', translation: 'Susuz'),
        ],
      ),
      // SEL (Sosyal-Duygusal Öğrenme, CASEL çerçevesi): duygu
      // kelimesini bağlamsal cümleyle pekiştir — "Ben mutluyum".
      FillInBlankExercise(
        id: 'ch_a2_ex_013',
        sentenceWithBlank: '😊 Îro ez ___ im.',
        correctWord: 'kêfxweş',
        options: ['kêfxweş', 'xemgîn', 'birçî'],
      ),
      CulturalContentExercise(
        id: 'ch_a2_ex_014',
        contentKu: 'Ger dilê te şa be, hemû dinya şa ye.',
        contentTr: 'Kalbin mutluysa, tüm dünya mutludur.',
        contentType: CulturalType.proverb,
      ),
    ],
  ),

  // ── Ders 3: Xweza (Doğa) ─────────────────────────────────
  Lesson(
    id: 'child_a2_03',
    titleKu: 'Xwezaya xweş',
    titleTr: 'Güzel Doğa',
    unitNumber: 3,
    lessonNumber: 1,
    level: CEFRLevel.a2,
    path: LessonPath.general,
    emoji: '🌳',
    estimatedMinutes: 7,
    targetCardIds: ['z_a2_020', 'z_a2_021', 'z_a2_022', 'z_a2_023', 'z_a2_024', 'z_a2_025'],
    exercises: [
      ListenAndSelectExercise(
        id: 'ch_a2_ex_020',
        kurmanjiText: 'Roj',
        audioAsset: null,
        options: ['Yıldız', 'Ay', 'Güneş', 'Su'],
        correctIndex: 2,
      ),
      PictureMatchExercise(
        id: 'ch_a2_ex_021',
        pairs: [
          PictureWordPair(emoji: '☀️', word: 'Roj', translation: 'Güneş'),
          PictureWordPair(emoji: '🌙', word: 'Heyv', translation: 'Ay'),
          PictureWordPair(emoji: '⭐', word: 'Stêr', translation: 'Yıldız'),
          PictureWordPair(emoji: '🌊', word: 'Av', translation: 'Su'),
        ],
      ),
      MultipleChoiceExercise(
        id: 'ch_a2_ex_022',
        prompt: '"Gul" ne demek?',
        options: ['Ağaç', 'Çiçek', 'Kar', 'Su'],
        correctIndex: 1,
      ),
      FillInBlankExercise(
        id: 'ch_a2_ex_023',
        sentenceWithBlank: 'Ev ___ mezin e û kesk e.',
        correctWord: 'dar',
        options: ['dar', 'gul', 'stêr'],
      ),
      // "ezmên" — ezman kelimesinin tekil oblik hali (standart YL kullanımı).
      // Eski "ezmanan" çoğul oblik, çocuk seviyesinde yaygın değil.
      SentenceOrderExercise(
        id: 'ch_a2_ex_024',
        shuffledWords: ['ezmên', 'Roj', 'li', 'e'],
        correctOrder: ['Roj', 'li', 'ezmên', 'e'],
      ),
      CulturalContentExercise(
        id: 'ch_a2_ex_025',
        contentKu: 'Bihar hat! Gul vebûn, çûk distirînin!',
        contentTr: 'Bahar geldi! Çiçekler açtı, kuşlar şakıyor!',
        contentType: CulturalType.story,
        source: 'Newroz — Biharê',
      ),
    ],
  ),

  // ── Ders 4: Lêkerên min (Fiillerim) ──────────────────────
  Lesson(
    id: 'child_a2_04',
    titleKu: 'Lêkerên min',
    titleTr: 'Fiillerim',
    unitNumber: 4,
    lessonNumber: 1,
    level: CEFRLevel.a2,
    path: LessonPath.general,
    emoji: '🏃',
    estimatedMinutes: 7,
    targetCardIds: ['z_a2_030', 'z_a2_031', 'z_a2_032', 'z_a2_033', 'z_a2_034'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_a2_ex_030',
        prompt: '"Dixwînim" ne demek?',
        options: ['Yazıyorum', 'Okuyorum', 'Yiyorum', 'İçiyorum'],
        correctIndex: 1,
      ),
      SentenceOrderExercise(
        id: 'ch_a2_ex_031',
        shuffledWords: ['dixwim', 'Ez', 'sêvê'],
        correctOrder: ['Ez', 'sêvê', 'dixwim'],
      ),
      // 3 seçenek — çocuk derslerinde tutarlı sayı (bilişsel yük sabit).
      FillInBlankExercise(
        id: 'ch_a2_ex_032',
        sentenceWithBlank: 'Em li parkê ___.',
        correctWord: 'dilîzin',
        options: ['dixwin', 'dilîzin', 'dinivîsin'],
      ),
      // Aynı dersin 032'sinden farklı bir fiil hedeflenir:
      // "dixwînin" (okuyoruz) — çeşitlilik + pedagojik kapsam.
      FillInBlankExercise(
        id: 'ch_a2_ex_033',
        sentenceWithBlank: 'Em pirtûkê ___.',
        correctWord: 'dixwînin',
        options: ['dixwînin', 'dilîzin', 'dinivîsin'],
      ),
      MultipleChoiceExercise(
        id: 'ch_a2_ex_034',
        prompt: '"Ez dinivîsim" ne demek?',
        options: ['Okuyorum', 'Yazıyorum', 'Söylüyorum', 'Gidiyorum'],
        correctIndex: 1,
      ),
      CulturalContentExercise(
        id: 'ch_a2_ex_035',
        contentKu: 'Xwendin xweş e, nivîsandin jî xweş e!',
        contentTr: 'Okumak güzel, yazmak da güzel!',
        contentType: CulturalType.proverb,
      ),
    ],
  ),

  // ── Ders 5: Dem (Zaman) ──────────────────────────────────
  Lesson(
    id: 'child_a2_05',
    titleKu: 'Dem û roj',
    titleTr: 'Zaman ve Gün',
    unitNumber: 5,
    lessonNumber: 1,
    level: CEFRLevel.a2,
    path: LessonPath.general,
    emoji: '⏰',
    estimatedMinutes: 6,
    // z_a2_022 (Stêr) egzersizde distraktör/anahtar olarak kullanılıyor — eklendi.
    targetCardIds: ['z_a2_020', 'z_a2_021', 'z_a2_022'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_a2_ex_040',
        prompt: '"Sibe" ne demek?',
        options: ['Gece', 'Sabah', 'Akşam', 'Öğle'],
        correctIndex: 1,
      ),
      // YL için somut ve kültürel-politik içerikten arındırılmış soru.
      // Önceki versiyon (Rojava/Bakur/Başûr) 4-10 yaş için soyut ve
      // yönlü-politik kavramlar içeriyordu.
      MultipleChoiceExercise(
        id: 'ch_a2_ex_041',
        prompt: '"Êvar" ne demek?',
        options: ['Sabah', 'Öğle', 'Akşam', 'Gece'],
        correctIndex: 2,
      ),
      FillInBlankExercise(
        id: 'ch_a2_ex_042',
        sentenceWithBlank: '🌙 Şevê ___ li ezmên e.',
        correctWord: 'heyv',
        options: ['heyv', 'roj', 'stêr'],
      ),
      // YL için somut ve bağlantılı: "Îro roja xweş e" (Bugün güzel bir gün).
      // Önceki "sêşem" (salı) kelime DB'sinde yok — öksüz sözcük kaldırıldı.
      SentenceOrderExercise(
        id: 'ch_a2_ex_043',
        shuffledWords: ['xweş', 'Îro', 'e', 'roj'],
        correctOrder: ['Îro', 'roj', 'xweş', 'e'],
      ),
      CulturalContentExercise(
        id: 'ch_a2_ex_044',
        contentKu: 'Dem tê, dem diçe, lê bîranîn dimîne.',
        contentTr: 'Zaman gelir, zaman geçer, ama anı kalır.',
        contentType: CulturalType.proverb,
      ),
    ],
  ),

  // ── Ders 6: Lîstik û Kar (Oyun ve Yap) ─────────────────────
  Lesson(
    id: 'child_a2_06',
    titleKu: 'Werin em bilîzin!',
    titleTr: 'Hadi Oynayalım!',
    unitNumber: 6,
    lessonNumber: 1,
    level: CEFRLevel.a2,
    path: LessonPath.general,
    emoji: '🎮',
    estimatedMinutes: 7,
    // z_a2_044 (Zanîn/"dizanim") dersin 053 egzersizinde kullanılıyor — eklendi.
    targetCardIds: ['z_a2_041', 'z_a2_042', 'z_a2_043', 'z_a2_044', 'z_a2_045'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_a2_ex_050',
        prompt: '"Em dikenin" ne demek?',
        options: ['Ağlıyoruz', 'Gülüyoruz', 'Gidiyoruz', 'Oynuyoruz'],
        correctIndex: 1,
      ),
      PictureMatchExercise(
        id: 'ch_a2_ex_051',
        pairs: [
          PictureWordPair(emoji: '😂', word: 'Kenîn', translation: 'Gülmek'),
          PictureWordPair(emoji: '😢', word: 'Girîn', translation: 'Ağlamak'),
          PictureWordPair(emoji: '💬', word: 'Gotin', translation: 'Söylemek'),
          PictureWordPair(emoji: '🙋', word: 'Xwestin', translation: 'İstemek'),
        ],
      ),
      FillInBlankExercise(
        id: 'ch_a2_ex_052',
        sentenceWithBlank: 'Ez av ___.',
        correctWord: 'dixwazim',
        options: ['dikenim', 'dixwazim', 'dizanim', 'digirîm'],
      ),
      FillInBlankExercise(
        id: 'ch_a2_ex_053',
        sentenceWithBlank: '🧠 Ez gelek tişt ___.',
        correctWord: 'dizanim',
        options: ['dizanim', 'dibînim', 'dibêjim'],
      ),
      CulturalContentExercise(
        id: 'ch_a2_ex_054',
        contentKu: 'Lîstik, ken, xwendin — jiyan xweş dikin!',
        contentTr: 'Oyun, gülüş, okumak — hayatı güzelleştirir!',
        contentType: CulturalType.story,
      ),
    ],
  ),
];

/// Çocuk A2 derslerini döndürür.
List<Lesson> getChildA2Lessons() => _kChildA2Lessons;
