// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'growth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GrowthState _$GrowthStateFromJson(Map<String, dynamic> json) {
  return _GrowthState.fromJson(json);
}

/// @nodoc
mixin _$GrowthState {
  String get userId => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  int get totalCommitmentsCompleted => throw _privateConstructorUsedError;
  int get growthLevel => throw _privateConstructorUsedError; // 0–100 scale
  int get leavesEarned =>
      throw _privateConstructorUsedError; // visual: leaves on the tree
  GrowthTheme get activeTheme => throw _privateConstructorUsedError;
  String? get lastCompletedDate => throw _privateConstructorUsedError;
  List<String> get missedDates => throw _privateConstructorUsedError;
  double get brightnessValue => throw _privateConstructorUsedError;

  /// Serializes this GrowthState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GrowthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GrowthStateCopyWith<GrowthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrowthStateCopyWith<$Res> {
  factory $GrowthStateCopyWith(
          GrowthState value, $Res Function(GrowthState) then) =
      _$GrowthStateCopyWithImpl<$Res, GrowthState>;
  @useResult
  $Res call(
      {String userId,
      int currentStreak,
      int longestStreak,
      int totalCommitmentsCompleted,
      int growthLevel,
      int leavesEarned,
      GrowthTheme activeTheme,
      String? lastCompletedDate,
      List<String> missedDates,
      double brightnessValue});
}

/// @nodoc
class _$GrowthStateCopyWithImpl<$Res, $Val extends GrowthState>
    implements $GrowthStateCopyWith<$Res> {
  _$GrowthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GrowthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalCommitmentsCompleted = null,
    Object? growthLevel = null,
    Object? leavesEarned = null,
    Object? activeTheme = null,
    Object? lastCompletedDate = freezed,
    Object? missedDates = null,
    Object? brightnessValue = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalCommitmentsCompleted: null == totalCommitmentsCompleted
          ? _value.totalCommitmentsCompleted
          : totalCommitmentsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      growthLevel: null == growthLevel
          ? _value.growthLevel
          : growthLevel // ignore: cast_nullable_to_non_nullable
              as int,
      leavesEarned: null == leavesEarned
          ? _value.leavesEarned
          : leavesEarned // ignore: cast_nullable_to_non_nullable
              as int,
      activeTheme: null == activeTheme
          ? _value.activeTheme
          : activeTheme // ignore: cast_nullable_to_non_nullable
              as GrowthTheme,
      lastCompletedDate: freezed == lastCompletedDate
          ? _value.lastCompletedDate
          : lastCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      missedDates: null == missedDates
          ? _value.missedDates
          : missedDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      brightnessValue: null == brightnessValue
          ? _value.brightnessValue
          : brightnessValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GrowthStateImplCopyWith<$Res>
    implements $GrowthStateCopyWith<$Res> {
  factory _$$GrowthStateImplCopyWith(
          _$GrowthStateImpl value, $Res Function(_$GrowthStateImpl) then) =
      __$$GrowthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int currentStreak,
      int longestStreak,
      int totalCommitmentsCompleted,
      int growthLevel,
      int leavesEarned,
      GrowthTheme activeTheme,
      String? lastCompletedDate,
      List<String> missedDates,
      double brightnessValue});
}

