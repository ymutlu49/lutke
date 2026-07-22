/// LÛTKE — Friends Quest (Duolingo tarzı ortak hedef)
///
/// İki kullanıcının 5 günlük ortak XP hedefi. Araştırma: arkadaşlı
/// kullanıcılar 5.6× daha çok kurs bitirir (Duolingo 2025 data).
///
/// Firebase Firestore: `friends_quests` collection.
/// Feature flag: `AppConfig.enableFriendsQuest`.
/// Çocuk modunda kapalı (COPPA — 1-on-1 sosyal yasak).

enum QuestStatus { pending, active, completed, expired }

class FriendsQuest {
  final String id;
  final String partnerAUid;
  final String partnerAName;
  final String partnerBUid;
  final String partnerBName;
  final int targetXp;           // Ortak XP hedefi (örn. 500)
  final int partnerAXp;
  final int partnerBXp;
  final DateTime startDate;
  final DateTime endDate;       // +5 gün
  final QuestStatus status;
  final int rewardXp;           // Her ikisine bonus XP

  const FriendsQuest({
    required this.id,
    required this.partnerAUid,
    required this.partnerAName,
    required this.partnerBUid,
    required this.partnerBName,
    required this.targetXp,
    this.partnerAXp = 0,
    this.partnerBXp = 0,
    required this.startDate,
    required this.endDate,
    this.status = QuestStatus.pending,
    this.rewardXp = 100,
  });

  int get totalXp => partnerAXp + partnerBXp;
  double get progress =>
      targetXp > 0 ? (totalXp / targetXp).clamp(0.0, 1.0) : 0.0;
  bool get isCompleted => totalXp >= targetXp;
  int get daysRemaining =>
      endDate.difference(DateTime.now()).inDays.clamp(0, 5);

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'partnerAUid': partnerAUid,
        'partnerAName': partnerAName,
        'partnerBUid': partnerBUid,
        'partnerBName': partnerBName,
        'targetXp': targetXp,
        'partnerAXp': partnerAXp,
        'partnerBXp': partnerBXp,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'status': status.name,
        'rewardXp': rewardXp,
      };

  factory FriendsQuest.fromFirestore(Map<String, dynamic> data) =>
      FriendsQuest(
        id: data['id'] as String,
        partnerAUid: data['partnerAUid'] as String,
        partnerAName: data['partnerAName'] as String,
        partnerBUid: data['partnerBUid'] as String,
        partnerBName: data['partnerBName'] as String,
        targetXp: data['targetXp'] as int,
        partnerAXp: data['partnerAXp'] as int? ?? 0,
        partnerBXp: data['partnerBXp'] as int? ?? 0,
        startDate: DateTime.parse(data['startDate'] as String),
        endDate: DateTime.parse(data['endDate'] as String),
        status: QuestStatus.values.firstWhere(
          (s) => s.name == data['status'],
          orElse: () => QuestStatus.pending,
        ),
        rewardXp: data['rewardXp'] as int? ?? 100,
      );
}

/// Repository arayüzü — Firestore implementasyonu sonra eklenir.
/// AppConfig.enableFriendsQuest false ise no-op stub döner.
abstract class FriendsQuestRepository {
  Future<FriendsQuest?> getActive(String userUid);
  Future<List<FriendsQuest>> getHistory(String userUid, {int limit = 10});
  Future<FriendsQuest> create({
    required String partnerAUid,
    required String partnerAName,
    required String partnerBUid,
    required String partnerBName,
    int targetXp = 500,
  });
  Future<void> addXp(String questId, String userUid, int xp);
  Future<void> complete(String questId);
}

/// Geçici no-op (in-memory) — Firebase bağlanmadan önce.
class InMemoryFriendsQuestRepository implements FriendsQuestRepository {
  final Map<String, FriendsQuest> _store = {};

  @override
  Future<FriendsQuest?> getActive(String userUid) async {
    final now = DateTime.now();
    try {
      return _store.values.firstWhere(
        (q) =>
            (q.partnerAUid == userUid || q.partnerBUid == userUid) &&
            q.status == QuestStatus.active &&
            q.endDate.isAfter(now),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<FriendsQuest>> getHistory(String userUid,
      {int limit = 10}) async {
    return _store.values
        .where(
            (q) => q.partnerAUid == userUid || q.partnerBUid == userUid)
        .toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  @override
  Future<FriendsQuest> create({
    required String partnerAUid,
    required String partnerAName,
    required String partnerBUid,
    required String partnerBName,
    int targetXp = 500,
  }) async {
    final id = '${DateTime.now().millisecondsSinceEpoch}';
    final quest = FriendsQuest(
      id: id,
      partnerAUid: partnerAUid,
      partnerAName: partnerAName,
      partnerBUid: partnerBUid,
      partnerBName: partnerBName,
      targetXp: targetXp,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 5)),
      status: QuestStatus.active,
    );
    _store[id] = quest;
    return quest;
  }

  @override
  Future<void> addXp(String questId, String userUid, int xp) async {
    final quest = _store[questId];
    if (quest == null) return;
    final isA = quest.partnerAUid == userUid;
    _store[questId] = FriendsQuest(
      id: quest.id,
      partnerAUid: quest.partnerAUid,
      partnerAName: quest.partnerAName,
      partnerBUid: quest.partnerBUid,
      partnerBName: quest.partnerBName,
      targetXp: quest.targetXp,
      partnerAXp: isA ? quest.partnerAXp + xp : quest.partnerAXp,
      partnerBXp: isA ? quest.partnerBXp : quest.partnerBXp + xp,
      startDate: quest.startDate,
      endDate: quest.endDate,
      status: quest.status,
      rewardXp: quest.rewardXp,
    );
  }

  @override
  Future<void> complete(String questId) async {
    final quest = _store[questId];
    if (quest == null) return;
    _store[questId] = FriendsQuest(
      id: quest.id,
      partnerAUid: quest.partnerAUid,
      partnerAName: quest.partnerAName,
      partnerBUid: quest.partnerBUid,
      partnerBName: quest.partnerBName,
      targetXp: quest.targetXp,
      partnerAXp: quest.partnerAXp,
      partnerBXp: quest.partnerBXp,
      startDate: quest.startDate,
      endDate: quest.endDate,
      status: QuestStatus.completed,
      rewardXp: quest.rewardXp,
    );
  }
}
