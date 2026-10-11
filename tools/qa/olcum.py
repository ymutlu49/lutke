# -*- coding: utf-8 -*-
"""LÛTKE içerik ölçümü — iyileştirme planının sayıları tek betikte.

    python tools/qa/olcum.py            # ölç, docs/olcum/olcum.md + .json yaz
    python tools/qa/olcum.py --taban    # ayrıca bugünkü değerleri taban olarak kaydet

Her faz bitince yeniden çalıştırılır; `docs/olcum/taban.json` varsa rapor
"taban -> şimdi" farkını da gösterir.

Ölçümlerin bir bölümü çalışma alanının ortak dil katmanına dayanır
(`Kurmanci/Ziman`, `Kurmanci/ku-tr-sozluk`). Katman bulunamazsa o bölümler
atlanır; kalanlar yine üretilir.

Üretilen listeler (docs/olcum/):
    cins_celiski.tsv     cinsiyeti en az bir kaynakla çelişen adlar
    cins_kanit.tsv       her adın cinsiyet kanıtı (üç kaynak + kendi örnekleri)
    taniksiz.tsv         hiçbir kaynakta tanığı olmayan tek sözcüklü maddeler
    eksik_cekirdek.tsv   korpusun çekirdek söz varlığında olup LÛTKE'de olmayanlar

Yöntem notları ve sınırlar: docs/olcum/README.md
"""

import csv
import datetime
import json
import re
import statistics
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402
import ziman_denetim  # noqa: E402

PROJE = icerik.PROJE
KURMANCI = PROJE.parents[2]
CIKTI = PROJE / "docs" / "olcum"
SEVIYE = icerik.DUZEYLER
TEK = re.compile(r"[a-zçêîşû']+")
SOZ = re.compile(r"[a-zçêîşû]+(?:'[a-zçêîşû]+)?")
KOSAC = {"e", "ye", "in", "im", "î", "yî", "ne", "bû", "bûn", "bûm", "bûyî",
         "heye", "hene", "tune", "tunene", "nîne", "nînin", "nîn"}
ZAMIR = {"ez", "tu", "ew", "em", "hûn", "min", "te", "wî", "wê", "me", "we", "wan"}
SIMDIKI = re.compile(r"^(?:di|bi|na|ne|ni|me)[a-zçêîşû]+(?:im|î|e|in)$")


def yuklem_var(s: str, coz=None) -> bool:
    """Sezgisel: örnekte koşaç ya da çekimli fiil var mı?

    Lemma tablosu varsa (`coz`) çekimli biçim ondan tanınır; yoksa yalnız
    şimdiki zaman kalıbına bakılır. Çoğul geçmiş mastarla eşyazımlıdır
    (*Wan hev dîtin*); cümlede zamir varsa ve son sözcük mastarsa fiil sayılır.
    """
    tok = SOZ.findall(kucuk(s))
    for i, t in enumerate(tok):
        if t in KOSAC:
            return True
        m, tur = coz(t) if coz else (t, "?")
        if tur == "verb" and t != m:
            return True
        if tur == "?" and SIMDIKI.match(t):
            return True
        if tur == "verb" and t == m and i == len(tok) - 1 and ZAMIR & set(tok[:i]):
            return True
    return False


CINS = {"nêr": "m", "mê": "f"}


def kucuk(s: str) -> str:
    return icerik.nfc(s).lower().strip().replace("’", "'")


def yuzde(a: int, b: int) -> float:
    return round(100 * a / b, 1) if b else 0.0


def tsv_oku(yol: Path) -> list:
    with yol.open(encoding="utf-8") as f:
        return list(csv.DictReader(f, delimiter="\t"))


def tsv_yaz(ad: str, basliklar: list, satirlar: list) -> None:
    CIKTI.mkdir(parents=True, exist_ok=True)
    with (CIKTI / ad).open("w", encoding="utf-8", newline="") as f:
        wr = csv.writer(f, delimiter="\t")
        wr.writerow(basliklar)
        wr.writerows(satirlar)


# ── 1. Envanter ──────────────────────────────────────────────────────────────

