/// İngilizce yolun biçim alıştırmaları ve düzey sınavı (Ekim 2026).
///
/// Kurmancî yolda yapılanların İngilizce karşılığı:
///
///   1. [enBicimDersi] — düzey başına, dilbilgisi konusu başına alıştırma
///      (`bicim_en_<konu>_<düzey>`). Sorular İngilizce test merkezinin
///      elle yazılmış ve denetlenmiş havuzundan ([kEnQuizItems], 698 soru)
///      gelir; her açılışta yeniden örneklenir. Konu adları test merkezinin
///      kullandığı Kurmancî adlardır (Artîkel, Dema borî, Pirjimar …); yeni
///      Kurmancî metin yazılmaz.
///   2. [ezmunEnDersi] — düzey sınavı (`ezmun_en_<düzey>`, 20 soru): düzeyin
///      dilbilgisi sorularından en çok 10 (konulara yayılarak), kalanı
///      düzeyin İngilizce kelime listesinden kelime sorusu. Sertifika bu
///      sınava bağlıdır (Kurmancî yoldaki gibi).
///
/// Dersler Kurmancî yoldaki gibi `WaneScreen`de oynanır; sonuç
/// `lessonProgressProvider`da kimlikle durur.
///
/// Saf Dart; Flutter içe aktarmaz.
library;

import 'dart:math';

import '../../en_learning/domain/en_quiz_items.dart';
import 'bicim_alistirma.dart' show bicimTohumu;
import 'lesson_catalog.dart' show kLessonLevels;
import 'lesson_entities.dart';
import 'olcme.dart' show enPeyvSorusu, kEnDuzeyListeleri, kEzmunSoruSayisi;

const String kBicimEnOneki = 'bicim_en_';
const String kEzmunEnOneki = 'ezmun_en_';

/// İngilizce düzey sınavının (ve sonucunun) kimliği: `ezmun_en_a1`.
String ezmunEnKimligi(String level) => '$kEzmunEnOneki${level.toLowerCase()}';

/// Konu → (Kurmancî ad — İngilizce test merkezindekiyle aynı, İngilizce ad,
/// kapsadığı soru türleri).
const Map<String, (String, String, Set<String>)> _konular = {
  'article': ('Artîkel', 'Articles', {'article'}),
  'past': ('Dema borî', 'Past tense', {'past'}),
  'plural': ('Pirjimar', 'Plurals', {'plural'}),
  'prep': ('Daçek', 'Prepositions', {'prep'}),
  'phrasal': ('Lêkerên frazî', 'Phrasal verbs', {'phrasal'}),
  'collocation': ('Hevaheng', 'Collocations', {'collocation'}),
  'compare': ('Berawirdkirin', 'Comparatives', {'compare', 'superlative', 'as_as'}),
  'synonym': ('Hevwate û Dijwate', 'Synonyms & antonyms', {'synonym', 'antonym'}),
};

/// Konusu ayrı alıştırma olmayan düzeylerde (C1, C2) bütün dilbilgisi
/// soruları tek alıştırmada toplanır.
const String _karmaKonu = 'reziman';

/// Bir konunun o düzeyde ayrı alıştırma olması için gereken en az soru.
const int _enAzSoru = 8;

/// Alıştırma başına soru.
const int kEnBicimSoruSayisi = 10;

/// Sınava ve alıştırmaya girebilen soru: seçenekler ayrık, doğru cevap içlerinde.
bool _uygun(EnQuizItem q) =>
    q.options.length >= 2 &&
    q.options.toSet().length == q.options.length &&
    q.options.contains(q.correctAnswer) &&
    q.promptEn.trim().isNotEmpty;

List<EnQuizItem> _duzeyinSorulari(String level) => [
      for (final q in kEnQuizItems)
        if (q.level == level && _uygun(q)) q,
    ];

List<EnQuizItem> _konununSorulari(String level, String konu) {
  final sorular = _duzeyinSorulari(level);
  if (konu == _karmaKonu) return sorular;
  final turler = _konular[konu]?.$3;
  if (turler == null) return const [];
  return [for (final q in sorular) if (turler.contains(q.type)) q];
}

/// Düzeyin alıştırma kimlikleri, test merkezindeki konu sırasıyla.
List<String> enBicimDersKimlikleri(String level) {
  final l = level.toUpperCase();
  if (!kLessonLevels.contains(l)) return const [];
  final kimlikler = [
    for (final konu in _konular.keys)
      if (_konununSorulari(l, konu).length >= _enAzSoru) '$kBicimEnOneki${konu}_${l.toLowerCase()}',
  ];
  if (kimlikler.isEmpty && _duzeyinSorulari(l).length >= 6) {
    kimlikler.add('$kBicimEnOneki${_karmaKonu}_${l.toLowerCase()}');
  }
  return kimlikler;
}

