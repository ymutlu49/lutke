// ════════════════════════════════════════════════════════════════
// EGZERSİZ MODELLERİ — LÛTKE
//
// Strategy Pattern: Her egzersiz tipi kendi verisi ve
// doğrulama mantığını taşır. ExerciseModel artık
// tek bir dev sınıf değil — her tip kendi sealed alt sınıfı.
//
// İlke §5.5: Heritage öncelik sırası
//   Ses dinle → seç: ⭐⭐⭐ (ilk bu)
//   Aile diyaloğu:   ⭐⭐⭐
//   Minimal çift:    ⭐⭐⭐
//   Çoktan seçmeli:  ⭐⭐
//   Sürükle-bırak:   ⭐⭐
//   Boşluk doldur:   ⭐⭐
// ════════════════════════════════════════════════════════════════

/// Egzersiz tipi — her biri farklı UI ve doğrulama mantığı gerektirir.
enum ExerciseType {
  listenAndSelect(
    labelKu: 'Guhdarî bike û hilbijêre',
    labelTr: 'Dinle ve seç',
    heritagePriority: 3,
  ),
  multipleChoice(
    labelKu: 'Bixwîne û hilbijêre',
    labelTr: 'Oku ve seç',
    heritagePriority: 2,
  ),
  typing(
    labelKu: 'Bi Kurmancî binivîse',
    labelTr: 'Kurmancî yaz',
    heritagePriority: 1,
  ),
  sentenceOrder(
    labelKu: 'Hevoka rast çêke',
    labelTr: 'Doğru cümleyi oluştur',
    heritagePriority: 2,
  ),
  fillInBlank(
    labelKu: 'Cihê vala dagire',
    labelTr: 'Boşluğu doldur',
    heritagePriority: 2,
  ),
  minimalPair(
    labelKu: 'Cûdahîyê bibîne',
    labelTr: 'Farkı bul',
    heritagePriority: 3,
  ),
  speakingPractice(
    labelKu: 'Bêje û guhdarî bike',
    labelTr: 'Söyle ve dinle',
    heritagePriority: 3,
  ),
  culturalContent(
    labelKu: 'Çanda Kurdî',
    labelTr: 'Kürt kültürü',
    heritagePriority: 3,
  ),
  pictureMatch(
    labelKu: 'Wêne û peyv',
    labelTr: 'Resim ve kelime eşleştir',
    heritagePriority: 2,
  );

  final String labelKu;
  final String labelTr;
  final int heritagePriority; // 1-3: ⭐ sayısı

  const ExerciseType({
    required this.labelKu,
    required this.labelTr,
    required this.heritagePriority,
  });
}

/// Tüm egzersiz tiplerinin ortak arayüzü.
///
/// Sealed class ile tip güvenliği: switch ile tüm tiplerin
/// ele alınmasını derleyici garanti eder.
sealed class Exercise {
  final String id;
  final ExerciseType type;
  final int xpReward;
  final String? cardId;
  final String? grammarNote;
  final String? culturalNote;
  final String? audioAsset;

  const Exercise({
    required this.id,
    required this.type,
    this.xpReward = 10,
    this.cardId,
    this.grammarNote,
    this.culturalNote,
    this.audioAsset,
  });

  /// Egzersiz tamamlandığında doğru mu kontrol et.
  bool checkAnswer(dynamic userAnswer);
}

// ── Dinle ve Seç ─────────────────────────────────────────────

class ListenAndSelectExercise extends Exercise {
  final String kurmanjiText;
  final List<String> options;
  final int correctIndex;

  const ListenAndSelectExercise({
    required super.id,
    required this.kurmanjiText,
    required super.audioAsset,
    required this.options,
    required this.correctIndex,
    super.xpReward,
    super.cardId,
    super.grammarNote,
    super.culturalNote,
  }) : super(type: ExerciseType.listenAndSelect);

  String get correctAnswer => options[correctIndex];

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is int) return userAnswer == correctIndex;
    if (userAnswer is String) return userAnswer == correctAnswer;
    return false;
  }
}

// ── Çoktan Seçmeli ──────────────────────────────────────────

class MultipleChoiceExercise extends Exercise {
  final String prompt;
  final String? promptTr;
  final List<String> options;
  final int correctIndex;

  const MultipleChoiceExercise({
    required super.id,
    required this.prompt,
    this.promptTr,
    required this.options,
    required this.correctIndex,
    super.xpReward,
    super.cardId,
    super.grammarNote,
    super.culturalNote,
    super.audioAsset,
  }) : super(type: ExerciseType.multipleChoice);

  String get correctAnswer => options[correctIndex];

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is int) return userAnswer == correctIndex;
    if (userAnswer is String) return userAnswer == correctAnswer;
    return false;
  }
}

// ── Yazma Pratiği ───────────────────────────────────────────

class TypingExercise extends Exercise {
  final String promptTr;
  final String correctKurmanji;

  const TypingExercise({
    required super.id,
    required this.promptTr,
    required this.correctKurmanji,
    super.xpReward,
    super.cardId,
    super.grammarNote,
    super.audioAsset,
  }) : super(type: ExerciseType.typing);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is! String) return false;
    final input = userAnswer.trim().toLowerCase();
    final expected = correctKurmanji.trim().toLowerCase();
    if (input == expected) return true;
    return _similarity(input, expected) > 0.85;
  }

  /// Levenshtein benzerlik oranı (typo toleransı).
  static double _similarity(String a, String b) {
    if (a == b) return 1.0;
    final la = a.length, lb = b.length;
    if (la == 0 || lb == 0) return 0.0;
    final d = List.generate(la + 1, (_) => List.filled(lb + 1, 0));
    for (var i = 0; i <= la; i++) d[i][0] = i;
    for (var j = 0; j <= lb; j++) d[0][j] = j;
    for (var i = 1; i <= la; i++) {
      for (var j = 1; j <= lb; j++) {
        d[i][j] = a[i - 1] == b[j - 1]
            ? d[i - 1][j - 1]
            : 1 + [d[i - 1][j], d[i][j - 1], d[i - 1][j - 1]]
                  .reduce((x, y) => x < y ? x : y);
      }
    }
    return 1 - d[la][lb] / (la > lb ? la : lb);
  }
}

