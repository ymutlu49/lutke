# LÛTKE içerik ölçümü — 2026-10-11

`python tools/qa/olcum.py` üretir; elle düzenlenmez. Yöntem ve sınırlar: [README.md](README.md).

> **Uyarı:** `website/data/content.json` Dart kaynağından eski; ders ve kültür sayıları güncel olmayabilir.

## Tabana göre (2026-10-11)

| Ölçüt | Taban | Şimdi |
|---|---:|---:|
| Kelime kaydı (uygulama) | 4215 | 4236 |
| Açık dil denetimi işareti | 929 | 929 |
| î + y yazımı (azadîya) | 825 | 825 |
| Cinsiyet çelişkisi | 72 | 66 |
| İki kaynağın hemfikir olduğu cinsiyet hatası | 1 | 0 |
| Cinsiyeti doğrulanmış ad (dört kaynak) | 615 | 635 |
| Kesin cinsiyet çelişkisi (dört kaynak) | 1 | 0 |
| `nêr` işaretli, kendi örneğinde `-a` alan ad | 6 | 6 |
| Tanıksız madde | 155 | 158 |
| Çekirdek ilk 2.000'de eksik madde | 1076 | 1072 |
| Hazır sesi olan madde başı | %40,2 | %40,0 |
| Hazır sesi olan dinleme metni | 0 | 0 |

## 1. Envanter

Uygulamanın kullandığı listelerde **4.236 kelime kaydı** var (3.757 farklı madde); web sitesine giden dışa aktarımda 3.632. Çocuk modu ayrıca 92 kayıt taşır.

|  | A1 | A2 | B1 | B2 | C1 | C2 |
|---|---:|---:|---:|---:|---:|---:|
| Kelime kaydı (uygulama) | 517 | 721 | 1555 | 598 | 510 | 335 |
| Farklı madde | 498 | 710 | 1478 | 573 | 504 | 335 |
| Web sitesinde | 517 | 721 | 951 | 598 | 510 | 335 |
| Öbek olan madde | %19,7 | %29,8 | %59,4 | %59,5 | %86,7 | %84,5 |
| Yazılmış ders | 20 | 25 | 15 | 15 | 15 | 15 |
| Derslerdeki egzersiz | 101 | 129 | 90 | 90 | 90 | 90 |
| Derslerin hedeflediği kelime | %37,1 | %44,4 | %4,7 | %15,2 | %9,6 | %12,5 |

Toplam 105 ders, 590 egzersiz · dinleme 105 · konuşma 60 · yazma 80 · diyalog 8 · dilbilgisi konusu 10 (A1, A2) · atasözü 3.359 · kültür ögesi 155.

## 2. Örnek cümleler

`her` etkinliklerde kullanılan kümedir; `gen` yalnız kelime ayrıntısında görünür.

**`her` örnekleri**

|  | A1 | A2 | B1 | B2 | C1 | C2 |
|---|---:|---:|---:|---:|---:|---:|
| Örnek sayısı | 1034 | 1441 | 3106 | 1196 | 1020 | 670 |
| Ortalama sözcük | 3,98 | 3,91 | 3,48 | 3,63 | 3,84 | 4,09 |
| Sonunda nokta yok | %0,0 | %0,1 | %0,0 | %0,0 | %0,0 | %0,0 |
| En çok 2 sözcük | %1,2 | %13,8 | %20,2 | %17,2 | %16,8 | %15,2 |
| Maddenin aynısı | %0,0 | %0,8 | %7,3 | %9,8 | %25,4 | %32,8 |
| Yüklemsiz (sezgisel) | %12,3 | %18,8 | %39,7 | %53,4 | %78,0 | %77,6 |

**`gen` örnekleri**

|  | A1 | A2 | B1 | B2 | C1 | C2 |
|---|---:|---:|---:|---:|---:|---:|
| Örnek sayısı | 1026 | 1420 | 3106 | 1196 | 1020 | 669 |
| Ortalama sözcük | 3,59 | 3,05 | 2,44 | 2,31 | 2,49 | 2,44 |
| Sonunda nokta yok | %3,0 | %72,4 | %88,9 | %94,3 | %99,1 | %99,6 |
| En çok 2 sözcük | %5,8 | %37,7 | %63,1 | %69,1 | %70,8 | %73,4 |
| Maddenin aynısı | %2,2 | %6,5 | %28,7 | %32,6 | %42,9 | %46,8 |
| Yüklemsiz (sezgisel) | %12,5 | %66,3 | %83,4 | %88,0 | %97,0 | %97,9 |

Örneklerin hiçbirinde çeviri alanı yok.

## 3. Tanıklık (tek sözcüklü maddeler)

|  | A1 | A2 | B1 | B2 | C1 | C2 |
|---|---:|---:|---:|---:|---:|---:|
| Tek sözcüklü madde | 406 | 505 | 632 | 236 | 68 | 52 |
| ku-tr sözlükte | %93,1 | %86,7 | %75,5 | %83,9 | %66,2 | %65,4 |
| Wîkîferheng'de | %92,6 | %92,5 | %82,0 | %89,8 | %76,5 | %76,9 |
| Farqînî'de | %85,2 | %77,6 | %65,3 | %61,4 | %45,6 | %38,5 |
| Korpusta en az 5 kez | %90,1 | %76,8 | %56,5 | %57,2 | %30,9 | %42,3 |

Hiçbir kaynakta tanığı olmayan madde: **158** (A1 14, A2 22, B1 84, B2 17, C1 11, C2 10) → [taniksiz.tsv](taniksiz.tsv)

