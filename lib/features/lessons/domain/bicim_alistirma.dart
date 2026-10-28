/// Veriden üretilen biçim alıştırmaları (iyileştirme planı Faz 4.6).
///
/// Sorular elle yazılmaz; iki kanıt tablosundan üretilir:
///
///   - [kCinsKaniti]: cinsiyeti en az bir bağımsız kaynakla doğrulanmış adlar
///     → "veqetandek" (izafe) alıştırması: *mala min* mı, *malê min* mi?
///   - [kFiiller]: geçişliliği sözlükten, geçmiş biçimi korpustan alınan fiiller
///     → ergatif alıştırması: *Min got* mu, *Ez got* mu?
///   - [kCekimler]: şimdiki zaman biçimleri korpusta tanıklı fiiller
///     → kişi eki alıştırması: *Tu dixwî* mi, *Tu dixwim* mi? ve olumsuzluk:
///     *Ez naçim* mi, *Ez nediçim* mi? (2026-10-24; kaynak ders kitapları bu
///     ikisini çekim tablosu ve dönüştürme alıştırmasıyla öğretiyor, Lütke'de yoktu)
///
/// Doğru cevap veriden gelir ve açıklama kanıtı gösterir ("Korpusta: çekimli
/// zamir + got 354, yalın zamir + got 0"). Kuralı ezberletmek yerine kanıtını
/// göstermek amaç.
///
/// Üretilen ders her çağrıda yeniden karılır; kimlikleri `bicim_` ile başlar
/// ve `lessonById` üzerinden elle yazılmış dersler gibi oynanır.
///
/// Saf Dart; Flutter içe aktarmaz.
library;

import 'dart:math';

import 'cekim_db.dart';
import 'cins_kanit_db.dart';
import 'fiil_db.dart';
import 'lesson_catalog.dart';
import 'lesson_entities.dart';

const String kBicimOneki = 'bicim_';
const int kBicimSoruSayisi = 10;

/// Sınamalar için: verilirse üretim bu tohumla yapılır (aynı tohum, aynı ders).
int? bicimTohumu;

/// İzafe alıştırmasına girebilecek kadar adı olan düzeyler için en az soru.
const int _enAzAd = 12;

/// Ergatif alıştırmasının sunulduğu düzeyler (ergatif A2'de başlıyor).
const Set<String> _ergatifDuzeyleri = {'A2', 'B1', 'B2'};

/// Şimdiki zaman kişi eki alıştırması (dilbilgisi ipucu "Dema niha" A1'de).
const Set<String> _nihaDuzeyleri = {'A1', 'A2'};

/// Olumsuzluk alıştırması (dilbilgisi ipucu "Neyînî" A2'de).
const Set<String> _neyiniDuzeyleri = {'A2', 'B1'};

/// Bir düzeyde sunulan üretilmiş derslerin kimlikleri.
List<String> bicimDersKimlikleri(String level) {
  final d = level.toUpperCase();
  return [
    if (izafeAdlari(d).length >= _enAzAd) '${kBicimOneki}izafe_${d.toLowerCase()}',
    if (_nihaDuzeyleri.contains(d)) '${kBicimOneki}niha_${d.toLowerCase()}',
    if (_neyiniDuzeyleri.contains(d)) '${kBicimOneki}neyini_${d.toLowerCase()}',
    if (_ergatifDuzeyleri.contains(d)) '${kBicimOneki}ergatif_${d.toLowerCase()}',
  ];
}

/// Ders başlıkları: (Kurmancî, Türkçe, simge)
const Map<String, (String, String, String)> _basliklar = {
  'izafe': ('Veqetandek: -a an -ê?', 'İzafe: dişil -a, eril -ê', '🔗'),
  'ergatif': ('Ergatîf: Min an Ez?', 'Geçmiş zamanda özne: min mi, ez mi?', '⏳'),
  'niha': ('Dema niha: dikim, dikî, dike', 'Şimdiki zaman: kişi ekleri', '▶️'),
  'neyini': ('Neyînî: dikim → nakim', 'Olumsuzluk: di- yerine na-', '🚫'),
};

