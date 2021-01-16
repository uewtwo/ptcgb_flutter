import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'ability_content.g.dart';

@JsonSerializable()
class AbilityContent extends Equatable {
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
        'name': name,
        'text': text,
      };

  @override
  List<Object> get props => [name, text];
}
