# -*- coding: utf-8 -*-
"""Cümle havuzu: örnek cümlelerin ölçümü, korpustan aday çıkarma, havuz denetimi.

İyileştirme planı Faz 3. Hedef: etkinliklerde kullanılan `her` örneklerinin
parça değil cümle olması; her kelime için Türkçe çevirisi olan en az iki tam cümle.

    python tools/qa/cumle.py --olc                  düzey düzey durum
    python tools/qa/cumle.py --aday a2              korpustan aday cümleler (depo DIŞINA yazar)
    python tools/qa/cumle.py --aday a2 --kat xwarin yalnız bir birim
    python tools/qa/cumle.py --denetle              docs/cumle/havuz.tsv'yi sına
    python tools/qa/cumle.py --uygula               havuzu içeriğe işle (düzeltme tablosu + çeviri dosyası)

Uzunluk ölçüsü (sözcük): A1 3–5, A2 4–7, B1 6–9, B2 8–12, C1–C2 10–15.

Aday dosyaları korpustan birebir cümle içerir; korpus teliflidir. Bu yüzden
`Kurmanci/Lutke/cumle_havuzu/` altına (depo dışına) yazılır ve gönderilmez.
Havuza giren cümle adaydan sadeleştirilerek ya da yeniden yazılarak alınır;
`kaynak` sütununa eserin adı değil, yalnız türü (`korpus-sade` / `yazıldı`) yazılır.

Korpusa dayandığı için yalnız yerelde çalışır.
"""

import csv
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402
import olcum  # noqa: E402

PROJE = icerik.PROJE
KURMANCI = PROJE.parents[2]
ZIMAN = KURMANCI / "Ziman"
ADAY_KLASOR = KURMANCI / "Lutke" / "cumle_havuzu"
HAVUZ = PROJE / "docs" / "cumle" / "havuz.tsv"
CEVIRI_DART = PROJE / "lib" / "features" / "lessons" / "domain" / "ornek_ceviri_db.dart"
SEVIYE = icerik.DUZEYLER
BANT = {"a1": (3, 5), "a2": (4, 7), "b1": (6, 9), "b2": (8, 12), "c1": (10, 15), "c2": (10, 15)}
SOZ = re.compile(r"[a-zçêîşû]+(?:'[a-zçêîşû]+)?")
HARF = "a-zA-ZçêîşûÇÊÎŞÛ"
HAVUZ_SUTUN = ["kimlik", "sira", "ku", "tr", "kaynak", "durum"]


def kucuk(s: str) -> str:
    return olcum.kucuk(s)


def sozcuk_sayisi(s: str) -> int:
    return len(SOZ.findall(kucuk(s)))


# `olcum.yuklem_var` taban ölçümüyle aynı kalsın diye değiştirilmedi; burada
# onun kaçırdığı çekimler eklenir: düzensiz şimdiki zaman (tê, dibe), bitmiş
# geçmiş (bûye, hatiye) ve mastarla eşyazımlı çoğul geçmiş (em çûn).
EK_FIIL = re.compile(r"^(?:t[êe]m?|têyî|tên|n?ay[êe]|dib[ei]n?|dibim|nab[ei]n?|"
                     r"(?:ne)?(?:bû|çû|hat|ket|ma|da|kir|got|dît)(?:m|n|yî|ye|ne|me|iye|ine|ime)?)$")


def yuklem_var(s: str, coz) -> bool:
    if olcum.yuklem_var(s, coz):
        return True
    tok = SOZ.findall(kucuk(s))
    for i, t in enumerate(tok):
        if EK_FIIL.match(t) or olcum.SIMDIKI.match(t):
            return True
        if i and coz(t) == (t, "verb") and set(tok[:i]) & (olcum.ZAMIR | {"zarok", "hemû"}):
            return True
    return False


def tam_cumle(s: str, coz) -> bool:
    """Yüklemi olan ve en az üç sözcüklü örnek."""
    return sozcuk_sayisi(s) >= 3 and yuklem_var(s, coz)


_korpus_bicim = {}


def bicim_maddeleri() -> dict:
    """biçim -> o biçimin bağlı olduğu maddeler (lemma tablosundaki bütün eşleşmeler)."""
    if "m" not in _korpus_bicim:
        d = defaultdict(set)
        with (ZIMAN / "lemma.tsv").open(encoding="utf-8", newline="") as f:
            for r in csv.DictReader(f, delimiter="\t"):
                d[r["bicim"]].add(r["madde"])
        _korpus_bicim["m"] = d
    return _korpus_bicim["m"]