/// `bicim_izafe_a1`, `bicim_ergatif_a2` gibi bir kimlikten ders üretir;
/// kimlik tanınmıyorsa ya da yeterli veri yoksa `null`.
LessonModel? bicimDersi(String id, {Random? rng}) {
  if (!id.startsWith(kBicimOneki)) return null;
  final parca = id.substring(kBicimOneki.length).split('_');
  if (parca.length != 2) return null;
  final level = parca[1].toUpperCase();
  if (!kLessonLevels.contains(level)) return null;
  final r = rng ?? (bicimTohumu == null ? Random() : Random(bicimTohumu));
  final sorular = switch (parca[0]) {
    'izafe' => izafeSorulari(level, r),
    'ergatif' => _ergatifDuzeyleri.contains(level) ? ergatifSorulari(r) : const <ExerciseModel>[],
    'niha' => _nihaDuzeyleri.contains(level) ? nihaSorulari(r) : const <ExerciseModel>[],
    'neyini' => _neyiniDuzeyleri.contains(level) ? neyiniSorulari(r) : const <ExerciseModel>[],
    _ => const <ExerciseModel>[],
  };
  if (sorular.isEmpty) return null;
  final (kuBaslik, trBaslik, simge) = _basliklar[parca[0]]!;
  return LessonModel(
    id: id,
    kurmanjTitle: kuBaslik,
    turkishTitle: trBaslik,
    unitNumber: 0,
    lessonNumber: 0,
    level: kLessonLevels.indexOf(level) + 1,
    path: LessonPath.general,
    exercises: sorular,
    estimatedMinutes: 3,
    emoji: simge,
  );
}

// ── İzafe ────────────────────────────────────────────────────────────────────

/// Bir düzeyde izafe alıştırmasına girebilen adlar: cinsiyeti doğrulanmış,
/// tek sözcüklü, izafe biçimi (`ez`) madde başına düzenli ek almış.
List<dynamic> izafeAdlari(String level) => [
      for (final w in wordsForLevel(level))
        if (_izafeyeUygun(w)) w,
    ];

/// Ortak cinsli adlar: kadın için dişil, erkek için eril izafe alır
/// (*hevalê min* / *hevala min*). İzafe sorusunda iki doğru cevap olurdu.
const Set<String> kOrtakCinsliAdlar = {'heval'};

bool _izafeyeUygun(dynamic w) {
  final cins = w.cins as String?;
  final ez = w.ez as String?;
  final ku = (w.ku as String).trim();
  if (ez == null || (cins != 'mê' && cins != 'nêr')) return false;
  if (!kCinsKaniti.containsKey(w.id as String)) return false;
  if (kOrtakCinsliAdlar.contains(ku.toLowerCase())) return false;
  if (ku.contains(' ') || ez.contains(' ')) return false;
  // Büyük harfle yazılan adlar (gün, ay, yer adı) iyelikle doğal durmuyor: "Pêncşema min".
  if (ez[0] != ez[0].toLowerCase()) return false;
  if (!ez.toLowerCase().startsWith(ku.toLowerCase())) return false;
  // Etiket ile izafe biçimi birbirini tutmalı: dişil -a, eril -ê.
  if (!(cins == 'mê' ? ez.endsWith('a') : ez.endsWith('ê'))) return false;
  // Üç seçenek (doğru, öteki cins, yalın) birbirinden farklı olmalı; madde
  // başı zaten -ê / -a ile bitiyorsa (taştê) soru anlamsızlaşır.
  return {ez.toLowerCase(), tersIzafe(ez).toLowerCase(), ku.toLowerCase()}.length == 3;
}

/// *mala* → *malê*, *bavê* → *bava*: öteki cinsin izafesi (yanlış seçenek).
String tersIzafe(String ez) => ez.endsWith('a')
    ? '${ez.substring(0, ez.length - 1)}ê'
    : '${ez.substring(0, ez.length - 1)}a';

List<ExerciseModel> izafeSorulari(String level, Random rng) {
  final adlar = izafeAdlari(level)..shuffle(rng);
  // A1–A2'de "benim", sonrasında "bizim": soyut adlarda daha doğal (civaka me).
  final erken = level == 'A1' || level == 'A2';
  final iyelik = erken ? 'min' : 'me';
  final iyelikTr = erken ? 'benim' : 'bizim';
  return [
    for (final w in adlar.take(kBicimSoruSayisi)) _izafeSorusu(w, iyelik, iyelikTr, rng),
  ];
}

