// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GrowthStateImpl _$$GrowthStateImplFromJson(Map<String, dynamic> json) =>
    _$GrowthStateImpl(
      userId: json['userId'] as String,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      totalCommitmentsCompleted:
          (json['totalCommitmentsCompleted'] as num?)?.toInt() ?? 0,
      growthLevel: (json['growthLevel'] as num?)?.toInt() ?? 0,
      leavesEarned: (json['leavesEarned'] as num?)?.toInt() ?? 0,
      activeTheme:
          $enumDecodeNullable(_$GrowthThemeEnumMap, json['activeTheme']) ??
              GrowthTheme.tree,
      lastCompletedDate: json['lastCompletedDate'] as String?,
      missedDates: (json['missedDates'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      brightnessValue: (json['brightnessValue'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$GrowthStateImplToJson(_$GrowthStateImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalCommitmentsCompleted': instance.totalCommitmentsCompleted,
      'growthLevel': instance.growthLevel,
      'leavesEarned': instance.leavesEarned,
      'activeTheme': _$GrowthThemeEnumMap[instance.activeTheme]!,
      'lastCompletedDate': instance.lastCompletedDate,
      'missedDates': instance.missedDates,
      'brightnessValue': instance.brightnessValue,
    };

const _$GrowthThemeEnumMap = {
  GrowthTheme.tree: 'tree',
  GrowthTheme.light: 'light',
  GrowthTheme.garden: 'garden',
};
