import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptcgb_flutter/common/appbar_search.dart';
import 'package:ptcgb_flutter/enums/generations/generations.dart';
import 'package:ptcgb_flutter/models/api/search_result_cards.dart';

import 'package:ptcgb_flutter/models/expansion/expansion_contents.dart';
import 'package:ptcgb_flutter/screens/cards/card_list.dart';

class Expansions extends StatefulWidget {
  static const routeName = '/expansions';
  @override
  ExpansionsState createState() => ExpansionsState();
}

class ExpansionsState extends State<Expansions> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  ExpansionsState() {
    dio = Dio();
    _listContent = [];
    _searchText = "";
    _pageNum = 1;
  }
  Dio dio;
  List<SearchResultCard> _listContent;
  String _searchText;
  int _hitCnt;
  int _pageNum;

  AppBarSearch appbarsearch;

  @override
  void initState() {
    super.initState();

    appbarsearch =
        AppBarSearch(state: this, onSubmitted: _searchCardsByKeyword);
  }

  @override
  Widget build(BuildContext context) {
    final GenerationsEnum genEnum = ModalRoute.of(context).settings.arguments;
    final String gen = genEnum.name;
    return _buildExpansionsList(context, gen);
  }

  Widget _buildExpansionsList(BuildContext context, String gen) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: appbarsearch.onTitle(const Text('Expansion List')),
            actions: <Widget>[
              appbarsearch.searchIcon,
              IconButton(icon: Icon(Icons.list), onPressed: null),
            ]),
        body: _searchText.isEmpty
            ? this._getExpansionContentsByGen(context, gen)
            : this._buildSearchCardList());
  }

  Widget _getExpansionContentsByGen(BuildContext context, String gen) {
    return Container(
      child: Column(children: <Widget>[
        Expanded(
          child: Center(
            child: FutureBuilder(
              future: this.getExpansionContentsByGen(context, gen),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return _buildExpansions(context, snapshot);
              },
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildSearchCardList() {
    return Scrollbar(
      child: ListView.builder(
        itemCount: _listContent.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if ((_hitCnt != null && index + 1 < _hitCnt) &&
              index + 1 >= _listContent.length) {
            _pageNum++;
            _searchCardsByKeyword(_searchText, page: _pageNum);
          }
          return Container(
            decoration: new BoxDecoration(
                border: new Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey))),
            child: ListTile(
              title: Text(_listContent[index].cardNameViewText,
                  style: _biggerFont),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpansions(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      // show circle during loading.
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    } else if (snapshot.hasData) {
      final List<ExpansionContent> expansions = snapshot.data;
      return Scrollbar(
        child: ListView.builder(
            itemCount: expansions.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return _expansionItem(context, expansions[index], index);
            }),
      );
    } else {
      return Text('No Data.');
    }
  }

  Widget _expansionItem(
      BuildContext context, ExpansionContent content, int index) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: _expansionImage(content),
        title: Text(content.name, style: _biggerFont),
        onTap: () {
          Navigator.of(context)
              .pushNamed(CardList.routeName, arguments: content);
        },
      ),
    );
  }

  Image _expansionImage(ExpansionContent content) {
    String targetPath =
        'assets/img/expansions/${content.generation}/${content.productNo}.png';
    // ↓DebugCode
    targetPath = 'assets/img/various/sample.png';
    try {
      return Image.asset(targetPath);
    } catch (e) {
      print(e);
      return Image.asset('assets/img/various/sample.png');
    }
  }

  Future<List<ExpansionContent>> getExpansionContentsByGen(
      BuildContext context, String gen) async {
    final String jsonPath = 'assets/text/expansions/$gen.json';
    final List<dynamic> jsonRes =
        jsonDecode(await DefaultAssetBundle.of(context).loadString(jsonPath));
    final List<ExpansionContent> _expansions =
        ExpansionContents.fromJson(jsonRes).getExpansionContentList();

    return _expansions;
  }

  void _searchCardsByKeyword(String keyword, {int page = 1}) async {
    _searchText = "";
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
      final Response response = await dio.post(url,
          data: new FormData.fromMap(payload),
          options: Options(
            headers: {},
          ));

      final SearchResultCards resData =
          SearchResultCards.fromJson(response.data);

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
