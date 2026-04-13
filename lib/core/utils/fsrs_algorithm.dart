import 'dart:math';

/// LÛTKE — FSRS-5 Spaced Repetition Algoritması
///
/// Free Spaced Repetition Scheduler v5 implementasyonu.
/// SM-2'ye (Duolingo/Anki) kıyasla %90 vs %47 başarı oranı.
///
/// Üç bileşen bellek modeli:
/// - Stability (S): Hatırlamanın ne kadar sürdüğü (gün cinsinden)
/// - Difficulty (D): Kartın bireysel zorluğu (1.0–10.0)
/// - Retrievability (R): Şu an hatırlama olasılığı (0.0–1.0)
///
/// Kurmancî özelleştirmeleri:
/// - Heritage kullanıcılar için başlangıç zorluğu azaltılmıştır
/// - Dilbilgisel kategorilere göre farklı başlangıç parametreleri

// ──────────────────────────────────────────────────────────────
// ENUM'LAR
// ──────────────────────────────────────────────────────────────

enum Rating {
  again, // Tekrar — hiç hatırlamadım
  hard,  // Zor — güçlükle hatırladım
  good,  // İyi — hatırladım
  easy,  // Kolay — çok kolaydı
}

enum CardState {
  newCard,    // Yeni kart, henüz görülmedi
  learning,   // Öğrenme aşamasında
  review,     // Tekrar aşamasında
  relearning, // Unutulmuş, yeniden öğrenme
}

/// Kurmancî kelime/yapı kategorileri
enum KurmanjiCategory {
  greeting,        // Selamlama — heritage maruziyeti yüksek
  family,          // Aile kelimeleri — yüksek pasif maruziyet
  numbers,         // Sayılar — nötr
  colors,          // Renkler — görsel bağlam yardımcı
  food,            // Yemek — orta maruziyet
  daily,           // Günlük hayat — orta
  grammar_ezafe,   // Ezafe — Türkçe'de yok, zor
  grammar_ergative,// Ergatiflik — en zor konu
  phoneme_xq,      // x/q sesleri — Türkçe'de yok
  minimal_pair,    // ker/kêr çiftleri — anlam bozucu fark
  general,         // Genel kelimeler
}

// ──────────────────────────────────────────────────────────────
// FSRS KART MODELİ
// ──────────────────────────────────────────────────────────────

class FSRSCard {
  final String cardId;
  final double stability;      // S: gün cinsinden
  final double difficulty;     // D: 1.0–10.0
  final double retrievability; // R: 0.0–1.0
  final CardState state;
  final DateTime? lastReview;
  final DateTime? dueDate;
  final int reviewCount;
  final int lapseCount; // Unutulma sayısı

  const FSRSCard({
    required this.cardId,
    this.stability = 0,
    this.difficulty = 5.0,
    this.retrievability = 0,
    this.state = CardState.newCard,
    this.lastReview,
    this.dueDate,
    this.reviewCount = 0,
    this.lapseCount = 0,
  });

  FSRSCard copyWith({
    double? stability,
    double? difficulty,
    double? retrievability,
    CardState? state,
    DateTime? lastReview,
    DateTime? dueDate,
    int? reviewCount,
    int? lapseCount,
  }) {
    return FSRSCard(
      cardId: cardId,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      retrievability: retrievability ?? this.retrievability,
      state: state ?? this.state,
      lastReview: lastReview ?? this.lastReview,
      dueDate: dueDate ?? this.dueDate,
      reviewCount: reviewCount ?? this.reviewCount,
      lapseCount: lapseCount ?? this.lapseCount,
    );
  }

  /// Yeni kart oluşturmak için kısa yol.
  factory FSRSCard.newCard(String cardId) => FSRSCard(
    cardId: cardId,
    state: CardState.newCard,
    dueDate: DateTime.now(),
  );

  bool get isNew => state == CardState.newCard;
  bool get isDue => dueDate == null || dueDate!.isBefore(DateTime.now());

