import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'attack_content.g.dart';

@JsonSerializable()
class AttackContent extends Equatable {
  final String name;
  final String damage;
  final String text;
  final List<dynamic> costs;
  final int convertedCost;

  AttackContent(this.name, this.damage, this.text, this.costs, this.convertedCost);

  factory AttackContent.fromJson(Map<String, dynamic> json) => _$AttackContentFromJson(json);

  Map<String, dynamic> toJson() => _$AttackContentToJson(this);

  @override
  List<Object> get props => [name, damage, text, costs, convertedCost];
}
