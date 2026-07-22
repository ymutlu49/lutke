import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Karîk Pet Evolution Sistemi
//
// Tamagotchi etkisi (sağlıklı sınırla): çocuk yıldız topladıkça
// Karîk büyür ve yeni özellikler kazanır. Khan Kids + Duolingo
// maskot araştırmasıyla uyumlu.
//
// 6 Aşama (her aşama 50 yıldız):
//   1. 🐐 Karîka Biçûk (Yavru Karîk) — 0-49 yıldız
//   2. 🧣 Karîk bi Şepik (Atkılı) — 50-149
//   3. 🎩 Karîka bi Şapik (Şapkalı) — 150-299
//   4. 🎸 Karîka Dengbêj (Müzisyen) — 300-499
//   5. 📚 Karîka Zana (Bilge) — 500-799
//   6. 👑 Karîka Serok (Lider/Efsane) — 800+
// Linguistic note: "karîk" di Kurmancî de mê ye → veqetandek -a.
// ════════════════════════════════════════════════════════════════

enum KarikStage {
  yavru(
    id: 1,
    emoji: '🐐',
    nameKu: 'Karîka Biçûk',
    nameTr: 'Yavru Karîk',
    descriptionKu: 'Karîka biçûk nû hatiye malê.',
    descriptionTr: 'Karîk yavru, yeni evine geldi.',
    minStars: 0,
  ),
  destmal(
    id: 2,
    emoji: '🧣',
    nameKu: 'Karîk bi Şepik',
    nameTr: 'Atkılı Karîk',
    descriptionKu: 'Karîk hinekî mezin bûye û şepikê xwe li stûyê xwe kiriye.',
    descriptionTr: 'Karîk biraz büyüdü, atkısını boynuna taktı.',
    minStars: 50,
  ),
  sapik(
    id: 3,
    emoji: '🎩',
    nameKu: 'Karîka bi Şapik',
    nameTr: 'Şapkalı Karîk',
    descriptionKu: 'Karîk bi şapika xwe niha pir xweşik xuya dike.',
    descriptionTr: 'Karîk şimdi şapkasıyla çok şık.',
    minStars: 150,
  ),
  dengbej(
    id: 4,
    emoji: '🎸',
    nameKu: 'Karîka Dengbêj',
    nameTr: 'Karîk-Müzisyen',
    descriptionKu: 'Karîk fêrî lêxistina sazê bûye!',
    descriptionTr: 'Karîk enstrüman çalmayı öğrendi!',
    minStars: 300,
  ),
  alim(
    id: 5,
    emoji: '📚',
    nameKu: 'Karîka Zana',
    nameTr: 'Bilge Karîk',
    descriptionKu: 'Karîk pir pirtûk xwendine û bûye zana.',
    descriptionTr: 'Karîk birçok kitap okudu ve bilge oldu.',
    minStars: 500,
  ),
  serok(
    id: 6,
    emoji: '👑',
    nameKu: 'Karîka Serok',
    nameTr: 'Lider Karîk',
    descriptionKu: 'Karîk niha bûye efsane — bi te re!',
    descriptionTr: 'Karîk şimdi bir efsane — seninle birlikte!',
    minStars: 800,
  );

  final int id;
  final String emoji;
  final String nameKu;
  final String nameTr;
  final String descriptionKu;
  final String descriptionTr;
  final int minStars;

  const KarikStage({
    required this.id,
    required this.emoji,
    required this.nameKu,
    required this.nameTr,
    required this.descriptionKu,
    required this.descriptionTr,
    required this.minStars,
  });

  static KarikStage fromStars(int stars) {
    for (final s in KarikStage.values.reversed) {
      if (stars >= s.minStars) return s;
    }
    return KarikStage.yavru;
  }

  /// Bir sonraki aşamaya kalan yıldız sayısı.
  int starsToNext(int currentStars) {
    final next = nextStage();
    if (next == null) return 0;
    return (next.minStars - currentStars).clamp(0, next.minStars);
  }

  KarikStage? nextStage() {
    final idx = KarikStage.values.indexOf(this);
    if (idx >= KarikStage.values.length - 1) return null;
    return KarikStage.values[idx + 1];
  }

  /// Aşamanın ilerleme yüzdesi (0.0 - 1.0) — o aşamanın aralığında nerede.
  double progressInStage(int currentStars) {
    final next = nextStage();
    if (next == null) return 1.0;
    final range = next.minStars - minStars;
    if (range <= 0) return 1.0;
    final inStage = currentStars - minStars;
    return (inStage / range).clamp(0.0, 1.0);
  }
}

class KarikEvolutionState {
  final int totalStars;
  final KarikStage stage;
  final bool hasNewStage; // Animasyon için — stage yeni açıldı mı

  const KarikEvolutionState({
    this.totalStars = 0,
    this.stage = KarikStage.yavru,
    this.hasNewStage = false,
  });

  KarikEvolutionState copyWith({
    int? totalStars,
    KarikStage? stage,
    bool? hasNewStage,
  }) =>
      KarikEvolutionState(
        totalStars: totalStars ?? this.totalStars,
        stage: stage ?? this.stage,
        hasNewStage: hasNewStage ?? this.hasNewStage,
      );
}

class KarikEvolutionNotifier extends StateNotifier<KarikEvolutionState> {
  // NOT: SharedPreferences anahtarı eski adıyla kalıyor — mevcut çocuk
  // kullanıcılarının yıldız ilerlemesi kaybolmasın. UI ve sembol Karîk olur.
  static const _kKey = 'bizer_evolution_stars';

  KarikEvolutionNotifier() : super(const KarikEvolutionState()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stars = prefs.getInt(_kKey) ?? 0;
    state = KarikEvolutionState(
      totalStars: stars,
      stage: KarikStage.fromStars(stars),
    );
  }

  Future<void> addStars(int amount) async {
    final oldStage = state.stage;
    final newTotal = state.totalStars + amount;
    final newStage = KarikStage.fromStars(newTotal);
    final leveledUp = newStage.id > oldStage.id;

    state = state.copyWith(
      totalStars: newTotal,
      stage: newStage,
      hasNewStage: leveledUp,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kKey, newTotal);
  }

  void clearNewStage() {
    state = state.copyWith(hasNewStage: false);
  }
}

final karikEvolutionProvider =
    StateNotifierProvider<KarikEvolutionNotifier, KarikEvolutionState>(
  (ref) => KarikEvolutionNotifier(),
);
