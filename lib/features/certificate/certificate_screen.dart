import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../shared/providers/learning_track_provider.dart';
import '../../shared/providers/lesson_progress_provider.dart';
import '../lessons/domain/olcme.dart';
import 'certificate_painter.dart';
import 'certificate_service.dart';

// ════════════════════════════════════════════════════════════════
// SERTİFİKA EKRANI — LÛTKE
//
// CEFR seviye tamamlama (A1→A2, ...) sonunda kullanıcıya özel
// tasarlanan başarı sertifikası ekranı.
//
// Akış:
//   1. İsim onayı (SharedPreferences'ta yoksa modal).
//   2. Sertifika preview (RepaintBoundary içinde A4-landscape canvas).
//   3. "Daxîne" butonu → PNG indir.
//
// İlkeler:
//   • Kurmancî-first UI (zorunlu, Turkish yazı yok).
//   • Orijinal tasarım — kilim motifli kenar, imza, doğrulama ID.
//   • Web-first: dart:html download; mobile fallback share_plus.
// ════════════════════════════════════════════════════════════════

const String _kPrefsFullNameKey = 'certificate_full_name';

class CertificateScreen extends ConsumerStatefulWidget {
  /// CEFR seviyesi — 'A1' | 'A2' | 'B1' | 'B2' | 'C1' | 'C2'
  final String level;

  const CertificateScreen({super.key, required this.level});

