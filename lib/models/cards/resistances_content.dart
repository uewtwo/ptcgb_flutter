import 'package:json_annotation/json_annotation.dart';

part 'resistances_content.g.dart';

@JsonSerializable()
class ResistancesContent {
  final String color;
  final calc; // resistances では常に - を想定しているので使用しない、nullが入っている。
  final String value;

  ResistancesContent({this.color, this.calc, this.value});

  factory ResistancesContent.fromJson(Map<String, dynamic> json) {
    return new ResistancesContent(
      color: json['color'],
      calc: json['calc'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'color': color,
    'calc': calc,
    'value': value,
  };
}
