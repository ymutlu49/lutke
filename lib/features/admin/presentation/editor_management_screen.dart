import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/auth_service.dart';
import '../data/editor_management_service.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Editor (Sub-editor) Management Screen
//
// Owner için: alt-editör listesi, ekleme, kaldırma, rol atama.
// Reviewer email'leri AdminConfig (build-time) + SharedPreferences
// (runtime) birleşiminden gelir.
// ════════════════════════════════════════════════════════════════

class EditorManagementScreen extends ConsumerWidget {
  const EditorManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwner = ref.watch(isOwnerProvider);
    if (!isOwner) {
      return _DeniedScaffold();
    }

    final editors = ref.watch(subEditorsProvider);
    final fromConfig = editors.where((e) => e.fromConfig).toList();
    final fromUser = editors.where((e) => !e.fromConfig).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        title: const Text('Edîtorên Min',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.profile),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _InfoBanner(),
            const SizedBox(height: 16),

            // ── User-managed editors ──
            _SectionHeader(
              icon: Icons.person_add_alt_1_rounded,
              title: 'Edîtorên ku te lê zêde kirine',
              count: fromUser.length,
            ),
            const SizedBox(height: 8),
            if (fromUser.isEmpty)
              _EmptyHint()
            else
              ...fromUser.map((e) => _EditorTile(
                    editor: e,
                    onRemove: () => _confirmRemove(context, ref, e),
                    onEdit: () => _showAddDialog(context, ref, existing: e),
                  )),

            const SizedBox(height: 24),

            // ── Config-defined editors ──
            if (fromConfig.isNotEmpty) ...[
              _SectionHeader(
                icon: Icons.lock_outline_rounded,
                title: 'Ji avakirinê (sabit)',
                count: fromConfig.length,
              ),
              const SizedBox(height: 8),
              ...fromConfig.map((e) => _EditorTile(
                    editor: e,
                    onRemove: null,
                    onEdit: null,
                  )),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context, ref),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Edîtorek lê zêde bike'),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref,
      {SubEditor? existing}) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _EditorDialog(existing: existing),
    );
  }

  Future<void> _confirmRemove(
      BuildContext context, WidgetRef ref, SubEditor editor) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edîtorê rake?'),
        content: Text(
          '"${editor.displayName}" (${editor.email}) ji navendê tê derxistin. '
          'Wê êdî nikare guhertinên çandê tomar bike.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vegere'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Rake'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(subEditorsProvider.notifier).remove(editor.email);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${editor.displayName} hate rakirin.')),
        );
      }
    }
  }
}

// ════════════════════════════════════════════════════════════════
// Info banner
// ════════════════════════════════════════════════════════════════

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tu kî dikare bide?',
                  style: AppTypography.label.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Edîtorên alîkar, dengbêj û pisporên Kurmancî yên ku '
                  'di edîtkirina naverokê de bibin alîkar. Her edîtor '
                  'bi e-name û rola xwe (wergêr / naverok / pispor) '
                  'lê zêde dibe. Ev liste yalnız ji bo te xuya dibe.',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  const _SectionHeader(
      {required this.icon, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTypography.label.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            '$count',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(Icons.group_outlined, color: AppColors.textTertiary, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Hîn te edîtorek lê zêde nekiriye. '
              'FAB"a "+" bide ku yek lê zêde bikî.',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// EDITOR TILE
// ════════════════════════════════════════════════════════════════

class _EditorTile extends StatelessWidget {
  final SubEditor editor;
  final VoidCallback? onRemove;
  final VoidCallback? onEdit;

  const _EditorTile({
    required this.editor,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final initials = editor.displayName.isEmpty
        ? '?'
        : editor.displayName
            .split(' ')
            .map((s) => s.isEmpty ? '' : s[0].toUpperCase())
            .take(2)
            .join();

    final roleColor = switch (editor.role) {
      EditorRole.translator => Colors.blue.shade700,
      EditorRole.content => Colors.purple.shade700,
      EditorRole.reviewer => Colors.green.shade700,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: roleColor,
          child: Text(
            initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        title: Text(
          editor.displayName.isEmpty
              ? editor.email.split('@').first
              : editor.displayName,
          style: AppTypography.body.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editor.email,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: roleColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                editor.role.labelKu,
                style: TextStyle(
                  color: roleColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        trailing: editor.fromConfig
            ? Tooltip(
                message: 'Sabit (build-time) — guhertin ji bo vê derê nayê',
                child: Icon(Icons.lock_rounded,
                    size: 18, color: AppColors.textTertiary),
              )
            : PopupMenuButton<String>(
                icon: Icon(Icons.more_vert,
                    color: AppColors.textSecondary),
                onSelected: (v) {
                  if (v == 'edit') onEdit?.call();
                  if (v == 'remove') onRemove?.call();
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                      value: 'edit', child: Text('Edît bike')),
                  PopupMenuItem(
                      value: 'remove', child: Text('Rake')),
                ],
              ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ADD/EDIT EDITOR DIALOG
// ════════════════════════════════════════════════════════════════

class _EditorDialog extends ConsumerStatefulWidget {
  final SubEditor? existing;
  const _EditorDialog({this.existing});

  @override
  ConsumerState<_EditorDialog> createState() => _EditorDialogState();
}

class _EditorDialogState extends ConsumerState<_EditorDialog> {
  late final TextEditingController _emailCtrl;
  late final TextEditingController _nameCtrl;
  late EditorRole _role;
  String? _error;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.existing?.email ?? '');
    _nameCtrl =
        TextEditingController(text: widget.existing?.displayName ?? '');
    _role = widget.existing?.role ?? EditorRole.reviewer;
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null
          ? 'Edîtorek nû'
          : 'Edîtorê edît bike'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'E-name *',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              enabled: widget.existing == null,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Navê tam',
                prefixIcon: Icon(Icons.badge_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<EditorRole>(
              value: _role,
              decoration: const InputDecoration(
                labelText: 'Rol',
                prefixIcon: Icon(Icons.work_outline),
                border: OutlineInputBorder(),
              ),
              items: EditorRole.values
                  .map((r) => DropdownMenuItem(
                        value: r,
                        child: Text('${r.labelKu} — ${r.labelTr}'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _role = v ?? _role),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(
                      color: Colors.red.shade800, fontSize: 12),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Vegere'),
        ),
        FilledButton(
          style:
              FilledButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: _save,
          child: const Text('Tomar bike'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final email = _emailCtrl.text.trim().toLowerCase();
    final name = _nameCtrl.text.trim();

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      setState(() => _error = 'E-nameyek derbasdar têxe.');
      return;
    }
    if (name.isEmpty) {
      setState(() => _error = 'Navê tam têxe.');
      return;
    }

    final editor = SubEditor(
      email: email,
      displayName: name,
      role: _role,
      addedAt: widget.existing?.addedAt ?? DateTime.now(),
    );

    await ref.read(subEditorsProvider.notifier).add(editor);
    if (mounted) Navigator.of(context).pop();
  }
}

// ════════════════════════════════════════════════════════════════
// DENIED SCAFFOLD — non-owner kullanıcı için
// ════════════════════════════════════════════════════════════════

class _DeniedScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edîtorên Min'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.home),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_rounded,
                  size: 56, color: AppColors.textTertiary),
              const SizedBox(height: 12),
              Text(
                'Tenê ji bo Rêveberê',
                style: AppTypography.title
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
