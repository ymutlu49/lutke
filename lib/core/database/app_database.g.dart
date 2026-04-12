// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
part of 'app_database.dart';

// ════════════════════════════════════════════════════════════════
// Drift tarafından otomatik üretilen kod
// dart run build_runner build --delete-conflicting-outputs
// ════════════════════════════════════════════════════════════════

// ── VocabularyCard DATA CLASS ─────────────────────────────────

class VocabularyCard extends DataClass implements Insertable<VocabularyCard> {
  final String id;
  final String kurmanji;
  final String turkish;
  final String? english;
  final String? audioUrl;
  final String gender;
  final String category;
  final int level;
  final String sentencesHeritage;
  final String sentencesGeneral;
  final double initialDifficulty;

  const VocabularyCard({
    required this.id,
    required this.kurmanji,
    required this.turkish,
    this.english,
    this.audioUrl,
    required this.gender,
    required this.category,
    required this.level,
    required this.sentencesHeritage,
    required this.sentencesGeneral,
    required this.initialDifficulty,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kurmanji'] = Variable<String>(kurmanji);
    map['turkish'] = Variable<String>(turkish);
    if (!nullToAbsent || english != null) map['english'] = Variable<String?>(english);
    if (!nullToAbsent || audioUrl != null) map['audio_url'] = Variable<String?>(audioUrl);
    map['gender'] = Variable<String>(gender);
    map['category'] = Variable<String>(category);
    map['level'] = Variable<int>(level);
    map['sentences_heritage'] = Variable<String>(sentencesHeritage);
    map['sentences_general'] = Variable<String>(sentencesGeneral);
    map['initial_difficulty'] = Variable<double>(initialDifficulty);
    return map;
  }

  VocabularyCardsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyCardsCompanion(
      id: Value(id),
      kurmanji: Value(kurmanji),
      turkish: Value(turkish),
      english: english == null && nullToAbsent ? const Value.absent() : Value(english),
      audioUrl: audioUrl == null && nullToAbsent ? const Value.absent() : Value(audioUrl),
      gender: Value(gender),
      category: Value(category),
      level: Value(level),
      sentencesHeritage: Value(sentencesHeritage),
      sentencesGeneral: Value(sentencesGeneral),
      initialDifficulty: Value(initialDifficulty),
    );
  }

  factory VocabularyCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyCard(
      id: serializer.fromJson<String>(json['id']),
      kurmanji: serializer.fromJson<String>(json['kurmanji']),
      turkish: serializer.fromJson<String>(json['turkish']),
      english: serializer.fromJson<String?>(json['english']),
      audioUrl: serializer.fromJson<String?>(json['audio_url']),
      gender: serializer.fromJson<String>(json['gender']),
      category: serializer.fromJson<String>(json['category']),
      level: serializer.fromJson<int>(json['level']),
      sentencesHeritage: serializer.fromJson<String>(json['sentences_heritage']),
      sentencesGeneral: serializer.fromJson<String>(json['sentences_general']),
      initialDifficulty: serializer.fromJson<double>(json['initial_difficulty']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kurmanji': serializer.toJson<String>(kurmanji),
      'turkish': serializer.toJson<String>(turkish),
      'english': serializer.toJson<String?>(english),
      'audio_url': serializer.toJson<String?>(audioUrl),
      'gender': serializer.toJson<String>(gender),
      'category': serializer.toJson<String>(category),
      'level': serializer.toJson<int>(level),
      'sentences_heritage': serializer.toJson<String>(sentencesHeritage),
      'sentences_general': serializer.toJson<String>(sentencesGeneral),
      'initial_difficulty': serializer.toJson<double>(initialDifficulty),
    };
  }

