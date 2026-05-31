// LÛTKE — Veri-güdümlü içerik sayfaları üreticisi
// content.json (tool/export_content.dart çıktısı) → statik Kurmancî sayfalar:
//   /naverok               içerik hub'ı (istatistik + bölüm kartları)
//   /peyv/<lvl>            kelime listesi (arama + kategori filtre)
//   /wane/<lvl>            ders listesi (birime gruplu)
//   /wane/<lessonId>       ders detayı — egzersizler/etkinlikler
//   /diyalog/<id>          heritage diyalog sahnesi
//   /reziman               gramer rehberi hub'ı
//   /reziman/<slug>        gramer konusu detayı (kural + örnek + ipucu)
//   /cand                  kültür hub'ı (bölüm kartları)
//   /cand/gotinen-pesiyan  atasözleri (arama + harf filtre)
//   /cand/<group>          kültür koleksiyonu (şiir/şarkı/efsane/yemek/...)
//   /cand/<group>/<id>     tek kültür öğesi (tam metin)
//
// build-site.mjs çağırır; ortak render bağlamını geçer (renderPage/escHtml/SITE_URL/log).

import { promises as fs } from 'node:fs';
import { existsSync } from 'node:fs';
import path from 'node:path';

const LEVELS = ['a1', 'a2', 'b1', 'b2', 'c1', 'c2'];
const LEVEL_NAME = {
  a1: 'Destpêk', a2: 'Bingehîn', b1: 'Navîna Jêrîn',
  b2: 'Navîna Jorîn', c1: 'Pêşketî', c2: 'Pispor',
};

const KAT_LABEL = {
  alfabe: 'Alfabe', silav: 'Silav û pêşkêşkirin', greeting: 'Silav',
  malbat: 'Malbat', family: 'Malbat', jimar: 'Jimar', numbers: 'Jimar',
  reng: 'Reng', food: 'Xwarin û vexwarin', xwarin: 'Xwarin', daily: 'Jiyana rojane',
  beden: 'Beden', las: 'Beden', cins: 'Cînavk', cinavk: 'Cînavk',
  pise: 'Pîşe', perwerde: 'Perwerdehî', dibistan: 'Dibistan', dem: 'Dem û rojan',
  cih: 'Cih û alî', xweza: 'Xweza', heywan: 'Heywan', ajal: 'Heywan',
  rengder: 'Rengdêr', leker: 'Leker (kar)', dacek: 'Daçek', edat: 'Daçek',
  ergatif: 'Ergatîf', ergatif_b2: 'Ergatîf (B2)', edebiyat: 'Edebiyat',
  zanist: 'Zanist', siyaset: 'Siyaset', cand: 'Çand', dirok: 'Dîrok',
  huner: 'Huner', ziman: 'Ziman', reziman: 'Rêziman', tendurist: 'Tenduristî',
  dua: 'Dua û daxwaz', vexwarin: 'Vexwarin', mewe: 'Mêwe', cil: 'Cil û berg',
  gihani: 'Gihanî', demsal: 'Demsal', peyvben: 'Peyvên pêkhatî', pirs: 'Pirs',
  bun: 'Bûn û hebûn', spor: 'Werziş', teknoloji: 'Teknolojî', huquq: 'Hiqûq', hukuk: 'Hiqûq',
};
function katLabel(k) {
  if (!k) return 'Giştî';
  return KAT_LABEL[k] || (k.charAt(0).toUpperCase() + k.slice(1));
}

const EX_TYPE_LABEL = {
  listenAndSelect: 'Guhdarî & hilbijartin',
  multipleChoice: 'Pirsa pirhilbijartî',
  dragAndDrop: 'Rêzkirina peyvan',
  fillInBlank: 'Cihê vala dagire',
  speakingPractice: 'Pratîka axaftinê',
  minimalPair: 'Cotên hindik-cuda',
  culturalContent: 'Naveroka çandî',
};
const PATH_LABEL = { heritage: 'Rêya Malê', general: 'Rêya Nû', cultural: 'Rêya Çandê' };

// Çand grup adları/etiketleri (export'taki cand anahtarlarıyla eşleşir)
const CAND_GROUPS = {
  artists: { ku: 'Stranbêj û Hunermend', emoji: '🎵', desc: 'Dengbêj, stranbêj û hunermendên Kurd.' },
  poems: { ku: 'Helbest', emoji: '✒️', desc: 'Helbestên klasîk û nûjen — bi tevahî metin.' },
  songs: { ku: 'Stran', emoji: '🎶', desc: 'Stranên Kurdî — gotinên wan bi temamî.' },
  legends: { ku: 'Destan û Efsane', emoji: '📜', desc: 'Destanên kevnar û çîrokên gelêrî.' },
  figures: { ku: 'Kesayetên Dîrokî', emoji: '🏛️', desc: 'Kesayetên ku şopa xwe li dîrokê hiştine.' },
  foods: { ku: 'Xwarinên Kurdî', emoji: '🍲', desc: 'Xwarin û edetên sifrê.' },
  celebrations: { ku: 'Cejn û Rojan', emoji: '🔥', desc: 'Newroz û cejnên Kurdî.' },
  dances: { ku: 'Govend û Cil', emoji: '💃', desc: 'Govend, dîlan û cil û bergên gelêrî.' },
  architecture: { ku: 'Mîmarî', emoji: '🕌', desc: 'Avahî û mîmariya Kurdî.' },
  events: { ku: 'Bûyerên Dîrokî', emoji: '📅', desc: 'Bûyerên girîng ên dîroka Kurdan.' },
  seed: { ku: 'Naveroka Giştî', emoji: '🌿', desc: 'Gotin, helbest û stranên bi birûman ve girêdayî.' },
};
const CAND_ORDER = ['artists', 'poems', 'songs', 'legends', 'figures', 'foods', 'celebrations', 'dances', 'architecture', 'events', 'seed'];

// ── SVG ikonlar ──
const CHECK = '<svg class="mk" viewBox="0 0 24 24" fill="none" stroke="#2D9E4F" stroke-width="3"><path d="M20 6L9 17l-5-5"/></svg>';
const DOT = '<svg class="mk" viewBox="0 0 24 24" fill="none" stroke="#CFE0DA" stroke-width="2"><circle cx="12" cy="12" r="8"/></svg>';
const SEARCH_ICO = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>';

function slugify(s) {
  return String(s)
    .replace(/İ/g, 'i').replace(/I/g, 'i') // Türkçe büyük I/İ → i (toLowerCase'den önce)
    .toLowerCase()
    .replace(/ê/g, 'e').replace(/î/g, 'i').replace(/û/g, 'u').replace(/ç/g, 'c').replace(/ş/g, 's')
    .replace(/ı/g, 'i').replace(/ğ/g, 'g').replace(/ö/g, 'o').replace(/ü/g, 'u') // Türkçe
    .replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '').slice(0, 60);
}

