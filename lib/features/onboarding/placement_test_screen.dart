import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../shared/providers/learning_track_provider.dart';
import '../../core/services/cloudflare_auth_service.dart';
import '../lessons/data/lesson_repository.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Düzey Belirleme Testi (CEFR Placement Test)
//
// Register/Login → Track Select → BU EKRAN → Home
//
// - 20 soru, A1 → C2 artan zorluk (3 A1 + 4 A2 + 4 B1 + 4 B2 + 3 C1 + 2 C2)
// - Track'e göre iki farklı soru seti (Kurmancî / İngilizce)
// - Scoring: cefr eşik tablosu (computePlacementLevel) — a1..c2
// - Skip ile doğrudan A1'den başlama seçeneği
// - Sonuç kaydı: SharedPreferences `placement_level_{ku|en}` + hesap
//   (POST /api/profile/placement, track parametreli)
// - Test-once: HESAP + TRACK bazlı. Ekran açılışında guard: bu track için
//   seviye zaten varsa (hesap VEYA prefs) ve kullanıcı profilden bilinçli
//   retake ile gelmediyse otomatik home'a yönlendirilir (çifte güvence).
// ════════════════════════════════════════════════════════════════
// NOT: prefs anahtar sabitleri cloudflare_auth_service.dart'ta
// (kPlacementLevelKeyKu/En) — login/me senkronu da aynı anahtarları yazar.

// Pêşniyara testê — testê ji nû ve nedan jî tê parastin. Bila bikarhêner
// di nav astan de bigere lê pêşniyar wenda nebe.
const String _kRecommendedLevelKeyKu = 'recommended_level_ku';
const String _kRecommendedLevelKeyEn = 'recommended_level_en';

/// SharedPreferences anahtarı — track'in languageCode'una göre.
String placementLevelKeyFor(String languageCode) =>
    languageCode == 'en' ? kPlacementLevelKeyEn : kPlacementLevelKeyKu;

/// Testin önerdiği düzey için ayrı anahtar — kullanıcı seviyeyi manuel
/// değiştirse bile placement önerisi kalıcı olarak saklanır.
String recommendedLevelKeyFor(String languageCode) =>
    languageCode == 'en' ? _kRecommendedLevelKeyEn : _kRecommendedLevelKeyKu;

/// "a1" | "a2" | "b1" | "b2" | "c1" | "c2"
enum PlacementCefr { a1, a2, b1, b2, c1, c2 }

extension _PlacementCefrX on PlacementCefr {
  String get label => switch (this) {
        PlacementCefr.a1 => 'A1',
        PlacementCefr.a2 => 'A2',
        PlacementCefr.b1 => 'B1',
        PlacementCefr.b2 => 'B2',
        PlacementCefr.c1 => 'C1',
        PlacementCefr.c2 => 'C2',
      };

  String get code => label.toLowerCase();

  /// Asta navîn şirovekirin — pure Kurmancî (Bedirxan-Hawar).
  String get descKu => switch (this) {
        PlacementCefr.a1 =>
          'Bingehîn: silavên hêsan û naskirina hejmaran. Tu yê ji destpêkê dest pê bikî.',
        PlacementCefr.a2 =>
          'Destpêka pêşketî: hevokên hêsan, dema borî/niha. Pratîka rojane.',
        PlacementCefr.b1 =>
          'Asta navîn: hevokên kompozît, dem-form. Axaftina serbesttir.',
        PlacementCefr.b2 =>
          'Navîn-jor: îdyom, rêzimanên kompleks. Bikaranîna hilbijartî.',
        PlacementCefr.c1 =>
          'Pêşketî: peyvên abstrakt, nivîsên edebî. Asta pîşeyî.',
        PlacementCefr.c2 =>
          'Pispor: nuansên akademîk/edebî, herikbarî temam. Nêzîkî zimanê dayikê.',
      };
}