def korpus_bicimleri() -> Counter:
    """Diakritiği sağlam korpusta her sözcük biçiminin geçiş sayısı."""
    if not _korpus_bicim:
        sys.path.insert(0, str(ZIMAN / "araclar"))
        import cins
        _korpus_bicim["c"] = Counter(SOZ.findall(icerik.nfc(cins.korpus_metni(saglam=True))))
    return _korpus_bicim["c"]


# ── Ölçüm ────────────────────────────────────────────────────────────────────

def olc(kel: dict, coz) -> dict:
    o = {}
    for d in SEVIYE:
        alt, ust = BANT[d]
        c = Counter()
        for k in kel[d]:
            tam = [s for s in k["her"] if tam_cumle(s, coz)]
            c["kelime"] += 1
            c["ornek"] += len(k["her"])
            c["tam"] += len(tam)
            c["bantta"] += sum(alt <= sozcuk_sayisi(s) <= ust for s in tam)
            c["iki_tam"] += len(tam) >= 2
            c["hic_tam"] += len(tam) == 0
        o[d] = dict(c)
    return o


def olc_yaz(o: dict) -> None:
    print(f"{'':4}{'kelime':>7}{'örnek':>7}{'tam cümle':>11}{'bantta':>8}{'iki tam cümlesi olan':>22}{'hiç tam cümlesi yok':>21}")
    for d in SEVIYE:
        c = o[d]
        print(f"{d:4}{c['kelime']:>7}{c['ornek']:>7}{c['tam']:>7} %{100 * c['tam'] / max(c['ornek'], 1):>2.0f}"
              f"{c['bantta']:>8}{c['iki_tam']:>16} %{100 * c['iki_tam'] / max(c['kelime'], 1):>3.0f}"
              f"{c['hic_tam']:>15} %{100 * c['hic_tam'] / max(c['kelime'], 1):>3.0f}")


# ── Korpustan aday ───────────────────────────────────────────────────────────

def korpus_cumleleri() -> list:
    """[(cümle, sınıf)] — diakritiği sağlam, edebiyat ve gramer dosyalarından."""
    sys.path.insert(0, str(ZIMAN / "araclar"))
    import diakritik
    hasarli = {x for l in diakritik.hasarli().values() for x in l} if isinstance(diakritik.hasarli(), dict) else set()
    cikti, gorulen = [], set()
    with (ZIMAN / "korpus" / "manifest.tsv").open(encoding="utf-8", newline="") as f:
        for m in csv.DictReader(f, delimiter="\t"):
            if m["dil"] != "ku" or m["sinif"] not in ("edebiyat", "gramer") or "[OCR]" in m["etiket"]:
                continue
            if m["dosya"] in hasarli or Path(m["dosya"]).name in hasarli:
                continue
            p = ZIMAN / "korpus" / m["dosya"]
            if not p.exists():
                continue
            t = icerik.nfc(p.read_text(encoding="utf-8", errors="ignore"))
            t = re.sub(r"-\n(?=[a-zçêîşû])", "", t)
            t = re.sub(r"\s+", " ", t)
            for s in re.split(r"(?<=[.!?])\s+(?=[A-ZÇÊÎŞÛ])", t):
                s = s.strip(" -–—\"“”'‘’")
                if not re.fullmatch(r"[" + HARF + r"' ,]+[.!?]", s):
                    continue
                if not 3 <= sozcuk_sayisi(s) <= 15 or kucuk(s) in gorulen:
                    continue
                gorulen.add(kucuk(s))
                cikti.append((s, m["sinif"]))
    return cikti


def bilinenler(kel: dict, duzey: str, coz) -> set:
    """Öğrencinin o düzeyin sonuna kadar gördüğü maddeler + en sık 150 işlev sözcüğü."""
    b = set()
    for d in SEVIYE[:SEVIYE.index(duzey) + 1]:
        for k in kel[d]:
            for t in SOZ.findall(kucuk(k["ku"])):
                b.add(t)
                b.add(coz(t)[0])
    with (ZIMAN / "siklik.tsv").open(encoding="utf-8", newline="") as f:
        for i, r in enumerate(csv.DictReader(f, delimiter="\t")):
            if i >= 150:
                break
            b.add(r["madde"])
    return b


