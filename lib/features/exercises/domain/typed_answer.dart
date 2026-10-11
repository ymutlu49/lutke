/// Yazılı cevabın değerlendirilmesi — "binivîse" (yaz) türü sorular.
///
/// Temel karar (iyileştirme planı Faz 1.6): Kurmancî'de ê/e, î/i, û/u ve
/// ç/c, ş/s ayrı seslerdir — *ker* (eşek) ile *kêr* (bıçak) farklı
/// sözcüklerdir. Önceden bu fark iki ayrı yoldan bağışlanıyordu: şapkalı
/// harfler katlanıp eşit sayılıyor, ayrıca tek harflik yazım toleransı
/// "ker"i "kêr" için doğru kabul ediyordu. Artık:
///
///   - yalnız şapkalı harfte ayrışan cevap YANLIŞTIR ve nedeni söylenir;
///   - yazım toleransı yalnız şapkalı harfler doğruysa çalışır.
///
/// Ekranda ê î û ç ş tuş sırası bulunduğu için bu harfleri yazmak mümkündür.
library;

import 'dart:math';

int levenshteinDistance(String a, String b) {
  final la = a.length;
  final lb = b.length;
  if (la == 0) return lb;
  if (lb == 0) return la;

  var prev = List<int>.generate(lb + 1, (i) => i);
  var curr = List<int>.filled(lb + 1, 0);

  for (int i = 1; i <= la; i++) {
    curr[0] = i;
    for (int j = 1; j <= lb; j++) {
      final cost = a[i - 1] == b[j - 1] ? 0 : 1;
      curr[j] = [
        prev[j] + 1, // deletion
        curr[j - 1] + 1, // insertion
        prev[j - 1] + cost, // substitution
      ].reduce(min);
    }
    final tmp = prev;
    prev = curr;
    curr = tmp;
  }

  return prev[lb];
}

/// Kelime uzunluğuna göre kabul edilebilir maksimum Levenshtein hatası.
/// Kısa kelimelerde sıkı, uzun kelimelerde tolere edilebilir.
/// - len < 4: 0 hata (örn. "av" için tam eşleşme)
/// - len 4-6: 1 hata
/// - len >= 7: 2 hata
int lenToleranceFor(int expectedLen) {
  if (expectedLen < 4) return 0;
  if (expectedLen <= 6) return 1;
  return 2;
}

/// Kurmancî'ye özgü harfler ve katlandıkları düz harf.
const Map<String, String> kKurmanciFolds = {
  'ê': 'e',
  'î': 'i',
  'û': 'u',
  'ç': 'c',
  'ş': 's',
};

/// Şapkalı ve çengelli harfleri düz karşılığına indirir. Yalnız "fark sadece
/// bu harflerde mi?" sorusunu yanıtlamak için kullanılır; eşitlik için DEĞİL.
String foldKurmanciDiacritics(String s) {
  var out = s;
  kKurmanciFolds.forEach((ozel, duz) => out = out.replaceAll(ozel, duz));
  return out;
}

/// Kabul edilen Kurmancî alternatif (eş anlam) yazımları.
/// Yazma alıştırmalarında kullanıcı "asıl" cevabın yerine eş bir form
/// yazsa da kabul edilir.
///
/// Anahtar: orijinal `word.ku` (lowercase, trim).
/// Değer: kabul edilen alternatifler listesi (lowercase, trim).
///
/// Buraya şapkasız yazım EKLENMEZ ('sê' için 'se', 'çar' için 'car' gibi):
/// o bir alternatif değil, yazım hatasıdır.
const Map<String, List<String>> kurmanciAlternatives = {
  // Selamlama
  'sibê baş': ['roj baş', 'rojbaş', 'roj baş!', 'sibe baş', 'sibebaş'],
  'roj baş': ['sibê baş', 'rojbaş', 'sibebaş'],
  'spas': ['sipas', 'spas dikim'],
  'silav': ['silaw', 'silaman'],
  'tu çawa yî?': ['tu çawanî?', 'çawa yî?', 'çawanî?'],
  'ez baş im': ['baş im', 'ez baş', 'ez başim'],
  'bi xêr hatî': ['xêr hatî', 'bi xêr hatî!'],
  'bila xweş be': ['bi xêr', 'xweş be'],
  // Vedalaşma
  'bi xatirê te': ['bixatirê te', 'xatirê te'],
  'oxir be': ['oxirbe', 'rê veke'],
  // Misafirperverlik
  'destê te xweş be': ['dest xweş', 'destxweş', 'destê te xweş'],
  // Sayılar (rakamla yazım)
  'yek': ['1'],
  'du': ['2', 'didu'],
  'sê': ['3'],
  'çar': ['4'],
  'pênc': ['5'],
  'şeş': ['6'],
  'heft': ['7'],
  'heşt': ['8'],
  'neh': ['9', 'no'],
  'deh': ['10'],
};

