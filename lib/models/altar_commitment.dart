// ─── models/altar_commitment.dart ──────────────────────────────────────
// Daily Companion (رفيق يومي) — Altar of the Heart commitment model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'altar_commitment.freezed.dart';
part 'altar_commitment.g.dart';

enum CommitmentType {
  prayer,
  donation,
  helpingOthers,
  fasting,
  readingBible,
  gratitude,
  forgiveness,
  custom,
}

@freezed
class AltarCommitment with _$AltarCommitment {
  const factory AltarCommitment({
    required String id,
    required String userId,
    required String date, // ISO date string
    required CommitmentType type,
    required String description,
    @Default(false) bool isFulfilled,
    DateTime? submittedAt,
    DateTime? fulfilledAt,
  }) = _AltarCommitment;

  factory AltarCommitment.fromJson(Map<String, dynamic> json) =>
      _$AltarCommitmentFromJson(json);

  factory AltarCommitment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return AltarCommitment.fromJson({...data, 'id': doc.id});
  }
}