  @override
  String toString() => 'FSRSCard(id: $cardId, S: ${stability.toStringAsFixed(2)}, '
      'D: ${difficulty.toStringAsFixed(2)}, R: ${retrievability.toStringAsFixed(2)}, '
      'state: $state, reviews: $reviewCount)';
}

// ──────────────────────────────────────────────────────────────
// FSRS-5 SCHEDULER
// ──────────────────────────────────────────────────────────────

class LutkeScheduler {
  // FSRS-5 parametreleri (açık kaynak default değerleri)
  static const List<double> _w = [
    0.4072, 1.1829, 3.1262, 15.4722, 7.2102,
    0.5316, 1.0651, 0.0589, 1.5330,  0.1544,
    1.0070, 1.9395, 0.1100, 0.2900,  2.2700,
    0.1600, 2.9898, 0.5100, 0.3400,
  ];

  // Hedef hatırlama oranı: %90
  static const double _targetRetention = 0.90;

  // Heritage kullanıcı ilk kart zorluk avantajı
  static const double _heritageBonus = 0.08;

  // ──────────────────────────────────────────────────────────────
  // KURMANCî BAŞLANGIÇ ZORLUKLARI
  // ──────────────────────────────────────────────────────────────

  /// Her Kurmancî kategorisi için bilimsel temelli başlangıç zorluğu.
  /// Düşük değer = daha kolay = daha seyrek tekrar.
  static const Map<KurmanjiCategory, double> _categoryDifficulty = {
    KurmanjiCategory.greeting: 0.85,         // Pasif maruziyet yüksek
    KurmanjiCategory.family: 0.82,           // Ev ortamında duyulmuş
    KurmanjiCategory.numbers: 0.78,          // Kolay fonetik
    KurmanjiCategory.colors: 0.80,           // Görsel bağlam
    KurmanjiCategory.food: 0.78,             // Orta maruziyet
    KurmanjiCategory.daily: 0.75,            // Genel günlük
    KurmanjiCategory.grammar_ezafe: 0.60,    // Türkçe'de yok!
    KurmanjiCategory.grammar_ergative: 0.50, // En zor yapı
    KurmanjiCategory.phoneme_xq: 0.65,       // Türkçe'de yok
    KurmanjiCategory.minimal_pair: 0.55,     // Anlam farkı kritik
    KurmanjiCategory.general: 0.80,
  };

  // ──────────────────────────────────────────────────────────────
  // YENİ KART OLUŞTURMA
  // ──────────────────────────────────────────────────────────────

  /// Kategori ve kullanıcı segmentine göre yeni kart oluşturur.
  static FSRSCard createCard({
    required String cardId,
    required KurmanjiCategory category,
    bool isHeritageUser = false,
  }) {
    double baseDifficulty =
        _categoryDifficulty[category] ?? _categoryDifficulty[KurmanjiCategory.general]!;

    // Heritage kullanıcı avantajı: pasif maruziyet ilk görüşte yardımcı olur
    if (isHeritageUser) {
      baseDifficulty = (baseDifficulty + _heritageBonus).clamp(0.0, 1.0);
    }

    // FSRS difficulty 1.0–10.0 skalasına dönüştür
    // 0.85 (kolay) → D=3.0, 0.50 (zor) → D=7.5
    final fsrsDifficulty = _baseDifficultyToFSRS(baseDifficulty);

    return FSRSCard(
      cardId: cardId,
      difficulty: fsrsDifficulty,
      state: CardState.newCard,
      dueDate: DateTime.now(),
    );
  }

  static double _baseDifficultyToFSRS(double base) {
    // base: 0.50 (zor) → 1.0 (kolay)
    // FSRS D: 1.0 (kolay) → 10.0 (zor)
    return ((1.0 - base) * 9.0 + 1.0).clamp(1.0, 10.0);
  }

  // ──────────────────────────────────────────────────────────────
  // TEKRAR ZAMANLAMA
  // ──────────────────────────────────────────────────────────────

