import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:ptcgb_flutter/models/expansion/expansion_contents.dart';

class CardList extends StatelessWidget {
  final TextStyle _biggerFont = TextStyle(fontSize: 14.0);

  @override
  Widget build(BuildContext context) {
    final ExpansionContent expansionContent =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
            title: Text(expansionContent.name, maxLines: 2),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.list), onPressed: null),
            ]),
        body: Container(
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {},
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  )),
              Expanded(
                child: Center(
                  child: FutureBuilder(
                    future: this.getCardListByExpansion(context, expansionContent),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return _buildCardList(context, snapshot);
                    },
                  ),
                ),
              )
            ])));
  }

  Widget _buildCardList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Container(
          padding: EdgeInsets.all(10.0), child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      //      throw snapshot.error;
      return Container(
          padding: EdgeInsets.all(10.0),
          child: Text(snapshot.error.toString()));
    } else if (snapshot.hasData) {
      final List<CardContent> cardList = snapshot.data;
      return Scrollbar(
        child: ListView.builder(
            itemCount: cardList.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return _cardItem(context, cardList[index], index);
            }),
      );
    } else {
      return Text('No Data.');
    }
  }

  Widget _cardItem(BuildContext context, CardContent content, int index) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: _cardImage(content),
        title: Text(content.nameJp, style: _biggerFont),
        onTap: () {
          Navigator.of(context).pushNamed('/card_detail', arguments: content);
        },
      ),
    );
  }

  Image _cardImage(CardContent content) {
    // TODO: 個別のカードの画像用意
    // TODO: 画像について個別にダウンロードボタンを用意して、画像がなければsampleを利用するようにしたい。
    // とりあえ試しにhttp通信で取得するようにしてみる？
    final String defaultTargetPath = 'assets/img/various/sample.png';
    //    final String targetPath = 'assets/img/cards/jp/${content.generation.toLowerCase()}/${content.setCode.toLowerCase()}.png';
    try {
      return Image.asset(defaultTargetPath);
    } catch (e) {
      return Image.asset(defaultTargetPath);
    }
  }

  Future<List<CardContent>> getCardListByExpansion(
      BuildContext context, ExpansionContent content) async {
    final String gen = content.generation;
    final String name = content.name;
    final String jsonPath = 'assets/text/cards/jp/$gen/$name.json';
    final List<dynamic> jsonRes =
        jsonDecode(await DefaultAssetBundle.of(context).loadString(jsonPath));
    final List<CardContent> _cardList =
        CardContents.fromJson(jsonRes).getCardContentList();
    return _cardList;
  }
}
