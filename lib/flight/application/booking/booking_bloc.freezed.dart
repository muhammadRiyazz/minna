// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BookingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )
    getRePrice,
    required TResult Function() confirmBooking,
    required TResult Function() resetBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult? Function()? confirmBooking,
    TResult? Function()? resetBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult Function()? confirmBooking,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(ConfirmBooking value) confirmBooking,
    required TResult Function(ResetBooking value) resetBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(ConfirmBooking value)? confirmBooking,
    TResult? Function(ResetBooking value)? resetBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(ConfirmBooking value)? confirmBooking,
    TResult Function(ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingEventCopyWith<$Res> {
  factory $BookingEventCopyWith(
    BookingEvent value,
    $Res Function(BookingEvent) then,
  ) = _$BookingEventCopyWithImpl<$Res, BookingEvent>;
}

/// @nodoc
class _$BookingEventCopyWithImpl<$Res, $Val extends BookingEvent>
    implements $BookingEventCopyWith<$Res> {
  _$BookingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetRePriceImplCopyWith<$Res> {
  factory _$$GetRePriceImplCopyWith(
    _$GetRePriceImpl value,
    $Res Function(_$GetRePriceImpl) then,
  ) = __$$GetRePriceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    bool reprice,
    String tripMode,
    FFlightOption fareReData,
    List<Map<String, dynamic>> passengerDataList,
    String token,
  });
}

