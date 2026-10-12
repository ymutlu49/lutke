# -*- coding: utf-8 -*-
"""Ortak denetleyicinin yakalamadığı hata kalıplarını bütün LÛTKE metinlerinde arar.

`ziman_denetim.py` izafe, edat, norm gibi kuralları işaretler; aşağıdaki türleri
görmez. Hepsi Ekim 2026'da diyaloglar okunurken bulundu ve korpusla doğrulandı
(sayılar `Ziman/araclar/ara.py` çıktısıdır):

  ji_kosac      "Ez baş im jî" — jî eklediği ögeden sonra gelir ("ez jî baş im" 4, tersi 0).
                "ne tenê X e, Y e jî" kalıbı doğrudur (4 tanık); ona dokunma.
  deye          "dêyê" seslenmesi (0) — doğrusu "dayê" (159)
  hatin_uzun    "hatîn" (0) — çoğul geçmiş "hatin"
  ne_di         "ne dizanim" (0) — şimdiki zaman olumsuzu na-/ni-: nizanim (219)
  ne_gecmis     "ne hatiye" — geçmiş zaman olumsuzluk eki bitişik: nehatiye
  erg_bun       "min ... fêr bû" (0) — fêr/hîn bûn geçişsiz: "ez fêrî ... bûm" (4)
  hez           "hez dikim" ji'siz (1) — "ji X hez dik-" (83)
  heman_e       "heman e" (0) — heman addan önce gelir (46)
  destpek_bike  "destpêk bike" (0) — fiil "dest pê kirin" (16)
  an_en         "Kurdan ên li ..." — eğik çoğula izafe parçacığı; bağlama bak
                ("hunerên destan ên kurdî" doğru bir zincirdir)
  erg_yalin     "Em hev dîtin" (0) — geçişli fiilin geçmişinde özne eğik: "me hev dît" (2).
                Ortak denetleyicinin ergatif kuralı yalnız bitişik özne-fiile bakar.

Hata sanılıp korpusta doğru çıkanlar (kalıp olarak EKLENMEDİ): "Min sê nevî hene"
(eğik iyelik), "li kû ye" (kû 313 tanık), "pêwist" (50; pêwîst 86), "zarokekî heye".

Atasözleri (`gotin`) kaynaktan aynen alındığı için özette ayrı sayılır.
`icerik.tum_metinler()` yanında `content.json`daki öteki dizgiler de (notlar,
seçenekler, açıklamalar) taranır; önce `dart run tool/export_content.dart`.

    python tools/qa/kalip_tara.py              # özet
    python tools/qa/kalip_tara.py --goster     # eşleşen metinler
    python tools/qa/kalip_tara.py hez deye     # yalnız bu kalıplar (--goster ile)

Araç karar vermez; her eşleşme okunmalıdır. Sıfır tanık "yanlış" demek değildir.
"""

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

I = re.I
KALIP = {
    "ji_kosac": (r"\b(im|me|î|yî|e|ye|in|ne)\s+jî\b", I),
    "deye": (r"\bdêyê\b", I),
    "hatin_uzun": (r"\bhatîn\b", I),
    "ne_di": (r"\bne\s+d[ia]\w+(im|î|e|in)\b", I),
    "ne_gecmis": (r"\bne\s+(hat|kir|dît|got|çû|xwar|ket|girt|anî|nivîsand|xwend|bihîst|zanî|karî)\w*", I),
    "erg_bun": (r"\b(min|te|wî|wê|me|we|wan)\b[^.!?]{0,45}\b(fêr|hîn|hînî|fêrî)\s+(ne)?bû\w*", I),
    "heman_e": (r"\bheman\s+(e|in)\b", I),
    "destpek_bike": (r"\bdestpêk\s+(bi)?k\w*", I),
    "an_en": (r"\b\w+an\s+(ên|yên)\b", I),
}


