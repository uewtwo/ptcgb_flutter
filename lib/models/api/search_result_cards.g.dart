// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_cards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultCards _$SearchResultCardsFromJson(Map<String, dynamic> json) {
  return SearchResultCards(
    result: json['result'] as int,
    errMsg: json['errMsg'] as String,
    thisPage: json['thisPage'] as int,
    maxPage: json['maxPage'] as int,
    hitCnt: json['hitCnt'] as int,
    cardStart: json['cardStart'] as int,
    cardEnd: json['cardEnd'] as int,
    searchCondition:
        (json['searchCondition'] as List)?.map((e) => e as String)?.toList(),
    regulation: json['regulation'] as String,
    cardList: (json['cardList'] as List)
        ?.map((e) => e == null
            ? null
            : SearchResultCard.fromJson((e as Map<String, dynamic>)?.map(
                (k, e) => MapEntry(k, e as String),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchResultCardsToJson(SearchResultCards instance) =>
    <String, dynamic>{
      'result': instance.result,
      'errMsg': instance.errMsg,
      'thisPage': instance.thisPage,
      'maxPage': instance.maxPage,
      'hitCnt': instance.hitCnt,
      'cardStart': instance.cardStart,
      'cardEnd': instance.cardEnd,
      'searchCondition': instance.searchCondition,
      'regulation': instance.regulation,
      'cardList': instance.cardList,
    };

SearchResultCard _$SearchResultCardFromJson(Map<String, dynamic> json) {
  return SearchResultCard(
    cardID: json['cardID'] as String,
    cardThumbFile: json['cardThumbFile'] as String,
    cardNameAltText: json['cardNameAltText'] as String,
    cardNameViewText: json['cardNameViewText'] as String,
  );
}

Map<String, dynamic> _$SearchResultCardToJson(SearchResultCard instance) =>
    <String, dynamic>{
      'cardID': instance.cardID,
      'cardThumbFile': instance.cardThumbFile,
      'cardNameAltText': instance.cardNameAltText,
      'cardNameViewText': instance.cardNameViewText,
    };
