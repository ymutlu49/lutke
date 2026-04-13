import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/user_segment.dart';

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

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});

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
      return AuthResult.failure('Beklenmeyen hata: $e');
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
      return AuthResult.failure('Anonim giriş hatası: $e');
    }
  }

  // ── ÇIKIŞ ──────────────────────────────────────────────────

  Future<void> signOut() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_anonymous');
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
      if (user == null) return AuthResult.failure('Oturum açık değil');

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
    'user-not-found' => 'Bu e-posta adresiyle kayıtlı kullanıcı yok.',
    'wrong-password' => 'Şifre hatalı.',
    'email-already-in-use' => 'Bu e-posta adresi zaten kullanımda.',
    'weak-password' => 'Şifre en az 6 karakter olmalı.',
    'invalid-email' => 'Geçersiz e-posta adresi.',
    'user-disabled' => 'Bu hesap devre dışı bırakılmış.',
    'too-many-requests' => 'Çok fazla deneme. Lütfen bekleyin.',
    'operation-not-allowed' => 'Bu işlem izin verilmiyor.',
    'requires-recent-login' =>
      'Bu işlem için yeniden giriş yapmanız gerekiyor.',
    _ => 'Bir hata oluştu. Lütfen tekrar deneyin.',
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
