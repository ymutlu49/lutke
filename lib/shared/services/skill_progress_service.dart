import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Her 5 dil becerisi için ilerleme takibi.
///
/// Key format: `skill_<module>_<skill>_completed` → int (tamamlanan egzersiz)
/// Key format: `skill_<module>_<skill>_xp` → int (kazanılan XP)
///
/// Beceriler: grammar, writing, reading, listening, speaking, quiz
/// Modüller: ku, en
class SkillProgressService {
  static const _prefix = 'skill_';

  /// Bir beceri için egzersiz tamamla.
  static Future<void> markCompleted({
    required String module, // 'ku' | 'en'
    required String skill, // 'grammar' | 'writing' | ...
    int xp = 10,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cKey = '$_prefix${module}_${skill}_completed';
    final xKey = '$_prefix${module}_${skill}_xp';
    await prefs.setInt(cKey, (prefs.getInt(cKey) ?? 0) + 1);
    await prefs.setInt(xKey, (prefs.getInt(xKey) ?? 0) + xp);
  }

  /// Bir beceri için toplam tamamlanan egzersiz.
  static Future<int> getCompleted({
    required String module,
    required String skill,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_prefix${module}_${skill}_completed') ?? 0;
  }

  /// Bir beceri için toplam XP.
  static Future<int> getXp({
    required String module,
    required String skill,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_prefix${module}_${skill}_xp') ?? 0;
  }

  /// Bir modül için tüm becerilerin toplam XP'si.
  static Future<int> getTotalXp(String module) async {
    final prefs = await SharedPreferences.getInstance();
    int total = 0;
    for (final skill in [
      'grammar', 'writing', 'reading', 'listening', 'speaking', 'quiz'
    ]) {
      total += prefs.getInt('$_prefix${module}_${skill}_xp') ?? 0;
    }
    return total;
  }

  /// Reset bir modülün tüm ilerlemesini.
  static Future<void> reset(String module) async {
    final prefs = await SharedPreferences.getInstance();
    for (final skill in [
      'grammar', 'writing', 'reading', 'listening', 'speaking', 'quiz'
    ]) {
      await prefs.remove('$_prefix${module}_${skill}_completed');
      await prefs.remove('$_prefix${module}_${skill}_xp');
    }
  }
}

/// Riverpod provider — modül toplam XP'si (async)
final skillTotalXpProvider =
    FutureProvider.family<int, String>((ref, module) async {
  return SkillProgressService.getTotalXp(module);
});

/// Bir beceri için tamamlanan sayı
final skillCompletedProvider = FutureProvider.family<int, ({String module, String skill})>(
  (ref, params) async {
    return SkillProgressService.getCompleted(module: params.module, skill: params.skill);
  },
);
