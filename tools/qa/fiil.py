# -*- coding: utf-8 -*-
"""Fiil kaydı: LÛTKE'deki fiillerin geçişliliği, geçmiş kökü ve örnek çekimleri.

İyileştirme planı Faz 4.2. Ergatiflik alıştırmaları bu tabloya dayanır
(`lib/features/lessons/domain/bicim_alistirma.dart`).

Hiçbir biçim kuralla üretilip öylece yazılmaz; her alan bir kaynaktan seçilir
ve korpusta sınanır:

    geçişlilik   Wîkîferheng (Ziman/lemma.tsv, `gecislilik` sütunu)
    geçmiş kökü  mastardan (-in / -n atılır), korpusta en az 3 kez geçmeli
    çekimler     lemma tablosunda o fiile bağlı, korpusta geçen biçimler arasından
                 (dikim / dike / bike; geçişsizde hatim)
    kanıt        korpusta "çekimli zamir + geçmiş" ve "yalın zamir + geçmiş" sayıları
                 (min got 170, ez got 0)

Tabloya yalnız kanıtı tutarlı fiiller girer: geçişli fiilde yalın zamirle
kullanım, geçişsizde çekimli zamirle kullanım toplamın %10'unu geçiyorsa fiil
dışarıda kalır ve `docs/olcum/fiil.tsv`de nedeni yazılır.

    python tools/qa/fiil.py            # ölç, fiil.tsv ve fiil_db.dart yaz
    python tools/qa/fiil.py dîtin hatin

Korpusa dayandığı için yalnız yerelde çalışır.
"""

import csv
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

PROJE = icerik.PROJE
ZIMAN = PROJE.parents[2] / "Ziman"
CIKTI = PROJE / "docs" / "olcum" / "fiil.tsv"
DART = PROJE / "lib" / "features" / "lessons" / "domain" / "fiil_db.dart"
SOZ = re.compile(r"[a-zçêîşû]+")
CEKIMLI = ("min", "te", "wî", "wê", "me", "we", "wan")
YALIN = ("ez", "tu", "em", "hûn")          # "ew" nesne de olabilir (min ew dît); sayılmaz
ONEK = r"(?:ve|ra|hil|da|der|wer|rû|lê|pê|tê|jê)?"


def kucuk(s: str) -> str:
    return icerik.nfc(s).strip().lower()


def gecmis_koku(mastar: str) -> str:
    if mastar.endswith("în"):
        return mastar[:-1]
    if mastar.endswith("in"):
        return mastar[:-2]
    return mastar[:-1] if mastar.endswith("n") else mastar


def lemma_tablosu() -> tuple:
    """(fiil -> geçişlilik sayımı, fiil -> biçimler)"""
    gecis, bicim = defaultdict(Counter), defaultdict(set)
    with (ZIMAN / "lemma.tsv").open(encoding="utf-8", newline="") as f:
        for r in csv.DictReader(f, delimiter="\t"):
            if r["tur"] == "verb":
                bicim[r["madde"]].add(r["bicim"])
                if r["gecislilik"]:
                    gecis[r["madde"]][r["gecislilik"]] += 1
    return gecis, bicim


def korpus() -> tuple:
    sys.path.insert(0, str(ZIMAN / "araclar"))
    import cins
    tok = SOZ.findall(icerik.nfc(cins.korpus_metni(saglam=True)))
    return Counter(tok), Counter(zip(tok, tok[1:]))


def sec(bicimler: set, desen: str, tek: Counter) -> str:
    """Desene uyan, korpusta en sık geçen biçim (en az 2 geçiş); yoksa ''."""
    aday = [(tek[b], b) for b in bicimler if re.fullmatch(desen, b) and tek[b] >= 2]
    return max(aday)[1] if aday else ""


