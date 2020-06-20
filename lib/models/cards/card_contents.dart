import 'package:json_annotation/json_annotation.dart';
import 'package:ptcgb_flutter/models/cards/ability_content.dart';
import 'package:ptcgb_flutter/models/cards/attack_content.dart';
import 'package:ptcgb_flutter/models/cards/opt_value_content.dart';
import 'package:ptcgb_flutter/models/cards/resistances_content.dart';
import 'package:ptcgb_flutter/models/cards/retreats_content.dart';
import 'package:ptcgb_flutter/models/cards/weaknesses_content.dart';

part 'card_contents.g.dart';

@JsonSerializable()
class CardContents {
  final List<CardContent> cardContentList;

  CardContents({this.cardContentList});

  factory CardContents.fromJson(List<dynamic> parsedJson) {
    List<CardContent> cardContents = new List<CardContent>();
    cardContents = parsedJson.map((i) => CardContent.fromJson(i)).toList();
    return new CardContents(cardContentList:cardContents);
  }

  List<CardContent> getCardContentList() => this.cardContentList;
}

@JsonSerializable()
class CardContent {
  final int cardId;
  final String multiId;
  final String nameJp;
  final String nameUs;
  final String imageUrlOfficial;
  final String imageUrl;
  final String cardText;
  final String supertype;
  final String subtype;
  final String trainerText;
  final String energyText;
  final String hp;
  final List<String> color;
  final Map<String, dynamic> optionValue;
  final String author;
  final String rarity;
  final String set;
  final String setCode;
  final String generation;
  final String setNo;
  final AbilityContent ability;
  final List<AttackContent> attacks;
  final String addRule;
  final Map<String, dynamic> weaknesses;
  final Map<String, dynamic> retreats;
  final Map<String, dynamic> resistances;
  final List<int> nationalPokedexNumbers;
  final String evloves;

  CardContent({this.nameJp, this.nameUs, this.imageUrlOfficial, this.imageUrl, this.cardText, this.supertype, this.subtype, this.trainerText, this.energyText, this.hp, this.color, this.optionValue, this.author, this.rarity, this.set, this.setCode, this.generation, this.setNo, this.ability, this.addRule, this.weaknesses, this.resistances, this.nationalPokedexNumbers, this.evloves, this.cardId, this.multiId, this.attacks, this.retreats});

  factory CardContent.fromJson(Map<String, dynamic> json) => _$CardContentFromJson(json);

  Map<String, dynamic> toJson() => _$CardContentToJson(this);
}
