// LÛTKE — POST /api/suggestions/update  (yalnız owner)
// Body: { id: string, status: 'open' | 'accepted' | 'rejected' }

import {
  errorResponse,
  getAuthFromRequest,
  jsonResponse,
  readJson,
  type Env,
} from "../../lib/http";

const ALLOWED_STATUS = new Set(["open", "accepted", "rejected"]);

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth?.isOwner) return errorResponse("Yetki yok.", 403, "forbidden");

  const body = await readJson<{ id?: string; status?: string }>(request);
  const id = (body?.id ?? "").trim();
  const status = (body?.status ?? "").trim();
  if (!id || !ALLOWED_STATUS.has(status)) {
    return errorResponse("Geçersiz istek.", 400, "bad_request");
  }

  const res = await env.DB.prepare(
    `UPDATE content_suggestions SET status = ?1, updated_at = ?2 WHERE id = ?3`,
  )
    .bind(status, Date.now(), id)
    .run();

  if ((res.meta?.changes ?? 0) === 0) {
    return errorResponse("Bulunamadı.", 404, "not_found");
  }
  return jsonResponse({ ok: true });
};
