import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/admin_config.dart';
import '../utils/user_segment.dart';
import 'local_auth_service.dart' show localCurrentUserProvider;
import 'cloudflare_auth_service.dart' show cloudflareCurrentUserProvider;

// ════════════════════════════════════════════════════════════════
// AUTH SERVICE — LÛTKE
// Firebase Authentication + Firestore kullanıcı profili
// ════════════════════════════════════════════════════════════════

// ── PROVIDERS ─────────────────────────────────────────────────

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  try {
    return ref.watch(authServiceProvider).authStateStream;
  } catch (_) {
    // Firebase yapılandırılmamış — null döndür
    return Stream.value(null);
  }
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});

/// Firebase-only login flag.
/// NOT: Uygulama çoğunlukla yerel auth'ta (SharedPreferences) çalıştığı için
/// gerçek "logged in" kontrolü `isAnyLoggedInProvider` üzerinden yapılmalı.
/// Yalnızca Firebase'e özgü akışlar için `isLoggedInProvider` kullan.
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});

/// Herhangi bir auth yoluyla oturum açık mı?
/// Firebase user varsa ya da yerel auth user varsa true döner.
/// Router redirect'i ve splash CTA bu provider'a bakmalı — aksi halde yerel
/// auth kullanıcıları her açılışta yeniden "Tomar bibe" görür.
///
/// Cold start'ta `localCurrentUserProvider` henüz Future'ı çözmediği için
/// değer false olabilir; ancak Future tamamlanır tamamlanmaz provider
/// otomatik re-evaluate eder (Riverpod async streaming) ve splash/router
/// yeniden render olur. Bu davranış doğru: yüklenene kadar splash Logo'yla
/// gösterilir, Future biter ve gerçek duruma göre yönlendirilir.
final isAnyLoggedInProvider = Provider<bool>((ref) {
  final firebaseLoggedIn = ref.watch(currentUserProvider) != null;
  if (firebaseLoggedIn) return true;
  // Yerel auth — localCurrentUserProvider async okuma. Data yoksa false.
  final localAsync = ref.watch(_localLoggedInAsyncProvider);
  return localAsync.maybeWhen(
    data: (v) => v,
    orElse: () => false,
  );
});

/// Yerel auth FutureProvider'ı bool'a indirger — cold start'ta SharedPrefs
/// okumasını splash'ten önce çözer. Async tamamlanınca router redirect
/// otomatik re-evaluate olur.
final _localLoggedInAsyncProvider = FutureProvider<bool>((ref) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('lutke_local_user_v1');
    return raw != null && raw.isNotEmpty;
  } catch (_) {
    return false;
  }
});

/// LÛTKE sahibi (Prof. Dr. Yılmaz Mutlu) email'i ve dil uzmanları listesi
/// `core/config/admin_config.dart`'a taşındı (Nisan 2026).
///
/// Build-time'da override etmek için:
///   flutter build apk --release \
///     --dart-define=LUTKE_OWNER_EMAIL=info@example.com \
///     --dart-define=LUTKE_REVIEWER_EMAILS=a@x.com,b@x.com
///
/// Backwards compatibility için aşağıdaki re-export'lar tutulur — yeni
/// kod doğrudan AdminConfig'i kullanmalı.
/// Multi-owner desteği (Mayıs 2026): kOwnerEmail const kaldırıldı,
/// yerine AdminConfig.isOwner(email) kullanın (liste kontrolü).
List<String> get kOwnerEmails => AdminConfig.ownerEmails;
List<String> get kReviewerEmails => AdminConfig.reviewerEmails;

/// Sahip kontrolü — Firebase + yerel auth bileşik kontrolü.
/// Firebase yapılandırıldıysa user.email; aksi halde yerel auth'tan.
///
/// Önemli: `_localOwnerCheckProvider` sadece aktif login/logout sonrası
/// set ediliyor. Sayfa reload / cold start'ta `false` kalır, edit butonu
/// görünmez. Bu yüzden `localCurrentUserProvider` (FutureProvider —
/// SharedPreferences'tan hidrate) yedek olarak da kontrol edilir.
final isOwnerProvider = Provider<bool>((ref) {
  // Firebase yolu (Firebase aktif ise)
  final firebaseUser = ref.watch(currentUserProvider);
  if (AdminConfig.isOwner(firebaseUser?.email)) {
    return true;
  }
  // Cloudflare auth (Mayıs 2026): D1'deki is_owner=1 flag'i.
  // Backend zaten OWNER_EMAIL env kontrolü yapıyor; biz JWT claim'ine
  // bakıyoruz — ekstra şifre kontrolüne gerek yok.
  final cfAsync = ref.watch(cloudflareCurrentUserProvider);
  final cfOwner = cfAsync.maybeWhen(
    data: (u) => u?.isOwner ?? false,
    orElse: () => false,
  );
  if (cfOwner) return true;
  // Yerel auth — state provider (hızlı, login sonrası anında güncel)
  final localOwner = ref.watch(_localOwnerCheckProvider);
  if (localOwner) return true;
  // Yerel auth — prefs-hydrated FutureProvider (cold start / reload'ta da çalışır)
  final async = ref.watch(localCurrentUserProvider);
  return async.maybeWhen(
    data: (user) => user?.isOwner ?? false,
    orElse: () => false,
  );
});

