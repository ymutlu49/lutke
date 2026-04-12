// ════════════════════════════════════════════════════════════════
// HATA YÖNETİMİ — LÛTKE
// Clean Architecture: Tip güvenli hata hiyerarşisi + Result pattern
// ════════════════════════════════════════════════════════════════

/// Tüm uygulama hatalarının temel sınıfı.
/// Her alt sınıf spesifik bir hata alanını temsil eder.
sealed class Failure {
  final String message;
  final String? messageKu; // Kurmancî hata mesajı (İlke §0.5)
  final Object? cause;

  const Failure({
    required this.message,
    this.messageKu,
    this.cause,
  });

  @override
  String toString() => '$runtimeType: $message';
}

// ── Veritabanı Hataları ─────────────────────────────────────

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.messageKu,
    super.cause,
  });
}

class SeedFailure extends DatabaseFailure {
  final int level;
  const SeedFailure({
    required this.level,
    required super.message,
    super.cause,
  }) : super(messageKu: 'Daneyên astê nehatin barkirin');
}

// ── Kimlik Doğrulama Hataları ──────────────────────────────

class AuthFailure extends Failure {
  final AuthFailureType type;
  const AuthFailure({
    required this.type,
    required super.message,
    super.messageKu,
    super.cause,
  });

  factory AuthFailure.fromFirebaseCode(String code) {
    final (type, message, messageKu) = switch (code) {
      'email-already-in-use' => (
        AuthFailureType.emailInUse,
        'Bu e-posta zaten kayıtlı.',
        'Ev e-peyam berê hatiye tomar kirin.',
      ),
      'wrong-password' || 'invalid-credential' => (
        AuthFailureType.wrongPassword,
        'E-posta veya şifre hatalı.',
        'E-peyam an şîfre xelet e.',
      ),
      'user-not-found' => (
        AuthFailureType.userNotFound,
        'Kullanıcı bulunamadı.',
        'Bikarhêner nehate dîtin.',
      ),
      'weak-password' => (
        AuthFailureType.weakPassword,
        'Şifre en az 6 karakter olmalıdır.',
        'Şîfre divê herî kêm 6 tîp be.',
      ),
      'network-request-failed' => (
        AuthFailureType.network,
        'İnternet bağlantınızı kontrol edin.',
        'Girêdana xwe ya înternetê kontrol bikin.',
      ),
      _ => (
        AuthFailureType.unknown,
        'Bir hata oluştu: $code',
        'Çewtîyek çêbû.',
      ),
    };
    return AuthFailure(type: type, message: message, messageKu: messageKu);
  }
}

enum AuthFailureType {
  emailInUse,
  wrongPassword,
  userNotFound,
  weakPassword,
  network,
  unknown,
}

// ── Ağ / Senkronizasyon Hataları ─────────────────────────

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.cause,
  }) : super(messageKu: 'Girêdana înternetê tune ye');
}

class SyncFailure extends Failure {
  const SyncFailure({
    required super.message,
    super.messageKu,
    super.cause,
  });
}

// ── Ses Hataları ────────────────────────────────────────────

class AudioFailure extends Failure {
  const AudioFailure({
    required super.message,
    super.cause,
  }) : super(messageKu: 'Deng nehate lêdan');
}

// ════════════════════════════════════════════════════════════════
// RESULT TİPİ — Either<Failure, T> alternatifi
// ════════════════════════════════════════════════════════════════

/// Fonksiyonel hata yönetimi: her işlem ya başarılı ya başarısız.
/// Exception fırlatmak yerine bu tip döndürülür.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Err<T>;

  /// Başarılıysa değeri döndürür, değilse null.
  T? get valueOrNull => switch (this) {
    Success(value: final v) => v,
    Err() => null,
  };

  /// Başarısızsa hatayı döndürür, değilse null.
  Failure? get failureOrNull => switch (this) {
    Success() => null,
    Err(failure: final f) => f,
  };

  /// Pattern matching ile işleme.
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) => switch (this) {
    Success(value: final v) => success(v),
    Err(failure: final f) => failure(f),
  };

  /// Başarılı değeri dönüştür.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success(value: final v) => Success(transform(v)),
    Err(failure: final f) => Err(f),
  };

  /// Zincirleme: başarılı değerden yeni Result üret.
  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
    Success(value: final v) => transform(v),
    Err(failure: final f) => Err(f),
  };
}

/// Başarılı sonuç.
class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  String toString() => 'Success($value)';
}

/// Başarısız sonuç.
class Err<T> extends Result<T> {
  final Failure failure;
  const Err(this.failure);

  @override
  String toString() => 'Err($failure)';
}
