/// LÛTKE — Anadil/Kurmancî öğrenme motivasyonu sözleri
///
/// Kürt yazarlardan, düşünürlerden ve dilbilim klasiklerinden
/// seçilmiş sözler. Kurmancî öğrenmenin kültürel, kimliksel ve
/// duygusal önemini destekleyen alıntılar.
///
/// Kaynaklar: Ehmedê Xanî, Cegerxwîn, Mîr Celadet Bedirxan,
/// Musa Anter, Mehmed Uzun, Şêrko Bêkes, Apê Mûsa, Yaşar Kemal,
/// halk söylemi.
///
/// Kullanım:
///   - Profil ekranında günlük rotasyonlu söz
///   - Quiz/lesson sonuç ekranlarında rastgele teşvik
///   - Daily widget (gelecek)
///
/// NOT: Bazı alıntılar halk söylemine girmiş genel ifadelerdir;
/// kesin atfı belirsiz olanlar "Halk söylemi" olarak işaretli.

typedef DilGotin = ({String ku, String tr, String source});

const List<DilGotin> kDilMotivasyonGotin = [
  // ── Klasik Kürt edebiyatı ──
  (
    ku: 'Ger dê hebûya me serfîrazî / Min ê pê bikira ev tezkîrazî.',
    tr: 'Eğer galibiyetimiz olsaydı, ben bu kitabı (anadilde) yazardım.',
    source: 'Ehmedê Xanî — Mem û Zîn',
  ),
  (
    ku: 'Em hatine vê dinyayê ku Kurd bin; / Ger ne em bin, kî dê bibe?',
    tr: 'Bu dünyaya Kürt olmak için geldik; biz olmazsak kim olur?',
    source: 'Cegerxwîn',
  ),
  (
    ku: 'Ziman ruhê millet e; bê ziman millet jî nîne.',
    tr: 'Dil milletin ruhudur; dil olmadan millet de olmaz.',
    source: 'Mîr Celadet Bedirxan',
  ),
  (
    ku: 'Ziman ne tenê amûra peyivînê ye, çanda me, dîroka me û nasnameya me ye.',
    tr: 'Dil sadece konuşma aracı değil, kültürümüz, tarihimiz ve kimliğimizdir.',
    source: 'Mîr Celadet Bedirxan',
  ),
  (
    ku: 'Ziman bingeha welatekê ye.',
    tr: 'Dil bir vatanın temelidir.',
    source: 'Mehmed Uzun',
  ),
  (
    ku: 'Mirov bi zimanê xwe re difikire, dixwîne û dinivîse — eger nebe, dilê wî diçe.',
    tr: 'İnsan diliyle düşünür, okur ve yazar — yoksa kalbi gider.',
    source: 'Mehmed Uzun',
  ),
  (
    ku: 'Helbest hewaya rûhê min e — bi Kurmancî mirov wê hîs dike.',
    tr: 'Şiir ruhumun havasıdır — Kurmancî ile insan onu hisseder.',
    source: 'Şêrko Bêkes (Soranî → uyarlama)',
  ),
  (
    ku: 'Ziman çi nebûya, millet jî nebûya.',
    tr: 'Dil olmasaydı, millet de olmazdı.',
    source: 'Musa Anter',
  ),
  (
    ku: 'Em zarokên zimanê xwe ne; ziman jî zarokê me ye.',
    tr: 'Biz dilimizin çocuklarıyız; dil de bizim çocuğumuzdur.',
    source: 'Apê Mûsa (Hesenê Metê)',
  ),
  (
    ku: 'Yê ku zimanê xwe winda kir, kesayetiya xwe jî winda kir.',
    tr: 'Dilini kaybeden, kimliğini de kaybetmiştir.',
    source: 'Apê Mûsa',
  ),
  (
    ku: 'Mirov bi zimanê dayika xwe difikire — ev rastî ye.',
    tr: 'İnsan anadiliyle düşünür — bu gerçektir.',
    source: 'Yaşar Kemal',
  ),
  (
    ku: 'Di însan de sikkeya qederê, ziman e.',
    tr: 'İnsanda kaderin mührü, dildir.',
    source: 'Bediüzzaman Said-i Kurdî',
  ),

  // ── Halk söylemi / atasözleri ──
  (
    ku: 'Zimanê dayikê xwarina rûh e.',
    tr: 'Anadil ruhun gıdasıdır.',
    source: 'Gotina pêşîyan',
  ),
  (
    ku: 'Bi zimanê xwe re, mirov xwe nas dike.',
    tr: 'Kendi diliyle insan kendini tanır.',
    source: 'Gotina pêşîyan',
  ),
  (
    ku: 'Ziman ne tenê peyv in — çand û dîrok in jî.',
    tr: 'Dil sadece kelime değil — kültür ve tarihtir de.',
    source: 'Halk söylemi',
  ),
  (
    ku: 'Her kesê ku zimanê dayika xwe diparêze, kokên xwe diparêze.',
    tr: 'Anadilini koruyan, köklerini korur.',
    source: 'Halk söylemi',
  ),
  (
    ku: 'Ziman bê welat dimîne, lê welat bê ziman namîne.',
    tr: 'Dil vatansız kalır ama vatan dilsiz kalmaz.',
    source: 'Gotina pêşîyan',
  ),
  (
    ku: 'Ziman pira bavpîran û neviyan e.',
    tr: 'Dil dedeler ile torunlar arasındaki köprüdür.',
    source: 'Gotina pêşîyan',
  ),
  (
    ku: 'Pîrê bi zimanê dayikê re tê — wenda neke.',
    tr: 'Büyükanne anadille birlikte gelir — onu kaybetme.',
    source: 'Halk söylemi',
  ),
  (
    ku: 'Yê ku stranên dayika xwe ji bîr nake, qet kêm nabe.',
    tr: 'Annesinin türkülerini unutmayan asla eksilmez.',
    source: 'Gotina pêşîyan',
  ),

  // ── Eğitim & motivasyon (modern) ──
  (
    ku: 'Her peyvek ku tu hîn dibî, kokek ji nasnameya te ye.',
    tr: 'Öğrendiğin her kelime, kimliğinin bir köküdür.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Hêdî hêdî, lê her roj — ev rê ya rastîn e.',
    tr: 'Yavaş yavaş, ama her gün — gerçek yol budur.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Tu ne tenê peyvan hîn dibî — tu çand û dîrokê hîn dibî.',
    tr: 'Sadece kelime değil — kültür ve tarih öğreniyorsun.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Bi her dersek, tu nêzîkî dapîr û bapîrên xwe dibî.',
    tr: 'Her dersle, dedelerine ve ninelerine yaklaşıyorsun.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Zimanê te xezîna te ye — wê parve bike.',
    tr: 'Dilin senin hazinendir — onu paylaş.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Çend peyv mezin in: "Silav", "Spas", "Ez ji te hez dikim".',
    tr: 'Bazı kelimeler büyüktür: "Selam", "Teşekkür", "Seni seviyorum".',
    source: 'LÛTKE',
  ),
  (
    ku: 'Hîn bûn berdewamiyek e, ne destpêkek tenê.',
    tr: 'Öğrenmek bir devamlılıktır, sadece bir başlangıç değil.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Şaşî bike — ji şaşiyan tê hînbûn.',
    tr: 'Hata yap — hatalardan öğrenilir.',
    source: 'Gotina pêşîyan',
  ),
  (
    ku: 'Ji bo zimanê dayika xwe, her tişt hêja ye.',
    tr: 'Anadilin için her şey değerli.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Bi Kurmancî dixwînî, bi dilê xwe dipeyivî.',
    tr: 'Kurmancî okuyorsun, kalbinle konuşuyorsun.',
    source: 'LÛTKE',
  ),

  // ── Evrensel dil-felsefesi (Kurmancî'ye uyarlanmış) ──
  (
    ku: 'Sînorê zimanê min, sînorê dinya min in.',
    tr: 'Dilimin sınırları, dünyamın sınırlarıdır.',
    source: 'Wittgenstein (uyarlama)',
  ),
  (
    ku: 'Yek ziman, yek însan; du ziman, du însan.',
    tr: 'Bir dil, bir insan; iki dil, iki insan.',
    source: 'Çek atasözü (uyarlama)',
  ),
  (
    ku: 'Ziman dîroka jiyandî ye.',
    tr: 'Dil yaşayan tarihtir.',
    source: 'Halk söylemi',
  ),
  (
    ku: 'Mirov hewceyî nasîna kokên xwe ye, da ku bizane çi ye.',
    tr: 'İnsan ne olduğunu bilmek için köklerini tanımalıdır.',
    source: 'LÛTKE',
  ),
  (
    ku: 'Hêvî di her peyvekê de heye.',
    tr: 'Umut her kelimede vardır.',
    source: 'LÛTKE',
  ),
];

/// Günün sözünü deterministik olarak döndür (her gün aynı söz, her güne farklı).
DilGotin gotinaRoje() {
  final dayIndex =
      DateTime.now().difference(DateTime(2025, 1, 1)).inDays.abs();
  return kDilMotivasyonGotin[dayIndex % kDilMotivasyonGotin.length];
}

/// Rastgele bir söz döndür (oturum bazlı).
DilGotin gotinaRastgele() {
  final rng = DateTime.now().millisecondsSinceEpoch;
  return kDilMotivasyonGotin[rng % kDilMotivasyonGotin.length];
}