  VocabularyCard copyWith({
    String? id,
    String? kurmanji,
    String? turkish,
    Value<String?> english = const Value.absent(),
    Value<String?> audioUrl = const Value.absent(),
    String? gender,
    String? category,
    int? level,
    String? sentencesHeritage,
    String? sentencesGeneral,
    double? initialDifficulty,
  }) => VocabularyCard(
    id: id ?? this.id,
    kurmanji: kurmanji ?? this.kurmanji,
    turkish: turkish ?? this.turkish,
    english: english.present ? english.value : this.english,
    audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
    gender: gender ?? this.gender,
    category: category ?? this.category,
    level: level ?? this.level,
    sentencesHeritage: sentencesHeritage ?? this.sentencesHeritage,
    sentencesGeneral: sentencesGeneral ?? this.sentencesGeneral,
    initialDifficulty: initialDifficulty ?? this.initialDifficulty,
  );

  @override
  String toString() {
    return (StringBuffer('VocabularyCard(')
          ..write('id: $id, ')
          ..write('kurmanji: $kurmanji, ')
          ..write('turkish: $turkish')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kurmanji, turkish, gender, category, level);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyCard &&
          other.id == id &&
          other.kurmanji == kurmanji &&
          other.turkish == turkish);
}

// ── VocabularyCardsCompanion ──────────────────────────────────

class VocabularyCardsCompanion extends UpdateCompanion<VocabularyCard> {
  final Value<String> id;
  final Value<String> kurmanji;
  final Value<String> turkish;
  final Value<String?> english;
  final Value<String?> audioUrl;
  final Value<String> gender;
  final Value<String> category;
  final Value<int> level;
  final Value<String> sentencesHeritage;
  final Value<String> sentencesGeneral;
  final Value<double> initialDifficulty;

  const VocabularyCardsCompanion({
    this.id = const Value.absent(),
    this.kurmanji = const Value.absent(),
    this.turkish = const Value.absent(),
    this.english = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.gender = const Value.absent(),
    this.category = const Value.absent(),
    this.level = const Value.absent(),
    this.sentencesHeritage = const Value.absent(),
    this.sentencesGeneral = const Value.absent(),
    this.initialDifficulty = const Value.absent(),
  });

  VocabularyCardsCompanion.insert({
    required String id,
    required String kurmanji,
    required String turkish,
    Value<String?> english = const Value.absent(),
    Value<String?> audioUrl = const Value.absent(),
    Value<String> gender = const Value('bêcins'),
    required String category,
    Value<int> level = const Value(1),
    Value<String> sentencesHeritage = const Value('[]'),
    Value<String> sentencesGeneral = const Value('[]'),
    Value<double> initialDifficulty = const Value(0.75),
  }) : id = Value(id),
       kurmanji = Value(kurmanji),
       turkish = Value(turkish),
       english = english,
       audioUrl = audioUrl,
       gender = gender,
       category = Value(category),
       level = level,
       sentencesHeritage = sentencesHeritage,
       sentencesGeneral = sentencesGeneral,
       initialDifficulty = initialDifficulty;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<String>(id.value);
    if (kurmanji.present) map['kurmanji'] = Variable<String>(kurmanji.value);
    if (turkish.present) map['turkish'] = Variable<String>(turkish.value);
    if (english.present) map['english'] = Variable<String?>(english.value);
    if (audioUrl.present) map['audio_url'] = Variable<String?>(audioUrl.value);
    if (gender.present) map['gender'] = Variable<String>(gender.value);
    if (category.present) map['category'] = Variable<String>(category.value);
    if (level.present) map['level'] = Variable<int>(level.value);
    if (sentencesHeritage.present) map['sentences_heritage'] = Variable<String>(sentencesHeritage.value);
    if (sentencesGeneral.present) map['sentences_general'] = Variable<String>(sentencesGeneral.value);
    if (initialDifficulty.present) map['initial_difficulty'] = Variable<double>(initialDifficulty.value);
    return map;
  }

  @override
  String toString() => 'VocabularyCardsCompanion(id: $id, kurmanji: $kurmanji)';
}

// ── FsrsReview DATA CLASS ─────────────────────────────────────

