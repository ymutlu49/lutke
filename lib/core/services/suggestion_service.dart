import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Düzeltme Önerisi Servisi
//
// Kullanıcılar içerik hatası/düzeltme önerisi gönderir
// (POST /api/suggestions — oturum opsiyonel), owner panelden listeler
// (GET /api/suggestions) ve durum günceller (POST /api/suggestions/update).
// Backend: functions/api/suggestions/ + D1 content_suggestions tablosu.
// ════════════════════════════════════════════════════════════════

/// API base — cloudflare_auth_service._apiBase ile aynı mantık.
String _apiBase() {
  const fromDefine = String.fromEnvironment('LUTKE_API_BASE', defaultValue: '');
  if (fromDefine.isNotEmpty) return fromDefine;
  if (kIsWeb) return Uri.base.origin;
  return 'https://lutke.app';
}

/// Öneri türleri — backend ALLOWED_TYPES ile birebir.
const kSuggestionTypes = <(String, String, String)>[
  ('peyv', 'Peyv', 'Kelime'),
  ('hevok', 'Hevok', 'Cümle'),
  ('werger', 'Werger', 'Çeviri'),
  ('deng', 'Deng', 'Ses/Telaffuz'),
  ('din', 'Din', 'Diğer'),
];

class ContentSuggestion {
  final String id;
  final String? userId;
  final String? email;
  final String itemType;
  final String? itemId;
  final String? itemText;
  final String message;
  final String? suggestion;
  final String? route;
  final String status; // open | accepted | rejected
  final DateTime createdAt;

  const ContentSuggestion({
    required this.id,
    this.userId,
    this.email,
    required this.itemType,
    this.itemId,
    this.itemText,
    required this.message,
    this.suggestion,
    this.route,
    required this.status,
    required this.createdAt,
  });

  factory ContentSuggestion.fromJson(Map<String, dynamic> j) =>
      ContentSuggestion(
        id: j['id'] as String,
        userId: j['user_id'] as String?,
        email: j['email'] as String?,
        itemType: (j['item_type'] as String?) ?? 'din',
        itemId: j['item_id'] as String?,
        itemText: j['item_text'] as String?,
        message: (j['message'] as String?) ?? '',
        suggestion: j['suggestion'] as String?,
        route: j['route'] as String?,
        status: (j['status'] as String?) ?? 'open',
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            (j['created_at'] as num?)?.toInt() ?? 0),
      );
}

class SuggestionService {
  final Dio _dio;

  SuggestionService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 12),
              receiveTimeout: const Duration(seconds: 20),
              validateStatus: (_) => true,
            ));

  String get _base => _apiBase();

  Future<Map<String, String>> _authHeader() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('cf_auth_token');
      if (token == null || token.isEmpty) return {};
      return {'Authorization': 'Bearer $token'};
    } catch (_) {
      return {};
    }
  }

  /// Öneri gönder. Başarıda true; hata durumunda false (sessiz — form
  /// kullanıcıya iki dilli genel hata gösterir).
  Future<bool> submit({
    required String itemType,
    required String message,
    String? itemId,
    String? itemText,
    String? suggestion,
    String? route,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '$_base/api/suggestions',
        data: {
          'itemType': itemType,
          'message': message,
          if (itemId != null && itemId.isNotEmpty) 'itemId': itemId,
          if (itemText != null && itemText.isNotEmpty) 'itemText': itemText,
          if (suggestion != null && suggestion.isNotEmpty)
            'suggestion': suggestion,
          if (route != null && route.isNotEmpty) 'route': route,
        },
        options: Options(headers: await _authHeader()),
      );
      return res.statusCode == 201;
    } catch (e) {
      if (kDebugMode) debugPrint('SuggestionService.submit: $e');
      return false;
    }
  }

  /// Owner: öneri listesi. [status] null → hepsi.
  Future<List<ContentSuggestion>> fetchAll({String? status}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '$_base/api/suggestions',
      queryParameters: status != null ? {'status': status} : null,
      options: Options(headers: await _authHeader()),
    );
    if (res.statusCode != 200 || res.data == null) return [];
    final list = (res.data!['suggestions'] as List<dynamic>? ?? []);
    return list
        .map((e) => ContentSuggestion.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Owner: durum güncelle ('open' | 'accepted' | 'rejected').
  Future<bool> updateStatus(String id, String status) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '$_base/api/suggestions/update',
      data: {'id': id, 'status': status},
      options: Options(headers: await _authHeader()),
    );
    return res.statusCode == 200;
  }
}

final suggestionServiceProvider =
    Provider<SuggestionService>((ref) => SuggestionService());

/// Admin paneli için öneri listesi (owner token'ıyla çekilir).
final contentSuggestionsProvider =
    FutureProvider.autoDispose<List<ContentSuggestion>>((ref) async {
  return ref.watch(suggestionServiceProvider).fetchAll();
});