/// İki yönlü kabul: hem `expected → user` hem `user → expected`.
/// Karşılaştırma lowercase + trim sonrası, şapkalı harfler KATLANMADAN yapılır.
bool acceptsAlternative(String userInput, String expected) {
  final u = userInput.trim().toLowerCase();
  final e = expected.trim().toLowerCase();
  if (u == e) return true;
  if (kurmanciAlternatives[e]?.contains(u) ?? false) return true;
  if (kurmanciAlternatives[u]?.contains(e) ?? false) return true;
  return false;
}

enum TypedVerdict {
  /// Birebir doğru.
  exact,

  /// Kabul edilen eş biçim (roj baş / sibê baş).
  variant,

  /// Uzunluğa göre tolere edilen küçük yazım hatası; şapkalı harfler doğru.
  typo,

  /// %75 ve üzeri benzerlik; şapkalı harfler doğru.
  nearMiss,

  /// Şapkalı/çengelli harf hatası (ker ↔ kêr). YANLIŞ sayılır.
  diacritic,

  wrong,
}

class TypedAnswerResult {
  final TypedVerdict verdict;

  /// [TypedVerdict.diacritic] için karışan harf çiftleri:
  /// (olması gereken, yazılan) — örn. ('ê', 'e').
  final List<(String, String)> diacriticPairs;

  const TypedAnswerResult(this.verdict, [this.diacriticPairs = const []]);

  bool get isCorrect =>
      verdict == TypedVerdict.exact ||
      verdict == TypedVerdict.variant ||
      verdict == TypedVerdict.typo ||
      verdict == TypedVerdict.nearMiss;
}

/// Yazılan ile beklenen arasında sayısı tutmayan özel harfler.
List<(String, String)> _diacriticPairs(String u, String e) {
  final pairs = <(String, String)>[];
  kKurmanciFolds.forEach((ozel, duz) {
    final beklenen = ozel.allMatches(e).length;
    final yazilan = ozel.allMatches(u).length;
    if (yazilan < beklenen) pairs.add((ozel, duz));
    if (yazilan > beklenen) pairs.add((duz, ozel));
  });
  return pairs;
}

TypedAnswerResult evaluateTypedAnswer(String userInput, String expected) {
  final u = userInput.trim().toLowerCase();
  final e = expected.trim().toLowerCase();
  if (u == e) return const TypedAnswerResult(TypedVerdict.exact);
  if (acceptsAlternative(u, e)) {
    return const TypedAnswerResult(TypedVerdict.variant);
  }
  if (u.isEmpty) return const TypedAnswerResult(TypedVerdict.wrong);

  final fu = foldKurmanciDiacritics(u);
  final fe = foldKurmanciDiacritics(e);
  if (fu == fe) {
    return TypedAnswerResult(TypedVerdict.diacritic, _diacriticPairs(u, e));
  }

  // Katlama mesafeyi düşürüyorsa hataların en az biri şapkalı harftedir;
  // hoşgörü katmanları onu bağışlamaz.
  final d = levenshteinDistance(u, e);
  final df = levenshteinDistance(fu, fe);
  final tolerans = lenToleranceFor(e.length);
  if (df < d) {
    return df <= tolerans
        ? TypedAnswerResult(TypedVerdict.diacritic, _diacriticPairs(u, e))
        : const TypedAnswerResult(TypedVerdict.wrong);
  }

  if (d <= tolerans) return const TypedAnswerResult(TypedVerdict.typo);

  // Yakın cevap: %75 eşiği — 4 harfte 1, 8 harfte 2, 16 harfte 4 hata.
  // Kısa kelimelerde (<4 harf) uygulanmaz.
  if (e.length >= 4) {
    final benzerlik = 1.0 - (d / max(u.length, e.length));
    if (benzerlik >= 0.75) return const TypedAnswerResult(TypedVerdict.nearMiss);
  }
  return const TypedAnswerResult(TypedVerdict.wrong);
}