def aday(kel: dict, duzey: str, coz, kat: str | None, hepsi: bool) -> None:
    alt, ust = BANT[duzey]
    cumleler = [(s, sinif, SOZ.findall(kucuk(s))) for s, sinif in korpus_cumleleri()]
    cumleler = [c for c in cumleler if alt <= len(c[2]) <= ust]
    bil = bilinenler(kel, duzey, coz)
    dizin = defaultdict(list)
    for i, (_, _, tok) in enumerate(cumleler):
        for m in {coz(t)[0] for t in tok} | set(tok):
            dizin[m].append(i)
    satir, kapsanan, hedef = [], 0, 0
    for k in kel[duzey]:
        if kat and k["kat"] != kat:
            continue
        tam = [s for s in k["her"] if tam_cumle(s, coz)]
        if len(tam) >= 2 and not hepsi:
            continue
        m = kucuk(k["ku"]).rstrip("!?.")
        if not SOZ.fullmatch(m):
            continue                      # çok sözcüklü madde başı: elle
        hedef += 1
        anahtar = {m, coz(m)[0]}
        adaylar = []
        for i in {i for a in anahtar for i in dizin.get(a, [])}:
            s, sinif, tok = cumleler[i]
            bilinen = sum(t in bil or coz(t)[0] in bil for t in tok) / len(tok)
            adaylar.append((bilinen, sinif == "gramer", -len(tok), s))
        adaylar.sort(reverse=True)
        kapsanan += bool(adaylar)
        for bilinen, _, _, s in adaylar[:6]:
            satir.append([k["id"], k["ku"], k["tr"], k["kat"], 2 - len(tam), f"{bilinen:.2f}", s])
    ADAY_KLASOR.mkdir(parents=True, exist_ok=True)
    yol = ADAY_KLASOR / f"aday_{duzey}{'_' + kat if kat else ''}.tsv"
    with yol.open("w", encoding="utf-8", newline="") as f:
        y = csv.writer(f, delimiter="\t", lineterminator="\n")
        y.writerow(["kimlik", "ku", "tr", "kat", "eksik", "bilinen_oran", "aday"])
        y.writerows(satir)
    print(f"{duzey}: bantta ({alt}–{ust} sözcük) {len(cumleler)} korpus cümlesi; tam cümlesi eksik tek sözcüklü madde {hedef}; "
          f"en az bir adayı olan {kapsanan} -> {yol}")


# ── Havuz ────────────────────────────────────────────────────────────────────

def havuz_oku() -> list:
    if not HAVUZ.exists():
        return []
    with HAVUZ.open(encoding="utf-8", newline="") as f:
        return [r for r in csv.DictReader((s for s in f if not s.startswith("#")), delimiter="\t") if r.get("kimlik")]


def denetle(kel: dict, coz) -> int:
    """Havuzdaki her cümleyi sınar; sorunlu satır sayısını döndürür."""
    sys.path.insert(0, str(ZIMAN / "araclar"))
    import kontrol
    import cins_kanit
    kontrol.EK_CINS = cins_kanit.lutke_cinsleri(kel)
    ix, rakip = kontrol.indeks_oku(), kontrol.terim_haritasi()
    kurallar = {"yazim", "ergatif", "ergnav", "lihev", "izafe", "nesne", "edat", "norm"}
    kayit = {k["id"]: (d, k) for d in kel for k in kel[d]}
    bicimler, korpus = cins_kanit._bicimler(), korpus_bicimleri()
    import ziman_denetim
    muaf = ziman_denetim.muafiyetler()
    sorunlu = 0
    for r in havuz_oku():
        d, k = kayit.get(r["kimlik"], (None, None))
        s, sorun = r["ku"], []
        if not k:
            sorun.append("kimlik yok")
        else:
            alt, ust = BANT[d]
            n = sozcuk_sayisi(s)
            if not alt <= n <= ust:
                sorun.append(f"uzunluk {n} (bant {alt}–{ust})")
            if not yuklem_var(s, coz):
                sorun.append("yüklem bulunamadı")
            m = [x for t in SOZ.findall(kucuk(k["ku"])) for x in {t, coz(t)[0]}]
            tok = SOZ.findall(kucuk(s))
            # çekimli fiilde ön ekle kök arasına di-/bi-/na- girer: vegerîn -> vedigerî
            acik = set(tok) | {t.replace(e, "", 1) for t in tok for e in ("di", "bi", "na", "ne")}
            kokler = {coz(t)[0] for t in tok} | acik
            # kökü değişen fiiller (bûn -> dibe, bibim): lemma tablosunda o fiile bağlı biçim yeter
            tablodan = any(x in bicim_maddeleri().get(t, ()) for t in tok for x in m)
            if not tablodan and not any(x in kokler or any(t.startswith(x[:max(3, len(x) - 2)]) for t in acik) for x in m):
                sorun.append("madde başı cümlede yok")
            # Tanınmayan biçim: ne sözlük tablosunda ne korpusta (en az iki kez) var. "Dur ve doğrula."
            def bilinir(t):
                kok = coz(t)[0]          # düzenli çekim: kökü biliniyorsa biçim de bilinir (neyar -> neyarê)
                return t in bicimler or korpus[t] >= 2 or (kok != t and (kok in bicimler or korpus[kok] >= 2))
            bilinmeyen = [t for t in tok if not bilinir(t)]
            if bilinmeyen:
                sorun.append("tanınmayan biçim: " + ", ".join(bilinmeyen))
        if not r["tr"].strip():
            sorun.append("çeviri yok")
        for kural, _, mesaj in kontrol.denetle_metin(s, kurallar, ix, rakip):
            anahtar = f"{mesaj} || {s}"
            if any(kr in (kural, "*") and ds.search(anahtar) and kp is None for kr, ds, kp, _ in muaf):
                continue
            sorun.append(f"{kural}: {' '.join(mesaj.split())[:70]}")
        if sorun:
            sorunlu += 1
            print(f"{r['kimlik']:10} {s}\n           -> " + " | ".join(sorun))
    print(f"{len(havuz_oku())} cümle; sorunlu {sorunlu}")
    return sorunlu


