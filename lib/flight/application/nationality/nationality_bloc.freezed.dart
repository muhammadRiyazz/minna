// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nationality_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NationalityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getList,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getList,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getList,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetList value) getList,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetList value)? getList,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetList value)? getList,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NationalityEventCopyWith<$Res> {
  factory $NationalityEventCopyWith(
    NationalityEvent value,
    $Res Function(NationalityEvent) then,
  ) = _$NationalityEventCopyWithImpl<$Res, NationalityEvent>;
}

/// @nodoc
class _$NationalityEventCopyWithImpl<$Res, $Val extends NationalityEvent>
    implements $NationalityEventCopyWith<$Res> {
  _$NationalityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NationalityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetListImplCopyWith<$Res> {
  factory _$$GetListImplCopyWith(
    _$GetListImpl value,
    $Res Function(_$GetListImpl) then,
  ) = __$$GetListImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetListImplCopyWithImpl<$Res>
    extends _$NationalityEventCopyWithImpl<$Res, _$GetListImpl>
    implements _$$GetListImplCopyWith<$Res> {
  __$$GetListImplCopyWithImpl(
    _$GetListImpl _value,
    $Res Function(_$GetListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetListImpl implements GetList {
  const _$GetListImpl();

  @override
  String toString() {
    return 'NationalityEvent.getList()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetListImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({required TResult Function() getList}) {
    return getList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({TResult? Function()? getList}) {
    return getList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getList,
    required TResult orElse(),
  }) {
    if (getList != null) {
      return getList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetList value) getList,
  }) {
    return getList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetList value)? getList,
  }) {
    return getList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetList value)? getList,
    required TResult orElse(),
  }) {
    if (getList != null) {
      return getList(this);
    }
    return orElse();
  }
}

abstract class GetList implements NationalityEvent {
  const factory GetList() = _$GetListImpl;
}

/// @nodoc
mixin _$NationalityState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Country> get nationalitList => throw _privateConstructorUsedError;

  /// Create a copy of NationalityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NationalityStateCopyWith<NationalityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NationalityStateCopyWith<$Res> {
  factory $NationalityStateCopyWith(
    NationalityState value,
    $Res Function(NationalityState) then,
  ) = _$NationalityStateCopyWithImpl<$Res, NationalityState>;
  @useResult
  $Res call({bool isLoading, List<Country> nationalitList});
}

/// @nodoc
class _$NationalityStateCopyWithImpl<$Res, $Val extends NationalityState>
    implements $NationalityStateCopyWith<$Res> {
  _$NationalityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NationalityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? nationalitList = null}) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            nationalitList: null == nationalitList
                ? _value.nationalitList
                : nationalitList // ignore: cast_nullable_to_non_nullable
                      as List<Country>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FetchNaionListStateImplCopyWith<$Res>
    implements $NationalityStateCopyWith<$Res> {
  factory _$$FetchNaionListStateImplCopyWith(
    _$FetchNaionListStateImpl value,
    $Res Function(_$FetchNaionListStateImpl) then,
  ) = __$$FetchNaionListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<Country> nationalitList});
}

/// @nodoc
class __$$FetchNaionListStateImplCopyWithImpl<$Res>
    extends _$NationalityStateCopyWithImpl<$Res, _$FetchNaionListStateImpl>
    implements _$$FetchNaionListStateImplCopyWith<$Res> {
  __$$FetchNaionListStateImplCopyWithImpl(
    _$FetchNaionListStateImpl _value,
    $Res Function(_$FetchNaionListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? nationalitList = null}) {
    return _then(
      _$FetchNaionListStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        nationalitList: null == nationalitList
            ? _value._nationalitList
            : nationalitList // ignore: cast_nullable_to_non_nullable
                  as List<Country>,
      ),
    );
  }
}

/// @nodoc

class _$FetchNaionListStateImpl implements _FetchNaionListState {
  const _$FetchNaionListStateImpl({
    required this.isLoading,
    required final List<Country> nationalitList,
  }) : _nationalitList = nationalitList;

  @override
  final bool isLoading;
  final List<Country> _nationalitList;
  @override
  List<Country> get nationalitList {
    if (_nationalitList is EqualUnmodifiableListView) return _nationalitList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nationalitList);
  }

  @override
  String toString() {
    return 'NationalityState(isLoading: $isLoading, nationalitList: $nationalitList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNaionListStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(
              other._nationalitList,
              _nationalitList,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_nationalitList),
  );

  /// Create a copy of NationalityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchNaionListStateImplCopyWith<_$FetchNaionListStateImpl> get copyWith =>
      __$$FetchNaionListStateImplCopyWithImpl<_$FetchNaionListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FetchNaionListState implements NationalityState {
  const factory _FetchNaionListState({
    required final bool isLoading,
    required final List<Country> nationalitList,
  }) = _$FetchNaionListStateImpl;

  @override
  bool get isLoading;
  @override
  List<Country> get nationalitList;

  /// Create a copy of NationalityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchNaionListStateImplCopyWith<_$FetchNaionListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
