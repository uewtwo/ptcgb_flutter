// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_content_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeckContentInfo _$DeckContentInfoFromJson(Map<String, dynamic> json) {
  return DeckContentInfo(
    json['deckId'] as String,
    (json['cardContents'] as List)?.map((e) => e as List)?.toList(),
  );
}

Map<String, dynamic> _$DeckContentInfoToJson(DeckContentInfo instance) =>
    <String, dynamic>{
      'deckId': instance.deckId,
      'cardContents': instance.cardContents,
    };