def uygula(kel: dict) -> None:
    """Havuzu düzeltme tablosuna ve çeviri dosyasına çevirir (içeriği `duzelt.py` değiştirir)."""
    kayit = {k["id"]: k for d in kel for k in kel[d]}
    satir, ceviri = [], {}
    for r in havuz_oku():
        k = kayit[r["kimlik"]]
        i = int(r["sira"])
        ceviri[r["ku"]] = r["tr"]
        if i < len(k["her"]) and k["her"][i] != r["ku"]:
            satir.append([r["kimlik"], "her", k["her"][i], r["ku"], "cumle", f"parça yerine tam cümle ({r['kaynak']})"])
    yol = PROJE / "docs" / "duzeltme" / "girdi" / "cumle_havuzu.tsv"
    with yol.open("w", encoding="utf-8", newline="") as f:
        y = csv.writer(f, delimiter="\t", lineterminator="\n")
        y.writerow(["kimlik", "alan", "eski", "yeni", "kural", "gerekce"])
        y.writerows(satir)
    d = ["// LÛTKE — Örnek cümlelerin Türkçe çevirileri (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// Kaynak: docs/cumle/havuz.tsv. Elle düzenleme; `python tools/qa/cumle.py --uygula` üzerine yazar.",
         "",
         "/// Kurmancî örnek cümle → Türkçe çevirisi.",
         "const Map<String, String> kOrnekTr = <String, String>{"]
    for ku in sorted(ceviri):
        d.append("  '" + ku.replace("\\", "\\\\").replace("'", "\\'") + "': '"
                 + ceviri[ku].replace("\\", "\\\\").replace("'", "\\'") + "',")
    d += ["};", "",
          "/// Örnek cümlenin Türkçesi; havuzda yoksa `null`.",
          "String? ornekCevirisi(String cumle) => kOrnekTr[cumle.trim()];", ""]
    CEVIRI_DART.write_text("\n".join(d), encoding="utf-8", newline="\n")
    print(f"{len(satir)} değişiklik -> {yol.relative_to(PROJE)}; {len(ceviri)} çeviri -> {CEVIRI_DART.relative_to(PROJE)}")
    print("Sonra: python tools/qa/duzelt.py docs/duzeltme/girdi/cumle_havuzu.tsv [--uygula]")


def main() -> None:
    if not olcum.ziman_var():
        print("Ziman katmanı bulunamadı; cümle havuzu araçları yalnız yerelde çalışır.")
        return
    kel = icerik.kelimeler(cocuk=False)
    coz = olcum.cozucu()
    arg = sys.argv[1:]
    if "--aday" in arg:
        d = arg[arg.index("--aday") + 1].lower()
        kat = arg[arg.index("--kat") + 1] if "--kat" in arg else None
        aday(kel, d, coz, kat, "--hepsi" in arg)
    elif "--denetle" in arg:
        sys.exit(1 if denetle(kel, coz) else 0)
    elif "--uygula" in arg:
        uygula(kel)
    else:
        o = olc(kel, coz)
        olc_yaz(o)
        # Sonuç dosyaya yazılır; Faz 3 başındaki durum `cumle_taban.json`da durur.
        cikti = PROJE / "docs" / "olcum"
        (cikti / "cumle.json").write_text(json.dumps(o, ensure_ascii=False, indent=1), encoding="utf-8")
        taban = cikti / "cumle_taban.json"
        if taban.exists():
            t = json.loads(taban.read_text(encoding="utf-8"))
            print()
            print("Faz 3 başına göre (iki tam cümlesi olan kelime / hiç tam cümlesi olmayan):")
            for d in SEVIYE:
                print(f"  {d}: {t[d]['iki_tam']} -> {o[d]['iki_tam']}   /   {t[d]['hic_tam']} -> {o[d]['hic_tam']}")


if __name__ == "__main__":
    main()
