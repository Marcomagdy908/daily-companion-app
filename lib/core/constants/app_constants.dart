// ─── core/constants/app_constants.dart ──────────────────────────────────
// Daily Companion (رفيق يومي) — Application-wide constants

class AppConstants {
  AppConstants._();

  // ── App Info ────────────────────────────────────────────────────────
  static const String appName = 'رفيق يومي';
  static const String appNameEn = 'Daily Companion';
  static const String appTagline = 'Give and Take — عطاء متبادل';

  // ── Data Collections / Keys ─────────────────────────────────────────
  static const String usersCollection = 'users';
  static const String giftsCollection = 'daily_gifts';
  static const String commitmentsCollection = 'commitments';
  static const String growthCollection = 'growth_states';
  static const String challengesCollection = 'challenges';

  // ── Storage Keys ────────────────────────────────────────────────────
  static const String prefLanguageKey = 'preferred_language';
  static const String prefNotificationTimeKey = 'notification_time';
  static const String prefNotificationsEnabledKey = 'notifications_enabled';
  static const String prefOnboardingCompleteKey = 'onboarding_complete';
  static const String prefGrowthThemeKey = 'growth_theme';

  // ── Growth ──────────────────────────────────────────────────────────
  static const int maxGrowthLevel = 100;
  static const int growthIncrementPerDay = 2;
  static const int maxLeaves = 100;

  // ── Challenge ──────────────────────────────────────────────────────
  static const int challengeTotalDays = 30;

  // ── UI ──────────────────────────────────────────────────────────────
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 16.0;
  static const double cardElevation = 2.0;

  // ── Commitment Presets ──────────────────────────────────────────────
  static const Map<String, List<String>> commitmentPresets = {
    'ar': [
      'أخصص 10 دقائق للصلاة الصامتة اليوم.',
      'أقرأ إصحاحًا من الكتاب المقدس.',
      'أساعد شخصًا محتاجًا اليوم.',
      'أصوم عن وسائل التواصل الاجتماعي اليوم.',
      'أقدم تبرعًا ماليًا.',
      'أغفر لشخص أساء إليَّ.',
      'أشكر الله على 5 نِعَم في حياتي.',
      'أصلي من أجل شخص محدد.',
      'أشارك كلمة تشجيع مع أحدهم.',
      'أخصص وقتًا للتأمل والصمت.',
    ],
    'en': [
      'I dedicate 10 minutes to silent prayer today.',
      'I will read a chapter from the Bible.',
      'I will help someone in need today.',
      'I will fast from social media today.',
      'I will make a financial donation.',
      'I will forgive someone who hurt me.',
      'I will thank God for 5 blessings.',
      'I will pray for a specific person.',
      'I will share a word of encouragement.',
      'I will spend time in meditation and silence.',
    ],
  };
}

/// Commitment type display info
class CommitmentTypeInfo {
  final String labelAr;
  final String labelEn;
  final String iconAsset;
  final String colorHex;

  const CommitmentTypeInfo({
    required this.labelAr,
    required this.labelEn,
    required this.iconAsset,
    required this.colorHex,
  });
}

const Map<String, CommitmentTypeInfo> commitmentTypeInfo = {
  'prayer': CommitmentTypeInfo(
    labelAr: 'صلاة',
    labelEn: 'Prayer',
    iconAsset: '🙏',
    colorHex: '#6C63FF',
  ),
  'donation': CommitmentTypeInfo(
    labelAr: 'تبرع',
    labelEn: 'Donation',
    iconAsset: '💝',
    colorHex: '#FF6B6B',
  ),
  'helpingOthers': CommitmentTypeInfo(
    labelAr: 'مساعدة',
    labelEn: 'Helping Others',
    iconAsset: '🤝',
    colorHex: '#4ECDC4',
  ),
  'fasting': CommitmentTypeInfo(
    labelAr: 'صوم',
    labelEn: 'Fasting',
    iconAsset: '🕊️',
    colorHex: '#45B7D1',
  ),
  'readingBible': CommitmentTypeInfo(
    labelAr: 'قراءة الكتاب',
    labelEn: 'Bible Reading',
    iconAsset: '📖',
    colorHex: '#96CEB4',
  ),
  'gratitude': CommitmentTypeInfo(
    labelAr: 'شكر',
    labelEn: 'Gratitude',
    iconAsset: '✨',
    colorHex: '#FFEAA7',
  ),
  'forgiveness': CommitmentTypeInfo(
    labelAr: 'غفران',
    labelEn: 'Forgiveness',
    iconAsset: '💫',
    colorHex: '#DDA0DD',
  ),
  'custom': CommitmentTypeInfo(
    labelAr: 'مخصص',
    labelEn: 'Custom',
    iconAsset: '✍️',
    colorHex: '#A8E6CF',
  ),
};
