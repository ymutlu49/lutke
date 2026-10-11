# -*- coding: utf-8 -*-
"""FerMat köprüsü: terim tabanından "Matematîk bi Kurmancî" birimi üretir.

İyileştirme planı Faz 7. Kaynak `Kurmanci/Ziman/terim.tsv` (FerMat'ın karara
bağlanmış terimleri). Tabloda 211 matematik teriminin Kurmancî tanımı
(`penase`), örnek cümlesi (`minak`), gündelik örneği (`rojane`) ve sınıf
düzeyi (`temen`) yazılı. Bu araç onlardan kelime kaydı üretir; hiçbir
Kurmancî metin burada yazılmaz ya da değiştirilmez.

Seçim:
    - alan = matematik, tanımı ve örneği dolu
    - sınıf düzeyi okul öncesi ya da 1. sınıf (P-1, 1)  -> A2 birimi
    - LÛTKE'de madde başı olarak zaten yoksa
    - tanımı ve örneği ortak dil denetiminden işaretsiz geçiyorsa

Cinsiyet `cins_kanit.py`deki kaynaklardan gelir; kaynak yoksa ya da kaynaklar
ayrışıyorsa `bêcins` yazılır (tahmin edilmez).

    python tools/qa/fermat.py            # özet + matematik_kelime_db.dart
    python tools/qa/fermat.py --dene     # yazma, yalnız göster

Korpusa dayandığı için yalnız yerelde çalışır.
"""

import csv
import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402
import cins_kanit  # noqa: E402

PROJE = icerik.PROJE
ZIMAN = PROJE.parents[2] / "Ziman"
DART = PROJE / "lib" / "features" / "lessons" / "domain" / "matematik_kelime_db.dart"
RAPOR = PROJE / "docs" / "olcum" / "fermat.tsv"
A2_TEMEN = {"P-1", "1"}
KAT = "matematîk"
HARF = "A-Za-zÇÊÎŞÛçêîşû"


def temiz_ad(ku: str) -> str:
    """'0️⃣ SIFIR' -> 'Sifir'; 'CÎH / MEKAN' -> 'Cîh'."""
    ad = ku.split("/")[0]
    ad = re.sub(r"[^" + HARF + r"' -]", "", ad).strip(" -")
    ad = re.sub(r"\s+", " ", ad)
    return ad[:1].upper() + ad[1:].lower() if ad.isupper() else ad


def temiz_cumle(s: str) -> str:
    s = icerik.nfc(s).strip().strip('"“”').strip()
    return re.sub(r"\s+", " ", s)


def izafe(ad: str, cins: str) -> str | None:
    m = ad.lower()
    if cins not in ("mê", "nêr") or " " in m:
        return None
    ek = "a" if cins == "mê" else "ê"
    if m.endswith("î"):
        return m[:-1] + "iy" + ek          # î + y -> iy (Rêbera Rastnivîsînê)
    return m + ("y" if m[-1] in "aeêiîouû" else "") + ek


