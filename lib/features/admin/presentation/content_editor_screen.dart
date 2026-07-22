import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/local_auth_service.dart';
import '../data/content_override_service.dart';
import '../data/cultural_content_override_service.dart';
import '../data/custom_quiz_service.dart';
import '../data/lesson_override_service.dart';
import 'content_cultural_tab.dart';
import 'content_lessons_tab.dart';
import 'content_quiz_tab.dart';
import 'content_words_tab.dart';

// ════════════════════════════════════════════════════════════════
// MUHERRIRÊ NAVEROKÊ — Hub şeklinde içerik yönetim ekranı
//
// Kullanıcı dostu yaklaşım:
//   1. Hub ekranı: 4 büyük kategori kartı (Peyv / Wane / Quiz /
//      Çand). Her kart üzerinde "kaç değişiklik var" rozeti.
//   2. Kart tıklanınca → o kategorinin tam editörü açılır
//      (FullScreen) — derin tab yapısı yerine düz akış.
//   3. AppBar'da hızlı eylemler: Reset, Export, Import (export/import
//      şu anda yalnız Çand içinde — diğer kategoriler için aynı
//      pattern eklenir).
//   4. Total değişiklik sayısı header'da görünür.
//
// Eski 3-tab tasarım yerine bu yapı seçildi:
//   - Tab navigasyonu küçük ekranda 4-5 kategori için sıkışık.
//   - Her kategori bağımsız bir "düzenleme oturumu" gibi görünür —
//     odaklanmış UX.
//   - Hub geri dönüş zihinsel modeli sağlar (her zaman home'a
//     dönülebilir).
// ════════════════════════════════════════════════════════════════

class ContentEditorScreen extends ConsumerWidget {
  const ContentEditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwner = ref.watch(isOwnerProvider);
    if (!isOwner) {
      return const _OwnerDenied();
    }

    final wordOverrides = ref.watch(contentOverridesProvider);
    final wordDeleted = ref.watch(deletedWordIdsProvider);
    final wordCustom = ref.watch(customWordsProvider);
    final lessonOverrides = ref.watch(lessonOverridesProvider);
    final customQs = ref.watch(customQuizQuestionsProvider);
    final cultOverrides = ref.watch(culturalOverridesProvider);
    final cultDeleted = ref.watch(deletedCulturalIdsProvider);
    final cultCustom = ref.watch(customCulturalItemsProvider);

    final wordChanges =
        wordOverrides.length + wordDeleted.length + wordCustom.length;
    final lessonChanges = lessonOverrides.length;
    final quizChanges = customQs.length;
    final cultChanges =
        cultOverrides.length + cultDeleted.length + cultCustom.length;

