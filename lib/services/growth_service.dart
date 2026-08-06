// ─── services/growth_service.dart ──────────────────────────────────────
// Daily Companion (رفيق يومي) — Growth state service (tree / light) (Local Storage)
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/growth_state.dart';

class GrowthService {
  String _key(String userId) => 'growth_state_$userId';

  /// Fetch or create the growth state for a user
  Future<GrowthState> fetchGrowthState(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key(userId));

    if (jsonStr == null || jsonStr.isEmpty) {
      final initialState = GrowthState.initial(userId: userId);
      await saveGrowthState(initialState);
      return initialState;
    }

    try {
      final Map<String, dynamic> map = jsonDecode(jsonStr);
      return GrowthState.fromJson({...map, 'userId': userId});
    } catch (_) {
      final initialState = GrowthState.initial(userId: userId);
      await saveGrowthState(initialState);
      return initialState;
    }
  }

  Future<void> saveGrowthState(GrowthState state) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(state.toJson());
    await prefs.setString(_key(state.userId), jsonStr);
  }

  /// Update growth state after successful commitment
  Future<GrowthState> incrementGrowth({
    required String userId,
    required int currentStreak,
    required String completedDate,
  }) async {
    final current = await fetchGrowthState(userId);

    final newLeaves = current.leavesEarned + _leavesPerStreak(currentStreak);
    final newLevel = (current.growthLevel + 2).clamp(0, 100);
    final newBrightness = (current.brightnessValue + 0.02).clamp(0.0, 1.0);
    final newLongestStreak =
        currentStreak > current.longestStreak ? currentStreak : current.longestStreak;

    final updated = current.copyWith(
      currentStreak: currentStreak,
      longestStreak: newLongestStreak,
      totalCommitmentsCompleted: current.totalCommitmentsCompleted + 1,
      growthLevel: newLevel,
      leavesEarned: newLeaves,
      lastCompletedDate: completedDate,
      brightnessValue: newBrightness,
    );

    await saveGrowthState(updated);
    return updated;
  }

  /// Handle missed days — pause growth
  Future<GrowthState> handleMissedDay({
    required String userId,
    required String missedDate,
  }) async {
    final current = await fetchGrowthState(userId);
    final missedDates = [...current.missedDates, missedDate];

    final updated = current.copyWith(
      currentStreak: 0,
      missedDates: missedDates,
      // Slight decay on missed day
      brightnessValue: (current.brightnessValue - 0.01).clamp(0.0, 1.0),
    );

    await saveGrowthState(updated);
    return updated;
  }

  /// Watch growth state
  Stream<GrowthState> watchGrowthState(String userId) async* {
    yield await fetchGrowthState(userId);
  }

  /// Leaves earned = 1 + bonus for milestone streaks
  int _leavesPerStreak(int streak) {
    if (streak >= 30) return 5;
    if (streak >= 14) return 3;
    if (streak >= 7) return 2;
    return 1;
  }
}

