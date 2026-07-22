import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../features/gamification/gamification_provider.dart';
import '../providers/learning_track_provider.dart';
import '../providers/streak_provider.dart';

// ════════════════════════════════════════════════════════════════
// MINI LEADERBOARD — Pêşbazî (Motivasyonel Siralama)
//
// Ilke §4b: Destekleyici gamification — rekabet degil motivasyon.
// 5 bot + kullanici, haftalik XP siralamasi.
// Bot isimleri gercekci Kurt isimlerinden secilmis.
// ════════════════════════════════════════════════════════════════

/// Simule edilmis bot kullanici.
class _BotLearner {
  final String name;
  final int weeklyXP;
  final String avatar; // Emoji avatar

  const _BotLearner({
    required this.name,
    required this.weeklyXP,
    required this.avatar,
  });
}

/// Siralama satirindaki veri.
class _LeaderboardEntry {
  final int rank;
  final String name;
  final int weeklyXP;
  final String avatar;
  final bool isCurrentUser;

  const _LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.weeklyXP,
    required this.avatar,
    this.isCurrentUser = false,
  });
}

/// Bot isim havuzlari — track'e gore secilir.
///
/// Kurmanci track: gercekci Kurt isimleri (kullanici kendi kulturunu gorur).
/// English track: uluslararasi isimler (tutarli deneyim).
const _kBotNamesKu = [
  'Heval',
  'Dilan',
  'Sinem',
  'Baran',
  'Azad',
  'Roj',
  'Delal',
  'Goran',
];

const _kBotNamesEn = [
  'Alex',
  'Emma',
  'Leo',
  'Maya',
  'Noah',
  'Lily',
  'Kai',
  'Zoe',
];

/// Bot avatarlari.
const _kBotAvatars = [
  '\u{1F9D1}\u{200D}\u{1F393}', // student
  '\u{1F469}\u{200D}\u{1F4BB}', // woman technologist
  '\u{1F468}\u{200D}\u{1F3A8}', // man artist
  '\u{1F9D1}\u{200D}\u{1F52C}', // scientist
  '\u{1F468}\u{200D}\u{1F3EB}', // man teacher
  '\u{1F469}\u{200D}\u{1F3A4}', // woman singer
  '\u{1F9D1}\u{200D}\u{1F680}', // astronaut
  '\u{1F468}\u{200D}\u{2695}\u{FE0F}', // man health worker
];

/// Haftalik bot XP uretici (deterministik seed ile — her hafta degisir).
///
/// [isEnglishTrack] true ise EN isim havuzu kullanilir; aksi halde KU.
/// Seed'e track codu karisir ki ayni hafta iki track'te farkli dagilim olsun.
List<_BotLearner> _generateBots({required bool isEnglishTrack}) {
  // Hafta numarasina gore seed — her hafta farkli siralama
  final now = DateTime.now();
  final weekOfYear = (now.difference(DateTime(now.year, 1, 1)).inDays / 7).floor();
  // Track'e gore farkli seed — ayni isim + ayni XP iki track'te gozukmesin.
  final trackSeed = isEnglishTrack ? 7919 : 1009;
  final rng = Random(now.year * 100 + weekOfYear + trackSeed);

  final namesPool = isEnglishTrack ? _kBotNamesEn : _kBotNamesKu;

  // 5 rastgele bot sec
  final shuffledIndices = List.generate(namesPool.length, (i) => i)
    ..shuffle(rng);
  final selectedIndices = shuffledIndices.take(5).toList();

  return selectedIndices.map((i) {
    final xp = 50 + rng.nextInt(451); // 50-500 arasi
    return _BotLearner(
      name: namesPool[i],
      weeklyXP: xp,
      avatar: _kBotAvatars[i],
    );
  }).toList();
}

// ════════════════════════════════════════════════════════════════
// LEADERBOARD WIDGET
// ════════════════════════════════════════════════════════════════

