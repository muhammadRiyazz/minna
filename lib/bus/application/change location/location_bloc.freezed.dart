// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LocationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(City? from, City? to) addLocation,
    required TResult Function(DateTime date) updateDate,
    required TResult Function() swapLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(City? from, City? to)? addLocation,
    TResult? Function(DateTime date)? updateDate,
    TResult? Function()? swapLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(City? from, City? to)? addLocation,
    TResult Function(DateTime date)? updateDate,
    TResult Function()? swapLocations,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddLocation value) addLocation,
    required TResult Function(UpdateDate value) updateDate,
    required TResult Function(SwapLocations value) swapLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddLocation value)? addLocation,
    TResult? Function(UpdateDate value)? updateDate,
    TResult? Function(SwapLocations value)? swapLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddLocation value)? addLocation,
    TResult Function(UpdateDate value)? updateDate,
    TResult Function(SwapLocations value)? swapLocations,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationEventCopyWith<$Res> {
  factory $LocationEventCopyWith(
    LocationEvent value,
    $Res Function(LocationEvent) then,
  ) = _$LocationEventCopyWithImpl<$Res, LocationEvent>;
}

/// @nodoc
class _$LocationEventCopyWithImpl<$Res, $Val extends LocationEvent>
    implements $LocationEventCopyWith<$Res> {
  _$LocationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddLocationImplCopyWith<$Res> {
  factory _$$AddLocationImplCopyWith(
    _$AddLocationImpl value,
    $Res Function(_$AddLocationImpl) then,
  ) = __$$AddLocationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({City? from, City? to});
}

/// @nodoc
class __$$AddLocationImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$AddLocationImpl>
    implements _$$AddLocationImplCopyWith<$Res> {
  __$$AddLocationImplCopyWithImpl(
    _$AddLocationImpl _value,
    $Res Function(_$AddLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? from = freezed, Object? to = freezed}) {
    return _then(
      _$AddLocationImpl(
        freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as City?,
        freezed == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as City?,
      ),
    );
  }
}

/// @nodoc

class _$AddLocationImpl implements AddLocation {
  const _$AddLocationImpl(this.from, this.to);

  @override
  final City? from;
  @override
  final City? to;

  @override
  String toString() {
    return 'LocationEvent.addLocation(from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddLocationImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @override
  int get hashCode => Object.hash(runtimeType, from, to);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddLocationImplCopyWith<_$AddLocationImpl> get copyWith =>
      __$$AddLocationImplCopyWithImpl<_$AddLocationImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(City? from, City? to) addLocation,
    required TResult Function(DateTime date) updateDate,
    required TResult Function() swapLocations,
  }) {
    return addLocation(from, to);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(City? from, City? to)? addLocation,
    TResult? Function(DateTime date)? updateDate,
    TResult? Function()? swapLocations,
  }) {
    return addLocation?.call(from, to);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(City? from, City? to)? addLocation,
    TResult Function(DateTime date)? updateDate,
    TResult Function()? swapLocations,
    required TResult orElse(),
  }) {
    if (addLocation != null) {
      return addLocation(from, to);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddLocation value) addLocation,
    required TResult Function(UpdateDate value) updateDate,
    required TResult Function(SwapLocations value) swapLocations,
  }) {
    return addLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddLocation value)? addLocation,
    TResult? Function(UpdateDate value)? updateDate,
    TResult? Function(SwapLocations value)? swapLocations,
  }) {
    return addLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddLocation value)? addLocation,
    TResult Function(UpdateDate value)? updateDate,
    TResult Function(SwapLocations value)? swapLocations,
    required TResult orElse(),
  }) {
    if (addLocation != null) {
      return addLocation(this);
    }
    return orElse();
  }
}

abstract class AddLocation implements LocationEvent {
  const factory AddLocation(final City? from, final City? to) =
      _$AddLocationImpl;

  City? get from;
  City? get to;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddLocationImplCopyWith<_$AddLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDateImplCopyWith<$Res> {
  factory _$$UpdateDateImplCopyWith(
    _$UpdateDateImpl value,
    $Res Function(_$UpdateDateImpl) then,
  ) = __$$UpdateDateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$$UpdateDateImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$UpdateDateImpl>
    implements _$$UpdateDateImplCopyWith<$Res> {
  __$$UpdateDateImplCopyWithImpl(
    _$UpdateDateImpl _value,
    $Res Function(_$UpdateDateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null}) {
    return _then(
      _$UpdateDateImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$UpdateDateImpl implements UpdateDate {
  const _$UpdateDateImpl({required this.date});

  @override
  final DateTime date;

  @override
  String toString() {
    return 'LocationEvent.updateDate(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDateImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDateImplCopyWith<_$UpdateDateImpl> get copyWith =>
      __$$UpdateDateImplCopyWithImpl<_$UpdateDateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(City? from, City? to) addLocation,
    required TResult Function(DateTime date) updateDate,
    required TResult Function() swapLocations,
  }) {
    return updateDate(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(City? from, City? to)? addLocation,
    TResult? Function(DateTime date)? updateDate,
    TResult? Function()? swapLocations,
  }) {
    return updateDate?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(City? from, City? to)? addLocation,
    TResult Function(DateTime date)? updateDate,
    TResult Function()? swapLocations,
    required TResult orElse(),
  }) {
    if (updateDate != null) {
      return updateDate(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddLocation value) addLocation,
    required TResult Function(UpdateDate value) updateDate,
    required TResult Function(SwapLocations value) swapLocations,
  }) {
    return updateDate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddLocation value)? addLocation,
    TResult? Function(UpdateDate value)? updateDate,
    TResult? Function(SwapLocations value)? swapLocations,
  }) {
    return updateDate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddLocation value)? addLocation,
    TResult Function(UpdateDate value)? updateDate,
    TResult Function(SwapLocations value)? swapLocations,
    required TResult orElse(),
  }) {
    if (updateDate != null) {
      return updateDate(this);
    }
    return orElse();
  }
}