# Çekirdek fiiller: LÛTKE'de madde başı olmasalar da alıştırmalar için gerekli.
# Türkçe karşılıklar elle yazıldı; `--sozluk` ile ku-tr-sozluk'e karşı sınanır.
CEKIRDEK_TR = {
    "kirin": "yapmak", "gotin": "söylemek", "hatin": "gelmek", "çûn": "gitmek", "xwarin": "yemek",
    "dan": "vermek", "bûn": "olmak", "dîtin": "görmek", "girtin": "tutmak", "anîn": "getirmek",
    "birin": "götürmek", "ketin": "düşmek", "man": "kalmak", "rabûn": "kalkmak", "rûniştin": "oturmak",
    "xwestin": "istemek", "zanîn": "bilmek", "nivîsîn": "yazmak", "xwendin": "okumak", "bihîstin": "duymak",
    "pirsîn": "sormak", "vexwarin": "içmek", "kirîn": "satın almak", "firotin": "satmak", "şandin": "göndermek",
    "avêtin": "atmak", "hiştin": "bırakmak", "kuştin": "öldürmek", "mirin": "ölmek", "revîn": "kaçmak",
    "gihîştin": "ulaşmak", "vegerîn": "dönmek", "derketin": "çıkmak", "razan": "uyumak", "şûştin": "yıkamak",
    "nêrîn": "bakmak", "geriyan": "gezmek", "sekinîn": "durmak", "kenîn": "gülmek", "girîn": "ağlamak",
}


def fiil_mi(k: dict) -> bool:
    return k["tr"].split("/")[0].strip().lower().endswith(("mak", "mek"))


def fiiller() -> list:
    kel = icerik.kelimeler(cocuk=False)
    gecis, bicim = lemma_tablosu()
    tek, iki = korpus()
    aday = {}                                   # mastar -> (düzey, kimlik, tr)
    for d in icerik.DUZEYLER:
        for k in kel[d]:
            m = kucuk(k["ku"])
            if m not in aday and SOZ.fullmatch(m) and m in bicim and m.endswith("n") and fiil_mi(k):
                aday[m] = (d, k["id"], k["tr"].split("/")[0].strip())
    for m, tr in CEKIRDEK_TR.items():
        aday.setdefault(m, ("", "", tr[0].upper() + tr[1:]))
    cikti = []
    for m, (d, kimlik, tr) in aday.items():
        g = gecis[m]
        tur = "trans" if g["trans"] and not g["intra"] else "intra" if g["intra"] and not g["trans"] else ""
        kok = gecmis_koku(m)
        o = {"duzey": d, "kimlik": kimlik, "mastar": m, "tr": tr, "gecis": tur, "gecmis": kok, "n_gecmis": tek[kok]}
        # geçişsizde fiil özneyle uyuşur (ez hatim, em hatin); geçişlide nesneyle (min got)
        bir = sec(bicim[m], re.escape(kok) + r"i?m", tek) if tur == "intra" else ""
        if tur == "intra":
            # Yalın özne: "ew hat", "ez hatim". Çekimli zamir geçişsiz fiilin önünde
            # çoğu kez edat tümlecidir (ji min re hat); özne olarak yanlış kullanımın
            # ölçüsü "min hatim"dir.
            yal = iki[("ew", kok)] + (iki[("ez", bir)] if bir else 0)
            cek = iki[("min", bir)] if bir else 0
        else:
            cek = sum(iki[(p, kok)] for p in CEKIMLI)
            yal = sum(iki[(p, kok)] for p in YALIN)
        emir = [(tek[b], b) for b in bicim[m]
                if re.fullmatch(ONEK + r"bi.+e", b) and b != kok and tek[b] >= 2]
        o.update(cekimli=cek, yalin=yal, gecmis1=bir,
                 # "di-" + geçmiş kök + "im" hikâye birleşik zamanıdır (diketim = düşüyordum);
                 # şimdiki zaman kökü geçmiş kökle aynıysa biçim iki anlamlıdır, boş bırakılır.
                 simdiki1=sec({b for b in bicim[m] if kok not in b}, ONEK + r"di.+i?m", tek),
                 emir=max(emir)[1] if emir else "")
        top = cek + yal
        if not tur:
            o["neden"] = "geçişlilik bilinmiyor ya da iki türlü"
        elif tek[kok] < 3:
            o["neden"] = "geçmiş kökü korpusta 3'ten az"
        elif tur == "trans" and cek < 3:
            o["neden"] = "çekimli zamirli tanık 3'ten az"
        elif tur == "trans" and yal / top > 0.10:
            o["neden"] = "geçişli ama yalın zamirle de kullanılmış"
        elif tur == "intra" and yal < 3:
            o["neden"] = "yalın özneli tanık 3'ten az"
        elif tur == "intra" and cek:
            o["neden"] = "geçişsiz ama 'min' + 1. kişi biçimi geçiyor"
        else:
            o["neden"] = ""
        cikti.append(o)
    return cikti


