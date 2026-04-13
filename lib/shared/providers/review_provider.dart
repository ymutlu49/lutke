import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// SMART REVIEW (DUBARE) — Provider
//
// Zayıf kelimeleri takip eder, tekrar oturumları için veri sağlar.
// SharedPreferences ile kalıcı depolama.
//
// Entegrasyon:
//   Quiz'de yanlış cevap → addWeakWord(wordId)
//   Flashcard'da sola kaydırma → addWeakWord(wordId)
//   Tekrar'da 3 kez doğru → removeWeakWord(wordId)
// ════════════════════════════════════════════════════════════════

/// Tek bir zayıf kelimenin tekrar verisi.
class WeakWordRecord {
  final String wordId;
  final int reviewCount;
  final int consecutiveCorrect;
  final DateTime addedAt;
  final DateTime? lastReviewedAt;

  const WeakWordRecord({
    required this.wordId,
    this.reviewCount = 0,
    this.consecutiveCorrect = 0,
    required this.addedAt,
    this.lastReviewedAt,
  });

  /// 3 kez üst üste doğru → mastered
  bool get isMastered => consecutiveCorrect >= 3;

  /// Tekrar önceliği: az tekrar + düşük ardışık doğru = yüksek öncelik
  double get priority {
    final ageFactor = DateTime.now().difference(addedAt).inHours / 24.0;
    return (1.0 / (reviewCount + 1)) * (1.0 + ageFactor) *
        (1.0 / (consecutiveCorrect + 1));
  }

  WeakWordRecord copyWith({
    int? reviewCount,
    int? consecutiveCorrect,
    DateTime? lastReviewedAt,
  }) =>
      WeakWordRecord(
        wordId: wordId,
        reviewCount: reviewCount ?? this.reviewCount,
        consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
        addedAt: addedAt,
        lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      );

  Map<String, dynamic> toJson() => {
        'wordId': wordId,
        'reviewCount': reviewCount,
        'consecutiveCorrect': consecutiveCorrect,
        'addedAt': addedAt.toIso8601String(),
        'lastReviewedAt': lastReviewedAt?.toIso8601String(),
      };

  factory WeakWordRecord.fromJson(Map<String, dynamic> json) => WeakWordRecord(
        wordId: json['wordId'] as String,
        reviewCount: json['reviewCount'] as int? ?? 0,
        consecutiveCorrect: json['consecutiveCorrect'] as int? ?? 0,
        addedAt: DateTime.parse(json['addedAt'] as String),
        lastReviewedAt: json['lastReviewedAt'] != null
            ? DateTime.parse(json['lastReviewedAt'] as String)
            : null,
      );
}

/// Tekrar durumu — provider state'i.
class ReviewState {
  final Map<String, WeakWordRecord> weakWords;
  final DateTime? lastReviewSession;
  final bool isLoaded;

  const ReviewState({
    this.weakWords = const {},
    this.lastReviewSession,
    this.isLoaded = false,
  });

  /// Tekrar bekleyen kelime sayısı (mastered olmayanlar).
  int get dueCount => weakWords.values.where((w) => !w.isMastered).length;

  /// Mastered kelime sayısı.
  int get masteredCount => weakWords.values.where((w) => w.isMastered).length;

  /// Son tekrardan bu yana geçen süre.
  Duration? get timeSinceLastReview => lastReviewSession != null
      ? DateTime.now().difference(lastReviewSession!)
      : null;

  /// Tekrar edilecek kelimeleri öncelik sırasına göre döndürür.
  List<WeakWordRecord> getReviewWords({int maxCount = 20}) {
    final due = weakWords.values.where((w) => !w.isMastered).toList();
    due.sort((a, b) => b.priority.compareTo(a.priority));
    return due.take(maxCount).toList();
  }

  ReviewState copyWith({
    Map<String, WeakWordRecord>? weakWords,
    DateTime? lastReviewSession,
    bool? isLoaded,
  }) =>
      ReviewState(
        weakWords: weakWords ?? this.weakWords,
        lastReviewSession: lastReviewSession ?? this.lastReviewSession,
        isLoaded: isLoaded ?? this.isLoaded,
      );
}

// ── SharedPreferences Anahtarları ────────────────────────────

