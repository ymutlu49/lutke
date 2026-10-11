import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activity_outcome.dart';

/// Ders (wane) ilerlemesi: ders kimliği → en iyi başarı yüzdesi.
///
/// Etkinlik ilerlemesiyle ([progressionProvider]) aynı yerde, cihazda
/// (SharedPreferences) tutulur; sunucuya eşitleme ayrı iş (plan M3).
/// Çıkışta [kLessonScoresKey] öteki ilerleme anahtarlarıyla birlikte silinir.
const String kLessonScoresKey = 'lutke_lesson_scores';

class LessonProgressNotifier extends StateNotifier<Map<String, int>> {
  LessonProgressNotifier() : super(const {}) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(kLessonScoresKey);
    if (raw == null) return;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      state = {for (final e in map.entries) e.key: (e.value as num).toInt()};
    } catch (_) {
      // Bozuk kayıt ilerlemeyi kilitlemesin; boş başla.
    }
  }

  /// Ders sonucu kaydedilir; önceki sonuçtan düşükse eskisi kalır.
  Future<void> record(String lessonId, int percent) async {
    if ((state[lessonId] ?? -1) >= percent) return;
    state = {...state, lessonId: percent};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kLessonScoresKey, jsonEncode(state));
  }
}

final lessonProgressProvider =
    StateNotifierProvider<LessonProgressNotifier, Map<String, int>>(
  (_) => LessonProgressNotifier(),
);

/// Ders geçildi mi? Eşik etkinliklerle aynıdır.
bool lessonPassed(Map<String, int> scores, String lessonId) =>
    (scores[lessonId] ?? -1) >= (ActivityOutcome.passRatio * 100).round();
