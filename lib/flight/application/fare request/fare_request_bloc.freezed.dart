// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fare_request_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FareRequestEvent {
  FlightOptionElement get flightTrip => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get tripMode => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      FlightOptionElement flightTrip,
      String token,
      String tripMode,
    )
    getFareRequestApi,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      FlightOptionElement flightTrip,
      String token,
      String tripMode,
    )?
    getFareRequestApi,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      FlightOptionElement flightTrip,
      String token,
      String tripMode,
    )?
    getFareRequestApi,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetFareRequestApi value) getFareRequestApi,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetFareRequestApi value)? getFareRequestApi,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetFareRequestApi value)? getFareRequestApi,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of FareRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FareRequestEventCopyWith<FareRequestEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FareRequestEventCopyWith<$Res> {
  factory $FareRequestEventCopyWith(
    FareRequestEvent value,
    $Res Function(FareRequestEvent) then,
  ) = _$FareRequestEventCopyWithImpl<$Res, FareRequestEvent>;
  @useResult
  $Res call({FlightOptionElement flightTrip, String token, String tripMode});
}

/// @nodoc
class _$FareRequestEventCopyWithImpl<$Res, $Val extends FareRequestEvent>
    implements $FareRequestEventCopyWith<$Res> {
  _$FareRequestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FareRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flightTrip = null,
    Object? token = null,
    Object? tripMode = null,
  }) {
    return _then(
      _value.copyWith(
            flightTrip: null == flightTrip
                ? _value.flightTrip
                : flightTrip // ignore: cast_nullable_to_non_nullable
                      as FlightOptionElement,
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            tripMode: null == tripMode
                ? _value.tripMode
                : tripMode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetFareRequestApiImplCopyWith<$Res>
    implements $FareRequestEventCopyWith<$Res> {
  factory _$$GetFareRequestApiImplCopyWith(
    _$GetFareRequestApiImpl value,
    $Res Function(_$GetFareRequestApiImpl) then,
  ) = __$$GetFareRequestApiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FlightOptionElement flightTrip, String token, String tripMode});
}

/// @nodoc
class __$$GetFareRequestApiImplCopyWithImpl<$Res>
    extends _$FareRequestEventCopyWithImpl<$Res, _$GetFareRequestApiImpl>
    implements _$$GetFareRequestApiImplCopyWith<$Res> {
  __$$GetFareRequestApiImplCopyWithImpl(
    _$GetFareRequestApiImpl _value,
    $Res Function(_$GetFareRequestApiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FareRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flightTrip = null,
    Object? token = null,
    Object? tripMode = null,
  }) {
    return _then(
      _$GetFareRequestApiImpl(
        flightTrip: null == flightTrip
            ? _value.flightTrip
            : flightTrip // ignore: cast_nullable_to_non_nullable
                  as FlightOptionElement,
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        tripMode: null == tripMode
            ? _value.tripMode
            : tripMode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetFareRequestApiImpl implements GetFareRequestApi {
  const _$GetFareRequestApiImpl({
    required this.flightTrip,
    required this.token,
    required this.tripMode,
  });

  @override
  final FlightOptionElement flightTrip;
  @override
  final String token;
  @override
  final String tripMode;

  @override
  String toString() {
    return 'FareRequestEvent.getFareRequestApi(flightTrip: $flightTrip, token: $token, tripMode: $tripMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFareRequestApiImpl &&
            (identical(other.flightTrip, flightTrip) ||
                other.flightTrip == flightTrip) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.tripMode, tripMode) ||
                other.tripMode == tripMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flightTrip, token, tripMode);

  /// Create a copy of FareRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFareRequestApiImplCopyWith<_$GetFareRequestApiImpl> get copyWith =>
      __$$GetFareRequestApiImplCopyWithImpl<_$GetFareRequestApiImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      FlightOptionElement flightTrip,
      String token,
      String tripMode,
    )
    getFareRequestApi,
  }) {
    return getFareRequestApi(flightTrip, token, tripMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      FlightOptionElement flightTrip,
      String token,
      String tripMode,
    )?
    getFareRequestApi,
  }) {
    return getFareRequestApi?.call(flightTrip, token, tripMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      FlightOptionElement flightTrip,
      String token,
      String tripMode,
    )?
    getFareRequestApi,
    required TResult orElse(),
  }) {
    if (getFareRequestApi != null) {
      return getFareRequestApi(flightTrip, token, tripMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetFareRequestApi value) getFareRequestApi,
  }) {
    return getFareRequestApi(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetFareRequestApi value)? getFareRequestApi,
  }) {
    return getFareRequestApi?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetFareRequestApi value)? getFareRequestApi,
    required TResult orElse(),
  }) {
    if (getFareRequestApi != null) {
      return getFareRequestApi(this);
    }
    return orElse();
  }
}

