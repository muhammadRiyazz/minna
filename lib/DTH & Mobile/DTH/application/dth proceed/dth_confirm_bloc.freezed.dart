// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dth_confirm_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DthConfirmEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )
    proceedWithPayment,
    required TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )
    paymentFailed,
    required TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )
    initiateRefund,
    required TResult Function() resetStates,
    required TResult Function() markRefundAttempted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult? Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult? Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult? Function()? resetStates,
    TResult? Function()? markRefundAttempted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult Function()? resetStates,
    TResult Function()? markRefundAttempted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(InitiateRefund value) initiateRefund,
    required TResult Function(ResetStates value) resetStates,
    required TResult Function(MarkRefundAttempted value) markRefundAttempted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(InitiateRefund value)? initiateRefund,
    TResult? Function(ResetStates value)? resetStates,
    TResult? Function(MarkRefundAttempted value)? markRefundAttempted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(InitiateRefund value)? initiateRefund,
    TResult Function(ResetStates value)? resetStates,
    TResult Function(MarkRefundAttempted value)? markRefundAttempted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DthConfirmEventCopyWith<$Res> {
  factory $DthConfirmEventCopyWith(
    DthConfirmEvent value,
    $Res Function(DthConfirmEvent) then,
  ) = _$DthConfirmEventCopyWithImpl<$Res, DthConfirmEvent>;
}

/// @nodoc
class _$DthConfirmEventCopyWithImpl<$Res, $Val extends DthConfirmEvent>
    implements $DthConfirmEventCopyWith<$Res> {
  _$DthConfirmEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProceedWithPaymentImplCopyWith<$Res> {
  factory _$$ProceedWithPaymentImplCopyWith(
    _$ProceedWithPaymentImpl value,
    $Res Function(_$ProceedWithPaymentImpl) then,
  ) = __$$ProceedWithPaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String phoneNo,
    String operator,
    String amount,
    String subcriberNo,
    String orderId,
    String transactionId,
    int paymentStatus,
    String callbackId,
  });
}

/// @nodoc
class __$$ProceedWithPaymentImplCopyWithImpl<$Res>
    extends _$DthConfirmEventCopyWithImpl<$Res, _$ProceedWithPaymentImpl>
    implements _$$ProceedWithPaymentImplCopyWith<$Res> {
  __$$ProceedWithPaymentImplCopyWithImpl(
    _$ProceedWithPaymentImpl _value,
    $Res Function(_$ProceedWithPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
    Object? subcriberNo = null,
    Object? orderId = null,
    Object? transactionId = null,
    Object? paymentStatus = null,
    Object? callbackId = null,
  }) {
    return _then(
      _$ProceedWithPaymentImpl(
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        operator: null == operator
            ? _value.operator
            : operator // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        subcriberNo: null == subcriberNo
            ? _value.subcriberNo
            : subcriberNo // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentStatus: null == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as int,
        callbackId: null == callbackId
            ? _value.callbackId
            : callbackId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProceedWithPaymentImpl implements ProceedWithPayment {
  const _$ProceedWithPaymentImpl({
    required this.phoneNo,
    required this.operator,
    required this.amount,
    required this.subcriberNo,
    required this.orderId,
    required this.transactionId,
    required this.paymentStatus,
    required this.callbackId,
  });

  @override
  final String phoneNo;
  @override
  final String operator;
  @override
  final String amount;
  @override
  final String subcriberNo;
  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final int paymentStatus;
  @override
  final String callbackId;

  @override
  String toString() {
    return 'DthConfirmEvent.proceedWithPayment(phoneNo: $phoneNo, operator: $operator, amount: $amount, subcriberNo: $subcriberNo, orderId: $orderId, transactionId: $transactionId, paymentStatus: $paymentStatus, callbackId: $callbackId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProceedWithPaymentImpl &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.subcriberNo, subcriberNo) ||
                other.subcriberNo == subcriberNo) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.callbackId, callbackId) ||
                other.callbackId == callbackId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    phoneNo,
    operator,
    amount,
    subcriberNo,
    orderId,
    transactionId,
    paymentStatus,
    callbackId,
  );

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProceedWithPaymentImplCopyWith<_$ProceedWithPaymentImpl> get copyWith =>
      __$$ProceedWithPaymentImplCopyWithImpl<_$ProceedWithPaymentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )
    proceedWithPayment,
    required TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )
    paymentFailed,
    required TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )
    initiateRefund,
    required TResult Function() resetStates,
    required TResult Function() markRefundAttempted,
  }) {
    return proceedWithPayment(
      phoneNo,
      operator,
      amount,
      subcriberNo,
      orderId,
      transactionId,
      paymentStatus,
      callbackId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult? Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult? Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult? Function()? resetStates,
    TResult? Function()? markRefundAttempted,
  }) {
    return proceedWithPayment?.call(
      phoneNo,
      operator,
      amount,
      subcriberNo,
      orderId,
      transactionId,
      paymentStatus,
      callbackId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult Function()? resetStates,
    TResult Function()? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (proceedWithPayment != null) {
      return proceedWithPayment(
        phoneNo,
        operator,
        amount,
        subcriberNo,
        orderId,
        transactionId,
        paymentStatus,
        callbackId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(InitiateRefund value) initiateRefund,
    required TResult Function(ResetStates value) resetStates,
    required TResult Function(MarkRefundAttempted value) markRefundAttempted,
  }) {
    return proceedWithPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(InitiateRefund value)? initiateRefund,
    TResult? Function(ResetStates value)? resetStates,
    TResult? Function(MarkRefundAttempted value)? markRefundAttempted,
  }) {
    return proceedWithPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(InitiateRefund value)? initiateRefund,
    TResult Function(ResetStates value)? resetStates,
    TResult Function(MarkRefundAttempted value)? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (proceedWithPayment != null) {
      return proceedWithPayment(this);
    }
    return orElse();
  }
}

