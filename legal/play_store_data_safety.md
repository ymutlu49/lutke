# LÛTKE — Play Console Data Safety Form

Bu doküman Play Console "Data safety" bölümü için hazırlanmıştır.
Lütfen Play Console → App content → Data safety bölümüne aşağıdaki bilgileri girin.

## Section 1: Data Collection and Sharing

### Q: Does your app collect or share any of the required user data types?
**Cevap:** ✅ Yes

### Q: Is all of the user data collected by your app encrypted in transit?
**Cevap:** ✅ Yes (HTTPS/TLS for all Firebase and HuggingFace requests)

### Q: Do you provide a way for users to request that their data is deleted?
**Cevap:** ✅ Yes (Profile → Hesabı Sil; or contact info@lutke.app)

---

## Section 2: Data Types Collected

### 📧 Personal Info — Email Address
- **Collected:** ✅ Yes (only if user creates account)
- **Shared:** ❌ No
- **Optional?** Yes (can use as guest)
- **Purpose:**
  - ✅ Account management
  - ✅ App functionality
- **Processing:** Encrypted at rest (Firebase Auth)

### 👤 Personal Info — Name
- **Collected:** ✅ Yes (display name only, optional)
- **Shared:** ❌ No
- **Optional?** Yes
- **Purpose:** App functionality (displayed in profile)

### 📊 App activity — Other actions
- **Collected:** ✅ Yes
- **Data:** Lesson progress, XP, streak, CEFR level
- **Shared:** ❌ No
- **Purpose:** App functionality (FSRS spaced repetition algorithm)

### 📊 App activity — In-app search history
- **Collected:** ❌ No

### 🎤 Audio Files — Voice recordings
- **Collected:** ✅ Yes (microphone for pronunciation practice)
- **PROCESSED LOCALLY:** ✅ Yes — voice samples processed on device
- **Stored on server?** ❌ NO (only anonymized score is sent)
- **Shared:** ❌ No

### 📱 Device or other IDs
- **Collected:** ✅ Yes (Firebase Installation ID — anonymous)
- **Shared:** ❌ No
- **Purpose:** Analytics (anonymous), crash reporting

### 🔧 App info and performance — Crash logs
- **Collected:** ✅ Yes (Firebase Crashlytics)
- **Personal data?** No (anonymous stack traces)
- **Purpose:** Bug fixing

### 🔧 App info and performance — Diagnostics
- **Collected:** ✅ Yes (anonymous)
- **Purpose:** Performance monitoring

---

## Section 3: Children's Data

### Q: Does your app target children (under 13) in any way?
**Cevap:** ✅ Yes (Child mode for ages 7-10)

### Q: Are there child-targeted features?
**Cevap:** ✅ Yes (LÛTKE ZAROK / LÛTKE KIDS modes)

### Q: How is verifiable parental consent collected?
**Cevap:**
- Math gate (Google-approved verification method)
- Explicit consent checkbox before child mode activation
- Stored in `parental_consent_given` flag (SharedPreferences)
- Path: `lib/features/child_mode/presentation/parental_gate_screen.dart`

### Child-Specific Data Practices:
- ❌ NO ads shown
- ❌ NO third-party analytics
- ❌ NO email/personal info collected
- ✅ Only age range (7-10) collected
- ✅ Parent can revoke at any time (Profile → Çocuk Mod → Veli Onayını Geri Al)

---

## Section 4: Data Sharing with Third Parties

### Firebase (Google LLC)
- **Service:** Authentication, Firestore (data storage), Crashlytics
- **Data shared:** Email, display name, learning progress, anonymous crash logs
- **Purpose:** App functionality
- **Privacy policy:** https://firebase.google.com/support/privacy

### HuggingFace Spaces
- **Service:** Kurmancî TTS (text-to-speech)
- **Data shared:** Text to be synthesized (NO user identity)
- **Purpose:** TTS audio generation
- **Privacy policy:** https://huggingface.co/privacy

### Google Fonts
- **Service:** Font loading
- **Data shared:** IP address (passive, not stored by us)
- **Purpose:** Font rendering

---

## Section 5: Data Security

- ✅ **In transit:** All requests over HTTPS/TLS 1.3
- ✅ **At rest:** Firebase ISO 27001/27017/27018 certified
- ✅ **Passwords:** Hashed with PBKDF2 (Firebase Auth)
- ✅ **Local storage:** Drift/SQLite with device-level encryption
- ✅ **User can delete data:** ✅ Yes (in-app, immediate)

---

## Section 6: Privacy Policy URL

**Privacy Policy URL:** https://lutke.app/privacy
*(USER MUST HOST: deploy `legal/privacy_policy_tr.md` to web hosting and provide URL here)*

**Terms of Service URL:** https://lutke.app/terms
*(USER MUST HOST: deploy `legal/terms_of_service_tr.md` and provide URL here)*

---

## Section 7: COPPA / GDPR / KVKK Compliance

### COPPA (Children's Online Privacy Protection Act)
- ✅ Verifiable parental consent before child mode activation
- ✅ No collection of personal info from children under 13
- ✅ No behavioral advertising to children
- ✅ Parental control to delete child's data

### GDPR (EU)
- ✅ Right to access — data export available
- ✅ Right to erasure — account deletion available
- ✅ Right to rectification — profile editing available
- ✅ Lawful basis: Consent (account) + Legitimate interest (analytics)

### KVKK (Türkiye)
- ✅ KVKK 6698 m.5 lawful basis documented
- ✅ KVKK 6698 m.11 user rights respected
- ✅ Privacy policy in Turkish

---

## Action Items for Owner Before Submission:

1. ⚠️ **HOST PRIVACY POLICY:** Deploy `legal/privacy_policy_tr.md` to public URL (e.g., lutke.app/privacy)
2. ⚠️ **HOST TERMS OF SERVICE:** Deploy `legal/terms_of_service_tr.md`
3. ⚠️ **UPDATE EMAIL:** Replace `info@lutke.app` placeholder with real contact email
4. ⚠️ **VERIFY URLs IN CODE:** Update `lib/features/legal/legal_screen.dart` with real URLs
5. ⚠️ **OBTAIN DPO IF >100k users (KVKK)**
6. ⚠️ **DESIGNED FOR FAMILIES?** If targeting children primarily, opt into Play Designed for Families program
