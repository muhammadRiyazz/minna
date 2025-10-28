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
      String triptype,
      FFlightResponse lastRespo,
    )
    getRePrice,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
    )
    confirmFlightBooking,
    required TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )
    saveFinalBooking,
    required TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )
    initiateRefund,
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult? Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult? Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult? Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(_ConfirmFlightBooking value) confirmFlightBooking,
    required TResult Function(_SaveFinalBooking value) saveFinalBooking,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_ResetBooking value) resetBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult? Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_ResetBooking value)? resetBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_ResetBooking value)? resetBooking,
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
    String triptype,
    FFlightResponse lastRespo,
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
    Object? triptype = null,
    Object? lastRespo = null,
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
        triptype: null == triptype
            ? _value.triptype
            : triptype // ignore: cast_nullable_to_non_nullable
                  as String,
        lastRespo: null == lastRespo
            ? _value.lastRespo
            : lastRespo // ignore: cast_nullable_to_non_nullable
                  as FFlightResponse,
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
    required this.triptype,
    required this.lastRespo,
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
  final String triptype;
  @override
  final FFlightResponse lastRespo;

  @override
  String toString() {
    return 'BookingEvent.getRePrice(reprice: $reprice, tripMode: $tripMode, fareReData: $fareReData, passengerDataList: $passengerDataList, token: $token, triptype: $triptype, lastRespo: $lastRespo)';
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
            (identical(other.token, token) || other.token == token) &&
            (identical(other.triptype, triptype) ||
                other.triptype == triptype) &&
            (identical(other.lastRespo, lastRespo) ||
                other.lastRespo == lastRespo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    reprice,
    tripMode,
    fareReData,
    const DeepCollectionEquality().hash(_passengerDataList),
    token,
    triptype,
    lastRespo,
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
      String triptype,
      FFlightResponse lastRespo,
    )
    getRePrice,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
    )
    confirmFlightBooking,
    required TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )
    saveFinalBooking,
    required TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )
    initiateRefund,
    required TResult Function() resetBooking,
  }) {
    return getRePrice(
      reprice,
      tripMode,
      fareReData,
      passengerDataList,
      token,
      triptype,
      lastRespo,
    );
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult? Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult? Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult? Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult? Function()? resetBooking,
  }) {
    return getRePrice?.call(
      reprice,
      tripMode,
      fareReData,
      passengerDataList,
      token,
      triptype,
      lastRespo,
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
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
        triptype,
        lastRespo,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(_ConfirmFlightBooking value) confirmFlightBooking,
    required TResult Function(_SaveFinalBooking value) saveFinalBooking,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_ResetBooking value) resetBooking,
  }) {
    return getRePrice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult? Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_ResetBooking value)? resetBooking,
  }) {
    return getRePrice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_ResetBooking value)? resetBooking,
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
    required final String triptype,
    required final FFlightResponse lastRespo,
  }) = _$GetRePriceImpl;

  bool get reprice;
  String get tripMode;
  FFlightOption get fareReData;
  List<Map<String, dynamic>> get passengerDataList;
  String get token;
  String get triptype;
  FFlightResponse get lastRespo;

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRePriceImplCopyWith<_$GetRePriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmFlightBookingImplCopyWith<$Res> {
  factory _$$ConfirmFlightBookingImplCopyWith(
    _$ConfirmFlightBookingImpl value,
    $Res Function(_$ConfirmFlightBookingImpl) then,
  ) = __$$ConfirmFlightBookingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String paymentId, String orderId, String signature});
}