abstract class UpdateDate implements LocationEvent {
  const factory UpdateDate({required final DateTime date}) = _$UpdateDateImpl;

  DateTime get date;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDateImplCopyWith<_$UpdateDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SwapLocationsImplCopyWith<$Res> {
  factory _$$SwapLocationsImplCopyWith(
    _$SwapLocationsImpl value,
    $Res Function(_$SwapLocationsImpl) then,
  ) = __$$SwapLocationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SwapLocationsImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$SwapLocationsImpl>
    implements _$$SwapLocationsImplCopyWith<$Res> {
  __$$SwapLocationsImplCopyWithImpl(
    _$SwapLocationsImpl _value,
    $Res Function(_$SwapLocationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SwapLocationsImpl implements SwapLocations {
  const _$SwapLocationsImpl();

  @override
  String toString() {
    return 'LocationEvent.swapLocations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SwapLocationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(City? from, City? to) addLocation,
    required TResult Function(DateTime date) updateDate,
    required TResult Function() swapLocations,
  }) {
    return swapLocations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(City? from, City? to)? addLocation,
    TResult? Function(DateTime date)? updateDate,
    TResult? Function()? swapLocations,
  }) {
    return swapLocations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(City? from, City? to)? addLocation,
    TResult Function(DateTime date)? updateDate,
    TResult Function()? swapLocations,
    required TResult orElse(),
  }) {
    if (swapLocations != null) {
      return swapLocations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddLocation value) addLocation,
    required TResult Function(UpdateDate value) updateDate,
    required TResult Function(SwapLocations value) swapLocations,
  }) {
    return swapLocations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddLocation value)? addLocation,
    TResult? Function(UpdateDate value)? updateDate,
    TResult? Function(SwapLocations value)? swapLocations,
  }) {
    return swapLocations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddLocation value)? addLocation,
    TResult Function(UpdateDate value)? updateDate,
    TResult Function(SwapLocations value)? swapLocations,
    required TResult orElse(),
  }) {
    if (swapLocations != null) {
      return swapLocations(this);
    }
    return orElse();
  }
}

abstract class SwapLocations implements LocationEvent {
  const factory SwapLocations() = _$SwapLocationsImpl;
}

/// @nodoc
mixin _$LocationState {
  City? get from => throw _privateConstructorUsedError;
  City? get to => throw _privateConstructorUsedError;
  DateTime get dateOfJourney => throw _privateConstructorUsedError;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationStateCopyWith<LocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
    LocationState value,
    $Res Function(LocationState) then,
  ) = _$LocationStateCopyWithImpl<$Res, LocationState>;
  @useResult
  $Res call({City? from, City? to, DateTime dateOfJourney});
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? dateOfJourney = null,
  }) {
    return _then(
      _value.copyWith(
            from: freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as City?,
            to: freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as City?,
            dateOfJourney: null == dateOfJourney
                ? _value.dateOfJourney
                : dateOfJourney // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationStateImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$LocationStateImplCopyWith(
    _$LocationStateImpl value,
    $Res Function(_$LocationStateImpl) then,
  ) = __$$LocationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({City? from, City? to, DateTime dateOfJourney});
}

/// @nodoc
class __$$LocationStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationStateImpl>
    implements _$$LocationStateImplCopyWith<$Res> {
  __$$LocationStateImplCopyWithImpl(
    _$LocationStateImpl _value,
    $Res Function(_$LocationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? dateOfJourney = null,
  }) {
    return _then(
      _$LocationStateImpl(
        from: freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as City?,
        to: freezed == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as City?,
        dateOfJourney: null == dateOfJourney
            ? _value.dateOfJourney
            : dateOfJourney // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$LocationStateImpl implements _LocationState {
  const _$LocationStateImpl({this.from, this.to, required this.dateOfJourney});

  @override
  final City? from;
  @override
  final City? to;
  @override
  final DateTime dateOfJourney;

  @override
  String toString() {
    return 'LocationState(from: $from, to: $to, dateOfJourney: $dateOfJourney)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationStateImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.dateOfJourney, dateOfJourney) ||
                other.dateOfJourney == dateOfJourney));
  }

  @override
  int get hashCode => Object.hash(runtimeType, from, to, dateOfJourney);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      __$$LocationStateImplCopyWithImpl<_$LocationStateImpl>(this, _$identity);
}

abstract class _LocationState implements LocationState {
  const factory _LocationState({
    final City? from,
    final City? to,
    required final DateTime dateOfJourney,
  }) = _$LocationStateImpl;

  @override
  City? get from;
  @override
  City? get to;
  @override
  DateTime get dateOfJourney;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
