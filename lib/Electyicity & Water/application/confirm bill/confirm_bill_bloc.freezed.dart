// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_bill_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConfirmBillEvent {
  String get receiptId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
    required TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )
    initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult? Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
    required TResult Function(InitiateRefund value) initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult? Function(InitiateRefund value)? initiateRefund,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult Function(InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfirmBillEventCopyWith<ConfirmBillEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmBillEventCopyWith<$Res> {
  factory $ConfirmBillEventCopyWith(
    ConfirmBillEvent value,
    $Res Function(ConfirmBillEvent) then,
  ) = _$ConfirmBillEventCopyWithImpl<$Res, ConfirmBillEvent>;
  @useResult
  $Res call({String receiptId});
}

/// @nodoc
class _$ConfirmBillEventCopyWithImpl<$Res, $Val extends ConfirmBillEvent>
    implements $ConfirmBillEventCopyWith<$Res> {
  _$ConfirmBillEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receiptId = null}) {
    return _then(
      _value.copyWith(
            receiptId: null == receiptId
                ? _value.receiptId
                : receiptId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InitiatePaymentImplCopyWith<$Res>
    implements $ConfirmBillEventCopyWith<$Res> {
  factory _$$InitiatePaymentImplCopyWith(
    _$InitiatePaymentImpl value,
    $Res Function(_$InitiatePaymentImpl) then,
  ) = __$$InitiatePaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ElectricityBillModel bill,
    String providerID,
    String phoneNo,
    String consumerId,
    String providerName,
    String receiptId,
  });
}

/// @nodoc
class __$$InitiatePaymentImplCopyWithImpl<$Res>
    extends _$ConfirmBillEventCopyWithImpl<$Res, _$InitiatePaymentImpl>
    implements _$$InitiatePaymentImplCopyWith<$Res> {
  __$$InitiatePaymentImplCopyWithImpl(
    _$InitiatePaymentImpl _value,
    $Res Function(_$InitiatePaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bill = null,
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
    Object? providerName = null,
    Object? receiptId = null,
  }) {
    return _then(
      _$InitiatePaymentImpl(
        bill: null == bill
            ? _value.bill
            : bill // ignore: cast_nullable_to_non_nullable
                  as ElectricityBillModel,
        providerID: null == providerID
            ? _value.providerID
            : providerID // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        consumerId: null == consumerId
            ? _value.consumerId
            : consumerId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerName: null == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptId: null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InitiatePaymentImpl implements InitiatePayment {
  const _$InitiatePaymentImpl({
    required this.bill,
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
    required this.providerName,
    required this.receiptId,
  });

  @override
  final ElectricityBillModel bill;
  @override
  final String providerID;
  @override
  final String phoneNo;
  @override
  final String consumerId;
  @override
  final String providerName;
  @override
  final String receiptId;

  @override
  String toString() {
    return 'ConfirmBillEvent.initiatePayment(bill: $bill, providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId, providerName: $providerName, receiptId: $receiptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiatePaymentImpl &&
            (identical(other.bill, bill) || other.bill == bill) &&
            (identical(other.providerID, providerID) ||
                other.providerID == providerID) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.consumerId, consumerId) ||
                other.consumerId == consumerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    bill,
    providerID,
    phoneNo,
    consumerId,
    providerName,
    receiptId,
  );

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiatePaymentImplCopyWith<_$InitiatePaymentImpl> get copyWith =>
      __$$InitiatePaymentImplCopyWithImpl<_$InitiatePaymentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
    required TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )
    initiateRefund,
  }) {
    return initiatePayment(
      bill,
      providerID,
      phoneNo,
      consumerId,
      providerName,
      receiptId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult? Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
  }) {
    return initiatePayment?.call(
      bill,
      providerID,
      phoneNo,
      consumerId,
      providerName,
      receiptId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (initiatePayment != null) {
      return initiatePayment(
        bill,
        providerID,
        phoneNo,
        consumerId,
        providerName,
        receiptId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
    required TResult Function(InitiateRefund value) initiateRefund,
  }) {
    return initiatePayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult? Function(InitiateRefund value)? initiateRefund,
  }) {
    return initiatePayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult Function(InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (initiatePayment != null) {
      return initiatePayment(this);
    }
    return orElse();
  }
}

abstract class InitiatePayment implements ConfirmBillEvent {
  const factory InitiatePayment({
    required final ElectricityBillModel bill,
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
    required final String providerName,
    required final String receiptId,
  }) = _$InitiatePaymentImpl;

  ElectricityBillModel get bill;
  String get providerID;
  String get phoneNo;
  String get consumerId;
  String get providerName;
  @override
  String get receiptId;

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiatePaymentImplCopyWith<_$InitiatePaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessPaymentSuccessImplCopyWith<$Res>
    implements $ConfirmBillEventCopyWith<$Res> {
  factory _$$ProcessPaymentSuccessImplCopyWith(
    _$ProcessPaymentSuccessImpl value,
    $Res Function(_$ProcessPaymentSuccessImpl) then,
  ) = __$$ProcessPaymentSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    String receiptId,
    String providerID,
    String phoneNo,
    String consumerId,
    ElectricityBillModel? currentBill,
  });
}

/// @nodoc
class __$$ProcessPaymentSuccessImplCopyWithImpl<$Res>
    extends _$ConfirmBillEventCopyWithImpl<$Res, _$ProcessPaymentSuccessImpl>
    implements _$$ProcessPaymentSuccessImplCopyWith<$Res> {
  __$$ProcessPaymentSuccessImplCopyWithImpl(
    _$ProcessPaymentSuccessImpl _value,
    $Res Function(_$ProcessPaymentSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? receiptId = null,
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
    Object? currentBill = freezed,
  }) {
    return _then(
      _$ProcessPaymentSuccessImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptId: null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerID: null == providerID
            ? _value.providerID
            : providerID // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        consumerId: null == consumerId
            ? _value.consumerId
            : consumerId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentBill: freezed == currentBill
            ? _value.currentBill
            : currentBill // ignore: cast_nullable_to_non_nullable
                  as ElectricityBillModel?,
      ),
    );
  }
}

/// @nodoc

class _$ProcessPaymentSuccessImpl implements ProcessPaymentSuccess {
  const _$ProcessPaymentSuccessImpl({
    required this.orderId,
    required this.transactionId,
    required this.receiptId,
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
    required this.currentBill,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final String receiptId;
  @override
  final String providerID;
  @override
  final String phoneNo;
  @override
  final String consumerId;
  @override
  final ElectricityBillModel? currentBill;

  @override
  String toString() {
    return 'ConfirmBillEvent.processPaymentSuccess(orderId: $orderId, transactionId: $transactionId, receiptId: $receiptId, providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId, currentBill: $currentBill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessPaymentSuccessImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId) &&
            (identical(other.providerID, providerID) ||
                other.providerID == providerID) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.consumerId, consumerId) ||
                other.consumerId == consumerId) &&
            (identical(other.currentBill, currentBill) ||
                other.currentBill == currentBill));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    transactionId,
    receiptId,
    providerID,
    phoneNo,
    consumerId,
    currentBill,
  );

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessPaymentSuccessImplCopyWith<_$ProcessPaymentSuccessImpl>
  get copyWith =>
      __$$ProcessPaymentSuccessImplCopyWithImpl<_$ProcessPaymentSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
    required TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )
    initiateRefund,
  }) {
    return processPaymentSuccess(
      orderId,
      transactionId,
      receiptId,
      providerID,
      phoneNo,
      consumerId,
      currentBill,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult? Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
  }) {
    return processPaymentSuccess?.call(
      orderId,
      transactionId,
      receiptId,
      providerID,
      phoneNo,
      consumerId,
      currentBill,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (processPaymentSuccess != null) {
      return processPaymentSuccess(
        orderId,
        transactionId,
        receiptId,
        providerID,
        phoneNo,
        consumerId,
        currentBill,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
    required TResult Function(InitiateRefund value) initiateRefund,
  }) {
    return processPaymentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult? Function(InitiateRefund value)? initiateRefund,
  }) {
    return processPaymentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult Function(InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (processPaymentSuccess != null) {
      return processPaymentSuccess(this);
    }
    return orElse();
  }
}

abstract class ProcessPaymentSuccess implements ConfirmBillEvent {
  const factory ProcessPaymentSuccess({
    required final String orderId,
    required final String transactionId,
    required final String receiptId,
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
    required final ElectricityBillModel? currentBill,
  }) = _$ProcessPaymentSuccessImpl;

  String get orderId;
  String get transactionId;
  @override
  String get receiptId;
  String get providerID;
  String get phoneNo;
  String get consumerId;
  ElectricityBillModel? get currentBill;

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessPaymentSuccessImplCopyWith<_$ProcessPaymentSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessPaymentFailureImplCopyWith<$Res>
    implements $ConfirmBillEventCopyWith<$Res> {
  factory _$$ProcessPaymentFailureImplCopyWith(
    _$ProcessPaymentFailureImpl value,
    $Res Function(_$ProcessPaymentFailureImpl) then,
  ) = __$$ProcessPaymentFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    String receiptId,
    String errorMessage,
  });
}