ExerciseModel _izafeSorusu(dynamic w, String iyelik, String iyelikTr, Random rng) {
  final ku = (w.ku as String).trim();
  final ez = w.ez as String;
  final disil = w.cins == 'mê';
  final yalin = ez[0] == ez[0].toUpperCase() ? ku : ku.toLowerCase();
  final dogru = '$ez $iyelik';
  final secenekler = <String>[dogru, '${tersIzafe(ez)} $iyelik', '$yalin $iyelik']..shuffle(rng);
  final kanit = kCinsKaniti[w.id as String] ?? '';
  return ExerciseModel(
    id: '${kBicimOneki}izafe_${w.id}',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: 'Kîjan rast e?',
    turkishPrompt: '${w.tr} ($iyelikTr)',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    grammarNote: '"$ku" ${disil ? 'dişil (mê): izafe -a' : 'eril (nêr): izafe -ê'} → $dogru.'
        '${kanit.isEmpty ? '' : '\nKanıt: $kanit.'}',
    cardId: w.id as String,
  );
}

// ── Ergatif ──────────────────────────────────────────────────────────────────

/// (çekimli, yalın, Türkçe özne)
const List<(String, String, String)> kKisiler = [
  ('Min', 'Ez', 'ben'),
  ('Te', 'Tu', 'sen'),
  ('Wî', 'Ew', 'o (erkek)'),
  ('Wê', 'Ew', 'o (kadın)'),
  ('Me', 'Em', 'biz'),
  ('Wan', 'Ew', 'onlar'),
];

List<ExerciseModel> ergatifSorulari(Random rng) {
  final gecisli = kFiiller.values.where((f) => f.gecisli).toList()..shuffle(rng);
  final gecissiz = kFiiller.values.where((f) => !f.gecisli).toList()..shuffle(rng);
  // On sorunun altısı geçişli, dördü geçişsiz: yalnız geçişli sorulursa
  // "geçmişte hep min" ezberlenir; fark geçişsizle birlikte görülür.
  final sorular = <ExerciseModel>[
    for (final f in gecisli.take(6)) _gecisliSorusu(f, rng),
    for (final f in gecissiz.take(4)) _gecissizSorusu(f, rng),
  ]..shuffle(rng);
  return sorular;
}

ExerciseModel _gecisliSorusu(Fiil f, Random rng) {
  final (cekimli, yalin, ozne) = kKisiler[rng.nextInt(kKisiler.length)];
  final dogru = '$cekimli ${f.gecmis}.';
  final secenekler = <String>[dogru, '$yalin ${f.gecmis}.']..shuffle(rng);
  return ExerciseModel(
    id: '${kBicimOneki}ergatif_${f.mastar}_$cekimli',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: 'Kîjan rast e?',
    turkishPrompt: '"${f.mastar}" (${f.tr.toLowerCase()}), geçmiş zaman. Özne: $ozne',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    grammarNote: '"${f.mastar}" geçişli: geçmiş zamanda özne çekimli hâlde '
        '(min, te, wî, wê, me, we, wan).\n'
        'Korpusta çekimli zamir + "${f.gecmis}" ${f.tanikCekimli} kez, '
        'yalın zamir + "${f.gecmis}" ${f.tanikYalin} kez.',
    cardId: f.kimlik.isEmpty ? null : f.kimlik,
  );
}

/// 1. kişiyle örnek cümlesi doğal olmayan fiiller ("Ez mirim").
const Set<String> _birinciKisisiz = {'mirin'};

ExerciseModel _gecissizSorusu(Fiil f, Random rng) {
  // 1. tekil kişi biçimi korpusta varsa (hatim) yarı yarıya o sorulur.
  final birinci = f.gecmis1 != null && !_birinciKisisiz.contains(f.mastar) && rng.nextBool();
  final bicim = birinci ? f.gecmis1! : f.gecmis;
  final (dogruOzne, yanlisOzne, ozne) = birinci ? ('Ez', 'Min', 'ben') : ('Ew', 'Wî', 'o (erkek)');
  final dogru = '$dogruOzne $bicim.';
  final secenekler = <String>[dogru, '$yanlisOzne $bicim.']..shuffle(rng);
  return ExerciseModel(
    id: '${kBicimOneki}ergatif_${f.mastar}_$dogruOzne',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: 'Kîjan rast e?',
    turkishPrompt: '"${f.mastar}" (${f.tr.toLowerCase()}), geçmiş zaman. Özne: $ozne',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    grammarNote: '"${f.mastar}" geçişsiz: özne yalın kalır (ez, tu, ew, em, hûn) '
        've fiil özneyle uyuşur.\n'
        'Korpusta yalın özne + "${f.gecmis}" ${f.tanikYalin} kez.',
    cardId: f.kimlik.isEmpty ? null : f.kimlik,
  );
}

// ── Şimdiki zaman: kişi ekleri ───────────────────────────────────────────────

