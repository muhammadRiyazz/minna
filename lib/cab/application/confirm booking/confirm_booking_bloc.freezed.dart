// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_booking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConfirmBookingEvent {
  String get orderId => throw _privateConstructorUsedError;
  String get tableid => throw _privateConstructorUsedError;
  String get bookingid => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )
    paymentDone,
    required TResult Function(String orderId, String tableid, String bookingid)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfirmBookingEventCopyWith<ConfirmBookingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmBookingEventCopyWith<$Res> {
  factory $ConfirmBookingEventCopyWith(
    ConfirmBookingEvent value,
    $Res Function(ConfirmBookingEvent) then,
  ) = _$ConfirmBookingEventCopyWithImpl<$Res, ConfirmBookingEvent>;
  @useResult
  $Res call({String orderId, String tableid, String bookingid});
}

/// @nodoc
class _$ConfirmBookingEventCopyWithImpl<$Res, $Val extends ConfirmBookingEvent>
    implements $ConfirmBookingEventCopyWith<$Res> {
  _$ConfirmBookingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _value.copyWith(
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            tableid: null == tableid
                ? _value.tableid
                : tableid // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingid: null == bookingid
                ? _value.bookingid
                : bookingid // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentDoneImplCopyWith<$Res>
    implements $ConfirmBookingEventCopyWith<$Res> {
  factory _$$PaymentDoneImplCopyWith(
    _$PaymentDoneImpl value,
    $Res Function(_$PaymentDoneImpl) then,
  ) = __$$PaymentDoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    int status,
    String tableid,
    String table,
    String bookingid,
    double amount,
  });
}

