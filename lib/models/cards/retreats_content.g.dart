// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retreats_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetreatsContent _$RetreatsContentFromJson(Map<String, dynamic> json) {
  return RetreatsContent(
    costs: (json['costs'] as List)?.map((e) => e as String)?.toList(),
    convertedCost: json['convertedCost'] as int,
  );
}

Map<String, dynamic> _$RetreatsContentToJson(RetreatsContent instance) =>
    <String, dynamic>{
      'costs': instance.costs,
      'convertedCost': instance.convertedCost,
    };
