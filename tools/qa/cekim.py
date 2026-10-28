# -*- coding: utf-8 -*-
"""Şimdiki zaman çekim kaydı: fiil tablosundaki fiillerin kişi biçimleri ve olumsuzları.

Neden (2026-10-24, kaynak kitaplarla karşılaştırma): Fêrkera Kurdî, Kurmanji Complete ve
Türkçe İzahlı Gramer şimdiki zamanı kişi ekleriyle (-im, -î, -e, -in) ve olumsuzunu
(di- yerine na-) çekim tablosu ve dönüştürme alıştırmasıyla öğretiyor. LÛTKE'de bunun
alıştırması yoktu; yalnız dilbilgisi ipucunda 10 soru vardı.

Biçimler `fiil_db.dart`taki 1. tekil biçimden (dikim) türetilir, ama kural tek başına
yetmez: ünlüyle başlayan kökte "na-" kuralı *naavêjim* verir, korpusta yok (doğrusu
*navêjim*). Bu yüzden her biçim korpusta sınanır ve tabloya yalnız tanıklı biçim girer:

    şimdiki      ez dikim, tu dikî, ew dike, em/hûn/ew dikin — dördü de korpusta geçmeli
    olumsuz      ez nakim, ew nake — en az 2 geçiş; yoksa fiil olumsuz alıştırmasına girmez

    python tools/qa/cekim.py           # ölç, cekim_db.dart yaz

Korpusa dayandığı için yalnız yerelde çalışır. Korpus `fiil.py` ile aynı (cins.korpus_metni,
sağlam kaynaklar); sayılar uygulamada "korpusta N kez" diye gösterilir.
"""

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import fiil  # noqa: E402

DART = fiil.PROJE / "lib" / "features" / "lessons" / "domain" / "cekim_db.dart"
EN_AZ_OLUMSUZ = 2


def tablo() -> list:
    """fiil_db.dart → [(kimlik, mastar, tr, 1. tekil şimdiki)]"""
    metin = fiil.DART.read_text(encoding="utf-8")
    cikti = []
    for m in re.finditer(r"Fiil\(kimlik: '([^']*)', mastar: '([^']+)',(.*?)tr: '([^']+)'\)", metin):
        s1 = re.search(r"simdiki1: '([^']+)'", m.group(3))
        if s1:
            cikti.append((m.group(1), m.group(2), m.group(4), s1.group(1)))
    return cikti


def olc() -> list:
    tek, _ = fiil.korpus()
    satirlar = []
    for kimlik, mastar, tr, s1 in tablo():
        if not s1.endswith("im"):
            continue
        kok = s1[:-2]
        bicim = {"ez": s1, "tu": kok + "î", "ew": kok + "e", "pir": kok + "in"}
        n = {k: tek[b] for k, b in bicim.items()}
        neden = "" if all(n.values()) else "tanıksız biçim: " + ", ".join(bicim[k] for k in n if not n[k])
        neg = {}
        if s1.startswith("di"):  # derdikevim, rûdinim gibi önekli fiillerde olumsuz başka kurulur
            for k, b in (("ez", "na" + s1[2:]), ("ew", "na" + kok[2:] + "e")):
                if tek[b] >= EN_AZ_OLUMSUZ:
                    neg[k] = (b, tek[b])
        satirlar.append(dict(kimlik=kimlik, mastar=mastar, tr=tr, bicim=bicim, n=n, neden=neden, neg=neg))
    return satirlar


def dart_yaz(satirlar: list) -> int:
    q = lambda s: "'" + s.replace("\\", "\\\\").replace("'", "\\'") + "'"
    d = ["// LÛTKE — Şimdiki zaman çekim kaydı (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// `python tools/qa/cekim.py` üzerine yazar; elle düzenleme.",
         "// Biçimler fiil_db.dart'taki 1. tekil biçimden türetilir; yalnız korpusta tanıklı olanlar girer.",
         "",
         "class Cekim {",
         "  final String kimlik;     // kelime kaydının kimliği; madde başı değilse boş",
         "  final String mastar;",
         "  final String tr;         // Türkçe mastar",
         "  final String ez, tu, ew, pir;      // dixwim, dixwî, dixwe, dixwin (pir: em/hûn/ew)",
         "  final int nEz, nTu, nEw, nPir;     // korpusta geçiş sayıları",
         "  final String? neyiniEz, neyiniEw;  // naxwim, naxwe — korpusta en az 2 kez geçiyorsa",
         "  final int nNeyiniEz, nNeyiniEw;",
         "",
         "  const Cekim({required this.kimlik, required this.mastar, required this.tr,",
         "      required this.ez, required this.tu, required this.ew, required this.pir,",
         "      required this.nEz, required this.nTu, required this.nEw, required this.nPir,",
         "      this.neyiniEz, this.neyiniEw, this.nNeyiniEz = 0, this.nNeyiniEw = 0});",
         "}",
         "",
         "/// Dört şimdiki zaman biçimi de korpusta tanıklı fiiller.",
         "const List<Cekim> kCekimler = <Cekim>["]
    sayi = 0
    for s in satirlar:
        if s["neden"]:
            continue
        b, n, neg = s["bicim"], s["n"], s["neg"]
        alanlar = [f"kimlik: {q(s['kimlik'])}", f"mastar: {q(s['mastar'])}", f"tr: {q(s['tr'])}",
                   f"ez: {q(b['ez'])}", f"tu: {q(b['tu'])}", f"ew: {q(b['ew'])}", f"pir: {q(b['pir'])}",
                   f"nEz: {n['ez']}", f"nTu: {n['tu']}", f"nEw: {n['ew']}", f"nPir: {n['pir']}"]
        if "ez" in neg:
            alanlar += [f"neyiniEz: {q(neg['ez'][0])}", f"nNeyiniEz: {neg['ez'][1]}"]
        if "ew" in neg:
            alanlar += [f"neyiniEw: {q(neg['ew'][0])}", f"nNeyiniEw: {neg['ew'][1]}"]
        d.append("  Cekim(" + ", ".join(alanlar) + "),")
        sayi += 1
    d += ["];", ""]
    DART.write_text("\n".join(d), encoding="utf-8", newline="\n")
    return sayi


def main() -> None:
    satirlar = olc()
    for s in satirlar:
        print("%-11s %s%s" % (s["mastar"], "  ".join("%s(%d)" % (s["bicim"][k], s["n"][k]) for k in ("ez", "tu", "ew", "pir")),
                              ("  · olumsuz: " + ", ".join("%s(%d)" % v for v in s["neg"].values())) if s["neg"] else "")
              + (("  ✗ " + s["neden"]) if s["neden"] else ""))
    sayi = dart_yaz(satirlar)
    print("\n%s: %d fiil (%d olumsuzlu) · dışarıda %d" % (DART.relative_to(fiil.PROJE), sayi,
          sum(1 for s in satirlar if not s["neden"] and s["neg"]), sum(1 for s in satirlar if s["neden"])))


if __name__ == "__main__":
    main()
