/// Ölçme: yerleştirme kararı ve düzey sınavı (iyileştirme planı Faz 6).
///
/// İki şey:
///
///   1. [yerlestirmeDuzeyi] — yerleştirme testinde düzey toplam puanla değil,
///      düzey bandı bazında başarıyla belirlenir. Eski kural (10 soruda 2–3
///      doğru → A2) dört seçenekli soruları rastgele işaretleyen birini
///      beklenen 2,5 doğruyla A2'ye yerleştiriyordu.
///
///   2. [ezmunDersi] — her düzey için çıkış sınavı ("Ezmûna astê"). Sorular
///      düzeyin kendi içeriğinden derlenir: elle yazılmış derslerin
///      egzersizleri, düzeyin kelimeleri ve veriden üretilen biçim soruları.
///      Sınav elle yazılmış dersler gibi oynanır (kimlik `ezmun_<düzey>`);
///      sonucu `lessonProgressProvider`da aynı kimlikle durur. Sertifika bu
///      sınava bağlıdır.
///
/// Saf Dart; Flutter içe aktarmaz.
library;

import 'dart:math';

import 'bicim_alistirma.dart';
import 'lesson_catalog.dart';
import 'lesson_entities.dart';

// ── Yerleştirme ──────────────────────────────────────────────────────────────

/// Bir bandın "biliniyor" sayılması için gereken doğru oranı.
/// 2 soruda 2, 4 soruda 3, 5 soruda 4 doğru.
const double kBantEsigi = 0.75;

/// Bant sonuçlarından (düzey → (doğru, toplam)) başlanacak düzey: aşağıdan
/// yukarı ilk "bilinmeyen" bant. Sorusu olmayan bant karar vermez. Hepsi
/// biliniyorsa en üst düzey.
///
/// Üst bantta şans eseri doğrular alt bant bilinmeden düzeyi yükseltmez.
String yerlestirmeDuzeyi(Map<String, (int, int)> bantlar) {
  for (final d in kLessonLevels) {
    final b = bantlar[d];
    if (b == null || b.$2 == 0) continue;
    if (b.$1 / b.$2 < kBantEsigi) return d;
  }
  return kLessonLevels.last;
}

// ── Düzey sınavı ─────────────────────────────────────────────────────────────

const String kEzmunOneki = 'ezmun_';
const int kEzmunSoruSayisi = 20;

/// Sınavın ve sonucunun kimliği: `ezmun_a1`.
String ezmunKimligi(String level) => '$kEzmunOneki${level.toLowerCase()}';

/// Ders egzersizlerinden sınava girebilenler: çoktan seçmeli ya da boşluk
/// doldurma, cevabı belirli. Dinleme (ses gerekir) ve sıralama girmez.
bool _sinavaUygun(ExerciseModel e) {
  if (e.type != ExerciseType.multipleChoice && e.type != ExerciseType.fillInBlank) return false;
  if (e.options.length < 2 || e.options.toSet().length != e.options.length) return false;
  final i = e.correctIndex ?? e.options.indexOf(e.correctAnswer);
  return i >= 0 && i < e.options.length;
}

/// Kelime sorusu: Kurmancîsi verilir, Türkçesi dört seçenekten seçilir.
/// Çeldiriciler önce aynı birimden alınır (rastgele birimden gelen çeldirici
/// konu ipucuyla elenir).
ExerciseModel? _peyvSorusu(dynamic w, List<dynamic> hepsi, Random rng) {
  final dogru = (w.tr as String).trim();
  if (dogru.isEmpty) return null;
  final digerleri = [
    for (final x in hepsi)
      if ((x.tr as String).trim() != dogru && (x.tr as String).trim().isNotEmpty) x,
  ]..shuffle(rng);
  final celdirici = <String>{};
  for (final x in [...digerleri.where((x) => x.kat == w.kat), ...digerleri]) {
    celdirici.add((x.tr as String).trim());
    if (celdirici.length == 3) break;
  }
  if (celdirici.length < 3) return null;
  final secenekler = <String>[dogru, ...celdirici]..shuffle(rng);
  return ExerciseModel(
    id: '${kEzmunOneki}peyv_${w.id}',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: (w.ku as String).trim(),
    turkishPrompt: 'Türkçesi hangisi?',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    cardId: w.id as String,
  );
}

/// `ezmun_a1` gibi bir kimlikten düzey sınavı; kimlik tanınmıyorsa `null`.
///
/// Bileşim (20 soru): en çok 10 ders egzersizi (ders başına en çok 2),
/// en çok 4 biçim sorusu (izafe, ergatif), kalanı kelime.
LessonModel? ezmunDersi(String id, {Random? rng}) {
  if (!id.startsWith(kEzmunOneki)) return null;
  final level = id.substring(kEzmunOneki.length).toUpperCase();
  if (!kLessonLevels.contains(level)) return null;
  final r = rng ?? (bicimTohumu == null ? Random() : Random(bicimTohumu));

  final sorular = <ExerciseModel>[];

  // 1. Düzeyin elle yazılmış derslerinden, derslere yayarak.
  final dersler = [...lessonsForLevel(level)]..shuffle(r);
  for (final d in dersler) {
    final uygun = d.exercises.where(_sinavaUygun).toList()..shuffle(r);
    sorular.addAll(uygun.take(2));
    if (sorular.length >= 10) break;
  }
  if (sorular.length > 10) sorular.removeRange(10, sorular.length);

  // 2. Veriden üretilen biçim soruları (kanıtlı adlar ve fiiller).
  final bicim = <ExerciseModel>[
    if (bicimDersKimlikleri(level).any((k) => k.contains('izafe'))) ...izafeSorulari(level, r).take(2),
    if (bicimDersKimlikleri(level).any((k) => k.contains('ergatif'))) ...ergatifSorulari(r).take(2),
  ];
  sorular.addAll(bicim);

  // 3. Kalanı düzeyin kelimelerinden.
  final kelimeler = wordsForLevel(level);
  final sirali = [...kelimeler]..shuffle(r);
  for (final w in sirali) {
    if (sorular.length >= kEzmunSoruSayisi) break;
    final s = _peyvSorusu(w, kelimeler, r);
    if (s != null) sorular.add(s);
  }
  if (sorular.isEmpty) return null;
  sorular.shuffle(r);

  return LessonModel(
    id: ezmunKimligi(level),
    kurmanjTitle: 'Ezmûna astê · $level',
    turkishTitle: 'Düzey sınavı · $level',
    unitNumber: 0,
    lessonNumber: 0,
    level: kLessonLevels.indexOf(level) + 1,
    path: LessonPath.general,
    exercises: sorular,
    estimatedMinutes: 10,
    emoji: '🎓',
  );
}
