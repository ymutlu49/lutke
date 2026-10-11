# -*- coding: utf-8 -*-
"""Bağlı metinlerin düzeye uygunluğu (iyileştirme planı Faz 5).

Planın ölçüsü: düzey başına en az 12 okuma metni, metin başına 4–6 anlama
sorusu; her metin o düzeye kadar öğretilen maddelerle en az %95 kapsanmalı.

Kapsama: metindeki sözcüklerin (özel adlar dışında) kaçı, öğrencinin o düzeyin
sonuna kadar gördüğü madde başlarından biri ya da onun çekimli biçimi?
Çözümleme `Ziman/araclar/lemma.py` ile; en sık 150 işlev sözcüğü bilinen sayılır
(`cumle.bilinenler`).

    python tools/qa/metin.py            # okuma metinleri; docs/olcum/metin.tsv
    python tools/qa/metin.py --dart     # ayrıca sözlükçe tablosunu yaz (xwendin_sozlukce_db.dart)
    python tools/qa/metin.py --dosya <yol> --duzey b1    # herhangi bir metin dosyası

Korpusa dayandığı için yalnız yerelde çalışır.
"""

import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402
import olcum  # noqa: E402
import cumle  # noqa: E402

PROJE = icerik.PROJE
SEVIYE = icerik.DUZEYLER
ESIK = 95.0
HEDEF_METIN, HEDEF_SORU = 12, (4, 6)
SOZ_HAM = re.compile(r"[A-Za-zÇÊÎŞÛçêîşû]+(?:'[a-zçêîşû]+)?")
STR = icerik._STR


def _dizgiler(blok: str, alan: str) -> list:
    return [icerik._coz(m, 1) for m in re.finditer(alan + r"\s*:\s*" + STR, blok)]


def okuma_metinleri() -> list:
    """Xwendin kataloğunun kaynakları: [(kimlik, düzey, başlık, [satır], soru sayısı)]"""
    cikti = []
    h = (PROJE / "lib/features/cultural_content/domain/character_stories_db.dart").read_text(encoding="utf-8")
    for blok in h.split("CharacterStory(")[2:]:          # [0] başlık, [1] sınıf tanımı
        kimlik = _dizgiler(blok, "id")
        d = re.search(r"StoryLevel\.(\w+)", blok)
        if kimlik and d:
            cikti.append((kimlik[0], d.group(1), (_dizgiler(blok, "titleKu") or [""])[0],
                          _dizgiler(blok, "textKu"), blok.count("StoryQuestion(")))
    c = (PROJE / "lib/features/lessons/domain/heritage_c_dialogues.dart").read_text(encoding="utf-8")
    for blok in c.split("= HeritageDialogue(")[1:]:
        kimlik = _dizgiler(blok, "id")
        d = re.search(r"level\s*:\s*(\d)", blok)
        if kimlik and d:
            cikti.append((kimlik[0], SEVIYE[int(d.group(1)) - 1], (_dizgiler(blok, "title") or [""])[0],
                          _dizgiler(blok, "kurmanci"), 0))
    return cikti


EKLER = ("ekê", "ekî", "eke", "yên", "yan", "an", "ên", "ek", "yê", "ya", "yî", "ê", "î", "a", "o")
_tablo = {}


def tablo_bicimleri() -> set:
    if "b" not in _tablo:
        import cins_kanit
        _tablo["b"] = cins_kanit._bicimler()
    return _tablo["b"]


def ozel_adlar(satirlar: list) -> set:
    """Kişi ve yer adları: metinde hep büyük harfle yazılan ve sözlük tablosunda
    bulunmayan sözcükler (Karik, Zîlan), ya da cümle ortasında büyük harfle
    yazılanlar (Mem, Cizîr)."""
    hep_buyuk, kucuk_gecen, ortada = set(), set(), set()
    for s in satirlar:
        for cumle_ in re.split(r"(?<=[.!?:…])\s+", s):
            tok = SOZ_HAM.findall(cumle_)
            for i, t in enumerate(tok):
                (hep_buyuk if t[0].isupper() else kucuk_gecen).add(t.lower())
                if i and t[0].isupper():
                    ortada.add(t.lower())
    bicim = tablo_bicimleri()
    return ortada | {t for t in hep_buyuk - kucuk_gecen if t not in bicim}


def madde(t: str, bilinen: set, coz) -> str | None:
    """Sözcüğün bilinen maddesi; bilinmiyorsa None. Çözücü yanılırsa (çayê -> ça)
    çekim eki soyularak yeniden denenir."""
    m = coz(t)[0]
    if t in bilinen:
        return t
    if m in bilinen:
        return m
    for ek in EKLER:
        if t.endswith(ek) and len(t) - len(ek) >= 2 and t[:-len(ek)] in bilinen:
            return t[:-len(ek)]
    return None


def kapsama(satirlar: list, bilinen: set, coz) -> tuple:
    """(yüzde, sözcük sayısı, bilinmeyen maddeler sayacı)"""
    adlar = ozel_adlar(satirlar)
    n = bil = 0
    yok = Counter()
    for s in satirlar:
        for t in cumle.SOZ.findall(olcum.kucuk(s)):
            if t in adlar or len(t) == 1:
                continue
            n += 1
            if madde(t, bilinen, coz):
                bil += 1
            else:
                yok[coz(t)[0]] += 1
    return (100 * bil / n if n else 0.0), n, yok


DART = PROJE / "lib" / "features" / "lessons" / "domain" / "xwendin_sozlukce_db.dart"