/// @nodoc
class __$$ConfirmFlightBookingImplCopyWithImpl<$Res>
    extends _$BookingEventCopyWithImpl<$Res, _$ConfirmFlightBookingImpl>
    implements _$$ConfirmFlightBookingImplCopyWith<$Res> {
  __$$ConfirmFlightBookingImplCopyWithImpl(
    _$ConfirmFlightBookingImpl _value,
    $Res Function(_$ConfirmFlightBookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? orderId = null,
    Object? signature = null,
  }) {
    return _then(
      _$ConfirmFlightBookingImpl(
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        signature: null == signature
            ? _value.signature
            : signature // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmFlightBookingImpl implements _ConfirmFlightBooking {
  const _$ConfirmFlightBookingImpl({
    required this.paymentId,
    required this.orderId,
    required this.signature,
  });

  @override
  final String paymentId;
  @override
  final String orderId;
  @override
  final String signature;

  @override
  String toString() {
    return 'BookingEvent.confirmFlightBooking(paymentId: $paymentId, orderId: $orderId, signature: $signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmFlightBookingImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentId, orderId, signature);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmFlightBookingImplCopyWith<_$ConfirmFlightBookingImpl>
  get copyWith =>
      __$$ConfirmFlightBookingImplCopyWithImpl<_$ConfirmFlightBookingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
      String triptype,
      FFlightResponse lastRespo,
    )
    getRePrice,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
    )
    confirmFlightBooking,
    required TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )
    saveFinalBooking,
    required TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )
    initiateRefund,
    required TResult Function() resetBooking,
  }) {
    return confirmFlightBooking(paymentId, orderId, signature);
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult? Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult? Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult? Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult? Function()? resetBooking,
  }) {
    return confirmFlightBooking?.call(paymentId, orderId, signature);
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) {
    if (confirmFlightBooking != null) {
      return confirmFlightBooking(paymentId, orderId, signature);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(_ConfirmFlightBooking value) confirmFlightBooking,
    required TResult Function(_SaveFinalBooking value) saveFinalBooking,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_ResetBooking value) resetBooking,
  }) {
    return confirmFlightBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult? Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_ResetBooking value)? resetBooking,
  }) {
    return confirmFlightBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (confirmFlightBooking != null) {
      return confirmFlightBooking(this);
    }
    return orElse();
  }
}

abstract class _ConfirmFlightBooking implements BookingEvent {
  const factory _ConfirmFlightBooking({
    required final String paymentId,
    required final String orderId,
    required final String signature,
  }) = _$ConfirmFlightBookingImpl;

  String get paymentId;
  String get orderId;
  String get signature;

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmFlightBookingImplCopyWith<_$ConfirmFlightBookingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveFinalBookingImplCopyWith<$Res> {
  factory _$$SaveFinalBookingImplCopyWith(
    _$SaveFinalBookingImpl value,
    $Res Function(_$SaveFinalBookingImpl) then,
  ) = __$$SaveFinalBookingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String alhindPnr,
    String tableID,
    String orderId,
    String signature,
    String paymentId,
    Map<String, dynamic> finalResponse,
    Map<String, dynamic> razorpayResponse,
  });
}

/// @nodoc
class __$$SaveFinalBookingImplCopyWithImpl<$Res>
    extends _$BookingEventCopyWithImpl<$Res, _$SaveFinalBookingImpl>
    implements _$$SaveFinalBookingImplCopyWith<$Res> {
  __$$SaveFinalBookingImplCopyWithImpl(
    _$SaveFinalBookingImpl _value,
    $Res Function(_$SaveFinalBookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alhindPnr = null,
    Object? tableID = null,
    Object? orderId = null,
    Object? signature = null,
    Object? paymentId = null,
    Object? finalResponse = null,
    Object? razorpayResponse = null,
  }) {
    return _then(
      _$SaveFinalBookingImpl(
        alhindPnr: null == alhindPnr
            ? _value.alhindPnr
            : alhindPnr // ignore: cast_nullable_to_non_nullable
                  as String,
        tableID: null == tableID
            ? _value.tableID
            : tableID // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        signature: null == signature
            ? _value.signature
            : signature // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        finalResponse: null == finalResponse
            ? _value._finalResponse
            : finalResponse // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        razorpayResponse: null == razorpayResponse
            ? _value._razorpayResponse
            : razorpayResponse // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$SaveFinalBookingImpl implements _SaveFinalBooking {
  const _$SaveFinalBookingImpl({
    required this.alhindPnr,
    required this.tableID,
    required this.orderId,
    required this.signature,
    required this.paymentId,
    required final Map<String, dynamic> finalResponse,
    required final Map<String, dynamic> razorpayResponse,
  }) : _finalResponse = finalResponse,
       _razorpayResponse = razorpayResponse;

  @override
  final String alhindPnr;
  @override
  final String tableID;
  @override
  final String orderId;
  @override
  final String signature;
  @override
  final String paymentId;
  final Map<String, dynamic> _finalResponse;
  @override
  Map<String, dynamic> get finalResponse {
    if (_finalResponse is EqualUnmodifiableMapView) return _finalResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_finalResponse);
  }

  final Map<String, dynamic> _razorpayResponse;
  @override
  Map<String, dynamic> get razorpayResponse {
    if (_razorpayResponse is EqualUnmodifiableMapView) return _razorpayResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_razorpayResponse);
  }

  @override
  String toString() {
    return 'BookingEvent.saveFinalBooking(alhindPnr: $alhindPnr, tableID: $tableID, orderId: $orderId, signature: $signature, paymentId: $paymentId, finalResponse: $finalResponse, razorpayResponse: $razorpayResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveFinalBookingImpl &&
            (identical(other.alhindPnr, alhindPnr) ||
                other.alhindPnr == alhindPnr) &&
            (identical(other.tableID, tableID) || other.tableID == tableID) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            const DeepCollectionEquality().equals(
              other._finalResponse,
              _finalResponse,
            ) &&
            const DeepCollectionEquality().equals(
              other._razorpayResponse,
              _razorpayResponse,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    alhindPnr,
    tableID,
    orderId,
    signature,
    paymentId,
    const DeepCollectionEquality().hash(_finalResponse),
    const DeepCollectionEquality().hash(_razorpayResponse),
  );

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveFinalBookingImplCopyWith<_$SaveFinalBookingImpl> get copyWith =>
      __$$SaveFinalBookingImplCopyWithImpl<_$SaveFinalBookingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
      String triptype,
      FFlightResponse lastRespo,
    )
    getRePrice,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
    )
    confirmFlightBooking,
    required TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )
    saveFinalBooking,
    required TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )
    initiateRefund,
    required TResult Function() resetBooking,
  }) {
    return saveFinalBooking(
      alhindPnr,
      tableID,
      orderId,
      signature,
      paymentId,
      finalResponse,
      razorpayResponse,
    );
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult? Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult? Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult? Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult? Function()? resetBooking,
  }) {
    return saveFinalBooking?.call(
      alhindPnr,
      tableID,
      orderId,
      signature,
      paymentId,
      finalResponse,
      razorpayResponse,
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) {
    if (saveFinalBooking != null) {
      return saveFinalBooking(
        alhindPnr,
        tableID,
        orderId,
        signature,
        paymentId,
        finalResponse,
        razorpayResponse,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(_ConfirmFlightBooking value) confirmFlightBooking,
    required TResult Function(_SaveFinalBooking value) saveFinalBooking,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_ResetBooking value) resetBooking,
  }) {
    return saveFinalBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult? Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_ResetBooking value)? resetBooking,
  }) {
    return saveFinalBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (saveFinalBooking != null) {
      return saveFinalBooking(this);
    }
    return orElse();
  }
}

