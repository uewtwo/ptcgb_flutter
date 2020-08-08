import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:ptcgb_flutter/handlers/deck_file_handler.dart';
import 'package:ptcgb_flutter/screens/home/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'deck_creator.dart';

class Decklists extends StatelessWidget {
  static const routeName = '/deck_lists';

  @override
  Widget build(BuildContext context) {
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
            // 新規作成は値を渡さない
            // TODO: null渡すの格好悪いし何か変えたい.
            Navigator.of(context).pushNamed(DeckCreator.routeName, arguments: null);
          },
          child: Icon(Icons.playlist_add),
        )
    );
  }

  Widget _buildDecklists(BuildContext context) {
    return FutureBuilder(
        future: getOwnedDeckInfoList(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _buildOwnedDecksList(context, snapshot);
        }
    );
  }

  Widget _buildOwnedDecksList(BuildContext context, AsyncSnapshot snapshot) {
    // TODO: 画面サイズに応じて動的にRowに表示するDeck数を変更したい
    // TODO: もしくは1Deckの情報量を増やす
    final int displayNum = 3;
    if (snapshot.connectionState != ConnectionState.done) {
      return Container(
          padding: EdgeInsets.all(10.0), child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Container(
          padding: EdgeInsets.all(10.0),
          child: Text(snapshot.error.toString()));
    } else if (snapshot.hasData) {
      return _buildRowDeckCard(context, snapshot.data, displayNum);
    } else {
      return Text('No Data.');
    }
  }

  Future<List<OwnedDeckInfo>> getOwnedDeckInfoList(context) async {
    try {
      return (await DeckFileHandler.ownedDecksInfo).toList();
    } catch(e) {
      throw e;
    }
  }

  // FIXME: 1行分の deck info を受け取るようにする
  // TODO: 端数がでたときの調整
  Widget _buildRowDeckCard(
      BuildContext context, List<OwnedDeckInfo> decksInfo, int displayNum) {
    final int itemCount = (decksInfo.length / displayNum).ceil();
    return Scrollbar(
        child: ListView.builder(
          itemCount: itemCount,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final int deckListMax = decksInfo.length; // minus index: zero start
            final displayRange = (int _index) => min(displayNum * _index, deckListMax - 1);
            // FIXME: 横にdisplayNum分表示していいか知りたいだけなのになんか複雑になった
            final rowNum = () {
              return 0 == ((deckListMax ~/ (displayNum*(index + 1))))
                  ? deckListMax - (displayNum * index)
                  : displayNum;
            };
            // FIXME: spaceEvenlyなので displayNumで割り切れない場合、表示位置がおかしくなる
            List<Widget> rowList = List.generate(rowNum(), (i) {
              final OwnedDeckInfo tarDeck = decksInfo[displayRange(index) + i];
              return _buildDeckCard(context, tarDeck.deckName,
                  tarDeck.topCardId, displayNum, tarDeck);
            });
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: rowList,
            );
          },
        )
    );
  }

  Widget _buildDeckCard(BuildContext context, String deckName,
      int cardId, int displayNum, OwnedDeckInfo deckInfo) {
    return Card(
        child: new InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(DeckCreator.routeName, arguments: deckInfo);
            },
            onLongPress: () {
              alertExceedCardList(context, deckInfo);
            },
            child: Container(
              // TODO: paddingとか適当に取ってるから表示+1を幅としてとる、適当なので直したい
              width: screenWidth(context) / (displayNum+1),
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Stack(children: <Widget>[
                      Center(
                        child: Column(children: <Widget>[
                          Text(deckName),
                          _deckImage(cardId),
                        ]),
                      )
                    ]),
                  )
                ]),
              ),
            )
        )
    );
  }

  Image _deckImage(int cardId) {
    // FIXME: カードIDに対応したサムネ用の画像とか欲しい
    // FIXME: staticな外部関数にしたい、サムネ画像使うのは使用ケースかなりある
    final String defaultTargetPath = 'assets/img/various/sample.png';
    return Image.asset(defaultTargetPath);
  }

  void alertExceedCardList(BuildContext context, OwnedDeckInfo deckInfo) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'Delete decks.',
      desc: 'Deleting ${deckInfo.deckName} deck, are you OK?',
      buttons: [
        DialogButton(
          child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => {
            DeckFileHandler.deleteDeckContentInfo(deckInfo),
            Navigator.pop(context),
            // statelessだがデッキリスト更新したいためpopではなくpush
            Navigator.pushNamedAndRemoveUntil(
            context, Decklists.routeName, ModalRoute.withName(Home.routeName)),
          }
        ),
        DialogButton(
            child: Text('CANCEL', style: TextStyle(color: Colors.white70)),
            onPressed: () => Navigator.pop(context)),
      ],
      closeFunction: () {},
    ).show();
  }
}