/// @nodoc
class __$$PaymentDoneImplCopyWithImpl<$Res>
    extends _$ConfirmBookingEventCopyWithImpl<$Res, _$PaymentDoneImpl>
    implements _$$PaymentDoneImplCopyWith<$Res> {
  __$$PaymentDoneImplCopyWithImpl(
    _$PaymentDoneImpl _value,
    $Res Function(_$PaymentDoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? status = null,
    Object? tableid = null,
    Object? table = null,
    Object? bookingid = null,
    Object? amount = null,
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        table: null == table
            ? _value.table
            : table // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$PaymentDoneImpl implements _PaymentDone {
  const _$PaymentDoneImpl({
    required this.orderId,
    required this.transactionId,
    required this.status,
    required this.tableid,
    required this.table,
    required this.bookingid,
    required this.amount,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final int status;
  @override
  final String tableid;
  @override
  final String table;
  @override
  final String bookingid;
  @override
  final double amount;

  @override
  String toString() {
    return 'ConfirmBookingEvent.paymentDone(orderId: $orderId, transactionId: $transactionId, status: $status, tableid: $tableid, table: $table, bookingid: $bookingid, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDoneImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    status,
    tableid,
    table,
    bookingid,
    amount,
  );

  /// Create a copy of ConfirmBookingEvent
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
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )
    paymentDone,
    required TResult Function(String orderId, String tableid, String bookingid)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    initiateRefund,
  }) {
    return paymentDone(
      orderId,
      transactionId,
      status,
      tableid,
      table,
      bookingid,
      amount,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
  }) {
    return paymentDone?.call(
      orderId,
      transactionId,
      status,
      tableid,
      table,
      bookingid,
      amount,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (paymentDone != null) {
      return paymentDone(
        orderId,
        transactionId,
        status,
        tableid,
        table,
        bookingid,
        amount,
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
  }) {
    return paymentDone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
  }) {
    return paymentDone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (paymentDone != null) {
      return paymentDone(this);
    }
    return orElse();
  }
}

abstract class _PaymentDone implements ConfirmBookingEvent {
  const factory _PaymentDone({
    required final String orderId,
    required final String transactionId,
    required final int status,
    required final String tableid,
    required final String table,
    required final String bookingid,
    required final double amount,
  }) = _$PaymentDoneImpl;

  @override
  String get orderId;
  String get transactionId;
  int get status;
  @override
  String get tableid;
  String get table;
  @override
  String get bookingid;
  double get amount;

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentDoneImplCopyWith<_$PaymentDoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentFailImplCopyWith<$Res>
    implements $ConfirmBookingEventCopyWith<$Res> {
  factory _$$PaymentFailImplCopyWith(
    _$PaymentFailImpl value,
    $Res Function(_$PaymentFailImpl) then,
  ) = __$$PaymentFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderId, String tableid, String bookingid});
}

/// @nodoc
class __$$PaymentFailImplCopyWithImpl<$Res>
    extends _$ConfirmBookingEventCopyWithImpl<$Res, _$PaymentFailImpl>
    implements _$$PaymentFailImplCopyWith<$Res> {
  __$$PaymentFailImplCopyWithImpl(
    _$PaymentFailImpl _value,
    $Res Function(_$PaymentFailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$PaymentFailImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentFailImpl implements _PaymentFail {
  const _$PaymentFailImpl({
    required this.orderId,
    required this.tableid,
    required this.bookingid,
  });

  @override
  final String orderId;
  @override
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingEvent.paymentFail(orderId: $orderId, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentFailImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId, tableid, bookingid);

  /// Create a copy of ConfirmBookingEvent
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
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )
    paymentDone,
    required TResult Function(String orderId, String tableid, String bookingid)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    initiateRefund,
  }) {
    return paymentFail(orderId, tableid, bookingid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
  }) {
    return paymentFail?.call(orderId, tableid, bookingid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (paymentFail != null) {
      return paymentFail(orderId, tableid, bookingid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
  }) {
    return paymentFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
  }) {
    return paymentFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (paymentFail != null) {
      return paymentFail(this);
    }
    return orElse();
  }
}

abstract class _PaymentFail implements ConfirmBookingEvent {
  const factory _PaymentFail({
    required final String orderId,
    required final String tableid,
    required final String bookingid,
  }) = _$PaymentFailImpl;

  @override
  String get orderId;
  @override
  String get tableid;
  @override
  String get bookingid;

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentFailImplCopyWith<_$PaymentFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitiateRefundImplCopyWith<$Res>
    implements $ConfirmBookingEventCopyWith<$Res> {
  factory _$$InitiateRefundImplCopyWith(
    _$InitiateRefundImpl value,
    $Res Function(_$InitiateRefundImpl) then,
  ) = __$$InitiateRefundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    double amount,
    String tableid,
    String bookingid,
  });
}

/// @nodoc
class __$$InitiateRefundImplCopyWithImpl<$Res>
    extends _$ConfirmBookingEventCopyWithImpl<$Res, _$InitiateRefundImpl>
    implements _$$InitiateRefundImplCopyWith<$Res> {
  __$$InitiateRefundImplCopyWithImpl(
    _$InitiateRefundImpl _value,
    $Res Function(_$InitiateRefundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableid = null,
    Object? bookingid = null,
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
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
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
    required this.tableid,
    required this.bookingid,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingEvent.initiateRefund(orderId: $orderId, transactionId: $transactionId, amount: $amount, tableid: $tableid, bookingid: $bookingid)';
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
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    amount,
    tableid,
    bookingid,
  );

  /// Create a copy of ConfirmBookingEvent
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
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )
    paymentDone,
    required TResult Function(String orderId, String tableid, String bookingid)
    paymentFail,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    initiateRefund,
  }) {
    return initiateRefund(orderId, transactionId, amount, tableid, bookingid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult? Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
  }) {
    return initiateRefund?.call(
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String orderId,
      String transactionId,
      int status,
      String tableid,
      String table,
      String bookingid,
      double amount,
    )?
    paymentDone,
    TResult Function(String orderId, String tableid, String bookingid)?
    paymentFail,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(orderId, transactionId, amount, tableid, bookingid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PaymentDone value) paymentDone,
    required TResult Function(_PaymentFail value) paymentFail,
    required TResult Function(_InitiateRefund value) initiateRefund,
  }) {
    return initiateRefund(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PaymentDone value)? paymentDone,
    TResult? Function(_PaymentFail value)? paymentFail,
    TResult? Function(_InitiateRefund value)? initiateRefund,
  }) {
    return initiateRefund?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PaymentDone value)? paymentDone,
    TResult Function(_PaymentFail value)? paymentFail,
    TResult Function(_InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(this);
    }
    return orElse();
  }
}

abstract class _InitiateRefund implements ConfirmBookingEvent {
  const factory _InitiateRefund({
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableid,
    required final String bookingid,
  }) = _$InitiateRefundImpl;

