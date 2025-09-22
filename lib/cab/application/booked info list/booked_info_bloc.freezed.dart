// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booked_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BookedInfoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fromDate, String? toDate) fetchList,
    required TResult Function(String query) searchChanged,
    required TResult Function(DateTime? date) dateFilterChanged,
    required TResult Function(String? status) statusFilterChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fromDate, String? toDate)? fetchList,
    TResult? Function(String query)? searchChanged,
    TResult? Function(DateTime? date)? dateFilterChanged,
    TResult? Function(String? status)? statusFilterChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fromDate, String? toDate)? fetchList,
    TResult Function(String query)? searchChanged,
    TResult Function(DateTime? date)? dateFilterChanged,
    TResult Function(String? status)? statusFilterChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchList value) fetchList,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_DateFilterChanged value) dateFilterChanged,
    required TResult Function(_StatusFilterChanged value) statusFilterChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchList value)? fetchList,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_DateFilterChanged value)? dateFilterChanged,
    TResult? Function(_StatusFilterChanged value)? statusFilterChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchList value)? fetchList,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_DateFilterChanged value)? dateFilterChanged,
    TResult Function(_StatusFilterChanged value)? statusFilterChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookedInfoEventCopyWith<$Res> {
  factory $BookedInfoEventCopyWith(
    BookedInfoEvent value,
    $Res Function(BookedInfoEvent) then,
  ) = _$BookedInfoEventCopyWithImpl<$Res, BookedInfoEvent>;
}

/// @nodoc
class _$BookedInfoEventCopyWithImpl<$Res, $Val extends BookedInfoEvent>
    implements $BookedInfoEventCopyWith<$Res> {
  _$BookedInfoEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchListImplCopyWith<$Res> {
  factory _$$FetchListImplCopyWith(
    _$FetchListImpl value,
    $Res Function(_$FetchListImpl) then,
  ) = __$$FetchListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? fromDate, String? toDate});
}

/// @nodoc
class __$$FetchListImplCopyWithImpl<$Res>
    extends _$BookedInfoEventCopyWithImpl<$Res, _$FetchListImpl>
    implements _$$FetchListImplCopyWith<$Res> {
  __$$FetchListImplCopyWithImpl(
    _$FetchListImpl _value,
    $Res Function(_$FetchListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fromDate = freezed, Object? toDate = freezed}) {
    return _then(
      _$FetchListImpl(
        fromDate: freezed == fromDate
            ? _value.fromDate
            : fromDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        toDate: freezed == toDate
            ? _value.toDate
            : toDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FetchListImpl implements _FetchList {
  const _$FetchListImpl({this.fromDate, this.toDate});

  @override
  final String? fromDate;
  @override
  final String? toDate;

  @override
  String toString() {
    return 'BookedInfoEvent.fetchList(fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchListImpl &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromDate, toDate);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchListImplCopyWith<_$FetchListImpl> get copyWith =>
      __$$FetchListImplCopyWithImpl<_$FetchListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fromDate, String? toDate) fetchList,
    required TResult Function(String query) searchChanged,
    required TResult Function(DateTime? date) dateFilterChanged,
    required TResult Function(String? status) statusFilterChanged,
  }) {
    return fetchList(fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fromDate, String? toDate)? fetchList,
    TResult? Function(String query)? searchChanged,
    TResult? Function(DateTime? date)? dateFilterChanged,
    TResult? Function(String? status)? statusFilterChanged,
  }) {
    return fetchList?.call(fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fromDate, String? toDate)? fetchList,
    TResult Function(String query)? searchChanged,
    TResult Function(DateTime? date)? dateFilterChanged,
    TResult Function(String? status)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(fromDate, toDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchList value) fetchList,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_DateFilterChanged value) dateFilterChanged,
    required TResult Function(_StatusFilterChanged value) statusFilterChanged,
  }) {
    return fetchList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchList value)? fetchList,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_DateFilterChanged value)? dateFilterChanged,
    TResult? Function(_StatusFilterChanged value)? statusFilterChanged,
  }) {
    return fetchList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchList value)? fetchList,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_DateFilterChanged value)? dateFilterChanged,
    TResult Function(_StatusFilterChanged value)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (fetchList != null) {
      return fetchList(this);
    }
    return orElse();
  }
}

