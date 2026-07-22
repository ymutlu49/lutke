import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/providers/learning_module_provider.dart';
import '../../shared/services/skill_progress_service.dart';

/// LÛTKE — Haftalık AI Tavsiye Sistemi
///
/// Yerel (offline) kural tabanlı öneri motoru. LLM çağrısı yok.
/// Kullanıcının becerilerini, streak'ini ve aktif modülünü analiz edip
/// Kurmancî dilinde haftalık çalışma programı önerir.
///
/// Kural setleri:
/// 1. Streak düşük → rutin kurma önerisi
/// 2. En zayıf beceri → odaklanma önerisi
/// 3. Rozet eşiği yakın → motivasyon önerisi
/// 4. Modül dengesi → cross-module öneri (hem KU hem EN varsa)
class AiRecommendationService {
  /// Son haftalık öneri üretim zamanı cache anahtarı.
  static const _lastGeneratedKey = 'ai_reco_last_generated';
  static const _cachedAdviceKey = 'ai_reco_cached_advice';

  /// Haftalık tavsiye üret. 24 saatten eski değilse cache'den döner.
  static Future<WeeklyRecommendation> getWeeklyRecommendation({
    required String activeModule, // 'ku' | 'en'
    required int streakDays,
    required int currentLevelNum,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final lastMillis = prefs.getInt(_lastGeneratedKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    final ageHours = (now - lastMillis) / (1000 * 60 * 60);

    // 24 saatten taze cache → kullan
    if (ageHours < 24 && lastMillis > 0) {
      final cached = prefs.getString(_cachedAdviceKey);
      if (cached != null && cached.isNotEmpty) {
        return WeeklyRecommendation.fromCache(cached);
      }
    }

    // Yeni öneri üret
    final analysis = await _analyze(activeModule);
    final reco = _generate(analysis, streakDays, currentLevelNum);

    await prefs.setInt(_lastGeneratedKey, now);
    await prefs.setString(_cachedAdviceKey, reco.toCache());

    return reco;
  }

  /// Cache'i temizle — kullanıcı yenilemek istediğinde.
  static Future<void> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastGeneratedKey);
    await prefs.remove(_cachedAdviceKey);
  }

  static Future<_SkillAnalysis> _analyze(String activeModule) async {
    const skills = [
      'grammar', 'writing', 'reading', 'listening', 'speaking', 'quiz',
    ];
    final kuXp = <String, int>{};
    final enXp = <String, int>{};
    for (final s in skills) {
      kuXp[s] = await SkillProgressService.getXp(module: 'ku', skill: s);
      enXp[s] = await SkillProgressService.getXp(module: 'en', skill: s);
    }
    return _SkillAnalysis(
      activeModule: activeModule,
      kuXp: kuXp,
      enXp: enXp,
    );
  }

