// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hotel_booking_confirm_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HotelBookingConfirmEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )
    createOrder,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )
    verifyPayment,
    required TResult Function() reset,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult? Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult? Function()? reset,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult Function()? reset,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateOrder value) createOrder,
    required TResult Function(_VerifyPayment value) verifyPayment,
    required TResult Function(_Reset value) reset,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateOrder value)? createOrder,
    TResult? Function(_VerifyPayment value)? verifyPayment,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateOrder value)? createOrder,
    TResult Function(_VerifyPayment value)? verifyPayment,
    TResult Function(_Reset value)? reset,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotelBookingConfirmEventCopyWith<$Res> {
  factory $HotelBookingConfirmEventCopyWith(
    HotelBookingConfirmEvent value,
    $Res Function(HotelBookingConfirmEvent) then,
  ) = _$HotelBookingConfirmEventCopyWithImpl<$Res, HotelBookingConfirmEvent>;
}

/// @nodoc
class _$HotelBookingConfirmEventCopyWithImpl<
  $Res,
  $Val extends HotelBookingConfirmEvent
>
    implements $HotelBookingConfirmEventCopyWith<$Res> {
  _$HotelBookingConfirmEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreateOrderImplCopyWith<$Res> {
  factory _$$CreateOrderImplCopyWith(
    _$CreateOrderImpl value,
    $Res Function(_$CreateOrderImpl) then,
  ) = __$$CreateOrderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String userId,
    Map<String, dynamic> bookingPayload,
    double amount,
    double serviceCharge,
  });
}

/// @nodoc
class __$$CreateOrderImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$CreateOrderImpl>
    implements _$$CreateOrderImplCopyWith<$Res> {
  __$$CreateOrderImplCopyWithImpl(
    _$CreateOrderImpl _value,
    $Res Function(_$CreateOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? bookingPayload = null,
    Object? amount = null,
    Object? serviceCharge = null,
  }) {
    return _then(
      _$CreateOrderImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingPayload: null == bookingPayload
            ? _value._bookingPayload
            : bookingPayload // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        serviceCharge: null == serviceCharge
            ? _value.serviceCharge
            : serviceCharge // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$CreateOrderImpl implements _CreateOrder {
  const _$CreateOrderImpl({
    required this.userId,
    required final Map<String, dynamic> bookingPayload,
    required this.amount,
    required this.serviceCharge,
  }) : _bookingPayload = bookingPayload;

  @override
  final String userId;
  final Map<String, dynamic> _bookingPayload;
  @override
  Map<String, dynamic> get bookingPayload {
    if (_bookingPayload is EqualUnmodifiableMapView) return _bookingPayload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bookingPayload);
  }

  @override
  final double amount;
  @override
  final double serviceCharge;

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.createOrder(userId: $userId, bookingPayload: $bookingPayload, amount: $amount, serviceCharge: $serviceCharge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOrderImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(
              other._bookingPayload,
              _bookingPayload,
            ) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.serviceCharge, serviceCharge) ||
                other.serviceCharge == serviceCharge));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    const DeepCollectionEquality().hash(_bookingPayload),
    amount,
    serviceCharge,
  );

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOrderImplCopyWith<_$CreateOrderImpl> get copyWith =>
      __$$CreateOrderImplCopyWithImpl<_$CreateOrderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )
    createOrder,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )
    verifyPayment,
    required TResult Function() reset,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return createOrder(userId, bookingPayload, amount, serviceCharge);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult? Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult? Function()? reset,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return createOrder?.call(userId, bookingPayload, amount, serviceCharge);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult Function()? reset,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (createOrder != null) {
      return createOrder(userId, bookingPayload, amount, serviceCharge);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateOrder value) createOrder,
    required TResult Function(_VerifyPayment value) verifyPayment,
    required TResult Function(_Reset value) reset,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return createOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateOrder value)? createOrder,
    TResult? Function(_VerifyPayment value)? verifyPayment,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return createOrder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateOrder value)? createOrder,
    TResult Function(_VerifyPayment value)? verifyPayment,
    TResult Function(_Reset value)? reset,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (createOrder != null) {
      return createOrder(this);
    }
    return orElse();
  }
}