class FsrsReview extends DataClass implements Insertable<FsrsReview> {
  final int id;
  final String cardId;
  final String userId;
  final double stability;
  final double difficulty;
  final double retrievability;
  final String state;
  final int reviewCount;
  final int lapseCount;
  final bool wasCorrect;
  final DateTime? lastReview;
  final DateTime dueDate;

  const FsrsReview({
    required this.id,
    required this.cardId,
    required this.userId,
    required this.stability,
    required this.difficulty,
    required this.retrievability,
    required this.state,
    required this.reviewCount,
    required this.lapseCount,
    required this.wasCorrect,
    this.lastReview,
    required this.dueDate,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<String>(cardId);
    map['user_id'] = Variable<String>(userId);
    map['stability'] = Variable<double>(stability);
    map['difficulty'] = Variable<double>(difficulty);
    map['retrievability'] = Variable<double>(retrievability);
    map['state'] = Variable<String>(state);
    map['review_count'] = Variable<int>(reviewCount);
    map['lapse_count'] = Variable<int>(lapseCount);
    map['was_correct'] = Variable<bool>(wasCorrect);
    if (!nullToAbsent || lastReview != null) {
      map['last_review'] = Variable<DateTime?>(lastReview);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    return map;
  }

  @override
  FsrsReviewsCompanion toCompanion(bool nullToAbsent) {
    return FsrsReviewsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      userId: Value(userId),
      stability: Value(stability),
      difficulty: Value(difficulty),
      retrievability: Value(retrievability),
      state: Value(state),
      reviewCount: Value(reviewCount),
      lapseCount: Value(lapseCount),
      wasCorrect: Value(wasCorrect),
      lastReview: lastReview == null && nullToAbsent ? const Value.absent() : Value(lastReview),
      dueDate: Value(dueDate),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) => {};

  factory FsrsReview.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) =>
      FsrsReview(
        id: json['id'] as int,
        cardId: json['card_id'] as String,
        userId: json['user_id'] as String,
        stability: (json['stability'] as num).toDouble(),
        difficulty: (json['difficulty'] as num).toDouble(),
        retrievability: (json['retrievability'] as num).toDouble(),
        state: json['state'] as String,
        reviewCount: json['review_count'] as int,
        lapseCount: json['lapse_count'] as int,
        wasCorrect: json['was_correct'] as bool,
        lastReview: json['last_review'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['last_review'] as int)
            : null,
        dueDate: DateTime.fromMillisecondsSinceEpoch(json['due_date'] as int),
      );

  @override
  int get hashCode => id;
  @override
  bool operator ==(Object other) => other is FsrsReview && other.id == id;
}

class FsrsReviewsCompanion extends UpdateCompanion<FsrsReview> {
  final Value<int> id;
  final Value<String> cardId;
  final Value<String> userId;
  final Value<double> stability;
  final Value<double> difficulty;
  final Value<double> retrievability;
  final Value<String> state;
  final Value<int> reviewCount;
  final Value<int> lapseCount;
  final Value<bool> wasCorrect;
  final Value<DateTime?> lastReview;
  final Value<DateTime> dueDate;

  const FsrsReviewsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.userId = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.retrievability = const Value.absent(),
    this.state = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lapseCount = const Value.absent(),
    this.wasCorrect = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.dueDate = const Value.absent(),
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (cardId.present) map['card_id'] = Variable<String>(cardId.value);
    if (userId.present) map['user_id'] = Variable<String>(userId.value);
    if (stability.present) map['stability'] = Variable<double>(stability.value);
    if (difficulty.present) map['difficulty'] = Variable<double>(difficulty.value);
    if (retrievability.present) map['retrievability'] = Variable<double>(retrievability.value);
    if (state.present) map['state'] = Variable<String>(state.value);
    if (reviewCount.present) map['review_count'] = Variable<int>(reviewCount.value);
    if (lapseCount.present) map['lapse_count'] = Variable<int>(lapseCount.value);
    if (wasCorrect.present) map['was_correct'] = Variable<bool>(wasCorrect.value);
    if (lastReview.present) map['last_review'] = Variable<DateTime?>(lastReview.value);
    if (dueDate.present) map['due_date'] = Variable<DateTime>(dueDate.value);
    return map;
  }

