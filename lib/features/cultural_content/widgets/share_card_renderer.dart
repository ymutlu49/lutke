import 'package:flutter/material.dart';

import '../cultural_entities.dart';

// ════════════════════════════════════════════════════════════════
// SHARE CARD RENDERER — 1080×1080 kare (Instagram/X/WhatsApp)
//
// Tek widget, içerikten türetilen dört varyant:
//   • proverb  → büyük pull-quote + (opsiyonel) TR altyazı
//   • poem     → helbestvan + yıllar + 4 satır şiir pasajı
//   • singer   → isim + mikrofon emoji + 2-3 stran
//   • writer   → yazar + eserleri
//
// Tüm varyantlar aynı iskeleti paylaşır:
//   [brand gradient] + [kilim corner motifs] + [LÛTKE logo/üst]
//   [merkez içerik] + [alt bilgi: site + hashtag]
// ════════════════════════════════════════════════════════════════

class ShareCardRenderer extends StatelessWidget {
  final CulturalItem item;

  /// Türkçe altyazı paylaşım kartında da görünsün mü?
  final bool includeTurkish;

  const ShareCardRenderer({
    super.key,
    required this.item,
    this.includeTurkish = true,
  });

  // Mantıksal ölçü — capture pixelRatio ile çarpılır.
  static const double logicalSize = 1080;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: logicalSize,
      height: logicalSize,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A7B6B), // primary teal
            Color(0xFF0C5247), // primaryDark
          ],
        ),
      ),
      child: Stack(
        children: [
          // ── Kilim köşe motifleri (dekoratif, ince) ──────────
          Positioned.fill(
            child: CustomPaint(
              painter: const _CornerMotifPainter(),
            ),
          ),

          // ── Logo + marka üstte (kompakt) ───────────────────
          Positioned(
            top: 56,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 108,
                  height: 108,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo_128.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'LÛTKE',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 12,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                // Alt tag kapsülü — küçük ama belirgin
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.28),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _subTag(item.type),
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withOpacity(0.95),
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Merkez içerik (genişletilmiş alan) ─────────────
          // 1080×1080 içinde:
          //   üst marka zonu  : 56-330 (≈274 px)
          //   içerik zonu     : 350-920 (≈570 px) ← daha geniş
          //   alt info zonu   : 940-1020 (≈80 px) ← tek satır
          Positioned(
            left: 70,
            right: 70,
            top: 350,
            bottom: 160,
            child: Center(
              child: _ContentByType(
                item: item,
                includeTurkish: includeTurkish,
              ),
            ),
          ),

          // ── Alt bilgi şeridi (kompakt, tek satır) ──────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 56,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 220,
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(0.55),
                          Colors.white.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'lutke.app  ·  #LÛTKE  ·  #Kurmancî',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.92),
                    letterSpacing: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _subTag(CulturalContentType type) => switch (type) {
        CulturalContentType.proverb => 'GOTINA PÊŞIYAN',
        CulturalContentType.song => 'STRAN',
        CulturalContentType.poem => 'HELBEST',
        CulturalContentType.story => 'DESTAN Û ÇÎROK',
        CulturalContentType.foodTradition => 'XWARINA KURDÎ',
        CulturalContentType.historicalFigure => 'KESAYETEK DÎROKÎ',
        CulturalContentType.singer => 'STRANBÊJ',
        CulturalContentType.poet => 'HELBESTVAN',
        CulturalContentType.writer => 'NIVÎSKAR',
        CulturalContentType.celebration => 'CEJN',
        CulturalContentType.folkDance => 'GOVEND Û CILÛBERG',
        CulturalContentType.historicalEvent => 'BÛYERA DÎROKÎ',
        CulturalContentType.architecture => 'MÎMARÎYA KURDÎ',
      };
}

// ════════════════════════════════════════════════════════════════
// İÇERİK (VARYANT) — tipe göre düzen
// ════════════════════════════════════════════════════════════════

class _ContentByType extends StatelessWidget {
  final CulturalItem item;
  final bool includeTurkish;

  const _ContentByType({
    required this.item,
    required this.includeTurkish,
  });

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case CulturalContentType.proverb:
      case CulturalContentType.story:
      case CulturalContentType.foodTradition:
      case CulturalContentType.celebration:
      case CulturalContentType.folkDance:
      case CulturalContentType.historicalEvent:
      case CulturalContentType.architecture:
        return _ProverbLayout(
          item: item,
          includeTurkish: includeTurkish,
        );

      case CulturalContentType.poem:
      case CulturalContentType.song:
        return _PoemLayout(
          item: item,
          includeTurkish: includeTurkish,
        );

      case CulturalContentType.singer:
        return _ArtistLayout(
          item: item,
          icon: '🎤',
          includeTurkish: includeTurkish,
        );

