import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/auth_service.dart';
import '../data/admin_note_repository.dart';

// Bug FAB görünürlük toggle'ı — yönetici Profil'den
// "Bug raporu butonunu gizle" diyebilir.
const _kHideBugFabKey = 'admin_hide_bug_fab_v1';

class HideBugFabNotifier extends StateNotifier<bool> {
  HideBugFabNotifier() : super(false) {
    _load();
  }
  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final v = prefs.getBool(_kHideBugFabKey) ?? false;
      if (!mounted) return;
      state = v;
    } catch (_) {}
  }

  Future<void> setHidden(bool hidden) async {
    state = hidden;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kHideBugFabKey, hidden);
    } catch (_) {}
  }
}

final hideBugFabProvider =
    StateNotifierProvider<HideBugFabNotifier, bool>((_) => HideBugFabNotifier());

// ════════════════════════════════════════════════════════════════
// LÛTKE — Global Bug Report FAB (Overlay)
//
// MaterialApp.builder içinde render edilir — tüm ekranlarda görünür
// (shell-içi, shell-dışı, modal vs. fark etmez). Sadece owner için.
//
// AdminNoteFab'tan farkı: GoRouterState'e bağlı değil, doğrudan router
// üzerinden current location'ı alır. Overlay olarak çalışır.
// ════════════════════════════════════════════════════════════════

class GlobalBugFab extends ConsumerWidget {
  const GlobalBugFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwner = ref.watch(isOwnerProvider);
    if (!isOwner) return const SizedBox.shrink();
    final hidden = ref.watch(hideBugFabProvider);
    if (hidden) return const SizedBox.shrink();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton.small(
          heroTag: 'global_bug_fab',
          backgroundColor: const Color(0xFFE53935).withValues(alpha: 0.90),
          foregroundColor: Colors.white,
          elevation: 4,
          tooltip: 'Xeletiyê ragihîne / nîşe bike',
          onPressed: () => _showBugDialog(context, ref),
          child: const Text('🐞', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  void _showBugDialog(BuildContext context, WidgetRef ref) {
    final router = ref.read(appRouterProvider);
    String route = '?';
    try {
      final config = router.routerDelegate.currentConfiguration;
      route = config.uri.toString();
    } catch (_) {
      route = 'unknown';
    }

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => _BugReportDialog(route: route),
    );
  }
}

class _BugReportDialog extends ConsumerStatefulWidget {
  final String route;
  const _BugReportDialog({required this.route});

  @override
  ConsumerState<_BugReportDialog> createState() => _BugReportDialogState();
}

class _BugReportDialogState extends ConsumerState<_BugReportDialog> {
  final _ctrl = TextEditingController();
  AdminNoteCategory _category = AdminNoteCategory.other;
  bool _saving = false;
  bool _saved = false;

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
        context: null,
        message: msg,
      ));
      ref.invalidate(adminNotesProvider);
      if (!mounted) return;
      setState(() {
        _saving = false;
        _saved = true;
      });
      await Future.delayed(const Duration(milliseconds: 900));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xeletî: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _saved ? _successContent() : _formContent(),
        ),
      ),
    );
  }

  Widget _successContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('✅', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 12),
        Text(
          'Nîşe hat tomarkirin!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _formContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🐞', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(
              'Xeletiyê Ragihîne / Nîşe Bike',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.route,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Kategorî',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: AdminNoteCategory.values.map((cat) {
            final isSelected = _category == cat;
            return GestureDetector(
              onTap: () => setState(() => _category = cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  '${cat.emoji} ${cat.labelKu}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _ctrl,
          maxLines: 3,
          textInputAction: TextInputAction.newline,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Xeletî çi ye? Divê çi çêtir bibe?',
            hintStyle: TextStyle(
              color: AppColors.textTertiary,
              fontSize: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _saving ? null : () => Navigator.of(context).pop(),
              child: const Text('Betal'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child:
                          CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send_rounded, size: 16),
              label: Text(_saving ? 'Tê şandin...' : 'Bişîne'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