def adaylar() -> tuple:
    sys.path.insert(0, str(ZIMAN / "araclar"))
    import kontrol
    ix, rakip = kontrol.indeks_oku(), {}
    kurallar = {"yazim", "ergatif", "ergnav", "lihev", "izafe", "nesne", "edat", "norm"}
    kel = icerik.kelimeler(cocuk=True)
    kontrol.EK_CINS = cins_kanit.lutke_cinsleri(kel)
    # Bu aracın daha önce ürettiği kayıtlar "zaten var" sayılmaz; yoksa ikinci
    # çalıştırmada birim boşalır.
    mevcut = {cins_kanit.kucuk(k["ku"]).rstrip("!?.") for d in kel for k in kel[d]
              if not k["id"].startswith("a2_mt_")}
    kontrol.EK_CINS = {m: g for m, g in kontrol.EK_CINS.items() if m in mevcut}
    secilen, neden, satir = [], Counter(), []
    with (ZIMAN / "terim.tsv").open(encoding="utf-8", newline="") as f:
        for r in csv.DictReader(f, delimiter="\t"):
            if r["alan"] != "matematik" or not r["penase"].strip() or not r["minak"].strip():
                continue
            if r["temen"].strip() not in A2_TEMEN:
                neden["sınıf düzeyi A2 dışı"] += 1
                continue
            ad = temiz_ad(r["ku"])
            durum = ""
            # Tek sözcük, ya da iki sözcüklü fiil (Jê derxistin). Çok sözcüklü
            # olanlar öğretmen kavramı (Pîvandina ne-standart), kelime değil.
            if not ad or len(ad.split()) > 2 or (len(ad.split()) == 2 and not ad.endswith("in")):
                durum = "çok sözcüklü kavram"
            elif ad.lower() in mevcut:
                durum = "LÛTKE'de zaten var"
            else:
                metinler = [temiz_cumle(r["minak"]), temiz_cumle(r["penase"])]
                isaret = [k for t in metinler for k, _, _ in kontrol.denetle_metin(t, kurallar, ix, rakip)]
                if isaret:
                    durum = "dil denetimi: " + ", ".join(sorted(set(isaret)))
            satir.append([ad, r["tr"], r["temen"], r["bes"], durum or "seçildi"])
            if durum:
                neden[durum.split(":")[0]] += 1
                continue
            mevcut.add(ad.lower())
            o = cins_kanit.bak(ad.lower())
            oy = {x for x in (o["w"], o["k"], o["f"], o["r"]) if x}
            cins = {"f": "mê", "m": "nêr"}[oy.pop()] if len(oy) == 1 else "bêcins"
            # Yer bildiren kavramlar (nav, çep) edat ve zarf olarak kullanılır; "di nava
            # ... de" kalıbındaki -a izafe sayılıp cins sözlüğünü yanıltmasın.
            if r["bes"].strip() == "TÊGEHÊN CIHÎ":
                cins = "bêcins"
            # "NAV / DER" = "iç / dış": ad ilk seçenekse karşılık da ilk seçenek.
            tr, en = r["tr"].strip(), r["en"].strip()
            if "/" in r["ku"]:
                tr = tr.split("/")[0].strip() if tr.count("/") == r["ku"].count("/") else tr
                en = en.split("/")[0].strip() if en.count("/") == r["ku"].count("/") else en
            secilen.append({"ad": ad, "tr": tr, "en": en, "cins": cins,
                            "ez": izafe(ad, cins), "bes": r["bes"].strip(),
                            "her": [temiz_cumle(r["minak"]), temiz_cumle(r["penase"])],
                            "gen": [temiz_cumle(r["rojane"])] if r["rojane"].strip() else []})
    # FerMat'ın kendi metni terime kaynakların söylediğinden başka cinsle izafe
    # takıyorsa (Çarçikê taybetî; kaynak: dişil) cins yazılmaz: terimde FerMat
    # esastır, ayrışma editöre bildirilir.
    ek = {o["ad"].lower(): {"mê": "f", "nêr": "m"}[o["cins"]] for o in secilen
          if o["cins"] != "bêcins" and " " not in o["ad"]}
    kontrol.EK_CINS = {**kontrol.EK_CINS, **ek}
    ayrisan = set()
    for o in secilen:
        for t in o["her"] + o["gen"]:
            for kural, _, mesaj in kontrol.denetle_metin(t, {"izafe"}, ix, rakip):
                m = re.search(r"— '(.+?)'", mesaj)
                if m and m.group(1) in ek:
                    ayrisan.add(m.group(1))
    for o in secilen:
        if o["ad"].lower() in ayrisan:
            o["cins"], o["ez"] = "bêcins", None
    neden["(cinsi yazılmadı: FerMat metni kaynakla ayrışıyor: " + ", ".join(sorted(ayrisan)) + ")"] = len(ayrisan)
    return secilen, neden, satir


def q(s: str) -> str:
    return "'" + s.replace(chr(92), chr(92) * 2).replace("'", chr(92) + "'") + "'"


def dart_yaz(secilen: list) -> None:
    d = ["// LÛTKE — Matematîk bi Kurmancî (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// `python tools/qa/fermat.py` üzerine yazar; elle düzenleme.",
         "// Kaynak: Kurmanci/Ziman/terim.tsv (FerMat terim tabanı). Tanım ve örnek",
         "// cümleler FerMat'tan aynen alınır; burada Kurmancî metin yazılmaz.",
         "",
         "// ignore_for_file: constant_identifier_names",
         "",
         "/// A2 — okul öncesi ve 1. sınıf düzeyindeki matematik terimleri.",
         "const kA2Matematik = ["]
    for i, o in enumerate(secilen, 1):
        tr = o["tr"][:1].upper() + o["tr"][1:]
        en = o["en"][:1].upper() + o["en"][1:]
        d += [f"  (id:{q('a2_mt_%02d' % i)}, ku:{q(o['ad'])}, tr:{q(tr)}, en:{q(en)},",
              f"   cins:{q(o['cins'])}, ez:{q(o['ez']) if o['ez'] else 'null'}, kat:{q(KAT)}, zor:0.75,",
              f"   not:{q('Matematik terimi: ' + o['tr'] + '. Tanım ve örnek FerMat terim tabanından.')},",
              "   her:[" + ", ".join(q(x) for x in o["her"]) + "],",
              "   gen:[" + ", ".join(q(x) for x in o["gen"]) + "]),",
              ""]
    d += ["];", ""]
    DART.write_text(chr(10).join(d), encoding="utf-8", newline=chr(10))


def main() -> None:
    if not (ZIMAN / "terim.tsv").exists():
        print("Ziman katmanı bulunamadı.")
        return
    secilen, neden, satir = adaylar()
    print(f"A2 için seçilen terim: {len(secilen)}  (cinsiyeti kaynaklı {sum(o['cins'] != 'bêcins' for o in secilen)})")
    for k, v in neden.most_common():
        print(f"  dışarıda {v:4}  {k}")
    print("  bölümlere göre:", dict(Counter(o["bes"] for o in secilen).most_common()))
    print("  " + ", ".join(o["ad"] for o in secilen))
    if "--dene" in sys.argv:
        return
    with RAPOR.open("w", encoding="utf-8", newline="") as f:
        y = csv.writer(f, delimiter="\t", lineterminator="\n")
        y.writerow(["ad", "tr", "temen", "bes", "durum"])
        y.writerows(satir)
    dart_yaz(secilen)
    print(f"-> {DART.relative_to(PROJE)}; rapor {RAPOR.relative_to(PROJE)}")


if __name__ == "__main__":
    main()
