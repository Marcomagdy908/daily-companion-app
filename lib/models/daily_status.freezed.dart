// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyStatus _$DailyStatusFromJson(Map<String, dynamic> json) {
  return _DailyStatus.fromJson(json);
}

/// @nodoc
mixin _$DailyStatus {
  String get date => throw _privateConstructorUsedError;
  bool get giftReceived => throw _privateConstructorUsedError;
  bool get giftRead => throw _privateConstructorUsedError;
  bool get commitmentMade => throw _privateConstructorUsedError;
  bool get commitmentFulfilled => throw _privateConstructorUsedError;
  bool get dayComplete => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this DailyStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyStatusCopyWith<DailyStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStatusCopyWith<$Res> {
  factory $DailyStatusCopyWith(
          DailyStatus value, $Res Function(DailyStatus) then) =
      _$DailyStatusCopyWithImpl<$Res, DailyStatus>;
  @useResult
  $Res call(
      {String date,
      bool giftReceived,
      bool giftRead,
      bool commitmentMade,
      bool commitmentFulfilled,
      bool dayComplete,
      DateTime? completedAt});
}

/// @nodoc
class _$DailyStatusCopyWithImpl<$Res, $Val extends DailyStatus>
    implements $DailyStatusCopyWith<$Res> {
  _$DailyStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? giftReceived = null,
    Object? giftRead = null,
    Object? commitmentMade = null,
    Object? commitmentFulfilled = null,
    Object? dayComplete = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      giftReceived: null == giftReceived
          ? _value.giftReceived
          : giftReceived // ignore: cast_nullable_to_non_nullable
              as bool,
      giftRead: null == giftRead
          ? _value.giftRead
          : giftRead // ignore: cast_nullable_to_non_nullable
              as bool,
      commitmentMade: null == commitmentMade
          ? _value.commitmentMade
          : commitmentMade // ignore: cast_nullable_to_non_nullable
              as bool,
      commitmentFulfilled: null == commitmentFulfilled
          ? _value.commitmentFulfilled
          : commitmentFulfilled // ignore: cast_nullable_to_non_nullable
              as bool,
      dayComplete: null == dayComplete
          ? _value.dayComplete
          : dayComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyStatusImplCopyWith<$Res>
    implements $DailyStatusCopyWith<$Res> {
  factory _$$DailyStatusImplCopyWith(
          _$DailyStatusImpl value, $Res Function(_$DailyStatusImpl) then) =
      __$$DailyStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      bool giftReceived,
      bool giftRead,
      bool commitmentMade,
      bool commitmentFulfilled,
      bool dayComplete,
      DateTime? completedAt});
}

/// @nodoc
class __$$DailyStatusImplCopyWithImpl<$Res>
    extends _$DailyStatusCopyWithImpl<$Res, _$DailyStatusImpl>
    implements _$$DailyStatusImplCopyWith<$Res> {
  __$$DailyStatusImplCopyWithImpl(
      _$DailyStatusImpl _value, $Res Function(_$DailyStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? giftReceived = null,
    Object? giftRead = null,
    Object? commitmentMade = null,
    Object? commitmentFulfilled = null,
    Object? dayComplete = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$DailyStatusImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      giftReceived: null == giftReceived
          ? _value.giftReceived
          : giftReceived // ignore: cast_nullable_to_non_nullable
              as bool,
      giftRead: null == giftRead
          ? _value.giftRead
          : giftRead // ignore: cast_nullable_to_non_nullable
              as bool,
      commitmentMade: null == commitmentMade
          ? _value.commitmentMade
          : commitmentMade // ignore: cast_nullable_to_non_nullable
              as bool,
      commitmentFulfilled: null == commitmentFulfilled
          ? _value.commitmentFulfilled
          : commitmentFulfilled // ignore: cast_nullable_to_non_nullable
              as bool,
      dayComplete: null == dayComplete
          ? _value.dayComplete
          : dayComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStatusImpl implements _DailyStatus {
  const _$DailyStatusImpl(
      {required this.date,
      this.giftReceived = false,
      this.giftRead = false,
      this.commitmentMade = false,
      this.commitmentFulfilled = false,
      this.dayComplete = false,
      this.completedAt});

  factory _$DailyStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStatusImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey()
  final bool giftReceived;
  @override
  @JsonKey()
  final bool giftRead;
  @override
  @JsonKey()
  final bool commitmentMade;
  @override
  @JsonKey()
  final bool commitmentFulfilled;
  @override
  @JsonKey()
  final bool dayComplete;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'DailyStatus(date: $date, giftReceived: $giftReceived, giftRead: $giftRead, commitmentMade: $commitmentMade, commitmentFulfilled: $commitmentFulfilled, dayComplete: $dayComplete, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStatusImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.giftReceived, giftReceived) ||
                other.giftReceived == giftReceived) &&
            (identical(other.giftRead, giftRead) ||
                other.giftRead == giftRead) &&
            (identical(other.commitmentMade, commitmentMade) ||
                other.commitmentMade == commitmentMade) &&
            (identical(other.commitmentFulfilled, commitmentFulfilled) ||
                other.commitmentFulfilled == commitmentFulfilled) &&
            (identical(other.dayComplete, dayComplete) ||
                other.dayComplete == dayComplete) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, giftReceived, giftRead,
      commitmentMade, commitmentFulfilled, dayComplete, completedAt);

  /// Create a copy of DailyStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStatusImplCopyWith<_$DailyStatusImpl> get copyWith =>
      __$$DailyStatusImplCopyWithImpl<_$DailyStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStatusImplToJson(
      this,
    );
  }
}

abstract class _DailyStatus implements DailyStatus {
  const factory _DailyStatus(
      {required final String date,
      final bool giftReceived,
      final bool giftRead,
      final bool commitmentMade,
      final bool commitmentFulfilled,
      final bool dayComplete,
      final DateTime? completedAt}) = _$DailyStatusImpl;

  factory _DailyStatus.fromJson(Map<String, dynamic> json) =
      _$DailyStatusImpl.fromJson;

  @override
  String get date;
  @override
  bool get giftReceived;
  @override
  bool get giftRead;
  @override
  bool get commitmentMade;
  @override
  bool get commitmentFulfilled;
  @override
  bool get dayComplete;
  @override
  DateTime? get completedAt;

  /// Create a copy of DailyStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyStatusImplCopyWith<_$DailyStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
