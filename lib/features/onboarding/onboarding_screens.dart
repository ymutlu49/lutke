import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';

// ════════════════════════════════════════════════════════════════
// ONBOARDING EKRANLARI — LÛTKE
//
// İlke §2: "Feel first, play second"
// İlke §0.5: Kurmancî birincil dil
// İlke §9b bulgu #5: Lehçe şeffaflığı (Zazaca)
// ════════════════════════════════════════════════════════════════

// ── LEHÇE SEÇİMİ ─────────────────────────────────────────────
// İlke §7.1, §9b bulgu #5: Zazaca şeffaf yönlendirme

class DialectSelectScreen extends StatelessWidget {
  const DialectSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingBase(
      step: 1,
      totalSteps: 4,
      child: Column(
        children: [
          _OnboardingHeader(
            kuTitle: 'Zaravaya xwe hilbijêre',
            trTitle: 'Lehçeni seç',
            icon: Icons.language_outlined,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Kurmancî seçeneği
          _DialectCard(
            name: 'Kurmancî',
            subtitle: 'Kuzey Kürtçe — Bakurê Kurdistanê',
            isRecommended: true,
            onTap: () => context.push(AppRoutes.scenarioSelect),
          ),

          const SizedBox(height: AppSpacing.md),

          // Zazaca — şeffaf yönlendirme (İlke §9b #5)
          _DialectCard(
            name: 'Zazakî',
            subtitle: 'Zazaca — Dimilî',
            isRecommended: false,
            onTap: () => _showZazaInfo(context),
          ),
        ],
      ),
    );
  }

  void _showZazaInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Zazakî û Kurmancî',
              style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              // İlke §9b #5: Şeffaf ve kullanıcıyı kaybetmeyen mesaj
              'Zazakî û Kurmancî zimên xwişk û bira ne — lê du zimanên cuda ne.\n\n'
              'Em niha Kurmancî hîn dikin. Tu dikari bi Kurmancî dest pê bikî.\n'
              'Piştî demekê Zazakî jî dê were zêdekirin.',
              style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.push(AppRoutes.scenarioSelect);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'Bi Kurmancî dest pê bike',
                style: AppTypography.labelLarge.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialectCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isRecommended;
  final VoidCallback onTap;

  const _DialectCard({
    required this.name,
    required this.subtitle,
    required this.isRecommended,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSpacing.touchLarge),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRecommended
                ? AppColors.primary
                : AppColors.border,
            width: isRecommended ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isRecommended
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.backgroundSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isRecommended
                    ? Icons.star_rounded
                    : Icons.language_outlined,
                color: isRecommended
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: AppTypography.labelLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700)),
                      if (isRecommended) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Pêşniyar',
                              style: AppTypography.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ],
                  ),
                  Text(subtitle,
                      style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

// ── SENARYO SEÇİMİ ───────────────────────────────────────────
// İlke §7.1: Heritage (Rêya Malê) / Genel (Rêya Nû) yol ayrımı
// İlke §9b #4: İlişki senaryosu bazlı isimlendirme

class ScenarioSelectScreen extends StatelessWidget {
  const ScenarioSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _OnboardingBase(
      step: 2,
      totalSteps: 4,
      child: Column(
        children: [
          _OnboardingHeader(
            kuTitle: 'Rêya xwe hilbijêre',
            trTitle: 'Yolunu seç',
            icon: Icons.fork_right_outlined,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Heritage yolu — İlke §7.1
          _ScenarioCard(
            kuTitle: 'Rêya Malê',
            trTitle: 'Ev Yolu — Heritage',
            description:
                'Malbata te Kurmancî dipeyive an tu berê fêr bûyî.\n'
                '"Büyükanneyle çay, sofrada, telefonda annem"',
            icon: Icons.home_outlined,
            isPrimary: true,
            onTap: () => context.push(AppRoutes.goalSelect),
          ),

          const SizedBox(height: AppSpacing.md),

          // Genel yol
          _ScenarioCard(
            kuTitle: 'Rêya Nû',
            trTitle: 'Yeni Yol — Sıfırdan',
            description:
                'Kurmancîyê ji destpêkê fêr dibî.\n'
                'Alfabe → Dengên → Rojane jiyan',
            icon: Icons.school_outlined,
            isPrimary: false,
            onTap: () => context.push(AppRoutes.goalSelect),
          ),
        ],
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final String kuTitle;
  final String trTitle;
  final String description;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ScenarioCard({
    required this.kuTitle,
    required this.trTitle,
    required this.description,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSpacing.touchLarge),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primary.withOpacity(0.04)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPrimary ? AppColors.primary : AppColors.border,
            width: isPrimary ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon,
                    color: isPrimary
                        ? AppColors.primary
                        : AppColors.textSecondary),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kurmancî önce — İlke §0.5
                    Text(kuTitle,
                        style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700)),
                    Text(trTitle,
                        style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary)),
                  ],
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.textSecondary),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(description,
                style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5)),
          ],
        ),
      ),
    );
  }
}

// ── HEDEF SEÇİMİ ─────────────────────────────────────────────
// İlke §9b: Haftalık ritim — günlük hedef esnekliği

class GoalSelectScreen extends StatefulWidget {
  const GoalSelectScreen({super.key});

  @override
  State<GoalSelectScreen> createState() => _GoalSelectScreenState();
}

class _GoalSelectScreenState extends State<GoalSelectScreen> {
  int _selectedGoal = 20;

