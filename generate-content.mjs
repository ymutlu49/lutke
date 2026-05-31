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
  return String(s).toLowerCase()
    .replace(/ê/g, 'e').replace(/î/g, 'i').replace(/û/g, 'u').replace(/ç/g, 'c').replace(/ş/g, 's')
    .replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '').slice(0, 60);
}

export async function generateContentPages(ctx) {
  const { ROOT, DIST, renderPage, SITE_URL, escHtml } = ctx;
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
      <p class="lead">Tevahiya naveroka sepanê — niha li ser gerokê jî. Peyv, ders, diyalog, rêziman û çand; bê daxistin, bê têketin.</p>
    </div></section>

    <section class="section-tight"><div class="wrap">
      <div class="stats">
        ${stat(nf(m.wordTotal), 'Peyv')}
        ${stat(m.lessonTotal, 'Ders')}
        ${stat(m.exerciseTotal, 'Egzersîz')}
        ${stat(nf(candCount), 'Naveroka çandî')}
      </div>
    </div></section>`;

    // Ana bölüm kartları (büyük, ikon + açıklama + alt-link)
    const sections = [
      { href: '/peyv/a1', emoji: '📖', t: 'Peyv', d: `${nf(m.wordTotal)} peyv, A1–C2 — bi mînak û cins.`,
        sub: LEVELS.filter(l => (data.words[l] || []).length).map(l => `<a href="/peyv/${l}">${l.toUpperCase()}</a>`).join('') },
      { href: '/wane/a1', emoji: '🎓', t: 'Ders û etkinlik', d: `${m.lessonTotal} ders, ${m.exerciseTotal} egzersîz.`,
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

    h += `<section class="section"><div class="wrap">${appCta('Bi tevahî, bi deng û bi pratîkê fêr bibe.', '/app/', 'Sepanê veke')}</div></section>`;

    await emit('naverok', h, {
      title: 'Naverok | Hemû peyv, ders, rêziman û çand — LÛTKE',
      desc: `LÛTKE naveroka tam: ${nf(m.wordTotal)} peyv (A1–C2), ${m.lessonTotal} ders, ${m.grammarTotal} mijarên rêzimanê û naveroka çandî (atasozî, helbest, stran). Di moda gerokê de bigere.`,
      og: 'og-default.png', _raw: true,
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

    await emit(`peyv/${lvl}`, body, {
      title: `Peyvên ${lvl.toUpperCase()} (${LEVEL_NAME[lvl]}) | Ferhenga Kurmancî — LÛTKE`,
      desc: `${words.length} peyvên Kurmancî yên asta ${lvl.toUpperCase()} — bi wateya tirkî, cins û mînakên hevokan. Ferhenga LÛTKE.`,
      og: 'og-default.png',
      jsonld: { '@context': 'https://schema.org', '@type': 'CollectionPage', name: `Peyvên ${lvl.toUpperCase()}`, inLanguage: 'ku', isPartOf: { '@type': 'WebSite', name: 'LÛTKE', url: SITE_URL + '/' } },
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

    const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Ders', href: '/wane/a1' }, { label: lvl.toUpperCase() }])}
      <span class="eyebrow">Ders · ${lvl.toUpperCase()} ${LEVEL_NAME[lvl]}</span>
      <h1>Dersên ${lvl.toUpperCase()}</h1>
      <p class="lead">${lessons.length} ders — her yek bi egzersîz û etkinlikên xwe.</p>
      <div class="segbar" role="tablist" aria-label="Ast">${levelNav}</div>
      ${listHtml}
      ${appCta('Van dersan bi tevahî û interaktîf di sepanê de bike.', '/app/', 'Sepanê veke')}`;

    await emit(`wane/${lvl}`, body, {
      title: `Dersên ${lvl.toUpperCase()} (${LEVEL_NAME[lvl]}) | Mufredata Kurmancî — LÛTKE`,
      desc: `${lessons.length} dersên Kurmancî yên asta ${lvl.toUpperCase()} — bi egzersîz, gramer û naveroka çandî. Mufredata LÛTKE.`,
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
        wordsHtml = `<h2 class="unit-head">Peyvên vê dersê (${tw.length})</h2><table class="word-table"><thead><tr><th>Kurmancî</th><th>Tirkî</th></tr></thead><tbody>`;
        for (const w of tw.slice(0, 80)) wordsHtml += `<tr><td class="w-ku">${escHtml(w.ku)}</td><td class="w-tr">${escHtml(w.tr)}</td></tr>`;
        wordsHtml += `</tbody></table>`;
      }
      const cul = (data.cultural || []).find(c => c.id === l.culturalRewardId);
      const culHtml = cul ? `<blockquote>${escHtml(cul.textKu)}<br><span style="font-weight:400;font-size:.92rem;color:var(--text-3)">${escHtml(cul.textTr)}${cul.source ? ' — ' + escHtml(cul.source) : ''}</span></blockquote>` : '';

      const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: `Ders ${lvl.toUpperCase()}`, href: `/wane/${lvl}` }, { label: l.kurmanjTitle }])}
        <span class="eyebrow">${lvl.toUpperCase()} · Birim ${l.unitNumber} · ${PATH_LABEL[l.path] || ''}</span>
        <h1>${escHtml(l.kurmanjTitle)}</h1>
        <p class="lead">${escHtml(l.turkishTitle)} · ${l.exercises.length} egzersîz · ${l.estimatedMinutes} xulek · ${l.totalXP} XP</p>
        ${culHtml}
        <h2 class="unit-head">Egzersîz û etkinlik</h2>
        ${ex || '<p class="muted">Egzersîzên vê dersê di sepanê de têne hilberandin.</p>'}
        ${wordsHtml}
        ${appCta('Vê dersê bi deng, pratîk û paşvexdistinê di sepanê de bike.', '/app/', 'Dersê di sepanê de bike')}`;

      await emit(`wane/${l.id}`, body, {
        title: `${l.kurmanjTitle} (${lvl.toUpperCase()}) | Dersa Kurmancî — LÛTKE`,
        desc: `${l.turkishTitle} — dersa Kurmancî ya asta ${lvl.toUpperCase()}: ${l.exercises.length} egzersîz, gramer û naverok. LÛTKE.`,
        og: 'og-default.png', ogType: 'article',
        jsonld: { '@context': 'https://schema.org', '@type': 'LearningResource', name: l.kurmanjTitle, inLanguage: 'ku', educationalLevel: lvl.toUpperCase(), learningResourceType: 'lesson', isPartOf: { '@type': 'Course', name: `Kurmancî ${lvl.toUpperCase()}` } },
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
        jsonld: { '@context': 'https://schema.org', '@type': 'LearningResource', name: g.titleKu, inLanguage: 'ku', educationalLevel: g.level, learningResourceType: 'grammar guide' },
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

    // ── Atasözleri (arama + harf filtre) ──
    if (proverbs.length) {
      const letters = [...new Set(proverbs.map(p => p.letter))];
      const chips = ['<button class="chip active" data-pfilter="all">Hemû</button>']
        .concat(letters.map(L => `<button class="chip" data-pfilter="${escHtml(L)}">${escHtml(L)}</button>`)).join(' ');
      let rows = '';
      for (const p of proverbs) {
        const hay = `${p.ku} ${p.tr || ''}`.toLowerCase();
        rows += `<tr data-pletter="${escHtml(p.letter)}" data-hay="${escHtml(hay)}">
          <td class="pv-ku">${escHtml(p.ku)}</td>
          <td class="pv-tr">${p.tr ? escHtml(p.tr) : '<span class="muted">—</span>'}</td>
        </tr>`;
      }
      const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: 'Çand', href: '/cand' }, { label: 'Gotinên Pêşiyan' }])}
        <span class="eyebrow">Çand · Gotinên Pêşiyan</span>
        <h1>Gotinên Pêşiyan</h1>
        <p class="lead">${nf(proverbs.length)} atasozîyên Kurmancî — berhevoka Prof. Dr. Yılmaz Mutlu. Bigere an li gor tîpê parzûn bike.</p>
        <div class="toolbar">
          <label class="search-box">${SEARCH_ICO}<input type="search" id="psearch" placeholder="Li gotinê bigere…" aria-label="Li gotinê bigere"></label>
          <span class="count-pill" id="pcount">${nf(proverbs.length)} gotin</span>
        </div>
        <div class="chips" role="group" aria-label="Tîp">${chips}</div>
        <table class="word-table" id="ptable"><thead><tr><th>Kurmancî</th><th>Tirkî</th></tr></thead><tbody>${rows}</tbody></table>
        <p class="w-empty hide" id="pempty">Tu gotin nehat dîtin.</p>
        ${appCta('Gotinên pêşiyan bi deng û çîrokan di sepanê de.', '/app/culture', 'Di sepanê de')}`;
      await emit('cand/gotinen-pesiyan', body, {
        title: `Gotinên Pêşiyan | ${nf(proverbs.length)} atasozîyên Kurmancî — LÛTKE`,
        desc: `${nf(proverbs.length)} atasozîyên (gotinên pêşiyan) Kurmancî bi wergera tirkî. Berhevoka Prof. Dr. Yılmaz Mutlu.`,
        og: 'og-default.png', _nav: 'naverok',
        jsonld: { '@context': 'https://schema.org', '@type': 'CollectionPage', name: 'Gotinên Pêşiyan', inLanguage: 'ku' },
      }, '0.7');
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
          jsonld: { '@context': 'https://schema.org', '@type': 'Article', headline: it.kurmanjTitle, inLanguage: 'ku' },
        }, '0.5');
      }
    }
  }

  ctx.log(`content: ${pageCount} sayfa (naverok + peyv + wane + diyalog + reziman + cand)`);
  return { pages: pageCount, urls };
}