/// @nodoc
class __$$ProcessPaymentFailureImplCopyWithImpl<$Res>
    extends _$ConfirmBillEventCopyWithImpl<$Res, _$ProcessPaymentFailureImpl>
    implements _$$ProcessPaymentFailureImplCopyWith<$Res> {
  __$$ProcessPaymentFailureImplCopyWithImpl(
    _$ProcessPaymentFailureImpl _value,
    $Res Function(_$ProcessPaymentFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? transactionId = null,
    Object? receiptId = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _$ProcessPaymentFailureImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptId: null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProcessPaymentFailureImpl implements ProcessPaymentFailure {
  const _$ProcessPaymentFailureImpl({
    required this.orderId,
    required this.transactionId,
    required this.receiptId,
    required this.errorMessage,
  });

  @override
  final String orderId;
  @override
  final String transactionId;
  @override
  final String receiptId;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'ConfirmBillEvent.processPaymentFailure(orderId: $orderId, transactionId: $transactionId, receiptId: $receiptId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessPaymentFailureImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, orderId, transactionId, receiptId, errorMessage);

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessPaymentFailureImplCopyWith<_$ProcessPaymentFailureImpl>
  get copyWith =>
      __$$ProcessPaymentFailureImplCopyWithImpl<_$ProcessPaymentFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
    required TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )
    initiateRefund,
  }) {
    return processPaymentFailure(
      orderId,
      transactionId,
      receiptId,
      errorMessage,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult? Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
  }) {
    return processPaymentFailure?.call(
      orderId,
      transactionId,
      receiptId,
      errorMessage,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (processPaymentFailure != null) {
      return processPaymentFailure(
        orderId,
        transactionId,
        receiptId,
        errorMessage,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
    required TResult Function(InitiateRefund value) initiateRefund,
  }) {
    return processPaymentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult? Function(InitiateRefund value)? initiateRefund,
  }) {
    return processPaymentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult Function(InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (processPaymentFailure != null) {
      return processPaymentFailure(this);
    }
    return orElse();
  }
}

abstract class ProcessPaymentFailure implements ConfirmBillEvent {
  const factory ProcessPaymentFailure({
    required final String orderId,
    required final String transactionId,
    required final String receiptId,
    required final String errorMessage,
  }) = _$ProcessPaymentFailureImpl;

  String get orderId;
  String get transactionId;
  @override
  String get receiptId;
  String get errorMessage;

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessPaymentFailureImplCopyWith<_$ProcessPaymentFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitiateRefundImplCopyWith<$Res>
    implements $ConfirmBillEventCopyWith<$Res> {
  factory _$$InitiateRefundImplCopyWith(
    _$InitiateRefundImpl value,
    $Res Function(_$InitiateRefundImpl) then,
  ) = __$$InitiateRefundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String transactionId,
    String receiptId,
    String amount,
    String reason,
  });
}

/// @nodoc
class __$$InitiateRefundImplCopyWithImpl<$Res>
    extends _$ConfirmBillEventCopyWithImpl<$Res, _$InitiateRefundImpl>
    implements _$$InitiateRefundImplCopyWith<$Res> {
  __$$InitiateRefundImplCopyWithImpl(
    _$InitiateRefundImpl _value,
    $Res Function(_$InitiateRefundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? receiptId = null,
    Object? amount = null,
    Object? reason = null,
  }) {
    return _then(
      _$InitiateRefundImpl(
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptId: null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
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

class _$InitiateRefundImpl implements InitiateRefund {
  const _$InitiateRefundImpl({
    required this.transactionId,
    required this.receiptId,
    required this.amount,
    required this.reason,
  });

  @override
  final String transactionId;
  @override
  final String receiptId;
  @override
  final String amount;
  @override
  final String reason;

  @override
  String toString() {
    return 'ConfirmBillEvent.initiateRefund(transactionId: $transactionId, receiptId: $receiptId, amount: $amount, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateRefundImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, transactionId, receiptId, amount, reason);

  /// Create a copy of ConfirmBillEvent
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
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
    required TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )
    initiateRefund,
  }) {
    return initiateRefund(transactionId, receiptId, amount, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult? Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
  }) {
    return initiateRefund?.call(transactionId, receiptId, amount, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
      String receiptId,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
      ElectricityBillModel? currentBill,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    TResult Function(
      String transactionId,
      String receiptId,
      String amount,
      String reason,
    )?
    initiateRefund,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(transactionId, receiptId, amount, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
    required TResult Function(InitiateRefund value) initiateRefund,
  }) {
    return initiateRefund(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult? Function(InitiateRefund value)? initiateRefund,
  }) {
    return initiateRefund?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    TResult Function(InitiateRefund value)? initiateRefund,
    required TResult orElse(),
  }) {
    if (initiateRefund != null) {
      return initiateRefund(this);
    }
    return orElse();
  }
}

abstract class InitiateRefund implements ConfirmBillEvent {
  const factory InitiateRefund({
    required final String transactionId,
    required final String receiptId,
    required final String amount,
    required final String reason,
  }) = _$InitiateRefundImpl;

  String get transactionId;
  @override
  String get receiptId;
  String get amount;
  String get reason;

  /// Create a copy of ConfirmBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateRefundImplCopyWith<_$InitiateRefundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConfirmBillState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmBillStateCopyWith<$Res> {
  factory $ConfirmBillStateCopyWith(
    ConfirmBillState value,
    $Res Function(ConfirmBillState) then,
  ) = _$ConfirmBillStateCopyWithImpl<$Res, ConfirmBillState>;
}

/// @nodoc
class _$ConfirmBillStateCopyWithImpl<$Res, $Val extends ConfirmBillState>
    implements $ConfirmBillStateCopyWith<$Res> {
  _$ConfirmBillStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ConfirmBillState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ConfirmBillState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$PaymentProcessingImplCopyWith<$Res> {
  factory _$$PaymentProcessingImplCopyWith(
    _$PaymentProcessingImpl value,
    $Res Function(_$PaymentProcessingImpl) then,
  ) = __$$PaymentProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaymentProcessingImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$PaymentProcessingImpl>
    implements _$$PaymentProcessingImplCopyWith<$Res> {
  __$$PaymentProcessingImplCopyWithImpl(
    _$PaymentProcessingImpl _value,
    $Res Function(_$PaymentProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentProcessingImpl implements _PaymentProcessing {
  const _$PaymentProcessingImpl();

  @override
  String toString() {
    return 'ConfirmBillState.paymentProcessing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PaymentProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return paymentProcessing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return paymentProcessing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentProcessing != null) {
      return paymentProcessing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return paymentProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return paymentProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentProcessing != null) {
      return paymentProcessing(this);
    }
    return orElse();
  }
}

abstract class _PaymentProcessing implements ConfirmBillState {
  const factory _PaymentProcessing() = _$PaymentProcessingImpl;
}

/// @nodoc
abstract class _$$OrderCreatedImplCopyWith<$Res> {
  factory _$$OrderCreatedImplCopyWith(
    _$OrderCreatedImpl value,
    $Res Function(_$OrderCreatedImpl) then,
  ) = __$$OrderCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId, String receiptId, ElectricityBillModel bill});
}

/// @nodoc
class __$$OrderCreatedImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$OrderCreatedImpl>
    implements _$$OrderCreatedImplCopyWith<$Res> {
  __$$OrderCreatedImplCopyWithImpl(
    _$OrderCreatedImpl _value,
    $Res Function(_$OrderCreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? receiptId = null,
    Object? bill = null,
  }) {
    return _then(
      _$OrderCreatedImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptId: null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
        bill: null == bill
            ? _value.bill
            : bill // ignore: cast_nullable_to_non_nullable
                  as ElectricityBillModel,
      ),
    );
  }
}

/// @nodoc

class _$OrderCreatedImpl implements _OrderCreated {
  const _$OrderCreatedImpl({
    required this.orderId,
    required this.receiptId,
    required this.bill,
  });

  @override
  final String orderId;
  @override
  final String receiptId;
  @override
  final ElectricityBillModel bill;

  @override
  String toString() {
    return 'ConfirmBillState.orderCreated(orderId: $orderId, receiptId: $receiptId, bill: $bill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCreatedImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId) &&
            (identical(other.bill, bill) || other.bill == bill));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId, receiptId, bill);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCreatedImplCopyWith<_$OrderCreatedImpl> get copyWith =>
      __$$OrderCreatedImplCopyWithImpl<_$OrderCreatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return orderCreated(orderId, receiptId, bill);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return orderCreated?.call(orderId, receiptId, bill);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (orderCreated != null) {
      return orderCreated(orderId, receiptId, bill);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return orderCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return orderCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (orderCreated != null) {
      return orderCreated(this);
    }
    return orElse();
  }
}

abstract class _OrderCreated implements ConfirmBillState {
  const factory _OrderCreated({
    required final String orderId,
    required final String receiptId,
    required final ElectricityBillModel bill,
  }) = _$OrderCreatedImpl;

  String get orderId;
  String get receiptId;
  ElectricityBillModel get bill;

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCreatedImplCopyWith<_$OrderCreatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentSuccessImplCopyWith<$Res> {
  factory _$$PaymentSuccessImplCopyWith(
    _$PaymentSuccessImpl value,
    $Res Function(_$PaymentSuccessImpl) then,
  ) = __$$PaymentSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String receiptId});
}

/// @nodoc
class __$$PaymentSuccessImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$PaymentSuccessImpl>
    implements _$$PaymentSuccessImplCopyWith<$Res> {
  __$$PaymentSuccessImplCopyWithImpl(
    _$PaymentSuccessImpl _value,
    $Res Function(_$PaymentSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? receiptId = null}) {
    return _then(
      _$PaymentSuccessImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentSuccessImpl implements _PaymentSuccess {
  const _$PaymentSuccessImpl(this.message, this.receiptId);

  @override
  final String message;
  @override
  final String receiptId;

  @override
  String toString() {
    return 'ConfirmBillState.paymentSuccess(message: $message, receiptId: $receiptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, receiptId);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentSuccessImplCopyWith<_$PaymentSuccessImpl> get copyWith =>
      __$$PaymentSuccessImplCopyWithImpl<_$PaymentSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return paymentSuccess(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return paymentSuccess?.call(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentSuccess != null) {
      return paymentSuccess(message, receiptId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return paymentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return paymentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentSuccess != null) {
      return paymentSuccess(this);
    }
    return orElse();
  }
}

abstract class _PaymentSuccess implements ConfirmBillState {
  const factory _PaymentSuccess(final String message, final String receiptId) =
      _$PaymentSuccessImpl;

  String get message;
  String get receiptId;

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentSuccessImplCopyWith<_$PaymentSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaymentErrorImplCopyWith<$Res> {
  factory _$$PaymentErrorImplCopyWith(
    _$PaymentErrorImpl value,
    $Res Function(_$PaymentErrorImpl) then,
  ) = __$$PaymentErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PaymentErrorImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$PaymentErrorImpl>
    implements _$$PaymentErrorImplCopyWith<$Res> {
  __$$PaymentErrorImplCopyWithImpl(
    _$PaymentErrorImpl _value,
    $Res Function(_$PaymentErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$PaymentErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentErrorImpl implements _PaymentError {
  const _$PaymentErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ConfirmBillState.paymentError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      __$$PaymentErrorImplCopyWithImpl<_$PaymentErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return paymentError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return paymentError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentError != null) {
      return paymentError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return paymentError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return paymentError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (paymentError != null) {
      return paymentError(this);
    }
    return orElse();
  }
}

abstract class _PaymentError implements ConfirmBillState {
  const factory _PaymentError(final String message) = _$PaymentErrorImpl;

  String get message;

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefundProcessingImplCopyWith<$Res> {
  factory _$$RefundProcessingImplCopyWith(
    _$RefundProcessingImpl value,
    $Res Function(_$RefundProcessingImpl) then,
  ) = __$$RefundProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefundProcessingImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$RefundProcessingImpl>
    implements _$$RefundProcessingImplCopyWith<$Res> {
  __$$RefundProcessingImplCopyWithImpl(
    _$RefundProcessingImpl _value,
    $Res Function(_$RefundProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefundProcessingImpl implements _RefundProcessing {
  const _$RefundProcessingImpl();

  @override
  String toString() {
    return 'ConfirmBillState.refundProcessing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefundProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return refundProcessing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return refundProcessing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundProcessing != null) {
      return refundProcessing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return refundProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return refundProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundProcessing != null) {
      return refundProcessing(this);
    }
    return orElse();
  }
}

abstract class _RefundProcessing implements ConfirmBillState {
  const factory _RefundProcessing() = _$RefundProcessingImpl;
}

/// @nodoc
abstract class _$$RefundSuccessImplCopyWith<$Res> {
  factory _$$RefundSuccessImplCopyWith(
    _$RefundSuccessImpl value,
    $Res Function(_$RefundSuccessImpl) then,
  ) = __$$RefundSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String receiptId});
}

/// @nodoc
class __$$RefundSuccessImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$RefundSuccessImpl>
    implements _$$RefundSuccessImplCopyWith<$Res> {
  __$$RefundSuccessImplCopyWithImpl(
    _$RefundSuccessImpl _value,
    $Res Function(_$RefundSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? receiptId = null}) {
    return _then(
      _$RefundSuccessImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RefundSuccessImpl implements _RefundSuccess {
  const _$RefundSuccessImpl(this.message, this.receiptId);

  @override
  final String message;
  @override
  final String receiptId;

  @override
  String toString() {
    return 'ConfirmBillState.refundSuccess(message: $message, receiptId: $receiptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefundSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, receiptId);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefundSuccessImplCopyWith<_$RefundSuccessImpl> get copyWith =>
      __$$RefundSuccessImplCopyWithImpl<_$RefundSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return refundSuccess(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return refundSuccess?.call(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundSuccess != null) {
      return refundSuccess(message, receiptId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return refundSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return refundSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundSuccess != null) {
      return refundSuccess(this);
    }
    return orElse();
  }
}

abstract class _RefundSuccess implements ConfirmBillState {
  const factory _RefundSuccess(final String message, final String receiptId) =
      _$RefundSuccessImpl;

  String get message;
  String get receiptId;

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefundSuccessImplCopyWith<_$RefundSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefundFailedImplCopyWith<$Res> {
  factory _$$RefundFailedImplCopyWith(
    _$RefundFailedImpl value,
    $Res Function(_$RefundFailedImpl) then,
  ) = __$$RefundFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String receiptId});
}

/// @nodoc
class __$$RefundFailedImplCopyWithImpl<$Res>
    extends _$ConfirmBillStateCopyWithImpl<$Res, _$RefundFailedImpl>
    implements _$$RefundFailedImplCopyWith<$Res> {
  __$$RefundFailedImplCopyWithImpl(
    _$RefundFailedImpl _value,
    $Res Function(_$RefundFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? receiptId = null}) {
    return _then(
      _$RefundFailedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RefundFailedImpl implements _RefundFailed {
  const _$RefundFailedImpl(this.message, this.receiptId);

  @override
  final String message;
  @override
  final String receiptId;

  @override
  String toString() {
    return 'ConfirmBillState.refundFailed(message: $message, receiptId: $receiptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefundFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, receiptId);

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefundFailedImplCopyWith<_$RefundFailedImpl> get copyWith =>
      __$$RefundFailedImplCopyWithImpl<_$RefundFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() paymentProcessing,
    required TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )
    orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
    required TResult Function() refundProcessing,
    required TResult Function(String message, String receiptId) refundSuccess,
    required TResult Function(String message, String receiptId) refundFailed,
  }) {
    return refundFailed(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? paymentProcessing,
    TResult? Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
    TResult? Function()? refundProcessing,
    TResult? Function(String message, String receiptId)? refundSuccess,
    TResult? Function(String message, String receiptId)? refundFailed,
  }) {
    return refundFailed?.call(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? paymentProcessing,
    TResult Function(
      String orderId,
      String receiptId,
      ElectricityBillModel bill,
    )?
    orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    TResult Function()? refundProcessing,
    TResult Function(String message, String receiptId)? refundSuccess,
    TResult Function(String message, String receiptId)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundFailed != null) {
      return refundFailed(message, receiptId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
    required TResult Function(_RefundProcessing value) refundProcessing,
    required TResult Function(_RefundSuccess value) refundSuccess,
    required TResult Function(_RefundFailed value) refundFailed,
  }) {
    return refundFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
    TResult? Function(_RefundProcessing value)? refundProcessing,
    TResult? Function(_RefundSuccess value)? refundSuccess,
    TResult? Function(_RefundFailed value)? refundFailed,
  }) {
    return refundFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    TResult Function(_RefundProcessing value)? refundProcessing,
    TResult Function(_RefundSuccess value)? refundSuccess,
    TResult Function(_RefundFailed value)? refundFailed,
    required TResult orElse(),
  }) {
    if (refundFailed != null) {
      return refundFailed(this);
    }
    return orElse();
  }
}

abstract class _RefundFailed implements ConfirmBillState {
  const factory _RefundFailed(final String message, final String receiptId) =
      _$RefundFailedImpl;

  String get message;
  String get receiptId;

  /// Create a copy of ConfirmBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefundFailedImplCopyWith<_$RefundFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
