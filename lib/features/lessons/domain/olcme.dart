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

// ── Aşamalı yerleştirme (Ekim 2026) ──────────────────────────────────────────
//
// Eski test 10 soruydu: bant başına 2 (C1 ve C2'de 1) soru. Tek bir dikkatsizlik
// düzeyi bir bant aşağı çekiyor, tek bir soruyla C1/C2 kararı veriliyordu.
//
// Yeni test bant başına [kBantSoruSayisi] soru sorar ve aşamalıdır: bantlar
// aşağıdan yukarı sırayla gelir; bir bandın sonucu kesinleşince (geçti ya da
// geçemeyeceği belli oldu) beklenmez. Geçilemeyen ilk bant başlanacak düzeydir
// ve test orada biter. Hiç bilmeyen biri 2 soruda, C2 düzeyindeki biri en çok
// 36 soruda sonuç alır.
//
// Dört seçenekli 6 soruda rastgele işaretleyerek bir bandı geçme olasılığı
// (en az 5 doğru) binde 5'in altındadır.

/// Yerleştirme testinde bant başına sorulan soru sayısı.
const int kBantSoruSayisi = 6;

/// [toplam] soruluk bandı geçmek için gereken en az doğru sayısı
/// ([kBantEsigi] ile aynı kural: 2→2, 4→3, 6→5).
int bantGerekli(int toplam) => (kBantEsigi * toplam - 1e-9).ceil();

/// Bandın sonucu kesinleşti mi? `true` geçti, `false` geçemez, `null` henüz
/// belli değil (sormaya devam).
bool? bantKarari({required int dogru, required int yanlis, required int toplam}) {
  final gerekli = bantGerekli(toplam);
  if (dogru >= gerekli) return true;
  if (yanlis > toplam - gerekli) return false;
  return null;
}

/// Aşamalı testin sıradaki adımı. [bantlar]: düzey → (doğru, yanlış, toplam);
/// "bilmiyorum" yanlış sayılır. Sorusu olmayan bant atlanır.
///
/// `bant` doluysa o banttan soru sorulur; `sonuc` doluysa test bitmiştir ve
/// başlanacak düzey odur. Sonuç [yerlestirmeDuzeyi] ile aynı kararı verir
/// (yanıtlanmayan sorular yanlış sayılarak).
({String? bant, String? sonuc}) yerlestirmeAdimi(Map<String, (int, int, int)> bantlar) {
  for (final d in kLessonLevels) {
    final b = bantlar[d];
    if (b == null || b.$3 == 0) continue;
    final karar = bantKarari(dogru: b.$1, yanlis: b.$2, toplam: b.$3);
    if (karar == null) return (bant: d, sonuc: null);
    if (!karar) return (bant: null, sonuc: d);
  }
  return (bant: null, sonuc: kLessonLevels.last);
}

const String _harfler = 'abcdefghijklmnopqrstuvwxyzçğıöşüâîûê';

String _yalin(String s) {
  const cift = {
    'î': 'i', 'û': 'u', 'ê': 'e', 'ç': 'c', 'ş': 's', 'ı': 'i', 'ö': 'o',
    'ü': 'u', 'ğ': 'g', 'â': 'a', 'x': 'h', 'q': 'k', 'w': 'v',
  };
  final b = StringBuffer();
  for (final r in s.toLowerCase().runes) {
    final c = String.fromCharCode(r);
    if (_harfler.contains(c)) b.write(cift[c] ?? c);
  }
  return b.toString();
}

/// Türkçe karşılığın ayrı ayrı okunabilen parçaları ("Tasa / Keder" → 2).
List<String> _karsiliklar(String tr) =>
    [for (final p in tr.split(RegExp(r'[/,;]'))) if (p.trim().isNotEmpty) p.trim()];

/// Karşılık Kurmancî sözcüğün Türkçedeki akrabası mı ("fonolojî" → "Fonoloji")?
/// Böyle sorular Kurmancî bilmeden de çözülür; yerleştirmede sorulmaz.
bool _hisim(String ku, String tr) {
  final k = _yalin(ku);
  if (k.length < 4) return false;
  for (final p in _karsiliklar(tr)) {
    final t = _yalin(p);
    if (t.length < 4) continue;
    if (t.startsWith(k.substring(0, 3)) || k.contains(t) || t.contains(k)) return true;
    // Yalnız ünlüsü değişen akrabalar: hefte/hafta, çetel/çatal.
    final ki = _iskelet(k), ti = _iskelet(t);
    if (ki.length >= 3 && ki == ti) return true;
  }
  return false;
}

String _iskelet(String yalin) => yalin.replaceAll(RegExp('[aeiou]'), '');

bool _fiilMi(String tr) => RegExp(r'(mek|mak)$').hasMatch(_karsiliklar(tr).first.toLowerCase());

/// Kaba sözcük türü: ad (cinsi yazılı), fiil (karşılığı -mek/-mak) ya da diğer.
String _tur(dynamic w) {
  final cins = (w.cins as String?)?.trim() ?? '';
  if (cins == 'mê' || cins == 'nêr') return 'ad';
  return _fiilMi((w.tr as String).trim()) ? 'fiil' : 'diger';
}

