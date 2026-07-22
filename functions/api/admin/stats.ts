// LÛTKE — GET /api/admin/stats
// Owner-only. Returns user count and breakdown.

import {
  errorResponse,
  getAuthFromRequest,
  isOwnerEmail,
  jsonResponse,
  type Env,
} from "../../lib/http";
import { getUserStats } from "../../lib/db";

export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth) return errorResponse("Oturum yok.", 401, "unauthorized");

  // Double-check: token claims AND fresh email check.
  // (Token "isOwner: false" kalmış olabilir — owner email değiştiyse.)
  if (!auth.isOwner && !isOwnerEmail(auth.email, env)) {
    return errorResponse("Erişim reddedildi.", 403, "forbidden");
  }

  try {
    const stats = await getUserStats(env.DB);
    return jsonResponse({ stats });
  } catch (e) {
    return errorResponse(
      "İstatistikler alınamadı.",
      500,
      "stats_error",
    );
  }
};
