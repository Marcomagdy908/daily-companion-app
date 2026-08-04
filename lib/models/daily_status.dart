// ─── models/daily_status.dart ──────────────────────────────────────────
// Daily Companion (رفيق يومي) — Aggregated daily status for locking logic
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_status.freezed.dart';
part 'daily_status.g.dart';

@freezed
class DailyStatus with _$DailyStatus {
  const factory DailyStatus({
    required String date,
    @Default(false) bool giftReceived,
    @Default(false) bool giftRead,
    @Default(false) bool commitmentMade,
    @Default(false) bool commitmentFulfilled,
    @Default(false) bool dayComplete,
    DateTime? completedAt,
  }) = _DailyStatus;

  factory DailyStatus.fromJson(Map<String, dynamic> json) =>
      _$DailyStatusFromJson(json);
}
