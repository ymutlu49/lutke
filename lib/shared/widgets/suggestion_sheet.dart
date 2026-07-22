import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/services/suggestion_service.dart';
import '../providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// DÜZELTME ÖNERİSİ FORMU — alt sayfa (bottom sheet)
//
// Kullanıcı içerik hatası bildirir / düzeltme önerir.
// Girişler: tür (peyv/hevok/werger/deng/din), sorun tarifi,
// opsiyonel önerilen düzeltme. Kelime detayından açılırsa itemId/itemText
// otomatik dolar. Backend: POST /api/suggestions (oturum opsiyonel).
// ════════════════════════════════════════════════════════════════

/// Düzeltme önerisi formunu aç. [itemId]/[itemText] verilirse form o
/// içeriğe bağlanır (ör. kelime detayından: id=a1_025, text='Bextewar').
Future<void> showSuggestionSheet(
  BuildContext context, {
  String? itemId,
  String? itemText,
  String initialType = 'peyv',
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: _SuggestionSheet(
        itemId: itemId,
        itemText: itemText,
        initialType: initialType,
      ),
    ),
  );
}

class _SuggestionSheet extends ConsumerStatefulWidget {
  final String? itemId;
  final String? itemText;
  final String initialType;

  const _SuggestionSheet({
    this.itemId,
    this.itemText,
    required this.initialType,
  });

  @override
  ConsumerState<_SuggestionSheet> createState() => _SuggestionSheetState();
}

class _SuggestionSheetState extends ConsumerState<_SuggestionSheet> {
  late String _type = widget.initialType;
  final _messageCtrl = TextEditingController();
  final _suggestionCtrl = TextEditingController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _messageCtrl.dispose();
    _suggestionCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_sending) return;
    final showTr = ref.read(showTurkishProvider);
    final msg = _messageCtrl.text.trim();
    if (msg.length < 5) {
      setState(() => _error = showTr
          ? 'Pirsgirêkê hinekî rave bike · Sorunu biraz açıkla (en az 5 karakter)'
          : 'Pirsgirêkê hinekî rave bike (herî kêm 5 tîp)');
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });

    String? route;
    try {
      route = GoRouterState.of(context).uri.toString();
    } catch (_) {}

    final ok = await ref.read(suggestionServiceProvider).submit(
          itemType: _type,
          message: msg,
          itemId: widget.itemId,
          itemText: widget.itemText,
          suggestion: _suggestionCtrl.text.trim(),
          route: route,
        );

    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
          content: Text(showTr
              ? 'Spas! Pêşniyara te hat şandin. · Teşekkürler! Önerin iletildi.'
              : 'Spas! Pêşniyara te hat şandin.'),
        ),
      );
    } else {
      setState(() {
        _sending = false;
        _error = showTr
            ? 'Şandin bi ser neket — girêdanê kontrol bike û dîsa biceribîne. · Gönderilemedi, bağlantıyı kontrol edip tekrar dene.'
            : 'Şandin bi ser neket — girêdanê kontrol bike û dîsa biceribîne.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTr = ref.watch(showTurkishProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.rate_review_outlined,
                    color: AppColors.primary, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    showTr
                        ? 'Pêşniyara serrastkirinê · Düzeltme önerisi'
                        : 'Pêşniyara serrastkirinê',
                    style: AppTypography.title
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              showTr
                  ? 'Şaşiyekê dîtî an pêşniyareke te heye? Ji me re binivîse.\nBir hata mı gördün, önerin mi var? Bize yaz.'
                  : 'Şaşiyekê dîtî an pêşniyareke te heye? Ji me re binivîse.',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary, height: 1.4),
            ),

            // Bağlı içerik (kelime detayından gelindiyse)
            if (widget.itemText != null && widget.itemText!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.link_rounded,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.itemId != null
                            ? '${widget.itemText}  ·  ${widget.itemId}'
                            : widget.itemText!,
                        style: AppTypography.label
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 14),

            // Tür seçimi
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final (code, ku, tr) in kSuggestionTypes)
                  ChoiceChip(
                    label: Text(showTr ? '$ku · $tr' : ku),
                    selected: _type == code,
                    onSelected: (_) => setState(() => _type = code),
                    selectedColor: AppColors.primary.withOpacity(0.15),
                    labelStyle: AppTypography.labelSmall.copyWith(
                      color: _type == code
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            // Sorun tarifi
            TextField(
              controller: _messageCtrl,
              maxLines: 3,
              maxLength: 2000,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: showTr ? 'Pirsgirêk çi ye? · Sorun ne?' : 'Pirsgirêk çi ye?',
                hintText: showTr
                    ? 'mînak: Wergera tirkî şaş e…'
                    : 'mînak: Wergera tirkî şaş e…',
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Önerilen düzeltme (opsiyonel)
            TextField(
              controller: _suggestionCtrl,
              maxLines: 2,
              maxLength: 2000,
              decoration: InputDecoration(
                labelText: showTr
                    ? 'Pêşniyara te (ne mecbûrî) · Önerin (isteğe bağlı)'
                    : 'Pêşniyara te (ne mecbûrî)',
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: AppTypography.caption
                    .copyWith(color: AppColors.errorSoft, height: 1.3),
              ),
            ],

            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sending ? null : _submit,
                icon: _sending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(showTr ? 'Bişîne · Gönder' : 'Bişîne'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
