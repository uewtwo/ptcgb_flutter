// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttackContent _$AttackContentFromJson(Map<String, dynamic> json) {
  return AttackContent(
    json['name'] as String,
    json['damage'] as String,
    json['text'] as String,
    json['convertedCost'] as int,
    json['costs'] as List,
  );
}

Map<String, dynamic> _$AttackContentToJson(AttackContent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'damage': instance.damage,
      'text': instance.text,
      'costs': instance.costs,
      'convertedCost': instance.convertedCost,
    };
