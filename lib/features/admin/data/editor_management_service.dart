import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/admin_config.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Editor (Reviewer/Sub-editor) Management
//
// Owner, kendi altında çalışacak alt-editörleri (reviewer) ekleyebilir,
// rolleri belirleyebilir, kaldırabilir.
//
// Production: bu liste Firebase Firestore /admin/reviewers koleksiyonu
// olmalı (server-side enforcement). Şu anki MVP: SharedPreferences'a
// yazılır + AdminConfig.reviewerEmails (build-time) ile birleşir.
//
// Yapı:
//   - AdminConfig.reviewerEmails (compile-time, immutable)
//   - +  SharedPreferences listesi (runtime, owner-yönetimli)
//   = Aktif reviewer havuzu
//
// Veri:
//   {
//     "email": "ahmed@kurd.org",
//     "displayName": "Ahmed Karîb",
//     "role": "translator|content|reviewer",
//     "addedAt": "2026-04-25T17:00Z"
//   }
// ════════════════════════════════════════════════════════════════

enum EditorRole {
  translator,   // Tirkî/Kurmancî werger
  content,      // Naveroka çandî edîtor
  reviewer,     // Giştî kontrolê dike
}

extension EditorRoleX on EditorRole {
  String get labelKu => switch (this) {
        EditorRole.translator => 'Wergêr',
        EditorRole.content => 'Edîtorê Naverokê',
        EditorRole.reviewer => 'Pispor (giştî)',
      };

  String get labelTr => switch (this) {
        EditorRole.translator => 'Çevirmen',
        EditorRole.content => 'İçerik Editörü',
        EditorRole.reviewer => 'Genel Uzman',
      };

  String get code => switch (this) {
        EditorRole.translator => 'translator',
        EditorRole.content => 'content',
        EditorRole.reviewer => 'reviewer',
      };

  static EditorRole fromCode(String? c) => switch (c) {
        'translator' => EditorRole.translator,
        'content' => EditorRole.content,
        _ => EditorRole.reviewer,
      };
}

class SubEditor {
  final String email;
  final String displayName;
  final EditorRole role;
  final DateTime addedAt;
  final bool fromConfig; // true: AdminConfig'ten, salt-okunur

  const SubEditor({
    required this.email,
    required this.displayName,
    required this.role,
    required this.addedAt,
    this.fromConfig = false,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'role': role.code,
        'addedAt': addedAt.toIso8601String(),
      };

  factory SubEditor.fromJson(Map<String, dynamic> j) => SubEditor(
        email: (j['email'] as String? ?? '').toLowerCase().trim(),
        displayName: j['displayName'] as String? ?? '',
        role: EditorRoleX.fromCode(j['role'] as String?),
        addedAt:
            DateTime.tryParse(j['addedAt'] as String? ?? '') ?? DateTime.now(),
      );

  SubEditor copyWith({
    String? email,
    String? displayName,
    EditorRole? role,
  }) =>
      SubEditor(
        email: (email ?? this.email).toLowerCase().trim(),
        displayName: displayName ?? this.displayName,
        role: role ?? this.role,
        addedAt: addedAt,
        fromConfig: fromConfig,
      );
}

// ════════════════════════════════════════════════════════════════
// Service
// ════════════════════════════════════════════════════════════════

class EditorManagementService {
  static const _kEditorsKey = 'admin_sub_editors_v1';

  Future<List<SubEditor>> loadCustom() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kEditorsKey);
      if (raw == null || raw.isEmpty) return <SubEditor>[];
      final decoded = jsonDecode(raw);
      if (decoded is! List) return <SubEditor>[];
      return decoded
          .whereType<Map>()
          .map((e) => SubEditor.fromJson(e.cast<String, dynamic>()))
          .toList();
    } catch (_) {
      return <SubEditor>[];
    }
  }

  Future<void> _saveCustom(List<SubEditor> list) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(list.map((e) => e.toJson()).toList());
    await prefs.setString(_kEditorsKey, json);
  }

  Future<void> addEditor(SubEditor editor) async {
    final all = await loadCustom();
    // Aynı email varsa güncelle, yoksa ekle.
    final idx = all.indexWhere((e) => e.email == editor.email);
    if (idx >= 0) {
      all[idx] = editor;
    } else {
      all.add(editor);
    }
    await _saveCustom(all);
  }

  Future<void> removeEditor(String email) async {
    final all = await loadCustom();
    all.removeWhere((e) => e.email == email.toLowerCase().trim());
    await _saveCustom(all);
  }

  /// AdminConfig'ten gelen + custom liste birleşir.
  Future<List<SubEditor>> loadAll() async {
    final custom = await loadCustom();
    final fromConfig = <SubEditor>[
      for (final email in AdminConfig.reviewerEmails)
        SubEditor(
          email: email,
          displayName: email.split('@').first,
          role: EditorRole.reviewer,
          addedAt: DateTime(2026, 1, 1),
          fromConfig: true,
        ),
    ];
    // custom'dakiler config'tekileri override eder (display name, role).
    final byEmail = <String, SubEditor>{
      for (final e in fromConfig) e.email: e,
    };
    for (final c in custom) {
      byEmail[c.email] = c;
    }
    final out = byEmail.values.toList()
      ..sort((a, b) => a.email.compareTo(b.email));
    return out;
  }
}

final editorManagementServiceProvider =
    Provider<EditorManagementService>((_) => EditorManagementService());

class SubEditorsNotifier extends StateNotifier<List<SubEditor>> {
  SubEditorsNotifier(this._service) : super(const <SubEditor>[]) {
    _load();
  }

  final EditorManagementService _service;

  Future<void> _load() async {
    final data = await _service.loadAll();
    if (!mounted) return;
    state = List.unmodifiable(data);
  }

  Future<void> add(SubEditor editor) async {
    await _service.addEditor(editor);
    await _load();
  }

  Future<void> remove(String email) async {
    await _service.removeEditor(email);
    await _load();
  }

  Future<void> reload() => _load();
}

final subEditorsProvider =
    StateNotifierProvider<SubEditorsNotifier, List<SubEditor>>((ref) {
  return SubEditorsNotifier(ref.watch(editorManagementServiceProvider));
});
