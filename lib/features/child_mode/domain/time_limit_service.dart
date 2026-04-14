import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Süre Sınırı Servisi
//
// Ebeveynin belirlediği günlük süre limitini takip eder.
// 5 dakika kala uyarı verir, süre dolduğunda ekran kilitler.
//
// SharedPreferences anahtarları:
//   - 'child_daily_limit_minutes': günlük limit (varsayılan 30)
//   - 'child_usage_YYYY-MM-DD': bugünkü kullanım (dakika)
//   - 'child_session_start': oturum başlangıç timestamp
// ════════════════════════════════════════════════════════════════

/// Süre sınırı durumu.
class TimeLimitState {
  final int limitMinutes;
  final int usedMinutes;
  final bool isWarning; // Son 5 dakika
  final bool isExpired; // Süre doldu
  final DateTime? sessionStart;

  const TimeLimitState({
    this.limitMinutes = 30,
    this.usedMinutes = 0,
    this.isWarning = false,
    this.isExpired = false,
    this.sessionStart,
  });

  int get remainingMinutes => (limitMinutes - usedMinutes).clamp(0, limitMinutes);
  double get progress => limitMinutes > 0 ? (usedMinutes / limitMinutes).clamp(0.0, 1.0) : 0.0;

  TimeLimitState copyWith({
    int? limitMinutes,
    int? usedMinutes,
    bool? isWarning,
    bool? isExpired,
    DateTime? sessionStart,
  }) => TimeLimitState(
    limitMinutes: limitMinutes ?? this.limitMinutes,
    usedMinutes: usedMinutes ?? this.usedMinutes,
    isWarning: isWarning ?? this.isWarning,
    isExpired: isExpired ?? this.isExpired,
    sessionStart: sessionStart ?? this.sessionStart,
  );
}

/// Süre sınırı yöneticisi.
final timeLimitProvider =
    StateNotifierProvider<TimeLimitNotifier, TimeLimitState>(
  (ref) => TimeLimitNotifier(),
);

class TimeLimitNotifier extends StateNotifier<TimeLimitState> {
  Timer? _ticker;

  TimeLimitNotifier() : super(const TimeLimitState()) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final limit = prefs.getInt('child_daily_limit_minutes') ?? 30;
    final todayKey = _todayKey();
    final usedToday = prefs.getInt(todayKey) ?? 0;

    state = state.copyWith(
      limitMinutes: limit,
      usedMinutes: usedToday,
      isWarning: (limit - usedToday) <= 5 && (limit - usedToday) > 0,
      isExpired: usedToday >= limit,
    );
  }

  /// Oturumu başlat — zamanlayıcı her dakika günceller.
  void startSession() {
    if (state.isExpired) return;

    state = state.copyWith(sessionStart: DateTime.now());

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(minutes: 1), (_) {
      _tick();
    });
  }

  /// Oturumu durdur — kullanılan süreyi kaydet.
  Future<void> stopSession() async {
    _ticker?.cancel();
    _ticker = null;

    if (state.sessionStart != null) {
      final sessionMinutes =
          DateTime.now().difference(state.sessionStart!).inMinutes;
      final newUsed = state.usedMinutes + sessionMinutes;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_todayKey(), newUsed);

      state = state.copyWith(
        usedMinutes: newUsed,
        sessionStart: null,
        isWarning: (state.limitMinutes - newUsed) <= 5 &&
            (state.limitMinutes - newUsed) > 0,
        isExpired: newUsed >= state.limitMinutes,
      );
    }
  }

  void _tick() {
    if (state.sessionStart == null) return;

    final sessionMinutes =
        DateTime.now().difference(state.sessionStart!).inMinutes;
    final totalUsed = state.usedMinutes + sessionMinutes;
    final remaining = state.limitMinutes - totalUsed;

    if (remaining <= 0) {
      // Süre doldu
      state = state.copyWith(
        usedMinutes: totalUsed,
        isExpired: true,
        isWarning: false,
      );
      _ticker?.cancel();
      _persistUsage(totalUsed);
    } else if (remaining <= 5) {
      state = state.copyWith(
        isWarning: true,
      );
    }
  }

  /// Günlük limiti güncelle (ebeveyn ayarı).
  Future<void> setLimit(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('child_daily_limit_minutes', minutes);

    state = state.copyWith(
      limitMinutes: minutes,
      isWarning: (minutes - state.usedMinutes) <= 5 &&
          (minutes - state.usedMinutes) > 0,
      isExpired: state.usedMinutes >= minutes,
    );
  }

  /// Günlük kullanımı sıfırla (yeni gün).
  Future<void> resetDaily() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_todayKey(), 0);

    state = state.copyWith(
      usedMinutes: 0,
      isWarning: false,
      isExpired: false,
    );
  }

  /// Mola onaylandı — çocuk uygulamayı kullanmaya devam edebilir.
  /// 30 dakikalık sayacı sıfırlar (yeni oturum başlar), warning/expired
  /// bayraklarını kapatır. Engelleyici değil; sağlıklı alışkanlık önerisi.
  Future<void> acknowledgeBreak() async {
    _ticker?.cancel();
    _ticker = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_todayKey(), 0);

    state = state.copyWith(
      usedMinutes: 0,
      isWarning: false,
      isExpired: false,
      sessionStart: DateTime.now(),
    );

    // Yeni oturum için sayacı baştan başlat
    _ticker = Timer.periodic(const Duration(minutes: 1), (_) {
      _tick();
    });
  }

  Future<void> _persistUsage(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_todayKey(), minutes);
  }

  String _todayKey() {
    final now = DateTime.now();
    return 'child_usage_${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
