/// LÛTKE — Heritage Senaryo Veritabanı
///
/// Prof. Dr. Mutlu'nun araştırmasıyla uyumlu: 2. nesil diaspora
/// için duygusal-bellek tetikleyici kategoriler. Harvard 2024:
/// aile-bağı kurmayan heritage learner kalıcılığı düşük.
///
/// Kategoriler:
/// - Mitbexa Dapîrê (Büyükanne mutfağı)
/// - Sohbeta Bavê (Baba sohbeti)
/// - Dawetê (Düğün / kutlama)
/// - Newroza Me (Bizim Nevruz'umuz)
/// - Çîrokên Pîrê (Nine'nin hikayeleri)
///
/// Her senaryo: 8-12 temel cümle + Kurmancî + TR karşılığı +
/// tema emoji. HF TTS runtime.

class HeritageScenario {
  final String id;
  final String titleKu;
  final String titleTr;
  final String emoji;
  final String category;    // 'kitchen', 'conversation', 'celebration'
  final List<HeritagePhrase> phrases;
  final String? culturalNote;

  const HeritageScenario({
    required this.id,
    required this.titleKu,
    required this.titleTr,
    required this.emoji,
    required this.category,
    required this.phrases,
    this.culturalNote,
  });
}

class HeritagePhrase {
  final String ku;
  final String tr;
  final String? context; // "pîrê der" / "dê dibêje"
  const HeritagePhrase({required this.ku, required this.tr, this.context});
}

// ════════════════════════════════════════════════════════════════
// HERITAGE SENARYOLAR
// ════════════════════════════════════════════════════════════════

