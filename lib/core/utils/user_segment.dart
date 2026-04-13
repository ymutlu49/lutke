// ════════════════════════════════════════════════════════════════
// USER SEGMENT — LÛTKE
// Kullanıcı profili + segmentasyon mantığı
// ════════════════════════════════════════════════════════════════

class UserProfile {
  final String userId;
  final String displayName;
  final String email;
  final String currentLevel;   // 'a1' | 'a2' | 'b1' | 'b2' | 'c1' | 'c2'
  final String targetLevel;
  final bool isHeritage;       // Miras konuşmacı mı?
  final int dailyGoal;         // Günlük kart hedefi
  final int streakDays;
  final int totalXP;
  final DateTime? lastActivity;
  final Map<String, bool> completedLessons;
  final UserMotivation motivation;

  const UserProfile({
    required this.userId,
    this.displayName = '',
    this.email = '',
    required this.currentLevel,
    required this.targetLevel,
    required this.isHeritage,
    required this.dailyGoal,
    this.streakDays = 0,
    this.totalXP = 0,
    this.lastActivity,
    this.completedLessons = const {},
    this.motivation = UserMotivation.general,
  });

  // ── SEGMENTASYON ─────────────────────────────────────────

  UserSegment get segment {
    if (isHeritage) {
      return currentLevelNum <= 2
          ? UserSegment.heritageBeginner
          : UserSegment.heritageIntermediate;
    }
    return switch (currentLevelNum) {
      1 || 2 => UserSegment.absoluteBeginner,
      3 || 4 => UserSegment.intermediate,
      _ => UserSegment.advanced,
    };
  }

  int get currentLevelNum => switch (currentLevel) {
    'a1' => 1, 'a2' => 2, 'b1' => 3,
    'b2' => 4, 'c1' => 5, 'c2' => 6,
    _ => 1,
  };

  int get targetLevelNum => switch (targetLevel) {
    'a1' => 1, 'a2' => 2, 'b1' => 3,
    'b2' => 4, 'c1' => 5, 'c2' => 6,
    _ => 3,
  };

  bool get hasReachedTarget => currentLevelNum >= targetLevelNum;

  /// Günlük hedef tamamlandı mı?
  bool isDailyGoalMet(int reviewedToday) => reviewedToday >= dailyGoal;

  // ── KOPYA ────────────────────────────────────────────────

  UserProfile copyWith({
    String? userId,
    String? displayName,
    String? email,
    String? currentLevel,
    String? targetLevel,
    bool? isHeritage,
    int? dailyGoal,
    int? streakDays,
    int? totalXP,
    DateTime? lastActivity,
    Map<String, bool>? completedLessons,
    UserMotivation? motivation,
  }) => UserProfile(
    userId: userId ?? this.userId,
    displayName: displayName ?? this.displayName,
    email: email ?? this.email,
    currentLevel: currentLevel ?? this.currentLevel,
    targetLevel: targetLevel ?? this.targetLevel,
    isHeritage: isHeritage ?? this.isHeritage,
    dailyGoal: dailyGoal ?? this.dailyGoal,
    streakDays: streakDays ?? this.streakDays,
    totalXP: totalXP ?? this.totalXP,
    lastActivity: lastActivity ?? this.lastActivity,
    completedLessons: completedLessons ?? this.completedLessons,
    motivation: motivation ?? this.motivation,
  );

  // ── FİRESTORE ────────────────────────────────────────────

  factory UserProfile.fromFirestore(Map<String, dynamic> data) => UserProfile(
    userId: data['userId'] ?? '',
    displayName: data['displayName'] ?? '',
    email: data['email'] ?? '',
    currentLevel: data['currentLevel'] ?? 'a1',
    targetLevel: data['targetLevel'] ?? 'b1',
    isHeritage: data['isHeritage'] ?? false,
    dailyGoal: data['dailyGoal'] ?? 20,
    streakDays: data['streakDays'] ?? 0,
    totalXP: data['totalXP'] ?? 0,
    motivation: UserMotivation.values.firstWhere(
      (m) => m.name == (data['motivation'] ?? 'general'),
      orElse: () => UserMotivation.general,
    ),
  );

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'displayName': displayName,
    'email': email,
    'currentLevel': currentLevel,
    'targetLevel': targetLevel,
    'isHeritage': isHeritage,
    'dailyGoal': dailyGoal,
    'streakDays': streakDays,
    'totalXP': totalXP,
    'motivation': motivation.name,
  };

  @override
  String toString() => 'UserProfile($userId, $currentLevel, '
      'isHeritage:$isHeritage, streak:$streakDays)';
}

// ════════════════════════════════════════════════════════════════
// ENUM'LAR
// ════════════════════════════════════════════════════════════════

enum UserSegment {
  absoluteBeginner,       // A1-A2, yeni başlayan
  heritageBeginner,       // A1-A2, miras konuşmacı (çocukluktan bilgi)
  heritageIntermediate,   // B1+, miras + formal öğrenim
  intermediate,           // B1-B2, standart öğrenci
  advanced,               // C1-C2, ileri seviye
}

enum UserMotivation {
  general,        // Genel ilgi
  heritage,       // Aile/kültür bağlantısı
  professional,   // İş/kariyer
  academic,       // Akademik araştırma
  travel,         // Gezi/turizm
  activism,       // Kültürel aktivizm
}

extension UserMotivationExt on UserMotivation {
  String get labelTr => switch (this) {
    UserMotivation.general => 'Balkişandina Giştî',
    UserMotivation.heritage => 'Malbat / Çanda Kurdî',
    UserMotivation.professional => 'Kar / Pîşe',
    UserMotivation.academic => 'Akademîk',
    UserMotivation.travel => 'Gerîn',
    UserMotivation.activism => 'Çalakîya Çandî',
  };

  String get labelKu => switch (this) {
    UserMotivation.general => 'Balkişandina Giştî',
    UserMotivation.heritage => 'Malbat / Çanda Kurdî',
    UserMotivation.professional => 'Kar / Pîşe',
    UserMotivation.academic => 'Akademîk',
    UserMotivation.travel => 'Gerîn',
    UserMotivation.activism => 'Çalakîya Çandî',
  };
}

extension UserSegmentExt on UserSegment {
  /// Segmente göre günlük hedef önerisi
  int get suggestedDailyGoal => switch (this) {
    UserSegment.absoluteBeginner => 10,
    UserSegment.heritageBeginner => 15,
    UserSegment.heritageIntermediate => 20,
    UserSegment.intermediate => 20,
    UserSegment.advanced => 30,
  };

  /// Heritage modunu kullan mı?
  bool get useHeritageMode => this == UserSegment.heritageBeginner ||
      this == UserSegment.heritageIntermediate;
}
