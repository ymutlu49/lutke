import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cultural_content/cultural_entities.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Cultural Content Override Service
//
// Çand sayfasındaki tüm CulturalItem içeriklerini (atasözü, destan,
// sanatçı, yemek, bayram, halay, mimari, helbest/stran metni)
// uygulama içinden derleme gerektirmeden düzenler.
//
// Aynı pattern olarak content_override_service (kelime) için
// kullanılır:
//   - Edit override (mevcut item'ı kısmî değiştirme)
//   - Soft-delete (gizlenen item ID'leri)
//   - Custom item (yeni kullanıcı-tanımlı CulturalItem)
//
// Yapısal koruma:
//   - id, type, unitId: salt-okunur (referans bütünlüğü).
//   - kurmanjTitle, turkishTitle, kurmanjContent, turkishContent,
//     backgroundNote, level, keywords: editable.
//
// Persistence (SharedPreferences):
//   - cultural_overrides_v1
//   - cultural_deleted_ids_v1
//   - cultural_custom_items_v1
// ════════════════════════════════════════════════════════════════

/// CulturalItem için kısmi override. Sadece null-olmayan alanlar
/// uygulanır; gerisi orijinalden okunur.
class CulturalOverride {
  final String? kurmanjTitle;
  final String? turkishTitle;
  final String? kurmanjContent;
  final String? turkishContent;
  final String? backgroundNote;
  final int? level;
  final List<String>? keywords;

  const CulturalOverride({
    this.kurmanjTitle,
    this.turkishTitle,
    this.kurmanjContent,
    this.turkishContent,
    this.backgroundNote,
    this.level,
    this.keywords,
  });

  bool get isEmpty =>
      kurmanjTitle == null &&
      turkishTitle == null &&
      kurmanjContent == null &&
      turkishContent == null &&
      backgroundNote == null &&
      level == null &&
      keywords == null;

  bool get isNotEmpty => !isEmpty;

  Map<String, dynamic> toJson() => {
        if (kurmanjTitle != null) 'kurmanjTitle': kurmanjTitle,
        if (turkishTitle != null) 'turkishTitle': turkishTitle,
        if (kurmanjContent != null) 'kurmanjContent': kurmanjContent,
        if (turkishContent != null) 'turkishContent': turkishContent,
        if (backgroundNote != null) 'backgroundNote': backgroundNote,
        if (level != null) 'level': level,
        if (keywords != null) 'keywords': keywords,
      };

  factory CulturalOverride.fromJson(Map<String, dynamic> j) =>
      CulturalOverride(
        kurmanjTitle: j['kurmanjTitle'] as String?,
        turkishTitle: j['turkishTitle'] as String?,
        kurmanjContent: j['kurmanjContent'] as String?,
        turkishContent: j['turkishContent'] as String?,
        backgroundNote: j['backgroundNote'] as String?,
        level: j['level'] as int?,
        keywords: (j['keywords'] as List?)
            ?.map((e) => e.toString())
            .toList(),
      );

  CulturalOverride copyWith({
    String? kurmanjTitle,
    String? turkishTitle,
    String? kurmanjContent,
    String? turkishContent,
    String? backgroundNote,
    int? level,
    List<String>? keywords,
  }) =>
      CulturalOverride(
        kurmanjTitle: kurmanjTitle ?? this.kurmanjTitle,
        turkishTitle: turkishTitle ?? this.turkishTitle,
        kurmanjContent: kurmanjContent ?? this.kurmanjContent,
        turkishContent: turkishContent ?? this.turkishContent,
        backgroundNote: backgroundNote ?? this.backgroundNote,
        level: level ?? this.level,
        keywords: keywords ?? this.keywords,
      );
}

// ════════════════════════════════════════════════════════════════
// CUSTOM CULTURAL ITEM — Kullanıcı-tanımlı yeni içerik
// ════════════════════════════════════════════════════════════════

/// Kullanıcı tarafından eklenen yeni CulturalItem.
/// ID 'ccustom_<millis>' format ile; DB id'leri ile çakışmaz.
class CustomCulturalItem {
  final String id; // 'ccustom_<millis>'
  final CulturalContentType type;
  final String kurmanjTitle;
  final String turkishTitle;
  final String kurmanjContent;
  final String turkishContent;
  final String? backgroundNote;
  final int level;
  final String unitId;
  final List<String> keywords;

