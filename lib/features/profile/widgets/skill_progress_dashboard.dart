import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/providers/learning_module_provider.dart';
import '../../../shared/services/skill_progress_service.dart';

/// 6 dil becerisi için görsel ilerleme gösterge paneli.
///
/// Modül filtre toggle'ı ile Kurmancî / English / Hemû karşılaştırması yapılır.
/// Her beceri için yatay XP bar chart + rozet eşiği göstergesi.
class SkillProgressDashboard extends ConsumerStatefulWidget {
  const SkillProgressDashboard({super.key});

  @override
  ConsumerState<SkillProgressDashboard> createState() =>
      _SkillProgressDashboardState();
}

class _SkillProgressDashboardState
    extends ConsumerState<SkillProgressDashboard> {
  /// 0 = aktif modül, 1 = Kurmancî, 2 = English, 3 = Hemû (yan yana)
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isEn = ref.watch(isEnglishModuleProvider);
    // İLERLEME FIX: Beceri kaydı yazılınca (markSkillCompletedAndNotify
    // version bump'i) panel açıkken de tazelensin — aksi halde FutureBuilder
    // yalnız widget yeniden kurulunca güncel veriyi çekiyordu.
    ref.watch(skillProgressVersionProvider);
    final activeModule = isEn ? 'en' : 'ku';

    final skills = const [
      _SkillDef('grammar', '📘', 'Gramer', Color(0xFF3F51B5)),
      _SkillDef('writing', '✍️', 'Nivîsîn', Color(0xFF7B1FA2)),
      _SkillDef('reading', '📖', 'Xwendin', Color(0xFFEF6C00)),
      _SkillDef('listening', '👂', 'Guhdarîkirin', Color(0xFF00838F)),
      _SkillDef('speaking', '🗣️', 'Axaftin', Color(0xFFD81B60)),
      _SkillDef('quiz', '🎯', 'Test', Color(0xFF43A047)),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📊', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Jêhatîyên min',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _FilterToggle(
            activeIndex: _filterIndex,
            activeModule: activeModule,
            onChanged: (i) => setState(() => _filterIndex = i),
          ),
          const SizedBox(height: AppSpacing.md),
          for (int i = 0; i < skills.length; i++) ...[
            _SkillBarChart(
              skill: skills[i],
              mode: _chartMode(activeModule),
            ),
            if (i < skills.length - 1) const SizedBox(height: 12),
          ],
          const SizedBox(height: AppSpacing.md),
          _TotalXpFooter(mode: _chartMode(activeModule)),
        ],
      ),
    );
  }

  _ChartMode _chartMode(String activeModule) {
    switch (_filterIndex) {
      case 1:
        return _ChartMode.single('ku', 'Kurmancî');
      case 2:
        return _ChartMode.single('en', 'English');
      case 3:
        return _ChartMode.compare();
      case 0:
      default:
        return _ChartMode.single(
          activeModule,
          activeModule == 'en' ? 'English' : 'Kurmancî',
        );
    }
  }
}

// ════════════════════════════════════════════════════════════════
// Filtre toggle — 4 seçenek: Çalan | KU | EN | Hemû
// ════════════════════════════════════════════════════════════════

class _FilterToggle extends StatelessWidget {
  final int activeIndex;
  final String activeModule;
  final ValueChanged<int> onChanged;

