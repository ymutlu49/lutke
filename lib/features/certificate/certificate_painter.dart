import 'dart:math' as math;
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════
// KILIM PAINTER — Kurdish kilim-inspired geometric border.
//
// Kaynak motifler: berbang (sabah), goç (göç), kurdish star (sekizli),
// elibelinde (gömülü kadın figürü) — hepsi ortak: kesin geometri,
// sarı/kırmızı/yeşil paleti, simetri.
//
// Burada stilize bir versiyon kullanıyoruz: dar üç katlı şerit,
// dış çizgi (deep navy) + elmas zinciri (teal/yellow/red) + iç hatça.
// Aşırı görsel gürültü yok — sertifikada isim/başlık öne çıkmalı.
// ════════════════════════════════════════════════════════════════

class KilimBorderPainter extends CustomPainter {
  /// Sertifika arka plan rengi — border altına hafif gradient için.
  final Color background;

  /// Ana çerçeve rengi (koyu lacivert — metinle aynı).
  final Color frameColor;

  /// Motif rengleri — Kurdish kilim paleti.
  final Color motifRed;
  final Color motifYellow;
  final Color motifGreen;
  final Color motifTeal;

  /// İç padding ölçüsü.
  final double inset;

  const KilimBorderPainter({
    required this.background,
    required this.frameColor,
    required this.motifRed,
    required this.motifYellow,
    required this.motifGreen,
    required this.motifTeal,
    this.inset = 36,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── 1. Dış ince çerçeve ──────────────────────────────────
    final outerRect = Rect.fromLTRB(inset, inset, w - inset, h - inset);
    final outerPaint = Paint()
      ..color = frameColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(outerRect, const Radius.circular(6)),
      outerPaint,
    );

    // ── 2. Motif şeridi — dışarıdan 14px içeride ─────────────
    const stripThickness = 14.0;
    final motifRect = outerRect.deflate(stripThickness / 2 + 4);
    _drawMotifStrip(canvas, motifRect, stripThickness);

    // ── 3. İç ince çerçeve — motif altında ikinci hat ────────
    final innerRect = motifRect.deflate(stripThickness / 2 + 2);
    final innerPaint = Paint()
      ..color = frameColor.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(innerRect, const Radius.circular(4)),
      innerPaint,
    );