  @override
  ConsumerState<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends ConsumerState<CertificateScreen> {
  final GlobalKey _boundaryKey = GlobalKey();
  String? _fullName;
  bool _loading = true;
  bool _downloading = false;
  bool _adSoruldu = false;

  @override
  void initState() {
    super.initState();
    _hydrateName();
  }

  Future<void> _hydrateName() async {
    String? name;
    try {
      final prefs = await SharedPreferences.getInstance();
      name = prefs.getString(_kPrefsFullNameKey);
      if (name != null && name.trim().isEmpty) name = null;
    } catch (_) {/* sessiz */}
    if (!mounted) return;
    setState(() {
      _fullName = name;
      _loading = false;
    });
  }

  Future<void> _askForName() async {
    final result = await showDialog<_NameResult>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _NameConfirmDialog(),
    );
    if (result == null) {
      if (mounted) context.pop();
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPrefsFullNameKey, result.fullName);
    } catch (_) {/* sessiz */}
    if (!mounted) return;
    setState(() => _fullName = result.fullName);
  }

  Future<void> _download() async {
    if (_downloading || _fullName == null) return;
    setState(() => _downloading = true);
    try {
      final bytes = await CertificateService.capture(
        _boundaryKey,
        pixelRatio: 3.0,
      );
      if (bytes == null) throw Exception('capture_failed');
      await CertificateService.download(
        bytes: bytes,
        fileName: CertificateService.buildCertificateFileName(
          userName: _fullName ?? 'Heval',
          level: widget.level,
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belgeya te hat daxistin 📜'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xeletî çêbû. Ji kerema xwe dîsa biceribîne.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Faz 6.3: sertifika düzey sınavını geçene verilir. İngilizce izinde
    // sınav olmadığı için eski davranış sürer.
    final sinavKimligi = ezmunKimligi(widget.level);
    if (!ref.watch(currentTrackProvider).isEnglish && !lessonPassed(ref.watch(lessonProgressProvider), sinavKimligi)) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textSecondary),
            onPressed: () => context.pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('🎓', textAlign: TextAlign.center, style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                'Ji bo belgeya ${widget.level.toUpperCase()} divê tu ezmûna astê derbas bikî.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                '20 pirs · ji sedî 70 pêwîst e',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.push(AppRoutes.wanePlay, extra: {'lessonId': sinavKimligi}),
                child: const Text('Dest bi ezmûnê bike'),
              ),
            ],
          ),
        ),
      );
    }

    // İsim, sınav geçildikten sonra ve bir kez sorulur.
    if (!_loading && _fullName == null && !_adSoruldu) {
      _adSoruldu = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _askForName();
      });
    }
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_fullName == null) {
      // İsim onayı bekleniyor — boş scaffold.
      return const Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
      );
    }

    final track = ref.watch(currentTrackProvider);
    final isEnglish = track.isEnglish;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Vegere',
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Belgeya Serkeftinê',
          style: AppTypography.headline.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Navê xwe biguherîne',
            onPressed: _askForName,
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  // ── Açıklama kartı ──
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.workspace_premium_rounded,
                          color: AppColors.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Pîroz be! Belgeya te ya asta '
                            '${widget.level.toUpperCase()} amade ye.',
                            style: AppTypography.body.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ── Sertifika önizleme ──
                  _CertificatePreview(
                    boundaryKey: _boundaryKey,
                    fullName: _fullName!,
                    level: widget.level,
                    isEnglish: isEnglish,
                    maxWidth: constraints.maxWidth - AppSpacing.lg,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Aksiyon butonları ──
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _askForName,
                          icon: const Icon(Icons.person_outline_rounded),
                          label: const Text('Navê xwe biguherîne'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: AppColors.primary),
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        flex: 2,
                        child: Semantics(
                          button: true,
                          label: 'Belgeya PNG daxîne',
                          child: ElevatedButton.icon(
                            onPressed: _downloading ? null : _download,
                            icon: _downloading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.download_rounded),
                            label: Text(
                              _downloading ? 'Tê amadekirin…' : 'Daxîne (PNG)',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: AppTypography.labelLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Not ──
                  Text(
                    'Belge 1200×848 px, bi formata PNG. '
                    'Ji bo çapkirinê an belavkirina li ser torên civakî guncaw e.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// İSİM ONAY MODALI
// ════════════════════════════════════════════════════════════════

class _NameResult {
  final String fullName;
  const _NameResult(this.fullName);
}

class _NameConfirmDialog extends StatefulWidget {
  const _NameConfirmDialog();

  @override
  State<_NameConfirmDialog> createState() => _NameConfirmDialogState();
}

class _NameConfirmDialogState extends State<_NameConfirmDialog> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _firstError;
  String? _lastError;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _submit() {
    final f = _firstNameController.text.trim();
    final l = _lastNameController.text.trim();
    setState(() {
      _firstError = f.isEmpty ? 'Nav pêwîst e' : null;
      _lastError = l.isEmpty ? 'Paşnav pêwîst e' : null;
    });
    if (f.isEmpty || l.isEmpty) return;
    Navigator.of(context).pop(_NameResult('$f $l'));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.verified_user_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Navê xwe piştrast bike',
              style: AppTypography.title.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ev nav dê li ser belgeyê xuya bibe. '
            'Tu dixwazî navê te çawa xuya bibe?',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _firstNameController,
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Nav',
              hintText: 'Mînak: Zîlan',
              border: const OutlineInputBorder(),
              errorText: _firstError,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _lastNameController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: 'Paşnav',
              hintText: 'Mînak: Kurdî',
              border: const OutlineInputBorder(),
              errorText: _lastError,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Betal'),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Piştrast bike'),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SERTİFİKA ÖNIZLEME — A4 LANDSCAPE
// 297 × 210 mm @ ~4.04 px/mm → 1200 × 848 px logical
// ════════════════════════════════════════════════════════════════

class _CertificatePreview extends StatelessWidget {
  final GlobalKey boundaryKey;
  final String fullName;
  final String level;
  final bool isEnglish;
  final double maxWidth;

  const _CertificatePreview({
    required this.boundaryKey,
    required this.fullName,
    required this.level,
    required this.isEnglish,
    required this.maxWidth,
  });

  // Mantıksal canvas ölçüsü (capture pixelRatio ile çarpılır).
  static const double _logicalWidth = 1200;
  static const double _logicalHeight = 848;

  @override
  Widget build(BuildContext context) {
    // Preview ekranda küçültülmüş; capture tam çözünürlükte olur.
    final scale = (maxWidth / _logicalWidth).clamp(0.25, 1.0);
    final previewWidth = _logicalWidth * scale;
    final previewHeight = _logicalHeight * scale;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: previewWidth,
          height: previewHeight,
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: _logicalWidth,
              height: _logicalHeight,
              child: RepaintBoundary(
                key: boundaryKey,
                child: _CertificateBody(
                  fullName: fullName,
                  level: level,
                  isEnglish: isEnglish,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SERTİFİKA GÖVDESİ — gerçek render edilen belge
// ════════════════════════════════════════════════════════════════

class _CertificateBody extends StatelessWidget {
  final String fullName;
  final String level;
  final bool isEnglish;

  const _CertificateBody({
    required this.fullName,
    required this.level,
    required this.isEnglish,
  });

  Color _levelColor(String level) {
    return switch (level.toUpperCase()) {
      'A1' => const Color(0xFF4CAF50), // yeşil — giriş
      'A2' => const Color(0xFF8BC34A), // lime
      'B1' => const Color(0xFFFF9800), // turuncu
      'B2' => const Color(0xFFF44336), // kırmızı
      'C1' => const Color(0xFF9C27B0), // mor
      'C2' => const Color(0xFF3F51B5), // lacivert
      _ => AppColors.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF1A2A4A);
    const cream = Color(0xFFFBF8F2);
    const teal = AppColors.primary;
    const motifRed = Color(0xFFC0392B);
    const motifYellow = Color(0xFFE8B923);
    const motifGreen = Color(0xFF5B8C3E);

    final date = DateTime.now();
    final dateLabel =
        '${_pad(date.day)}/${_pad(date.month)}/${date.year}';
    final certId = CertificateService.buildCertificateId(
      userId: fullName,
      level: level,
      date: date,
    );
    final levelBig = level.toUpperCase();
    final levelColor = _levelColor(levelBig);

    final languageLabel = isEnglish ? 'Îngilîzî' : 'Kurmancî';

    return Container(
      width: 1200,
      height: 848,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cream, Color(0xFFF3EEDE)],
        ),
      ),
      child: Stack(
        children: [
          // ── Kilim border ────────────────────────────────────
          Positioned.fill(
            child: CustomPaint(
              painter: const KilimBorderPainter(
                background: cream,
                frameColor: navy,
                motifRed: motifRed,
                motifYellow: motifYellow,
                motifGreen: motifGreen,
                motifTeal: teal,
                inset: 36,
              ),
            ),
          ),

          // ── İç içerik ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(90, 80, 90, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo + marka
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: navy, width: 2.5),
                      ),
                      padding: const EdgeInsets.all(7),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo_128.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    const Text(
                      'LÛTKE',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 62,
                        fontWeight: FontWeight.w900,
                        color: navy,
                        letterSpacing: 12,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // Başlık — Kurmancî
                const Text(
                  'BELGEYA SERKEFTINÊ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    color: navy,
                    letterSpacing: 14,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Certificate of Achievement',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: navy.withOpacity(0.62),
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 32),

                // Alt başlık
                const Text(
                  'Ev belge tê pêşkêşkirin ji',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A5A6A),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 18),

                // İsim — büyük, kaligrafik görünümlü serif
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Text(
                      fullName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 76,
                        fontWeight: FontWeight.w800,
                        color: teal,
                        letterSpacing: 2.5,
                        shadows: [
                          Shadow(
                            color: teal.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        width: 640,
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              teal.withOpacity(0),
                              teal,
                              teal.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Gövde metin
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'Ji ber ku te asta $levelBig ya $languageLabel '
                    'bi serkeftinê temam kir.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xFF2A3A5A),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const Spacer(),

                // Alt şerit: Level badge — Tarih — İmza
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Tarih
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DÎROK',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: navy.withOpacity(0.62),
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dateLabel,
                            style: const TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: navy,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Level badge — ortada büyük daire
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            width: 166,
                            height: 166,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  levelColor,
                                  _darken(levelColor, 0.2),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: levelColor.withOpacity(0.35),
                                  blurRadius: 18,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    levelBig,
                                    style: const TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 68,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'CEFR',
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.95),
                                      letterSpacing: 4,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // İmza bölgesi
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 58,
                            width: 220,
                            child: CustomPaint(
                              painter: const SignatureScribblePainter(
                                color: teal,
                              ),
                            ),
                          ),
                          Container(
                            width: 240,
                            height: 1.5,
                            color: navy.withOpacity(0.45),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Prof. Dr. Yılmaz Mutlu',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: navy,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            'Damezrînerê LÛTKE',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: navy.withOpacity(0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Alt bilgi şeridi: sertifika ID + site
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(3),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo_128.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'lutke.app',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: navy.withOpacity(0.7),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'ID: $certId',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: navy.withOpacity(0.55),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _pad(int v) => v.toString().padLeft(2, '0');

  static Color _darken(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}

// ════════════════════════════════════════════════════════════════
// KULLANIM: `/certificate/A2` → CertificateScreen(level: 'A2')
// Dışarıdan kullanım kolay.
// ════════════════════════════════════════════════════════════════

/// Profil ekranından "Belgeya serkeftinê" açılırken kullanıcıya
/// hangi seviye belgesi isteyeceğini sormak için küçük bottom-sheet.
class CertificateLevelPicker extends StatelessWidget {
  /// Kullanıcının şu anki CEFR seviye numarası (1..6).
  final int unlockedUpTo;

  const CertificateLevelPicker({super.key, required this.unlockedUpTo});

  static const _levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Belgeya kîjan astê?',
                    style: AppTypography.title.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Tu dikarî tenê ji bo astên ku te temam kirin belgê bistînî.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _levels.asMap().entries.map((e) {
                final idx = e.key; // 0..5
                final label = e.value;
                final levelNum = idx + 1;
                final unlocked = levelNum <= unlockedUpTo;
                return _LevelPickerChip(
                  label: label,
                  unlocked: unlocked,
                  onTap: unlocked
                      ? () {
                          Navigator.of(context).pop();
                          context.push('/certificate/$label');
                        }
                      : null,
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _LevelPickerChip extends StatelessWidget {
  final String label;
  final bool unlocked;
  final VoidCallback? onTap;

  const _LevelPickerChip({
    required this.label,
    required this.unlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: unlocked,
      label: unlocked ? 'Belgeya $label' : 'Asta $label hîn nehatiye temamkirin',
      child: Material(
        color: unlocked ? AppColors.primary : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  unlocked
                      ? Icons.verified_rounded
                      : Icons.lock_outline_rounded,
                  size: 18,
                  color: unlocked
                      ? Colors.white
                      : AppColors.textTertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: unlocked
                        ? Colors.white
                        : AppColors.textTertiary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