    final total = wordChanges + lessonChanges + quizChanges + cultChanges;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Row(
          children: [
            const Icon(Icons.edit_note_rounded,
                color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              'Edîtor',
              style:
                  AppTypography.headingSmall.copyWith(color: Colors.white),
            ),
            const Spacer(),
            if (total > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$total guhertin',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            tooltip: 'Alîkarî',
            onPressed: () => _showHelp(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Naverokê hilbijêre ku tu dixwazî biguherînî',
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w700).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Hemû guhertin di cihazê de tê parastin — derav nayê girtin.',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // ── 4 kategori kartı ──
              Expanded(
                child: GridView(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  children: [
                    _CategoryCard(
                      icon: Icons.menu_book_rounded,
                      title: 'Peyv',
                      subtitle: 'Kelimeler',
                      color: const Color(0xFF4CAF50),
                      changes: wordChanges,
                      onTap: () => _open(context, const _WordsEditor()),
                    ),
                    _CategoryCard(
                      icon: Icons.school_rounded,
                      title: 'Wane',
                      subtitle: 'Dersler',
                      color: const Color(0xFF2196F3),
                      changes: lessonChanges,
                      onTap: () => _open(context, const _LessonsEditor()),
                    ),
                    _CategoryCard(
                      icon: Icons.quiz_rounded,
                      title: 'Quiz',
                      subtitle: 'Sorular',
                      color: const Color(0xFFFF9800),
                      changes: quizChanges,
                      onTap: () => _open(context, const _QuizEditor()),
                    ),
                    _CategoryCard(
                      icon: Icons.theater_comedy_rounded,
                      title: 'Çand',
                      subtitle: 'Kültürel İçerik',
                      color: const Color(0xFF9C27B0),
                      changes: cultChanges,
                      onTap: () => _open(context, const _CulturalEditor()),
                    ),
                  ],
                ),
              ),

              // ── Footer: hızlı eylemler ──
              const SizedBox(height: 12),
              if (total > 0) _BulkActions(),
            ],
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _showHelp(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Çawa bi kar tînim?'),
        content: const SingleChildScrollView(
          child: Text(
            '• Her karta naverokê — wek bingehê — giraneya xwe ya '
            'taybet heye.\n\n'
            '• Yek tikan li kartê bide → editorê wê derbas bibe.\n\n'
            '• Edît bike, jê bibe, naverokeke nû lê zêde bike.\n\n'
            '• Tu dikarî her dem li ser bingehê orjînal vegerî.\n\n'
            '• Hemû guhertin di cihazê de tê parastin — '
            'tu pêdivîtî pevgirtina înternetê tune ye.',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CATEGORY CARD
// ════════════════════════════════════════════════════════════════

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final int changes;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.changes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 26, color: color),
                  ),
                  const Spacer(),
                  if (changes > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$changes',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    'Veke',
                    style: AppTypography.caption.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 16, color: color),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// BULK ACTIONS — sıfırla, export
// ════════════════════════════════════════════════════════════════

class _BulkActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              size: 18, color: Colors.orange.shade700),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Te guhertin hene',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _resetAll(context, ref),
            child: Text(
              'Hemûyan rake',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resetAll(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hemû guhertinan rake?'),
        content: const Text(
          'Hemû Peyv, Wane, Quiz û Çand guhertinên te dê bê rakirin. '
          'Naverok dê vegere ser rewşa orjînal. Vê derê venayê.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vegere'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Erê, hemûyan rake'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    await ref.read(contentOverridesProvider.notifier).clearAll();
    await ref.read(deletedWordIdsProvider.notifier).clearAll();
    await ref.read(customWordsProvider.notifier).clearAll();
    await ref.read(lessonOverridesProvider.notifier).clearAll();
    await ref.read(customQuizQuestionsProvider.notifier).clearAll();
    await ref.read(culturalOverridesProvider.notifier).clearAll();
    await ref.read(deletedCulturalIdsProvider.notifier).clearAll();
    await ref.read(customCulturalItemsProvider.notifier).clearAll();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hemû guhertin hatin rakirin.'),
        ),
      );
    }
  }
}

// ════════════════════════════════════════════════════════════════
// SUB-EDITOR WRAPPERS — full screen with consistent appbar
// ════════════════════════════════════════════════════════════════

/// Geri dönüş butonu garanti — Navigator.pop her durumda çalışır.
AppBar _subEditorAppBar(BuildContext context, String title,
    {List<Widget>? actions}) {
  return AppBar(
    backgroundColor: AppColors.primaryDark,
    title: Text(title, style: const TextStyle(color: Colors.white)),
    iconTheme: const IconThemeData(color: Colors.white),
    leading: IconButton(
      tooltip: 'Vegere',
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: actions,
  );
}

class _WordsEditor extends StatelessWidget {
  const _WordsEditor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: _subEditorAppBar(context, 'Peyv'),
      body: const ContentWordsTab(),
    );
  }
}

class _LessonsEditor extends StatelessWidget {
  const _LessonsEditor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: _subEditorAppBar(context, 'Wane'),
      body: const ContentLessonsTab(),
    );
  }
}

class _QuizEditor extends StatelessWidget {
  const _QuizEditor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: _subEditorAppBar(context, 'Quiz'),
      body: const ContentQuizTab(),
    );
  }
}