    // ── 4. Dört köşede Kurdish yıldız rozeti ─────────────────
    _drawCornerStars(canvas, outerRect);
  }

  // ────────────────────────────────────────────────────────────
  // Motif şeridi — elmas zinciri + üçgen diş
  // ────────────────────────────────────────────────────────────
  void _drawMotifStrip(Canvas canvas, Rect rect, double thick) {
    // Şerit, dört kenarı takip eden bir "dörtgen yolu".
    // Her kenarı eşit parça diamondlarla doldururuz.
    final colors = [motifRed, motifYellow, motifGreen, motifTeal];

    // Üst kenar
    _drawHorizontalDiamondRow(
      canvas,
      y: rect.top,
      left: rect.left,
      right: rect.right,
      thick: thick,
      colors: colors,
    );
    // Alt kenar
    _drawHorizontalDiamondRow(
      canvas,
      y: rect.bottom,
      left: rect.left,
      right: rect.right,
      thick: thick,
      colors: colors,
    );
    // Sol kenar
    _drawVerticalDiamondRow(
      canvas,
      x: rect.left,
      top: rect.top,
      bottom: rect.bottom,
      thick: thick,
      colors: colors,
    );
    // Sağ kenar
    _drawVerticalDiamondRow(
      canvas,
      x: rect.right,
      top: rect.top,
      bottom: rect.bottom,
      thick: thick,
      colors: colors,
    );
  }

  void _drawHorizontalDiamondRow(
    Canvas canvas, {
    required double y,
    required double left,
    required double right,
    required double thick,
    required List<Color> colors,
  }) {
    final length = right - left;
    // Her elmas genişliği ≈ thick * 1.4; aralarında küçük gap
    const unit = 18.0;
    final count = (length / unit).floor();
    final actualUnit = length / count;
    for (int i = 0; i < count; i++) {
      final cx = left + (i + 0.5) * actualUnit;
      final color = colors[i % colors.length];
      _drawDiamond(canvas, Offset(cx, y), thick * 0.5, thick * 0.4, color);
    }
  }

  void _drawVerticalDiamondRow(
    Canvas canvas, {
    required double x,
    required double top,
    required double bottom,
    required double thick,
    required List<Color> colors,
  }) {
    final length = bottom - top;
    const unit = 18.0;
    final count = (length / unit).floor();
    final actualUnit = length / count;
    for (int i = 0; i < count; i++) {
      final cy = top + (i + 0.5) * actualUnit;
      final color = colors[(i + 1) % colors.length];
      _drawDiamond(canvas, Offset(x, cy), thick * 0.4, thick * 0.5, color);
    }
  }

  void _drawDiamond(
    Canvas canvas,
    Offset c,
    double halfW,
    double halfH,
    Color color,
  ) {
    final path = Path()
      ..moveTo(c.dx, c.dy - halfH)
      ..lineTo(c.dx + halfW, c.dy)
      ..lineTo(c.dx, c.dy + halfH)
      ..lineTo(c.dx - halfW, c.dy)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
    // Kontur — koyulaştırılmış aynı ton
    canvas.drawPath(
      path,
      Paint()
        ..color = _darken(color, 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.6,
    );
  }

  // ────────────────────────────────────────────────────────────
  // Dört köşede 8-uçlu Kürt yıldızı (Stêrka Kurdî)
  // ────────────────────────────────────────────────────────────
  void _drawCornerStars(Canvas canvas, Rect rect) {
    const starRadius = 16.0;
    final positions = [
      rect.topLeft,
      rect.topRight,
      rect.bottomLeft,
      rect.bottomRight,
    ];
    for (final p in positions) {
      _drawStar(canvas, p, starRadius);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double r) {
    // Arka daire — dolgu teal
    canvas.drawCircle(
      center,
      r,
      Paint()..color = motifTeal.withOpacity(0.95),
    );
    canvas.drawCircle(
      center,
      r,
      Paint()
        ..color = frameColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // 8-uçlu yıldız
    final path = Path();
    const spikes = 8;
    final inner = r * 0.45;
    for (int i = 0; i < spikes * 2; i++) {
      final angle = (math.pi / spikes) * i - math.pi / 2;
      final rr = i.isEven ? r * 0.85 : inner;
      final x = center.dx + rr * math.cos(angle);
      final y = center.dy + rr * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(
      path,
      Paint()..color = motifYellow,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = _darken(motifYellow, 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7,
    );

    // Orta nokta
    canvas.drawCircle(
      center,
      r * 0.15,
      Paint()..color = motifRed,
    );
  }

  static Color _darken(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    final hslDark = hsl.withLightness(
      (hsl.lightness - amount).clamp(0.0, 1.0),
    );
    return hslDark.toColor();
  }

  @override
  bool shouldRepaint(covariant KilimBorderPainter old) =>
      background != old.background ||
      frameColor != old.frameColor ||
      motifRed != old.motifRed ||
      motifYellow != old.motifYellow ||
      motifGreen != old.motifGreen ||
      motifTeal != old.motifTeal ||
      inset != old.inset;
}

// ════════════════════════════════════════════════════════════════
// SIGNATURE SCRIBBLE — elle imza taklidi (bezier scribble).
// Prof. Dr. Yılmaz Mutlu için deterministik (aynı seed → aynı imza).
// ════════════════════════════════════════════════════════════════

class SignatureScribblePainter extends CustomPainter {
  final Color color;

  const SignatureScribblePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Sol alttan başla, bir döngü, sonra kuyruk — klasik imza.
    final path = Path();
    path.moveTo(w * 0.05, h * 0.65);
    path.cubicTo(
      w * 0.15, h * 0.10,
      w * 0.30, h * 0.95,
      w * 0.42, h * 0.55,
    );
    path.cubicTo(
      w * 0.48, h * 0.25,
      w * 0.38, h * 0.20,
      w * 0.55, h * 0.40,
    );
    path.cubicTo(
      w * 0.70, h * 0.70,
      w * 0.80, h * 0.10,
      w * 0.92, h * 0.55,
    );
    // Kuyruk — uzun bir alt çizgi
    path.moveTo(w * 0.05, h * 0.82);
    path.cubicTo(
      w * 0.45, h * 0.95,
      w * 0.70, h * 0.70,
      w * 0.95, h * 0.85,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SignatureScribblePainter old) =>
      color != old.color;
}
