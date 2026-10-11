// LÛTKE — Fiil kaydı (OTOMATİK ÜRETİLMİŞTİR)
//
// `python tools/qa/fiil.py` üzerine yazar; elle düzenleme.
// Geçişlilik Wîkîferheng'den, biçimler ve sayılar korpustan (bkz. tools/qa/fiil.py).

class Fiil {
  final String kimlik;      // kelime kaydının kimliği; madde başı değilse boş
  final String mastar;
  final bool gecisli;
  final String gecmis;      // geçmiş zaman kökü = 3. tekil kişi (got, hat)
  final String? gecmis1;    // geçişsizde 1. tekil kişi (hatim)
  final String? simdiki1;   // şimdiki zaman 1. tekil kişi (dibêjim)
  final String? emir;       // emir (bibêje)
  final int tanikCekimli;   // korpusta: min/te/wî/wê/me/we/wan + geçmiş
  final int tanikYalin;     // korpusta: geçişlide ez/tu/em/hûn + geçmiş; geçişsizde ew + geçmiş, ez + 1. kişi
  final String tr;          // Türkçe mastar

  const Fiil({
    required this.kimlik,
    required this.mastar,
    required this.gecisli,
    required this.gecmis,
    this.gecmis1,
    this.simdiki1,
    this.emir,
    required this.tanikCekimli,
    required this.tanikYalin,
    required this.tr,
  });
}