  const CustomCulturalItem({
    required this.id,
    required this.type,
    required this.kurmanjTitle,
    required this.turkishTitle,
    required this.kurmanjContent,
    required this.turkishContent,
    this.backgroundNote,
    this.level = 2,
    this.unitId = 'custom',
    this.keywords = const [],
  });

  static String newId() =>
      'ccustom_${DateTime.now().millisecondsSinceEpoch}';

  /// CulturalItem'a dönüştür (UI tarafı her zaman CulturalItem ile
  /// çalışır).
  CulturalItem toCulturalItem() => CulturalItem(
        id: id,
        type: type,
        kurmanjTitle: kurmanjTitle,
        turkishTitle: turkishTitle,
        kurmanjContent: kurmanjContent,
        turkishContent: turkishContent,
        backgroundNote: backgroundNote,
        level: level,
        unitId: unitId,
        keywords: keywords,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'kurmanjTitle': kurmanjTitle,
        'turkishTitle': turkishTitle,
        'kurmanjContent': kurmanjContent,
        'turkishContent': turkishContent,
        if (backgroundNote != null) 'backgroundNote': backgroundNote,
        'level': level,
        'unitId': unitId,
        'keywords': keywords,
      };

  factory CustomCulturalItem.fromJson(Map<String, dynamic> j) {
    final typeName = j['type'] as String? ?? 'proverb';
    final type = CulturalContentType.values.firstWhere(
      (t) => t.name == typeName,
      orElse: () => CulturalContentType.proverb,
    );
    return CustomCulturalItem(
      id: j['id'] as String,
      type: type,
      kurmanjTitle: (j['kurmanjTitle'] as String?) ?? '',
      turkishTitle: (j['turkishTitle'] as String?) ?? '',
      kurmanjContent: (j['kurmanjContent'] as String?) ?? '',
      turkishContent: (j['turkishContent'] as String?) ?? '',
      backgroundNote: j['backgroundNote'] as String?,
      level: (j['level'] as int?) ?? 2,
      unitId: (j['unitId'] as String?) ?? 'custom',
      keywords: (j['keywords'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  CustomCulturalItem copyWith({
    CulturalContentType? type,
    String? kurmanjTitle,
    String? turkishTitle,
    String? kurmanjContent,
    String? turkishContent,
    String? backgroundNote,
    int? level,
    String? unitId,
    List<String>? keywords,
  }) =>
      CustomCulturalItem(
        id: id,
        type: type ?? this.type,
        kurmanjTitle: kurmanjTitle ?? this.kurmanjTitle,
        turkishTitle: turkishTitle ?? this.turkishTitle,
        kurmanjContent: kurmanjContent ?? this.kurmanjContent,
        turkishContent: turkishContent ?? this.turkishContent,
        backgroundNote: backgroundNote ?? this.backgroundNote,
        level: level ?? this.level,
        unitId: unitId ?? this.unitId,
        keywords: keywords ?? this.keywords,
      );
}

bool isCustomCulturalId(String id) => id.startsWith('ccustom_');

// ════════════════════════════════════════════════════════════════
// Persistent storage
// ════════════════════════════════════════════════════════════════

class CulturalContentOverrideService {
  static const _kOverridesKey = 'cultural_overrides_v1';
  static const _kDeletedKey = 'cultural_deleted_ids_v1';
  static const _kCustomKey = 'cultural_custom_items_v1';

  // ── Overrides ──────────────────────────────────────────────

  Future<Map<String, CulturalOverride>> loadAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kOverridesKey);
      if (raw == null || raw.isEmpty) return <String, CulturalOverride>{};
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, CulturalOverride>{};
      final result = <String, CulturalOverride>{};
      decoded.forEach((k, v) {
        if (k is String && v is Map) {
          result[k] =
              CulturalOverride.fromJson(v.cast<String, dynamic>());
        }
      });
      return result;
    } catch (_) {
      return <String, CulturalOverride>{};
    }
  }

  Future<void> _persistOverrides(Map<String, CulturalOverride> all) async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    all.forEach((k, v) {
      if (v.isNotEmpty) map[k] = v.toJson();
    });
    await prefs.setString(_kOverridesKey, jsonEncode(map));
  }