class _CulturalEditor extends ConsumerWidget {
  const _CulturalEditor();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: _subEditorAppBar(
        context,
        'Çand',
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (v) async {
              switch (v) {
                case 'export':
                  await _exportCultural(context, ref);
                  break;
                case 'reset':
                  await _resetCultural(context, ref);
                  break;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.upload_file, size: 18),
                    SizedBox(width: 8),
                    Text('JSON eksport bike'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.restore, size: 18),
                    SizedBox(width: 8),
                    Text('Çandê vegerîne'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: const ContentCulturalTab(),
    );
  }

  Future<void> _exportCultural(BuildContext context, WidgetRef ref) async {
    final svc = ref.read(culturalContentOverrideServiceProvider);
    final json = await svc.exportJson();
    if (!context.mounted) return;
    await Clipboard.setData(ClipboardData(text: json));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('JSON kopîya hat girtin.'),
      ),
    );
  }

  Future<void> _resetCultural(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Çand guhertinan rake?'),
        content: const Text(
          'Tenê guhertinên Çandê dê bên rakirin. Peyv, Wane û Quiz '
          'guhertinên te dê bimînin.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vegere'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Erê'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    await ref.read(culturalOverridesProvider.notifier).clearAll();
    await ref.read(deletedCulturalIdsProvider.notifier).clearAll();
    await ref.read(customCulturalItemsProvider.notifier).clearAll();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Çand guhertin hatin rakirin.')),
      );
    }
  }
}

// ════════════════════════════════════════════════════════════════
// OWNER DENIED — QUICK LOGIN FORM
// Yönetici değilse: e-posta + şifre formu ile yetkilen.
// ════════════════════════════════════════════════════════════════

class _OwnerDenied extends ConsumerStatefulWidget {
  const _OwnerDenied();

  @override
  ConsumerState<_OwnerDenied> createState() => _OwnerDeniedState();
}

class _OwnerDeniedState extends ConsumerState<_OwnerDenied> {
  late final TextEditingController _emailCtrl;
  final _passCtrl = TextEditingController();
  bool _busy = false;
  String? _error;
  bool _showPass = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill: configured owner email (still requires correct password).
    _emailCtrl = TextEditingController(text: kOwnerEmailLocal);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Text(
          'Edîtorê Naverokê',
          style: AppTypography.headingSmall.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.admin_panel_settings_rounded,
                      size: 38,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'Têketina Rêveberiyê',
                    textAlign: TextAlign.center,
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ji bo edîtkirina naverokê, bi credential\'ên rêveberiyê '
                    'derbas bibe.',
                    textAlign: TextAlign.center,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Email
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'E-name',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
                      enabled: !_busy,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Password
                  TextField(
                    controller: _passCtrl,
                    obscureText: !_showPass,
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: 'Şîfre',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_showPass
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            setState(() => _showPass = !_showPass),
                      ),
                      border: const OutlineInputBorder(),
                      enabled: !_busy,
                    ),
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              size: 18, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: AppTypography.caption.copyWith(
                                color: Colors.red.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 48,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: _busy ? null : _submit,
                      icon: _busy
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.login),
                      label: Text(_busy ? 'Tê kontrol kirin…' : 'Têkeve'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,
                            size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'E-name û şîfreya rêveberiyê li ber dema avakirinê '
                            'tê dîyar kirin (`--dart-define` an `admin_config.dart`). '
                            'Tu nikarî vê derê serbest hesab biafirîne.',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_busy) return;
    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'E-name û şîfreyê tijî bike.');
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      final svc = ref.read(localAuthServiceProvider);
      final user = await svc.login(email: email, password: password);
      if (user == null) {
        if (!mounted) return;
        setState(() {
          _busy = false;
          _error = 'E-name an şîfre çewt e.';
        });
        return;
      }
      if (!user.isOwner) {
        if (!mounted) return;
        setState(() {
          _busy = false;
          _error = 'Ev hesab ne hesabê rêveberiyê ye.';
        });
        return;
      }
      // Refresh provider state
      await refreshLocalOwnerState(ref);
      if (!mounted) return;
      // The build will re-evaluate isOwnerProvider and now show the hub.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tê dîtin xêr hatî, rêveber!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Çewtî: $e';
      });
    }
  }
}
