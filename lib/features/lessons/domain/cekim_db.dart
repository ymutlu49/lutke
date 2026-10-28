// LÛTKE — Şimdiki zaman çekim kaydı (OTOMATİK ÜRETİLMİŞTİR)
//
// `python tools/qa/cekim.py` üzerine yazar; elle düzenleme.
// Biçimler fiil_db.dart'taki 1. tekil biçimden türetilir; yalnız korpusta tanıklı olanlar girer.

class Cekim {
  final String kimlik;     // kelime kaydının kimliği; madde başı değilse boş
  final String mastar;
  final String tr;         // Türkçe mastar
  final String ez, tu, ew, pir;      // dixwim, dixwî, dixwe, dixwin (pir: em/hûn/ew)
  final int nEz, nTu, nEw, nPir;     // korpusta geçiş sayıları
  final String? neyiniEz, neyiniEw;  // naxwim, naxwe — korpusta en az 2 kez geçiyorsa
  final int nNeyiniEz, nNeyiniEw;

  const Cekim({required this.kimlik, required this.mastar, required this.tr,
      required this.ez, required this.tu, required this.ew, required this.pir,
      required this.nEz, required this.nTu, required this.nEw, required this.nPir,
      this.neyiniEz, this.neyiniEw, this.nNeyiniEz = 0, this.nNeyiniEw = 0});
}

