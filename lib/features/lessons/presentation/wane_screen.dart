import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/sound_service.dart';
import '../../../core/services/tts_asset_manifest.dart';
import '../../../shared/providers/activity_outcome.dart';
import '../../../shared/providers/lesson_progress_provider.dart';
import '../../../shared/services/skill_progress_service.dart';
import '../../../shared/widgets/speak_button.dart';
import '../../gamification/gamification_provider.dart';
import '../domain/lesson_catalog.dart';
import '../domain/lesson_entities.dart';

// ════════════════════════════════════════════════════════════════
// WANE EKRANI — elle yazılmış bir dersi oynatır
//
// Ders = sıralı egzersizler; her biri kendi dilbilgisi / kültür notunu
// taşır. Üç görünüm vardır:
//   • seçmeli (multipleChoice, listenAndSelect, fillInBlank)
//   • sıralama (dragAndDrop) — parçalara dokunarak cümle kur
//   • konuşma (speakingPractice) — dinle, söyle; puana girmez
//
// Ses: derslerdeki `audioAsset` yolları (assets/audio/a1/…mp3) hiç
// üretilmemiş. Hoparlör yalnız metnin HAZIR sesi varsa gösterilir.
// ════════════════════════════════════════════════════════════════

class WaneScreen extends ConsumerStatefulWidget {
  final String lessonId;
  const WaneScreen({super.key, required this.lessonId});

  @override
  ConsumerState<WaneScreen> createState() => _WaneScreenState();
}

class _WaneScreenState extends ConsumerState<WaneScreen> {
  late final LessonModel? _lesson = lessonById(widget.lessonId);
  int _index = 0;
  int _correct = 0;
  int _xp = 0;
  bool _answered = false;
  bool _lastCorrect = false;
  int? _selected;
  final List<String> _dizilen = []; // sıralama egzersizinde seçilen parçalar
  bool _bitti = false;
  bool _raporlandi = false;

  List<ExerciseModel> get _egzersizler => _lesson?.exercises ?? const [];
  ExerciseModel get _e => _egzersizler[_index];
  int get _puanlanan => _egzersizler.where(isScored).length;