SUTUN = ["duzey", "kimlik", "mastar", "tr", "gecis", "gecmis", "n_gecmis", "cekimli", "yalin",
         "gecmis1", "simdiki1", "emir", "neden"]


def dart_yaz(fs: list) -> int:
    iyi = [o for o in fs if not o["neden"]]
    def q(s):
        return "'" + s.replace("\\", "\\\\").replace("'", "\\'") + "'"
    d = ["// LÛTKE — Fiil kaydı (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// `python tools/qa/fiil.py` üzerine yazar; elle düzenleme.",
         "// Geçişlilik Wîkîferheng'den, biçimler ve sayılar korpustan (bkz. tools/qa/fiil.py).",
         "",
         "class Fiil {",
         "  final String kimlik;      // kelime kaydının kimliği; madde başı değilse boş",
         "  final String mastar;",
         "  final bool gecisli;",
         "  final String gecmis;      // geçmiş zaman kökü = 3. tekil kişi (got, hat)",
         "  final String? gecmis1;    // geçişsizde 1. tekil kişi (hatim)",
         "  final String? simdiki1;   // şimdiki zaman 1. tekil kişi (dibêjim)",
         "  final String? emir;       // emir (bibêje)",
         "  final int tanikCekimli;   // korpusta: min/te/wî/wê/me/we/wan + geçmiş",
         "  final int tanikYalin;     // korpusta: geçişlide ez/tu/em/hûn + geçmiş; geçişsizde ew + geçmiş, ez + 1. kişi",
         "  final String tr;          // Türkçe mastar",
         "",
         "  const Fiil({",
         "    required this.kimlik,",
         "    required this.mastar,",
         "    required this.gecisli,",
         "    required this.gecmis,",
         "    this.gecmis1,",
         "    this.simdiki1,",
         "    this.emir,",
         "    required this.tanikCekimli,",
         "    required this.tanikYalin,",
         "    required this.tr,",
         "  });",
         "}",
         "",
         "/// Mastar (küçük harf) → fiil kaydı. Yalnız kanıtı tutarlı fiiller.",
         "const Map<String, Fiil> kFiiller = <String, Fiil>{"]
    for o in sorted(iyi, key=lambda x: x["mastar"]):
        ek = "".join(f", {a}: {q(o[a])}" for a in ("gecmis1", "simdiki1", "emir") if o[a])
        d.append(f"  {q(o['mastar'])}: Fiil(kimlik: {q(o['kimlik'])}, mastar: {q(o['mastar'])}, "
                 f"gecisli: {'true' if o['gecis'] == 'trans' else 'false'}, gecmis: {q(o['gecmis'])}{ek}, "
                 f"tanikCekimli: {o['cekimli']}, tanikYalin: {o['yalin']}, tr: {q(o['tr'])}),")
    d += ["};", ""]
    DART.write_text("\n".join(d), encoding="utf-8", newline="\n")
    return len(iyi)


def main() -> None:
    if not (ZIMAN / "lemma.tsv").exists():
        print("Ziman katmanı bulunamadı; fiil kaydı yalnız yerelde üretilir.")
        return
    fs = fiiller()
    ara = {kucuk(a) for a in sys.argv[1:] if not a.startswith("--")}
    if ara:
        for o in fs:
            if o["mastar"] in ara:
                print({a: o[a] for a in SUTUN})
        return
    with CIKTI.open("w", encoding="utf-8", newline="") as f:
        y = csv.writer(f, delimiter="\t", lineterminator="\n")
        y.writerow(SUTUN)
        y.writerows([[o[a] for a in SUTUN] for o in fs])
    n = dart_yaz(fs)
    c = Counter(o["neden"] or "tabloda" for o in fs)
    print(f"{len(fs)} fiil madde başı; tabloya giren {n} "
          f"(geçişli {sum(o['gecis'] == 'trans' and not o['neden'] for o in fs)}, "
          f"geçişsiz {sum(o['gecis'] == 'intra' and not o['neden'] for o in fs)})")
    for k, v in c.most_common():
        print(f"  {v:4}  {k}")


if __name__ == "__main__":
    main()
