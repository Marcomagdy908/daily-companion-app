#!/bin/bash
# ═════════════════════════════════════════════════════════════════════
# سكريبت بناء APK محلي — رفيق يومي
# ═════════════════════════════════════════════════════════════════════
# استخدم السكريبت ده لبناء APK على جهازك (Linux/macOS)
# التشغيل: bash build_apk.sh
# ═════════════════════════════════════════════════════════════════════

set -e  # وقف عند أي خطأ

# ألوان للطباعة
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  🌿 بناء APK - رفيق يومي (Daily Companion)${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"

# ─── 1. تحقق من Flutter ────────────────────────────────────────────────
echo -e "\n${YELLOW}[1/6] فحص إعدادات Flutter...${NC}"
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter غير مثبّت!${NC}"
    echo -e "نزّله من: https://flutter.dev/docs/get-started/install"
    exit 1
fi

flutter --version
flutter doctor --android-licenses > /dev/null 2>&1 || true

# ─── 2. تنظيف ────────────────────────────────────────────────────────────
echo -e "\n${YELLOW}[2/6] تنظيف البناء السابق...${NC}"
flutter clean

# ─── 3. تنزيل المكتبات ──────────────────────────────────────────────────
echo -e "\n${YELLOW}[3/6] تنزيل المكتبات...${NC}"
flutter pub get

# ─── 4. توليد الكود الآلي ───────────────────────────────────────────────
echo -e "\n${YELLOW}[4/6] توليد الكود الآلي (freezed + riverpod)...${NC}"
dart run build_runner build --delete-conflicting-outputs

# ─── 5. بناء APK ────────────────────────────────────────────────────────
echo -e "\n${YELLOW}[5/6] بناء APK للإنتاج (قد يستغرق 5-15 دقيقة أول مرة)...${NC}"
flutter build apk --release

# APK مقسّم حسب المعمارية (اختياري - أحجام أصغر)
echo -e "\n${YELLOW}[6/6] بناء APK مقسّم حسب المعمارية...${NC}"
flutter build apk --split-per-abi --release

# ─── النتيجة ────────────────────────────────────────────────────────────
APK_DIR="build/app/outputs/flutter-apk"
echo -e "\n${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✅ تم البناء بنجاح!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "\nملفات APK موجودة في: ${BLUE}${APK_DIR}${NC}\n"

ls -lh "$APK_DIR"/*.apk 2>/dev/null | awk '{printf "  📦 %s  (%s)\n", $9, $5}'

echo -e "\n${YELLOW}📱 لتثبيت APK على جهاز موصول عبر USB:${NC}"
echo -e "   flutter install"
echo -e "\n${YELLOW}📤 لإرسال APK للناس:${NC}"
echo -e "   ابعت الملف: ${APK_DIR}/app-release.apk"
echo -e "\n${GREEN}═══════════════════════════════════════════════════════${NC}"
