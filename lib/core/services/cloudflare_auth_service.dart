import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// CLOUDFLARE AUTH SERVICE — LÛTKE
//
// Cloudflare Pages Functions backend ile çalışır.
// Endpoint'ler:
//   POST /api/auth/signup
//   POST /api/auth/login
//   POST /api/auth/verify-email
//   POST /api/auth/resend-verification
//   POST /api/auth/request-password-reset
//   POST /api/auth/reset-password
//   GET  /api/auth/me
//   GET  /api/admin/stats   (owner only)
//
// JWT token: SharedPreferences'ta saklanır (key: 'cf_auth_token')
// User profili: SharedPreferences cache (key: 'cf_auth_user')
// ════════════════════════════════════════════════════════════════

const String _kAuthTokenKey = 'cf_auth_token';
const String _kAuthUserKey = 'cf_auth_user';

/// Track-bazlı placement prefs anahtarları — TEK kaynak burası.
/// placement_test_screen.dart `placementLevelKeyFor` bu sabitleri kullanır.
/// Login/me sonrası hesaptaki seviyeler bu anahtarlara senkronlanır
/// (cihaz/tarayıcı değişiminde localStorage otomatik dolar).
const String kPlacementLevelKeyKu = 'placement_level_ku';
const String kPlacementLevelKeyEn = 'placement_level_en';

/// API base URL — production'da lutke.app, debug'da overridable.
String _apiBase() {
  // --dart-define=LUTKE_API_BASE=https://staging.lutke.app
  const fromDefine = String.fromEnvironment('LUTKE_API_BASE', defaultValue: '');
  if (fromDefine.isNotEmpty) return fromDefine;
  if (kIsWeb) {
    // Same-origin in production. Browser absolute URL.
    return Uri.base.origin;
  }
  // Mobile: production by default
  return 'https://lutke.app';
}

class CloudflareUser {
  final String id;
  final String email;
  final String? displayName;
  final bool emailVerified;
  final bool isOwner;
  final String? currentLevel;
  final String? targetLevel;
  final bool isHeritage;
  final int dailyGoal;
  final String?
      placementLevel; // null = Kurmancî düzey testi yapılmadı → test gösterilir
  final String?
      placementLevelEn; // null = İngilizce düzey testi yapılmadı (track-bazlı)

  const CloudflareUser({
    required this.id,
    required this.email,
    this.displayName,
    required this.emailVerified,
    required this.isOwner,
    this.currentLevel,
    this.targetLevel,
    this.isHeritage = false,
    this.dailyGoal = 10,
    this.placementLevel,
    this.placementLevelEn,
  });

  /// Hesapta KURMANCÎ düzey testi tamamlanmış mı? (geriye uyumlu — eski
  /// çağıranlar için KU anlamı korunur; track-duyarlı kontrol için
  /// [hasPlacementFor] kullan.)
  bool get hasPlacement => placementLevel != null && placementLevel!.isNotEmpty;

  /// Track-duyarlı test-once sinyali: 'en' → placementLevelEn,
  /// diğer her şey ('ku') → placementLevel. Cihaz/origin bağımsız.
  bool hasPlacementFor(String languageCode) {
    final v = languageCode == 'en' ? placementLevelEn : placementLevel;
    return v != null && v.isNotEmpty;
  }

  factory CloudflareUser.fromJson(Map<String, dynamic> j) => CloudflareUser(
        id: j['id'] as String,
        email: j['email'] as String,
        displayName: j['displayName'] as String?,
        emailVerified: j['emailVerified'] as bool? ?? false,
        isOwner: j['isOwner'] as bool? ?? false,
        currentLevel: j['currentLevel'] as String?,
        targetLevel: j['targetLevel'] as String?,
        isHeritage: j['isHeritage'] as bool? ?? false,
        dailyGoal: (j['dailyGoal'] as num?)?.toInt() ?? 10,
        placementLevel: j['placementLevel'] as String?,
        placementLevelEn: j['placementLevelEn'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'emailVerified': emailVerified,
        'isOwner': isOwner,
        'currentLevel': currentLevel,
        'targetLevel': targetLevel,
        'isHeritage': isHeritage,
        'dailyGoal': dailyGoal,
        'placementLevel': placementLevel,
        'placementLevelEn': placementLevelEn,
      };

  CloudflareUser copyWith({
    bool? emailVerified,
    String? placementLevel,
    String? placementLevelEn,
  }) =>
      CloudflareUser(
        id: id,
        email: email,
        displayName: displayName,
        emailVerified: emailVerified ?? this.emailVerified,
        isOwner: isOwner,
        currentLevel: currentLevel,
        targetLevel: targetLevel,
        isHeritage: isHeritage,
        dailyGoal: dailyGoal,
        placementLevel: placementLevel ?? this.placementLevel,
        placementLevelEn: placementLevelEn ?? this.placementLevelEn,
      );
}

class CloudflareAuthResult {
  final CloudflareUser? user;
  final String? token;
  final String? error;
  final String? errorCode;
  final bool emailSent;

