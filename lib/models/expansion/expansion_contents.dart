import 'package:json_annotation/json_annotation.dart';

part 'expansion_contents.g.dart';

@JsonSerializable()
class ExpansionContents {
  final List<ExpansionContent> expansionInfoList;

  ExpansionContents({this.expansionInfoList});

  factory ExpansionContents.fromJson(List<dynamic> parsedJson) {
    List<ExpansionContent> expansionInfoList = new List<ExpansionContent>();
    expansionInfoList = parsedJson.map((i) => ExpansionContent.fromJson(i)).toList();
    // productNo descending sort
    expansionInfoList.sort((b, a) => a.productNo.compareTo(b.productNo));

    return new ExpansionContents(expansionInfoList: expansionInfoList);
  }

  List<ExpansionContent> getExpansionContentList() => this.expansionInfoList;
}

@JsonSerializable()
class ExpansionContent {
  final String productNo;
  final String name;
  final String releaseDate;
  final String generation;

  ExpansionContent(this.productNo, this.name, this.releaseDate, this.generation);

  factory ExpansionContent.fromJson(Map<String, dynamic> json) => _$ExpansionContentFromJson(json);

  Map<String, dynamic> toJson() => _$ExpansionContentToJson(this);
}
