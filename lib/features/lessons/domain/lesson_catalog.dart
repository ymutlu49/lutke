/// Elle yazılmış derslerin (wane) kataloğu.
///
/// 105 ders ve 590 egzersiz `*_lesson_definitions.dart` dosyalarında duruyor
/// ama öğrencinin yoluna hiç bağlanmamıştı (yalnız yönetici paneli okuyordu).
/// Bu dosya onları iki yoldan erişilir kılar:
///
///   - düzeye göre sıralı liste ([lessonsForLevel]),
///   - kelime kategorisine (birime) göre ([lessonsForUnit]): bir ders, hedef
///     kartlarının en çok ait olduğu kategorinin dersidir.
///
/// Saf Dart; Flutter içe aktarmaz.
library;

import 'a1_kelime_db.dart';
import 'a1_lesson_definitions.dart';
import 'a2_kelime_db.dart';
import 'a2_lesson_definitions.dart';
import 'b1_kelime_db.dart';
import 'b1_lesson_definitions.dart';
import 'b2_kelime_db.dart';
import 'b2_lesson_definitions.dart';
import 'c1_kelime_db.dart';
import 'c1_lesson_definitions.dart';
import 'c2_kelime_db.dart';
import 'bicim_alistirma.dart';
import 'c2_lesson_definitions.dart';
import 'lesson_entities.dart';
import 'olcme.dart';
import 'xwendin_catalog.dart';

const List<String> kLessonLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

/// Düzeyin dersleri, yazıldıkları sırayla.
List<LessonModel> lessonsForLevel(String level) => switch (level.toUpperCase()) {
      'A1' => kA1Lessons,
      'A2' => kA2Lessons,
      'B1' => kB1Lessons,
      'B2' => kB2Lessons,
      'C1' => kC1Lessons,
      'C2' => kC2Lessons,
      _ => const <LessonModel>[],
    };

List<dynamic> _wordsForLevel(String level) => switch (level.toUpperCase()) {
      'A1' => kA1TamListe,
      'A2' => kA2TamListe,
      'B1' => kB1All,
      'B2' => kB2All,
      'C1' => kC1All,
      'C2' => kC2All,
      _ => const <dynamic>[],
    };

/// Düzeyin kelime kayıtları (uygulamanın kullandığı liste).
List<dynamic> wordsForLevel(String level) => _wordsForLevel(level);

LessonModel? lessonById(String id) {
  // Veriden üretilen biçim alıştırmaları: her çağrıda yeniden karılır.
  if (id.startsWith(kBicimOneki)) return bicimDersi(id);
  // Okuma metinlerinin anlama soruları.
  if (id.startsWith(kXwendinOneki)) return xwendinDersi(id);
  // Düzey sınavı: her çağrıda yeniden derlenir.
  if (id.startsWith(kEzmunOneki)) return ezmunDersi(id);
  for (final level in kLessonLevels) {
    for (final lesson in lessonsForLevel(level)) {
      if (lesson.id == id) return lesson;
    }
  }
  return null;
}

final Map<String, Map<String, String>> _kategoriOnbellek = {};

/// düzey → (kart kimliği → kategori)
Map<String, String> _kartKategorileri(String level) =>
    _kategoriOnbellek.putIfAbsent(level.toUpperCase(), () {
      final harita = <String, String>{};
      for (final w in _wordsForLevel(level)) {
        final kat = w.kat as String? ?? '';
        if (kat.isNotEmpty) harita[w.id as String] = kat;
      }
      return harita;
    });

/// Dersin hedef kartlarının en çok ait olduğu kategori; kartı yoksa `null`.
/// Eşitlikte, kartların dersteki sırasına göre ilk görülen kategori kazanır.
String? dominantCategory(LessonModel lesson, String level) {
  final kategoriler = _kartKategorileri(level);
  final sayim = <String, int>{};
  for (final id in lesson.targetCardIds) {
    final kat = kategoriler[id];
    if (kat != null) sayim[kat] = (sayim[kat] ?? 0) + 1;
  }
  String? enIyi;
  var enCok = 0;
  sayim.forEach((kat, n) {
    if (n > enCok) {
      enCok = n;
      enIyi = kat;
    }
  });
  return enIyi;
}

final Map<String, List<LessonModel>> _birimOnbellek = {};

/// Bir birimin (düzey + kategori) dersleri, yazıldıkları sırayla.
List<LessonModel> lessonsForUnit(String level, String category) =>
    _birimOnbellek.putIfAbsent('${level.toUpperCase()}|$category', () {
      return [
        for (final lesson in lessonsForLevel(level))
          if (dominantCategory(lesson, level) == category) lesson,
      ];
    });

/// Egzersiz puanlanır mı? Konuşma alıştırması öğrencinin kendi beyanıdır
/// (Kurmancî konuşma tanıma yok); puana girmez.
bool isScored(ExerciseModel e) => e.type != ExerciseType.speakingPractice;
