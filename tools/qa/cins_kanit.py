# -*- coding: utf-8 -*-
"""LÛTKE'deki her adın cinsiyet (nêr / mê) kanıtı.

Bir adın cinsiyeti dört kaynakla karşılaştırılır:

    W  Wîkîferheng etiketi                       Ziman/cins-wikt.tsv
    K  korpusta `-a` / `-ê` izafe sayımı          Ziman/cins-ham.tsv  (en az 6, %80)
    F  Farqînî sözlüğünün madde içi izafe örneği  Ziman/cins-farq.tsv (cinsfarq.hukum)
    R  son ek kuralı                              aşağıdaki EK_KURALI

R dilbilgisi kitaplarındaki kuraldır (mastardan türeyen adlar ve `-î`, `-tî`,
`-geh`, `-xane`, `-name`, `-îzm` ile biten adlar dişildir) ve Wîkîferheng'in
52 bin adında ölçülmüştür: listedeki her ek için oran en az %98. Oranlar
`python tools/qa/cins_kanit.py --kural` ile yeniden ölçülür. R bir genellemedir:
ada özgü bir kaynak (W, K, F) LÛTKE'yi doğruluyorsa R'nin karşı oyu sayılmaz
(*hestî* eril; kural onu dişil sanar).

Sınıflar:
    doğrulandı            en az bir kaynak LÛTKE ile aynı, hiçbiri karşı değil
    kesin çelişki         en az iki kaynak karşı, hiçbiri yanında değil
    tek kaynak çelişiyor  bir kaynak karşı, yanında kaynak yok
    kaynaklar ayrışıyor   hem yanında hem karşısında kaynak var
    kaynak yok

Ayrıca `kendi_ornegi`: kayıt `nêr` işaretli ama kendi örnek cümlesinde madde
başı `-a` izafesi almış. (`-ê` yönü burada sayılmaz: dişil adın çekimli hâli de
`-ê` alır. O yönü `ziman_denetim.py` bağlamı eleyerek denetler.)

Kullanım:
    python tools/qa/cins_kanit.py            # özet
    python tools/qa/cins_kanit.py --kural    # son ek kurallarının ölçümü
    python tools/qa/cins_kanit.py tevger av  # tek tek

Korpusa ve sözlük verisine dayandığı için yalnız yerelde çalışır.
"""

import csv
import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

PROJE = icerik.PROJE
KURMANCI = PROJE.parents[2]
ZIMAN = KURMANCI / "Ziman"
SEVIYE = icerik.DUZEYLER
TEK = re.compile(r"[a-zçêîşû']+")
CINS = {"nêr": "m", "mê": "f"}
AD = {"f": "mê", "m": "nêr"}

# (ek, en kısa sözcük uzunluğu). Uzun ek önce denenir.
# Listede OLMAYANLAR ve nedeni: `-dan` alıntı sözcükleri de yakalıyor (meydan,
# wîjdan, cizdan); `-in` %94'te kalıyor; `-stan`, `-dank`, `-ok`, `-ek` %95'in altında.
EK_KURALI = [
    ("kirin", 7), ("girtin", 8), ("xistin", 9), ("ketin", 7), ("andin", 7),
    ("bûn", 5), ("çûn", 5), ("tin", 6),
    ("vanî", 6), ("karî", 6), ("darî", 6), ("nasî", 6), ("zanî", 6), ("lojî", 6), ("grafî", 7),
    ("îtî", 5), ("atî", 5), ("ahî", 5), ("ayî", 5), ("anî", 6), ("tî", 5), ("yî", 5), ("î", 6),
    ("xane", 6), ("name", 6), ("geh", 5), ("îzm", 5), ("syon", 6),
]
EK_KURALI.sort(key=lambda x: -len(x[0]))
# Yalın `-î` soyut ad ekidir (azad -> azadî) ama her `-î` ek değildir (fasûlî,
# birazî, xwarzî; çekimli *kiloyekî*). Bu üç ek yalnız gövde ayrı bir sözcük
# olarak biliniyorsa uygulanır.
GOVDE_SARTI = {"î": (1,), "tî": (2, 1), "yî": (2, 1)}

