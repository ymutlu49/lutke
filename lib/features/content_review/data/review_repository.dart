import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/review_models.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Content Review Repository (Firestore)
//
// Firestore collection: `content_reviews`
//
// Index önerileri (manual):
//   - (contentType ASC, createdAt DESC)
//   - (reviewerUid ASC, createdAt DESC)
//   - (status ASC, createdAt DESC)
//   - (contentType ASC, contentId ASC)
//
// Firebase yapılandırılmamışsa in-memory fallback kullanılır —
// uygulamayı çökertmemek için.
// ════════════════════════════════════════════════════════════════

class ContentReviewRepository {
  FirebaseFirestore? _dbOrNull;
  // Firebase yoksa kullanılan bellek-içi mağaza (dev/test modu)
  final List<ContentReview> _memory = [];

  FirebaseFirestore? _safeDb() {
    if (_dbOrNull != null) return _dbOrNull;
    try {
      _dbOrNull = FirebaseFirestore.instance;
      return _dbOrNull;
    } catch (_) {
      return null;
    }
  }

  CollectionReference<Map<String, dynamic>>? _col() =>
      _safeDb()?.collection('content_reviews');

  /// Yeni review ekle.
  Future<ContentReview?> add(ContentReview review) async {
    final col = _col();
    if (col == null) {
      _memory.add(review);
      return review;
    }
    try {
      await col.add(review.toJson());
      return review.copyWith(updatedAt: DateTime.now());
    } catch (_) {
      _memory.add(review);
      return review;
    }
  }

  /// Belirli içerik türü + seviye için tüm review'lar.
  Stream<List<ContentReview>> watchByType({
    required ReviewContentType type,
    String? level,
  }) {
    final col = _col();
    if (col == null) {
      // Memory fallback
      final filtered = _memory
          .where((r) => r.contentType == type)
          .where((r) => level == null || r.level == level)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Stream<List<ContentReview>>.value(filtered);
    }

    Query<Map<String, dynamic>> q =
        col.where('contentType', isEqualTo: type.id);
    if (level != null) q = q.where('level', isEqualTo: level);
    q = q.orderBy('createdAt', descending: true).limit(200);

    return q.snapshots().map((snap) => snap.docs
        .map((d) => ContentReview.fromJson(d.id, d.data()))
        .toList());
  }

