// ─── models/user_profile.dart ──────────────────────────────────────────
// Daily Companion (رفيق يومي) — User profile model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    String? displayName,
    String? email,
    @Default('ar') String preferredLanguage,
    @Default('Africa/Cairo') String timezone,
    @Default(false) bool notificationsEnabled,
    @Default('09:00') String notificationTime,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    DateTime? createdAt,
    DateTime? lastActiveAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return UserProfile.fromJson({...data, 'uid': doc.id});
  }
}
