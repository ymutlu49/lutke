import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ════════════════════════════════════════════════════════════════
// ANALYTICS SERVICE — LÛTKE
// Kullanıcı davranışı ve öğrenme istatistikleri
// ════════════════════════════════════════════════════════════════

final analyticsServiceProvider =
    Provider<AnalyticsService>((ref) => AnalyticsService());

class AnalyticsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // ── ÖĞRENME OLAYLARI ─────────────────────────────────────

  Future<void> logCardReview({
    required String cardId,
    required String kurmanji,
    required int levelNum,
    required String rating,    // 'again' | 'hard' | 'good' | 'easy'
    required int responseMs,   // milisaniye cevap süresi
  }) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'card_review',
      'cardId': cardId,
      'kurmanji': kurmanji,
      'level': levelNum,
      'rating': rating,
      'responseMs': responseMs,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Günlük özeti güncelle
    await _updateDailySummary(uid, rating == 'again' ? 0 : 1);
  }

  Future<void> logLessonComplete({
    required String lessonId,
    required String lessonTitle,
    required int levelNum,
    required int durationSeconds,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'lesson_complete',
      'lessonId': lessonId,
      'lessonTitle': lessonTitle,
      'level': levelNum,
      'durationSeconds': durationSeconds,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'accuracy': totalQuestions > 0
          ? correctAnswers / totalQuestions
          : 0.0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> logLevelUp({
    required int fromLevel,
    required int toLevel,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'level_up',
      'fromLevel': fromLevel,
      'toLevel': toLevel,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> logStreakMilestone(int days) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'streak_milestone',
      'days': days,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // ── HERITAGE OLAYLARI ─────────────────────────────────────

  Future<void> logHeritageDialogueStart({
    required String dialogueId,
    required String topic,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'heritage_dialogue_start',
      'dialogueId': dialogueId,
      'topic': topic,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // ── UYGULAMA OLAYLARI ────────────────────────────────────

  Future<void> logAppOpen() async {
    final uid = _uid;
    if (uid == null) return;

    final today = _todayKey();
    final ref = _db.collection('users').doc(uid)
        .collection('activity').doc(today);

    await ref.set({
      'date': today,
      'appOpens': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> logOnboardingStep(String step) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'onboarding_step',
      'step': step,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> logSearch(String query) async {
    final uid = _uid;
    if (uid == null) return;

    await _db.collection('analytics').add({
      'userId': uid,
      'event': 'search',
      'query': query,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // ── OKUMA İSTATİSTİĞİ ─────────────────────────────────────

  Future<Map<String, dynamic>> getWeeklySummary(String userId) async {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final snapshot = await _db.collection('analytics')
        .where('userId', isEqualTo: userId)
        .where('event', isEqualTo: 'card_review')
        .where('timestamp', isGreaterThan: Timestamp.fromDate(weekAgo))
        .get();

    int total = snapshot.docs.length;
    int correct = snapshot.docs
        .where((d) => d['rating'] != 'again')
        .length;
    double avgResponseMs = total > 0
        ? snapshot.docs
              .map<int>((d) => (d['responseMs'] as num?)?.toInt() ?? 0)
              .reduce((a, b) => a + b) /
              total
        : 0.0;

    return {
      'totalReviews': total,
      'correctReviews': correct,
      'accuracy': total > 0 ? correct / total : 0.0,
      'avgResponseMs': avgResponseMs.round(),
    };
  }

  Future<List<Map<String, dynamic>>> getDailyActivity(
      String userId, int days) async {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 0; i < days; i++) {
      final date = now.subtract(Duration(days: i));
      final key = _dateKey(date);
      final doc = await _db.collection('users').doc(userId)
          .collection('activity').doc(key).get();
      result.add({
        'date': key,
        'reviews': doc.data()?['cardReviews'] ?? 0,
        'correct': doc.data()?['correctReviews'] ?? 0,
      });
    }
    return result;
  }

  // ── YARDIMCI ─────────────────────────────────────────────

  Future<void> _updateDailySummary(String uid, int correct) async {
    final today = _todayKey();
    final ref = _db.collection('users').doc(uid)
        .collection('activity').doc(today);

    await ref.set({
      'date': today,
      'cardReviews': FieldValue.increment(1),
      'correctReviews': FieldValue.increment(correct),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  String _todayKey() => _dateKey(DateTime.now());

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
