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

class GamificationState {
  final int totalXP;
  final int levelXP;        // Bu seviyede kazanılan XP
  final int xpToNextLevel;  // Bir sonraki seviyeye kadar kalan
  final String level;       // A1, A2, B1, B2
  final WeeklyRhythmState weeklyRhythm;
  final List<String> earnedBadgeIds;
  final String? newlyEarnedBadgeId; // Animasyon için

  const GamificationState({
    this.totalXP = 0,
    this.levelXP = 0,
    this.xpToNextLevel = 200,
    this.level = 'A1',
    required this.weeklyRhythm,
    this.earnedBadgeIds = const [],
    this.newlyEarnedBadgeId,
  });

  GamificationState copyWith({
    int? totalXP,
    int? levelXP,
    int? xpToNextLevel,
    String? level,
    WeeklyRhythmState? weeklyRhythm,
    List<String>? earnedBadgeIds,
    String? newlyEarnedBadgeId,
  }) =>
      GamificationState(
        totalXP: totalXP ?? this.totalXP,
        levelXP: levelXP ?? this.levelXP,
        xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
        level: level ?? this.level,
        weeklyRhythm: weeklyRhythm ?? this.weeklyRhythm,
        earnedBadgeIds: earnedBadgeIds ?? this.earnedBadgeIds,
        newlyEarnedBadgeId: newlyEarnedBadgeId,
      );

  double get levelProgress =>
      xpToNextLevel > 0 ? (levelXP / xpToNextLevel).clamp(0.0, 1.0) : 1.0;

  // Seviye XP eşikleri
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

        // Hafta kontrolü — yeni hafta başlamış mı?
        final rhythm = WeeklyRhythmState.fromJson(
            data['weeklyRhythm'] as Map<String, dynamic>);
        final updatedRhythm = _checkWeekAdvance(rhythm);

        state = GamificationState(
          totalXP: xp,
          levelXP: data['levelXP'] as int? ?? 0,
          xpToNextLevel: levelThreshold,
          level: level,
          weeklyRhythm: updatedRhythm,
          earnedBadgeIds:
              (data['earnedBadgeIds'] as List?)?.cast<String>() ?? [],
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
      }),
    );
  }

  // ── XP Ekleme ─────────────────────────────────────────────────

  Future<void> addXP(int amount) async {
    final newTotal = state.totalXP + amount;
    final newLevelXP = state.levelXP + amount;
    final newLevel = GamificationState.levelFromXP(newTotal);
    final threshold = GamificationState.thresholdForLevel(newLevel);

    state = state.copyWith(
      totalXP: newTotal,
      levelXP: newLevelXP > threshold ? newLevelXP - threshold : newLevelXP,
      xpToNextLevel: threshold,
      level: newLevel,
    );

    // Bugünü aktif gün olarak işaretle
    await markTodayActive();
    await _saveToPrefs();
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

  // ── Rozet Kontrolü ─────────────────────────────────────────────

  Future<List<String>> _checkBadges({int wordCount = 0}) async {
    final newBadges = <String>[];
    final existing = Set<String>.from(state.earnedBadgeIds);

    // İlk ders rozeti
    if (!existing.contains('destpeker')) {
      newBadges.add('destpeker');
    }

    // 4 hafta aktif — Serbestî rozeti
    if (state.weeklyRhythm.weekStreak >= 4 &&
        !existing.contains('serbesti')) {
      newBadges.add('serbesti');
    }

    // Kelime sayısı rozetleri (mock — Faz 2'de DB'den gelecek)
    if (state.totalXP >= 500 && !existing.contains('zimanzan')) {
      newBadges.add('zimanzan');
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