/// (özne, Türkçe özne, biçim seçici, korpus sayısı seçici). "Ew" çoğulda da
/// kullanılır; belirsiz kalmasın diye çoğul yalnız em / hûn ile sorulur.
final List<(String, String, String Function(Cekim), int Function(Cekim))> _nihaKisileri = [
  ('Ez', 'ben', (c) => c.ez, (c) => c.nEz),
  ('Tu', 'sen', (c) => c.tu, (c) => c.nTu),
  ('Ew', 'o', (c) => c.ew, (c) => c.nEw),
  ('Em', 'biz', (c) => c.pir, (c) => c.nPir),
  ('Hûn', 'siz', (c) => c.pir, (c) => c.nPir),
];

List<ExerciseModel> nihaSorulari(Random rng) {
  final fiiller = List<Cekim>.of(kCekimler)..shuffle(rng);
  return [for (final c in fiiller.take(kBicimSoruSayisi)) _nihaSorusu(c, rng)];
}

ExerciseModel _nihaSorusu(Cekim c, Random rng) {
  final (ozne, ozneTr, bicim, sayi) = _nihaKisileri[rng.nextInt(_nihaKisileri.length)];
  final dogruBicim = bicim(c);
  // Yanlış seçenekler aynı fiilin öteki kişi biçimleri: soru yalnız kişi ekini sınar.
  final yanlis = {c.ez, c.tu, c.ew, c.pir}..remove(dogruBicim);
  final dogru = '$ozne $dogruBicim.';
  final secenekler = <String>[
    dogru,
    for (final b in (yanlis.toList()..shuffle(rng)).take(2)) '$ozne $b.',
  ]..shuffle(rng);
  return ExerciseModel(
    id: '${kBicimOneki}niha_${c.mastar}_$ozne',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: 'Kîjan rast e?',
    turkishPrompt: '"${c.mastar}" (${c.tr.toLowerCase()}), şimdiki zaman. Özne: $ozneTr',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    grammarNote: 'Şimdiki zaman: di- + kök + kişi eki — ez -im, tu -î, ew -e, em/hûn/ew -in '
        '(${c.ez}, ${c.tu}, ${c.ew}, ${c.pir}).\n'
        'Korpusta "$dogruBicim" ${sayi(c)} kez.',
    cardId: c.kimlik.isEmpty ? null : c.kimlik,
  );
}

// ── Şimdiki zaman: olumsuzluk ────────────────────────────────────────────────

List<ExerciseModel> neyiniSorulari(Random rng) {
  // (fiil, özne, olumlu, olumsuz, korpus sayısı) — yalnız olumsuzu tanıklı biçimler
  final adaylar = <(Cekim, String, String, String, int)>[
    for (final c in kCekimler) ...[
      if (c.neyiniEz != null) (c, 'Ez', c.ez, c.neyiniEz!, c.nNeyiniEz),
      if (c.neyiniEw != null) (c, 'Ew', c.ew, c.neyiniEw!, c.nNeyiniEw),
    ],
  ]..shuffle(rng);
  // Aynı fiil iki kez gelmesin (ez ve ew biçimi aynı kuralı sınar).
  final gorulen = <String>{};
  final secilen = [
    for (final a in adaylar)
      if (gorulen.add(a.$1.mastar)) a,
  ].take(kBicimSoruSayisi);
  return [for (final a in secilen) _neyiniSorusu(a, rng)];
}

ExerciseModel _neyiniSorusu((Cekim, String, String, String, int) a, Random rng) {
  final (c, ozne, olumlu, olumsuz, sayi) = a;
  final dogru = '$ozne $olumsuz.';
  // Yanlış seçenekler dilbilgisine aykırı: di- kalıp ne-/na- eklenmiş (nediçim, nadiçim).
  final secenekler = <String>[dogru, '$ozne ne$olumlu.', '$ozne na$olumlu.']..shuffle(rng);
  return ExerciseModel(
    id: '${kBicimOneki}neyini_${c.mastar}_$ozne',
    type: ExerciseType.multipleChoice,
    kurmanjPrompt: 'Kîjan rast e?',
    turkishPrompt: '"$ozne $olumlu." cümlesinin olumsuzu (şimdiki zaman)',
    options: secenekler,
    correctAnswer: dogru,
    correctIndex: secenekler.indexOf(dogru),
    grammarNote: 'Şimdiki zamanda olumsuzluk: di- düşer, yerine na- gelir ($olumlu → $olumsuz).\n'
        'Korpusta "$olumsuz" $sayi kez.',
    cardId: c.kimlik.isEmpty ? null : c.kimlik,
  );
}
