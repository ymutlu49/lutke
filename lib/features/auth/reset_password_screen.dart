import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/cloudflare_auth_service.dart';
import '../../shared/widgets/lutke_goat_icon.dart';

// ════════════════════════════════════════════════════════════════
// SAZKIRINA ŞÎFREYÊ — LÛTKE
//
// Kullanıcı e-postadan gelen "Şîfreyê biguherîne" linkine tıklayınca
// bu ekran açılır: /reset-password?token=…
//
// Token URL'den okunur, kullanıcı yeni şifre + onay yazar, POST eder.
// Başarılı → "Şîfreya te hate guhertin" + login sayfasına dönüş.
// Hatalı/süresi dolmuş → açıklayıcı hata + "Yeni link iste" yönlendirmesi.
// ════════════════════════════════════════════════════════════════

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String? token;
  const ResetPasswordScreen({super.key, this.token});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  // Odak sırası: yeni şifre → (Enter/Next) → tekrar → (Enter) → submit.
  final _confirmFocus = FocusNode();

  bool _loading = false;
  bool _success = false;
  bool _passVisible = false;
  bool _confirmVisible = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    // Token yoksa (link bozuk kopyalanmış / elle açılmış) kullanıcıyı
    // form doldurmadan ÖNCE bilgilendir — submit sonrası sürpriz olmasın.
    final t = widget.token;
    if (t == null || t.isEmpty) {
      _errorMsg = 'Lînk ne derbasdar e — ji ekrana têketinê '
          '"Şîfreya xwe ji bîr kir?" bitikîne û lînka nû bixwaze.\n'
          'Link geçersiz — giriş ekranından "Şifremi unuttum"a dokunup '
          'yeni link iste.';
    }
  }

  @override
  void dispose() {
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_loading) return; // Çift tıklama / Enter spam koruması
    if (!_formKey.currentState!.validate()) return;

    final token = widget.token;
    if (token == null || token.isEmpty) {
      setState(() => _errorMsg =
          'Lînk ne derbasdar e. Ji nû ve daxwaz bike.\n'
          'Link geçersiz. Yeni link iste.');
      return;
    }

    setState(() {
      _loading = true;
      _errorMsg = null;
    });

    final result =
        await ref.read(cloudflareAuthServiceProvider).resetPassword(
              token: token,
              newPassword: _newPassCtrl.text,
            );

    if (!mounted) return;

    if (result.isSuccess) {
      // Tarayıcıya yeni şifreyi kaydetme fırsatı ver (autofill).
      TextInput.finishAutofillContext(shouldSave: true);
      setState(() {
        _loading = false;
        _success = true;
      });
    } else {
      setState(() {
        _loading = false;
        _errorMsg = _humanize(result.errorCode, result.error);
      });
    }
  }

  /// İKİ DİLLİ hata mesajları (Kurmancî + Türkçe) — bu ekran login öncesi
  /// açıldığından dil/track seçimi henüz belli olmayabilir.
  String _humanize(String? code, String? raw) {
    final c = code ?? '';
    if (c == 'token_expired') {
      return 'Lînk demborî bûye. Ji bo lînka nû "Şîfreya xwe ji bîr kir?" bitikîne.\n'
          'Linkin süresi dolmuş. Giriş ekranından "Şifremi unuttum" ile yeni link iste.';
    }
    if (c == 'token_invalid' || c == 'invalid_token' || c == 'token_missing') {
      return 'Ev lînk ne derbasdar e. Ji nû ve daxwaz bike.\n'
          'Bu link geçersiz. Yeni link iste.';
    }
    if (c == 'weak_password') {
      return 'Şîfre pir kurt e — herî kêm 8 tîp pêwîst in.\n'
          'Şifre çok kısa — en az 8 karakter olmalı.';
    }
    if (c == 'rate_limited') {
      return 'Pir gelek hewl. Çend deqe bisekine û paşê biceribîne.\n'
          'Çok fazla deneme. Birkaç dakika bekleyip tekrar dene.';
    }
    if (c == 'network') {
      return 'Girêdana înternetê tune. Ji kerema xwe biceribîne.\n'
          'İnternet bağlantısı yok. Lütfen tekrar dene.';
    }
    return 'Tiştek xelet bû. Ji kerema xwe dîsa biceribîne.\n'
        'Bir şeyler ters gitti. Lütfen tekrar dene.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: _success ? _buildSuccess() : _buildForm(),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_outline,
              color: Color(0xFF4CAF50), size: 56),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Şîfreya te hate guhertin!',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Niha bi şîfreya nû têkeve.\nŞimdi yeni şifrenle giriş yap.',
          style:
              AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        ElevatedButton(
          onPressed: () => context.go(AppRoutes.login),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            'Têkeve',
            style: AppTypography.labelLarge
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          const Center(child: LutkeGoatIcon(size: 72)),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Şîfreya nû binivîse',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Şîfreya nû ya hesabê xwe binivîse û cardin piştrast bike.\n'
            'Hesabın için yeni şifre yaz ve tekrar doğrula.',
            style: AppTypography.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Yeni şifre
          _buildField(
            ctrl: _newPassCtrl,
            label: 'Şîfreya nû',
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscure: !_passVisible,
            visibleToggle: () =>
                setState(() => _passVisible = !_passVisible),
            isVisible: _passVisible,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _confirmFocus.requestFocus(),
            validator: (v) {
              if (v == null || v.length < 8) {
                return 'Şîfre herî kêm 8 tîp · Şifre en az 8 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),

          // Şifre tekrar
          _buildField(
            ctrl: _confirmPassCtrl,
            label: 'Cardin binivîse',
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscure: !_confirmVisible,
            visibleToggle: () =>
                setState(() => _confirmVisible = !_confirmVisible),
            isVisible: _confirmVisible,
            focusNode: _confirmFocus,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Şîfreyê cardin binivîse · Şifreni tekrar yaz';
              }
              if (v != _newPassCtrl.text) {
                return 'Şîfre ne wek hev in · Şifreler eşleşmiyor';
              }
              return null;
            },
          ),

          if (_errorMsg != null) ...[
            const SizedBox(height: AppSpacing.md),
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
                      style: AppTypography.caption
                          .copyWith(color: const Color(0xFFEF5350)),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.lg),

          ElevatedButton(
            onPressed: _loading ? null : _submit,
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
                    'Şîfreyê biguherîne',
                    style: AppTypography.labelLarge.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
          ),

          const SizedBox(height: AppSpacing.md),

          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            child: Text(
              'Têketinê veke · Girişe dön',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    required bool obscure,
    required VoidCallback visibleToggle,
    required bool isVisible,
    String? Function(String?)? validator,
    FocusNode? focusNode,
    TextInputAction textInputAction = TextInputAction.done,
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
          focusNode: focusNode,
          obscureText: obscure,
          validator: validator,
          autofillHints: const [AutofillHints.newPassword],
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary.withOpacity(0.5)),
            prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
            suffixIcon: IconButton(
              tooltip: isVisible
                  ? 'Şîfreyê veşêre · Şifreyi gizle'
                  : 'Şîfreyê nîşan bide · Şifreyi göster',
              icon: Icon(
                isVisible ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textSecondary,
              ),
              onPressed: visibleToggle,
            ),
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
              borderSide:
                  const BorderSide(color: Color(0xFFEF5350), width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
