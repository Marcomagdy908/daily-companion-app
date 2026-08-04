// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyStatusImpl _$$DailyStatusImplFromJson(Map<String, dynamic> json) =>
    _$DailyStatusImpl(
      date: json['date'] as String,
      giftReceived: json['giftReceived'] as bool? ?? false,
      giftRead: json['giftRead'] as bool? ?? false,
      commitmentMade: json['commitmentMade'] as bool? ?? false,
      commitmentFulfilled: json['commitmentFulfilled'] as bool? ?? false,
      dayComplete: json['dayComplete'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$DailyStatusImplToJson(_$DailyStatusImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'giftReceived': instance.giftReceived,
      'giftRead': instance.giftRead,
      'commitmentMade': instance.commitmentMade,
      'commitmentFulfilled': instance.commitmentFulfilled,
      'dayComplete': instance.dayComplete,
      'completedAt': instance.completedAt?.toIso8601String(),
    };
