// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_data_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchDataEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchDataEventCopyWith<$Res> {
  factory $SearchDataEventCopyWith(
    SearchDataEvent value,
    $Res Function(SearchDataEvent) then,
  ) = _$SearchDataEventCopyWithImpl<$Res, SearchDataEvent>;
}

/// @nodoc
class _$SearchDataEventCopyWithImpl<$Res, $Val extends SearchDataEvent>
    implements $SearchDataEventCopyWith<$Res> {
  _$SearchDataEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OneWayOrRoundImplCopyWith<$Res> {
  factory _$$OneWayOrRoundImplCopyWith(
    _$OneWayOrRoundImpl value,
    $Res Function(_$OneWayOrRoundImpl) then,
  ) = __$$OneWayOrRoundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String oneWayOrRound});
}

/// @nodoc
class __$$OneWayOrRoundImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$OneWayOrRoundImpl>
    implements _$$OneWayOrRoundImplCopyWith<$Res> {
  __$$OneWayOrRoundImplCopyWithImpl(
    _$OneWayOrRoundImpl _value,
    $Res Function(_$OneWayOrRoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? oneWayOrRound = null}) {
    return _then(
      _$OneWayOrRoundImpl(
        oneWayOrRound: null == oneWayOrRound
            ? _value.oneWayOrRound
            : oneWayOrRound // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OneWayOrRoundImpl implements OneWayOrRound {
  const _$OneWayOrRoundImpl({required this.oneWayOrRound});

  @override
  final String oneWayOrRound;

  @override
  String toString() {
    return 'SearchDataEvent.oneWayOrRound(oneWayOrRound: $oneWayOrRound)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OneWayOrRoundImpl &&
            (identical(other.oneWayOrRound, oneWayOrRound) ||
                other.oneWayOrRound == oneWayOrRound));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oneWayOrRound);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OneWayOrRoundImplCopyWith<_$OneWayOrRoundImpl> get copyWith =>
      __$$OneWayOrRoundImplCopyWithImpl<_$OneWayOrRoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return oneWayOrRound(this.oneWayOrRound);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return oneWayOrRound?.call(this.oneWayOrRound);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (oneWayOrRound != null) {
      return oneWayOrRound(this.oneWayOrRound);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return oneWayOrRound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return oneWayOrRound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (oneWayOrRound != null) {
      return oneWayOrRound(this);
    }
    return orElse();
  }
}

abstract class OneWayOrRound implements SearchDataEvent {
  const factory OneWayOrRound({required final String oneWayOrRound}) =
      _$OneWayOrRoundImpl;

  String get oneWayOrRound;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OneWayOrRoundImplCopyWith<_$OneWayOrRoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClassChangeImplCopyWith<$Res> {
  factory _$$ClassChangeImplCopyWith(
    _$ClassChangeImpl value,
    $Res Function(_$ClassChangeImpl) then,
  ) = __$$ClassChangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String seatClass});
}

/// @nodoc
class __$$ClassChangeImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$ClassChangeImpl>
    implements _$$ClassChangeImplCopyWith<$Res> {
  __$$ClassChangeImplCopyWithImpl(
    _$ClassChangeImpl _value,
    $Res Function(_$ClassChangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? seatClass = null}) {
    return _then(
      _$ClassChangeImpl(
        seatClass: null == seatClass
            ? _value.seatClass
            : seatClass // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClassChangeImpl implements ClassChange {
  const _$ClassChangeImpl({required this.seatClass});

  @override
  final String seatClass;

  @override
  String toString() {
    return 'SearchDataEvent.classChange(seatClass: $seatClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassChangeImpl &&
            (identical(other.seatClass, seatClass) ||
                other.seatClass == seatClass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seatClass);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassChangeImplCopyWith<_$ClassChangeImpl> get copyWith =>
      __$$ClassChangeImplCopyWithImpl<_$ClassChangeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return classChange(seatClass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return classChange?.call(seatClass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (classChange != null) {
      return classChange(seatClass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return classChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return classChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (classChange != null) {
      return classChange(this);
    }
    return orElse();
  }
}

abstract class ClassChange implements SearchDataEvent {
  const factory ClassChange({required final String seatClass}) =
      _$ClassChangeImpl;

  String get seatClass;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassChangeImplCopyWith<_$ClassChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FromOrToImplCopyWith<$Res> {
  factory _$$FromOrToImplCopyWith(
    _$FromOrToImpl value,
    $Res Function(_$FromOrToImpl) then,
  ) = __$$FromOrToImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String fromOrTo, Airport airport});
}

/// @nodoc
class __$$FromOrToImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$FromOrToImpl>
    implements _$$FromOrToImplCopyWith<$Res> {
  __$$FromOrToImplCopyWithImpl(
    _$FromOrToImpl _value,
    $Res Function(_$FromOrToImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fromOrTo = null, Object? airport = null}) {
    return _then(
      _$FromOrToImpl(
        fromOrTo: null == fromOrTo
            ? _value.fromOrTo
            : fromOrTo // ignore: cast_nullable_to_non_nullable
                  as String,
        airport: null == airport
            ? _value.airport
            : airport // ignore: cast_nullable_to_non_nullable
                  as Airport,
      ),
    );
  }
}

/// @nodoc

class _$FromOrToImpl implements FromOrTo {
  const _$FromOrToImpl({required this.fromOrTo, required this.airport});

  @override
  final String fromOrTo;
  @override
  final Airport airport;

  @override
  String toString() {
    return 'SearchDataEvent.fromOrTo(fromOrTo: $fromOrTo, airport: $airport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FromOrToImpl &&
            (identical(other.fromOrTo, fromOrTo) ||
                other.fromOrTo == fromOrTo) &&
            (identical(other.airport, airport) || other.airport == airport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromOrTo, airport);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FromOrToImplCopyWith<_$FromOrToImpl> get copyWith =>
      __$$FromOrToImplCopyWithImpl<_$FromOrToImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return fromOrTo(this.fromOrTo, airport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return fromOrTo?.call(this.fromOrTo, airport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (fromOrTo != null) {
      return fromOrTo(this.fromOrTo, airport);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return fromOrTo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return fromOrTo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (fromOrTo != null) {
      return fromOrTo(this);
    }
    return orElse();
  }
}

abstract class FromOrTo implements SearchDataEvent {
  const factory FromOrTo({
    required final String fromOrTo,
    required final Airport airport,
  }) = _$FromOrToImpl;

  String get fromOrTo;
  Airport get airport;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FromOrToImplCopyWith<_$FromOrToImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PassengersImplCopyWith<$Res> {
  factory _$$PassengersImplCopyWith(
    _$PassengersImpl value,
    $Res Function(_$PassengersImpl) then,
  ) = __$$PassengersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, int> travellers});
}

/// @nodoc
class __$$PassengersImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$PassengersImpl>
    implements _$$PassengersImplCopyWith<$Res> {
  __$$PassengersImplCopyWithImpl(
    _$PassengersImpl _value,
    $Res Function(_$PassengersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? travellers = null}) {
    return _then(
      _$PassengersImpl(
        travellers: null == travellers
            ? _value._travellers
            : travellers // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc

class _$PassengersImpl implements Passengers {
  const _$PassengersImpl({required final Map<String, int> travellers})
    : _travellers = travellers;

  // Fixed spelling (was Passangers)
  final Map<String, int> _travellers;
  // Fixed spelling (was Passangers)
  @override
  Map<String, int> get travellers {
    if (_travellers is EqualUnmodifiableMapView) return _travellers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_travellers);
  }

  @override
  String toString() {
    return 'SearchDataEvent.passengers(travellers: $travellers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassengersImpl &&
            const DeepCollectionEquality().equals(
              other._travellers,
              _travellers,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_travellers),
  );

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PassengersImplCopyWith<_$PassengersImpl> get copyWith =>
      __$$PassengersImplCopyWithImpl<_$PassengersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return passengers(travellers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return passengers?.call(travellers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (passengers != null) {
      return passengers(travellers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return passengers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return passengers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (passengers != null) {
      return passengers(this);
    }
    return orElse();
  }
}

abstract class Passengers implements SearchDataEvent {
  const factory Passengers({required final Map<String, int> travellers}) =
      _$PassengersImpl;

  // Fixed spelling (was Passangers)
  Map<String, int> get travellers;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PassengersImplCopyWith<_$PassengersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetAirportsImplCopyWith<$Res> {
  factory _$$GetAirportsImplCopyWith(
    _$GetAirportsImpl value,
    $Res Function(_$GetAirportsImpl) then,
  ) = __$$GetAirportsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String searchKey});
}

/// @nodoc
class __$$GetAirportsImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$GetAirportsImpl>
    implements _$$GetAirportsImplCopyWith<$Res> {
  __$$GetAirportsImplCopyWithImpl(
    _$GetAirportsImpl _value,
    $Res Function(_$GetAirportsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? searchKey = null}) {
    return _then(
      _$GetAirportsImpl(
        searchKey: null == searchKey
            ? _value.searchKey
            : searchKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetAirportsImpl implements GetAirports {
  const _$GetAirportsImpl({required this.searchKey});

  @override
  final String searchKey;

  @override
  String toString() {
    return 'SearchDataEvent.getAirports(searchKey: $searchKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAirportsImpl &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchKey);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAirportsImplCopyWith<_$GetAirportsImpl> get copyWith =>
      __$$GetAirportsImplCopyWithImpl<_$GetAirportsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return getAirports(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return getAirports?.call(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (getAirports != null) {
      return getAirports(searchKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return getAirports(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return getAirports?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (getAirports != null) {
      return getAirports(this);
    }
    return orElse();
  }
}

abstract class GetAirports implements SearchDataEvent {
  const factory GetAirports({required final String searchKey}) =
      _$GetAirportsImpl;

  String get searchKey;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAirportsImplCopyWith<_$GetAirportsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DepartureDateChangeImplCopyWith<$Res> {
  factory _$$DepartureDateChangeImplCopyWith(
    _$DepartureDateChangeImpl value,
    $Res Function(_$DepartureDateChangeImpl) then,
  ) = __$$DepartureDateChangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime departureDate});
}

/// @nodoc
class __$$DepartureDateChangeImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$DepartureDateChangeImpl>
    implements _$$DepartureDateChangeImplCopyWith<$Res> {
  __$$DepartureDateChangeImplCopyWithImpl(
    _$DepartureDateChangeImpl _value,
    $Res Function(_$DepartureDateChangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? departureDate = null}) {
    return _then(
      _$DepartureDateChangeImpl(
        departureDate: null == departureDate
            ? _value.departureDate
            : departureDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$DepartureDateChangeImpl implements DepartureDateChange {
  const _$DepartureDateChangeImpl({required this.departureDate});

  @override
  final DateTime departureDate;

  @override
  String toString() {
    return 'SearchDataEvent.departureDateChange(departureDate: $departureDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DepartureDateChangeImpl &&
            (identical(other.departureDate, departureDate) ||
                other.departureDate == departureDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, departureDate);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DepartureDateChangeImplCopyWith<_$DepartureDateChangeImpl> get copyWith =>
      __$$DepartureDateChangeImplCopyWithImpl<_$DepartureDateChangeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return departureDateChange(departureDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return departureDateChange?.call(departureDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (departureDateChange != null) {
      return departureDateChange(departureDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return departureDateChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return departureDateChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (departureDateChange != null) {
      return departureDateChange(this);
    }
    return orElse();
  }
}

abstract class DepartureDateChange implements SearchDataEvent {
  const factory DepartureDateChange({required final DateTime departureDate}) =
      _$DepartureDateChangeImpl;

  DateTime get departureDate;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DepartureDateChangeImplCopyWith<_$DepartureDateChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReturnDateChangeImplCopyWith<$Res> {
  factory _$$ReturnDateChangeImplCopyWith(
    _$ReturnDateChangeImpl value,
    $Res Function(_$ReturnDateChangeImpl) then,
  ) = __$$ReturnDateChangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime returnDate});
}

/// @nodoc
class __$$ReturnDateChangeImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$ReturnDateChangeImpl>
    implements _$$ReturnDateChangeImplCopyWith<$Res> {
  __$$ReturnDateChangeImplCopyWithImpl(
    _$ReturnDateChangeImpl _value,
    $Res Function(_$ReturnDateChangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? returnDate = null}) {
    return _then(
      _$ReturnDateChangeImpl(
        returnDate: null == returnDate
            ? _value.returnDate
            : returnDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ReturnDateChangeImpl implements ReturnDateChange {
  const _$ReturnDateChangeImpl({required this.returnDate});

  @override
  final DateTime returnDate;

  @override
  String toString() {
    return 'SearchDataEvent.returnDateChange(returnDate: $returnDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReturnDateChangeImpl &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, returnDate);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReturnDateChangeImplCopyWith<_$ReturnDateChangeImpl> get copyWith =>
      __$$ReturnDateChangeImplCopyWithImpl<_$ReturnDateChangeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return returnDateChange(returnDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return returnDateChange?.call(returnDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (returnDateChange != null) {
      return returnDateChange(returnDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return returnDateChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return returnDateChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (returnDateChange != null) {
      return returnDateChange(this);
    }
    return orElse();
  }
}

abstract class ReturnDateChange implements SearchDataEvent {
  const factory ReturnDateChange({required final DateTime returnDate}) =
      _$ReturnDateChangeImpl;

  DateTime get returnDate;

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReturnDateChangeImplCopyWith<_$ReturnDateChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSearchAirportsImplCopyWith<$Res> {
  factory _$$ClearSearchAirportsImplCopyWith(
    _$ClearSearchAirportsImpl value,
    $Res Function(_$ClearSearchAirportsImpl) then,
  ) = __$$ClearSearchAirportsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchAirportsImplCopyWithImpl<$Res>
    extends _$SearchDataEventCopyWithImpl<$Res, _$ClearSearchAirportsImpl>
    implements _$$ClearSearchAirportsImplCopyWith<$Res> {
  __$$ClearSearchAirportsImplCopyWithImpl(
    _$ClearSearchAirportsImpl _value,
    $Res Function(_$ClearSearchAirportsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchAirportsImpl implements ClearSearchAirports {
  const _$ClearSearchAirportsImpl();

  @override
  String toString() {
    return 'SearchDataEvent.clearSearchAirports()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearSearchAirportsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String oneWayOrRound) oneWayOrRound,
    required TResult Function(String seatClass) classChange,
    required TResult Function(String fromOrTo, Airport airport) fromOrTo,
    required TResult Function(Map<String, int> travellers) passengers,
    required TResult Function(String searchKey) getAirports,
    required TResult Function(DateTime departureDate) departureDateChange,
    required TResult Function(DateTime returnDate) returnDateChange,
    required TResult Function() clearSearchAirports,
  }) {
    return clearSearchAirports();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String oneWayOrRound)? oneWayOrRound,
    TResult? Function(String seatClass)? classChange,
    TResult? Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult? Function(Map<String, int> travellers)? passengers,
    TResult? Function(String searchKey)? getAirports,
    TResult? Function(DateTime departureDate)? departureDateChange,
    TResult? Function(DateTime returnDate)? returnDateChange,
    TResult? Function()? clearSearchAirports,
  }) {
    return clearSearchAirports?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String oneWayOrRound)? oneWayOrRound,
    TResult Function(String seatClass)? classChange,
    TResult Function(String fromOrTo, Airport airport)? fromOrTo,
    TResult Function(Map<String, int> travellers)? passengers,
    TResult Function(String searchKey)? getAirports,
    TResult Function(DateTime departureDate)? departureDateChange,
    TResult Function(DateTime returnDate)? returnDateChange,
    TResult Function()? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (clearSearchAirports != null) {
      return clearSearchAirports();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OneWayOrRound value) oneWayOrRound,
    required TResult Function(ClassChange value) classChange,
    required TResult Function(FromOrTo value) fromOrTo,
    required TResult Function(Passengers value) passengers,
    required TResult Function(GetAirports value) getAirports,
    required TResult Function(DepartureDateChange value) departureDateChange,
    required TResult Function(ReturnDateChange value) returnDateChange,
    required TResult Function(ClearSearchAirports value) clearSearchAirports,
  }) {
    return clearSearchAirports(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OneWayOrRound value)? oneWayOrRound,
    TResult? Function(ClassChange value)? classChange,
    TResult? Function(FromOrTo value)? fromOrTo,
    TResult? Function(Passengers value)? passengers,
    TResult? Function(GetAirports value)? getAirports,
    TResult? Function(DepartureDateChange value)? departureDateChange,
    TResult? Function(ReturnDateChange value)? returnDateChange,
    TResult? Function(ClearSearchAirports value)? clearSearchAirports,
  }) {
    return clearSearchAirports?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OneWayOrRound value)? oneWayOrRound,
    TResult Function(ClassChange value)? classChange,
    TResult Function(FromOrTo value)? fromOrTo,
    TResult Function(Passengers value)? passengers,
    TResult Function(GetAirports value)? getAirports,
    TResult Function(DepartureDateChange value)? departureDateChange,
    TResult Function(ReturnDateChange value)? returnDateChange,
    TResult Function(ClearSearchAirports value)? clearSearchAirports,
    required TResult orElse(),
  }) {
    if (clearSearchAirports != null) {
      return clearSearchAirports(this);
    }
    return orElse();
  }
}

abstract class ClearSearchAirports implements SearchDataEvent {
  const factory ClearSearchAirports() = _$ClearSearchAirportsImpl;
}

/// @nodoc
mixin _$SearchDataState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get oneWay => throw _privateConstructorUsedError;
  String get seatClass => throw _privateConstructorUsedError;
  DateTime get departureDate => throw _privateConstructorUsedError;
  DateTime? get returnDate => throw _privateConstructorUsedError;
  Map<String, int> get travellers => throw _privateConstructorUsedError;
  List<Airport> get airports => throw _privateConstructorUsedError;
  Airport? get from => throw _privateConstructorUsedError;
  Airport? get to => throw _privateConstructorUsedError;

  /// Create a copy of SearchDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchDataStateCopyWith<SearchDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchDataStateCopyWith<$Res> {
  factory $SearchDataStateCopyWith(
    SearchDataState value,
    $Res Function(SearchDataState) then,
  ) = _$SearchDataStateCopyWithImpl<$Res, SearchDataState>;
  @useResult
  $Res call({
    bool isLoading,
    bool oneWay,
    String seatClass,
    DateTime departureDate,
    DateTime? returnDate,
    Map<String, int> travellers,
    List<Airport> airports,
    Airport? from,
    Airport? to,
  });
}

/// @nodoc
class _$SearchDataStateCopyWithImpl<$Res, $Val extends SearchDataState>
    implements $SearchDataStateCopyWith<$Res> {
  _$SearchDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? oneWay = null,
    Object? seatClass = null,
    Object? departureDate = null,
    Object? returnDate = freezed,
    Object? travellers = null,
    Object? airports = null,
    Object? from = freezed,
    Object? to = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            oneWay: null == oneWay
                ? _value.oneWay
                : oneWay // ignore: cast_nullable_to_non_nullable
                      as bool,
            seatClass: null == seatClass
                ? _value.seatClass
                : seatClass // ignore: cast_nullable_to_non_nullable
                      as String,
            departureDate: null == departureDate
                ? _value.departureDate
                : departureDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            returnDate: freezed == returnDate
                ? _value.returnDate
                : returnDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            travellers: null == travellers
                ? _value.travellers
                : travellers // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            airports: null == airports
                ? _value.airports
                : airports // ignore: cast_nullable_to_non_nullable
                      as List<Airport>,
            from: freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as Airport?,
            to: freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as Airport?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchDataStateImplCopyWith<$Res>
    implements $SearchDataStateCopyWith<$Res> {
  factory _$$SearchDataStateImplCopyWith(
    _$SearchDataStateImpl value,
    $Res Function(_$SearchDataStateImpl) then,
  ) = __$$SearchDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool oneWay,
    String seatClass,
    DateTime departureDate,
    DateTime? returnDate,
    Map<String, int> travellers,
    List<Airport> airports,
    Airport? from,
    Airport? to,
  });
}

/// @nodoc
class __$$SearchDataStateImplCopyWithImpl<$Res>
    extends _$SearchDataStateCopyWithImpl<$Res, _$SearchDataStateImpl>
    implements _$$SearchDataStateImplCopyWith<$Res> {
  __$$SearchDataStateImplCopyWithImpl(
    _$SearchDataStateImpl _value,
    $Res Function(_$SearchDataStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? oneWay = null,
    Object? seatClass = null,
    Object? departureDate = null,
    Object? returnDate = freezed,
    Object? travellers = null,
    Object? airports = null,
    Object? from = freezed,
    Object? to = freezed,
  }) {
    return _then(
      _$SearchDataStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        oneWay: null == oneWay
            ? _value.oneWay
            : oneWay // ignore: cast_nullable_to_non_nullable
                  as bool,
        seatClass: null == seatClass
            ? _value.seatClass
            : seatClass // ignore: cast_nullable_to_non_nullable
                  as String,
        departureDate: null == departureDate
            ? _value.departureDate
            : departureDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        returnDate: freezed == returnDate
            ? _value.returnDate
            : returnDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        travellers: null == travellers
            ? _value._travellers
            : travellers // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        airports: null == airports
            ? _value._airports
            : airports // ignore: cast_nullable_to_non_nullable
                  as List<Airport>,
        from: freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as Airport?,
        to: freezed == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as Airport?,
      ),
    );
  }
}

/// @nodoc

class _$SearchDataStateImpl implements _SearchDataState {
  const _$SearchDataStateImpl({
    required this.isLoading,
    required this.oneWay,
    required this.seatClass,
    required this.departureDate,
    this.returnDate,
    required final Map<String, int> travellers,
    required final List<Airport> airports,
    this.from,
    this.to,
  }) : _travellers = travellers,
       _airports = airports;

  @override
  final bool isLoading;
  @override
  final bool oneWay;
  @override
  final String seatClass;
  @override
  final DateTime departureDate;
  @override
  final DateTime? returnDate;
  final Map<String, int> _travellers;
  @override
  Map<String, int> get travellers {
    if (_travellers is EqualUnmodifiableMapView) return _travellers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_travellers);
  }

  final List<Airport> _airports;
  @override
  List<Airport> get airports {
    if (_airports is EqualUnmodifiableListView) return _airports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_airports);
  }

  @override
  final Airport? from;
  @override
  final Airport? to;

  @override
  String toString() {
    return 'SearchDataState(isLoading: $isLoading, oneWay: $oneWay, seatClass: $seatClass, departureDate: $departureDate, returnDate: $returnDate, travellers: $travellers, airports: $airports, from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchDataStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.oneWay, oneWay) || other.oneWay == oneWay) &&
            (identical(other.seatClass, seatClass) ||
                other.seatClass == seatClass) &&
            (identical(other.departureDate, departureDate) ||
                other.departureDate == departureDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            const DeepCollectionEquality().equals(
              other._travellers,
              _travellers,
            ) &&
            const DeepCollectionEquality().equals(other._airports, _airports) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    oneWay,
    seatClass,
    departureDate,
    returnDate,
    const DeepCollectionEquality().hash(_travellers),
    const DeepCollectionEquality().hash(_airports),
    from,
    to,
  );

  /// Create a copy of SearchDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchDataStateImplCopyWith<_$SearchDataStateImpl> get copyWith =>
      __$$SearchDataStateImplCopyWithImpl<_$SearchDataStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SearchDataState implements SearchDataState {
  const factory _SearchDataState({
    required final bool isLoading,
    required final bool oneWay,
    required final String seatClass,
    required final DateTime departureDate,
    final DateTime? returnDate,
    required final Map<String, int> travellers,
    required final List<Airport> airports,
    final Airport? from,
    final Airport? to,
  }) = _$SearchDataStateImpl;

  @override
  bool get isLoading;
  @override
  bool get oneWay;
  @override
  String get seatClass;
  @override
  DateTime get departureDate;
  @override
  DateTime? get returnDate;
  @override
  Map<String, int> get travellers;
  @override
  List<Airport> get airports;
  @override
  Airport? get from;
  @override
  Airport? get to;

  /// Create a copy of SearchDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchDataStateImplCopyWith<_$SearchDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
