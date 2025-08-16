// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_list_fetch_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BusListFetchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )
    filterConform,
    required TResult Function(DateTime dateOfjurny, City destID, City sourceID)
    fetchTrip,
    required TResult Function(AvailableTrip trip, City destID, City sourceID)
    selectTrip,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult? Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult? Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterConform value) filterConform,
    required TResult Function(FetchTrip value) fetchTrip,
    required TResult Function(SelectTrip value) selectTrip,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FilterConform value)? filterConform,
    TResult? Function(FetchTrip value)? fetchTrip,
    TResult? Function(SelectTrip value)? selectTrip,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterConform value)? filterConform,
    TResult Function(FetchTrip value)? fetchTrip,
    TResult Function(SelectTrip value)? selectTrip,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusListFetchEventCopyWith<$Res> {
  factory $BusListFetchEventCopyWith(
    BusListFetchEvent value,
    $Res Function(BusListFetchEvent) then,
  ) = _$BusListFetchEventCopyWithImpl<$Res, BusListFetchEvent>;
}

/// @nodoc
class _$BusListFetchEventCopyWithImpl<$Res, $Val extends BusListFetchEvent>
    implements $BusListFetchEventCopyWith<$Res> {
  _$BusListFetchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FilterConformImplCopyWith<$Res> {
  factory _$$FilterConformImplCopyWith(
    _$FilterConformImpl value,
    $Res Function(_$FilterConformImpl) then,
  ) = __$$FilterConformImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    bool sleeper,
    bool seater,
    bool ac,
    bool nonAC,
    bool departureCase1,
    bool departureCase2,
    bool departureCase3,
    bool departureCase4,
    bool arrivalCase1,
    bool arrivalCase2,
    bool arrivalCase3,
    bool arrivalCase4,
    List<AvailableTrip> availableTrips,
  });
}

/// @nodoc
class __$$FilterConformImplCopyWithImpl<$Res>
    extends _$BusListFetchEventCopyWithImpl<$Res, _$FilterConformImpl>
    implements _$$FilterConformImplCopyWith<$Res> {
  __$$FilterConformImplCopyWithImpl(
    _$FilterConformImpl _value,
    $Res Function(_$FilterConformImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sleeper = null,
    Object? seater = null,
    Object? ac = null,
    Object? nonAC = null,
    Object? departureCase1 = null,
    Object? departureCase2 = null,
    Object? departureCase3 = null,
    Object? departureCase4 = null,
    Object? arrivalCase1 = null,
    Object? arrivalCase2 = null,
    Object? arrivalCase3 = null,
    Object? arrivalCase4 = null,
    Object? availableTrips = null,
  }) {
    return _then(
      _$FilterConformImpl(
        sleeper: null == sleeper
            ? _value.sleeper
            : sleeper // ignore: cast_nullable_to_non_nullable
                  as bool,
        seater: null == seater
            ? _value.seater
            : seater // ignore: cast_nullable_to_non_nullable
                  as bool,
        ac: null == ac
            ? _value.ac
            : ac // ignore: cast_nullable_to_non_nullable
                  as bool,
        nonAC: null == nonAC
            ? _value.nonAC
            : nonAC // ignore: cast_nullable_to_non_nullable
                  as bool,
        departureCase1: null == departureCase1
            ? _value.departureCase1
            : departureCase1 // ignore: cast_nullable_to_non_nullable
                  as bool,
        departureCase2: null == departureCase2
            ? _value.departureCase2
            : departureCase2 // ignore: cast_nullable_to_non_nullable
                  as bool,
        departureCase3: null == departureCase3
            ? _value.departureCase3
            : departureCase3 // ignore: cast_nullable_to_non_nullable
                  as bool,
        departureCase4: null == departureCase4
            ? _value.departureCase4
            : departureCase4 // ignore: cast_nullable_to_non_nullable
                  as bool,
        arrivalCase1: null == arrivalCase1
            ? _value.arrivalCase1
            : arrivalCase1 // ignore: cast_nullable_to_non_nullable
                  as bool,
        arrivalCase2: null == arrivalCase2
            ? _value.arrivalCase2
            : arrivalCase2 // ignore: cast_nullable_to_non_nullable
                  as bool,
        arrivalCase3: null == arrivalCase3
            ? _value.arrivalCase3
            : arrivalCase3 // ignore: cast_nullable_to_non_nullable
                  as bool,
        arrivalCase4: null == arrivalCase4
            ? _value.arrivalCase4
            : arrivalCase4 // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableTrips: null == availableTrips
            ? _value._availableTrips
            : availableTrips // ignore: cast_nullable_to_non_nullable
                  as List<AvailableTrip>,
      ),
    );
  }
}

