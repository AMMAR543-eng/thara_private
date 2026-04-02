# 🚀 Thara App

A fintech Flutter application for managing investments, subscriptions, and financial operations with high security and performance.

---

# 📱 Features

* 🔐 Secure Authentication (OTP / Biometrics)
* 💰 Investment & Subscription Management
* 📊 Financial Statistics & Profit Charts
* 🏦 Wallet & Transactions
* 🔔 Notifications
* 🌍 Multi-language (Arabic / English)
* 🔐 AES Encryption + SSL Pinning

---

# 🏗️ Project Structure

lib/
│
├── binding/                # Dependency injection (GetX bindings)
├── data/                   # Models, APIs, repositories
├── domain/                 # Entities + UseCases (Business logic)
├── global/                 # Constants, themes, config, env
├── index/                  # Central exports
├── presentation/
│   ├── design_systems/     # Reusable UI components
│   ├── parentControllers/  # Base controllers
│   └── screens/
│       ├── authentication/
│       ├── dashboard/
│       ├── investment_wizard/
│       ├── opportunity_details/
│       ├── process/
│       ├── wallet/
│       ├── statistics/
│       ├── settings/
│       └── mainpage/

---

# 🧠 Architecture

The app follows Clean Architecture + GetX

Layers:

* Presentation → UI + Controllers
* Domain → Business logic (UseCases)
* Data → API, Models, Repositories

---

# 🛠️ Tech Stack

Core:

* Flutter (>= 3.3)
* GetX
* Dio
* Dartz

Firebase:

* Firebase Analytics
* Firebase Crashlytics

Security:

* AES Encryption
* SSL Pinning
* flutter_secure_storage
* biometric auth

UI:

* flutter_screenutil
* shimmer
* lottie
* syncfusion charts

---

# ⚙️ Setup Instructions

## 1. Clone project

git clone <repo-url>
cd thara

## 2. Install dependencies

flutter pub get

## 3. Environment Configuration 🔐

IMPORTANT: Secrets are NOT stored in code

Run with:

flutter run
--dart-define=KEY_ENCRYPTION=your_key
--dart-define=IV_ENCRYPTION=your_iv

## 4. Run App

DEV:
flutter run

PROD:
flutter run
--dart-define=KEY_ENCRYPTION=prod_key
--dart-define=IV_ENCRYPTION=prod_iv

---

# 📦 Build

Android:
flutter build apk
--dart-define=KEY_ENCRYPTION=prod_key
--dart-define=IV_ENCRYPTION=prod_iv

iOS:
flutter build ios
--dart-define=KEY_ENCRYPTION=prod_key
--dart-define=IV_ENCRYPTION=prod_iv

---

# 🔥 Firebase Setup

Android:
ضع الملف:
android/app/google-services.json

iOS:
ضع الملف:
ios/Runner/GoogleService-Info.plist

---

# 📊 Analytics Example

FirebaseAnalytics.instance.logEvent(
name: "investment_created",
parameters: {
"amount": 1000,
},
);

---

# 💥 Crashlytics

* Captures:

    * Flutter errors
    * Native crashes
    * Runtime exceptions

Test crash:

FirebaseCrashlytics.instance.crash();

NOTE: يعمل فقط في release mode

---

# 🧪 Testing

flutter test

---

# 🧑‍💻 Contribution Guidelines

1. Create branch:
   git checkout -b feature/feature-name

2. Naming conventions:

* files → snake_case
* classes → PascalCase
* variables → camelCase

3. Before commit:
   flutter format .

---

# 🚨 Security Rules

❌ Do NOT hardcode keys
❌ Do NOT commit:

* keystore.jks
* key.properties
* secrets

✅ Use dart-define for sensitive data

---

# 📌 Important Notes

* Project uses environment-based config
* Keys must be rotated if exposed
* Git history should be cleaned if secrets leaked

---

# 📈 Future Improvements

* [ ] Unit Tests
* [ ] Integration Tests
* [ ] CI/CD Pipeline
* [ ] Feature Flags

---

# 👨‍💻 Maintainers

Thara Team

---

# 📄 License

Private – Confidential