/// @nodoc
class __$$GetRePriceImplCopyWithImpl<$Res>
    extends _$BookingEventCopyWithImpl<$Res, _$GetRePriceImpl>
    implements _$$GetRePriceImplCopyWith<$Res> {
  __$$GetRePriceImplCopyWithImpl(
    _$GetRePriceImpl _value,
    $Res Function(_$GetRePriceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reprice = null,
    Object? tripMode = null,
    Object? fareReData = null,
    Object? passengerDataList = null,
    Object? token = null,
  }) {
    return _then(
      _$GetRePriceImpl(
        reprice: null == reprice
            ? _value.reprice
            : reprice // ignore: cast_nullable_to_non_nullable
                  as bool,
        tripMode: null == tripMode
            ? _value.tripMode
            : tripMode // ignore: cast_nullable_to_non_nullable
                  as String,
        fareReData: null == fareReData
            ? _value.fareReData
            : fareReData // ignore: cast_nullable_to_non_nullable
                  as FFlightOption,
        passengerDataList: null == passengerDataList
            ? _value._passengerDataList
            : passengerDataList // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetRePriceImpl implements _GetRePrice {
  const _$GetRePriceImpl({
    required this.reprice,
    required this.tripMode,
    required this.fareReData,
    required final List<Map<String, dynamic>> passengerDataList,
    required this.token,
  }) : _passengerDataList = passengerDataList;

  @override
  final bool reprice;
  @override
  final String tripMode;
  @override
  final FFlightOption fareReData;
  final List<Map<String, dynamic>> _passengerDataList;
  @override
  List<Map<String, dynamic>> get passengerDataList {
    if (_passengerDataList is EqualUnmodifiableListView)
      return _passengerDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_passengerDataList);
  }

  @override
  final String token;

  @override
  String toString() {
    return 'BookingEvent.getRePrice(reprice: $reprice, tripMode: $tripMode, fareReData: $fareReData, passengerDataList: $passengerDataList, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRePriceImpl &&
            (identical(other.reprice, reprice) || other.reprice == reprice) &&
            (identical(other.tripMode, tripMode) ||
                other.tripMode == tripMode) &&
            (identical(other.fareReData, fareReData) ||
                other.fareReData == fareReData) &&
            const DeepCollectionEquality().equals(
              other._passengerDataList,
              _passengerDataList,
            ) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    reprice,
    tripMode,
    fareReData,
    const DeepCollectionEquality().hash(_passengerDataList),
    token,
  );

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRePriceImplCopyWith<_$GetRePriceImpl> get copyWith =>
      __$$GetRePriceImplCopyWithImpl<_$GetRePriceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )
    getRePrice,
    required TResult Function() confirmBooking,
    required TResult Function() resetBooking,
  }) {
    return getRePrice(reprice, tripMode, fareReData, passengerDataList, token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult? Function()? confirmBooking,
    TResult? Function()? resetBooking,
  }) {
    return getRePrice?.call(
      reprice,
      tripMode,
      fareReData,
      passengerDataList,
      token,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult Function()? confirmBooking,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) {
    if (getRePrice != null) {
      return getRePrice(
        reprice,
        tripMode,
        fareReData,
        passengerDataList,
        token,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(ConfirmBooking value) confirmBooking,
    required TResult Function(ResetBooking value) resetBooking,
  }) {
    return getRePrice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(ConfirmBooking value)? confirmBooking,
    TResult? Function(ResetBooking value)? resetBooking,
  }) {
    return getRePrice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(ConfirmBooking value)? confirmBooking,
    TResult Function(ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (getRePrice != null) {
      return getRePrice(this);
    }
    return orElse();
  }
}

abstract class _GetRePrice implements BookingEvent {
  const factory _GetRePrice({
    required final bool reprice,
    required final String tripMode,
    required final FFlightOption fareReData,
    required final List<Map<String, dynamic>> passengerDataList,
    required final String token,
  }) = _$GetRePriceImpl;

  bool get reprice;
  String get tripMode;
  FFlightOption get fareReData;
  List<Map<String, dynamic>> get passengerDataList;
  String get token;

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRePriceImplCopyWith<_$GetRePriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingImplCopyWith<$Res> {
  factory _$$ConfirmBookingImplCopyWith(
    _$ConfirmBookingImpl value,
    $Res Function(_$ConfirmBookingImpl) then,
  ) = __$$ConfirmBookingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfirmBookingImplCopyWithImpl<$Res>
    extends _$BookingEventCopyWithImpl<$Res, _$ConfirmBookingImpl>
    implements _$$ConfirmBookingImplCopyWith<$Res> {
  __$$ConfirmBookingImplCopyWithImpl(
    _$ConfirmBookingImpl _value,
    $Res Function(_$ConfirmBookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConfirmBookingImpl implements ConfirmBooking {
  const _$ConfirmBookingImpl();

  @override
  String toString() {
    return 'BookingEvent.confirmBooking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConfirmBookingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )
    getRePrice,
    required TResult Function() confirmBooking,
    required TResult Function() resetBooking,
  }) {
    return confirmBooking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult? Function()? confirmBooking,
    TResult? Function()? resetBooking,
  }) {
    return confirmBooking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult Function()? confirmBooking,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) {
    if (confirmBooking != null) {
      return confirmBooking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(ConfirmBooking value) confirmBooking,
    required TResult Function(ResetBooking value) resetBooking,
  }) {
    return confirmBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(ConfirmBooking value)? confirmBooking,
    TResult? Function(ResetBooking value)? resetBooking,
  }) {
    return confirmBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(ConfirmBooking value)? confirmBooking,
    TResult Function(ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (confirmBooking != null) {
      return confirmBooking(this);
    }
    return orElse();
  }
}

abstract class ConfirmBooking implements BookingEvent {
  const factory ConfirmBooking() = _$ConfirmBookingImpl;
}

/// @nodoc
abstract class _$$ResetBookingImplCopyWith<$Res> {
  factory _$$ResetBookingImplCopyWith(
    _$ResetBookingImpl value,
    $Res Function(_$ResetBookingImpl) then,
  ) = __$$ResetBookingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetBookingImplCopyWithImpl<$Res>
    extends _$BookingEventCopyWithImpl<$Res, _$ResetBookingImpl>
    implements _$$ResetBookingImplCopyWith<$Res> {
  __$$ResetBookingImplCopyWithImpl(
    _$ResetBookingImpl _value,
    $Res Function(_$ResetBookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetBookingImpl implements ResetBooking {
  const _$ResetBookingImpl();

  @override
  String toString() {
    return 'BookingEvent.resetBooking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetBookingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )
    getRePrice,
    required TResult Function() confirmBooking,
    required TResult Function() resetBooking,
  }) {
    return resetBooking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult? Function()? confirmBooking,
    TResult? Function()? resetBooking,
  }) {
    return resetBooking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
    )?
    getRePrice,
    TResult Function()? confirmBooking,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) {
    if (resetBooking != null) {
      return resetBooking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(ConfirmBooking value) confirmBooking,
    required TResult Function(ResetBooking value) resetBooking,
  }) {
    return resetBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(ConfirmBooking value)? confirmBooking,
    TResult? Function(ResetBooking value)? resetBooking,
  }) {
    return resetBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(ConfirmBooking value)? confirmBooking,
    TResult Function(ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (resetBooking != null) {
      return resetBooking(this);
    }
    return orElse();
  }
}

abstract class ResetBooking implements BookingEvent {
  const factory ResetBooking() = _$ResetBookingImpl;
}

/// @nodoc
mixin _$BookingState {
  bool get isLoading => throw _privateConstructorUsedError;
  BBBookingRequest? get bookingdata => throw _privateConstructorUsedError;
  String? get bookingError => throw _privateConstructorUsedError;
  bool? get isBookingConfirmed => throw _privateConstructorUsedError;
  String? get alhindPnr => throw _privateConstructorUsedError;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingStateCopyWith<BookingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
    BookingState value,
    $Res Function(BookingState) then,
  ) = _$BookingStateCopyWithImpl<$Res, BookingState>;
  @useResult
  $Res call({
    bool isLoading,
    BBBookingRequest? bookingdata,
    String? bookingError,
    bool? isBookingConfirmed,
    String? alhindPnr,
  });
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res, $Val extends BookingState>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? bookingdata = freezed,
    Object? bookingError = freezed,
    Object? isBookingConfirmed = freezed,
    Object? alhindPnr = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            bookingdata: freezed == bookingdata
                ? _value.bookingdata
                : bookingdata // ignore: cast_nullable_to_non_nullable
                      as BBBookingRequest?,
            bookingError: freezed == bookingError
                ? _value.bookingError
                : bookingError // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBookingConfirmed: freezed == isBookingConfirmed
                ? _value.isBookingConfirmed
                : isBookingConfirmed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            alhindPnr: freezed == alhindPnr
                ? _value.alhindPnr
                : alhindPnr // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingStateImplCopyWith<$Res>
    implements $BookingStateCopyWith<$Res> {
  factory _$$BookingStateImplCopyWith(
    _$BookingStateImpl value,
    $Res Function(_$BookingStateImpl) then,
  ) = __$$BookingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    BBBookingRequest? bookingdata,
    String? bookingError,
    bool? isBookingConfirmed,
    String? alhindPnr,
  });
}

/// @nodoc
class __$$BookingStateImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateImpl>
    implements _$$BookingStateImplCopyWith<$Res> {
  __$$BookingStateImplCopyWithImpl(
    _$BookingStateImpl _value,
    $Res Function(_$BookingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? bookingdata = freezed,
    Object? bookingError = freezed,
    Object? isBookingConfirmed = freezed,
    Object? alhindPnr = freezed,
  }) {
    return _then(
      _$BookingStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        bookingdata: freezed == bookingdata
            ? _value.bookingdata
            : bookingdata // ignore: cast_nullable_to_non_nullable
                  as BBBookingRequest?,
        bookingError: freezed == bookingError
            ? _value.bookingError
            : bookingError // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBookingConfirmed: freezed == isBookingConfirmed
            ? _value.isBookingConfirmed
            : isBookingConfirmed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        alhindPnr: freezed == alhindPnr
            ? _value.alhindPnr
            : alhindPnr // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$BookingStateImpl implements _BookingState {
  const _$BookingStateImpl({
    required this.isLoading,
    this.bookingdata,
    this.bookingError,
    this.isBookingConfirmed,
    this.alhindPnr,
  });

  @override
  final bool isLoading;
  @override
  final BBBookingRequest? bookingdata;
  @override
  final String? bookingError;
  @override
  final bool? isBookingConfirmed;
  @override
  final String? alhindPnr;

  @override
  String toString() {
    return 'BookingState(isLoading: $isLoading, bookingdata: $bookingdata, bookingError: $bookingError, isBookingConfirmed: $isBookingConfirmed, alhindPnr: $alhindPnr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.bookingdata, bookingdata) ||
                other.bookingdata == bookingdata) &&
            (identical(other.bookingError, bookingError) ||
                other.bookingError == bookingError) &&
            (identical(other.isBookingConfirmed, isBookingConfirmed) ||
                other.isBookingConfirmed == isBookingConfirmed) &&
            (identical(other.alhindPnr, alhindPnr) ||
                other.alhindPnr == alhindPnr));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    bookingdata,
    bookingError,
    isBookingConfirmed,
    alhindPnr,
  );

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      __$$BookingStateImplCopyWithImpl<_$BookingStateImpl>(this, _$identity);
}

abstract class _BookingState implements BookingState {
  const factory _BookingState({
    required final bool isLoading,
    final BBBookingRequest? bookingdata,
    final String? bookingError,
    final bool? isBookingConfirmed,
    final String? alhindPnr,
  }) = _$BookingStateImpl;

  @override
  bool get isLoading;
  @override
  BBBookingRequest? get bookingdata;
  @override
  String? get bookingError;
  @override
  bool? get isBookingConfirmed;
  @override
  String? get alhindPnr;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