  Future<void> save(String id, CulturalOverride override) async {
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

  // ── Soft-delete ────────────────────────────────────────────

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

  // ── Custom items ───────────────────────────────────────────

  Future<Map<String, CustomCulturalItem>> loadCustom() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kCustomKey);
      if (raw == null || raw.isEmpty) {
        return <String, CustomCulturalItem>{};
      }
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return <String, CustomCulturalItem>{};
      final result = <String, CustomCulturalItem>{};
      decoded.forEach((k, v) {
        if (k is String && v is Map) {
          try {
            result[k] = CustomCulturalItem.fromJson(
                v.cast<String, dynamic>());
          } catch (_) {/* skip malformed */}
        }
      });
      return result;
    } catch (_) {
      return <String, CustomCulturalItem>{};
    }
  }

  Future<void> _persistCustom(Map<String, CustomCulturalItem> all) async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    all.forEach((k, v) => map[k] = v.toJson());
    await prefs.setString(_kCustomKey, jsonEncode(map));
  }

  Future<void> saveCustom(CustomCulturalItem item) async {
    final all = await loadCustom();
    all[item.id] = item;
    await _persistCustom(all);
  }

  Future<void> deleteCustom(String id) async {
    final all = await loadCustom();
    all.remove(id);
    await _persistCustom(all);
  }

  Future<void> clearCustom() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kCustomKey);
  }

  // ── Tüm değişiklikleri sıfırla ─────────────────────────────
  Future<void> clearEverything() async {
    await clearAll();
    await clearDeletedIds();
    await clearCustom();
  }

  // ── JSON export / import ───────────────────────────────────

  Future<String> exportJson() async {
    final overrides = await loadAll();
    final deleted = await loadDeletedIds();
    final custom = await loadCustom();
    return jsonEncode({
      'version': 1,
      'overrides':
          overrides.map((k, v) => MapEntry(k, v.toJson())),
      'deletedIds': deleted.toList(),
      'customItems':
          custom.map((k, v) => MapEntry(k, v.toJson())),
    });
  }

  /// JSON içeriği yükler (verilmiş içeriği SharedPreferences'a yazar).
  /// Geriye yüklenen kayıt sayılarını döner: (overrides, deleted, custom).
  Future<({int overrides, int deleted, int custom})> importJson(
      String jsonStr) async {
    final decoded = jsonDecode(jsonStr);
    if (decoded is! Map) {
      throw const FormatException('Invalid JSON: expected object');
    }
    int oCount = 0, dCount = 0, cCount = 0;

    // Overrides
    final overridesMap = decoded['overrides'];
    if (overridesMap is Map) {
      final all = <String, CulturalOverride>{};
      overridesMap.forEach((k, v) {
        if (k is String && v is Map) {
          all[k] = CulturalOverride.fromJson(v.cast<String, dynamic>());
        }
      });
      await _persistOverrides(all);
      oCount = all.length;
    }

    // Deleted
    final deletedList = decoded['deletedIds'];
    if (deletedList is List) {
      final ids = deletedList.map((e) => e.toString()).toSet();
      await saveDeletedIds(ids);
      dCount = ids.length;
    }

    // Custom
    final customMap = decoded['customItems'];
    if (customMap is Map) {
      final all = <String, CustomCulturalItem>{};
      customMap.forEach((k, v) {
        if (k is String && v is Map) {
          try {
            all[k] = CustomCulturalItem.fromJson(
                v.cast<String, dynamic>());
          } catch (_) {/* skip malformed */}
        }
      });
      await _persistCustom(all);
      cCount = all.length;
    }

    return (overrides: oCount, deleted: dCount, custom: cCount);
  }
}

// ════════════════════════════════════════════════════════════════
// RIVERPOD PROVIDERS
// ════════════════════════════════════════════════════════════════

final culturalContentOverrideServiceProvider =
    Provider<CulturalContentOverrideService>(
  (_) => CulturalContentOverrideService(),
);

class CulturalOverridesNotifier
    extends StateNotifier<Map<String, CulturalOverride>> {
  CulturalOverridesNotifier(this._service)
      : super(const <String, CulturalOverride>{}) {
    _load();
  }

  final CulturalContentOverrideService _service;

  Future<void> _load() async {
    final data = await _service.loadAll();
    if (!mounted) return;
    state = Map.unmodifiable(data);
  }

  Future<void> setOverride(String id, CulturalOverride v) async {
    final next = Map<String, CulturalOverride>.from(state);
    if (v.isEmpty) {
      next.remove(id);
    } else {
      next[id] = v;
    }
    state = Map.unmodifiable(next);
    await _service.save(id, v);
  }

  Future<void> removeOverride(String id) async {
    final next = Map<String, CulturalOverride>.from(state)..remove(id);
    state = Map.unmodifiable(next);
    await _service.delete(id);
  }

  Future<void> clearAll() async {
    state = const <String, CulturalOverride>{};
    await _service.clearAll();
  }

  Future<void> reload() => _load();
}