  static WeeklyRecommendation _generate(
    _SkillAnalysis a,
    int streakDays,
    int levelNum,
  ) {
    final activeXp = a.activeModule == 'en' ? a.enXp : a.kuXp;
    final inactiveXp = a.activeModule == 'en' ? a.kuXp : a.enXp;
    final moduleEmoji = a.activeModule == 'en' ? '🌍' : '🐐';
    final moduleName = a.activeModule == 'en' ? 'Îngilîzî' : 'Kurmancî';

    // En zayıf beceri (XP < 50)
    final sortedSkills = activeXp.entries.toList()
      ..sort((x, y) => x.value.compareTo(y.value));
    final weakest = sortedSkills.first;
    final strongest = sortedSkills.last;

    // Toplam aktif XP
    final totalActive = activeXp.values.fold<int>(0, (s, v) => s + v);
    final totalInactive = inactiveXp.values.fold<int>(0, (s, v) => s + v);

    // Kurallar ve ağırlıkları
    final tips = <RecommendationTip>[];

    // Kural 1: Streak düşük
    if (streakDays < 3) {
      tips.add(RecommendationTip(
        emoji: '🔥',
        title: 'Rêze ava bike',
        body: streakDays == 0
            ? 'Îro dest pê bike! 10 deqîqe jî bes e.'
            : 'Rêzeya te $streakDays rojî ye. 7 rojî bike!',
        priority: 10,
        actionKey: 'daily_practice',
      ));
    } else if (streakDays >= 7) {
      tips.add(RecommendationTip(
        emoji: '🎉',
        title: 'Rêzeya te xurt e!',
        body: '$streakDays roj bi berdewamî — bi vê leza xwe berdewam bike.',
        priority: 4,
        actionKey: 'keep_streak',
      ));
    } else {
      tips.add(RecommendationTip(
        emoji: '🔥',
        title: 'Rêze xurt bike',
        body: 'Niha $streakDays roj e. Heta 7 rojan bê qutbûn berdewam be!',
        priority: 7,
        actionKey: 'extend_streak',
      ));
    }

    // Kural 2: En zayıf beceri
    if (weakest.value < 50) {
      tips.add(RecommendationTip(
        emoji: _skillEmoji(weakest.key),
        title: '${_skillLabelKu(weakest.key)} kêm maye',
        body:
            'Vê hefteyê sê caran li ser ${_skillLabelKu(weakest.key).toLowerCase()}ê kar bike. Armanc: ${50 - weakest.value} XP zêde.',
        priority: 9,
        actionKey: 'weak_skill_${weakest.key}',
      ));
    } else if (weakest.value < 200 && strongest.value > 200) {
      tips.add(RecommendationTip(
        emoji: _skillEmoji(weakest.key),
        title: 'Di jêhatiyên xwe de hevsengiyê peyda bike',
        body:
            '${_skillLabelKu(strongest.key)} xurt e (${strongest.value} XP), lê ${_skillLabelKu(weakest.key).toLowerCase()} (${weakest.value} XP) hîn jî pêdivî bi xebatê heye.',
        priority: 6,
        actionKey: 'balance_${weakest.key}',
      ));
    }

    // Kural 3: Rozet eşiği yakın
    final closeToTier = _closestTierGap(activeXp);
    if (closeToTier != null) {
      tips.add(RecommendationTip(
        emoji: closeToTier.$3,
        title: '${closeToTier.$4} pir nêz e!',
        body:
            '${_skillLabelKu(closeToTier.$1)} tenê ${closeToTier.$2} XP maye ${closeToTier.$4.toLowerCase()} rozetê!',
        priority: 8,
        actionKey: 'tier_${closeToTier.$1}',
      ));
    }

    // Kural 4: Modül dengesi (hem KU hem EN hareketliyse)
    if (totalInactive > 0 && totalActive > totalInactive * 3) {
      final otherModule = a.activeModule == 'en' ? 'Kurmancî' : 'Îngilîzî';
      final otherEmoji = a.activeModule == 'en' ? '🐐' : '🌍';
      tips.add(RecommendationTip(
        emoji: otherEmoji,
        title: '$otherModule ji bîr meke',
        body:
            '$moduleName li pêş ketiye. Di hefteyê de yek rojê $otherModule jî kar bike.',
        priority: 5,
        actionKey: 'balance_modules',
      ));
    }

    // Kural 5: Seviye ilerleme
    if (totalActive > 400 && levelNum <= 3) {
      tips.add(RecommendationTip(
        emoji: '📈',
        title: 'Ji bo asteke nû amade yî?',
        body:
            'Te $totalActive XP kom kirin; dibe ku asteke nû li benda te be.',
        priority: 4,
        actionKey: 'level_up',
      ));
    }

    // En yüksek 3 öneriyi al
    tips.sort((x, y) => y.priority.compareTo(x.priority));
    final top = tips.take(3).toList();

    // Haftalık plan: 7 gün boyunca hangi aktivite
    final plan = _buildWeeklyPlan(activeXp, streakDays);

    return WeeklyRecommendation(
      moduleName: moduleName,
      moduleEmoji: moduleEmoji,
      summary: _buildSummary(top, activeXp, totalActive),
      tips: top,
      weeklyPlan: plan,
      generatedAt: DateTime.now(),
    );
  }

