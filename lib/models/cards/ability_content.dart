import 'package:json_annotation/json_annotation.dart';

part 'ability_content.g.dart';

@JsonSerializable()
class AbilityContent {
  final String name;
  final String text;

  AbilityContent({this.name, this.text});

  factory AbilityContent.fromJson(Map<String, dynamic> json) {
    return new AbilityContent(
      name: json['name'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
    'iname': name,
    'text': text,
  };
}