final culturalOverridesProvider = StateNotifierProvider<
    CulturalOverridesNotifier, Map<String, CulturalOverride>>((ref) {
  return CulturalOverridesNotifier(
      ref.watch(culturalContentOverrideServiceProvider));
});

class DeletedCulturalIdsNotifier extends StateNotifier<Set<String>> {
  DeletedCulturalIdsNotifier(this._service) : super(const <String>{}) {
    _load();
  }

  final CulturalContentOverrideService _service;

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

  Future<void> reload() => _load();
}

final deletedCulturalIdsProvider = StateNotifierProvider<
    DeletedCulturalIdsNotifier, Set<String>>((ref) {
  return DeletedCulturalIdsNotifier(
      ref.watch(culturalContentOverrideServiceProvider));
});

class CustomCulturalItemsNotifier
    extends StateNotifier<Map<String, CustomCulturalItem>> {
  CustomCulturalItemsNotifier(this._service)
      : super(const <String, CustomCulturalItem>{}) {
    _load();
  }

  final CulturalContentOverrideService _service;

  Future<void> _load() async {
    final data = await _service.loadCustom();
    if (!mounted) return;
    state = Map.unmodifiable(data);
  }

  Future<void> saveItem(CustomCulturalItem w) async {
    final next = Map<String, CustomCulturalItem>.from(state);
    next[w.id] = w;
    state = Map.unmodifiable(next);
    await _service.saveCustom(w);
  }

  Future<void> deleteItem(String id) async {
    final next = Map<String, CustomCulturalItem>.from(state)..remove(id);
    state = Map.unmodifiable(next);
    await _service.deleteCustom(id);
  }

  Future<void> clearAll() async {
    state = const <String, CustomCulturalItem>{};
    await _service.clearCustom();
  }

  Future<void> reload() => _load();
}

final customCulturalItemsProvider = StateNotifierProvider<
    CustomCulturalItemsNotifier,
    Map<String, CustomCulturalItem>>((ref) {
  return CustomCulturalItemsNotifier(
      ref.watch(culturalContentOverrideServiceProvider));
});

// ════════════════════════════════════════════════════════════════
// APPLY HELPERS — UI'da raw listeyi düzenlenmiş haliyle döndürür
// ════════════════════════════════════════════════════════════════

/// Tek bir CulturalItem'a override uygular.
CulturalItem applyCulturalOverride(
  CulturalItem item,
  CulturalOverride? override,
) {
  if (override == null || override.isEmpty) return item;
  return CulturalItem(
    id: item.id,
    type: item.type,
    kurmanjTitle: override.kurmanjTitle ?? item.kurmanjTitle,
    turkishTitle: override.turkishTitle ?? item.turkishTitle,
    kurmanjContent: override.kurmanjContent ?? item.kurmanjContent,
    turkishContent: override.turkishContent ?? item.turkishContent,
    audioAsset: item.audioAsset,
    backgroundNote: override.backgroundNote ?? item.backgroundNote,
    level: override.level ?? item.level,
    unitId: item.unitId,
    keywords: override.keywords ?? item.keywords,
  );
}

/// Ham CulturalItem listesine; soft-delete + override + custom item
/// uygular ve düzenli liste döner.
List<CulturalItem> applyCulturalContent(
  List<CulturalItem> rawList, {
  Map<String, CulturalOverride> overrides = const <String, CulturalOverride>{},
  Set<String> deletedIds = const <String>{},
  Map<String, CustomCulturalItem> customItems =
      const <String, CustomCulturalItem>{},
}) {
  final out = <CulturalItem>[];
  for (final item in rawList) {
    if (deletedIds.contains(item.id)) continue;
    final o = overrides[item.id];
    out.add(applyCulturalOverride(item, o));
  }
  for (final c in customItems.values) {
    if (deletedIds.contains(c.id)) continue;
    out.add(c.toCulturalItem());
  }
  return out;
}