      case CulturalContentType.poet:
        return _ArtistLayout(
          item: item,
          icon: '📜',
          includeTurkish: includeTurkish,
        );

      case CulturalContentType.writer:
        return _ArtistLayout(
          item: item,
          icon: '📖',
          includeTurkish: includeTurkish,
        );

      case CulturalContentType.historicalFigure:
        return _ArtistLayout(
          item: item,
          icon: '🕊️',
          includeTurkish: includeTurkish,
        );
    }
  }
}

// ── Proverb / quote layout ─────────────────────────────────────

class _ProverbLayout extends StatelessWidget {
  final CulturalItem item;
  final bool includeTurkish;

  const _ProverbLayout({
    required this.item,
    required this.includeTurkish,
  });

  @override
  Widget build(BuildContext context) {
    // Font ladder — en uzun durum gözetilerek seçildi.
    // İçerik alanı 940 px wide × ~570 px tall. Kapasite tahmini:
    //   ≤30 char  → 92pt (1 satır, hero etki)
    //   ≤60 char  → 76pt (1-2 satır)
    //   ≤100 char → 60pt (2-3 satır)
    //   ≤160 char → 50pt (3-4 satır)
    //   ≤220 char → 42pt (4-5 satır)
    //   >220      → 36pt (5-7 satır)
    final length = item.kurmanjContent.length;
    final heroSize = length <= 30
        ? 92.0
        : length <= 60
            ? 76.0
            : length <= 100
                ? 60.0
                : length <= 160
                    ? 50.0
                    : length <= 220
                        ? 42.0
                        : 36.0;

    final hasDistinctTitle =
        !_isSameAsContent(item.kurmanjTitle, item.kurmanjContent) &&
            item.kurmanjTitle.isNotEmpty;
    final hasTr =
        includeTurkish && item.turkishContent.trim().isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Dekoratif tırnak — küçültüldü, az dikey alan harcar.
        Text(
          '“',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 96,
            height: 0.55,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE8B923).withOpacity(0.55),
          ),
        ),
        const SizedBox(height: 14),

        // Kurmancî metin — hero
        Text(
          item.kurmanjContent,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: heroSize,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.32,
            letterSpacing: 0.3,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),

        // Atalama — yalnız başlık atasözünden gerçekten farklıysa.
        // Robust dedup: trailing punctuation + whitespace + casefold.
        if (hasDistinctTitle) ...[
          const SizedBox(height: 28),
          Text(
            '— ${item.kurmanjTitle}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: const Color(0xFFE8B923).withOpacity(0.95),
              letterSpacing: 0.5,
            ),
          ),
        ],

        // TR çeviri — kutu yerine ince ayraç + italik satır.
        // Daha az dikey alan harcar, görsel hiyerarşi netleşir.
        if (hasTr) ...[
          const SizedBox(height: 32),
          Container(
            width: 80,
            height: 1.4,
            color: const Color(0xFFE8B923).withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            item.turkishContent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 26,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.86),
              height: 1.45,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }
}

/// Robust normalized comparison — strips trailing/leading punctuation +
/// whitespace and casefolds. Atasözlerinde kurmanjTitle == kurmanjContent
/// olur ama nokta/boşluk farkı naïve `==` testini yanıltır.
bool _isSameAsContent(String title, String content) {
  String norm(String s) => s
      .trim()
      .replaceAll(RegExp(r'[.!?…\s"“”]+$'), '')
      .replaceAll(RegExp(r'^[.!?…\s"“”]+'), '')
      .toLowerCase();
  return norm(title) == norm(content);
}

// ── Poem / song layout — ritim için monospace-ish hizalama ──────

class _PoemLayout extends StatelessWidget {
  final CulturalItem item;
  final bool includeTurkish;

  const _PoemLayout({
    required this.item,
    required this.includeTurkish,
  });

