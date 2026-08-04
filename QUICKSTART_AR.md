# 🚀 البدء السريع — من كود لـ APK في ٥ خطوات

هدفنا: تحصل على ملف APK جاهز يتثبت على أي أندرويد، وتبعته لأصحابك.

## ⚡ الطريقة الأسرع (Codemagic — 15 دقيقة)

### الخطوة ١: افتح حسابات مجانية
- **GitHub**: https://github.com/signup (لتخزين الكود)
- **Codemagic**: https://codemagic.io/signup (لبناء APK)

### الخطوة ٢: ارفع الكود على GitHub

**من مساحة العمل، حمّل كل ملفات مجلد `/daily-companion/`** ثم:

```bash
# على جهازك
cd daily-companion
git init
git add .
git commit -m "Initial commit — Daily Companion رفيق يومي"

# اعمل repo فارغ على GitHub باسم daily-companion، ثم:
git remote add origin https://github.com/USERNAME/daily-companion.git
git branch -M main
git push -u origin main
```

### الخطوة ٣: اربط Codemagic بـ GitHub
1. ادخل على codemagic.io
2. اضغط **Add application → GitHub**
3. اختار الـ repo بتاعك `daily-companion`
4. Codemagic هيقرأ ملف `codemagic.yaml` الموجود فعلاً

### الخطوة ٤: اضغط Start Build
- استنى 10-15 دقيقة
- هتلاقي إيميل فيه اللينك

### الخطوة ٥: نزّل الـ APK وابعته
- حمّل `app-release.apk`
- ابعته على واتساب / تليجرام / إيميل
- المستقبل يفتح الملف على تليفونه (بعد ما يفعّل Unknown Sources)

---

## 📦 محتويات المجلد جاهزة كلها

كل ملفات البناء موجودة فعلاً في `/daily-companion/`:

| الملف | الغرض |
|-------|-------|
| `codemagic.yaml` | إعدادات Codemagic — جاهز |
| `.github/workflows/build-apk.yml` | إعدادات GitHub Actions — جاهز |
| `build_apk.sh` | سكريبت لينكس/ماك — جاهز |
| `build_apk.bat` | سكريبت ويندوز — جاهز |
| `BUILD_APK.md` | الدليل الكامل بالتفاصيل |

---

## ⚠️ مهم جدًا قبل النشر النهائي

### ١. اربط Firebase حقيقي
البرنامج معتمد على Firebase (لحفظ البيانات، الآيات، تسجيل الدخول). لازم:

```bash
# على جهازك
dart pub global activate flutterfire_cli
cd daily-companion
flutterfire configure
```

هيولّد `lib/firebase_options.dart` بمفاتيح مشروعك.

### ٢. أعدّ Firebase Console
- ادخل على https://console.firebase.google.com
- اعمل مشروع جديد باسم "Daily Companion"
- فعّل: **Authentication**, **Firestore Database**, **Cloud Messaging**
- انشر قواعد الأمان: `firebase deploy --only firestore:rules`

### ٣. أنشئ Keystore للتوقيع (مهم للنشر)
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**احفظ الكلمة السرية في مكان آمن** — لو ضاعت مش هتقدر تحدّث التطبيق!

### ٤. غيّر الأيقونة
- استبدل الملفات في: `android/app/src/main/res/mipmap-*/ic_launcher.png`
- الأحجام: 48px, 72px, 96px, 144px, 192px

استعن بـ https://icon.kitchen لتوليد كل الأحجام تلقائيًا.

---

## 📱 كيف يثبّت المستخدم APK

اشرحله الخطوات دي:
1. **حمّل الملف** على التليفون
2. **الإعدادات → الأمان → مصادر غير معروفة (Unknown Sources)** — فعّلها
3. **افتح الملف** من مدير الملفات
4. **اضغط "تثبيت"**
5. **افتح التطبيق** وابدأ الرحلة الروحية 🌿

---

## 🎁 نصيحة إضافية

لو عايز **صفحة تحميل احترافية** بلينك واحد للناس:
- استخدم **GitHub Releases** — مجاني تمامًا
- كل إصدار له صفحة خاصة بشكل احترافي
- مثال: `https://github.com/USERNAME/daily-companion/releases/latest`

هتلاقي زر أخضر كبير "Download APK" على الصفحة.

---

## 🆘 لو حصل مشكلة

### "Build failed" على Codemagic
- افتح الـ Log
- الغالب: مشكلة في `firebase_options.dart` (المفاتيح ناقصة)
- الحل: نفّذ `flutterfire configure` قبل رفع الكود

### "App not installed" على التليفون
- المستخدم لازم يفعّل Unknown Sources
- تأكد إن نسخة الأندرويد >= 6.0

### "APK signature verification failed"
- اتأكد إن الـ Keystore صحيح
- شغّل `flutter build apk --release` مش `--debug`

---

**بالتوفيق! 🌟 أي سؤال، اسأل زارو مباشرة.**
