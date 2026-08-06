// ─── services/gift_service.dart ────────────────────────────────────────
// Daily Companion (رفيق يومي) — Divine Gift service (Local Storage)
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/daily_gift.dart';

class GiftService {
  static const String _giftsKey = 'daily_gifts_local';
  static const String _readsKey = 'user_reads_local';

  Future<List<DailyGift>> _fetchAllGifts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_giftsKey);
    if (jsonStr == null || jsonStr.isEmpty) return [];

    try {
      final List<dynamic> rawList = jsonDecode(jsonStr);
      return rawList
          .map((item) => DailyGift.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveGifts(List<DailyGift> gifts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(gifts.map((g) => g.toJson()).toList());
    await prefs.setString(_giftsKey, jsonStr);
  }

  /// Fetch the gift of the day by date
  Future<DailyGift?> fetchGiftForDate(String date) async {
    final gifts = await _fetchAllGifts();
    try {
      return gifts.firstWhere((g) => g.date == date);
    } catch (_) {
      // Generate default gift for date if none exists locally
      final defaultGift = _generateDefaultGift(date);
      gifts.add(defaultGift);
      await _saveGifts(gifts);
      return defaultGift;
    }
  }

  /// Fetch today's gift
  Future<DailyGift?> fetchTodayGift() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return fetchGiftForDate(today);
  }

  /// Mark a gift as read by a specific user
  Future<void> markGiftAsRead(String userId, String giftId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final readId = '${userId}_$today';
    final prefs = await SharedPreferences.getInstance();
    final List<String> reads = prefs.getStringList(_readsKey) ?? [];
    if (!reads.contains(readId)) {
      reads.add(readId);
      await prefs.setStringList(_readsKey, reads);
    }
  }

  /// Check if a user has read today's gift
  Future<bool> hasReadTodayGift(String userId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final readId = '${userId}_$today';
    final prefs = await SharedPreferences.getInstance();
    final List<String> reads = prefs.getStringList(_readsKey) ?? [];
    return reads.contains(readId);
  }

  /// Stream today's gift
  Stream<DailyGift?> watchTodayGift() async* {
    yield await fetchTodayGift();
  }

  /// Seed a gift — admin/seed function
  Future<void> createGift({
    required String date,
    required String verseReference,
    required String verseText,
    required String reflection,
    required String blessingReminder,
    String category = 'guidance',
  }) async {
    final gifts = await _fetchAllGifts();
    final gift = DailyGift(
      id: const Uuid().v4(),
      date: date,
      verseReference: verseReference,
      verseText: verseText,
      reflection: reflection,
      blessingReminder: blessingReminder,
      category: category,
    );
    gifts.removeWhere((g) => g.date == date);
    gifts.add(gift);
    await _saveGifts(gifts);
  }

  /// Built-in fallback gift generator
  DailyGift _generateDefaultGift(String date) {
    return DailyGift(
      id: 'gift_$date',
      date: date,
      verseReference: 'يوحنا 14: 27',
      verseText: 'سَلاَمًا أَتْرُكُ لَكُمْ. سَلاَمِي أُعْطِيكُمْ. لَيْسَ كَمَا يُعْطِي ٱلْعَالَمُ أُعْطِيكُمْ أَنَا.',
      reflection: 'سلام المسيح لا يعتمد على الظروف الخارجية، بل يملأ القلب بالطمأنينة والثقة في محبة الله العجيبة.',
      blessingReminder: 'تذكر اليوم أنك محاط بسلام الله الذي يفوق كل عقل.',
      category: 'peace',
    );
  }
}

