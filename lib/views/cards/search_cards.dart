import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/debug/sa_expansion_list.dart';
import 'package:ptcgb_flutter/models/api/search_result_cards.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';

class SearchCards extends StatefulWidget {
  static const routeName = '/search_cards';

  @override
  SearchCardsState createState() => SearchCardsState();
}

class SearchCardsState extends State<SearchCards> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  final _searchCardController = TextEditingController();

  Future<List<CardContent>> baseCardList;
  List<CardContent> filteredCardList;

  @override
  void initState() {
    super.initState();
    baseCardList = getAllCardInSa(context);
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: textWidgetForSearch(),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: null),
          ]
        ),
        body: // Container(child: Expanded(
        //  child:
        filteredCardList != null
              ? _buildFilteredCardList()
              : _buildFutureCardList(context)
       // ))
    );
  }

  Widget _buildFilteredCardList() {
    return _buildScrolledCardList(filteredCardList);
  }

  Widget _buildFutureCardList(BuildContext context) {
    return  FutureBuilder(
        future: baseCardList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _buildCardList(context, snapshot);
        }
    );
  }

  Widget _buildCardList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Container(
          height: 20,
          width: 20,
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      //      throw snapshot.error;
      return Container(
          padding: EdgeInsets.all(10.0),
          child: Text(snapshot.error.toString()));
    } else if (snapshot.hasData) {
      final List<CardContent> cardList = snapshot.data;
      return _buildScrolledCardList(cardList);
    } else {
      return Text('No Data.');
    }
  }

  Widget _buildScrolledCardList(List<CardContent> cardList) {
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
        onTap: () {
//          addDeckElement(content);
        },
        onLongPress: () {
//          Navigator.of(context).pushNamed(CardDetail.routeName, arguments: content);
        },
      ),
    );
  }

  Image _cardImage(CardContent content) {
    return Image.asset(
        'assets/img/various/sample.png'
    );
  }

  @override
  void dispose() {
    _searchCardController.dispose();
    super.dispose();
  }

  // お試し全カード取得
  Future<List<CardContent>> getAllCardInSa(BuildContext context) async {
    List<CardContent> _list = [];
    final String basePath = 'assets/text/cards/jp/sa/';
    SA_LIST.forEach((ele) async {
      _list.addAll(CardContents.fromJson(
        jsonDecode(await DefaultAssetBundle.of(context).loadString(
          '$basePath$ele.json'))).toList()
      );
    });
    
    return _list;
  }

  Widget textWidgetForSearch() {
    return TextField(
      onSubmitted: (value) { _filteringCard(value); },
      controller: _searchCardController,
    );
  }
}