abstract class ProceedWithPayment implements DthConfirmEvent {
  const factory ProceedWithPayment({
    required final String phoneNo,
    required final String operator,
    required final String amount,
    required final String subcriberNo,
    required final String orderId,
    required final String transactionId,
    required final int paymentStatus,
    required final String callbackId,
  }) = _$ProceedWithPaymentImpl;

  String get phoneNo;
  String get operator;
  String get amount;
  String get subcriberNo;
  String get orderId;
  String get transactionId;
  int get paymentStatus;
  String get callbackId;

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProceedWithPaymentImplCopyWith<_$ProceedWithPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentFailedImplCopyWith<$Res> {
  factory _$$PaymentFailedImplCopyWith(
    _$PaymentFailedImpl value,
    $Res Function(_$PaymentFailedImpl) then,
  ) = __$$PaymentFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String orderId,
    String phoneNo,
    String operator,
    String amount,
    String subcriberNo,
    String callbackId,
  });
}

/// @nodoc
class __$$PaymentFailedImplCopyWithImpl<$Res>
    extends _$DthConfirmEventCopyWithImpl<$Res, _$PaymentFailedImpl>
    implements _$$PaymentFailedImplCopyWith<$Res> {
  __$$PaymentFailedImplCopyWithImpl(
    _$PaymentFailedImpl _value,
    $Res Function(_$PaymentFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
    Object? subcriberNo = null,
    Object? callbackId = null,
  }) {
    return _then(
      _$PaymentFailedImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        operator: null == operator
            ? _value.operator
            : operator // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        subcriberNo: null == subcriberNo
            ? _value.subcriberNo
            : subcriberNo // ignore: cast_nullable_to_non_nullable
                  as String,
        callbackId: null == callbackId
            ? _value.callbackId
            : callbackId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentFailedImpl implements PaymentFailed {
  const _$PaymentFailedImpl({
    required this.orderId,
    required this.phoneNo,
    required this.operator,
    required this.amount,
    required this.subcriberNo,
    required this.callbackId,
  });

  @override
  final String orderId;
  @override
  final String phoneNo;
  @override
  final String operator;
  @override
  final String amount;
  @override
  final String subcriberNo;
  @override
  final String callbackId;

  @override
  String toString() {
    return 'DthConfirmEvent.paymentFailed(orderId: $orderId, phoneNo: $phoneNo, operator: $operator, amount: $amount, subcriberNo: $subcriberNo, callbackId: $callbackId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentFailedImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.subcriberNo, subcriberNo) ||
                other.subcriberNo == subcriberNo) &&
            (identical(other.callbackId, callbackId) ||
                other.callbackId == callbackId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    phoneNo,
    operator,
    amount,
    subcriberNo,
    callbackId,
  );

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentFailedImplCopyWith<_$PaymentFailedImpl> get copyWith =>
      __$$PaymentFailedImplCopyWithImpl<_$PaymentFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )
    proceedWithPayment,
    required TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )
    paymentFailed,
    required TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )
    initiateRefund,
    required TResult Function() resetStates,
    required TResult Function() markRefundAttempted,
  }) {
    return paymentFailed(
      orderId,
      phoneNo,
      operator,
      amount,
      subcriberNo,
      callbackId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult? Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult? Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult? Function()? resetStates,
    TResult? Function()? markRefundAttempted,
  }) {
    return paymentFailed?.call(
      orderId,
      phoneNo,
      operator,
      amount,
      subcriberNo,
      callbackId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult Function()? resetStates,
    TResult Function()? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(
        orderId,
        phoneNo,
        operator,
        amount,
        subcriberNo,
        callbackId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(InitiateRefund value) initiateRefund,
    required TResult Function(ResetStates value) resetStates,
    required TResult Function(MarkRefundAttempted value) markRefundAttempted,
  }) {
    return paymentFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(InitiateRefund value)? initiateRefund,
    TResult? Function(ResetStates value)? resetStates,
    TResult? Function(MarkRefundAttempted value)? markRefundAttempted,
  }) {
    return paymentFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(InitiateRefund value)? initiateRefund,
    TResult Function(ResetStates value)? resetStates,
    TResult Function(MarkRefundAttempted value)? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(this);
    }
    return orElse();
  }
}

