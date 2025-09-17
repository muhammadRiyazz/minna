// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_cabs_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FetchCabsEvent {
  Map<String, dynamic> get requestData => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> requestData) fetchCabs,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> requestData)? fetchCabs,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> requestData)? fetchCabs,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchCabs value) fetchCabs,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchCabs value)? fetchCabs,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchCabs value)? fetchCabs,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of FetchCabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FetchCabsEventCopyWith<FetchCabsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchCabsEventCopyWith<$Res> {
  factory $FetchCabsEventCopyWith(
    FetchCabsEvent value,
    $Res Function(FetchCabsEvent) then,
  ) = _$FetchCabsEventCopyWithImpl<$Res, FetchCabsEvent>;
  @useResult
  $Res call({Map<String, dynamic> requestData});
}

/// @nodoc
class _$FetchCabsEventCopyWithImpl<$Res, $Val extends FetchCabsEvent>
    implements $FetchCabsEventCopyWith<$Res> {
  _$FetchCabsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FetchCabsEvent
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
abstract class _$$FetchCabsImplCopyWith<$Res>
    implements $FetchCabsEventCopyWith<$Res> {
  factory _$$FetchCabsImplCopyWith(
    _$FetchCabsImpl value,
    $Res Function(_$FetchCabsImpl) then,
  ) = __$$FetchCabsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> requestData});
}

/// @nodoc
class __$$FetchCabsImplCopyWithImpl<$Res>
    extends _$FetchCabsEventCopyWithImpl<$Res, _$FetchCabsImpl>
    implements _$$FetchCabsImplCopyWith<$Res> {
  __$$FetchCabsImplCopyWithImpl(
    _$FetchCabsImpl _value,
    $Res Function(_$FetchCabsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchCabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestData = null}) {
    return _then(
      _$FetchCabsImpl(
        requestData: null == requestData
            ? _value._requestData
            : requestData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$FetchCabsImpl implements _FetchCabs {
  const _$FetchCabsImpl({required final Map<String, dynamic> requestData})
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
    return 'FetchCabsEvent.fetchCabs(requestData: $requestData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCabsImpl &&
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

  /// Create a copy of FetchCabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCabsImplCopyWith<_$FetchCabsImpl> get copyWith =>
      __$$FetchCabsImplCopyWithImpl<_$FetchCabsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> requestData) fetchCabs,
  }) {
    return fetchCabs(requestData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> requestData)? fetchCabs,
  }) {
    return fetchCabs?.call(requestData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> requestData)? fetchCabs,
    required TResult orElse(),
  }) {
    if (fetchCabs != null) {
      return fetchCabs(requestData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchCabs value) fetchCabs,
  }) {
    return fetchCabs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchCabs value)? fetchCabs,
  }) {
    return fetchCabs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchCabs value)? fetchCabs,
    required TResult orElse(),
  }) {
    if (fetchCabs != null) {
      return fetchCabs(this);
    }
    return orElse();
  }
}

abstract class _FetchCabs implements FetchCabsEvent {
  const factory _FetchCabs({required final Map<String, dynamic> requestData}) =
      _$FetchCabsImpl;

  @override
  Map<String, dynamic> get requestData;

  /// Create a copy of FetchCabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchCabsImplCopyWith<_$FetchCabsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
