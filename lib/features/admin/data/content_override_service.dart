import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Runtime Kelime Overrides + CRUD (Content Override Service)
//
// Sahip kullanıcının uygulama içinden kelime metadata'larını düzenlemesine,
// yeni özel kelime eklemesine ve var olan kelimeleri gizlemesine olanak
// tanır. Derleme zorunlu değil — SharedPreferences'e yazılır, okuma
// anında `applyVocabulary()` tarafından merge edilir.
//
// Yalnızca KURMANCÎ kelime DB'lerine (a1..c2 + child_a1/a2) uygulanır.
// İngilizce DB'si ayrı bir iş akışı ile düzenlenir (bu fazda kapsam dışı).
//
// Kalıcı depolama (hepsi SharedPreferences):
//   - `content_overrides_v1`    : düzenlemeler (edit-only)
//   - `content_deleted_ids_v1`  : gizlenen kelime id'leri (soft-delete)
//   - `content_custom_words_v1` : kullanıcı-tanımlı yeni kelimeler
//
// Yapısal koruma (DIKKAT):
//   - Edit akışı: `id`, `ku`, `kat` SALT OKUNUR (ders/FSRS referansları)
//   - Delete akışı: Dersler silinen id'yi hedefliyorsa kart yumuşakça
//     atlanır (`debugPrint` uyarısıyla) — çökme yok.
// ════════════════════════════════════════════════════════════════

/// Tek bir kelime için opsiyonel override katmanı.
/// Sadece null-olmayan alanlar uygulanır; gerisi original DB'den okunur.
class WordOverride {
  final String? tr;
  final String? en;
  final String? not;
  final double? zor;
  final String? cins;
  final String? ez;

  const WordOverride({
    this.tr,
    this.en,
    this.not,
    this.zor,
    this.cins,
    this.ez,
  });

  bool get isEmpty =>
      tr == null && en == null && not == null && zor == null && cins == null && ez == null;

  bool get isNotEmpty => !isEmpty;

  Map<String, dynamic> toJson() => {
        if (tr != null) 'tr': tr,
        if (en != null) 'en': en,
        if (not != null) 'not': not,
        if (zor != null) 'zor': zor,
        if (cins != null) 'cins': cins,
        if (ez != null) 'ez': ez,
      };

  factory WordOverride.fromJson(Map<String, dynamic> j) => WordOverride(
        tr: j['tr'] as String?,
        en: j['en'] as String?,
        not: j['not'] as String?,
        zor: (j['zor'] is num) ? (j['zor'] as num).toDouble() : null,
        cins: j['cins'] as String?,
        ez: j['ez'] as String?,
      );

  /// Diğer override ile birleştir — diğerinin değerleri önceliklidir.
  WordOverride mergeWith(WordOverride other) => WordOverride(
        tr: other.tr ?? tr,
        en: other.en ?? en,
        not: other.not ?? not,
        zor: other.zor ?? zor,
        cins: other.cins ?? cins,
        ez: other.ez ?? ez,
      );
}

// ════════════════════════════════════════════════════════════════
// CUSTOM WORD — Sahip tarafından eklenen özel kelime
// ════════════════════════════════════════════════════════════════

/// Kullanıcı-tanımlı yeni Kurmancî kelime.
///
/// ID'ler `custom_` ön ekiyle üretilir (millis timestamp). Bu sayede:
/// - DB çakışmaları imkansız (DB id'leri a1_001, z_a1_002 vb.)
/// - applyVocabulary filtre/merge kolay tanıma
/// - Dersler içinde referans alındığında graceful handling mümkün
class CustomWord {
  final String id;      // 'custom_<millis>'
  final String ku;      // zorunlu
  final String tr;      // zorunlu
  final String en;      // boş olabilir
  final String cins;    // 'mê' | 'nêr' | 'bêcins'
  final String? ez;
  final String kat;     // kategori (ör. 'malbat', 'xwarin')
  final double zor;     // 0.0–1.0
  final String level;   // 'A1'..'C2' + 'CHILD_A1'|'CHILD_A2'
  final List<String> her;  // heritage örnek cümleler
  final List<String> gen;  // genel örnek cümleler

  const CustomWord({
    required this.id,
    required this.ku,
    required this.tr,
    this.en = '',
    this.cins = 'bêcins',
    this.ez,
    this.kat = 'custom',
    this.zor = 0.75,
    this.level = 'A1',
    this.her = const [],
    this.gen = const [],
  });

  /// Yeni ID üret — millis timestamp tabanlı, çakışma riski yok.
  static String newId() =>
      'custom_${DateTime.now().millisecondsSinceEpoch}';

