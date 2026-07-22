import 'entities/exercise.dart';
import 'entities/lesson.dart';
import 'entities/vocabulary_card.dart';

/// LÛTKE ZAROK — A1 Çocuk Ders Tanımları
///
/// Tematik dersler, 3-5 alıştırma/ders.
/// Typing ve MinimalPair yok — sadece çocuğa uygun tipler.

const _kChildLessons = <Lesson>[
  // ── Ders 1: Silav! (Merhaba!) ─────────────────────────────
  Lesson(
    id: 'child_a1_01',
    titleKu: 'Silav!',
    titleTr: 'Merhaba!',
    unitNumber: 1,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.general,
    emoji: '👋',
    estimatedMinutes: 5,
    targetCardIds: ['z_a1_001', 'z_a1_002', 'z_a1_003', 'z_a1_004'],
    exercises: [
      // audioAsset: null → TTS dinamik üretir (asset eksikliği fallback).
      ListenAndSelectExercise(
        id: 'ch_ex_001',
        kurmanjiText: 'Silav!',
        audioAsset: null,
        options: ['Merhaba', 'Teşekkür', 'Evet', 'Hayır'],
        correctIndex: 0,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_002',
        prompt: '"Teşekkür ederim" Kurmancî\'de nasıl söylenir?',
        options: ['Na', 'Silav', 'Spas', 'Erê'],
        correctIndex: 2,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_003',
        prompt: '"Erê" ne demek?',
        options: ['Hayır', 'Evet', 'Merhaba', 'Teşekkür'],
        correctIndex: 1,
      ),
      // Hafıza oyunu — selamlaşma kelimelerini ilişkilendir
      MemoryMatchExercise(
        id: 'ch_ex_005',
        pairs: [
          PictureWordPair(emoji: '👋', word: 'Silav', translation: 'Merhaba'),
          PictureWordPair(emoji: '🙏', word: 'Spas',  translation: 'Teşekkür'),
          PictureWordPair(emoji: '✅', word: 'Erê',   translation: 'Evet'),
          PictureWordPair(emoji: '❌', word: 'Na',    translation: 'Hayır'),
        ],
      ),
      CulturalContentExercise(
        id: 'ch_ex_004',
        contentKu: 'Silav keça xweşbextiyê ye.',
        contentTr: 'Selam, mutluluğun kızıdır.',
        contentType: CulturalType.proverb,
      ),
    ],
  ),

  // ── Ders 2: Malbata min (Ailem) ──────────────────────────
  Lesson(
    id: 'child_a1_02',
    titleKu: 'Malbata min',
    titleTr: 'Ailem',
    unitNumber: 2,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.heritage,
    emoji: '👨‍👩‍👧‍👦',
    estimatedMinutes: 6,
    targetCardIds: ['z_a1_010', 'z_a1_011', 'z_a1_012', 'z_a1_013', 'z_a1_014'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_ex_010',
        prompt: '"Dê" ne demek?',
        options: ['Baba', 'Anne', 'Kardeş', 'Dede'],
        correctIndex: 1,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_011',
        prompt: '"Bav" ne demek?',
        options: ['Anne', 'Kız kardeş', 'Baba', 'Büyükanne'],
        correctIndex: 2,
      ),
      FillInBlankExercise(
        id: 'ch_ex_012',
        sentenceWithBlank: '👧 ___ min biçûk e.',
        correctWord: 'Xwişka',
        options: ['Xwişka', 'Bavê', 'Segê'],
      ),
      SentenceOrderExercise(
        id: 'ch_ex_013',
        shuffledWords: ['min', 'Dapîra', 'xweş', 'e'],
        correctOrder: ['Dapîra', 'min', 'xweş', 'e'],
      ),
      // Piaget concrete-operational (7-10 yaş): orthographic production
      // (typing) yerine seçim-tabanlı scaffolding — bilişsel yük azaltılır,
      // metabilişsel yorgunluk önlenir.
      FillInBlankExercise(
        id: 'ch_ex_013b',
        sentenceWithBlank: '👩 ___ li mitbexê ye.',
        correctWord: 'Dê',
        options: ['Dê', 'Bav', 'Bira'],
      ),
      CulturalContentExercise(
        id: 'ch_ex_014',
        contentKu: 'Malbat — kulîlka jiyanê ye.',
        contentTr: 'Aile — hayatın çiçeğidir.',
        contentType: CulturalType.proverb,
      ),
    ],
  ),

  // ── Ders 3: Rengên min (Renklerim) ───────────────────────
  Lesson(
    id: 'child_a1_03',
    titleKu: 'Rengên min',
    titleTr: 'Renklerim',
    unitNumber: 3,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.general,
    emoji: '🎨',
    estimatedMinutes: 5,
    targetCardIds: ['z_a1_020', 'z_a1_021', 'z_a1_022', 'z_a1_023', 'z_a1_024', 'z_a1_025'],
    exercises: [
      // Görsel eşleştirme — renkler için ideal başlangıç
      PictureMatchExercise(
        id: 'ch_ex_019',
        pairs: [
          PictureWordPair(emoji: '🔴', word: 'Sor',  translation: 'Kırmızı'),
          PictureWordPair(emoji: '🟢', word: 'Kesk', translation: 'Yeşil'),
          PictureWordPair(emoji: '🟡', word: 'Zer',  translation: 'Sarı'),
          PictureWordPair(emoji: '🔵', word: 'Şîn',  translation: 'Mavi'),
        ],
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_020',
        prompt: '🔴 Bu renk Kurmancî\'de ne?',
        options: ['Kesk', 'Sor', 'Zer', 'Şîn'],
        correctIndex: 1,
      ),
      FillInBlankExercise(
        id: 'ch_ex_022',
        sentenceWithBlank: 'Berf ___ ye.',
        correctWord: 'spî',
        options: ['sor', 'spî', 'reş'],
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_023',
        prompt: '"Zer" hangi renk?',
        options: ['Mavi', 'Siyah', 'Sarı', 'Kırmızı'],
        correctIndex: 2,
      ),
      // Piaget/Vygotsky: 7-10 yaş için renk-kelime eşleştirmesi,
      // klavye yazımından pedagojik olarak çok daha uygun.
      // NOT: Roj (güneş) sarı renktir — "sor" (kırmızı) değil. Olgusal doğruluk.
      FillInBlankExercise(
        id: 'ch_ex_023b',
        sentenceWithBlank: 'Roj ___ e.',
        correctWord: 'zer',
        options: ['sor', 'zer', 'kesk'],
      ),
      CulturalContentExercise(
        id: 'ch_ex_024',
        contentKu: 'Ala Kurdistanê: sor, spî, kesk û roja zer.',
        contentTr: 'Kürdistan bayrağı: kırmızı, beyaz, yeşil ve sarı güneş.',
        contentType: CulturalType.story,
        source: 'Çanda Kurdî',
      ),
    ],
  ),

  // ── Ders 4: Heywanên malê (Hayvanlar) ────────────────────
  Lesson(
    id: 'child_a1_04',
    titleKu: 'Heywanên malê',
    titleTr: 'Evcil hayvanlar',
    unitNumber: 4,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.general,
    emoji: '🐱',
    estimatedMinutes: 6,
    targetCardIds: ['z_a1_030', 'z_a1_031', 'z_a1_032', 'z_a1_033', 'z_a1_034'],
    exercises: [
      // Görsel eşleştirme — hayvanlar çocuklar için en güçlü modalite
      PictureMatchExercise(
        id: 'ch_ex_029',
        pairs: [
          PictureWordPair(emoji: '🐱', word: 'Pisîk',  translation: 'Kedi'),
          PictureWordPair(emoji: '🐕', word: 'Seg',    translation: 'Köpek'),
          PictureWordPair(emoji: '🐐', word: 'Karîk',  translation: 'Oğlak'),
          PictureWordPair(emoji: '🐦', word: 'Çûk',    translation: 'Kuş'),
        ],
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_030',
        prompt: '🐱 Bu hayvan Kurmancî\'de ne?',
        options: ['Seg', 'Pisîk', 'Çûk', 'Karîk'],
        correctIndex: 1,
      ),
      FillInBlankExercise(
        id: 'ch_ex_032',
        sentenceWithBlank: '___ li çiyayî ye.',
        correctWord: 'Karîk',
        options: ['Masî', 'Karîk', 'Pisîk'],
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_033',
        prompt: '"Çûk" ne demek?',
        options: ['Balık', 'Tavuk', 'Kuş', 'Keçi'],
        correctIndex: 2,
      ),
      // YL 4-10 için üçlü veqetandek zinciri kognitif yük yarattığı için
      // basitleştirildi. "Pisîk li malê ye" — somut, tek veqetandek, açık.
      FillInBlankExercise(
        id: 'ch_ex_033b',
        sentenceWithBlank: '___ li malê ye.',
        correctWord: 'Pisîk',
        options: ['Pisîk', 'Masî', 'Çûk'],
      ),
      CulturalContentExercise(
        id: 'ch_ex_034',
        contentKu: 'Karik li çiyayên Kurdistanê dijîn. Karîk jî karikek e!',
        contentTr: 'Oğlaklar Kürdistan dağlarında yaşar. Karîk de bir oğlaktır!',
        contentType: CulturalType.story,
      ),
    ],
  ),

  // ── Ders 5: Em dixwin! (Yemek yiyoruz!) ──────────────────
  Lesson(
    id: 'child_a1_05',
    titleKu: 'Em dixwin!',
    titleTr: 'Yemek yiyoruz!',
    unitNumber: 5,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.heritage,
    emoji: '🍎',
    estimatedMinutes: 5,
    targetCardIds: ['z_a1_040', 'z_a1_041', 'z_a1_042', 'z_a1_043', 'z_a1_044'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_ex_040',
        prompt: '🍞 Bu Kurmancî\'de ne?',
        options: ['Şîr', 'Nan', 'Av', 'Sêv'],
        correctIndex: 1,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_041',
        prompt: '"Av" ne demek?',
        options: ['Ekmek', 'Süt', 'Su', 'Elma'],
        correctIndex: 2,
      ),
      FillInBlankExercise(
        id: 'ch_ex_042',
        sentenceWithBlank: 'Dê ___ çêdike.',
        correctWord: 'nan',
        options: ['nan', 'av', 'sêv'],
      ),
      SentenceOrderExercise(
        id: 'ch_ex_043',
        shuffledWords: ['vedixwim', 'Ez', 'av'],
        correctOrder: ['Ez', 'av', 'vedixwim'],
      ),
      FillInBlankExercise(
        id: 'ch_ex_043b',
        sentenceWithBlank: '🍞 Ez ___ dixwim.',
        correctWord: 'nan',
        options: ['nan', 'av', 'şîr'],
      ),
    ],
  ),

  // ── Ders 6: Hejmartinê fêr bibe (Sayı öğren) ─────────────
  Lesson(
    id: 'child_a1_06',
    titleKu: 'Hejmartinê fêr bibe',
    titleTr: 'Sayı öğren',
    unitNumber: 6,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.general,
    emoji: '🔢',
    estimatedMinutes: 6,
    targetCardIds: ['z_a1_050', 'z_a1_051', 'z_a1_052', 'z_a1_053', 'z_a1_054'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_ex_050',
        prompt: '"Yek" hangi sayı?',
        options: ['2', '1', '3', '5'],
        correctIndex: 1,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_051',
        prompt: '"Sê" hangi sayı?',
        options: ['4', '2', '3', '5'],
        correctIndex: 2,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_052',
        prompt: '5 Kurmancî\'de nasıl söylenir?',
        options: ['Çar', 'Pênc', 'Şeş', 'Du'],
        correctIndex: 1,
      ),
      // Tam cümle: "___ tiliyên min hene" (benim beş parmağım var).
      // YL için noun phrase yerine gerçek cümle daha anlaşılır.
      FillInBlankExercise(
        id: 'ch_ex_053',
        sentenceWithBlank: '___ tiliyên min hene.',
        correctWord: 'Pênc',
        options: ['Sê', 'Pênc', 'Deh'],
      ),
      FillInBlankExercise(
        id: 'ch_ex_053b',
        sentenceWithBlank: 'Min ___ bira hene.',
        correctWord: 'du',
        options: ['yek', 'du', 'sê'],
      ),
    ],
  ),

  // ── Ders 7: Li dibistanê (Okulda) ────────────────────────
  Lesson(
    id: 'child_a1_07',
    titleKu: 'Li dibistanê',
    titleTr: 'Okulda',
    unitNumber: 7,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.general,
    emoji: '🏫',
    estimatedMinutes: 5,
    targetCardIds: ['z_a1_060', 'z_a1_061', 'z_a1_062'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_ex_060',
        prompt: '📚 Bu Kurmancî\'de ne?',
        options: ['Pênûsk', 'Mamoste', 'Pirtûk', 'Top'],
        correctIndex: 2,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_061',
        prompt: '"Mamoste" ne demek?',
        options: ['Kitap', 'Öğretmen', 'Kalem', 'Okul'],
        correctIndex: 1,
      ),
      // Belirsizlik önlendi: emoji (✏️) ile "kalem" kastı netleştirildi.
      // Aksi halde "Pirtûka min sor e" de doğru olabilirdi — çocukta
      // haksız hata hissi yaratır.
      FillInBlankExercise(
        id: 'ch_ex_062',
        sentenceWithBlank: '✏️ ___ min sor e.',
        correctWord: 'Pênûska',
        options: ['Pênûska', 'Pirtûka', 'Topê'],
      ),
      FillInBlankExercise(
        id: 'ch_ex_062b',
        sentenceWithBlank: 'Ez ___ dixwînim.',
        correctWord: 'pirtûk',
        options: ['pirtûk', 'pênûsk', 'top'],
      ),
    ],
  ),

  // ── Ders 8: Lîstik! (Oyun!) ──────────────────────────────
  Lesson(
    id: 'child_a1_08',
    titleKu: 'Lîstik!',
    titleTr: 'Oyun!',
    unitNumber: 8,
    lessonNumber: 1,
    level: CEFRLevel.a1,
    path: LessonPath.general,
    emoji: '⚽',
    estimatedMinutes: 5,
    targetCardIds: ['z_a1_070', 'z_a1_071', 'z_a1_072'],
    exercises: [
      MultipleChoiceExercise(
        id: 'ch_ex_070',
        prompt: '⚽ Bu Kurmancî\'de ne?',
        options: ['Sêv', 'Lîstik', 'Top', 'Pirtûk'],
        correctIndex: 2,
      ),
      MultipleChoiceExercise(
        id: 'ch_ex_071',
        prompt: '"Lîstik" ne demek?',
        options: ['Oyuncak', 'Oyun', 'Top', 'Kitap'],
        correctIndex: 1,
      ),
      SentenceOrderExercise(
        id: 'ch_ex_072',
        shuffledWords: ['dilîzin', 'Em', 'topê', 'bi'],
        correctOrder: ['Em', 'bi', 'topê', 'dilîzin'],
      ),
      CulturalContentExercise(
        id: 'ch_ex_073',
        contentKu: 'Newroz — cejna biharê! Em dilîzin û dibezin!',
        contentTr: 'Nevruz — bahar bayramı! Oynar ve koşarız!',
        contentType: CulturalType.story,
        source: 'Newroz — 21ê Adarê',
      ),
    ],
  ),
];

/// Çocuk A1 derslerini döndürür.
List<Lesson> getChildA1Lessons() => _kChildLessons;