def envanter(kel: dict, web: dict) -> dict:
    o = {"duzey": {}}
    for d in SEVIYE:
        kimlik = {k["id"] for k in kel[d]}
        hedef = set()
        for ders in web["lessons"][d]:
            hedef.update(ders.get("targetCardIds") or [])
        o["duzey"][d] = {
            "kayit": len(kel[d]),
            "benzersiz_madde": len({kucuk(k["ku"]) for k in kel[d]}),
            "web": len(web["words"][d]),
            "ders": len(web["lessons"][d]),
            "egzersiz": sum(len(x.get("exercises") or []) for x in web["lessons"][d]),
            "ders_hedefi": len(hedef & kimlik),
            "ders_kapsama": yuzde(len(hedef & kimlik), len(kimlik)),
            "cok_sozcuklu": yuzde(sum(" " in k["ku"].strip() for k in kel[d]), len(kel[d])),
        }
    o["kayit"] = sum(v["kayit"] for v in o["duzey"].values())
    o["web"] = sum(v["web"] for v in o["duzey"].values())
    o["benzersiz_madde"] = len({kucuk(k["ku"]) for d in SEVIYE for k in kel[d]})
    o["cocuk"] = len(kel["child_a1"]) + len(kel["child_a2"])
    o["ders"] = sum(v["ders"] for v in o["duzey"].values())
    o["egzersiz"] = sum(v["egzersiz"] for v in o["duzey"].values())
    ek = Counter(g for g, *_ in icerik.ek_metinler())
    o["dinleme"] = sum(1 for g, _, a, _ in icerik.ek_metinler() if g == "listening_exercise_db" and a == "audioText")
    o["konusma"] = ek["ku_speaking_db"]
    o["yazma"] = len(re.findall(r"\bid:\s*'ku_write_",
                                (PROJE / "lib/features/exercises/domain/ku_writing_db.dart").read_text(encoding="utf-8")))
    o["diyalog"] = len(web["dialogues"])
    o["dilbilgisi_konusu"] = len(web["grammar"])
    o["dilbilgisi_duzeyleri"] = sorted({g["level"] for g in web["grammar"]})
    o["atasozu"] = len(web["proverbs"])
    o["kultur"] = sum(len(v) for v in web["cand"].values())
    return o


# ── 2. Örnek cümleler ────────────────────────────────────────────────────────

def ornekler(kel: dict, coz=None) -> dict:
    o = {}
    for d in SEVIYE:
        o[d] = {}
        for alan in ("her", "gen"):
            c = [(k["ku"], s) for k in kel[d] for s in k[alan]]
            n = len(c)
            uz = [len(s.split()) for _, s in c]
            o[d][alan] = {
                "n": n,
                "ort_sozcuk": round(statistics.mean(uz), 2) if uz else 0,
                "noktasiz": yuzde(sum(not re.search(r"[.!?…]\s*$", s) for _, s in c), n),
                "en_cok_2_sozcuk": yuzde(sum(u <= 2 for u in uz), n),
                "maddenin_aynisi": yuzde(sum(kucuk(s).strip(" .!?") == kucuk(m) for m, s in c), n),
                "yuklemsiz": yuzde(sum(not yuklem_var(s, coz) for _, s in c), n),
            }
    return o


# ── 3–5. Ortak dil katmanına dayananlar ──────────────────────────────────────

def ziman_var() -> bool:
    return all((KURMANCI / p).exists() for p in
               ("Ziman/lemma.tsv", "Ziman/siklik.tsv", "Ziman/cins-wikt.tsv", "Ziman/cins-ham.tsv", "Ziman/cins-farq.tsv"))


