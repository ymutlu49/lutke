/// LÛTKE — EnWord → Quiz/Flashcard uyumlu kayıt adaptörü.
///
/// Mevcut Kurmancî ekranları (quiz_screen, flashcard_screen, vb.)
/// `(id, ku, tr, en, cins, ez, kat, zor, not, her, gen)` şeklinde
/// Dart record şekli bekliyor. Bu adaptör EnWord verisini aynı şekle
/// dönüştürerek tüm ekranların İngilizce moduyla çalışmasını sağlar.
///
/// EŞLEME (önemli):
///   _QuizWord.ku ← EnWord.en  (öğrenilen hedef = İngilizce kelime)
///   _QuizWord.tr ← EnWord.ku  (anadildeki açıklama = Kurmancî karşılık)
///   _QuizWord.en ← EnWord.en  (yedek)
///
/// Bu sayede mevcut ekranlar:
///   - "ku" alanında İngilizce gösterir
///   - "tr" alanında Kurmancî açıklama gösterir (mother tongue)
///   - showTurkishProvider toggle'ı KU↔EN modunda KU↔KU gibi davranır
///     (Kurmancî her zaman gösterilir, çünkü o "mother tongue")

import 'en_word.dart';
import 'en_a1_kelime_db.dart';
import 'en_a2_kelime_db.dart';
import 'en_b1_kelime_db.dart';
import 'en_b2_kelime_db.dart';
import 'en_c1_kelime_db.dart';
import 'en_c2_kelime_db.dart';
import 'en_child_a1_kelime_db.dart';
import 'en_child_a2_kelime_db.dart';

/// Kurmancî DB ile aynı şekildeki record (uyumlu).
typedef LearningRecord = ({
  String id,
  String ku,
  String tr,
  String en,
  String? cins,
  String? ez,
  String kat,
  double zor,
  String? not,
  List<String>? her,
  List<String>? gen,
});

LearningRecord _adaptEn(EnWord w) {
  return (
    id: w.id,
    ku: w.en,         // hedef dil İngilizce
    tr: w.ku,         // anadildeki açıklama Kurmancî
    en: w.en,
    cins: '',         // İngilizce'de cinsiyet sistemi yok
    ez: null,
    kat: w.kat,
    zor: w.zor,
    not: w.notKu,
    her: w.her,       // İngilizce örnek cümleler
    gen: w.herKu,     // Kurmancî çevirileri (yedek görünüm)
  );
}

/// İngilizce A1 kelime listesi — Kurmancî record şeklinde.
final List<LearningRecord> kEnA1AsRecords =
    kEnA1Liste.map(_adaptEn).toList(growable: false);

final List<LearningRecord> kEnA2AsRecords =
    kEnA2Liste.map(_adaptEn).toList(growable: false);
final List<LearningRecord> kEnB1AsRecords =
    kEnB1Liste.map(_adaptEn).toList(growable: false);
final List<LearningRecord> kEnB2AsRecords =
    kEnB2Liste.map(_adaptEn).toList(growable: false);
final List<LearningRecord> kEnC1AsRecords =
    kEnC1Liste.map(_adaptEn).toList(growable: false);
final List<LearningRecord> kEnC2AsRecords =
    kEnC2Liste.map(_adaptEn).toList(growable: false);

/// Çocuk modu — İngilizce.
final List<LearningRecord> kEnChildA1AsRecords =
    kEnChildA1Liste.map(_adaptEn).toList(growable: false);
final List<LearningRecord> kEnChildA2AsRecords =
    kEnChildA2Liste.map(_adaptEn).toList(growable: false);

/// Seviye string → İngilizce kayıt listesi
List<dynamic> getEnWordsForLevel(String level) {
  return switch (level.toUpperCase()) {
    'A1' => kEnA1AsRecords,
    'A2' => kEnA2AsRecords,
    'B1' => kEnB1AsRecords,
    'B2' => kEnB2AsRecords,
    'C1' => kEnC1AsRecords,
    'C2' => kEnC2AsRecords,
    _ => kEnA1AsRecords,
  };
}
