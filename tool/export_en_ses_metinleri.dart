// LÛTKE — İngilizce ses metinleri dışa aktarma aracı (Dart → JSON)
//
// Uygulamanın İngilizce TTS'e verdiği metinleri BİREBİR toplar — ses
// fabrikası bunları önceden seslendirir, EnSesManifest bu listeden üretilir.
// Her kaynak, ilgili ekranın konuşma çağrısını aynen taklit eder:
//
//   en_listening_screen  → EnTtsHelper.speak(q.audioText)
//   en_reading_screen    → EnTtsHelper.speak(p.passage)
//   en_grammar_screen    → EnTtsHelper.speak(ex.en)   (tüm konular/kurallar)
//   en_speaking_screen   → EnTtsHelper.speak(item.textEn)
//   flashcard / lesson / quiz (İngilizce modül) → SpeakButton(lang:'en',
//       text: record.ku) — adaptörde record.ku ← EnWord.en; kaynak
//       getEnWordsForLevel (A1–C2 + çocuk A1/A2)
//   child_vocabulary_screen → SpeakButton(lang:'en', text: w.en)
//       (kEnChildA1Liste.take(24) — çocuk A1 kümesinin alt kümesi)
//
// Metin DEĞİŞTİRİLMEZ (kırpma/sadeleştirme yok): EnSesManifest.anahtar
// arama anında aynı sadeleştirmeyi yapar; fabrika da aynı kuralı uygular.
// Yinelenen metinler (birebir aynı dize) bir kez yazılır.
//
// Çalıştırma:  dart run tool/export_en_ses_metinleri.dart
// Çıktı:       build/en_ses_metinleri.json  (JSON dizi — string listesi)
//
// Saf Dart (Flutter import etmez): yalnızca en_learning/domain veri
// dosyaları ve EnSesManifest (anahtar kuralı, sayım için).

import 'dart:convert';
import 'dart:io';

import 'package:lutke/core/services/en_ses_manifest.dart';
import 'package:lutke/features/en_learning/domain/en_word.dart';
import 'package:lutke/features/en_learning/domain/en_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_a2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_c1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_c2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_child_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_child_a2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_listening_db.dart';
import 'package:lutke/features/en_learning/domain/en_reading_db.dart';
import 'package:lutke/features/en_learning/domain/en_grammar_db.dart';
import 'package:lutke/features/en_learning/domain/en_speaking_db.dart';

/// Kaynak adı → o kaynağın seslendirdiği metinler (ekran sırasıyla).
Map<String, Iterable<String>> kaynaklar() {
  Iterable<String> kelimeler(List<EnWord> liste) => liste.map((w) => w.en);
  return {
    // Dinleme — iki "dinle" düğmesi de q.audioText okur.
    'en_listening (audioText)':
        kEnListeningExercises.map((q) => q.audioText),
    // Okuma — "Pasajê bibihîze" tüm pasajı okur (rate 0.85).
    'en_reading (passage)': kEnReadingPassages.map((p) => p.passage),
    // Dilbilgisi — her örnek kartı kendi İngilizce cümlesini okur.
    'en_grammar (examples.en)': [
      for (final t in kEnGrammarTopics)
        for (final r in t.rules)
          for (final ex in r.examples) ex.en,
    ],
    // Konuşma — model ses (0.85) ve yavaş (0.6) aynı metni okur.
    'en_speaking (textEn)': kEnSpeakingExercises.map((s) => s.textEn),
    // Kelime kartları / ders / quiz (İngilizce modül) — SpeakButton(lang:'en').
    'en_a1_kelime (en)': kelimeler(kEnA1Liste),
    'en_a2_kelime (en)': kelimeler(kEnA2Liste),
    'en_b1_kelime (en)': kelimeler(kEnB1Liste),
    'en_b2_kelime (en)': kelimeler(kEnB2Liste),
    'en_c1_kelime (en)': kelimeler(kEnC1Liste),
    'en_c2_kelime (en)': kelimeler(kEnC2Liste),
    'en_child_a1_kelime (en)': kelimeler(kEnChildA1Liste),
    'en_child_a2_kelime (en)': kelimeler(kEnChildA2Liste),
    // Çocuk kelime ekranı — çocuk A1'in ilk 24'ü (yukarıdakinin alt kümesi;
    // ekran mantığı değişirse burada görünsün diye ayrı sayılır).
    'child_vocabulary (ilk 24)':
        kEnChildA1Liste.take(24).map((w) => w.en),
  };
}

void main() {
  final gorulen = <String>{};
  final cikti = <String>[];

  stdout.writeln('İngilizce ses metinleri — kaynak başına:');
  for (final e in kaynaklar().entries) {
    var toplam = 0;
    var yeni = 0;
    for (final metin in e.value) {
      if (metin.trim().isEmpty) continue;
      toplam++;
      if (gorulen.add(metin)) {
        cikti.add(metin);
        yeni++;
      }
    }
    stdout.writeln('  ${e.key.padRight(30)} $toplam metin, $yeni yeni');
  }

  final anahtarlar = cikti.map(EnSesManifest.anahtar).toSet();
  final dosya = File('build/en_ses_metinleri.json');
  dosya.parent.createSync(recursive: true);
  dosya.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(cikti),
  );

  final karakter = cikti.fold<int>(0, (t, m) => t + m.length);
  stdout.writeln('');
  stdout.writeln('Toplam: ${cikti.length} benzersiz metin '
      '(${anahtarlar.length} benzersiz manifest anahtarı, '
      '$karakter karakter)');
  stdout.writeln('Yazıldı: ${dosya.path}');
}