class _PQ {
  final String id;
  final String prompt;
  final PlacementCefr cefr;
  final List<String> options;
  final int correctIndex;
  // Açıklama UI'da gösterilmiyor; bakım için kısa Kurmancî not.
  final String explanationKu;

  const _PQ({
    required this.id,
    required this.prompt,
    required this.cefr,
    required this.options,
    required this.correctIndex,
    required this.explanationKu,
  });
}

// ── Kurmancî soru seti (10) ─────────────────────────────────────
// Dağılım: 2×A1 + 2×A2 + 2×B1 + 2×B2 + 1×C1 + 1×C2 = 10
// Tîpolojî (Mayîs 2026): Tev pirs û bersiv bi Kurmancî ne, bê tirkî.
// Bedirxan-Hawar standardîya termînolojî. correctIndex dağılımı dengeli:
// her pozîsyon (0,1,2,3) deqîqayekî ye, biaseyekî tunebe.
const List<_PQ> _kuQuestions = [
  // ─── A1 — Bingehîn (2) ─────────────────────────────────────
  _PQ(
    id: 'ku-1',
    prompt: '"Silav" kengê tê bikaranîn?',
    cefr: PlacementCefr.a1,
    options: [
      'Dema dîtina kesekî',
      'Dema xwarinê',
      'Dema xewê',
      'Dema xwendinê',
    ],
    correctIndex: 0,
    explanationKu: '"Silav" peyveke silavkirinê ye.',
  ),
  _PQ(
    id: 'ku-2',
    prompt: 'Kîjan rêz ji endamên malbatê pêk tê?',
    cefr: PlacementCefr.a1,
    options: [
      'sêv, hêjîr, gûz',
      'erd, av, agir',
      'kitêb, qelem, defter',
      'dayik, bav, bira',
    ],
    correctIndex: 3,
    explanationKu: 'Endamên malbatê: dayik, bav, bira, xwişk, ap, met, ...',
  ),
  // ─── A2 — Hevokên hêsan (2) ──────────────────────────────
  _PQ(
    id: 'ku-3',
    prompt: 'Forma rast: "Ez her roj ___ dibistanê."',
    cefr: PlacementCefr.a2,
    options: [
      'çûm',
      'diçim',
      'biçim',
      'çû',
    ],
    correctIndex: 1,
    explanationKu: 'Dema niha, kesê yekem yekjimar: ez di-ç-im. '
        '"çûm" borî ye, "biçim" subjûnktîv, "çû" kesê sêyem.',
  ),
  _PQ(
    id: 'ku-4',
    prompt: '"Tu ji ku derê yî?" — bersiva rast kîjan e?',
    cefr: PlacementCefr.a2,
    options: [
      'Ez ji Amedê me',
      'Ez baş im',
      'Ez naxwazim',
      'Ez westiyam',
    ],
    correctIndex: 0,
    explanationKu: '"Ji ku derê" derbarê eslê (cihê ji-derketinê) ye. '
        'Bersiv: "ji [navê cih]ê me".',
  ),
  // ─── B1 — Hevoka komplêks / ergatîvî (2) ─────────────────
  _PQ(
    id: 'ku-5',
    prompt: '"Min pirtûk xwend" — di vê hevokê de "min" çi ye?',
    cefr: PlacementCefr.b1,
    options: [
      'Bireser',
      'Cihê pêkhatinê',
      'Kirdeya tewandî',
      'Xwedîtî',
    ],
    correctIndex: 2,
    explanationKu: 'Avahiya ergatîv: di lêkerên derbasdar ên dema borî de '
        'kirde tewandî dibe (min, te, wî/wê, me, we, wan). '
        'Loma "min" li vir kirdeya tewandî ye, ne bireser.',
  ),
  _PQ(
    id: 'ku-6',
    prompt: '"Ger baran bibare, ez ê neyêm" — ev hevok çi nîşan dide?',
    cefr: PlacementCefr.b1,
    options: [
      'Bibîranînek ji dema rabirdûyê',
      'Diyarkirineke gelemperî ya rastiyê',
      'Hewildaneke neguherbar a berdewam',
      'Şertekî pêşerojê û encama neyînî',
    ],
    correctIndex: 3,
    explanationKu: '"Ger ... bibare" = şertê pêşerojê (subjûnktîv). '
        '"Ez ê neyêm" = encama neyînî ya pêşerojê.',
  ),
  // ─── B2 — Gotin / kompoze (2) ───────────────────────────
  _PQ(
    id: 'ku-7',
    prompt: '"Dilê min geş e" — wateya rast kîjan e?',
    cefr: PlacementCefr.b2,
    options: [
      'Ez xemgîn im',
      'Ez bextiyar im',
      'Ez aciz im',
      'Ez bêhêvî me',
    ],
    correctIndex: 1,
    explanationKu: 'Gotineke îmajîner: "dilê min ronî/geş e" → kêfxweşî.',
  ),
  _PQ(
    id: 'ku-8',
    prompt: '"Ez ji xewê şiyar bûm" — "ji" di vê hevokê de çi diyar dike?',
    cefr: PlacementCefr.b2,
    options: [
      'Hevkarî',
      'Armanc',
      'Çavkanî',
      'Xwedîtî',
    ],
    correctIndex: 2,
    explanationKu: '"ji" daçeka çavkanî / dûrketinê ye. '
        'Mînak: ji malê derketin, ji xewê şiyar bûn.',
  ),
  // ─── C1 — Abstrakt / edebî (1) ───────────────────────────
  _PQ(
    id: 'ku-9',
    prompt: '"Civak bêyî ziman namîne; ziman jî bêyî civak namîne." '
        'Wateya giştî ya vê gotinê kîjan e?',
    cefr: PlacementCefr.c1,
    options: [
      'Ziman ji civakê girîngtir e',
      'Ziman û civak bi hev ve girêdayî ne',
      'Civak ziman çêdike',
      'Ziman çarenûsa civakê diyar dike',
    ],
    correctIndex: 1,
    explanationKu: 'Têkiliyeke dualî: ne diyarker e, ne jî yek-jêhatî — '
        'her du jî bi hev re hene yan jî bi hev re ji holê radibin.',
  ),
  // ─── C2 — Pisporî / akademîk (1) ─────────────────────────
  _PQ(
    id: 'ku-10',
    prompt: '"Zimannasî" kîjan disîplîna akademîk e?',
    cefr: PlacementCefr.c2,
    options: [
      'Lêkolîna edebiyatê',
      'Lêkolîna dîrokê',
      'Lêkolîna felsefeyê',
      'Lêkolîna ziman',
    ],
    correctIndex: 3,
    explanationKu: 'ziman (dil) + -nasî (zanyarî) = lêkolîna sîstema ziman. '
        'Termê standart yê Kurmancî (Bedirxan-Hawar).',
  ),
];

