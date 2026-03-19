// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recharge_proceed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RechargeProceedEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
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
      String callbackId,
    )
    paymentFailed,
    required TResult Function() resetStates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
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
      String callbackId,
    )?
    paymentFailed,
    TResult? Function()? resetStates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
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
      String callbackId,
    )?
    paymentFailed,
    TResult Function()? resetStates,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(ResetStates value) resetStates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(ResetStates value)? resetStates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(ResetStates value)? resetStates,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RechargeProceedEventCopyWith<$Res> {
  factory $RechargeProceedEventCopyWith(
    RechargeProceedEvent value,
    $Res Function(RechargeProceedEvent) then,
  ) = _$RechargeProceedEventCopyWithImpl<$Res, RechargeProceedEvent>;
}

/// @nodoc
class _$RechargeProceedEventCopyWithImpl<
  $Res,
  $Val extends RechargeProceedEvent
>
    implements $RechargeProceedEventCopyWith<$Res> {
  _$RechargeProceedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RechargeProceedEvent
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
    String orderId,
    String transactionId,
    int paymentStatus,
    String callbackId,
  });
}

/// @nodoc
class __$$ProceedWithPaymentImplCopyWithImpl<$Res>
    extends _$RechargeProceedEventCopyWithImpl<$Res, _$ProceedWithPaymentImpl>
    implements _$$ProceedWithPaymentImplCopyWith<$Res> {
  __$$ProceedWithPaymentImplCopyWithImpl(
    _$ProceedWithPaymentImpl _value,
    $Res Function(_$ProceedWithPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
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
  final String orderId;
  @override
  final String transactionId;
  @override
  final int paymentStatus;
  @override
  final String callbackId;

  @override
  String toString() {
    return 'RechargeProceedEvent.proceedWithPayment(phoneNo: $phoneNo, operator: $operator, amount: $amount, orderId: $orderId, transactionId: $transactionId, paymentStatus: $paymentStatus, callbackId: $callbackId)';
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
    orderId,
    transactionId,
    paymentStatus,
    callbackId,
  );

  /// Create a copy of RechargeProceedEvent
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
      String callbackId,
    )
    paymentFailed,
    required TResult Function() resetStates,
  }) {
    return proceedWithPayment(
      phoneNo,
      operator,
      amount,
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
      String callbackId,
    )?
    paymentFailed,
    TResult? Function()? resetStates,
  }) {
    return proceedWithPayment?.call(
      phoneNo,
      operator,
      amount,
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
      String callbackId,
    )?
    paymentFailed,
    TResult Function()? resetStates,
    required TResult orElse(),
  }) {
    if (proceedWithPayment != null) {
      return proceedWithPayment(
        phoneNo,
        operator,
        amount,
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
    required TResult Function(ResetStates value) resetStates,
  }) {
    return proceedWithPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(ResetStates value)? resetStates,
  }) {
    return proceedWithPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(ResetStates value)? resetStates,
    required TResult orElse(),
  }) {
    if (proceedWithPayment != null) {
      return proceedWithPayment(this);
    }
    return orElse();
  }
}

abstract class ProceedWithPayment implements RechargeProceedEvent {
  const factory ProceedWithPayment({
    required final String phoneNo,
    required final String operator,
    required final String amount,
    required final String orderId,
    required final String transactionId,
    required final int paymentStatus,
    required final String callbackId,
  }) = _$ProceedWithPaymentImpl;

  String get phoneNo;
  String get operator;
  String get amount;
  String get orderId;
  String get transactionId;
  int get paymentStatus;
  String get callbackId;

  /// Create a copy of RechargeProceedEvent
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
    String callbackId,
  });
}