def taniklik(kel: dict) -> dict:
    sozluk = {kucuk(r["kurdi"]) for r in tsv_oku(KURMANCI / "ku-tr-sozluk/data/ku-tr.tsv") if r["lehce"] == "kmr"}
    lemma = {r["bicim"] for r in tsv_oku(KURMANCI / "Ziman/lemma.tsv")}
    siklik = {r["madde"]: int(r["n"]) + int(r["n_gramer"]) + int(r["n_klasik"])
              for r in tsv_oku(KURMANCI / "Ziman/siklik.tsv")}
    farq = KURMANCI / "Ziman/korpus/sozluk/ferhenga-kurdi-tirki-zana-farqini-buyuk-turkce-kurtce-sozluk.txt"
    farqini = set(TEK.findall(kucuk(farq.read_text(encoding="utf-8")))) if farq.exists() else set()

    o, taniksiz, gorulen = {}, [], set()
    for d in SEVIYE:
        tek = [k for k in kel[d] if TEK.fullmatch(kucuk(k["ku"]))]
        o[d] = {
            "tek_sozcuklu": len(tek),
            "sozlukte": yuzde(sum(kucuk(k["ku"]) in sozluk for k in tek), len(tek)),
            "wikiferhengde": yuzde(sum(kucuk(k["ku"]) in lemma for k in tek), len(tek)),
            "farqinide": yuzde(sum(kucuk(k["ku"]) in farqini for k in tek), len(tek)),
            "korpusta_5": yuzde(sum(siklik.get(kucuk(k["ku"]), 0) >= 5 for k in tek), len(tek)),
        }
        for k in tek:
            m = kucuk(k["ku"])
            if m in gorulen:
                continue
            gorulen.add(m)
            if m not in sozluk and m not in lemma and m not in farqini and m not in siklik:
                taniksiz.append([d, k["id"], k["ku"], k["tr"], k["kat"]])
    tsv_yaz("taniksiz.tsv", ["duzey", "kimlik", "madde", "tr", "kat"], taniksiz)
    o["taniksiz"] = len(taniksiz)
    o["taniksiz_duzey"] = dict(Counter(t[0] for t in taniksiz))
    return o


def cozucu():
    sys.path.insert(0, str(KURMANCI / "Ziman" / "araclar"))
    from lemma import Cozucu
    return Cozucu().coz


# Çekirdek söz varlığı: sıralamaya giren 12 dosyanın en az 4'ünde geçen maddeler.
CEKIRDEK_KAYNAK = 4


def kapsam(kel: dict, coz) -> dict:
    cekirdek = [r for r in tsv_oku(KURMANCI / "Ziman/siklik.tsv")
                if int(r["kaynak"]) >= CEKIRDEK_KAYNAK and r["tur"] != "?"]
    bilinen, o = set(), {"cekirdek": len(cekirdek), "duzey": {}}
    for d in SEVIYE:
        for k in kel[d]:
            bilinen.add(kucuk(k["ku"]))
            for t in SOZ.findall(kucuk(k["ku"])):
                bilinen.add(t)
                bilinen.add(coz(t)[0])
        o["duzey"][d] = {f"ilk_{n}": yuzde(sum(r["madde"] in bilinen for r in cekirdek[:n]), min(n, len(cekirdek)))
                         for n in (500, 1000, 2000)}
    eksik = [[r["sira"], r["madde"], r["tur"], r["n"], r["kaynak"]]
             for r in cekirdek[:2000] if r["madde"] not in bilinen]
    tsv_yaz("eksik_cekirdek.tsv", ["sira", "madde", "tur", "n", "kaynak"], eksik)
    o["eksik_ilk_2000"] = len(eksik)
    o["eksik_ornek"] = [e[1] for e in eksik[:40]]
    return o


