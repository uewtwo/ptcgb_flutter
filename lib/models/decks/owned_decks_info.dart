import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'owned_decks_info.g.dart';

@JsonSerializable()
class OwnedDecksInfo {
  final List<OwnedDeckInfo> ownedDeckInfoList;

  OwnedDecksInfo({this.ownedDeckInfoList});

  factory OwnedDecksInfo.fromJson(List<dynamic> parsedJson) {
    List<OwnedDeckInfo> ownedDecksInfo = List<OwnedDeckInfo>();
    ownedDecksInfo = parsedJson.map((i) => OwnedDeckInfo.fromJson(i)).toList();
    return OwnedDecksInfo(ownedDeckInfoList:ownedDecksInfo);
  }

  Map<String, dynamic> toJson() => _$OwnedDecksInfoToJson(this);
  String get jsonString => json.encode(this);

  List<OwnedDeckInfo> toList() => this.ownedDeckInfoList;
  OwnedDecksInfo fromList(List<OwnedDeckInfo> val) => OwnedDecksInfo(ownedDeckInfoList: val);

  int get length => this.ownedDeckInfoList.length;
}

@JsonSerializable()
class OwnedDeckInfo {
  final String deckId;
  final String deckName;
  final int topCardId;
  final int sortValue;

  OwnedDeckInfo(this.deckId, this.deckName, this.topCardId, this.sortValue);

  factory OwnedDeckInfo.fromJson(Map<String, dynamic> json) => _$OwnedDeckInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OwnedDeckInfoToJson(this);
}

