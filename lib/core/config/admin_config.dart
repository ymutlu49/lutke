import 'package:flutter/foundation.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Admin Config
//
// Owner ve reviewer email listesi.
// PRODUCTION ÖNERİSİ: Bu liste Firebase Remote Config veya Firestore
// /admin/owners ve /admin/reviewers koleksiyonlarından okunmalıdır.
// Şu an yapılandırma BUILD-TIME sabittir (--dart-define ile override
// edilebilir). Şifre/credential DEĞİL — yetki listesi.
//
// Güvenlik notu (Nisan 2026):
//   • Bu değerler APK'da görünür (reverse engineering ile çıkar).
//   • Ama YETKİLENDİRME server tarafında (Firebase Auth claims +
//     Firestore Security Rules) yapılır. Email listesi sadece
//     UI gating için kullanılır (admin panel butonu vs.).
//   • Yine de email'leri compile-time'a taşımak yerine Remote
//     Config kullanmak v2'de yapılmalı (TODO: server-side config).
// ════════════════════════════════════════════════════════════════

class AdminConfig {
  // ─── Sahipler (Owners) ────────────────────────────────────────
  // Yönetici: y.mutlu@alparslan.edu.tr
  // CI/CD'de override için: --dart-define=LUTKE_OWNER_EMAILS=a@x.com,b@y.com
  // Legacy --dart-define=LUTKE_OWNER_EMAIL=... hala desteklenir (tek owner).
  static const String _ownerListRaw = String.fromEnvironment(
    'LUTKE_OWNER_EMAILS',
    defaultValue: '',
  );
  static const String _legacyOwnerEmail = String.fromEnvironment(
    'LUTKE_OWNER_EMAIL',
    defaultValue: 'y.mutlu@alparslan.edu.tr',
  );

  /// Owner e-posta listesi (lowercase, normalize).
  static List<String> get ownerEmails {
    final raw = _ownerListRaw.isNotEmpty ? _ownerListRaw : _legacyOwnerEmail;
    return raw
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty && e.contains('@'))
        .toList();
  }

  /// Geriye uyumluluk: tek owner email (listenin ilki).
  static String get ownerEmail =>
      ownerEmails.isNotEmpty ? ownerEmails.first : '';

  // ─── Reviewer (Dil Uzmanı) — 10 slot ──────────────────────────
  // Production'da Firebase Remote Config'e alınmalı.
  // Şu anki halinde compile-time sabit, --dart-define ile virgüllü
  // bir liste verilirse parse edilir.
  static const String _reviewerListRaw = String.fromEnvironment(
    'LUTKE_REVIEWER_EMAILS',
    defaultValue: 'pispor1@lutke.app,pispor2@lutke.app,pispor3@lutke.app,'
        'pispor4@lutke.app,pispor5@lutke.app,pispor6@lutke.app,'
        'pispor7@lutke.app,pispor8@lutke.app,pispor9@lutke.app,'
        'pispor10@lutke.app',
  );

  /// Reviewer e-posta listesi (lowercase).
  static List<String> get reviewerEmails {
    return _reviewerListRaw
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty && e.contains('@'))
        .toList();
  }

  /// Verilen email sahip mi? (owner listesinde mi)
  static bool isOwner(String? email) {
    if (email == null) return false;
    return ownerEmails.contains(email.toLowerCase().trim());
  }

  /// Verilen email reviewer mı? (owner her zaman reviewer'dır)
  static bool isReviewer(String? email) {
    if (email == null) return false;
    final norm = email.toLowerCase().trim();
    if (isOwner(norm)) return true;
    return reviewerEmails.contains(norm);
  }

  // ─── Geliştirici diagnostic ─────────────────────────────────
  // Yalnızca debug build'de log atar — APK'a leak olmaz.
  static void logConfig() {
    if (!kDebugMode) return;
    debugPrint('AdminConfig: owners=${ownerEmails.join(",")}, '
        'reviewers=${reviewerEmails.length}');
  }
}
