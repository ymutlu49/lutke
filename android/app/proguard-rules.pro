# ════════════════════════════════════════════════════════════════
# LÛTKE — ProGuard / R8 Rules
# ════════════════════════════════════════════════════════════════
# Bu dosya release build'da minifyEnabled true olduğunda kullanılır.
# minifyEnabled false ise atlanır.
#
# Bedirxan ilkesi: APK boyutunu küçült + reverse-engineering zorlaştır.
# Ama Firebase, Drift, Riverpod gibi reflection kullanan kütüphanelerin
# sınıflarını koru, yoksa runtime crash olur.
# ════════════════════════════════════════════════════════════════

# ── Flutter genel ────────────────────────────────────────────────
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# ── Firebase / Google Play Services ─────────────────────────────
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.gms.common.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Auth — reflection-based credential providers
-keepclassmembers class com.google.firebase.auth.** { *; }

# Firestore — Document type adapters
-keepclassmembers class * {
  @com.google.firebase.firestore.PropertyName <fields>;
  @com.google.firebase.firestore.PropertyName <methods>;
}

# Firebase Cloud Messaging (gelecek için hazır)
-keep class com.google.firebase.messaging.** { *; }

# ── Drift / SQLite ──────────────────────────────────────────────
-keep class * extends androidx.room.RoomDatabase
-keep @androidx.room.Entity class *
-dontwarn androidx.room.paging.**
# sqlite3 native library
-keep class com.tekartik.sqflite.** { *; }
-keep class org.sqlite.** { *; }

# ── just_audio ──────────────────────────────────────────────────
-keep class com.ryanheise.just_audio.** { *; }
-keep class com.ryanheise.audioservice.** { *; }

# ── Connectivity Plus ───────────────────────────────────────────
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# ── Path Provider ───────────────────────────────────────────────
-keep class io.flutter.plugins.pathprovider.** { *; }

# ── Shared Preferences ──────────────────────────────────────────
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# ── Share Plus ──────────────────────────────────────────────────
-keep class dev.fluttercommunity.plus.share.** { *; }

# ── Dio (HTTP) — Retrofit-style annotations ─────────────────────
-keepattributes Signature
-keepattributes *Annotation*
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# ── Riverpod / Annotation-based generators ──────────────────────
# Generated code (.g.dart) — Dart side, not affected by ProGuard
# Ama Java<->Dart bridge için generic types korunmalı:
-keepattributes Signature
-keepattributes InnerClasses

# ── JSON serialization (genel) ──────────────────────────────────
-keepclassmembers class * {
  @com.fasterxml.jackson.annotation.JsonProperty <fields>;
}

# ── Native obfuscation: kullanıcı sınıfları ─────────────────────
# LÛTKE iç sınıfları minify edilebilir AMA reflection veya
# dinamik dispatch yok, güvenli.
# (Specific keep rules eklemek için ihtiyaç çıktığında bu bölüme yazın)

# ── Kotlin Reflection (kullanılmıyor ama defansif) ──────────────
-dontwarn kotlin.reflect.jvm.internal.**

# ── Genel anti-warning ──────────────────────────────────────────
-dontwarn java.lang.invoke.**
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement

# ── Stack trace okunabilirliği ──────────────────────────────────
# Crashlytics raporlarında satır numaraları görünsün:
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# ── Native crash debugging (Crashlytics için) ───────────────────
# Crashlytics eklenince bu satırları aktif edin:
# -keep class com.google.firebase.crashlytics.** { *; }
# -dontwarn com.google.firebase.crashlytics.**