/// @nodoc
class __$$GrowthStateImplCopyWithImpl<$Res>
    extends _$GrowthStateCopyWithImpl<$Res, _$GrowthStateImpl>
    implements _$$GrowthStateImplCopyWith<$Res> {
  __$$GrowthStateImplCopyWithImpl(
      _$GrowthStateImpl _value, $Res Function(_$GrowthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GrowthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalCommitmentsCompleted = null,
    Object? growthLevel = null,
    Object? leavesEarned = null,
    Object? activeTheme = null,
    Object? lastCompletedDate = freezed,
    Object? missedDates = null,
    Object? brightnessValue = null,
  }) {
    return _then(_$GrowthStateImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalCommitmentsCompleted: null == totalCommitmentsCompleted
          ? _value.totalCommitmentsCompleted
          : totalCommitmentsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      growthLevel: null == growthLevel
          ? _value.growthLevel
          : growthLevel // ignore: cast_nullable_to_non_nullable
              as int,
      leavesEarned: null == leavesEarned
          ? _value.leavesEarned
          : leavesEarned // ignore: cast_nullable_to_non_nullable
              as int,
      activeTheme: null == activeTheme
          ? _value.activeTheme
          : activeTheme // ignore: cast_nullable_to_non_nullable
              as GrowthTheme,
      lastCompletedDate: freezed == lastCompletedDate
          ? _value.lastCompletedDate
          : lastCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      missedDates: null == missedDates
          ? _value._missedDates
          : missedDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      brightnessValue: null == brightnessValue
          ? _value.brightnessValue
          : brightnessValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GrowthStateImpl implements _GrowthState {
  const _$GrowthStateImpl(
      {required this.userId,
      this.currentStreak = 0,
      this.longestStreak = 0,
      this.totalCommitmentsCompleted = 0,
      this.growthLevel = 0,
      this.leavesEarned = 0,
      this.activeTheme = GrowthTheme.tree,
      this.lastCompletedDate,
      final List<String> missedDates = const [],
      this.brightnessValue = 0.0})
      : _missedDates = missedDates;

  factory _$GrowthStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GrowthStateImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  @JsonKey()
  final int totalCommitmentsCompleted;
  @override
  @JsonKey()
  final int growthLevel;
// 0–100 scale
  @override
  @JsonKey()
  final int leavesEarned;
// visual: leaves on the tree
  @override
  @JsonKey()
  final GrowthTheme activeTheme;
  @override
  final String? lastCompletedDate;
  final List<String> _missedDates;
  @override
  @JsonKey()
  List<String> get missedDates {
    if (_missedDates is EqualUnmodifiableListView) return _missedDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missedDates);
  }

  @override
  @JsonKey()
  final double brightnessValue;

  @override
  String toString() {
    return 'GrowthState(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, totalCommitmentsCompleted: $totalCommitmentsCompleted, growthLevel: $growthLevel, leavesEarned: $leavesEarned, activeTheme: $activeTheme, lastCompletedDate: $lastCompletedDate, missedDates: $missedDates, brightnessValue: $brightnessValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrowthStateImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalCommitmentsCompleted,
                    totalCommitmentsCompleted) ||
                other.totalCommitmentsCompleted == totalCommitmentsCompleted) &&
            (identical(other.growthLevel, growthLevel) ||
                other.growthLevel == growthLevel) &&
            (identical(other.leavesEarned, leavesEarned) ||
                other.leavesEarned == leavesEarned) &&
            (identical(other.activeTheme, activeTheme) ||
                other.activeTheme == activeTheme) &&
            (identical(other.lastCompletedDate, lastCompletedDate) ||
                other.lastCompletedDate == lastCompletedDate) &&
            const DeepCollectionEquality()
                .equals(other._missedDates, _missedDates) &&
            (identical(other.brightnessValue, brightnessValue) ||
                other.brightnessValue == brightnessValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      currentStreak,
      longestStreak,
      totalCommitmentsCompleted,
      growthLevel,
      leavesEarned,
      activeTheme,
      lastCompletedDate,
      const DeepCollectionEquality().hash(_missedDates),
      brightnessValue);

  /// Create a copy of GrowthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GrowthStateImplCopyWith<_$GrowthStateImpl> get copyWith =>
      __$$GrowthStateImplCopyWithImpl<_$GrowthStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GrowthStateImplToJson(
      this,
    );
  }
}

abstract class _GrowthState implements GrowthState {
  const factory _GrowthState(
      {required final String userId,
      final int currentStreak,
      final int longestStreak,
      final int totalCommitmentsCompleted,
      final int growthLevel,
      final int leavesEarned,
      final GrowthTheme activeTheme,
      final String? lastCompletedDate,
      final List<String> missedDates,
      final double brightnessValue}) = _$GrowthStateImpl;

  factory _GrowthState.fromJson(Map<String, dynamic> json) =
      _$GrowthStateImpl.fromJson;

  @override
  String get userId;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  int get totalCommitmentsCompleted;
  @override
  int get growthLevel; // 0–100 scale
  @override
  int get leavesEarned; // visual: leaves on the tree
  @override
  GrowthTheme get activeTheme;
  @override
  String? get lastCompletedDate;
  @override
  List<String> get missedDates;
  @override
  double get brightnessValue;

  /// Create a copy of GrowthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GrowthStateImplCopyWith<_$GrowthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
