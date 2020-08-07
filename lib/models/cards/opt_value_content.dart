import 'package:json_annotation/json_annotation.dart';

part 'opt_value_content.g.dart';

// FIXME: 既にSMのTAG TEAMを追えていないが、新Optionがでた時にどうするか検討
@JsonSerializable()
class OptValueContent {
  final bool isV;
  final bool isVMAX;
  final bool isFossil;

  OptValueContent({this.isV, this.isVMAX, this.isFossil});
  
  factory OptValueContent.fromJson(Map<String, dynamic> json) => _$OptValueContentFromJson(json);

  Map<String, dynamic> toJson() => _$OptValueContentToJson(this);
}
