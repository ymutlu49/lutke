// ════════════════════════════════════════════════════════════════
// LÛTKE — Dil Uzmanı Review Sistemi — Domain Modelleri
//
// 10 dil uzmanı Kurmancî içerik üzerinde:
//   - Onay (içerik doğru, tamam)
//   - Öneri (yeni bir ifade öner)
//   - Sorun (bir not düş — örn. imla hatası)
//
// Her review Firestore'a kaydedilir. Admin (owner) bunları
// panel üzerinden görüp kabul/red edebilir.
// ════════════════════════════════════════════════════════════════

/// Review'a konu olan içerik türü.
enum ReviewContentType {
  /// Kurmancî kelime (A1-C2)
  wordKu(id: 'word_ku', labelKu: 'Peyv (Mezinan)', emoji: '📝'),

  /// Çocuk modu Kurmancî kelime
  childWordKu(id: 'child_word_ku', labelKu: 'Peyv (Zarokan)', emoji: '🧒'),

  /// Quiz sorusu + distraktörler
  quizKu(id: 'quiz_ku', labelKu: 'Ceribandin', emoji: '🎯'),

  /// Heritage örnek cümle (kelime DB'sindeki `her[]`/`herKu[]`)
  exampleSentenceKu(
      id: 'example_sentence_ku',
      labelKu: 'Hevokên Mînak',
      emoji: '💬'),

  /// Diyalog / hevpeyvîn
  dialogueKu(id: 'dialogue_ku', labelKu: 'Hevpeyvîn', emoji: '🗣️'),

  /// Gramer notu
  grammarKu(id: 'grammar_ku', labelKu: 'Rêziman', emoji: '📘'),

  /// Okuma metni
  readingKu(id: 'reading_ku', labelKu: 'Xwendin', emoji: '📖'),

  /// Kültürel içerik (gotinên pêşiyan, çîrok, lorî)
  culturalKu(id: 'cultural_ku', labelKu: 'Çandî', emoji: '🎵'),

  /// UI metinleri (.arb)
  uiKu(id: 'ui_ku', labelKu: 'Navberê Bikarhêner', emoji: '🖥️');

  final String id;
  final String labelKu;
  final String emoji;

  const ReviewContentType({
    required this.id,
    required this.labelKu,
    required this.emoji,
  });

  static ReviewContentType fromId(String id) {
    return ReviewContentType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => ReviewContentType.wordKu,
    );
  }
}

/// Review verisinin durumu.
enum ReviewStatus {
  /// Uzman içeriği onayladı — doğru, değişiklik gerekmez.
  approved(id: 'approved', emoji: '✅', labelKu: 'Qebûl'),

  /// Uzman alternatif bir öneri sundu.
  suggested(id: 'suggested', emoji: '💡', labelKu: 'Pêşniyar'),

  /// Uzman bir sorun tespit etti (imla, anlam, telaffuz).
  flagged(id: 'flagged', emoji: '⚠️', labelKu: 'Pirsgirêk'),

  /// Admin öneriyi kabul etti.
  accepted(id: 'accepted', emoji: '🎉', labelKu: 'Pejirandî'),

  /// Admin öneriyi reddetti.
  dismissed(id: 'dismissed', emoji: '❌', labelKu: 'Redkirî');

  final String id;
  final String emoji;
  final String labelKu;

  const ReviewStatus({
    required this.id,
    required this.emoji,
    required this.labelKu,
  });

  static ReviewStatus fromId(String id) {
    return ReviewStatus.values.firstWhere(
      (e) => e.id == id,
      orElse: () => ReviewStatus.suggested,
    );
  }
}

/// Tek bir review kaydı.
class ContentReview {
  /// Firestore document ID (otomatik veya custom).
  final String id;

  /// İçerik türü.
  final ReviewContentType contentType;

  /// İçeriğin kendine özgü kimliği (örn. 'ku_a1_051', 'quiz_a2_12').
  final String contentId;

  /// Review edilen asıl metin.
  final String originalText;

