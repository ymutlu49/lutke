import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';

/// Motivasyon Çapası Ekranı
///
/// Araştırma Bulgusu #2: Motivasyon soyut kaldığında uygulama
/// arka plana düşüyor. "Bunu niye yapıyorum ki" sorusu herkeste.
///
/// Çözüm: Kullanıcı somut bir isim yazar — büyükannem Fatma,
/// annem, kuzenim Baran. Tüm bildirimler, streak kutlamaları,
/// ders tamamlama ekranları bu isimle kişiselleştirilir.

const _kAnchorNameKey = 'motivation_anchor_name';

class MotivationAnchorScreen extends ConsumerStatefulWidget {
  const MotivationAnchorScreen({super.key});

  @override
  ConsumerState<MotivationAnchorScreen> createState() =>
      _MotivationAnchorScreenState();
}

class _MotivationAnchorScreenState
    extends ConsumerState<MotivationAnchorScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasText = false;

  // Öneri isimleri — doğal, kültürel
  static const _suggestions = [
    'Büyükannem',
    'Annem',
    'Babam',
    'Dedem',
    'Kardeşim',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _hasText = _controller.text.trim().isNotEmpty);
    });
    // Klavyeyi otomatik aç
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kAnchorNameKey, name);
    }
    if (mounted) context.go(AppRoutes.dialectSelect);
  }

  void _skip() => context.go(AppRoutes.dialectSelect);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap.lg,

                // ── Başlık ──────────────────────────────────────
                Text(
                  'Ji bo kê hîn dibî?',
                  style: AppTypography.kurmanjiLarge.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 500.ms),

                Gap.xs,

                Text(
                  'Kimin için öğreniyorsun?',
                  style: AppTypography.body.muted,
                  textAlign: TextAlign.center,
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

                Gap.xl,

                // ── Açıklama ────────────────────────────────────
                Text(
                  'Kürtçe öğrenince ilk aklına gelen kişinin adını yaz. '
                  'Büyükannen, annen, deden, kardeşin — kim olursa.',
                  style: AppTypography.body,
                  textAlign: TextAlign.center,
                ).animate(delay: 350.ms).fadeIn(duration: 400.ms),

                Gap.lg,

                // ── İsim girişi ─────────────────────────────────
                _NameInput(
                  controller: _controller,
                  focusNode: _focusNode,
                ).animate(delay: 500.ms).fadeIn(duration: 400.ms),

                Gap.md,

                // ── Hızlı seçenekler ─────────────────────────────
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  alignment: WrapAlignment.center,
                  children: _suggestions.map((s) {
                    return _SuggestionChip(
                      label: s,
                      onTap: () {
                        _controller.text = s;
                        _controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: s.length),
                        );
                      },
                    );
                  }).toList(),
                ).animate(delay: 650.ms).fadeIn(duration: 400.ms),

                Gap.xxl,

                // ── Önizleme ─────────────────────────────────────
                if (_hasText) ...[
                  _PreviewCard(name: _controller.text.trim())
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, end: 0),
                  Gap.lg,
                ],

                // ── Devam butonu ─────────────────────────────────
                AnimatedOpacity(
                  opacity: _hasText ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 200),
                  child: ElevatedButton(
                    onPressed: _hasText ? _continue : null,
                    child: Text(
                      'Devam et →',
                      style: AppTypography.labelLarge.onPrimary,
                    ),
                  ),
                ).animate(delay: 700.ms).fadeIn(duration: 400.ms),

                Gap.md,

                // ── Atla ────────────────────────────────────────
                TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Şimdi değil, atla',
                    style: AppTypography.label.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ).animate(delay: 800.ms).fadeIn(duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── İsim Girişi ──────────────────────────────────────────────────

class _NameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _NameInput({required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textCapitalization: TextCapitalization.words,
      style: AppTypography.bodyLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Büyükannem Fatma...',
        hintStyle: AppTypography.bodyLarge.copyWith(
          color: AppColors.textTertiary,
        ),
        prefixIcon: const Icon(
          Icons.favorite_outline,
          color: AppColors.accent,
          size: 20,
        ),
      ),
      onSubmitted: (_) {
        if (controller.text.trim().isNotEmpty) {
          // _continue() metodu parent widget'ta
        }
      },
    );
  }
}

// ── Öneri Chip ───────────────────────────────────────────────────

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: AppRadius.full,
          border: Border.all(
            color: AppColors.borderLight,
            width: AppSpacing.borderThin,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.label.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ── Önizleme Kartı ───────────────────────────────────────────────

class _PreviewCard extends StatelessWidget {
  final String name;
  const _PreviewCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: AppColors.borderLight,
          width: AppSpacing.borderThin,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Bildirimler şöyle görünecek:',
            style: AppTypography.captionStrong.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Gap.sm,
          Text(
            '"$name için bugün 10 dakika pratik yaptın!"',
            style: AppTypography.body.copyWith(
              color: AppColors.primaryDark,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          Gap.xs,
          Text(
            '"$name\'i görmeden önce harika olacak!"',
            style: AppTypography.body.copyWith(
              color: AppColors.primaryDark,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
