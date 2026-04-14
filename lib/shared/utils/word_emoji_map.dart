/// Kelime bazli emoji haritasi -- gorsel hafiza icin
/// Kaynak: A1 kelime listesinden yaygin nesneler
const kWordEmojis = <String, String>{
  // Selamlama
  'Silav': '\u{1F44B}', 'Merheba': '\u{1F91D}', 'Oxir be': '\u{1F44B}',

  // Aile
  'D\u00EA': '\u{1F469}', 'Bav': '\u{1F468}', 'Dap\u00EEr': '\u{1F475}', 'Bap\u00EEr': '\u{1F474}',
  'Xwi\u015Fk': '\u{1F467}', 'Bira': '\u{1F466}', 'Zarok': '\u{1F476}', 'Ke\u00E7': '\u{1F467}', 'Kur': '\u{1F466}',
  'Malbat': '\u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467}\u{200D}\u{1F466}', 'Jin': '\u{1F469}', 'M\u00EAr': '\u{1F468}',

  // Yemek
  'Nan': '\u{1F35E}', 'Av': '\u{1F4A7}', '\u015E\u00EEr': '\u{1F95B}', '\u00C7ay': '\u{1F375}', 'Qehwe': '\u{2615}',
  'Go\u015Ft': '\u{1F969}', 'Mast': '\u{1F963}', 'R\u00FBn': '\u{1F9C8}', 'H\u00EAk': '\u{1F95A}',
  'Birinc': '\u{1F35A}', '\u015Eorbe': '\u{1F372}', 'Xw\u00EA': '\u{1F9C2}', '\u015Eekir': '\u{1F36C}',

  // Meyveler
  'S\u00EAv': '\u{1F34E}', 'Tir\u00EE': '\u{1F347}', 'M\u00FBz': '\u{1F34C}', 'Porteqal': '\u{1F34A}',
  'Hirm\u00EE': '\u{1F350}', 'Zebe\u015F': '\u{1F349}', 'F\u00EEstiq': '\u{1F95C}', 'G\u00FBz': '\u{1F330}',
  'Mi\u015Fmi\u015F': '\u{1F351}', 'G\u00EAlaz': '\u{1F352}', 'Xox': '\u{1F351}', 'Hinar': '\u{1F34E}',

  // Sebzeler
  '\u00CEsot': '\u{1F336}\u{FE0F}', 'Firing\u00EE': '\u{1F345}', 'Kartol': '\u{1F954}', 'P\u00EEvaz': '\u{1F9C5}',
  'S\u00EEr': '\u{1F9C4}', 'Gezer': '\u{1F955}', 'Xiyar': '\u{1F952}', 'Kelem': '\u{1F96C}',
  'Nok': '\u{1FAD8}', 'N\u00EEsk': '\u{1FAD8}', 'Sewze': '\u{1F966}',

  // Hayvanlar
  'Pis\u00EEk': '\u{1F431}', 'K\u00FB\u00E7ik': '\u{1F415}', 'Hesp': '\u{1F434}', 'Ker': '\u{1FACF}',
  '\u00C7\u00EAlek': '\u{1F404}', 'Mir\u00EE\u015Fk': '\u{1F414}', 'Mas\u00EE': '\u{1F41F}', '\u00C7\u00FBk': '\u{1F426}',
  'Mi\u015Fk': '\u{1F42D}', 'Mar': '\u{1F40D}', '\u015E\u00EAr': '\u{1F981}', 'Pez': '\u{1F411}',

  // Vucut
  'Ser': '\u{1F5E3}\u{FE0F}', '\u00C7av': '\u{1F441}\u{FE0F}', 'Guh': '\u{1F442}', 'Poz': '\u{1F443}',
  'Dev': '\u{1F444}', 'Didan': '\u{1F9B7}', 'Dest': '\u{270B}', 'Ling': '\u{1F9B6}',
  'Dil': '\u{2764}\u{FE0F}', 'Por': '\u{1F487}',

  // Renkler
  'Sor': '\u{1F534}', 'Kesk': '\u{1F7E2}', '\u015E\u00EEn': '\u{1F535}', 'Zer': '\u{1F7E1}',
  'Sp\u00EE': '\u{26AA}', 'Re\u015F': '\u{26AB}', 'Pembe': '\u{1FA77}', 'Mor': '\u{1F7E3}',

  // Ev
  'Mal': '\u{1F3E0}', 'Der\u00EE': '\u{1F6AA}', 'Pace': '\u{1FA9F}', 'Ode': '\u{1F6CF}\u{FE0F}',
  'Mitbax': '\u{1F373}', 'Kurs\u00EE': '\u{1FA91}', 'Mase': '\u{1FA91}', 'D\u00EEwar': '\u{1F9F1}',

  // Doga
  'Roj': '\u{2600}\u{FE0F}', 'Heyv': '\u{1F319}', 'St\u00EAr': '\u{2B50}', 'Ewr': '\u{2601}\u{FE0F}',
  'Baran': '\u{1F327}\u{FE0F}', 'Berf': '\u{2744}\u{FE0F}', 'Ba': '\u{1F4A8}', 'Tav': '\u{1F31E}',
  'Dar': '\u{1F333}', 'Gul': '\u{1F339}', '\u00C7iya': '\u{26F0}\u{FE0F}', 'Deryay\u00EE': '\u{1F30A}',
  'Gol\u00EA': '\u{1F3DE}\u{FE0F}', 'Zev\u00EE': '\u{1F33E}',

  // Sayilar
  'Yek': '1\u{FE0F}\u{20E3}', 'Du': '2\u{FE0F}\u{20E3}', 'S\u00EA': '3\u{FE0F}\u{20E3}',
  '\u00C7ar': '4\u{FE0F}\u{20E3}', 'P\u00EAnc': '5\u{FE0F}\u{20E3}',
  '\u015Ee\u015F': '6\u{FE0F}\u{20E3}', 'Heft': '7\u{FE0F}\u{20E3}', 'He\u015Ft': '8\u{FE0F}\u{20E3}',
  'Neh': '9\u{FE0F}\u{20E3}', 'Deh': '\u{1F51F}',

  // Ulasim
  'Erebe': '\u{1F697}', 'Otob\u00FBs': '\u{1F68C}', 'Tr\u00EAn': '\u{1F682}', 'Balafir': '\u{2708}\u{FE0F}',
  'Ke\u015Ft\u00EE': '\u{1F6A2}', 'Bisikl\u00EAt': '\u{1F6B2}',

  // Meslekler
  'Bij\u00EE\u015Fk': '\u{1F468}\u{200D}\u{2695}\u{FE0F}', 'Mamoste': '\u{1F468}\u{200D}\u{1F3EB}',
  'Cotkar': '\u{1F468}\u{200D}\u{1F33E}', 'Nanp\u00EAj': '\u{1F468}\u{200D}\u{1F373}',
  '\u015Eof\u00EAr': '\u{1F697}',

  // Giysi
  'Kiras': '\u{1F454}', 'Pantol': '\u{1F456}', 'Sol': '\u{1F45F}', 'Kumik': '\u{1F9E2}',
  'Gore': '\u{1F9E6}', '\u015Eal': '\u{1F9E3}',

  // Zaman
  'Sib\u00EA': '\u{1F305}', '\u00CAvar': '\u{1F306}', '\u015Eev': '\u{1F319}', 'N\u00EEvro': '\u{2600}\u{FE0F}',

  // Kultur
  'Newroz': '🔥', 'Govend': '💃', 'Stran': '🎵', 'Dengbêj': '🎤',

  // ── A1+A2 yetişkin DB'sinden yaygın ek kelimeler ──
  // Selamlama / sosyal
  'Spas': '🙏', 'Erê': '✅', 'Na': '❌', 'Bibore': '😔', 'Roj baş': '☀️',
  'Êvar baş': '🌆', 'Şev baş': '🌙', 'Şeva te xweş be': '🌙',
  'Bi xêr hatî': '🤗', 'Xatir': '👋', 'Xatirê te': '👋', 'Tu çawa yî': '🤔',

  // Aile (ek)
  'Hevjîn': '💑', 'Lawik': '👦',
  'Birê': '👦', 'Xwişka': '👧', 'Mam': '👨', 'Xal': '👨', 'Met': '👩',
  'Xaltî': '👩', 'Apê': '👨',

  // Vücut (ek)
  'Pê': '🦶', 'Devê': '👄', 'Çavê': '👁️', 'Stû': '🧣', 'Pişt': '🧍',

  // Yiyecek/içecek (ek)
  'Penîr': '🧀', 'Kerî': '🧈', 'Tirş': '🍋',
  'Şêv': '🍽️', 'Taştê': '🍳',
  'Çayê': '🍵', 'Şîrîn': '🍬',

  // Doğa / mevsim (ek)
  'Bihar': '🌸', 'Havîn': '☀️', 'Payîz': '🍂', 'Zivistan': '❄️',
  'Hewa': '🌤️', 'Avhewa': '🌦️',
  'Cemed': '🧊', 'Mij': '🌫️', 'Bahoz': '⛈️',

  // Hayvanlar (ek)
  'Karîk': '🐐', 'Beraz': '🐗', 'Kew': '🦃', 'Quling': '🦢', 'Mêş': '🐝',
  'Pirpirok': '🦋', 'Mîst': '🐭',

  // Ev / mobilya (ek)
  'Pencere': '🪟', 'Bûka': '🛏️', 'Cilşo': '🧺', 'Hemam': '🛁', 'Tewlîd': '🪑',
  'Berfirehe': '🛋️', 'Pirtûkxane': '📚', 'Saet': '🕐', 'Lampe': '💡',

  // Okul / eğitim
  'Dibistan': '🏫', 'Defter': '📓', 'Pênûs': '✏️',
  'Pirtûk': '📖', 'Xwendekar': '🎓', 'Tahta': '📋',
  'Ders': '📝', 'Pirs': '❓', 'Bersiv': '💡',

  // İş / meslek (ek)
  'Kar': '💼', 'Bizînes': '💼', 'Bijîjk': '👨‍⚕️', 'Hemşîre': '👩‍⚕️',
  'Polîs': '👮', 'Mihendis': '👨‍💻', 'Kesek': '🧑',

  // Şehir / yer
  'Bajar': '🏙️', 'Gund': '🏘️', 'Kuçe': '🛣️', 'Hespxan': '🏚️', 'Xanî': '🏠',
  'Park': '🌳', 'Baxçe': '🌷', 'Kanî': '⛲', 'Çem': '🏞️',
  'Gol': '🏞️', 'Behr': '🌊', 'Çiyê': '⛰️',

  // Ulaşım (ek)
  'Wesayit': '🚗', 'Texsî': '🚕', 'Motorsîklet': '🏍️', 'Pawer': '🚉',
  'Rê': '🛣️', 'Sefer': '🧳',

  // Teknoloji
  'Telefon': '📱', 'Komputer': '💻', 'Înternet': '🌐', 'Email': '📧',
  'Mesaj': '💬', 'Wêne': '🖼️', 'Vîdyo': '🎥', 'Muzîk': '🎶',

  // Sağlık (ek)
  'Tendurist': '💪', 'Nexweş': '🤒', 'Derman': '💊', 'Nexweşxane': '🏥',
  'Nexweşî': '🤧', 'Tab': '🌡️', 'Birîn': '🩹',

  // Duygu / his
  'Kêfxweş': '😊', 'Xemgîn': '😢', 'Hêrs': '😡', 'Tirs': '😨',
  'Kenê': '😄', 'Hez': '❤️', 'Evîn': '💕', 'Hêvî': '🌟',

  // Genel sıfat (rengder)
  'Mezin': '🐘', 'Biçûk': '🐭', 'Dirêj': '📏', 'Kurt': '📐', 'Bilind': '⬆️',
  'Nizm': '⬇️', 'Germ': '🔥', 'Sar': '❄️', 'Nû': '✨', 'Kevn': '📜',
  'Xweş': '😊', 'Xirab': '👎', 'Baş': '👍', 'Pîs': '🤢', 'Paqij': '✨',
  'Çê': '👍', 'Tal': '🌶️',

  // Eylem (leker) — yaygın fiiller
  'Çûn': '🚶', 'Hatin': '🏃', 'Razan': '😴',
  'Rabûn': '🌅', 'Xwendin': '📖', 'Nivîsîn': '✍️', 'Lîstîn': '🎮',
  'Stiran': '🎤', 'Reqisîn': '💃', 'Bazdan': '🏃', 'Bûn': '✨',
  'Dîtîn': '👀', 'Bihîstîn': '👂', 'Bêjin': '💬', 'Kirîn': '🛒',
  'Firotin': '💰', 'Şuştîn': '🧼', 'Çêkirin': '🔨', 'Xebitîn': '💼',

  // Zaman (ek)
  'Hefte': '📅', 'Meh': '📆', 'Sal': '🗓️', 'Demek': '⏳',
  'Niha': '⏰', 'Berê': '⏪', 'Piştre': '⏩', 'Îro': '📅', 'Sibê (gelecek)': '⏭️',
  'Duh': '⏮️',

  // Renk (ek)
  'Gewr': '⚪', 'Qehweyî': '🟤', 'Narencî': '🟠',

  // Sayılar (ek)
  'Sifir': '0️⃣', 'Bîst': '2️⃣0️⃣', 'Sed': '💯', 'Hezar': '🔢',

  // Giyim (ek)
  'Berg': '🧥', 'Çakêt': '🧥', 'Şewqe': '🎩', 'Pêlav': '👟', 'Çant': '👜',
};

