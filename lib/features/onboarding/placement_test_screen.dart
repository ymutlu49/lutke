import 'dart:math';

import 'package:flutter/material.dart';
import '../lessons/domain/olcme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../shared/providers/learning_track_provider.dart';
import '../../core/services/cloudflare_auth_service.dart';
import '../lessons/data/lesson_repository.dart';
import '../../shared/widgets/placement_invite_card.dart'
    show placementRevisionProvider;
import 'placement_questions.dart';

export 'placement_questions.dart' show PlacementCefr, PlacementCefrX, PlacementQuestion;

// ════════════════════════════════════════════════════════════════
// LÛTKE — Düzey Belirleme Testi (CEFR Placement Test)
//
// Register/Login → Track Select → BU EKRAN → Home
//
// - GÖNÜLLÜ (Ekim 2026): test artık akışta zorunlu değil. Kullanıcı
//   uygulamaya doğrudan girer; testi ana ekrandaki davetten, düzey
//   seçicisinden ya da profilden kendi isteğiyle açar.
// - AŞAMALI (Ekim 2026): bantlar A1'den yukarı sırayla, bant başına 6 soru
//   (en çok 36). Bir bandın sonucu kesinleşince beklenmez; geçilemeyen ilk
//   bant başlanacak düzeydir ve test orada biter (bkz. olcme.dart).
// - Sorular: placement_questions.dart (Kurmancî: elle yazılmış + düzeyin
//   kendi içeriğinden üretilen; İngilizce: 36 soruluk sabit havuz)
// - "Nizanim" (bilmiyorum) yanlış sayılır; tahmin yürütmeye zorlamaz.
// - Skip ile doğrudan A1'den başlama seçeneği
// - Sonuç kaydı: SharedPreferences `placement_level_{ku|en}` + hesap
//   (POST /api/profile/placement, track parametreli)
// - Test-once: HESAP + TRACK bazlı. Ekran açılışında guard: bu track için
//   seviye zaten varsa (hesap VEYA prefs) ve kullanıcı profilden bilinçli
//   retake ile gelmediyse otomatik home'a yönlendirilir (çifte güvence).
// ════════════════════════════════════════════════════════════════
// NOT: prefs anahtar sabitleri cloudflare_auth_service.dart'ta
// (kPlacementLevelKeyKu/En) — login/me senkronu da aynı anahtarları yazar.

// Pêşniyara testê — testê ji nû ve nedan jî tê parastin. Bila bikarhêner
// di nav astan de bigere lê pêşniyar wenda nebe.
const String _kRecommendedLevelKeyKu = 'recommended_level_ku';
const String _kRecommendedLevelKeyEn = 'recommended_level_en';

/// SharedPreferences anahtarı — track'in languageCode'una göre.
String placementLevelKeyFor(String languageCode) =>
    languageCode == 'en' ? kPlacementLevelKeyEn : kPlacementLevelKeyKu;

/// Testin önerdiği düzey için ayrı anahtar — kullanıcı seviyeyi manuel
/// değiştirse bile placement önerisi kalıcı olarak saklanır.
String recommendedLevelKeyFor(String languageCode) =>
    languageCode == 'en' ? _kRecommendedLevelKeyEn : _kRecommendedLevelKeyKu;

typedef _PQ = PlacementQuestion;

/// CEFR puanlaması.
///
/// Düzey toplam puanla değil, bant bazında başarıyla belirlenir (Faz 6.1):
/// aşağıdan yukarı, soruların en az dörtte üçü doğru olmayan ilk bant
/// başlanacak düzeydir. Eski toplam puan kuralı (2–3 doğru → A2) dört
/// seçenekli soruları rastgele işaretleyen birini beklenen 2,5 doğruyla A2'ye
/// yerleştiriyordu; üst bantta şans eseri doğrular da düzeyi yükseltiyordu.
///
/// [bantlar]: düzey → (doğru, toplam).
PlacementCefr computePlacementLevel(Map<PlacementCefr, (int, int)> bantlar) {
  final kod = yerlestirmeDuzeyi({
    for (final e in bantlar.entries) e.key.label: e.value,
  });
  return PlacementCefr.values.firstWhere((c) => c.label == kod);
}