  @override
  String get orderId;
  String get transactionId;
  double get amount;
  @override
  String get tableid;
  @override
  String get bookingid;

  /// Create a copy of ConfirmBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateRefundImplCopyWith<_$InitiateRefundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConfirmBookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmBookingStateCopyWith<$Res> {
  factory $ConfirmBookingStateCopyWith(
    ConfirmBookingState value,
    $Res Function(ConfirmBookingState) then,
  ) = _$ConfirmBookingStateCopyWithImpl<$Res, ConfirmBookingState>;
}

/// @nodoc
class _$ConfirmBookingStateCopyWithImpl<$Res, $Val extends ConfirmBookingState>
    implements $ConfirmBookingStateCopyWith<$Res> {
  _$ConfirmBookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConfirmBookingInitialImplCopyWith<$Res> {
  factory _$$ConfirmBookingInitialImplCopyWith(
    _$ConfirmBookingInitialImpl value,
    $Res Function(_$ConfirmBookingInitialImpl) then,
  ) = __$$ConfirmBookingInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfirmBookingInitialImplCopyWithImpl<$Res>
    extends _$ConfirmBookingStateCopyWithImpl<$Res, _$ConfirmBookingInitialImpl>
    implements _$$ConfirmBookingInitialImplCopyWith<$Res> {
  __$$ConfirmBookingInitialImplCopyWithImpl(
    _$ConfirmBookingInitialImpl _value,
    $Res Function(_$ConfirmBookingInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConfirmBookingInitialImpl implements ConfirmBookingInitial {
  const _$ConfirmBookingInitialImpl();

  @override
  String toString() {
    return 'ConfirmBookingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
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
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingInitial implements ConfirmBookingState {
  const factory ConfirmBookingInitial() = _$ConfirmBookingInitialImpl;
}

/// @nodoc
abstract class _$$ConfirmBookingLoadingImplCopyWith<$Res> {
  factory _$$ConfirmBookingLoadingImplCopyWith(
    _$ConfirmBookingLoadingImpl value,
    $Res Function(_$ConfirmBookingLoadingImpl) then,
  ) = __$$ConfirmBookingLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfirmBookingLoadingImplCopyWithImpl<$Res>
    extends _$ConfirmBookingStateCopyWithImpl<$Res, _$ConfirmBookingLoadingImpl>
    implements _$$ConfirmBookingLoadingImplCopyWith<$Res> {
  __$$ConfirmBookingLoadingImplCopyWithImpl(
    _$ConfirmBookingLoadingImpl _value,
    $Res Function(_$ConfirmBookingLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConfirmBookingLoadingImpl implements ConfirmBookingLoading {
  const _$ConfirmBookingLoadingImpl();

  @override
  String toString() {
    return 'ConfirmBookingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingLoading implements ConfirmBookingState {
  const factory ConfirmBookingLoading() = _$ConfirmBookingLoadingImpl;
}

/// @nodoc
abstract class _$$ConfirmBookingSuccessImplCopyWith<$Res> {
  factory _$$ConfirmBookingSuccessImplCopyWith(
    _$ConfirmBookingSuccessImpl value,
    $Res Function(_$ConfirmBookingSuccessImpl) then,
  ) = __$$ConfirmBookingSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BookingConfirmData data});
}

/// @nodoc
class __$$ConfirmBookingSuccessImplCopyWithImpl<$Res>
    extends _$ConfirmBookingStateCopyWithImpl<$Res, _$ConfirmBookingSuccessImpl>
    implements _$$ConfirmBookingSuccessImplCopyWith<$Res> {
  __$$ConfirmBookingSuccessImplCopyWithImpl(
    _$ConfirmBookingSuccessImpl _value,
    $Res Function(_$ConfirmBookingSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$ConfirmBookingSuccessImpl(
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as BookingConfirmData,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingSuccessImpl implements ConfirmBookingSuccess {
  const _$ConfirmBookingSuccessImpl({required this.data});

  @override
  final BookingConfirmData data;

  @override
  String toString() {
    return 'ConfirmBookingState.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingSuccessImplCopyWith<_$ConfirmBookingSuccessImpl>
  get copyWith =>
      __$$ConfirmBookingSuccessImplCopyWithImpl<_$ConfirmBookingSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
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
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingSuccess implements ConfirmBookingState {
  const factory ConfirmBookingSuccess({
    required final BookingConfirmData data,
  }) = _$ConfirmBookingSuccessImpl;

  BookingConfirmData get data;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingSuccessImplCopyWith<_$ConfirmBookingSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingPaymentFailedImplCopyWith<$Res> {
  factory _$$ConfirmBookingPaymentFailedImplCopyWith(
    _$ConfirmBookingPaymentFailedImpl value,
    $Res Function(_$ConfirmBookingPaymentFailedImpl) then,
  ) = __$$ConfirmBookingPaymentFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String orderId, String tableid, String bookingid});
}

/// @nodoc
class __$$ConfirmBookingPaymentFailedImplCopyWithImpl<$Res>
    extends
        _$ConfirmBookingStateCopyWithImpl<
          $Res,
          _$ConfirmBookingPaymentFailedImpl
        >
    implements _$$ConfirmBookingPaymentFailedImplCopyWith<$Res> {
  __$$ConfirmBookingPaymentFailedImplCopyWithImpl(
    _$ConfirmBookingPaymentFailedImpl _value,
    $Res Function(_$ConfirmBookingPaymentFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$ConfirmBookingPaymentFailedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingPaymentFailedImpl implements ConfirmBookingPaymentFailed {
  const _$ConfirmBookingPaymentFailedImpl({
    required this.message,
    required this.orderId,
    required this.tableid,
    required this.bookingid,
  });

  @override
  final String message;
  @override
  final String orderId;
  @override
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingState.paymentFailed(message: $message, orderId: $orderId, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingPaymentFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, orderId, tableid, bookingid);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingPaymentFailedImplCopyWith<_$ConfirmBookingPaymentFailedImpl>
  get copyWith =>
      __$$ConfirmBookingPaymentFailedImplCopyWithImpl<
        _$ConfirmBookingPaymentFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return paymentFailed(message, orderId, tableid, bookingid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return paymentFailed?.call(message, orderId, tableid, bookingid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(message, orderId, tableid, bookingid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return paymentFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return paymentFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingPaymentFailed implements ConfirmBookingState {
  const factory ConfirmBookingPaymentFailed({
    required final String message,
    required final String orderId,
    required final String tableid,
    required final String bookingid,
  }) = _$ConfirmBookingPaymentFailedImpl;

  String get message;
  String get orderId;
  String get tableid;
  String get bookingid;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingPaymentFailedImplCopyWith<_$ConfirmBookingPaymentFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingPaymentSavedFailedImplCopyWith<$Res> {
  factory _$$ConfirmBookingPaymentSavedFailedImplCopyWith(
    _$ConfirmBookingPaymentSavedFailedImpl value,
    $Res Function(_$ConfirmBookingPaymentSavedFailedImpl) then,
  ) = __$$ConfirmBookingPaymentSavedFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    String orderId,
    String transactionId,
    double amount,
    String tableid,
    String bookingid,
  });
}

/// @nodoc
class __$$ConfirmBookingPaymentSavedFailedImplCopyWithImpl<$Res>
    extends
        _$ConfirmBookingStateCopyWithImpl<
          $Res,
          _$ConfirmBookingPaymentSavedFailedImpl
        >
    implements _$$ConfirmBookingPaymentSavedFailedImplCopyWith<$Res> {
  __$$ConfirmBookingPaymentSavedFailedImplCopyWithImpl(
    _$ConfirmBookingPaymentSavedFailedImpl _value,
    $Res Function(_$ConfirmBookingPaymentSavedFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$ConfirmBookingPaymentSavedFailedImpl(
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
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingPaymentSavedFailedImpl
    implements ConfirmBookingPaymentSavedFailed {
  const _$ConfirmBookingPaymentSavedFailedImpl({
    required this.message,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableid,
    required this.bookingid,
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
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingState.paymentSavedFailed(message: $message, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingPaymentSavedFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    orderId,
    transactionId,
    amount,
    tableid,
    bookingid,
  );

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingPaymentSavedFailedImplCopyWith<
    _$ConfirmBookingPaymentSavedFailedImpl
  >
  get copyWith =>
      __$$ConfirmBookingPaymentSavedFailedImplCopyWithImpl<
        _$ConfirmBookingPaymentSavedFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return paymentSavedFailed(
      message,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return paymentSavedFailed?.call(
      message,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
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
        tableid,
        bookingid,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return paymentSavedFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return paymentSavedFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentSavedFailed != null) {
      return paymentSavedFailed(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingPaymentSavedFailed implements ConfirmBookingState {
  const factory ConfirmBookingPaymentSavedFailed({
    required final String message,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableid,
    required final String bookingid,
  }) = _$ConfirmBookingPaymentSavedFailedImpl;

  String get message;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableid;
  String get bookingid;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingPaymentSavedFailedImplCopyWith<
    _$ConfirmBookingPaymentSavedFailedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingErrorImplCopyWith<$Res> {
  factory _$$ConfirmBookingErrorImplCopyWith(
    _$ConfirmBookingErrorImpl value,
    $Res Function(_$ConfirmBookingErrorImpl) then,
  ) = __$$ConfirmBookingErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    bool shouldRefund,
    String orderId,
    String transactionId,
    double amount,
    String tableid,
    String bookingid,
  });
}

/// @nodoc
class __$$ConfirmBookingErrorImplCopyWithImpl<$Res>
    extends _$ConfirmBookingStateCopyWithImpl<$Res, _$ConfirmBookingErrorImpl>
    implements _$$ConfirmBookingErrorImplCopyWith<$Res> {
  __$$ConfirmBookingErrorImplCopyWithImpl(
    _$ConfirmBookingErrorImpl _value,
    $Res Function(_$ConfirmBookingErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? shouldRefund = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$ConfirmBookingErrorImpl(
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
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingErrorImpl implements ConfirmBookingError {
  const _$ConfirmBookingErrorImpl({
    required this.message,
    required this.shouldRefund,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableid,
    required this.bookingid,
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
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingState.error(message: $message, shouldRefund: $shouldRefund, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.shouldRefund, shouldRefund) ||
                other.shouldRefund == shouldRefund) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    shouldRefund,
    orderId,
    transactionId,
    amount,
    tableid,
    bookingid,
  );

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingErrorImplCopyWith<_$ConfirmBookingErrorImpl> get copyWith =>
      __$$ConfirmBookingErrorImplCopyWithImpl<_$ConfirmBookingErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return error(
      message,
      shouldRefund,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return error?.call(
      message,
      shouldRefund,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
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
        tableid,
        bookingid,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingError implements ConfirmBookingState {
  const factory ConfirmBookingError({
    required final String message,
    required final bool shouldRefund,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableid,
    required final String bookingid,
  }) = _$ConfirmBookingErrorImpl;

  String get message;
  bool get shouldRefund;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableid;
  String get bookingid;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingErrorImplCopyWith<_$ConfirmBookingErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingRefundProcessingImplCopyWith<$Res> {
  factory _$$ConfirmBookingRefundProcessingImplCopyWith(
    _$ConfirmBookingRefundProcessingImpl value,
    $Res Function(_$ConfirmBookingRefundProcessingImpl) then,
  ) = __$$ConfirmBookingRefundProcessingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    double amount,
    String tableid,
    String bookingid,
  });
}

/// @nodoc
class __$$ConfirmBookingRefundProcessingImplCopyWithImpl<$Res>
    extends
        _$ConfirmBookingStateCopyWithImpl<
          $Res,
          _$ConfirmBookingRefundProcessingImpl
        >
    implements _$$ConfirmBookingRefundProcessingImplCopyWith<$Res> {
  __$$ConfirmBookingRefundProcessingImplCopyWithImpl(
    _$ConfirmBookingRefundProcessingImpl _value,
    $Res Function(_$ConfirmBookingRefundProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$ConfirmBookingRefundProcessingImpl(
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
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingRefundProcessingImpl
    implements ConfirmBookingRefundProcessing {
  const _$ConfirmBookingRefundProcessingImpl({
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableid,
    required this.bookingid,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final double amount;
  @override
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingState.refundProcessing(orderId: $orderId, transactionId: $transactionId, amount: $amount, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingRefundProcessingImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    amount,
    tableid,
    bookingid,
  );

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingRefundProcessingImplCopyWith<
    _$ConfirmBookingRefundProcessingImpl
  >
  get copyWith =>
      __$$ConfirmBookingRefundProcessingImplCopyWithImpl<
        _$ConfirmBookingRefundProcessingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return refundProcessing(orderId, transactionId, amount, tableid, bookingid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return refundProcessing?.call(
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
    required TResult orElse(),
  }) {
    if (refundProcessing != null) {
      return refundProcessing(
        orderId,
        transactionId,
        amount,
        tableid,
        bookingid,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return refundProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return refundProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundProcessing != null) {
      return refundProcessing(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingRefundProcessing implements ConfirmBookingState {
  const factory ConfirmBookingRefundProcessing({
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableid,
    required final String bookingid,
  }) = _$ConfirmBookingRefundProcessingImpl;

  String get orderId;
  String get transactionId;
  double get amount;
  String get tableid;
  String get bookingid;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingRefundProcessingImplCopyWith<
    _$ConfirmBookingRefundProcessingImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingRefundInitiatedImplCopyWith<$Res> {
  factory _$$ConfirmBookingRefundInitiatedImplCopyWith(
    _$ConfirmBookingRefundInitiatedImpl value,
    $Res Function(_$ConfirmBookingRefundInitiatedImpl) then,
  ) = __$$ConfirmBookingRefundInitiatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    String orderId,
    String transactionId,
    double amount,
    String tableid,
    String bookingid,
  });
}

/// @nodoc
class __$$ConfirmBookingRefundInitiatedImplCopyWithImpl<$Res>
    extends
        _$ConfirmBookingStateCopyWithImpl<
          $Res,
          _$ConfirmBookingRefundInitiatedImpl
        >
    implements _$$ConfirmBookingRefundInitiatedImplCopyWith<$Res> {
  __$$ConfirmBookingRefundInitiatedImplCopyWithImpl(
    _$ConfirmBookingRefundInitiatedImpl _value,
    $Res Function(_$ConfirmBookingRefundInitiatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$ConfirmBookingRefundInitiatedImpl(
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
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingRefundInitiatedImpl
    implements ConfirmBookingRefundInitiated {
  const _$ConfirmBookingRefundInitiatedImpl({
    required this.message,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableid,
    required this.bookingid,
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
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingState.refundInitiated(message: $message, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingRefundInitiatedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    orderId,
    transactionId,
    amount,
    tableid,
    bookingid,
  );

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingRefundInitiatedImplCopyWith<
    _$ConfirmBookingRefundInitiatedImpl
  >
  get copyWith =>
      __$$ConfirmBookingRefundInitiatedImplCopyWithImpl<
        _$ConfirmBookingRefundInitiatedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return refundInitiated(
      message,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return refundInitiated?.call(
      message,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
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
        tableid,
        bookingid,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return refundInitiated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return refundInitiated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundInitiated != null) {
      return refundInitiated(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingRefundInitiated implements ConfirmBookingState {
  const factory ConfirmBookingRefundInitiated({
    required final String message,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableid,
    required final String bookingid,
  }) = _$ConfirmBookingRefundInitiatedImpl;

  String get message;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableid;
  String get bookingid;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingRefundInitiatedImplCopyWith<
    _$ConfirmBookingRefundInitiatedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmBookingRefundFailedImplCopyWith<$Res> {
  factory _$$ConfirmBookingRefundFailedImplCopyWith(
    _$ConfirmBookingRefundFailedImpl value,
    $Res Function(_$ConfirmBookingRefundFailedImpl) then,
  ) = __$$ConfirmBookingRefundFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    String orderId,
    String transactionId,
    double amount,
    String tableid,
    String bookingid,
  });
}

/// @nodoc
class __$$ConfirmBookingRefundFailedImplCopyWithImpl<$Res>
    extends
        _$ConfirmBookingStateCopyWithImpl<
          $Res,
          _$ConfirmBookingRefundFailedImpl
        >
    implements _$$ConfirmBookingRefundFailedImplCopyWith<$Res> {
  __$$ConfirmBookingRefundFailedImplCopyWithImpl(
    _$ConfirmBookingRefundFailedImpl _value,
    $Res Function(_$ConfirmBookingRefundFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? tableid = null,
    Object? bookingid = null,
  }) {
    return _then(
      _$ConfirmBookingRefundFailedImpl(
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
        tableid: null == tableid
            ? _value.tableid
            : tableid // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingid: null == bookingid
            ? _value.bookingid
            : bookingid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmBookingRefundFailedImpl implements ConfirmBookingRefundFailed {
  const _$ConfirmBookingRefundFailedImpl({
    required this.message,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.tableid,
    required this.bookingid,
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
  final String tableid;
  @override
  final String bookingid;

  @override
  String toString() {
    return 'ConfirmBookingState.refundFailed(message: $message, orderId: $orderId, transactionId: $transactionId, amount: $amount, tableid: $tableid, bookingid: $bookingid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmBookingRefundFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tableid, tableid) || other.tableid == tableid) &&
            (identical(other.bookingid, bookingid) ||
                other.bookingid == bookingid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    orderId,
    transactionId,
    amount,
    tableid,
    bookingid,
  );

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmBookingRefundFailedImplCopyWith<_$ConfirmBookingRefundFailedImpl>
  get copyWith =>
      __$$ConfirmBookingRefundFailedImplCopyWithImpl<
        _$ConfirmBookingRefundFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookingConfirmData data) success,
    required TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )
    paymentFailed,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    paymentSavedFailed,
    required TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    error,
    required TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundProcessing,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundInitiated,
    required TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )
    refundFailed,
  }) {
    return refundFailed(
      message,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookingConfirmData data)? success,
    TResult? Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult? Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult? Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult? Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundFailed,
  }) {
    return refundFailed?.call(
      message,
      orderId,
      transactionId,
      amount,
      tableid,
      bookingid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookingConfirmData data)? success,
    TResult Function(
      String message,
      String orderId,
      String tableid,
      String bookingid,
    )?
    paymentFailed,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    paymentSavedFailed,
    TResult Function(
      String message,
      bool shouldRefund,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    error,
    TResult Function(
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundProcessing,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
    )?
    refundInitiated,
    TResult Function(
      String message,
      String orderId,
      String transactionId,
      double amount,
      String tableid,
      String bookingid,
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
        tableid,
        bookingid,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmBookingInitial value) initial,
    required TResult Function(ConfirmBookingLoading value) loading,
    required TResult Function(ConfirmBookingSuccess value) success,
    required TResult Function(ConfirmBookingPaymentFailed value) paymentFailed,
    required TResult Function(ConfirmBookingPaymentSavedFailed value)
    paymentSavedFailed,
    required TResult Function(ConfirmBookingError value) error,
    required TResult Function(ConfirmBookingRefundProcessing value)
    refundProcessing,
    required TResult Function(ConfirmBookingRefundInitiated value)
    refundInitiated,
    required TResult Function(ConfirmBookingRefundFailed value) refundFailed,
  }) {
    return refundFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmBookingInitial value)? initial,
    TResult? Function(ConfirmBookingLoading value)? loading,
    TResult? Function(ConfirmBookingSuccess value)? success,
    TResult? Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult? Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult? Function(ConfirmBookingError value)? error,
    TResult? Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult? Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult? Function(ConfirmBookingRefundFailed value)? refundFailed,
  }) {
    return refundFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmBookingInitial value)? initial,
    TResult Function(ConfirmBookingLoading value)? loading,
    TResult Function(ConfirmBookingSuccess value)? success,
    TResult Function(ConfirmBookingPaymentFailed value)? paymentFailed,
    TResult Function(ConfirmBookingPaymentSavedFailed value)?
    paymentSavedFailed,
    TResult Function(ConfirmBookingError value)? error,
    TResult Function(ConfirmBookingRefundProcessing value)? refundProcessing,
    TResult Function(ConfirmBookingRefundInitiated value)? refundInitiated,
    TResult Function(ConfirmBookingRefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundFailed != null) {
      return refundFailed(this);
    }
    return orElse();
  }
}

abstract class ConfirmBookingRefundFailed implements ConfirmBookingState {
  const factory ConfirmBookingRefundFailed({
    required final String message,
    required final String orderId,
    required final String transactionId,
    required final double amount,
    required final String tableid,
    required final String bookingid,
  }) = _$ConfirmBookingRefundFailedImpl;

  String get message;
  String get orderId;
  String get transactionId;
  double get amount;
  String get tableid;
  String get bookingid;

  /// Create a copy of ConfirmBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmBookingRefundFailedImplCopyWith<_$ConfirmBookingRefundFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
