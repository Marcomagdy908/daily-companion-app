// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'ar',
      timezone: json['timezone'] as String? ?? 'Africa/Cairo',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? false,
      notificationTime: json['notificationTime'] as String? ?? '09:00',
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'preferredLanguage': instance.preferredLanguage,
      'timezone': instance.timezone,
      'notificationsEnabled': instance.notificationsEnabled,
      'notificationTime': instance.notificationTime,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
    };