  /// Giriş 403 `email_not_verified` döndüğünde: sunucu bu denemede yeni bir
  /// doğrulama e-postası gönderdiyse true.
  final bool verificationSent;

  bool get isSuccess => error == null;

  const CloudflareAuthResult.success({
    required this.user,
    required this.token,
    this.emailSent = false,
  })  : error = null,
        errorCode = null,
        verificationSent = false;

  const CloudflareAuthResult.failure({
    required this.error,
    this.errorCode,
    this.verificationSent = false,
  })  : user = null,
        token = null,
        emailSent = false;
}

class UserStats {
  final int total;
  final int verified;
  final int unverified;
  final int registeredLast24h;
  final int registeredLast7d;
  final int activeLast30d;

  const UserStats({
    required this.total,
    required this.verified,
    required this.unverified,
    required this.registeredLast24h,
    required this.registeredLast7d,
    required this.activeLast30d,
  });

  factory UserStats.fromJson(Map<String, dynamic> j) => UserStats(
        total: (j['total'] as num?)?.toInt() ?? 0,
        verified: (j['verified'] as num?)?.toInt() ?? 0,
        unverified: (j['unverified'] as num?)?.toInt() ?? 0,
        registeredLast24h: (j['registeredLast24h'] as num?)?.toInt() ?? 0,
        registeredLast7d: (j['registeredLast7d'] as num?)?.toInt() ?? 0,
        activeLast30d: (j['activeLast30d'] as num?)?.toInt() ?? 0,
      );
}

class CloudflareAuthService {
  final Dio _dio;

