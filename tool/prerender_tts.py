"""LÛTKE — TTS ön-render script.

Kurmancî kelimeleri HuggingFace Kurmancî TTS API'sine (amedcj/kmr_tts)
gönderir, dönen MP3'leri assets/audio/words/ altına kaydeder ve Dart
manifest dosyasını günceller.

Kullanım:
    python tool/prerender_tts.py               # A1'in ilk 50 kelimesi (test)
    python tool/prerender_tts.py --level a1    # Tüm A1
    python tool/prerender_tts.py --level all   # Tüm seviyeler (dikkat: yüzlerce MB)
    python tool/prerender_tts.py --limit 10    # sadece 10 kelime
    python tool/prerender_tts.py --only dest,nan,av  # belirli kelimeler

Bağımlılıklar:
    pip install requests
"""
import argparse
import json
import re
import sys
import time
import hashlib
from pathlib import Path
from typing import Optional

try:
    import requests
except ImportError:
    print("ERROR: 'requests' yok. Kur: pip install requests")
    sys.exit(1)

PROJECT = Path(__file__).parent.parent
ASSETS_DIR = PROJECT / 'assets' / 'audio' / 'words'
MANIFEST_FILE = PROJECT / 'lib' / 'core' / 'services' / 'tts_asset_manifest.dart'
DB_DIR = PROJECT / 'lib' / 'features' / 'lessons' / 'domain'

HF_BASE = 'https://amedcj-kmr-tts.hf.space'
HF_ENDPOINT = 'text_to_speech'  # Gradio named endpoint
HF_SUBMIT = f'{HF_BASE}/gradio_api/call/{HF_ENDPOINT}'
AUDIO_EXT = 'wav'  # HF model returns WAV

# ── Kelime çıkarma ────────────────────────────────────────────────
ID_KU_PAT = re.compile(
    r"\(\s*id\s*:\s*['\"]([^'\"]+)['\"][^)]*?ku\s*:\s*['\"]([^'\"]+)['\"]",
    re.DOTALL,
)
# her:[ '...', '...' ]  veya her:[ "...", "..." ] — string list yakalama
HER_LIST_PAT = re.compile(r"her\s*:\s*\[([^\[\]]*)\]", re.DOTALL)
HER_STR_PAT = re.compile(r"['\"]([^'\"]+)['\"]")


def extract_words(level: str):
    """Verilen seviyenin DB dosyasından (id, ku) çiftlerini çıkar."""
    db = DB_DIR / f'{level}_kelime_db.dart'
    if not db.exists():
        return []
    text = db.read_text(encoding='utf-8')
    items = []
    for m in ID_KU_PAT.finditer(text):
        wid, ku = m.group(1), m.group(2)
        # Çok-kelimeli ifadeleri/prefixleri atla — tek kelime ses hedefliyoruz.
        if (' ' in ku) or ('.' in ku) or ('-' in ku and not ku.endswith('in')):
            continue
        # Tek harf veya çok kısa (HF model 500 verir)
        if len(ku) < 3:
            continue
        items.append((wid, ku))
    return items


def extract_heritage(level: str):
    """Verilen seviyeden tüm heritage cümlelerini (id, sentence) çıkar.
    Her kelimenin her cümlesi için: id = '{wid}_h{n}' (n=1,2,...).
    """
    db = DB_DIR / f'{level}_kelime_db.dart'
    if not db.exists():
        return []
    text = db.read_text(encoding='utf-8')
    items = []
    # Tüm kayıtları gez
    for m in ID_KU_PAT.finditer(text):
        wid = m.group(1)
        # Bu kaydın açılış parantezinden kapanışına kadar al
        depth, i = 0, m.start()
        while i < len(text):
            if text[i] == '(':
                depth += 1
            elif text[i] == ')':
                depth -= 1
                if depth == 0:
                    end = i + 1
                    break
            i += 1
        else:
            continue
        record = text[m.start():end]
        her_m = HER_LIST_PAT.search(record)
        if not her_m:
            continue
        sentences = HER_STR_PAT.findall(her_m.group(1))
        for idx, sent in enumerate(sentences, 1):
            sent = sent.strip()
            # Çok kısa (3 karakter) atla; çok uzun (200+) HF için riskli
            if len(sent) < 5 or len(sent) > 200:
                continue
            items.append((f'{wid}_h{idx}', sent))
    return items


