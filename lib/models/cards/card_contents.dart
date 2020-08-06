import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'package:ptcgb_flutter/enums/card/card_supertype.dart';
import 'package:ptcgb_flutter/enums/card/energy_subtype.dart';
import 'package:ptcgb_flutter/enums/card/pokemon_subtype.dart';
import 'package:ptcgb_flutter/enums/card/trainer_subtype.dart';
import 'package:ptcgb_flutter/models/cards/ability_content.dart';
import 'package:ptcgb_flutter/models/cards/attack_content.dart';
// TODO: 下記はモデルを使えていない
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
    List<CardContent> cardContents = List<CardContent>();
    cardContents = parsedJson.map((i) => CardContent.fromJson(i)).toList();
    return CardContents(cardContentList:cardContents);
  }

  List<CardContent> toList() => this.cardContentList;
  CardContents fromList(List<CardContent> val) => CardContents(cardContentList: val);

  int get length => this.cardContentList.length;
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
  // TODO: OptionValueはGenerationによって変わるので、どこかで吸収する
  final Map<String, dynamic> optionValue;
  final String author;
  final String rarity;
  final String productNo;
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
  final String evolves;

  CardContent({this.nameJp, this.nameUs, this.imageUrlOfficial, this.imageUrl, this.cardText, this.supertype, this.subtype, this.trainerText, this.energyText, this.hp, this.color, this.optionValue, this.author, this.rarity, this.productNo, this.set, this.setCode, this.generation, this.setNo, this.ability, this.addRule, this.weaknesses, this.resistances, this.nationalPokedexNumbers, this.evolves, this.cardId, this.multiId, this.attacks, this.retreats});

  factory CardContent.fromJson(Map<String, dynamic> json) => _$CardContentFromJson(json);

  Map<String, dynamic> toJson() => _$CardContentToJson(this);

  bool isTheSameEffectCard(CardContent other) {
    return this.minCardText == other.minCardText;
//    return identical(this, other) ||
//        nameJp == other.nameJp ||
//        cardText == other.cardText ||
//        subtype == other.subtype ||
//        trainerText == other.trainerText ||
//        energyText == other.energyText ||
//        hp == other.hp ||
//        ability == other.ability ||
//        ListEqua lity().equals(attacks, other.attacks);
  }

  bool searchCardText(String searchStr) {
    // 平仮名カタカナで検索する
    final String hira = searchStr.replaceAllMapped(
        RegExp("[ぁ-ゔ]"),
            (Match m) => String.fromCharCode(m.group(0).codeUnitAt(0) + 0x60));
    final String kana = searchStr.replaceAllMapped(
        RegExp("[ァ-ヴ]"),
            (Match m) => String.fromCharCode(m.group(0).codeUnitAt(0) - 0x60));
    final RegExp _regex = RegExp('$hira|$kana');


    return minCardText.contains(_regex);
  }

  /// 検索対象の文字列集めたもの、同一チェックもこれで行う
  // TODO: 多分遅い
  String get minCardText {
    String attacksStr = '';
    for (int i = 0; i < attacks.length; i++) {
      attacksStr = [
        attacksStr, attacks[i].name, attacks[i].text, attacks[i].damage
      ].where((val) => val != null).join();
    }
    final String _target = [
      nameJp, trainerText, energyText,
      ability.text, ability.name,
      hp, attacksStr
    ].where((val) => val != null).join();

    return _target;
  }

  CardSupertype get cardSupertype {
    final CardSupertype _cardSupertype = CardSupertype.values
        .where((_supertype) => _supertype.name == supertype)
        .toList()[0];
    return _cardSupertype;
  }

  // TODO: Supertype毎のenumじゃない何かを用意した方が良い？
  // FIXME: cardSubtypeの返す値が固定enumじゃない問題
  get cardSubtype {
    Object _sub;
    final CardSupertype _cardSupertype = cardSupertype;
    switch (_cardSupertype) {
      case CardSupertype.POKEMON:
        _sub = PokemonSubtype.values
          .where((_subtype) => _subtype.name == subtype)
          .toList()[0];
        break;
      case CardSupertype.TRAINER:
        _sub = TrainerSubtype.values
            .where((_subtype) => _subtype.name == subtype)
            .toList()[0];
        break;
      case CardSupertype.ENERGY:
        _sub = EnergySubtype.values
            .where((_subtype) => _subtype.name == subtype)
            .toList()[0];
        break;
      default: Error();
    }

    return _sub;
  }
}
