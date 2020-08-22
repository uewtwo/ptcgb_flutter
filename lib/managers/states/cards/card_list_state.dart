import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
part 'card_list_state.freezed.dart';

@freezed
abstract class CardListState with _$CardListState {
  factory CardListState({
    Future<List<CardContent>> baseCardList,
    List<CardContent> filteredCardList
  }) = _CardListState;
}