# ── HF API ────────────────────────────────────────────────────────
def synthesize(text: str, session: requests.Session, cold_timeout: int = 90) -> Optional[bytes]:
    """Bir kelimeyi HF API'ye gönder, dönen MP3 bayt dizisini döndür."""
    # Adım 1: iş gönder
    try:
        r = session.post(
            HF_SUBMIT,
            json={'data': [text]},
            headers={'Content-Type': 'application/json; charset=utf-8',
                     'Accept': 'application/json'},
            timeout=cold_timeout,
        )
        r.raise_for_status()
        event_id = r.json().get('event_id')
        if not event_id:
            return None
    except Exception as e:
        print(f'  submit fail [{text}]: {e}')
        return None

    # Adım 2: polling
    result_url = f'{HF_BASE}/gradio_api/call/{HF_ENDPOINT}/{event_id}'
    audio_url = None
    for _ in range(180):  # max 90s
        time.sleep(0.5)
        try:
            rr = session.get(result_url, timeout=15)
            body = rr.text
        except Exception:
            continue
        if 'event: complete' in body:
            for line in body.split('\n'):
                line = line.strip()
                if line.startswith('data:'):
                    try:
                        data = json.loads(line[5:].strip())
                    except json.JSONDecodeError:
                        continue
                    if isinstance(data, list) and data:
                        first = data[0]
                        if isinstance(first, dict) and 'url' in first:
                            audio_url = first['url']
                        elif isinstance(first, str):
                            audio_url = f'{HF_BASE}/file={first}'
                        break
            break
        if 'event: error' in body:
            return None

    if not audio_url:
        return None

    # Adım 3: MP3 indir
    try:
        dr = session.get(audio_url, timeout=30)
        dr.raise_for_status()
        return dr.content
    except Exception as e:
        print(f'  download fail [{text}]: {e}')
        return None


# ── Manifest dosyası güncelleme ───────────────────────────────────
def write_manifest(entries: dict):
    """{kelime: asset_yolu} eşlemesini Dart const Map olarak yaz."""
    sorted_keys = sorted(entries.keys())
    lines = []
    for k in sorted_keys:
        v = entries[k]
        # Dart string escape
        k_esc = k.replace("\\", "\\\\").replace("'", "\\'")
        v_esc = v.replace("\\", "\\\\").replace("'", "\\'")
        lines.append(f"    '{k_esc}': '{v_esc}',")
    body = '\n'.join(lines)
    content = f'''/// LÛTKE — TTS Asset Manifest (OTOMATIK ÜRETİLMİŞTİR)
///
/// Ön-üretilen Kurmancî TTS ses dosyalarının kataloğu.
/// Bu dosyayı elle düzenleme — `tool/prerender_tts.py` üzerine yazar.

class TtsAssetManifest {{
  /// Kelime (küçük harf, normalleştirilmiş) → asset yolu.
  static const Map<String, String> entries = <String, String>{{
{body}
  }};

  static int get count => entries.length;

  static String? lookup(String word) {{
    final key = word.trim().toLowerCase();
    if (key.isEmpty) return null;
    final normalized = key.replaceAll(RegExp(r'[.,!?]+$'), '').trim();
    return entries[normalized] ?? entries[key];
  }}
}}
'''
    MANIFEST_FILE.write_text(content, encoding='utf-8')


def load_existing_manifest():
    """Mevcut manifest'ten entries'i oku (birikmeli çalışma için)."""
    if not MANIFEST_FILE.exists():
        return {}
    text = MANIFEST_FILE.read_text(encoding='utf-8')
    entries = {}
    for m in re.finditer(r"'([^']+)'\s*:\s*'([^']+)'", text):
        k, v = m.group(1), m.group(2)
        # "count" gibi property olmayanları filtre
        if v.startswith('assets/'):
            entries[k] = v
    return entries


