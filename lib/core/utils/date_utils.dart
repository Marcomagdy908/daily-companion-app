// ─── core/utils/date_utils.dart ────────────────────────────────────────
// Daily Companion (رفيق يومي) — Date helper utilities
import 'package:intl/intl.dart';

class DateHelpers {
  DateHelpers._();

  /// Today as ISO date string
  static String get today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  /// Format a date string for display in Arabic
  static String formatDateAr(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return isoDate;
    return DateFormat('dd MMMM yyyy', 'ar').format(date);
  }

  /// Format a date string for display in English
  static String formatDateEn(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return isoDate;
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// Get day name in Arabic
  static String dayNameAr(DateTime date) {
    return DateFormat('EEEE', 'ar').format(date);
  }

  /// Check if two dates are the same day
  static bool isSameDay(String date1, String date2) {
    return date1 == date2;
  }

  /// Is the given date today?
  static bool isToday(String isoDate) {
    return isoDate == today;
  }

  /// Days between two dates
  static int daysBetween(String from, String to) {
    final d1 = DateTime.tryParse(from);
    final d2 = DateTime.tryParse(to);
    if (d1 == null || d2 == null) return 0;
    return d2.difference(d1).inDays;
  }

  /// Yesterday as ISO date string
  static String get yesterday {
    return DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 1)));
  }
}
