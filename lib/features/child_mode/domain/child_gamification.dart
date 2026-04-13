// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Gamifikasyonu
//
// XP yerine yıldız, badge yerine çıkartma gösterir.
// Dahili olarak mevcut GamificationNotifier'ı kullanır.
//
// Dönüşüm: 1 yıldız = 10 XP
// ════════════════════════════════════════════════════════════════

/// Çocuk gamifikasyon durumu — GamificationState'in çocuk yüzü.
class ChildGamificationState {
  final int totalXP;
  final int completedLessons;
  final int wordsLearned;
  final List<bool> weeklyDays; // 7 gün: aktif mi?

  const ChildGamificationState({
    this.totalXP = 0,
    this.completedLessons = 0,
    this.wordsLearned = 0,
    this.weeklyDays = const [false, false, false, false, false, false, false],
  });

  /// Toplam yıldız sayısı (10 XP = 1 yıldız).
  int get totalStars => totalXP ~/ 10;

  /// Bu haftaki aktif gün sayısı.
  int get activeDaysThisWeek => weeklyDays.where((d) => d).length;

  /// Haftalık hedef tamamlandı mı? (4/7 gün).
  bool get weeklyGoalMet => activeDaysThisWeek >= 4;

  /// Haftalık ilerleme yüzdesi.
  double get weeklyProgress => (activeDaysThisWeek / 4).clamp(0.0, 1.0);

  /// Her gün için emoji.
  List<String> get weeklyEmojis => weeklyDays
      .map((active) => active ? '😊' : '😴')
      .toList();

  ChildGamificationState copyWith({
    int? totalXP,
    int? completedLessons,
    int? wordsLearned,
    List<bool>? weeklyDays,
  }) => ChildGamificationState(
    totalXP: totalXP ?? this.totalXP,
    completedLessons: completedLessons ?? this.completedLessons,
    wordsLearned: wordsLearned ?? this.wordsLearned,
    weeklyDays: weeklyDays ?? this.weeklyDays,
  );
}

/// Çocuk çıkartma türleri.
enum StickerCategory {
  animal(emoji: '🐱', labelKu: 'Heywanan', labelTr: 'Hayvanlar'),
  nature(emoji: '🌿', labelKu: 'Xwezayê', labelTr: 'Doğa'),
  food(emoji: '🍎', labelKu: 'Xwarinê', labelTr: 'Yiyecek'),
  star(emoji: '⭐', labelKu: 'Stêrkan', labelTr: 'Yıldızlar'),
  culture(emoji: '🎵', labelKu: 'Çandê', labelTr: 'Kültür');

  final String emoji;
  final String labelKu;
  final String labelTr;

  const StickerCategory({
    required this.emoji,
    required this.labelKu,
    required this.labelTr,
  });
}

/// Tek bir çıkartma.
class Sticker {
  final String id;
  final String emoji;
  final String nameKu;
  final String nameTr;
  final StickerCategory category;
  final bool isEarned;

  const Sticker({
    required this.id,
    required this.emoji,
    required this.nameKu,
    required this.nameTr,
    required this.category,
    this.isEarned = false,
  });
}

/// Başlangıç çıkartma koleksiyonu.
const kChildStickers = [
  Sticker(id: 'sticker_silav', emoji: '👋', nameKu: 'Silav!', nameTr: 'Merhaba!', category: StickerCategory.star),
  Sticker(id: 'sticker_malbat', emoji: '👨‍👩‍👧‍👦', nameKu: 'Malbat', nameTr: 'Aile', category: StickerCategory.culture),
  Sticker(id: 'sticker_pisik', emoji: '🐱', nameKu: 'Pisîk', nameTr: 'Kedi', category: StickerCategory.animal),
  Sticker(id: 'sticker_seg', emoji: '🐕', nameKu: 'Seg', nameTr: 'Köpek', category: StickerCategory.animal),
  Sticker(id: 'sticker_sev', emoji: '🍎', nameKu: 'Sêv', nameTr: 'Elma', category: StickerCategory.food),
  Sticker(id: 'sticker_reng', emoji: '🎨', nameKu: 'Reng', nameTr: 'Renk', category: StickerCategory.nature),
  Sticker(id: 'sticker_sterk', emoji: '⭐', nameKu: 'Stêrk', nameTr: 'Yıldız', category: StickerCategory.star),
  Sticker(id: 'sticker_newroz', emoji: '🔥', nameKu: 'Newroz', nameTr: 'Nevruz', category: StickerCategory.culture),
];