/// @nodoc

class _$FilterConformImpl implements FilterConform {
  const _$FilterConformImpl({
    required this.sleeper,
    required this.seater,
    required this.ac,
    required this.nonAC,
    required this.departureCase1,
    required this.departureCase2,
    required this.departureCase3,
    required this.departureCase4,
    required this.arrivalCase1,
    required this.arrivalCase2,
    required this.arrivalCase3,
    required this.arrivalCase4,
    required final List<AvailableTrip> availableTrips,
  }) : _availableTrips = availableTrips;

  @override
  final bool sleeper;
  @override
  final bool seater;
  @override
  final bool ac;
  @override
  final bool nonAC;
  @override
  final bool departureCase1;
  @override
  final bool departureCase2;
  @override
  final bool departureCase3;
  @override
  final bool departureCase4;
  @override
  final bool arrivalCase1;
  @override
  final bool arrivalCase2;
  @override
  final bool arrivalCase3;
  @override
  final bool arrivalCase4;
  final List<AvailableTrip> _availableTrips;
  @override
  List<AvailableTrip> get availableTrips {
    if (_availableTrips is EqualUnmodifiableListView) return _availableTrips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTrips);
  }

  @override
  String toString() {
    return 'BusListFetchEvent.filterConform(sleeper: $sleeper, seater: $seater, ac: $ac, nonAC: $nonAC, departureCase1: $departureCase1, departureCase2: $departureCase2, departureCase3: $departureCase3, departureCase4: $departureCase4, arrivalCase1: $arrivalCase1, arrivalCase2: $arrivalCase2, arrivalCase3: $arrivalCase3, arrivalCase4: $arrivalCase4, availableTrips: $availableTrips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterConformImpl &&
            (identical(other.sleeper, sleeper) || other.sleeper == sleeper) &&
            (identical(other.seater, seater) || other.seater == seater) &&
            (identical(other.ac, ac) || other.ac == ac) &&
            (identical(other.nonAC, nonAC) || other.nonAC == nonAC) &&
            (identical(other.departureCase1, departureCase1) ||
                other.departureCase1 == departureCase1) &&
            (identical(other.departureCase2, departureCase2) ||
                other.departureCase2 == departureCase2) &&
            (identical(other.departureCase3, departureCase3) ||
                other.departureCase3 == departureCase3) &&
            (identical(other.departureCase4, departureCase4) ||
                other.departureCase4 == departureCase4) &&
            (identical(other.arrivalCase1, arrivalCase1) ||
                other.arrivalCase1 == arrivalCase1) &&
            (identical(other.arrivalCase2, arrivalCase2) ||
                other.arrivalCase2 == arrivalCase2) &&
            (identical(other.arrivalCase3, arrivalCase3) ||
                other.arrivalCase3 == arrivalCase3) &&
            (identical(other.arrivalCase4, arrivalCase4) ||
                other.arrivalCase4 == arrivalCase4) &&
            const DeepCollectionEquality().equals(
              other._availableTrips,
              _availableTrips,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sleeper,
    seater,
    ac,
    nonAC,
    departureCase1,
    departureCase2,
    departureCase3,
    departureCase4,
    arrivalCase1,
    arrivalCase2,
    arrivalCase3,
    arrivalCase4,
    const DeepCollectionEquality().hash(_availableTrips),
  );

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterConformImplCopyWith<_$FilterConformImpl> get copyWith =>
      __$$FilterConformImplCopyWithImpl<_$FilterConformImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )
    filterConform,
    required TResult Function(DateTime dateOfjurny, City destID, City sourceID)
    fetchTrip,
    required TResult Function(AvailableTrip trip, City destID, City sourceID)
    selectTrip,
  }) {
    return filterConform(
      sleeper,
      seater,
      ac,
      nonAC,
      departureCase1,
      departureCase2,
      departureCase3,
      departureCase4,
      arrivalCase1,
      arrivalCase2,
      arrivalCase3,
      arrivalCase4,
      availableTrips,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult? Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult? Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
  }) {
    return filterConform?.call(
      sleeper,
      seater,
      ac,
      nonAC,
      departureCase1,
      departureCase2,
      departureCase3,
      departureCase4,
      arrivalCase1,
      arrivalCase2,
      arrivalCase3,
      arrivalCase4,
      availableTrips,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
    required TResult orElse(),
  }) {
    if (filterConform != null) {
      return filterConform(
        sleeper,
        seater,
        ac,
        nonAC,
        departureCase1,
        departureCase2,
        departureCase3,
        departureCase4,
        arrivalCase1,
        arrivalCase2,
        arrivalCase3,
        arrivalCase4,
        availableTrips,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterConform value) filterConform,
    required TResult Function(FetchTrip value) fetchTrip,
    required TResult Function(SelectTrip value) selectTrip,
  }) {
    return filterConform(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FilterConform value)? filterConform,
    TResult? Function(FetchTrip value)? fetchTrip,
    TResult? Function(SelectTrip value)? selectTrip,
  }) {
    return filterConform?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterConform value)? filterConform,
    TResult Function(FetchTrip value)? fetchTrip,
    TResult Function(SelectTrip value)? selectTrip,
    required TResult orElse(),
  }) {
    if (filterConform != null) {
      return filterConform(this);
    }
    return orElse();
  }
}