IC_ILGEC = {"de", "da", "re", "ra", "ve", "va"}
_onbellek = {}


def kucuk(s: str) -> str:
    return icerik.nfc(s).strip().lower().replace("İ", "i")


def tsv(yol: Path) -> list:
    if not yol.exists():
        return []
    with yol.open(encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f, delimiter="\t"))


def var() -> bool:
    return all((ZIMAN / a).exists() for a in ("cins-wikt.tsv", "cins-ham.tsv", "cins-farq.tsv"))


def _bicimler() -> set:
    if "b" not in _onbellek:
        _onbellek["b"] = {r["bicim"] for r in tsv(ZIMAN / "lemma.tsv")}
    return _onbellek["b"]


def kural(m: str):
    """Son ek kuralı uyuyorsa ('f', ek), uymuyorsa (None, '')."""
    for ek, enaz in EK_KURALI:
        if not m.endswith(ek) or len(m) < enaz:
            continue
        if ek in GOVDE_SARTI:
            if m.endswith("ekî") or not any(m[:-n] in _bicimler() for n in GOVDE_SARTI[ek]):
                return None, ""
        return "f", "-" + ek
    return None, ""


def kendi_ornekleri(k: dict) -> tuple:
    """Kaydın kendi örnek ve notunda madde başına eklenen izafe: (-a, -ê)."""
    m = re.escape(kucuk(k["ku"]))
    t = kucuk(" . ".join([*(k.get("her") or []), *(k.get("gen") or []), k.get("not") or ""]))
    a = e = 0
    for z in re.finditer(r"(?<![a-zçêîşû])" + m + r"(y?a|y?ê)\s+([a-zçêîşû]{2,})", t):
        if z.group(1).endswith("a"):
            a += 1
        elif z.group(2) not in IC_ILGEC:
            e += 1
    return a, e


def _kaynaklar() -> tuple:
    if "k" not in _onbellek:
        sys.path.insert(0, str(ZIMAN / "araclar"))
        import cinsfarq  # noqa: E402
        _onbellek["k"] = (
            {r["kok"]: r["cins"] for r in tsv(ZIMAN / "cins-wikt.tsv")},
            {r["kok"]: (int(r["izafe_a"]), int(r["izafe_e"])) for r in tsv(ZIMAN / "cins-ham.tsv")},
            {r["kok"]: (int(r["izafe_a"]), int(r["izafe_e"])) for r in tsv(ZIMAN / "cins-farq.tsv")},
            cinsfarq.hukum,
        )
    return _onbellek["k"]


def bak(m: str, lut: str | None = None) -> dict:
    """Bir kökün dört kaynaktaki durumu. `lut` verilirse sınıf da hesaplanır."""
    wikt, ham, farq, hukum = _kaynaklar()
    w = wikt.get(m) if wikt.get(m) in ("f", "m") else None
    a, e = ham.get(m, (0, 0))
    kor = None
    if a + e >= 6:
        kor = "f" if a / (a + e) >= 0.8 else "m" if e / (a + e) >= 0.8 else None
    fa, fe = farq.get(m, (0, 0))
    far = hukum(fa, fe)
    r, ek = kural(m)
    o = {"w": w, "k": kor, "ka": a, "ke": e, "f": far, "fa": fa, "fe": fe, "r": r, "ek": ek}
    ozel = [x for x in (w, kor, far) if x]
    oy = ozel + ([r] if r else [])
    if lut and ozel and all(x == lut for x in ozel):
        oy = ozel          # R genellemedir; ada özgü kanıt varken karşı oyu sayılmaz
    o["oy"] = oy
    if lut:
        yana = sum(x == lut for x in oy)
        karsi = len(oy) - yana
        o["sinif"] = ("kaynak yok" if not oy else "doğrulandı" if karsi == 0
                      else "kesin çelişki" if yana == 0 and karsi >= 2
                      else "tek kaynak çelişiyor" if yana == 0 else "kaynaklar ayrışıyor")
    return o


