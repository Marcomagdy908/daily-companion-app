// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_gift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyGiftImpl _$$DailyGiftImplFromJson(Map<String, dynamic> json) =>
    _$DailyGiftImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      verseReference: json['verseReference'] as String,
      verseText: json['verseText'] as String,
      reflection: json['reflection'] as String,
      blessingReminder: json['blessingReminder'] as String,
      category: json['category'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$DailyGiftImplToJson(_$DailyGiftImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'verseReference': instance.verseReference,
      'verseText': instance.verseText,
      'reflection': instance.reflection,
      'blessingReminder': instance.blessingReminder,
      'category': instance.category,
      'isRead': instance.isRead,
    };