  CloudflareAuthService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 12),
              receiveTimeout: const Duration(seconds: 20),
              // 4xx body'lerini hata değil, normal Response olarak ele al
              // (errorCode/error JSON'unu kullanıyoruz).
              validateStatus: (_) => true,
            ));

  String get _base => _apiBase();

  // ─── Token persistence ───────────────────────────────────

  Future<String?> getStoredToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_kAuthTokenKey);
    } catch (_) {
      return null;
    }
  }

  Future<CloudflareUser?> getCachedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kAuthUserKey);
      if (raw == null) return null;
      return CloudflareUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> _persistAuth(String? token, CloudflareUser? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(_kAuthTokenKey);
    } else {
      await prefs.setString(_kAuthTokenKey, token);
    }
    if (user == null) {
      await prefs.remove(_kAuthUserKey);
    } else {
      await prefs.setString(_kAuthUserKey, jsonEncode(user.toJson()));
    }
  }

  // ─── HTTP helpers ────────────────────────────────────────

  Future<Map<String, String>> _buildHeaders(
      {bool authenticated = false}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (authenticated) {
      final t = await getStoredToken();
      if (t != null) headers['Authorization'] = 'Bearer $t';
    }
    return headers;
  }

  Map<String, dynamic> _decodeBody(Response resp) {
    final data = resp.data;
    if (data is Map<String, dynamic>) return data;
    if (data is String && data.isNotEmpty) {
      try {
        final parsed = jsonDecode(data);
        if (parsed is Map<String, dynamic>) return parsed;
      } catch (_) {}
    }
    return <String, dynamic>{};
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body, {
    bool authenticated = false,
  }) async {
    final headers = await _buildHeaders(authenticated: authenticated);
    final resp = await _dio.post<dynamic>(
      '$_base$path',
      data: body,
      options: Options(
        headers: headers,
        responseType: ResponseType.json,
      ),
    );
    final decoded = _decodeBody(resp);
    final status = resp.statusCode ?? 0;
    if (status >= 400) {
      throw _AuthApiException(
        decoded['error']?.toString() ?? 'API hatası ($status)',
        decoded['code']?.toString(),
        status,
        decoded,
      );
    }
    return decoded;
  }

  Future<Map<String, dynamic>> _get(String path,
      {bool authenticated = true}) async {
    final headers = await _buildHeaders(authenticated: authenticated);
    final resp = await _dio.get<dynamic>(
      '$_base$path',
      options: Options(
        headers: headers,
        responseType: ResponseType.json,
      ),
    );
    final decoded = _decodeBody(resp);
    final status = resp.statusCode ?? 0;
    if (status >= 400) {
      throw _AuthApiException(
        decoded['error']?.toString() ?? 'API hatası ($status)',
        decoded['code']?.toString(),
        status,
        decoded,
      );
    }
    return decoded;
  }

  // ─── Placement senkronizasyonu ───────────────────────────

  /// GET /api/profile/placement — hesaptaki track-bazlı seviyeler.
  /// Dönen map: {'ku': 'b1'|null, 'en': 'a2'|null}. Hata → null.
  Future<Map<String, String?>?> fetchPlacementLevels() async {
    try {
      final data = await _get('/api/profile/placement');
      return {
        'ku': data['placementLevel'] as String?,
        'en': data['placementLevelEn'] as String?,
      };
    } catch (_) {
      return null;
    }
  }

  /// Hesaptaki placement seviyelerini SharedPreferences'a yazar —
  /// cihaz/tarayıcı değişiminde localStorage otomatik dolar, gate'ler
  /// testi bir daha göstermez. Yalnız DOLU değerler yazılır (sunucuya
  /// yazımı başarısız olmuş yerel fallback seviyesi silinmez).
  Future<void> _syncPlacementPrefs(CloudflareUser user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ku = user.placementLevel;
      if (ku != null && ku.isNotEmpty) {
        await prefs.setString(kPlacementLevelKeyKu, ku);
      }
      final en = user.placementLevelEn;
      if (en != null && en.isNotEmpty) {
        await prefs.setString(kPlacementLevelKeyEn, en);
      }
    } catch (_) {
      // Sessiz — prefs yazılamazsa hesap sinyali yine de geçerli.
    }
  }

  /// Sunucu user JSON'unu modele çevirir; yanıt placementLevelEn alanını
  /// İÇERMİYORSA (auth endpoint'leri henüz güncellenmemişse) GET
  /// /api/profile/placement ile tamamlar, sonra prefs'e senkronlar.
  /// NOT: Çağrılmadan önce token persist edilmiş olmalı (GET auth ister).
  Future<CloudflareUser> _hydrateUser(Map<String, dynamic> json) async {
    var user = CloudflareUser.fromJson(json);
    if (!json.containsKey('placementLevelEn')) {
      final levels = await fetchPlacementLevels();
      if (levels != null) {
        user = user.copyWith(
          placementLevel: levels['ku'] ?? user.placementLevel,
          placementLevelEn: levels['en'],
        );
      }
    }
    await _syncPlacementPrefs(user);
    return user;
  }

  // ─── Public API ──────────────────────────────────────────

  Future<CloudflareAuthResult> signup({
    required String email,
    required String password,
    required String displayName,
    bool isHeritage = false,
    String currentLevel = 'a1',
    String targetLevel = 'b1',
    int dailyGoal = 10,
  }) async {
    try {
      final data = await _post('/api/auth/signup', {
        'email': email,
        'password': password,
        'displayName': displayName,
        'isHeritage': isHeritage,
        'currentLevel': currentLevel,
        'targetLevel': targetLevel,
        'dailyGoal': dailyGoal,
      });
      final user = CloudflareUser.fromJson(
        data['user'] as Map<String, dynamic>,
      );
      final token = data['token'] as String;
      final emailSent = data['emailSent'] as bool? ?? false;
      await _persistAuth(token, user);
      return CloudflareAuthResult.success(
        user: user,
        token: token,
        emailSent: emailSent,
      );
    } on _AuthApiException catch (e) {
      return CloudflareAuthResult.failure(error: e.message, errorCode: e.code);
    } catch (e) {
      return CloudflareAuthResult.failure(
        error: 'Bağlantı hatası. İnterneti kontrol et.',
        errorCode: 'network',
      );
    }
  }

  Future<CloudflareAuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _post('/api/auth/login', {
        'email': email,
        'password': password,
      });
      final userJson = data['user'] as Map<String, dynamic>;
      final token = data['token'] as String;
      // Önce token'ı persist et — placement senkron GET'i auth ister.
      await _persistAuth(token, CloudflareUser.fromJson(userJson));
      // Hesaptaki placement seviyelerini tamamla + prefs'e senkronla
      // (farklı cihaz/tarayıcıda login → test bir daha gösterilmez).
      final user = await _hydrateUser(userJson);
      await _persistAuth(token, user);
      return CloudflareAuthResult.success(user: user, token: token);
    } on _AuthApiException catch (e) {
      return CloudflareAuthResult.failure(
        error: e.message,
        errorCode: e.code,
        verificationSent: e.data['verificationSent'] == true,
      );
    } catch (e) {
      return CloudflareAuthResult.failure(
        error: 'Bağlantı hatası. İnterneti kontrol et.',
        errorCode: 'network',
      );
    }
  }

  /// Google Sign-In: GIS'ten alınan ID token ile backend'e POST.
  /// Backend Google'da verify eder, user bul/yarat/link → JWT döner.
  Future<CloudflareAuthResult> signInWithGoogle(String idToken) async {
    try {
      final data = await _post('/api/auth/google', {'idToken': idToken});
      final userJson = data['user'] as Map<String, dynamic>;
      final token = data['token'] as String;
      // Önce token'ı persist et — placement senkron GET'i auth ister.
      await _persistAuth(token, CloudflareUser.fromJson(userJson));
      // Mevcut Google kullanıcısı başka cihazda test yapmış olabilir —
      // hesaptaki seviyeleri tamamla + prefs'e senkronla.
      final user = await _hydrateUser(userJson);
      await _persistAuth(token, user);
      return CloudflareAuthResult.success(user: user, token: token);
    } on _AuthApiException catch (e) {
      return CloudflareAuthResult.failure(error: e.message, errorCode: e.code);
    } catch (e) {
      return CloudflareAuthResult.failure(
        error: 'Google ile giriş başarısız. İnterneti kontrol et.',
        errorCode: 'network',
      );
    }
  }

  /// Public config (Google Client ID vb.) — frontend startup'ta çağrılır.
  /// Hata durumunda null değerler döner; UI Google butonunu gizler.
  Future<Map<String, dynamic>> fetchPublicConfig() async {
    try {
      return await _get('/api/public-config', authenticated: false);
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  Future<CloudflareAuthResult> resendVerification() async {
    try {
      await _post('/api/auth/resend-verification', {}, authenticated: true);
      return const CloudflareAuthResult.success(
        user: null,
        token: null,
        emailSent: true,
      );
    } on _AuthApiException catch (e) {
      return CloudflareAuthResult.failure(error: e.message, errorCode: e.code);
    } catch (e) {
      return CloudflareAuthResult.failure(
        error: 'Bağlantı hatası.',
        errorCode: 'network',
      );
    }
  }

  Future<CloudflareAuthResult> verifyEmailWithToken(String token) async {
    try {
      await _post('/api/auth/verify-email', {'token': token});
      // Mevcut session user'ı güncelle (verified=true)
      final user = await getCachedUser();
      if (user != null) {
        final updated = user.copyWith(emailVerified: true);
        await _persistAuth(await getStoredToken(), updated);
      }
      return const CloudflareAuthResult.success(user: null, token: null);
    } on _AuthApiException catch (e) {
      return CloudflareAuthResult.failure(error: e.message, errorCode: e.code);
    } catch (e) {
      return CloudflareAuthResult.failure(
        error: 'Bağlantı hatası.',
        errorCode: 'network',
      );
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    try {
      await _post('/api/auth/request-password-reset', {'email': email});
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<CloudflareAuthResult> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _post('/api/auth/reset-password', {
        'token': token,
        'newPassword': newPassword,
      });
      return const CloudflareAuthResult.success(user: null, token: null);
    } on _AuthApiException catch (e) {
      return CloudflareAuthResult.failure(error: e.message, errorCode: e.code);
    } catch (e) {
      return CloudflareAuthResult.failure(
        error: 'Bağlantı hatası.',
        errorCode: 'network',
      );
    }
  }

  /// Refresh user from server (re-fetch /me).
  /// Placement seviyelerini de tamamlar ve prefs'e senkronlar — sayfa
  /// yenileme / yeni cihaz açılışında gate'ler doğru karar versin.
  Future<CloudflareUser?> refreshMe() async {
    try {
      final data = await _get('/api/auth/me');
      final user = await _hydrateUser(data['user'] as Map<String, dynamic>);
      await _persistAuth(await getStoredToken(), user);
      return user;
    } catch (_) {
      return null;
    }
  }

  /// Düzey belirleme testi sonucunu hesaba yazar (account + TRACK bazlı
  /// test-once). track: 'ku' (varsayılan) | 'en'. Başarılıysa güncel user'ı
  /// (ilgili placement alanı dolu) cache'e yazar ve döner.
  /// Hata olursa null — çağıran taraf localStorage fallback'iyle devam eder.
  Future<CloudflareUser?> savePlacementLevel(
    String level, {
    String track = 'ku',
  }) async {
    try {
      final data = await _post(
        '/api/profile/placement',
        {'level': level, 'track': track},
        authenticated: true,
      );
      final user =
          CloudflareUser.fromJson(data['user'] as Map<String, dynamic>);
      await _persistAuth(await getStoredToken(), user);
      await _syncPlacementPrefs(user);
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<UserStats?> fetchAdminStats() async {
    try {
      final data = await _get('/api/admin/stats');
      return UserStats.fromJson(data['stats'] as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    await _persistAuth(null, null);
    // Placement prefs HESABA ait sinyaldir — logout'ta temizle ki aynı
    // tarayıcıda başka hesapla girildiğinde önceki hesabın seviyesi
    // testi yanlışlıkla atlatmasın. Login'de sunucudan yeniden senkronlanır.
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(kPlacementLevelKeyKu);
      await prefs.remove(kPlacementLevelKeyEn);
    } catch (_) {}
  }
}

class _AuthApiException implements Exception {
  final String message;
  final String? code;
  final int statusCode;

  /// Hata yanıtının tüm gövdesi (ör. `verificationSent`).
  final Map<String, dynamic> data;
  _AuthApiException(this.message, this.code, this.statusCode,
      [this.data = const {}]);
}

// ─── Riverpod providers ──────────────────────────────────

final cloudflareAuthServiceProvider = Provider<CloudflareAuthService>(
  (ref) => CloudflareAuthService(),
);

/// Cloudflare current user — önce SharedPrefs cache'inden oku (anlık),
/// sonra arka planda /api/auth/me ile server'dan tazele. Server cache'den
/// daha güncelse persist eder ve provider state'i refresh olur.
///
/// Bu sayede: tarayıcı yeniden açıldığında veya yeni JS bundle yüklendiğinde
/// isOwner / emailVerified bayrakları bayat kalmaz.
final cloudflareCurrentUserProvider =
    FutureProvider<CloudflareUser?>((ref) async {
  final svc = ref.read(cloudflareAuthServiceProvider);
  // Cache'den anlık değer
  final cached = await svc.getCachedUser();
  // Token varsa server'dan tazele (await — owner widget bayat değer almasın)
  final token = await svc.getStoredToken();
  if (token != null) {
    final fresh = await svc.refreshMe();
    if (fresh != null) return fresh;
  }
  return cached;
});

/// Stats provider — refresh on demand.
final cloudflareStatsProvider = FutureProvider<UserStats?>((ref) async {
  return ref.read(cloudflareAuthServiceProvider).fetchAdminStats();
});

// ─── Gate yardımcıları (yarış durumu düzeltmesi) ─────────────────
//
// SORUN: Gate'ler (splash / intro / track-select) cloudflareCurrentUserProvider
// değerini .valueOrNull ile okuyordu — sayfa yenilenince /api/auth/me henüz
// dönmemişse null gelir, localStorage da boşsa (yeni cihaz) düzey testi
// YENİDEN gösterilirdi. Çözüm: hesap bilgisi YÜKLENENE kadar bekle
// (makul timeout), ancak ondan sonra yönlendirme kararı ver.

/// Hesap bilgisini provider Future'ı üzerinden bekler (maks [timeout]).
/// Timeout/hata → null; çağıran prefs fallback'iyle devam eder.
Future<CloudflareUser?> resolveAccountUser(
  WidgetRef ref, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  try {
    return await ref
        .read(cloudflareCurrentUserProvider.future)
        .timeout(timeout);
  } catch (_) {
    return null;
  }
}

/// Track-duyarlı placement kontrolü: önce HESAP (yüklenene kadar bekle),
/// sonra SharedPreferences fallback. `true` → bu track için düzey testi
/// tamamlanmış, bir daha gösterme.
Future<bool> hasPlacementForTrack(WidgetRef ref, String languageCode) async {
  final user = await resolveAccountUser(ref);
  if (user != null && user.hasPlacementFor(languageCode)) return true;
  try {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(
      languageCode == 'en' ? kPlacementLevelKeyEn : kPlacementLevelKeyKu,
    );
    return v != null && v.isNotEmpty;
  } catch (_) {
    return false;
  }
}