ExerciseModel _soru(EnQuizItem q, Random r) {
  final secenekler = [...q.options]..shuffle(r);
  return ExerciseModel(
    id: q.id,
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: q.promptEn,
    options: secenekler,
    correctAnswer: q.correctAnswer,
    correctIndex: secenekler.indexOf(q.correctAnswer),
    grammarNote: q.explanationKu.isEmpty ? null : q.explanationKu,
  );
}

Random _rng(Random? rng) => rng ?? (bicimTohumu == null ? Random() : Random(bicimTohumu));

/// `bicim_en_article_a1` gibi bir kimlikten alıştırma; tanınmıyorsa `null`.
LessonModel? enBicimDersi(String id, {Random? rng}) {
  if (!id.startsWith(kBicimEnOneki)) return null;
  final govde = id.substring(kBicimEnOneki.length);
  final i = govde.lastIndexOf('_');
  if (i <= 0) return null;
  final konu = govde.substring(0, i);
  final level = govde.substring(i + 1).toUpperCase();
  if (!enBicimDersKimlikleri(level).contains(id)) return null;
  final r = _rng(rng);
  final havuz = [..._konununSorulari(level, konu)]..shuffle(r);
  final sorular = [for (final q in havuz.take(kEnBicimSoruSayisi)) _soru(q, r)];
  if (sorular.isEmpty) return null;
  final (ku, en) = konu == _karmaKonu
      ? ('Rêziman', 'Grammar')
      : (_konular[konu]!.$1, _konular[konu]!.$2);
  return LessonModel(
    id: id,
    kurmanjTitle: '$ku · $level',
    turkishTitle: '$en · $level',
    unitNumber: 0,
    lessonNumber: 0,
    level: kLessonLevels.indexOf(level) + 1,
    path: LessonPath.general,
    exercises: sorular,
    estimatedMinutes: 5,
    emoji: '🧩',
  );
}

/// `ezmun_en_a1` gibi bir kimlikten İngilizce düzey sınavı; tanınmıyorsa `null`.
///
/// Bileşim (20 soru): düzeyin dilbilgisi sorularından en çok 10, konulara
/// sırayla yayılarak; kalanı düzeyin kelime listesinden kelime sorusu.
LessonModel? ezmunEnDersi(String id, {Random? rng}) {
  if (!id.startsWith(kEzmunEnOneki)) return null;
  final level = id.substring(kEzmunEnOneki.length).toUpperCase();
  if (!kLessonLevels.contains(level)) return null;
  final r = _rng(rng);

  final sorular = <ExerciseModel>[];

  // 1. Dilbilgisi: konulara sırayla yayılarak en çok 10.
  final kumeler = <String, List<EnQuizItem>>{};
  for (final q in _duzeyinSorulari(level)) {
    kumeler.putIfAbsent(q.type, () => []).add(q);
  }
  for (final k in kumeler.values) {
    k.shuffle(r);
  }
  final turler = kumeler.keys.toList()..shuffle(r);
  var tur = 0;
  while (sorular.length < 10 && kumeler.values.any((k) => k.isNotEmpty)) {
    final k = kumeler[turler[tur % turler.length]]!;
    if (k.isNotEmpty) sorular.add(_soru(k.removeLast(), r));
    tur++;
  }

  // 2. Kalanı düzeyin kelime listesinden.
  final liste = kEnDuzeyListeleri[level] ?? const [];
  for (final w in [...liste]..shuffle(r)) {
    if (sorular.length >= kEzmunSoruSayisi) break;
    final s = enPeyvSorusu(w, liste, r, onek: '${kEzmunEnOneki}peyv_');
    if (s != null) sorular.add(s);
  }
  if (sorular.isEmpty) return null;
  sorular.shuffle(r);

  return LessonModel(
    id: ezmunEnKimligi(level),
    kurmanjTitle: 'Ezmûna astê · $level',
    turkishTitle: 'Level exam · $level',
    unitNumber: 0,
    lessonNumber: 0,
    level: kLessonLevels.indexOf(level) + 1,
    path: LessonPath.general,
    exercises: sorular,
    estimatedMinutes: 10,
    emoji: '🎓',
  );
}