// ── English soru seti (10) ──────────────────────────────────────
// Dağılım: 2×A1 + 2×A2 + 2×B1 + 2×B2 + 1×C1 + 1×C2 = 10
// Tîpolojî (Mayîs 2026): Pirsiyar bi Kurmancî ne, bersiv bi îngilîzî ne.
// Hîç peyveke Tirkî tune. Kurmancî zimanê fêrkirinê ye → bikarhêner divê
// dikare bi Kurmancî pirsê fêm bike, û rastiya gramerê/peyvê ya îngilîzî
// hilbijêre.
const List<_PQ> _enQuestions = [
  // ─── A1 — Bingehîn (2) ─────────────────────────────────────
  _PQ(
    id: 'en-1',
    prompt: 'Hevwateya peyva "Hello" çi ye?',
    cefr: PlacementCefr.a1,
    options: ['Hi', 'Goodbye', 'Thanks', 'Sorry'],
    correctIndex: 0,
    explanationKu: '"Hello" û "Hi" her du jî silavên hevwate ne. '
        '"Goodbye" ji bo veqetînê ye.',
  ),
  _PQ(
    id: 'en-2',
    prompt: 'Hevoka rast: "I ___ a student."',
    cefr: PlacementCefr.a1,
    options: ['be', 'is', 'am', 'are'],
    correctIndex: 2,
    explanationKu: '"To be" bi kesê yekem yekjimar (I) re → "am".',
  ),
  // ─── A2 — Hevokên hêsan (2) ──────────────────────────────
  _PQ(
    id: 'en-3',
    prompt: 'Forma rast a borî: "Yesterday I ___ to the park."',
    cefr: PlacementCefr.a2,
    options: ['go', 'gone', 'going', 'went'],
    correctIndex: 3,
    explanationKu: 'Borîya hêsan: "go → went". "gone" V3, "going" gerund.',
  ),
  _PQ(
    id: 'en-4',
    prompt: 'Hevoka rast: "There ___ three apples on the table."',
    cefr: PlacementCefr.a2,
    options: ['be', 'is', 'am', 'are'],
    correctIndex: 3,
    explanationKu: '"There + to be" pirjimar → "are". '
        'Mînak: There is one apple / There are three apples.',
  ),
  // ─── B1 — Gramer navîn (2) ───────────────────────────────
  _PQ(
    id: 'en-5',
    prompt: 'Forma rast: "I have lived here ___ 2020."',
    cefr: PlacementCefr.b1,
    options: ['for', 'since', 'from', 'at'],
    correctIndex: 1,
    explanationKu: 'Present perfect: "since" + xala destpêkê ya diyar (2020). '
        '"for" + dirêjahiya demê (5 years).',
  ),
  _PQ(
    id: 'en-6',
    prompt: 'Hevoka rast: "If I had more time, I ___ travel more."',
    cefr: PlacementCefr.b1,
    options: ['will', 'shall', 'would', 'do'],
    correctIndex: 2,
    explanationKu: 'Şertê 2yem (unreal present): if + past simple, '
        'apodosîs: would + bingeh.',
  ),
  // ─── B2 — Gramera bilind / gotin (2) ────────────────────
  _PQ(
    id: 'en-7',
    prompt: 'Wateya gotina "hit the books" çi ye?',
    cefr: PlacementCefr.b2,
    options: [
      'to sell books',
      'to dislike books',
      'to study hard',
      'to tear pages',
    ],
    correctIndex: 2,
    explanationKu: '"li pirtûkan dan" → dema xwendin/lêkolîna giran.',
  ),
  _PQ(
    id: 'en-8',
    prompt: 'Hevoka rast: "Had I known earlier, I ___ differently."',
    cefr: PlacementCefr.b2,
    options: [
      'will act',
      'acted',
      'would have acted',
      'would act',
    ],
    correctIndex: 2,
    explanationKu:
        '"Had I known" = inversion of "If I had known" → 3rd conditional. '
        'Apodosîs: would have + V3.',
  ),
  // ─── C1 — Abstrakt / edebî (1) ───────────────────────────
  _PQ(
    id: 'en-9',
    prompt:
        '"He gave a cursory glance at the document." Wateya "cursory" çi ye?',
    cefr: PlacementCefr.c1,
    options: [
      'quick and superficial',
      'thorough and in-depth',
      'careful and attentive',
      'slow and long-lasting',
    ],
    correctIndex: 0,
    explanationKu: '"cursory" = bilez û ne kûr, bê detay. '
        '"in-depth" û "careful" dijber in.',
  ),
  // ─── C2 — Pisporî / akademîk (1) ─────────────────────────
  _PQ(
    id: 'en-10',
    prompt:
        '"The committee\'s decision was a fait accompli." Ev gotin çi diyar dike?',
    cefr: PlacementCefr.c2,
    options: [
      'a newly drafted proposal',
      'an openly debated decision',
      'a partial interim result',
      'an irreversible done deal',
    ],
    correctIndex: 3,
    explanationKu: '"fait accompli" (Fransî → îngilîzî) = '
        'kar berê hatiye qedandin, vegera gengaz nîne.',
  ),
];