// ── Cümle Sıralama ──────────────────────────────────────────

class SentenceOrderExercise extends Exercise {
  final List<String> shuffledWords;
  final List<String> correctOrder;

  const SentenceOrderExercise({
    required super.id,
    required this.shuffledWords,
    required this.correctOrder,
    super.xpReward,
    super.cardId,
    super.grammarNote,
    super.audioAsset,
  }) : super(type: ExerciseType.sentenceOrder);

  String get correctSentence => correctOrder.join(' ');

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is List<String>) {
      return userAnswer.join(' ') == correctSentence;
    }
    if (userAnswer is String) return userAnswer == correctSentence;
    return false;
  }
}

// ── Boşluk Doldurma ─────────────────────────────────────────

class FillInBlankExercise extends Exercise {
  /// Cümle: "Ez ___ dixwim" (boşluk ___ ile işaretli)
  final String sentenceWithBlank;
  final String correctWord;
  final List<String> options; // Boş ise serbest yazım

  const FillInBlankExercise({
    required super.id,
    required this.sentenceWithBlank,
    required this.correctWord,
    this.options = const [],
    super.xpReward,
    super.cardId,
    super.grammarNote,
    super.audioAsset,
  }) : super(type: ExerciseType.fillInBlank);

  String get completedSentence =>
      sentenceWithBlank.replaceAll('___', correctWord);

  bool get hasOptions => options.isNotEmpty;

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is String) {
      return userAnswer.trim().toLowerCase() ==
          correctWord.trim().toLowerCase();
    }
    return false;
  }
}

// ── Minimal Çift (Fonemik Ayrım) ────────────────────────────
// İlke §5.5: ker/kêr gibi çiftler — ⭐⭐⭐ Heritage önceliği

class MinimalPairExercise extends Exercise {
  final String wordA;
  final String wordB;
  final String meaningA;
  final String meaningB;
  final String? audioA;
  final String? audioB;

  /// Hangi ses çalınıyor? 0 = wordA, 1 = wordB
  final int playedIndex;

  const MinimalPairExercise({
    required super.id,
    required this.wordA,
    required this.wordB,
    required this.meaningA,
    required this.meaningB,
    this.audioA,
    this.audioB,
    required this.playedIndex,
    super.xpReward,
    super.cardId,
    super.grammarNote,
  }) : super(type: ExerciseType.minimalPair);

  String get playedWord => playedIndex == 0 ? wordA : wordB;
  String get correctMeaning => playedIndex == 0 ? meaningA : meaningB;

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer is int) return userAnswer == playedIndex;
    return false;
  }
}

// ── Konuşma Pratiği ──────────────────────────────────────────
// İlke §5.5: Dinle + kaydet + kendin karşılaştır (MVP)

class SpeakingPracticeExercise extends Exercise {
  final String targetText;
  final String? targetTranslation;

  const SpeakingPracticeExercise({
    required super.id,
    required this.targetText,
    this.targetTranslation,
    required super.audioAsset,
    super.xpReward = 18, // Konuşma pratiği +8 bonus
    super.cardId,
  }) : super(type: ExerciseType.speakingPractice);

  /// MVP'de kullanıcı kendi değerlendirmesini yapar.
  @override
  bool checkAnswer(dynamic userAnswer) {
    // userAnswer: kullanıcının öz-değerlendirmesi (0=kötü, 1=yakın, 2=iyi)
    if (userAnswer is int) return userAnswer >= 1;
    return false;
  }
}

// ── Kültürel İçerik ─────────────────────────────────────────
// İlke §7.1: Zorunlu — ek özellik değil, temel kazanım

class CulturalContentExercise extends Exercise {
  final String contentKu;
  final String contentTr;
  final String? source;
  final CulturalType contentType;

  const CulturalContentExercise({
    required super.id,
    required this.contentKu,
    required this.contentTr,
    this.source,
    required this.contentType,
    super.audioAsset,
    super.xpReward = 10,
  }) : super(type: ExerciseType.culturalContent);

  @override
  bool checkAnswer(dynamic userAnswer) => true; // Bilgi kartı, cevap yok
}

enum CulturalType { proverb, poem, song, story }

// ── Resim Eşleştirme (Lûtke Zarok) ─────────────────────────
// Çocuklar kelimeyi emoji/resim ile eşleştirir.

class PictureWordPair {
  final String emoji;
  final String word;
  final String translation;

  const PictureWordPair({
    required this.emoji,
    required this.word,
    required this.translation,
  });
}

class PictureMatchExercise extends Exercise {
  final List<PictureWordPair> pairs;

  const PictureMatchExercise({
    required super.id,
    required this.pairs,
    super.xpReward = 12,
    super.cardId,
  }) : super(type: ExerciseType.pictureMatch);

  @override
  bool checkAnswer(dynamic userAnswer) {
    // userAnswer: Map<String, String> (emoji → word eşleşmesi)
    if (userAnswer is Map<String, String>) {
      return pairs.every((p) => userAnswer[p.emoji] == p.word);
    }
    return false;
  }
}