abstract class PaymentFailed implements DthConfirmEvent {
  const factory PaymentFailed({
    required final String orderId,
    required final String phoneNo,
    required final String operator,
    required final String amount,
    required final String subcriberNo,
    required final String callbackId,
  }) = _$PaymentFailedImpl;

  String get orderId;
  String get phoneNo;
  String get operator;
  String get amount;
  String get subcriberNo;
  String get callbackId;

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentFailedImplCopyWith<_$PaymentFailedImpl> get copyWith =>
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
    String amount,
    String phoneNo,
    String callbackId,
  });
}

/// @nodoc
class __$$InitiateRefundImplCopyWithImpl<$Res>
    extends _$DthConfirmEventCopyWithImpl<$Res, _$InitiateRefundImpl>
    implements _$$InitiateRefundImplCopyWith<$Res> {
  __$$InitiateRefundImplCopyWithImpl(
    _$InitiateRefundImpl _value,
    $Res Function(_$InitiateRefundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? phoneNo = null,
    Object? callbackId = null,
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
                  as String,
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        callbackId: null == callbackId
            ? _value.callbackId
            : callbackId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InitiateRefundImpl implements InitiateRefund {
  const _$InitiateRefundImpl({
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.phoneNo,
    required this.callbackId,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final String amount;
  @override
  final String phoneNo;
  @override
  final String callbackId;

  @override
  String toString() {
    return 'DthConfirmEvent.initiateRefund(orderId: $orderId, transactionId: $transactionId, amount: $amount, phoneNo: $phoneNo, callbackId: $callbackId)';
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
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.callbackId, callbackId) ||
                other.callbackId == callbackId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    amount,
    phoneNo,
    callbackId,
  );

  /// Create a copy of DthConfirmEvent
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
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )
    proceedWithPayment,
    required TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )
    paymentFailed,
    required TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )
    initiateRefund,
    required TResult Function() resetStates,
    required TResult Function() markRefundAttempted,
  }) {
    return initiateRefund(orderId, transactionId, amount, phoneNo, callbackId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult? Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult? Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult? Function()? resetStates,
    TResult? Function()? markRefundAttempted,
  }) {
    return initiateRefund?.call(
      orderId,
      transactionId,
      amount,
      phoneNo,
      callbackId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult Function()? resetStates,
    TResult Function()? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(
        orderId,
        transactionId,
        amount,
        phoneNo,
        callbackId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(InitiateRefund value) initiateRefund,
    required TResult Function(ResetStates value) resetStates,
    required TResult Function(MarkRefundAttempted value) markRefundAttempted,
  }) {
    return initiateRefund(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(InitiateRefund value)? initiateRefund,
    TResult? Function(ResetStates value)? resetStates,
    TResult? Function(MarkRefundAttempted value)? markRefundAttempted,
  }) {
    return initiateRefund?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(InitiateRefund value)? initiateRefund,
    TResult Function(ResetStates value)? resetStates,
    TResult Function(MarkRefundAttempted value)? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(this);
    }
    return orElse();
  }
}

