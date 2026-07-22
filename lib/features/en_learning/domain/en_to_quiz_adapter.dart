// LÛTKE — EnWord → Kurmancî kelime_db (LearningRecord) uyumluluk adaptörü.
//
// Mevcut Kurmancî ekranları (quiz_screen, flashcard_screen, lesson_screen,
// unit_hub_screen, home_screen) positional record şeklinde kayıt bekliyor:
//   (id, ku, tr, en, cins, ez, kat, zor, not, her, gen)
// Bu şekil `lib/features/lessons/domain/a1_kelime_db.dart` vb.'nin const
// satırlarıyla bire bir uyuşur. Adaptör EnWord verisini aynı şekle
// dönüştürerek tüm ekranların İngilizce track'inde çalışmasını sağlar.
//
// EŞLEME (önemli — bilinçli bir perspektif kayması):
//   LearningRecord.ku ← EnWord.en   (hedef dil = öğrenilen İngilizce kelime)
//   LearningRecord.tr ← EnWord.ku   (anadildeki açıklama = Kurmancî karşılık)
//   LearningRecord.en ← EnWord.en   (yedek, UI ingilizce alanı için)
//   LearningRecord.her ← EnWord.her (İngilizce örnek cümleler)
//   LearningRecord.gen ← EnWord.herKu (Kurmancî paralel çeviri)
//   LearningRecord.not ← EnWord.notKu
//   LearningRecord.kat, zor değişmeden geçer.
//
// Bu sayede mevcut ekranlar:
//   - "ku" alanında İngilizce gösterir (target = öğrenilen)
//   - "tr" alanında Kurmancî açıklama gösterir (anadildeki karşılık)
//   - `showTurkishProvider` toggle'ı EN modunda KU↔EN gibi davranır; Kurmancî
//     her zaman görünür çünkü o "mother tongue"dür.
//
// İngilizce'de cinsiyet sistemi yok: `cins` boş string (''), `ez` null.
// Kurmancî DB'sinde `cins` her zaman dolu ('nêr' / 'mê' / 'bêcins') olduğundan
// adaptör aynı sözleşmeyi korumak için `cins: ''` döner — null DEĞİL — ki
// downstream `record.cins as String` cast'i güvenli çalışsın.

library;

import 'en_word.dart';
import 'en_a1_kelime_db.dart';
import 'en_a2_kelime_db.dart';
import 'en_b1_kelime_db.dart';
import 'en_b2_kelime_db.dart';
import 'en_c1_kelime_db.dart';
import 'en_c2_kelime_db.dart';
import 'en_child_a1_kelime_db.dart';
import 'en_child_a2_kelime_db.dart';

/// Kurmancî DB satırları ile aynı şekildeki positional record.
///
/// Bu typedef'in alan sırası ve nullability'si `a1_kelime_db.dart` vb.'deki
/// const girdileriyle bire bir eşleşmelidir; yoksa downstream dynamic
/// cast'leri (örn. `flashcard_screen.dart` → `record.cins as String`) runtime
/// TypeError atar. Alan değiştirilirken Kurmancî DB'leri de güncellenmeli.
typedef LearningRecord = ({
  String id,
  String ku,
  String tr,
  String en,
  // `cins` Kurmancî DB'de her zaman non-null ('nêr'/'mê'/'bêcins'); EN'de
  // '' olarak set edilir. Nullable tutulmasının sebebi: Kurmancî tarafında
  // eski bazı girdilerin null ihtimali — yeni veri için '' tercih edilir.
  String? cins,
  String? ez,
  String kat,
  double zor,
  String? not,
  List<String>? her,
  List<String>? gen,
});

/// Tek bir EnWord kaydını LearningRecord şekline taşır (pure, allocation-ucuz).
LearningRecord _adaptEn(EnWord w) {
  return (
    id: w.id,
    ku: w.en,         // hedef dil İngilizce
    tr: w.ku,         // anadildeki açıklama Kurmancî
    en: w.en,
    cins: '',         // İngilizce'de cinsiyet sistemi yok (non-null by convention)
    ez: null,
    kat: w.kat,
    zor: w.zor,
    not: w.notKu,
    her: w.her,       // İngilizce örnek cümleler
    gen: w.herKu,     // Kurmancî çevirileri (yedek görünüm)
  );
}

/// Desteklenen seviye anahtarları — `_getEnRecords` ile uyumlu.
/// Geçersiz değer fallback için A1 kullanılır ama debug'da uyarı loglanır.
const _kSupportedLevels = <String>{
  'A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'CHILD_A1', 'CHILD_A2',
};

