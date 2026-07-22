import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Sahip-Tanımlı Quiz Soruları (Custom Quiz Questions)
//
// Sahip kullanıcı, kendi çoktan seçmeli (MC) Kurmancî sorularını
// uygulama içinden ekleyebilir. Depolama: SharedPreferences.
// Pref key: `custom_quiz_v1` → { "<questionId>": { ...json... } }
//
// MVP kapsamı:
//   - Create / list / delete
//   - Quiz ekranında ayrı bir "Custom Quiz" modu olarak oynama
// Gelecek (bu sprint'te DEĞİL):
//   - Düzenleme
//   - Gündelik havuzla otomatik harmanlama
// ════════════════════════════════════════════════════════════════

/// Bir özel çoktan seçmeli Kurmancî sorusu.
class CustomQuizQuestion {
  final String id;          // 'cq_<millis>'
  final String questionKu;  // Kurmancî soru metni
  final List<String> options; // 4 seçenek (Kurmancî veya Türkçe)
  final int correctIndex;   // 0..3
  final String explanationTr; // Türkçe açıklama (doğru yanıt neden doğrudur?)
  final String kat;         // kategori (ör. 'malbat')

  const CustomQuizQuestion({
    required this.id,
    required this.questionKu,
    required this.options,
    required this.correctIndex,
    required this.explanationTr,
    required this.kat,
  });

  bool get isValid =>
      questionKu.trim().isNotEmpty &&
      options.length == 4 &&
      options.every((o) => o.trim().isNotEmpty) &&
      correctIndex >= 0 &&
      correctIndex < 4;

  static String newId() => 'cq_${DateTime.now().millisecondsSinceEpoch}';

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionKu': questionKu,
        'options': options,
        'correctIndex': correctIndex,
        'explanationTr': explanationTr,
        'kat': kat,
      };

  factory CustomQuizQuestion.fromJson(Map<String, dynamic> j) =>
      CustomQuizQuestion(
        id: j['id'] as String,
        questionKu: (j['questionKu'] as String?) ?? '',
        options: (j['options'] as List?)?.map((e) => e.toString()).toList() ??
            const [],
        correctIndex: (j['correctIndex'] is int)
            ? j['correctIndex'] as int
            : int.tryParse('${j['correctIndex']}') ?? 0,
        explanationTr: (j['explanationTr'] as String?) ?? '',
        kat: (j['kat'] as String?) ?? 'custom',
      );
}

// ── Kalıcı depolama ─────────────────────────────────────────────

class CustomQuizService {
  static const _key = 'custom_quiz_v1';

  Future<Map<String, CustomQuizQuestion>> loadAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return <String, CustomQuizQuestion>{};
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, CustomQuizQuestion>{};
      final result = <String, CustomQuizQuestion>{};
      decoded.forEach((k, v) {
        if (k is String && v is Map) {
          try {
            result[k] =
                CustomQuizQuestion.fromJson(v.cast<String, dynamic>());
          } catch (_) {/* skip malformed */}
        }
      });
      return result;
    } catch (_) {
      return <String, CustomQuizQuestion>{};
    }
  }

  Future<void> _persist(Map<String, CustomQuizQuestion> all) async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    all.forEach((k, v) => map[k] = v.toJson());
    await prefs.setString(_key, jsonEncode(map));
  }

  Future<void> save(CustomQuizQuestion q) async {
    final all = await loadAll();
    all[q.id] = q;
    await _persist(all);
  }

  Future<void> delete(String id) async {
    final all = await loadAll();
    all.remove(id);
    await _persist(all);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

// ── Riverpod providers ──────────────────────────────────────────

final customQuizServiceProvider =
    Provider<CustomQuizService>((_) => CustomQuizService());

class CustomQuizQuestionsNotifier
    extends StateNotifier<Map<String, CustomQuizQuestion>> {
  CustomQuizQuestionsNotifier(this._service)
      : super(const <String, CustomQuizQuestion>{}) {
    _load();
  }

  final CustomQuizService _service;

  Future<void> _load() async {
    final data = await _service.loadAll();
    if (!mounted) return;
    state = Map.unmodifiable(data);
  }

  Future<void> addQuestion(CustomQuizQuestion q) async {
    if (!q.isValid) return;
    final next = Map<String, CustomQuizQuestion>.from(state);
    next[q.id] = q;
    state = Map.unmodifiable(next);
    await _service.save(q);
  }

  Future<void> removeQuestion(String id) async {
    final next = Map<String, CustomQuizQuestion>.from(state)..remove(id);
    state = Map.unmodifiable(next);
    await _service.delete(id);
  }

  Future<void> clearAll() async {
    state = const <String, CustomQuizQuestion>{};
    await _service.clearAll();
  }
}

final customQuizQuestionsProvider = StateNotifierProvider<
    CustomQuizQuestionsNotifier, Map<String, CustomQuizQuestion>>((ref) {
  return CustomQuizQuestionsNotifier(ref.watch(customQuizServiceProvider));
});
