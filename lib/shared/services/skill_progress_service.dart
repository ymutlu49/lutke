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

/// Riverpod provider — modül toplam XP'si (async).
/// autoDispose: family üye sayısı sınırsız büyümesin (mem leak önlemi).
final skillTotalXpProvider =
    FutureProvider.autoDispose.family<int, String>((ref, module) async {
  // Mutation bump'ina bagli — markCompleted sonrasi counter arttirilinca
  // watcher'lar yeniden fetch eder.
  ref.watch(skillProgressVersionProvider);
  return SkillProgressService.getTotalXp(module);
});

/// Bir beceri için tamamlanan sayı
final skillCompletedProvider = FutureProvider.autoDispose
    .family<int, ({String module, String skill})>(
  (ref, params) async {
    ref.watch(skillProgressVersionProvider);
    return SkillProgressService.getCompleted(
        module: params.module, skill: params.skill);
  },
);

/// BUG FIX: markCompleted SharedPreferences'e yazar ama FutureProvider'lar
/// otomatik yenilenmezdi — skill dashboard stale veri gosteriyordu.
/// Bu counter'i increment ederek dependent provider'lari invalidate ederiz.
/// StateProvider yerine StateNotifier — global olarak erisim (container
/// gerekmeden) StatefulWidget ve ConsumerStatefulWidget'tan cagrilabilir.
final skillProgressVersionProvider = StateProvider<int>((ref) => 0);

/// Yardimci: markCompleted sonrasi cagir — UI otomatik yenilensin.
/// `ref` tipi `WidgetRef` ya da `Ref` olabilir (ikisinde de .read vardir).
Future<void> markSkillCompletedAndNotify(
  dynamic ref, {
  required String module,
  required String skill,
  int xp = 10,
}) async {
  // Notifier'i AWAIT'TEN ONCE oku: cagiran widget await sirasinda dispose
  // edilirse (fire-and-forget cagrilar + ekran gecisi) ref.read
  // "Cannot use ref after the widget was disposed" firlatirdi.
  // ignore: avoid_dynamic_calls
  final notifier = ref.read(skillProgressVersionProvider.notifier);
  await SkillProgressService.markCompleted(
      module: module, skill: skill, xp: xp);
  try {
    // ignore: avoid_dynamic_calls
    notifier.state = (notifier.state as int) + 1;
  } catch (_) {
    // Provider container kapandiysa sessiz gec — veri zaten kaydedildi.
  }
}
