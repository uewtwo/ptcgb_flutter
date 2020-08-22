// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'card_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$CardListStateTearOff {
  const _$CardListStateTearOff();

// ignore: unused_element
  _CardListState call(
      {Future<List<CardContent>> baseCardList,
      List<CardContent> filteredCardList}) {
    return _CardListState(
      baseCardList: baseCardList,
      filteredCardList: filteredCardList,
    );
  }
}

// ignore: unused_element
const $CardListState = _$CardListStateTearOff();

mixin _$CardListState {
  Future<List<CardContent>> get baseCardList;
  List<CardContent> get filteredCardList;

  $CardListStateCopyWith<CardListState> get copyWith;
}

abstract class $CardListStateCopyWith<$Res> {
  factory $CardListStateCopyWith(
          CardListState value, $Res Function(CardListState) then) =
      _$CardListStateCopyWithImpl<$Res>;
  $Res call(
      {Future<List<CardContent>> baseCardList,
      List<CardContent> filteredCardList});
}

class _$CardListStateCopyWithImpl<$Res>
    implements $CardListStateCopyWith<$Res> {
  _$CardListStateCopyWithImpl(this._value, this._then);

  final CardListState _value;
  // ignore: unused_field
  final $Res Function(CardListState) _then;

  @override
  $Res call({
    Object baseCardList = freezed,
    Object filteredCardList = freezed,
  }) {
    return _then(_value.copyWith(
      baseCardList: baseCardList == freezed
          ? _value.baseCardList
          : baseCardList as Future<List<CardContent>>,
      filteredCardList: filteredCardList == freezed
          ? _value.filteredCardList
          : filteredCardList as List<CardContent>,
    ));
  }
}

abstract class _$CardListStateCopyWith<$Res>
    implements $CardListStateCopyWith<$Res> {
  factory _$CardListStateCopyWith(
          _CardListState value, $Res Function(_CardListState) then) =
      __$CardListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Future<List<CardContent>> baseCardList,
      List<CardContent> filteredCardList});
}

class __$CardListStateCopyWithImpl<$Res>
    extends _$CardListStateCopyWithImpl<$Res>
    implements _$CardListStateCopyWith<$Res> {
  __$CardListStateCopyWithImpl(
      _CardListState _value, $Res Function(_CardListState) _then)
      : super(_value, (v) => _then(v as _CardListState));

  @override
  _CardListState get _value => super._value as _CardListState;

  @override
  $Res call({
    Object baseCardList = freezed,
    Object filteredCardList = freezed,
  }) {
    return _then(_CardListState(
      baseCardList: baseCardList == freezed
          ? _value.baseCardList
          : baseCardList as Future<List<CardContent>>,
      filteredCardList: filteredCardList == freezed
          ? _value.filteredCardList
          : filteredCardList as List<CardContent>,
    ));
  }
}

class _$_CardListState implements _CardListState {
  _$_CardListState({this.baseCardList, this.filteredCardList});

  @override
  final Future<List<CardContent>> baseCardList;
  @override
  final List<CardContent> filteredCardList;

  @override
  String toString() {
    return 'CardListState(baseCardList: $baseCardList, filteredCardList: $filteredCardList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CardListState &&
            (identical(other.baseCardList, baseCardList) ||
                const DeepCollectionEquality()
                    .equals(other.baseCardList, baseCardList)) &&
            (identical(other.filteredCardList, filteredCardList) ||
                const DeepCollectionEquality()
                    .equals(other.filteredCardList, filteredCardList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(baseCardList) ^
      const DeepCollectionEquality().hash(filteredCardList);

  @override
  _$CardListStateCopyWith<_CardListState> get copyWith =>
      __$CardListStateCopyWithImpl<_CardListState>(this, _$identity);
}

abstract class _CardListState implements CardListState {
  factory _CardListState(
      {Future<List<CardContent>> baseCardList,
      List<CardContent> filteredCardList}) = _$_CardListState;

  @override
  Future<List<CardContent>> get baseCardList;
  @override
  List<CardContent> get filteredCardList;
  @override
  _$CardListStateCopyWith<_CardListState> get copyWith;
}