  @override
  String toString() => 'FsrsReviewsCompanion(cardId: $cardId, state: $state)';
}

// ── EarnedBadge DATA CLASS ────────────────────────────────────

class EarnedBadge extends DataClass implements Insertable<EarnedBadge> {
  final int id;
  final String userId;
  final String badgeId;
  final DateTime earnedAt;

  const EarnedBadge({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.earnedAt,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) => {
    'id': Variable<int>(id),
    'user_id': Variable<String>(userId),
    'badge_id': Variable<String>(badgeId),
    'earned_at': Variable<DateTime>(earnedAt),
  };

  EarnedBadgesCompanion toCompanion(bool nullToAbsent) => EarnedBadgesCompanion(
    id: Value(id),
    userId: Value(userId),
    badgeId: Value(badgeId),
    earnedAt: Value(earnedAt),
  );

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) => {};
  factory EarnedBadge.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) =>
      EarnedBadge(
        id: json['id'] as int,
        userId: json['user_id'] as String,
        badgeId: json['badge_id'] as String,
        earnedAt: DateTime.fromMillisecondsSinceEpoch(json['earned_at'] as int),
      );

  @override
  int get hashCode => id;
  @override
  bool operator ==(Object other) => other is EarnedBadge && other.id == id;
}

class EarnedBadgesCompanion extends UpdateCompanion<EarnedBadge> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> badgeId;
  final Value<DateTime> earnedAt;

  const EarnedBadgesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.badgeId = const Value.absent(),
    this.earnedAt = const Value.absent(),
  });

  EarnedBadgesCompanion.insert({
    required String userId,
    required String badgeId,
    required DateTime earnedAt,
  })  : id = const Value.absent(),
        userId = Value(userId),
        badgeId = Value(badgeId),
        earnedAt = Value(earnedAt);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (userId.present) map['user_id'] = Variable<String>(userId.value);
    if (badgeId.present) map['badge_id'] = Variable<String>(badgeId.value);
    if (earnedAt.present) map['earned_at'] = Variable<DateTime>(earnedAt.value);
    return map;
  }

  @override
  String toString() => 'EarnedBadgesCompanion(userId: $userId, badgeId: $badgeId)';
}

