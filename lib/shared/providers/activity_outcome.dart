/// Etkinlik oturumunun sonucu — birim merkezinin "tamamlandı" kararı için.
///
/// Önceden etkinlik, ekrandan geri dönülünce tamamlanmış sayılıyordu: puan da
/// bitirme koşulu da yoktu. Artık etkinlik ekranı oturum BİTİNCE sonucunu
/// [ActivityOutcome.report] ile bildirir; birim merkezi etkinlikten dönünce
/// [ActivityOutcome.take] ile alır ve yalnız [passed] ise işaretler.
/// Ekrandan erken çıkılırsa bildirim olmaz, etkinlik tamamlanmış sayılmaz.
///
/// Statik tutucu yeterli: etkinlikler tek tek açılır, aynı anda iki oturum
/// olmaz. Kalıcı değildir; yalnız "aç → oyna → dön" arasını taşır.
class ActivityOutcome {
  /// Puanlı etkinliklerde geçme eşiği (doğru / toplam).
  static const double passRatio = 0.7;

  final int correct;
  final int total;

  const ActivityOutcome(this.correct, this.total);

  /// Puansız etkinlik (kart, telaffuz, eşleştirme): oturumu bitirmek yeterli.
  const ActivityOutcome.completed()
      : correct = 1,
        total = 1;

  double get ratio => total > 0 ? correct / total : 0;
  bool get passed => total > 0 && ratio >= passRatio;
  int get percent => (ratio * 100).round();

  static ActivityOutcome? _last;

  /// Etkinlik açılmadan önce çağrılır; önceki oturumun sonucu taşınmasın.
  static void clear() => _last = null;

  /// Oturum bitince çağrılır. Aynı ekranda "yeniden dene" ile birden çok
  /// oturum oynanabilir; en iyi sonuç tutulur.
  static void report(ActivityOutcome outcome) {
    final onceki = _last;
    if (onceki == null || outcome.ratio >= onceki.ratio) _last = outcome;
  }

  /// Etkinliğin gösterecek içeriği yok (birimde yeterli cümle yok vb.).
  /// İçerik eksiği öğrencinin yolunu kilitlememeli; basamak geçilmiş sayılır.
  static void reportNoContent() => report(const ActivityOutcome.completed());

  /// Sonucu alır ve tutucuyu boşaltır.
  static ActivityOutcome? take() {
    final outcome = _last;
    _last = null;
    return outcome;
  }
}
