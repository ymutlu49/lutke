// LÛTKE — /api/suggestions
// POST: kullanıcı düzeltme önerisi gönderir (herkese açık, rate-limitli).
// GET:  öneri listesi (yalnız owner; ?status=open|accepted|rejected filtresi).

import {
  checkRateLimit,
  errorResponse,
  generateUuid,
  getAuthFromRequest,
  getClientIp,
  hashIp,
  jsonResponse,
  readJson,
  type Env,
} from "../../lib/http";

const ALLOWED_TYPES = new Set(["peyv", "hevok", "werger", "deng", "din"]);
const ALLOWED_STATUS = new Set(["open", "accepted", "rejected"]);
const MAX_MSG = 2000;
const MAX_SHORT = 200;

interface SuggestionBody {
  itemType?: string;
  itemId?: string;
  itemText?: string;
  message?: string;
  suggestion?: string;
  route?: string;
  email?: string;
}

/** Kontrol karakterlerini temizle + uzunluk sınırla. */
function clean(s: unknown, max: number): string | null {
  if (typeof s !== "string") return null;
  // eslint-disable-next-line no-control-regex
  const t = s.replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F\u007F]/g, '').trim();
  if (!t) return null;
  return t.slice(0, max);
}

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  // Rate limit: IP başına 10/saat — istismarı engelle, dürüst kullanıcıyı engelleme.
  const ipHash = await hashIp(getClientIp(request));
  const allowed = await checkRateLimit(
    env.DB,
    `suggestion:${ipHash}`,
    10,
    60 * 60 * 1000,
  );
  if (!allowed) {
    return errorResponse("Pir pêşniyar hatin şandin. Paşê dîsa biceribîne.", 429, "rate_limited");
  }

  const body = await readJson<SuggestionBody>(request);
  if (!body) return errorResponse("Geçersiz istek.", 400, "bad_request");

  const message = clean(body.message, MAX_MSG);
  if (!message || message.length < 5) {
    return errorResponse("Mesaj çok kısa.", 400, "message_too_short");
  }
  const itemType = (body.itemType ?? "din").toLowerCase().trim();
  if (!ALLOWED_TYPES.has(itemType)) {
    return errorResponse("Geçersiz tür.", 400, "invalid_type");
  }

  // Oturum opsiyonel — varsa user_id bağlanır (yanıt verebilmek için).
  const auth = await getAuthFromRequest(request, env);

  const now = Date.now();
  const id = generateUuid();
  await env.DB.prepare(
    `INSERT INTO content_suggestions
       (id, user_id, email, item_type, item_id, item_text, message, suggestion, route, status, created_at, updated_at)
     VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, 'open', ?10, ?10)`,
  )
    .bind(
      id,
      auth?.userId ?? null,
      clean(body.email, MAX_SHORT) ?? auth?.email ?? null,
      itemType,
      clean(body.itemId, MAX_SHORT),
      clean(body.itemText, MAX_SHORT),
      message,
      clean(body.suggestion, MAX_MSG),
      clean(body.route, MAX_SHORT),
      now,
    )
    .run();

  return jsonResponse({ ok: true, id }, 201);
};

export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth?.isOwner) return errorResponse("Yetki yok.", 403, "forbidden");

  const url = new URL(request.url);
  const status = url.searchParams.get("status");
  const limit = Math.min(
    parseInt(url.searchParams.get("limit") ?? "200", 10) || 200,
    500,
  );

  const rows = ALLOWED_STATUS.has(status ?? "")
    ? await env.DB.prepare(
        `SELECT * FROM content_suggestions WHERE status = ?1
         ORDER BY created_at DESC LIMIT ?2`,
      )
        .bind(status, limit)
        .all()
    : await env.DB.prepare(
        `SELECT * FROM content_suggestions ORDER BY created_at DESC LIMIT ?1`,
      )
        .bind(limit)
        .all();

  return jsonResponse({ suggestions: rows.results ?? [] });
};