abstract class _SaveFinalBooking implements BookingEvent {
  const factory _SaveFinalBooking({
    required final String alhindPnr,
    required final String tableID,
    required final String orderId,
    required final String signature,
    required final String paymentId,
    required final Map<String, dynamic> finalResponse,
    required final Map<String, dynamic> razorpayResponse,
  }) = _$SaveFinalBookingImpl;

  String get alhindPnr;
  String get tableID;
  String get orderId;
  String get signature;
  String get paymentId;
  Map<String, dynamic> get finalResponse;
  Map<String, dynamic> get razorpayResponse;

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveFinalBookingImplCopyWith<_$SaveFinalBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitiateRefundImplCopyWith<$Res> {
  factory _$$InitiateRefundImplCopyWith(
    _$InitiateRefundImpl value,
    $Res Function(_$InitiateRefundImpl) then,
  ) = __$$InitiateRefundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String orderId,
    String paymentId,
    double amount,
    String tableID,
    String reason,
  });
}

/// @nodoc
class __$$InitiateRefundImplCopyWithImpl<$Res>
    extends _$BookingEventCopyWithImpl<$Res, _$InitiateRefundImpl>
    implements _$$InitiateRefundImplCopyWith<$Res> {
  __$$InitiateRefundImplCopyWithImpl(
    _$InitiateRefundImpl _value,
    $Res Function(_$InitiateRefundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? paymentId = null,
    Object? amount = null,
    Object? tableID = null,
    Object? reason = null,
  }) {
    return _then(
      _$InitiateRefundImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentId: null == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableID: null == tableID
            ? _value.tableID
            : tableID // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InitiateRefundImpl implements _InitiateRefund {
  const _$InitiateRefundImpl({
    required this.orderId,
    required this.paymentId,
    required this.amount,
    required this.tableID,
    required this.reason,
  });

  @override
  final String orderId;
  @override
  final String paymentId;
  @override
  final double amount;
  @override
  final String tableID;
  @override
  final String reason;

  @override
  String toString() {
    return 'BookingEvent.initiateRefund(orderId: $orderId, paymentId: $paymentId, amount: $amount, tableID: $tableID, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateRefundImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableID, tableID) || other.tableID == tableID) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, orderId, paymentId, amount, tableID, reason);

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateRefundImplCopyWith<_$InitiateRefundImpl> get copyWith =>
      __$$InitiateRefundImplCopyWithImpl<_$InitiateRefundImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool reprice,
      String tripMode,
      FFlightOption fareReData,
      List<Map<String, dynamic>> passengerDataList,
      String token,
      String triptype,
      FFlightResponse lastRespo,
    )
    getRePrice,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
    )
    confirmFlightBooking,
    required TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )
    saveFinalBooking,
    required TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )
    initiateRefund,
    required TResult Function() resetBooking,
  }) {
    return initiateRefund(orderId, paymentId, amount, tableID, reason);
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult? Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult? Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult? Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult? Function()? resetBooking,
  }) {
    return initiateRefund?.call(orderId, paymentId, amount, tableID, reason);
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
    TResult Function()? resetBooking,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(orderId, paymentId, amount, tableID, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRePrice value) getRePrice,
    required TResult Function(_ConfirmFlightBooking value) confirmFlightBooking,
    required TResult Function(_SaveFinalBooking value) saveFinalBooking,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_ResetBooking value) resetBooking,
  }) {
    return initiateRefund(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult? Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_ResetBooking value)? resetBooking,
  }) {
    return initiateRefund?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(this);
    }
    return orElse();
  }
}

