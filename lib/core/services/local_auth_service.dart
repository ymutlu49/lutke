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
// Kayıt verisi cihazda saklanır (sunucu yok). Sahip email'i sabit:
//   y.mutlu@alparslan.edu.tr + ysfrns49 → owner privileges aktif
//
// İleride Firebase eklenince bu servis aşamalı olarak yerini
// gerçek auth'a bırakır.
// ════════════════════════════════════════════════════════════════

const String kOwnerEmailLocal = 'y.mutlu@alparslan.edu.tr';
const String kOwnerPasswordLocal = 'ysfrns49';

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
  Future<LocalAuthUser> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final isOwner = cleanEmail == kOwnerEmailLocal.toLowerCase() &&
        password == kOwnerPasswordLocal;

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
  /// - Sahip credential'ları tam doğru → owner
  /// - Daha önce kayıt olmuş herhangi bir email/şifre eşleşirse → kabul
  /// - Yoksa null
  Future<LocalAuthUser?> login({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    // Sahip kontrolü
    if (cleanEmail == kOwnerEmailLocal.toLowerCase() &&
        password == kOwnerPasswordLocal) {
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