abstract class FilterConform implements BusListFetchEvent {
  const factory FilterConform({
    required final bool sleeper,
    required final bool seater,
    required final bool ac,
    required final bool nonAC,
    required final bool departureCase1,
    required final bool departureCase2,
    required final bool departureCase3,
    required final bool departureCase4,
    required final bool arrivalCase1,
    required final bool arrivalCase2,
    required final bool arrivalCase3,
    required final bool arrivalCase4,
    required final List<AvailableTrip> availableTrips,
  }) = _$FilterConformImpl;

  bool get sleeper;
  bool get seater;
  bool get ac;
  bool get nonAC;
  bool get departureCase1;
  bool get departureCase2;
  bool get departureCase3;
  bool get departureCase4;
  bool get arrivalCase1;
  bool get arrivalCase2;
  bool get arrivalCase3;
  bool get arrivalCase4;
  List<AvailableTrip> get availableTrips;

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterConformImplCopyWith<_$FilterConformImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchTripImplCopyWith<$Res> {
  factory _$$FetchTripImplCopyWith(
    _$FetchTripImpl value,
    $Res Function(_$FetchTripImpl) then,
  ) = __$$FetchTripImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateOfjurny, City destID, City sourceID});
}

/// @nodoc
class __$$FetchTripImplCopyWithImpl<$Res>
    extends _$BusListFetchEventCopyWithImpl<$Res, _$FetchTripImpl>
    implements _$$FetchTripImplCopyWith<$Res> {
  __$$FetchTripImplCopyWithImpl(
    _$FetchTripImpl _value,
    $Res Function(_$FetchTripImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfjurny = null,
    Object? destID = null,
    Object? sourceID = null,
  }) {
    return _then(
      _$FetchTripImpl(
        dateOfjurny: null == dateOfjurny
            ? _value.dateOfjurny
            : dateOfjurny // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        destID: null == destID
            ? _value.destID
            : destID // ignore: cast_nullable_to_non_nullable
                  as City,
        sourceID: null == sourceID
            ? _value.sourceID
            : sourceID // ignore: cast_nullable_to_non_nullable
                  as City,
      ),
    );
  }
}

/// @nodoc

class _$FetchTripImpl implements FetchTrip {
  const _$FetchTripImpl({
    required this.dateOfjurny,
    required this.destID,
    required this.sourceID,
  });

  @override
  final DateTime dateOfjurny;
  @override
  final City destID;
  @override
  final City sourceID;

  @override
  String toString() {
    return 'BusListFetchEvent.fetchTrip(dateOfjurny: $dateOfjurny, destID: $destID, sourceID: $sourceID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchTripImpl &&
            (identical(other.dateOfjurny, dateOfjurny) ||
                other.dateOfjurny == dateOfjurny) &&
            (identical(other.destID, destID) || other.destID == destID) &&
            (identical(other.sourceID, sourceID) ||
                other.sourceID == sourceID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateOfjurny, destID, sourceID);

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchTripImplCopyWith<_$FetchTripImpl> get copyWith =>
      __$$FetchTripImplCopyWithImpl<_$FetchTripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )
    filterConform,
    required TResult Function(DateTime dateOfjurny, City destID, City sourceID)
    fetchTrip,
    required TResult Function(AvailableTrip trip, City destID, City sourceID)
    selectTrip,
  }) {
    return fetchTrip(dateOfjurny, destID, sourceID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult? Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult? Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
  }) {
    return fetchTrip?.call(dateOfjurny, destID, sourceID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
    required TResult orElse(),
  }) {
    if (fetchTrip != null) {
      return fetchTrip(dateOfjurny, destID, sourceID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterConform value) filterConform,
    required TResult Function(FetchTrip value) fetchTrip,
    required TResult Function(SelectTrip value) selectTrip,
  }) {
    return fetchTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FilterConform value)? filterConform,
    TResult? Function(FetchTrip value)? fetchTrip,
    TResult? Function(SelectTrip value)? selectTrip,
  }) {
    return fetchTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterConform value)? filterConform,
    TResult Function(FetchTrip value)? fetchTrip,
    TResult Function(SelectTrip value)? selectTrip,
    required TResult orElse(),
  }) {
    if (fetchTrip != null) {
      return fetchTrip(this);
    }
    return orElse();
  }
}