abstract class InitiateRefund implements DthConfirmEvent {
  const factory InitiateRefund({
    required final String orderId,
    required final String transactionId,
    required final String amount,
    required final String phoneNo,
    required final String callbackId,
  }) = _$InitiateRefundImpl;

  String get orderId;
  String get transactionId;
  String get amount;
  String get phoneNo;
  String get callbackId;

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateRefundImplCopyWith<_$InitiateRefundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetStatesImplCopyWith<$Res> {
  factory _$$ResetStatesImplCopyWith(
    _$ResetStatesImpl value,
    $Res Function(_$ResetStatesImpl) then,
  ) = __$$ResetStatesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetStatesImplCopyWithImpl<$Res>
    extends _$DthConfirmEventCopyWithImpl<$Res, _$ResetStatesImpl>
    implements _$$ResetStatesImplCopyWith<$Res> {
  __$$ResetStatesImplCopyWithImpl(
    _$ResetStatesImpl _value,
    $Res Function(_$ResetStatesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetStatesImpl implements ResetStates {
  const _$ResetStatesImpl();

  @override
  String toString() {
    return 'DthConfirmEvent.resetStates()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetStatesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )
    proceedWithPayment,
    required TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )
    paymentFailed,
    required TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )
    initiateRefund,
    required TResult Function() resetStates,
    required TResult Function() markRefundAttempted,
  }) {
    return resetStates();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult? Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult? Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult? Function()? resetStates,
    TResult? Function()? markRefundAttempted,
  }) {
    return resetStates?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult Function()? resetStates,
    TResult Function()? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (resetStates != null) {
      return resetStates();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(InitiateRefund value) initiateRefund,
    required TResult Function(ResetStates value) resetStates,
    required TResult Function(MarkRefundAttempted value) markRefundAttempted,
  }) {
    return resetStates(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(InitiateRefund value)? initiateRefund,
    TResult? Function(ResetStates value)? resetStates,
    TResult? Function(MarkRefundAttempted value)? markRefundAttempted,
  }) {
    return resetStates?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(InitiateRefund value)? initiateRefund,
    TResult Function(ResetStates value)? resetStates,
    TResult Function(MarkRefundAttempted value)? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (resetStates != null) {
      return resetStates(this);
    }
    return orElse();
  }
}

abstract class ResetStates implements DthConfirmEvent {
  const factory ResetStates() = _$ResetStatesImpl;
}

/// @nodoc
abstract class _$$MarkRefundAttemptedImplCopyWith<$Res> {
  factory _$$MarkRefundAttemptedImplCopyWith(
    _$MarkRefundAttemptedImpl value,
    $Res Function(_$MarkRefundAttemptedImpl) then,
  ) = __$$MarkRefundAttemptedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarkRefundAttemptedImplCopyWithImpl<$Res>
    extends _$DthConfirmEventCopyWithImpl<$Res, _$MarkRefundAttemptedImpl>
    implements _$$MarkRefundAttemptedImplCopyWith<$Res> {
  __$$MarkRefundAttemptedImplCopyWithImpl(
    _$MarkRefundAttemptedImpl _value,
    $Res Function(_$MarkRefundAttemptedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MarkRefundAttemptedImpl implements MarkRefundAttempted {
  const _$MarkRefundAttemptedImpl();

  @override
  String toString() {
    return 'DthConfirmEvent.markRefundAttempted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkRefundAttemptedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )
    proceedWithPayment,
    required TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )
    paymentFailed,
    required TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )
    initiateRefund,
    required TResult Function() resetStates,
    required TResult Function() markRefundAttempted,
  }) {
    return markRefundAttempted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult? Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult? Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult? Function()? resetStates,
    TResult? Function()? markRefundAttempted,
  }) {
    return markRefundAttempted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String orderId,
      String transactionId,
      int paymentStatus,
      String callbackId,
    )?
    proceedWithPayment,
    TResult Function(
      String orderId,
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
      String callbackId,
    )?
    paymentFailed,
    TResult Function(
      String orderId,
      String transactionId,
      String amount,
      String phoneNo,
      String callbackId,
    )?
    initiateRefund,
    TResult Function()? resetStates,
    TResult Function()? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (markRefundAttempted != null) {
      return markRefundAttempted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(InitiateRefund value) initiateRefund,
    required TResult Function(ResetStates value) resetStates,
    required TResult Function(MarkRefundAttempted value) markRefundAttempted,
  }) {
    return markRefundAttempted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(InitiateRefund value)? initiateRefund,
    TResult? Function(ResetStates value)? resetStates,
    TResult? Function(MarkRefundAttempted value)? markRefundAttempted,
  }) {
    return markRefundAttempted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(InitiateRefund value)? initiateRefund,
    TResult Function(ResetStates value)? resetStates,
    TResult Function(MarkRefundAttempted value)? markRefundAttempted,
    required TResult orElse(),
  }) {
    if (markRefundAttempted != null) {
      return markRefundAttempted(this);
    }
    return orElse();
  }
}