/// CEFR puanlaması — `correct` = doğru cevap sayısı (0..10).
/// Dağılım: 2×A1 + 2×A2 + 2×B1 + 2×B2 + 1×C1 + 1×C2 = 10.
/// Eşik (kümülatif):
///   0-1 → A1, 2-3 → A2, 4-5 → B1, 6-7 → B2, 8 → C1, 9-10 → C2.
PlacementCefr computePlacementLevel(int correct) {
  if (correct <= 1) return PlacementCefr.a1;
  if (correct <= 3) return PlacementCefr.a2;
  if (correct <= 5) return PlacementCefr.b1;
  if (correct <= 7) return PlacementCefr.b2;
  if (correct <= 8) return PlacementCefr.c1;
  return PlacementCefr.c2;
}

class PlacementTestScreen extends ConsumerStatefulWidget {
  /// true → kullanıcı profilden bilinçli "Dîsa biceribîne" ile geldi;
  /// yerleşiklik guard'ı atlanır. Router `extra: {'retake': true}` geçirir.
  final bool retake;

  const PlacementTestScreen({super.key, this.retake = false});

  @override
  ConsumerState<PlacementTestScreen> createState() =>
      _PlacementTestScreenState();
}

class _PlacementTestScreenState extends ConsumerState<PlacementTestScreen> {
  int _index = 0;
  final Map<String, int> _answers = {}; // questionId → selectedIndex
  bool _finished = false;
  PlacementCefr? _result;