  @override
  Widget build(BuildContext context) {
    final allLines = item.kurmanjContent.split('
')
        .where((l) => l.trim().isNotEmpty)
        .toList();
    final preview = allLines.take(6).toList();

    // Satır sayısı + en uzun satır karakter sayısına göre dinamik font.
    final maxLineLen =
        preview.fold<int>(0, (m, l) => l.length > m ? l.length : m);
    final lineSize = preview.length <= 3 && maxLineLen <= 32
        ? 50.0
        : preview.length <= 4 && maxLineLen <= 40
            ? 44.0
            : preview.length <= 5 && maxLineLen <= 48
                ? 38.0
                : 34.0;

    final hasTr =
        includeTurkish && item.turkishContent.trim().isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Başlık (helbestin / stranê adı)
        Text(
          item.kurmanjTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 50,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.0,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Helbest pasajı — yumuşak çerçeve, daha az padding
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE8B923).withOpacity(0.35),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (final l in preview)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    l,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: lineSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.4,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (hasTr) ...[
          const SizedBox(height: 22),
          Text(
            item.turkishContent.split('
').take(2).join('
'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 22,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.82),
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

// ── Artist layout (singer / poet / writer / historicalFigure) ──

class _ArtistLayout extends StatelessWidget {
  final CulturalItem item;
  final String icon;
  final bool includeTurkish;

  const _ArtistLayout({
    required this.item,
    required this.icon,
    required this.includeTurkish,
  });

  @override
  Widget build(BuildContext context) {
    // Biyografi/eser satırları — boş olmayanlar, max 4 (alan kısıtı).
    final lines = item.kurmanjContent.split('
');
    final highlights =
        lines.where((l) => l.trim().isNotEmpty).take(4).toList();

    // Sanatçı adı çoğu zaman uzun (başlık + tarih). Uzun ise daha küçük.
    final nameSize = item.kurmanjTitle.length <= 24
        ? 64.0
        : item.kurmanjTitle.length <= 36
            ? 54.0
            : 44.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon — küçültüldü (132 → 96)
        Text(
          icon,
          style: const TextStyle(fontSize: 96),
        ),
        const SizedBox(height: 14),

        // Sanatçı adı + tarih
        Text(
          item.kurmanjTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: nameSize,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.15,
            letterSpacing: 0.6,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Eser/biyografi kutusu — daha sıkı padding
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 22,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE8B923).withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final l in highlights)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    l,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.95),
                      height: 1.35,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KÖŞE MOTİF PAINTER — 1080×1080 köşelerinde ince kilim dekorasyonu
// ════════════════════════════════════════════════════════════════

class _CornerMotifPainter extends CustomPainter {
  const _CornerMotifPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Üst-sol köşe
    _drawCornerCluster(canvas, const Offset(40, 40), quadrant: 1);
    // Üst-sağ köşe
    _drawCornerCluster(
      canvas,
      Offset(size.width - 40, 40),
      quadrant: 2,
    );
    // Alt-sol
    _drawCornerCluster(
      canvas,
      Offset(40, size.height - 40),
      quadrant: 3,
    );
    // Alt-sağ
    _drawCornerCluster(
      canvas,
      Offset(size.width - 40, size.height - 40),
      quadrant: 4,
    );
  }

  void _drawCornerCluster(
    Canvas canvas,
    Offset anchor, {
    required int quadrant,
  }) {
    // 3 elmas, "L" dizilim
    const motifColors = [
      Color(0xFFE8B923), // yellow
      Color(0xFFC0392B), // red
      Color(0xFFFBF8F2), // cream/off-white
    ];
    final dirX = (quadrant == 1 || quadrant == 3) ? 1.0 : -1.0;
    final dirY = (quadrant == 1 || quadrant == 2) ? 1.0 : -1.0;

    for (int i = 0; i < 3; i++) {
      final color = motifColors[i];
      final ox = anchor.dx + dirX * (i * 28.0);
      final oy = anchor.dy + dirY * (i * 28.0);
      _diamond(canvas, Offset(ox, oy), 10, 12, color.withOpacity(0.85));
    }
    // Ek "yıldız pırıltıları"
    for (int i = 0; i < 5; i++) {
      final ox = anchor.dx + dirX * (90.0 + i * 20);
      final oy = anchor.dy + dirY * (20.0 + (i.isEven ? 0 : 8));
      _sparkle(canvas, Offset(ox, oy), 3.0);
    }
    for (int i = 0; i < 5; i++) {
      final ox = anchor.dx + dirX * (20.0 + (i.isEven ? 0 : 8));
      final oy = anchor.dy + dirY * (90.0 + i * 20);
      _sparkle(canvas, Offset(ox, oy), 3.0);
    }
  }

  void _diamond(
    Canvas canvas,
    Offset c,
    double halfW,
    double halfH,
    Color color,
  ) {
    final p = Path()
      ..moveTo(c.dx, c.dy - halfH)
      ..lineTo(c.dx + halfW, c.dy)
      ..lineTo(c.dx, c.dy + halfH)
      ..lineTo(c.dx - halfW, c.dy)
      ..close();
    canvas.drawPath(p, Paint()..color = color);
    canvas.drawPath(
      p,
      Paint()
        ..color = Colors.white.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );
  }

  void _sparkle(Canvas canvas, Offset c, double r) {
    final paint = Paint()..color = Colors.white.withOpacity(0.55);
    // Dört uçlu basit pırıltı
    canvas.drawCircle(c, r * 0.5, paint);
    canvas.drawRect(
      Rect.fromCenter(
        center: c,
        width: r * 2,
        height: 1.2,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: c,
        width: 1.2,
        height: r * 2,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CornerMotifPainter oldDelegate) => false;
}

