// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altar_commitment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AltarCommitmentImpl _$$AltarCommitmentImplFromJson(
        Map<String, dynamic> json) =>
    _$AltarCommitmentImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      type: $enumDecode(_$CommitmentTypeEnumMap, json['type']),
      description: json['description'] as String,
      isFulfilled: json['isFulfilled'] as bool? ?? false,
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      fulfilledAt: json['fulfilledAt'] == null
          ? null
          : DateTime.parse(json['fulfilledAt'] as String),
    );

Map<String, dynamic> _$$AltarCommitmentImplToJson(
        _$AltarCommitmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date,
      'type': _$CommitmentTypeEnumMap[instance.type]!,
      'description': instance.description,
      'isFulfilled': instance.isFulfilled,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'fulfilledAt': instance.fulfilledAt?.toIso8601String(),
    };

const _$CommitmentTypeEnumMap = {
  CommitmentType.prayer: 'prayer',
  CommitmentType.donation: 'donation',
  CommitmentType.helpingOthers: 'helpingOthers',
  CommitmentType.fasting: 'fasting',
  CommitmentType.readingBible: 'readingBible',
  CommitmentType.gratitude: 'gratitude',
  CommitmentType.forgiveness: 'forgiveness',
  CommitmentType.custom: 'custom',
};