abstract class _InitiateRefund implements BookingEvent {
  const factory _InitiateRefund({
    required final String orderId,
    required final String paymentId,
    required final double amount,
    required final String tableID,
    required final String reason,
  }) = _$InitiateRefundImpl;

  String get orderId;
  String get paymentId;
  double get amount;
  String get tableID;
  String get reason;

  /// Create a copy of BookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateRefundImplCopyWith<_$InitiateRefundImpl> get copyWith =>
      throw _privateConstructorUsedError;
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

class _$ResetBookingImpl implements _ResetBooking {
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
      String triptype,
      FFlightResponse lastRespo,
    )
    getRePrice,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
    )
    confirmFlightBooking,
    required TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )
    saveFinalBooking,
    required TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )
    initiateRefund,
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult? Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult? Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult? Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
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
      String triptype,
      FFlightResponse lastRespo,
    )?
    getRePrice,
    TResult Function(String paymentId, String orderId, String signature)?
    confirmFlightBooking,
    TResult Function(
      String alhindPnr,
      String tableID,
      String orderId,
      String signature,
      String paymentId,
      Map<String, dynamic> finalResponse,
      Map<String, dynamic> razorpayResponse,
    )?
    saveFinalBooking,
    TResult Function(
      String orderId,
      String paymentId,
      double amount,
      String tableID,
      String reason,
    )?
    initiateRefund,
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
    required TResult Function(_ConfirmFlightBooking value) confirmFlightBooking,
    required TResult Function(_SaveFinalBooking value) saveFinalBooking,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_ResetBooking value) resetBooking,
  }) {
    return resetBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRePrice value)? getRePrice,
    TResult? Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult? Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_ResetBooking value)? resetBooking,
  }) {
    return resetBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRePrice value)? getRePrice,
    TResult Function(_ConfirmFlightBooking value)? confirmFlightBooking,
    TResult Function(_SaveFinalBooking value)? saveFinalBooking,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_ResetBooking value)? resetBooking,
    required TResult orElse(),
  }) {
    if (resetBooking != null) {
      return resetBooking(this);
    }
    return orElse();
  }
}

abstract class _ResetBooking implements BookingEvent {
  const factory _ResetBooking() = _$ResetBookingImpl;
}