  Map<String, dynamic> toJson() => {
        'id': id,
        'ku': ku,
        'tr': tr,
        'en': en,
        'cins': cins,
        if (ez != null) 'ez': ez,
        'kat': kat,
        'zor': zor,
        'level': level,
        'her': her,
        'gen': gen,
      };

  factory CustomWord.fromJson(Map<String, dynamic> j) => CustomWord(
        id: j['id'] as String,
        ku: (j['ku'] as String?) ?? '',
        tr: (j['tr'] as String?) ?? '',
        en: (j['en'] as String?) ?? '',
        cins: (j['cins'] as String?) ?? 'bêcins',
        ez: j['ez'] as String?,
        kat: (j['kat'] as String?) ?? 'custom',
        zor: (j['zor'] is num) ? (j['zor'] as num).toDouble() : 0.75,
        level: (j['level'] as String?) ?? 'A1',
        her: (j['her'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        gen: (j['gen'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      );

  CustomWord copyWith({
    String? ku,
    String? tr,
    String? en,
    String? cins,
    String? ez,
    String? kat,
    double? zor,
    String? level,
    List<String>? her,
    List<String>? gen,
  }) =>
      CustomWord(
        id: id,
        ku: ku ?? this.ku,
        tr: tr ?? this.tr,
        en: en ?? this.en,
        cins: cins ?? this.cins,
        ez: ez ?? this.ez,
        kat: kat ?? this.kat,
        zor: zor ?? this.zor,
        level: level ?? this.level,
        her: her ?? this.her,
        gen: gen ?? this.gen,
      );
}

// ════════════════════════════════════════════════════════════════
// KALICI DEPOLAMA (SharedPreferences)
// ════════════════════════════════════════════════════════════════

class ContentOverrideService {
  static const _kOverridesKey = 'content_overrides_v1';
  static const _kDeletedKey = 'content_deleted_ids_v1';
  static const _kCustomKey = 'content_custom_words_v1';

  // ── Edit overrides ─────────────────────────────────────────────

  Future<Map<String, WordOverride>> loadAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kOverridesKey);
      if (raw == null || raw.isEmpty) return <String, WordOverride>{};
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, WordOverride>{};
      final result = <String, WordOverride>{};
      decoded.forEach((k, v) {
        if (k is String && v is Map) {
          result[k] = WordOverride.fromJson(v.cast<String, dynamic>());
        }
      });
      return result;
    } catch (_) {
      return <String, WordOverride>{};
    }
  }

  Future<void> _persistOverrides(Map<String, WordOverride> all) async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    all.forEach((k, v) {
      if (v.isNotEmpty) map[k] = v.toJson();
    });
    await prefs.setString(_kOverridesKey, jsonEncode(map));
  }

  Future<void> save(String id, WordOverride override) async {
    final all = await loadAll();
    if (override.isEmpty) {
      all.remove(id);
    } else {
      all[id] = override;
    }
    await _persistOverrides(all);
  }

  Future<void> delete(String id) async {
    final all = await loadAll();
    all.remove(id);
    await _persistOverrides(all);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kOverridesKey);
  }

  // ── Soft-delete (gizlenen id'ler) ──────────────────────────────

  Future<Set<String>> loadDeletedIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_kDeletedKey);
      if (raw == null) return <String>{};
      return raw.toSet();
    } catch (_) {
      return <String>{};
    }
  }

  Future<void> saveDeletedIds(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kDeletedKey, ids.toList());
  }

  Future<void> addDeletedId(String id) async {
    final all = await loadDeletedIds();
    all.add(id);
    await saveDeletedIds(all);
  }

  Future<void> removeDeletedId(String id) async {
    final all = await loadDeletedIds();
    all.remove(id);
    await saveDeletedIds(all);
  }

  Future<void> clearDeletedIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kDeletedKey);
  }

  // ── Custom words ───────────────────────────────────────────────

  Future<Map<String, CustomWord>> loadCustomWords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kCustomKey);
      if (raw == null || raw.isEmpty) return <String, CustomWord>{};
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, CustomWord>{};
      final result = <String, CustomWord>{};
      decoded.forEach((k, v) {
        if (k is String && v is Map) {
          try {
            result[k] = CustomWord.fromJson(v.cast<String, dynamic>());
          } catch (_) {/* skip malformed */}
        }
      });
      return result;
    } catch (_) {
      return <String, CustomWord>{};
    }
  }

  Future<void> _persistCustomWords(Map<String, CustomWord> all) async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    all.forEach((k, v) => map[k] = v.toJson());
    await prefs.setString(_kCustomKey, jsonEncode(map));
  }

  Future<void> saveCustomWord(CustomWord w) async {
    final all = await loadCustomWords();
    all[w.id] = w;
    await _persistCustomWords(all);
  }

  Future<void> deleteCustomWord(String id) async {
    final all = await loadCustomWords();
    all.remove(id);
    await _persistCustomWords(all);
  }

  Future<void> clearCustomWords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kCustomKey);
  }
}

