import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptcgb_flutter/common/appbar_search.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/enums/generations/generations.dart';
import 'package:ptcgb_flutter/models/api/search_result_cards.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';

import 'package:ptcgb_flutter/models/expansion/expansion_contents.dart';
import 'package:ptcgb_flutter/views/cards/card_list.dart';

class Expansions extends StatefulWidget {
  static const routeName = '/expansions';
  @override
  ExpansionsState createState() => ExpansionsState();
}

class ExpansionsState extends State<Expansions> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  final _searchCardController = TextEditingController();

  AppBarSearch appbarsearch;

  Future<List<CardContent>> baseCardList;
  List<CardContent> filteredCardList;

  @override
  void initState() {
    super.initState();
    appbarsearch = AppBarSearch(
      state: this,
      onSubmitted: (value) { _filteringCard(value); },
      controller: _searchCardController,
    );

    baseCardList = getAllCardByGeneration(context, 'sa');
  }

  void _filteringCard(String searchStr) async {
    filteredCardList = [];
    filteredCardList = (await baseCardList).where(
            (val) => val.searchCardText(searchStr)
    ).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GenerationsEnum gen = ModalRoute.of(context).settings.arguments;
    return _buildExpansionsList(context, gen.name);
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
        body: filteredCardList != null
            ? _buildSearchCardList(filteredCardList)
            : _getExpansionContentsByGen(context, gen)
    );
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
                  ))),
        ])
    );
  }

  Widget _buildSearchCardList(List<CardContent> cardList) {
    return Scrollbar(
      child: ListView.builder(
          itemCount: cardList.length,
          padding: EdgeInsets.all(1.0),
          itemBuilder: (context, index) {
            return _cardItem(context, cardList[index], index);
          }),
    );
  }

  Widget _cardItem(BuildContext context, CardContent content, int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: _cardImage(content),
        title: Text(content.nameJp, style: _biggerFont),
        onTap: () {},
        onLongPress: () {},
      ),
    );
  }

  Image _cardImage(CardContent content) {
    return Image.asset(
        'assets/img/various/sample.png'
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
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: ListTile(
        leading: _expansionImage(content),
        title: Text(content.name, style: _biggerFont),
        onTap: () {
          Navigator.of(context).pushNamed(CardList.routeName, arguments: content);
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
}