  void _cevapla(bool dogru) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _lastCorrect = dogru;
      if (dogru) {
        _correct++;
        _xp += _e.xpReward;
      }
    });
    dogru ? SoundService.playCorrect() : SoundService.playWrong();
  }

  void _sonraki() {
    SpeakButton.stopAll();
    if (_index >= _egzersizler.length - 1) {
      setState(() => _bitti = true);
      return;
    }
    setState(() {
      _index++;
      _answered = false;
      _lastCorrect = false;
      _selected = null;
      _dizilen.clear();
    });
  }

  void _bastan() {
    setState(() {
      _index = 0;
      _correct = 0;
      _xp = 0;
      _answered = false;
      _lastCorrect = false;
      _selected = null;
      _dizilen.clear();
      _bitti = false;
      _raporlandi = false;
    });
  }

  void _cik() =>
      context.canPop() ? context.pop() : context.go(AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    final lesson = _lesson;
    if (lesson == null || _egzersizler.isEmpty) {
      ActivityOutcome.reportNoContent();
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: _cik,
          ),
        ),
        body: Center(
          child: Text('Wane tune ye.',
              style: AppTypography.bodyLarge
                  .copyWith(color: AppColors.textSecondary)),
        ),
      );
    }
    if (_bitti) return _sonucEkrani(lesson);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _ustBar(lesson),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.lg),
                child: KeyedSubtree(
                  key: ValueKey(_e.id),
                  child: switch (_e.type) {
                    ExerciseType.speakingPractice => _konusma(),
                    ExerciseType.dragAndDrop => _siralama(),
                    _ => _secmeli(),
                  },
                ).animate().fadeIn(duration: 200.ms),
              ),
            ),
            if (_answered) _altBar(),
          ],
        ),
      ),
    );
  }

  // ── Üst bar: kapat + ilerleme ───────────────────────────────

  Widget _ustBar(LessonModel lesson) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.sm, 8, AppSpacing.md, 4),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                tooltip: 'Derkeve',
                onPressed: _cik,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: (_index + (_answered ? 1 : 0)) / _egzersizler.length,
                    minHeight: 8,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text('${_index + 1} / ${_egzersizler.length}',
                  style: AppTypography.label
                      .copyWith(color: AppColors.textSecondary)),
            ],
          ),
          Text(
            lesson.kurmanjTitle,
            textAlign: TextAlign.center,
            style: AppTypography.label.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  // ── Soru metni (Kurmancî + varsa hoparlör + Türkçe yönerge) ──

  Widget _soruMetni({bool buyuk = false}) {
    final ku = _e.kurmanjPrompt.trim();
    final tr = (_e.turkishPrompt ?? '').trim();
    final sesVar = TtsAssetManifest.lookup(ku) != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                ku,
                style: (buyuk
                        ? AppTypography.kurmanjiLarge
                        : AppTypography.kurmanji)
                    .copyWith(color: AppColors.textPrimary),
              ),
            ),
            if (sesVar) SpeakButton(text: ku, size: 44),
          ],
        ),
        if (tr.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.kurmanjToTranslation),
          Text(tr, style: AppTypography.translation),
        ],
      ],
    );
  }

  // ── Seçmeli egzersiz ────────────────────────────────────────

  Widget _secmeli() {
    final dogruIndex = _e.correctIndex ?? _e.options.indexOf(_e.correctAnswer);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _soruMetni(),
        const SizedBox(height: AppSpacing.questionToOptions),
        for (int i = 0; i < _e.options.length; i++) ...[
          _Secenek(
            metin: _e.options[i],
            durum: !_answered
                ? _SecenekDurum.bekliyor
                : i == dogruIndex
                    ? _SecenekDurum.dogru
                    : i == _selected
                        ? _SecenekDurum.yanlis
                        : _SecenekDurum.soluk,
            onTap: _answered
                ? null
                : () {
                    _selected = i;
                    _cevapla(i == dogruIndex);
                  },
          ),
          const SizedBox(height: AppSpacing.optionGap),
        ],
        if (_answered) _notlar(),
      ],
    );
  }

  // ── Sıralama egzersizi ──────────────────────────────────────

  static String _duz(String s) =>
      s.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();

  Widget _siralama() {
    final parcalar = _e.wordPieces ?? _e.options;
    final kalan = [...parcalar];
    for (final p in _dizilen) {
      kalan.remove(p);
    }
    // Hedef cümle: yazarı vermişse o, yoksa parçaların yazıldığı sıra.
    final hedef = (_e.targetSentence ?? _e.correctAnswer).trim().isNotEmpty
        ? (_e.targetSentence ?? _e.correctAnswer)
        : parcalar.join(' ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _soruMetni(),
        const SizedBox(height: AppSpacing.md),
        Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.primary.withOpacity(0.25)),
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final p in _dizilen)
                ActionChip(
                  label: Text(p, style: AppTypography.kurmanji),
                  onPressed: _answered
                      ? null
                      : () => setState(() => _dizilen.remove(p)),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final p in kalan)
              ActionChip(
                label: Text(p, style: AppTypography.kurmanji),
                onPressed: _answered
                    ? null
                    : () => setState(() => _dizilen.add(p)),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        if (!_answered)
          ElevatedButton(
            onPressed: kalan.isEmpty
                ? () => _cevapla(_duz(_dizilen.join(' ')) == _duz(hedef))
                : null,
            style: _anaDugme(),
            child: const Text('Kontrol bike'),
          ),
        if (_answered && !_lastCorrect) ...[
          Text('Bersiva rast:',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textTertiary)),
          const SizedBox(height: 4),
          Text(hedef,
              style: AppTypography.kurmanji.copyWith(
                  color: AppColors.success, fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (_answered) _notlar(),
      ],
    );
  }

  // ── Konuşma alıştırması (puana girmez) ──────────────────────

  Widget _konusma() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Bi dengê bilind bibêje',
            style: AppTypography.label.copyWith(color: AppColors.primary)),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: _soruMetni(buyuk: true),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (!_answered)
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _answered = true;
                _lastCorrect = true;
                _xp += _e.xpReward;
              });
            },
            icon: const Icon(Icons.record_voice_over_rounded, size: 20),
            label: const Text('Min got'),
            style: _anaDugme(),
          ),
        if (_answered) _notlar(),
      ],
    );
  }

  // ── Dilbilgisi ve kültür notları ────────────────────────────

  Widget _notlar() {
    final dilbilgisi = (_e.grammarNote ?? _e.grammar ?? '').trim();
    final kultur = (_e.culturalNote ?? '').trim();
    if (dilbilgisi.isEmpty && kultur.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        children: [
          if (dilbilgisi.isNotEmpty)
            _Not(
              ikon: Icons.lightbulb_outline_rounded,
              baslik: 'Rêziman',
              metin: dilbilgisi,
              renk: AppColors.primary,
            ),
          if (dilbilgisi.isNotEmpty && kultur.isNotEmpty)
            const SizedBox(height: AppSpacing.sm),
          if (kultur.isNotEmpty)
            _Not(
              ikon: Icons.auto_stories_outlined,
              baslik: 'Çand',
              metin: kultur,
              renk: AppColors.accent,
            ),
        ],
      ),
    ).animate().fadeIn(duration: 200.ms);
  }

  // ── Alt bar: sonuç + devam ──────────────────────────────────

  Widget _altBar() {
    final puanli = isScored(_e);
    final renk = !puanli || _lastCorrect ? AppColors.success : AppColors.errorSoft;
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
      decoration: BoxDecoration(
        color: (!puanli || _lastCorrect)
            ? AppColors.successSurface
            : AppColors.errorSurface,
        border: Border(top: BorderSide(color: renk.withOpacity(0.3))),
      ),
      child: Row(
        children: [
          if (puanli) ...[
            Icon(_lastCorrect ? Icons.check_circle : Icons.cancel,
                color: renk, size: 22),
            const SizedBox(width: AppSpacing.sm),
            Text(_lastCorrect ? 'Pîroz be!' : 'Ne rast e',
                style: AppTypography.label
                    .copyWith(color: renk, fontWeight: FontWeight.w700)),
          ],
          const Spacer(),
          ElevatedButton(
            onPressed: _sonraki,
            style: _anaDugme(satirda: true),
            child: const Text('Berdewam'),
          ),
        ],
      ),
    );
  }

  /// `satirda`: düğme bir Row içindeyse. Uygulama teması ElevatedButton'a
  /// tam genişlik (`Size.fromHeight`) verir; Row'da bu sonsuz genişlik
  /// demektir ve yerleşim çöker. Row içindeki düğmeye sonlu ölçü verilir.
  ButtonStyle _anaDugme({bool satirda = false}) => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: satirda ? const Size(120, AppSpacing.touchMin) : null,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
      );

  // ── Sonuç ekranı ────────────────────────────────────────────

  Widget _sonucEkrani(LessonModel lesson) {
    final sonuc = _puanlanan == 0
        ? const ActivityOutcome.completed()
        : ActivityOutcome(_correct, _puanlanan);
    if (!_raporlandi) {
      _raporlandi = true;
      ActivityOutcome.report(sonuc);
      SoundService.playSessionComplete();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref
            .read(lessonProgressProvider.notifier)
            .record(lesson.id, sonuc.percent);
        if (_xp > 0) ref.read(gamificationProvider.notifier).addXP(_xp);
        markSkillCompletedAndNotify(ref,
            module: 'ku', skill: 'grammar', xp: 10);
      });
    }
    final gecti = sonuc.passed;
    final renk = gecti ? AppColors.success : AppColors.warning;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(gecti ? Icons.emoji_events_rounded : Icons.refresh_rounded,
                  size: 64, color: renk),
              const SizedBox(height: AppSpacing.md),
              Text(
                gecti ? 'Wane qediya!' : 'Hema hema!',
                textAlign: TextAlign.center,
                style: AppTypography.headline.copyWith(color: renk),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(lesson.kurmanjTitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.translation),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '$_correct / $_puanlanan rast · ji sedî ${sonuc.percent}',
                textAlign: TextAlign.center,
                style: AppTypography.title
                    .copyWith(color: AppColors.textPrimary),
              ),
              if (!gecti) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Ji sedî 70 pêwîst e. Careke din biceribîne.',
                  textAlign: TextAlign.center,
                  style: AppTypography.caption,
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: gecti ? _cik : _bastan,
                style: _anaDugme(),
                child: Text(gecti ? 'Berdewam' : 'Dîsa biceribîne'),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: gecti ? _bastan : _cik,
                child: Text(gecti ? 'Dîsa biceribîne' : 'Vegere'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Seçenek düğmesi ────────────────────────────────────────────

enum _SecenekDurum { bekliyor, dogru, yanlis, soluk }

class _Secenek extends StatelessWidget {
  final String metin;
  final _SecenekDurum durum;
  final VoidCallback? onTap;
  const _Secenek({required this.metin, required this.durum, this.onTap});

  @override
  Widget build(BuildContext context) {
    final (Color cerceve, Color zemin, IconData? ikon) = switch (durum) {
      _SecenekDurum.dogru => (
          AppColors.success,
          AppColors.successSurface,
          Icons.check_circle
        ),
      _SecenekDurum.yanlis => (
          AppColors.errorSoft,
          AppColors.errorSurface,
          Icons.cancel
        ),
      _SecenekDurum.soluk => (
          Colors.grey.shade300,
          AppColors.surface,
          null
        ),
      _SecenekDurum.bekliyor => (
          AppColors.primary.withOpacity(0.25),
          AppColors.surface,
          null
        ),
    };
    return Material(
      color: zemin,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          constraints: const BoxConstraints(minHeight: AppSpacing.touchMin),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: cerceve, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  metin,
                  style: AppTypography.bodyLarge.copyWith(
                    color: durum == _SecenekDurum.soluk
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              if (ikon != null) Icon(ikon, color: cerceve, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Not kutusu ─────────────────────────────────────────────────

class _Not extends StatelessWidget {
  final IconData ikon;
  final String baslik;
  final String metin;
  final Color renk;
  const _Not({
    required this.ikon,
    required this.baslik,
    required this.metin,
    required this.renk,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: renk.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: renk.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, size: 16, color: renk),
              const SizedBox(width: 6),
              Text(baslik,
                  style: AppTypography.caption
                      .copyWith(color: renk, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          Text(metin, style: AppTypography.bodyGrammar),
        ],
      ),
    );
  }
}
