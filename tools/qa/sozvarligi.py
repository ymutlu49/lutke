# -*- coding: utf-8 -*-
"""Söz varlığı ölçümü: çekirdek maddelerin madde başı açığı ve yinelenen kayıtlar.

İyileştirme planı Faz 4.1 ve 4.4.

`olcum.py`nin kapsam ölçüsü bir maddeyi, herhangi bir madde başının içinde
geçiyorsa "biliniyor" sayar: *Qebûl kirin* kaydı *kirin*i kapatır. Bu araç daha
dar sorar: çekirdek madde LÛTKE'de **kendi başına** bir kayıt mı?

    python tools/qa/sozvarligi.py          # özet + iki liste

Çıktılar (docs/olcum/):
    cekirdek_madde_eksik.tsv   en sık 500 maddeden kendi kaydı olmayanlar
    yinelenen.tsv              aynı madde başını taşıyan kayıtlar, sınıfıyla

Korpusa dayandığı için yalnız yerelde çalışır.
"""

import csv
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402
import olcum  # noqa: E402

CIKTI = olcum.CIKTI
ZIMAN = olcum.KURMANCI / "Ziman"
ILK = 500


def madde_baslari(kel: dict) -> dict:
    """küçük harfli madde başı -> [(düzey, kimlik, tr)]"""
    g = defaultdict(list)
    for d in kel:
        for k in kel[d]:
            g[olcum.kucuk(k["ku"]).rstrip("!?.")].append((d, k["id"], k["tr"]))
    return g


def cekirdek_eksik(kel: dict, coz) -> list:
    bas = madde_baslari(kel)
    # Çekimli madde başı (Ket, Dihat) mastarın kaydı sayılmaz; yalnız ad ve
    # sıfatlarda çekimli biçim (bajêr -> bajar) kökünü kapatır.
    kokler = set(bas)
    for m in bas:
        kok, tur = coz(m)
        if tur != "verb":
            kokler.add(kok)
    icinde = Counter()
    for m in bas:
        for t in m.split():
            icinde[t] += 1
            icinde[coz(t)[0]] += 1
    cikti = []
    with (ZIMAN / "siklik.tsv").open(encoding="utf-8", newline="") as f:
        for r in list(csv.DictReader(f, delimiter="\t"))[:ILK]:
            if r["madde"] not in kokler and r["tur"] != "name" and len(r["madde"]) > 1:
                cikti.append([r["sira"], r["madde"], r["tur"], r["n"], r["kaynak"], icinde[r["madde"]]])
    return cikti


def yinelenen(kel: dict) -> list:
    cikti = []
    for m, l in madde_baslari(kel).items():
        if len(l) < 2:
            continue
        duzeyler = [x[0] for x in l]
        ayni_duzey = len(set(duzeyler)) < len(duzeyler)
        ayni_anlam = len({x[2].split("/")[0].strip().lower() for x in l}) == 1
        sinif = ("aynı düzeyde, " if ayni_duzey else "düzeyler arası, ") + ("aynı karşılık" if ayni_anlam else "farklı karşılık")
        cikti.append([sinif, m, len(l), " | ".join(f"{d}:{i}={t}" for d, i, t in l)])
    cikti.sort(key=lambda s: (s[0], -s[2], s[1]))
    return cikti


def main() -> None:
    if not olcum.ziman_var():
        print("Ziman katmanı bulunamadı.")
        return
    kel = icerik.kelimeler(cocuk=False)
    coz = olcum.cozucu()
    e = cekirdek_eksik(kel, coz)
    olcum.tsv_yaz("cekirdek_madde_eksik.tsv", ["sira", "madde", "tur", "n", "kaynak", "baska_maddede_gecis"], e)
    y = yinelenen(kel)
    olcum.tsv_yaz("yinelenen.tsv", ["sinif", "madde", "kayit", "kayitlar"], y)
    print(f"En sık {ILK} çekirdek maddeden kendi kaydı olmayan: {len(e)}")
    for n in (100, 200, 300, 500):
        print(f"  ilk {n}: {sum(int(s[0]) <= n for s in e)}")
    print("  türe göre:", dict(Counter(s[2] for s in e).most_common()))
    print("  fiil:", ", ".join(s[1] for s in e if s[2] == "verb"))
    c = Counter(s[0] for s in y)
    print(f"Yinelenen madde başı: {len(y)}; fazladan kayıt: {sum(s[2] - 1 for s in y)}")
    for k, v in c.most_common():
        print(f"  {v:4}  {k}")


if __name__ == "__main__":
    main()
