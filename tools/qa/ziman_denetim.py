# -*- coding: utf-8 -*-
"""LÛTKE'nin Kurmancî metinlerini ortak dil denetleyicisinden geçirir.

Denetleyici bu depoda değil, çalışma alanının ortak katmanındadır:
`Kurmanci/Ziman/araclar/kontrol.py` (kurallar: `Kurmanci/Ziman/REBER.md`).
Korpusa dayandığı ve korpus telifli metinlerden oluştuğu için depoya
alınamaz; bu yüzden GitHub CI'da değil, **yerelde** çalışır. Ortak katman
bulunamazsa betik atlar ve 0 ile çıkar.

    python tools/qa/ziman_denetim.py                 # özet
    python tools/qa/ziman_denetim.py --goster izafe  # bir kuralın açık işaretleri
    python tools/qa/ziman_denetim.py --yaz           # açık işaretleri kayda geçir
    python tools/qa/ziman_denetim.py --kapi          # kayıtta olmayan YENİ işaret varsa 1

Denetleyici karar vermez, işaretler. Bu betik işaretleri üçe ayırır:

  muaf   `ziman_muaf.tsv`de gerekçesiyle yazılı (özel ad, şarkı adı, sahte uyarı)
  açık   incelenmeyi bekleyen; `docs/olcum/ziman_isaret.tsv`de kayıtlı
  yeni   kayıtta olmayan — son içerik değişikliğiyle gelmiş

`--kapi` yalnız "yeni"ye bakar: eski borç yayını durdurmaz, yeni hata durdurur.
"""

import csv
import os
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

PROJE = icerik.PROJE
KAYIT = PROJE / "docs" / "olcum" / "ziman_isaret.tsv"
MUAF = Path(__file__).parent / "ziman_muaf.tsv"
ALANLAR = ["kural", "grup", "kimlik", "alan", "mesaj", "metin"]

TR_HARF = re.compile(r"[ıİğĞüÜöÖ]")
# Ögeler arasına konur. "0." hem sözcük komşuluğunu keser (ergatif kuralı
# bitişik sözcüğe bakar) hem de noktası sayesinde çok sözcüklü kalıpların bir
# ögeden ötekine taşmasını önler. Öge başına 4 satır eder (bkz. tara()).
AYRAC = "\n\n0.\n\n"


def ziman_kok() -> Path | None:
    aday = os.environ.get("ZIMAN_KOK")
    kok = Path(aday) if aday else PROJE.parents[2] / "Ziman"
    return kok if (kok / "araclar" / "kontrol.py").exists() else None


def ku_kismi(s: str) -> str:
    """Karışık metinden Türkçe ayraç içi ve tırnak içi parçaları çıkarır."""
    s = re.sub(r"\([^()]*\)", lambda m: " " if TR_HARF.search(m.group(0)) else m.group(0), s)
    return re.sub(r'"[^"]*"|“[^”]*”', lambda m: " " if TR_HARF.search(m.group(0)) else m.group(0), s)


# Alıntı metinler: atasözleri, şiirler, şarkı sözleri. Derlendikleri ya da
# yazıldıkları biçimde durur; ağız biçimleri (ra/da, ko), eski yazım (ezê) ve
# serbest sözdizimi hata değildir. Yalnız yazı sistemi (Hawar dışı harf)
# denetlenir; kaynağa uygunlukları ayrı bir iştir (olgu denetimi).
ALINTI_GRUP = {"gotin", "cand_poems", "cand_songs"}


def tek_satir(s: str, dize: bool = False) -> str:
    """Ögeyi tek satıra indirir; denetleyicinin satır sayımı buna dayanır.

    Kültür metinleri elle satır kırılmış düzyazıdır: satır sonu cümle sonu
    değildir, ama boş satır ve liste imi (•, -, 1.) yeni bir birimdir. Bunlar
    noktaya çevrilir ki bir maddedeki `di` öbürüne taşmasın. `dize=True`
    (şiir, şarkı) her satırı ayrı birim sayar.
    """
    if dize:
        s = re.sub(r"\s*\n\s*", " . ", s)
    else:
        s = re.sub(r"\n\s*\n", " . ", s)
        s = re.sub(r"\n\s*(?=[•\-–—*]|\d+[.)])", " . ", s)
        s = s.replace("•", " . ")
    return " ".join(s.split())


def muafiyetler() -> list:
    if not MUAF.exists():
        return []
    with MUAF.open(encoding="utf-8") as f:
        return [(r["kural"], re.compile(r["desen"], re.I),
                 re.compile(r["kapsam"]) if r.get("kapsam") else None, r["gerekce"])
                for r in csv.DictReader((s for s in f if not s.startswith("#")), delimiter="\t")]


