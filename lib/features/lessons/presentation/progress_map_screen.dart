import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/auth_service.dart';
import '../data/lesson_repository.dart';
import '../domain/entities/vocabulary_card.dart';

// ════════════════════════════════════════════════════════════════
// RÊYA MIN — İlerleme Haritası (Progress Map)
//
// Dağ tırmanışı metaforu ile A1→C2 öğrenme yolculuğu.
// LÛTKE logosu (dağ keçisi + zirve + yıldız) ile uyumlu.
//
// İlke §4.5: İlerleme görselleştirmesi
// İlke §8: WCAG 2.2 AA erişilebilirlik
// ════════════════════════════════════════════════════════════════

class ProgressMapScreen extends ConsumerWidget {
  const ProgressMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider);
    final userId = user?.uid ?? 'anonymous';

    // Her seviye için ilerleme verisini topla
    final levelProgresses = <int, LevelProgress>{};
    for (var i = 1; i <= 6; i++) {
      try {
        final asyncProgress =
            ref.watch(levelProgressProvider((userId: userId, level: i)));
        asyncProgress.whenData((data) => levelProgresses[i] = data);
      } catch (_) {}
    }

    final currentLevelNum = profile.currentLevelNum;

    // Toplam istatistikler
    int totalLearned = 0;
    for (final lp in levelProgresses.values) {
      totalLearned += lp.learnedCards;
    }

    return Scaffold(
      body: Stack(
        children: [
          // ── Gradient Arka Plan ──────────────────────────────────
          const _MountainBackground(),

          // ── Ana İçerik ─────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── Üst Bar ──────────────────────────────────────
                _TopBar(
                  totalLearned: totalLearned,
                  totalXP: profile.totalXP,
                  streakDays: 0, // dailyStats'tan gelecek
                ),

                // ── Dağ Yolu ─────────────────────────────────────
                Expanded(
                  child: _MountainPathView(
                    currentLevel: currentLevelNum,
                    levelProgresses: levelProgresses,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GRADIENT ARKA PLAN — Yeşil çayırdan karanlık zirveye
// ════════════════════════════════════════════════════════════════

class _MountainBackground extends StatelessWidget {
  const _MountainBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFF4CAF50), // Yeşil çayır (A1)
            Color(0xFF388E3C), // Koyu yeşil orman (A2)
            Color(0xFF6D8B74), // Kayalık yeşil-gri (B1)
            Color(0xFF90A4AE), // Bulutlar üstü (B2)
            Color(0xFFCFD8DC), // Kar sınırı (C1)
            Color(0xFF1A2A4A), // Koyu zirve (C2)
          ],
          stops: [0.0, 0.18, 0.38, 0.58, 0.78, 1.0],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ÜST BAR — İstatistikler + geri butonu
// ════════════════════════════════════════════════════════════════

class _TopBar extends StatelessWidget {
  final int totalLearned;
  final int totalXP;
  final int streakDays;

  const _TopBar({
    required this.totalLearned,
    required this.totalXP,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        children: [
          // ── Geri butonu + Başlık ────────────────────────────
          Row(
            children: [
              _GlassButton(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Rêya min',
                style: AppTypography.headline.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              // Yıldız ikonu — toplam kelime
              _StatChip(
                icon: Icons.auto_stories_rounded,
                value: '$totalLearned / 3900',
                label: 'peyv',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          // ── Alt istatistik satırı ──────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatChip(
                icon: Icons.star_rounded,
                value: '$totalXP',
                label: 'XP',
              ),
              const SizedBox(width: AppSpacing.md),
              _StatChip(
                icon: Icons.local_fire_department_rounded,
                value: '$streakDays',
                label: 'hefte',
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.accentWarm, size: 16),
          const SizedBox(width: 4),
          Text(
            value,
            style: AppTypography.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _GlassButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// DAĞ YOLU GÖRÜNTÜLEYİCİ — CustomPaint + Seviye Düğümleri
// ════════════════════════════════════════════════════════════════

/// Seviye meta verileri — isim, renk, ikon, kelime sayısı
class _LevelMeta {
  final int number;
  final String label;
  final String labelKu;
  final int wordCount;
  final Color color;
  final String biome;

  const _LevelMeta({
    required this.number,
    required this.label,
    required this.labelKu,
    required this.wordCount,
    required this.color,
    required this.biome,
  });
}

const _levels = [
  _LevelMeta(number: 1, label: 'A1', labelKu: 'Destpêk', wordCount: 400,
      color: Color(0xFF4CAF50), biome: 'Deşt'),
  _LevelMeta(number: 2, label: 'A2', labelKu: 'Bingehîn', wordCount: 700,
      color: Color(0xFF66BB6A), biome: 'Daristan'),
  _LevelMeta(number: 3, label: 'B1', labelKu: 'Navîn', wordCount: 1500,
      color: Color(0xFF8D6E63), biome: 'Zinaran'),
  _LevelMeta(number: 4, label: 'B2', labelKu: 'Navîn-Bilind', wordCount: 500,
      color: Color(0xFF78909C), biome: 'Ewr'),
  _LevelMeta(number: 5, label: 'C1', labelKu: 'Pêşketî', wordCount: 500,
      color: Color(0xFFB0BEC5), biome: 'Berf'),
  _LevelMeta(number: 6, label: 'C2', labelKu: 'Jêhatî', wordCount: 300,
      color: Color(0xFFFFD54F), biome: 'Lûtke'),
];

class _MountainPathView extends StatelessWidget {
  final int currentLevel;
  final Map<int, LevelProgress> levelProgresses;

  const _MountainPathView({
    required this.currentLevel,
    required this.levelProgresses,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      reverse: true, // Aşağıdan başla (A1 altta)
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: size.width,
        height: max(size.height * 1.4, 900),
        child: Stack(
          children: [
            // ── Yol çizgisi (CustomPaint) ────────────────────
            Positioned.fill(
              child: CustomPaint(
                painter: _MountainPathPainter(
                  currentLevel: currentLevel,
                ),
              ),
            ),

            // ── Seviye düğümleri ─────────────────────────────
            ..._buildLevelNodes(context, size),

            // ── Dağ keçisi maskotu ───────────────────────────
            _buildGoatMascot(size),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLevelNodes(BuildContext context, Size size) {
    final nodes = <Widget>[];
    final totalHeight = max(size.height * 1.4, 900.0);
    final nodeSpacing = totalHeight / 7; // 6 seviye + üst/alt boşluk

    for (var i = 0; i < _levels.length; i++) {
      final level = _levels[i];
      final progress = levelProgresses[level.number];
      final isCurrentOrBelow = level.number <= currentLevel;
      final isCurrent = level.number == currentLevel;
      final isLocked = level.number > currentLevel + 1;

      // Kıvrımlı yol: çift seviyeleri sola, tek seviyeleri sağa
      final isLeft = i.isEven;
      final xOffset = isLeft
          ? size.width * 0.2
          : size.width * 0.65;

      // Y: aşağıdan yukarı
      final yPos = totalHeight - nodeSpacing * (i + 1);

      final delay = (i * 150).ms;

      nodes.add(
        Positioned(
          left: xOffset - 55,
          top: yPos - 45,
          child: _LevelNode(
            meta: level,
            progress: progress,
            isActive: isCurrentOrBelow,
            isCurrent: isCurrent,
            isLocked: isLocked,
            onTap: isLocked
                ? null
                : () => _showLevelDetail(context, level, progress),
          )
              .animate()
              .fadeIn(delay: delay, duration: 500.ms)
              .scale(
                delay: delay,
                duration: 500.ms,
                begin: const Offset(0.5, 0.5),
                end: const Offset(1, 1),
                curve: Curves.elasticOut,
              ),
        ),
      );
    }

    return nodes;
  }

  Widget _buildGoatMascot(Size size) {
    final totalHeight = max(size.height * 1.4, 900.0);
    final nodeSpacing = totalHeight / 7;
    final levelIndex = (currentLevel - 1).clamp(0, 5);
    final isLeft = levelIndex.isEven;

    final xOffset = isLeft
        ? size.width * 0.2 + 50
        : size.width * 0.65 + 50;
    final yPos = totalHeight - nodeSpacing * (levelIndex + 1) - 60;

    return Positioned(
      left: xOffset - 20,
      top: yPos,
      child: const _GoatMascot(),
    );
  }

  void _showLevelDetail(
    BuildContext context,
    _LevelMeta meta,
    LevelProgress? progress,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _LevelDetailSheet(
        meta: meta,
        progress: progress,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// YOL ÇİZİCİ — Dağda kıvrımlı patika
// ════════════════════════════════════════════════════════════════

class _MountainPathPainter extends CustomPainter {
  final int currentLevel;

  _MountainPathPainter({required this.currentLevel});

  @override
  void paint(Canvas canvas, Size size) {
    final totalHeight = size.height;
    final nodeSpacing = totalHeight / 7;

    // ── Yol gölgesi ──────────────────────────────────────────
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // ── Aktif olmayan yol ────────────────────────────────────
    final inactivePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // ── Aktif yol ────────────────────────────────────────────
    final activePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // ── Noktalı aktif yol ────────────────────────────────────
    final dashPaint = Paint()
      ..color = AppColors.accentWarm
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Her seviye çifti arası bağlantı çiz
    for (var i = 0; i < _levels.length - 1; i++) {
      final isLeft = i.isEven;
      final nextIsLeft = (i + 1).isEven;

      final startX = isLeft ? size.width * 0.2 : size.width * 0.65;
      final endX = nextIsLeft ? size.width * 0.2 : size.width * 0.65;

      final startY = totalHeight - nodeSpacing * (i + 1);
      final endY = totalHeight - nodeSpacing * (i + 2);

      final path = Path();
      path.moveTo(startX, startY);

      // Kıvrımlı Bezier eğrisi
      final midY = (startY + endY) / 2;
      final controlX1 = startX;
      final controlX2 = endX;
      path.cubicTo(controlX1, midY, controlX2, midY, endX, endY);

      // Gölge
      canvas.drawPath(path, shadowPaint);

      // Yolu seviyeye göre renklendir
      final isActive = i < currentLevel;
      canvas.drawPath(path, isActive ? activePaint : inactivePaint);

      // Aktif yolda turuncu noktalı çizgi
      if (isActive) {
        _drawDashedPath(canvas, path, dashPaint);
      }
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final start = distance;
        final end = (distance + 8).clamp(0.0, metric.length);
        final extractPath = metric.extractPath(start, end);
        canvas.drawPath(extractPath, paint);
        distance += 20; // 8px çizgi + 12px boşluk
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MountainPathPainter oldDelegate) {
    return oldDelegate.currentLevel != currentLevel;
  }
}

// ════════════════════════════════════════════════════════════════
// SEVİYE DÜĞÜMÜ — Yuvarlak ilerleme halkası + bilgi
// ════════════════════════════════════════════════════════════════

class _LevelNode extends StatelessWidget {
  final _LevelMeta meta;
  final LevelProgress? progress;
  final bool isActive;
  final bool isCurrent;
  final bool isLocked;
  final VoidCallback? onTap;

  const _LevelNode({
    required this.meta,
    required this.progress,
    required this.isActive,
    required this.isCurrent,
    required this.isLocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final percent = progress?.completionPercent ?? 0.0;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 110,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── İlerleme Halkası ─────────────────────────────
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Halka arka plan
                  CustomPaint(
                    size: const Size(80, 80),
                    painter: _ProgressRingPainter(
                      progress: percent,
                      activeColor: isActive ? meta.color : Colors.white24,
                      trackColor: Colors.white.withOpacity(0.15),
                    ),
                  ),
                  // İç daire
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? meta.color.withOpacity(0.9)
                          : Colors.black.withOpacity(0.3),
                      border: isCurrent
                          ? Border.all(color: AppColors.accentWarm, width: 3)
                          : null,
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: AppColors.accentWarm.withOpacity(0.4),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: isLocked
                        ? Icon(
                            Icons.lock_rounded,
                            color: Colors.white.withOpacity(0.5),
                            size: 24,
                          )
                        : Text(
                            meta.label,
                            style: AppTypography.title.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                  ),
                  // Zirve ikonu (C2)
                  if (meta.number == 6)
                    Positioned(
                      top: 0,
                      child: Icon(
                        Icons.star_rounded,
                        color: AppColors.badgeGold,
                        size: 22,
                      )
                          .animate(
                            onPlay: (c) => c.repeat(reverse: true),
                          )
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.2, 1.2),
                            duration: 1500.ms,
                          ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // ── Seviye Adı (Kurmancî) ────────────────────────
            Text(
              meta.labelKu,
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(
                color: isActive ? Colors.white : Colors.white54,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
            // ── Kelime sayısı ────────────────────────────────
            Text(
              '${meta.wordCount} peyv',
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(
                color: isActive ? Colors.white70 : Colors.white30,
                fontSize: 10,
              ),
            ),
            // ── Yüzde ───────────────────────────────────────
            if (isActive && !isLocked)
              Text(
                '%${(percent * 100).toInt()}',
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(
                  color: AppColors.accentWarm,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// İLERLEME HALKASI ÇİZİCİ
// ════════════════════════════════════════════════════════════════

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color trackColor;

  _ProgressRingPainter({
    required this.progress,
    required this.activeColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 6.0;

    // Arka plan halkası
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // İlerleme arkı
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = activeColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, // Saat 12'den başla
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor;
  }
}

// ════════════════════════════════════════════════════════════════
// DAĞ KEÇİSİ MASKOTU — Animasyonlu
// ════════════════════════════════════════════════════════════════

class _GoatMascot extends StatelessWidget {
  const _GoatMascot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.accentWarm,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentWarm.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        '\u{1F410}', // Keçi emoji
        style: TextStyle(fontSize: 20),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -6, duration: 1200.ms, curve: Curves.easeInOut)
        .then()
        .moveY(begin: -6, end: 0, duration: 1200.ms, curve: Curves.easeInOut);
  }
}

// ════════════════════════════════════════════════════════════════
// SEVİYE DETAY SAYFASI (Bottom Sheet)
// ════════════════════════════════════════════════════════════════

class _LevelDetailSheet extends StatelessWidget {
  final _LevelMeta meta;
  final LevelProgress? progress;

  const _LevelDetailSheet({
    required this.meta,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percent = progress?.completionPercent ?? 0.0;
    final learned = progress?.learnedCards ?? 0;
    final mastered = progress?.masteredCards ?? 0;
    final total = progress?.totalCards ?? meta.wordCount;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Çizgi göstergesi ────────────────────────────────
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Seviye başlığı ─────────────────────────────────
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: meta.color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  meta.label,
                  style: AppTypography.title.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meta.labelKu,
                      style: AppTypography.title.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      meta.biome,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Yüzde
              Text(
                '%${(percent * 100).toInt()}',
                style: AppTypography.headline.copyWith(
                  color: meta.color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── İlerleme çubuğu ────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: percent.clamp(0.0, 1.0),
              backgroundColor: AppColors.borderLight,
              valueColor: AlwaysStoppedAnimation(meta.color),
              minHeight: 10,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── İstatistikler ──────────────────────────────────
          Row(
            children: [
              _DetailStat(
                label: 'Fêrbûyî',
                value: '$learned',
                icon: Icons.check_circle_rounded,
                color: AppColors.success,
              ),
              _DetailStat(
                label: 'Serkeftî',
                value: '$mastered',
                icon: Icons.emoji_events_rounded,
                color: AppColors.badgeGold,
              ),
              _DetailStat(
                label: 'Hemû',
                value: '$total',
                icon: Icons.library_books_rounded,
                color: AppColors.primary,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Kategori kısa özeti ────────────────────────────
          Text(
            '${meta.wordCount} peyvên ${meta.label}',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.md),
        ],
      ),
    ).animate().slideY(begin: 0.3, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}

class _DetailStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _DetailStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.title.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