_GECISLI = ("kir|got|dît|xwar|vexwar|nivîsand|xwend|kirî|girt|anî|bir|da|şand|bihîst|pirsî|hilda|avêt|vekir|girêda|"
            "şûşt|firot|dizî|kuşt|xwest|hilbijart|danî|hişt|kişand|parast|şikand|birî|qedand|guhert|stand|hejmart|"
            "çand|rakir|derxist|xist|bijart|pijand|vexwend|çêkir")
_ERG = re.compile(r"(^|[.!?…:]\s+|[\"“]\s*)(Ez|Tu|Em|Hûn)\s+([^.!?]{0,60}?)\b(" + _GECISLI
                  + r")(in|im|î|e|iye|ine|ibû|ibûn)?(?=[\s.!?,])")
# şimdiki zaman, gelecek, dilek, yardımcı fiil ve edilgen araya girmişse geçmiş zaman değildir
_ERG_DEGIL = re.compile(r"\b(ê|dê|wê|divê|hat|hatin|hatim|hatî|hatiye|tê|tên|têm|bên|bê)\b|\bdi\w+|\bna\w+|\bbi\w+(im|î|e|in)\b", I)


def erg_yalin(metin: str) -> list:
    """Geçişli fiilin geçmiş zamanında yalın özne (Ez/Tu/Em/Hûn)."""
    return [" ".join(x.group(0).split()) for x in _ERG.finditer(metin) if not _ERG_DEGIL.search(x.group(3))]


def hez_ji_yok(metin: str) -> list:
    """`hez kirin` çekimli ama cümlede ji/jê yok."""
    return [c for c in re.split(r"(?<=[.!?…])\s+", metin)
            if re.search(r"\bhez\s+(di|na)k\w+", c, I) and not re.search(r"\bj(i|ê)\b", c, I)]


def oteki_dizgiler(gorulen: set) -> list:
    veri = json.loads(icerik.ICERIK_JSON.read_text(encoding="utf-8"))
    c = []

    def gez(v, yol):
        if isinstance(v, str):
            s = icerik.nfc(v)
            if len(s) > 2 and s not in gorulen:
                c.append(("json", yol, "", s))
        elif isinstance(v, list):
            for i, x in enumerate(v):
                gez(x, f"{yol}[{i}]")
        elif isinstance(v, dict):
            kim = v.get("id")
            for k, x in v.items():
                gez(x, f"{kim}.{k}" if kim else f"{yol}.{k}")

    gez(veri, "")
    return c


def main() -> int:
    secim = {a for a in sys.argv[1:] if not a.startswith("--")}
    goster = "--goster" in sys.argv or bool(secim)
    asil = [(g, k, a, icerik.nfc(m)) for g, k, a, m, _ in icerik.tum_metinler()]
    hepsi = asil + oteki_dizgiler({m for _, _, _, m in asil})
    print(f"{len(hepsi)} dizgi tarandı\n")
    print(f"{'kalıp':<14}{'eşleşme':>8}{'atasözü':>9}")
    bulgular = {}
    for ad, (desen, bayrak) in KALIP.items():
        r = re.compile(desen, bayrak)
        bulgular[ad] = [(g, k, a, m, x.group(0).strip()) for g, k, a, m in hepsi for x in [r.search(m)] if x]
    bulgular["hez"] = [(g, k, a, c, "") for g, k, a, m in hepsi for c in hez_ji_yok(m)]
    bulgular["erg_yalin"] = [(g, k, a, m, e) for g, k, a, m in hepsi for e in erg_yalin(m)]
    for ad, b in bulgular.items():
        atasozu = sum(1 for x in b if x[0] == "gotin")
        print(f"{ad:<14}{len(b) - atasozu:>8}{atasozu:>9}")
    if goster:
        for ad, b in bulgular.items():
            if secim and ad not in secim:
                continue
            print(f"\n=== {ad}")
            for g, k, a, m, e in b:
                if g != "gotin":
                    print(f"  [{g}|{k}|{a}] {('⟨' + e + '⟩ ') if e else ''}{' '.join(m.split())[:150]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