abstract class _FetchList implements BookedInfoEvent {
  const factory _FetchList({final String? fromDate, final String? toDate}) =
      _$FetchListImpl;

  String? get fromDate;
  String? get toDate;

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchListImplCopyWith<_$FetchListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchChangedImplCopyWith<$Res> {
  factory _$$SearchChangedImplCopyWith(
    _$SearchChangedImpl value,
    $Res Function(_$SearchChangedImpl) then,
  ) = __$$SearchChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchChangedImplCopyWithImpl<$Res>
    extends _$BookedInfoEventCopyWithImpl<$Res, _$SearchChangedImpl>
    implements _$$SearchChangedImplCopyWith<$Res> {
  __$$SearchChangedImplCopyWithImpl(
    _$SearchChangedImpl _value,
    $Res Function(_$SearchChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchChangedImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchChangedImpl implements _SearchChanged {
  const _$SearchChangedImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'BookedInfoEvent.searchChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      __$$SearchChangedImplCopyWithImpl<_$SearchChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fromDate, String? toDate) fetchList,
    required TResult Function(String query) searchChanged,
    required TResult Function(DateTime? date) dateFilterChanged,
    required TResult Function(String? status) statusFilterChanged,
  }) {
    return searchChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fromDate, String? toDate)? fetchList,
    TResult? Function(String query)? searchChanged,
    TResult? Function(DateTime? date)? dateFilterChanged,
    TResult? Function(String? status)? statusFilterChanged,
  }) {
    return searchChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fromDate, String? toDate)? fetchList,
    TResult Function(String query)? searchChanged,
    TResult Function(DateTime? date)? dateFilterChanged,
    TResult Function(String? status)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchList value) fetchList,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_DateFilterChanged value) dateFilterChanged,
    required TResult Function(_StatusFilterChanged value) statusFilterChanged,
  }) {
    return searchChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchList value)? fetchList,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_DateFilterChanged value)? dateFilterChanged,
    TResult? Function(_StatusFilterChanged value)? statusFilterChanged,
  }) {
    return searchChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchList value)? fetchList,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_DateFilterChanged value)? dateFilterChanged,
    TResult Function(_StatusFilterChanged value)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(this);
    }
    return orElse();
  }
}

abstract class _SearchChanged implements BookedInfoEvent {
  const factory _SearchChanged(final String query) = _$SearchChangedImpl;

  String get query;

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DateFilterChangedImplCopyWith<$Res> {
  factory _$$DateFilterChangedImplCopyWith(
    _$DateFilterChangedImpl value,
    $Res Function(_$DateFilterChangedImpl) then,
  ) = __$$DateFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? date});
}

/// @nodoc
class __$$DateFilterChangedImplCopyWithImpl<$Res>
    extends _$BookedInfoEventCopyWithImpl<$Res, _$DateFilterChangedImpl>
    implements _$$DateFilterChangedImplCopyWith<$Res> {
  __$$DateFilterChangedImplCopyWithImpl(
    _$DateFilterChangedImpl _value,
    $Res Function(_$DateFilterChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = freezed}) {
    return _then(
      _$DateFilterChangedImpl(
        freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$DateFilterChangedImpl implements _DateFilterChanged {
  const _$DateFilterChangedImpl(this.date);

  @override
  final DateTime? date;

  @override
  String toString() {
    return 'BookedInfoEvent.dateFilterChanged(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateFilterChangedImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateFilterChangedImplCopyWith<_$DateFilterChangedImpl> get copyWith =>
      __$$DateFilterChangedImplCopyWithImpl<_$DateFilterChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fromDate, String? toDate) fetchList,
    required TResult Function(String query) searchChanged,
    required TResult Function(DateTime? date) dateFilterChanged,
    required TResult Function(String? status) statusFilterChanged,
  }) {
    return dateFilterChanged(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fromDate, String? toDate)? fetchList,
    TResult? Function(String query)? searchChanged,
    TResult? Function(DateTime? date)? dateFilterChanged,
    TResult? Function(String? status)? statusFilterChanged,
  }) {
    return dateFilterChanged?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fromDate, String? toDate)? fetchList,
    TResult Function(String query)? searchChanged,
    TResult Function(DateTime? date)? dateFilterChanged,
    TResult Function(String? status)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (dateFilterChanged != null) {
      return dateFilterChanged(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchList value) fetchList,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_DateFilterChanged value) dateFilterChanged,
    required TResult Function(_StatusFilterChanged value) statusFilterChanged,
  }) {
    return dateFilterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchList value)? fetchList,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_DateFilterChanged value)? dateFilterChanged,
    TResult? Function(_StatusFilterChanged value)? statusFilterChanged,
  }) {
    return dateFilterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchList value)? fetchList,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_DateFilterChanged value)? dateFilterChanged,
    TResult Function(_StatusFilterChanged value)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (dateFilterChanged != null) {
      return dateFilterChanged(this);
    }
    return orElse();
  }
}

