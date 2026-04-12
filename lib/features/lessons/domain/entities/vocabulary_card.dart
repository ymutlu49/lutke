import '../../../../core/utils/fsrs_algorithm.dart';

// ════════════════════════════════════════════════════════════════
// VOCABULARY CARD — Birleştirilmiş Tek Kaynak (Single Source of Truth)
//
// Daha önce lesson_entities.dart ve lesson_repository.dart'ta
// iki farklı VocabularyCardModel vardı. Şimdi tek bir immutable
// entity ile temsil ediliyor.
//
// İlke §7.2: Her kelime Kurmancî, Türkçe, İngilizce + ses +
//            heritage/general cümle seti + cinsiyet + CEFR seviyesi
// ════════════════════════════════════════════════════════════════

/// CEFR seviye enum'u — string yerine tip güvenliği sağlar.
enum CEFRLevel {
  a1(1, 'A1', 'Destpêk'),
  a2(2, 'A2', 'Bingehîn'),
  b1(3, 'B1', 'Navîn'),
  b2(4, 'B2', 'Navîn-Bilind'),
  c1(5, 'C1', 'Pêşketî'),
  c2(6, 'C2', 'Jêhatî');

  final int number;
  final String label;
  final String labelKu;

  const CEFRLevel(this.number, this.label, this.labelKu);

  static CEFRLevel fromNumber(int n) => switch (n) {
    1 => CEFRLevel.a1,
    2 => CEFRLevel.a2,
    3 => CEFRLevel.b1,
    4 => CEFRLevel.b2,
    5 => CEFRLevel.c1,
    6 => CEFRLevel.c2,
    _ => CEFRLevel.a1,
  };

  static CEFRLevel fromString(String s) => switch (s.toLowerCase()) {
    'a1' => CEFRLevel.a1,
    'a2' => CEFRLevel.a2,
    'b1' => CEFRLevel.b1,
    'b2' => CEFRLevel.b2,
    'c1' => CEFRLevel.c1,
    'c2' => CEFRLevel.c2,
    _ => CEFRLevel.a1,
  };
}

/// Kurmancî kelime cinsiyeti.
enum WordGender {
  masculine('nêr', '♂'),
  feminine('mê', '♀'),
  neutral('bêcins', '');

  final String labelKu;
  final String symbol;

  const WordGender(this.labelKu, this.symbol);

  static WordGender fromString(String s) => switch (s.toLowerCase()) {
    'nêr' || 'masculine' || 'm' => WordGender.masculine,
    'mê' || 'feminine' || 'f' => WordGender.feminine,
    _ => WordGender.neutral,
  };
}

/// Tek ve birleşik kelime kartı modeli.
///
/// Hem veritabanı kaydı hem de FSRS tekrar verisi taşır.
/// Immutable — değişiklik [copyWith] ile yapılır.
class VocabularyCard {
  final String id;
  final String kurmanji;
  final String turkish;
  final String? english;
  final String? pronunciation;
  final String? audioUrl;
  final WordGender gender;
  final KurmanjiCategory category;
  final CEFRLevel level;
  final List<String> sentencesHeritage;
  final List<String> sentencesGeneral;
  final double initialDifficulty;

  /// FSRS verisi — kullanıcıya özel, DB'den join edilir.
  /// Null ise kart henüz hiç görülmemiş demektir.
  final FSRSCard? fsrsCard;

  const VocabularyCard({
    required this.id,
    required this.kurmanji,
    required this.turkish,
    this.english,
    this.pronunciation,
    this.audioUrl,
    this.gender = WordGender.neutral,
    required this.category,
    required this.level,
    this.sentencesHeritage = const [],
    this.sentencesGeneral = const [],
    this.initialDifficulty = 0.80,
    this.fsrsCard,
  });

  // ── Hesaplanmış Özellikler ────────────────────────────────

  /// Kart tekrar zamanı geldi mi?
  bool get isDue =>
      fsrsCard == null ||
      fsrsCard!.dueDate == null ||
      fsrsCard!.dueDate!.isBefore(DateTime.now());

  /// Şu anki hatırlanabilirlik oranı (0.0–1.0).
  double get currentRetention =>
      fsrsCard != null ? LutkeScheduler.currentRetrievability(fsrsCard!) : 0.0;

  /// Kart "mastered" durumda mı? (stabilite > 21 gün + review state)
  bool get isMastered =>
      fsrsCard != null &&
      fsrsCard!.state == CardState.review &&
      fsrsCard!.stability > 21.0;

  /// Kart hiç görülmedi mi?
  bool get isNew => fsrsCard == null || fsrsCard!.isNew;

  /// Kullanıcı segmentine göre örnek cümleler.
  List<String> sentencesFor({required bool isHeritage}) =>
      isHeritage ? sentencesHeritage : sentencesGeneral;

  // ── Kopyalama ─────────────────────────────────────────────

  VocabularyCard copyWith({
    String? id,
    String? kurmanji,
    String? turkish,
    String? english,
    String? pronunciation,
    String? audioUrl,
    WordGender? gender,
    KurmanjiCategory? category,
    CEFRLevel? level,
    List<String>? sentencesHeritage,
    List<String>? sentencesGeneral,
    double? initialDifficulty,
    FSRSCard? fsrsCard,
  }) => VocabularyCard(
    id: id ?? this.id,
    kurmanji: kurmanji ?? this.kurmanji,
    turkish: turkish ?? this.turkish,
    english: english ?? this.english,
    pronunciation: pronunciation ?? this.pronunciation,
    audioUrl: audioUrl ?? this.audioUrl,
    gender: gender ?? this.gender,
    category: category ?? this.category,
    level: level ?? this.level,
    sentencesHeritage: sentencesHeritage ?? this.sentencesHeritage,
    sentencesGeneral: sentencesGeneral ?? this.sentencesGeneral,
    initialDifficulty: initialDifficulty ?? this.initialDifficulty,
    fsrsCard: fsrsCard ?? this.fsrsCard,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is VocabularyCard && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'VocabularyCard($id: $kurmanji / $turkish [${level.label}])';
}