def kanit(kel: dict | None = None) -> list:
    """Tek sözcüklü, cinsiyetli her farklı ad için bir kayıt."""
    kel = kel or icerik.kelimeler(cocuk=True)
    cikti, gorulen = [], set()
    for d in SEVIYE:
        for k in kel[d]:
            m = kucuk(k["ku"])
            if k["cins"] not in CINS or not TEK.fullmatch(m) or m in gorulen:
                continue
            gorulen.add(m)
            lut = CINS[k["cins"]]
            o = bak(m, lut)
            oa, oe = kendi_ornekleri(k)
            o.update(duzey=d, kimlik=k["id"], ad=k["ku"], kok=m, lutke=lut, ez=k["ez"] or "",
                     oa=oa, oe=oe, kendi=bool(lut == "m" and oa))
            cikti.append(o)
    return cikti


def cakisanlar(kel: dict | None = None) -> dict:
    """Aynı madde başını taşıyan kayıtlarda farklı cins: kök -> [(kimlik, cins)].

    `kanit()` her madde başının yalnız ilk kaydına bakar; yinelenen kayıt başka
    cinsle işaretliyse bu denetim olmadan görünmez (Faz 2'de 31 kök gözden
    kaçtı: *Roj* A1'de mê, B1'de nêr). Hedef: boş.
    """
    kel = kel or icerik.kelimeler(cocuk=True)
    g = {}
    for d in kel:
        for k in kel[d]:
            m = kucuk(k["ku"])
            if k["cins"] in CINS and TEK.fullmatch(m):
                g.setdefault(m, []).append((k["id"], k["cins"]))
    return {m: l for m, l in g.items() if len({c for _, c in l}) > 1}


def lutke_cinsleri(kel: dict | None = None) -> dict:
    """kök -> 'f' / 'm': LÛTKE'nin kendi işaretlemesi (denetleyicinin izafe kuralına verilir).

    Aynı kök iki kayıtta farklı cinsle geçiyorsa alınmaz.
    """
    kel = kel or icerik.kelimeler(cocuk=True)
    o, cakisan = {}, set()
    for d in kel:
        for k in kel[d]:
            m = kucuk(k["ku"])
            if k["cins"] not in CINS or not TEK.fullmatch(m):
                continue
            if m in o and o[m] != CINS[k["cins"]]:
                cakisan.add(m)
            o[m] = CINS[k["cins"]]
    return {m: g for m, g in o.items() if m not in cakisan}


BASLIK = ["sinif", "duzey", "kimlik", "ad", "lutke", "ez", "wikiferheng", "korpus_a", "korpus_e",
          "farqini_a", "farqini_e", "kural", "ornek_a", "ornek_e", "kendi_ornegi"]
SIRA = {"kesin çelişki": 0, "tek kaynak çelişiyor": 1, "kaynaklar ayrışıyor": 2, "kaynak yok": 3, "doğrulandı": 4}


def satir(o: dict) -> list:
    return [o["sinif"], o["duzey"], o["kimlik"], o["ad"], AD[o["lutke"]], o["ez"], AD.get(o["w"], ""),
            o["ka"], o["ke"], o["fa"], o["fe"], o["ek"], o["oa"], o["oe"], "çelişiyor" if o["kendi"] else ""]


def sirala(kayitlar: list) -> list:
    return sorted(kayitlar, key=lambda o: (SIRA[o["sinif"]], SEVIYE.index(o["duzey"]), o["kimlik"]))


DART = PROJE / "lib" / "features" / "lessons" / "domain" / "cins_kanit_db.dart"