// ════════════════════════════════════════════════════════════════
// RIVERPOD PROVIDERS
// ════════════════════════════════════════════════════════════════

final contentOverrideServiceProvider =
    Provider<ContentOverrideService>((_) => ContentOverrideService());

// ── Edit overrides notifier ────────────────────────────────────

class ContentOverridesNotifier
    extends StateNotifier<Map<String, WordOverride>> {
  ContentOverridesNotifier(this._service)
      : super(const <String, WordOverride>{}) {
    _load();
  }

  final ContentOverrideService _service;

  Future<void> _load() async {
    final data = await _service.loadAll();
    if (!mounted) return;
    state = Map.unmodifiable(data);
  }

  Future<void> setOverride(String id, WordOverride v) async {
    // Optimistik: önce state'i güncelle, sonra kaydet (non-blocking UI).
    final next = Map<String, WordOverride>.from(state);
    if (v.isEmpty) {
      next.remove(id);
    } else {
      next[id] = v;
    }
    state = Map.unmodifiable(next);
    await _service.save(id, v);
  }

  Future<void> removeOverride(String id) async {
    final next = Map<String, WordOverride>.from(state)..remove(id);
    state = Map.unmodifiable(next);
    await _service.delete(id);
  }

  Future<void> clearAll() async {
    state = const <String, WordOverride>{};
    await _service.clearAll();
  }
}

final contentOverridesProvider = StateNotifierProvider<
    ContentOverridesNotifier, Map<String, WordOverride>>((ref) {
  return ContentOverridesNotifier(ref.watch(contentOverrideServiceProvider));
});

// ── Deleted ids notifier ──────────────────────────────────────

class DeletedWordIdsNotifier extends StateNotifier<Set<String>> {
  DeletedWordIdsNotifier(this._service) : super(const <String>{}) {
    _load();
  }

  final ContentOverrideService _service;

  Future<void> _load() async {
    final data = await _service.loadDeletedIds();
    if (!mounted) return;
    state = Set.unmodifiable(data);
  }

  Future<void> markDeleted(String id) async {
    if (state.contains(id)) return;
    final next = {...state, id};
    state = Set.unmodifiable(next);
    await _service.addDeletedId(id);
  }

  Future<void> restore(String id) async {
    if (!state.contains(id)) return;
    final next = {...state}..remove(id);
    state = Set.unmodifiable(next);
    await _service.removeDeletedId(id);
  }

  Future<void> clearAll() async {
    state = const <String>{};
    await _service.clearDeletedIds();
  }
}

final deletedWordIdsProvider =
    StateNotifierProvider<DeletedWordIdsNotifier, Set<String>>((ref) {
  return DeletedWordIdsNotifier(ref.watch(contentOverrideServiceProvider));
});

// ── Custom words notifier ─────────────────────────────────────

class CustomWordsNotifier extends StateNotifier<Map<String, CustomWord>> {
  CustomWordsNotifier(this._service) : super(const <String, CustomWord>{}) {
    _load();
  }

  final ContentOverrideService _service;

  Future<void> _load() async {
    final data = await _service.loadCustomWords();
    if (!mounted) return;
    state = Map.unmodifiable(data);
  }

  Future<void> saveWord(CustomWord w) async {
    final next = Map<String, CustomWord>.from(state);
    next[w.id] = w;
    state = Map.unmodifiable(next);
    await _service.saveCustomWord(w);
  }

  Future<void> deleteWord(String id) async {
    final next = Map<String, CustomWord>.from(state)..remove(id);
    state = Map.unmodifiable(next);
    await _service.deleteCustomWord(id);
  }

  Future<void> clearAll() async {
    state = const <String, CustomWord>{};
    await _service.clearCustomWords();
  }
}

final customWordsProvider = StateNotifierProvider<CustomWordsNotifier,
    Map<String, CustomWord>>((ref) {
  return CustomWordsNotifier(ref.watch(contentOverrideServiceProvider));
});

// ════════════════════════════════════════════════════════════════
// UYGULAMA YARDIMCILARI
// ════════════════════════════════════════════════════════════════

/// Raw kelime kaydına override uygular.
///
/// Not: Kaynak kayıt Dart `record` tipindedir; doğrudan kopyalayamayız.
/// Bunun yerine dinamik getter'ları olan bir sarmalayıcı (`_OverriddenWord`)
/// döndürürüz. Tüm mevcut UI çağrıları `w.ku as String` vb. şeklinde
/// `dynamic` üzerinden okuduğu için sarmalayıcı şeffaf biçimde çalışır.
///
/// `id`, `ku`, `kat` alanları asla değiştirilmez (yapısal alanlar).
/// Override yoksa raw kayıt olduğu gibi döner (alokasyon yok).
dynamic applyOverride(dynamic w, WordOverride? override) {
  if (override == null || override.isEmpty) return w;
  return _OverriddenWord(w, override);
}