  const _FilterToggle({
    required this.activeIndex,
    required this.activeModule,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      activeModule == 'en' ? '🌍 Çalak' : '🐐 Çalak',
      '🐐 Kurmancî',
      '🌍 English',
      '📈 Hemû',
    ];

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(options.length, (i) {
          final isActive = i == activeIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    options[i],
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: isActive
                          ? Colors.white
                          : AppColors.primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Chart modu — tek modül veya karşılaştırma
// ════════════════════════════════════════════════════════════════

class _ChartMode {
  final bool compare;
  final String? module;
  final String? label;

  const _ChartMode._({required this.compare, this.module, this.label});

  factory _ChartMode.single(String module, String label) =>
      _ChartMode._(compare: false, module: module, label: label);

  factory _ChartMode.compare() => const _ChartMode._(compare: true);
}

// ════════════════════════════════════════════════════════════════
// Beceri bar chart — tek veya karşılaştırmalı
//
// Rozet eşikleri: 50 XP (Bronz), 200 XP (Gümüş), 500 XP (Altın)
// ════════════════════════════════════════════════════════════════

const _xpTargetBronze = 50;
const _xpTargetSilver = 200;
const _xpTargetGold = 500;

class _SkillBarChart extends StatelessWidget {
  final _SkillDef skill;
  final _ChartMode mode;

  const _SkillBarChart({required this.skill, required this.mode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_SkillData>(
      future: _load(),
      builder: (_, snap) {
        final data = snap.data ?? const _SkillData(0, 0, 0, 0);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SkillIcon(skill: skill),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          skill.titleKu,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _tierBadge(_maxXp(data)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (mode.compare)
                    _compareBars(data)
                  else
                    _singleBar(data, mode),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  int _maxXp(_SkillData d) =>
      d.kuXp > d.enXp ? d.kuXp : d.enXp;

  Widget _compareBars(_SkillData d) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarRow(
            label: '🐐 KU',
            xp: d.kuXp,
            completed: d.kuCompleted,
            color: skill.color,
          ),
          const SizedBox(height: 4),
          _BarRow(
            label: '🌍 EN',
            xp: d.enXp,
            completed: d.enCompleted,
            color: skill.color.withValues(alpha: 0.55),
          ),
        ],
      );

  Widget _singleBar(_SkillData d, _ChartMode mode) {
    final xp = mode.module == 'en' ? d.enXp : d.kuXp;
    final completed = mode.module == 'en' ? d.enCompleted : d.kuCompleted;
    return _BarRow(
      label: '${mode.label}',
      xp: xp,
      completed: completed,
      color: skill.color,
      showLabel: false,
    );
  }

  Widget _tierBadge(int xp) {
    String emoji;
    String label;
    Color color;
    if (xp >= _xpTargetGold) {
      emoji = '🥇';
      label = 'Zêr';
      color = const Color(0xFFFFB300);
    } else if (xp >= _xpTargetSilver) {
      emoji = '🥈';
      label = 'Zîv';
      color = const Color(0xFF90A4AE);
    } else if (xp >= _xpTargetBronze) {
      emoji = '🥉';
      // NOT: "Birinc" = pirinç (yiyecek); bronz madde için "Bronz" doğru.
      label = 'Bronz';
      color = const Color(0xFFA1887F);
    } else {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Future<_SkillData> _load() async {
    final kuXp = await SkillProgressService.getXp(module: 'ku', skill: skill.id);
    final enXp = await SkillProgressService.getXp(module: 'en', skill: skill.id);
    final kuC = await SkillProgressService.getCompleted(module: 'ku', skill: skill.id);
    final enC = await SkillProgressService.getCompleted(module: 'en', skill: skill.id);
    return _SkillData(kuXp, enXp, kuC, enC);
  }
}

class _SkillData {
  final int kuXp;
  final int enXp;
  final int kuCompleted;
  final int enCompleted;
  const _SkillData(this.kuXp, this.enXp, this.kuCompleted, this.enCompleted);
}

class _SkillIcon extends StatelessWidget {
  final _SkillDef skill;
  const _SkillIcon({required this.skill});

  @override
  Widget build(BuildContext context) => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: skill.color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(skill.emoji, style: const TextStyle(fontSize: 18)),
      );
}

// ════════════════════════════════════════════════════════════════
// Tek bar çizim — XP değerini göster, rozet eşiklerine göre ilerleme
// ════════════════════════════════════════════════════════════════

class _BarRow extends StatelessWidget {
  final String label;
  final int xp;
  final int completed;
  final Color color;
  final bool showLabel;

  const _BarRow({
    required this.label,
    required this.xp,
    required this.completed,
    required this.color,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final (progress, nextTarget, tierLabel) = _progressToNextTier(xp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (showLabel) ...[
              SizedBox(
                width: 42,
                child: Text(
                  label,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  _barBackground(color),
                  _barFill(color, progress),
                  _tierTicks(color),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 64,
              child: Text(
                '$xp XP',
                style: AppTypography.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        if (xp < _xpTargetGold)
          Padding(
            padding: EdgeInsets.only(top: 3, left: showLabel ? 48 : 0),
            child: Text(
              '$tierLabel: ${nextTarget - xp} XP maye · $completed çalakî',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
                fontSize: 9.5,
              ),
            ),
          ),
      ],
    );
  }

  (double, int, String) _progressToNextTier(int xp) {
    if (xp < _xpTargetBronze) {
      return (xp / _xpTargetBronze, _xpTargetBronze, '🥉 Birinc');
    }
    if (xp < _xpTargetSilver) {
      return (
        (xp - _xpTargetBronze) / (_xpTargetSilver - _xpTargetBronze),
        _xpTargetSilver,
        '🥈 Zîv',
      );
    }
    if (xp < _xpTargetGold) {
      return (
        (xp - _xpTargetSilver) / (_xpTargetGold - _xpTargetSilver),
        _xpTargetGold,
        '🥇 Zêr',
      );
    }
    return (1.0, _xpTargetGold, '🏆');
  }

  Widget _barBackground(Color color) => Container(
        height: 10,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(5),
        ),
      );

  Widget _barFill(Color color, double progress) => FractionallySizedBox(
        widthFactor: progress.clamp(0.0, 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          height: 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.85),
                color,
              ],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );

  /// Bronz/Gümüş tick'leri (barın üzerinde yerel eşikleri göster)
  Widget _tierTicks(Color color) {
    return LayoutBuilder(
      builder: (_, cts) {
        final w = cts.maxWidth;
        // Bar %0-33 bronz, %33-66 gümüş, %66-100 altın
        // Bronz eşiği %33 (50/150), gümüş %66 (200/300)...
        // Sadece 2 tick gösterelim: 1/3 ve 2/3 noktaları
        return Stack(
          children: [
            Positioned(
              left: w * 0.33,
              top: 1,
              bottom: 1,
              child: Container(width: 1.5, color: Colors.white),
            ),
            Positioned(
              left: w * 0.66,
              top: 1,
              bottom: 1,
              child: Container(width: 1.5, color: Colors.white),
            ),
          ],
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Alt toplam göstergesi
// ════════════════════════════════════════════════════════════════

class _TotalXpFooter extends StatelessWidget {
  final _ChartMode mode;
  const _TotalXpFooter({required this.mode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(int, int)>(
      future: _loadTotals(),
      builder: (_, snap) {
        final (kuTotal, enTotal) = snap.data ?? (0, 0);
        final total = kuTotal + enTotal;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.accent.withValues(alpha: 0.15),
              AppColors.accent.withValues(alpha: 0.05),
            ]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: mode.compare
              ? Row(
                  children: [
                    Expanded(
                      child: _TotalTile(emoji: '🐐', label: 'Kurmancî', value: kuTotal),
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                    Expanded(
                      child: _TotalTile(emoji: '🌍', label: 'English', value: enTotal),
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                    Expanded(
                      child: _TotalTile(emoji: '⭐', label: 'Hemû', value: total),
                    ),
                  ],
                )
              : Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Text(
                      '${mode.label}: ${mode.module == 'en' ? enTotal : kuTotal} XP',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<(int, int)> _loadTotals() async {
    final ku = await SkillProgressService.getTotalXp('ku');
    final en = await SkillProgressService.getTotalXp('en');
    return (ku, en);
  }
}

class _TotalTile extends StatelessWidget {
  final String emoji;
  final String label;
  final int value;

  const _TotalTile({
    required this.emoji,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          Text(
            '$value',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 9.5,
            ),
          ),
        ],
      );
}

class _SkillDef {
  final String id;
  final String emoji;
  final String titleKu;
  final Color color;
  const _SkillDef(this.id, this.emoji, this.titleKu, this.color);
}
