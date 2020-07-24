// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expansion_contents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpansionContents _$ExpansionContentsFromJson(Map<String, dynamic> json) {
  return ExpansionContents(
    expansionInfoList: (json['expansionInfoList'] as List)
        ?.map((e) => e == null
            ? null
            : ExpansionContent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExpansionContentsToJson(ExpansionContents instance) =>
    <String, dynamic>{
      'expansionInfoList': instance.expansionInfoList,
    };

ExpansionContent _$ExpansionContentFromJson(Map<String, dynamic> json) {
  return ExpansionContent(
    json['productNo'] as String,
    json['name'] as String,
    json['releaseDate'] as String,
    json['generation'] as String,
  );
}

Map<String, dynamic> _$ExpansionContentToJson(ExpansionContent instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'name': instance.name,
      'releaseDate': instance.releaseDate,
      'generation': instance.generation,
    };