const _kWeakWords = 'review_weak_words';
const _kLastReview = 'review_last_session';

// ── StateNotifier ────────────────────────────────────────────

class ReviewNotifier extends StateNotifier<ReviewState> {
  ReviewNotifier() : super(const ReviewState()) {
    _load();
  }

  // ── Kalıcı Depolama ──────────────────────────────────────

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();

    // Zayıf kelimeler
    final rawList = prefs.getStringList(_kWeakWords) ?? [];
    final map = <String, WeakWordRecord>{};
    for (final raw in rawList) {
      try {
        final json = jsonDecode(raw) as Map<String, dynamic>;
        final record = WeakWordRecord.fromJson(json);
        map[record.wordId] = record;
      } catch (_) {
        // Bozuk veri — atla
      }
    }

    // Son tekrar zamanı
    final lastStr = prefs.getString(_kLastReview);
    final lastReview = lastStr != null ? DateTime.tryParse(lastStr) : null;

    state = state.copyWith(
      weakWords: map,
      lastReviewSession: lastReview,
      isLoaded: true,
    );
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = state.weakWords.values
        .map((r) => jsonEncode(r.toJson()))
        .toList();
    await prefs.setStringList(_kWeakWords, list);
    if (state.lastReviewSession != null) {
      await prefs.setString(
          _kLastReview, state.lastReviewSession!.toIso8601String());
    }
  }

  // ── Genel API ─────────────────────────────────────────────

  /// Yanlış cevaplanan kelimeyi zayıf listesine ekle.
  /// Zaten varsa consecutiveCorrect sıfırlanır.
  void addWeakWord(String wordId) {
    final current = state.weakWords[wordId];
    final updated = Map<String, WeakWordRecord>.from(state.weakWords);

    if (current != null) {
      // Zaten listede — ardışık doğruyu sıfırla
      updated[wordId] = current.copyWith(consecutiveCorrect: 0);
    } else {
      updated[wordId] = WeakWordRecord(
        wordId: wordId,
        addedAt: DateTime.now(),
      );
    }

    state = state.copyWith(weakWords: updated);
    _save();
  }

  /// Tekrar oturumunda "Dizanim" (biliyorum) yanıtı.
  void markCorrect(String wordId) {
    final current = state.weakWords[wordId];
    if (current == null) return;

    final updated = Map<String, WeakWordRecord>.from(state.weakWords);
    final newRecord = current.copyWith(
      reviewCount: current.reviewCount + 1,
      consecutiveCorrect: current.consecutiveCorrect + 1,
      lastReviewedAt: DateTime.now(),
    );

    // 3 kez üst üste doğru → mastered → listeden kaldır
    if (newRecord.isMastered) {
      updated.remove(wordId);
    } else {
      updated[wordId] = newRecord;
    }

    state = state.copyWith(weakWords: updated);
    _save();
  }

  /// Tekrar oturumunda "Nizanim" (bilmiyorum) yanıtı.
  void markIncorrect(String wordId) {
    final current = state.weakWords[wordId];
    if (current == null) return;

    final updated = Map<String, WeakWordRecord>.from(state.weakWords);
    updated[wordId] = current.copyWith(
      reviewCount: current.reviewCount + 1,
      consecutiveCorrect: 0,
      lastReviewedAt: DateTime.now(),
    );

    state = state.copyWith(weakWords: updated);
    _save();
  }

  /// Kelimeyi zayıf listesinden kaldır (manuel mastered).
  void removeWeakWord(String wordId) {
    final updated = Map<String, WeakWordRecord>.from(state.weakWords);
    updated.remove(wordId);
    state = state.copyWith(weakWords: updated);
    _save();
  }

  /// Tekrar oturumu tamamlandı — zaman damgasını güncelle.
  void completeReviewSession() {
    state = state.copyWith(lastReviewSession: DateTime.now());
    _save();
  }
}

// ── Providers ────────────────────────────────────────────────

final reviewProvider =
    StateNotifierProvider<ReviewNotifier, ReviewState>(
  (_) => ReviewNotifier(),
);

/// Tekrar bekleyen kelime sayısı.
final reviewDueCountProvider = Provider<int>((ref) {
  return ref.watch(reviewProvider).dueCount;
});