def cinsiyet(kel: dict) -> dict:
    """Her adın cinsiyet kanıtı (bkz. cins_kanit.py: dört kaynak ve sınıflar).

    Taban ile karşılaştırma bozulmasın diye iki kaynaklı (Wîkîferheng + korpus)
    eski sayımlar aynı anahtarlarla tutulur; dört kaynaklı sınıflama `uc`
    anahtarı altında verilir (anahtar adı ilk sürümden kaldı).
    """
    import cins_kanit as ck

    kayitlar = ck.sirala(ck.kanit(kel))
    say, uc = Counter(), Counter()
    for o in kayitlar:
        w, kor, lut = o["w"], o["k"], o["lutke"]
        say["ad"] += 1
        say["wikiferheng_var"] += bool(w)
        say["korpus_var"] += bool(kor)
        say["en_az_bir_kaynak"] += bool(w or kor)
        if w and kor:
            say["iki_kaynak_var"] += 1
            say["iki_kaynak_hemfikir"] += w == kor
        if w and kor and w == kor and w != lut:
            say["iki kaynak hemfikir"] += 1
        elif w and kor and w != kor:
            say["kaynaklar ayrışıyor"] += 1
        elif (w and w != lut) or (kor and kor != lut):
            say["yalnız Wîkîferheng" if w and w != lut else "yalnız korpus"] += 1
        uc[o["sinif"]] += 1
        uc["farqini_var"] += bool(o["f"])
        uc["kural_var"] += bool(o["r"])
        uc["kendi örneğiyle çelişiyor"] += o["kendi"]
    for anahtar in ("doğrulandı", "kesin çelişki", "tek kaynak çelişiyor", "kaynaklar ayrışıyor",
                    "kaynak yok", "kendi örneğiyle çelişiyor", "iki kaynak hemfikir"):
        uc.setdefault(anahtar, 0)
        if anahtar == "iki kaynak hemfikir":
            say.setdefault(anahtar, 0)
    tsv_yaz("cins_celiski.tsv", ck.BASLIK,
            [ck.satir(o) for o in kayitlar if o["sinif"] not in ("doğrulandı", "kaynak yok") or o["kendi"]])
    tsv_yaz("cins_kanit.tsv", ck.BASLIK, [ck.satir(o) for o in kayitlar])
    o = dict(say)
    o["celiski"] = sum(say[s] for s in ("iki kaynak hemfikir", "yalnız korpus", "yalnız Wîkîferheng"))
    o["uc"] = dict(uc)
    return o


# ── 6. Ses ───────────────────────────────────────────────────────────────────

def ses(kel: dict) -> dict:
    """tts_asset_manifest.dart::lookup ve tts_service.dart::synthesize'ın eşi."""
    m = (PROJE / "lib/core/services/tts_asset_manifest.dart").read_text(encoding="utf-8")
    E = {icerik._coz(x, 1) for x in re.finditer(r"^\s*" + icerik._STR + r"\s*:\s*'assets/", m, re.M)}

    def bak(s: str) -> bool:
        a = kucuk(s) if False else icerik.nfc(s).strip().lower()
        b = re.sub(r"[.,!?]+$", "", a).strip()
        aday = [b, a, b.replace("’", "'").replace("‘", "'").replace("ʼ", "'").replace("`", "'").replace("´", "'"),
                b.replace("'", "’"), " ".join(b.split())]
        tam = re.sub(r"^[\W_]+|[\W_]+$", "", b)
        aday += [tam, tam.replace("’", "'")]
        return any(x in E for x in aday)

    def var(s: str) -> bool:
        t = " ".join(s.split())
        if " " not in t and not t.endswith((".", "!", "?")):
            t += "."
        return bak(re.sub(r"[.,!?]+$", "", t.lower()).strip()) or bak(t.lower())

    o = {"bildirim_anahtari": len(E), "duzey": {}}
    for d in SEVIYE:
        o["duzey"][d] = {
            "madde": yuzde(sum(var(k["ku"]) for k in kel[d]), len(kel[d])),
            "her": yuzde(sum(var(s) for k in kel[d] for s in k["her"]), sum(len(k["her"]) for k in kel[d])),
            "gen": yuzde(sum(var(s) for k in kel[d] for s in k["gen"]), sum(len(k["gen"]) for k in kel[d])),
        }
    tum = [k for d in SEVIYE for k in kel[d]]
    o["madde"] = yuzde(sum(var(k["ku"]) for k in tum), len(tum))
    o["her"] = yuzde(sum(var(s) for k in tum for s in k["her"]), sum(len(k["her"]) for k in tum))
    o["gen"] = yuzde(sum(var(s) for k in tum for s in k["gen"]), sum(len(k["gen"]) for k in tum))
    din = [t for g, _, a, t in icerik.ek_metinler() if g == "listening_exercise_db" and a == "audioText"]
    o["dinleme_var"], o["dinleme"] = sum(var(t) for t in din), len(din)
    return o


# ── 7. Atasözleri ve açık norm kararları ─────────────────────────────────────

def atasozu(web: dict) -> dict:
    p = [x["ku"] for x in web["proverbs"]]
    uzun = [s for s in p if len(s.split()) >= 4]
    return {"n": len(p),
            "turkce_harfli": sum(bool(re.search(r"[ıİğĞüÜöÖâÂ]", s)) for s in p),
            "sapkasiz": sum(not re.search(r"[êîûÊÎÛ]", s) for s in uzun),
            "sapkasiz_payda": len(uzun)}