  static String _buildSummary(
    List<RecommendationTip> tips,
    Map<String, int> xp,
    int total,
  ) {
    if (total == 0) {
      return 'Bi xêr hatî! Em bi hev re dest pê bikin. Plana hefteya te ya yekem amade ye: rojê 15 deqîqe.';
    }
    if (tips.isEmpty) return 'Her tişt baş e. Berdewam bike!';
    return '${tips.first.body} Hefteya te bi vê şîretê dest pê dike.';
  }

  static (String, int, String, String)? _closestTierGap(
    Map<String, int> xp,
  ) {
    // En yakın eşik boşluğunu bul (en fazla 30 XP uzaklıkta)
    (String, int, String, String)? best;
    for (final e in xp.entries) {
      final targets = [
        // NOT: "Birinc" = pirinç (yiyecek); bronz için "Bronz" doğru terim.
        (50, '🥉', 'Bronz'),
        (200, '🥈', 'Zîv'),
        (500, '🥇', 'Zêr'),
      ];
      for (final t in targets) {
        final gap = t.$1 - e.value;
        if (gap > 0 && gap <= 30) {
          if (best == null || gap < best.$2) {
            best = (e.key, gap, t.$2, t.$3);
          }
        }
      }
    }
    return best;
  }

  static List<DailyPlanItem> _buildWeeklyPlan(
    Map<String, int> xp,
    int streakDays,
  ) {
    // 7 günlük plan — beceri rotasyonu
    final sorted = xp.entries.toList()
      ..sort((x, y) => x.value.compareTo(y.value));
    final weakSkills = sorted.take(3).map((e) => e.key).toList();
    final strongSkills = sorted.skip(3).map((e) => e.key).toList();

    // Rotasyon: 3 zayıf beceri, 2 kuvvetli, 1 quiz, 1 ödül (kültür/story)
    final plan = <DailyPlanItem>[];
    final days = ['Dş', 'Sş', 'Çş', 'Pş', 'În', 'Şe', 'Yş'];
    final rnd = Random(DateTime.now().weekOfYear + DateTime.now().year);

    final activities = [
      // 3 zayıf becerilerden
      ...weakSkills.map((s) => (s, _skillLabelKu(s), _skillEmoji(s))),
      // 2 güçlü becerilerden
      ...strongSkills.take(2).map((s) => (s, _skillLabelKu(s), _skillEmoji(s))),
      // 1 quiz
      ('quiz', 'Testeke giştî', '🎯'),
      // 1 ödül günü (hafıza veya kültür)
      ('culture', 'Çanda Kurmancî', '🎵'),
    ];
    activities.shuffle(rnd);

    for (int i = 0; i < 7; i++) {
      final (skill, label, emoji) = activities[i % activities.length];
      plan.add(DailyPlanItem(
        dayShort: days[i],
        skillId: skill,
        labelKu: label,
        emoji: emoji,
        targetXp: 15 + (i % 3) * 5, // 15-25 XP arası
      ));
    }
    return plan;
  }

  static String _skillEmoji(String s) {
    switch (s) {
      case 'grammar':
        return '📘';
      case 'writing':
        return '✍️';
      case 'reading':
        return '📖';
      case 'listening':
        return '👂';
      case 'speaking':
        return '🗣️';
      case 'quiz':
        return '🎯';
      default:
        return '⭐';
    }
  }

  static String _skillLabelKu(String s) {
    switch (s) {
      case 'grammar':
        return 'Gramer';
      case 'writing':
        return 'Nivîsîn';
      case 'reading':
        return 'Xwendin';
      case 'listening':
        return 'Guhdarîkirin';
      case 'speaking':
        return 'Axaftin';
      case 'quiz':
        return 'Test';
      default:
        return s;
    }
  }
}

class _SkillAnalysis {
  final String activeModule;
  final Map<String, int> kuXp;
  final Map<String, int> enXp;
  const _SkillAnalysis({
    required this.activeModule,
    required this.kuXp,
    required this.enXp,
  });
}

// ════════════════════════════════════════════════════════════════
// Domain modeli
// ════════════════════════════════════════════════════════════════

class WeeklyRecommendation {
  final String moduleName;
  final String moduleEmoji;
  final String summary;
  final List<RecommendationTip> tips;
  final List<DailyPlanItem> weeklyPlan;
  final DateTime generatedAt;