# ── Ana akış ──────────────────────────────────────────────────────
def normalize_key(ku: str) -> str:
    """Manifest anahtarı için kelime normalleştirme (TTS _preprocessText ile uyumlu)."""
    clean = ku.strip().lower()
    clean = re.sub(r'\s+', ' ', clean)
    # Tek kelime ise nokta eklenir (TTS service gibi) — ama manifest key olarak
    # nokta'sız tutalım çünkü lookup iki varyantı da dener.
    return clean


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--level', default='a1',
                        choices=['a1', 'a2', 'b1', 'b2', 'c1', 'c2', 'all'])
    parser.add_argument('--limit', type=int, default=50,
                        help='Max kelime sayısı (test için). 0 = sınırsız.')
    parser.add_argument('--only', type=str, default='',
                        help='Sadece verilen Kurmancî kelimeler (virgülle ayrılmış).')
    parser.add_argument('--force', action='store_true',
                        help='Mevcut MP3\'ün üzerine yaz (yeniden üret).')
    parser.add_argument('--heritage', action='store_true',
                        help='Kelimeler yerine heritage cümlelerini render et.')
    args = parser.parse_args()

    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    existing = load_existing_manifest()
    print(f'Mevcut manifest: {len(existing)} kayıt')

    # Hedef kelime listesi oluştur
    targets = []
    if args.only:
        only_list = [w.strip() for w in args.only.split(',') if w.strip()]
        # onlyFields: basit, id yoktur — hash kullan
        for ku in only_list:
            wid = 'only_' + hashlib.md5(ku.encode('utf-8')).hexdigest()[:8]
            targets.append((wid, ku))
    else:
        levels = ['a1', 'a2', 'b1', 'b2', 'c1', 'c2'] if args.level == 'all' else [args.level]
        extractor = extract_heritage if args.heritage else extract_words
        seen_keys = set()
        for lvl in levels:
            for wid, txt in extractor(lvl):
                # Aynı cümle farklı kelimelerde geçebilir — dedupe
                k = txt.strip().lower()
                if k in seen_keys:
                    continue
                seen_keys.add(k)
                targets.append((wid, txt))

    if args.limit > 0:
        targets = targets[: args.limit]

    print(f'Hedef kelime sayısı: {len(targets)}')

    session = requests.Session()

    # Warm-up
    try:
        session.get(HF_BASE, timeout=10)
    except Exception:
        pass

    new_count = 0
    skip_count = 0
    fail_count = 0
    for i, (wid, ku) in enumerate(targets, 1):
        asset_name = f'{wid}.{AUDIO_EXT}'
        target_path = ASSETS_DIR / asset_name
        relative = f'assets/audio/words/{asset_name}'
        key = normalize_key(ku)

        if not args.force and target_path.exists() and key in existing:
            skip_count += 1
            print(f'[{i}/{len(targets)}] SKIP {ku} ({wid}) — zaten var')
            continue

        print(f'[{i}/{len(targets)}] synth: {ku} ({wid})...', end=' ', flush=True)
        mp3 = synthesize(ku, session)
        if mp3 is None or len(mp3) < 1000:
            print('FAIL')
            fail_count += 1
            continue

        target_path.write_bytes(mp3)
        existing[key] = relative
        new_count += 1
        print(f'OK ({len(mp3)//1024}KB)')

        # Her 20'de bir manifest'i güncelle (kesinti durumunda ilerleme korunsun)
        if new_count % 20 == 0:
            write_manifest(existing)

    # Son manifest yazımı
    write_manifest(existing)

    print(f'\n== BİTTİ ==')
    print(f'  Yeni: {new_count}')
    print(f'  Atlanan (zaten var): {skip_count}')
    print(f'  Hatalı: {fail_count}')
    print(f'  Manifest toplam: {len(existing)} kayıt')
    print(f'  Dosyalar: {ASSETS_DIR}')


if __name__ == '__main__':
    main()
