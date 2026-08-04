// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeDayImpl _$$ChallengeDayImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeDayImpl(
      dayNumber: (json['dayNumber'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      topic: json['topic'] as String,
      reflectionPrompt: json['reflectionPrompt'] as String,
      actionItem: json['actionItem'] as String,
      bibleVerse: json['bibleVerse'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      userJournalEntry: json['userJournalEntry'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      isUnlocked: json['isUnlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$ChallengeDayImplToJson(_$ChallengeDayImpl instance) =>
    <String, dynamic>{
      'dayNumber': instance.dayNumber,
      'title': instance.title,
      'description': instance.description,
      'topic': instance.topic,
      'reflectionPrompt': instance.reflectionPrompt,
      'actionItem': instance.actionItem,
      'bibleVerse': instance.bibleVerse,
      'isCompleted': instance.isCompleted,
      'userJournalEntry': instance.userJournalEntry,
      'completedAt': instance.completedAt?.toIso8601String(),
      'isUnlocked': instance.isUnlocked,
    };
