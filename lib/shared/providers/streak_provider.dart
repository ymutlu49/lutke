import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// STREAK STATE
// Günlük hedef takibi, streak sayacı, haftalık aktivite
// SharedPreferences ile lokal persistans
// ════════════════════════════════════════════════════════════════

class StreakState {
  final int streakDays;
  final String lastActiveDate; // ISO 8601
  final int todayWordsReviewed;
  final int todayXP;
  final List<bool> weeklyActivity; // 7 eleman: Pzt=0 ... Paz=6
  final int dailyGoal;
  final bool streakBroken; // Dün aktif değilse

  const StreakState({
    this.streakDays = 0,
    this.lastActiveDate = '',
    this.todayWordsReviewed = 0,
    this.todayXP = 0,
    this.weeklyActivity = const [false, false, false, false, false, false, false],
    this.dailyGoal = 20,
    this.streakBroken = false,
  });

  double get dailyProgress =>
      dailyGoal > 0 ? (todayWordsReviewed / dailyGoal).clamp(0.0, 1.0) : 0.0;

  bool get dailyGoalMet => todayWordsReviewed >= dailyGoal;

  int get todayIndex => (DateTime.now().weekday - 1).clamp(0, 6);

  StreakState copyWith({
    int? streakDays,
    String? lastActiveDate,
    int? todayWordsReviewed,
    int? todayXP,
    List<bool>? weeklyActivity,
    int? dailyGoal,
    bool? streakBroken,
  }) {
    return StreakState(
      streakDays: streakDays ?? this.streakDays,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      todayWordsReviewed: todayWordsReviewed ?? this.todayWordsReviewed,
      todayXP: todayXP ?? this.todayXP,
      weeklyActivity: weeklyActivity ?? this.weeklyActivity,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      streakBroken: streakBroken ?? this.streakBroken,
    );
  }

  Map<String, dynamic> toJson() => {
        'streakDays': streakDays,
        'lastActiveDate': lastActiveDate,
        'todayWordsReviewed': todayWordsReviewed,
        'todayXP': todayXP,
        'weeklyActivity': weeklyActivity,
        'dailyGoal': dailyGoal,
      };

  factory StreakState.fromJson(Map<String, dynamic> json) {
    return StreakState(
      streakDays: json['streakDays'] as int? ?? 0,
      lastActiveDate: json['lastActiveDate'] as String? ?? '',
      todayWordsReviewed: json['todayWordsReviewed'] as int? ?? 0,
      todayXP: json['todayXP'] as int? ?? 0,
      weeklyActivity: (json['weeklyActivity'] as List?)?.cast<bool>() ??
          List.filled(7, false),
      dailyGoal: json['dailyGoal'] as int? ?? 20,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STREAK NOTIFIER
// ════════════════════════════════════════════════════════════════

class StreakNotifier extends StateNotifier<StreakState> {
  static const _kPrefsKey = 'streak_state';

  StreakNotifier() : super(const StreakState()) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_kPrefsKey);
    if (json != null) {
      try {
        final data = jsonDecode(json) as Map<String, dynamic>;
        var loaded = StreakState.fromJson(data);
        loaded = _reconcileDate(loaded);
        state = loaded;
      } catch (_) {
        // Bozuk veri — varsayilan state ile devam
      }
    }
  }

  /// Tarih kontrolu: yeni gun veya kacirilmis gun
  StreakState _reconcileDate(StreakState s) {
    final now = DateTime.now();
    final todayStr = _dateToIso(now);

    if (s.lastActiveDate.isEmpty) {
      return s.copyWith(lastActiveDate: todayStr);
    }

    if (s.lastActiveDate == todayStr) {
      // Ayni gun — degisiklik yok
      return s;
    }

    final lastDate = DateTime.tryParse(s.lastActiveDate);
    if (lastDate == null) {
      return s.copyWith(
        lastActiveDate: todayStr,
        todayWordsReviewed: 0,
        todayXP: 0,
      );
    }

    final daysDiff = DateTime(now.year, now.month, now.day)
        .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
        .inDays;

    if (daysDiff == 1) {
      // Dun aktifti — streak devam ediyor, yeni gun baslat
      final newWeekly = _buildWeeklyForToday(s.weeklyActivity, now);
      return s.copyWith(
        lastActiveDate: todayStr,
        todayWordsReviewed: 0,
        todayXP: 0,
        weeklyActivity: newWeekly,
        streakBroken: false,
      );
    } else if (daysDiff > 1) {
      // Streak kirildi
      final newWeekly = _buildWeeklyForToday(null, now);
      return s.copyWith(
        streakDays: 0,
        lastActiveDate: todayStr,
        todayWordsReviewed: 0,
        todayXP: 0,
        weeklyActivity: newWeekly,
        streakBroken: true,
      );
    }

    return s;
  }

  /// Haftalik aktiviteyi guncelle (yeni hafta ise sifirla)
  List<bool> _buildWeeklyForToday(List<bool>? previous, DateTime now) {
    final todayIdx = (now.weekday - 1).clamp(0, 6);

    // Pazartesi ise veya onceki veri yoksa yeni hafta
    if (previous == null || todayIdx == 0) {
      return List.filled(7, false);
    }

    return List<bool>.from(previous);
  }

  String _dateToIso(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefsKey, jsonEncode(state.toJson()));
  }

  // ── Kelime tekrari kaydet ─────────────────────────────────────

  Future<void> recordWordReview({int xpEarned = 10}) async {
    final now = DateTime.now();
    final todayStr = _dateToIso(now);
    final todayIdx = (now.weekday - 1).clamp(0, 6);

    final newReviewed = state.todayWordsReviewed + 1;
    final newXP = state.todayXP + xpEarned;
    final newWeekly = List<bool>.from(state.weeklyActivity);
    newWeekly[todayIdx] = true;

    // Streak guncelle: eger bugun ilk kez aktifse
    int newStreak = state.streakDays;
    if (state.lastActiveDate != todayStr) {
      final lastDate = DateTime.tryParse(state.lastActiveDate);
      if (lastDate != null) {
        final daysDiff = DateTime(now.year, now.month, now.day)
            .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
            .inDays;
        if (daysDiff <= 1) {
          newStreak = state.streakDays + 1;
        } else {
          newStreak = 1;
        }
      } else {
        newStreak = 1;
      }
    }

    state = state.copyWith(
      todayWordsReviewed: newReviewed,
      todayXP: newXP,
      weeklyActivity: newWeekly,
      streakDays: newStreak,
      lastActiveDate: todayStr,
      streakBroken: false,
    );

    await _saveToPrefs();
  }

  // ── XP ekle (kelime olmadan) ──────────────────────────────────

  Future<void> addXP(int amount) async {
    state = state.copyWith(todayXP: state.todayXP + amount);
    await _saveToPrefs();
  }

  // ── Gunluk hedef degistir ─────────────────────────────────────

  Future<void> setDailyGoal(int goal) async {
    state = state.copyWith(dailyGoal: goal.clamp(5, 100));
    await _saveToPrefs();
  }

  // ── Streak broken uyarisini kapat ─────────────────────────────

  void dismissBrokenWarning() {
    state = state.copyWith(streakBroken: false);
  }
}

// ── Provider ────────────────────────────────────────────────────

final streakProvider =
    StateNotifierProvider<StreakNotifier, StreakState>(
  (ref) => StreakNotifier(),
);
