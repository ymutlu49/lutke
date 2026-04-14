import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Yönetici Hata Notları (Admin Note Repository)
//
// Sahip kullanıcı uygulama içinde gezerken karşılaştığı her türlü
// soruna anında not düşebilir. Notlar SharedPreferences'a yazılır,
// uygulama yeniden başlatılınca da kalır.
//
// Notlar admin panelinde liste şeklinde görülür:
//   - Düzenle / sil / "fixed" işaretle
//   - JSON olarak kopyala (developer kalıcı koda taşır)
//
// NOT: Bu yerel bir tutucudur — Firebase backend yok. Notlar
// yalnızca o cihazda durur. JSON export ile aktarılır.
// ════════════════════════════════════════════════════════════════

enum AdminNoteCategory {
  word,         // Kelime hatası (yanlış çeviri, eksik emoji, vb.)
  question,     // Quiz/etkinlik sorusu hatası
  ui,           // Arayüz/tasarım sorunu
  translation,  // Çeviri/dilbilgisi hatası
  feature,      // Yeni özellik isteği
  other,        // Diğer
}

extension AdminNoteCategoryX on AdminNoteCategory {
  String get labelKu => switch (this) {
        AdminNoteCategory.word => 'Peyv',
        AdminNoteCategory.question => 'Pirs',
        AdminNoteCategory.ui => 'Dîmen',
        AdminNoteCategory.translation => 'Werger',
        AdminNoteCategory.feature => 'Taybetmendî',
        AdminNoteCategory.other => 'Yên din',
      };

  String get emoji => switch (this) {
        AdminNoteCategory.word => '🔤',
        AdminNoteCategory.question => '❓',
        AdminNoteCategory.ui => '🎨',
        AdminNoteCategory.translation => '🌐',
        AdminNoteCategory.feature => '💡',
        AdminNoteCategory.other => '📝',
      };
}

enum AdminNoteStatus { open, fixed, ignored }

extension AdminNoteStatusX on AdminNoteStatus {
  String get labelKu => switch (this) {
        AdminNoteStatus.open => 'Vekirî',
        AdminNoteStatus.fixed => 'Çareser',
        AdminNoteStatus.ignored => 'Paş de',
      };
}

class AdminNote {
  final String id;
  final DateTime created;
  final AdminNoteCategory category;
  final String route;       // hangi ekrandan açıldı (ör. /home/quiz)
  final String? context;    // ek bağlam (kelime id, soru numarası, vb.)
  final String message;     // sahibin yazdığı not
  final AdminNoteStatus status;

  const AdminNote({
    required this.id,
    required this.created,
    required this.category,
    required this.route,
    this.context,
    required this.message,
    this.status = AdminNoteStatus.open,
  });

  AdminNote copyWith({
    AdminNoteStatus? status,
    String? message,
  }) =>
      AdminNote(
        id: id,
        created: created,
        category: category,
        route: route,
        context: context,
        message: message ?? this.message,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created': created.toIso8601String(),
        'category': category.name,
        'route': route,
        'context': context,
        'message': message,
        'status': status.name,
      };

  factory AdminNote.fromJson(Map<String, dynamic> json) => AdminNote(
        id: json['id'] as String,
        created: DateTime.parse(json['created'] as String),
        category: AdminNoteCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => AdminNoteCategory.other,
        ),
        route: json['route'] as String,
        context: json['context'] as String?,
        message: json['message'] as String,
        status: AdminNoteStatus.values.firstWhere(
          (s) => s.name == json['status'],
          orElse: () => AdminNoteStatus.open,
        ),
      );
}

class AdminNoteRepository {
  static const _key = 'lutke_admin_notes_v1';

  Future<List<AdminNote>> loadAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return [];
      final list = jsonDecode(raw) as List;
      return list
          .map((e) => AdminNote.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveAll(List<AdminNote> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final list = notes.map((n) => n.toJson()).toList();
    await prefs.setString(_key, jsonEncode(list));
  }

  Future<void> add(AdminNote note) async {
    final all = await loadAll();
    all.insert(0, note); // En yeni başa
    await _saveAll(all);
  }

  Future<void> update(AdminNote updated) async {
    final all = await loadAll();
    final idx = all.indexWhere((n) => n.id == updated.id);
    if (idx >= 0) {
      all[idx] = updated;
      await _saveAll(all);
    }
  }

  Future<void> delete(String id) async {
    final all = await loadAll();
    all.removeWhere((n) => n.id == id);
    await _saveAll(all);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// Notları JSON formatında dışarı aktar — developer'a kopyalanır.
  Future<String> exportJson() async {
    final all = await loadAll();
    return const JsonEncoder.withIndent('  ')
        .convert(all.map((n) => n.toJson()).toList());
  }
}

// ── Riverpod providers ──────────────────────────────────────────

final adminNoteRepositoryProvider =
    Provider<AdminNoteRepository>((_) => AdminNoteRepository());

/// Tüm notlar (FutureProvider — her okuma yeniler).
final adminNotesProvider = FutureProvider<List<AdminNote>>((ref) async {
  return ref.watch(adminNoteRepositoryProvider).loadAll();
});

/// Notları yenilemek için trigger — refresh sonrası invalidate edilebilir.
final notesRefreshProvider = StateProvider<int>((_) => 0);