/// Kelime icin emoji dondur (once kelime bazli, sonra kategori bazli)
String emojiForWord(String ku, String kat) {
  // Tam eslesme
  if (kWordEmojis.containsKey(ku)) return kWordEmojis[ku]!;
  // Kucuk harfle dene
  for (final entry in kWordEmojis.entries) {
    if (entry.key.toLowerCase() == ku.toLowerCase()) return entry.value;
  }
  // Kategori bazli fallback
  return _categoryEmoji(kat);
}

/// Kategori-bazlı emoji fallback — kelime-spesifik eşleşme yoksa
/// kategoriden bir emoji döner. 49+ DB kategorisinin tümü kapsanmış.
String _categoryEmoji(String kat) => switch (kat) {
  // Yüksek frekanslı kategoriler
  'silav' || 'selamlama'              => '\u{1F44B}',                 // 👋
  'malbat'                            => '\u{1F46A}',                 // 👪
  'xwarin'                            => '\u{1F37D}\u{FE0F}',         // 🍽️
  'vexwarin'                          => '\u{1F964}',                 // 🥤
  'ajal' || 'heywan'                  => '\u{1F43E}',                 // 🐾
  'reng'                              => '\u{1F3A8}',                 // 🎨
  'mal'                               => '\u{1F3E0}',                 // 🏠
  'beden' || 'las'                    => '\u{1FAC1}',                 // 🫁
  'cil'                               => '\u{1F455}',                 // 👕
  // Zaman / dem
  'dem'                               => '\u{23F0}',                  // ⏰
  'roj'                               => '\u{1F4C5}',                 // 📅
  'demsal' || 'werzî'                 => '\u{1F33B}',                 // 🌻
  'hewa'                              => '\u{1F324}\u{FE0F}',         // 🌤️
  // Sayılar / matematik
  'jimar' || 'hejmar'                 => '\u{1F522}',                 // 🔢
  // Doğa / yer
  'xweza'                             => '\u{1F33F}',                 // 🌿
  'cih' || 'bajêr'                    => '\u{1F4CD}',                 // 📍
  'welat'                             => '\u{1F30D}',                 // 🌍
  'ekoloji'                           => '\u{267B}\u{FE0F}',          // ♻️
  // Eylem / fiil
  'leker' || 'leker_ergatif' || 'ergatif' || 'ergatif_b2' => '\u{1F3AC}', // 🎬
  'bun'                               => '\u{1F4AB}',                 // 💫
  // Sıfat / zarf
  'rengder'                           => '\u{1F308}',                 // 🌈
  'soyut'                             => '\u{1F4AD}',                 // 💭
  // Fonksiyonel sözcükler
  'temel' || 'peyvben'                => '\u{1F4AC}',                 // 💬
  'daçek'                             => '\u{1F517}',                 // 🔗
  'cinavk'                            => '\u{1F464}',                 // 👤
  'pirs'                              => '\u{2753}',                  // ❓
  'neyekî'                            => '\u{26D4}',                  // ⛔
  'navdêr'                            => '\u{1F516}',                 // 🔖
  'rêziman'                           => '\u{1F4D0}',                 // 📐
  'alfabe'                            => '\u{1F524}',                 // 🔤
  // Eğitim / iş / pîşe
  'perwerde'                          => '\u{1F4DA}',                 // 📚
  'pîşe' || 'kar'                     => '\u{1F4BC}',                 // 💼
  'akademik'                          => '\u{1F393}',                 // 🎓
  'ziman'                             => '\u{1F5E3}\u{FE0F}',         // 🗣️
  'edebiyat'                          => '\u{1F4D6}',                 // 📖
  'huner'                             => '\u{1F3A8}',                 // 🎨
  // Sosyal / kültür / yaşam
  'civakî' || 'kimlik'                => '\u{1F465}',                 // 👥
  'jiyan'                             => '\u{1F31F}',                 // 🌟
  'çand'                              => '\u{1F3AD}',                 // 🎭
  'his' || 'psikoloji'                => '\u{2764}\u{FE0F}',          // ❤️
  'dua'                               => '\u{1F932}',                 // 🤲
  'siyaset'                           => '\u{1F3DB}\u{FE0F}',         // 🏛️
  'zagon'                             => '\u{2696}\u{FE0F}',          // ⚖️
  // Sağlık
  'tendurist'                         => '\u{1FA7A}',                 // 🩺
  // Yiyecek alt-kategorileri
  'mêwe'                              => '\u{1F34E}',                 // 🍎
  // Ulaşım / seyahat
  'gihanî' || 'rêwîtî'                => '\u{1F697}',                 // 🚗
  // Teknoloji / medya
  'teknoloji'                         => '\u{1F4BB}',                 // 💻
  'medya'                             => '\u{1F4FA}',                 // 📺
  'zanist'                            => '\u{1F52C}',                 // 🔬
  // Ticaret
  'aborî' || 'bazirganî' || 'cotkarî' => '\u{1F6D2}',                 // 🛒
  // Felsefe / din
  'felsefe'                           => '\u{1F914}',                 // 🤔
  'dîrok'                             => '\u{1F4DC}',                 // 📜
  // Halk edebiyatı
  'deyim'                             => '\u{1F4AC}',                 // 💬
  // Fallback — kelime kategorisi yok ise nötr
  _                                   => '\u{1F4D6}',                 // 📖 (varsayılan: kitap)
};
