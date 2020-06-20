import 'package:json_annotation/json_annotation.dart';

part 'opt_value_content.g.dart';

@JsonSerializable()
class OptValueContent {
  final bool isV;
  final bool isVMAX;
  final bool isFossil;

  OptValueContent({this.isV, this.isVMAX, this.isFossil});
  
  factory OptValueContent.fromJson(Map<String, dynamic> json) => _$OptValueContentFromJson(json);

  Map<String, dynamic> toJson() => _$OptValueContentToJson(this);
}
