# -*- coding: utf-8 -*-
"""Madde başlarının Türkçe karşılığını sözlük verisiyle karşılaştırır.

Neden: Faz 2'de dört kayıtta sözcük yanlış anlamla öğretiliyordu
(*mêtingeh* "vicdan", *têkçûn* "asimilasyon", *destûr* "hak"). Bu hata türü
yazım ya da dilbilgisi denetimine takılmaz.

Yöntem: `Kurmanci/ku-tr-sozluk/data/ku-tr.tsv` (Wîkîferheng + FreeDict,
Kurmancî satırlar) madde başını içeriyorsa, LÛTKE'nin `tr` alanındaki her
karşılık sözlükteki karşılıklarla kök düzeyinde (ilk 4 harf) eşleştirilir.
Hiçbiri eşleşmiyorsa kayıt **şüpheli** sayılır.

Şüpheli = yanlış değil. Sözlük eksik olabilir, LÛTKE eşanlamlı bir karşılık
vermiş olabilir. Liste okunarak ayıklanır; karar verilenler
`anlam_muaf.tsv`ye (kimlik, gerekçe) yazılır ve bir daha çıkmaz.

Kullanım:
    python tools/qa/anlam_denetim.py            # özet + docs/olcum/anlam_supheli.tsv
    python tools/qa/anlam_denetim.py --goster   # listeyi ekrana da dök

Sözlük verisi CC BY-SA / GPL; yalnız doğrulama için okunur, uygulamaya girmez.
"""

import csv
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

PROJE = icerik.PROJE
SOZLUK = PROJE.parents[2] / "ku-tr-sozluk" / "data" / "ku-tr.tsv"
CIKTI = PROJE / "docs" / "olcum" / "anlam_supheli.tsv"
MUAF = Path(__file__).parent / "anlam_muaf.tsv"
TR_KUCUK = str.maketrans("İIÂÎÛ", "iıaiu")
BOS = {"bir", "ve", "ile", "için", "olan", "etmek", "olmak", "yapmak", "şey", "gibi", "çok", "daha",
       "the", "bu", "şu", "da", "de"}


def tr_kucuk(s: str) -> str:
    return icerik.nfc(s).translate(TR_KUCUK).lower().replace("â", "a").replace("î", "i").replace("û", "u")


def kokler(s: str) -> set:
    """Türkçe karşılıktaki anlamlı sözcüklerin ilk 4 harfi."""
    s = re.sub(r"\([^)]*\)", " ", tr_kucuk(s))
    return {t[:4] for t in re.findall(r"[a-zçğıöşü]+", s) if len(t) >= 3 and t not in BOS}


def sozluk() -> dict:
    d = defaultdict(set)
    if not SOZLUK.exists():
        return d
    with SOZLUK.open(encoding="utf-8", newline="") as f:
        for r in csv.DictReader(f, delimiter="\t"):
            if r["lehce"] == "kmr":
                d[icerik.nfc(r["kurdi"]).strip().lower()].add(r["turkce"])
    return d


def muaflar() -> dict:
    if not MUAF.exists():
        return {}
    with MUAF.open(encoding="utf-8", newline="") as f:
        return {r["kimlik"]: r["gerekce"] for r in csv.DictReader((s for s in f if not s.startswith("#")), delimiter="\t")}


def tara(kel: dict | None = None) -> dict:
    kel = kel or icerik.kelimeler(cocuk=True)
    d, muaf = sozluk(), muaflar()
    o = {"sozlukte": 0, "eslesen": 0, "muaf": 0, "supheli": []}
    if not d:
        return o
    gorulen = set()
    for duzey in kel:
        for k in kel[duzey]:
            m = icerik.nfc(k["ku"]).strip().lower().rstrip("!?.")
            if m in gorulen or m not in d:
                continue
            gorulen.add(m)
            o["sozlukte"] += 1
            soz = set().union(*(kokler(x) for x in d[m]))
            if kokler(k["tr"]) & soz or not kokler(k["tr"]):
                o["eslesen"] += 1
            elif k["id"] in muaf:
                o["muaf"] += 1
            else:
                o["supheli"].append([duzey, k["id"], k["ku"], k["tr"], " ; ".join(sorted(d[m]))[:160]])
    return o


def main() -> None:
    if not SOZLUK.exists():
        print("ku-tr-sozluk bulunamadı; anlam denetimi yalnız yerelde çalışır.")
        return
    o = tara()
    with CIKTI.open("w", encoding="utf-8", newline="") as f:
        y = csv.writer(f, delimiter="\t", lineterminator="\n")
        y.writerow(["duzey", "kimlik", "ku", "lutke_tr", "sozluk_tr"])
        y.writerows(o["supheli"])
    print(f"sözlükte bulunan madde başı {o['sozlukte']}; karşılığı eşleşen {o['eslesen']}; "
          f"incelenip muaf tutulan {o['muaf']}; şüpheli {len(o['supheli'])} -> {CIKTI.relative_to(PROJE)}")
    if "--goster" in sys.argv:
        for s in o["supheli"]:
            print(f"{s[1]:10} {s[2]:16} | {s[3][:34]:34} | {s[4][:90]}")


if __name__ == "__main__":
    main()