abstract class _CreateOrder implements HotelBookingConfirmEvent {
  const factory _CreateOrder({
    required final String userId,
    required final Map<String, dynamic> bookingPayload,
    required final double amount,
    required final double serviceCharge,
  }) = _$CreateOrderImpl;

  String get userId;
  Map<String, dynamic> get bookingPayload;
  double get amount;
  double get serviceCharge;

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateOrderImplCopyWith<_$CreateOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyPaymentImplCopyWith<$Res> {
  factory _$$VerifyPaymentImplCopyWith(
    _$VerifyPaymentImpl value,
    $Res Function(_$VerifyPaymentImpl) then,
  ) = __$$VerifyPaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String paymentId,
    String orderId,
    String signature,
    String traceId,
    String tokenId,
  });
}

/// @nodoc
class __$$VerifyPaymentImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$VerifyPaymentImpl>
    implements _$$VerifyPaymentImplCopyWith<$Res> {
  __$$VerifyPaymentImplCopyWithImpl(
    _$VerifyPaymentImpl _value,
    $Res Function(_$VerifyPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? orderId = null,
    Object? signature = null,
    Object? traceId = null,
    Object? tokenId = null,
  }) {
    return _then(
      _$VerifyPaymentImpl(
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
        traceId: null == traceId
            ? _value.traceId
            : traceId // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenId: null == tokenId
            ? _value.tokenId
            : tokenId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$VerifyPaymentImpl implements _VerifyPayment {
  const _$VerifyPaymentImpl({
    required this.paymentId,
    required this.orderId,
    required this.signature,
    required this.traceId,
    required this.tokenId,
  });

  @override
  final String paymentId;
  @override
  final String orderId;
  @override
  final String signature;
  @override
  final String traceId;
  @override
  final String tokenId;

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.verifyPayment(paymentId: $paymentId, orderId: $orderId, signature: $signature, traceId: $traceId, tokenId: $tokenId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyPaymentImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, paymentId, orderId, signature, traceId, tokenId);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyPaymentImplCopyWith<_$VerifyPaymentImpl> get copyWith =>
      __$$VerifyPaymentImplCopyWithImpl<_$VerifyPaymentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )
    createOrder,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )
    verifyPayment,
    required TResult Function() reset,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return verifyPayment(paymentId, orderId, signature, traceId, tokenId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult? Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult? Function()? reset,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return verifyPayment?.call(paymentId, orderId, signature, traceId, tokenId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult Function()? reset,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (verifyPayment != null) {
      return verifyPayment(paymentId, orderId, signature, traceId, tokenId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateOrder value) createOrder,
    required TResult Function(_VerifyPayment value) verifyPayment,
    required TResult Function(_Reset value) reset,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return verifyPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateOrder value)? createOrder,
    TResult? Function(_VerifyPayment value)? verifyPayment,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return verifyPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateOrder value)? createOrder,
    TResult Function(_VerifyPayment value)? verifyPayment,
    TResult Function(_Reset value)? reset,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (verifyPayment != null) {
      return verifyPayment(this);
    }
    return orElse();
  }
}

abstract class _VerifyPayment implements HotelBookingConfirmEvent {
  const factory _VerifyPayment({
    required final String paymentId,
    required final String orderId,
    required final String signature,
    required final String traceId,
    required final String tokenId,
  }) = _$VerifyPaymentImpl;

  String get paymentId;
  String get orderId;
  String get signature;
  String get traceId;
  String get tokenId;

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyPaymentImplCopyWith<_$VerifyPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
    _$ResetImpl value,
    $Res Function(_$ResetImpl) then,
  ) = __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
    _$ResetImpl _value,
    $Res Function(_$ResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )
    createOrder,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )
    verifyPayment,
    required TResult Function() reset,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult? Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult? Function()? reset,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult Function()? reset,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateOrder value) createOrder,
    required TResult Function(_VerifyPayment value) verifyPayment,
    required TResult Function(_Reset value) reset,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateOrder value)? createOrder,
    TResult? Function(_VerifyPayment value)? verifyPayment,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateOrder value)? createOrder,
    TResult Function(_VerifyPayment value)? verifyPayment,
    TResult Function(_Reset value)? reset,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements HotelBookingConfirmEvent {
  const factory _Reset() = _$ResetImpl;
}

