// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hold_cab_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HoldCabEvent {
  Map<String, dynamic> get requestData => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> requestData) holdCab,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> requestData)? holdCab,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> requestData)? holdCab,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HoldCab value) holdCab,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HoldCab value)? holdCab,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HoldCab value)? holdCab,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of HoldCabEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldCabEventCopyWith<HoldCabEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldCabEventCopyWith<$Res> {
  factory $HoldCabEventCopyWith(
    HoldCabEvent value,
    $Res Function(HoldCabEvent) then,
  ) = _$HoldCabEventCopyWithImpl<$Res, HoldCabEvent>;
  @useResult
  $Res call({Map<String, dynamic> requestData});
}

/// @nodoc
class _$HoldCabEventCopyWithImpl<$Res, $Val extends HoldCabEvent>
    implements $HoldCabEventCopyWith<$Res> {
  _$HoldCabEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldCabEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestData = null}) {
    return _then(
      _value.copyWith(
            requestData: null == requestData
                ? _value.requestData
                : requestData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HoldCabImplCopyWith<$Res>
    implements $HoldCabEventCopyWith<$Res> {
  factory _$$HoldCabImplCopyWith(
    _$HoldCabImpl value,
    $Res Function(_$HoldCabImpl) then,
  ) = __$$HoldCabImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> requestData});
}

/// @nodoc
class __$$HoldCabImplCopyWithImpl<$Res>
    extends _$HoldCabEventCopyWithImpl<$Res, _$HoldCabImpl>
    implements _$$HoldCabImplCopyWith<$Res> {
  __$$HoldCabImplCopyWithImpl(
    _$HoldCabImpl _value,
    $Res Function(_$HoldCabImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HoldCabEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestData = null}) {
    return _then(
      _$HoldCabImpl(
        requestData: null == requestData
            ? _value._requestData
            : requestData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$HoldCabImpl implements _HoldCab {
  const _$HoldCabImpl({required final Map<String, dynamic> requestData})
    : _requestData = requestData;

  final Map<String, dynamic> _requestData;
  @override
  Map<String, dynamic> get requestData {
    if (_requestData is EqualUnmodifiableMapView) return _requestData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requestData);
  }

  @override
  String toString() {
    return 'HoldCabEvent.holdCab(requestData: $requestData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldCabImpl &&
            const DeepCollectionEquality().equals(
              other._requestData,
              _requestData,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_requestData),
  );

  /// Create a copy of HoldCabEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldCabImplCopyWith<_$HoldCabImpl> get copyWith =>
      __$$HoldCabImplCopyWithImpl<_$HoldCabImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> requestData) holdCab,
  }) {
    return holdCab(requestData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> requestData)? holdCab,
  }) {
    return holdCab?.call(requestData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> requestData)? holdCab,
    required TResult orElse(),
  }) {
    if (holdCab != null) {
      return holdCab(requestData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HoldCab value) holdCab,
  }) {
    return holdCab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HoldCab value)? holdCab,
  }) {
    return holdCab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HoldCab value)? holdCab,
    required TResult orElse(),
  }) {
    if (holdCab != null) {
      return holdCab(this);
    }
    return orElse();
  }
}

abstract class _HoldCab implements HoldCabEvent {
  const factory _HoldCab({required final Map<String, dynamic> requestData}) =
      _$HoldCabImpl;

  @override
  Map<String, dynamic> get requestData;

  /// Create a copy of HoldCabEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldCabImplCopyWith<_$HoldCabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
