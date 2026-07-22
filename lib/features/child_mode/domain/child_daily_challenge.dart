import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Günlük Meydan Okuma Sistemi
//
// Her gün 3 farklı meydan okuma sunar. Tamamlanan her meydan okuma
// yıldız kazandırır. Hepsi tamamlandığında ödül sandığı açılır.
//
// Modül-agnostik: Hem Kurmancî hem İngilizce çocuk modülünde çalışır.
// ════════════════════════════════════════════════════════════════

enum ChallengeKind {
  learnWords(
    id: 'learn_words',
    emoji: '📝',
    titleKu: 'Peyvên Nû Fêr Bibe',
    titleTr: 'Yeni Kelime Öğren',
    targetDefault: 5,
  ),
  playGames(
    id: 'play_games',
    emoji: '🎮',
    // NOT: "bileyîze" ne rast e; fêrmana fiîla "lîstin" → "bilîze".
    titleKu: 'Lîstikan Bilîze',
    titleTr: 'Oyun Oyna',
    targetDefault: 2,
  ),
  correctAnswers(
    id: 'correct_answers',
    emoji: '✅',
    // NOT: "rast" sifet e; "bersivên rast" (doğru cevaplar) watan hîn zelaltir e.
    titleKu: 'Bersivên Rast Bide',
    titleTr: 'Doğru Cevap Ver',
    targetDefault: 10,
  ),
  completeLesson(
    id: 'complete_lesson',
    emoji: '📚',
    titleKu: 'Waneyekê Biqedîne',
    titleTr: 'Ders Tamamla',
    targetDefault: 1,
  ),
  listenAudio(
    id: 'listen_audio',
    emoji: '🎵',
    titleKu: 'Guhdariya Dengan Bike',
    titleTr: 'Ses Dinle',
    targetDefault: 5,
  ),
  streakDay(
    id: 'streak_day',
    emoji: '🔥',
    // NOT: "Bugün Serinde Kal" tirkî ne normatif bû; "streak" idyomê ji nû ve hat çêkirin.
    titleKu: 'Rêzeya Xwe Berdewam Bike',
    titleTr: 'Serini Sürdür',
    targetDefault: 1,
  );

  final String id;
  final String emoji;
  final String titleKu;
  final String titleTr;
  final int targetDefault;

  const ChallengeKind({
    required this.id,
    required this.emoji,
    required this.titleKu,
    required this.titleTr,
    required this.targetDefault,
  });

  static ChallengeKind fromId(String id) {
    return ChallengeKind.values.firstWhere(
      (e) => e.id == id,
      orElse: () => ChallengeKind.learnWords,
    );
  }
}

/// Tek bir meydan okuma (bugünün 3 meydan okumasından biri).
class DailyChallenge {
  final ChallengeKind kind;
  final int target;
  final int progress;
  final int starsReward;

  const DailyChallenge({
    required this.kind,
    required this.target,
    required this.progress,
    required this.starsReward,
  });

  bool get isCompleted => progress >= target;
  double get percentComplete =>
      target == 0 ? 0 : (progress / target).clamp(0.0, 1.0);

  DailyChallenge copyWith({int? progress}) => DailyChallenge(
        kind: kind,
        target: target,
        progress: progress ?? this.progress,
        starsReward: starsReward,
      );
}

// ════════════════════════════════════════════════════════════════
// Service — SharedPreferences tabanlı, Firebase bağımsız
// ════════════════════════════════════════════════════════════════

class ChildDailyChallengeService {
  static const _dateKey = 'child_challenge_date';
  static const _challengesKey = 'child_challenge_list';
  static const _progressKeyPrefix = 'child_challenge_progress_';
  static const _chestKey = 'child_reward_chests';

  /// Bugünün meydan okumalarını al. Gün değiştiyse yenisi oluşturulur.
  static Future<List<DailyChallenge>> getTodayChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final todayStr = _todayKey();
    final savedDate = prefs.getString(_dateKey);

    if (savedDate != todayStr) {
      // Yeni gün — yeni meydan okumalar seç
      return _generateNewDay(prefs, todayStr);
    }

    // Mevcut günün meydan okumalarını yükle
    final savedChallenges = prefs.getStringList(_challengesKey) ?? const [];
    if (savedChallenges.isEmpty) {
      return _generateNewDay(prefs, todayStr);
    }

