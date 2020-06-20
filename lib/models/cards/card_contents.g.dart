// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_contents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardContents _$CardContentsFromJson(Map<String, dynamic> json) {
  return CardContents(
    cardContentList: (json['cardContentList'] as List)
        ?.map((e) =>
            e == null ? null : CardContent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CardContentsToJson(CardContents instance) =>
    <String, dynamic>{
      'cardContentList': instance.cardContentList,
    };

CardContent _$CardContentFromJson(Map<String, dynamic> json) {
  return CardContent(
    nameJp: json['nameJp'] as String,
    nameUs: json['nameUs'] as String,
    imageUrlOfficial: json['imageUrlOfficial'] as String,
    imageUrl: json['imageUrl'] as String,
    cardText: json['cardText'] as String,
    supertype: json['supertype'] as String,
    subtype: json['subtype'] as String,
    trainerText: json['trainerText'] as String,
    energyText: json['energyText'] as String,
    hp: json['hp'] as String,
    color: (json['color'] as List)?.map((e) => e as String)?.toList(),
    optionValue: json['optionValue'] as Map<String, dynamic>,
    author: json['author'] as String,
    rarity: json['rarity'] as String,
    set: json['set'] as String,
    setCode: json['setCode'] as String,
    generation: json['generation'] as String,
    setNo: json['setNo'] as String,
    ability: json['ability'] == null
        ? null
        : AbilityContent.fromJson(json['ability'] as Map<String, dynamic>),
    addRule: json['addRule'] as String,
    weaknesses: json['weaknesses'] as Map<String, dynamic>,
    resistances: json['resistances'] as Map<String, dynamic>,
    nationalPokedexNumbers: (json['nationalPokedexNumbers'] as List)
        ?.map((e) => e as int)
        ?.toList(),
    evloves: json['evloves'] as String,
    cardId: json['cardId'] as int,
    multiId: json['multiId'] as String,
    attacks: (json['attacks'] as List)
        ?.map((e) => e == null
            ? null
            : AttackContent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    retreats: json['retreats'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CardContentToJson(CardContent instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'multiId': instance.multiId,
      'nameJp': instance.nameJp,
      'nameUs': instance.nameUs,
      'imageUrlOfficial': instance.imageUrlOfficial,
      'imageUrl': instance.imageUrl,
      'cardText': instance.cardText,
      'supertype': instance.supertype,
      'subtype': instance.subtype,
      'trainerText': instance.trainerText,
      'energyText': instance.energyText,
      'hp': instance.hp,
      'color': instance.color,
      'optionValue': instance.optionValue,
      'author': instance.author,
      'rarity': instance.rarity,
      'set': instance.set,
      'setCode': instance.setCode,
      'generation': instance.generation,
      'setNo': instance.setNo,
      'ability': instance.ability,
      'attacks': instance.attacks,
      'addRule': instance.addRule,
      'weaknesses': instance.weaknesses,
      'retreats': instance.retreats,
      'resistances': instance.resistances,
      'nationalPokedexNumbers': instance.nationalPokedexNumbers,
      'evloves': instance.evloves,
    };
