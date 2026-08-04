// ─── services/growth_service.dart ──────────────────────────────────────
// Daily Companion (رفيق يومي) — Growth state service (tree / light)
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/growth_state.dart';
import 'firebase_config.dart';

class GrowthService {
  final FirebaseConfig _config = FirebaseConfig();

  /// Fetch or create the growth state for a user
  Future<GrowthState> fetchGrowthState(String userId) async {
    final doc = await _config.growthCollection.doc(userId).get();

    if (!doc.exists || doc.data() == null) {
      // Create initial state
      final initialState = GrowthState.initial(userId: userId);
      await _config.growthCollection.doc(userId).set(initialState.toJson());
      return initialState;
    }

    return GrowthState.fromJson({...doc.data()!, 'userId': userId});
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

    await _config.growthCollection.doc(userId).set(updated.toJson());
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

    await _config.growthCollection.doc(userId).set(updated.toJson());
    return updated;
  }

  /// Watch growth state in real-time
  Stream<GrowthState> watchGrowthState(String userId) {
    return _config.growthCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return GrowthState.initial(userId: userId);
      }
      return GrowthState.fromJson({...doc.data()!, 'userId': userId});
    });
  }

  /// Leaves earned = 1 + bonus for milestone streaks
  int _leavesPerStreak(int streak) {
    if (streak >= 30) return 5;
    if (streak >= 14) return 3;
    if (streak >= 7) return 2;
    return 1;
  }
}
