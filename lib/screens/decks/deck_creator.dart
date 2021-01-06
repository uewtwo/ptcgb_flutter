import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/decorations/decks/deck_creator_decorations.dart';
import 'package:ptcgb_flutter/enums/generations/generations.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:ptcgb_flutter/repositories/decks/deck_charts_repository.dart';
import 'package:ptcgb_flutter/repositories/decks/deck_element_repository.dart';
import 'package:ptcgb_flutter/repositories/commons/text_repository.dart';
import 'package:ptcgb_flutter/repositories/cards/filtered_card_repository.dart';
import 'package:ptcgb_flutter/screens/cards/card_detail.dart';
import 'package:ptcgb_flutter/screens/decks/decklists.dart';
import 'package:ptcgb_flutter/screens/home/home.dart';
import 'package:ptcgb_flutter/screens/widgets/deck_charts_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tuple/tuple.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:ptcgb_flutter/handlers/deck_file_handler.dart';

class DeckCreator extends HookWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final deco = DeckCreatorDecorations();

  final filteredGenCardProvider =
      StateNotifierProvider.autoDispose((ref) => FilteredCardRepository());
  final filteredSearchCardProvider =
      StateNotifierProvider.autoDispose((ref) => FilteredCardRepository());
  final deckElementsProvider =
      StateNotifierProvider.autoDispose((ref) => DeckElementRepository());
  final deckNameProvider =
      StateNotifierProvider.autoDispose((ref) => TextRepository(""));
  final baseGenerationProvider = StateNotifierProvider.autoDispose(
      (ref) => TextRepository(GenerationsEnum.values[0].name));

  static const routeName = '/deck_creator';
  static const TextStyle _biggerFont = TextStyle(fontSize: 18);
  static const TextStyle _deckContentFont = TextStyle(fontSize: 11);

  static const double deckContentWidth = 120.0;

  OwnedDeckInfo getDeckInfo(context) {
    return ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getScreenWidth(context);
    final double customWidth = getScreenWidth(context) * 0.2;

    // デッキ要素リスト
    final List<Tuple2<CardContent, int>> stateDeckElements =
        useProvider(deckElementsProvider.state);
    final deckElementsExporter = useProvider(deckElementsProvider);
    if (getDeckInfo(context) != null && stateDeckElements.length == 0) {
      DeckFileHandler.getDeckContent(getDeckInfo(context).deckId).then((value) {
        deckElementsExporter.exportResult(value.deckElements);
      });
    }

    // ジェネレーションテキスト
    final String stateGeneration = useProvider(baseGenerationProvider.state);
    final generationExporter = useProvider(baseGenerationProvider);

    // ジェネレーションベースの全カードリスト
    final List<CardContent> stateBaseCardList =
        useProvider(filteredGenCardProvider.state);
    final baseExporter = useProvider(filteredGenCardProvider);
    getAllCardInGeneration(baseExporter, stateGeneration);

    // サーチリスト
    final List<CardContent> stateFilteredCard =
        useProvider(filteredSearchCardProvider.state);
    final filteredExporter = useProvider(filteredSearchCardProvider);

    final int deckNums = deckContentNum(stateDeckElements);

    // TODO: min, max 決めてRowに表示するカードの枚数を調整する
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          title: Text(getDeckInfo(context) == null
              ? 'New Deck'
              : getDeckInfo(context).deckName),
          actions: <Widget>[
            IconButton(
              // FIXME: save iconがフロッピーでダサい.
              icon: Icon(Icons.save),
              onPressed: () {
                _buildSaveDeck(context, stateDeckElements);
              },
            ),
          ]),
      body: Row(children: <Widget>[
        Expanded(
          child: Column(children: <Widget>[
            _buildSearchingCard(filteredExporter, stateBaseCardList),
            _buildSelectGeneration(stateGeneration, generationExporter),
            Padding(padding: EdgeInsets.only(top: 10), child: Text('カード検索結果')),
            Container(
              child: _buildSearchedCard(stateDeckElements, deckElementsExporter,
                  stateBaseCardList, stateFilteredCard),
            ),
          ]),
        ),
        Container(
          width: deckContentWidth,
          child: Column(children: <Widget>[
            _buildDeckSummaryCharts(stateDeckElements),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('デッキ: $deckNums枚'),
              ),
              decoration: BoxDecoration(
                border: const Border(
                  bottom: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
            Container(
              child:
                  _buildDeckContents(stateDeckElements, deckElementsExporter),
            ),
          ]),
          decoration: BoxDecoration(
            border: const Border(
              left: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  /// 対象Generationのカードリスト全取得
  void getAllCardInGeneration(
      FilteredCardRepository exporter, String generation) async {
    final context = useContext();
//    FIXME: getApplicationDocumentsDirectory() とか使って
//    FIXME: カードリストjson管理しないとダメそう
//    FIXME: その上でファイルリストを取得して対象Genカード全リストを取得とか？
//    final Directory dir = Directory('/assets/text/cards/jp/$generation/');
//    final Directory dir = Directory.current;
//    final Future<List<FileSystemEntity>> fileLists = dirContents(dir);

    // TODO: テストデータ
    List<CardContent> _list = [];
    // FIXME: _typeがラジオボタンのgenを受け取るからそれを参照するようにする
//    final String basePath = 'assets/text/cards/jp/$generation/';
    final String basePath = 'assets/text/cards/jp/sa/';
    _list.addAll(CardContents.fromJson(jsonDecode(
            await DefaultAssetBundle.of(context)
                .loadString('${basePath}708.json')))
        .toList());
    _list.addAll(CardContents.fromJson(jsonDecode(
            await DefaultAssetBundle.of(context)
                .loadString('${basePath}709.json')))
        .toList());
    _list.addAll(CardContents.fromJson(jsonDecode(
            await DefaultAssetBundle.of(context)
                .loadString('${basePath}710.json')))
        .toList());

    exporter.exportResult(_list);
  }

  /// ラジオボタンがGenerationが選択されたときに、対象カードリストを全部読み込む
  /// その後SearchでFilterをかける
  Widget _buildSearchingCard(filteredExporter, stateBaseCardList) {
    return Container(
      height: 50,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          // onChanged: (value) {}, // 入力中から裏で検索回す場合に使用
          onSubmitted: (value) {
            _filteringCard(filteredExporter, value, stateBaseCardList);
          },
          // controller: TextEditingController(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            labelText: 'Search',
            hintText: 'card name here...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'.+')),
          ],
        ),
      ),
    );
  }

  void _filteringCard(
      exporter, String searchStr, List<CardContent> baseCardList) async {
    exporter.exportResult(
        baseCardList.where((val) => val.searchCardText(searchStr)).toList());
  }

  Widget _buildSelectGeneration(stateGeneration, generationExporter) {
    return DropdownButton<String>(
        items: GenerationsEnum.values.map((element) {
          return new DropdownMenuItem<String>(
            value: element.name,
            child: new Text(element.displayName),
          );
        }).toList(),
        onChanged: (_) => generationExporter.exportResult(_),
        value: stateGeneration);
  }

  Widget _buildDeckSummaryCharts(List<Tuple2<CardContent, int>> deckElements) {
    final DeckChartsWidget chartsWidget = DeckChartsWidget(deckElements);

    return Container(
      width: deckContentWidth,
      height: deckContentWidth,
      child: chartsWidget.barChart,
    );
  }

  Widget _buildSearchedCard(
      stateDeckElements,
      deckElementsExporter,
      List<CardContent> stateBaseCardList,
      List<CardContent> stateFilteredCardList) {
    return Expanded(
      child: stateFilteredCardList.length != 0
          ? _buildScrolledCardList(
              stateDeckElements, deckElementsExporter, stateFilteredCardList)
          : _buildScrolledCardList(
              stateDeckElements, deckElementsExporter, stateBaseCardList),
    );
  }

  Widget _buildScrolledCardList(
      stateDeckElements, deckElementsExporter, List<CardContent> cardList) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: cardList.length,
        padding: EdgeInsets.all(1.0),
        itemBuilder: (context, index) {
          return _cardItem(context, stateDeckElements, deckElementsExporter,
              cardList[index], index);
        },
      ),
    );
  }

  Widget _cardItem(context, stateDeckElements, deckElementsExporter,
      CardContent content, int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: _cardImage(content),
        title: Text(content.nameJp, style: _biggerFont),
        onTap: () {
          addDeckElement(
              context, stateDeckElements, deckElementsExporter, content);
        },
        onLongPress: () {
          Navigator.of(context)
              .pushNamed(CardDetail.routeName, arguments: content);
        },
      ),
    );
  }

  Image _cardImage(CardContent content) {
    return Image.asset('assets/img/various/sample.png');
  }

  Widget _buildDeckContents(stateDeckElements, deckElementsExporter) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: stateDeckElements.length,
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
//            physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey))),
              child: ListTile(
                title: Text(
                    '${stateDeckElements[index].item1.nameJp}×${stateDeckElements[index].item2}',
                    style: _deckContentFont),
                onTap: () {
                  subDeckElement(
                      stateDeckElements, deckElementsExporter, index);
                },
                onLongPress: () {
                  addDeckElement(context, stateDeckElements,
                      deckElementsExporter, stateDeckElements[index].item1);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _buildSaveDeck(
      context, List<Tuple2<CardContent, int>> stateDeckElements) {
    int deckLength = 0;
    stateDeckElements.forEach((element) => deckLength += element.item2);
    if (deckLength == 0) {
      alertRequireCardsInDecks(context);
      return;
    }
    // if (deckLength != 60) {
    //   alertRequireCardsInDecks(context);
    //   return;
    // }

    final OwnedDeckInfo ownedDeckInfo = getDeckInfo(context);
    int topCardId =
        ownedDeckInfo?.topCardId ?? stateDeckElements[0].item1.cardId;
    showDialog(
      context: context,
      builder: (_context) {
        // デッキ保存確認画面で状態が欲しかったので、とりあえずStatefulBuilderを使用
        String deckName = ownedDeckInfo?.deckName ?? "";
        TextEditingController deckTextEditor =
            TextEditingController(text: deckName);
        return StatefulBuilder(
          builder: (_context, setState) {
            return AlertDialog(
              title: Text(
                "Save Deck",
                style: TextStyle(color: Colors.black54, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Deck Top Card",
                          // textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                        ),
                      ),
                      DropdownButtonFormField<int>(
                        itemHeight: 50,
                        items: stateDeckElements.map((element) {
                          return new DropdownMenuItem<int>(
                            value: element.item1.cardId,
                            child: Container(
                              color: element.item1.cardId == topCardId
                                  ? Colors.white60
                                  : Colors.white,
                              child: Text(element.item1.nameJp),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {
                          setState(() {
                            topCardId = _;
                          });
                        },
                        value: topCardId,
                        hint: Text("Choose Top Card"),
                      ),
                    ]),
                    color: Colors.white60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Container(
                      child: TextField(
                        onSubmitted: (value) => setState(() {
                          deckName = value;
                        }),
                        onChanged: (value) => setState(() {
                          deckName = value;
                        }),
                        controller: deckTextEditor,
                        decoration: deco.enterDeckNameDecoration(),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.bottom,
                      ),
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                _buildSaveDeckOK(context, ownedDeckInfo, stateDeckElements,
                    deckName, topCardId),
                _buildSaveDeckCancel(context),
              ],
              scrollable: true,
            );
          },
        );
      },
    );
  }

  Widget _buildSaveDeckOK(context, ownedDeckInfo, stateDeckElements,
      String deckName, int topCardId) {
    return RaisedButton(
      child: Text('SAVE', style: TextStyle(color: Colors.white)),
      onPressed: deckName.isEmpty
          ? null
          : () async {
              getDeckInfo(context) == null
                  ? await DeckFileHandler.saveDeckContentInfo(
                      stateDeckElements, deckName, topCardId)
                  : await DeckFileHandler.overwriteDeckContentInfo(
                      stateDeckElements,
                      deckName,
                      topCardId,
                      ownedDeckInfo.deckId,
                      ownedDeckInfo.sortValue);
              // Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, Decklists.routeName,
                  ModalRoute.withName(Home.routeName));
              // TODO: エラーハンドリング
              // FIXME: navigationと一緒に snackbar出すやり方が分からん
              _displaySnackBar("$deckName: デッキを保存しました。");
            },
    );
  }

  void _displaySnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Widget _buildSaveDeckCancel(context) {
    return RaisedButton(
      child: Text('CANCEL', style: TextStyle(color: Colors.white)),
      onPressed: () => Navigator.pop(context),
    );
  }

  void addDeckElement(
      context, stateDeckElements, deckElementsExporter, CardContent content) {
    // 80枚超えるなら追加しない
    if (stateDeckElements.length + 1 > 80) {
      alertExceedDeckList(context);
    } else {
      int existsCardIndex = -1;
      for (int i = 0; i < stateDeckElements.length; i++) {
        if (stateDeckElements[i].item1.isTheSameEffectCard(content)) {
          existsCardIndex = i;
          break;
        }
      }
      List<Tuple2<CardContent, int>> _deckElements = stateDeckElements;

      // indexがなければ新規追加
      if (existsCardIndex == -1) {
        _deckElements.add(Tuple2(content, 1));
        deckElementsExporter.exportResult(_deckElements);
        sortDeckElement(stateDeckElements, deckElementsExporter);
      } else {
        final Tuple2<CardContent, int> _target =
            stateDeckElements[existsCardIndex];
        if (_target.item2 >= 4) {
          alertExceedCardList(context);
        } else {
          // Tuple要素がfinalなのでList要素を置き換える
          _deckElements[existsCardIndex] = _target.withItem2(_target.item2 + 1);
          deckElementsExporter.exportResult(_deckElements);
        }
      }
    }
  }

  void subDeckElement(stateDeckElements, deckElementsExporter, int index) {
    List<Tuple2<CardContent, int>> _ = stateDeckElements;
    final Tuple2<CardContent, int> _target = _[index];
    // 減らす前が1枚ならListから削除
    if (_target.item2 == 1) {
      _.removeAt(index);
      deckElementsExporter.exportResult(_);
    } else {
      // Tuple要素がfinalなのでList要素を置き換える
      _[index] = _target.withItem2(_target.item2 - 1);
      deckElementsExporter.exportResult(_);
    }
  }

  // FIXME: 追加するカードの位置だけ探せれば良い、全部並びかえは無駄
  void sortDeckElement(
      List<Tuple2<CardContent, int>> stateDeckElements, exporter) {
    List<Tuple2<CardContent, int>> _ = stateDeckElements;
    _.sort(
      (a, b) {
        int supertypeSort =
            a.item1.cardSupertype.index.compareTo(b.item1.cardSupertype.index);
        int subtypeSort =
            a.item1.cardSubtype.index.compareTo(b.item1.cardSupertype.index);
        if (supertypeSort != 0) {
          return supertypeSort;
        } else if (subtypeSort != 0) {
          return subtypeSort;
        } else {
          return a.item1.nameJp.compareTo(b.item1.nameJp);
        }
      },
    );
    exporter.exportResult(_);
  }

  int deckContentNum(stateDeckElements) {
    int _nums = 0;
    stateDeckElements.forEach((val) => _nums += val.item2);
    return _nums;
  }

  void alertExceedDeckList(context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text('Exceed 80.'),
              content: Text(
                  'Please reduce the number of cards in the deck list first'),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'), onPressed: () => Navigator.pop(context)),
              ]);
        });
  }

  void alertExceedCardList(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: 'Exceed 4.',
      desc: 'Please reduce the number of cards first',
      buttons: [
        DialogButton(
          child:
              Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
      closeFunction: () {},
    ).show();
  }

  void alertRequireCardsInDecks(context, {num = 0}) {
    Alert(
      context: context,
      type: AlertType.error,
      title: 'Require cards in the deck.',
      desc: 'Adjust cards properly.',
      buttons: [
        DialogButton(
          child:
              Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
      closeFunction: () {},
    ).show();
  }
}