/// Dil uzmanı (reviewer) kontrolü — email whitelist'e göre.
/// Owner + reviewer email'leri birlikte reviewer yetkisine sahiptir.
final isReviewerProvider = Provider<bool>((ref) {
  final isOwner = ref.watch(isOwnerProvider);
  if (isOwner) return true;
  final firebaseUser = ref.watch(currentUserProvider);
  final email = firebaseUser?.email?.toLowerCase();
  if (email == null) return false;
  return kReviewerEmails.any((e) => e.toLowerCase() == email);
});

/// Yerel auth'tan owner durumunu okur — local_auth_service.dart'a delege.
/// Bu helper provider, auth_service.dart ↔ local_auth_service.dart döngüsel
/// import'unu önler (string-tabanlı SharedPreferences okuma).
final _localOwnerCheckProvider = StateProvider<bool>((_) => false);

/// Yerel auth durumunu ref provider'a yansıtır (login/register/logout sonrası çağrılır).
/// `ref` parametresi `WidgetRef` veya `Ref` olabilir — sadece `read`/`invalidate`
/// kullanılır.
///
/// `_localOwnerCheckProvider`'ı owner flag'i için günceller + async
/// `_localLoggedInAsyncProvider`'ı invalidate eder, böylece login/logout
/// sonrası router/splash yeniden değerlendirir.
Future<void> refreshLocalOwnerState(dynamic ref) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('lutke_local_user_v1');
    if (raw == null) {
      ref.read(_localOwnerCheckProvider.notifier).state = false;
    } else {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final isOwner = json['isOwner'] as bool? ?? false;
      ref.read(_localOwnerCheckProvider.notifier).state = isOwner;
    }
  } catch (_) {
    ref.read(_localOwnerCheckProvider.notifier).state = false;
  }
  // Async login flag'ini invalidate et — yeni değer SharedPreferences'tan okunsun.
  try {
    ref.invalidate(_localLoggedInAsyncProvider);
  } catch (_) {}
}

final userProfileFirestoreProvider =
    FutureProvider.family<UserProfile?, String>((ref, userId) {
  return ref.watch(authServiceProvider).getUserProfile(userId);
});