def tara() -> list | None:
    """Bütün işaretler: [dict(kural, grup, kimlik, alan, mesaj, metin, muaf)]"""
    kok = ziman_kok()
    if kok is None:
        return None
    sys.path.insert(0, str(kok / "araclar"))
    import kontrol

    ix = kontrol.indeks_oku()
    rakip = kontrol.terim_haritasi()
    # İzafe kuralına LÛTKE'nin kendi cins işaretlemesi verilir: bir kaydın
    # `cins` alanı ile herhangi bir cümlede o ada takılan izafe çelişiyorsa
    # ikisinden biri yanlıştır (bkz. cins_kanit.py).
    import cins_kanit
    kontrol.EK_CINS = cins_kanit.lutke_cinsleri()
    tum = {"yazim","ergatif", "ergnav", "lihev", "izafe", "nesne", "edat", "terim", "alinti", "norm"}

    gruplar = defaultdict(list)
    for grup, kimlik, alan, metin, karisik in icerik.tum_metinler():
        gruplar[grup].append((kimlik, alan, metin, tek_satir(ku_kismi(metin) if karisik else metin,
                                                             dize=grup in ALINTI_GRUP)))

    muaf = muafiyetler()
    isaretler = []
    for grup, ogeler in gruplar.items():
        kurallar = {"yazim"} if grup in ALINTI_GRUP else tum
        metin = AYRAC.join(o[3] for o in ogeler)
        for kural, satir, mesaj in kontrol.denetle_metin(metin, kurallar, ix, rakip if "terim" in kurallar else {}):
            kimlik, alan, ham, _ = ogeler[(satir - 1) // 4]
            anahtar = f"{mesaj} || {ham}"
            kapsam = f"{grup}:{kimlik}:{alan}"
            g = next((ger for k, d, kp, ger in muaf
                      if k in (kural, "*") and d.search(anahtar) and (kp is None or kp.search(kapsam))), None)
            isaretler.append({"kural": kural, "grup": grup, "kimlik": kimlik, "alan": alan,
                              "mesaj": " ".join(mesaj.split()),
                              "metin": " ".join(ham.split())[:160], "muaf": g})
    return isaretler


def kayit_oku() -> set:
    if not KAYIT.exists():
        return set()
    with KAYIT.open(encoding="utf-8") as f:
        return {(r["kural"], r["kimlik"], r["alan"], r["mesaj"]) for r in csv.DictReader(f, delimiter="\t")}


def ozet(isaretler: list) -> dict:
    """kural -> {toplam, muaf, acik}"""
    o = defaultdict(Counter)
    for i in isaretler:
        o[i["kural"]]["toplam"] += 1
        o[i["kural"]]["muaf" if i["muaf"] else "acik"] += 1
    return o


def main() -> None:
    arg = sys.argv[1:]
    isaretler = tara()
    if isaretler is None:
        print("Ziman katmanı bulunamadı (Kurmanci/Ziman) — dil denetimi atlandı.")
        print("Yerelde çalıştırın ya da ZIMAN_KOK ortam değişkenini verin.")
        return

    acik = [i for i in isaretler if not i["muaf"]]
    kayitli = kayit_oku()
    yeni = [i for i in acik if (i["kural"], i["kimlik"], i["alan"], i["mesaj"]) not in kayitli]

    o = ozet(isaretler)
    print(f"{'kural':9}{'toplam':>8}{'muaf':>7}{'açık':>7}")
    for k in sorted(o):
        print(f"{k:9}{o[k]['toplam']:>8}{o[k]['muaf']:>7}{o[k]['acik']:>7}")
    print(f"{'':9}{len(isaretler):>8}{len(isaretler) - len(acik):>7}{len(acik):>7}")
    if KAYIT.exists():
        print(f"\nkayıtlı açık işaret: {len(kayitli)} · kayıtta olmayan yeni: {len(yeni)}")

    if "--goster" in arg:
        hedef = arg[arg.index("--goster") + 1]
        for i in acik:
            if hedef in ("hepsi", i["kural"]):
                print(f"\n[{i['kural']}] {i['grup']} {i['kimlik']} · {i['alan']}\n    {i['metin']}\n    -> {i['mesaj']}")

    if "--yaz" in arg:
        KAYIT.parent.mkdir(parents=True, exist_ok=True)
        with KAYIT.open("w", encoding="utf-8", newline="") as f:
            wr = csv.DictWriter(f, fieldnames=ALANLAR, delimiter="\t", extrasaction="ignore")
            wr.writeheader()
            wr.writerows(sorted(acik, key=lambda i: (i["kural"], i["grup"], i["kimlik"], i["alan"])))
        print(f"\n{len(acik)} açık işaret -> {KAYIT.relative_to(PROJE)}")

    if "--kapi" in arg and yeni:
        print(f"\nKAPI: kayıtta olmayan {len(yeni)} yeni işaret")
        for i in yeni[:30]:
            print(f"  [{i['kural']}] {i['grup']} {i['kimlik']} · {i['alan']}: {i['mesaj']}")
        sys.exit(1)


if __name__ == "__main__":
    main()
