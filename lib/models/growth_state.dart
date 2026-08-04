// ─── models/growth_state.dart ──────────────────────────────────────────
// Daily Companion (رفيق يومي) — Growth tree / light visual state model
import 'package:freezed_annotation/freezed_annotation.dart';

part 'growth_state.freezed.dart';
part 'growth_state.g.dart';

enum GrowthTheme { tree, light, garden }

@freezed
class GrowthState with _$GrowthState {
  const factory GrowthState({
    required String userId,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @Default(0) int totalCommitmentsCompleted,
    @Default(0) int growthLevel, // 0–100 scale
    @Default(0) int leavesEarned, // visual: leaves on the tree
    @Default(GrowthTheme.tree) GrowthTheme activeTheme,
    String? lastCompletedDate,
    @Default([]) List<String> missedDates,
    @Default(0.0) double brightnessValue, // for the light theme (0.0–1.0)
  }) = _GrowthState;

  factory GrowthState.fromJson(Map<String, dynamic> json) =>
      _$GrowthStateFromJson(json);

  /// Derive growth level from streak (each day = +2, capped at 100)
  factory GrowthState.initial({
    required String userId,
    GrowthTheme theme = GrowthTheme.tree,
  }) {
    return GrowthState(userId: userId, activeTheme: theme);
  }
}