// ── UserProfile DATA CLASS ────────────────────────────────────

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final String userId;
  final String displayName;
  final String segment;
  final String currentLevel;
  final String interfaceLanguage;
  final int dailyGoalCards;
  final int streakDays;
  final int totalXp;
  final bool dyslexiaMode;
  final bool animationsEnabled;
  final bool isHeritage;

  const UserProfileData({
    required this.userId,
    required this.displayName,
    required this.segment,
    required this.currentLevel,
    required this.interfaceLanguage,
    required this.dailyGoalCards,
    required this.streakDays,
    required this.totalXp,
    required this.dyslexiaMode,
    required this.animationsEnabled,
    required this.isHeritage,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) => {
    'user_id': Variable<String>(userId),
    'display_name': Variable<String>(displayName),
    'segment': Variable<String>(segment),
    'current_level': Variable<String>(currentLevel),
    'interface_language': Variable<String>(interfaceLanguage),
    'daily_goal_cards': Variable<int>(dailyGoalCards),
    'streak_days': Variable<int>(streakDays),
    'total_xp': Variable<int>(totalXp),
    'dyslexia_mode': Variable<bool>(dyslexiaMode),
    'animations_enabled': Variable<bool>(animationsEnabled),
    'is_heritage': Variable<bool>(isHeritage),
  };

  @override
  UserProfilesCompanion toCompanion(bool nullToAbsent) => UserProfilesCompanion(
    userId: Value(userId),
    displayName: Value(displayName),
    segment: Value(segment),
    currentLevel: Value(currentLevel),
    interfaceLanguage: Value(interfaceLanguage),
    dailyGoalCards: Value(dailyGoalCards),
    streakDays: Value(streakDays),
    totalXp: Value(totalXp),
    dyslexiaMode: Value(dyslexiaMode),
    animationsEnabled: Value(animationsEnabled),
    isHeritage: Value(isHeritage),
  );

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) => {};
  factory UserProfileData.fromJson(Map<String, dynamic> j, {ValueSerializer? s}) =>
      UserProfileData(
        userId: j['user_id'] as String,
        displayName: j['display_name'] as String? ?? '',
        segment: j['segment'] as String? ?? 'absoluteBeginner',
        currentLevel: j['current_level'] as String? ?? 'a1',
        interfaceLanguage: j['interface_language'] as String? ?? 'tr',
        dailyGoalCards: j['daily_goal_cards'] as int? ?? 20,
        streakDays: j['streak_days'] as int? ?? 0,
        totalXp: j['total_xp'] as int? ?? 0,
        dyslexiaMode: j['dyslexia_mode'] as bool? ?? false,
        animationsEnabled: j['animations_enabled'] as bool? ?? true,
        isHeritage: j['is_heritage'] as bool? ?? false,
      );

  @override
  int get hashCode => userId.hashCode;
  @override
  bool operator ==(Object other) => other is UserProfileData && other.userId == userId;
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileData> {
  final Value<String> userId;
  final Value<String> displayName;
  final Value<String> segment;
  final Value<String> currentLevel;
  final Value<String> interfaceLanguage;
  final Value<int> dailyGoalCards;
  final Value<int> streakDays;
  final Value<int> totalXp;
  final Value<bool> dyslexiaMode;
  final Value<bool> animationsEnabled;
  final Value<bool> isHeritage;

  const UserProfilesCompanion({
    this.userId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.segment = const Value.absent(),
    this.currentLevel = const Value.absent(),
    this.interfaceLanguage = const Value.absent(),
    this.dailyGoalCards = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.dyslexiaMode = const Value.absent(),
    this.animationsEnabled = const Value.absent(),
    this.isHeritage = const Value.absent(),
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) map['user_id'] = Variable<String>(userId.value);
    if (displayName.present) map['display_name'] = Variable<String>(displayName.value);
    if (segment.present) map['segment'] = Variable<String>(segment.value);
    if (currentLevel.present) map['current_level'] = Variable<String>(currentLevel.value);
    if (interfaceLanguage.present) map['interface_language'] = Variable<String>(interfaceLanguage.value);
    if (dailyGoalCards.present) map['daily_goal_cards'] = Variable<int>(dailyGoalCards.value);
    if (streakDays.present) map['streak_days'] = Variable<int>(streakDays.value);
    if (totalXp.present) map['total_xp'] = Variable<int>(totalXp.value);
    if (dyslexiaMode.present) map['dyslexia_mode'] = Variable<bool>(dyslexiaMode.value);
    if (animationsEnabled.present) map['animations_enabled'] = Variable<bool>(animationsEnabled.value);
    if (isHeritage.present) map['is_heritage'] = Variable<bool>(isHeritage.value);
    return map;
  }

  @override
  String toString() => 'UserProfilesCompanion(userId: $userId)';
}

// ── AppDatabase MIXIN ─────────────────────────────────────────

mixin _$AppDatabase on GeneratedDatabase {
  $VocabularyCardsTable get vocabularyCards =>
      LazyDatabase(() async => $VocabularyCardsTable(attachedDatabase))
          as $VocabularyCardsTable;
  $FsrsReviewsTable get fsrsReviews =>
      LazyDatabase(() async => $FsrsReviewsTable(attachedDatabase))
          as $FsrsReviewsTable;
  $CompletedLessonsTable get completedLessons =>
      LazyDatabase(() async => $CompletedLessonsTable(attachedDatabase))
          as $CompletedLessonsTable;
  $UserProfilesTable get userProfiles =>
      LazyDatabase(() async => $UserProfilesTable(attachedDatabase))
          as $UserProfilesTable;
  $EarnedBadgesTable get earnedBadges =>
      LazyDatabase(() async => $EarnedBadgesTable(attachedDatabase))
          as $EarnedBadgesTable;
}

