import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:ptcgb_flutter/handlers/deck_file_handler.dart';
import 'package:ptcgb_flutter/repositories/decks/deck_list_repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'deck_creator.dart';

final deckListProvider =
    StateNotifierProvider.autoDispose((ref) => DeckListRepository());

class Decklists extends HookWidget {
  static const routeName = '/deck_lists';

  @override
  Widget build(BuildContext context) {
    final List<OwnedDeckInfo> stateDeckList =
        useProvider(deckListProvider.state);
    final decksProvider = useProvider(deckListProvider);
    getOwnedDeckInfoList(context, decksProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Decklists"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: null),
        ],
      ),
      body: _buildOwnedDecksList(context, stateDeckList, decksProvider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 新規作成は値を渡さない
          // TODO: null渡すの格好悪いし何か変えたい.
          Navigator.of(context)
              .pushNamed(DeckCreator.routeName, arguments: null);
        },
        child: Icon(Icons.playlist_add),
      ),
    );
  }

  Widget _buildOwnedDecksList(
      BuildContext context, stateDeckList, decksProvider) {
    final int displayNum = 3;
    final int itemCount = (stateDeckList.length / displayNum).ceil();
    return Scrollbar(
      child: ListView.builder(
        itemCount: itemCount,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final int deckListMax =
              stateDeckList.length; // minus index: zero start
          final displayRange =
              (int _index) => min(displayNum * _index, deckListMax - 1);
          // FIXME: 横にdisplayNum分表示していいか知りたいだけなのになんか複雑になった
          final rowNum = () {
            return 0 == ((deckListMax ~/ (displayNum * (index + 1))))
                ? deckListMax - (displayNum * index)
                : displayNum;
          };
          // FIXME: spaceEvenlyなので displayNumで割り切れない場合、表示位置がおかしくなる
          List<Widget> rowList = List.generate(rowNum(), (i) {
            final OwnedDeckInfo tarDeck =
                stateDeckList[displayRange(index) + i];
            return _buildDeckCard(context, tarDeck.deckName, tarDeck.topCardId,
                displayNum, tarDeck, decksProvider);
          });
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowList,
          );
        },
      ),
    );
  }

  void getOwnedDeckInfoList(context, decksProvider) async {
    decksProvider.exportResult((await DeckFileHandler.ownedDecksInfo).toList());
  }

  Widget _buildDeckCard(BuildContext context, String deckName, int cardId,
      int displayNum, OwnedDeckInfo deckInfo, decksProvider) {
    return Card(
      child: new InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DeckCreator.routeName, arguments: deckInfo);
        },
        onLongPress: () {
          alertDeleteDeck(context, deckInfo, decksProvider);
        },
        child: Container(
          // TODO: paddingとか適当に取ってるから表示+1を幅としてとる、適当なので直したい
          width: getScreenWidth(context) / (displayNum + 1),
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Stack(children: <Widget>[
                  Center(
                    child: Column(children: <Widget>[
                      Text(deckName, style: TextStyle(fontSize: 12)),
                      _deckImage(cardId),
                    ]),
                  )
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Image _deckImage(int cardId) {
    // FIXME: カードIDに対応したサムネ用の画像とか欲しい
    // FIXME: staticな外部関数にしたい、サムネ画像使うのは使用ケースかなりある
    final String defaultTargetPath = 'assets/img/various/sample.png';
    return Image.asset(defaultTargetPath);
  }

  void alertDeleteDeck(
      BuildContext context, OwnedDeckInfo deckInfo, decksProvider) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'Delete decks.',
      desc: 'Deleting ${deckInfo.deckName} deck, are you OK?',
      buttons: [
        DialogButton(
          child:
              Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => {
            DeckFileHandler.deleteDeckContentInfo(deckInfo),
            decksProvider.deleteDeck(deckInfo),
            Navigator.pop(context),
          },
        ),
        DialogButton(
            child: Text('CANCEL', style: TextStyle(color: Colors.white70)),
            onPressed: () => Navigator.pop(context)),
      ],
      closeFunction: () {},
    ).show();
  }
}