const kHeritageScenarios = <HeritageScenario>[

  // ── 1. Mitbexa Dapîrê ─────────────────────────────────────
  HeritageScenario(
    id: 'h_mitfax_dapir',
    titleKu: 'Mitbexa Dapîrê',
    titleTr: 'Büyükanne Mutfağı',
    emoji: '🍲',
    category: 'kitchen',
    culturalNote:
        'Kürt mutfağında büyükanne (dapîr/pîrê) dilin en canlı aktarıcısıdır. '
        'Bu kalıplar çoğunlukla onun sesinden öğrenilir.',
    phrases: [
      HeritagePhrase(
        ku: 'Were cem min, karikê min!',
        tr: 'Gel yanıma yavrum!',
        context: 'Dapîr çağırır',
      ),
      HeritagePhrase(
        ku: 'Destê xwe bavêje nên.',
        tr: 'Ekmekten bir parça al.',
      ),
      HeritagePhrase(
        ku: 'Bismillah bêje, bixwe, xurt bibe.',
        tr: 'Bismillah de, ye, güçlen.',
      ),
      HeritagePhrase(
        ku: 'Tu çayê dixwazî yan dew?',
        tr: 'Çay mı ayran mı istersin?',
      ),
      HeritagePhrase(
        ku: 'Ez ê ji te re dolme çêkim.',
        tr: 'Sana dolma yapacağım.',
      ),
      HeritagePhrase(
        ku: 'Tu di destê min de mezin bûyî.',
        tr: 'Benim elimde büyüdün.',
      ),
      HeritagePhrase(
        ku: 'Tu çîrokê bêje, ez ê ji te re xwarinê çêkim.',
        tr: 'Sen hikaye anlat, ben sana yemek yapayım.',
      ),
      HeritagePhrase(
        ku: 'Nan û xwê — mala me bi te şên e.',
        tr: 'Ekmek ve tuz — evimiz seninle şenlenir.',
      ),
      HeritagePhrase(
        ku: 'Sifre tê danîn, bavê te tê.',
        tr: 'Sofra kuruluyor, baban geliyor.',
      ),
      HeritagePhrase(
        ku: 'Ez bi xatirê te rihet dixwim.',
        tr: 'Senin hatırın için rahat yiyorum.',
      ),
    ],
  ),

  // ── 2. Sohbeta Bavê (Hespek Çay) ──────────────────────────
  HeritageScenario(
    id: 'h_sohbet_bav',
    titleKu: 'Sohbeta Bavê bi Çayê re',
    titleTr: 'Baba ile Çay Sohbeti',
    emoji: '☕',
    category: 'conversation',
    culturalNote:
        'Çay saati Kürt kültüründe "hezkirina gotinê"nin mekânıdır. '
        'Bav ve zarok arasında dil aktarımı çay soğurken gerçekleşir.',
    phrases: [
      HeritagePhrase(
        ku: 'Were rûne, em ê çayekê vexwin.',
        tr: 'Gel otur, bir çay içelim.',
        context: 'Bav dibêje',
      ),
      HeritagePhrase(
        ku: 'Îro li dibistanê te çi kir?',
        tr: 'Bugün okulda ne yaptın?',
      ),
      HeritagePhrase(
        ku: 'Bapîrê min jî wisa digot.',
        tr: 'Benim dedem de böyle derdi.',
      ),
      HeritagePhrase(
        ku: 'Zimanê dayikê ji bîr neke.',
        tr: 'Ana dilini unutma.',
      ),
      HeritagePhrase(
        ku: 'Em ji gund hatin, lê gundê me di dilê me de ye.',
        tr: 'Köyden geldik ama köyümüz kalbimizde.',
      ),
      HeritagePhrase(
        ku: 'Kurdîtî bi ziman û bi hiş e.',
        tr: 'Kürtlük dil ve akıldır.',
      ),
      HeritagePhrase(
        ku: 'Kalikê te gelek pirtûk xwendibûn.',
        tr: 'Deden çok kitap okumuştu.',
      ),
      HeritagePhrase(
        ku: 'Divê tu hem bixwînî, hem jî çandê fêr bibî.',
        tr: 'Hem okumalısın hem kültürü öğrenmelisin.',
      ),
    ],
  ),

  // ── 3. Dawetê (Düğün) ─────────────────────────────────────
  HeritageScenario(
    id: 'h_dawet',
    titleKu: 'Li Dawetê',
    titleTr: 'Düğünde',
    emoji: '💃',
    category: 'celebration',
    culturalNote:
        'Dawet, dengbêjî, govend — kolektif kutlamalar diasporada kültür '
        'aktarımının kritik anlarıdır.',
    phrases: [
      HeritagePhrase(
        ku: 'Dawet pîroz be — jiyana we bi kêf û xêr!',
        tr: 'Düğün kutlu olsun — hayatınız neşe ve bereketle!',
      ),
      HeritagePhrase(
        ku: 'Govend dest pê kir — were em bigerin.',
        tr: 'Halay başladı — gel halaya katılalım.',
      ),
      HeritagePhrase(
        ku: 'Destê xwe deyne ser milê min.',
        tr: 'Elini omzuma koy.',
      ),
      HeritagePhrase(
        ku: 'Dengbêj bi kilama "Lê lê dîlberê" dest pê kir.',
        tr: 'Dengbêj "Lê lê dîlberê" ile başladı.',
      ),
      HeritagePhrase(
        ku: 'Zarok li ser milê bavê xwe siwar e.',
        tr: 'Çocuk babasının omzunda oturuyor.',
      ),
      HeritagePhrase(
        ku: 'Dîyariya dawetê pir xweş bû.',
        tr: 'Düğün hediyesi çok güzeldi.',
      ),
      HeritagePhrase(
        ku: 'Em hemû bi hev re şa bûn.',
        tr: 'Hepimiz birlikte sevindik.',
      ),
    ],
  ),

  // ── 4. Newroza Me ─────────────────────────────────────────
  HeritageScenario(
    id: 'h_newroz',
    titleKu: 'Newroza Me',
    titleTr: 'Bizim Nevruz\'umuz',
    emoji: '🔥',
    category: 'celebration',
    culturalNote:
        'Newroz, Kawayê Hesinker efsanesinden günümüze 21 Mart\'ta '
        'kutlanır. Diaspora için kimlik günü.',
    phrases: [
      HeritagePhrase(
        ku: 'Newroz pîroz be!',
        tr: 'Nevruz kutlu olsun!',
      ),
      HeritagePhrase(
        ku: 'Em li dora agir digerin.',
        tr: 'Ateşin etrafında dönüyoruz.',
      ),
      HeritagePhrase(
        ku: 'Kawa zordariya Dehak hilweşand.',
        tr: 'Kawa, Dehak\'ın zulmünü yıktı.',
      ),
      HeritagePhrase(
        ku: 'Sala nû bi kêf û xêr be.',
        tr: 'Yeni yıl neşe ve hayırla gelsin.',
      ),
      HeritagePhrase(
        ku: 'Agir şahidê yekîtiya gel e.',
        tr: 'Ateş, halkın birliğinin tanığıdır.',
      ),
      HeritagePhrase(
        ku: 'Em bi rengên zer, sor û kesk xemilî ne.',
        tr: 'Sarı, kırmızı ve yeşil renklerle süsleniyoruz.',
      ),
      HeritagePhrase(
        ku: 'Newroz ne tenê bihar e, ew azadî jî ye.',
        tr: 'Nevruz sadece bahar değil, aynı zamanda özgürlüktür.',
      ),
    ],
  ),

  // ── 5. Çîrokên Pîrê ─────────────────────────────────────────
  HeritageScenario(
    id: 'h_cirok_pir',
    titleKu: 'Çîrokên Pîrê',
    titleTr: 'Nine\'nin Hikayeleri',
    emoji: '📚',
    category: 'conversation',
    culturalNote:
        'Çîrok (hikaye) dilin en doğal aktarıcısıdır — disleksi dostu, '
        'imgesel, tekrarlı yapı.',
    phrases: [
      HeritagePhrase(
        ku: 'Hebû tune bû, li gundekî dûr...',
        tr: 'Bir varmış bir yokmuş, uzak bir köyde...',
      ),
      HeritagePhrase(
        ku: 'Padîşahekî hebû, sê kurên wî hebûn.',
        tr: 'Bir padişah vardı, üç oğlu vardı.',
      ),
      HeritagePhrase(
        ku: 'Roj li pey rojan derbas bûn.',
        tr: 'Günler günleri kovaladı.',
      ),
      HeritagePhrase(
        ku: 'Bizin û hirç — bi hev re dost bûn.',
        tr: 'Keçi ile ayı — birbirleriyle dosttular.',
      ),
      HeritagePhrase(
        ku: 'Ji wê rojê ve em fêr bûn ku yekîtî hêz e.',
        tr: 'O günden beri birliğin güç olduğunu öğrendik.',
      ),
      HeritagePhrase(
        ku: 'Çîrok bi xêr û bi ken dawî bû.',
        tr: 'Hikaye hayır ve kahkahayla sona erdi.',
      ),
    ],
  ),
];

/// Kategori filtresi.
List<HeritageScenario> heritageScenariosByCategory(String category) =>
    kHeritageScenarios.where((s) => s.category == category).toList();

/// Track kontrolü — Kurmancî heritage yalnız Kurmancî track'te anlamlı.
/// İngilizce track'te boş liste döner.
/// Çocuk track'te yalnızca kitchen + celebration (karmaşık conversation yok).
List<HeritageScenario> heritageScenariosForTrack({
  required bool isEnglish,
  required bool isChild,
}) {
  if (isEnglish) return const [];
  if (isChild) {
    return kHeritageScenarios
        .where((s) => s.category == 'kitchen' || s.category == 'celebration')
        .toList();
  }
  return kHeritageScenarios;
}
