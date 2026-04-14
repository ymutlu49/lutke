import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/auth_service.dart';
import '../data/admin_note_repository.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Hata Bildir FAB (sadece sahip için)
//
// Sahip kullanıcı uygulamada herhangi bir ekrandayken sağ alt köşede
// küçük bir floating buton görür. Tıklayınca form açılır:
//   - Kategori (kelime/soru/UI/çeviri/özellik/diğer)
//   - Mesaj
//   - Otomatik route bilgisi (hangi ekrandan açıldı)
//
// Bu FAB sadece `isOwnerProvider == true` durumunda render edilir.
// Diğer kullanıcılar hiç görmez.
// ════════════════════════════════════════════════════════════════

class AdminNoteFab extends ConsumerWidget {
  /// Opsiyonel ekstra bağlam (örn. kelime id, soru numarası).
  final String? contextHint;

  const AdminNoteFab({super.key, this.contextHint});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwner = ref.watch(isOwnerProvider);
    if (!isOwner) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: FloatingActionButton.small(
        heroTag: 'admin_note_fab',
        backgroundColor: AppColors.primary.withOpacity(0.85),
        foregroundColor: Colors.white,
        elevation: 3,
        tooltip: 'Hata bildir / not düş',
        onPressed: () => _showNoteDialog(context, ref),
        child: const Icon(Icons.bug_report_outlined, size: 20),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, WidgetRef ref) {
    final route = GoRouterState.of(context).matchedLocation;
    showDialog(
      context: context,
      builder: (_) => _AdminNoteDialog(
        route: route,
        contextHint: contextHint,
      ),
    );
  }
}

// ── Not ekleme dialog'u ─────────────────────────────────────────

class _AdminNoteDialog extends ConsumerStatefulWidget {
  final String route;
  final String? contextHint;

  const _AdminNoteDialog({
    required this.route,
    this.contextHint,
  });

  @override
  ConsumerState<_AdminNoteDialog> createState() => _AdminNoteDialogState();
}

class _AdminNoteDialogState extends ConsumerState<_AdminNoteDialog> {
  final _ctrl = TextEditingController();
  AdminNoteCategory _category = AdminNoteCategory.other;
  bool _saving = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final msg = _ctrl.text.trim();
    if (msg.isEmpty) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(adminNoteRepositoryProvider);
      await repo.add(AdminNote(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        created: DateTime.now(),
        category: _category,
        route: widget.route,
        context: widget.contextHint,
        message: msg,
      ));
      // Notları invalidate et
      ref.invalidate(adminNotesProvider);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Not kaydedildi'),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bug_report_rounded,
                    color: AppColors.primary, size: 22),
                const SizedBox(width: 8),
                Text('Hata Bildir / Not Düş',
                    style: AppTypography.title.copyWith(
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Ekran: ${widget.route}',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 16),

            // Kategori seçimi
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AdminNoteCategory.values.map((cat) {
                final isSelected = _category == cat;
                return GestureDetector(
                  onTap: () => setState(() => _category = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      '${cat.emoji} ${cat.labelKu}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),

            // Mesaj
            TextField(
              controller: _ctrl,
              maxLines: 4,
              maxLength: 500,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Hatayı veya öneriyi yaz...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),

            const SizedBox(height: 8),

            // Eylemler
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _saving
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: const Text('Vazgeç'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: _saving
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_rounded, size: 18),
                  label: const Text('Kaydet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