def kanit_ozeti(o: dict) -> str:
    """Öğrenciye gösterilebilecek kısa kanıt: LÛTKE ile aynı yönü gösteren kaynaklar."""
    p = []
    if o["w"] == o["lutke"]:
        p.append("Wîkîferheng")
    if o["k"] == o["lutke"]:
        p.append(f"korpus -a {o['ka']} / -ê {o['ke']}")
    if o["f"] == o["lutke"]:
        p.append("Farqînî")
    if o["r"] == o["lutke"]:
        p.append(f"son ek {o['ek']}")
    return "; ".join(p)


def dart_yaz() -> int:
    """Cinsiyeti doğrulanmış adların kanıt tablosu (biçim alıştırmaları bunu kullanır)."""
    ks = [o for o in sirala(kanit()) if o["sinif"] == "doğrulandı"]
    def q(s):
        return "'" + s.replace("\\", "\\\\").replace("'", "\\'") + "'"
    d = ["// LÛTKE — Cinsiyeti doğrulanmış adlar (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// `python tools/qa/cins_kanit.py --dart` üzerine yazar; elle düzenleme.",
         "// Buraya yalnız en az bir bağımsız kaynağın LÛTKE ile aynı cinsi gösterdiği,",
         "// hiçbir kaynağın karşı çıkmadığı adlar girer (bkz. tools/qa/cins_kanit.py).",
         "",
         "/// Kelime kimliği → kanıt özeti.",
         "const Map<String, String> kCinsKaniti = <String, String>{"]
    d += [f"  {q(o['kimlik'])}: {q(kanit_ozeti(o))}," for o in sorted(ks, key=lambda o: o["kimlik"])]
    d += ["};", ""]
    DART.write_text(chr(10).join(d), encoding="utf-8", newline=chr(10))
    return len(ks)


def kural_olcumu() -> None:
    wikt = [r for r in tsv(ZIMAN / "cins-wikt.tsv") if " " not in r["kok"]]
    print(f"Wîkîferheng: {len(wikt)} tek sözcüklü ad. Kural: uzun ek önce, sözcük en az belirtilen uzunlukta.")
    say = {ek: Counter() for ek, _ in EK_KURALI}
    for r in wikt:
        g, ek = kural(r["kok"])
        if g and r["cins"] in ("f", "m"):
            say[ek[1:]][r["cins"]] += 1
    top = Counter()
    for ek, _ in sorted(EK_KURALI, key=lambda x: x[0]):
        c = say[ek]
        n = c["f"] + c["m"]
        top.update(c)
        print(f"  -{ek:7} dişil {c['f']:6}  eril {c['m']:4}  -> %{100 * c['f'] / max(n, 1):5.1f}")
    print(f"  TOPLAM   dişil {top['f']:6}  eril {top['m']:4}  -> %{100 * top['f'] / max(top['f'] + top['m'], 1):5.2f}")


def main() -> None:
    if not var():
        print("Ziman katmanı bulunamadı; cinsiyet kanıtı yalnız yerelde hesaplanır.")
        return
    if "--kural" in sys.argv:
        kural_olcumu()
        return
    if "--dart" in sys.argv:
        print(f"{dart_yaz()} ad -> {DART.relative_to(PROJE)}")
        return
    kokler = [a for a in sys.argv[1:] if not a.startswith("--")]
    if kokler:
        for k in kokler:
            o = bak(kucuk(k))
            print(f"{k}\tW={AD.get(o['w'], '-')}\tK={o['ka']}:{o['ke']} {AD.get(o['k'], '-')}\t"
                  f"F={o['fa']}:{o['fe']} {AD.get(o['f'], '-')}\tR={o['ek'] or '-'}")
        return
    ks = kanit()
    c = Counter(o["sinif"] for o in ks)
    for s in SIRA:
        print(f"{c[s]:5}  {s}")
    print(f"{sum(o['kendi'] for o in ks):5}  nêr işaretli, kendi örneğinde -a")
    ck = cakisanlar()
    print(f"{len(ck):5}  aynı madde başı, kayıtlarda farklı cins" + (": " + ", ".join(sorted(ck)) if ck else ""))


if __name__ == "__main__":
    main()