/// Karşılık soruda gösterilebilecek kadar kısa mı: parantezsiz, en çok 28
/// harf, her parçası en çok üç sözcük (cümle biçimindeki karşılıklar girmez).
bool _kisaKarsilik(String tr) {
  if (tr.isEmpty || tr.length > 28 || tr.contains('(')) return false;
  return _karsiliklar(tr).every((p) => p.split(RegExp(r'\s+')).length <= 3);
}

/// Yerleştirme için kelime sorusu. Düzey sınavındaki [_peyvSorusu]ndan daha
/// sıkı elenir, çünkü tek tek soruların ağırlığı daha büyüktür:
///   - madde başı tek sözcük, karşılık kısa ve parantezsiz;
///   - karşılık Türkçe akraba değil ([_hisim]);
///   - çeldiriciler aynı düzeyden ve aynı sözcük türünden ([_tur]) ama BAŞKA
///     konudan seçilir. Aynı konunun sözcükleri sık sık yakın anlamlıdır
///     ("ragihandin": bildirmek / yayımlamak / iletişim kurmak); yakın
///     anlamlı çeldirici soruyu belirsiz kılar. Kelime düzeyi testlerinde
///     ölçünlü yol budur: çeldirici aynı sıklık bandından, anlamca ilgisiz;
///   - çeldiriciler doğru karşılıkla ve birbirleriyle ortak sözcük taşımaz,
///     hiçbiri madde başının Türkçe akrabası değildir.
ExerciseModel? _yerlestirmePeyvSorusu(dynamic w, List<dynamic> hepsi, Random rng) {
  final ku = (w.ku as String).trim();
  final dogru = (w.tr as String).trim();
  if (ku.isEmpty || ku.contains(' ') || dogru.isEmpty) return null;
  if (!_kisaKarsilik(dogru) || _hisim(ku, dogru)) return null;
  final dogruSozcukler = <String>{
    for (final p in _karsiliklar(dogru))
      if (_yalin(p).isNotEmpty) _yalin(p),
  };
  final tur = _tur(w);

  bool uygun(dynamic x) {
    final t = (x.tr as String).trim();
    if (x.kat == w.kat || !_kisaKarsilik(t)) return false;
    if (_tur(x) != tur || _hisim(ku, t)) return false;
    for (final p in _karsiliklar(t)) {
      final y = _yalin(p);
      if (y.isEmpty) continue;
      for (final d in dogruSozcukler) {
        if (y == d || y.contains(d) || d.contains(y)) return false;
      }
    }
    return true;
  }

  final adaylar = [for (final x in hepsi) if (uygun(x)) x]..shuffle(rng);
  final celdirici = <String>[];
  final gorulen = <String>{};
  for (final x in adaylar) {
    final t = (x.tr as String).trim();
    final anahtar = _yalin(t);
    // Çeldiriciler birbirinin eş anlamlısı da olmasın.
    if (gorulen.any((g) => g == anahtar || g.contains(anahtar) || anahtar.contains(g))) continue;
    gorulen.add(anahtar);
    celdirici.add(t);
    if (celdirici.length == 3) break;
  }
  if (celdirici.length < 3) return null;
  final secenekler = <String>[dogru, ...celdirici]..shuffle(rng);
  return ExerciseModel(
    id: 'yerlestirme_peyv_${w.id}',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: ku,
    turkishPrompt: 'Türkçesi hangisi?',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    cardId: w.id as String,
  );
}

/// Yerleştirme testinin bir bandı için, düzeyin KENDİ içeriğinden [adet] soru:
/// varsa veriden üretilen bir biçim sorusu (izafe ya da ergatif; kanıtlı adlar
/// ve fiiller), kalanı düzeyin kelime listesinden örneklenen kelime soruları.
///
/// Sorular her açılışta yeniden örneklenir (testi tekrarlayan aynı soruları
/// ezberleyemez); [rng] verilirse aynı tohum aynı soruları üretir.
List<ExerciseModel> yerlestirmeBandi(String level, int adet, Random rng) {
  if (adet <= 0 || !kLessonLevels.contains(level)) return const [];
  final sorular = <ExerciseModel>[];

  final kimlikler = bicimDersKimlikleri(level);
  final bicim = <ExerciseModel>[
    if (kimlikler.any((k) => k.contains('izafe'))) ...izafeSorulari(level, rng).take(1),
    if (kimlikler.any((k) => k.contains('ergatif'))) ...ergatifSorulari(rng).take(1),
  ]..shuffle(rng);
  // Bant başına en çok bir biçim sorusu; en az iki seçeneği kelimeye bırak.
  if (bicim.isNotEmpty && adet >= 3) sorular.add(bicim.first);

  // Biçim sorusunun ipucu satırı sözcüğün anlamını verir ("İçerik (bizim)" →
  // "navoka me"); aynı sözcük aynı bantta kelime sorusu olarak sorulmaz.
  final bicimMetni = sorular.expand((s) => s.options).join(' ').toLowerCase();

  final kelimeler = wordsForLevel(level);
  final sirali = [...kelimeler]..shuffle(rng);
  for (final w in sirali) {
    if (sorular.length >= adet) break;
    final ku = (w.ku as String).trim().toLowerCase();
    if (ku.length >= 3 && bicimMetni.contains(ku.substring(0, 3))) continue;
    final s = _yerlestirmePeyvSorusu(w, kelimeler, rng);
    if (s != null) sorular.add(s);
  }
  return sorular;
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
