// LÛTKE — GET /api/admin/stats
// Owner-only. Returns user count and breakdown.

import {
  errorResponse,
  getAuthFromRequest,
  isOwnerEmail,
  jsonResponse,
  type Env,
} from "../../lib/http";
import { findUserById, getUserStats } from "../../lib/db";

export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth) return errorResponse("Oturum yok.", 401, "unauthorized");

  // GÜVENLİK (Eki 2026): yetki, belirteçteki e-postaya değil veritabanındaki
  // güncel satıra bakılarak verilir. Eskiden belirteçteki e-posta sahip
  // listesindeyse yeterliydi; kayıt ucu doğrulanmamış hesaba da belirteç
  // verdiği için, sahip e-postasıyla (henüz kayıtlı değilse) kayıt olan biri
  // posta kutusunu kanıtlamadan bu uca erişebiliyordu.
  //   - is_owner=1: posta kutusu kanıtından sonra verilir (bkz. signup.ts).
  //   - Sahip listesine SONRADAN eklenen, e-postası zaten doğrulanmış hesap
  //     da kabul edilir (terfi bir sonraki doğrulama/sıfırlamada yazılır).
  const user = await findUserById(env.DB, auth.userId);
  const isOwner =
    !!user &&
    (user.is_owner === 1 ||
      (user.email_verified === 1 && isOwnerEmail(user.email, env)));
  if (!isOwner) {
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
