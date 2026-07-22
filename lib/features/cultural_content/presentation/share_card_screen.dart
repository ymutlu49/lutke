import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../certificate/certificate_service.dart';
import '../cultural_entities.dart';
import '../widgets/share_card_renderer.dart';

// ════════════════════════════════════════════════════════════════
// SHARE CARD MODAL — Çand kartı için paylaşım
//
// Kullanım:
//   showShareCardSheet(context, item: someCulturalItem);
//
// Davranış:
//   • Önizleme (RepaintBoundary içinde 1080×1080 küçültülmüş)
//   • "Daxîne" → PNG indir (web: browser; mobile: share sheet)
//   • "Kopî bike" → kurmancî içeriği clipboard'a
//   • "Parve bike" → share_plus text share (metin)
// ════════════════════════════════════════════════════════════════

Future<void> showShareCardSheet(
  BuildContext context, {
  required CulturalItem item,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.backgroundSecondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _ShareCardSheet(item: item),
  );
}

class _ShareCardSheet extends StatefulWidget {
  final CulturalItem item;
  const _ShareCardSheet({required this.item});

  @override
  State<_ShareCardSheet> createState() => _ShareCardSheetState();
}

class _ShareCardSheetState extends State<_ShareCardSheet> {
  final GlobalKey _boundaryKey = GlobalKey();
  bool _downloading = false;

  String get _titleForFile =>
      widget.item.kurmanjTitle.isEmpty
          ? widget.item.id
          : widget.item.kurmanjTitle;

  Future<void> _download() async {
    if (_downloading) return;
    setState(() => _downloading = true);
    try {
      final bytes = await CertificateService.capture(
        _boundaryKey,
        pixelRatio: 2.0, // 1080×1080 → 2160×2160 PNG
      );
      if (bytes == null) throw Exception('capture_failed');
      await CertificateService.download(
        bytes: bytes,
        fileName: CertificateService.buildShareCardFileName(
          title: _titleForFile,
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kart hat daxistin 🎉'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xeletî: kart nehat amadekirin.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  Future<void> _copyText() async {
    final text = _buildShareText();
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nivîs hat kopîkirin 📋'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _shareText() async {
    await CertificateService.shareText(_buildShareText());
  }

  String _buildShareText() {
    final item = widget.item;
    final buf = StringBuffer();
    buf.writeln(item.kurmanjContent);
    if (item.kurmanjTitle.isNotEmpty &&
        item.kurmanjTitle != item.kurmanjContent) {
      buf.writeln('— ${item.kurmanjTitle}');
    }
    buf.writeln();
    buf.writeln('LÛTKE · Zimanê Kurdî · lutke.app');
    buf.writeln('#LÛTKE #Kurmancî #ZimanêKurdî');
    return buf.toString();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height * 0.92),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Başlık
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.share_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parve bike',
                          style: AppTypography.title.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Kart ji bo torên civakî amade ye',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Bigre',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Preview — küçültülmüş render.
              _PreviewFrame(
                boundaryKey: _boundaryKey,
                item: widget.item,
              ),

              const SizedBox(height: AppSpacing.md),

              // Buton şeridi
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _copyText,
                      icon: const Icon(
                        Icons.content_copy_rounded,
                        size: 18,
                      ),
                      label: const Text('Nivîsê kopî bike'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _shareText,
                      icon: const Icon(Icons.link_rounded, size: 18),
                      label: const Text('Nivîsê parve bike'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Semantics(
                button: true,
                label: 'Karta PNG daxîne',
                child: ElevatedButton.icon(
                  onPressed: _downloading ? null : _download,
                  icon: _downloading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Icon(Icons.download_rounded, size: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}

// ── Preview çerçeve (1080×1080 FittedBox içinde küçültülür) ─────

class _PreviewFrame extends StatelessWidget {
  final GlobalKey boundaryKey;
  final CulturalItem item;

  const _PreviewFrame({
    required this.boundaryKey,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Kare oranı: display side = constraints.maxWidth, cap 360
        final side = constraints.maxWidth.clamp(240.0, 360.0);
        return Center(
          child: Container(
            width: side,
            height: side,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: ShareCardRenderer.logicalSize,
                  height: ShareCardRenderer.logicalSize,
                  child: RepaintBoundary(
                    key: boundaryKey,
                    child: ShareCardRenderer(item: item),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
