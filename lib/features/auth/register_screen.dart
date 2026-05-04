import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/local_auth_service.dart';
import '../../shared/widgets/lutke_logo.dart';

// ════════════════════════════════════════════════════════════════
// KAYIT / GİRİŞ EKRANI — LÛTKE
//
// İlke §1.1: Yargılamayan, destekleyici ton
// İlke §0.5: Kurmancî birincil dil
// İlke §2: Anonim giriş seçeneği (bariyer yok)
// İlke §9: Misyon öncelikli — ödeme duvarı engel değil
// ════════════════════════════════════════════════════════════════

class RegisterScreen extends ConsumerStatefulWidget {
  final bool isLogin;
  const RegisterScreen({super.key, this.isLogin = false});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _loading = false;
  bool _isLogin = false;
  String? _errorMsg;
  bool _passVisible = false;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // ── KAYIT (Yerel Auth — Firebase olmadan) ───────────────────
  // Firebase yapılandırılana kadar SharedPreferences'a yazar.
  // Sahip credential'ları (y.mutlu@alparslan.edu.tr + ysfrns49) ile
  // giriş yapan kullanıcı admin özelliklerini açar.

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _errorMsg = null; });

    try {
      final localAuth = ref.read(localAuthServiceProvider);
      await localAuth.register(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        displayName: _nameCtrl.text.trim(),
      );
      // Owner state'i yenile
      await refreshLocalOwnerState(ref);
      // Provider'ı invalidate et — UI yenilensin
      ref.invalidate(localCurrentUserProvider);

      if (!mounted) return;
      setState(() => _loading = false);
      // Tarayıcının şifre yöneticisine kaydet prompt'u gönder.
      TextInput.finishAutofillContext(shouldSave: true);
      // Yeni akış (Nisan 2026): register → intro → placement → track-select.
      context.go(AppRoutes.introFlow);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        // Raw exception gizli — Kurmancî nazik mesaj.
        _errorMsg = _humanizeAuthError(e, isLogin: false);
      });
    }
  }

  // ── GİRİŞ (Yerel Auth) ──────────────────────────────────────

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _errorMsg = null; });

    try {
      final localAuth = ref.read(localAuthServiceProvider);
      final user = await localAuth.login(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );

      if (!mounted) return;

      if (user != null) {
        await refreshLocalOwnerState(ref);
        ref.invalidate(localCurrentUserProvider);
        setState(() => _loading = false);
        // Tarayıcının şifre yöneticisine kaydet prompt'u gönder.
        TextInput.finishAutofillContext(shouldSave: true);
        // Yeni akış (Nisan 2026): login → intro → placement → track-select.
        context.go(AppRoutes.introFlow);
      } else {
        setState(() {
          _loading = false;
          // Pure Kurmancî — destekleyici ton, ne yapması gerektiği açık.
          _errorMsg = 'E-nav an şîfre ne rast e. '
              'Eger hesabê te tune be, "Tomar bibe" bitikîne.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMsg = _humanizeAuthError(e, isLogin: true);
      });
    }
  }

  /// Auth hatalarını kullanıcı diline çevir — raw `$e` asla gösterilmez.
  /// Pure Kurmancî, action hint dahil.
  String _humanizeAuthError(Object e, {required bool isLogin}) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('network') || msg.contains('socket') ||
        msg.contains('timeout') || msg.contains('connection')) {
      return 'Girêdana înternetê tune. Ji kerema xwe girêdanê kontrol bike.';
    }
    if (msg.contains('exist') || msg.contains('already') ||
        msg.contains('duplicate')) {
      return 'Ev e-nav berê hatiye tomarkirin. Ji kerema xwe "Têkeve" bitikîne.';
    }
    if (msg.contains('weak') || msg.contains('password')) {
      return 'Şîfre qels e — herî kêm 6 tîp pêwîst in.';
    }
    return isLogin
        ? 'Têketin bi ser neket. Ji kerema xwe dîsa biceribîne.'
        : 'Tomarkirin bi ser neket. Ji kerema xwe dîsa biceribîne.';
  }

  // NOT (Nisan 2026): Anonim/misafir giriş kaldırıldı.
  // Firebase yapılandırması tamamlanmadığı için anonim giriş hata
  // veriyordu. Şimdi sadece email + şifre kayıt/giriş açık.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),

                // Logo ve başlık — Kurmancî önce (İlke §0.5)
                _Header(isLogin: _isLogin),

                const SizedBox(height: AppSpacing.xl),

                // Ad — sadece kayıtta
                if (!_isLogin) ...[
                  _buildField(
                    ctrl: _nameCtrl,
                    label: 'Nav',
                    hint: 'Navê xwe binivîse',
                    icon: Icons.person_outline,
                    autofillHints: const [AutofillHints.name],
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Navê xwe binivîse';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // E-nav
                _buildField(
                  ctrl: _emailCtrl,
                  label: 'E-nav',
                  hint: 'e-nav@mînak.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    // RegExp ji bo domain + TLD pejirandinê — toleranslı.
                    final val = v?.trim() ?? '';
                    if (val.isEmpty) {
                      return 'E-nava xwe binivîse';
                    }
                    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(val);
                    if (!ok) {
                      return 'E-naveke rast binivîse (mînak: navê@mînak.com)';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                // Şifre
                _buildField(
                  ctrl: _passCtrl,
                  label: 'Şîfre',
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  obscure: !_passVisible,
                  autofillHints: _isLogin
                      ? const [AutofillHints.password]
                      : const [AutofillHints.newPassword],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    // Submit sırasında tarayıcının şifre kaydet prompt'unu tetikle.
                    TextInput.finishAutofillContext(shouldSave: true);
                    if (_isLogin) {
                      _login();
                    } else {
                      _register();
                    }
                  },
                  suffix: IconButton(
                    icon: Icon(
                      _passVisible ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _passVisible = !_passVisible),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) {
                      return 'Şîfre divê herî kêm 6 tîp be';
                    }
                    return null;
                  },
                ),

                // Şifremi unuttum — sadece girişte
                if (_isLogin) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _forgotPassword,
                      child: Text(
                        'Şîfreya xwe ji bîr kir?',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],

                // Hata mesajı — nazik ton (İlke §1.1)
                // A11Y (19 Nisan): Semantics liveRegion → ekran okuyucu
                // otomatik okur, user odaklanmak zorunda kalmaz.
                if (_errorMsg != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Semantics(
                    liveRegion: true,
                    label: 'Xeletî: ${_errorMsg!}',
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF5350).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFEF5350).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Color(0xFFEF5350), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMsg!,
                              style: AppTypography.caption.copyWith(
                                  color: const Color(0xFFEF5350)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: AppSpacing.lg),

                // Ana buton
                ElevatedButton(
                  onPressed: _loading
                      ? null
                      : (_isLogin ? _login : _register),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          _isLogin ? 'Têkeve' : 'Tomar bibe',
                          style: AppTypography.labelLarge.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Geçiş linki
                TextButton(
                  onPressed: () => setState(() {
                    _isLogin = !_isLogin;
                    _errorMsg = null;
                  }),
                  child: Text(
                    _isLogin
                        ? 'Hesabê te tune? Tomar bibe →'
                        : 'Hesabê te heye? Têkeve →',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Gizlilik notu
                Text(
                  'Agahiyên te bi ewlehî tên parastin.',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffix,
    String? Function(String?)? validator,
    Iterable<String>? autofillHints,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.labelMedium
                .copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium
                .copyWith(color: AppColors.textSecondary.withOpacity(0.5)),
            prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
            suffixIcon: suffix,
            filled: true,
            fillColor: AppColors.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Future<void> _forgotPassword() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _errorMsg = 'Pêşî e-nava xwe binivîse, paşê dîsa biceribîne.');
      return;
    }
    await ref.read(authServiceProvider).sendPasswordReset(email);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lînka guhertina şîfreyê hate şandin bo: $email'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// BAŞLIK — Kurmancî önce (İlke §0.5)
// ════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final bool isLogin;
  const _Header({required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LutkeLogo.brand(iconSize: 72, animated: true),

        const SizedBox(height: AppSpacing.md),

        Text(
          isLogin
              ? 'Bi xêr hatî dîsa'
              : 'Bê ziman, mirov bê kok e!',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textSecondary),
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
      ],
    );
  }
}