## 4. Çekirdek söz varlığı kapsamı

Çekirdek liste: korpusta en az 4 ayrı kaynakta geçen 3.772 madde başı, sıklık sırasıyla. Sütunlar o düzeyin sonuna kadar öğretilen maddelerle kapsanan payı gösterir (birikimli).

|  | A1 | A2 | B1 | B2 | C1 | C2 |
|---|---:|---:|---:|---:|---:|---:|
| En sık 500 | %40,2 | %58,4 | %73,8 | %75,6 | %76,2 | %76,6 |
| En sık 1.000 | %26,6 | %44,3 | %58,6 | %60,7 | %61,8 | %62,4 |
| En sık 2.000 | %17,0 | %29,9 | %42,7 | %44,9 | %46,0 | %46,4 |

İlk 2.000'de olup LÛTKE'de hiç geçmeyen: **1072** → [eksik_cekirdek.tsv](eksik_cekirdek.tsv)

En sık eksikler: *ko*, *baz*, *kevok*, *ma*, *van*, *beg*, *dîsan*, *car*, *ka*, *an*, *dû*, *tiştekî*, *herdu*, *selîm*, *pey*, *axa*, *hinekî*, *hertim*, *însan*, *herîn*, *dinya*, *ha*, *beden*, *law*, *bêdeng*, *hawar*, *welê*, *bîra*, *gor*, *carina*, *ken*, *dora*, *bêyî*, *kitab*, *yan*, *hingî*, *od*, *nik*, *jinik*, *hem*.

## 5. Cinsiyet (nêr / mê)

|  | Ad |
|---|---:|
| Tek sözcüklü, cinsiyetli farklı ad | 926 |
| En az bir bağımsız kaynağı olan | 647 |
| İki kaynakta da bulunan | 139 |
| İki kaynağın hemfikir olduğu | 132 |
| **İki kaynak hemfikir, LÛTKE farklı** | **0** |
| Yalnız korpus LÛTKE ile çelişiyor | 4 |
| Yalnız Wîkîferheng LÛTKE ile çelişiyor | 62 |
| İki kaynak birbiriyle çelişiyor | 7 |

Yukarıdaki tablo tabanla aynı yöntemi (Wîkîferheng + korpus) kullanır. Faz 2'de iki kaynak eklendi: Farqînî sözlüğünün madde içi izafe örnekleri (`Ziman/araclar/cinsfarq.py`) ve son ek kuralı (`tools/qa/cins_kanit.py`).

| Dört kaynakla | Ad |
|---|---:|
| En az bir kaynak LÛTKE ile aynı, hiçbiri karşı değil (**doğrulandı**) | **635** |
| En az iki kaynak karşı, hiçbiri yanında değil (**kesin çelişki**) | **0** |
| Tek kaynak karşı, yanında kaynak yok | 68 |
| Kaynaklar birbiriyle çelişiyor | 14 |
| Hiç kaynağı yok | 209 |
| Farqînî örneği olan | 147 |
| Son ek kuralının kapsadığı | 215 |
| `nêr` işaretli, kendi örnek cümlesinde `-a` izafesi almış | 6 |

Listeler: [cins_celiski.tsv](cins_celiski.tsv) (açık sorular), [cins_kanit.tsv](cins_kanit.tsv) (her adın kanıtı)

## 6. Dil denetimi (ortak denetleyici)

| Kural | Toplam | Muaf | Açık |
|---|---:|---:|---:|
| edat | 17 | 7 | 10 |
| ergatif | 1 | 1 | 0 |
| ergnav | 1 | 1 | 0 |
| izafe | 106 | 47 | 59 |
| norm | 848 | 2 | 846 |
| terim | 38 | 38 | 0 |
| yazim | 32 | 18 | 14 |
| **Toplam** | 1043 | 114 | **929** |

`norm` işaretlerinin 825 tanesi î + y yazımıdır (*azadîya* → *azadiya*). Açık işaretler: [ziman_isaret.tsv](ziman_isaret.tsv) · muafiyetler: `tools/qa/ziman_muaf.tsv`

## 7. Hazır ses kapsamı

|  | A1 | A2 | B1 | B2 | C1 | C2 | Tümü |
|---|---:|---:|---:|---:|---:|---:|---:|
| Madde başı | %68,1 | %58,9 | %38,8 | %36,8 | %11,8 | %9,9 | %40,0 |
| `her` cümleleri | %39,8 | %69,7 | %87,2 | %89,4 | %86,9 | %74,5 | %77,7 |
| `gen` cümleleri | %5,8 | %5,9 | %5,4 | %7,4 | %2,1 | %2,5 | %5,2 |

Dinleme metinleri: 0 / 105 · ses bildirimi 9.448 anahtar.

## 8. Atasözleri

3.359 atasözünün 5 tanesinde Türkçe harf (ı ğ ü ö â) var; en az dört sözcüklü 3.185 atasözünün 1.031 tanesinde hiç şapkalı ünlü (ê î û) yok.

## 9. Karara bağlanmamış yazım noktaları

Sayılır, işaretlenmez; karar: [../norm_uzlasmasi.md](../norm_uzlasmasi.md).

| Nokta | Biçim A | Sayı | Biçim B | Sayı |
|---|---:|---:|---:|---:|
| Dil adı (cümle içi) | Kurdî, Kurmancî | 239 | kurdî, kurmancî | 597 |
| Ay adı (cümle içi) | Adar, Gulan | 25 | adar, gulan | 0 |
| İkisi de | herdu | 3 | her du | 5 |
