import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ptcgb_flutter/debug/sa_expansion_list.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:ptcgb_flutter/managers/states/cards/card_list_state.dart';

class CardListAction {
  Future<List<CardContent>> baseCardList;
//  List<CardContent> filteredCardList;
  String generation;

  CardListAction({
    Future<List<CardContent>> baseCardList,
//    List<CardContent> filteredCardList,
    String generation
  });

  Future<List<CardContent>> filterCard(String searchStr) async {
    List<CardContent> filteredCardList = (await _getAllCardByGeneration()).where(
        (val) => val.searchCardText(searchStr)
    ).toList();
    return filteredCardList;
  }

  Future<List<CardContent>> _getAllCardByGeneration() async {
    List<CardContent> _list = [];
    final String basePath = 'assets/text/cards/jp/$generation/';
    // FIXME: debug用にsaのリストを予め用意、本来はgenによって動的にファイルリストを取得
    SA_LIST.forEach((ele) async {
      _list.addAll(CardContents.fromJson(
        jsonDecode(await rootBundle.loadString('$basePath$ele.json'))
      ).toList());
    });

    return _list;
  }
}
