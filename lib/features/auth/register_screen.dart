import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/user_segment.dart';

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

  // ── KAYIT ──────────────────────────────────────────────────

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _errorMsg = null; });

    final result = await ref.read(authServiceProvider).registerWithEmail(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
      displayName: _nameCtrl.text.trim(),
      initialProfile: const UserProfile(
        userId: '',
        currentLevel: 'a1',
        targetLevel: 'b1',
        isHeritage: false,
        dailyGoal: 20,
      ),
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (result.isSuccess) {
      context.go(AppRoutes.home);
    } else {
      setState(() => _errorMsg = result.error);
    }
  }

  // ── GİRİŞ ──────────────────────────────────────────────────

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _errorMsg = null; });

    final result = await ref.read(authServiceProvider).signInWithEmail(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (result.isSuccess) {
      context.go(AppRoutes.home);
    } else {
      setState(() => _errorMsg = result.error);
    }
  }

  // ── ANONİM GİRİŞ ──────────────────────────────────────────
  // İlke §2: Bariyer koyma — misafir olarak başlat

  Future<void> _loginAnonymously() async {
    setState(() { _loading = true; _errorMsg = null; });

    final result = await ref.read(authServiceProvider).signInAnonymously();

    if (!mounted) return;
    setState(() => _loading = false);

    if (result.isSuccess) {
      context.go(AppRoutes.passiveTest); // Onboarding'e yönlendir
    } else {
      setState(() => _errorMsg = result.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
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
                    label: 'Nav — Ad',
                    hint: 'Navê xwe binivîse',
                    icon: Icons.person_outline,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Nav lazim e';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // E-posta
                _buildField(
                  ctrl: _emailCtrl,
                  label: 'E-name — E-posta',
                  hint: 'e-name@mînak.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || !v.contains('@')) {
                      return 'E-nameya derbasdar binivîse';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                // Şifre
                _buildField(
                  ctrl: _passCtrl,
                  label: 'Şîfre — Parola',
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  obscure: !_passVisible,
                  suffix: IconButton(
                    icon: Icon(
                      _passVisible ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _passVisible = !_passVisible),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) {
                      return 'Şîfre divê 6 tîpan mezintir be';
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
                if (_errorMsg != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Container(
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
                          _isLogin ? 'Têkeve' : 'Destpê bike',
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

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('an jî — ya da'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),

                // Misafir girişi — bariyer yok (İlke §2, §9)
                OutlinedButton.icon(
                  onPressed: _loading ? null : _loginAnonymously,
                  icon: const Icon(Icons.person_outline),
                  label: Text(
                    'Bê hesab dewam bike — Hesapsız devam',
                    style: AppTypography.labelMedium
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    side: BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Gizlilik notu
                Text(
                  'Agahiyên te bi ewlehî tên paristin.',
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
      setState(() => _errorMsg = 'E-nameya xwe binivîse û dîsa biceribîne');
      return;
    }
    await ref.read(authServiceProvider).sendPasswordReset(email);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Şîfreya sifirkirinê hate şandin: $email'),
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
        // Logo
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'L',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
          ),
        ).animate().scale(
              begin: const Offset(0, 0),
              curve: Curves.elasticOut,
              duration: 500.ms,
            ),

        const SizedBox(height: AppSpacing.md),

        Text(
          'LÛTKE',
          style: AppTypography.headingLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          isLogin
              ? 'Bi xêr hatî dîsa' // Yeniden hoş geldin
              : 'Zimanê xwe vegerîne', // Dilini geri al
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textSecondary),
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }
}