abstract class MarkRefundAttempted implements DthConfirmEvent {
  const factory MarkRefundAttempted() = _$MarkRefundAttemptedImpl;
}

/// @nodoc
mixin _$DthConfirmState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get rechargeStatus => throw _privateConstructorUsedError;
  String? get refundStatus => throw _privateConstructorUsedError;
  String? get paymentSavedStatus => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool? get shouldRefund => throw _privateConstructorUsedError;
  bool get isRefundInProgress => throw _privateConstructorUsedError;
  bool get hasRefundBeenAttempted => throw _privateConstructorUsedError;
  bool get hasRechargeFailedHandled => throw _privateConstructorUsedError;
  bool get hasPaymentSaveFailedHandled => throw _privateConstructorUsedError;

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DthConfirmStateCopyWith<DthConfirmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DthConfirmStateCopyWith<$Res> {
  factory $DthConfirmStateCopyWith(
    DthConfirmState value,
    $Res Function(DthConfirmState) then,
  ) = _$DthConfirmStateCopyWithImpl<$Res, DthConfirmState>;
  @useResult
  $Res call({
    bool isLoading,
    String? rechargeStatus,
    String? refundStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? errorMessage,
    bool? shouldRefund,
    bool isRefundInProgress,
    bool hasRefundBeenAttempted,
    bool hasRechargeFailedHandled,
    bool hasPaymentSaveFailedHandled,
  });
}

