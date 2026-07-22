import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Runtime Ders (Lesson) Overrides
//
// Sahip kullanıcı ders kart listelerini (targetCardIds) uygulama içinden
// yeniden sıralayabilir, ekleyebilir veya çıkarabilir. MVP kapsamında
// yalnızca targetCardIds override edilir; alıştırma seti (exercises)
// derleme ile gelmeye devam eder.
//
// Depolama: `lesson_overrides_v1` pref key.
//   {
//     "<lessonId>": { "targetCardIds": [<wordId>, ...] }
//   }
//
// applyLessonOverride() bir ders nesnesini ve override'ı alıp
// `targetCardIds` alanı geçersiz kılınmış sarmalayıcı döndürür.
// ════════════════════════════════════════════════════════════════

/// Tek bir ders için opsiyonel override katmanı. İleride `exerciseIds`
/// gibi alanlar eklenebilir — backward compat için JSON tolerant.
class LessonOverride {
  /// Eğer null: orijinal kart listesi korunur.
  /// Eğer non-null: bu liste orijinalin yerine geçer.
  final List<String>? targetCardIds;

  const LessonOverride({this.targetCardIds});

  bool get isEmpty => targetCardIds == null;
  bool get isNotEmpty => !isEmpty;

  Map<String, dynamic> toJson() => {
        if (targetCardIds != null) 'targetCardIds': targetCardIds,
      };

  factory LessonOverride.fromJson(Map<String, dynamic> j) => LessonOverride(
        targetCardIds: (j['targetCardIds'] as List?)
            ?.map((e) => e.toString())
            .toList(),
      );
}

// ── Kalıcı depolama ─────────────────────────────────────────────

class LessonOverrideService {
  static const _key = 'lesson_overrides_v1';

  Future<Map<String, LessonOverride>> loadAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return <String, LessonOverride>{};
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, LessonOverride>{};
      final result = <String, LessonOverride>{};
      decoded.forEach((k, v) {
        if (k is String && v is Map) {
          result[k] = LessonOverride.fromJson(v.cast<String, dynamic>());
        }
      });
      return result;
    } catch (_) {
      return <String, LessonOverride>{};
    }
  }

  Future<void> _persist(Map<String, LessonOverride> all) async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    all.forEach((k, v) {
      if (v.isNotEmpty) map[k] = v.toJson();
    });
    await prefs.setString(_key, jsonEncode(map));
  }

  Future<void> save(String lessonId, LessonOverride override) async {
    final all = await loadAll();
    if (override.isEmpty) {
      all.remove(lessonId);
    } else {
      all[lessonId] = override;
    }
    await _persist(all);
  }

  Future<void> delete(String lessonId) async {
    final all = await loadAll();
    all.remove(lessonId);
    await _persist(all);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

// ── Riverpod providers ──────────────────────────────────────────

final lessonOverrideServiceProvider =
    Provider<LessonOverrideService>((_) => LessonOverrideService());

class LessonOverridesNotifier
    extends StateNotifier<Map<String, LessonOverride>> {
  LessonOverridesNotifier(this._service)
      : super(const <String, LessonOverride>{}) {
    _load();
  }

  final LessonOverrideService _service;

  Future<void> _load() async {
    final data = await _service.loadAll();
    if (!mounted) return;
    state = Map.unmodifiable(data);
  }

  Future<void> setOverride(String lessonId, LessonOverride v) async {
    final next = Map<String, LessonOverride>.from(state);
    if (v.isEmpty) {
      next.remove(lessonId);
    } else {
      next[lessonId] = v;
    }
    state = Map.unmodifiable(next);
    await _service.save(lessonId, v);
  }

  Future<void> removeOverride(String lessonId) async {
    final next = Map<String, LessonOverride>.from(state)..remove(lessonId);
    state = Map.unmodifiable(next);
    await _service.delete(lessonId);
  }

  Future<void> clearAll() async {
    state = const <String, LessonOverride>{};
    await _service.clearAll();
  }
}

final lessonOverridesProvider = StateNotifierProvider<LessonOverridesNotifier,
    Map<String, LessonOverride>>((ref) {
  return LessonOverridesNotifier(ref.watch(lessonOverrideServiceProvider));
});

// ════════════════════════════════════════════════════════════════
// UYGULAMA YARDIMCISI
// ════════════════════════════════════════════════════════════════

/// Bir ders nesnesine override uygular. Override yoksa ders olduğu gibi
/// döner (alokasyon yok). Ders tarafında `targetCardIds` dinamik erişimle
/// okunduğunda sarmalayıcının getter'ı devreye girer.
///
/// Öncelik:
///   - override.targetCardIds != null  → override listeyi kullan
///   - aksi                             → ders orijinal listesini kullan
dynamic applyLessonOverride(dynamic lesson, LessonOverride? override) {
  if (override == null || override.isEmpty) return lesson;
  return _OverriddenLesson(lesson, override);
}

/// Dinamik sarmalayıcı — LessonModel'in getter'larını pass-through eder,
/// yalnızca `targetCardIds`'i override'dan okur.
class _OverriddenLesson {
  final dynamic _lesson;
  final LessonOverride _o;
  const _OverriddenLesson(this._lesson, this._o);

  List<String> get targetCardIds =>
      _o.targetCardIds ?? (_lesson.targetCardIds as List).cast<String>();

  // Geri kalan alanlar pass-through
  dynamic get id => _lesson.id;
  dynamic get kurmanjTitle => _lesson.kurmanjTitle;
  dynamic get turkishTitle => _lesson.turkishTitle;
  dynamic get unitNumber => _lesson.unitNumber;
  dynamic get lessonNumber => _lesson.lessonNumber;
  dynamic get level => _lesson.level;
  dynamic get path => _lesson.path;
  dynamic get exercises => _lesson.exercises;
  dynamic get culturalRewardId => _lesson.culturalRewardId;
  dynamic get estimatedMinutes => _lesson.estimatedMinutes;
  dynamic get emoji => _lesson.emoji;

  // Getter yardımcıları (LessonModel üzerinde var)
  dynamic get titleKu => _lesson.titleKu;
  dynamic get titleTr => _lesson.titleTr;
  dynamic get kuTitle => _lesson.kuTitle;
  dynamic get trTitle => _lesson.trTitle;
  dynamic get icon => _lesson.icon;
  dynamic get totalXP => _lesson.totalXP;
  dynamic get xpReward => _lesson.xpReward;
  dynamic get hasHeritageContent => _lesson.hasHeritageContent;
  dynamic get culturalReward => _lesson.culturalReward;
  dynamic get buildExercises => _lesson.buildExercises;
}
