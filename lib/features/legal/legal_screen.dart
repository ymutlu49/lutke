import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Legal Screens (Privacy Policy + Terms of Service)
//
// Play Store / KVKK / GDPR / COPPA gereksinimi:
//   • Gizlilik Politikası uygulama içinden erişilebilir olmalı
//   • Kullanım Koşulları açıkça gösterilmeli
//   • Onboarding sırasında kabul edilmeli (consent)
//
// Kullanım:
//   AppRoutes.privacyPolicy → PrivacyPolicyScreen()
//   AppRoutes.termsOfService → TermsOfServiceScreen()
//   AppRoutes.aboutLegal → LegalIndexScreen()
//
// Metin kaynakları: legal/privacy_policy_tr.md, legal/terms_of_service_tr.md
// (markdown'dan değil, sürdürülebilirlik için Dart sabitlerinden)
// ════════════════════════════════════════════════════════════════

class LegalIndexScreen extends StatelessWidget {
  const LegalIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: const Text('Yasal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _LegalTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Gizlilik Politikası',
            subtitle: 'Verilerinizi nasıl koruyoruz',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivacyPolicyScreen(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _LegalTile(
            icon: Icons.gavel_outlined,
            title: 'Kullanım Koşulları',
            subtitle: 'Uygulama kullanım şartları',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TermsOfServiceScreen(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _LegalTile(
            icon: Icons.info_outline,
            title: 'Hakkında',
            subtitle: 'Uygulama bilgileri',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AboutScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LegalTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        )),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Gizlilik Politikası ─────────────────────────────────────────

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _LegalDocScaffold(
      title: 'Gizlilik Politikası',
      lastUpdated: '25 Nisan 2026',
      sections: _privacyPolicySections,
    );
  }
}

// ── Kullanım Koşulları ──────────────────────────────────────────

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _LegalDocScaffold(
      title: 'Kullanım Koşulları',
      lastUpdated: '25 Nisan 2026',
      sections: _termsOfServiceSections,
    );
  }
}

// ── Hakkında ────────────────────────────────────────────────────

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: const Text('Hakkında'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(
            child: Text('LÛTKE',
                style: AppTypography.display.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                )),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Text('Zimanê Kurdî',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                )),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _InfoRow(
            label: 'Sürüm',
            // build.gradle'da versionName + Play Store'da gösterilen
            // sürüm. Uygulama güncellenirse bu değer manuel güncellenmeli.
            value: '1.0.0 (build 1)',
          ),
          const _InfoRow(
            label: 'Yayıncı',
            value: 'Prof. Dr. Yılmaz Mutlu',
          ),
          const _InfoRow(
            label: 'Tarih',
            value: 'Nisan 2026',
          ),
          const _InfoRow(
            label: 'İletişim',
            value: 'info@lutke.app',
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Akademik Kaynaklar',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '• Emir Celadet Bedirxan — Hawar alfabesi (1932)\n'
            '• Kemal Badıllı — Türkçe İzahlı Kürtçe Grameri (1965)\n'
            '• Yılmaz Mutlu — Gotinên Pêşiyan Derlemesi\n'
            '• Institut Kurde de Paris\n'
            '• Kurdipedia',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: SelectableText(value,
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                )),
          ),
        ],
      ),
    );
  }
}

// ── Ortak doc scaffold ──────────────────────────────────────────

class _LegalDocScaffold extends StatelessWidget {
  final String title;
  final String lastUpdated;
  final List<_DocSection> sections;

