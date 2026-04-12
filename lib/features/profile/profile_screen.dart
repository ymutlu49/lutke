import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../lessons/data/lesson_repository.dart';
import '../../features/lessons/data/lesson_repository.dart';

// ════════════════════════════════════════════════════════════════
// PROFİL EKRANI — LÛTKE
// İlke §0.5: Kurmancî birincil
// İlke §1: Kimlik odaklı profil (asimilasyon yolculuğu)
// İlke §8: WCAG 2.2 AA erişilebilirlik
// ════════════════════════════════════════════════════════════════

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider);
    final userId = user?.uid ?? 'anonymous';

    final dailyStats = ref.watch(dailyStatsProvider(userId));

    // Tüm seviyeler için ilerleme
    final levelProgresses = [1,2,3,4,5,6].map(
      (lvl) => ref.watch(levelProgressProvider((userId: userId, level: lvl))),
    ).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Üst Bar ──────────────────────────────────────
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.backgroundPrimary,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Profîla min', // Profilim — Kurmancî (İlke §0.5)
                style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w700),
              ),
              actions: [
                // Ayarlar
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => context.push(AppRoutes.settings),
                ),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([

                  // ── Kullanıcı Kimliği ─────────────────────
                  _ProfileHeader(
                    displayName: profile.displayName.isNotEmpty
                        ? profile.displayName
                        : user?.displayName ?? 'Heval',
                    currentLevel: profile.currentLevel.toUpperCase(),
                    isHeritage: profile.isHeritage,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Özet İstatistikler ────────────────────
                  dailyStats.when(
                    data: (s) => _StatsRow(
                      totalReviewed: s.totalReviewed,
                      accuracy: s.accuracy,
                      streakDays: s.streakDays,
                      xpToday: s.xpToday,
                    ),
                    loading: () => const _StatsRow(
                      totalReviewed: 0, accuracy: 0, streakDays: 0, xpToday: 0),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ── CEFR Haritası ─────────────────────────
                  // Kullanıcının ilerleme yolculuğu
                  _CEFRMap(
                    currentLevel: profile.currentLevelNum,
                    progresses: levelProgresses,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Motivasyon Çapası ─────────────────────
                  // İlke §9b bulgu #2
                  _MotivationCard(motivation: profile.motivation.labelTr),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Erişilebilirlik Ayarları ──────────────
                  // İlke §8.2: Disleksi desteği
                  _AccessibilityCard(),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Hesap Eylemleri ───────────────────────
                  _AccountActions(
                    isAnonymous: user?.isAnonymous ?? true,
                    ref: ref,
                    context: context,
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// PROFİL BAŞLIĞI
// ════════════════════════════════════════════════════════════════

class _ProfileHeader extends StatelessWidget {
  final String displayName;
  final String currentLevel;
  final bool isHeritage;

  const _ProfileHeader({
    required this.displayName,
    required this.currentLevel,
    required this.isHeritage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.primary.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Text(
              displayName.isNotEmpty ? displayName[0].toUpperCase() : 'H',
              style: AppTypography.headingLarge.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _LevelBadge(level: currentLevel),
                    const SizedBox(width: 8),
                    if (isHeritage)
                      _HeritageBadge(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}

class _LevelBadge extends StatelessWidget {
  final String level;
  const _LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      'Asta $level',
      style: AppTypography.caption.copyWith(
          color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
}

class _HeritageBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.accent.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.accent.withOpacity(0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.home_outlined, size: 12, color: AppColors.accent),
        const SizedBox(width: 4),
        Text('Heritage',
            style: AppTypography.caption.copyWith(
                color: AppColors.accent, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════
// İSTATİSTİK SATIRI
// ════════════════════════════════════════════════════════════════

class _StatsRow extends StatelessWidget {
  final int totalReviewed;
  final double accuracy;
  final int streakDays;
  final int xpToday;

  const _StatsRow({
    required this.totalReviewed,
    required this.accuracy,
    required this.streakDays,
    required this.xpToday,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(
          label: 'Peyv îro',
          value: '$totalReviewed',
          icon: Icons.layers_outlined,
        )),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _StatCard(
          label: 'Rast',
          value: '${(accuracy * 100).round()}%',
          icon: Icons.check_circle_outline,
        )),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _StatCard(
          label: 'Roj',
          value: '$streakDays 🔥',
          icon: Icons.local_fire_department_outlined,
        )),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _StatCard(
          label: 'XP',
          value: '+$xpToday',
          icon: Icons.star_outline,
        )),
      ],
    ).animate().fadeIn(delay: 150.ms);
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.04), blurRadius: 8)],
    ),
    child: Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(value, style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        Text(label, style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary)),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════
// CEFR HARİTASI — İlerleme yolculuğu
// ════════════════════════════════════════════════════════════════

class _CEFRMap extends StatelessWidget {
  final int currentLevel;
  final List<AsyncValue<LevelProgress>> progresses;

  const _CEFRMap({required this.currentLevel, required this.progresses});

  @override
  Widget build(BuildContext context) {
    const levels = ['A1','A2','B1','B2','C1','C2'];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rêya fêrbûnê', // Öğrenme yolu
              style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.md),
          ...levels.asMap().entries.map((entry) {
            final i = entry.key;
            final level = entry.value;
            final isActive = i + 1 == currentLevel;
            final isCompleted = i + 1 < currentLevel;
            final progress = progresses[i];

            return _CEFRLevel(
              level: level,
              isActive: isActive,
              isCompleted: isCompleted,
              progressAsync: progress,
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}

class _CEFRLevel extends StatelessWidget {
  final String level;
  final bool isActive;
  final bool isCompleted;
  final AsyncValue<LevelProgress> progressAsync;

  const _CEFRLevel({
    required this.level,
    required this.isActive,
    required this.isCompleted,
    required this.progressAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          // Seviye rozeti
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.primary
                  : isActive
                      ? AppColors.primary.withOpacity(0.15)
                      : AppColors.backgroundSecondary,
              shape: BoxShape.circle,
              border: isActive
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      level,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // İlerleme çubuğu
          Expanded(
            child: progressAsync.when(
              data: (p) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Asta $level',
                        style: AppTypography.caption.copyWith(
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                      Text(
                        '${p.learnedCards}/${p.totalCards}',
                        style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: p.completionPercent,
                      backgroundColor: AppColors.primary.withOpacity(0.08),
                      valueColor: AlwaysStoppedAnimation(
                        isActive ? AppColors.primary : AppColors.primary.withOpacity(0.4),
                      ),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
              loading: () => const SizedBox(height: 24),
              error: (_, __) => const SizedBox(height: 24),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// MOTİVASYON ÇAPASI
// İlke §9b bulgu #2
// ════════════════════════════════════════════════════════════════

class _MotivationCard extends StatelessWidget {
  final String motivation;
  const _MotivationCard({required this.motivation});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(Icons.favorite_outline, color: AppColors.accent, size: 24),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Motivasyona te', // Motivasyonun
                  style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary)),
              Text(motivation,
                  style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════════
// ERİŞİLEBİLİRLİK KARTI
// İlke §8.2: Disleksi desteği, Prof. Dr. Yılmaz Mutlu
// ════════════════════════════════════════════════════════════════

class _AccessibilityCard extends StatefulWidget {
  @override
  State<_AccessibilityCard> createState() => _AccessibilityCardState();
}

class _AccessibilityCardState extends State<_AccessibilityCard> {
  bool _dyslexicFont = false;
  bool _largeText = false;
  bool _reduceMotion = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gihîştbarî', // Erişilebilirlik
              style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          // Disleksi fontu
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text('Tîpên disleksiyê',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textPrimary)),
            subtitle: Text('OpenDyslexic font',
                style: AppTypography.caption
                    .copyWith(color: AppColors.textSecondary)),
            value: _dyslexicFont,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _dyslexicFont = v),
          ),
          // Büyük metin
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text('Tîpên mezin',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textPrimary)),
            value: _largeText,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _largeText = v),
          ),
          // Animasyonları azalt
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text('Livîn kêm bike', // Animasyonları azalt
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textPrimary)),
            value: _reduceMotion,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _reduceMotion = v),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HESAP EYLEMLERİ
// ════════════════════════════════════════════════════════════════

class _AccountActions extends StatelessWidget {
  final bool isAnonymous;
  final WidgetRef ref;
  final BuildContext context;

  const _AccountActions({
    required this.isAnonymous,
    required this.ref,
    required this.context,
  });

  Future<void> _signOut() async {
    await ref.read(authServiceProvider).signOut();
    if (context.mounted) context.go(AppRoutes.splash);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hesap kaydı (anonim ise)
        if (isAnonymous)
          OutlinedButton.icon(
            onPressed: () => context.push(AppRoutes.register),
            icon: const Icon(Icons.person_add_outlined),
            label: const Text('Hesabê xwe biparêze'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              side: BorderSide(color: AppColors.primary),
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),

        if (isAnonymous) const SizedBox(height: AppSpacing.sm),

        // Çıkış
        OutlinedButton.icon(
          onPressed: _signOut,
          icon: const Icon(Icons.logout_outlined),
          label: const Text('Derkeve — Çıkış'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            side: BorderSide(color: AppColors.border),
            foregroundColor: AppColors.textSecondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }
}
