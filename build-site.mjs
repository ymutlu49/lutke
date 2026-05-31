#!/usr/bin/env node
// LÛTKE — Static site builder
// website/  →  dist/   (marketing site at root) + dist/app/ (Flutter app, base-href /app/)
//
// Usage:
//   node build-site.mjs            # build marketing + content pages (fast; keeps dist/app)
//   node build-site.mjs --with-app # also copy Flutter build/web -> dist/app (heavy)
//
// Design:
//   - Common parts injected from website/layout.html (<!--#head/header/footer/content-->)
//   - Per-page <!--META {json}--> drives <title>/description/canonical/OG
//   - Content-hashed css/js (immutable cache safe)
//   - Data-driven content pages from website/data/content.json (generate-content.mjs)
//   - Clean URLs, dynamic sitemap.xml, robots.txt, _headers, _redirects
//   - functions/ stays at project root; `wrangler pages deploy dist` bundles it from CWD
//
import { promises as fs } from 'node:fs';
import { existsSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { execFileSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = __dirname;
const SRC = path.join(ROOT, 'website');
const DIST = path.join(ROOT, 'dist');
const BUILD_WEB = path.join(ROOT, 'build', 'web');
const SITE_URL = 'https://lutke.app';
const WITH_APP = process.argv.includes('--with-app');

const log = (...a) => console.log('[build-site]', ...a);
const BUILD_DATE = process.env.BUILD_DATE || '2026-05-31';

// ── Site-geneli varlık (entity) düğümleri — AEO/GEO için ──
// Her sayfanın JSON-LD @graph'ine eklenir. Sabit @id'ler ile AI motorları
// LÛTKE'yi ve yazarı (Prof. Dr. Yılmaz Mutlu) tutarlı bir varlık olarak tanır.
// sameAs: gerçek profiller eklendikçe genişletilmeli (Wikidata/ORCID/sosyal).
const ENTITY_NODES = [
  {
    '@type': ['Organization', 'EducationalOrganization'],
    '@id': 'https://lutke.app/#org',
    name: 'LÛTKE',
    alternateName: 'LÛTKE — Zimanê Kurdî',
    url: 'https://lutke.app/',
    logo: 'https://lutke.app/assets/site/logo-512.png',
    description: 'Platformeke belaş a fêrbûna zimanê Kurmancî (Kurdiya Bakur): ferheng (3.900+ peyv, A1–C2), ders, rêziman û çanda Kurdî (gotinên pêşiyan, helbest, stran).',
    inLanguage: 'ku',
    slogan: 'Ji peyvekê heya welatekî.',
    founder: { '@id': 'https://lutke.app/#yilmaz-mutlu' },
    sameAs: [],
  },
  {
    '@type': 'Person',
    '@id': 'https://lutke.app/#yilmaz-mutlu',
    name: 'Yılmaz Mutlu',
    honorificPrefix: 'Prof. Dr.',
    jobTitle: 'Professor',
    description: 'Akademîsyen û pêşxistinerê platforma LÛTKE; xebatkarê li ser zimanê Kurmancî.',
    knowsAbout: ['Kurmancî', 'Zimanê Kurdî', 'Kurdish linguistics', 'Language education', 'CEFR'],
    worksFor: { '@id': 'https://lutke.app/#org' },
    sameAs: [],
  },
  {
    '@type': 'WebSite',
    '@id': 'https://lutke.app/#website',
    url: 'https://lutke.app/',
    name: 'LÛTKE',
    inLanguage: 'ku',
    publisher: { '@id': 'https://lutke.app/#org' },
  },
];

// ---------- helpers ----------
async function rmrf(p) { await fs.rm(p, { recursive: true, force: true }); }
async function mkdirp(p) { await fs.mkdir(p, { recursive: true }); }
async function read(p) { return fs.readFile(p, 'utf8'); }
async function write(p, c) { await mkdirp(path.dirname(p)); await fs.writeFile(p, c); }
function hash8(buf) { return createHash('sha256').update(buf).digest('hex').slice(0, 8); }
async function copyDir(from, to) { await fs.cp(from, to, { recursive: true }); }
function escHtml(s) {
  return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}
async function listFiles(dir) {
  const out = [];
  async function walk(d) {
    let ents = [];
    try { ents = await fs.readdir(d, { withFileTypes: true }); } catch { return; }
    for (const e of ents) {
      const fp = path.join(d, e.name);
      if (e.isDirectory()) await walk(fp); else out.push(fp);
    }
  }
  await walk(dir);
  return out;
}

// ---------- pages registry (drives nav + sitemap) ----------
const PAGES = [
  { src: 'index.html',          slug: '',               nav: null,            prio: '1.0' },
  { src: 'lutke-ci-ye.html',    slug: 'lutke-ci-ye',    nav: 'LÛTKE Çi ye?',  prio: '0.9' },
  { src: 'rebaz.html',          slug: 'rebaz',          nav: 'Rêbaz',         prio: '0.8' },
  { src: 'asten-ferbune.html',  slug: 'asten-ferbune',  nav: 'Astên Fêrbûnê', prio: '0.8' },
  { src: 'taybetmendi.html',    slug: 'taybetmendi',    nav: 'Taybetmendî',   prio: '0.8' },
  // naverok = içerik hub'ı; HTML'ini generate-content.mjs üretir. Burada sadece nav linki.
  { slug: 'naverok',            nav: 'Naverok',         navOnly: true },
  { src: 'derbare.html',        slug: 'derbare',        nav: 'Derbarê',       prio: '0.6' },
  { src: 'tekili.html',         slug: 'tekili',         nav: 'Têkilî',        prio: '0.5' },
  { src: 'daxistin.html',       slug: 'daxistin',       nav: null,            prio: '0.9' },
];

// auth utility pages (functional, not in nav/sitemap)
const AUTH_PAGES = [
  { src: 'auth/verify-email.html',  out: 'auth/verify-email.html' },
  { src: 'auth/reset-password.html', out: 'reset-password.html' },
];

// Physical redirect pages -> /app/...  (static-first safe; _redirects is SKIPPED for
// paths under a folder that holds a static file, e.g. /auth/*; and /vocabulary gets a
// 308-to-trailing-slash before _redirects runs).
const REDIRECT_PAGES = [
  { out: 'auth/login.html',    to: '/app/auth/login' },
  { out: 'auth/register.html', to: '/app/auth/register' },
  { out: 'vocabulary.html',    to: '/app/vocabulary' },
];

function redirectPageHtml(to) {
  return `<!DOCTYPE html><html lang="ku" dir="ltr"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>LÛTKE</title>
<link rel="canonical" href="https://lutke.app${to}">
<meta http-equiv="refresh" content="0; url=${to}">
<script>location.replace('${to}' + location.search + location.hash);</script>
<style>body{font-family:system-ui,sans-serif;display:grid;place-items:center;min-height:100vh;margin:0;color:#0C5247;background:#EDF7F4}</style>
</head><body>Tê beralîkirin… <a href="${to}">LÛTKE</a></body></html>`;
}

// Naverok açılır menüsü — içerik bölümleri alt başlık olarak
const NAVEROK_SUB = [
  { href: '/naverok', label: 'Hemû Naverok' },
  { href: '/peyv/a1', label: 'Peyv (Ferheng)' },
  { href: '/wane/a1', label: 'Wane û Çalakî' },
  { href: '/reziman', label: 'Rêziman' },
  { href: '/cand', label: 'Çand' },
];
const CHEV = '<svg class="chev" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" aria-hidden="true"><path d="M6 9l6 6 6-6"/></svg>';

function navHtml(activeSlug) {
  return PAGES.filter(p => p.nav).map(p => {
    if (p.slug === 'naverok') {
      const active = activeSlug === 'naverok' ? ' active' : '';
      const items = NAVEROK_SUB.map(s => `<li><a href="${s.href}">${s.label}</a></li>`).join('');
      return `<li class="has-dropdown${active}">
          <button type="button" class="nav-drop-toggle" aria-expanded="false" aria-haspopup="true">${p.nav}${CHEV}</button>
          <ul class="dropdown">${items}</ul>
        </li>`;
    }
    const href = p.slug === '' ? '/' : `/${p.slug}`;
    const active = p.slug === activeSlug ? ' aria-current="page"' : '';
    return `<li><a href="${href}"${active}>${p.nav}</a></li>`;
  }).join('\n        ');
}

// ---------- main ----------
async function main() {
  log('clean dist');
  if (WITH_APP) {
    await rmrf(DIST);
  } else {
    // remove everything except dist/app (fast iteration on the marketing/content site)
    if (existsSync(DIST)) {
      for (const e of await fs.readdir(DIST)) {
        if (e !== 'app') await rmrf(path.join(DIST, e));
      }
    }
  }
  await mkdirp(DIST);

  // 1) hash + emit css/js
  const cssRaw = await read(path.join(SRC, 'styles', 'site.css'));
  const jsRaw = await read(path.join(SRC, 'scripts', 'site.js'));
  const cssName = `site.${hash8(cssRaw)}.css`;
  const jsName = `site.${hash8(jsRaw)}.js`;
  await write(path.join(DIST, 'assets', 'site', cssName), cssRaw);
  await write(path.join(DIST, 'assets', 'site', jsName), jsRaw);
  log('assets', cssName, jsName);

  // 2) copy static site assets (images, og, favicon, etc.)
  const siteAssets = path.join(SRC, 'assets');
  if (existsSync(siteAssets)) {
    await copyDir(siteAssets, path.join(DIST, 'assets', 'site'));
    log('copied site assets');
  }

  // 3) layout + partials
  const layout = await read(path.join(SRC, 'layout.html'));
  const header = await read(path.join(SRC, 'partials', 'header.html'));
  const footer = await read(path.join(SRC, 'partials', 'footer.html'));
  const head = await read(path.join(SRC, 'partials', 'head.html'));

  // Shared page renderer — used by static PAGES and by generate-content.mjs.
  function renderPage({ slug, body, meta = {}, activeNav = null }) {
    const canonical = slug === '' ? `${SITE_URL}/` : `${SITE_URL}/${slug}`;
    const ogImage = `${SITE_URL}/assets/site/${meta.og || 'og-default.png'}`;
    const lang = meta.lang || 'ku';
    // JSON-LD: site-geneli varlık @graph'i (Organization + Person + WebSite) HER
    // sayfada referanslanabilir @id'lerle + sayfaya özel node'lar. AEO/GEO: AI
    // motorları varlık reconciliation yapar; sabit @id'ler güveni artırır.
    const graph = [...ENTITY_NODES];
    if (meta.jsonld) {
      const extra = Array.isArray(meta.jsonld) ? meta.jsonld : [meta.jsonld];
      graph.push(...extra);
    }
    const jsonld = `<script type="application/ld+json">${JSON.stringify({ '@context': 'https://schema.org', '@graph': graph })}</script>`;
    const headFilled = head
      .replaceAll('{{TITLE}}', meta.title || 'LÛTKE — Zimanê Kurdî')
      .replaceAll('{{DESC}}', (meta.desc || '').replace(/"/g, '&quot;'))
      .replaceAll('{{CANONICAL}}', canonical)
      .replaceAll('{{OG_IMAGE}}', ogImage)
      .replaceAll('{{OG_TYPE}}', meta.ogType || 'website')
      .replaceAll('{{OG_LOCALE}}', lang === 'tr' ? 'tr_TR' : (lang === 'en' ? 'en' : 'ku'))
      .replaceAll('{{CSS}}', `/assets/site/${cssName}`)
      .replaceAll('{{JS}}', `/assets/site/${jsName}`)
      .replaceAll('{{JSONLD}}', jsonld);
    return layout
      .replace('<html lang="ku" dir="ltr">', `<html lang="${lang}" dir="ltr">`)
      .replace('<!--#head-->', headFilled)
      .replace('<!--#header-->', header.replaceAll('{{NAV}}', navHtml(activeNav ?? slug)))
      .replace('<!--#content-->', body)
      .replace('<!--#footer-->', footer);
  }

  // 4) static content pages
  const wordsHtml = await buildWordSamples();
  let staticCount = 0;
  for (const page of PAGES) {
    if (page.navOnly) continue;
    const raw = await read(path.join(SRC, 'pages', page.src));
    const m = raw.match(/^<!--META([\s\S]*?)-->/);
    const meta = m ? JSON.parse(m[1]) : {};
    const body = raw.replace(/^<!--META[\s\S]*?-->\s*/, '').replaceAll('{{WORDS}}', wordsHtml);
    const html = renderPage({ slug: page.slug, body, meta });
    const outPath = page.slug === ''
      ? path.join(DIST, 'index.html')
      : path.join(DIST, `${page.slug}.html`);
    await write(outPath, html);
    staticCount++;
  }
  log(`built ${staticCount} static pages`);

  // 4b) data-driven content pages (peyv / wane / diyalog / naverok hub)
  let contentUrls = [];
  {
    const { generateContentPages } = await import('./generate-content.mjs');
    const res = await generateContentPages({ ROOT, DIST, SITE_URL, renderPage, escHtml, log, BUILD_DATE });
    contentUrls = res.urls;
  }

  // 5) auth utility pages (standalone, self-contained)
  for (const ap of AUTH_PAGES) {
    const raw = await read(path.join(SRC, ap.src));
    const filled = raw
      .replaceAll('{{CSS}}', `/assets/site/${cssName}`)
      .replaceAll('{{JS}}', `/assets/site/${jsName}`);
    await write(path.join(DIST, ap.out), filled);
  }
  log(`built ${AUTH_PAGES.length} auth pages`);

  // 5b) physical redirect pages (static-first safe)
  for (const rp of REDIRECT_PAGES) {
    await write(path.join(DIST, rp.out), redirectPageHtml(rp.to));
  }
  log(`built ${REDIRECT_PAGES.length} redirect pages`);

  // 6) sitemap + robots
  const today = process.env.BUILD_DATE || '2026-05-31';
  const staticUrls = PAGES.filter(p => !p.navOnly).map(p => {
    const loc = p.slug === '' ? `${SITE_URL}/` : `${SITE_URL}/${p.slug}`;
    return `  <url><loc>${loc}</loc><lastmod>${today}</lastmod><priority>${p.prio}</priority></url>`;
  });
  const contentSiteUrls = contentUrls.map(u =>
    `  <url><loc>${u.loc}</loc><lastmod>${today}</lastmod><priority>${u.prio}</priority></url>`);
  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${[...staticUrls, ...contentSiteUrls].join('\n')}
</urlset>
`;
  await write(path.join(DIST, 'sitemap.xml'), sitemap);
  await write(path.join(DIST, 'robots.txt'), buildRobots());
  await write(path.join(DIST, 'llms.txt'), buildLlmsTxt());
  log(`sitemap (${staticUrls.length + contentSiteUrls.length} url) + robots + llms.txt`);

  // 7) _redirects + 8) _headers
  await write(path.join(DIST, '_redirects'), buildRedirects());
  await write(path.join(DIST, '_headers'), buildHeaders());
  log('_redirects + _headers');

  // 10) Flutter app -> dist/app
  if (WITH_APP) {
    await copyAppBuild();
  } else if (!existsSync(path.join(DIST, 'app', 'index.html'))) {
    log('WARNING: dist/app missing. Run with --with-app to include the Flutter app.');
  } else {
    log('reusing existing dist/app');
  }

  const files = await listFiles(DIST);
  log(`DONE. dist has ${files.length} files.`);
}

// Extract REAL sample words from the Dart content DBs for the marketing index page.
async function buildWordSamples() {
  const domain = path.join(ROOT, 'lib', 'features', 'lessons', 'domain');
  const levels = [
    { lvl: 'a1', file: 'a1_kelime_db.dart', from: 16, take: 9 },
    { lvl: 'a2', file: 'a2_kelime_db.dart', from: 6, take: 9 },
    { lvl: 'b1', file: 'b1_kelime_db.dart', from: 6, take: 6 },
    { lvl: 'c1', file: 'c1_kelime_db.dart', from: 6, take: 6 },
  ];
  const re = /id:\s*['"][a-z0-9_]+['"]\s*,\s*ku:\s*['"]([^'"\\]{2,42})['"]\s*,\s*tr:\s*['"]([^'"\\]{1,52})['"]/g;
  let html = '';
  for (const L of levels) {
    let txt = '';
    try { txt = await read(path.join(domain, L.file)); } catch { continue; }
    const all = [];
    let m; re.lastIndex = 0;
    while ((m = re.exec(txt))) {
      const tr = m[2];
      if (/ünlü|sesi|harf/i.test(tr)) continue;
      all.push({ ku: m[1], tr });
    }
    for (const w of all.slice(L.from, L.from + L.take)) {
      html += `<div class="word" data-level="${L.lvl}"><span class="lvl">${L.lvl.toUpperCase()}</span><div class="ku">${escHtml(w.ku)}</div><div class="tr">${escHtml(w.tr)}</div></div>\n        `;
    }
  }
  return html.trim() || '<p class="muted">Naverok di sepanê de ye.</p>';
}

function buildRedirects() {
  // vocabulary + auth/login + auth/register = physical redirect pages (static-first safe).
  const appRoutes = ['home', 'word-detail', 'progress-map', 'unit-hub', 'grammar', 'profile'];
  const splatRoutes = ['home', 'culture', 'onboarding', 'certificate', 'en', 'child', 'admin', 'review', 'legal'];
  const exactExtra = ['welcome', 'track-select', 'placement-test', 'listening-pilot', 'culture', 'legal', 'admin', 'review'];
  let r = `# LÛTKE — redirects
# Eski uygulama giriş noktaları -> /app/ (yer imleri / PWA / eski e-posta linkleri korunur)
# vocabulary + auth/login + auth/register = fiziksel redirect sayfalari (static-first guvenli)
`;
  for (const x of appRoutes) r += `/${x}  /app/${x}  301\n`;
  for (const x of exactExtra) r += `/${x}  /app/${x}  301\n`;
  for (const x of splatRoutes) r += `/${x}/*  /app/${x}/:splat  301\n`;
  r += `\n# Flutter app entry + SPA deep-link fallback\n`;
  r += `/app  /app/  301\n`;
  r += `/app/*  /app/index.html  200\n`;
  return r;
}

function buildRobots() {
  // AEO/GEO: AI arama/cevap botlarına AÇIKÇA izin ver (alıntılanmak için şart).
  // Eğitim (training) botlarına da izin: düşük-kaynaklı bir dilin gelecek
  // modellere girmesi LÛTKE için avantaj. /app/ (Flutter SPA) crawl dışı.
  const searchBots = ['OAI-SearchBot', 'ChatGPT-User', 'Claude-SearchBot', 'Claude-User',
    'PerplexityBot', 'Perplexity-User', 'Bingbot', 'Applebot', 'Googlebot'];
  const trainBots = ['GPTBot', 'ClaudeBot', 'Google-Extended', 'Amazonbot', 'Applebot-Extended', 'CCBot'];
  let r = `# robots.txt — lutke.app · Em dixwazin werin crawl kirin û jêgirtin (AEO/GEO)\n\n`;
  r += `User-agent: *\nAllow: /\nDisallow: /app/\n\n`;
  r += `# AI lêgerîn/bersiv-botên (jêgirtin/citation çêdikin)\n`;
  for (const b of searchBots) r += `User-agent: ${b}\nAllow: /\nDisallow: /app/\n`;
  r += `\n# AI training botên (ziman têkeve modelên paşerojê)\n`;
  for (const b of trainBots) r += `User-agent: ${b}\nAllow: /\nDisallow: /app/\n`;
  r += `\nSitemap: ${SITE_URL}/sitemap.xml\n`;
  return r;
}

function buildLlmsTxt() {
  // /llms.txt — AI ajanları/araçları için küratörlü özet (forward-looking).
  return `# LÛTKE — Platforma fêrbûna Kurmancî

> LÛTKE platformeke belaş a fêrbûna zimanê Kurmancî (Kurdiya Bakur) ye, ji aliyê
> Prof. Dr. Yılmaz Mutlu ve. Tê de ferhengek bi 3.900+ peyvên A1–C2, ders û
> egzersîz, rêbera rêzimanê û naveroka çandî ya Kurdî (gotinên pêşiyan, helbest,
> stran, kesayetên dîrokî) heye. Armanc: bibe çavkaniya vekirî ya bingehîn a Kurmancî.

## Naverok (Content)
- [Naverok — hemû](${SITE_URL}/naverok): peyv, wane, rêziman û çand.
- [Ferheng (Peyv)](${SITE_URL}/peyv/a1): 3.900+ peyvên Kurmancî bi wate û mînakan, A1–C2.
- [Wane û Çalakî](${SITE_URL}/wane/a1): dersên Kurmancî bi egzersîzan.
- [Rêziman](${SITE_URL}/reziman): rêbera rêzimana Kurmancî (alfabe, veqetandek, ergatîf, lêker).
- [Çand](${SITE_URL}/cand): atasozî, helbest, stran û kesayetên dîrokî.
- [Gotinên Pêşiyan](${SITE_URL}/cand/gotinen-pesiyan): 3.361 atasozîyên Kurmancî bi wergera tirkî.

## Derbarê (About)
- [LÛTKE Çi ye?](${SITE_URL}/lutke-ci-ye): naskirina platformê.
- [Rêbaz](${SITE_URL}/rebaz): rêbaza zanistî (FSRS, CEFR, standardê Bedirxan-Hawar).
- [Derbarê](${SITE_URL}/derbare): platform û nivîskar Prof. Dr. Yılmaz Mutlu.

## Sepan (App)
- [Sepana LÛTKE](${SITE_URL}/app/): sepana interaktîf (Flutter web).

## Projeyên xwişk (Related projects — same creator, Prof. Dr. Yılmaz Mutlu)
- [Gav bi Gav](https://gavbigav.com/): platforma perwerdehiya matematîkê bi Kurmancî ji bo zarokan.
- [Jimaro](https://jimaro.app/): proje ya perwerdehiya matematîkê (FerMat).
`;
}

function buildHeaders() {
  return `# LÛTKE — headers
# Hashed (immutable) marketing assets
/assets/site/*
  Cache-Control: public, max-age=31536000, immutable

# Marketing pages: revalidate + security headers
/*
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin
  X-Frame-Options: SAMEORIGIN

# Flutter app: main bundle must revalidate (stable filename, content changes per build)
/app/index.html
  Cache-Control: no-cache
/app/flutter_bootstrap.js
  Cache-Control: no-cache
/app/flutter_service_worker.js
  Cache-Control: no-cache
/app/main.dart.js
  Cache-Control: no-cache
/app/flutter.js
  Cache-Control: no-cache
/app/canvaskit/*
  Cache-Control: public, max-age=2592000
`;
}

async function copyAppBuild() {
  if (!existsSync(path.join(BUILD_WEB, 'index.html'))) {
    throw new Error('build/web/index.html not found — cannot copy Flutter app');
  }
  log('copying Flutter build/web -> dist/app (large, ~1.3GB) ...');
  await rmrf(path.join(DIST, 'app'));
  try {
    execFileSync('robocopy', [BUILD_WEB, path.join(DIST, 'app'), '/E', '/NFL', '/NDL', '/NJH', '/NJS', '/NC', '/NS', '/MT:16'],
      { stdio: 'inherit' });
  } catch (e) {
    if (e.status !== undefined && e.status >= 8) throw e; // robocopy 0-7 = success
  }
  const idxPath = path.join(DIST, 'app', 'index.html');
  let idx = await read(idxPath);
  idx = idx.replace(/<base href="\/">/, '<base href="/app/">');
  await fs.writeFile(idxPath, idx);
  log('  base-href set to /app/');

  const oauthSrc = path.join(BUILD_WEB, 'oauth-callback.html');
  if (existsSync(oauthSrc)) {
    await fs.copyFile(oauthSrc, path.join(DIST, 'oauth-callback.html'));
    log('  oauth-callback.html copied to root');
  }
}

main().catch(e => { console.error(e); process.exit(1); });