// ── AUTH SERVICE ──────────────────────────────────────────────

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateStream => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  bool get isLoggedIn => _auth.currentUser != null;

  // ── KAYIT ──────────────────────────────────────────────────

  Future<AuthResult> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
    required UserProfile initialProfile,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      // Display name güncelle
      await user.updateDisplayName(displayName);

      // Firestore'a profil kaydet
      await _createUserProfile(
        user.uid,
        initialProfile.copyWith(
          userId: user.uid,
          displayName: displayName,
          email: email,
        ),
      );

      return AuthResult.success(user);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_mapFirebaseError(e.code));
    } catch (e) {
      return AuthResult.failure('Çewtîya nedîtî: $e');
    }
  }

  // ── GİRİŞ ──────────────────────────────────────────────────

  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success(credential.user!);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_mapFirebaseError(e.code));
    }
  }

  // ── ANONİM ─────────────────────────────────────────────────

  Future<AuthResult> signInAnonymously({
    UserProfile? initialProfile,
  }) async {
    try {
      final credential = await _auth.signInAnonymously();
      final user = credential.user!;

      await _createUserProfile(
        user.uid,
        (initialProfile ?? const UserProfile(
          userId: '',
          currentLevel: 'a1',
          targetLevel: 'b1',
          isHeritage: false,
          dailyGoal: 10,
        )).copyWith(userId: user.uid),
      );

      // Anonim kullanıcı flag'ini kaydet
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_anonymous', true);

      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.failure('Çewtîya têketina anonîm: $e');
    }
  }

  // ── ÇIKIŞ ──────────────────────────────────────────────────

  Future<void> signOut() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    // Oturumla bağlı tüm yerel state'i temizle — farklı hesapla gelen
    // kullanıcı eski track/onboarding/challenge state'iyle karşılaşmasın.
    await prefs.remove('is_anonymous');
    await prefs.remove('learning_track_v1');
    await prefs.remove('child_onboarding_complete');
    await prefs.remove('onboarding_complete');
    await prefs.remove('is_child_mode');
    // BUG FIX: Anahtarlar provider ile uyumsuzdu (learning_module_v1 vs learning_module,
    // language_mode eksikti). Bu yüzden logout sonrası yeni hesap eski modül/dili görüyordu.
    await prefs.remove('learning_module');
    await prefs.remove('language_mode');
    await prefs.remove('user_mode_preference_v1');
    await prefs.remove('kurmanci_tts_source_v1');
    // Challenge/streak/gamification state'i de sıfırla
    await prefs.remove('streak_state');
    await prefs.remove('gamification_state');
    await prefs.remove('gamification_daily_xp_log');
    await prefs.remove('child_challenge_date');
    await prefs.remove('bizer_evolution_stars');
    await prefs.remove('review_weak_words');
    await prefs.remove('review_last_session');
    await prefs.remove('lutke_completed_activities');
    await prefs.remove('lutke_lesson_scores'); // kLessonScoresKey
    // NOT (2026-05-06): Eskiden placement_level_ku/en burada silinirdi
    // ("oturum-scoped" niyetiyle) — ama bu kullanıcı her login olduğunda
    // CEFR testini tekrar tetikliyordu. Kullanıcı isteği: test sadece ilk
    // kayıt + ilk girişte gösterilsin. Artık placement level cihazda
    // kalıcı; aynı kullanıcı tekrar login → track-select doğrudan home'a.
    await prefs.remove('motivation_anchor_name');
    // Skill XP — her modül × her skill için kaldır
    for (final module in ['ku', 'en']) {
      for (final skill in ['grammar', 'writing', 'reading', 'listening',
          'speaking', 'quiz']) {
        await prefs.remove('skill_${module}_${skill}_completed');
        await prefs.remove('skill_${module}_${skill}_xp');
      }
    }
  }

  // ── PROFİL ─────────────────────────────────────────────────

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (!doc.exists) return null;
      return UserProfile.fromFirestore(doc.data()!);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    await _firestore
        .collection('users')
        .doc(profile.userId)
        .update(profile.toFirestore());
  }

  Future<void> updateCurrentLevel(String userId, String level) async {
    await _firestore.collection('users').doc(userId).update({
      'currentLevel': level,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDailyGoal(String userId, int goal) async {
    await _firestore.collection('users').doc(userId).update({
      'dailyGoal': goal,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateStreak(String userId) async {
    final ref = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((tx) async {
      final doc = await tx.get(ref);
      if (!doc.exists) return;

      final data = doc.data()!;
      final lastActivity = (data['lastActivity'] as Timestamp?)?.toDate();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      int streak = data['streakDays'] ?? 0;
      if (lastActivity != null) {
        final lastDay = DateTime(
            lastActivity.year, lastActivity.month, lastActivity.day);
        final diff = today.difference(lastDay).inDays;
        if (diff == 1) {
          streak++; // Ardışık gün
        } else if (diff > 1) {
          streak = 1; // Seri bozuldu
        }
        // diff == 0 → aynı gün, streak değişmez
      } else {
        streak = 1;
      }

      tx.update(ref, {
        'streakDays': streak,
        'lastActivity': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  // ── ŞİFRE SIFIRLAMA ───────────────────────────────────────

  Future<AuthResult> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult.success(null);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_mapFirebaseError(e.code));
    }
  }

  // ── E-POSTA DOĞRULAMA ─────────────────────────────────────

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  bool get isEmailVerified =>
      _auth.currentUser?.emailVerified ?? false;

  // ── HESAP SİLME ───────────────────────────────────────────

  Future<AuthResult> deleteAccount(String password) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return AuthResult.failure('Danişîn vekirî nîne');

      // Firestore verilerini sil
      await _deleteUserData(user.uid);

      // Firebase Auth hesabını sil
      await user.delete();

      return AuthResult.success(null);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_mapFirebaseError(e.code));
    }
  }

  // ── YARDIMCI ─────────────────────────────────────────────

  Future<void> _createUserProfile(String uid, UserProfile profile) async {
    await _firestore.collection('users').doc(uid).set({
      ...profile.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _deleteUserData(String uid) async {
    final batch = _firestore.batch();
    // Kullanıcı verilerini temizle
    batch.delete(_firestore.collection('users').doc(uid));
    // (reviews, progress gibi alt koleksiyonlar varsa onları da sil)
    await batch.commit();
  }

  String _mapFirebaseError(String code) => switch (code) {
    'user-not-found' => 'Bi vê e-nameyê bikarhêner tune.',
    'wrong-password' => 'Şîfre çewt e.',
    'email-already-in-use' => 'Ev e-name berê tê bikaranîn.',
    'weak-password' => 'Şîfre divê herî kêm 6 tîp be.',
    'invalid-email' => 'E-nameya nederbasdar.',
    'user-disabled' => 'Ev hesab hatiye astengkirin.',
    'too-many-requests' => 'Pir ceribandin. Ji kerema xwe bisekinin.',
    'operation-not-allowed' => 'Ev kar nayê destûrkirin.',
    'requires-recent-login' =>
      'Ji bo vê karê divê hûn ji nû ve têkevin.',
    _ => 'Çewtî derket. Ji kerema xwe dîsa biceribînin.',
  };
}

// ════════════════════════════════════════════════════════════════
// SONUÇ MODELİ
// ════════════════════════════════════════════════════════════════

class AuthResult {
  final User? user;
  final String? error;
  bool get isSuccess => error == null;

  const AuthResult.success(this.user) : error = null;
  const AuthResult.failure(this.error) : user = null;
}
