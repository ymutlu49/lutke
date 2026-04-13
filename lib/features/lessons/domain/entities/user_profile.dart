import 'vocabulary_card.dart';

// ════════════════════════════════════════════════════════════════
// KULLANICI PROFİLİ — Birleştirilmiş Tek Kaynak
//
// Daha önce 3 yerde tanımlıydı:
//   1. core/utils/user_segment.dart  (UserProfile)
//   2. core/services/auth_service.dart (UserProfile — farklı alanlar)
//   3. core/services/sync_service.dart (kısmi)
//
// Şimdi tek bir immutable entity.
//
// İlke §1: Üç kullanıcı segmenti
// İlke §3.1: Heritage vs yabancı dil öğrenicisi ayrımı
// ════════════════════════════════════════════════════════════════

/// Kullanıcı segmenti — pedagojik yol seçimi belirler.
enum UserSegment {
  absoluteBeginner(labelTr: 'Yeni Başlayan', labelKu: 'Destpêker'),
  heritageBeginner(labelTr: 'Miras Başlangıç', labelKu: 'Mêvanê Destpêk'),
  heritageIntermediate(labelTr: 'Miras Orta', labelKu: 'Mêvanê Navîn'),
  intermediate(labelTr: 'Orta Seviye', labelKu: 'Navîn'),
  advanced(labelTr: 'İleri Seviye', labelKu: 'Pêşketî');

  final String labelTr;
  final String labelKu;

  const UserSegment({required this.labelTr, required this.labelKu});

  bool get isHeritage =>
      this == heritageBeginner || this == heritageIntermediate;

  int get suggestedDailyGoal => switch (this) {
    absoluteBeginner => 10,
    heritageBeginner => 15,
    heritageIntermediate => 20,
    intermediate => 20,
    advanced => 30,
  };
}

/// Kullanıcı motivasyonu — bildirim personalizasyonu için.
enum UserMotivation {
  general(labelTr: 'Genel İlgi', labelKu: 'Balkişandina Giştî'),
  heritage(labelTr: 'Aile / Kültürel Bağ', labelKu: 'Malbat / Çanda Kurdî'),
  professional(labelTr: 'İş / Kariyer', labelKu: 'Kar / Pîşe'),
  academic(labelTr: 'Akademik', labelKu: 'Akademîk'),
  travel(labelTr: 'Gezi', labelKu: 'Gerîn'),
  activism(labelTr: 'Kültürel Aktivizm', labelKu: 'Çalakîya Çandî');

  final String labelTr;
  final String labelKu;

  const UserMotivation({required this.labelTr, required this.labelKu});
}

/// Birleşik kullanıcı profili — hem auth hem local DB hem Firestore.
class UserProfile {
  final String userId;
  final String displayName;
  final String email;
  final CEFRLevel currentLevel;
  final CEFRLevel targetLevel;
  final bool isHeritage;
  final int dailyGoalCards;
  final int streakDays;
  final int totalXP;
  final DateTime? lastActivity;
  final Map<String, bool> completedLessons;
  final UserMotivation motivation;
  final String? motivationAnchor; // "Fatma" gibi isim (İlke §2.1)
  final String interfaceLanguage; // 'ku', 'tr', 'en'
  final bool dyslexiaMode;
  final bool animationsEnabled;

  // ── Lûtke Zarok (Çocuk Modu) ──────────────────────────────
  final bool isChildMode;
  final int? childAge; // 7-10
  final String? parentPin; // SHA-256 hash, 4 haneli PIN
  final int dailyTimeLimitMinutes; // Ebeveyn kontrol: günlük süre limiti

  const UserProfile({
    required this.userId,
    this.displayName = '',
    this.email = '',
    this.currentLevel = CEFRLevel.a1,
    this.targetLevel = CEFRLevel.b2,
    this.isHeritage = false,
    this.dailyGoalCards = 20,
    this.streakDays = 0,
    this.totalXP = 0,
    this.lastActivity,
    this.completedLessons = const {},
    this.motivation = UserMotivation.general,
    this.motivationAnchor,
    this.interfaceLanguage = 'tr',
    this.dyslexiaMode = false,
    this.animationsEnabled = true,
    this.isChildMode = false,
    this.childAge,
    this.parentPin,
    this.dailyTimeLimitMinutes = 30,
  });

  // ── Hesaplanmış Özellikler ────────────────────────────────

  UserSegment get segment {
    if (isHeritage) {
      return currentLevel.number <= 2
          ? UserSegment.heritageBeginner
          : UserSegment.heritageIntermediate;
    }
    return switch (currentLevel.number) {
      1 || 2 => UserSegment.absoluteBeginner,
      3 || 4 => UserSegment.intermediate,
      _ => UserSegment.advanced,
    };
  }