/// Dört şimdiki zaman biçimi de korpusta tanıklı fiiller.
const List<Cekim> kCekimler = <Cekim>[
  Cekim(kimlik: 'b1_400', mastar: 'avêtin', tr: 'Atmak', ez: 'diavêjim', tu: 'diavêjî', ew: 'diavêje', pir: 'diavêjin', nEz: 4, nTu: 2, nEw: 31, nPir: 10),
  Cekim(kimlik: 'a2_603', mastar: 'bezîn', tr: 'Koşmak', ez: 'dibezim', tu: 'dibezî', ew: 'dibeze', pir: 'dibezin', nEz: 3, nTu: 2, nEw: 17, nPir: 20),
  Cekim(kimlik: 'a1_597', mastar: 'bihîstin', tr: 'Duymak', ez: 'dibihîzim', tu: 'dibihîzî', ew: 'dibihîze', pir: 'dibihîzin', nEz: 5, nTu: 1, nEw: 24, nPir: 13, neyiniEz: 'nabihîzim', nNeyiniEz: 2, neyiniEw: 'nabihîze', nNeyiniEw: 7),
  Cekim(kimlik: 'b1_201', mastar: 'birin', tr: 'Götürmek', ez: 'dibim', tu: 'dibî', ew: 'dibe', pir: 'dibin', nEz: 81, nTu: 32, nEw: 2341, nPir: 1026, neyiniEz: 'nabim', nNeyiniEz: 11, neyiniEw: 'nabe', nNeyiniEw: 391),
  Cekim(kimlik: 'a2_1706', mastar: 'birîn', tr: 'Kesmek', ez: 'dibirim', tu: 'dibirî', ew: 'dibire', pir: 'dibirin', nEz: 9, nTu: 9, nEw: 61, nPir: 38, neyiniEw: 'nabire', nNeyiniEw: 2),
  Cekim(kimlik: 'a1_cf_05', mastar: 'bûn', tr: 'Olmak', ez: 'dibim', tu: 'dibî', ew: 'dibe', pir: 'dibin', nEz: 81, nTu: 32, nEw: 2341, nPir: 1026, neyiniEz: 'nabim', nNeyiniEz: 11, neyiniEw: 'nabe', nNeyiniEw: 391),
  Cekim(kimlik: 'a1_cf_07', mastar: 'dan', tr: 'Vermek', ez: 'didim', tu: 'didî', ew: 'dide', pir: 'didin', nEz: 52, nTu: 28, nEw: 1217, nPir: 356, neyiniEz: 'nadim', nNeyiniEz: 28, neyiniEw: 'nade', nNeyiniEw: 63),
  Cekim(kimlik: '', mastar: 'derketin', tr: 'Çıkmak', ez: 'derdikevim', tu: 'derdikevî', ew: 'derdikeve', pir: 'derdikevin', nEz: 7, nTu: 3, nEw: 265, nPir: 110),
  Cekim(kimlik: 'b1_813', mastar: 'derxistin', tr: 'Çıkarmak', ez: 'derdixim', tu: 'derdixî', ew: 'derdixe', pir: 'derdixin', nEz: 2, nTu: 2, nEw: 138, nPir: 33),
  Cekim(kimlik: 'b1_gn05', mastar: 'dîtin', tr: 'Görmek', ez: 'dibînim', tu: 'dibînî', ew: 'dibîne', pir: 'dibînin', nEz: 200, nTu: 86, nEw: 348, nPir: 164, neyiniEz: 'nabînim', nNeyiniEz: 22, neyiniEw: 'nabîne', nNeyiniEw: 52),
  Cekim(kimlik: 'b1_401', mastar: 'girtin', tr: 'Tutmak', ez: 'digirim', tu: 'digirî', ew: 'digire', pir: 'digirin', nEz: 14, nTu: 102, nEw: 390, nPir: 174, neyiniEz: 'nagirim', nNeyiniEz: 7, neyiniEw: 'nagire', nNeyiniEw: 48),
  Cekim(kimlik: 'a1_cf_02', mastar: 'gotin', tr: 'Söylemek', ez: 'dibêjim', tu: 'dibêjî', ew: 'dibêje', pir: 'dibêjin', nEz: 214, nTu: 101, nEw: 1333, nPir: 496, neyiniEz: 'nabêjim', nNeyiniEz: 23, neyiniEw: 'nabêje', nNeyiniEw: 36),
  Cekim(kimlik: 'b1_gn10', mastar: 'hiştin', tr: 'Bırakmak', ez: 'dihêlim', tu: 'dihêlî', ew: 'dihêle', pir: 'dihêlin', nEz: 10, nTu: 2, nEw: 44, nPir: 19, neyiniEz: 'nahêlim', nNeyiniEz: 9, neyiniEw: 'nahêle', nNeyiniEw: 19),
  Cekim(kimlik: 'a2_1504', mastar: 'ketin', tr: 'Düşmek', ez: 'dikevim', tu: 'dikevî', ew: 'dikeve', pir: 'dikevin', nEz: 34, nTu: 10, nEw: 776, nPir: 294, neyiniEz: 'nakevim', nNeyiniEz: 6, neyiniEw: 'nakeve', nNeyiniEw: 54),
  Cekim(kimlik: 'a1_cf_01', mastar: 'kirin', tr: 'Yapmak', ez: 'dikim', tu: 'dikî', ew: 'dike', pir: 'dikin', nEz: 519, nTu: 293, nEw: 2732, nPir: 1248, neyiniEz: 'nakim', nNeyiniEz: 98, neyiniEw: 'nake', nNeyiniEw: 304),
  Cekim(kimlik: '', mastar: 'nêrîn', tr: 'Bakmak', ez: 'dinêrim', tu: 'dinêrî', ew: 'dinêre', pir: 'dinêrin', nEz: 31, nTu: 38, nEw: 155, nPir: 30),
  Cekim(kimlik: 'a2_715', mastar: 'pirsîn', tr: 'Sormak', ez: 'dipirsim', tu: 'dipirsî', ew: 'dipirse', pir: 'dipirsin', nEz: 12, nTu: 33, nEw: 114, nPir: 29, neyiniEw: 'napirse', nNeyiniEw: 7),
  Cekim(kimlik: 'b1_lk18', mastar: 'rabûn', tr: 'Kalkmak', ez: 'radibim', tu: 'radibî', ew: 'radibe', pir: 'radibin', nEz: 16, nTu: 3, nEw: 291, nPir: 60),
  Cekim(kimlik: 'a1_595', mastar: 'rûniştin', tr: 'Oturmak', ez: 'rûdinim', tu: 'rûdinî', ew: 'rûdine', pir: 'rûdinin', nEz: 11, nTu: 8, nEw: 135, nPir: 50),
  Cekim(kimlik: 'a1_594', mastar: 'sekinîn', tr: 'Durmak', ez: 'disekinim', tu: 'disekinî', ew: 'disekine', pir: 'disekinin', nEz: 6, nTu: 10, nEw: 62, nPir: 22, neyiniEw: 'nasekine', nNeyiniEw: 14),
  Cekim(kimlik: '', mastar: 'xwarin', tr: 'Yemek', ez: 'dixwim', tu: 'dixwî', ew: 'dixwe', pir: 'dixwin', nEz: 59, nTu: 12, nEw: 91, nPir: 59, neyiniEz: 'naxwim', nNeyiniEz: 5, neyiniEw: 'naxwe', nNeyiniEw: 49),
  Cekim(kimlik: 'a2_402', mastar: 'xwendin', tr: 'Okumak', ez: 'dixwînim', tu: 'dixwînî', ew: 'dixwîne', pir: 'dixwînin', nEz: 23, nTu: 4, nEw: 71, nPir: 37, neyiniEw: 'naxwîne', nNeyiniEw: 6),
  Cekim(kimlik: 'a2_408', mastar: 'xwestin', tr: 'İstemek', ez: 'dixwazim', tu: 'dixwazî', ew: 'dixwaze', pir: 'dixwazin', nEz: 160, nTu: 81, nEw: 262, nPir: 158, neyiniEz: 'naxwazim', nNeyiniEz: 66, neyiniEw: 'naxwaze', nNeyiniEw: 38),
  Cekim(kimlik: 'a1_cf_04', mastar: 'çûn', tr: 'Gitmek', ez: 'diçim', tu: 'diçî', ew: 'diçe', pir: 'diçin', nEz: 105, nTu: 47, nEw: 438, nPir: 179, neyiniEz: 'naçim', nNeyiniEz: 21, neyiniEw: 'naçe', nNeyiniEw: 54),
  Cekim(kimlik: 'a2_1707', mastar: 'şewitandin', tr: 'Yakmak', ez: 'dişewitînim', tu: 'dişewitînî', ew: 'dişewitîne', pir: 'dişewitînin', nEz: 3, nTu: 1, nEw: 18, nPir: 3),
];
