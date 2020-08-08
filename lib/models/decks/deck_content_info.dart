import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:tuple/tuple.dart';

part 'deck_content_info.g.dart';

@JsonSerializable()
class DeckContentInfo {
  final String deckId;
  // TODO: Tuple2<CardContent, int>にしたいけど、TupleがjsonSerializeに載せられない
  final List<List<dynamic>> cardContents;

  DeckContentInfo(this.deckId, this.cardContents);

  factory DeckContentInfo.fromJson(Map<String, dynamic> json) => _$DeckContentInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeckContentInfoToJson(this);

  List<Tuple2<CardContent, int>> get deckElements {
    return List.generate(cardContents.length, (val) {
      final deckElement = cardContents[val];
      return Tuple2(CardContent.fromJson(deckElement[0]), deckElement[1]);
    });
  }
}
