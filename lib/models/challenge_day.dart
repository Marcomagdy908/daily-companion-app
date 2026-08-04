// ─── models/challenge_day.dart ─────────────────────────────────────────
// Daily Companion (رفيق يومي) — 30-Day Challenge day model
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_day.freezed.dart';
part 'challenge_day.g.dart';

@freezed
class ChallengeDay with _$ChallengeDay {
  const factory ChallengeDay({
    required int dayNumber, // 1–30
    required String title,
    required String description,
    required String topic,
    required String reflectionPrompt,
    required String actionItem,
    @Default('') String bibleVerse,
    @Default(false) bool isCompleted,
    String? userJournalEntry,
    DateTime? completedAt,
    @Default(false) bool isUnlocked,
  }) = _ChallengeDay;

  factory ChallengeDay.fromJson(Map<String, dynamic> json) =>
      _$ChallengeDayFromJson(json);
}