/// Mastar (küçük harf) → fiil kaydı. Yalnız kanıtı tutarlı fiiller.
const Map<String, Fiil> kFiiller = <String, Fiil>{
  'anîn': Fiil(kimlik: 'b1_200', mastar: 'anîn', gecisli: true, gecmis: 'anî', emir: 'biîne', tanikCekimli: 30, tanikYalin: 1, tr: 'Getirmek'),
  'avêtin': Fiil(kimlik: 'b1_400', mastar: 'avêtin', gecisli: true, gecmis: 'avêt', simdiki1: 'diavêjim', emir: 'biavêje', tanikCekimli: 3, tanikYalin: 0, tr: 'Atmak'),
  'berdan': Fiil(kimlik: 'b1_402', mastar: 'berdan', gecisli: true, gecmis: 'berda', tanikCekimli: 3, tanikYalin: 0, tr: 'Bırakmak'),
  'bezîn': Fiil(kimlik: 'a2_603', mastar: 'bezîn', gecisli: false, gecmis: 'bezî', simdiki1: 'dibezim', emir: 'bibeze', tanikCekimli: 0, tanikYalin: 3, tr: 'Koşmak'),
  'bihîstin': Fiil(kimlik: 'a1_597', mastar: 'bihîstin', gecisli: true, gecmis: 'bihîst', simdiki1: 'dibihîzim', tanikCekimli: 51, tanikYalin: 0, tr: 'Duymak'),
  'birin': Fiil(kimlik: 'b1_201', mastar: 'birin', gecisli: true, gecmis: 'bir', simdiki1: 'dibim', emir: 'bibe', tanikCekimli: 36, tanikYalin: 0, tr: 'Götürmek'),
  'birîn': Fiil(kimlik: 'a2_1706', mastar: 'birîn', gecisli: true, gecmis: 'birî', simdiki1: 'dibirim', emir: 'bibire', tanikCekimli: 31, tanikYalin: 2, tr: 'Kesmek'),
  'bûn': Fiil(kimlik: 'a1_cf_05', mastar: 'bûn', gecisli: false, gecmis: 'bû', gecmis1: 'bûm', simdiki1: 'dibim', emir: 'bibe', tanikCekimli: 0, tanikYalin: 111, tr: 'Olmak'),
  'dan': Fiil(kimlik: 'a1_cf_07', mastar: 'dan', gecisli: true, gecmis: 'da', simdiki1: 'didim', emir: 'bide', tanikCekimli: 228, tanikYalin: 9, tr: 'Vermek'),
  'danîn': Fiil(kimlik: 'b1_gn03', mastar: 'danîn', gecisli: true, gecmis: 'danî', tanikCekimli: 8, tanikYalin: 0, tr: 'Koymak'),
  'derketin': Fiil(kimlik: '', mastar: 'derketin', gecisli: false, gecmis: 'derket', gecmis1: 'derketim', simdiki1: 'derdikevim', tanikCekimli: 0, tanikYalin: 9, tr: 'Çıkmak'),
  'derxistin': Fiil(kimlik: 'b1_813', mastar: 'derxistin', gecisli: true, gecmis: 'derxist', simdiki1: 'derdixim', tanikCekimli: 5, tanikYalin: 0, tr: 'Çıkarmak'),
  'dîtin': Fiil(kimlik: 'b1_gn05', mastar: 'dîtin', gecisli: true, gecmis: 'dît', simdiki1: 'dibînim', emir: 'bibîne', tanikCekimli: 157, tanikYalin: 1, tr: 'Görmek'),
  'girtin': Fiil(kimlik: 'b1_401', mastar: 'girtin', gecisli: true, gecmis: 'girt', simdiki1: 'digirim', emir: 'bigire', tanikCekimli: 78, tanikYalin: 1, tr: 'Tutmak'),
  'gotin': Fiil(kimlik: 'a1_cf_02', mastar: 'gotin', gecisli: true, gecmis: 'got', simdiki1: 'dibêjim', emir: 'bibêje', tanikCekimli: 449, tanikYalin: 0, tr: 'Söylemek'),
  'hatin': Fiil(kimlik: 'a1_cf_03', mastar: 'hatin', gecisli: false, gecmis: 'hat', gecmis1: 'hatim', tanikCekimli: 0, tanikYalin: 97, tr: 'Gelmek'),
  'hildan': Fiil(kimlik: 'b1_gn02', mastar: 'hildan', gecisli: true, gecmis: 'hilda', tanikCekimli: 3, tanikYalin: 0, tr: 'Kaldırmak'),
  'hiştin': Fiil(kimlik: 'b1_gn10', mastar: 'hiştin', gecisli: true, gecmis: 'hişt', simdiki1: 'dihêlim', emir: 'bihêle', tanikCekimli: 5, tanikYalin: 0, tr: 'Bırakmak'),
  'ketin': Fiil(kimlik: 'a2_1504', mastar: 'ketin', gecisli: false, gecmis: 'ket', gecmis1: 'ketim', simdiki1: 'dikevim', emir: 'bikeve', tanikCekimli: 0, tanikYalin: 40, tr: 'Düşmek'),
  'kirin': Fiil(kimlik: 'a1_cf_01', mastar: 'kirin', gecisli: true, gecmis: 'kir', simdiki1: 'dikim', emir: 'bike', tanikCekimli: 241, tanikYalin: 0, tr: 'Yapmak'),
  'kişandin': Fiil(kimlik: 'b1_100', mastar: 'kişandin', gecisli: true, gecmis: 'kişand', simdiki1: 'dikişînim', emir: 'bikişîne', tanikCekimli: 15, tanikYalin: 0, tr: 'Çizmek'),
  'mirin': Fiil(kimlik: '', mastar: 'mirin', gecisli: false, gecmis: 'mir', gecmis1: 'mirim', emir: 'bimire', tanikCekimli: 0, tanikYalin: 11, tr: 'Ölmek'),
  'nêrîn': Fiil(kimlik: '', mastar: 'nêrîn', gecisli: true, gecmis: 'nêrî', simdiki1: 'dinêrim', emir: 'binêre', tanikCekimli: 16, tanikYalin: 0, tr: 'Bakmak'),
  'pirsîn': Fiil(kimlik: 'a2_715', mastar: 'pirsîn', gecisli: true, gecmis: 'pirsî', simdiki1: 'dipirsim', emir: 'bipirse', tanikCekimli: 76, tanikYalin: 0, tr: 'Sormak'),
  'rabûn': Fiil(kimlik: 'b1_lk18', mastar: 'rabûn', gecisli: false, gecmis: 'rabû', gecmis1: 'rabûm', simdiki1: 'radibim', tanikCekimli: 0, tanikYalin: 37, tr: 'Kalkmak'),
  'rûniştin': Fiil(kimlik: 'a1_595', mastar: 'rûniştin', gecisli: false, gecmis: 'rûnişt', gecmis1: 'rûniştim', simdiki1: 'rûdinim', tanikCekimli: 0, tanikYalin: 4, tr: 'Oturmak'),
  'sekinîn': Fiil(kimlik: 'a1_594', mastar: 'sekinîn', gecisli: false, gecmis: 'sekinî', gecmis1: 'sekinîm', simdiki1: 'disekinim', emir: 'bisekine', tanikCekimli: 0, tanikYalin: 5, tr: 'Durmak'),
  'vegerandin': Fiil(kimlik: 'b1_1151', mastar: 'vegerandin', gecisli: true, gecmis: 'vegerand', simdiki1: 'vedigerînim', tanikCekimli: 22, tanikYalin: 0, tr: 'Geri vermek'),
  'wergirtin': Fiil(kimlik: 'a2_416', mastar: 'wergirtin', gecisli: true, gecmis: 'wergirt', tanikCekimli: 3, tanikYalin: 0, tr: 'Almak'),
  'xwarin': Fiil(kimlik: '', mastar: 'xwarin', gecisli: true, gecmis: 'xwar', simdiki1: 'dixwim', emir: 'bixwe', tanikCekimli: 25, tanikYalin: 1, tr: 'Yemek'),
  'xwendin': Fiil(kimlik: 'a2_402', mastar: 'xwendin', gecisli: true, gecmis: 'xwend', simdiki1: 'dixwînim', emir: 'bixwîne', tanikCekimli: 11, tanikYalin: 0, tr: 'Okumak'),
  'xwestin': Fiil(kimlik: 'a2_408', mastar: 'xwestin', gecisli: true, gecmis: 'xwest', simdiki1: 'dixwazim', emir: 'bixwaze', tanikCekimli: 84, tanikYalin: 0, tr: 'İstemek'),
  'zewicîn': Fiil(kimlik: 'a2_040', mastar: 'zewicîn', gecisli: false, gecmis: 'zewicî', gecmis1: 'zewicîm', emir: 'bizewice', tanikCekimli: 0, tanikYalin: 4, tr: 'Evlenmek'),
  'çûn': Fiil(kimlik: 'a1_cf_04', mastar: 'çûn', gecisli: false, gecmis: 'çû', gecmis1: 'çûm', simdiki1: 'diçim', emir: 'biçe', tanikCekimli: 0, tanikYalin: 117, tr: 'Gitmek'),
  'şandin': Fiil(kimlik: 'a2_415', mastar: 'şandin', gecisli: true, gecmis: 'şand', simdiki1: 'dişînim', emir: 'bişîne', tanikCekimli: 9, tanikYalin: 0, tr: 'Göndermek'),
  'şewitandin': Fiil(kimlik: 'a2_1707', mastar: 'şewitandin', gecisli: true, gecmis: 'şewitand', simdiki1: 'dişewitînim', emir: 'bişewitîne', tanikCekimli: 7, tanikYalin: 0, tr: 'Yakmak'),
  'şikandin': Fiil(kimlik: 'a2_1530', mastar: 'şikandin', gecisli: true, gecmis: 'şikand', tanikCekimli: 6, tanikYalin: 0, tr: 'Kırmak'),
};
