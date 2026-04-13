import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lessons/domain/lesson_entities.dart';
import '../lessons/data/lesson_repository.dart';

// ════════════════════════════════════════════════════════════════
// XP KURALLARI
// Araştırma bulgularına göre tasarlanmış — her anlamlı eylem ödüllenir
// ════════════════════════════════════════════════════════════════

abstract class XPRules {
  static const int correctAnswer = 10;
  static const int highAccuracy = 5;          // %90+ doğruluk bonusu
  static const int speakingPractice = 8;      // Konuşma pratiği bonusu
  static const int firstTimeCard = 8;         // İlk kez öğrenilen kelime
  static const int familyDialogue = 15;       // Aile diyaloğu tamamlama
  static const int culturalContent = 10;      // Kültürel içerik modülü
  static const int perfectLesson = 15;        // Mükemmel ders (%100)
  static const int weeklyGoalMet = 30;        // Haftalık hedef tamamlandı
  static const int badgeEarned = 20;          // Rozet kazanımı

  /// Ders sonucu XP hesabı
  static int calculateLessonXP({
    required int correctCount,
    required int totalCount,
    required bool hasSpeaking,
    required bool hasFamilyDialogue,
  }) {
    int xp = correctCount * correctAnswer;
    final accuracy = totalCount > 0 ? correctCount / totalCount : 0.0;

    if (accuracy >= 0.90) xp += highAccuracy;
    if (accuracy >= 1.0) xp += perfectLesson;
    if (hasSpeaking) xp += speakingPractice;
    if (hasFamilyDialogue) xp += familyDialogue;

    return xp;
  }
}

// ════════════════════════════════════════════════════════════════
// HAFTALIK RİTİM MODELİ
//
// Araştırma Bulgusu #3: Günlük streak kırılınca bırakmak için
// bahane oluyor. Zeynep: "tamam bitti zaten moduna giriyorum."
//
// Çözüm: 7 günde 4 gün aktif = hafta başarılı.
// Günlük "kaçırdım" baskısı yok, haftalık ritim var.
// ════════════════════════════════════════════════════════════════

class WeeklyRhythmState {
  final List<bool> activeDays;    // 7 eleman, Pzt=0 ... Paz=6
  final int weekStreak;           // Kaç hafta üst üste aktif
  final DateTime weekStartDate;   // Bu haftanın başlangıcı (Pazartesi)
  final bool weekGoalMet;         // Bu hafta 4 gün tamamlandı mı?
  final int totalActiveDays;      // Genel toplam aktif gün

  const WeeklyRhythmState({
    required this.activeDays,
    required this.weekStreak,
    required this.weekStartDate,
    required this.totalActiveDays,
  })  : weekGoalMet = false;

  WeeklyRhythmState._({
    required this.activeDays,
    required this.weekStreak,
    required this.weekStartDate,
    required this.totalActiveDays,
    required this.weekGoalMet,
  });

  factory WeeklyRhythmState.initial() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final weekStart = DateTime(monday.year, monday.month, monday.day);