abstract class _DateFilterChanged implements BookedInfoEvent {
  const factory _DateFilterChanged(final DateTime? date) =
      _$DateFilterChangedImpl;

  DateTime? get date;

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateFilterChangedImplCopyWith<_$DateFilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusFilterChangedImplCopyWith<$Res> {
  factory _$$StatusFilterChangedImplCopyWith(
    _$StatusFilterChangedImpl value,
    $Res Function(_$StatusFilterChangedImpl) then,
  ) = __$$StatusFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? status});
}

/// @nodoc
class __$$StatusFilterChangedImplCopyWithImpl<$Res>
    extends _$BookedInfoEventCopyWithImpl<$Res, _$StatusFilterChangedImpl>
    implements _$$StatusFilterChangedImplCopyWith<$Res> {
  __$$StatusFilterChangedImplCopyWithImpl(
    _$StatusFilterChangedImpl _value,
    $Res Function(_$StatusFilterChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = freezed}) {
    return _then(
      _$StatusFilterChangedImpl(
        freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StatusFilterChangedImpl implements _StatusFilterChanged {
  const _$StatusFilterChangedImpl(this.status);

  @override
  final String? status;

  @override
  String toString() {
    return 'BookedInfoEvent.statusFilterChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusFilterChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusFilterChangedImplCopyWith<_$StatusFilterChangedImpl> get copyWith =>
      __$$StatusFilterChangedImplCopyWithImpl<_$StatusFilterChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? fromDate, String? toDate) fetchList,
    required TResult Function(String query) searchChanged,
    required TResult Function(DateTime? date) dateFilterChanged,
    required TResult Function(String? status) statusFilterChanged,
  }) {
    return statusFilterChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? fromDate, String? toDate)? fetchList,
    TResult? Function(String query)? searchChanged,
    TResult? Function(DateTime? date)? dateFilterChanged,
    TResult? Function(String? status)? statusFilterChanged,
  }) {
    return statusFilterChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? fromDate, String? toDate)? fetchList,
    TResult Function(String query)? searchChanged,
    TResult Function(DateTime? date)? dateFilterChanged,
    TResult Function(String? status)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (statusFilterChanged != null) {
      return statusFilterChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchList value) fetchList,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_DateFilterChanged value) dateFilterChanged,
    required TResult Function(_StatusFilterChanged value) statusFilterChanged,
  }) {
    return statusFilterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchList value)? fetchList,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_DateFilterChanged value)? dateFilterChanged,
    TResult? Function(_StatusFilterChanged value)? statusFilterChanged,
  }) {
    return statusFilterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchList value)? fetchList,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_DateFilterChanged value)? dateFilterChanged,
    TResult Function(_StatusFilterChanged value)? statusFilterChanged,
    required TResult orElse(),
  }) {
    if (statusFilterChanged != null) {
      return statusFilterChanged(this);
    }
    return orElse();
  }
}

abstract class _StatusFilterChanged implements BookedInfoEvent {
  const factory _StatusFilterChanged(final String? status) =
      _$StatusFilterChangedImpl;

  String? get status;

