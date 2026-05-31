#!/usr/bin/env node
// LÛTKE — OG image generator (1200x630) via headless Chrome + file://
// Çıktı: website/assets/og-home.png + og-default.png (build-site bunları dist'e kopyalar)
//
// Tuzak notları: file:// çalışır, http(s):// bu ortamda başarısız olabilir.
// --headless=new KULLAN; --virtual-time-budget KULLANMA. İzole --user-data-dir şart
// (yoksa çalışan Chrome'a bağlanır ve --screenshot sessizce atlanır). Sistem fontu.
import { promises as fs } from 'node:fs';
import { existsSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..', '..');
const ASSETS = path.join(ROOT, 'website', 'assets');
const TMP = path.join(ROOT, '.ogtmp');

const CHROMES = [
  'C:/Program Files/Google/Chrome/Application/chrome.exe',
  'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe',
  'C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe',
  'C:/Program Files/Microsoft/Edge/Application/msedge.exe',
];
function findChrome() {
  for (const c of CHROMES) if (existsSync(c)) return c;
  throw new Error('Chrome/Edge bulunamadı.');
}
function fwd(p) { return p.replace(/\\/g, '/'); }

function ogHtml({ logoUrl, title, sub, tag }) {
  return `<!DOCTYPE html><html><head><meta charset="utf-8"><style>
  *{margin:0;box-sizing:border-box}
  html,body{width:1200px;height:630px;overflow:hidden}
  body{font-family:"Segoe UI",Arial,sans-serif;
    background:radial-gradient(900px 600px at 82% 18%, #1F8A78 0%, transparent 60%),
               linear-gradient(135deg,#0C5247 0%,#1A7B6B 100%);
    color:#fff;display:flex;align-items:center;justify-content:space-between;padding:0 84px}
  .l{max-width:720px}
  .word{font-size:104px;font-weight:800;letter-spacing:2px;line-height:1}
  .title{font-size:50px;font-weight:700;margin-top:18px;color:#fff}
  .sub{font-size:34px;font-weight:400;margin-top:10px;color:#CFEDE5}
  .tags{margin-top:34px;display:flex;gap:14px;flex-wrap:wrap}
  .chip{background:rgba(255,255,255,.16);border:1px solid rgba(255,255,255,.28);
    padding:12px 22px;border-radius:999px;font-size:26px;font-weight:600}
  .art img{width:340px;height:340px;filter:drop-shadow(0 24px 50px rgba(0,0,0,.35))}
  </style></head><body>
  <div class="l">
    <div class="word">LÛTKE</div>
    <div class="title">${title}</div>
    <div class="sub">${sub}</div>
    <div class="tags">${tag.map(t => `<span class="chip">${t}</span>`).join('')}</div>
  </div>
  <div class="art"><img src="${logoUrl}" alt=""></div>
  </body></html>`;
}

async function shoot(chrome, html, outPng) {
  await fs.mkdir(TMP, { recursive: true });
  const base = path.basename(outPng).replace(/\.png$/, '');
  const htmlPath = path.join(TMP, base + '.html');
  const shotPath = path.join(TMP, base + '.shot.png');
  const profileDir = path.join(TMP, 'profile-' + base);
  await fs.writeFile(htmlPath, html);
  const url = pathToFileURL(htmlPath).href;
  execFileSync(chrome, [
    '--headless=new', '--disable-gpu', '--hide-scrollbars', '--no-sandbox',
    `--user-data-dir=${fwd(profileDir)}`,
    '--force-device-scale-factor=1', '--window-size=1200,630',
    `--screenshot=${fwd(shotPath)}`, url,
  ], { stdio: 'inherit' });
  const buf = await fs.readFile(shotPath);
  const w = buf.readUInt32BE(16), h = buf.readUInt32BE(20);
  if (w !== 1200 || h !== 630) throw new Error(`OG screenshot wrong size ${w}x${h} for ${outPng}`);
  await fs.copyFile(shotPath, outPng);
  console.log('[og] wrote', fwd(outPng), `(${w}x${h}, ${Math.round(buf.length / 1024)}KB)`);
}

async function main() {
  const chrome = findChrome();
  const logoUrl = pathToFileURL(path.join(ASSETS, 'logo-512.png')).href;
  await fs.mkdir(ASSETS, { recursive: true });

  await shoot(chrome, ogHtml({
    logoUrl,
    title: 'Kurmancî Fêr Bibe',
    sub: 'Ji peyvekê heya welatekî',
    tag: ['A1–C2', '3.900+ peyv', '137 ders'],
  }), path.join(ASSETS, 'og-home.png'));

  await shoot(chrome, ogHtml({
    logoUrl,
    title: 'Zimanê Kurdî',
    sub: 'Sepana fêrbûna Kurmancî',
    tag: ['Belaş', 'Bê reklam', 'A1–C2'],
  }), path.join(ASSETS, 'og-default.png'));

  await fs.rm(TMP, { recursive: true, force: true });
  console.log('[og] done');
}
main().catch(e => { console.error('[og] FAILED:', e.message); process.exit(1); });