  /// Belirli content için tüm review'lar (contentType + contentId).
  Stream<List<ContentReview>> watchByContent({
    required ReviewContentType type,
    required String contentId,
  }) {
    final col = _col();
    if (col == null) {
      final filtered = _memory
          .where((r) => r.contentType == type && r.contentId == contentId)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Stream<List<ContentReview>>.value(filtered);
    }

    return col
        .where('contentType', isEqualTo: type.id)
        .where('contentId', isEqualTo: contentId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => ContentReview.fromJson(d.id, d.data()))
            .toList());
  }

  /// Admin — tüm bekleyen öneriler.
  Stream<List<ContentReview>> watchPending() {
    final col = _col();
    if (col == null) {
      final filtered = _memory
          .where((r) =>
              r.status == ReviewStatus.suggested ||
              r.status == ReviewStatus.flagged)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Stream<List<ContentReview>>.value(filtered);
    }

    return col
        .where('status', whereIn: [
          ReviewStatus.suggested.id,
          ReviewStatus.flagged.id,
        ])
        .orderBy('createdAt', descending: true)
        .limit(200)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => ContentReview.fromJson(d.id, d.data()))
            .toList());
  }

  /// Admin — öneriyi kabul/red et.
  Future<void> updateStatus({
    required String reviewId,
    required ReviewStatus status,
    String? adminNote,
  }) async {
    final col = _col();
    final update = {
      'status': status.id,
      'updatedAt': DateTime.now().toIso8601String(),
      if (adminNote != null) 'adminNote': adminNote,
    };
    if (col == null) {
      // Bellek güncelle
      for (int i = 0; i < _memory.length; i++) {
        if (_memory[i].id == reviewId) {
          _memory[i] = _memory[i].copyWith(
            status: status,
            adminNote: adminNote,
            updatedAt: DateTime.now(),
          );
          return;
        }
      }
      return;
    }
    try {
      await col.doc(reviewId).update(update);
    } catch (_) {}
  }

  /// Belirli uzmanın tüm review'ları.
  Stream<List<ContentReview>> watchByReviewer(String reviewerUid) {
    final col = _col();
    if (col == null) {
      final filtered = _memory
          .where((r) => r.reviewerUid == reviewerUid)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Stream<List<ContentReview>>.value(filtered);
    }

    return col
        .where('reviewerUid', isEqualTo: reviewerUid)
        .orderBy('createdAt', descending: true)
        .limit(100)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => ContentReview.fromJson(d.id, d.data()))
            .toList());
  }

  /// Özet istatistik — admin paneli.
  Future<ReviewStats> stats() async {
    final col = _col();
    if (col == null) {
      return _statsFromList(_memory);
    }
    try {
      final snap = await col.limit(1000).get();
      final list = snap.docs
          .map((d) => ContentReview.fromJson(d.id, d.data()))
          .toList();
      return _statsFromList(list);
    } catch (_) {
      return _statsFromList(_memory);
    }
  }

  ReviewStats _statsFromList(List<ContentReview> list) {
    final total = list.length;
    final suggested = list.where((r) => r.status == ReviewStatus.suggested).length;
    final flagged = list.where((r) => r.status == ReviewStatus.flagged).length;
    final approved = list.where((r) => r.status == ReviewStatus.approved).length;
    final accepted = list.where((r) => r.status == ReviewStatus.accepted).length;
    final dismissed =
        list.where((r) => r.status == ReviewStatus.dismissed).length;
    final reviewers = list.map((r) => r.reviewerUid).toSet().length;
    return ReviewStats(
      total: total,
      suggested: suggested,
      flagged: flagged,
      approved: approved,
      accepted: accepted,
      dismissed: dismissed,
      activeReviewers: reviewers,
    );
  }
}

class ReviewStats {
  final int total;
  final int suggested;
  final int flagged;
  final int approved;
  final int accepted;
  final int dismissed;
  final int activeReviewers;

  const ReviewStats({
    required this.total,
    required this.suggested,
    required this.flagged,
    required this.approved,
    required this.accepted,
    required this.dismissed,
    required this.activeReviewers,
  });

  int get pending => suggested + flagged;
}

// ════════════════════════════════════════════════════════════════
// Riverpod providers
// ════════════════════════════════════════════════════════════════

final contentReviewRepositoryProvider =
    Provider<ContentReviewRepository>((_) => ContentReviewRepository());

/// Belirli tür + seviye için reviews — reactive.
final reviewsByTypeProvider = StreamProvider.family
    .autoDispose<List<ContentReview>, ({ReviewContentType type, String? level})>(
  (ref, p) {
    return ref
        .watch(contentReviewRepositoryProvider)
        .watchByType(type: p.type, level: p.level);
  },
);

/// Belirli içerik için review'lar (spesifik item'ın geçmişi).
final reviewsByContentProvider = StreamProvider.family.autoDispose<
    List<ContentReview>,
    ({ReviewContentType type, String contentId})>(
  (ref, p) {
    return ref
        .watch(contentReviewRepositoryProvider)
        .watchByContent(type: p.type, contentId: p.contentId);
  },
);

/// Admin için: bekleyen öneriler.
final pendingReviewsProvider =
    StreamProvider.autoDispose<List<ContentReview>>((ref) {
  return ref.watch(contentReviewRepositoryProvider).watchPending();
});

/// İstatistik.
final reviewStatsProvider =
    FutureProvider.autoDispose<ReviewStats>((ref) async {
  return ref.watch(contentReviewRepositoryProvider).stats();
});
