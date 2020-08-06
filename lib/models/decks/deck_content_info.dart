import 'package:json_annotation/json_annotation.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:tuple/tuple.dart';

part 'deck_contents.g.dart';

@JsonSerializable()
class DeckContents {
  final List<DeckContent> deckContentList;

  DeckContents({this.id, this.name, this.deckContentList});

  factory DeckContents.fromJson(List<dynamic> parsedJson) {
    List<DeckContent> deckContents = List<DeckContent>();
    deckContents = parsedJson.map((i) => DeckContent.fromJson(i)).toList();
    return DeckContents(deckContentList:deckContents);
  }

  List<DeckContent> getDeckContentList() => this.deckContentList;
}

@JsonSerializable()
class DeckContent {

  List<Tuple2<CardContent, int>> deckElementList;

}
