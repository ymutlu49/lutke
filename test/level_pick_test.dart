// Beceri alıştırmalarında düzeye göre seçim (iyileştirme planı Faz 1.2).

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/features/exercises/domain/ku_speaking_db.dart';
import 'package:lutke/features/exercises/domain/ku_writing_db.dart';
import 'package:lutke/features/exercises/domain/level_pick.dart';

void main() {
  final ogeler = [
    for (int i = 0; i < 12; i++) ('A1', i),
    for (int i = 0; i < 5; i++) ('A2', i),
    for (int i = 0; i < 3; i++) ('B1', i),
  ];
  List<(String, int)> sec(String? duzey, {int adet = 10}) =>
      pickForLevel(ogeler, duzey, (e) => e.$1, adet: adet, rng: Random(1));

  test('düzeyde yeterli öge varsa hepsi o düzeyden gelir', () {
    final s = sec('A1');
    expect(s.length, 10);
    expect(s.every((e) => e.$1 == 'A1'), isTrue);
  });

  test('düzeyde az öge varsa önce alt düzeylerle tamamlanır', () {
    final s = sec('A2');
    expect(s.length, 10);
    expect(s.where((e) => e.$1 == 'A2').length, 5);
    expect(s.where((e) => e.$1 == 'A1').length, 5);
    expect(s.any((e) => e.$1 == 'B1'), isFalse);
  });

  test('alt düzeyler de yetmezse üst düzeylere çıkılır', () {
    final yalnizUst = [for (int i = 0; i < 4; i++) ('B2', i)];
    final s = pickForLevel(yalnizUst, 'A1', (e) => e.$1, rng: Random(1));
    expect(s.length, 4);
  });

  test('düzey verilmezse ya da tanınmazsa tümünden seçilir', () {
    expect(sec(null).length, 10);
    expect(sec('zz').length, 10);
  });

  test('gerçek veride A1 öğrencisine yalnız A1 ögesi düşer', () {
    final yazma = pickForLevel(kKuWritingExercises, 'A1', (e) => e.level);
    final konusma = pickForLevel(kKuSpeakingExercises, 'A1', (e) => e.level);
    expect(yazma.length, 10);
    expect(konusma.length, 10);
    expect(yazma.every((e) => e.level == 'A1'), isTrue);
    expect(konusma.every((e) => e.level == 'A1'), isTrue);
  });

  test('gerçek veride C1 öğrencisi boş ekranla karşılaşmaz', () {
    // C1 düzeyinde yazma/konuşma ögesi yok; alt düzeylerden tamamlanır.
    expect(pickForLevel(kKuWritingExercises, 'C1', (e) => e.level).length, 10);
    expect(pickForLevel(kKuSpeakingExercises, 'C1', (e) => e.level).length, 10);
  });
}
