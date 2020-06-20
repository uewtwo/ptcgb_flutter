import 'package:json_annotation/json_annotation.dart';

part 'weaknesses_content.g.dart';

@JsonSerializable()
class WeaknessesContent {
  final String color;
  final String calc; // weakness では常に *2 を想定しているので使用しない、nullが入っている。
  final String value;

  WeaknessesContent({this.color, this.calc, this.value});

  factory WeaknessesContent.fromJson(Map<String, dynamic> json) => _$WeaknessesContentFromJson(json);

  Map<String, dynamic> toJson() => _$WeaknessesContentToJson(this);
}
