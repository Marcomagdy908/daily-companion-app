// ─── models/daily_gift.dart ────────────────────────────────────────────
// Daily Companion (رفيق يومي) — Divine Gift model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_gift.freezed.dart';
part 'daily_gift.g.dart';

@freezed
class DailyGift with _$DailyGift {
  const factory DailyGift({
    required String id,
    required String date, // ISO date string "2026-08-03"
    required String verseReference,
    required String verseText,
    required String reflection,
    required String blessingReminder,
    @Default('') String category, // e.g. "peace", "health", "guidance"
    @Default(false) bool isRead,
  }) = _DailyGift;

  factory DailyGift.fromJson(Map<String, dynamic> json) =>
      _$DailyGiftFromJson(json);

  factory DailyGift.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return DailyGift.fromJson({...data, 'id': doc.id});
  }
}
