// ─── services/gift_service.dart ────────────────────────────────────────
// Daily Companion (رفيق يومي) — Divine Gift service (Firestore)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/daily_gift.dart';
import 'firebase_config.dart';

class GiftService {
  final FirebaseConfig _config = FirebaseConfig();

  /// Fetch the gift of the day by date
  Future<DailyGift?> fetchGiftForDate(String date) async {
    final snapshot = await _config.giftsCollection
        .where('date', isEqualTo: date)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return DailyGift.fromFirestore(snapshot.docs.first);
  }

  /// Fetch today's gift
  Future<DailyGift?> fetchTodayGift() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return fetchGiftForDate(today);
  }

  /// Mark a gift as read by the user
  Future<void> markGiftAsRead(String giftId) async {
    await _config.giftsCollection.doc(giftId).update({'isRead': true});
  }

  /// Stream today's gift (real-time)
  Stream<DailyGift?> watchTodayGift() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return _config.giftsCollection
        .where('date', isEqualTo: today)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      return DailyGift.fromFirestore(snapshot.docs.first);
    });
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
    final gift = DailyGift(
      id: _config.giftsCollection.doc().id,
      date: date,
      verseReference: verseReference,
      verseText: verseText,
      reflection: reflection,
      blessingReminder: blessingReminder,
      category: category,
    );
    await _config.giftsCollection.doc(gift.id).set(gift.toJson());
  }
}