/// @nodoc
abstract class _$$StartLoadingImplCopyWith<$Res> {
  factory _$$StartLoadingImplCopyWith(
    _$StartLoadingImpl value,
    $Res Function(_$StartLoadingImpl) then,
  ) = __$$StartLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartLoadingImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$StartLoadingImpl>
    implements _$$StartLoadingImplCopyWith<$Res> {
  __$$StartLoadingImplCopyWithImpl(
    _$StartLoadingImpl _value,
    $Res Function(_$StartLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartLoadingImpl implements _StartLoading {
  const _$StartLoadingImpl();

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.startLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )
    createOrder,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )
    verifyPayment,
    required TResult Function() reset,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return startLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult? Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult? Function()? reset,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return startLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult Function()? reset,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (startLoading != null) {
      return startLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateOrder value) createOrder,
    required TResult Function(_VerifyPayment value) verifyPayment,
    required TResult Function(_Reset value) reset,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return startLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateOrder value)? createOrder,
    TResult? Function(_VerifyPayment value)? verifyPayment,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return startLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateOrder value)? createOrder,
    TResult Function(_VerifyPayment value)? verifyPayment,
    TResult Function(_Reset value)? reset,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (startLoading != null) {
      return startLoading(this);
    }
    return orElse();
  }
}

abstract class _StartLoading implements HotelBookingConfirmEvent {
  const factory _StartLoading() = _$StartLoadingImpl;
}

/// @nodoc
abstract class _$$StopLoadingImplCopyWith<$Res> {
  factory _$$StopLoadingImplCopyWith(
    _$StopLoadingImpl value,
    $Res Function(_$StopLoadingImpl) then,
  ) = __$$StopLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopLoadingImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$StopLoadingImpl>
    implements _$$StopLoadingImplCopyWith<$Res> {
  __$$StopLoadingImplCopyWithImpl(
    _$StopLoadingImpl _value,
    $Res Function(_$StopLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopLoadingImpl implements _StopLoading {
  const _$StopLoadingImpl();

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.stopLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )
    createOrder,
    required TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )
    verifyPayment,
    required TResult Function() reset,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return stopLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult? Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult? Function()? reset,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return stopLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String userId,
      Map<String, dynamic> bookingPayload,
      double amount,
      double serviceCharge,
    )?
    createOrder,
    TResult Function(
      String paymentId,
      String orderId,
      String signature,
      String traceId,
      String tokenId,
    )?
    verifyPayment,
    TResult Function()? reset,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (stopLoading != null) {
      return stopLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateOrder value) createOrder,
    required TResult Function(_VerifyPayment value) verifyPayment,
    required TResult Function(_Reset value) reset,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return stopLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateOrder value)? createOrder,
    TResult? Function(_VerifyPayment value)? verifyPayment,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return stopLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateOrder value)? createOrder,
    TResult Function(_VerifyPayment value)? verifyPayment,
    TResult Function(_Reset value)? reset,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (stopLoading != null) {
      return stopLoading(this);
    }
    return orElse();
  }
}

abstract class _StopLoading implements HotelBookingConfirmEvent {
  const factory _StopLoading() = _$StopLoadingImpl;
}

