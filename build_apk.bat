@echo off
REM ═════════════════════════════════════════════════════════════════════
REM سكريبت بناء APK محلي - رفيق يومي (لأنظمة Windows)
REM ═════════════════════════════════════════════════════════════════════
REM التشغيل: انقر مرتين على الملف أو نفذه من CMD
REM ═════════════════════════════════════════════════════════════════════

chcp 65001 > nul
setlocal

echo ═══════════════════════════════════════════════════════
echo   🌿 بناء APK - رفيق يومي (Daily Companion)
echo ═══════════════════════════════════════════════════════

REM ─── 1. تحقق من Flutter ─────────────────────────────────────────
echo.
echo [1/6] فحص إعدادات Flutter...
where flutter >nul 2>&1
if errorlevel 1 (
    echo ❌ Flutter غير مثبّت!
    echo نزّله من: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

flutter --version

REM ─── 2. تنظيف ───────────────────────────────────────────────────
echo.
echo [2/6] تنظيف البناء السابق...
call flutter clean

REM ─── 3. تنزيل المكتبات ────────────────────────────────────────
echo.
echo [3/6] تنزيل المكتبات...
call flutter pub get

REM ─── 4. توليد الكود الآلي ────────────────────────────────────
echo.
echo [4/6] توليد الكود الآلي (freezed + riverpod)...
call dart run build_runner build --delete-conflicting-outputs

REM ─── 5. بناء APK ─────────────────────────────────────────────
echo.
echo [5/6] بناء APK للإنتاج (قد يستغرق 5-15 دقيقة أول مرة)...
call flutter build apk --release

echo.
echo [6/6] بناء APK مقسّم حسب المعمارية...
call flutter build apk --split-per-abi --release

REM ─── النتيجة ─────────────────────────────────────────────────
echo.
echo ═══════════════════════════════════════════════════════
echo   ✅ تم البناء بنجاح!
echo ═══════════════════════════════════════════════════════
echo.
echo ملفات APK موجودة في: build\app\outputs\flutter-apk\
echo.
dir build\app\outputs\flutter-apk\*.apk

echo.
echo 📱 لتثبيت APK على جهاز موصول عبر USB:
echo    flutter install
echo.
echo 📤 لإرسال APK للناس:
echo    ابعت الملف: build\app\outputs\flutter-apk\app-release.apk
echo.

pause