// PERF: Eskiden 8 ayrı `final` top-level ifadesi vardı:
//   final kEnA1AsRecords = kEnA1Liste.map(_adaptEn).toList(...)   // × 8
// Dart bu finalleri lazy başlatsa da her biri uygulama ömrü boyunca
// bellek tutuyordu. Web için öğrenci genelde tek seviye çalışıyor (örn.
// B1); diğer 7 seviyenin ~1000-1700 öğelik record listesini üretmek boşuna.
//
// Yeni tasarım: tek bir cache `Map<String, List<LearningRecord>>`.
// İlk istekte o seviyenin listesi üretilip ezberlenir, diğerleri
// hiç materialize olmaz. Belleğe yansıma: kullanıcı sadece B1 seçerse
// ~1700 record (A1..C2 toplamı ~6500 record'un %26'sı).
final Map<String, List<LearningRecord>> _enRecordCache = {};

/// Verilen seviye için record listesi üretir (cache'siz). Sadece cache miss'te
/// çağrılır. `growable:false` — downstream mutate etmez, sabit kalır.
List<LearningRecord> _buildRecords(String level) {
  final List<EnWord> source = switch (level) {
    'A1' => kEnA1Liste,
    'A2' => kEnA2Liste,
    'B1' => kEnB1Liste,
    'B2' => kEnB2Liste,
    'C1' => kEnC1Liste,
    'C2' => kEnC2Liste,
    'CHILD_A1' => kEnChildA1Liste,
    'CHILD_A2' => kEnChildA2Liste,
    _ => kEnA1Liste, // Defensive fallback — uyarı yukarıda loglanır
  };
  return source.map(_adaptEn).toList(growable: false);
}

/// Seviye → kayıt listesi (cache'lenir, ilk çağrıda üretilir).
List<LearningRecord> _getEnRecords(String level) =>
    _enRecordCache.putIfAbsent(level, () => _buildRecords(level));

/// İngilizce seviye başına kayıt listesi getters'ı.
/// Kurmancî tarafıyla simetri için tutulur; doğrudan kullanılmazsa bile
/// `kEnA1AsRecords.length` gibi testlerde yararlı.
List<LearningRecord> get kEnA1AsRecords => _getEnRecords('A1');
List<LearningRecord> get kEnA2AsRecords => _getEnRecords('A2');
List<LearningRecord> get kEnB1AsRecords => _getEnRecords('B1');
List<LearningRecord> get kEnB2AsRecords => _getEnRecords('B2');
List<LearningRecord> get kEnC1AsRecords => _getEnRecords('C1');
List<LearningRecord> get kEnC2AsRecords => _getEnRecords('C2');

/// Çocuk modu — İngilizce (Pre-A1 Starters seviyesi).
List<LearningRecord> get kEnChildA1AsRecords => _getEnRecords('CHILD_A1');
List<LearningRecord> get kEnChildA2AsRecords => _getEnRecords('CHILD_A2');

/// Seviye string → İngilizce kayıt listesi.
///
/// [level] — 'A1'/'a1'/'B2'/'child_a1' gibi, büyük-küçük farkı önemsiz.
/// [childOnly] — true ise EN child A1/A2 DB'sine yönlendirir (Oxford 3000
/// yerine yaş-uygun çocuk kelimeleri). Child modunda yetişkin B1-C2 yok;
/// A2+ child seviyesi yoksa A1 child'a düşer.
///
/// Return type `List<LearningRecord>` — mevcut call-site'lar `List<dynamic>`
/// olarak tüketiyor (dynamic alan erişimi için), bu geriye dönük uyumlu.
List<LearningRecord> getEnWordsForLevel(
  String level, {
  bool childOnly = false,
}) {
  final upper = level.toUpperCase();
  if (childOnly) {
    // Child modu sadece A1/A2 tanımlı; daha üst seviye child istenirse A2'ye
    // clamp — çocuk kullanıcı için üst-seviye uygun değil.
    final childKey = (upper == 'A2' || upper == 'CHILD_A2')
        ? 'CHILD_A2'
        : 'CHILD_A1';
    return _getEnRecords(childKey);
  }
  if (!_kSupportedLevels.contains(upper)) {
    // Unknown level — A1'e düş. Debug build'de görünür olması için assert.
    assert(() {
      // ignore: avoid_print
      print('[en_to_quiz_adapter] Bilinmeyen seviye "$level" → A1 fallback');
      return true;
    }());
    return _getEnRecords('A1');
  }
  return _getEnRecords(upper);
}

/// Test-only: cache'i temizler (birim testlerinde taze state gerekirse).
/// Production kodundan çağırmayın.
void debugClearEnAdapterCache() => _enRecordCache.clear();
