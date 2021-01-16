import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:ptcgb_flutter/handlers/deck_file_handler.dart';
import 'package:ptcgb_flutter/repositories/decks/deck_list_repository.dart';
import 'package:ptcgb_flutter/screens/decks/deck_simulator.dart';
import 'package:share/share.dart';
import 'deck_creator.dart';

final deckListProvider =
    StateNotifierProvider.autoDispose((ref) => DeckListRepository());

// TODO: 遷移先からの戻り値が適当すぎるので deckCreator 用戻り値のクラスを定義したい
class Decklists extends HookWidget {
  static const routeName = '/deck/deck_lists';

  @override
  Widget build(BuildContext context) {
    // 遷移先から戻ってきた場合はSnackbarで表示する
    if (ModalRoute.of(context).settings.arguments == 'saved') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('保存しました！'),
          duration: Duration(seconds: 1),
          action: SnackBarAction(
            label: 'DeckCreator',
            onPressed: () {},
          ),
        ),
      );
    }

    final List<OwnedDeckInfo> stateDeckList =
        useProvider(deckListProvider.state);
    final DeckListRepository decksProvider = useProvider(deckListProvider);
    getOwnedDeckInfoList(decksProvider);

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
        onPressed: () async {
          // 新規作成は値を渡さない
          Navigator.of(context).pushNamed(DeckCreator.routeName);
        },
        child: Icon(Icons.playlist_add),
      ),
    );
  }

  Widget _buildOwnedDecksList(
      BuildContext context, stateDeckList, DeckListRepository decksProvider) {
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

  void getOwnedDeckInfoList(decksProvider) async {
    decksProvider.exportResult((await DeckFileHandler.ownedDecksInfo).toList());
  }

  Widget _buildDeckCard(
      BuildContext context,
      String deckName,
      int cardId,
      int displayNum,
      OwnedDeckInfo deckInfo,
      DeckListRepository decksProvider) {
    return Card(
      child: new InkWell(
        onTap: () async {
          Navigator.of(context)
              .pushNamed(DeckCreator.routeName, arguments: deckInfo);
        },
        onLongPress: () {
          popDeckMenu(context, deckInfo, decksProvider);
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
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          deckName,
                          maxLines: 1,
                        ),
                      ),
                      _deckImage(cardId),
                    ]),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _deckImage(int cardId) {
    // FIXME: カードIDに対応したサムネ用の画像とか欲しい
    // FIXME: staticな外部関数にしたい、サムネ画像使うのは使用ケースかなりある
    final String defaultTargetPath = 'assets/img/various/sample.png';
    return Image.asset(defaultTargetPath);
  }

  Future<void> popDeckMenu(BuildContext context, OwnedDeckInfo deckInfo,
      DeckListRepository decksProvider) async {
    final String route = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 1000, 0, 0),
      items: <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          enabled: false,
          value: DeckCreator.routeName,
          child: ListTile(
            leading: Icon(Icons.list_alt_sharp),
            title: Text('一覧'),
          ),
        ),
        PopupMenuItem<String>(
          value: DeckCreator.routeName,
          child: ListTile(
            leading: Icon(Icons.edit_sharp),
            title: Text('編集'),
          ),
        ),
        PopupMenuItem<String>(
          value: DeckSimulator.routeName,
          child: ListTile(
            leading: Icon(Icons.play_arrow_outlined),
            title: Text('シミュレーター'),
          ),
        ),
        PopupMenuItem<String>(
          enabled: false,
          value: '/cmd:share',
          child: ListTile(
            leading: Icon(Icons.share_sharp),
            title: Text('Share'),
          ),
        ),
        PopupMenuItem<String>(
          value: '/cmd:delete',
          child: ListTile(
            leading: Icon(Icons.delete_sharp),
            title: Text('削除'),
          ),
        ),
      ],
    );

    // 画面遷移先に合わせて呼ぶ.
    // 画面遷移がないものはマジックワードで対応
    // コマンド系マジックワードが増えてきそうならEnumにまとめる
    switch (route) {
      case DeckCreator.routeName:
        Navigator.of(context)
            .pushNamed(DeckCreator.routeName, arguments: deckInfo);
        break;
      case DeckSimulator.routeName:
        Navigator.of(context).pushNamed(route, arguments: deckInfo);
        break;
      case '/cmd:share':
        Share.share(
            // TODO: デッキ内容シェアの内容
            // 例えば全部の画像をくっつけたデッキ画像や、アプリのDLリンクとかそういうのが欲しい
            'FIXME!!');
        break;
      case '/cmd:delete':
        DeckFileHandler.deleteDeckContentInfo(deckInfo);
        decksProvider.deleteDeck(deckInfo);
        break;
      default:
        break;
    }
  }
}