    return WeeklyRhythmState._(
      activeDays: List.filled(7, false),
      weekStreak: 0,
      weekStartDate: weekStart,
      totalActiveDays: 0,
      weekGoalMet: false,
    );
  }

  int get activeDayCount => activeDays.where((d) => d).length;
  static const int weekGoalDays = 4; // Haftalık hedef: 4 gün

  double get weekProgress =>
      activeDayCount / weekGoalDays > 1.0 ? 1.0 : activeDayCount / weekGoalDays;

  int get todayIndex {
    final now = DateTime.now();
    return (now.weekday - 1).clamp(0, 6);
  }

  bool get isTodayActive => activeDays[todayIndex];

  WeeklyRhythmState markTodayActive() {
    final newDays = List<bool>.from(activeDays);
    newDays[todayIndex] = true;
    final newCount = newDays.where((d) => d).length;
    final isNowMet = newCount >= weekGoalDays;

    return WeeklyRhythmState._(
      activeDays: newDays,
      weekStreak: weekStreak,
      weekStartDate: weekStartDate,
      totalActiveDays: totalActiveDays + (activeDays[todayIndex] ? 0 : 1),
      weekGoalMet: isNowMet,
    );
  }

  WeeklyRhythmState advanceWeek(bool previousWeekMet) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final newWeekStart = DateTime(monday.year, monday.month, monday.day);

    return WeeklyRhythmState._(
      activeDays: List.filled(7, false),
      weekStreak: previousWeekMet ? weekStreak + 1 : 0,
      weekStartDate: newWeekStart,
      totalActiveDays: totalActiveDays,
      weekGoalMet: false,
    );
  }

  Map<String, dynamic> toJson() => {
        'activeDays': activeDays,
        'weekStreak': weekStreak,
        'weekStartDate': weekStartDate.toIso8601String(),
        'totalActiveDays': totalActiveDays,
        'weekGoalMet': weekGoalMet,
      };

  factory WeeklyRhythmState.fromJson(Map<String, dynamic> json) {
    return WeeklyRhythmState._(
      activeDays: (json['activeDays'] as List).cast<bool>(),
      weekStreak: json['weekStreak'] as int,
      weekStartDate: DateTime.parse(json['weekStartDate'] as String),
      totalActiveDays: json['totalActiveDays'] as int,
      weekGoalMet: json['weekGoalMet'] as bool,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GAMIFICATION STATE
// ════════════════════════════════════════════════════════════════

// ════════════════════════════════════════════════════════════════
// SEVİYE SİSTEMİ — Numerik seviyeler (XP tabanlı)
// Gamification seviyesi, CEFR seviyesinden bağımsızdır.
// ════════════════════════════════════════════════════════════════

abstract class LevelSystem {
  /// Her seviye için gereken kümülatif XP
  static int xpForLevel(int level) {
    if (level <= 1) return 0;
    // Seviye 2: 100, 3: 250, 4: 500, 5: 800, 6: 1200, ...
    // Formül: level^2 * 25 + level * 25
    return (level * level * 25) + (level * 25);
  }

  /// XP'den seviye hesapla
  static int levelFromXP(int totalXP) {
    int lvl = 1;
    while (xpForLevel(lvl + 1) <= totalXP) {
      lvl++;
    }
    return lvl;
  }

  /// Mevcut seviyedeki ilerleme (0.0 - 1.0)
  static double progressInLevel(int totalXP) {
    final currentLevel = levelFromXP(totalXP);
    final currentThreshold = xpForLevel(currentLevel);
    final nextThreshold = xpForLevel(currentLevel + 1);
    final range = nextThreshold - currentThreshold;
    if (range <= 0) return 1.0;
    return ((totalXP - currentThreshold) / range).clamp(0.0, 1.0);
  }

  /// Bir sonraki seviyeye kadar kalan XP
  static int xpToNextLevel(int totalXP) {
    final currentLevel = levelFromXP(totalXP);
    return xpForLevel(currentLevel + 1) - totalXP;
  }

  /// Mevcut seviyede kazanılan XP
  static int xpInCurrentLevel(int totalXP) {
    final currentLevel = levelFromXP(totalXP);
    return totalXP - xpForLevel(currentLevel);
  }

  /// Mevcut seviyenin XP aralığı
  static int xpRangeForCurrentLevel(int totalXP) {
    final currentLevel = levelFromXP(totalXP);
    return xpForLevel(currentLevel + 1) - xpForLevel(currentLevel);
  }
}

// ════════════════════════════════════════════════════════════════
// GAMIFICATION STATE
// ════════════════════════════════════════════════════════════════

class GamificationState {
  final int totalXP;
  final int levelXP;        // Bu seviyede kazanılan XP
  final int xpToNextLevel;  // Bir sonraki seviyeye kadar kalan
  final String level;       // A1, A2, B1, B2 (CEFR)
  final int numericLevel;   // Gamification seviyesi (1, 2, 3, ...)
  final WeeklyRhythmState weeklyRhythm;
  final List<String> earnedBadgeIds;
  final String? newlyEarnedBadgeId; // Animasyon için
  final bool showLevelUp;           // Seviye atlama animasyonu
  final int previousLevel;          // Seviye atlama karşılaştırması
  final DateTime? lastDailyReward;  // Son günlük ödül tarihi
  final bool dailyRewardAvailable;  // Bugün ödül alınabilir mi?
  final int perfectScoreCount;      // Mükemmel skor sayısı
  final int totalWordsLearned;      // Toplam öğrenilen kelime

  const GamificationState({
    this.totalXP = 0,
    this.levelXP = 0,
    this.xpToNextLevel = 200,
    this.level = 'A1',
    this.numericLevel = 1,
    required this.weeklyRhythm,
    this.earnedBadgeIds = const [],
    this.newlyEarnedBadgeId,
    this.showLevelUp = false,
    this.previousLevel = 0,
    this.lastDailyReward,
    this.dailyRewardAvailable = true,
    this.perfectScoreCount = 0,
    this.totalWordsLearned = 0,
  });

  GamificationState copyWith({
    int? totalXP,
    int? levelXP,
    int? xpToNextLevel,
    String? level,
    int? numericLevel,
    WeeklyRhythmState? weeklyRhythm,
    List<String>? earnedBadgeIds,
    String? newlyEarnedBadgeId,
    bool? showLevelUp,
    int? previousLevel,
    DateTime? lastDailyReward,
    bool? dailyRewardAvailable,
    int? perfectScoreCount,
    int? totalWordsLearned,
  }) =>
      GamificationState(
        totalXP: totalXP ?? this.totalXP,
        levelXP: levelXP ?? this.levelXP,
        xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
        level: level ?? this.level,
        numericLevel: numericLevel ?? this.numericLevel,
        weeklyRhythm: weeklyRhythm ?? this.weeklyRhythm,
        earnedBadgeIds: earnedBadgeIds ?? this.earnedBadgeIds,
        newlyEarnedBadgeId: newlyEarnedBadgeId,
        showLevelUp: showLevelUp ?? this.showLevelUp,
        previousLevel: previousLevel ?? this.previousLevel,
        lastDailyReward: lastDailyReward ?? this.lastDailyReward,
        dailyRewardAvailable: dailyRewardAvailable ?? this.dailyRewardAvailable,
        perfectScoreCount: perfectScoreCount ?? this.perfectScoreCount,
        totalWordsLearned: totalWordsLearned ?? this.totalWordsLearned,
      );

  double get levelProgress => LevelSystem.progressInLevel(totalXP);

  // CEFR seviye XP eşikleri
  static const Map<String, int> _levelThresholds = {
    'A1': 500,
    'A2': 1500,
    'B1': 4000,
    'B2': 9000,
  };

  static String levelFromXP(int xp) {
    if (xp >= 9000) return 'B2';
    if (xp >= 4000) return 'B1';
    if (xp >= 1500) return 'A2';
    return 'A1';
  }

  static int thresholdForLevel(String level) =>
      _levelThresholds[level] ?? 500;
}

// ════════════════════════════════════════════════════════════════
// GAMIFICATION NOTIFIER
// ════════════════════════════════════════════════════════════════

class GamificationNotifier extends StateNotifier<GamificationState> {
  static const _kPrefsKey = 'gamification_state';
  static const int dailyRewardXP = 50;

  GamificationNotifier()
      : super(GamificationState(
          weeklyRhythm: WeeklyRhythmState.initial(),
        )) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_kPrefsKey);
    if (json != null) {
      try {
        final data = jsonDecode(json) as Map<String, dynamic>;
        final xp = data['totalXP'] as int? ?? 0;
        final level = GamificationState.levelFromXP(xp);
        final levelThreshold = GamificationState.thresholdForLevel(level);
        final numLevel = LevelSystem.levelFromXP(xp);

        // Hafta kontrolü — yeni hafta başlamış mı?
        final rhythm = WeeklyRhythmState.fromJson(
            data['weeklyRhythm'] as Map<String, dynamic>);
        final updatedRhythm = _checkWeekAdvance(rhythm);

        // Günlük ödül kontrolü
        DateTime? lastDaily;
        final lastDailyStr = data['lastDailyReward'] as String?;
        if (lastDailyStr != null) {
          lastDaily = DateTime.tryParse(lastDailyStr);
        }
        final now = DateTime.now();
        final todayStart = DateTime(now.year, now.month, now.day);
        final isDailyAvailable = lastDaily == null ||
            lastDaily.isBefore(todayStart);

        state = GamificationState(
          totalXP: xp,
          levelXP: data['levelXP'] as int? ?? 0,
          xpToNextLevel: levelThreshold,
          level: level,
          numericLevel: numLevel,
          weeklyRhythm: updatedRhythm,
          earnedBadgeIds:
              (data['earnedBadgeIds'] as List?)?.cast<String>() ?? [],
          lastDailyReward: lastDaily,
          dailyRewardAvailable: isDailyAvailable,
          perfectScoreCount: data['perfectScoreCount'] as int? ?? 0,
          totalWordsLearned: data['totalWordsLearned'] as int? ?? 0,
        );
      } catch (_) {
        // Bozuk veri — initial state ile devam
      }
    }
  }

  WeeklyRhythmState _checkWeekAdvance(WeeklyRhythmState rhythm) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final thisWeekStart = DateTime(monday.year, monday.month, monday.day);

    if (rhythm.weekStartDate.isBefore(thisWeekStart)) {
      // Yeni hafta — önceki hafta tamamlandı mı?
      return rhythm.advanceWeek(rhythm.weekGoalMet);
    }
    return rhythm;
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _kPrefsKey,
      jsonEncode({
        'totalXP': state.totalXP,
        'levelXP': state.levelXP,
        'weeklyRhythm': state.weeklyRhythm.toJson(),
        'earnedBadgeIds': state.earnedBadgeIds,
        'lastDailyReward': state.lastDailyReward?.toIso8601String(),
        'perfectScoreCount': state.perfectScoreCount,
        'totalWordsLearned': state.totalWordsLearned,
      }),
    );
  }

  // ── XP Ekleme ─────────────────────────────────────────────────

  Future<void> addXP(int amount) async {
    final oldLevel = LevelSystem.levelFromXP(state.totalXP);
    final newTotal = state.totalXP + amount;
    final newNumericLevel = LevelSystem.levelFromXP(newTotal);
    final newLevelXP = state.levelXP + amount;
    final newLevel = GamificationState.levelFromXP(newTotal);
    final threshold = GamificationState.thresholdForLevel(newLevel);
    final leveledUp = newNumericLevel > oldLevel;

    state = state.copyWith(
      totalXP: newTotal,
      levelXP: newLevelXP > threshold ? newLevelXP - threshold : newLevelXP,
      xpToNextLevel: threshold,
      level: newLevel,
      numericLevel: newNumericLevel,
      showLevelUp: leveledUp,
      previousLevel: leveledUp ? oldLevel : state.previousLevel,
    );

    // Bugünü aktif gün olarak işaretle
    await markTodayActive();
    await _saveToPrefs();
  }

  // ── Günlük Ödül ────────────────────────────────────────────────

  Future<bool> claimDailyReward() async {
    if (!state.dailyRewardAvailable) return false;

    final now = DateTime.now();
    final oldLevel = LevelSystem.levelFromXP(state.totalXP);
    final newTotal = state.totalXP + dailyRewardXP;
    final newNumericLevel = LevelSystem.levelFromXP(newTotal);
    final newLevel = GamificationState.levelFromXP(newTotal);
    final threshold = GamificationState.thresholdForLevel(newLevel);
    final leveledUp = newNumericLevel > oldLevel;

    state = state.copyWith(
      totalXP: newTotal,
      levelXP: LevelSystem.xpInCurrentLevel(newTotal),
      xpToNextLevel: threshold,
      level: newLevel,
      numericLevel: newNumericLevel,
      lastDailyReward: now,
      dailyRewardAvailable: false,
      showLevelUp: leveledUp,
      previousLevel: leveledUp ? oldLevel : state.previousLevel,
    );

    await markTodayActive();
    await _saveToPrefs();
    return true;
  }

  /// Seviye atlama animasyonu gösterildikten sonra temizle
  void clearLevelUp() {
    state = state.copyWith(showLevelUp: false);
  }

  // ── Ders Tamamlama ────────────────────────────────────────────

  Future<List<String>> completedLesson({
    required int correctCount,
    required int totalCount,
    required bool hasSpeaking,
    required bool hasFamilyDialogue,
    required int wordCount,
  }) async {
    final xp = XPRules.calculateLessonXP(
      correctCount: correctCount,
      totalCount: totalCount,
      hasSpeaking: hasSpeaking,
      hasFamilyDialogue: hasFamilyDialogue,
    );

    await addXP(xp);

    // Rozet kontrolü
    final newBadges = await _checkBadges(wordCount: wordCount);
    return newBadges;
  }

  // ── Bugünü Aktif İşaretle ──────────────────────────────────────

  Future<void> markTodayActive() async {
    if (state.weeklyRhythm.isTodayActive) return; // Zaten aktif

    final updatedRhythm = state.weeklyRhythm.markTodayActive();
    state = state.copyWith(weeklyRhythm: updatedRhythm);

    // Haftalık hedef tamamlandı mı? XP ver
    if (updatedRhythm.weekGoalMet &&
        !state.weeklyRhythm.weekGoalMet) {
      final newTotal = state.totalXP + XPRules.weeklyGoalMet;
      state = state.copyWith(totalXP: newTotal);
    }

    await _saveToPrefs();
  }

  // ── Mükemmel Skor Kaydet ────────────────────────────────────────

  Future<void> recordPerfectScore() async {
    state = state.copyWith(
      perfectScoreCount: state.perfectScoreCount + 1,
    );
    await _saveToPrefs();
  }

  // ── Kelime Sayısı Güncelle ─────────────────────────────────────

  Future<void> updateWordsLearned(int count) async {
    state = state.copyWith(
      totalWordsLearned: state.totalWordsLearned + count,
    );
    await _saveToPrefs();
  }

  // ── Rozet Kontrolü ─────────────────────────────────────────────

  Future<List<String>> _checkBadges({int wordCount = 0}) async {
    final newBadges = <String>[];
    final existing = Set<String>.from(state.earnedBadgeIds);

    // İlk ders rozeti — Destpeker
    if (!existing.contains('destpeker')) {
      newBadges.add('destpeker');
    }

    // 100 kelime — Zimanzan
    if (state.totalWordsLearned >= 100 && !existing.contains('zimanzan')) {
      newBadges.add('zimanzan');
    }

    // 7 gün streak (hafta hedefi tamamlama) — Hefteya Temam
    if (state.weeklyRhythm.weekGoalMet &&
        !existing.contains('hefteya_temam')) {
      newBadges.add('hefteya_temam');
    }

    // 4 hafta aktif — Serbestî rozeti
    if (state.weeklyRhythm.weekStreak >= 4 &&
        !existing.contains('serbesti')) {
      newBadges.add('serbesti');
    }

    // 500 XP — XP Koleksiyoncusu
    if (state.totalXP >= 500 && !existing.contains('xp_500')) {
      newBadges.add('xp_500');
    }

    // Mükemmel skor — Rast 100%
    if (state.perfectScoreCount >= 1 &&
        !existing.contains('rast_100')) {
      newBadges.add('rast_100');
    }

    // A1 tamamlandı
    if (state.totalXP >= GamificationState.thresholdForLevel('A1') &&
        !existing.contains('a1_qediya')) {
      newBadges.add('a1_qediya');
    }

    // Malbatvan — 10 aile kelimesi
    if (!existing.contains('malbatvan') && wordCount >= 10) {
      newBadges.add('malbatvan');
    }

    if (newBadges.isNotEmpty) {
      final updatedBadges = [...existing, ...newBadges];
      state = state.copyWith(
        earnedBadgeIds: updatedBadges,
        newlyEarnedBadgeId: newBadges.first,
        totalXP: state.totalXP + newBadges.length * XPRules.badgeEarned,
      );
      await _saveToPrefs();
    }

    return newBadges;
  }

  /// Rozet animasyonu gösterildikten sonra temizle
  void clearNewBadge() {
    state = state.copyWith(newlyEarnedBadgeId: null);
  }
}

// ── Provider ──────────────────────────────────────────────────────

final gamificationProvider =
    StateNotifierProvider<GamificationNotifier, GamificationState>(
  (ref) => GamificationNotifier(),
);
