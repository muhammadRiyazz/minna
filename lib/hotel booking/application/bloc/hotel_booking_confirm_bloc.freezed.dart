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
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )
    paymentDone,
    required TResult Function(String orderId, String tableId, String bookingId)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    initiateRefund,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
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
abstract class _$$PaymentDoneImplCopyWith<$Res> {
  factory _$$PaymentDoneImplCopyWith(
    _$PaymentDoneImpl value,
    $Res Function(_$PaymentDoneImpl) then,
  ) = __$$PaymentDoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    String tableId,
    String bookingId,
    double amount,
    String prebookId,
    Map<String, dynamic> bookingRequest,
  });
}

/// @nodoc
class __$$PaymentDoneImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$PaymentDoneImpl>
    implements _$$PaymentDoneImplCopyWith<$Res> {
  __$$PaymentDoneImplCopyWithImpl(
    _$PaymentDoneImpl _value,
    $Res Function(_$PaymentDoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? tableId = null,
    Object? bookingId = null,
    Object? amount = null,
    Object? prebookId = null,
    Object? bookingRequest = null,
  }) {
    return _then(
      _$PaymentDoneImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        prebookId: null == prebookId
            ? _value.prebookId
            : prebookId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingRequest: null == bookingRequest
            ? _value._bookingRequest
            : bookingRequest // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$PaymentDoneImpl implements _PaymentDone {
  const _$PaymentDoneImpl({
    required this.orderId,
    required this.transactionId,
    required this.tableId,
    required this.bookingId,
    required this.amount,
    required this.prebookId,
    required final Map<String, dynamic> bookingRequest,
  }) : _bookingRequest = bookingRequest;

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final String tableId;
  @override
  final String bookingId;
  @override
  final double amount;
  @override
  final String prebookId;
  final Map<String, dynamic> _bookingRequest;
  @override
  Map<String, dynamic> get bookingRequest {
    if (_bookingRequest is EqualUnmodifiableMapView) return _bookingRequest;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bookingRequest);
  }

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.paymentDone(orderId: $orderId, transactionId: $transactionId, tableId: $tableId, bookingId: $bookingId, amount: $amount, prebookId: $prebookId, bookingRequest: $bookingRequest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDoneImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.prebookId, prebookId) ||
                other.prebookId == prebookId) &&
            const DeepCollectionEquality().equals(
              other._bookingRequest,
              _bookingRequest,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    tableId,
    bookingId,
    amount,
    prebookId,
    const DeepCollectionEquality().hash(_bookingRequest),
  );

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentDoneImplCopyWith<_$PaymentDoneImpl> get copyWith =>
      __$$PaymentDoneImplCopyWithImpl<_$PaymentDoneImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )
    paymentDone,
    required TResult Function(String orderId, String tableId, String bookingId)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    initiateRefund,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return paymentDone(
      orderId,
      transactionId,
      tableId,
      bookingId,
      amount,
      prebookId,
      bookingRequest,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return paymentDone?.call(
      orderId,
      transactionId,
      tableId,
      bookingId,
      amount,
      prebookId,
      bookingRequest,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (paymentDone != null) {
      return paymentDone(
        orderId,
        transactionId,
        tableId,
        bookingId,
        amount,
        prebookId,
        bookingRequest,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return paymentDone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return paymentDone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (paymentDone != null) {
      return paymentDone(this);
    }
    return orElse();
  }
}

abstract class _PaymentDone implements HotelBookingConfirmEvent {
  const factory _PaymentDone({
    required final String orderId,
    required final String transactionId,
    required final String tableId,
    required final String bookingId,
    required final double amount,
    required final String prebookId,
    required final Map<String, dynamic> bookingRequest,
  }) = _$PaymentDoneImpl;

  String get orderId;
  String get transactionId;
  String get tableId;
  String get bookingId;
  double get amount;
  String get prebookId;
  Map<String, dynamic> get bookingRequest;

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentDoneImplCopyWith<_$PaymentDoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentFailImplCopyWith<$Res> {
  factory _$$PaymentFailImplCopyWith(
    _$PaymentFailImpl value,
    $Res Function(_$PaymentFailImpl) then,
  ) = __$$PaymentFailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId, String tableId, String bookingId});
}

/// @nodoc
class __$$PaymentFailImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$PaymentFailImpl>
    implements _$$PaymentFailImplCopyWith<$Res> {
  __$$PaymentFailImplCopyWithImpl(
    _$PaymentFailImpl _value,
    $Res Function(_$PaymentFailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$PaymentFailImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentFailImpl implements _PaymentFail {
  const _$PaymentFailImpl({
    required this.orderId,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String orderId;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.paymentFail(orderId: $orderId, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentFailImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId, tableId, bookingId);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentFailImplCopyWith<_$PaymentFailImpl> get copyWith =>
      __$$PaymentFailImplCopyWithImpl<_$PaymentFailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )
    paymentDone,
    required TResult Function(String orderId, String tableId, String bookingId)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    initiateRefund,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return paymentFail(orderId, tableId, bookingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return paymentFail?.call(orderId, tableId, bookingId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (paymentFail != null) {
      return paymentFail(orderId, tableId, bookingId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return paymentFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return paymentFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (paymentFail != null) {
      return paymentFail(this);
    }
    return orElse();
  }
}

abstract class _PaymentFail implements HotelBookingConfirmEvent {
  const factory _PaymentFail({
    required final String orderId,
    required final String tableId,
    required final String bookingId,
  }) = _$PaymentFailImpl;

  String get orderId;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentFailImplCopyWith<_$PaymentFailImpl> get copyWith =>
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
    String transactionId,
    double amount,
    String tableId,
    String bookingId,
  });
}

/// @nodoc
class __$$InitiateRefundImplCopyWithImpl<$Res>
    extends _$HotelBookingConfirmEventCopyWithImpl<$Res, _$InitiateRefundImpl>
    implements _$$InitiateRefundImplCopyWith<$Res> {
  __$$InitiateRefundImplCopyWithImpl(
    _$InitiateRefundImpl _value,
    $Res Function(_$InitiateRefundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$InitiateRefundImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InitiateRefundImpl implements _InitiateRefund {
  const _$InitiateRefundImpl({
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmEvent.initiateRefund(orderId: $orderId, transactionId: $transactionId, amount: $amount, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateRefundImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    amount,
    tableId,
    bookingId,
  );

  /// Create a copy of HotelBookingConfirmEvent
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
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )
    paymentDone,
    required TResult Function(String orderId, String tableId, String bookingId)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    initiateRefund,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return initiateRefund(orderId, transactionId, amount, tableId, bookingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return initiateRefund?.call(
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult Function()? startLoading,
    TResult Function()? stopLoading,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(orderId, transactionId, amount, tableId, bookingId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return initiateRefund(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return initiateRefund?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    TResult Function(_StartLoading value)? startLoading,
    TResult Function(_StopLoading value)? stopLoading,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(this);
    }
    return orElse();
  }
}

abstract class _InitiateRefund implements HotelBookingConfirmEvent {
  const factory _InitiateRefund({
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableId,
    required final String bookingId,
  }) = _$InitiateRefundImpl;

  String get orderId;
  String get transactionId;
  double get amount;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateRefundImplCopyWith<_$InitiateRefundImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )
    paymentDone,
    required TResult Function(String orderId, String tableId, String bookingId)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    initiateRefund,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return startLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return startLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
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
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return startLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return startLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
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
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )
    paymentDone,
    required TResult Function(String orderId, String tableId, String bookingId)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    initiateRefund,
    required TResult Function() startLoading,
    required TResult Function() stopLoading,
  }) {
    return stopLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
    TResult? Function()? startLoading,
    TResult? Function()? stopLoading,
  }) {
    return stopLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      String tableId,
      String bookingId,
      double amount,
      String prebookId,
      Map<String, dynamic> bookingRequest,
    )?
    paymentDone,
    TResult Function(String orderId, String tableId, String bookingId)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    initiateRefund,
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
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
    required TResult Function(_StartLoading value) startLoading,
    required TResult Function(_StopLoading value) stopLoading,
  }) {
    return stopLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
    TResult? Function(_StartLoading value)? startLoading,
    TResult? Function(_StopLoading value)? stopLoading,
  }) {
    return stopLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
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
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
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
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
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
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
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
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return loading(previousState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return loading?.call(previousState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
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
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
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
abstract class _$$HotelBookingConfirmSuccessImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmSuccessImplCopyWith(
    _$HotelBookingConfirmSuccessImpl value,
    $Res Function(_$HotelBookingConfirmSuccessImpl) then,
  ) = __$$HotelBookingConfirmSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    Map<String, dynamic> data,
    String bookingId,
    String confirmationNo,
    String bookingRefNo,
  });
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
  $Res call({
    Object? data = null,
    Object? bookingId = null,
    Object? confirmationNo = null,
    Object? bookingRefNo = null,
  }) {
    return _then(
      _$HotelBookingConfirmSuccessImpl(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmationNo: null == confirmationNo
            ? _value.confirmationNo
            : confirmationNo // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingRefNo: null == bookingRefNo
            ? _value.bookingRefNo
            : bookingRefNo // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmSuccessImpl implements HotelBookingConfirmSuccess {
  const _$HotelBookingConfirmSuccessImpl({
    required final Map<String, dynamic> data,
    required this.bookingId,
    required this.confirmationNo,
    required this.bookingRefNo,
  }) : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final String bookingId;
  @override
  final String confirmationNo;
  @override
  final String bookingRefNo;

  @override
  String toString() {
    return 'HotelBookingConfirmState.success(data: $data, bookingId: $bookingId, confirmationNo: $confirmationNo, bookingRefNo: $bookingRefNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmSuccessImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.confirmationNo, confirmationNo) ||
                other.confirmationNo == confirmationNo) &&
            (identical(other.bookingRefNo, bookingRefNo) ||
                other.bookingRefNo == bookingRefNo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    bookingId,
    confirmationNo,
    bookingRefNo,
  );

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
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return success(data, bookingId, confirmationNo, bookingRefNo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return success?.call(data, bookingId, confirmationNo, bookingRefNo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, bookingId, confirmationNo, bookingRefNo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
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
    required final String bookingId,
    required final String confirmationNo,
    required final String bookingRefNo,
  }) = _$HotelBookingConfirmSuccessImpl;

  Map<String, dynamic> get data;
  String get bookingId;
  String get confirmationNo;
  String get bookingRefNo;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmSuccessImplCopyWith<_$HotelBookingConfirmSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmPaymentFailedImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmPaymentFailedImplCopyWith(
    _$HotelBookingConfirmPaymentFailedImpl value,
    $Res Function(_$HotelBookingConfirmPaymentFailedImpl) then,
  ) = __$$HotelBookingConfirmPaymentFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String orderId, String tableId, String bookingId});
}

/// @nodoc
class __$$HotelBookingConfirmPaymentFailedImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmPaymentFailedImpl
        >
    implements _$$HotelBookingConfirmPaymentFailedImplCopyWith<$Res> {
  __$$HotelBookingConfirmPaymentFailedImplCopyWithImpl(
    _$HotelBookingConfirmPaymentFailedImpl _value,
    $Res Function(_$HotelBookingConfirmPaymentFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$HotelBookingConfirmPaymentFailedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmPaymentFailedImpl
    implements HotelBookingConfirmPaymentFailed {
  const _$HotelBookingConfirmPaymentFailedImpl({
    required this.message,
    required this.orderId,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String message;
  @override
  final String orderId;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmState.paymentFailed(message: $message, orderId: $orderId, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmPaymentFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, orderId, tableId, bookingId);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmPaymentFailedImplCopyWith<
    _$HotelBookingConfirmPaymentFailedImpl
  >
  get copyWith =>
      __$$HotelBookingConfirmPaymentFailedImplCopyWithImpl<
        _$HotelBookingConfirmPaymentFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return paymentFailed(message, orderId, tableId, bookingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return paymentFailed?.call(message, orderId, tableId, bookingId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(message, orderId, tableId, bookingId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return paymentFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return paymentFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmPaymentFailed
    implements HotelBookingConfirmState {
  const factory HotelBookingConfirmPaymentFailed({
    required final String message,
    required final String orderId,
    required final String tableId,
    required final String bookingId,
  }) = _$HotelBookingConfirmPaymentFailedImpl;

  String get message;
  String get orderId;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmPaymentFailedImplCopyWith<
    _$HotelBookingConfirmPaymentFailedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmPaymentSavedFailedImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmPaymentSavedFailedImplCopyWith(
    _$HotelBookingConfirmPaymentSavedFailedImpl value,
    $Res Function(_$HotelBookingConfirmPaymentSavedFailedImpl) then,
  ) = __$$HotelBookingConfirmPaymentSavedFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    String orderId,
    String transactionId,
    double amount,
    String tableId,
    String bookingId,
    bool shouldRefund,
  });
}

/// @nodoc
class __$$HotelBookingConfirmPaymentSavedFailedImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmPaymentSavedFailedImpl
        >
    implements _$$HotelBookingConfirmPaymentSavedFailedImplCopyWith<$Res> {
  __$$HotelBookingConfirmPaymentSavedFailedImplCopyWithImpl(
    _$HotelBookingConfirmPaymentSavedFailedImpl _value,
    $Res Function(_$HotelBookingConfirmPaymentSavedFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableId = null,
    Object? bookingId = null,
    Object? shouldRefund = null,
  }) {
    return _then(
      _$HotelBookingConfirmPaymentSavedFailedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
        shouldRefund: null == shouldRefund
            ? _value.shouldRefund
            : shouldRefund // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmPaymentSavedFailedImpl
    implements HotelBookingConfirmPaymentSavedFailed {
  const _$HotelBookingConfirmPaymentSavedFailedImpl({
    required this.message,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableId,
    required this.bookingId,
    required this.shouldRefund,
  });

  @override
  final String message;
  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableId;
  @override
  final String bookingId;
  @override
  final bool shouldRefund;

  @override
  String toString() {
    return 'HotelBookingConfirmState.paymentSavedFailed(message: $message, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableId: $tableId, bookingId: $bookingId, shouldRefund: $shouldRefund)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmPaymentSavedFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.shouldRefund, shouldRefund) ||
                other.shouldRefund == shouldRefund));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    orderId,
    transactionId,
    amount,
    tableId,
    bookingId,
    shouldRefund,
  );

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmPaymentSavedFailedImplCopyWith<
    _$HotelBookingConfirmPaymentSavedFailedImpl
  >
  get copyWith =>
      __$$HotelBookingConfirmPaymentSavedFailedImplCopyWithImpl<
        _$HotelBookingConfirmPaymentSavedFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return paymentSavedFailed(
      message,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
      shouldRefund,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return paymentSavedFailed?.call(
      message,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
      shouldRefund,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (paymentSavedFailed != null) {
      return paymentSavedFailed(
        message,
        orderId,
        transactionId,
        amount,
        tableId,
        bookingId,
        shouldRefund,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return paymentSavedFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return paymentSavedFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentSavedFailed != null) {
      return paymentSavedFailed(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmPaymentSavedFailed
    implements HotelBookingConfirmState {
  const factory HotelBookingConfirmPaymentSavedFailed({
    required final String message,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableId,
    required final String bookingId,
    required final bool shouldRefund,
  }) = _$HotelBookingConfirmPaymentSavedFailedImpl;

  String get message;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableId;
  String get bookingId;
  bool get shouldRefund;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmPaymentSavedFailedImplCopyWith<
    _$HotelBookingConfirmPaymentSavedFailedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmErrorImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmErrorImplCopyWith(
    _$HotelBookingConfirmErrorImpl value,
    $Res Function(_$HotelBookingConfirmErrorImpl) then,
  ) = __$$HotelBookingConfirmErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    bool shouldRefund,
    String orderId,
    String transactionId,
    double amount,
    String tableId,
    String bookingId,
  });
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
  $Res call({
    Object? message = null,
    Object? shouldRefund = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$HotelBookingConfirmErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        shouldRefund: null == shouldRefund
            ? _value.shouldRefund
            : shouldRefund // ignore: cast_nullable_to_non_nullable
                  as bool,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmErrorImpl implements HotelBookingConfirmError {
  const _$HotelBookingConfirmErrorImpl({
    required this.message,
    required this.shouldRefund,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String message;
  @override
  final bool shouldRefund;
  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmState.error(message: $message, shouldRefund: $shouldRefund, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.shouldRefund, shouldRefund) ||
                other.shouldRefund == shouldRefund) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    shouldRefund,
    orderId,
    transactionId,
    amount,
    tableId,
    bookingId,
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
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return error(
      message,
      shouldRefund,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return error?.call(
      message,
      shouldRefund,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(
        message,
        shouldRefund,
        orderId,
        transactionId,
        amount,
        tableId,
        bookingId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
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
    required final bool shouldRefund,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableId,
    required final String bookingId,
  }) = _$HotelBookingConfirmErrorImpl;

  String get message;
  bool get shouldRefund;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmErrorImplCopyWith<_$HotelBookingConfirmErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmRefundProcessingImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmRefundProcessingImplCopyWith(
    _$HotelBookingConfirmRefundProcessingImpl value,
    $Res Function(_$HotelBookingConfirmRefundProcessingImpl) then,
  ) = __$$HotelBookingConfirmRefundProcessingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    double amount,
    String tableId,
    String bookingId,
  });
}

/// @nodoc
class __$$HotelBookingConfirmRefundProcessingImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmRefundProcessingImpl
        >
    implements _$$HotelBookingConfirmRefundProcessingImplCopyWith<$Res> {
  __$$HotelBookingConfirmRefundProcessingImplCopyWithImpl(
    _$HotelBookingConfirmRefundProcessingImpl _value,
    $Res Function(_$HotelBookingConfirmRefundProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$HotelBookingConfirmRefundProcessingImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmRefundProcessingImpl
    implements HotelBookingConfirmRefundProcessing {
  const _$HotelBookingConfirmRefundProcessingImpl({
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmState.refundProcessing(orderId: $orderId, transactionId: $transactionId, amount: $amount, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmRefundProcessingImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    amount,
    tableId,
    bookingId,
  );

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmRefundProcessingImplCopyWith<
    _$HotelBookingConfirmRefundProcessingImpl
  >
  get copyWith =>
      __$$HotelBookingConfirmRefundProcessingImplCopyWithImpl<
        _$HotelBookingConfirmRefundProcessingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return refundProcessing(orderId, transactionId, amount, tableId, bookingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return refundProcessing?.call(
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (refundProcessing != null) {
      return refundProcessing(
        orderId,
        transactionId,
        amount,
        tableId,
        bookingId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return refundProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return refundProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundProcessing != null) {
      return refundProcessing(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmRefundProcessing
    implements HotelBookingConfirmState {
  const factory HotelBookingConfirmRefundProcessing({
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableId,
    required final String bookingId,
  }) = _$HotelBookingConfirmRefundProcessingImpl;

  String get orderId;
  String get transactionId;
  double get amount;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmRefundProcessingImplCopyWith<
    _$HotelBookingConfirmRefundProcessingImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmRefundInitiatedImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmRefundInitiatedImplCopyWith(
    _$HotelBookingConfirmRefundInitiatedImpl value,
    $Res Function(_$HotelBookingConfirmRefundInitiatedImpl) then,
  ) = __$$HotelBookingConfirmRefundInitiatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    String orderId,
    String transactionId,
    double amount,
    String tableId,
    String bookingId,
  });
}

/// @nodoc
class __$$HotelBookingConfirmRefundInitiatedImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmRefundInitiatedImpl
        >
    implements _$$HotelBookingConfirmRefundInitiatedImplCopyWith<$Res> {
  __$$HotelBookingConfirmRefundInitiatedImplCopyWithImpl(
    _$HotelBookingConfirmRefundInitiatedImpl _value,
    $Res Function(_$HotelBookingConfirmRefundInitiatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$HotelBookingConfirmRefundInitiatedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmRefundInitiatedImpl
    implements HotelBookingConfirmRefundInitiated {
  const _$HotelBookingConfirmRefundInitiatedImpl({
    required this.message,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String message;
  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmState.refundInitiated(message: $message, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmRefundInitiatedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    orderId,
    transactionId,
    amount,
    tableId,
    bookingId,
  );

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmRefundInitiatedImplCopyWith<
    _$HotelBookingConfirmRefundInitiatedImpl
  >
  get copyWith =>
      __$$HotelBookingConfirmRefundInitiatedImplCopyWithImpl<
        _$HotelBookingConfirmRefundInitiatedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return refundInitiated(
      message,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return refundInitiated?.call(
      message,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (refundInitiated != null) {
      return refundInitiated(
        message,
        orderId,
        transactionId,
        amount,
        tableId,
        bookingId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return refundInitiated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return refundInitiated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundInitiated != null) {
      return refundInitiated(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmRefundInitiated
    implements HotelBookingConfirmState {
  const factory HotelBookingConfirmRefundInitiated({
    required final String message,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableId,
    required final String bookingId,
  }) = _$HotelBookingConfirmRefundInitiatedImpl;

  String get message;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmRefundInitiatedImplCopyWith<
    _$HotelBookingConfirmRefundInitiatedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HotelBookingConfirmRefundFailedImplCopyWith<$Res> {
  factory _$$HotelBookingConfirmRefundFailedImplCopyWith(
    _$HotelBookingConfirmRefundFailedImpl value,
    $Res Function(_$HotelBookingConfirmRefundFailedImpl) then,
  ) = __$$HotelBookingConfirmRefundFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    String orderId,
    String transactionId,
    double amount,
    String tableId,
    String bookingId,
  });
}

/// @nodoc
class __$$HotelBookingConfirmRefundFailedImplCopyWithImpl<$Res>
    extends
        _$HotelBookingConfirmStateCopyWithImpl<
          $Res,
          _$HotelBookingConfirmRefundFailedImpl
        >
    implements _$$HotelBookingConfirmRefundFailedImplCopyWith<$Res> {
  __$$HotelBookingConfirmRefundFailedImplCopyWithImpl(
    _$HotelBookingConfirmRefundFailedImpl _value,
    $Res Function(_$HotelBookingConfirmRefundFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableId = null,
    Object? bookingId = null,
  }) {
    return _then(
      _$HotelBookingConfirmRefundFailedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$HotelBookingConfirmRefundFailedImpl
    implements HotelBookingConfirmRefundFailed {
  const _$HotelBookingConfirmRefundFailedImpl({
    required this.message,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableId,
    required this.bookingId,
  });

  @override
  final String message;
  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableId;
  @override
  final String bookingId;

  @override
  String toString() {
    return 'HotelBookingConfirmState.refundFailed(message: $message, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableId: $tableId, bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelBookingConfirmRefundFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    orderId,
    transactionId,
    amount,
    tableId,
    bookingId,
  );

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelBookingConfirmRefundFailedImplCopyWith<
    _$HotelBookingConfirmRefundFailedImpl
  >
  get copyWith =>
      __$$HotelBookingConfirmRefundFailedImplCopyWithImpl<
        _$HotelBookingConfirmRefundFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HotelBookingConfirmState? previousState) loading,
    required TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )
    success,
    required TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )
    refundFailed,
  }) {
    return refundFailed(
      message,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HotelBookingConfirmState? previousState)? loading,
    TResult? Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult? Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
  }) {
    return refundFailed?.call(
      message,
      orderId,
      transactionId,
      amount,
      tableId,
      bookingId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HotelBookingConfirmState? previousState)? loading,
    TResult Function(
      Map<String, dynamic> data,
      String bookingId,
      String confirmationNo,
      String bookingRefNo,
    )?
    success,
    TResult Function(
      String message,
      String orderId,
      String tableId,
      String bookingId,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
      bool shouldRefund,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableId,
      String bookingId,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (refundFailed != null) {
      return refundFailed(
        message,
        orderId,
        transactionId,
        amount,
        tableId,
        bookingId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelBookingConfirmInitial value) initial,
    required TResult Function(HotelBookingConfirmLoading value) loading,
    required TResult Function(HotelBookingConfirmSuccess value) success,
    required TResult Function(HotelBookingConfirmPaymentFailed value)
    paymentFailed,
    required TResult Function(HotelBookingConfirmPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(HotelBookingConfirmError value) error,
    required TResult Function(HotelBookingConfirmRefundProcessing value)
    refundProcessing,
    required TResult Function(HotelBookingConfirmRefundInitiated value)
    refundInitiated,
    required TResult Function(HotelBookingConfirmRefundFailed value)
    refundFailed,
  }) {
    return refundFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelBookingConfirmInitial value)? initial,
    TResult? Function(HotelBookingConfirmLoading value)? loading,
    TResult? Function(HotelBookingConfirmSuccess value)? success,
    TResult? Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult? Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(HotelBookingConfirmError value)? error,
    TResult? Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult? Function(HotelBookingConfirmRefundInitiated value)?
    refundInitiated,
    TResult? Function(HotelBookingConfirmRefundFailed value)? refundFailed,
  }) {
    return refundFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelBookingConfirmInitial value)? initial,
    TResult Function(HotelBookingConfirmLoading value)? loading,
    TResult Function(HotelBookingConfirmSuccess value)? success,
    TResult Function(HotelBookingConfirmPaymentFailed value)? paymentFailed,
    TResult Function(HotelBookingConfirmPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(HotelBookingConfirmError value)? error,
    TResult Function(HotelBookingConfirmRefundProcessing value)?
    refundProcessing,
    TResult Function(HotelBookingConfirmRefundInitiated value)? refundInitiated,
    TResult Function(HotelBookingConfirmRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundFailed != null) {
      return refundFailed(this);
    }
    return orElse();
  }
}

abstract class HotelBookingConfirmRefundFailed
    implements HotelBookingConfirmState {
  const factory HotelBookingConfirmRefundFailed({
    required final String message,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableId,
    required final String bookingId,
  }) = _$HotelBookingConfirmRefundFailedImpl;

  String get message;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableId;
  String get bookingId;

  /// Create a copy of HotelBookingConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelBookingConfirmRefundFailedImplCopyWith<
    _$HotelBookingConfirmRefundFailedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
