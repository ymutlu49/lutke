import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/child_theme.dart';
import '../domain/time_limit_service.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Mola Hatırlatıcısı
//
// 30 dakika çalışma sonunda çocuğa kibar bir Kurmancî hatırlatıcı:
// gözlerini dinlendir, dışarı çık, hareket et. Engelleyici değil —
// çocuk "Fam kir" dediğinde uygulamayı kullanmaya devam edebilir.
//
// NOT (Nisan 2026): Ebeveyn kontrol sistemi kaldırıldı.
// LÛTKE bir dil öğrenme uygulaması — kısıtlama değil, sağlıklı
// alışkanlık önerisi sunar.
// ════════════════════════════════════════════════════════════════

class TimeUpScreen extends ConsumerWidget {
  const TimeUpScreen({super.key});

  // Fiziksel aktivite önerileri (Kurmancî) — rastgele birini göster.
  // Her öneri: (emoji, başlık, kısa açıklama)
  static const List<(String, String, String)> _suggestions = [
    ('🌳', 'Derkeve derve!',
        'Piçekî li baxçe bigere, hewayê paqij hilîne.'),
    ('⚽', 'Bi hevalan re bilîze!',
        'Top, xurê an lîstikên kolanê — tev bi hev re kêfxweş in.'),
    ('🚴', 'Bi bisîkletê bajo!',
        'Sivik be, bi guh be. Laşê te hez dike!'),
    ('🌸', 'Çavên xwe vehewîne!',
        'Ji ekranê dûr bibe, li dûr binihêre. Çavên te jî dixwazin bêhn bigirin.'),
    ('💃', 'Rabe, bilive!',
        'Piçekî reqisê, bistîre, xwe biaxive — laşê xwe germ bike.'),
    ('🧘', 'Hinekî bêhna xwe bigire!',
        'Li erdê rûnê, çav bigire û nêrîna xwe xweş bike.'),
    ('📚', 'Pirtûkek bixwîne!',
        'Çîrokek bibîne, xeyalê xwe xweş bike.'),
    ('🎨', 'Resim çêke!',
        'Qelem û kaxiz bistîne — hunera te li bendê ye.'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Her oturumda rastgele bir öneri seç (deterministik: saniye bazlı)
    final idx = DateTime.now().second % _suggestions.length;
    final (emoji, title, desc) = _suggestions[idx];

    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Maskot — gülümseyerek öneriyor
              const Text('🐐', style: TextStyle(fontSize: 80))
                  .animate()
                  .fadeIn()
                  .then()
                  .moveY(begin: 0, end: -10, duration: 500.ms)
                  .then()
                  .moveY(begin: -10, end: 0, duration: 500.ms),

              const SizedBox(height: 24),

              // Etkinlik emojisi
              Text(emoji, style: const TextStyle(fontSize: 56))
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .scale(begin: const Offset(0.5, 0.5)),

              const SizedBox(height: 24),

              Text(
                'Wext e ku bêhna xwe bigirî!',
                style: ChildTypography.display.copyWith(
                  color: ChildColors.primary,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 12),

              Text(
                'Te 30 deqîqe xwend. Pîroz be!\nNiha hinekî biliv û bêhna xwe vede.',
                style: ChildTypography.bodyLarge.copyWith(
                  color: ChildColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 800.ms),

              const Spacer(flex: 1),

              // Öneri kartı — fiziksel aktivite
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ChildColors.starYellow.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                  border: Border.all(
                    color: ChildColors.starYellow.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: ChildTypography.title.copyWith(
                        color: ChildColors.accent,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      desc,
                      style: ChildTypography.bodyLarge.copyWith(
                        color: ChildColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 1000.ms),

              const Spacer(flex: 2),

              // "Fam kir" (Anladım) butonu — çocuk devam edebilir
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    // Süre takibini sıfırla — mola alındı, oturum yeniden başlıyor
                    ref.read(timeLimitProvider.notifier).acknowledgeBreak();
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Fam kir, spas!'),
                  style: FilledButton.styleFrom(
                    backgroundColor: ChildColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: ChildTypography.title.copyWith(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ChildSpacing.radiusLg),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 1200.ms),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
