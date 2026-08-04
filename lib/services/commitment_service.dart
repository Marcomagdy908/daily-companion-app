// ─── services/commitment_service.dart ──────────────────────────────────
// Daily Companion (رفيق يومي) — Altar of the Heart commitment service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/altar_commitment.dart';
import 'firebase_config.dart';

class CommitmentService {
  final FirebaseConfig _config = FirebaseConfig();

  /// Submit a daily commitment
  Future<AltarCommitment> submitCommitment({
    required String userId,
    required CommitmentType type,
    required String description,
  }) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final now = DateTime.now();

    final commitment = AltarCommitment(
      id: _config.commitmentsCollection.doc().id,
      userId: userId,
      date: today,
      type: type,
      description: description,
      submittedAt: now,
    );

    await _config.commitmentsCollection.doc(commitment.id).set(
      commitment.toJson(),
    );
    return commitment;
  }

  /// Fetch today's commitment for a user
  Future<AltarCommitment?> fetchTodayCommitment(String userId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final snapshot = await _config.commitmentsCollection
        .where('userId', isEqualTo: userId)
        .where('date', isEqualTo: today)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return AltarCommitment.fromFirestore(snapshot.docs.first);
  }

  /// Check if user has made a commitment today
  Future<bool> hasTodayCommitment(String userId) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final snapshot = await _config.commitmentsCollection
        .where('userId', isEqualTo: userId)
        .where('date', isEqualTo: today)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  /// Mark a commitment as fulfilled
  Future<void> fulfillCommitment(String commitmentId) async {
    await _config.commitmentsCollection
        .doc(commitmentId)
        .update({'isFulfilled': true, 'fulfilledAt': DateTime.now().toIso8601String()});
  }

  /// Stream today's commitment
  Stream<AltarCommitment?> watchTodayCommitment(String userId) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return _config.commitmentsCollection
        .where('userId', isEqualTo: userId)
        .where('date', isEqualTo: today)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      return AltarCommitment.fromFirestore(snapshot.docs.first);
    });
  }

  /// Get commitment history for streak calculation
  Future<List<AltarCommitment>> fetchCommitmentHistory(
    String userId, {
    int limit = 60,
  }) async {
    final snapshot = await _config.commitmentsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => AltarCommitment.fromFirestore(doc))
        .toList();
  }
}
