import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/models/api/search_result_cards.dart';

class SearchCards extends StatefulWidget {
  static const routeName = '/search_cards';

  @override
  SearchCardsState createState() => SearchCardsState();
}

class SearchCardsState extends State<SearchCards> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  final _searchCardController = TextEditingController();
  final Dio _dio = Dio();
  List<SearchResultCard> _listContent = [];
  String _searchText;
  int _hitCnt;
  int _pageNum ;

  @override
  void initState() {
    _pageNum = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: textWidgetForSearch(),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: null),
          ]
        ),
        body: Scrollbar(
          child: ListView.builder(
              itemCount: _listContent.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                if ((_hitCnt != null && index + 1 < _hitCnt)
                      && index + 1 >= _listContent.length) {
                  _pageNum++;
                  _searchCardsByKeyword(_searchText, page: _pageNum);
                }
                return Container(
                  decoration: new BoxDecoration(
                      border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: ListTile(
                    title: Text(_listContent[index].cardNameViewText, style: _biggerFont),
                    onTap: () {},
                  ),
                );
              }),
        )
    );
  }

  @override
  void dispose() {
    _searchCardController.dispose();
    super.dispose();
  }

  Widget textWidgetForSearch() {
    return TextField(
        onSubmitted: _searchCardsByKeyword
    );
  }

  void _searchCardsByKeyword(String keyword, {int page = 1}) async {
    // 何となく2文字以上でsubmitされた場合に絞る
    if (keyword.length >= 2) {
      final url = 'https://www.pokemon-card.com/card-search/resultAPI.php';
      final payload = {
        'keyword': keyword,
        'regulation_sidebar_form': 'XY',
        'sm_and_keyword': true,
        'page': page
      };

      // FIXME: エラーハンドリング
      final Response response = await _dio.post(
          url,
          data: new FormData.fromMap(payload),
          options: Options(
            headers: {},
          ));

      final SearchResultCards resData = SearchResultCards.fromJson(
          response.data);

      setState(() {
        _searchText = keyword;
        _hitCnt = resData.hitCnt;
        if (page == 1) {
          _listContent = [];
        }

        _listContent.addAll(resData.cardList);
      });
    }
  }
}
