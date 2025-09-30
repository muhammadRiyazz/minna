// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_bill_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FetchBillEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchWaterBill,
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchBillEventCopyWith<$Res> {
  factory $FetchBillEventCopyWith(
    FetchBillEvent value,
    $Res Function(FetchBillEvent) then,
  ) = _$FetchBillEventCopyWithImpl<$Res, FetchBillEvent>;
}

/// @nodoc
class _$FetchBillEventCopyWithImpl<$Res, $Val extends FetchBillEvent>
    implements $FetchBillEventCopyWith<$Res> {
  _$FetchBillEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchElectricityBillImplCopyWith<$Res> {
  factory _$$FetchElectricityBillImplCopyWith(
    _$FetchElectricityBillImpl value,
    $Res Function(_$FetchElectricityBillImpl) then,
  ) = __$$FetchElectricityBillImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerID, String phoneNo, String consumerId});
}

/// @nodoc
class __$$FetchElectricityBillImplCopyWithImpl<$Res>
    extends _$FetchBillEventCopyWithImpl<$Res, _$FetchElectricityBillImpl>
    implements _$$FetchElectricityBillImplCopyWith<$Res> {
  __$$FetchElectricityBillImplCopyWithImpl(
    _$FetchElectricityBillImpl _value,
    $Res Function(_$FetchElectricityBillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
  }) {
    return _then(
      _$FetchElectricityBillImpl(
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
      ),
    );
  }
}

/// @nodoc

class _$FetchElectricityBillImpl implements FetchElectricityBill {
  const _$FetchElectricityBillImpl({
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
  });

  @override
  final String providerID;
  @override
  final String phoneNo;
  @override
  final String consumerId;

  @override
  String toString() {
    return 'FetchBillEvent.fetchElectricityBill(providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchElectricityBillImpl &&
            (identical(other.providerID, providerID) ||
                other.providerID == providerID) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.consumerId, consumerId) ||
                other.consumerId == consumerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerID, phoneNo, consumerId);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchElectricityBillImplCopyWith<_$FetchElectricityBillImpl>
  get copyWith =>
      __$$FetchElectricityBillImplCopyWithImpl<_$FetchElectricityBillImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchWaterBill,
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
  }) {
    return fetchElectricityBill(providerID, phoneNo, consumerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
  }) {
    return fetchElectricityBill?.call(providerID, phoneNo, consumerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    required TResult orElse(),
  }) {
    if (fetchElectricityBill != null) {
      return fetchElectricityBill(providerID, phoneNo, consumerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
  }) {
    return fetchElectricityBill(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
  }) {
    return fetchElectricityBill?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    required TResult orElse(),
  }) {
    if (fetchElectricityBill != null) {
      return fetchElectricityBill(this);
    }
    return orElse();
  }
}

abstract class FetchElectricityBill implements FetchBillEvent {
  const factory FetchElectricityBill({
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
  }) = _$FetchElectricityBillImpl;

  String get providerID;
  String get phoneNo;
  String get consumerId;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchElectricityBillImplCopyWith<_$FetchElectricityBillImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchWaterBillImplCopyWith<$Res> {
  factory _$$FetchWaterBillImplCopyWith(
    _$FetchWaterBillImpl value,
    $Res Function(_$FetchWaterBillImpl) then,
  ) = __$$FetchWaterBillImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerID, String phoneNo, String consumerId});
}

/// @nodoc
class __$$FetchWaterBillImplCopyWithImpl<$Res>
    extends _$FetchBillEventCopyWithImpl<$Res, _$FetchWaterBillImpl>
    implements _$$FetchWaterBillImplCopyWith<$Res> {
  __$$FetchWaterBillImplCopyWithImpl(
    _$FetchWaterBillImpl _value,
    $Res Function(_$FetchWaterBillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
  }) {
    return _then(
      _$FetchWaterBillImpl(
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
      ),
    );
  }
}

/// @nodoc

