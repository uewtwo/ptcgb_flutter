import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './deck_creator.dart';

class Decklists extends StatefulWidget {
  @override
  DecklistsState createState() => DecklistsState();
}

class DecklistsState extends State<Decklists> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18);
  double screenWidth;
  double customWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    customWidth = screenWidth * 0.2;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Decklists"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: null),
        ],
      ),
      body: _buildDecklists(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/deck_creator');
        },
        child: Icon(Icons.playlist_add),
      )
    );
  }

  Widget _buildDecklists(BuildContext context) {

    // TODO: 画面サイズに応じて動的にRowに表示するDeck数を変更したい
    // TODO: もしくは1Deckの情報量を増やす
    // FIXME: 初回はとりえあえず3列で
    final int displayNum = 3;
    // TODO: ユーザプロファイルを作成して、[デッキ]からデータを取得するようにしたい。
    final int cardId = 1000;
    /**
     * イメージは、ユーザデックオブジェクトのリストを取得する感じ
     */
    final int userDecks = 23;

    return Scrollbar(
      child: ListView.builder(
        itemCount: (userDecks / displayNum).ceil(),
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return _buildRowDeckCard(context, index, cardId, displayNum);
        },
      )
    );
  }

  // FIXME: 1行分の deck info を受け取るようにする
  // TODO: 端数がでたときの調整
  Widget _buildRowDeckCard(
      BuildContext context, int index, int cardId, int displayNum) {
    // TODO: displayNum を switch で分岐するのいけてない、動的に変えたい
    switch (displayNum) {
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDeckCard(context, (displayNum * index)+1, cardId, displayNum),
            _buildDeckCard(context, (displayNum * index)+2, cardId, displayNum),
            _buildDeckCard(context, (displayNum * index)+3, cardId, displayNum)
          ],
        );
      default:
        throw Error();
    }
  }

  Widget _buildDeckCard(
      BuildContext context, int deckIndex, int cardId, int displayNum) {
    return Card(
      child: Container(
        // TODO: paddingとか適当に取ってるから表示+1を幅としてとる、適当なので直したい
        width: screenWidth / (displayNum+1),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Stack(children: <Widget>[
                Center(
                  child: Column(children: <Widget>[
                    Text('Deck $deckIndex'),
                    _deckImage(cardId),
                  ]),
                )
              ]),
            )
          ]),
        ),
      )
    );
  }

  Image _deckImage(int cardId) {
    // TODO: カードIDに対応したサムネ用の画像とか欲しい
    final String defaultTargetPath = 'assets/img/various/sample.png';
    return Image.asset(defaultTargetPath);
  }
}
