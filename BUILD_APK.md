# 📱 دليل بناء ونشر APK — رفيق يومي

## 🎯 الهدف
تحوّل البرنامج لملف `.apk` يتثبت على أي جهاز أندرويد، وتبعته للناس عبر واتساب / تليجرام / رابط تحميل.

---

## 🥇 الطريقة الأولى: Codemagic (الأسهل — سحابة، بدون تثبيت أي حاجة)

### الخطوات:
1. **افتح حساب على GitHub** (لو معندكش) — https://github.com/signup
2. **ارفع الكود** على GitHub:
   - اعمل repo جديد باسم `daily-companion`
   - ارفع كل الملفات من مجلد `/daily-companion/` في مساحة العمل
3. **اشترك في Codemagic** — https://codemagic.io/signup (فيه خطة مجانية: 500 دقيقة/شهر)
4. **اربط GitHub** — Codemagic سيقرأ الـ repo تلقائيًا
5. **اضغط Start Build** — هيبنيلك APK في ~10 دقائق
6. **حمّل الـ APK** من صفحة النتيجة، وابعت اللينك لأي حد

### مميزات:
- ✅ مجاني (500 دقيقة شهريًا كافية جدًا)
- ✅ بدون تثبيت Flutter على جهازك
- ✅ ملف `codemagic.yaml` جاهز في المشروع (تحت 👇)

---

## 🥈 الطريقة الثانية: GitHub Actions (تلقائي — كل push جديد = APK جديد)

1. ارفع المشروع على GitHub
2. الملف `.github/workflows/build-apk.yml` جاهز في المشروع
3. كل مرة تعمل push، الـ APK هيتبني تلقائيًا
4. تنزّل الـ APK من صفحة **Actions → Latest workflow → Artifacts**

### مميزات:
- ✅ مجاني تمامًا (2000 دقيقة/شهر مجانية على GitHub Free)
- ✅ تلقائي بدون تدخل
- ✅ تاريخ لكل الإصدارات

---

## 🥉 الطريقة الثالثة: على جهازك مباشرة (Flutter محليًا)

### المتطلبات (مرة واحدة فقط):
```bash
# 1. تثبيت Flutter
# Windows: https://docs.flutter.dev/get-started/install/windows
# macOS:   https://docs.flutter.dev/get-started/install/macos
# Linux:   https://docs.flutter.dev/get-started/install/linux

# 2. تثبيت Android Studio
# https://developer.android.com/studio

# 3. اتأكد إن كل حاجة تمام
flutter doctor
```

### أوامر البناء (بعد كل تعديل):
```bash
cd daily-companion

# نزّل المكتبات
flutter pub get

# ولّد الكود الآلي (freezed + riverpod)
dart run build_runner build --delete-conflicting-outputs

# ابنِ APK للإنتاج
flutter build apk --release

# الـ APK هيكون هنا:
# build/app/outputs/flutter-apk/app-release.apk
```

### لتقليل حجم الملف (APK منفصل لكل معمارية):
```bash
flutter build apk --split-per-abi --release
# 3 ملفات أصغر لأجهزة مختلفة
```

---

## 📤 نشر الـ APK للناس

### الطريقة 1: مباشرة (واتساب / تليجرام / إيميل)
- ارفع الملف مباشرة، والمستقبل يفتحه على تليفونه
- **مهم:** المستخدم لازم يفعّل "Install from Unknown Sources" في الإعدادات

### الطريقة 2: رابط تحميل ثابت
- ارفع على Google Drive / MediaFire / GitHub Releases
- ابعت اللينك، الناس تحمّل مباشرة

### الطريقة 3: Google Play Store (احترافية)
- محتاج حساب مطور — **رسوم واحدة $25 مدى الحياة**
- المستخدم يحمّل من Play Store مباشرة (بدون تفعيل Unknown Sources)
- التفاصيل: https://play.google.com/console

### الطريقة 4: صفحة تحميل جميلة
- استخدم **AppMirror** أو **APKMirror** لصفحة تحميل احترافية

---

## ⚠️ خطوات إضافية قبل البناء (مهمة!)

قبل ما تبني APK حقيقي للناس، لازم تعمل:

### 1. اربط Firebase الحقيقي
```bash
# ثبّت FlutterFire CLI
dart pub global activate flutterfire_cli

# اربط بمشروع Firebase بتاعك
flutterfire configure
```
ده هيولّد ملف `firebase_options.dart` بمفاتيح مشروعك الحقيقي.

### 2. اعمل توقيع للـ APK (Signing)
```bash
# ولّد keystore
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# ضيف الملف android/key.properties:
```
```properties
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

### 3. غيّر الأيقونة واسم التطبيق
- `android/app/src/main/res/mipmap-*/ic_launcher.png` — الأيقونة
- `android/app/src/main/AndroidManifest.xml` — اسم التطبيق:
  ```xml
  <application android:label="رفيق يومي">
  ```

---

## 📊 مقارنة سريعة

| الطريقة | التكلفة | الصعوبة | الوقت |
|---------|---------|---------|-------|
| Codemagic | مجاني (500 min/شهر) | سهلة ⭐ | 15 دقيقة |
| GitHub Actions | مجاني تمامًا | متوسطة ⭐⭐ | 20 دقيقة |
| محلي | مجاني | صعبة ⭐⭐⭐ | ساعة إعداد |
| Google Play | $25 مرة واحدة | متوسطة ⭐⭐ | يوم للمراجعة |

---

## 🎁 نصيحة للانطلاق السريع

**ابدأ بـ Codemagic** — أسهل طريقة تحصل بيها على APK حقيقي في أقل من 20 دقيقة، بدون ما تلمس Flutter أو Android Studio على جهازك.