class PlacementTestScreen extends ConsumerStatefulWidget {
  /// true → kullanıcı profilden bilinçli "Dîsa biceribîne" ile geldi;
  /// yerleşiklik guard'ı atlanır. Router `extra: {'retake': true}` geçirir.
  final bool retake;

  /// Sınamalar için: verilirse aynı tohum aynı soruları üretir.
  final Random? rng;

  const PlacementTestScreen({super.key, this.retake = false, this.rng});

  @override
  ConsumerState<PlacementTestScreen> createState() =>
      _PlacementTestScreenState();
}

class _PlacementTestScreenState extends ConsumerState<PlacementTestScreen> {
  int _index = 0;

  /// questionId → selectedIndex; "Nizanim" (bilmiyorum) için -1.
  final Map<String, int> _answers = {};

  /// Testin bütün soruları, bant sırasıyla. Ekran açılırken bir kez kurulur
  /// (Kurmancî sorularının bir kısmı her açılışta yeniden örneklenir).
  List<_PQ>? _sorular;

  /// Sorulan sorular, soruluş sırasıyla (cevap anahtarı için). Aşamalı
  /// testte bütün sorular sorulmaz.
  final List<_PQ> _sorulanlar = [];
  bool _finished = false;
  PlacementCefr? _result;

  /// Guard tamamlanana kadar test UI'ı render edilmez (flash önlemi).
  /// retake akışında guard yok → direkt test.
  bool _guardDone = false;

  /// Hesaba placement yazıldı, cloudflareCurrentUserProvider tazelenmeyi
  /// bekliyor. Invalidate EKRANDAN AYRILIRKEN yapılır — bkz.
  /// [_refreshAccountAndGo] (router rebuild fix, Tem 2026).
  bool _accountRefreshPending = false;

