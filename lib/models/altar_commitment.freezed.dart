// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'altar_commitment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AltarCommitment _$AltarCommitmentFromJson(Map<String, dynamic> json) {
  return _AltarCommitment.fromJson(json);
}

/// @nodoc
mixin _$AltarCommitment {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // ISO date string
  CommitmentType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isFulfilled => throw _privateConstructorUsedError;
  DateTime? get submittedAt => throw _privateConstructorUsedError;
  DateTime? get fulfilledAt => throw _privateConstructorUsedError;

  /// Serializes this AltarCommitment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AltarCommitment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AltarCommitmentCopyWith<AltarCommitment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AltarCommitmentCopyWith<$Res> {
  factory $AltarCommitmentCopyWith(
          AltarCommitment value, $Res Function(AltarCommitment) then) =
      _$AltarCommitmentCopyWithImpl<$Res, AltarCommitment>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String date,
      CommitmentType type,
      String description,
      bool isFulfilled,
      DateTime? submittedAt,
      DateTime? fulfilledAt});
}

/// @nodoc
class _$AltarCommitmentCopyWithImpl<$Res, $Val extends AltarCommitment>
    implements $AltarCommitmentCopyWith<$Res> {
  _$AltarCommitmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AltarCommitment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? type = null,
    Object? description = null,
    Object? isFulfilled = null,
    Object? submittedAt = freezed,
    Object? fulfilledAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommitmentType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isFulfilled: null == isFulfilled
          ? _value.isFulfilled
          : isFulfilled // ignore: cast_nullable_to_non_nullable
              as bool,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fulfilledAt: freezed == fulfilledAt
          ? _value.fulfilledAt
          : fulfilledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AltarCommitmentImplCopyWith<$Res>
    implements $AltarCommitmentCopyWith<$Res> {
  factory _$$AltarCommitmentImplCopyWith(_$AltarCommitmentImpl value,
          $Res Function(_$AltarCommitmentImpl) then) =
      __$$AltarCommitmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String date,
      CommitmentType type,
      String description,
      bool isFulfilled,
      DateTime? submittedAt,
      DateTime? fulfilledAt});
}

/// @nodoc
class __$$AltarCommitmentImplCopyWithImpl<$Res>
    extends _$AltarCommitmentCopyWithImpl<$Res, _$AltarCommitmentImpl>
    implements _$$AltarCommitmentImplCopyWith<$Res> {
  __$$AltarCommitmentImplCopyWithImpl(
      _$AltarCommitmentImpl _value, $Res Function(_$AltarCommitmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AltarCommitment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? type = null,
    Object? description = null,
    Object? isFulfilled = null,
    Object? submittedAt = freezed,
    Object? fulfilledAt = freezed,
  }) {
    return _then(_$AltarCommitmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommitmentType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isFulfilled: null == isFulfilled
          ? _value.isFulfilled
          : isFulfilled // ignore: cast_nullable_to_non_nullable
              as bool,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fulfilledAt: freezed == fulfilledAt
          ? _value.fulfilledAt
          : fulfilledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AltarCommitmentImpl implements _AltarCommitment {
  const _$AltarCommitmentImpl(
      {required this.id,
      required this.userId,
      required this.date,
      required this.type,
      required this.description,
      this.isFulfilled = false,
      this.submittedAt,
      this.fulfilledAt});

  factory _$AltarCommitmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AltarCommitmentImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String date;
// ISO date string
  @override
  final CommitmentType type;
  @override
  final String description;
  @override
  @JsonKey()
  final bool isFulfilled;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? fulfilledAt;

  @override
  String toString() {
    return 'AltarCommitment(id: $id, userId: $userId, date: $date, type: $type, description: $description, isFulfilled: $isFulfilled, submittedAt: $submittedAt, fulfilledAt: $fulfilledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AltarCommitmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isFulfilled, isFulfilled) ||
                other.isFulfilled == isFulfilled) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.fulfilledAt, fulfilledAt) ||
                other.fulfilledAt == fulfilledAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, date, type,
      description, isFulfilled, submittedAt, fulfilledAt);

  /// Create a copy of AltarCommitment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AltarCommitmentImplCopyWith<_$AltarCommitmentImpl> get copyWith =>
      __$$AltarCommitmentImplCopyWithImpl<_$AltarCommitmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AltarCommitmentImplToJson(
      this,
    );
  }
}

abstract class _AltarCommitment implements AltarCommitment {
  const factory _AltarCommitment(
      {required final String id,
      required final String userId,
      required final String date,
      required final CommitmentType type,
      required final String description,
      final bool isFulfilled,
      final DateTime? submittedAt,
      final DateTime? fulfilledAt}) = _$AltarCommitmentImpl;

  factory _AltarCommitment.fromJson(Map<String, dynamic> json) =
      _$AltarCommitmentImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get date; // ISO date string
  @override
  CommitmentType get type;
  @override
  String get description;
  @override
  bool get isFulfilled;
  @override
  DateTime? get submittedAt;
  @override
  DateTime? get fulfilledAt;

  /// Create a copy of AltarCommitment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AltarCommitmentImplCopyWith<_$AltarCommitmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