  bool get hasReachedTarget => currentLevel.number >= targetLevel.number;

  bool isDailyGoalMet(int reviewedToday) => reviewedToday >= dailyGoalCards;

  /// XP'ye göre seviye hesabı (her 500 XP = 1 seviye).
  int get xpLevel => (totalXP / 500).floor() + 1;

  // ── Kopyalama ─────────────────────────────────────────────

  UserProfile copyWith({
    String? userId,
    String? displayName,
    String? email,
    CEFRLevel? currentLevel,
    CEFRLevel? targetLevel,
    bool? isHeritage,
    int? dailyGoalCards,
    int? streakDays,
    int? totalXP,
    DateTime? lastActivity,
    Map<String, bool>? completedLessons,
    UserMotivation? motivation,
    String? motivationAnchor,
    String? interfaceLanguage,
    bool? dyslexiaMode,
    bool? animationsEnabled,
    bool? isChildMode,
    int? childAge,
    String? parentPin,
    int? dailyTimeLimitMinutes,
  }) => UserProfile(
    userId: userId ?? this.userId,
    displayName: displayName ?? this.displayName,
    email: email ?? this.email,
    currentLevel: currentLevel ?? this.currentLevel,
    targetLevel: targetLevel ?? this.targetLevel,
    isHeritage: isHeritage ?? this.isHeritage,
    dailyGoalCards: dailyGoalCards ?? this.dailyGoalCards,
    streakDays: streakDays ?? this.streakDays,
    totalXP: totalXP ?? this.totalXP,
    lastActivity: lastActivity ?? this.lastActivity,
    completedLessons: completedLessons ?? this.completedLessons,
    motivation: motivation ?? this.motivation,
    motivationAnchor: motivationAnchor ?? this.motivationAnchor,
    interfaceLanguage: interfaceLanguage ?? this.interfaceLanguage,
    dyslexiaMode: dyslexiaMode ?? this.dyslexiaMode,
    animationsEnabled: animationsEnabled ?? this.animationsEnabled,
    isChildMode: isChildMode ?? this.isChildMode,
    childAge: childAge ?? this.childAge,
    parentPin: parentPin ?? this.parentPin,
    dailyTimeLimitMinutes: dailyTimeLimitMinutes ?? this.dailyTimeLimitMinutes,
  );

  // ── Firestore Serialization ───────────────────────────────

  factory UserProfile.fromFirestore(Map<String, dynamic> data) => UserProfile(
    userId: data['userId'] as String? ?? '',
    displayName: data['displayName'] as String? ?? '',
    email: data['email'] as String? ?? '',
    currentLevel: CEFRLevel.fromString(data['currentLevel'] as String? ?? 'a1'),
    targetLevel: CEFRLevel.fromString(data['targetLevel'] as String? ?? 'b2'),
    isHeritage: data['isHeritage'] as bool? ?? false,
    dailyGoalCards: data['dailyGoalCards'] as int? ?? 20,
    streakDays: data['streakDays'] as int? ?? 0,
    totalXP: data['totalXP'] as int? ?? 0,
    motivation: UserMotivation.values.firstWhere(
      (m) => m.name == (data['motivation'] as String? ?? 'general'),
      orElse: () => UserMotivation.general,
    ),
    motivationAnchor: data['motivationAnchor'] as String?,
    interfaceLanguage: data['interfaceLanguage'] as String? ?? 'tr',
    dyslexiaMode: data['dyslexiaMode'] as bool? ?? false,
    animationsEnabled: data['animationsEnabled'] as bool? ?? true,
    isChildMode: data['isChildMode'] as bool? ?? false,
    childAge: data['childAge'] as int?,
    parentPin: data['parentPin'] as String?,
    dailyTimeLimitMinutes: data['dailyTimeLimitMinutes'] as int? ?? 30,
  );

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'displayName': displayName,
    'email': email,
    'currentLevel': currentLevel.label.toLowerCase(),
    'targetLevel': targetLevel.label.toLowerCase(),
    'isHeritage': isHeritage,
    'dailyGoalCards': dailyGoalCards,
    'streakDays': streakDays,
    'totalXP': totalXP,
    'motivation': motivation.name,
    'motivationAnchor': motivationAnchor,
    'interfaceLanguage': interfaceLanguage,
    'dyslexiaMode': dyslexiaMode,
    'animationsEnabled': animationsEnabled,
    'isChildMode': isChildMode,
    'childAge': childAge,
    'parentPin': parentPin,
    'dailyTimeLimitMinutes': dailyTimeLimitMinutes,
  };

  @override
  String toString() => 'UserProfile($userId, ${currentLevel.label}, '
      'isHeritage:$isHeritage, isChild:$isChildMode, streak:$streakDays)';
}