  final _goals = [
    (10, 'Sivik', 'Hêsanî — ~5 dk', Icons.coffee_outlined),
    (20, 'Navîn', 'Pêşniyar — ~10 dk', Icons.local_library_outlined),
    (30, 'Dijwar', 'Zêde pêşve — ~15 dk', Icons.rocket_launch_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // İlerleme çubuğu
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md + (statusBarHeight > 0 ? 0 : AppSpacing.sm),
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: AppSpacing.touchMin,
                    height: AppSpacing.touchMin,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 3 / 4,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('3/4',
                      style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary)),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    _OnboardingHeader(
                      kuTitle: 'Armanca rojane',
                      trTitle: 'Günlük hedef',
                      icon: Icons.flag_outlined,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    ..._goals.map((g) {
                      final (count, kuLabel, trLabel, icon) = g;
                      final isSelected = _selectedGoal == count;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedGoal = count),
                          child: AnimatedContainer(
                            duration: 200.ms,
                            constraints: const BoxConstraints(minHeight: AppSpacing.touchLarge),
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.08)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(icon,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textSecondary),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Kurmancî önce (§0.5)
                                      Text('$count peyv — $kuLabel',
                                          style: AppTypography.labelLarge.copyWith(
                                              color: AppColors.textPrimary,
                                              fontWeight: FontWeight.w700)),
                                      Text(trLabel,
                                          style: AppTypography.caption.copyWith(
                                              color: AppColors.textSecondary)),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(Icons.check_circle,
                                      color: AppColors.primary),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Pinned bottom button
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md + (bottomPadding > 0 ? 0 : AppSpacing.md),
              ),
              child: ElevatedButton(
                onPressed: () => context.push(AppRoutes.firstLesson),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, AppSpacing.touchPreferred),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text(
                  'Dest pê bike! — Başla!',
                  style: AppTypography.labelLarge.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── AYARLAR EKRANI ────────────────────────────────────────────
// İlke §8.2: Disleksi + erişilebilirlik

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: Text(
          'Mîhengên — Ayarlar',
          style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md + MediaQuery.of(context).padding.bottom + AppSpacing.lg,
        ),
        children: [
          _SettingsSection(
            title: 'Ziman — Dil',
            children: const [
              _SettingsTile(
                title: 'Zimanê navnîşê',
                subtitle: 'Kurmancî / Türkçe / English',
                icon: Icons.translate,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SettingsSection(
            title: 'Gihîştbarî — Erişilebilirlik',
            children: const [
              _SettingsTile(
                title: 'Tîpên OpenDyslexic',
                subtitle: 'Prof. Dr. Y. Mutlu araştırması',
                icon: Icons.font_download_outlined,
              ),
              _SettingsTile(
                title: 'Tîpên mezin',
                subtitle: 'Yazı boyutunu artır',
                icon: Icons.text_increase,
              ),
              _SettingsTile(
                title: 'Livîn kêm bike',
                subtitle: 'Animasyonları azalt',
                icon: Icons.animation,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SettingsSection(
            title: 'Agahî — Bildirimler',
            children: const [
              _SettingsTile(
                title: 'Bîranîna rojane',
                subtitle: 'Günlük hatırlatıcı',
                icon: Icons.notifications_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppSpacing.sm, bottom: AppSpacing.xs),
          child: Text(title,
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title,
          style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary)),
      subtitle: Text(subtitle,
          style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary)),
      trailing: Switch(
        value: false,
        onChanged: (_) {},
        activeColor: AppColors.primary,
      ),
    );
  }
}

// ── HATA EKRANI ───────────────────────────────────────────────
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 64, color: AppColors.primary.withOpacity(0.5)),
              const SizedBox(height: AppSpacing.lg),
              Text('Rê nehat dîtin',
                  style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textPrimary)),
              const SizedBox(height: AppSpacing.sm),
              Text('Rûpel tune ye. — Sayfa bulunamadı.',
                  style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton.icon(
                onPressed: () => context.go(AppRoutes.home),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Vegere serê — Ana Sayfa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ORTAK ONBOARDING YAPILAR
// ════════════════════════════════════════════════════════════════

class _OnboardingBase extends StatelessWidget {
  final int step;
  final int totalSteps;
  final Widget child;

  const _OnboardingBase({
    required this.step,
    required this.totalSteps,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // İlerleme çubuğu — status bar spacing
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md + (statusBarHeight > 0 ? 0 : AppSpacing.sm),
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  if (step > 1)
                    SizedBox(
                      width: AppSpacing.touchMin,
                      height: AppSpacing.touchMin,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: step / totalSteps,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('$step/$totalSteps',
                      style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary)),
                ],
              ),
            ),

            // İçerik — bottom padding for gesture navigation
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg + (bottomPadding > 0 ? bottomPadding : AppSpacing.xl),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingHeader extends StatelessWidget {
  final String kuTitle;
  final String trTitle;
  final IconData icon;

  const _OnboardingHeader({
    required this.kuTitle,
    required this.trTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 32),
        ).animate().scale(curve: Curves.elasticOut, duration: 500.ms),
        const SizedBox(height: AppSpacing.md),
        // Kurmancî önce — İlke §0.5
        Text(kuTitle,
            style: AppTypography.headingMedium.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(trTitle,
            style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary),
            textAlign: TextAlign.center),
      ],
    );
  }
}