def acik_norm(metinler: list) -> dict:
    """Karara bağlanmamış yazım noktaları: yalnız sayılır, işaretlenmez."""
    t = "\n".join(m for g, _, _, m, _ in metinler if g not in ziman_denetim.ALINTI_GRUP)
    ic = r"(?<=[a-zçêîşû,] )"
    return {
        "dil_adi_buyuk": len(re.findall(ic + r"(?:Kurdî|Kurmancî|Tirkî|Îngilîzî|Erebî|Farisî)\b", t)),
        "dil_adi_kucuk": len(re.findall(ic + r"(?:kurdî|kurmancî|tirkî|îngilîzî|erebî|farisî)\b", t)),
        "ay_adi_buyuk": len(re.findall(ic + r"(?:Adar|Gulan|Nîsan|Tebax|Îlon|Çile|Sibat)(?:ê)?\b", t)),
        "ay_adi_kucuk": len(re.findall(ic + r"(?:adar|gulan|nîsan|tebax|îlon|çile|sibat)(?:ê)?\b", t)),
        "herdu": len(re.findall(r"\bherdu\b", t, re.I)),
        "her_du": len(re.findall(r"\bher du\b", t, re.I)),
    }


# ── Rapor ────────────────────────────────────────────────────────────────────

def olc() -> dict:
    kel = icerik.kelimeler(cocuk=True)
    web = icerik.web()
    metinler = icerik.tum_metinler()
    coz = cozucu() if ziman_var() else None
    o = {"tarih": datetime.date.today().isoformat(), "icerik_json_eski": web["_eski"],
         "envanter": envanter(kel, web), "ornek": ornekler(kel, coz), "ses": ses(kel),
         "atasozu": atasozu(web), "acik_norm": acik_norm(metinler)}
    if coz:
        o["taniklik"] = taniklik(kel)
        o["kapsam"] = kapsam(kel, coz)
        o["cinsiyet"] = cinsiyet(kel)
    isaret = ziman_denetim.tara()
    if isaret is not None:
        oz = ziman_denetim.ozet(isaret)
        o["denetim"] = {k: dict(v) for k, v in sorted(oz.items())}
        o["denetim"]["_acik"] = sum(v["acik"] for v in oz.values())
        o["denetim"]["_muaf"] = sum(v["muaf"] for v in oz.values())
        o["denetim"]["_norm_iy"] = sum(1 for i in isaret if i["kural"] == "norm" and "y'den önce" in i["mesaj"])
    return o


def tablo(basliklar: list, satirlar: list) -> str:
    s = ["| " + " | ".join(basliklar) + " |",
         "|" + "|".join("---" if i == 0 else "---:" for i in range(len(basliklar))) + "|"]
    s += ["| " + " | ".join(str(h) for h in r) + " |" for r in satirlar]
    return "\n".join(s)


def bin(n: int) -> str:
    return f"{n:,}".replace(",", ".")


def pc(x) -> str:
    return f"%{str(x).replace('.', ',')}"