class _$FetchWaterBillImpl implements FetchWaterBill {
  const _$FetchWaterBillImpl({
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
  });

  @override
  final String providerID;
  @override
  final String phoneNo;
  @override
  final String consumerId;

  @override
  String toString() {
    return 'FetchBillEvent.fetchWaterBill(providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchWaterBillImpl &&
            (identical(other.providerID, providerID) ||
                other.providerID == providerID) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.consumerId, consumerId) ||
                other.consumerId == consumerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerID, phoneNo, consumerId);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchWaterBillImplCopyWith<_$FetchWaterBillImpl> get copyWith =>
      __$$FetchWaterBillImplCopyWithImpl<_$FetchWaterBillImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchWaterBill,
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
  }) {
    return fetchWaterBill(providerID, phoneNo, consumerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
  }) {
    return fetchWaterBill?.call(providerID, phoneNo, consumerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    required TResult orElse(),
  }) {
    if (fetchWaterBill != null) {
      return fetchWaterBill(providerID, phoneNo, consumerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
  }) {
    return fetchWaterBill(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
  }) {
    return fetchWaterBill?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    required TResult orElse(),
  }) {
    if (fetchWaterBill != null) {
      return fetchWaterBill(this);
    }
    return orElse();
  }
}

abstract class FetchWaterBill implements FetchBillEvent {
  const factory FetchWaterBill({
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
  }) = _$FetchWaterBillImpl;

  String get providerID;
  String get phoneNo;
  String get consumerId;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchWaterBillImplCopyWith<_$FetchWaterBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitiatePaymentImplCopyWith<$Res> {
  factory _$$InitiatePaymentImplCopyWith(
    _$InitiatePaymentImpl value,
    $Res Function(_$InitiatePaymentImpl) then,
  ) = __$$InitiatePaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    ElectricityBillModel bill,
    String providerID,
    String phoneNo,
    String consumerId,
    String providerName,
  });
}

/// @nodoc
class __$$InitiatePaymentImplCopyWithImpl<$Res>
    extends _$FetchBillEventCopyWithImpl<$Res, _$InitiatePaymentImpl>
    implements _$$InitiatePaymentImplCopyWith<$Res> {
  __$$InitiatePaymentImplCopyWithImpl(
    _$InitiatePaymentImpl _value,
    $Res Function(_$InitiatePaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bill = null,
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
    Object? providerName = null,
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
  String toString() {
    return 'FetchBillEvent.initiatePayment(bill: $bill, providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId, providerName: $providerName)';
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
                other.providerName == providerName));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    bill,
    providerID,
    phoneNo,
    consumerId,
    providerName,
  );

  /// Create a copy of FetchBillEvent
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
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchWaterBill,
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
  }) {
    return initiatePayment(bill, providerID, phoneNo, consumerId, providerName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
  }) {
    return initiatePayment?.call(
      bill,
      providerID,
      phoneNo,
      consumerId,
      providerName,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
    required TResult orElse(),
  }) {
    if (initiatePayment != null) {
      return initiatePayment(
        bill,
        providerID,
        phoneNo,
        consumerId,
        providerName,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
  }) {
    return initiatePayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
  }) {
    return initiatePayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    required TResult orElse(),
  }) {
    if (initiatePayment != null) {
      return initiatePayment(this);
    }
    return orElse();
  }
}

abstract class InitiatePayment implements FetchBillEvent {
  const factory InitiatePayment({
    required final ElectricityBillModel bill,
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
    required final String providerName,
  }) = _$InitiatePaymentImpl;

  ElectricityBillModel get bill;
  String get providerID;
  String get phoneNo;
  String get consumerId;
  String get providerName;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiatePaymentImplCopyWith<_$InitiatePaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessPaymentSuccessImplCopyWith<$Res> {
  factory _$$ProcessPaymentSuccessImplCopyWith(
    _$ProcessPaymentSuccessImpl value,
    $Res Function(_$ProcessPaymentSuccessImpl) then,
  ) = __$$ProcessPaymentSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String orderId,
    String transactionId,
    String receiptId,
    String providerID,
    String phoneNo,
    String consumerId,
  });
}