class LeaderboardWidget extends ConsumerWidget {
  const LeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);
    final track = ref.watch(currentTrackProvider);
    final isEn = track.isEnglish;

    // Kullanicinin haftalik XP tahmini:
    // 1) streak.todayXP * 7 (gunluk kelime review — bugun hic review yapmamissa 0).
    // 2) gamificationProvider uzerinden son 7 gunun XP toplami (canli veri).
    //    Bu, ders tamamlaninca addXP ile logalanir.
    // Ikisinden buyugunu sec — ogrenci ne yapiyorsa onun uzerinden siralansin.
    final gami = ref.watch(gamificationProvider);
    final userWeeklyXP = streak.todayXP * 7 > 0
        ? streak.todayXP * 7
        : (gami.totalXP > 0 ? (gami.totalXP ~/ 4).clamp(0, 600) : 0);

    // Botlari olustur — track'e gore KU veya EN isim havuzu
    final bots = _generateBots(isEnglishTrack: isEn);

    // "Sen" etiketi track'e gore: Kurmanci "Tu" / English "You"
    final meLabel = isEn ? 'You' : 'Tu';

    // Kullaniciyi ekle ve sirala
    final entries = <_LeaderboardEntry>[];
    final allParticipants = [
      ...bots.map((b) => _LeaderboardEntry(
            rank: 0,
            name: b.name,
            weeklyXP: b.weeklyXP,
            avatar: b.avatar,
          )),
      _LeaderboardEntry(
        rank: 0,
        name: meLabel,
        weeklyXP: userWeeklyXP,
        avatar: '\u{2B50}', // star
        isCurrentUser: true,
      ),
    ];

    // XP'ye gore sirala (buyukten kucuge)
    allParticipants.sort((a, b) => b.weeklyXP.compareTo(a.weeklyXP));

    // Siralama numarasi ata
    for (int i = 0; i < allParticipants.length; i++) {
      final p = allParticipants[i];
      entries.add(_LeaderboardEntry(
        rank: i + 1,
        name: p.name,
        weeklyXP: p.weeklyXP,
        avatar: p.avatar,
        isCurrentUser: p.isCurrentUser,
      ));
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.leaderboard_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  isEn ? 'Leaderboard' : 'Pêşbazî',
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    isEn ? 'This week' : 'Vê hefteyê',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.borderLight),

          // Leaderboard rows
          ...entries.asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final entry = mapEntry.value;
            return _LeaderboardRow(
              entry: entry,
              animationDelay: Duration(milliseconds: 100 + index * 80),
            );
          }),

          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// LEADERBOARD ROW
// ════════════════════════════════════════════════════════════════

class _LeaderboardRow extends StatelessWidget {
  final _LeaderboardEntry entry;
  final Duration animationDelay;

  const _LeaderboardRow({
    required this.entry,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? AppColors.primarySurface
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: entry.isCurrentUser
            ? Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          // Rank indicator
          SizedBox(
            width: 28,
            child: _buildRankWidget(),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Avatar
          Text(
            entry.avatar,
            style: const TextStyle(fontSize: 22),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Name — kullanicinin "sen" isareti zaten isme katilmis durumda
          // (build() icinde "Tu" veya "You" olarak secildi). Tekrar
          // "(ez)" eklemiyoruz; Kurmanci "Tu" / English "You" tutarli kalsin.
          Expanded(
            child: Text(
              entry.name,
              style: AppTypography.label.copyWith(
                color: entry.isCurrentUser
                    ? AppColors.primary
                    : AppColors.textPrimary,
                fontWeight: entry.isCurrentUser
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),

          // XP
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: entry.isCurrentUser
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.accentSurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(
              '${entry.weeklyXP} XP',
              style: AppTypography.labelSmall.copyWith(
                color: entry.isCurrentUser
                    ? AppColors.primary
                    : AppColors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: animationDelay, duration: 300.ms)
        .slideX(begin: 0.1, end: 0, delay: animationDelay, duration: 300.ms);
  }

  Widget _buildRankWidget() {
    switch (entry.rank) {
      case 1:
        return const Icon(
          Icons.workspace_premium_rounded,
          color: AppColors.badgeGold,
          size: 24,
        );
      case 2:
        return const Icon(
          Icons.workspace_premium_rounded,
          color: AppColors.badgeSilver,
          size: 22,
        );
      case 3:
        return const Icon(
          Icons.workspace_premium_rounded,
          color: AppColors.badgeBronze,
          size: 20,
        );
      default:
        return Text(
          '${entry.rank}',
          textAlign: TextAlign.center,
          style: AppTypography.label.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }
}
