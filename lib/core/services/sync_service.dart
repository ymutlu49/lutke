import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../utils/user_segment.dart';
import '../../features/gamification/gamification_provider.dart';

// ════════════════════════════════════════════════════════════════
// AUTH SERVİSİ
// ════════════════════════════════════════════════════════════════

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  bool get isSignedIn => currentUser != null;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Google ile giriş
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleAuthProvider provider = GoogleAuthProvider();
      return await _auth.signInWithProvider(provider);
    } catch (e) {
      return null;
    }
  }

  /// Apple ile giriş
  Future<UserCredential?> signInWithApple() async {
    try {
      final AppleAuthProvider provider = AppleAuthProvider();
      return await _auth.signInWithProvider(provider);
    } catch (e) {
      return null;
    }
  }

  /// E-posta/şifre kaydı
  Future<UserCredential?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapAuthError(e);
    }
  }

  /// E-posta/şifre girişi
  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapAuthError(e);
    }
  }

  /// Çıkış
  Future<void> signOut() async => _auth.signOut();

  /// Anonim giriş (onboarding'den önce)
  Future<UserCredential?> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (_) {
      return null;
    }
  }

  String _mapAuthError(FirebaseAuthException e) {
    return switch (e.code) {
      'weak-password' => 'Şifre çok kısa — en az 6 karakter',
      'email-already-in-use' => 'Bu e-posta zaten kullanımda',
      'user-not-found' => 'Hesap bulunamadı',
      'wrong-password' => 'Şifre yanlış',
      'invalid-email' => 'Geçersiz e-posta adresi',
      _ => 'Bir sorun oluştu: ${e.message}',
    };
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// ════════════════════════════════════════════════════════════════
// FIRESTORE SENKRON SERVİSİ
// Çevrimdışı öncelikli — önce lokal, sonra bulut
// ════════════════════════════════════════════════════════════════

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AppDatabase _db;
  final String _userId;

  SyncService({required AppDatabase db, required String userId})
      : _db = db,
        _userId = userId;

  // ── Kullanıcı Profili Sync ────────────────────────────────────

  /// Profili Firestore'a yükle
  Future<void> pushProfile(UserProfile profile) async {
    try {
      await _firestore.collection('users').doc(_userId).set({
        'displayName': profile.displayName,
        'segment': profile.segment.name,
        'learningGoal': profile.learningGoal.name,
        'dialect': profile.dialect.name,
        'interfaceLanguage': profile.interfaceLanguage.name,
        'motivationAnchorName': profile.motivationAnchorName,
        'dailyGoalMinutes': profile.dailyGoalMinutes,
        'totalXP': profile.totalXP,
        'currentLevel': profile.currentLevel,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Offline — kuyruğa al, sonra tekrar dene
      await _queueSync('profile', profile.toJson());
    }
  }

  /// FSRS verilerini Firestore'a yükle
  Future<void> pushFsrsReviews() async {
    try {
      final reviews = await _db.getAllReviews(_userId);
      if (reviews.isEmpty) return;

      final batch = _firestore.batch();
      for (final review in reviews) {
        final ref = _firestore
            .collection('users')
            .doc(_userId)
            .collection('fsrs_reviews')
            .doc('${review.cardId}_$_userId');

        batch.set(ref, {
          'cardId': review.cardId,
          'stability': review.stability,
          'difficulty': review.difficulty,
          'retrievability': review.retrievability,
          'state': review.state,
          'reviewCount': review.reviewCount,
          'lapseCount': review.lapseCount,
          'lastReview': review.lastReview?.toIso8601String(),
          'dueDate': review.dueDate.toIso8601String(),
          'syncedAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
    } catch (_) {
      await _queueSync('fsrs_reviews', {'userId': _userId});
    }
  }

  /// XP ve gamification verilerini sync et
  Future<void> pushGamification(GamificationState state) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('gamification')
          .doc('current')
          .set({
        'totalXP': state.totalXP,
        'level': state.level,
        'earnedBadgeIds': state.earnedBadgeIds,
        'weekStreak': state.weeklyRhythm.weekStreak,
        'totalActiveDays': state.weeklyRhythm.totalActiveDays,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Offline — devam et
    }
  }

  /// Rozet kazanımını kaydet
  Future<void> pushBadge(String badgeId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('badges')
          .doc(badgeId)
          .set({
        'badgeId': badgeId,
        'earnedAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {}
  }

  // ── Firestore'dan Çek ─────────────────────────────────────────

  Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      final doc = await _firestore.collection('users').doc(_userId).get();
      return doc.data();
    } catch (_) {
      return null;
    }
  }

  // ── Çevrimdışı Kuyruk ─────────────────────────────────────────

  static const _kQueueKey = 'sync_queue';

  Future<void> _queueSync(String type, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_kQueueKey);
    final queue =
        existing != null ? (jsonDecode(existing) as List).cast<Map>() : [];
    queue.add({'type': type, 'data': data, 'timestamp': DateTime.now().toIso8601String()});
    await prefs.setString(_kQueueKey, jsonEncode(queue));
  }

  /// İnternet bağlantısı geldiğinde kuyruktaki işlemleri gönder
  Future<void> flushQueue() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_kQueueKey);
    if (existing == null) return;

    final queue = (jsonDecode(existing) as List).cast<Map>();
    final remaining = <Map>[];

    for (final item in queue) {
      try {
        final type = item['type'] as String;
        if (type == 'fsrs_reviews') await pushFsrsReviews();
        // Diğer tipler...
        // Başarılı — kuyruğa koyma
      } catch (_) {
        remaining.add(item); // Başarısız — tekrar dene
      }
    }

    if (remaining.isEmpty) {
      await prefs.remove(_kQueueKey);
    } else {
      await prefs.setString(_kQueueKey, jsonEncode(remaining));
    }
  }
}

extension on UserProfile {
  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'segment': segment.name,
        'learningGoal': learningGoal.name,
      };
}

final syncServiceProvider = Provider.family<SyncService, String>(
  (ref, userId) => SyncService(
    db: ref.watch(databaseProvider),
    userId: userId,
  ),
);