export async function generateContentPages(ctx) {
  const { ROOT, DIST, renderPage, SITE_URL, escHtml, BUILD_DATE = '2026-05-31' } = ctx;
  const candidates = [
    path.join(ROOT, 'website', 'data', 'content.json'),
    path.join(process.cwd(), 'website', 'data', 'content.json'),
  ];
  const dataPath = candidates.find(p => existsSync(p));
  if (!dataPath) {
    ctx.log(`WARNING: content.json yok (denenen: ${candidates.join(' | ')}) — atlandı. Önce: dart run tool/export_content.dart`);
    return { pages: 0, urls: [] };
  }
  const data = JSON.parse(await fs.readFile(dataPath, 'utf8'));
  const urls = [];
  let pageCount = 0;
  const m = data.meta;
  const nf = (n) => Number(n).toLocaleString('tr-TR');

  const wordById = new Map();
  for (const lvl of LEVELS) for (const w of (data.words[lvl] || [])) wordById.set(w.id, w);

  async function writeFile(p, c) { await fs.mkdir(path.dirname(p), { recursive: true }); await fs.writeFile(p, c); }
  async function emit(slugPath, html, meta, prio) {
    // İçerik detay sayfaları kendi section'larını içermez → .wrap konteyneriyle sar
    // (kenar boşluğu). Tam section yapısı olan sayfalar (naverok hub) _raw:true geçer.
    const body = meta._raw ? html : `<section class="content-page"><div class="wrap">${html}</div></section>`;
    const full = renderPage({ slug: slugPath, body, meta, activeNav: meta._nav || 'naverok' });
    await writeFile(path.join(DIST, slugPath + '.html'), full);
    if (meta._noindex !== true) urls.push({ loc: `${SITE_URL}/${slugPath}`, prio: prio || '0.5' });
    pageCount++;
  }
  function crumb(parts) {
    return `<nav class="crumb" aria-label="Rêçik">${parts.map((p, i) =>
      i === parts.length - 1
        ? `<span aria-current="page">${escHtml(p.label)}</span>`
        : `<a href="${p.href}">${escHtml(p.label)}</a><span class="sep">›</span>`
    ).join(' ')}</nav>`;
  }
  const appCta = (text, href, btn) =>
    `<div class="app-cta"><p>${escHtml(text)}</p><a class="btn btn-primary" href="${href}">${escHtml(btn)}</a></div>`;
  // çok satırlı içeriği paragraflara böl
  const para = (txt) => escHtml(txt).split(/\n{2,}/).map(p =>
    `<p>${p.replace(/\n/g, '<br>')}</p>`).join('');

  // ════════════════════════════════════════════════════════
  // 1) NAVEROK HUB — profesyonel: istatistik bandı + bölüm kartları
  // ════════════════════════════════════════════════════════
  {
    const stat = (num, lbl) => `<div class="stat"><div class="num">${num}</div><div class="lbl">${lbl}</div></div>`;
    const candCount = (m.candTotal || 0) + (m.proverbTotal || 0);
    let h = `<section class="page-hero"><div class="wrap">
      <span class="eyebrow">Naverok</span>
      <h1>Hemû naveroka LÛTKE</h1>
      <p class="lead">Tevahiya naveroka sepanê — niha li ser gerokê jî. Peyv, wane, diyalog, rêziman û çand; bê daxistin, bê têketin.</p>
    </div></section>

    <section class="section-tight"><div class="wrap">
      <div class="stats">
        ${stat(nf(m.wordTotal), 'Peyv')}
        ${stat(m.lessonTotal, 'Wane')}
        ${stat(m.exerciseTotal, 'Egzersîz')}
        ${stat(nf(candCount), 'Naveroka çandî')}
      </div>
    </div></section>`;

    // Ana bölüm kartları (büyük, ikon + açıklama + alt-link)
    const sections = [
      { href: '/peyv/a1', emoji: '📖', t: 'Peyv', d: `${nf(m.wordTotal)} peyv, A1–C2 — bi mînak û cins.`,
        sub: LEVELS.filter(l => (data.words[l] || []).length).map(l => `<a href="/peyv/${l}">${l.toUpperCase()}</a>`).join('') },
      { href: '/wane/a1', emoji: '🎓', t: 'Wane û Çalakî', d: `${m.lessonTotal} wane, ${m.exerciseTotal} egzersîz.`,
        sub: LEVELS.filter(l => (data.lessons[l] || []).length).map(l => `<a href="/wane/${l}">${l.toUpperCase()}</a>`).join('') },
      { href: '/reziman', emoji: '📐', t: 'Rêziman', d: `${m.grammarTotal} mijarên gramerê — bi qaîde û mînak.`, sub: '' },
      { href: '/cand', emoji: '🪕', t: 'Çand', d: `Atasozî, helbest, stran, destan û kesayet — ${nf(candCount)}+ tişt.`, sub: '' },
    ];
    h += `<section class="section"><div class="wrap">
      <div class="center" style="margin-bottom:40px"><span class="eyebrow">Beş</span><h2>Çi dixwazî fêr bibî?</h2></div>
      <div class="grid grid-2">`;
    for (const s of sections) {
      h += `<a class="feature-card" href="${s.href}">
        <div class="fc-emoji" aria-hidden="true">${s.emoji}</div>
        <div class="fc-body"><h3>${s.t}</h3><p>${escHtml(s.d)}</p>
        ${s.sub ? `<div class="fc-sub">${s.sub}</div>` : ''}</div>
        <span class="fc-arrow" aria-hidden="true">→</span>
      </a>`;
    }
    h += `</div></div></section>`;

    // Diyalog şeridi
    if (data.dialogues.length) {
      h += `<section class="section-tight section-alt"><div class="wrap">
        <div class="center" style="margin-bottom:30px"><span class="eyebrow">Diyalog</span><h2>Sahneyên axaftinê</h2>
        <p class="lead">Sahneyên rastîn ên malbatê û jiyana rojane.</p></div>
        <div class="lesson-list">`;
      for (const d of data.dialogues) {
        h += `<a class="lesson-row" href="/diyalog/${escHtml(d.id)}"><span class="num">💬</span><div class="body"><div class="t-ku">${escHtml(d.kurmanjTitle)}</div><div class="t-tr">${escHtml(d.turkishTitle)}</div></div><span class="meta">${d.lines.length} rêz</span></a>`;
      }
      h += `</div></div></section>`;
    }

    // Görünür FAQ (AEO: AI motorları bunu doğrudan alıntılar — şema sadece görünür Q&A'yı işaretler)
    const faqs = [
      { q: 'LÛTKE çi ye?', a: `LÛTKE platformeke belaş e ji bo fêrbûna zimanê Kurmancî (Kurdiya Bakur). Tê de ferhengek bi ${nf(m.wordTotal)} peyvan (A1–C2), ${m.lessonTotal} ders, rêbera rêzimanê û naveroka çandî (gotinên pêşiyan, helbest, stran) hene. Pêşxistî: Prof. Dr. Yılmaz Mutlu.` },
      { q: 'LÛTKE belaş e?', a: 'Erê, hemû naveroka LÛTKE bi temamî belaş e — bê reklam, bê şopandin.' },
      { q: 'Kurmancî çi ye?', a: 'Kurmancî (Kurdiya Bakur) zaravayê herî belav ê zimanê Kurdî ye. Bi alfabeya Latînî (alfabeya Hawar a Bedirxan, 31 tîp) tê nivîsîn û ji aliyê ~15 mîlyon kesan ve tê axaftin.' },
      { q: 'Ez çawa dest bi fêrbûna Kurmancî bikim?', a: 'Di LÛTKE de testek bilez asta te (A1–C2) dibîne; paşê her roj çend deqîqe bi kartên peyvan, quiz, guhdarî û axaftinê fêr dibî. Dest pê bike li lutke.app/app.' },
      { q: 'LÛTKE kîjan astan vedigire?', a: 'Hemû şeş astên CEFR: A1 (Destpêk), A2 (Bingehîn), B1–B2 (Navîn), C1 (Pêşketî) û C2 (Pispor).' },
    ];
    h += `<section class="section section-alt"><div class="wrap" style="max-width:760px">
      <div class="center" style="margin-bottom:30px"><span class="eyebrow">Pirsên Gelemperî</span><h2>Pirs û Bersiv</h2></div>
      ${faqs.map(f => `<div class="ex-card"><div class="ex-q">${escHtml(f.q)}</div><p style="margin:8px 0 0">${escHtml(f.a)}</p></div>`).join('')}
    </div></section>`;

    h += `<section class="section"><div class="wrap">${appCta('Bi tevahî, bi deng û bi pratîkê fêr bibe.', '/app/', 'Sepanê veke')}</div></section>`;

    await emit('naverok', h, {
      title: 'Naverok | Hemû peyv, wane, rêziman û çand — LÛTKE',
      desc: `LÛTKE naveroka tam: ${nf(m.wordTotal)} peyv (A1–C2), ${m.lessonTotal} wane, ${m.grammarTotal} mijarên rêzimanê û naveroka çandî (atasozî, helbest, stran). Di moda gerokê de bigere.`,
      og: 'og-default.png', _raw: true,
      jsonld: {
        '@type': 'FAQPage',
        '@id': `${SITE_URL}/naverok#faq`,
        mainEntity: faqs.map(f => ({
          '@type': 'Question', name: f.q,
          acceptedAnswer: { '@type': 'Answer', text: f.a },
        })),
      },
    }, '0.9');
  }

  // ════════════════════════════════════════════════════════
  // 2) PEYV /peyv/<lvl>
  // ════════════════════════════════════════════════════════
  for (const lvl of LEVELS) {
    const words = data.words[lvl] || [];
    if (!words.length) continue;
    const cats = [...new Set(words.map(w => w.kat))].sort();
    const catChips = ['<button class="chip active" data-wfilter="all">Hemû</button>']
      .concat(cats.map(c => `<button class="chip" data-wfilter="${escHtml(c)}">${escHtml(katLabel(c))}</button>`))
      .join(' ');

    let rows = '';
    for (const w of words) {
      const ex = (w.gen && w.gen[0]) || (w.her && w.her[0]) || '';
      const cins = w.cins && w.cins !== 'bêcins' ? w.cins : '';
      const hay = `${w.ku} ${w.tr} ${w.en || ''} ${katLabel(w.kat)}`.toLowerCase();
      rows += `<tr data-wcat="${escHtml(w.kat)}" data-hay="${escHtml(hay)}">
        <td><div class="w-ku">${escHtml(w.ku)}</div>${cins ? `<span class="w-cins">${escHtml(cins)}</span>` : ''}</td>
        <td><div class="w-tr">${escHtml(w.tr)}</div><div class="w-cat">${escHtml(katLabel(w.kat))}</div></td>
        <td class="w-ex">${escHtml(ex)}</td>
      </tr>`;
    }
    const levelNav = LEVELS.filter(l => (data.words[l] || []).length).map(l =>
      `<a class="seg${l === lvl ? ' active' : ''}" href="/peyv/${l}">${l.toUpperCase()}</a>`).join('');

    const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Peyv', href: '/peyv/a1' }, { label: lvl.toUpperCase() }])}
      <span class="eyebrow">Peyv · ${lvl.toUpperCase()} ${LEVEL_NAME[lvl]}</span>
      <h1>Ferhenga ${lvl.toUpperCase()}</h1>
      <p class="lead">${words.length} peyv — li gor kategoriyan parzûn bike an bigere.</p>
      <div class="segbar" role="tablist" aria-label="Ast">${levelNav}</div>
      <div class="toolbar">
        <label class="search-box">${SEARCH_ICO}<input type="search" id="wsearch" placeholder="Li peyvê bigere…" aria-label="Li peyvê bigere"></label>
        <span class="count-pill" id="wcount">${words.length} peyv</span>
      </div>
      <div class="chips" role="group" aria-label="Kategorî">${catChips}</div>
      <table class="word-table" id="wtable">
        <thead><tr><th>Kurmancî</th><th>Tirkî</th><th>Mînak</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>
      <p class="w-empty hide" id="wempty">Tu peyv nehat dîtin.</p>
      ${appCta('Van peyvan bi kartên jîr (FSRS) û deng fêr bibe.', '/app/vocabulary', 'Di sepanê de')}`;

    // DefinedTermSet — sözlük için en güçlü AEO schema'sı: her madde makine-okur
    // (peyv, wate) çifti. AI cevap motorları bunu doğrudan alıntılar.
    const terms = words.map(w => ({
      '@type': 'DefinedTerm',
      name: w.ku,
      inLanguage: 'ku',
      description: w.tr,
      termCode: lvl.toUpperCase(),
    }));
    await emit(`peyv/${lvl}`, body, {
      title: `Peyvên ${lvl.toUpperCase()} (${LEVEL_NAME[lvl]}) | Ferhenga Kurmancî — LÛTKE`,
      desc: `${words.length} peyvên Kurmancî yên asta ${lvl.toUpperCase()} — bi wateya tirkî, cins û mînakên hevokan. Ferhenga LÛTKE.`,
      og: 'og-default.png',
      jsonld: {
        '@type': 'DefinedTermSet',
        '@id': `${SITE_URL}/peyv/${lvl}#set`,
        name: `Ferhenga Kurmancî — ${lvl.toUpperCase()} (${LEVEL_NAME[lvl]})`,
        description: `${words.length} peyvên Kurmancî yên asta ${lvl.toUpperCase()}, bi wateya tirkî.`,
        inLanguage: 'ku',
        url: `${SITE_URL}/peyv/${lvl}`,
        publisher: { '@id': 'https://lutke.app/#org' },
        hasDefinedTerm: terms,
      },
    }, '0.7');
  }

  // ════════════════════════════════════════════════════════
  // 3) WANE liste /wane/<lvl>
  // ════════════════════════════════════════════════════════
  for (const lvl of LEVELS) {
    const lessons = data.lessons[lvl] || [];
    if (!lessons.length) continue;
    const byUnit = new Map();
    for (const l of lessons) {
      const u = l.unitNumber || 0;
      if (!byUnit.has(u)) byUnit.set(u, []);
      byUnit.get(u).push(l);
    }
    let listHtml = '';
    for (const [unit, ls] of [...byUnit.entries()].sort((a, b) => a[0] - b[0])) {
      listHtml += `<h2 class="unit-head">Birim ${unit}</h2><div class="lesson-list">`;
      for (const l of ls) {
        listHtml += `<a class="lesson-row" href="/wane/${escHtml(l.id)}">
          <span class="num">${l.emoji || l.lessonNumber}</span>
          <div class="body"><div class="t-ku">${escHtml(l.kurmanjTitle)}</div><div class="t-tr">${escHtml(l.turkishTitle)}</div></div>
          <span class="meta">${l.exercises.length} egzersîz<br>${l.estimatedMinutes} xulek</span>
        </a>`;
      }
      listHtml += `</div>`;
    }
    const levelNav = LEVELS.filter(l => (data.lessons[l] || []).length).map(l =>
      `<a class="seg${l === lvl ? ' active' : ''}" href="/wane/${l}">${l.toUpperCase()}</a>`).join('');

    const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Wane', href: '/wane/a1' }, { label: lvl.toUpperCase() }])}
      <span class="eyebrow">Wane · ${lvl.toUpperCase()} ${LEVEL_NAME[lvl]}</span>
      <h1>Waneyên ${lvl.toUpperCase()}</h1>
      <p class="lead">${lessons.length} wane — her yek bi egzersîz û çalakiyên xwe.</p>
      <div class="segbar" role="tablist" aria-label="Ast">${levelNav}</div>
      ${listHtml}
      ${appCta('Van waneyan bi tevahî û interaktîf di sepanê de bike.', '/app/', 'Sepanê veke')}`;

    await emit(`wane/${lvl}`, body, {
      title: `Waneyên ${lvl.toUpperCase()} (${LEVEL_NAME[lvl]}) | Mufredata Kurmancî — LÛTKE`,
      desc: `${lessons.length} waneyên Kurmancî yên asta ${lvl.toUpperCase()} — bi egzersîz, gramer û naveroka çandî. Mufredata LÛTKE.`,
      og: 'og-default.png',
    }, '0.7');
  }

  // ════════════════════════════════════════════════════════
  // 4) WANE detay /wane/<lessonId>
  // ════════════════════════════════════════════════════════
  for (const lvl of LEVELS) {
    for (const l of (data.lessons[lvl] || [])) {
      let ex = '';
      l.exercises.forEach((e, i) => {
        const opts = (e.options || []).map(o =>
          `<div class="ex-opt${o === e.correctAnswer ? ' correct' : ''}">${o === e.correctAnswer ? CHECK : DOT}<span>${escHtml(o)}</span></div>`
        ).join('');
        ex += `<div class="ex-card">
          <div class="ex-head"><span class="ex-type">${escHtml(EX_TYPE_LABEL[e.type] || e.type)}</span><span class="ex-num">Egzersîz ${i + 1}/${l.exercises.length}</span></div>
          <div class="ex-q">${escHtml(e.kurmanjPrompt || '')}</div>
          ${e.turkishPrompt ? `<div class="ex-q-tr">${escHtml(e.turkishPrompt)}</div>` : ''}
          ${opts ? `<div class="ex-opts">${opts}</div>` : ''}
          ${e.grammarNote ? `<div class="ex-note"><b>Nîşe:</b> ${escHtml(e.grammarNote)}</div>` : ''}
          ${e.culturalNote ? `<div class="ex-note"><b>Çand:</b> ${escHtml(e.culturalNote)}</div>` : ''}
        </div>`;
      });

      let wordsHtml = '';
      const tw = (l.targetCardIds || []).map(id => wordById.get(id)).filter(Boolean);
      if (tw.length) {
        wordsHtml = `<h2 class="unit-head">Peyvên vê waneyê (${tw.length})</h2><table class="word-table"><thead><tr><th>Kurmancî</th><th>Tirkî</th></tr></thead><tbody>`;
        for (const w of tw.slice(0, 80)) wordsHtml += `<tr><td class="w-ku">${escHtml(w.ku)}</td><td class="w-tr">${escHtml(w.tr)}</td></tr>`;
        wordsHtml += `</tbody></table>`;
      }
      const cul = (data.cultural || []).find(c => c.id === l.culturalRewardId);
      const culHtml = cul ? `<blockquote>${escHtml(cul.textKu)}<br><span style="font-weight:400;font-size:.92rem;color:var(--text-3)">${escHtml(cul.textTr)}${cul.source ? ' — ' + escHtml(cul.source) : ''}</span></blockquote>` : '';

      const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: `Wane ${lvl.toUpperCase()}`, href: `/wane/${lvl}` }, { label: l.kurmanjTitle }])}
        <span class="eyebrow">${lvl.toUpperCase()} · Birim ${l.unitNumber} · ${PATH_LABEL[l.path] || ''}</span>
        <h1>${escHtml(l.kurmanjTitle)}</h1>
        <p class="lead">${escHtml(l.turkishTitle)} · ${l.exercises.length} egzersîz · ${l.estimatedMinutes} xulek · ${l.totalXP} XP</p>
        ${culHtml}
        <h2 class="unit-head">Egzersîz û Çalakî</h2>
        ${ex || '<p class="muted">Egzersîzên vê waneyê di sepanê de têne hilberandin.</p>'}
        ${wordsHtml}
        ${appCta('Vê waneyê bi deng, pratîk û paşvexdistinê di sepanê de bike.', '/app/', 'Waneyê di sepanê de bike')}`;

      await emit(`wane/${l.id}`, body, {
        title: `${l.kurmanjTitle} (${lvl.toUpperCase()}) | Waneya Kurmancî — LÛTKE`,
        desc: `${l.turkishTitle} — waneya Kurmancî ya asta ${lvl.toUpperCase()}: ${l.exercises.length} egzersîz, gramer û naverok. LÛTKE.`,
        og: 'og-default.png', ogType: 'article',
        jsonld: { '@type': 'LearningResource', name: l.kurmanjTitle, inLanguage: 'ku', educationalLevel: lvl.toUpperCase(), learningResourceType: 'lesson', isAccessibleForFree: true, author: { '@id': 'https://lutke.app/#yilmaz-mutlu' }, publisher: { '@id': 'https://lutke.app/#org' }, dateModified: BUILD_DATE, isPartOf: { '@type': 'Course', name: `Kurmancî ${lvl.toUpperCase()}` } },
      }, '0.6');
    }
  }

  // ════════════════════════════════════════════════════════
  // 5) DIYALOG /diyalog/<id>
  // ════════════════════════════════════════════════════════
  for (const d of data.dialogues) {
    let lines = '';
    for (const ln of d.lines) {
      lines += `<div class="dlg-line">
        <div class="dlg-spk">${escHtml(ln.speakerRole || ln.speaker || '')}</div>
        <div class="dlg-ku">${escHtml(ln.kurmanci)}</div>
        <div class="dlg-tr">${escHtml(ln.turkish)}</div>
        ${ln.grammarNote ? `<div class="dlg-note"><b>Nîşe:</b> ${escHtml(ln.grammarNote)}</div>` : ''}
        ${ln.culturalNote ? `<div class="dlg-note"><b>Çand:</b> ${escHtml(ln.culturalNote)}</div>` : ''}
      </div>`;
    }
    const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: d.kurmanjTitle }])}
      <span class="eyebrow">Diyalog</span>
      <h1>${escHtml(d.kurmanjTitle)}</h1>
      <p class="lead">${escHtml(d.turkishTitle)}</p>
      ${d.scene ? `<div class="dlg-scene"><b>Sahne:</b> ${escHtml(d.scene)}</div>` : ''}
      ${d.culturalContext ? `<div class="dlg-scene">${escHtml(d.culturalContext)}</div>` : ''}
      <div class="dlg-lines">${lines}</div>
      ${appCta('Diyalogê bi deng guhdarî bike û pratîk bike.', '/app/', 'Sepanê veke')}`;
    await emit(`diyalog/${d.id}`, body, {
      title: `${d.kurmanjTitle} | Diyaloga Kurmancî — LÛTKE`,
      desc: `${d.turkishTitle} — diyaloga Kurmancî bi wergera tirkî û nîşeyên gramerê. LÛTKE.`,
      og: 'og-default.png', ogType: 'article',
    }, '0.5');
  }

  // ════════════════════════════════════════════════════════
  // 6) RÊZIMAN — gramer hub + konu detayları
  // ════════════════════════════════════════════════════════
  const grammar = (data.grammar || []).map((g, i) => ({ ...g, slug: slugify(g.titleKu) || `mijar-${i + 1}` }));
  if (grammar.length) {
    // Hub
    let gh = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Rêziman' }])}
      <span class="eyebrow">Rêziman</span>
      <h1>Rêbera rêzimanê</h1>
      <p class="lead">${grammar.length} mijarên bingehîn ên rêzimana Kurmancî — bi qaîde, mînak û şîretan. Standardê Bedirxan-Hawar.</p>
      <div class="lesson-list">`;
    for (const g of grammar) {
      gh += `<a class="lesson-row" href="/reziman/${g.slug}">
        <span class="num">${g.level}</span>
        <div class="body"><div class="t-ku">${escHtml(g.titleKu)}</div>${g.titleTr ? `<div class="t-tr">${escHtml(g.titleTr)}</div>` : ''}</div>
        <span class="meta">${g.rules.length} qaîde<br>${g.examples.length} mînak</span>
      </a>`;
    }
    gh += `</div>${appCta('Rêzimanê bi quiz û pratîkê fêr bibe.', '/app/grammar', 'Di sepanê de')}`;
    await emit('reziman', gh, {
      title: 'Rêziman | Rêbera rêzimana Kurmancî — LÛTKE',
      desc: `Rêbera rêzimana Kurmancî: ${grammar.length} mijar (alfabe, zayend, veqetandek, cinavk, lêker, daçek…) bi qaîde û mînakan. Standardê Bedirxan-Hawar.`,
      og: 'og-default.png', _nav: 'naverok',
    }, '0.7');

    // Konu detayları
    for (const g of grammar) {
      const rules = g.rules.length
        ? `<h2 class="unit-head">Qaîde</h2><ul class="bullets">${g.rules.map(r => `<li>${escHtml(r)}</li>`).join('')}</ul>` : '';
      const examples = g.examples.length
        ? `<h2 class="unit-head">Mînak</h2><div class="ex-list">${g.examples.map(e =>
            `<div class="gex"><div class="gex-ku">${escHtml(e.ku)}</div>${e.tr ? `<div class="gex-tr">${escHtml(e.tr)}</div>` : ''}${e.note ? `<div class="gex-note">${escHtml(e.note)}</div>` : ''}</div>`).join('')}</div>` : '';
      const tip = g.tip ? `<div class="tip-box"><span class="tip-ico" aria-hidden="true">💡</span><div><b>Şîret:</b> ${escHtml(g.tip)}</div></div>` : '';
      const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Rêziman', href: '/reziman' }, { label: g.titleKu }])}
        <span class="eyebrow">Rêziman · ${g.level}</span>
        <h1>${escHtml(g.titleKu)}</h1>
        ${g.titleTr ? `<p class="lead">${escHtml(g.titleTr)}</p>` : ''}
        ${rules}${examples}${tip}
        ${appCta('Vê mijarê bi quiz û egzersîzan di sepanê de bike.', '/app/grammar', 'Di sepanê de')}`;
      await emit(`reziman/${g.slug}`, body, {
        title: `${g.titleKu} | Rêzimana Kurmancî (${g.level}) — LÛTKE`,
        desc: `${g.titleTr || g.titleKu} — mijara rêzimana Kurmancî: ${g.rules.length} qaîde, ${g.examples.length} mînak. Asta ${g.level}. LÛTKE.`,
        og: 'og-default.png', ogType: 'article', _nav: 'naverok',
        jsonld: { '@type': 'LearningResource', name: g.titleKu, inLanguage: 'ku', educationalLevel: g.level, learningResourceType: 'grammar guide', isAccessibleForFree: true, author: { '@id': 'https://lutke.app/#yilmaz-mutlu' }, publisher: { '@id': 'https://lutke.app/#org' }, dateModified: BUILD_DATE },
      }, '0.6');
    }
  }

  // ════════════════════════════════════════════════════════
  // 7) ÇAND — kültür hub + atasözleri + koleksiyonlar + öğeler
  // ════════════════════════════════════════════════════════
  const cand = data.cand || {};
  const proverbs = data.proverbs || [];
  const motivation = data.motivation || [];
  {
    // ── Çand hub ──
    let ch = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand' }])}
      <span class="eyebrow">Çand û Mîratî</span>
      <h1>Çanda Kurdî</h1>
      <p class="lead">Atasozî, helbest, stran, destan, xwarin û kesayetên dîrokî — ziman di nava şopa çandê de.</p>
      <div class="hub-grid">`;
    // atasözleri kartı önce (en büyük koleksiyon)
    if (proverbs.length) {
      ch += `<a class="hub-card feat" href="/cand/gotinen-pesiyan"><span class="hc-emoji">🗣️</span><div class="nm">Gotinên Pêşiyan</div><div class="ct">${nf(proverbs.length)} atasozî</div></a>`;
    }
    for (const key of CAND_ORDER) {
      const list = cand[key];
      if (!list || !list.length) continue;
      const g = CAND_GROUPS[key] || { ku: key, emoji: '•' };
      ch += `<a class="hub-card" href="/cand/${key}"><span class="hc-emoji">${g.emoji}</span><div class="nm">${escHtml(g.ku)}</div><div class="ct">${list.length} tişt</div></a>`;
    }
    if (motivation.length) {
      ch += `<a class="hub-card" href="/cand/gotinen-mezinan"><span class="hc-emoji">⭐</span><div class="nm">Gotinên Mezinan</div><div class="ct">${motivation.length} gotin</div></a>`;
    }
    ch += `</div>${appCta('Naveroka çandî bi deng û bi kûrahî di sepanê de.', '/app/culture', 'Di sepanê de')}`;
    await emit('cand', ch, {
      title: 'Çand | Çanda Kurdî — atasozî, helbest, stran — LÛTKE',
      desc: `Çanda Kurdî li LÛTKE: ${nf(proverbs.length)} atasozî, helbest, stran, destan, xwarin û kesayetên dîrokî. Bi Kurmancî û wergera tirkî.`,
      og: 'og-default.png', _nav: 'naverok',
    }, '0.8');

    // ── Atasözleri: hub (harf kartları + arama) + harf başına sayfa ──
    // Her harf sayfası o harfin TÜM atasözlerini görünür kart + per-atasözü
    // CreativeWork JSON-LD (#anchor) ile sunar → her atasözü AI'ca tek tek
    // alıntılanabilir, ama sayfa dolu olduğu için thin-content yok.
    if (proverbs.length) {
      const letters = [...new Set(proverbs.map(p => p.letter))];
      const byLetter = new Map();
      for (const p of proverbs) {
        if (!byLetter.has(p.letter)) byLetter.set(p.letter, []);
        byLetter.get(p.letter).push(p);
      }
      const letterSlug = L => slugify(L) || L.toLowerCase().charCodeAt(0).toString(36);

      // Hub: harf kartları + (client-side) arama tüm atasözlerinde
      let rows = '';
      for (const p of proverbs) {
        const hay = `${p.ku} ${p.tr || ''}`.toLowerCase();
        rows += `<tr data-pletter="${escHtml(p.letter)}" data-hay="${escHtml(hay)}" class="hide">
          <td class="pv-ku">${escHtml(p.ku)}</td>
          <td class="pv-tr">${p.tr ? escHtml(p.tr) : '<span class="muted">—</span>'}</td>
        </tr>`;
      }
      const letterCards = letters.map(L =>
        `<a class="hub-card" href="/cand/gotinen-pesiyan/${letterSlug(L)}"><span class="lv">${escHtml(L)}</span><div class="ct">${byLetter.get(L).length} gotin</div></a>`).join('');
      const hubBody = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand', href: '/cand' }, { label: 'Gotinên Pêşiyan' }])}
        <span class="eyebrow">Çand · Gotinên Pêşiyan</span>
        <h1>Gotinên Pêşiyan</h1>
        <p class="lead">${nf(proverbs.length)} atasozîyên Kurmancî — berhevoka Prof. Dr. Yılmaz Mutlu. Li gor tîpê hilbijêre an li jêr bigere.</p>
        <div class="toolbar">
          <label class="search-box">${SEARCH_ICO}<input type="search" id="psearch" placeholder="Li gotinê bigere…" aria-label="Li gotinê bigere"></label>
          <span class="count-pill" id="pcount">${nf(proverbs.length)} gotin</span>
        </div>
        <div class="hub-grid" id="pletters">${letterCards}</div>
        <table class="word-table hide" id="ptable"><thead><tr><th>Kurmancî</th><th>Tirkî</th></tr></thead><tbody>${rows}</tbody></table>
        <p class="w-empty hide" id="pempty">Tu gotin nehat dîtin.</p>
        ${appCta('Gotinên pêşiyan bi deng û çîrokan di sepanê de.', '/app/culture', 'Di sepanê de')}`;
      await emit('cand/gotinen-pesiyan', hubBody, {
        title: `Gotinên Pêşiyan | ${nf(proverbs.length)} atasozîyên Kurmancî — LÛTKE`,
        desc: `${nf(proverbs.length)} atasozîyên (gotinên pêşiyan) Kurmancî bi wergera tirkî, li gor tîpan. Berhevoka Prof. Dr. Yılmaz Mutlu.`,
        og: 'og-default.png', _nav: 'naverok',
        jsonld: { '@type': 'CollectionPage', name: 'Gotinên Pêşiyan', inLanguage: 'ku', isPartOf: { '@id': 'https://lutke.app/#website' } },
      }, '0.7');

      // Harf sayfaları
      for (const L of letters) {
        const list = byLetter.get(L);
        let cards = '', items = [];
        list.forEach((p, i) => {
          const aid = `g-${letterSlug(L)}-${p.num}`;
          cards += `<div class="pv-card" id="${aid}">
            <div class="pv-ku">${escHtml(p.ku)}</div>
            ${p.tr ? `<div class="pv-tr">${escHtml(p.tr)}</div>` : ''}
          </div>`;
          items.push({
            '@type': 'CreativeWork',
            '@id': `${SITE_URL}/cand/gotinen-pesiyan/${letterSlug(L)}#${aid}`,
            additionalType: 'https://schema.org/Quotation',
            text: p.ku, inLanguage: 'ku',
            ...(p.tr ? { abstract: p.tr } : {}),
            genre: 'gotina pêşiyan',
            isPartOf: { '@id': 'https://lutke.app/#org' },
          });
        });
        const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand', href: '/cand' }, { label: 'Gotinên Pêşiyan', href: '/cand/gotinen-pesiyan' }, { label: `Tîpa ${L}` }])}
          <span class="eyebrow">Gotinên Pêşiyan · Tîpa ${escHtml(L)}</span>
          <h1>Gotinên Pêşiyan bi tîpa “${escHtml(L)}”</h1>
          <p class="lead">${list.length} atasozîyên Kurmancî yên ku bi tîpa ${escHtml(L)} dest pê dikin, bi wergera tirkî.</p>
          <div class="pv-list">${cards}</div>
          ${appCta('Hemû gotinên pêşiyan û bêtir naverok di sepanê de.', '/app/culture', 'Di sepanê de')}`;
        await emit(`cand/gotinen-pesiyan/${letterSlug(L)}`, body, {
          title: `Gotinên Pêşiyan — Tîpa ${L} (${list.length}) | Atasozîyên Kurmancî — LÛTKE`,
          desc: `${list.length} atasozîyên (gotinên pêşiyan) Kurmancî yên bi tîpa ${L}, bi wergera tirkî. Berhevoka Prof. Dr. Yılmaz Mutlu.`,
          og: 'og-default.png', _nav: 'naverok',
          jsonld: { '@type': 'CollectionPage', name: `Gotinên Pêşiyan — Tîpa ${L}`, inLanguage: 'ku', hasPart: items },
        }, '0.6');
      }
    }

    // ── Gotinên Mezinan (motivasyon) ──
    if (motivation.length) {
      let cards = '';
      for (const q of motivation) {
        cards += `<blockquote class="quote-card">${escHtml(q.ku)}<br><span class="q-tr">${escHtml(q.tr)}</span>${q.source ? `<cite>— ${escHtml(q.source)}</cite>` : ''}</blockquote>`;
      }
      const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand', href: '/cand' }, { label: 'Gotinên Mezinan' }])}
        <span class="eyebrow">Çand · Gotinên Mezinan</span>
        <h1>Gotinên Mezinan</h1>
        <p class="lead">Gotinên zana û helbestvanên Kurd li ser ziman, nasname û jiyanê.</p>
        <div class="quote-grid">${cards}</div>
        ${appCta('Bêtir gotin û naveroka çandî di sepanê de.', '/app/culture', 'Di sepanê de')}`;
      await emit('cand/gotinen-mezinan', body, {
        title: 'Gotinên Mezinan | Gotinên li ser ziman û nasnameyê — LÛTKE',
        desc: 'Gotinên zana û helbestvanên Kurd (Cegerxwîn, Bedirxan, Xanî…) li ser ziman, nasname û jiyanê. Bi Kurmancî û tirkî.',
        og: 'og-default.png', _nav: 'naverok',
      }, '0.6');
    }

    // ── Koleksiyon listeleri + öğe detayları ──
    for (const key of CAND_ORDER) {
      const list = cand[key];
      if (!list || !list.length) continue;
      const g = CAND_GROUPS[key] || { ku: key, emoji: '•', desc: '' };
      // liste
      let lh = '';
      for (const it of list) {
        const sl = slugify(it.kurmanjTitle) || it.id;
        lh += `<a class="lesson-row" href="/cand/${key}/${it.id}">
          <span class="num">${g.emoji}</span>
          <div class="body"><div class="t-ku">${escHtml(it.kurmanjTitle)}</div><div class="t-tr">${escHtml(it.turkishTitle)}</div></div>
          <span class="meta">${escHtml(it.typeLabel || '')}</span>
        </a>`;
      }
      const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand', href: '/cand' }, { label: g.ku }])}
        <span class="eyebrow">Çand · ${escHtml(g.ku)}</span>
        <h1>${escHtml(g.ku)}</h1>
        <p class="lead">${escHtml(g.desc)} (${list.length})</p>
        <div class="lesson-list">${lh}</div>
        ${appCta('Naveroka çandî bi deng di sepanê de.', '/app/culture', 'Di sepanê de')}`;
      await emit(`cand/${key}`, body, {
        title: `${g.ku} | Çanda Kurdî — LÛTKE`,
        desc: `${g.desc} ${list.length} tişt, bi Kurmancî û wergera tirkî. Çanda Kurdî li LÛTKE.`,
        og: 'og-default.png', _nav: 'naverok',
      }, '0.6');

      // öğe detayları
      for (const it of list) {
        const note = it.backgroundNote
          ? `<div class="bg-note"><h2 class="unit-head">Arka plan</h2>${para(it.backgroundNote)}</div>` : '';
        const kw = (it.keywords || []).length
          ? `<div class="kw-row">${it.keywords.map(k => `<span class="kw">${escHtml(k)}</span>`).join('')}</div>` : '';
        const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand', href: '/cand' }, { label: g.ku, href: `/cand/${key}` }, { label: it.kurmanjTitle }])}
          <span class="eyebrow">${escHtml(it.typeLabel || g.ku)}${it.typeTurkish ? ' · ' + escHtml(it.typeTurkish) : ''}</span>
          <h1>${escHtml(it.kurmanjTitle)}</h1>
          <p class="lead">${escHtml(it.turkishTitle)}</p>
          <div class="cand-content">
            <div class="cc-ku">${para(it.kurmanjContent)}</div>
            ${it.turkishContent ? `<div class="cc-tr"><div class="cc-label">Tirkî</div>${para(it.turkishContent)}</div>` : ''}
          </div>
          ${note}${kw}
          ${appCta('Naveroka çandî bi deng û pratîkê di sepanê de.', '/app/culture', 'Di sepanê de')}`;
        await emit(`cand/${key}/${it.id}`, body, {
          title: `${it.kurmanjTitle} | ${g.ku} — LÛTKE`,
          desc: `${it.turkishTitle} — ${it.typeTurkish || 'naveroka çandî'} bi Kurmancî û tirkî. Çanda Kurdî li LÛTKE.`,
          og: 'og-default.png', ogType: 'article', _nav: 'naverok',
          jsonld: { '@type': 'Article', headline: it.kurmanjTitle, inLanguage: 'ku', author: { '@id': 'https://lutke.app/#yilmaz-mutlu' }, publisher: { '@id': 'https://lutke.app/#org' }, dateModified: BUILD_DATE },
        }, '0.5');
      }
    }
  }

  // ════════════════════════════════════════════════════════
  // 8) "Kürtçe X nasıl denir" — programatik (sözlükten, somut kategoriler)
  //    /nasil-denir          hub (kategori + arama)
  //    /nasil-denir/<slug>   tek ifade: cevap-önce + telaffuz + örnek + schema
  //    AEO: "Kürtçe X nasıl denir" / "how to say X in Kurdish" aramaları + AI alıntı.
  // ════════════════════════════════════════════════════════
  {
    // Sadece SOMUT, günlük "nasıl denir" aramasına uygun kategoriler (thin-content
    // ve anlamsız soyut terimlerden kaçınmak için akademik/soyut kategoriler hariç).
    const CONCRETE_KATS = new Set([
      'silav', 'his', 'malbat', 'xwarin', 'vexwarin', 'mewe', 'jimar', 'reng', 'rengder', 'rengdêr',
      'beden', 'ajal', 'mal', 'cih', 'dem', 'demsal', 'roj', 'hewa', 'cil', 'pîşe', 'kar',
      'temel', 'pirs', 'dua', 'rêwîtî', 'tendurist', 'gihanî', 'spor', 'werzî', 'huner', 'deyim',
    ]);
    const KAT_TR = {
      silav: 'Selamlaşma', his: 'Duygular', malbat: 'Aile', xwarin: 'Yiyecek', vexwarin: 'İçecek',
      mewe: 'Meyve', jimar: 'Sayılar', reng: 'Renkler', rengder: 'Sıfatlar', 'rengdêr': 'Sıfatlar',
      beden: 'Vücut', ajal: 'Hayvanlar', mal: 'Ev', cih: 'Yer', dem: 'Zaman', demsal: 'Mevsimler',
      roj: 'Günler', hewa: 'Hava', cil: 'Giyim', 'pîşe': 'Meslekler', kar: 'İş',
      temel: 'Temel kelimeler', pirs: 'Soru kelimeleri', dua: 'Dilek & dua', 'rêwîtî': 'Seyahat',
      tendurist: 'Sağlık', gihanî: 'Ulaşım', spor: 'Spor', 'werzî': 'Spor', huner: 'Sanat', deyim: 'Deyimler',
    };
    // tüm kelimeler, somut kategori + makul uzunlukta TR karşılık (tek kavram)
    const allWords = [];
    for (const lvl of LEVELS) for (const w of (data.words[lvl] || [])) allWords.push(w);
    const seenSlug = new Map(); // slug → ilk kelime (çakışma engelle)
    const phrases = [];
    for (const w of allWords) {
      if (!CONCRETE_KATS.has(w.kat)) continue;
      // TR karşılığı: parantez/açıklama at, ilk varyantı al ("a / b" → "a")
      const trClean = (w.tr || '').replace(/\(.*?\)/g, '').split(/[\/;,]/)[0].trim();
      if (!trClean || trClean.length < 2 || trClean.length > 28) continue;
      if (/[0-9]/.test(trClean) && w.kat !== 'jimar') continue;
      const slug = slugify(trClean);
      if (!slug || slug.length < 2) continue;
      if (seenSlug.has(slug)) continue; // ilk geleni tut
      seenSlug.set(slug, w);
      phrases.push({ ...w, trClean, slug });
    }
    phrases.sort((a, b) => a.trClean.localeCompare(b.trClean, 'tr'));

    if (phrases.length) {
      // Hub
      let rows = '';
      for (const p of phrases) {
        const hay = `${p.trClean} ${p.ku}`.toLowerCase();
        rows += `<tr data-hay="${escHtml(hay)}"><td><a href="/nasil-denir/${p.slug}">${escHtml(p.trClean)}</a></td><td class="w-ku">${escHtml(p.ku)}</td></tr>`;
      }
      const hubBody = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Kürtçe nasıl denir?' }])}
        <span class="eyebrow">Ferheng · Kürtçe nasıl denir?</span>
        <h1>Kürtçe nasıl denir?</h1>
        <p class="lead">${phrases.length} kelime ve ifadenin Kürtçesi (Kurmancî) — doğru yazım, telaffuz ve örnek cümlelerle. Prof. Dr. Yılmaz Mutlu derlemesi.</p>
        <div class="toolbar">
          <label class="search-box">${SEARCH_ICO}<input type="search" id="ndsearch" placeholder="Kelime ara… (örn. günaydın)" aria-label="Kelime ara"></label>
          <span class="count-pill" id="ndcount">${phrases.length} ifade</span>
        </div>
        <table class="word-table" id="ndtable"><thead><tr><th>Türkçe</th><th>Kürtçe (Kurmancî)</th></tr></thead><tbody>${rows}</tbody></table>
        <p class="w-empty hide" id="ndempty">Sonuç bulunamadı.</p>
        ${appCta('Tüm kelimeleri sesli ve pratikle öğren.', '/app/vocabulary', 'Sepanê veke')}`;
      await emit('nasil-denir', hubBody, {
        title: `Kürtçe nasıl denir? | ${phrases.length} kelimenin Kürtçesi — LÛTKE`,
        desc: `Kürtçe (Kurmancî) kelime ve ifadeler: günaydın, teşekkür ederim, seni seviyorum ve ${phrases.length}+ kelimenin doğru Kürtçesi, telaffuz ve örneklerle.`,
        og: 'og-default.png', _nav: 'naverok', lang: 'tr',
        jsonld: { '@type': 'CollectionPage', name: 'Kürtçe nasıl denir?', inLanguage: 'tr', about: 'Kurmancî (Northern Kurdish) vocabulary' },
      }, '0.7');

      // Tek ifade sayfaları
      for (const p of phrases) {
        const trCap = p.trClean.charAt(0).toUpperCase() + p.trClean.slice(1);
        const q = `Kürtçe "${p.trClean}" nasıl denir?`;
        const answer = `Kürtçe (Kurmancî) "${p.trClean}" = "${p.ku}".`;
        const examples = [...(p.her || []), ...(p.gen || [])].filter(Boolean).slice(0, 4);
        const exHtml = examples.length
          ? `<h2 class="unit-head">Örnek cümleler</h2><div class="ex-list">${examples.map(e => `<div class="gex"><div class="gex-ku">${escHtml(e)}</div></div>`).join('')}</div>` : '';
        const note = p.not ? `<div class="tip-box"><span class="tip-ico" aria-hidden="true">💡</span><div>${escHtml(p.not)}</div></div>` : '';
        const katLbl = KAT_TR[p.kat] || katLabel(p.kat);
        // ilgili: aynı kategoriden 6 kelime
        const related = phrases.filter(x => x.kat === p.kat && x.slug !== p.slug).slice(0, 6);
        const relHtml = related.length
          ? `<h2 class="unit-head">İlgili kelimeler</h2><div class="kw-row">${related.map(r => `<a class="kw" href="/nasil-denir/${r.slug}">${escHtml(r.trClean)} · ${escHtml(r.ku)}</a>`).join('')}</div>` : '';
        const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Kürtçe nasıl denir?', href: '/nasil-denir' }, { label: trCap }])}
          <span class="eyebrow">Ferheng · ${escHtml(katLbl)}</span>
          <h1>${escHtml(q)}</h1>
          <div class="answer-box">
            <p class="answer-lead">Kürtçe <strong>${escHtml(p.trClean)}</strong> = <strong class="answer-ku">${escHtml(p.ku)}</strong>${p.cins && p.cins !== 'bêcins' ? ` <span class="muted">(${escHtml(p.cins)})</span>` : ''}</p>
          </div>
          ${exHtml}${note}${relHtml}
          ${appCta(`"${p.ku}" kelimesini sesli dinle ve pratik yap.`, '/app/vocabulary', 'Sepanê veke')}`;
        await emit(`nasil-denir/${p.slug}`, body, {
          title: `Kürtçe "${p.trClean}" nasıl denir? — "${p.ku}" | LÛTKE`,
          desc: `Kürtçe (Kurmancî) "${p.trClean}" = "${p.ku}". Doğru yazım, telaffuz ve örnek cümlelerle. ${katLbl} — LÛTKE Kürtçe sözlük.`,
          og: 'og-default.png', ogType: 'article', _nav: 'naverok', lang: 'tr',
          jsonld: [
            {
              '@type': 'QAPage', inLanguage: 'tr',
              mainEntity: {
                '@type': 'Question', name: q,
                acceptedAnswer: { '@type': 'Answer', text: `${answer}${examples.length ? ' Örnek: ' + examples[0] : ''}` },
              },
            },
            {
              '@type': 'DefinedTerm', name: p.ku, inLanguage: 'ku', description: p.tr,
              inDefinedTermSet: { '@id': 'https://lutke.app/peyv/a1#set' },
            },
          ],
        }, '0.6');
      }
      ctx.log(`nasil-denir: ${phrases.length + 1} sayfa (hub + ifadeler)`);
    }
  }

  ctx.log(`content: ${pageCount} sayfa (naverok + peyv + wane + diyalog + reziman + cand + nasil-denir)`);
  return { pages: pageCount, urls };
}
