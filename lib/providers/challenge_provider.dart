// ─── providers/challenge_provider.dart ──────────────────────────────────
// Daily Companion (رفيق يومي) — 30-Day Challenge state management
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/challenge_day.dart';
import '../services/challenge_service.dart';
import 'auth_provider.dart';

/// All challenge days
final challengeDaysProvider =
    AsyncNotifierProvider<ChallengeDaysNotifier, List<ChallengeDay>>(
  ChallengeDaysNotifier.new,
);

class ChallengeDaysNotifier extends AsyncNotifier<List<ChallengeDay>> {
  ChallengeService get _service => ChallengeService();

  @override
  Future<List<ChallengeDay>> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];
    return _service.fetchChallengeDays(user.uid);
  }

  /// Complete a challenge day with a journal entry
  Future<void> completeDay({
    required int dayNumber,
    String? journalEntry,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    await _service.completeDay(
      userId: user.uid,
      dayNumber: dayNumber,
      journalEntry: journalEntry,
    );

    // Refresh the list
    final updated = await _service.fetchChallengeDays(user.uid);
    state = AsyncData(updated);
  }

  /// Get a specific day
  ChallengeDay? getDay(int dayNumber) {
    final days = state.valueOrNull ?? [];
    if (dayNumber < 1 || dayNumber > days.length) return null;
    return days[dayNumber - 1];
  }

  /// Whether a specific day is unlocked
  bool isDayUnlocked(int dayNumber) {
    return getDay(dayNumber)?.isUnlocked ?? false;
  }

  /// Whether a specific day is completed
  bool isDayCompleted(int dayNumber) {
    return getDay(dayNumber)?.isCompleted ?? false;
  }
}

/// Challenge progress percentage (0.0–1.0)
final challengeProgressProvider = Provider<double>((ref) {
  final days = ref.watch(challengeDaysProvider).valueOrNull ?? [];
  if (days.isEmpty) return 0.0;
  final completed = days.where((d) => d.isCompleted).length;
  return completed / days.length;
});

/// Number of completed days
final challengeCompletedCountProvider = Provider<int>((ref) {
  final days = ref.watch(challengeDaysProvider).valueOrNull ?? [];
  return days.where((d) => d.isCompleted).length;
});