  @override
  void initState() {
    super.initState();
    if (widget.retake) {
      _guardDone = true;
      return;
    }
    // ÇİFTE GÜVENCE (Temmuz 2026): Gate'ler yanlışlıkla buraya yönlendirse
    // bile — bu track için seviye zaten varsa (hesap VEYA prefs) ve kullanıcı
    // bilinçli retake ile gelmediyse otomatik home'a dön.
    // Profilden `context.push` ile gelen retake akışı canPop==true olur;
    // extra parametresi unutulmuş olsa da test gösterilir (akış korunur).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (context.canPop()) {
        // push ile gelinmiş (profil retake) → guard yok.
        setState(() => _guardDone = true);
        return;
      }
      final track = ref.read(currentTrackProvider);
      final placed = await hasPlacementForTrack(ref, track.languageCode);
      if (!mounted) return;
      if (placed) {
        context.go(track.nativeHomePath);
        return;
      }
      setState(() => _guardDone = true);
    });
  }

  List<_PQ> get _questions => _sorular ??= buildPlacementQuestions(
        english: ref.read(currentTrackProvider).isEnglish,
        rng: widget.rng,
      );

  int get _correctCount {
    int c = 0;
    for (final q in _sorulanlar) {
      if (_answers[q.id] == q.correctIndex) c++;
    }
    return c;
  }

  /// Düzey → (doğru, yanlış, toplam). "Nizanim" yanlış sayılır.
  Map<String, (int, int, int)> _bantDurumu() {
    final bantlar = <String, (int, int, int)>{};
    for (final q in _questions) {
      final (dogru, yanlis, toplam) = bantlar[q.cefr.label] ?? (0, 0, 0);
      final secilen = _answers[q.id];
      bantlar[q.cefr.label] = (
        dogru + (secilen != null && secilen == q.correctIndex ? 1 : 0),
        yanlis + (secilen != null && secilen != q.correctIndex ? 1 : 0),
        toplam + 1,
      );
    }
    return bantlar;
  }

  /// Bu banttan şimdiye dek kaç soru yanıtlandı / bantta kaç soru var.
  (int, int) _bantIlerlemesi(PlacementCefr cefr) {
    final b = _bantDurumu()[cefr.label] ?? (0, 0, 0);
    return (b.$1 + b.$2, b.$3);
  }

  /// "Nizanim": soruyu yanlış say ve ilerle.
  void _bilmiyorum(_PQ q) {
    _answers[q.id] = -1;
    _goNext();
  }

  Future<void> _skipToA1(BuildContext context) async {
    final track = ref.read(currentTrackProvider);
    // Profile > "Dîsa biceribîne" akışında mevcut seviyeyi silmeyelim:
    // önceden B2 olan kullanıcı yanlışlıkla "A1'den başla" derse B2 gidiyordu.
    // Mevcut bir seviye varsa yalnızca track-select'e dön; yoksa A1 yazıp git.
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing =
          prefs.getString(placementLevelKeyFor(track.languageCode));
      if (existing != null && existing.isNotEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Asta heyî hate parastin: ${existing.toUpperCase()}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        // YENİ AKIŞ (Mayıs 2026): track-select → placement → home.
        context.go(track.nativeHomePath);
        return;
      }
    } catch (_) {}
    await _persistLevel(track.languageCode, PlacementCefr.a1);
    if (!context.mounted) return;
    await _refreshAccountAndGo(context, track.nativeHomePath);
  }

  Future<void> _persistLevel(
    String languageCode,
    PlacementCefr level,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        placementLevelKeyFor(languageCode),
        level.code,
      );
    } catch (_) {
      // Sessiz hata — web/pref yoksa kullanıcıyı takılmaz.
    }
    // Ana ekrandaki davet kartı sonucu görsün (aynı örnek olarak kalıyor).
    ref.read(placementRevisionProvider.notifier).state++;
    // userProfileProvider state'ini anlık güncelle → home ekranı doğru
    // seviyeyi gösterir (reload gerekmez).
    try {
      await ref.read(userProfileProvider.notifier).setLevel(level.code);
    } catch (_) {}
    // Hesaba da yaz (account + TRACK bazlı test-once) — cihaz/origin bağımsız.
    // track parametresi: EN testi placement_level_en'e, KU testi
    // placement_level'e yazılır.
    //
    // ROUTER REBUILD FIX (Tem 2026): Eskiden başarılı kayıtta burada hemen
    // `ref.invalidate(cloudflareCurrentUserProvider)` çağrılıyordu. appRouter
    // bu provider'ı watch ettiği için (app_router.dart) invalidate YENİ bir
    // GoRouter instance'ı yaratıyor ve _resolveInitialLocation yalnız token
    // route'larını koruduğundan uygulama splash'a resetleniyordu. _goNext
    // akışında bu, `setState(_finished=true)`'den ÖNCE tetiklendiği için
    // ekran unmount oluyor ve kullanıcı sonuç görünümünü (_ResultView) hiç
    // göremiyordu. Artık yalnız bayrak set edilir; invalidate ekrandan
    // ayrılırken _refreshAccountAndGo içinde yapılır — böylece gate'ler
    // (splash / track-select / intro) yine taze kullanıcıyı görür ama sonuç
    // ekranı kaybolmaz.
    try {
      final updated = await ref
          .read(cloudflareAuthServiceProvider)
          .savePlacementLevel(
            level.code,
            track: languageCode == 'en' ? 'en' : 'ku',
          );
      if (updated != null) _accountRefreshPending = true;
    } catch (_) {}
  }

  /// Ekrandan home'a ayrılırken bekleyen hesap tazelemesini uygular.
  ///
  /// register_screen.dart'taki desen: invalidate → future'ı bekle → ~50ms
  /// settle → context.go. Invalidate appRouter'ı yeniden kurdurduğu için
  /// context.go'nun ESKİ router instance'ına uygulanıp kaybolmaması adına
  /// önce rebuild'in oturması beklenir. Widget bu sırada unmount olursa
  /// (yeni router splash'tan başlar) splash gate'i zaten yerleşmiş
  /// kullanıcıyı home'a yönlendirir — kullanıcı mahsur kalmaz.
  Future<void> _refreshAccountAndGo(
    BuildContext context,
    String location,
  ) async {
    if (_accountRefreshPending) {
      _accountRefreshPending = false;
      ref.invalidate(cloudflareCurrentUserProvider);
      try {
        await ref.read(cloudflareCurrentUserProvider.future);
      } catch (_) {}
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    if (!context.mounted) return;
    context.go(location);
  }

  void _selectOption(_PQ q, int selected) {
    setState(() {
      _answers[q.id] = selected;
    });
  }

  Future<void> _goNext() async {
    final simdiki = _questions[_index];
    if (!_answers.containsKey(simdiki.id)) return;
    if (!_sorulanlar.contains(simdiki)) _sorulanlar.add(simdiki);

    // Aşamalı karar: bant kesinleşmediyse aynı banttan sıradaki soru; geçildiyse
    // üst bant; geçilemediyse test biter.
    final durum = _bantDurumu();
    final adim = yerlestirmeAdimi(durum);
    if (adim.bant != null) {
      final i = _questions.indexWhere(
        (q) => q.cefr.label == adim.bant && !_answers.containsKey(q.id),
      );
      if (i >= 0) {
        setState(() => _index = i);
        return;
      }
    }
    // Test bitti — sonucu hesapla ve sakla. (Yanıtlanmayan sorular yanlış
    // sayılır; karar yerlestirmeAdimi ile aynıdır.)
    final level = computePlacementLevel({
      for (final c in PlacementCefr.values)
        if (durum[c.label] != null) c: (durum[c.label]!.$1, durum[c.label]!.$3),
    });
    final track = ref.read(currentTrackProvider);
    await _persistLevel(track.languageCode, level);
    // Pêşniyara testê serbixwe sakla — paşê bikarhêner asta xwe biguherîne
    // jî pêşniyar wenda nabe.
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        recommendedLevelKeyFor(track.languageCode),
        level.code,
      );
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _result = level;
      _finished = true;
    });
  }

  Future<void> _startAtLevel(
    BuildContext context,
    PlacementCefr level,
  ) async {
    final track = ref.read(currentTrackProvider);
    await _persistLevel(track.languageCode, level);
    if (!context.mounted) return;
    await _refreshAccountAndGo(context, track.nativeHomePath);
  }

  @override
  Widget build(BuildContext context) {
    final track = ref.watch(currentTrackProvider);

    // Guard sürerken test sorularını FLASH'lama — kısa loading göster.
    if (!_guardDone) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              semanticsLabel: 'Tê barkirin',
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _finished && _result != null
                  ? _ResultView(
                      level: _result!,
                      correct: _correctCount,
                      total: _sorulanlar.length,
                      questions: _sorulanlar,
                      answers: _answers,
                      onStart: (lvl) => _startAtLevel(context, lvl),
                    )
                  : _QuestionView(
                      questions: _questions,
                      index: _index,
                      answers: _answers,
                      isEnglishTrack: track.isEnglish,
                      bantIlerlemesi: _bantIlerlemesi(_questions[_index].cefr),
                      onSelect: _selectOption,
                      onNext: _goNext,
                      onDontKnow: () => _bilmiyorum(_questions[_index]),
                      onSkip: () => _skipToA1(context),
                      onClose: () {
                        // Test gönüllü: vazgeçen sonuç yazılmadan geri döner.
                        // Doğrudan adresle gelindiyse (geri yığını yok) ana ekrana.
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(track.nativeHomePath);
                        }
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Soru görünümü ───────────────────────────────────────────────

class _QuestionView extends StatelessWidget {
  final List<_PQ> questions;
  final int index;
  final Map<String, int> answers;
  final bool isEnglishTrack;
  /// Bu bantta (yanıtlanan, toplam) soru sayısı.
  final (int, int) bantIlerlemesi;
  final void Function(_PQ question, int selectedIndex) onSelect;
  final VoidCallback onNext;
  final VoidCallback onDontKnow;
  final VoidCallback onSkip;

  /// Testten sonuç yazmadan çık (düzey değişmez).
  final VoidCallback onClose;

  const _QuestionView({
    required this.questions,
    required this.index,
    required this.answers,
    required this.isEnglishTrack,
    required this.bantIlerlemesi,
    required this.onSelect,
    required this.onNext,
    required this.onDontKnow,
    required this.onSkip,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final q = questions[index];
    final selected = answers[q.id];
    final progress = (index + 1) / questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // UX FIX: Geri/kapat butonu — profile'dan retake eden kullanıcı
        // vazgeçince ekranda mahsur kalmasın. canPop varsa pop, aksi halde
        // home'a dön.
        Row(
          children: [
            SizedBox(
              width: AppSpacing.touchMin,
              height: AppSpacing.touchMin,
              child: IconButton(
                tooltip: 'Vegere',
                icon: const Icon(Icons.close_rounded),
                onPressed: onClose,
              ),
            ),
            const Spacer(),
            Text(
              '${q.cefr.label} · ${bantIlerlemesi.$1 + 1} / ${bantIlerlemesi.$2}',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        // Skip row — "Ji A1 dest pê bike"
        Row(
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
              ),
              onPressed: onSkip,
              icon: const Icon(Icons.skip_next_rounded, size: 18),
              label: Text(
                'Ji A1 dest pê bike',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.borderLight,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Header — pure Kurmancî
        Text(
          'Diyarkirina astê',
          style: AppTypography.caption.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isEnglishTrack
              ? 'Asta xwe bibîne — Îngilîzî'
              : 'Asta xwe bibîne — Kurmancî',
          style: AppTypography.title.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Question card
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              q.cefr.label,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        q.prompt,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      // Üretilen sorularda yardımcı satır ("Türkçesi hangisi?").
                      if ((q.subPrompt ?? '').isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          q.subPrompt!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ).animate().fadeIn(duration: 200.ms),
                const SizedBox(height: AppSpacing.md),

                // Options
                for (var i = 0; i < q.options.length; i++) ...[
                  _OptionTile(
                    label: q.options[i],
                    isSelected: selected == i,
                    onTap: () => onSelect(q, i),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],

                // Yardımcı not — pure Kurmancî
                Text(
                  'Bijareyekê hilbijêre, paşê "Berdewam bike" pêl bike',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),

        // "Nizanim" — bilmeyen tahmin yürütmek zorunda kalmasın. Yanlış
        // sayılır; testi kısaltır ve sonucu şansa bırakmaz. Kaydırma alanının
        // dışında, her ekran boyunda görünür.
        Align(
          alignment: Alignment.center,
          child: TextButton.icon(
            onPressed: onDontKnow,
            icon: const Icon(Icons.help_outline_rounded, size: 18),
            label: const Text('Nizanim · Bilmiyorum'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              minimumSize: const Size(0, AppSpacing.touchMin),
            ),
          ),
        ),

        // Next button
        SizedBox(
          height: AppSpacing.touchPreferred,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            onPressed: selected == null ? null : onNext,
            child: Text(
              index == questions.length - 1 ? 'Encamê bibîne' : 'Berdewam bike',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(
            minHeight: AppSpacing.touchPreferred,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
              width:
                  isSelected ? AppSpacing.borderThick : AppSpacing.borderMedium,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
                size: 22,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sonuç görünümü ──────────────────────────────────────────────
// NOT (2026-05-06): Eskiden chip'lerle alternatif seviye seçtirip ayrı
// "Dest pê bike" butonu vardı — kullanıcı seçimi takibi için StatefulWidget
// idi. CTA 2 kaldırılınca state gereksiz kaldı → StatelessWidget.

class _ResultView extends StatelessWidget {
  final PlacementCefr level;
  final int correct;
  final int total;
  final List<_PQ> questions;
  final Map<String, int> answers;
  final Future<void> Function(PlacementCefr) onStart;

  const _ResultView({
    required this.level,
    required this.correct,
    required this.total,
    required this.questions,
    required this.answers,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          // Büyük rozet
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  level.label,
                  style: AppTypography.display.copyWith(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppSpacing.lg),

          Text(
            'Asta te: ${level.label}',
            textAlign: TextAlign.center,
            style: AppTypography.headline.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$correct ji $total rast',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Text(
              level.descKu,
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // CTA 1: Ji asta pêşniyarkirî dest pê bike
          SizedBox(
            height: AppSpacing.touchPreferred,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              onPressed: () => onStart(level),
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(
                'Ji asta ${level.label} dest pê bike',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Reassurance: pêşniyar e, ne ferman e
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Ev pêşniyar e, ne ferman. Tu dikarî her astê biceribînî — paşê dîsa biguherîne.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // NOT (2026-05-06): "An jî asteke din hilbijêre" CTA 2 bloğu
          // (chip'ler + alt OutlinedButton) kullanıcı isteği üzerine
          // kaldırıldı — üstteki "Ji asta X dest pê bike" CTA 1 ile
          // duplicate görünüyordu. Reassurance kutusu zaten "paşê dîsa
          // biguherîne" diyor; kullanıcı seviyeyi profile'dan değiştirir.

          // Mifteya bersivan — test bitince cevap anahtarı (KU + EN).
          const SizedBox(height: AppSpacing.lg),
          _AnswerKey(questions: questions, answers: answers),
        ],
      ),
    );
  }
}

// ── Mifteya bersivan (Cevap anahtarı) ───────────────────────────
// Test bitince gösterilir: her soru, doğru cevap (yeşil), kullanıcının
// yanlış seçimi (kırmızı) ve kısa Kurmancî açıklama. Hem Kurmancî hem
// İngilizce track'te çalışır — _ResultView ikisini de kullanır.

class _AnswerKey extends StatelessWidget {
  final List<_PQ> questions;
  final Map<String, int> answers;

  const _AnswerKey({required this.questions, required this.answers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.fact_check_rounded,
                size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Mifteya bersivan',
              style: AppTypography.title.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Bersivên rast û şîroveyên kurt li jêr in.',
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < questions.length; i++) ...[
          _AnswerKeyItem(
            number: i + 1,
            q: questions[i],
            selectedIndex: answers[questions[i].id],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _AnswerKeyItem extends StatelessWidget {
  final int number;
  final _PQ q;
  final int? selectedIndex;

  const _AnswerKeyItem({
    required this.number,
    required this.q,
    required this.selectedIndex,
  });

  static const _green = Color(0xFF2E7D32);
  static const _red = Color(0xFFC62828);

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedIndex != null && selectedIndex == q.correctIndex;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$number · ${q.cefr.label}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                size: 18,
                color: isCorrect ? _green : _red,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            q.prompt,
            style: AppTypography.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          if ((q.subPrompt ?? '').isNotEmpty)
            Text(
              q.subPrompt!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < q.options.length; i++) _optionRow(i),
          // Üretilen soruların ve yeni İngilizce soruların açıklaması yok.
          if (q.explanationKu.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline_rounded,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    q.explanationKu,
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
        ],
      ),
    );
  }

  Widget _optionRow(int i) {
    final isCorrectOpt = i == q.correctIndex;
    final isUserPick = selectedIndex == i;
    final isWrongPick = isUserPick && !isCorrectOpt;
    final Color fg =
        isCorrectOpt ? _green : (isWrongPick ? _red : AppColors.textSecondary);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrectOpt
                ? Icons.check_circle_rounded
                : (isWrongPick
                    ? Icons.cancel_rounded
                    : Icons.radio_button_unchecked),
            size: 16,
            color: fg,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              q.options[i],
              style: AppTypography.body.copyWith(
                color:
                    (isCorrectOpt || isWrongPick) ? fg : AppColors.textPrimary,
                fontWeight: isCorrectOpt ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          if (isUserPick) ...[
            const SizedBox(width: 6),
            Text(
              'bersiva te',
              style: AppTypography.labelSmall.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