  /// Guard tamamlanana kadar test UI'ı render edilmez (flash önlemi).
  /// retake akışında guard yok → direkt test.
  bool _guardDone = false;

  /// Hesaba placement yazıldı, cloudflareCurrentUserProvider tazelenmeyi
  /// bekliyor. Invalidate EKRANDAN AYRILIRKEN yapılır — bkz.
  /// [_refreshAccountAndGo] (router rebuild fix, Tem 2026).
  bool _accountRefreshPending = false;

  @override
  void initState() {
    super.initState();
    if (widget.retake) {
      _guardDone = true;
      return;
    }
    // ÇİFTE GÜVENCE (Temmuz 2026): Gate'ler yanlışlıkla buraya yönlendirse
    // bile — bu track için seviye zaten varsa (hesap VEYA prefs) ve kullanıcı
    // bilinçli retake ile gelmediyse otomatik home'a dön.
    // Profilden `context.push` ile gelen retake akışı canPop==true olur;
    // extra parametresi unutulmuş olsa da test gösterilir (akış korunur).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (context.canPop()) {
        // push ile gelinmiş (profil retake) → guard yok.
        setState(() => _guardDone = true);
        return;
      }
      final track = ref.read(currentTrackProvider);
      final placed = await hasPlacementForTrack(ref, track.languageCode);
      if (!mounted) return;
      if (placed) {
        context.go(track.nativeHomePath);
        return;
      }
      setState(() => _guardDone = true);
    });
  }

  List<_PQ> get _questions {
    final track = ref.read(currentTrackProvider);
    return track.isEnglish ? _enQuestions : _kuQuestions;
  }

  int get _correctCount {
    int c = 0;
    for (final q in _questions) {
      final selected = _answers[q.id];
      if (selected != null && selected == q.correctIndex) c++;
    }
    return c;
  }

  Future<void> _skipToA1(BuildContext context) async {
    final track = ref.read(currentTrackProvider);
    // Profile > "Dîsa biceribîne" akışında mevcut seviyeyi silmeyelim:
    // önceden B2 olan kullanıcı yanlışlıkla "A1'den başla" derse B2 gidiyordu.
    // Mevcut bir seviye varsa yalnızca track-select'e dön; yoksa A1 yazıp git.
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing =
          prefs.getString(placementLevelKeyFor(track.languageCode));
      if (existing != null && existing.isNotEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Asta heyî hate parastin: ${existing.toUpperCase()}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        // YENİ AKIŞ (Mayıs 2026): track-select → placement → home.
        context.go(track.nativeHomePath);
        return;
      }
    } catch (_) {}
    await _persistLevel(track.languageCode, PlacementCefr.a1);
    if (!context.mounted) return;
    await _refreshAccountAndGo(context, track.nativeHomePath);
  }

  Future<void> _persistLevel(
    String languageCode,
    PlacementCefr level,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        placementLevelKeyFor(languageCode),
        level.code,
      );
    } catch (_) {
      // Sessiz hata — web/pref yoksa kullanıcıyı takılmaz.
    }
    // userProfileProvider state'ini anlık güncelle → home ekranı doğru
    // seviyeyi gösterir (reload gerekmez).
    try {
      await ref.read(userProfileProvider.notifier).setLevel(level.code);
    } catch (_) {}
    // Hesaba da yaz (account + TRACK bazlı test-once) — cihaz/origin bağımsız.
    // track parametresi: EN testi placement_level_en'e, KU testi
    // placement_level'e yazılır.
    //
    // ROUTER REBUILD FIX (Tem 2026): Eskiden başarılı kayıtta burada hemen
    // `ref.invalidate(cloudflareCurrentUserProvider)` çağrılıyordu. appRouter
    // bu provider'ı watch ettiği için (app_router.dart) invalidate YENİ bir
    // GoRouter instance'ı yaratıyor ve _resolveInitialLocation yalnız token
    // route'larını koruduğundan uygulama splash'a resetleniyordu. _goNext
    // akışında bu, `setState(_finished=true)`'den ÖNCE tetiklendiği için
    // ekran unmount oluyor ve kullanıcı sonuç görünümünü (_ResultView) hiç
    // göremiyordu. Artık yalnız bayrak set edilir; invalidate ekrandan
    // ayrılırken _refreshAccountAndGo içinde yapılır — böylece gate'ler
    // (splash / track-select / intro) yine taze kullanıcıyı görür ama sonuç
    // ekranı kaybolmaz.
    try {
      final updated = await ref
          .read(cloudflareAuthServiceProvider)
          .savePlacementLevel(
            level.code,
            track: languageCode == 'en' ? 'en' : 'ku',
          );
      if (updated != null) _accountRefreshPending = true;
    } catch (_) {}
  }

  /// Ekrandan home'a ayrılırken bekleyen hesap tazelemesini uygular.
  ///
  /// register_screen.dart'taki desen: invalidate → future'ı bekle → ~50ms
  /// settle → context.go. Invalidate appRouter'ı yeniden kurdurduğu için
  /// context.go'nun ESKİ router instance'ına uygulanıp kaybolmaması adına
  /// önce rebuild'in oturması beklenir. Widget bu sırada unmount olursa
  /// (yeni router splash'tan başlar) splash gate'i zaten yerleşmiş
  /// kullanıcıyı home'a yönlendirir — kullanıcı mahsur kalmaz.
  Future<void> _refreshAccountAndGo(
    BuildContext context,
    String location,
  ) async {
    if (_accountRefreshPending) {
      _accountRefreshPending = false;
      ref.invalidate(cloudflareCurrentUserProvider);
      try {
        await ref.read(cloudflareCurrentUserProvider.future);
      } catch (_) {}
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    if (!context.mounted) return;
    context.go(location);
  }

  void _selectOption(_PQ q, int selected) {
    setState(() {
      _answers[q.id] = selected;
    });
  }

  Future<void> _goNext() async {
    if (_index < _questions.length - 1) {
      setState(() => _index++);
      return;
    }
    // Test bitti — sonucu hesapla ve sakla
    final level = computePlacementLevel(_correctCount);
    final track = ref.read(currentTrackProvider);
    await _persistLevel(track.languageCode, level);
    // Pêşniyara testê serbixwe sakla — paşê bikarhêner asta xwe biguherîne
    // jî pêşniyar wenda nabe.
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        recommendedLevelKeyFor(track.languageCode),
        level.code,
      );
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _result = level;
      _finished = true;
    });
  }

  Future<void> _startAtLevel(
    BuildContext context,
    PlacementCefr level,
  ) async {
    final track = ref.read(currentTrackProvider);
    await _persistLevel(track.languageCode, level);
    if (!context.mounted) return;
    await _refreshAccountAndGo(context, track.nativeHomePath);
  }

  @override
  Widget build(BuildContext context) {
    final track = ref.watch(currentTrackProvider);

    // Guard sürerken test sorularını FLASH'lama — kısa loading göster.
    if (!_guardDone) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              semanticsLabel: 'Tê barkirin',
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _finished && _result != null
                  ? _ResultView(
                      level: _result!,
                      correct: _correctCount,
                      total: _questions.length,
                      questions: _questions,
                      answers: _answers,
                      onStart: (lvl) => _startAtLevel(context, lvl),
                    )
                  : _QuestionView(
                      questions: _questions,
                      index: _index,
                      answers: _answers,
                      isEnglishTrack: track.isEnglish,
                      onSelect: _selectOption,
                      onNext: _goNext,
                      onSkip: () => _skipToA1(context),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Soru görünümü ───────────────────────────────────────────────

class _QuestionView extends StatelessWidget {
  final List<_PQ> questions;
  final int index;
  final Map<String, int> answers;
  final bool isEnglishTrack;
  final void Function(_PQ question, int selectedIndex) onSelect;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _QuestionView({
    required this.questions,
    required this.index,
    required this.answers,
    required this.isEnglishTrack,
    required this.onSelect,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final q = questions[index];
    final selected = answers[q.id];
    final progress = (index + 1) / questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // UX FIX: Geri/kapat butonu — profile'dan retake eden kullanıcı
        // vazgeçince ekranda mahsur kalmasın. canPop varsa pop, aksi halde
        // home'a dön.
        Row(
          children: [
            SizedBox(
              width: AppSpacing.touchMin,
              height: AppSpacing.touchMin,
              child: IconButton(
                tooltip: 'Vegere',
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    // Fallback: aktif track home'u
                    Navigator.of(context).maybePop();
                  }
                },
              ),
            ),
            const Spacer(),
            Text(
              '${index + 1} / ${questions.length}',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        // Skip row — "Ji A1 dest pê bike"
        Row(
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
              ),
              onPressed: onSkip,
              icon: const Icon(Icons.skip_next_rounded, size: 18),
              label: Text(
                'Ji A1 dest pê bike',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.borderLight,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Header — pure Kurmancî
        Text(
          'Diyarkirina astê',
          style: AppTypography.caption.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isEnglishTrack
              ? 'Asta xwe bibîne — Îngilîzî'
              : 'Asta xwe bibîne — Kurmancî',
          style: AppTypography.title.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Question card
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              q.cefr.label,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        q.prompt,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 200.ms),
                const SizedBox(height: AppSpacing.md),

                // Options
                for (var i = 0; i < q.options.length; i++) ...[
                  _OptionTile(
                    label: q.options[i],
                    isSelected: selected == i,
                    onTap: () => onSelect(q, i),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],

                // Yardımcı not — pure Kurmancî
                Text(
                  'Bijareyekê hilbijêre, paşê "Berdewam bike" pêl bike',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Next button
        SizedBox(
          height: AppSpacing.touchPreferred,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            onPressed: selected == null ? null : onNext,
            child: Text(
              index == questions.length - 1 ? 'Encamê bibîne' : 'Berdewam bike',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(
            minHeight: AppSpacing.touchPreferred,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
              width:
                  isSelected ? AppSpacing.borderThick : AppSpacing.borderMedium,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
                size: 22,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sonuç görünümü ──────────────────────────────────────────────
// NOT (2026-05-06): Eskiden chip'lerle alternatif seviye seçtirip ayrı
// "Dest pê bike" butonu vardı — kullanıcı seçimi takibi için StatefulWidget
// idi. CTA 2 kaldırılınca state gereksiz kaldı → StatelessWidget.

class _ResultView extends StatelessWidget {
  final PlacementCefr level;
  final int correct;
  final int total;
  final List<_PQ> questions;
  final Map<String, int> answers;
  final Future<void> Function(PlacementCefr) onStart;

  const _ResultView({
    required this.level,
    required this.correct,
    required this.total,
    required this.questions,
    required this.answers,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          // Büyük rozet
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  level.label,
                  style: AppTypography.display.copyWith(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppSpacing.lg),

          Text(
            'Asta te: ${level.label}',
            textAlign: TextAlign.center,
            style: AppTypography.headline.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$correct ji $total rast',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Text(
              level.descKu,
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // CTA 1: Ji asta pêşniyarkirî dest pê bike
          SizedBox(
            height: AppSpacing.touchPreferred,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              onPressed: () => onStart(level),
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(
                'Ji asta ${level.label} dest pê bike',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Reassurance: pêşniyar e, ne ferman e
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Ev pêşniyar e, ne ferman. Tu dikarî her astê biceribînî — paşê dîsa biguherîne.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // NOT (2026-05-06): "An jî asteke din hilbijêre" CTA 2 bloğu
          // (chip'ler + alt OutlinedButton) kullanıcı isteği üzerine
          // kaldırıldı — üstteki "Ji asta X dest pê bike" CTA 1 ile
          // duplicate görünüyordu. Reassurance kutusu zaten "paşê dîsa
          // biguherîne" diyor; kullanıcı seviyeyi profile'dan değiştirir.

          // Mifteya bersivan — test bitince cevap anahtarı (KU + EN).
          const SizedBox(height: AppSpacing.lg),
          _AnswerKey(questions: questions, answers: answers),
        ],
      ),
    );
  }
}

// ── Mifteya bersivan (Cevap anahtarı) ───────────────────────────
// Test bitince gösterilir: her soru, doğru cevap (yeşil), kullanıcının
// yanlış seçimi (kırmızı) ve kısa Kurmancî açıklama. Hem Kurmancî hem
// İngilizce track'te çalışır — _ResultView ikisini de kullanır.

class _AnswerKey extends StatelessWidget {
  final List<_PQ> questions;
  final Map<String, int> answers;

  const _AnswerKey({required this.questions, required this.answers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.fact_check_rounded,
                size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Mifteya bersivan',
              style: AppTypography.title.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Bersivên rast û şîroveyên kurt li jêr in.',
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < questions.length; i++) ...[
          _AnswerKeyItem(
            number: i + 1,
            q: questions[i],
            selectedIndex: answers[questions[i].id],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _AnswerKeyItem extends StatelessWidget {
  final int number;
  final _PQ q;
  final int? selectedIndex;

  const _AnswerKeyItem({
    required this.number,
    required this.q,
    required this.selectedIndex,
  });

  static const _green = Color(0xFF2E7D32);
  static const _red = Color(0xFFC62828);

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedIndex != null && selectedIndex == q.correctIndex;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$number · ${q.cefr.label}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                size: 18,
                color: isCorrect ? _green : _red,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            q.prompt,
            style: AppTypography.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < q.options.length; i++) _optionRow(i),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline_rounded,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    q.explanationKu,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionRow(int i) {
    final isCorrectOpt = i == q.correctIndex;
    final isUserPick = selectedIndex == i;
    final isWrongPick = isUserPick && !isCorrectOpt;
    final Color fg =
        isCorrectOpt ? _green : (isWrongPick ? _red : AppColors.textSecondary);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrectOpt
                ? Icons.check_circle_rounded
                : (isWrongPick
                    ? Icons.cancel_rounded
                    : Icons.radio_button_unchecked),
            size: 16,
            color: fg,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              q.options[i],
              style: AppTypography.body.copyWith(
                color:
                    (isCorrectOpt || isWrongPick) ? fg : AppColors.textPrimary,
                fontWeight: isCorrectOpt ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          if (isUserPick) ...[
            const SizedBox(width: 6),
            Text(
              'bersiva te',
              style: AppTypography.labelSmall.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