abstract class FetchTrip implements BusListFetchEvent {
  const factory FetchTrip({
    required final DateTime dateOfjurny,
    required final City destID,
    required final City sourceID,
  }) = _$FetchTripImpl;

  DateTime get dateOfjurny;
  City get destID;
  City get sourceID;

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchTripImplCopyWith<_$FetchTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectTripImplCopyWith<$Res> {
  factory _$$SelectTripImplCopyWith(
    _$SelectTripImpl value,
    $Res Function(_$SelectTripImpl) then,
  ) = __$$SelectTripImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AvailableTrip trip, City destID, City sourceID});
}

/// @nodoc
class __$$SelectTripImplCopyWithImpl<$Res>
    extends _$BusListFetchEventCopyWithImpl<$Res, _$SelectTripImpl>
    implements _$$SelectTripImplCopyWith<$Res> {
  __$$SelectTripImplCopyWithImpl(
    _$SelectTripImpl _value,
    $Res Function(_$SelectTripImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trip = null,
    Object? destID = null,
    Object? sourceID = null,
  }) {
    return _then(
      _$SelectTripImpl(
        trip: null == trip
            ? _value.trip
            : trip // ignore: cast_nullable_to_non_nullable
                  as AvailableTrip,
        destID: null == destID
            ? _value.destID
            : destID // ignore: cast_nullable_to_non_nullable
                  as City,
        sourceID: null == sourceID
            ? _value.sourceID
            : sourceID // ignore: cast_nullable_to_non_nullable
                  as City,
      ),
    );
  }
}

/// @nodoc

class _$SelectTripImpl implements SelectTrip {
  const _$SelectTripImpl({
    required this.trip,
    required this.destID,
    required this.sourceID,
  });

  @override
  final AvailableTrip trip;
  @override
  final City destID;
  @override
  final City sourceID;

  @override
  String toString() {
    return 'BusListFetchEvent.selectTrip(trip: $trip, destID: $destID, sourceID: $sourceID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectTripImpl &&
            (identical(other.trip, trip) || other.trip == trip) &&
            (identical(other.destID, destID) || other.destID == destID) &&
            (identical(other.sourceID, sourceID) ||
                other.sourceID == sourceID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trip, destID, sourceID);

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectTripImplCopyWith<_$SelectTripImpl> get copyWith =>
      __$$SelectTripImplCopyWithImpl<_$SelectTripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )
    filterConform,
    required TResult Function(DateTime dateOfjurny, City destID, City sourceID)
    fetchTrip,
    required TResult Function(AvailableTrip trip, City destID, City sourceID)
    selectTrip,
  }) {
    return selectTrip(trip, destID, sourceID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult? Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult? Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
  }) {
    return selectTrip?.call(trip, destID, sourceID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool sleeper,
      bool seater,
      bool ac,
      bool nonAC,
      bool departureCase1,
      bool departureCase2,
      bool departureCase3,
      bool departureCase4,
      bool arrivalCase1,
      bool arrivalCase2,
      bool arrivalCase3,
      bool arrivalCase4,
      List<AvailableTrip> availableTrips,
    )?
    filterConform,
    TResult Function(DateTime dateOfjurny, City destID, City sourceID)?
    fetchTrip,
    TResult Function(AvailableTrip trip, City destID, City sourceID)?
    selectTrip,
    required TResult orElse(),
  }) {
    if (selectTrip != null) {
      return selectTrip(trip, destID, sourceID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FilterConform value) filterConform,
    required TResult Function(FetchTrip value) fetchTrip,
    required TResult Function(SelectTrip value) selectTrip,
  }) {
    return selectTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FilterConform value)? filterConform,
    TResult? Function(FetchTrip value)? fetchTrip,
    TResult? Function(SelectTrip value)? selectTrip,
  }) {
    return selectTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FilterConform value)? filterConform,
    TResult Function(FetchTrip value)? fetchTrip,
    TResult Function(SelectTrip value)? selectTrip,
    required TResult orElse(),
  }) {
    if (selectTrip != null) {
      return selectTrip(this);
    }
    return orElse();
  }
}

abstract class SelectTrip implements BusListFetchEvent {
  const factory SelectTrip({
    required final AvailableTrip trip,
    required final City destID,
    required final City sourceID,
  }) = _$SelectTripImpl;

  AvailableTrip get trip;
  City get destID;
  City get sourceID;

  /// Create a copy of BusListFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectTripImplCopyWith<_$SelectTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
