import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:ptcgb_flutter/models/expansion/expansion_contents.dart';

class CardList extends StatelessWidget {
  final TextStyle _biggerFont = TextStyle(fontSize: 14.0);

  @override
  Widget build(BuildContext context) {
    final ExpansionContent expansionContent =
        ModalRoute.of(context).settings.arguments;
    final String genDisplay = getGenerationDisplayName(
        expansionContent.generation).replaceFirst('＆', '&');
    final String titleText = expansionContent.name
        .replaceAll(RegExp('$genDisplay'), '')
        .replaceAll(RegExp(r'強化拡張パック'), '')
        .replaceAll(RegExp(r'拡張パック'), '')
        .replaceAll(RegExp(r'ハイクラスパック'), '')
        .replaceAll(RegExp(r'「'), '')
        .replaceAll(RegExp(r'」'), '')
        .replaceAll(RegExp(r'　'), '\n')
        .replaceFirst(RegExp(r' '), '')
    ;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(titleText, maxLines: 2),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.list), onPressed: null),
            ]),
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Center(
                  child: FutureBuilder(
                    future: getCardListByExpansion(context, expansionContent),
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
            padding: EdgeInsets.all(16.0),
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
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
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
    final String defaultTargetPath = 'assets/img/various/sample.png';
    final String targetPath = 'assets/img/cards/jp/${content.generation.toLowerCase()}/${content.productNo}/${content.cardId}.png';
    try {
      // FIXME: 非同期処理だからか try-catch で画像がないときにdefaultTargetPathをみてくれない
//      return Image.asset(targetPath);
      return Image.asset(defaultTargetPath);
    } catch (e) {
      return Image.asset(defaultTargetPath);
    }
  }

  Future<List<CardContent>> getCardListByExpansion(
      BuildContext context, ExpansionContent content) async {
    final String gen = content.generation;
    final String productNo = content.productNo;
    final String jsonPath = 'assets/text/cards/jp/$gen/$productNo.json';
    final List<dynamic> jsonRes =
        jsonDecode(await DefaultAssetBundle.of(context).loadString(jsonPath));
    final List<CardContent> _cardList =
        CardContents.fromJson(jsonRes).toList();
    return _cardList;
  }
}
