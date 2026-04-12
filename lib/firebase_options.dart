// Bu dosya `flutterfire configure` komutuyla otomatik oluşturulur.
// Aşağıdaki değerleri gerçek Firebase proje değerleriyle değiştirin.
// https://firebase.google.com/docs/flutter/setup

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// LÛTKE — Firebase yapılandırma seçenekleri
///
/// Kullanım:
/// ```dart
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => macos,
      _ => throw UnsupportedError(
          'DefaultFirebaseOptions desteklenmayan platform: '
          '$defaultTargetPlatform',
        ),
    };
  }

  // ────────────────────────────────────────────────────────────
  // Android — google-services.json değerleri
  // android/app/google-services.json dosyasından alın
  // ────────────────────────────────────────────────────────────
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'ANDROID_API_KEY',               // ← google-services.json
    appId: '1:XXXXXXXXXX:android:XXXXXXXXXX',// ← mobilesdk_app_id
    messagingSenderId: 'XXXXXXXXXX',          // ← project_number
    projectId: 'lutke-kurdish',              // ← project_id
    storageBucket: 'lutke-kurdish.appspot.com',
  );

  // ────────────────────────────────────────────────────────────
  // iOS — GoogleService-Info.plist değerleri
  // ios/Runner/GoogleService-Info.plist dosyasından alın
  // ────────────────────────────────────────────────────────────
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'IOS_API_KEY',                   // ← API_KEY
    appId: '1:XXXXXXXXXX:ios:XXXXXXXXXX',    // ← GOOGLE_APP_ID
    messagingSenderId: 'XXXXXXXXXX',          // ← GCG_SENDER_ID
    projectId: 'lutke-kurdish',
    storageBucket: 'lutke-kurdish.appspot.com',
    iosBundleId: 'com.lutke.kurmanci',       // ← BUNDLE_ID
  );

  // ────────────────────────────────────────────────────────────
  // macOS — iOS ile aynı değerleri kullanabilir
  // ────────────────────────────────────────────────────────────
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'IOS_API_KEY',
    appId: '1:XXXXXXXXXX:ios:XXXXXXXXXX',
    messagingSenderId: 'XXXXXXXXXX',
    projectId: 'lutke-kurdish',
    storageBucket: 'lutke-kurdish.appspot.com',
    iosBundleId: 'com.lutke.kurmanci',
  );

  // ────────────────────────────────────────────────────────────
  // Web (opsiyonel)
  // ────────────────────────────────────────────────────────────
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'WEB_API_KEY',
    appId: '1:XXXXXXXXXX:web:XXXXXXXXXX',
    messagingSenderId: 'XXXXXXXXXX',
    projectId: 'lutke-kurdish',
    storageBucket: 'lutke-kurdish.appspot.com',
    authDomain: 'lutke-kurdish.firebaseapp.com',
  );
}

// ════════════════════════════════════════════════════════════════
// KURULUM NOTLARI
// ════════════════════════════════════════════════════════════════
//
// 1. Firebase Console'da yeni proje oluşturun:
//    https://console.firebase.google.com
//    Proje adı: lutke-kurdish
//
// 2. FlutterFire CLI kurulumu:
//    dart pub global activate flutterfire_cli
//
// 3. Bu dosyayı otomatik oluşturun:
//    flutterfire configure --project=lutke-kurdish
//
// 4. Firebase Console'da etkinleştirin:
//    - Authentication → Email/Password + Anonim
//    - Firestore Database (prod modu)
//    - Storage
//
// 5. Firestore güvenlik kuralları (firestore.rules):
//    rules_version = '2';
//    service cloud.firestore {
//      match /databases/{database}/documents {
//        match /users/{userId} {
//          allow read, write: if request.auth.uid == userId;
//        }
//        match /analytics/{doc} {
//          allow create: if request.auth != null;
//          allow read: if false; // Sadece backend okuyabilir
//        }
//      }
//    }