  /// Kullanıcının cevabına göre kartı yeniden zamanlar.
  /// Güncellenmiş FSRSCard döndürür.
  static FSRSCard schedule({
    required FSRSCard card,
    required Rating rating,
    DateTime? reviewTime,
  }) {
    final now = reviewTime ?? DateTime.now();

    switch (card.state) {
      case CardState.newCard:
      case CardState.learning:
        return _scheduleNewCard(card, rating, now);
      case CardState.review:
        return _scheduleReviewCard(card, rating, now);
      case CardState.relearning:
        return _scheduleRelearningCard(card, rating, now);
    }
  }

  // Yeni/öğrenme aşamasındaki kart
  static FSRSCard _scheduleNewCard(FSRSCard card, Rating rating, DateTime now) {
    double newStability;
    double newDifficulty = _updateDifficulty(card.difficulty, rating);
    CardState newState;
    DateTime newDue;

    switch (rating) {
      case Rating.again:
        newStability = _w[0];
        newState = CardState.learning;
        newDue = now.add(const Duration(minutes: 1));
        break;
      case Rating.hard:
        newStability = _w[1];
        newState = CardState.learning;
        newDue = now.add(const Duration(minutes: 5));
        break;
      case Rating.good:
        newStability = _w[2];
        newState = CardState.review;
        newDue = now.add(Duration(days: max(1, newStability.round())));
        break;
      case Rating.easy:
        newStability = _w[3];
        newState = CardState.review;
        newDue = now.add(Duration(days: max(4, (newStability * 2).round())));
        break;
    }

    final newR = _retrievability(newStability, 0);

    return card.copyWith(
      stability: newStability,
      difficulty: newDifficulty,
      retrievability: newR,
      state: newState,
      lastReview: now,
      dueDate: newDue,
      reviewCount: card.reviewCount + 1,
    );
  }

  // Tekrar aşamasındaki kart
  static FSRSCard _scheduleReviewCard(FSRSCard card, Rating rating, DateTime now) {
    final elapsedDays = card.lastReview != null
        ? now.difference(card.lastReview!).inDays.toDouble()
        : 1.0;

    final currentR = _retrievability(card.stability, elapsedDays);
    final newDifficulty = _updateDifficulty(card.difficulty, rating);
    double newStability;
    CardState newState = CardState.review;
    DateTime newDue;
    int lapseCount = card.lapseCount;

    switch (rating) {
      case Rating.again:
        // Unutulmuş — yeniden öğrenme
        newStability = _forgettingStability(card.stability, newDifficulty, currentR);
        newState = CardState.relearning;
        newDue = now.add(const Duration(minutes: 10));
        lapseCount = card.lapseCount + 1;
        break;
      case Rating.hard:
        newStability = _recallStability(
            card.stability, newDifficulty, currentR, rating);
        newDue = _nextDueDate(now, newStability);
        break;
      case Rating.good:
        newStability = _recallStability(
            card.stability, newDifficulty, currentR, rating);
        newDue = _nextDueDate(now, newStability);
        break;
      case Rating.easy:
        newStability = _recallStability(
            card.stability, newDifficulty, currentR, rating);
        newDue = _nextDueDate(now, newStability);
        break;
    }

    return card.copyWith(
      stability: newStability,
      difficulty: newDifficulty,
      retrievability: _retrievability(newStability, 0),
      state: newState,
      lastReview: now,
      dueDate: newDue,
      reviewCount: card.reviewCount + 1,
      lapseCount: lapseCount,
    );
  }

  // Yeniden öğrenme aşamasındaki kart
  static FSRSCard _scheduleRelearningCard(
      FSRSCard card, Rating rating, DateTime now) {
    double newStability;
    CardState newState = CardState.review;
    DateTime newDue;

    switch (rating) {
      case Rating.again:
        newStability = card.stability * 0.5;
        newState = CardState.relearning;
        newDue = now.add(const Duration(minutes: 10));
        break;
      case Rating.hard:
      case Rating.good:
      case Rating.easy:
        newStability = max(card.stability, _w[11] + _w[12] * (card.difficulty - 1));
        newDue = _nextDueDate(now, newStability);
        break;
    }

    return card.copyWith(
      stability: newStability,
      retrievability: _retrievability(newStability, 0),
      state: newState,
      lastReview: now,
      dueDate: newDue,
      reviewCount: card.reviewCount + 1,
    );
  }

