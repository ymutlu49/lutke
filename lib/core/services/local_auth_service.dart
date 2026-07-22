import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Yerel Auth Servisi (Firebase'siz)
//
// Firebase yapılandırması tamamlanmadan kullanıcıların kayıt/giriş
// yapabilmesi için SharedPreferences-tabanlı basit bir yerel auth.
//
// Kayıt verisi cihazda saklanır (sunucu yok). Sahip email'i sabit
// (kOwnerEmailLocal) — yalnız UI pre-fill ve eşleştirme için kullanılır.
//
// İleride Firebase eklenince bu servis aşamalı olarak yerini
// gerçek auth'a bırakır.
// ════════════════════════════════════════════════════════════════

const String kOwnerEmailLocal = 'y.mutlu@alparslan.edu.tr';

// GÜVENLİK FIX (Tem 2026): Owner parolası eskiden düz metin const olarak
// buradaydı — Flutter web'de main.dart.js içine derlenip herkese açık
// servis ediliyordu (APK'da da grep'lenebilirdi). Artık parola SADECE
// derleme zamanında enjekte edilir:
//
//   flutter build web --dart-define=LUTKE_OWNER_LOCAL_PASSWORD=...
//
// Define verilmezse boş kalır → yerel/offline owner credential girişi
// devre dışıdır; owner tespiti Cloudflare JWT claim'i (isOwner, sunucudaki
// OWNER_EMAILS listesi) üzerinden çalışmaya devam eder. Yani normal
// (online) owner akışı bu define olmadan da tam çalışır.
const String _kOwnerPasswordLocal =
    String.fromEnvironment('LUTKE_OWNER_LOCAL_PASSWORD');

/// Yerel owner credential kontrolü — define boşsa HER ZAMAN false
/// (boş parola ile owner açılamaz).
bool _isOwnerCredentials(String cleanEmail, String password) =>
    _kOwnerPasswordLocal.isNotEmpty &&
    cleanEmail == kOwnerEmailLocal.toLowerCase() &&
    password == _kOwnerPasswordLocal;

class LocalAuthUser {
  final String email;
  final String displayName;
  final bool isOwner;
  final DateTime registeredAt;

  const LocalAuthUser({
    required this.email,
    required this.displayName,
    required this.isOwner,
    required this.registeredAt,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'isOwner': isOwner,
        'registeredAt': registeredAt.toIso8601String(),
      };

  factory LocalAuthUser.fromJson(Map<String, dynamic> json) => LocalAuthUser(
        email: json['email'] as String,
        displayName: json['displayName'] as String? ?? '',
        isOwner: json['isOwner'] as bool? ?? false,
        registeredAt: DateTime.tryParse(json['registeredAt'] as String? ?? '') ??
            DateTime.now(),
      );
}

class LocalAuthService {
  static const _userKey = 'lutke_local_user_v1';
  static const _passKey = 'lutke_local_pass_v1';

  Future<LocalAuthUser?> currentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_userKey);
      if (raw == null || raw.isEmpty) return null;
      return LocalAuthUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  /// Kayıt: email + şifre + isim → SharedPreferences'a yazar.
  /// Sahip email'i ile özel şifre eşleşirse `isOwner: true` döner.
  ///
  /// [serverVerifiedOwner]: Cloudflare login/signup SUNUCUDAN doğrulanmış
  /// isOwner claim'i döndürdüyse mirror akışı (register_screen._mirrorToLocal)
  /// bunu geçirebilir — yerel owner bayrağı gömülü parolaya gerek kalmadan
  /// sunucu kanıtıyla set edilir. null → eski davranış (credential kontrolü).
  ///
  /// BUG FIX: Önceden farklı bir e-postayla kayıt olmak mevcut kullanıcıyı
  /// sessizce siliyordu (aile üyesi tek cihazda hesap değiştiriyorsa diğer
  /// kişi kayboluyordu). Artık farklı e-posta kayıtlıysa Exception fırlatır —
  /// register_screen.dart bunu "Ev e-name berê hatiye tomarkirin" mesajına
  /// çevirir.
  Future<LocalAuthUser> register({
    required String email,
    required String password,
    required String displayName,
    bool? serverVerifiedOwner,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final isOwner =
        serverVerifiedOwner ?? _isOwnerCredentials(cleanEmail, password);

    // Owner tekrarı serbest — her zaman owner credential'ı ile girebilmeli.
    if (!isOwner) {
      final existing = await currentUser();
      if (existing != null && existing.email != cleanEmail) {
        // Farklı bir hesap cihazda kayıtlı — kullanıcıya "already exists"
        // mesajı gösterilecek.
        throw Exception(
          'exists: Bu cihazda farklı bir hesap açık. Önce "Derkeve" ile çıkış yap.',
        );
      }
    }

    final user = LocalAuthUser(
      email: cleanEmail,
      displayName: displayName.trim().isEmpty
          ? cleanEmail.split('@').first
          : displayName.trim(),
      isOwner: isOwner,
      registeredAt: DateTime.now(),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    // Şifreyi de saklayıp giriş kontrolü için tutuyoruz (yerel).
    // Üretim için bunu hash'leyip backend'e yazmak gerek.
    await prefs.setString(_passKey, password);

    return user;
  }

  /// Giriş: email + şifre kontrol eder.
  /// - Sahip credential'ları tam doğru (yalnız --dart-define enjekte
  ///   edildiyse mümkün) → owner
  /// - Daha önce kayıt olmuş herhangi bir email/şifre eşleşirse → kabul
  ///   (online owner girişi mirror'landıysa isOwner bayrağı kayıttan gelir)
  /// - Yoksa null
  Future<LocalAuthUser?> login({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    // Sahip kontrolü — define yoksa asla eşleşmez (bkz. _isOwnerCredentials).
    if (_isOwnerCredentials(cleanEmail, password)) {
      // Owner kaydı her zaman üret/güncelle
      return register(
        email: cleanEmail,
        password: password,
        displayName: 'Prof. Dr. Yılmaz Mutlu',
      );
    }

    // Mevcut kullanıcıyla eşleşme
    final stored = await currentUser();
    final prefs = await SharedPreferences.getInstance();
    final storedPass = prefs.getString(_passKey);

    if (stored != null &&
        stored.email == cleanEmail &&
        storedPass == password) {
      return stored;
    }

    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_passKey);
    // Oturum bağlı yerel state'i sil — farklı kullanıcı eski track ile
    // karşılaşmasın (gizlilik + UX tuzağı önleme).
    await prefs.remove('is_anonymous');
    await prefs.remove('learning_track_v1');
    await prefs.remove('child_onboarding_complete');
    await prefs.remove('onboarding_complete');
    await prefs.remove('is_child_mode');
    // BUG FIX: provider ile uyumlu anahtarlar — `learning_module_v1` yok,
    // gerçek anahtarlar `learning_module` ve `language_mode`.
    await prefs.remove('learning_module');
    await prefs.remove('language_mode');
    await prefs.remove('learning_module_v1');
    await prefs.remove('user_mode_preference_v1');
    await prefs.remove('streak_state');
    await prefs.remove('gamification_state');
    await prefs.remove('gamification_daily_xp_log');
    await prefs.remove('child_challenge_date');
    await prefs.remove('bizer_evolution_stars');
    await prefs.remove('review_weak_words');
    await prefs.remove('review_last_session');
    await prefs.remove('lutke_completed_activities');
    // BUG FIX: Placement level de oturum-bağlı — iki farklı kullanıcı aynı
    // cihazda kullanırsa önceki C1 yeni hesaba sızmasın.
    await prefs.remove('placement_level_ku');
    await prefs.remove('placement_level_en');
    // Motivation anchor da kişisel bir bilgi — temizlenmeli.
    await prefs.remove('motivation_anchor_name');
    // Skill XP temizliği
    for (final module in ['ku', 'en']) {
      for (final skill in ['grammar', 'writing', 'reading', 'listening',
          'speaking', 'quiz']) {
        await prefs.remove('skill_${module}_${skill}_completed');
        await prefs.remove('skill_${module}_${skill}_xp');
      }
    }
  }
}

// ── Riverpod providers ──────────────────────────────────────────

final localAuthServiceProvider =
    Provider<LocalAuthService>((_) => LocalAuthService());

/// Mevcut yerel kullanıcı (FutureProvider — uygulama açılışında okur).
final localCurrentUserProvider = FutureProvider<LocalAuthUser?>((ref) async {
  return ref.watch(localAuthServiceProvider).currentUser();
});

/// Sahip kontrolü — yerel auth'tan okur.
/// Firebase user.email yerine SharedPreferences'taki user.isOwner kullanılır.
final isOwnerLocalProvider = Provider<bool>((ref) {
  final asyncUser = ref.watch(localCurrentUserProvider);
  return asyncUser.maybeWhen(
    data: (user) => user?.isOwner ?? false,
    orElse: () => false,
  );
});

/// Login durumu — yerel auth varsa true.
final isLoggedInLocalProvider = Provider<bool>((ref) {
  final asyncUser = ref.watch(localCurrentUserProvider);
  return asyncUser.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});