/// CRUD-aware varyasyon: ham listeyi silinen id'lerden filtreler,
/// eşleşen edit override'larını uygular ve özel kelimeleri ekler.
///
/// Okuma hem geniş UI hem pure-service testleri için tek giriş noktası.
///
/// Filtre/merge mantığı:
///   1. Silinen id'ler atılır (custom_ dahil — kullanıcı tarafından
///      hem custom_ hem de DB id'lerini silebilir).
///   2. Kalan DB kayıtlarına edit override uygulanır.
///   3. Aynı level (+ opsiyonel kat) için custom kelimeler eklenir.
///
/// `level` parametresi `'A1'..'C2'` veya `'CHILD_A1'|'CHILD_A2'` şeklinde
/// olmalı (CustomWord.level ile birebir eşleşir).
List<dynamic> applyVocabulary(
  List<dynamic> rawList, {
  String? level,
  String? kat,
  Map<String, WordOverride> overrides = const <String, WordOverride>{},
  Set<String> deletedIds = const <String>{},
  Map<String, CustomWord> customWords = const <String, CustomWord>{},
}) {
  // 1) Silinenleri ele + override uygula
  final out = <dynamic>[];
  for (final w in rawList) {
    final id = w.id as String;
    if (deletedIds.contains(id)) continue;
    final o = overrides[id];
    out.add(o == null || o.isEmpty ? w : _OverriddenWord(w, o));
  }

  // 2) Custom kelimeler — level (+ kat) filtresi ile
  if (customWords.isNotEmpty && level != null) {
    for (final w in customWords.values) {
      if (deletedIds.contains(w.id)) continue;
      if (w.level != level) continue;
      if (kat != null && w.kat != kat) continue;
      out.add(_CustomWordWrapper(w));
    }
  }

  return out;
}

/// Dynamic-typed wrapper — raw record'a override katmanı bindirir.
/// Getter'lar `dynamic` döner: böylece `w.ku as String` gibi cast'ler
/// orijinal koddaki gibi çalışmaya devam eder.
class _OverriddenWord {
  final dynamic _raw;
  final WordOverride _o;
  const _OverriddenWord(this._raw, this._o);

  // Yapısal — değiştirilemez
  dynamic get id => _raw.id;
  dynamic get ku => _raw.ku;
  dynamic get kat => _raw.kat;

  // Düzenlenebilir alanlar
  dynamic get tr => _o.tr ?? _raw.tr;
  dynamic get en => _o.en ?? _raw.en;
  dynamic get not => _o.not ?? _raw.not;
  dynamic get zor => _o.zor ?? _raw.zor;
  dynamic get cins => _o.cins ?? _raw.cins;
  dynamic get ez => _o.ez ?? _raw.ez;

  // Pass-through (override kapsamı dışı)
  dynamic get her => _raw.her;
  dynamic get gen => _raw.gen;

  /// Çocuk DB'sinde `emoji` alanı mevcut — yetişkin DB'sinde yoktur.
  /// Çağrı yapıldığında sorunsuz iletmek için try/catch ile güvenli getter.
  dynamic get emoji {
    try {
      return (_raw as dynamic).emoji;
    } catch (_) {
      return null;
    }
  }
}

/// CustomWord'ü DB record şekline sarmalayan wrapper — mevcut UI
/// `w.ku as String` / `w.zor as double` vb. dinamik erişim kullanır.
/// Bu sınıf aynı API'yi sağlar, böylece tüketiciler özel kelimeyi
/// DB kaydı gibi görür.
class _CustomWordWrapper {
  final CustomWord _w;
  const _CustomWordWrapper(this._w);

  String get id => _w.id;
  String get ku => _w.ku;
  String get tr => _w.tr;
  String get en => _w.en;
  String get cins => _w.cins;
  String? get ez => _w.ez;
  String get kat => _w.kat;
  double get zor => _w.zor;
  String? get not => null;
  List<String> get her => _w.her;
  List<String> get gen => _w.gen;
  String? get emoji => null;
}

/// Verilen id'nin `custom_` ön ekli olup olmadığını söyler.
bool isCustomWordId(String id) => id.startsWith('custom_');

/// Bir id'nin silinmiş/eksik kart olduğunu debugPrint ile bildir.
/// (Dersler silinen id'ye referans verirse UI'da kart atlanır.)
/// Production: debug log atlanır (kDebugMode guard).
void warnMissingCardId(String lessonId, String cardId) {
  if (kDebugMode) {
    debugPrint(
        '[LessonOverride] Lesson "$lessonId" references missing card "$cardId" — skipping.');
  }
}