// ── Tablo Sınıfları ───────────────────────────────────────────

class $VocabularyCardsTable extends VocabularyCards
    with TableInfo<$VocabularyCardsTable, VocabularyCard> {
  final GeneratedDatabase attachedDatabase;
  $VocabularyCardsTable(this.attachedDatabase);

  @override
  List<GeneratedColumn> get $columns => [
        GeneratedColumn<String>('id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('kurmanji', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('turkish', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String?>('english', aliasedName, true,
            type: DriftSqlType.string),
        GeneratedColumn<String?>('audio_url', aliasedName, true,
            type: DriftSqlType.string),
        GeneratedColumn<String>('gender', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('bêcins')),
        GeneratedColumn<String>('category', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<int>('level', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(1)),
        GeneratedColumn<String>('sentences_heritage', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('[]')),
        GeneratedColumn<String>('sentences_general', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('[]')),
        GeneratedColumn<double>('initial_difficulty', aliasedName, false,
            type: DriftSqlType.double, defaultValue: const Constant(0.75)),
      ];

  @override
  String get aliasedName => _alias ?? 'vocabulary_cards';
  @override
  String get actualTableName => 'vocabulary_cards';
  String? _alias;

  @override
  $VocabularyCardsTable createAlias(String alias) {
    return $VocabularyCardsTable(attachedDatabase).._alias = alias;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {$columns[0]};

  @override
  VocabularyCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final p = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyCard(
      id: data['${p}id'] as String,
      kurmanji: data['${p}kurmanji'] as String,
      turkish: data['${p}turkish'] as String,
      english: data['${p}english'] as String?,
      audioUrl: data['${p}audio_url'] as String?,
      gender: data['${p}gender'] as String? ?? 'bêcins',
      category: data['${p}category'] as String,
      level: data['${p}level'] as int? ?? 1,
      sentencesHeritage: data['${p}sentences_heritage'] as String? ?? '[]',
      sentencesGeneral: data['${p}sentences_general'] as String? ?? '[]',
      initialDifficulty: (data['${p}initial_difficulty'] as num?)?.toDouble() ?? 0.75,
    );
  }
}

class $FsrsReviewsTable extends FsrsReviews
    with TableInfo<$FsrsReviewsTable, FsrsReview> {
  final GeneratedDatabase attachedDatabase;
  $FsrsReviewsTable(this.attachedDatabase);

  @override
  List<GeneratedColumn> get $columns => [
        GeneratedColumn<int>('id', aliasedName, false,
            hasAutoIncrement: true, type: DriftSqlType.int),
        GeneratedColumn<String>('card_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('user_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<double>('stability', aliasedName, false,
            type: DriftSqlType.double, defaultValue: const Constant(1.0)),
        GeneratedColumn<double>('difficulty', aliasedName, false,
            type: DriftSqlType.double, defaultValue: const Constant(5.0)),
        GeneratedColumn<double>('retrievability', aliasedName, false,
            type: DriftSqlType.double, defaultValue: const Constant(0.9)),
        GeneratedColumn<String>('state', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('new')),
        GeneratedColumn<int>('review_count', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<int>('lapse_count', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<bool>('was_correct', aliasedName, false,
            type: DriftSqlType.bool, defaultValue: const Constant(true)),
        GeneratedColumn<DateTime?>('last_review', aliasedName, true,
            type: DriftSqlType.dateTime),
        GeneratedColumn<DateTime>('due_date', aliasedName, false,
            type: DriftSqlType.dateTime),
      ];

  @override
  String get aliasedName => _alias ?? 'fsrs_reviews';
  @override
  String get actualTableName => 'fsrs_reviews';
  String? _alias;

  @override
  $FsrsReviewsTable createAlias(String alias) =>
      $FsrsReviewsTable(attachedDatabase).._alias = alias;

  @override
  Set<GeneratedColumn> get $primaryKey => {$columns[0]};

  @override
  FsrsReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final p = tablePrefix != null ? '$tablePrefix.' : '';
    return FsrsReview(
      id: data['${p}id'] as int,
      cardId: data['${p}card_id'] as String,
      userId: data['${p}user_id'] as String,
      stability: (data['${p}stability'] as num?)?.toDouble() ?? 1.0,
      difficulty: (data['${p}difficulty'] as num?)?.toDouble() ?? 5.0,
      retrievability: (data['${p}retrievability'] as num?)?.toDouble() ?? 0.9,
      state: data['${p}state'] as String? ?? 'new',
      reviewCount: data['${p}review_count'] as int? ?? 0,
      lapseCount: data['${p}lapse_count'] as int? ?? 0,
      wasCorrect: data['${p}was_correct'] as bool? ?? true,
      lastReview: data['${p}last_review'] as DateTime?,
      dueDate: data['${p}due_date'] as DateTime? ?? DateTime.now(),
    );
  }
}

class $CompletedLessonsTable extends CompletedLessons
    with TableInfo<$CompletedLessonsTable, CompletedLessonData> {
  final GeneratedDatabase attachedDatabase;
  $CompletedLessonsTable(this.attachedDatabase);

  @override
  List<GeneratedColumn> get $columns => [
        GeneratedColumn<int>('id', aliasedName, false,
            hasAutoIncrement: true, type: DriftSqlType.int),
        GeneratedColumn<String>('user_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('lesson_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<DateTime>('completed_at', aliasedName, false,
            type: DriftSqlType.dateTime),
        GeneratedColumn<int>('correct_count', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<int>('total_count', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<int>('xp_earned', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<int>('duration_seconds', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
      ];

  @override
  String get aliasedName => _alias ?? 'completed_lessons';
  @override
  String get actualTableName => 'completed_lessons';
  String? _alias;

  @override
  $CompletedLessonsTable createAlias(String alias) =>
      $CompletedLessonsTable(attachedDatabase).._alias = alias;

  @override
  Set<GeneratedColumn> get $primaryKey => {$columns[0]};

  @override
  CompletedLessonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final p = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedLessonData(
      id: data['${p}id'] as int,
      userId: data['${p}user_id'] as String,
      lessonId: data['${p}lesson_id'] as String,
      completedAt: data['${p}completed_at'] as DateTime? ?? DateTime.now(),
      correctCount: data['${p}correct_count'] as int? ?? 0,
      totalCount: data['${p}total_count'] as int? ?? 0,
      xpEarned: data['${p}xp_earned'] as int? ?? 0,
      durationSeconds: data['${p}duration_seconds'] as int? ?? 0,
    );
  }
}

class CompletedLessonData extends DataClass
    implements Insertable<CompletedLessonData> {
  final int id;
  final String userId;
  final String lessonId;
  final DateTime completedAt;
  final int correctCount;
  final int totalCount;
  final int xpEarned;
  final int durationSeconds;

  const CompletedLessonData({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.completedAt,
    required this.correctCount,
    required this.totalCount,
    required this.xpEarned,
    required this.durationSeconds,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) => {};
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) => {};
  factory CompletedLessonData.fromJson(Map<String, dynamic> j, {ValueSerializer? s}) =>
      CompletedLessonData(
        id: j['id'] as int,
        userId: j['user_id'] as String,
        lessonId: j['lesson_id'] as String,
        completedAt: DateTime.fromMillisecondsSinceEpoch(j['completed_at'] as int),
        correctCount: j['correct_count'] as int? ?? 0,
        totalCount: j['total_count'] as int? ?? 0,
        xpEarned: j['xp_earned'] as int? ?? 0,
        durationSeconds: j['duration_seconds'] as int? ?? 0,
      );

  @override
  int get hashCode => id;
  @override
  bool operator ==(Object other) => other is CompletedLessonData && other.id == id;
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileData> {
  final GeneratedDatabase attachedDatabase;
  $UserProfilesTable(this.attachedDatabase);

  @override
  List<GeneratedColumn> get $columns => [
        GeneratedColumn<String>('user_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('display_name', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('')),
        GeneratedColumn<String>('segment', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('current_level', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('a1')),
        GeneratedColumn<String>('interface_language', aliasedName, false,
            type: DriftSqlType.string, defaultValue: const Constant('tr')),
        GeneratedColumn<int>('daily_goal_cards', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(20)),
        GeneratedColumn<int>('streak_days', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<int>('total_xp', aliasedName, false,
            type: DriftSqlType.int, defaultValue: const Constant(0)),
        GeneratedColumn<bool>('dyslexia_mode', aliasedName, false,
            type: DriftSqlType.bool, defaultValue: const Constant(false)),
        GeneratedColumn<bool>('animations_enabled', aliasedName, false,
            type: DriftSqlType.bool, defaultValue: const Constant(true)),
        GeneratedColumn<bool>('is_heritage', aliasedName, false,
            type: DriftSqlType.bool, defaultValue: const Constant(false)),
      ];

  @override
  String get aliasedName => _alias ?? 'user_profiles';
  @override
  String get actualTableName => 'user_profiles';
  String? _alias;

  @override
  $UserProfilesTable createAlias(String alias) =>
      $UserProfilesTable(attachedDatabase).._alias = alias;

  @override
  Set<GeneratedColumn> get $primaryKey => {$columns[0]};

  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final p = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      userId: data['${p}user_id'] as String,
      displayName: data['${p}display_name'] as String? ?? '',
      segment: data['${p}segment'] as String? ?? 'absoluteBeginner',
      currentLevel: data['${p}current_level'] as String? ?? 'a1',
      interfaceLanguage: data['${p}interface_language'] as String? ?? 'tr',
      dailyGoalCards: data['${p}daily_goal_cards'] as int? ?? 20,
      streakDays: data['${p}streak_days'] as int? ?? 0,
      totalXp: data['${p}total_xp'] as int? ?? 0,
      dyslexiaMode: data['${p}dyslexia_mode'] as bool? ?? false,
      animationsEnabled: data['${p}animations_enabled'] as bool? ?? true,
      isHeritage: data['${p}is_heritage'] as bool? ?? false,
    );
  }
}

class $EarnedBadgesTable extends EarnedBadges
    with TableInfo<$EarnedBadgesTable, EarnedBadge> {
  final GeneratedDatabase attachedDatabase;
  $EarnedBadgesTable(this.attachedDatabase);

  @override
  List<GeneratedColumn> get $columns => [
        GeneratedColumn<int>('id', aliasedName, false,
            hasAutoIncrement: true, type: DriftSqlType.int),
        GeneratedColumn<String>('user_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<String>('badge_id', aliasedName, false,
            type: DriftSqlType.string),
        GeneratedColumn<DateTime>('earned_at', aliasedName, false,
            type: DriftSqlType.dateTime),
      ];

  @override
  String get aliasedName => _alias ?? 'earned_badges';
  @override
  String get actualTableName => 'earned_badges';
  String? _alias;

  @override
  $EarnedBadgesTable createAlias(String alias) =>
      $EarnedBadgesTable(attachedDatabase).._alias = alias;

  @override
  Set<GeneratedColumn> get $primaryKey => {$columns[0]};

  @override
  EarnedBadge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final p = tablePrefix != null ? '$tablePrefix.' : '';
    return EarnedBadge(
      id: data['${p}id'] as int,
      userId: data['${p}user_id'] as String,
      badgeId: data['${p}badge_id'] as String,
      earnedAt: data['${p}earned_at'] as DateTime? ?? DateTime.now(),
    );
  }
}