/// @nodoc
class __$$PaymentFailedImplCopyWithImpl<$Res>
    extends _$RechargeProceedEventCopyWithImpl<$Res, _$PaymentFailedImpl>
    implements _$$PaymentFailedImplCopyWith<$Res> {
  __$$PaymentFailedImplCopyWithImpl(
    _$PaymentFailedImpl _value,
    $Res Function(_$PaymentFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
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
  final String callbackId;

  @override
  String toString() {
    return 'RechargeProceedEvent.paymentFailed(orderId: $orderId, phoneNo: $phoneNo, operator: $operator, amount: $amount, callbackId: $callbackId)';
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
            (identical(other.callbackId, callbackId) ||
                other.callbackId == callbackId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, orderId, phoneNo, operator, amount, callbackId);

  /// Create a copy of RechargeProceedEvent
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
      String callbackId,
    )
    paymentFailed,
    required TResult Function() resetStates,
  }) {
    return paymentFailed(orderId, phoneNo, operator, amount, callbackId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
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
      String callbackId,
    )?
    paymentFailed,
    TResult? Function()? resetStates,
  }) {
    return paymentFailed?.call(orderId, phoneNo, operator, amount, callbackId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
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
      String callbackId,
    )?
    paymentFailed,
    TResult Function()? resetStates,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(orderId, phoneNo, operator, amount, callbackId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProceedWithPayment value) proceedWithPayment,
    required TResult Function(PaymentFailed value) paymentFailed,
    required TResult Function(ResetStates value) resetStates,
  }) {
    return paymentFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(ResetStates value)? resetStates,
  }) {
    return paymentFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(ResetStates value)? resetStates,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(this);
    }
    return orElse();
  }
}

abstract class PaymentFailed implements RechargeProceedEvent {
  const factory PaymentFailed({
    required final String orderId,
    required final String phoneNo,
    required final String operator,
    required final String amount,
    required final String callbackId,
  }) = _$PaymentFailedImpl;

  String get orderId;
  String get phoneNo;
  String get operator;
  String get amount;
  String get callbackId;

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentFailedImplCopyWith<_$PaymentFailedImpl> get copyWith =>
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
    extends _$RechargeProceedEventCopyWithImpl<$Res, _$ResetStatesImpl>
    implements _$$ResetStatesImplCopyWith<$Res> {
  __$$ResetStatesImplCopyWithImpl(
    _$ResetStatesImpl _value,
    $Res Function(_$ResetStatesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetStatesImpl implements ResetStates {
  const _$ResetStatesImpl();

  @override
  String toString() {
    return 'RechargeProceedEvent.resetStates()';
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
      String callbackId,
    )
    paymentFailed,
    required TResult Function() resetStates,
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
      String callbackId,
    )?
    paymentFailed,
    TResult? Function()? resetStates,
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
      String callbackId,
    )?
    paymentFailed,
    TResult Function()? resetStates,
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
    required TResult Function(ResetStates value) resetStates,
  }) {
    return resetStates(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProceedWithPayment value)? proceedWithPayment,
    TResult? Function(PaymentFailed value)? paymentFailed,
    TResult? Function(ResetStates value)? resetStates,
  }) {
    return resetStates?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProceedWithPayment value)? proceedWithPayment,
    TResult Function(PaymentFailed value)? paymentFailed,
    TResult Function(ResetStates value)? resetStates,
    required TResult orElse(),
  }) {
    if (resetStates != null) {
      return resetStates(this);
    }
    return orElse();
  }
}

abstract class ResetStates implements RechargeProceedEvent {
  const factory ResetStates() = _$ResetStatesImpl;
}

/// @nodoc
mixin _$RechargeProceedState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get rechargeStatus => throw _privateConstructorUsedError;
  String? get paymentSavedStatus => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  String? get actualStatus => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RechargeProceedStateCopyWith<RechargeProceedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RechargeProceedStateCopyWith<$Res> {
  factory $RechargeProceedStateCopyWith(
    RechargeProceedState value,
    $Res Function(RechargeProceedState) then,
  ) = _$RechargeProceedStateCopyWithImpl<$Res, RechargeProceedState>;
  @useResult
  $Res call({
    bool isLoading,
    String? rechargeStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? actualStatus,
    String? errorMessage,
  });
}

/// @nodoc
class _$RechargeProceedStateCopyWithImpl<
  $Res,
  $Val extends RechargeProceedState
