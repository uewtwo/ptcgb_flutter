import 'package:json_annotation/json_annotation.dart';

part 'attack_content.g.dart';

@JsonSerializable()
class AttackContent {
  final String name;
  final String damage;
  final String text;
  final List<dynamic> costs;
  final int convertedCost;

  AttackContent(this.name, this.damage, this.text, this.convertedCost, this.costs);

  factory AttackContent.fromJson(Map<String, dynamic> json) => _$AttackContentFromJson(json);

  Map<String, dynamic> toJson() => _$AttackContentToJson(this);
}
