// ─── services/commitment_service.dart ──────────────────────────────────
// Daily Companion (رفيق يومي) — Altar of the Heart commitment service (Local Storage)
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/altar_commitment.dart';

class CommitmentService {
  String _key(String userId) => 'commitments_$userId';

  Future<List<AltarCommitment>> _fetchAll(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key(userId));
    if (jsonStr == null || jsonStr.isEmpty) return [];

    try {
      final List<dynamic> rawList = jsonDecode(jsonStr);
      return rawList
          .map((item) => AltarCommitment.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveAll(String userId, List<AltarCommitment> list) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(list.map((c) => c.toJson()).toList());
    await prefs.setString(_key(userId), jsonStr);
  }

  /// Submit a daily commitment
  Future<AltarCommitment> submitCommitment({
    required String userId,
    required CommitmentType type,
    required String description,
  }) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final now = DateTime.now();

    final commitment = AltarCommitment(
      id: const Uuid().v4(),
      userId: userId,
      date: today,
      type: type,
      description: description,
      submittedAt: now,
    );

    final list = await _fetchAll(userId);
    list.removeWhere((c) => c.date == today); // Replace if existing for today
    list.add(commitment);
    await _saveAll(userId, list);

    return commitment;
  }

  /// Fetch today's commitment for a user
  Future<AltarCommitment?> fetchTodayCommitment(String userId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final list = await _fetchAll(userId);
    try {
      return list.firstWhere((c) => c.date == today);
    } catch (_) {
      return null;
    }
  }

  /// Check if user has made a commitment today
  Future<bool> hasTodayCommitment(String userId) async {
    final commitment = await fetchTodayCommitment(userId);
    return commitment != null;
  }

  /// Mark a commitment as fulfilled
  Future<void> fulfillCommitment(String commitmentId, String userId) async {
    final list = await _fetchAll(userId);
    final index = list.indexWhere((c) => c.id == commitmentId);
    if (index != -1) {
      list[index] = list[index].copyWith(
        isFulfilled: true,
        fulfilledAt: DateTime.now(),
      );
      await _saveAll(userId, list);
    }
  }

  /// Stream today's commitment
  Stream<AltarCommitment?> watchTodayCommitment(String userId) async* {
    yield await fetchTodayCommitment(userId);
  }

  /// Get commitment history for streak calculation
  Future<List<AltarCommitment>> fetchCommitmentHistory(
    String userId, {
    int limit = 60,
  }) async {
    final list = await _fetchAll(userId);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list.take(limit).toList();
  }
}