def sozlukce(kel: dict, coz, bilinen: dict) -> dict:
    """metin kimliği -> [(sözcük, Türkçe)]: metnin düzeyinde öğretilmemiş ama
    LÛTKE'nin daha üst bir düzeyinde kaydı olan sözcükler. Karşılık LÛTKE'nin
    kendi kaydından gelir; sözlük verisi uygulamaya girmez."""
    kayit = {}
    for d in SEVIYE:
        for k in kel[d]:
            m = olcum.kucuk(k["ku"]).rstrip("!?.")
            if " " not in m:
                kayit.setdefault(m, k["tr"])
    hepsi = set(kayit)
    cikti = {}
    for kimlik, d, _, satirlar, _ in okuma_metinleri():
        adlar = ozel_adlar(satirlar)
        liste, gorulen = [], set()
        for s in satirlar:
            for t in cumle.SOZ.findall(olcum.kucuk(s)):
                if t in adlar or len(t) == 1 or madde(t, bilinen[d], coz):
                    continue
                m = madde(t, hepsi, coz)
                if m and m in kayit and m not in gorulen:
                    gorulen.add(m)
                    liste.append((m, kayit[m]))
        cikti[kimlik] = liste
    return cikti


def dart_yaz(sz: dict) -> None:
    def q(x):
        return "'" + x.replace(chr(92), chr(92) * 2).replace("'", chr(92) + "'") + "'"
    d = ["// LÛTKE — Okuma metinlerinin sözlükçesi (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// `python tools/qa/metin.py --dart` üzerine yazar; elle düzenleme.",
         "// Bir metnin düzeyinde öğretilmemiş ama daha üst düzeyde kaydı olan sözcükler;",
         "// Türkçe karşılık LÛTKE'nin kendi kelime kaydından gelir.",
         "",
         "/// Metin kimliği → (sözcük, Türkçe karşılık) çiftleri, metindeki sırayla.",
         "const Map<String, List<(String, String)>> kXwendinSozlukce = <String, List<(String, String)>>{"]
    for kimlik in sorted(sz):
        if sz[kimlik]:
            d.append(f"  {q(kimlik)}: [" + ", ".join(f"({q(a)}, {q(b)})" for a, b in sz[kimlik]) + "],")
    d += ["};", ""]
    DART.write_text(chr(10).join(d), encoding="utf-8", newline=chr(10))


def main() -> None:
    if not olcum.ziman_var():
        print("Ziman katmanı bulunamadı; metin ölçümü yalnız yerelde çalışır.")
        return
    kel = icerik.kelimeler(cocuk=False)
    coz = olcum.cozucu()
    bilinen = {d: cumle.bilinenler(kel, d, coz) for d in SEVIYE}
    arg = sys.argv[1:]
    if "--dosya" in arg:
        yol = Path(arg[arg.index("--dosya") + 1])
        d = arg[arg.index("--duzey") + 1].lower() if "--duzey" in arg else "b1"
        satirlar = [s for s in icerik.nfc(yol.read_text(encoding="utf-8")).splitlines() if s.strip()]
        for x in SEVIYE:
            y, n, yok = kapsama(satirlar, bilinen[x], coz)
            print(f"{x}: %{y:.1f}  ({n} sözcük)" + ("  <- hedef düzey" if x == d else ""))
        _, _, yok = kapsama(satirlar, bilinen[d], coz)
        print("bilinmeyen (sözlükçe adayı):", ", ".join(f"{m}×{c}" if c > 1 else m for m, c in yok.most_common(40)))
        return

    sz = sozlukce(kel, coz, bilinen)
    if "--dart" in arg:
        dart_yaz(sz)
        print(f"sözlükçe: {sum(len(v) for v in sz.values())} sözcük, {sum(bool(v) for v in sz.values())} metin -> {DART.relative_to(PROJE)}")
    satir, say = [], Counter()
    for kimlik, d, baslik, satirlar, soru in okuma_metinleri():
        y, n, yok = kapsama(satirlar, bilinen[d], coz)
        uygun = next((x for x in SEVIYE if kapsama(satirlar, bilinen[x], coz)[0] >= ESIK), "")
        say[d] += 1
        satir.append([kimlik, d, baslik, n, soru, f"{y:.1f}", uygun or "hiçbiri",
                      ", ".join(m for m, _ in yok.most_common(15))])
        print(f"{kimlik:16} {d}  {n:4} sözcük  {soru} soru  kapsama %{y:5.1f}  "
              f"%{ESIK:.0f}'e ulaştığı düzey: {uygun or 'hiçbiri'}")
        print(f"    bilinmeyen {len(yok)} madde, sözlükçede {len(sz[kimlik])}: " + ", ".join(m for m, _ in yok.most_common(10)))
    olcum.tsv_yaz("metin.tsv", ["kimlik", "duzey", "baslik", "sozcuk", "soru", "kapsama", "uygun_duzey", "bilinmeyen"], satir)
    print()
    print(f"Hedef: düzey başına {HEDEF_METIN} metin, metin başına {HEDEF_SORU[0]}–{HEDEF_SORU[1]} soru, kapsama en az %{ESIK:.0f}")
    print("Düzey başına metin: " + ", ".join(f"{d} {say[d]}" for d in SEVIYE))
    print(f"Ölçüyü tutan metin (kendi düzeyinde %{ESIK:.0f}): {sum(float(s[5]) >= ESIK for s in satir)} / {len(satir)}; "
          f"4–6 sorusu olan: {sum(HEDEF_SORU[0] <= s[4] <= HEDEF_SORU[1] for s in satir)} / {len(satir)}")


if __name__ == "__main__":
    main()
