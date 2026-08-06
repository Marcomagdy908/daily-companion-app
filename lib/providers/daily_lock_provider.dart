// ─── providers/daily_lock_provider.dart ────────────────────────────────
// Daily Companion (رفيق يومي) — Core daily lock/unlock state machine
//
// THE CORE LOGIC:
// The user CANNOT unlock the next day's gift without completing today's
// commitment. This provider is the single source of truth for:
//   1. Has today's gift been received?
//   2. Has today's commitment been made?
//   3. Is the day complete?
//   4. Is the user allowed to see tomorrow's gift?
//
// State flow:
//   MORNING → Gift arrives → User reads → Commitment screen opens
//   → User submits commitment → Day is COMPLETE → Growth increments
//   → NEXT DAY: Process repeats. If yesterday incomplete, growth pauses.
// ────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/daily_status.dart';
import '../models/daily_gift.dart';
import '../models/altar_commitment.dart';
import '../models/growth_state.dart';
import '../services/gift_service.dart';
import '../services/commitment_service.dart';
import '../services/growth_service.dart';
import 'auth_provider.dart';

/// Current daily status — reactive state machine
final dailyStatusProvider =
    AsyncNotifierProvider<DailyStatusNotifier, DailyStatus>(
  DailyStatusNotifier.new,
);

class DailyStatusNotifier extends AsyncNotifier<DailyStatus> {
  GiftService get _giftService => GiftService();
  CommitmentService get _commitmentService => CommitmentService();
  GrowthService get _growthService => GrowthService();

  String get _today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Future<DailyStatus> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return DailyStatus(date: _today);
    }

    // Check if today's gift exists
    final gift = await _giftService.fetchTodayGift();
    final hasRead = await _giftService.hasReadTodayGift(user.uid);
    final commitment = await _commitmentService.fetchTodayCommitment(user.uid);

    return DailyStatus(
      date: _today,
      giftReceived: gift != null,
      giftRead: hasRead,
      commitmentMade: commitment != null,
      commitmentFulfilled: commitment?.isFulfilled ?? false,
      dayComplete: commitment != null, // A submitted commitment = day complete
      completedAt: commitment?.submittedAt,
    );
  }

  /// Called when the user reads the gift — triggers commitment screen
  Future<void> markGiftRead() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    
    final current = state.value!;
    if (!current.giftReceived || current.giftRead) return;

    final gift = await _giftService.fetchTodayGift();
    if (gift != null) {
      await _giftService.markGiftAsRead(user.uid, gift.id);
    }

    state = AsyncData(current.copyWith(giftRead: true));
  }

  /// Called when user submits their Altar of the Heart commitment
  Future<void> submitCommitment({
    required String userId,
    required CommitmentType type,
    required String description,
  }) async {
    final commitment = await _commitmentService.submitCommitment(
      userId: userId,
      type: type,
      description: description,
    );

    // Update growth state
    final growth = ref.read(growthStateProvider).valueOrNull;
    final newStreak = (growth?.currentStreak ?? 0) + 1;

    await _growthService.incrementGrowth(
      userId: userId,
      currentStreak: newStreak,
      completedDate: _today,
    );

    // Refresh growth state
    ref.invalidate(growthStateProvider);

    state = AsyncData(
      state.value!.copyWith(
        commitmentMade: true,
        dayComplete: true,
        completedAt: commitment.submittedAt,
      ),
    );
  }

  /// Check if the user is locked out (missed yesterday)
  Future<bool> isLockedOut() async {
    final current = state.value!;
    if (current.dayComplete) return false;
    return false; // Gift is always available; growth pauses instead
  }

  /// Reset for a new day (called on app open / midnight check)
  Future<void> refreshForNewDay() async {
    final newStatus = await build();
    state = AsyncData(newStatus);
  }

  /// MARK: — Convenience getters
  bool get canSeeGift => state.value?.giftReceived == true;
  bool get canMakeCommitment => state.value?.giftRead == true;
  bool get isDayComplete => state.value?.dayComplete == false;
  bool get needsCommitment =>
      state.value?.giftRead == true && !(state.value?.commitmentMade ?? true);
}


// ─── Growth State ──────────────────────────────────────────────────────
final growthStateProvider =
    AsyncNotifierProvider<GrowthStateNotifier, GrowthState>(
  GrowthStateNotifier.new,
);

class GrowthStateNotifier extends AsyncNotifier<GrowthState> {
  GrowthService get _growthService => GrowthService();

  @override
  Future<GrowthState> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return GrowthState.initial(userId: '');
    }
    return _growthService.fetchGrowthState(user.uid);
  }
}

// ─── Today's Gift Provider ─────────────────────────────────────────────
final todayGiftProvider = AsyncNotifierProvider<TodayGiftNotifier, DailyGift?>(
  TodayGiftNotifier.new,
);

class TodayGiftNotifier extends AsyncNotifier<DailyGift?> {
  GiftService get _giftService => GiftService();

  @override
  Future<DailyGift?> build() async {
    return _giftService.fetchTodayGift();
  }
}

// ─── Today's Commitment Provider ───────────────────────────────────────
final todayCommitmentProvider =
    AsyncNotifierProvider<TodayCommitmentNotifier, AltarCommitment?>(
  TodayCommitmentNotifier.new,
);

class TodayCommitmentNotifier extends AsyncNotifier<AltarCommitment?> {
  CommitmentService get _service => CommitmentService();

  @override
  Future<AltarCommitment?> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    return _service.fetchTodayCommitment(user.uid);
  }
}