  /// Varsa bağlam (örn. soru metni, dialog cümlesi).
  final String? contextText;

  /// CEFR seviyesi (A1-C2) veya 'child' / 'ui'.
  final String level;

  final ReviewStatus status;

  /// Öneri durumunda: uzmanın önerisi.
  final String? suggestedText;

  /// Opsiyonel not (özellikle flagged için).
  final String? note;

  final String reviewerUid;
  final String reviewerEmail;

  final DateTime createdAt;
  final DateTime? updatedAt;

  /// Admin notu (accepted/dismissed olduğunda).
  final String? adminNote;

  const ContentReview({
    required this.id,
    required this.contentType,
    required this.contentId,
    required this.originalText,
    this.contextText,
    required this.level,
    required this.status,
    this.suggestedText,
    this.note,
    required this.reviewerUid,
    required this.reviewerEmail,
    required this.createdAt,
    this.updatedAt,
    this.adminNote,
  });

  ContentReview copyWith({
    ReviewStatus? status,
    String? suggestedText,
    String? note,
    String? adminNote,
    DateTime? updatedAt,
  }) =>
      ContentReview(
        id: id,
        contentType: contentType,
        contentId: contentId,
        originalText: originalText,
        contextText: contextText,
        level: level,
        status: status ?? this.status,
        suggestedText: suggestedText ?? this.suggestedText,
        note: note ?? this.note,
        reviewerUid: reviewerUid,
        reviewerEmail: reviewerEmail,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        adminNote: adminNote ?? this.adminNote,
      );

  Map<String, dynamic> toJson() => {
        'contentType': contentType.id,
        'contentId': contentId,
        'originalText': originalText,
        if (contextText != null) 'contextText': contextText,
        'level': level,
        'status': status.id,
        if (suggestedText != null) 'suggestedText': suggestedText,
        if (note != null) 'note': note,
        'reviewerUid': reviewerUid,
        'reviewerEmail': reviewerEmail,
        'createdAt': createdAt.toIso8601String(),
        if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
        if (adminNote != null) 'adminNote': adminNote,
      };

  factory ContentReview.fromJson(String id, Map<String, dynamic> json) =>
      ContentReview(
        id: id,
        contentType: ReviewContentType.fromId(json['contentType'] as String? ?? 'word_ku'),
        contentId: json['contentId'] as String? ?? '',
        originalText: json['originalText'] as String? ?? '',
        contextText: json['contextText'] as String?,
        level: json['level'] as String? ?? 'A1',
        status: ReviewStatus.fromId(json['status'] as String? ?? 'suggested'),
        suggestedText: json['suggestedText'] as String?,
        note: json['note'] as String?,
        reviewerUid: json['reviewerUid'] as String? ?? '',
        reviewerEmail: json['reviewerEmail'] as String? ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'] as String)
            : null,
        adminNote: json['adminNote'] as String?,
      );
}

/// İçerik listesi için tek bir inceleme öğesi (Firestore öncesi, in-memory).
class ReviewableItem {
  /// Kararlı identifier (DB içindeki).
  final String contentId;

  /// Ana Kurmancî metin (gösterilecek).
  final String text;

  /// Opsiyonel bağlam (örn. Türkçe çeviri, soru metni).
  final String? context;

  /// Seviye (A1-C2 veya 'child' / 'ui').
  final String level;

  /// Opsiyonel kategori (örn. 'heywan', 'xwarin' — kelime DB'si için).
  final String? kategori;

  /// Bu öğe hakkında zaten kayıtlı review var mı?
  /// (Firestore'dan ayrıca sorgulanır.)
  final int existingReviewCount;

  const ReviewableItem({
    required this.contentId,
    required this.text,
    this.context,
    required this.level,
    this.kategori,
    this.existingReviewCount = 0,
  });

  ReviewableItem copyWith({int? existingReviewCount}) => ReviewableItem(
        contentId: contentId,
        text: text,
        context: context,
        level: level,
        kategori: kategori,
        existingReviewCount: existingReviewCount ?? this.existingReviewCount,
      );
}
