// ════════════════════════════════════════════════════════════════
// LÛTKE — Subscription Domain Model
//
// Üyelik durumları:
//   none              — yeni kullanıcı, deneme başlamadı
//   trial             — 7 günlük ücretsiz deneme aktif
//   trialExpired      — deneme bitti, abone değil
//   premium           — yıllık abone (299 TL)
//   premiumExpired    — abonelik süresi doldu
//
// Premium Süresi: 365 gün, başlangıç: aktivasyon anı.
// Deneme Süresi: 7 gün.
// Fiyat: 299 ₺ / yıl.
//
// AÇILIŞ TANITIM DÖNEMI (Promo Period):
//   `SubscriptionConstants.promoEndsAt` tarihine kadar bütün uygulama
//   ücretsiz açıktır. `hasFullAccess` getter'ı bu dönemde tier'a
//   bakmadan true döner — gating noktalarında ek kod değişikliği
//   gerekmez. Promo bittiğinde sistem otomatik normal trial/premium
//   akışına döner; mevcut kullanıcı verisi (trialStartedAt, premium
//   expiresAt) korunur.
// ════════════════════════════════════════════════════════════════

enum SubscriptionTier {
  none,
  trial,
  trialExpired,
  premium,
  premiumExpired,
}

extension SubscriptionTierX on SubscriptionTier {
  /// Premium-içerik erişim hakkı var mı?
  /// Promo dönemi (her kullanıcıya ücretsiz tam erişim) aktifse,
  /// tier'a bakılmadan true döner.
  bool get hasFullAccess =>
      SubscriptionConstants.isPromoPeriodActive ||
      this == SubscriptionTier.trial ||
      this == SubscriptionTier.premium;

  /// Deneme veya premium aktif mi?
  bool get isActive => hasFullAccess;

  /// Persist için kısa kod.
  String get code => switch (this) {
        SubscriptionTier.none => 'none',
        SubscriptionTier.trial => 'trial',
        SubscriptionTier.trialExpired => 'trial_expired',
        SubscriptionTier.premium => 'premium',
        SubscriptionTier.premiumExpired => 'premium_expired',
      };

  static SubscriptionTier fromCode(String? c) => switch (c) {
        'trial' => SubscriptionTier.trial,
        'trial_expired' => SubscriptionTier.trialExpired,
        'premium' => SubscriptionTier.premium,
        'premium_expired' => SubscriptionTier.premiumExpired,
        _ => SubscriptionTier.none,
      };
}

class SubscriptionState {
  final SubscriptionTier tier;
  final DateTime? trialStartedAt;
  final DateTime? premiumStartedAt;
  final DateTime? premiumExpiresAt;

  const SubscriptionState({
    required this.tier,
    this.trialStartedAt,
    this.premiumStartedAt,
    this.premiumExpiresAt,
  });

  /// Yeni başlangıç durumu.
  factory SubscriptionState.none() =>
      const SubscriptionState(tier: SubscriptionTier.none);

  /// Aktif erişim — paywall'ı geçer.
  bool get hasFullAccess => tier.hasFullAccess;

  /// Deneme kaç gün kaldı (yalnız tier=trial).
  int? get trialDaysRemaining {
    if (tier != SubscriptionTier.trial || trialStartedAt == null) return null;
    final endDate = trialStartedAt!.add(SubscriptionConstants.trialDuration);
    final remaining = endDate.difference(DateTime.now()).inDays;
    return remaining < 0 ? 0 : remaining + 1; // +1: bugünü dahil et
  }

  /// Premium kaç gün kaldı (yalnız tier=premium).
  int? get premiumDaysRemaining {
    if (tier != SubscriptionTier.premium || premiumExpiresAt == null) {
      return null;
    }
    final remaining = premiumExpiresAt!.difference(DateTime.now()).inDays;
    return remaining < 0 ? 0 : remaining + 1;
  }

  SubscriptionState copyWith({
    SubscriptionTier? tier,
    DateTime? trialStartedAt,
    DateTime? premiumStartedAt,
    DateTime? premiumExpiresAt,
  }) =>
      SubscriptionState(
        tier: tier ?? this.tier,
        trialStartedAt: trialStartedAt ?? this.trialStartedAt,
        premiumStartedAt: premiumStartedAt ?? this.premiumStartedAt,
        premiumExpiresAt: premiumExpiresAt ?? this.premiumExpiresAt,
      );
}

abstract class SubscriptionConstants {
  /// Yıllık abonelik fiyatı (₺). Tek kaynak — tüm UI buradan okur.
  static const int annualPriceTry = 299;

  /// Ücretsiz deneme süresi.
  static const Duration trialDuration = Duration(days: 7);

  /// Premium süresi.
  static const Duration premiumDuration = Duration(days: 365);

  /// Görsel etiket.
  static const String annualPriceLabel = '299 ₺ / sal';

  /// Görsel etiket (Türkçe).
  static const String annualPriceLabelTr = '299 ₺ / yıl';

  // ─── AÇILIŞ TANITIM DÖNEMI ──────────────────────────────────
  /// Promo döneminin biteceği UTC tarih. Bu tarihe kadar bütün
  /// uygulama her kullanıcıya ücretsiz açık.
  ///
  /// Tek satır değişikliği ile dönemi uzatabilirsin. Acil kapatmak
  /// için: bu sabiti geçmişe çek (ör. `2025-01-01`) → tüm sistem
  /// aynı build'de normal trial/premium akışına döner.
  ///
  /// `--dart-define=LUTKE_PROMO_ENDS=YYYY-MM-DD` ile build-time
  /// override mümkün (CI veya farklı kanal için).
  static const String _promoEndsRaw = String.fromEnvironment(
    'LUTKE_PROMO_ENDS',
    defaultValue: '2026-12-31',
  );

  static DateTime get promoEndsAt {
    try {
      return DateTime.parse('${_promoEndsRaw}T23:59:59Z');
    } catch (_) {
      // Geçersiz tarih → promo kapalı say (güvenli default).
      return DateTime.utc(2000, 1, 1);
    }
  }

  /// Promo dönemi şu an aktif mi?
  /// `hasFullAccess` getter'ı buraya bakar — her gating noktası
  /// otomatik bu kontrole tabi olur.
  static bool get isPromoPeriodActive =>
      DateTime.now().toUtc().isBefore(promoEndsAt);

  /// Promo dönemi sonuna kaç gün kaldı (negatif → bitmiş).
  static int get promoDaysRemaining {
    final diff = promoEndsAt.difference(DateTime.now().toUtc()).inDays;
    return diff < 0 ? 0 : diff + 1;
  }

  /// Etiket için Türkçe formatlı bitiş tarihi (örn. "31 Aralık 2026").
  static String get promoEndsLabelTr {
    const months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
    ];
    final d = promoEndsAt;
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  /// Etiket için Kurmancî formatlı bitiş tarihi (örn. "31ê Berfanbarê 2026").
  static String get promoEndsLabelKu {
    const months = [
      'Rêbendanê', 'Reşemiyê', 'Adarê', 'Avrêlê', 'Gulanê', 'Pûşperê',
      'Tîrmehê', 'Gelawêjê', 'Rezberê', 'Kewçêrê', 'Sermawezê', 'Berfanbarê',
    ];
    final d = promoEndsAt;
    return '${d.day}ê ${months[d.month - 1]} ${d.year}';
  }
}