/// @nodoc
mixin _$BookingState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isRepriceLoading => throw _privateConstructorUsedError;
  bool get isRepriceCompleted =>
      throw _privateConstructorUsedError; // Booking Data
  BBBookingRequest? get bookingdata => throw _privateConstructorUsedError;
  String? get bookingError => throw _privateConstructorUsedError;
  bool? get isBookingConfirmed => throw _privateConstructorUsedError;
  String? get alhindPnr => throw _privateConstructorUsedError;
  String? get tableID => throw _privateConstructorUsedError;
  double? get totalCommission => throw _privateConstructorUsedError;
  double? get totalAmountWithCommission =>
      throw _privateConstructorUsedError; // Razorpay Data
  String? get razorpayOrderId => throw _privateConstructorUsedError;
  String? get razorpayPaymentId => throw _privateConstructorUsedError;
  String? get razorpaySignature =>
      throw _privateConstructorUsedError; // Process Flags
  bool? get isCreatingOrder => throw _privateConstructorUsedError;
  bool? get isPaymentProcessing => throw _privateConstructorUsedError;
  bool? get isConfirmingBooking => throw _privateConstructorUsedError;
  bool? get isSavingFinalBooking => throw _privateConstructorUsedError;
  bool? get isRefundProcessing =>
      throw _privateConstructorUsedError; // Status Flags
  bool? get paymentFailed => throw _privateConstructorUsedError;
  bool? get bookingFailed => throw _privateConstructorUsedError;
  bool? get refundRequired => throw _privateConstructorUsedError;
  bool? get refundInitiated => throw _privateConstructorUsedError;
  bool? get refundFailed => throw _privateConstructorUsedError;
  bool? get isBookingCompleted =>
      throw _privateConstructorUsedError; // Temporary data
  String? get tempBookingId => throw _privateConstructorUsedError;
  double? get tempAmount => throw _privateConstructorUsedError;

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
    bool isRepriceLoading,
    bool isRepriceCompleted,
    BBBookingRequest? bookingdata,
    String? bookingError,
    bool? isBookingConfirmed,
    String? alhindPnr,
    String? tableID,
    double? totalCommission,
    double? totalAmountWithCommission,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? razorpaySignature,
    bool? isCreatingOrder,
    bool? isPaymentProcessing,
    bool? isConfirmingBooking,
    bool? isSavingFinalBooking,
    bool? isRefundProcessing,
    bool? paymentFailed,
    bool? bookingFailed,
    bool? refundRequired,
    bool? refundInitiated,
    bool? refundFailed,
    bool? isBookingCompleted,
    String? tempBookingId,
    double? tempAmount,
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
    Object? isRepriceLoading = null,
    Object? isRepriceCompleted = null,
    Object? bookingdata = freezed,
    Object? bookingError = freezed,
    Object? isBookingConfirmed = freezed,
    Object? alhindPnr = freezed,
    Object? tableID = freezed,
    Object? totalCommission = freezed,
    Object? totalAmountWithCommission = freezed,
    Object? razorpayOrderId = freezed,
    Object? razorpayPaymentId = freezed,
    Object? razorpaySignature = freezed,
    Object? isCreatingOrder = freezed,
    Object? isPaymentProcessing = freezed,
    Object? isConfirmingBooking = freezed,
    Object? isSavingFinalBooking = freezed,
    Object? isRefundProcessing = freezed,
    Object? paymentFailed = freezed,
    Object? bookingFailed = freezed,
    Object? refundRequired = freezed,
    Object? refundInitiated = freezed,
    Object? refundFailed = freezed,
    Object? isBookingCompleted = freezed,
    Object? tempBookingId = freezed,
    Object? tempAmount = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRepriceLoading: null == isRepriceLoading
                ? _value.isRepriceLoading
                : isRepriceLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRepriceCompleted: null == isRepriceCompleted
                ? _value.isRepriceCompleted
                : isRepriceCompleted // ignore: cast_nullable_to_non_nullable
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
            tableID: freezed == tableID
                ? _value.tableID
                : tableID // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalCommission: freezed == totalCommission
                ? _value.totalCommission
                : totalCommission // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalAmountWithCommission: freezed == totalAmountWithCommission
                ? _value.totalAmountWithCommission
                : totalAmountWithCommission // ignore: cast_nullable_to_non_nullable
                      as double?,
            razorpayOrderId: freezed == razorpayOrderId
                ? _value.razorpayOrderId
                : razorpayOrderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            razorpayPaymentId: freezed == razorpayPaymentId
                ? _value.razorpayPaymentId
                : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            razorpaySignature: freezed == razorpaySignature
                ? _value.razorpaySignature
                : razorpaySignature // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCreatingOrder: freezed == isCreatingOrder
                ? _value.isCreatingOrder
                : isCreatingOrder // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isPaymentProcessing: freezed == isPaymentProcessing
                ? _value.isPaymentProcessing
                : isPaymentProcessing // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isConfirmingBooking: freezed == isConfirmingBooking
                ? _value.isConfirmingBooking
                : isConfirmingBooking // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isSavingFinalBooking: freezed == isSavingFinalBooking
                ? _value.isSavingFinalBooking
                : isSavingFinalBooking // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isRefundProcessing: freezed == isRefundProcessing
                ? _value.isRefundProcessing
                : isRefundProcessing // ignore: cast_nullable_to_non_nullable
                      as bool?,
            paymentFailed: freezed == paymentFailed
                ? _value.paymentFailed
                : paymentFailed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            bookingFailed: freezed == bookingFailed
                ? _value.bookingFailed
                : bookingFailed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            refundRequired: freezed == refundRequired
                ? _value.refundRequired
                : refundRequired // ignore: cast_nullable_to_non_nullable
                      as bool?,
            refundInitiated: freezed == refundInitiated
                ? _value.refundInitiated
                : refundInitiated // ignore: cast_nullable_to_non_nullable
                      as bool?,
            refundFailed: freezed == refundFailed
                ? _value.refundFailed
                : refundFailed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isBookingCompleted: freezed == isBookingCompleted
                ? _value.isBookingCompleted
                : isBookingCompleted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            tempBookingId: freezed == tempBookingId
                ? _value.tempBookingId
                : tempBookingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tempAmount: freezed == tempAmount
                ? _value.tempAmount
                : tempAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
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
    bool isRepriceLoading,
    bool isRepriceCompleted,
    BBBookingRequest? bookingdata,
    String? bookingError,
    bool? isBookingConfirmed,
    String? alhindPnr,
    String? tableID,
    double? totalCommission,
    double? totalAmountWithCommission,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? razorpaySignature,
    bool? isCreatingOrder,
    bool? isPaymentProcessing,
    bool? isConfirmingBooking,
    bool? isSavingFinalBooking,
    bool? isRefundProcessing,
    bool? paymentFailed,
    bool? bookingFailed,
    bool? refundRequired,
    bool? refundInitiated,
    bool? refundFailed,
    bool? isBookingCompleted,
    String? tempBookingId,
    double? tempAmount,
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
    Object? isRepriceLoading = null,
    Object? isRepriceCompleted = null,
    Object? bookingdata = freezed,
    Object? bookingError = freezed,
    Object? isBookingConfirmed = freezed,
    Object? alhindPnr = freezed,
    Object? tableID = freezed,
    Object? totalCommission = freezed,
    Object? totalAmountWithCommission = freezed,
    Object? razorpayOrderId = freezed,
    Object? razorpayPaymentId = freezed,
    Object? razorpaySignature = freezed,
    Object? isCreatingOrder = freezed,
    Object? isPaymentProcessing = freezed,
    Object? isConfirmingBooking = freezed,
    Object? isSavingFinalBooking = freezed,
    Object? isRefundProcessing = freezed,
    Object? paymentFailed = freezed,
    Object? bookingFailed = freezed,
    Object? refundRequired = freezed,
    Object? refundInitiated = freezed,
    Object? refundFailed = freezed,
    Object? isBookingCompleted = freezed,
    Object? tempBookingId = freezed,
    Object? tempAmount = freezed,
  }) {
    return _then(
      _$BookingStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRepriceLoading: null == isRepriceLoading
            ? _value.isRepriceLoading
            : isRepriceLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRepriceCompleted: null == isRepriceCompleted
            ? _value.isRepriceCompleted
            : isRepriceCompleted // ignore: cast_nullable_to_non_nullable
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
        tableID: freezed == tableID
            ? _value.tableID
            : tableID // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalCommission: freezed == totalCommission
            ? _value.totalCommission
            : totalCommission // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalAmountWithCommission: freezed == totalAmountWithCommission
            ? _value.totalAmountWithCommission
            : totalAmountWithCommission // ignore: cast_nullable_to_non_nullable
                  as double?,
        razorpayOrderId: freezed == razorpayOrderId
            ? _value.razorpayOrderId
            : razorpayOrderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        razorpayPaymentId: freezed == razorpayPaymentId
            ? _value.razorpayPaymentId
            : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        razorpaySignature: freezed == razorpaySignature
            ? _value.razorpaySignature
            : razorpaySignature // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCreatingOrder: freezed == isCreatingOrder
            ? _value.isCreatingOrder
            : isCreatingOrder // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isPaymentProcessing: freezed == isPaymentProcessing
            ? _value.isPaymentProcessing
            : isPaymentProcessing // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isConfirmingBooking: freezed == isConfirmingBooking
            ? _value.isConfirmingBooking
            : isConfirmingBooking // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isSavingFinalBooking: freezed == isSavingFinalBooking
            ? _value.isSavingFinalBooking
            : isSavingFinalBooking // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isRefundProcessing: freezed == isRefundProcessing
            ? _value.isRefundProcessing
            : isRefundProcessing // ignore: cast_nullable_to_non_nullable
                  as bool?,
        paymentFailed: freezed == paymentFailed
            ? _value.paymentFailed
            : paymentFailed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        bookingFailed: freezed == bookingFailed
            ? _value.bookingFailed
            : bookingFailed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        refundRequired: freezed == refundRequired
            ? _value.refundRequired
            : refundRequired // ignore: cast_nullable_to_non_nullable
                  as bool?,
        refundInitiated: freezed == refundInitiated
            ? _value.refundInitiated
            : refundInitiated // ignore: cast_nullable_to_non_nullable
                  as bool?,
        refundFailed: freezed == refundFailed
            ? _value.refundFailed
            : refundFailed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isBookingCompleted: freezed == isBookingCompleted
            ? _value.isBookingCompleted
            : isBookingCompleted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        tempBookingId: freezed == tempBookingId
            ? _value.tempBookingId
            : tempBookingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tempAmount: freezed == tempAmount
            ? _value.tempAmount
            : tempAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$BookingStateImpl implements _BookingState {
  const _$BookingStateImpl({
    required this.isLoading,
    required this.isRepriceLoading,
    required this.isRepriceCompleted,
    this.bookingdata,
    this.bookingError,
    this.isBookingConfirmed,
    this.alhindPnr,
    this.tableID,
    this.totalCommission,
    this.totalAmountWithCommission,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    this.razorpaySignature,
    this.isCreatingOrder,
    this.isPaymentProcessing,
    this.isConfirmingBooking,
    this.isSavingFinalBooking,
    this.isRefundProcessing,
    this.paymentFailed,
    this.bookingFailed,
    this.refundRequired,
    this.refundInitiated,
    this.refundFailed,
    this.isBookingCompleted,
    this.tempBookingId,
    this.tempAmount,
  });

  @override
  final bool isLoading;
  @override
  final bool isRepriceLoading;
  @override
  final bool isRepriceCompleted;
  // Booking Data
  @override
  final BBBookingRequest? bookingdata;
  @override
  final String? bookingError;
  @override
  final bool? isBookingConfirmed;
  @override
  final String? alhindPnr;
  @override
  final String? tableID;
  @override
  final double? totalCommission;
  @override
  final double? totalAmountWithCommission;
  // Razorpay Data
  @override
  final String? razorpayOrderId;
  @override
  final String? razorpayPaymentId;
  @override
  final String? razorpaySignature;
  // Process Flags
  @override
  final bool? isCreatingOrder;
  @override
  final bool? isPaymentProcessing;
  @override
  final bool? isConfirmingBooking;
  @override
  final bool? isSavingFinalBooking;
  @override
  final bool? isRefundProcessing;
  // Status Flags
  @override
  final bool? paymentFailed;
  @override
  final bool? bookingFailed;
  @override
  final bool? refundRequired;
  @override
  final bool? refundInitiated;
  @override
  final bool? refundFailed;
  @override
  final bool? isBookingCompleted;
  // Temporary data
  @override
  final String? tempBookingId;
  @override
  final double? tempAmount;

  @override
  String toString() {
    return 'BookingState(isLoading: $isLoading, isRepriceLoading: $isRepriceLoading, isRepriceCompleted: $isRepriceCompleted, bookingdata: $bookingdata, bookingError: $bookingError, isBookingConfirmed: $isBookingConfirmed, alhindPnr: $alhindPnr, tableID: $tableID, totalCommission: $totalCommission, totalAmountWithCommission: $totalAmountWithCommission, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature, isCreatingOrder: $isCreatingOrder, isPaymentProcessing: $isPaymentProcessing, isConfirmingBooking: $isConfirmingBooking, isSavingFinalBooking: $isSavingFinalBooking, isRefundProcessing: $isRefundProcessing, paymentFailed: $paymentFailed, bookingFailed: $bookingFailed, refundRequired: $refundRequired, refundInitiated: $refundInitiated, refundFailed: $refundFailed, isBookingCompleted: $isBookingCompleted, tempBookingId: $tempBookingId, tempAmount: $tempAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isRepriceLoading, isRepriceLoading) ||
                other.isRepriceLoading == isRepriceLoading) &&
            (identical(other.isRepriceCompleted, isRepriceCompleted) ||
                other.isRepriceCompleted == isRepriceCompleted) &&
            (identical(other.bookingdata, bookingdata) ||
                other.bookingdata == bookingdata) &&
            (identical(other.bookingError, bookingError) ||
                other.bookingError == bookingError) &&
            (identical(other.isBookingConfirmed, isBookingConfirmed) ||
                other.isBookingConfirmed == isBookingConfirmed) &&
            (identical(other.alhindPnr, alhindPnr) ||
                other.alhindPnr == alhindPnr) &&
            (identical(other.tableID, tableID) || other.tableID == tableID) &&
            (identical(other.totalCommission, totalCommission) ||
                other.totalCommission == totalCommission) &&
            (identical(
                  other.totalAmountWithCommission,
                  totalAmountWithCommission,
                ) ||
                other.totalAmountWithCommission == totalAmountWithCommission) &&
            (identical(other.razorpayOrderId, razorpayOrderId) ||
                other.razorpayOrderId == razorpayOrderId) &&
            (identical(other.razorpayPaymentId, razorpayPaymentId) ||
                other.razorpayPaymentId == razorpayPaymentId) &&
            (identical(other.razorpaySignature, razorpaySignature) ||
                other.razorpaySignature == razorpaySignature) &&
            (identical(other.isCreatingOrder, isCreatingOrder) ||
                other.isCreatingOrder == isCreatingOrder) &&
            (identical(other.isPaymentProcessing, isPaymentProcessing) ||
                other.isPaymentProcessing == isPaymentProcessing) &&
            (identical(other.isConfirmingBooking, isConfirmingBooking) ||
                other.isConfirmingBooking == isConfirmingBooking) &&
            (identical(other.isSavingFinalBooking, isSavingFinalBooking) ||
                other.isSavingFinalBooking == isSavingFinalBooking) &&
            (identical(other.isRefundProcessing, isRefundProcessing) ||
                other.isRefundProcessing == isRefundProcessing) &&
            (identical(other.paymentFailed, paymentFailed) ||
                other.paymentFailed == paymentFailed) &&
            (identical(other.bookingFailed, bookingFailed) ||
                other.bookingFailed == bookingFailed) &&
            (identical(other.refundRequired, refundRequired) ||
                other.refundRequired == refundRequired) &&
            (identical(other.refundInitiated, refundInitiated) ||
                other.refundInitiated == refundInitiated) &&
            (identical(other.refundFailed, refundFailed) ||
                other.refundFailed == refundFailed) &&
            (identical(other.isBookingCompleted, isBookingCompleted) ||
                other.isBookingCompleted == isBookingCompleted) &&
            (identical(other.tempBookingId, tempBookingId) ||
                other.tempBookingId == tempBookingId) &&
            (identical(other.tempAmount, tempAmount) ||
                other.tempAmount == tempAmount));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    isLoading,
    isRepriceLoading,
    isRepriceCompleted,
    bookingdata,
    bookingError,
    isBookingConfirmed,
    alhindPnr,
    tableID,
    totalCommission,
    totalAmountWithCommission,
    razorpayOrderId,
    razorpayPaymentId,
    razorpaySignature,
    isCreatingOrder,
    isPaymentProcessing,
    isConfirmingBooking,
    isSavingFinalBooking,
    isRefundProcessing,
    paymentFailed,
    bookingFailed,
    refundRequired,
    refundInitiated,
    refundFailed,
    isBookingCompleted,
    tempBookingId,
    tempAmount,
  ]);

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
    required final bool isRepriceLoading,
    required final bool isRepriceCompleted,
    final BBBookingRequest? bookingdata,
    final String? bookingError,
    final bool? isBookingConfirmed,
    final String? alhindPnr,
    final String? tableID,
    final double? totalCommission,
    final double? totalAmountWithCommission,
    final String? razorpayOrderId,
    final String? razorpayPaymentId,
    final String? razorpaySignature,
    final bool? isCreatingOrder,
    final bool? isPaymentProcessing,
    final bool? isConfirmingBooking,
    final bool? isSavingFinalBooking,
    final bool? isRefundProcessing,
    final bool? paymentFailed,
    final bool? bookingFailed,
    final bool? refundRequired,
    final bool? refundInitiated,
    final bool? refundFailed,
    final bool? isBookingCompleted,
    final String? tempBookingId,
    final double? tempAmount,
  }) = _$BookingStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isRepriceLoading;
  @override
  bool get isRepriceCompleted; // Booking Data
  @override
  BBBookingRequest? get bookingdata;
  @override
  String? get bookingError;
  @override
  bool? get isBookingConfirmed;
  @override
  String? get alhindPnr;
  @override
  String? get tableID;
  @override
  double? get totalCommission;
  @override
  double? get totalAmountWithCommission; // Razorpay Data
  @override
  String? get razorpayOrderId;
  @override
  String? get razorpayPaymentId;
  @override
  String? get razorpaySignature; // Process Flags
  @override
  bool? get isCreatingOrder;
  @override
  bool? get isPaymentProcessing;
  @override
  bool? get isConfirmingBooking;
  @override
  bool? get isSavingFinalBooking;
  @override
  bool? get isRefundProcessing; // Status Flags
  @override
  bool? get paymentFailed;
  @override
  bool? get bookingFailed;
  @override
  bool? get refundRequired;
  @override
  bool? get refundInitiated;
  @override
  bool? get refundFailed;
  @override
  bool? get isBookingCompleted; // Temporary data
  @override
  String? get tempBookingId;
  @override
  double? get tempAmount;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingStateImplCopyWith<_$BookingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
