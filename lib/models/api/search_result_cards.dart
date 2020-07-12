import 'package:json_annotation/json_annotation.dart';

part 'search_result_cards.g.dart';

@JsonSerializable()
class SearchResultCards {
  final int result;
  final String errMsg;
  final int thisPage;
  final int maxPage;
  final int hitCnt;
  final int cardStart;
  final int cardEnd;
  final List<String> searchCondition;
  final String regulation;
  final List<SearchResultCard> cardList;

  SearchResultCards({
    this.result,
    this.errMsg,
    this.thisPage,
    this.maxPage,
    this.hitCnt,
    this.cardStart,
    this.cardEnd,
    this.searchCondition,
    this.regulation,
    this.cardList
  });

  factory SearchResultCards.fromJson(Map<String, dynamic> json) => _$SearchResultCardsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultCardsToJson(this);
}

@JsonSerializable()
class SearchResultCard {
  final String cardID;
  final String cardThumbFile;
  final String cardNameAltText;
  final String cardNameViewText;

  SearchResultCard({this.cardID, this.cardThumbFile, this.cardNameAltText, this.cardNameViewText});
  factory SearchResultCard.fromJson(Map<String, String> json) => _$SearchResultCardFromJson(json);
  Map<String, String> toJson() => _$SearchResultCardToJson(this);
}
