// LÛTKE — Veri-güdümlü içerik sayfaları üreticisi
// content.json (tool/export_content.dart çıktısı) → statik Kurmancî sayfalar:
//   /naverok           içerik hub'ı (seviye kartları)
//   /peyv/<lvl>        kelime listesi (arama + kategori filtre, client-side)
//   /wane/<lvl>        ders listesi (birime göre gruplu)
//   /wane/<lessonId>   ders detayı — egzersizler/etkinlikler okunur halde
//   /diyalog/<id>      heritage diyalog sahnesi
//
// build-site.mjs bunu çağırır ve ortak render bağlamını geçer
// (renderPage/escHtml/SITE_URL/log + ROOT/DIST).

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

const CHECK = '<svg class="mk" viewBox="0 0 24 24" fill="none" stroke="#2D9E4F" stroke-width="3"><path d="M20 6L9 17l-5-5"/></svg>';
const DOT = '<svg class="mk" viewBox="0 0 24 24" fill="none" stroke="#CFE0DA" stroke-width="2"><circle cx="12" cy="12" r="8"/></svg>';
const SEARCH_ICO = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>';

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

  const wordById = new Map();
  for (const lvl of LEVELS) for (const w of (data.words[lvl] || [])) wordById.set(w.id, w);

  async function writeFile(p, c) { await fs.mkdir(path.dirname(p), { recursive: true }); await fs.writeFile(p, c); }
  async function emit(slugPath, html, meta, prio) {
    const full = renderPage({ slug: slugPath, body: html, meta, activeNav: 'naverok' });
    await writeFile(path.join(DIST, slugPath + '.html'), full);
    urls.push({ loc: `${SITE_URL}/${slugPath}`, prio: prio || '0.5' });
    pageCount++;
  }
  function crumb(parts) {
    return `<div class="crumb">${parts.map((p, i) =>
      i === parts.length - 1
        ? `<span>${escHtml(p.label)}</span>`
        : `<a href="${p.href}">${escHtml(p.label)}</a><span class="sep">›</span>`
    ).join(' ')}</div>`;
  }
  const appCta = (text, href, btn) =>
    `<div class="app-cta"><p>${escHtml(text)}</p><a class="btn btn-primary" href="${href}">${escHtml(btn)}</a></div>`;

  // ===== 1) HUB (/naverok) =====
  {
    let h = `<section class="page-hero"><div class="wrap">
      <span class="eyebrow">Naverok</span>
      <h1>Hemû naveroka LÛTKE</h1>
      <p class="lead">${data.meta.wordTotal.toLocaleString('tr-TR')} peyv, ${data.meta.lessonTotal} ders (${data.meta.exerciseTotal} egzersîz) û ${data.meta.dialogueTotal} diyalog — hemû li vir, di moda gerokê de.</p>
    </div></section>`;

    h += `<section class="section-tight"><div class="wrap">
      <h2 class="center" style="margin-bottom:8px">Peyv li gor astê</h2>
      <p class="center lead" style="margin-bottom:26px">Ferhenga tam — bi mînak, cins û kategoriyan.</p>
      <div class="hub-grid">`;
    for (const lvl of LEVELS) {
      const n = (data.words[lvl] || []).length;
      if (!n) continue;
      h += `<a class="hub-card" href="/peyv/${lvl}"><span class="lv">${lvl.toUpperCase()}</span><div class="nm">${LEVEL_NAME[lvl]}</div><div class="ct">${n} peyv</div></a>`;
    }
    h += `</div></div></section>`;

    h += `<section class="section-tight section-alt"><div class="wrap">
      <h2 class="center" style="margin-bottom:8px">Ders û etkinlik li gor astê</h2>
      <p class="center lead" style="margin-bottom:26px">Her ders bi egzersîzên xwe — guhdarî, pirhilbijartî, dagirtin û hwd.</p>
      <div class="hub-grid">`;
    for (const lvl of LEVELS) {
      const n = (data.lessons[lvl] || []).length;
      if (!n) continue;
      h += `<a class="hub-card" href="/wane/${lvl}"><span class="lv">${lvl.toUpperCase()}</span><div class="nm">${LEVEL_NAME[lvl]}</div><div class="ct">${n} ders</div></a>`;
    }
    h += `</div></div></section>`;

    if (data.dialogues.length) {
      h += `<section class="section-tight"><div class="wrap">
        <h2 class="center" style="margin-bottom:8px">Diyalog</h2>
        <p class="center lead" style="margin-bottom:26px">Sahneyên rastîn ên malbatê û jiyana rojane.</p>
        <div class="lesson-list">`;
      for (const d of data.dialogues) {
        h += `<a class="lesson-row" href="/diyalog/${escHtml(d.id)}"><span class="num">💬</span><div class="body"><div class="t-ku">${escHtml(d.kurmanjTitle)}</div><div class="t-tr">${escHtml(d.turkishTitle)}</div></div><span class="meta">${d.lines.length} rêz</span></a>`;
      }
      h += `</div></div></section>`;
    }

    h += `<section class="section"><div class="wrap">${appCta('Bi tevahî, bi deng û bi pratîkê fêr bibe.', '/app/', 'Sepanê veke')}</div></section>`;

    await emit('naverok', h, {
      title: 'Naverok | Hemû peyv, ders û diyalog — LÛTKE',
      desc: `LÛTKE naveroka tam: ${data.meta.wordTotal} peyv (A1–C2), ${data.meta.lessonTotal} ders û egzersîz, ${data.meta.dialogueTotal} diyalog. Di moda gerokê de bigere.`,
      og: 'og-default.png',
    }, '0.8');
  }

  // ===== 2) PEYV /peyv/<lvl> =====
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

    const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: `Peyv · ${lvl.toUpperCase()}` }])}
      <span class="eyebrow">Peyv · ${lvl.toUpperCase()} ${LEVEL_NAME[lvl]}</span>
      <h1>Ferhenga ${lvl.toUpperCase()}</h1>
      <p class="lead">${words.length} peyv — li gor kategoriyan parzûn bike an bigere.</p>
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
      jsonld: {
        '@context': 'https://schema.org', '@type': 'CollectionPage',
        name: `Peyvên ${lvl.toUpperCase()}`, inLanguage: 'ku',
        isPartOf: { '@type': 'WebSite', name: 'LÛTKE', url: SITE_URL + '/' },
      },
    }, '0.7');
  }

  // ===== 3) WANE liste /wane/<lvl> =====
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
    const body = `${crumb([{ label: 'Naverok', href: '/naverok' }, { label: `Ders · ${lvl.toUpperCase()}` }])}
      <span class="eyebrow">Ders · ${lvl.toUpperCase()} ${LEVEL_NAME[lvl]}</span>
      <h1>Dersên ${lvl.toUpperCase()}</h1>
      <p class="lead">${lessons.length} ders — her yek bi egzersîz û etkinlikên xwe.</p>
      ${listHtml}
      ${appCta('Van dersan bi tevahî û interaktîf di sepanê de bike.', '/app/', 'Sepanê veke')}`;

    await emit(`wane/${lvl}`, body, {
      title: `Dersên ${lvl.toUpperCase()} (${LEVEL_NAME[lvl]}) | Mufredata Kurmancî — LÛTKE`,
      desc: `${lessons.length} dersên Kurmancî yên asta ${lvl.toUpperCase()} — bi egzersîz, gramer û naveroka çandî. Mufredata LÛTKE.`,
      og: 'og-default.png',
    }, '0.7');
  }

  // ===== 4) WANE detay /wane/<lessonId> =====
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
        for (const w of tw.slice(0, 80)) {
          wordsHtml += `<tr><td class="w-ku">${escHtml(w.ku)}</td><td class="w-tr">${escHtml(w.tr)}</td></tr>`;
        }
        wordsHtml += `</tbody></table>`;
      }

      const cul = (data.cultural || []).find(c => c.id === l.culturalRewardId);
      const culHtml = cul
        ? `<blockquote>${escHtml(cul.textKu)}<br><span style="font-weight:400;font-size:.92rem;color:var(--text-3)">${escHtml(cul.textTr)}${cul.source ? ' — ' + escHtml(cul.source) : ''}</span></blockquote>`
        : '';

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
        jsonld: {
          '@context': 'https://schema.org', '@type': 'LearningResource',
          name: l.kurmanjTitle, inLanguage: 'ku',
          educationalLevel: lvl.toUpperCase(), learningResourceType: 'lesson',
          isPartOf: { '@type': 'Course', name: `Kurmancî ${lvl.toUpperCase()}` },
        },
      }, '0.6');
    }
  }

  // ===== 5) DIYALOG /diyalog/<id> =====
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

  ctx.log(`content: ${pageCount} sayfa (naverok + peyv + wane + diyalog)`);
  return { pages: pageCount, urls };
}
