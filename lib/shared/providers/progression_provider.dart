import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Etkinlik ilerleme sistemi.
///
/// Her tamamlanan etkinlik `{level}_{category}_{activityIndex}` formatında saklanır.
/// Örnek: "a1_silav_1" = A1 Silav durağının 1. etkinliği (Flashcard)
///
/// Saklama: SharedPreferences (web + mobile uyumlu)
///
/// Etkinlik sıralaması (kolaydan zora):
///   1: Peld (Flashcard)
///   2: Ceribandin (Quiz)
///   3: Guhdarêkirin (Dinleme)
///   4: Lîhevhatên (Eşleştirme)
///   5: Hevokê çêke (Cümle Kur)
///   6: Hevpeyvîn (Diyalog)
///   7: Bilêvkirin (Telaffuz)

const int kActivityCount = 7;
const String _prefsKey = 'lutke_completed_activities';

/// Tamamlanan etkinliklerin kümesi.
class ProgressionNotifier extends StateNotifier<Set<String>> {
  ProgressionNotifier() : super({}) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_prefsKey) ?? [];
    state = list.toSet();
  }

  /// Bir etkinliği tamamlanmış olarak işaretle.
  Future<void> markComplete(String lessonId) async {
    if (state.contains(lessonId)) return;
    state = {...state, lessonId};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, state.toList());
  }

  /// Belirli bir etkinlik tamamlanmış mı?
  bool isComplete(String lessonId) => state.contains(lessonId);

  /// Bir durağın kaç etkinliği tamamlanmış?
  int completedCountForStop(String level, String category) {
    int count = 0;
    for (int i = 1; i <= kActivityCount; i++) {
      if (state.contains('${level.toLowerCase()}_${category}_$i')) count++;
    }
    return count;
  }

  /// Bir durak tamamen tamamlanmış mı? (7/7)
  bool isStopComplete(String level, String category) =>
      completedCountForStop(level, category) >= kActivityCount;

  /// Belirli bir etkinlik kilidi açık mı?
  /// İlk etkinlik her zaman açık, sonrakiler önceki tamamlanmışsa açık.
  bool isActivityUnlocked(String level, String category, int activityIndex) {
    if (activityIndex <= 1) return true;
    final prevId = '${level.toLowerCase()}_${category}_${activityIndex - 1}';
    return state.contains(prevId);
  }

  /// LessonId oluştur.
  static String makeLessonId(String level, String category, int activityIndex) =>
      '${level.toLowerCase()}_${category}_$activityIndex';
}

final progressionProvider =
    StateNotifierProvider<ProgressionNotifier, Set<String>>(
  (_) => ProgressionNotifier(),
);