/// @nodoc
class __$$ProcessPaymentSuccessImplCopyWithImpl<$Res>
    extends _$FetchBillEventCopyWithImpl<$Res, _$ProcessPaymentSuccessImpl>
    implements _$$ProcessPaymentSuccessImplCopyWith<$Res> {
  __$$ProcessPaymentSuccessImplCopyWithImpl(
    _$ProcessPaymentSuccessImpl _value,
    $Res Function(_$ProcessPaymentSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
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
  String toString() {
    return 'FetchBillEvent.processPaymentSuccess(orderId: $orderId, transactionId: $transactionId, receiptId: $receiptId, providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId)';
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
                other.consumerId == consumerId));
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
  );

  /// Create a copy of FetchBillEvent
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
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchWaterBill,
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
  }) {
    return processPaymentSuccess(
      orderId,
      transactionId,
      receiptId,
      providerID,
      phoneNo,
      consumerId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
  }) {
    return processPaymentSuccess?.call(
      orderId,
      transactionId,
      receiptId,
      providerID,
      phoneNo,
      consumerId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
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
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
  }) {
    return processPaymentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
  }) {
    return processPaymentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    required TResult orElse(),
  }) {
    if (processPaymentSuccess != null) {
      return processPaymentSuccess(this);
    }
    return orElse();
  }
}

abstract class ProcessPaymentSuccess implements FetchBillEvent {
  const factory ProcessPaymentSuccess({
    required final String orderId,
    required final String transactionId,
    required final String receiptId,
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
  }) = _$ProcessPaymentSuccessImpl;

  String get orderId;
  String get transactionId;
  String get receiptId;
  String get providerID;
  String get phoneNo;
  String get consumerId;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessPaymentSuccessImplCopyWith<_$ProcessPaymentSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessPaymentFailureImplCopyWith<$Res> {
  factory _$$ProcessPaymentFailureImplCopyWith(
    _$ProcessPaymentFailureImpl value,
    $Res Function(_$ProcessPaymentFailureImpl) then,
  ) = __$$ProcessPaymentFailureImplCopyWithImpl<$Res>;
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
    extends _$FetchBillEventCopyWithImpl<$Res, _$ProcessPaymentFailureImpl>
    implements _$$ProcessPaymentFailureImplCopyWith<$Res> {
  __$$ProcessPaymentFailureImplCopyWithImpl(
    _$ProcessPaymentFailureImpl _value,
    $Res Function(_$ProcessPaymentFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
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
    return 'FetchBillEvent.processPaymentFailure(orderId: $orderId, transactionId: $transactionId, receiptId: $receiptId, errorMessage: $errorMessage)';
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

  /// Create a copy of FetchBillEvent
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
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
    )
    fetchWaterBill,
    required TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    initiatePayment,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )
    processPaymentSuccess,
    required TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )
    processPaymentFailure,
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
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult? Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult? Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult? Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
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
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchElectricityBill,
    TResult Function(String providerID, String phoneNo, String consumerId)?
    fetchWaterBill,
    TResult Function(
      ElectricityBillModel bill,
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    initiatePayment,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String providerID,
      String phoneNo,
      String consumerId,
    )?
    processPaymentSuccess,
    TResult Function(
      String orderId,
      String transactionId,
      String receiptId,
      String errorMessage,
    )?
    processPaymentFailure,
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
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
    required TResult Function(InitiatePayment value) initiatePayment,
    required TResult Function(ProcessPaymentSuccess value)
    processPaymentSuccess,
    required TResult Function(ProcessPaymentFailure value)
    processPaymentFailure,
  }) {
    return processPaymentFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
    TResult? Function(InitiatePayment value)? initiatePayment,
    TResult? Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult? Function(ProcessPaymentFailure value)? processPaymentFailure,
  }) {
    return processPaymentFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    TResult Function(InitiatePayment value)? initiatePayment,
    TResult Function(ProcessPaymentSuccess value)? processPaymentSuccess,
    TResult Function(ProcessPaymentFailure value)? processPaymentFailure,
    required TResult orElse(),
  }) {
    if (processPaymentFailure != null) {
      return processPaymentFailure(this);
    }
    return orElse();
  }
}