/// @nodoc
class _$DthConfirmStateCopyWithImpl<$Res, $Val extends DthConfirmState>
    implements $DthConfirmStateCopyWith<$Res> {
  _$DthConfirmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rechargeStatus = freezed,
    Object? refundStatus = freezed,
    Object? paymentSavedStatus = freezed,
    Object? orderId = freezed,
    Object? transactionId = freezed,
    Object? amount = freezed,
    Object? errorMessage = freezed,
    Object? shouldRefund = freezed,
    Object? isRefundInProgress = null,
    Object? hasRefundBeenAttempted = null,
    Object? hasRechargeFailedHandled = null,
    Object? hasPaymentSaveFailedHandled = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            rechargeStatus: freezed == rechargeStatus
                ? _value.rechargeStatus
                : rechargeStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            refundStatus: freezed == refundStatus
                ? _value.refundStatus
                : refundStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentSavedStatus: freezed == paymentSavedStatus
                ? _value.paymentSavedStatus
                : paymentSavedStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderId: freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            transactionId: freezed == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            shouldRefund: freezed == shouldRefund
                ? _value.shouldRefund
                : shouldRefund // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isRefundInProgress: null == isRefundInProgress
                ? _value.isRefundInProgress
                : isRefundInProgress // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasRefundBeenAttempted: null == hasRefundBeenAttempted
                ? _value.hasRefundBeenAttempted
                : hasRefundBeenAttempted // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasRechargeFailedHandled: null == hasRechargeFailedHandled
                ? _value.hasRechargeFailedHandled
                : hasRechargeFailedHandled // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPaymentSaveFailedHandled: null == hasPaymentSaveFailedHandled
                ? _value.hasPaymentSaveFailedHandled
                : hasPaymentSaveFailedHandled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DthConfirmStateImplCopyWith<$Res>
    implements $DthConfirmStateCopyWith<$Res> {
  factory _$$DthConfirmStateImplCopyWith(
    _$DthConfirmStateImpl value,
    $Res Function(_$DthConfirmStateImpl) then,
  ) = __$$DthConfirmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? rechargeStatus,
    String? refundStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? errorMessage,
    bool? shouldRefund,
    bool isRefundInProgress,
    bool hasRefundBeenAttempted,
    bool hasRechargeFailedHandled,
    bool hasPaymentSaveFailedHandled,
  });
}

