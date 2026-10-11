// Yazılı cevap değerlendirmesi (iyileştirme planı Faz 1.6):
// şapkalı harf farkı artık sessizce doğru sayılmaz.

import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/features/exercises/domain/typed_answer.dart';

void main() {
  TypedVerdict karar(String yazilan, String beklenen) =>
      evaluateTypedAnswer(yazilan, beklenen).verdict;

  group('şapkalı harf farkı yanlış sayılır', () {
    test('en küçük çiftler: ker ≠ kêr, bir ≠ bîr, dur ≠ dûr', () {
      expect(karar('ker', 'kêr'), TypedVerdict.diacritic);
      expect(karar('bir', 'bîr'), TypedVerdict.diacritic);
      expect(karar('dur', 'dûr'), TypedVerdict.diacritic);
      expect(evaluateTypedAnswer('ker', 'kêr').isCorrect, isFalse);
    });

    test('ters yön de yanlış: kêr yazıldı, ker bekleniyordu', () {
      final r = evaluateTypedAnswer('kêr', 'ker');
      expect(r.verdict, TypedVerdict.diacritic);
      expect(r.diacriticPairs, [('e', 'ê')]);
    });

    test('uzun kelimede tolerans şapkalı harfi bağışlamaz', () {
      // Eski davranış: 1 harflik tolerans "pirtuk"u doğru sayıyordu.
      expect(karar('pirtuk', 'pirtûk'), TypedVerdict.diacritic);
      expect(karar('xwendekar', 'xwendekar'), TypedVerdict.exact);
      expect(karar('cay', 'çay'), TypedVerdict.diacritic);
      expect(karar('ses', 'şeş'), TypedVerdict.diacritic);
    });

    test('karışan harf çiftleri bildirilir', () {
      expect(evaluateTypedAnswer('ker', 'kêr').diacriticPairs, [('ê', 'e')]);
      expect(evaluateTypedAnswer('ses', 'şeş').diacriticPairs, [('ş', 's')]);
      expect(evaluateTypedAnswer('penc', 'pênc').diacriticPairs, [('ê', 'e')]);
      expect(evaluateTypedAnswer('cîrok', 'çîrok').diacriticPairs,
          [('ç', 'c')]);
    });

    test('şapka hatası + küçük yazım hatası: yine şapka geri bildirimi', () {
      // "pirtûkên" bekleniyor; hem û düşmüş hem bir harf eksik.
      expect(karar('pirtuke', 'pirtûkên'), isNot(TypedVerdict.typo));
      expect(evaluateTypedAnswer('pirtuke', 'pirtûkên').isCorrect, isFalse);
    });
  });

  group('doğru sayılanlar değişmedi', () {
    test('birebir, büyük-küçük harf ve boşluk farkı', () {
      expect(karar('Kêr', 'kêr'), TypedVerdict.exact);
      expect(karar('  kêr ', 'kêr'), TypedVerdict.exact);
    });

    test('kabul edilen eş biçimler', () {
      expect(karar('roj baş', 'Sibê baş'), TypedVerdict.variant);
      expect(karar('sipas', 'spas'), TypedVerdict.variant);
      expect(karar('3', 'sê'), TypedVerdict.variant);
    });

    test('şapkalı harfler doğruysa küçük yazım hatası tolere edilir', () {
      expect(karar('pirtûkk', 'pirtûk'), TypedVerdict.typo);
      expect(karar('xwendekr', 'xwendekar'), TypedVerdict.typo);
    });

    test('kısa kelimede tolerans yok', () {
      expect(karar('aw', 'av'), TypedVerdict.wrong);
      expect(karar('nen', 'nan'), TypedVerdict.wrong);
    });
  });

  group('alternatif listesi şapkasız yazım içermez', () {
    test("'se', 'car', 'penc' artık kabul edilmez", () {
      expect(karar('se', 'sê'), TypedVerdict.diacritic);
      expect(karar('car', 'çar'), TypedVerdict.diacritic);
      expect(karar('penc', 'pênc'), TypedVerdict.diacritic);
      expect(karar('xatire te', 'bi xatirê te'), isNot(TypedVerdict.variant));
    });

    test('listede katlanınca anahtarıyla aynı olan alternatif yok', () {
      // Bilinçli istisna: "sibe" sözcüğün yalın biçimidir, "sibê" bükünlüsü;
      // ikisi de gerçek biçim, şapka düşmesi değil.
      const istisna = {('sibê baş', 'sibe baş')};
      kurmanciAlternatives.forEach((anahtar, liste) {
        for (final a in liste) {
          if (istisna.contains((anahtar, a))) continue;
          expect(
            foldKurmanciDiacritics(a) == foldKurmanciDiacritics(anahtar) &&
                a != anahtar,
            isFalse,
            reason: "'$anahtar' için '$a' şapkasız bir yazım",
          );
        }
      });
    });
  });

  test('boş cevap yanlıştır', () {
    expect(karar('', 'kêr'), TypedVerdict.wrong);
    expect(karar('   ', 'kêr'), TypedVerdict.wrong);
  });
}
