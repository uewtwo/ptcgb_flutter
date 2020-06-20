import 'package:json_annotation/json_annotation.dart';

part 'retreats_content.g.dart';

@JsonSerializable()
class RetreatsContent {
  final List<String> costs;
  final int convertedCost;

  RetreatsContent({this.costs, this.convertedCost});

  factory RetreatsContent.fromJson(Map<String, dynamic> json) {
    return new RetreatsContent(
      costs: json['costs'],
      convertedCost: json['convertedCost'],
    );
  }

  Map<String, dynamic> toJson() => {
    'costs': costs,
    'convertedCost': convertedCost,
  };
}