  /// Create a copy of BookedInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusFilterChangedImplCopyWith<_$StatusFilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookedInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )
    success,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookedInfoStateCopyWith<$Res> {
  factory $BookedInfoStateCopyWith(
    BookedInfoState value,
    $Res Function(BookedInfoState) then,
  ) = _$BookedInfoStateCopyWithImpl<$Res, BookedInfoState>;
}

/// @nodoc
class _$BookedInfoStateCopyWithImpl<$Res, $Val extends BookedInfoState>
    implements $BookedInfoStateCopyWith<$Res> {
  _$BookedInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookedInfoState
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
    extends _$BookedInfoStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'BookedInfoState.initial()';
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
    required TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )
    success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult Function(String message)? error,
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
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements BookedInfoState {
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
    extends _$BookedInfoStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'BookedInfoState.loading()';
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
    required TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )
    success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult Function(String message)? error,
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
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements BookedInfoState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<CabBooking> allBookings,
    List<CabBooking> filteredBookings,
    String searchQuery,
    DateTime? selectedDate,
    String? statusFilter,
  });
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$BookedInfoStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allBookings = null,
    Object? filteredBookings = null,
    Object? searchQuery = null,
    Object? selectedDate = freezed,
    Object? statusFilter = freezed,
  }) {
    return _then(
      _$SuccessImpl(
        allBookings: null == allBookings
            ? _value._allBookings
            : allBookings // ignore: cast_nullable_to_non_nullable
                  as List<CabBooking>,
        filteredBookings: null == filteredBookings
            ? _value._filteredBookings
            : filteredBookings // ignore: cast_nullable_to_non_nullable
                  as List<CabBooking>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedDate: freezed == selectedDate
            ? _value.selectedDate
            : selectedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        statusFilter: freezed == statusFilter
            ? _value.statusFilter
            : statusFilter // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({
    required final List<CabBooking> allBookings,
    required final List<CabBooking> filteredBookings,
    required this.searchQuery,
    required this.selectedDate,
    required this.statusFilter,
  }) : _allBookings = allBookings,
       _filteredBookings = filteredBookings;

  final List<CabBooking> _allBookings;
  @override
  List<CabBooking> get allBookings {
    if (_allBookings is EqualUnmodifiableListView) return _allBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allBookings);
  }

  final List<CabBooking> _filteredBookings;
  @override
  List<CabBooking> get filteredBookings {
    if (_filteredBookings is EqualUnmodifiableListView)
      return _filteredBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredBookings);
  }

  @override
  final String searchQuery;
  @override
  final DateTime? selectedDate;
  @override
  final String? statusFilter;

  @override
  String toString() {
    return 'BookedInfoState.success(allBookings: $allBookings, filteredBookings: $filteredBookings, searchQuery: $searchQuery, selectedDate: $selectedDate, statusFilter: $statusFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(
              other._allBookings,
              _allBookings,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredBookings,
              _filteredBookings,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.statusFilter, statusFilter) ||
                other.statusFilter == statusFilter));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_allBookings),
    const DeepCollectionEquality().hash(_filteredBookings),
    searchQuery,
    selectedDate,
    statusFilter,
  );

  /// Create a copy of BookedInfoState
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
    required TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )
    success,
    required TResult Function(String message) error,
  }) {
    return success(
      allBookings,
      filteredBookings,
      searchQuery,
      selectedDate,
      statusFilter,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(
      allBookings,
      filteredBookings,
      searchQuery,
      selectedDate,
      statusFilter,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(
        allBookings,
        filteredBookings,
        searchQuery,
        selectedDate,
        statusFilter,
      );
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
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements BookedInfoState {
  const factory _Success({
    required final List<CabBooking> allBookings,
    required final List<CabBooking> filteredBookings,
    required final String searchQuery,
    required final DateTime? selectedDate,
    required final String? statusFilter,
  }) = _$SuccessImpl;

  List<CabBooking> get allBookings;
  List<CabBooking> get filteredBookings;
  String get searchQuery;
  DateTime? get selectedDate;
  String? get statusFilter;

  /// Create a copy of BookedInfoState
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
    extends _$BookedInfoStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedInfoState
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
    return 'BookedInfoState.error(message: $message)';
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

  /// Create a copy of BookedInfoState
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
    required TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )
    success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<CabBooking> allBookings,
      List<CabBooking> filteredBookings,
      String searchQuery,
      DateTime? selectedDate,
      String? statusFilter,
    )?
    success,
    TResult Function(String message)? error,
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
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements BookedInfoState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of BookedInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
