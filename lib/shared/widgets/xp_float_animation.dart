import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

// ════════════════════════════════════════════════════════════════
// XP FLOAT ANIMATION
//
// Overlay tabanlı "+X XP" yüzen metin:
// • Bir kere tetikle, widget ağacı bozulmaz — Overlay ile enjekte edilir.
// • Yukarı kayar + solar, yaklaşık 1sn sonra kendini temizler.
// • Hızlı art arda çağrılırsa her biri Stack içinde birikir (batched).
// • MediaQuery.disableAnimations aktifse 400ms sade fade ile gösterilir.
// ════════════════════════════════════════════════════════════════

/// Göster: `+{xp} XP` yüzen animasyon.
///
/// [from] verilirse animasyon bu ekran koordinatından başlar; yoksa
/// ekranın üst-sağ köşesinden (XP badge bölgesi) başlar.
///
/// Örnek:
/// ```dart
/// showXpFloat(context, 10);
/// ```
void showXpFloat(BuildContext context, int xp, {Offset? from, String? label}) {
  if (xp <= 0) return;
  final overlayState = Overlay.maybeOf(context, rootOverlay: true);
  if (overlayState == null) return;

  // Başlangıç konumu: sağ-üst (XP badge civarı).
  final mq = MediaQuery.of(context);
  final screenSize = mq.size;
  final topInset = mq.padding.top;
  final start = from ??
      Offset(
        screenSize.width - 80,
        topInset + 56,
      );

  final disableAnim = mq.disableAnimations;

  final entry = OverlayEntry(
    builder: (ctx) => Positioned(
      left: start.dx,
      top: start.dy,
      child: IgnorePointer(
        ignoring: true,
        child: _XpFloatingText(
          xp: xp,
          label: label,
          reducedMotion: disableAnim,
        ),
      ),
    ),
  );

  overlayState.insert(entry);

  final life = disableAnim
      ? const Duration(milliseconds: 600)
      : const Duration(milliseconds: 1100);
  Future.delayed(life, () {
    if (entry.mounted) entry.remove();
  });
}

class _XpFloatingText extends StatefulWidget {
  final int xp;
  final String? label;
  final bool reducedMotion;

  const _XpFloatingText({
    required this.xp,
    this.label,
    this.reducedMotion = false,
  });

  @override
  State<_XpFloatingText> createState() => _XpFloatingTextState();
}

class _XpFloatingTextState extends State<_XpFloatingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<double> _dy;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    final ms = widget.reducedMotion ? 500 : 1000;
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: ms),
    );

    // 0-15% fade-in + scale, 15-60% hold (yukarı kay), 60-100% fade-out.
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
    ]).animate(_ctrl);

    _dy = Tween<double>(begin: 0, end: widget.reducedMotion ? -20 : -60)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.7, end: 1.15).chain(
          CurveTween(curve: Curves.elasticOut),
        ),
        weight: 35,
      ),
      TweenSequenceItem(tween: ConstantTween(1.15), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 25),
    ]).animate(_ctrl);

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Opacity(
          opacity: _opacity.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, _dy.value),
            child: Transform.scale(
              scale: _scale.value,
              child: _XpPill(xp: widget.xp, label: widget.label),
            ),
          ),
        );
      },
    );
  }
}

class _XpPill extends StatelessWidget {
  final int xp;
  final String? label;

  const _XpPill({required this.xp, this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_rounded,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              label ?? '+$xp XP',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