  const _LegalDocScaffold({
    required this.title,
    required this.lastUpdated,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('Son güncelleme: $lastUpdated',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final s in sections) ...[
            Text(s.heading,
                style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(height: AppSpacing.sm),
            SelectableText(s.body,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                )),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _DocSection {
  final String heading;
  final String body;
  const _DocSection(this.heading, this.body);
}

// ── İçerik (legal/*.md'den özet) ────────────────────────────────

const _privacyPolicySections = <_DocSection>[
  _DocSection(
    '1. Veri Sorumlusu',
    'LÛTKE — Zimanê Kurdî\nYayıncı: Prof. Dr. Yılmaz Mutlu\nİletişim: info@lutke.app',
  ),
  _DocSection(
    '2. Topladığımız Veriler',
    'Otomatik veriler:\n'
        '  • Cihaz modeli ve OS sürümü\n'
        '  • Anonim kullanım istatistikleri (FSRS algoritması)\n'
        '  • Çökme raporları (Crashlytics — kişisel veri içermez)\n\n'
        'Hesap oluşturursanız:\n'
        '  • E-posta adresi ve görünen ad\n'
        '  • Şifre (Firebase tarafından şifrelenmiş)\n'
        '  • Öğrenme ilerlemesi (XP, streak, CEFR)\n\n'
        'Konuşma pratiği:\n'
        '  • Mikrofon kaydı CİHAZINIZDA işlenir\n'
        '  • Sunuculara yalnızca anonim eşleşme skoru gönderilir\n'
        '  • Ham ses verisi SAKLANMAZ',
  ),
  _DocSection(
    '3. Çocuk Modu (8-12 yaş)',
    '• Çocuk modu için VELİ ONAYI ve PIN kodu zorunludur.\n'
        '• Yalnızca yaş aralığı (7-10) toplanır; ad/e-posta/iletişim TOPLANMAZ.\n'
        '• Reklam GÖSTERİLMEZ, üçüncü taraf izleme YAPILMAZ.\n'
        '• COPPA (ABD) ve KVKK (TR) uyumlu.\n'
        '• Veli, herhangi bir zamanda veriyi silmeyi talep edebilir.',
  ),
  _DocSection(
    '4. Üçüncü Taraf Servisler',
    '• Firebase (Google LLC): Authentication, Firestore, Crashlytics\n'
        '• HuggingFace Spaces: Kurmancî TTS (yalnızca metin gönderilir)\n'
        '• Google Fonts: Yazı tipi yüklemesi',
  ),
  _DocSection(
    '5. Haklarınız (KVKK m.11 / GDPR Art. 15-22)',
    '✓ Erişim — verilerinizi sorgulayabilirsiniz\n'
        '✓ Düzeltme — yanlış verileri düzeltme\n'
        '✓ Silme — Profil → Hesabı Sil ile tüm verilerinizi silme\n'
        '✓ Taşınabilirlik — JSON formatında dışa aktarma\n'
        '✓ İtiraz — meşru menfaate dayalı işlemeye itiraz\n'
        '✓ Şikayet — KVKK Kurulu\'na başvuru\n\n'
        'Talep için: info@lutke.app',
  ),
  _DocSection(
    '6. Veri Saklama Süresi',
    '• Aktif hesap: Hesabınız aktif olduğu sürece\n'
        '• Hesap silme: 30 gün içinde tüm veriler kalıcı olarak silinir\n'
        '• Anonim istatistikler: Kişiyle ilişkilendirilemeyen toplu veriler 24 ay',
  ),
  _DocSection(
    '7. Veri Güvenliği',
    '• Tüm transferler TLS/HTTPS ile şifrelenir\n'
        '• Firebase Google ISO 27001/27017/27018 sertifikalı altyapısı\n'
        '• Şifreler Argon2/PBKDF2 ile hash\'lenmiş saklanır\n'
        '• Yerel cihaz veritabanı cihaz şifrelemesi altında',
  ),
  _DocSection(
    '8. İletişim',
    'Sorularınız için: info@lutke.app\n\n'
        'KVKK 6698 — Kişisel Verilerin Korunması Kanunu\n'
        'GDPR — Regulation (EU) 2016/679\n'
        'COPPA — Children\'s Online Privacy Protection Act',
  ),
];

const _termsOfServiceSections = <_DocSection>[
  _DocSection(
    '1. Hizmetin Tanımı',
    'LÛTKE, Kurmancî (Kuzey Kürtçe) ve İngilizce öğrenmek için tasarlanmış bir mobil dil öğrenim uygulamasıdır. CEFR seviyelerinde (A1–C2) içerik sunar.',
  ),
  _DocSection(
    '2. Kullanıcı Hesabı',
    '• Hesap oluşturmak için 13 yaşında veya daha büyük olmalısınız\n'
        '• Hesap bilgilerinizin doğruluğundan SİZ sorumlusunuz\n'
        '• Şifrenizi gizli tutmakla yükümlüsünüz',
  ),
  _DocSection(
    '3. İçerik Kullanım Hakkı',
    'LÛTKE içeriği telif hakkıyla korunur:\n'
        '• Yayıncı: Prof. Dr. Yılmaz Mutlu\n'
        '• Atasözleri: Yılmaz Mutlu derlemesi\n'
        '• Kullanım: Sadece kişisel, ticari olmayan eğitim amaçlı\n\n'
        'Yapamayacaklarınız:\n'
        '✗ İçeriği kopyalama veya satışa sunma\n'
        '✗ Tersine mühendislik, demontaj\n'
        '✗ Otomatik script/bot kullanımı\n'
        '✗ Sahte hesap oluşturma',
  ),
  _DocSection(
    '4. Sorumluluk Reddi',
    '• LÛTKE bir öğrenim aracıdır, RESMİ SERTİFİKA DEĞİLDİR\n'
        '• CEFR seviyeleri gösterici amaçlıdır, akademik geçerliliği yoktur\n'
        '• Uygulama "OLDUĞU GİBİ" sunulur, kesintisizlik garantisi yoktur\n'
        '• Veri kaybı için mali sorumluluk kabul edilmez (yedekleme önerilir)',
  ),
  _DocSection(
    '5. Hesap Sona Erdirme',
    '• Hesabınızı istediğiniz zaman silebilirsiniz (Profil → Hesabı Sil)\n'
        '• Bu Koşulları ihlal ederseniz hesabınız askıya alınabilir',
  ),
  _DocSection(
    '6. Uygulanacak Hukuk',
    '• Bu sözleşme Türkiye Cumhuriyeti hukukuna tabidir\n'
        '• Anlaşmazlıklar Muş mahkemelerinde çözülür',
  ),
  _DocSection(
    '7. İletişim',
    'info@lutke.app',
  ),
];
