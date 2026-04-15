/// LÛTKE — TTS Asset Manifest (OTOMATIK ÜRETİLMİŞTİR)
///
/// Ön-üretilen Kurmancî TTS ses dosyalarının kataloğu.
/// Bu dosyayı elle düzenleme — `tool/prerender_tts.py` üzerine yazar.

class TtsAssetManifest {
  /// Kelime (küçük harf, normalleştirilmiş) → asset yolu.
  static const Map<String, String> entries = <String, String>{
    'bav': 'assets/audio/words/a1_080.wav',
    'bextewar': 'assets/audio/words/a1_025.wav',
    'bibore': 'assets/audio/words/a1_023.wav',
    'bira': 'assets/audio/words/a1_082.wav',
    'bîst': 'assets/audio/words/a1_041.wav',
    'dapîr': 'assets/audio/words/a1_084.wav',
    'deh': 'assets/audio/words/a1_040.wav',
    'erê': 'assets/audio/words/a1_014.wav',
    'gewr': 'assets/audio/words/a1_066.wav',
    'heft': 'assets/audio/words/a1_037.wav',
    'heftê': 'assets/audio/words/a1_046.wav',
    'hezar': 'assets/audio/words/a1_050.wav',
    'heşt': 'assets/audio/words/a1_038.wav',
    'heştê': 'assets/audio/words/a1_047.wav',
    'hûn': 'assets/audio/words/a1_104.wav',
    'jin': 'assets/audio/words/a1_091.wav',
    'kal': 'assets/audio/words/a1_085.wav',
    'kesk': 'assets/audio/words/a1_063.wav',
    'keç': 'assets/audio/words/a1_089.wav',
    'kur': 'assets/audio/words/a1_088.wav',
    'mamosta': 'assets/audio/words/a1_110.wav',
    'merheba': 'assets/audio/words/a1_011.wav',
    'min': 'assets/audio/words/a1_106.wav',
    'mor': 'assets/audio/words/a1_069.wav',
    'mêr': 'assets/audio/words/a1_090.wav',
    'narencî': 'assets/audio/words/a1_070.wav',
    'neh': 'assets/audio/words/a1_039.wav',
    'nevî': 'assets/audio/words/a1_092.wav',
    'nod': 'assets/audio/words/a1_048.wav',
    'pembe': 'assets/audio/words/a1_068.wav',
    'pênc': 'assets/audio/words/a1_035.wav',
    'pêncî': 'assets/audio/words/a1_044.wav',
    'qehweyî': 'assets/audio/words/a1_067.wav',
    'reş': 'assets/audio/words/a1_061.wav',
    'sed': 'assets/audio/words/a1_049.wav',
    'sifir': 'assets/audio/words/a1_030.wav',
    'sih': 'assets/audio/words/a1_042.wav',
    'silav': 'assets/audio/words/a1_010.wav',
    'sor': 'assets/audio/words/a1_062.wav',
    'spas': 'assets/audio/words/a1_012.wav',
    'spî': 'assets/audio/words/a1_060.wav',
    'xaltî': 'assets/audio/words/a1_087.wav',
    'xwişk': 'assets/audio/words/a1_083.wav',
    'yek': 'assets/audio/words/a1_031.wav',
    'zer': 'assets/audio/words/a1_065.wav',
    'çar': 'assets/audio/words/a1_034.wav',
    'çil': 'assets/audio/words/a1_043.wav',
    'şeş': 'assets/audio/words/a1_036.wav',
    'şêst': 'assets/audio/words/a1_045.wav',
    'şîn': 'assets/audio/words/a1_064.wav',
  };

  static int get count => entries.length;

  static String? lookup(String word) {
    final key = word.trim().toLowerCase();
    if (key.isEmpty) return null;
    final normalized = key.replaceAll(RegExp(r'[.,!?]+$'), '').trim();
    return entries[normalized] ?? entries[key];
  }
}