abstract class ProcessPaymentFailure implements FetchBillEvent {
  const factory ProcessPaymentFailure({
    required final String orderId,
    required final String transactionId,
    required final String receiptId,
    required final String errorMessage,
  }) = _$ProcessPaymentFailureImpl;

  String get orderId;
  String get transactionId;
  String get receiptId;
  String get errorMessage;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessPaymentFailureImplCopyWith<_$ProcessPaymentFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FetchBillState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchBillStateCopyWith<$Res> {
  factory $FetchBillStateCopyWith(
    FetchBillState value,
    $Res Function(FetchBillState) then,
  ) = _$FetchBillStateCopyWithImpl<$Res, FetchBillState>;
}

/// @nodoc
class _$FetchBillStateCopyWithImpl<$Res, $Val extends FetchBillState>
    implements $FetchBillStateCopyWith<$Res> {
  _$FetchBillStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FetchBillState
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
    extends _$FetchBillStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'FetchBillState.initial()';
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
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements FetchBillState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'FetchBillState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements FetchBillState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ElectricityBillModel bill});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bill = null}) {
    return _then(
      _$SuccessImpl(
        bill: null == bill
            ? _value.bill
            : bill // ignore: cast_nullable_to_non_nullable
                  as ElectricityBillModel,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({required this.bill});

  @override
  final ElectricityBillModel bill;

  @override
  String toString() {
    return 'FetchBillState.success(bill: $bill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.bill, bill) || other.bill == bill));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bill);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return success(bill);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return success?.call(bill);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(bill);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements FetchBillState {
  const factory _Success({required final ElectricityBillModel bill}) =
      _$SuccessImpl;

  ElectricityBillModel get bill;

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'FetchBillState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements FetchBillState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$FetchBillStateCopyWithImpl<$Res, _$PaymentProcessingImpl>
    implements _$$PaymentProcessingImplCopyWith<$Res> {
  __$$PaymentProcessingImplCopyWithImpl(
    _$PaymentProcessingImpl _value,
    $Res Function(_$PaymentProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentProcessingImpl implements _PaymentProcessing {
  const _$PaymentProcessingImpl();

  @override
  String toString() {
    return 'FetchBillState.paymentProcessing()';
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
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return paymentProcessing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return paymentProcessing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return paymentProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return paymentProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (paymentProcessing != null) {
      return paymentProcessing(this);
    }
    return orElse();
  }
}

abstract class _PaymentProcessing implements FetchBillState {
  const factory _PaymentProcessing() = _$PaymentProcessingImpl;
}

/// @nodoc
abstract class _$$OrderCreatedImplCopyWith<$Res> {
  factory _$$OrderCreatedImplCopyWith(
    _$OrderCreatedImpl value,
    $Res Function(_$OrderCreatedImpl) then,
  ) = __$$OrderCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId, String receiptId});
}

/// @nodoc
class __$$OrderCreatedImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$OrderCreatedImpl>
    implements _$$OrderCreatedImplCopyWith<$Res> {
  __$$OrderCreatedImplCopyWithImpl(
    _$OrderCreatedImpl _value,
    $Res Function(_$OrderCreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null, Object? receiptId = null}) {
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
      ),
    );
  }
}

/// @nodoc

class _$OrderCreatedImpl implements _OrderCreated {
  const _$OrderCreatedImpl({required this.orderId, required this.receiptId});

  @override
  final String orderId;
  @override
  final String receiptId;

  @override
  String toString() {
    return 'FetchBillState.orderCreated(orderId: $orderId, receiptId: $receiptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCreatedImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId, receiptId);

  /// Create a copy of FetchBillState
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
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return orderCreated(orderId, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return orderCreated?.call(orderId, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
    required TResult orElse(),
  }) {
    if (orderCreated != null) {
      return orderCreated(orderId, receiptId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return orderCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return orderCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (orderCreated != null) {
      return orderCreated(this);
    }
    return orElse();
  }
}

abstract class _OrderCreated implements FetchBillState {
  const factory _OrderCreated({
    required final String orderId,
    required final String receiptId,
  }) = _$OrderCreatedImpl;

  String get orderId;
  String get receiptId;

  /// Create a copy of FetchBillState
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
    extends _$FetchBillStateCopyWithImpl<$Res, _$PaymentSuccessImpl>
    implements _$$PaymentSuccessImplCopyWith<$Res> {
  __$$PaymentSuccessImplCopyWithImpl(
    _$PaymentSuccessImpl _value,
    $Res Function(_$PaymentSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
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
    return 'FetchBillState.paymentSuccess(message: $message, receiptId: $receiptId)';
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

  /// Create a copy of FetchBillState
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
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return paymentSuccess(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return paymentSuccess?.call(message, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return paymentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return paymentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (paymentSuccess != null) {
      return paymentSuccess(this);
    }
    return orElse();
  }
}

abstract class _PaymentSuccess implements FetchBillState {
  const factory _PaymentSuccess(final String message, final String receiptId) =
      _$PaymentSuccessImpl;

  String get message;
  String get receiptId;

  /// Create a copy of FetchBillState
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
    extends _$FetchBillStateCopyWithImpl<$Res, _$PaymentErrorImpl>
    implements _$$PaymentErrorImplCopyWith<$Res> {
  __$$PaymentErrorImplCopyWithImpl(
    _$PaymentErrorImpl _value,
    $Res Function(_$PaymentErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
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
    return 'FetchBillState.paymentError(message: $message)';
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

  /// Create a copy of FetchBillState
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
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill) success,
    required TResult Function(String message) error,
    required TResult Function() paymentProcessing,
    required TResult Function(String orderId, String receiptId) orderCreated,
    required TResult Function(String message, String receiptId) paymentSuccess,
    required TResult Function(String message) paymentError,
  }) {
    return paymentError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill)? success,
    TResult? Function(String message)? error,
    TResult? Function()? paymentProcessing,
    TResult? Function(String orderId, String receiptId)? orderCreated,
    TResult? Function(String message, String receiptId)? paymentSuccess,
    TResult? Function(String message)? paymentError,
  }) {
    return paymentError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill)? success,
    TResult Function(String message)? error,
    TResult Function()? paymentProcessing,
    TResult Function(String orderId, String receiptId)? orderCreated,
    TResult Function(String message, String receiptId)? paymentSuccess,
    TResult Function(String message)? paymentError,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PaymentProcessing value) paymentProcessing,
    required TResult Function(_OrderCreated value) orderCreated,
    required TResult Function(_PaymentSuccess value) paymentSuccess,
    required TResult Function(_PaymentError value) paymentError,
  }) {
    return paymentError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PaymentProcessing value)? paymentProcessing,
    TResult? Function(_OrderCreated value)? orderCreated,
    TResult? Function(_PaymentSuccess value)? paymentSuccess,
    TResult? Function(_PaymentError value)? paymentError,
  }) {
    return paymentError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PaymentProcessing value)? paymentProcessing,
    TResult Function(_OrderCreated value)? orderCreated,
    TResult Function(_PaymentSuccess value)? paymentSuccess,
    TResult Function(_PaymentError value)? paymentError,
    required TResult orElse(),
  }) {
    if (paymentError != null) {
      return paymentError(this);
    }
    return orElse();
  }
}

abstract class _PaymentError implements FetchBillState {
  const factory _PaymentError(final String message) = _$PaymentErrorImpl;

  String get message;

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentErrorImplCopyWith<_$PaymentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