def rapor(o: dict, taban: dict | None) -> str:
    e, D = o["envanter"], [d.upper() for d in SEVIYE]
    b = [f"# LÛTKE içerik ölçümü — {o['tarih']}", "",
         "`python tools/qa/olcum.py` üretir; elle düzenlenmez. Yöntem ve sınırlar: [README.md](README.md).", ""]
    if o["icerik_json_eski"]:
        b += ["> **Uyarı:** `website/data/content.json` Dart kaynağından eski; ders ve kültür sayıları güncel olmayabilir.", ""]

    if taban:
        def fark(ad, yol, bicim=str):
            def al(x):
                for k in yol:
                    x = x.get(k, {}) if isinstance(x, dict) else {}
                return x if not isinstance(x, dict) else None
            return [ad, bicim(al(taban)) if al(taban) is not None else "—", bicim(al(o)) if al(o) is not None else "—"]
        b += [f"## Tabana göre ({taban['tarih']})", "",
              tablo(["Ölçüt", "Taban", "Şimdi"], [
                  fark("Kelime kaydı (uygulama)", ["envanter", "kayit"]),
                  fark("Açık dil denetimi işareti", ["denetim", "_acik"]),
                  fark("î + y yazımı (azadîya)", ["denetim", "_norm_iy"]),
                  fark("Cinsiyet çelişkisi", ["cinsiyet", "celiski"]),
                  fark("İki kaynağın hemfikir olduğu cinsiyet hatası", ["cinsiyet", "iki kaynak hemfikir"]),
                  fark("Cinsiyeti doğrulanmış ad (dört kaynak)", ["cinsiyet", "uc", "doğrulandı"]),
                  fark("Kesin cinsiyet çelişkisi (dört kaynak)", ["cinsiyet", "uc", "kesin çelişki"]),
                  fark("`nêr` işaretli, kendi örneğinde `-a` alan ad", ["cinsiyet", "uc", "kendi örneğiyle çelişiyor"]),
                  fark("Tanıksız madde", ["taniklik", "taniksiz"]),
                  fark("Çekirdek ilk 2.000'de eksik madde", ["kapsam", "eksik_ilk_2000"]),
                  fark("Hazır sesi olan madde başı", ["ses", "madde"], pc),
                  fark("Hazır sesi olan dinleme metni", ["ses", "dinleme_var"]),
              ]), ""]

    b += ["## 1. Envanter", "",
          f"Uygulamanın kullandığı listelerde **{bin(e['kayit'])} kelime kaydı** var "
          f"({bin(e['benzersiz_madde'])} farklı madde); web sitesine giden dışa aktarımda {bin(e['web'])}. "
          f"Çocuk modu ayrıca {e['cocuk']} kayıt taşır.", "",
          tablo([""] + D, [
              ["Kelime kaydı (uygulama)"] + [e["duzey"][d]["kayit"] for d in SEVIYE],
              ["Farklı madde"] + [e["duzey"][d]["benzersiz_madde"] for d in SEVIYE],
              ["Web sitesinde"] + [e["duzey"][d]["web"] for d in SEVIYE],
              ["Öbek olan madde"] + [pc(e["duzey"][d]["cok_sozcuklu"]) for d in SEVIYE],
              ["Yazılmış ders"] + [e["duzey"][d]["ders"] for d in SEVIYE],
              ["Derslerdeki egzersiz"] + [e["duzey"][d]["egzersiz"] for d in SEVIYE],
              ["Derslerin hedeflediği kelime"] + [pc(e["duzey"][d]["ders_kapsama"]) for d in SEVIYE],
          ]), "",
          f"Toplam {e['ders']} ders, {e['egzersiz']} egzersiz · dinleme {e['dinleme']} · konuşma {e['konusma']} · "
          f"yazma {e['yazma']} · diyalog {e['diyalog']} · dilbilgisi konusu {e['dilbilgisi_konusu']} "
          f"({', '.join(e['dilbilgisi_duzeyleri'])}) · atasözü {bin(e['atasozu'])} · kültür ögesi {e['kultur']}.", ""]

    b += ["## 2. Örnek cümleler", "",
          "`her` etkinliklerde kullanılan kümedir; `gen` yalnız kelime ayrıntısında görünür.", ""]
    for alan, ad in (("her", "`her` örnekleri"), ("gen", "`gen` örnekleri")):
        x = {d: o["ornek"][d][alan] for d in SEVIYE}
        b += [f"**{ad}**", "",
              tablo([""] + D, [
                  ["Örnek sayısı"] + [x[d]["n"] for d in SEVIYE],
                  ["Ortalama sözcük"] + [str(x[d]["ort_sozcuk"]).replace(".", ",") for d in SEVIYE],
                  ["Sonunda nokta yok"] + [pc(x[d]["noktasiz"]) for d in SEVIYE],
                  ["En çok 2 sözcük"] + [pc(x[d]["en_cok_2_sozcuk"]) for d in SEVIYE],
                  ["Maddenin aynısı"] + [pc(x[d]["maddenin_aynisi"]) for d in SEVIYE],
                  ["Yüklemsiz (sezgisel)"] + [pc(x[d]["yuklemsiz"]) for d in SEVIYE],
              ]), ""]
    b += ["Örneklerin hiçbirinde çeviri alanı yok.", ""]

    if "taniklik" in o:
        t = o["taniklik"]
        b += ["## 3. Tanıklık (tek sözcüklü maddeler)", "",
              tablo([""] + D, [
                  ["Tek sözcüklü madde"] + [t[d]["tek_sozcuklu"] for d in SEVIYE],
                  ["ku-tr sözlükte"] + [pc(t[d]["sozlukte"]) for d in SEVIYE],
                  ["Wîkîferheng'de"] + [pc(t[d]["wikiferhengde"]) for d in SEVIYE],
                  ["Farqînî'de"] + [pc(t[d]["farqinide"]) for d in SEVIYE],
                  ["Korpusta en az 5 kez"] + [pc(t[d]["korpusta_5"]) for d in SEVIYE],
              ]), "",
              f"Hiçbir kaynakta tanığı olmayan madde: **{t['taniksiz']}** "
              f"({', '.join(f'{k.upper()} {v}' for k, v in sorted(t['taniksiz_duzey'].items()))}) "
              "→ [taniksiz.tsv](taniksiz.tsv)", ""]

        k = o["kapsam"]
        b += ["## 4. Çekirdek söz varlığı kapsamı", "",
              f"Çekirdek liste: korpusta en az {CEKIRDEK_KAYNAK} ayrı kaynakta geçen {bin(k['cekirdek'])} madde başı, "
              "sıklık sırasıyla. Sütunlar o düzeyin sonuna kadar öğretilen maddelerle kapsanan payı gösterir (birikimli).", "",
              tablo([""] + D, [
                  [f"En sık {bin(n)}"] + [pc(k["duzey"][d][f"ilk_{n}"]) for d in SEVIYE]
                  for n in (500, 1000, 2000)]), "",
              f"İlk 2.000'de olup LÛTKE'de hiç geçmeyen: **{k['eksik_ilk_2000']}** → [eksik_cekirdek.tsv](eksik_cekirdek.tsv)", "",
              "En sık eksikler: " + ", ".join(f"*{m}*" for m in k["eksik_ornek"]) + ".", ""]

        c = o["cinsiyet"]
        b += ["## 5. Cinsiyet (nêr / mê)", "",
              tablo(["", "Ad"], [
                  ["Tek sözcüklü, cinsiyetli farklı ad", c["ad"]],
                  ["En az bir bağımsız kaynağı olan", c["en_az_bir_kaynak"]],
                  ["İki kaynakta da bulunan", c.get("iki_kaynak_var", 0)],
                  ["İki kaynağın hemfikir olduğu", c.get("iki_kaynak_hemfikir", 0)],
                  ["**İki kaynak hemfikir, LÛTKE farklı**", f"**{c.get('iki kaynak hemfikir', 0)}**"],
                  ["Yalnız korpus LÛTKE ile çelişiyor", c.get("yalnız korpus", 0)],
                  ["Yalnız Wîkîferheng LÛTKE ile çelişiyor", c.get("yalnız Wîkîferheng", 0)],
                  ["İki kaynak birbiriyle çelişiyor", c.get("kaynaklar ayrışıyor", 0)],
              ]), "",
              "Yukarıdaki tablo tabanla aynı yöntemi (Wîkîferheng + korpus) kullanır. "
              "Faz 2'de iki kaynak eklendi: Farqînî sözlüğünün madde içi izafe örnekleri "
              "(`Ziman/araclar/cinsfarq.py`) ve son ek kuralı (`tools/qa/cins_kanit.py`).", ""]
        u = c.get("uc", {})
        if u:
            b += [tablo(["Dört kaynakla", "Ad"], [
                      ["En az bir kaynak LÛTKE ile aynı, hiçbiri karşı değil (**doğrulandı**)", f"**{u.get('doğrulandı', 0)}**"],
                      ["En az iki kaynak karşı, hiçbiri yanında değil (**kesin çelişki**)", f"**{u.get('kesin çelişki', 0)}**"],
                      ["Tek kaynak karşı, yanında kaynak yok", u.get("tek kaynak çelişiyor", 0)],
                      ["Kaynaklar birbiriyle çelişiyor", u.get("kaynaklar ayrışıyor", 0)],
                      ["Hiç kaynağı yok", u.get("kaynak yok", 0)],
                      ["Farqînî örneği olan", u.get("farqini_var", 0)],
                      ["Son ek kuralının kapsadığı", u.get("kural_var", 0)],
                      ["`nêr` işaretli, kendi örnek cümlesinde `-a` izafesi almış", u.get("kendi örneğiyle çelişiyor", 0)],
                  ]), "",
                  "Listeler: [cins_celiski.tsv](cins_celiski.tsv) (açık sorular), "
                  "[cins_kanit.tsv](cins_kanit.tsv) (her adın kanıtı)", ""]

    if "denetim" in o:
        dn = o["denetim"]
        b += ["## 6. Dil denetimi (ortak denetleyici)", "",
              tablo(["Kural", "Toplam", "Muaf", "Açık"],
                    [[k, v.get("toplam", 0), v.get("muaf", 0), v.get("acik", 0)]
                     for k, v in dn.items() if not k.startswith("_")]
                    + [["**Toplam**", dn["_acik"] + dn["_muaf"], dn["_muaf"], f"**{dn['_acik']}**"]]), "",
              f"`norm` işaretlerinin {dn['_norm_iy']} tanesi î + y yazımıdır (*azadîya* → *azadiya*). "
              "Açık işaretler: [ziman_isaret.tsv](ziman_isaret.tsv) · muafiyetler: `tools/qa/ziman_muaf.tsv`", ""]

    s = o["ses"]
    b += ["## 7. Hazır ses kapsamı", "",
          tablo([""] + D + ["Tümü"], [
              ["Madde başı"] + [pc(s["duzey"][d]["madde"]) for d in SEVIYE] + [pc(s["madde"])],
              ["`her` cümleleri"] + [pc(s["duzey"][d]["her"]) for d in SEVIYE] + [pc(s["her"])],
              ["`gen` cümleleri"] + [pc(s["duzey"][d]["gen"]) for d in SEVIYE] + [pc(s["gen"])],
          ]), "",
          f"Dinleme metinleri: {s['dinleme_var']} / {s['dinleme']} · ses bildirimi {bin(s['bildirim_anahtari'])} anahtar.", ""]

    a, n = o["atasozu"], o["acik_norm"]
    b += ["## 8. Atasözleri", "",
          f"{bin(a['n'])} atasözünün {a['turkce_harfli']} tanesinde Türkçe harf (ı ğ ü ö â) var; "
          f"en az dört sözcüklü {bin(a['sapkasiz_payda'])} atasözünün {bin(a['sapkasiz'])} tanesinde "
          "hiç şapkalı ünlü (ê î û) yok.", "",
          "## 9. Karara bağlanmamış yazım noktaları", "",
          "Sayılır, işaretlenmez; karar: [../norm_uzlasmasi.md](../norm_uzlasmasi.md).", "",
          tablo(["Nokta", "Biçim A", "Sayı", "Biçim B", "Sayı"], [
              ["Dil adı (cümle içi)", "Kurdî, Kurmancî", n["dil_adi_buyuk"], "kurdî, kurmancî", n["dil_adi_kucuk"]],
              ["Ay adı (cümle içi)", "Adar, Gulan", n["ay_adi_buyuk"], "adar, gulan", n["ay_adi_kucuk"]],
              ["İkisi de", "herdu", n["herdu"], "her du", n["her_du"]],
          ]), ""]
    return "\n".join(b)


def main() -> None:
    o = olc()
    CIKTI.mkdir(parents=True, exist_ok=True)
    taban_yol = CIKTI / "taban.json"
    if "--taban" in sys.argv:
        taban_yol.write_text(json.dumps(o, ensure_ascii=False, indent=1), encoding="utf-8")
    taban = json.loads(taban_yol.read_text(encoding="utf-8")) if taban_yol.exists() else None
    (CIKTI / "olcum.json").write_text(json.dumps(o, ensure_ascii=False, indent=1), encoding="utf-8")
    (CIKTI / "olcum.md").write_text(rapor(o, taban), encoding="utf-8")
    print(f"-> {(CIKTI / 'olcum.md').relative_to(PROJE)}")
    if "taniklik" not in o:
        print("Ziman katmanı bulunamadı: tanıklık, kapsam, cinsiyet ve dil denetimi bölümleri atlandı.")


if __name__ == "__main__":
    main()