>
    implements $RechargeProceedStateCopyWith<$Res> {
  _$RechargeProceedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rechargeStatus = freezed,
    Object? paymentSavedStatus = freezed,
    Object? orderId = freezed,
    Object? transactionId = freezed,
    Object? amount = freezed,
    Object? actualStatus = freezed,
    Object? errorMessage = freezed,
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
            actualStatus: freezed == actualStatus
                ? _value.actualStatus
                : actualStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RechargeProceedStateImplCopyWith<$Res>
    implements $RechargeProceedStateCopyWith<$Res> {
  factory _$$RechargeProceedStateImplCopyWith(
    _$RechargeProceedStateImpl value,
    $Res Function(_$RechargeProceedStateImpl) then,
  ) = __$$RechargeProceedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? rechargeStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? actualStatus,
    String? errorMessage,
  });
}

/// @nodoc
class __$$RechargeProceedStateImplCopyWithImpl<$Res>
    extends _$RechargeProceedStateCopyWithImpl<$Res, _$RechargeProceedStateImpl>
    implements _$$RechargeProceedStateImplCopyWith<$Res> {
  __$$RechargeProceedStateImplCopyWithImpl(
    _$RechargeProceedStateImpl _value,
    $Res Function(_$RechargeProceedStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rechargeStatus = freezed,
    Object? paymentSavedStatus = freezed,
    Object? orderId = freezed,
    Object? transactionId = freezed,
    Object? amount = freezed,
    Object? actualStatus = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$RechargeProceedStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        rechargeStatus: freezed == rechargeStatus
            ? _value.rechargeStatus
            : rechargeStatus // ignore: cast_nullable_to_non_nullable
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
        actualStatus: freezed == actualStatus
            ? _value.actualStatus
            : actualStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RechargeProceedStateImpl implements _RechargeProceedState {
  const _$RechargeProceedStateImpl({
    required this.isLoading,
    this.rechargeStatus,
    this.paymentSavedStatus,
    this.orderId,
    this.transactionId,
    this.amount,
    this.actualStatus,
    this.errorMessage,
  });

  @override
  final bool isLoading;
  @override
  final String? rechargeStatus;
  @override
  final String? paymentSavedStatus;
  @override
  final String? orderId;
  @override
  final String? transactionId;
  @override
  final String? amount;
  @override
  final String? actualStatus;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'RechargeProceedState(isLoading: $isLoading, rechargeStatus: $rechargeStatus, paymentSavedStatus: $paymentSavedStatus, orderId: $orderId, transactionId: $transactionId, amount: $amount, actualStatus: $actualStatus, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RechargeProceedStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.rechargeStatus, rechargeStatus) ||
                other.rechargeStatus == rechargeStatus) &&
            (identical(other.paymentSavedStatus, paymentSavedStatus) ||
                other.paymentSavedStatus == paymentSavedStatus) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.actualStatus, actualStatus) ||
                other.actualStatus == actualStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    rechargeStatus,
    paymentSavedStatus,
    orderId,
    transactionId,
    amount,
    actualStatus,
    errorMessage,
  );

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RechargeProceedStateImplCopyWith<_$RechargeProceedStateImpl>
  get copyWith =>
      __$$RechargeProceedStateImplCopyWithImpl<_$RechargeProceedStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RechargeProceedState implements RechargeProceedState {
  const factory _RechargeProceedState({
    required final bool isLoading,
    final String? rechargeStatus,
    final String? paymentSavedStatus,
    final String? orderId,
    final String? transactionId,
    final String? amount,
    final String? actualStatus,
    final String? errorMessage,
  }) = _$RechargeProceedStateImpl;

  @override
  bool get isLoading;
  @override
  String? get rechargeStatus;
  @override
  String? get paymentSavedStatus;
  @override
  String? get orderId;
  @override
  String? get transactionId;
  @override
  String? get amount;
  @override
  String? get actualStatus;
  @override
  String? get errorMessage;

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RechargeProceedStateImplCopyWith<_$RechargeProceedStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
