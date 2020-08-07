// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_decks_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnedDecksInfo _$OwnedDecksInfoFromJson(Map<String, dynamic> json) {
  return OwnedDecksInfo(
    ownedDeckInfoList: (json['ownedDeckInfoList'] as List)
        ?.map((e) => e == null
            ? null
            : OwnedDeckInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OwnedDecksInfoToJson(OwnedDecksInfo instance) =>
    <String, dynamic>{
      'ownedDeckInfoList': instance.ownedDeckInfoList,
    };

OwnedDeckInfo _$OwnedDeckInfoFromJson(Map<String, dynamic> json) {
  return OwnedDeckInfo(
    json['deckId'] as String,
    json['deckName'] as String,
    json['topCardId'] as int,
    json['sortValue'] as int,
  );
}

Map<String, dynamic> _$OwnedDeckInfoToJson(OwnedDeckInfo instance) =>
    <String, dynamic>{
      'deckId': instance.deckId,
      'deckName': instance.deckName,
      'topCardId': instance.topCardId,
      'sortValue': instance.sortValue,
    };
