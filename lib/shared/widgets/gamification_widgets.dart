/// Gamification widget'ları — barrel export
///
/// Tüm gamification bileşenleri features/gamification altında yaşar.
/// Bu dosya, shared/widgets konvansiyonu ile kolay erişim sağlar.
///
/// Kullanılabilir widget'lar:
/// - [XPProgressBar] — XP ilerleme çubuğu (seviye rozeti + animasyonlu dolum)
/// - [AchievementBadgeGrid] — Rozet koleksiyonu grid'i
/// - [LevelUpCelebrationOverlay] — Seviye atlama kutlama overlay'i
/// - [DailyRewardWidget] — Günlük ödül widget'ı (Xelata Rojane)
/// - [BadgeEarnedOverlay] — Rozet kazanma overlay'i
/// - [XPGainAnimation] — XP kazanma popup animasyonu
/// - [WeeklyRhythmWidget] — Haftalık ritim kartı
/// - [WeeklySummaryCard] — Haftalık özet kartı
/// - [BadgeGrid] — Rozet ızgarası (geriye uyumluluk)
export '../../features/gamification/gamification_widgets.dart';
export '../../features/gamification/gamification_provider.dart';