  const WeeklyRecommendation({
    required this.moduleName,
    required this.moduleEmoji,
    required this.summary,
    required this.tips,
    required this.weeklyPlan,
    required this.generatedAt,
  });

  /// Haftanın kaçıncı günü? (1-7)
  int get dayOfWeek => generatedAt.weekday;

  String toCache() {
    final parts = [
      moduleName,
      moduleEmoji,
      summary,
      generatedAt.millisecondsSinceEpoch.toString(),
      tips.map((t) => t.toCache()).join(';;'),
      weeklyPlan.map((p) => p.toCache()).join(';;'),
    ];
    return parts.join('||');
  }

  factory WeeklyRecommendation.fromCache(String raw) {
    final parts = raw.split('||');
    if (parts.length < 6) {
      return WeeklyRecommendation(
        moduleName: 'Kurmancî',
        moduleEmoji: '🐐',
        summary: '',
        tips: const [],
        weeklyPlan: const [],
        generatedAt: DateTime.now(),
      );
    }
    return WeeklyRecommendation(
      moduleName: parts[0],
      moduleEmoji: parts[1],
      summary: parts[2],
      generatedAt:
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(parts[3]) ?? 0),
      tips: parts[4].isEmpty
          ? []
          : parts[4].split(';;').map(RecommendationTip.fromCache).toList(),
      weeklyPlan: parts[5].isEmpty
          ? []
          : parts[5].split(';;').map(DailyPlanItem.fromCache).toList(),
    );
  }
}

class RecommendationTip {
  final String emoji;
  final String title;
  final String body;
  final int priority; // 1-10
  final String actionKey;

  const RecommendationTip({
    required this.emoji,
    required this.title,
    required this.body,
    required this.priority,
    required this.actionKey,
  });

  String toCache() => [emoji, title, body, priority, actionKey].join('::');
  factory RecommendationTip.fromCache(String raw) {
    final p = raw.split('::');
    return RecommendationTip(
      emoji: p.elementAtOrNull(0) ?? '',
      title: p.elementAtOrNull(1) ?? '',
      body: p.elementAtOrNull(2) ?? '',
      priority: int.tryParse(p.elementAtOrNull(3) ?? '0') ?? 0,
      actionKey: p.elementAtOrNull(4) ?? '',
    );
  }
}

class DailyPlanItem {
  final String dayShort;
  final String skillId;
  final String labelKu;
  final String emoji;
  final int targetXp;

  const DailyPlanItem({
    required this.dayShort,
    required this.skillId,
    required this.labelKu,
    required this.emoji,
    required this.targetXp,
  });

  String toCache() => [dayShort, skillId, labelKu, emoji, targetXp].join('::');
  factory DailyPlanItem.fromCache(String raw) {
    final p = raw.split('::');
    return DailyPlanItem(
      dayShort: p.elementAtOrNull(0) ?? '',
      skillId: p.elementAtOrNull(1) ?? '',
      labelKu: p.elementAtOrNull(2) ?? '',
      emoji: p.elementAtOrNull(3) ?? '',
      targetXp: int.tryParse(p.elementAtOrNull(4) ?? '0') ?? 0,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Riverpod provider
// ════════════════════════════════════════════════════════════════

final weeklyRecommendationProvider = FutureProvider.family
    .autoDispose<WeeklyRecommendation, ({int streak, int level})>(
  (ref, p) async {
    final isEn = ref.watch(isEnglishModuleProvider);
    return AiRecommendationService.getWeeklyRecommendation(
      activeModule: isEn ? 'en' : 'ku',
      streakDays: p.streak,
      currentLevelNum: p.level,
    );
  },
);

/// Yardımcı extension — haftanın yılın kaçıncı haftası
extension on DateTime {
  int get weekOfYear {
    final firstDayOfYear = DateTime(year, 1, 1);
    final daysSinceFirst = difference(firstDayOfYear).inDays;
    return ((daysSinceFirst + firstDayOfYear.weekday - 1) / 7).ceil();
  }
}