abstract class GetFareRequestApi implements FareRequestEvent {
  const factory GetFareRequestApi({
    required final FlightOptionElement flightTrip,
    required final String token,
    required final String tripMode,
  }) = _$GetFareRequestApiImpl;

  @override
  FlightOptionElement get flightTrip;
  @override
  String get token;
  @override
  String get tripMode;

  /// Create a copy of FareRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetFareRequestApiImplCopyWith<_$GetFareRequestApiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FareRequestState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get tokan => throw _privateConstructorUsedError;
  FFlightResponse? get respo => throw _privateConstructorUsedError;

  /// Create a copy of FareRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FareRequestStateCopyWith<FareRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FareRequestStateCopyWith<$Res> {
  factory $FareRequestStateCopyWith(
    FareRequestState value,
    $Res Function(FareRequestState) then,
  ) = _$FareRequestStateCopyWithImpl<$Res, FareRequestState>;
  @useResult
  $Res call({bool isLoading, String? tokan, FFlightResponse? respo});
}

/// @nodoc
class _$FareRequestStateCopyWithImpl<$Res, $Val extends FareRequestState>
    implements $FareRequestStateCopyWith<$Res> {
  _$FareRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FareRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? tokan = freezed,
    Object? respo = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            tokan: freezed == tokan
                ? _value.tokan
                : tokan // ignore: cast_nullable_to_non_nullable
                      as String?,
            respo: freezed == respo
                ? _value.respo
                : respo // ignore: cast_nullable_to_non_nullable
                      as FFlightResponse?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingStateImplCopyWith<$Res>
    implements $FareRequestStateCopyWith<$Res> {
  factory _$$BookingStateImplCopyWith(
    _$BookingStateImpl value,
    $Res Function(_$BookingStateImpl) then,
  ) = __$$BookingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? tokan, FFlightResponse? respo});
}

/// @nodoc
class __$$BookingStateImplCopyWithImpl<$Res>
    extends _$FareRequestStateCopyWithImpl<$Res, _$BookingStateImpl>
    implements _$$BookingStateImplCopyWith<$Res> {
  __$$BookingStateImplCopyWithImpl(
    _$BookingStateImpl _value,
    $Res Function(_$BookingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FareRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? tokan = freezed,
    Object? respo = freezed,
  }) {
    return _then(
      _$BookingStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        tokan: freezed == tokan
            ? _value.tokan
            : tokan // ignore: cast_nullable_to_non_nullable
                  as String?,
        respo: freezed == respo
            ? _value.respo
            : respo // ignore: cast_nullable_to_non_nullable
                  as FFlightResponse?,
      ),
    );
  }
}

/// @nodoc

class _$BookingStateImpl implements _BookingState {
  const _$BookingStateImpl({required this.isLoading, this.tokan, this.respo});

  @override
  final bool isLoading;
  @override
  final String? tokan;
  @override
  final FFlightResponse? respo;

  @override
  String toString() {
    return 'FareRequestState(isLoading: $isLoading, tokan: $tokan, respo: $respo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.tokan, tokan) || other.tokan == tokan) &&
            (identical(other.respo, respo) || other.respo == respo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, tokan, respo);

  /// Create a copy of FareRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      __$$BookingStateImplCopyWithImpl<_$BookingStateImpl>(this, _$identity);
}

abstract class _BookingState implements FareRequestState {
  const factory _BookingState({
    required final bool isLoading,
    final String? tokan,
    final FFlightResponse? respo,
  }) = _$BookingStateImpl;

  @override
  bool get isLoading;
  @override
  String? get tokan;
  @override
  FFlightResponse? get respo;

  /// Create a copy of FareRequestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