  // ──────────────────────────────────────────────────────────────
  // FSRS MATEMATİKSEL FONKSİYONLARI
  // ──────────────────────────────────────────────────────────────

  /// Hatırlanabilirlik hesabı: R = e^(-t/S)
  static double _retrievability(double stability, double elapsedDays) {
    if (stability <= 0) return 0;
    return pow(1 + elapsedDays / (9 * stability), -1).toDouble().clamp(0.0, 1.0);
  }

  /// Zorluğu güncelle (rating'e göre)
  static double _updateDifficulty(double d, Rating rating) {
    const Map<Rating, double> ratingDelta = {
      Rating.again: 0.8,
      Rating.hard: 0.54,
      Rating.good: 0.0,
      Rating.easy: -0.72,
    };
    final delta = ratingDelta[rating]!;
    final newD = d + delta * (10 - d) / 9;
    return newD.clamp(1.0, 10.0);
  }

  /// Hatırlama sonrası yeni stabilite
  static double _recallStability(
      double s, double d, double r, Rating rating) {
    const Map<Rating, double> ratingMultiplier = {
      Rating.hard: 1.0,
      Rating.good: 1.0,
      Rating.easy: 1.0,
      Rating.again: 1.0,
    };

    final hardPenalty = rating == Rating.hard ? _w[15] : 1.0;
    final easyBonus = rating == Rating.easy ? _w[16] : 1.0;

    return (s *
            _w[8] *
            pow(d, -_w[9]) *
            (pow(s + 1, _w[10]) - 1) *
            exp(_w[11] * (1 - r)) *
            hardPenalty *
            easyBonus)
        .clamp(0.1, 36500);
  }

  /// Unutma sonrası yeni stabilite
  static double _forgettingStability(double s, double d, double r) {
    return (_w[11] *
            pow(d, -_w[12]) *
            (pow(s + 1, _w[13]) - 1) *
            exp(_w[14] * (1 - r)))
        .clamp(0.1, s);
  }

  /// Hedef retention'a göre bir sonraki tekrar tarihi
  static DateTime _nextDueDate(DateTime now, double stability) {
    final interval = stability *
        pow((_targetRetention / _w[17]).clamp(0.001, 0.999), -1 / _w[18]);
    final days = max(1, interval.round());
    return now.add(Duration(days: days));
  }

  // ──────────────────────────────────────────────────────────────
  // YARDIMCI FONKSİYONLAR
  // ──────────────────────────────────────────────────────────────

  /// Kartın şu anki retrievability değerini hesaplar
  static double currentRetrievability(FSRSCard card) {
    if (card.lastReview == null) return 0;
    final elapsed = DateTime.now().difference(card.lastReview!).inDays.toDouble();
    return _retrievability(card.stability, elapsed);
  }

  /// Gün sayısına göre kart listesini sıralar (en acil önce)
  static List<FSRSCard> sortByUrgency(List<FSRSCard> cards) {
    final sorted = List<FSRSCard>.from(cards);
    sorted.sort((a, b) {
      final aR = currentRetrievability(a);
      final bR = currentRetrievability(b);
      return aR.compareTo(bR); // En düşük R en acil
    });
    return sorted;
  }

  /// Bugün tekrar edilmesi gereken kart sayısı
  static int dueTodayCount(List<FSRSCard> cards) {
    return cards.where((c) => c.isDue).length;
  }
}

// ── FSRSAlgorithm ADAPTER ────────────────────────────────────
// lesson_repository ile uyumluluk katmanı
class FSRSAlgorithm {
  static FSRSCard schedule(FSRSCard card, Rating rating) {
    return LutkeScheduler.schedule(card: card, rating: rating);
  }
}

// FSRSCard.newCard factory constructor is now defined directly
// in the FSRSCard class above.