/// @nodoc
class __$$DthConfirmStateImplCopyWithImpl<$Res>
    extends _$DthConfirmStateCopyWithImpl<$Res, _$DthConfirmStateImpl>
    implements _$$DthConfirmStateImplCopyWith<$Res> {
  __$$DthConfirmStateImplCopyWithImpl(
    _$DthConfirmStateImpl _value,
    $Res Function(_$DthConfirmStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rechargeStatus = freezed,
    Object? refundStatus = freezed,
    Object? paymentSavedStatus = freezed,
    Object? orderId = freezed,
    Object? transactionId = freezed,
    Object? amount = freezed,
    Object? errorMessage = freezed,
    Object? shouldRefund = freezed,
    Object? isRefundInProgress = null,
    Object? hasRefundBeenAttempted = null,
    Object? hasRechargeFailedHandled = null,
    Object? hasPaymentSaveFailedHandled = null,
  }) {
    return _then(
      _$DthConfirmStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        rechargeStatus: freezed == rechargeStatus
            ? _value.rechargeStatus
            : rechargeStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        refundStatus: freezed == refundStatus
            ? _value.refundStatus
            : refundStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentSavedStatus: freezed == paymentSavedStatus
            ? _value.paymentSavedStatus
            : paymentSavedStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderId: freezed == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        transactionId: freezed == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        shouldRefund: freezed == shouldRefund
            ? _value.shouldRefund
            : shouldRefund // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isRefundInProgress: null == isRefundInProgress
            ? _value.isRefundInProgress
            : isRefundInProgress // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasRefundBeenAttempted: null == hasRefundBeenAttempted
            ? _value.hasRefundBeenAttempted
            : hasRefundBeenAttempted // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasRechargeFailedHandled: null == hasRechargeFailedHandled
            ? _value.hasRechargeFailedHandled
            : hasRechargeFailedHandled // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPaymentSaveFailedHandled: null == hasPaymentSaveFailedHandled
            ? _value.hasPaymentSaveFailedHandled
            : hasPaymentSaveFailedHandled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DthConfirmStateImpl implements _DthConfirmState {
  const _$DthConfirmStateImpl({
    required this.isLoading,
    this.rechargeStatus,
    this.refundStatus,
    this.paymentSavedStatus,
    this.orderId,
    this.transactionId,
    this.amount,
    this.errorMessage,
    this.shouldRefund,
    this.isRefundInProgress = false,
    this.hasRefundBeenAttempted = false,
    this.hasRechargeFailedHandled = false,
    this.hasPaymentSaveFailedHandled = false,
  });

  @override
  final bool isLoading;
  @override
  final String? rechargeStatus;
  @override
  final String? refundStatus;
  @override
  final String? paymentSavedStatus;
  @override
  final String? orderId;
  @override
  final String? transactionId;
  @override
  final String? amount;
  @override
  final String? errorMessage;
  @override
  final bool? shouldRefund;
  @override
  @JsonKey()
  final bool isRefundInProgress;
  @override
  @JsonKey()
  final bool hasRefundBeenAttempted;
  @override
  @JsonKey()
  final bool hasRechargeFailedHandled;
  @override
  @JsonKey()
  final bool hasPaymentSaveFailedHandled;

  @override
  String toString() {
    return 'DthConfirmState(isLoading: $isLoading, rechargeStatus: $rechargeStatus, refundStatus: $refundStatus, paymentSavedStatus: $paymentSavedStatus, orderId: $orderId, transactionId: $transactionId, amount: $amount, errorMessage: $errorMessage, shouldRefund: $shouldRefund, isRefundInProgress: $isRefundInProgress, hasRefundBeenAttempted: $hasRefundBeenAttempted, hasRechargeFailedHandled: $hasRechargeFailedHandled, hasPaymentSaveFailedHandled: $hasPaymentSaveFailedHandled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DthConfirmStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.rechargeStatus, rechargeStatus) ||
                other.rechargeStatus == rechargeStatus) &&
            (identical(other.refundStatus, refundStatus) ||
                other.refundStatus == refundStatus) &&
            (identical(other.paymentSavedStatus, paymentSavedStatus) ||
                other.paymentSavedStatus == paymentSavedStatus) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.shouldRefund, shouldRefund) ||
                other.shouldRefund == shouldRefund) &&
            (identical(other.isRefundInProgress, isRefundInProgress) ||
                other.isRefundInProgress == isRefundInProgress) &&
            (identical(other.hasRefundBeenAttempted, hasRefundBeenAttempted) ||
                other.hasRefundBeenAttempted == hasRefundBeenAttempted) &&
            (identical(
                  other.hasRechargeFailedHandled,
                  hasRechargeFailedHandled,
                ) ||
                other.hasRechargeFailedHandled == hasRechargeFailedHandled) &&
            (identical(
                  other.hasPaymentSaveFailedHandled,
                  hasPaymentSaveFailedHandled,
                ) ||
                other.hasPaymentSaveFailedHandled ==
                    hasPaymentSaveFailedHandled));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    rechargeStatus,
    refundStatus,
    paymentSavedStatus,
    orderId,
    transactionId,
    amount,
    errorMessage,
    shouldRefund,
    isRefundInProgress,
    hasRefundBeenAttempted,
    hasRechargeFailedHandled,
    hasPaymentSaveFailedHandled,
  );

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DthConfirmStateImplCopyWith<_$DthConfirmStateImpl> get copyWith =>
      __$$DthConfirmStateImplCopyWithImpl<_$DthConfirmStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DthConfirmState implements DthConfirmState {
  const factory _DthConfirmState({
    required final bool isLoading,
    final String? rechargeStatus,
    final String? refundStatus,
    final String? paymentSavedStatus,
    final String? orderId,
    final String? transactionId,
    final String? amount,
    final String? errorMessage,
    final bool? shouldRefund,
    final bool isRefundInProgress,
    final bool hasRefundBeenAttempted,
    final bool hasRechargeFailedHandled,
    final bool hasPaymentSaveFailedHandled,
  }) = _$DthConfirmStateImpl;

  @override
  bool get isLoading;
  @override
  String? get rechargeStatus;
  @override
  String? get refundStatus;
  @override
  String? get paymentSavedStatus;
  @override
  String? get orderId;
  @override
  String? get transactionId;
  @override
  String? get amount;
  @override
  String? get errorMessage;
  @override
  bool? get shouldRefund;
  @override
  bool get isRefundInProgress;
  @override
  bool get hasRefundBeenAttempted;
  @override
  bool get hasRechargeFailedHandled;
  @override
  bool get hasPaymentSaveFailedHandled;

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DthConfirmStateImplCopyWith<_$DthConfirmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