    return savedChallenges.map((line) {
      final parts = line.split(':');
      final kind = ChallengeKind.fromId(parts[0]);
      final target = int.tryParse(parts.elementAtOrNull(1) ?? '0') ??
          kind.targetDefault;
      final stars = int.tryParse(parts.elementAtOrNull(2) ?? '3') ?? 3;
      final progress = prefs.getInt('$_progressKeyPrefix${kind.id}') ?? 0;
      return DailyChallenge(
        kind: kind,
        target: target,
        progress: progress,
        starsReward: stars,
      );
    }).toList();
  }

  /// Meydan okuma ilerlemesini artır.
  /// Tamamlanırsa otomatik ödül verilir (yıldız + istatistik).
  static Future<DailyChallenge?> recordProgress(
    ChallengeKind kind, {
    int amount = 1,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_progressKeyPrefix${kind.id}';
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + amount);

    final all = await getTodayChallenges();
    final c = all.firstWhere(
      (x) => x.kind == kind,
      orElse: () => DailyChallenge(
        kind: kind,
        target: kind.targetDefault,
        progress: current + amount,
        starsReward: 3,
      ),
    );

    // 3/3 meydan okuma tamamlandıysa sandık ver
    if (all.every((x) => x.isCompleted)) {
      await _awardChest(prefs);
    }

    return c;
  }

  /// Ödül sandığı sayısını al.
  static Future<int> getUnopenedChests() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_chestKey) ?? 0;
  }

  /// Sandığı aç — yıldız döner (25-45 arası, makul).
  ///
  /// Pedagojik NOT (Ryan-Deci CET, 1985; Deci Koestner Ryan 2001 meta-analiz):
  /// Büyük ve sürprizli ödüller (örn. 50-150 yıldız) task-contingent
  /// reinforcement yarattığı için intrinsic motivasyonu aşındırır.
  /// Ödüller bu yüzden daha dar bir aralığa çekildi; öğrenmenin iç
  /// hazzı (Karîk'in büyümesi, Kurmancî kelimelerin ses-anlam bağı)
  /// asıl güdüleyici kalmalı.
  static Future<int> openChest() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_chestKey) ?? 0;
    if (count == 0) return 0;

    final reward = 25 + (DateTime.now().millisecondsSinceEpoch % 21);
    await prefs.setInt(_chestKey, count - 1);
    return reward;
  }

  /// Test/reset — tüm günlük verileri sil.
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_dateKey);
    await prefs.remove(_challengesKey);
    await prefs.remove(_chestKey);
    for (final k in ChallengeKind.values) {
      await prefs.remove('$_progressKeyPrefix${k.id}');
    }
  }

  // ── İç yardımcılar ───────────────────────────────────────

  static Future<List<DailyChallenge>> _generateNewDay(
    SharedPreferences prefs,
    String todayStr,
  ) async {
    // 3 farklı challenge seç (rastgele ama gün sabit)
    final seed = todayStr.hashCode;
    final shuffled = List<ChallengeKind>.from(ChallengeKind.values)
      ..shuffleWith(_SeededRandom(seed));
    final selected = shuffled.take(3).toList();

    // Önceki ilerlemeleri sıfırla
    for (final k in ChallengeKind.values) {
      await prefs.remove('$_progressKeyPrefix${k.id}');
    }

    final lines = selected.map((k) {
      // Rastgele yıldız ödülü: 3-7
      final stars = 3 + (seed.abs() % 5);
      return '${k.id}:${k.targetDefault}:$stars';
    }).toList();

    await prefs.setString(_dateKey, todayStr);
    await prefs.setStringList(_challengesKey, lines);

    return selected.map((k) => DailyChallenge(
          kind: k,
          target: k.targetDefault,
          progress: 0,
          starsReward: 3 + (seed.abs() % 5),
        )).toList();
  }

  static Future<void> _awardChest(SharedPreferences prefs) async {
    final flagKey = 'child_chest_awarded_${_todayKey()}';
    if (prefs.getBool(flagKey) == true) return; // aynı gün 2. kez verme
    final count = prefs.getInt(_chestKey) ?? 0;
    await prefs.setInt(_chestKey, count + 1);
    await prefs.setBool(flagKey, true);
  }

  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}

/// Basit deterministik rasgele sayı üreteci.
class _SeededRandom {
  int _state;
  _SeededRandom(int seed) : _state = seed == 0 ? 1 : seed.abs();

  int nextInt(int max) {
    _state = (_state * 1103515245 + 12345) & 0x7FFFFFFF;
    return _state % max;
  }
}

extension _ListShuffleExt<T> on List<T> {
  void shuffleWith(_SeededRandom r) {
    for (int i = length - 1; i > 0; i--) {
      final j = r.nextInt(i + 1);
      final tmp = this[i];
      this[i] = this[j];
      this[j] = tmp;
    }
  }
}

// ════════════════════════════════════════════════════════════════
// Riverpod providers
// ════════════════════════════════════════════════════════════════

/// BUG FIX: Provider version bumper — ChildDailyChallengeService.recordProgress
/// SharedPreferences'e yaziyordu ama FutureProvider'lar yenilenmedigi icin
/// daily challenge kart stale ilerleme gosteriyordu. recordProgress sonrasi
/// bu counter'i artir ki watcher'lar refetch etsin.
final childChallengeVersionProvider = StateProvider<int>((ref) => 0);

final todayChallengesProvider =
    FutureProvider.autoDispose<List<DailyChallenge>>((ref) async {
  ref.watch(childChallengeVersionProvider);
  return ChildDailyChallengeService.getTodayChallenges();
});

final unopenedChestsProvider =
    FutureProvider.autoDispose<int>((ref) async {
  ref.watch(childChallengeVersionProvider);
  return ChildDailyChallengeService.getUnopenedChests();
});

/// Yardimci: recordProgress cagrisindan sonra UI'yi otomatik yenile.
Future<void> recordChallengeProgressAndNotify(
  dynamic ref,
  ChallengeKind kind, {
  int amount = 1,
}) async {
  // Notifier'i AWAIT'TEN ONCE oku — cagiran widget await sirasinda dispose
  // edilirse ref.read "ref after dispose" hatasi firlatirdi.
  // ignore: avoid_dynamic_calls
  final notifier = ref.read(childChallengeVersionProvider.notifier);
  await ChildDailyChallengeService.recordProgress(kind, amount: amount);
  try {
    // ignore: avoid_dynamic_calls
    notifier.state = (notifier.state as int) + 1;
  } catch (_) {
    // Container kapandiysa sessiz gec — veri zaten kaydedildi.
  }
}