/// @nodoc
mixin _$HotelBookingConfirmState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(Map<String, dynamic> orderData) orderCreated,
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message, Map<String, dynamic>? data) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(Map<String, dynamic> orderData)? orderCreated,
    TResult? Function(Map<String, dynamic> data)? success,
    TResult? Function(String message, Map<String, dynamic>? data)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(Map<String, dynamic> orderData)? orderCreated,
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message, Map<String, dynamic>? data)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmOrderCreated value)
    orderCreated,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotelBookingConfirmStateCopyWith<$Res> {
  factory $HotelBookingConfirmStateCopyWith(
    HotelBookingConfirmState value,
    $Res Function(HotelBookingConfirmState) then,
  ) = _$HotelBookingConfirmStateCopyWithImpl<$Res, HotelBookingConfirmState>;
}

/// @nodoc
class _$HotelBookingConfirmStateCopyWithImpl<
  $Res,
  $Val extends HotelBookingConfirmState
>
    implements $HotelBookingConfirmStateCopyWith<$Res> {
  _$HotelBookingConfirmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HotelBookingConfirmInitialImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmInitialImplCopyWith(
    _$HotelBookingConfirmInitialImpl value,
    $Res Function(_$HotelBookingConfirmInitialImpl) then,
  ) = __$$HotelBookingConfirmInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HotelBookingConfirmInitialImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmInitialImpl
        >
    implements _$$HotelBookingConfirmInitialImplCopyWith<$Res> {
  __$$HotelBookingConfirmInitialImplCopyWithImpl(
    _$HotelBookingConfirmInitialImpl _value,
    $Res Function(_$HotelBookingConfirmInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HotelBookingConfirmInitialImpl implements HotelBookingConfirmInitial {
  const _$HotelBookingConfirmInitialImpl();

  @override
  String toString() {
    return 'HotelBookingConfirmState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(Map<String, dynamic> orderData) orderCreated,
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message, Map<String, dynamic>? data) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(Map<String, dynamic> orderData)? orderCreated,
    TResult? Function(Map<String, dynamic> data)? success,
    TResult? Function(String message, Map<String, dynamic>? data)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(Map<String, dynamic> orderData)? orderCreated,
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message, Map<String, dynamic>? data)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmOrderCreated value)
    orderCreated,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmInitial implements HotelBookingConfirmState {
  const factory HotelBookingConfirmInitial() = _$HotelBookingConfirmInitialImpl;
}

/// @nodoc
abstract class _$$HotelBookingConfirmLoadingImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmLoadingImplCopyWith(
    _$HotelBookingConfirmLoadingImpl value,
    $Res Function(_$HotelBookingConfirmLoadingImpl) then,
  ) = __$$HotelBookingConfirmLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({HotelBookingConfirmState? previousState});

  $HotelBookingConfirmStateCopyWith<$Res>? get previousState;
}

/// @nodoc
class __$$HotelBookingConfirmLoadingImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmLoadingImpl
        >
    implements _$$HotelBookingConfirmLoadingImplCopyWith<$Res> {
  __$$HotelBookingConfirmLoadingImplCopyWithImpl(
    _$HotelBookingConfirmLoadingImpl _value,
    $Res Function(_$HotelBookingConfirmLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? previousState = freezed}) {
    return _then(
      _$HotelBookingConfirmLoadingImpl(
        previousState: freezed == previousState
            ? _value.previousState
            : previousState // ignore: cast_nullable_to_non_nullable
                  as HotelBookingConfirmState?,
      ),
    );
  }

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HotelBookingConfirmStateCopyWith<$Res>? get previousState {
    if (_value.previousState == null) {
      return null;
    }

    return $HotelBookingConfirmStateCopyWith<$Res>(_value.previousState!, (
      value,
    ) {
      return _then(_value.copyWith(previousState: value));
    });
  }
}

/// @nodoc

class _$HotelBookingConfirmLoadingImpl implements HotelBookingConfirmLoading {
  const _$HotelBookingConfirmLoadingImpl({this.previousState});

  @override
  final HotelBookingConfirmState? previousState;

  @override
  String toString() {
    return 'HotelBookingConfirmState.loading(previousState: $previousState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmLoadingImpl &&
            (identical(other.previousState, previousState) ||
                other.previousState == previousState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, previousState);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmLoadingImplCopyWith<_$HotelBookingConfirmLoadingImpl>
  get copyWith =>
      __$$HotelBookingConfirmLoadingImplCopyWithImpl<
        _$HotelBookingConfirmLoadingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(Map<String, dynamic> orderData) orderCreated,
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message, Map<String, dynamic>? data) error,
  }) {
    return loading(previousState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(Map<String, dynamic> orderData)? orderCreated,
    TResult? Function(Map<String, dynamic> data)? success,
    TResult? Function(String message, Map<String, dynamic>? data)? error,
  }) {
    return loading?.call(previousState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(Map<String, dynamic> orderData)? orderCreated,
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message, Map<String, dynamic>? data)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(previousState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmOrderCreated value)
    orderCreated,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmLoading implements HotelBookingConfirmState {
  const factory HotelBookingConfirmLoading({
    final HotelBookingConfirmState? previousState,
  }) = _$HotelBookingConfirmLoadingImpl;

  HotelBookingConfirmState? get previousState;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmLoadingImplCopyWith<_$HotelBookingConfirmLoadingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmOrderCreatedImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmOrderCreatedImplCopyWith(
    _$HotelBookingConfirmOrderCreatedImpl value,
    $Res Function(_$HotelBookingConfirmOrderCreatedImpl) then,
  ) = __$$HotelBookingConfirmOrderCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> orderData});
}

/// @nodoc
class __$$HotelBookingConfirmOrderCreatedImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmOrderCreatedImpl
        >
    implements _$$HotelBookingConfirmOrderCreatedImplCopyWith<$Res> {
  __$$HotelBookingConfirmOrderCreatedImplCopyWithImpl(
    _$HotelBookingConfirmOrderCreatedImpl _value,
    $Res Function(_$HotelBookingConfirmOrderCreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderData = null}) {
    return _then(
      _$HotelBookingConfirmOrderCreatedImpl(
        orderData: null == orderData
            ? _value._orderData
            : orderData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmOrderCreatedImpl
    implements HotelBookingConfirmOrderCreated {
  const _$HotelBookingConfirmOrderCreatedImpl({
    required final Map<String, dynamic> orderData,
  }) : _orderData = orderData;

  final Map<String, dynamic> _orderData;
  @override
  Map<String, dynamic> get orderData {
    if (_orderData is EqualUnmodifiableMapView) return _orderData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_orderData);
  }

  @override
  String toString() {
    return 'HotelBookingConfirmState.orderCreated(orderData: $orderData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmOrderCreatedImpl &&
            const DeepCollectionEquality().equals(
              other._orderData,
              _orderData,
            ));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orderData));

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmOrderCreatedImplCopyWith<
    _$HotelBookingConfirmOrderCreatedImpl
  >
  get copyWith =>
      __$$HotelBookingConfirmOrderCreatedImplCopyWithImpl<
        _$HotelBookingConfirmOrderCreatedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(Map<String, dynamic> orderData) orderCreated,
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message, Map<String, dynamic>? data) error,
  }) {
    return orderCreated(orderData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(Map<String, dynamic> orderData)? orderCreated,
    TResult? Function(Map<String, dynamic> data)? success,
    TResult? Function(String message, Map<String, dynamic>? data)? error,
  }) {
    return orderCreated?.call(orderData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(Map<String, dynamic> orderData)? orderCreated,
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message, Map<String, dynamic>? data)? error,
    required TResult orElse(),
  }) {
    if (orderCreated != null) {
      return orderCreated(orderData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmOrderCreated value)
    orderCreated,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmError value) error,
  }) {
    return orderCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmError value)? error,
  }) {
    return orderCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmError value)? error,
    required TResult orElse(),
  }) {
    if (orderCreated != null) {
      return orderCreated(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmOrderCreated
    implements HotelBookingConfirmState {
  const factory HotelBookingConfirmOrderCreated({
    required final Map<String, dynamic> orderData,
  }) = _$HotelBookingConfirmOrderCreatedImpl;

  Map<String, dynamic> get orderData;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmOrderCreatedImplCopyWith<
    _$HotelBookingConfirmOrderCreatedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmSuccessImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmSuccessImplCopyWith(
    _$HotelBookingConfirmSuccessImpl value,
    $Res Function(_$HotelBookingConfirmSuccessImpl) then,
  ) = __$$HotelBookingConfirmSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$HotelBookingConfirmSuccessImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmSuccessImpl
        >
    implements _$$HotelBookingConfirmSuccessImplCopyWith<$Res> {
  __$$HotelBookingConfirmSuccessImplCopyWithImpl(
    _$HotelBookingConfirmSuccessImpl _value,
    $Res Function(_$HotelBookingConfirmSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$HotelBookingConfirmSuccessImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmSuccessImpl implements HotelBookingConfirmSuccess {
  const _$HotelBookingConfirmSuccessImpl({
    required final Map<String, dynamic> data,
  }) : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'HotelBookingConfirmState.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmSuccessImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmSuccessImplCopyWith<_$HotelBookingConfirmSuccessImpl>
  get copyWith =>
      __$$HotelBookingConfirmSuccessImplCopyWithImpl<
        _$HotelBookingConfirmSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(Map<String, dynamic> orderData) orderCreated,
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message, Map<String, dynamic>? data) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(Map<String, dynamic> orderData)? orderCreated,
    TResult? Function(Map<String, dynamic> data)? success,
    TResult? Function(String message, Map<String, dynamic>? data)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(Map<String, dynamic> orderData)? orderCreated,
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message, Map<String, dynamic>? data)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmOrderCreated value)
    orderCreated,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmSuccess implements HotelBookingConfirmState {
  const factory HotelBookingConfirmSuccess({
    required final Map<String, dynamic> data,
  }) = _$HotelBookingConfirmSuccessImpl;

  Map<String, dynamic> get data;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmSuccessImplCopyWith<_$HotelBookingConfirmSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmErrorImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmErrorImplCopyWith(
    _$HotelBookingConfirmErrorImpl value,
    $Res Function(_$HotelBookingConfirmErrorImpl) then,
  ) = __$$HotelBookingConfirmErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, Map<String, dynamic>? data});
}

/// @nodoc
class __$$HotelBookingConfirmErrorImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmErrorImpl
        >
    implements _$$HotelBookingConfirmErrorImplCopyWith<$Res> {
  __$$HotelBookingConfirmErrorImplCopyWithImpl(
    _$HotelBookingConfirmErrorImpl _value,
    $Res Function(_$HotelBookingConfirmErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? data = freezed}) {
    return _then(
      _$HotelBookingConfirmErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmErrorImpl implements HotelBookingConfirmError {
  const _$HotelBookingConfirmErrorImpl({
    required this.message,
    final Map<String, dynamic>? data,
  }) : _data = data;

  @override
  final String message;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HotelBookingConfirmState.error(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmErrorImplCopyWith<_$HotelBookingConfirmErrorImpl>
  get copyWith =>
      __$$HotelBookingConfirmErrorImplCopyWithImpl<
        _$HotelBookingConfirmErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(Map<String, dynamic> orderData) orderCreated,
    required TResult Function(Map<String, dynamic> data) success,
    required TResult Function(String message, Map<String, dynamic>? data) error,
  }) {
    return error(message, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(Map<String, dynamic> orderData)? orderCreated,
    TResult? Function(Map<String, dynamic> data)? success,
    TResult? Function(String message, Map<String, dynamic>? data)? error,
  }) {
    return error?.call(message, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(Map<String, dynamic> orderData)? orderCreated,
    TResult Function(Map<String, dynamic> data)? success,
    TResult Function(String message, Map<String, dynamic>? data)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmOrderCreated value)
    orderCreated,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmOrderCreated value)? orderCreated,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmError implements HotelBookingConfirmState {
  const factory HotelBookingConfirmError({
    required final String message,
    final Map<String, dynamic>? data,
  }) = _$HotelBookingConfirmErrorImpl;

  String get message;
  Map<String, dynamic>? get data;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmErrorImplCopyWith<_$HotelBookingConfirmErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
