import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tuple/tuple.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:ptcgb_flutter/handlers/deck_file_handler.dart';

class DeckCreator extends StatefulWidget {
  @override
  DeckCreatorState createState() => DeckCreatorState();
}

class DeckCreatorState extends State<DeckCreator> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18);
  final TextStyle _deckContentFont = TextStyle(fontSize: 11);
  double screenWidth;
  double customWidth;
  /// デッキの中身, [カード内容, 枚数を想定
  List<Tuple2<CardContent, int>> deckElementList;

  // TODO: 決め打ちではなく最新の弾を自動で読み込むようにしたい
  String _generation = 'sa';
  // FIXME: List<CardContent>にしたいがList<dynamic> ... のエラーが出る
  Future<List> baseCardList;
  List<CardContent> filteredCardList;

  String _type = 'sa';

  final double deckContentWidth = 120.0;

  TextEditingController editingController = TextEditingController();

  List<charts.Series> seriesList;

  @override
  void initState() {
    baseCardList = getAllCardInGeneration(context, _generation);
    deckElementList = [];
    super.initState();
  }

  /// ラジオボタンのGeneration用リセット関数
  void _handleGeneration(String e) => setState(() {_type = e;});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    customWidth = screenWidth * 0.2;

    seriesList = _createSampleData();

    // TODO: min, max 決めてRowに表示するカードの枚数を調整する
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Deck Creator'),
        actions: <Widget>[
          IconButton(
              // FIXME: save iconがフロッピーでダサい.
              icon: Icon(Icons.save),
              onPressed: (){_buildSaveDeck();}
          )
        ],
      ),
      body: Row(
          children: <Widget>[
            Expanded(child: Column(
              children: <Widget>[
                _buildSearchingCard(context),
                _buildSelectGeneration(context),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('カード検索結果')),
                Container(
                    child: _buildSearchedCard(context)
                ),
              ])
            ),
            Container(
              width: deckContentWidth,
              child: Column(
                children: <Widget>[
                  _buildDeckSummaryCharts(),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('デッキ: $deckContentNum枚')),
                  Container(
                      child: _buildDeckContents()
                  ),
              ])
            )
          ])
    );
  }
  
  /// 対象Generationのカードリスト全取得
  Future<List<CardContent>> getAllCardInGeneration(BuildContext context, String generation) async {
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
    _list.addAll(CardContents.fromJson(
      jsonDecode(await DefaultAssetBundle.of(context).loadString(
          '${basePath}708.json'))).toList()
    );
    _list.addAll(CardContents.fromJson(
        jsonDecode(await DefaultAssetBundle.of(context).loadString(
            '${basePath}709.json'))).toList()
    );
    _list.addAll(CardContents.fromJson(
        jsonDecode(await DefaultAssetBundle.of(context).loadString(
            '${basePath}710.json'))).toList()
    );

    return _list;
  }

  /// ラジオボタンがGenerationが選択されたときに、対象カードリストを全部読み込む
  /// その後SearchでFilterをかける
  Widget _buildSearchingCard(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {}, // 入力中から裏で検索回す場合に使用
              onSubmitted: (value) { _filteringCard(value); },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'card name here...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  )
              ),
            )
        )
    );
  }

  void _filteringCard(String searchStr) async {
    filteredCardList = [];
    filteredCardList = (await baseCardList).where(
            (val) => val.searchCardText(searchStr)
    ).toList();

    setState(() {});
  }

  // FIXME: assets/管理をやめないとダメそう
  Widget _buildSelectGeneration(context) {
    // TODO: generation config みたいなところから動的にリストを生成できると良い
    return Column(
        children: <Widget>[
          RadioListTile(
            // FIXME: Update generation image.
            secondary: Image.asset('assets/img/various/sample.png'),
            activeColor: Colors.amberAccent,
            title: Text("ソード&シールド"),
            value: 'sa',
            // FIXME: onChanged時の全カードリスト取得機能
//            onChanged: _handleGeneration,
            groupValue: _type,
          ),
          RadioListTile(
            // FIXME: Update generation image.
            secondary: Image.asset('assets/img/various/sample.png'),
            activeColor: Colors.amberAccent,
            title: Text("サン&ムーン"),
            value: 'sm',
            // FIXME: onChanged時の全カードリスト取得機能
//            onChanged: _handleGeneration,
            groupValue: _type,
          ),
        ]
    );
  }

  Widget _buildDeckSummaryCharts() {
    return Container(
        width: deckContentWidth,
        height: deckContentWidth,
        child: charts.BarChart(
          seriesList,
          animate: true,
          barGroupingType: charts.BarGroupingType.stacked,
        )
    );
  }

  Widget _buildSearchedCard(BuildContext context) {
    return Expanded(
        child: filteredCardList != null
            ? _buildFilteredCardList()
            : _buildFutureCardList(context)
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
          addDeckElement(content);
        },
        onLongPress: () {
          Navigator.of(context).pushNamed('/card_detail', arguments: content);
        },
      ),
    );
  }

  Image _cardImage(CardContent content) {
    return Image.asset(
      'assets/img/various/sample.png'
    );
  }

  Widget _buildDeckContents() {
    return Expanded(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: deckElementList.length,
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
//            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                decoration: new BoxDecoration(
                    border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
                child: ListTile(
                  title: Text(
                      '${deckElementList[index].item1.nameJp}×${deckElementList[index].item2}',
                      style: _deckContentFont),
                  onTap: () {
                    subDeckElement(index);
                  },
                  onLongPress: () {
                    addDeckElement(deckElementList[index].item1);
                  }
                ),
              );
            },
          )
        )
      );
  }

  // TODO: AlertDialogの実装でええんか？
  void _buildSaveDeck() {
    int deckLength = 0;
    deckElementList.forEach((element) => deckLength += element.item2);
//    if (deckLength != 60) {
//      alertRequire60CardsInDecks();
//      return;
//    }
    int topCardId = deckElementList[0].item1.cardId; // FIXME
    String deckName = 'テストデッキ';
    TextEditingController deckNameEditor = TextEditingController();
    Alert(
      context: context,
      type: AlertType.info,
      title: 'Save deck',
      content: Column(
        children: <Widget>[
          // TODO: タップしてアイコンにするカードを選択できるようにする
          // とりあえず先頭のカードIDを使う
          _buildPickTopCard(),
          TextField(
              onChanged: (value) => deckName = value,
              controller: deckNameEditor,
              decoration: InputDecoration(
                  labelText: 'Deck Name',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  )
              )),
        ],
      ),
      buttons: [
        DialogButton(
            child: Text('OK', style: TextStyle(color: Colors.white)),
            onPressed: () async => {
              await DeckFileHandler.saveDeckContentInfo(deckElementList, deckName, topCardId),
              Navigator.pop(context),
              Navigator.pop(context)
            }),
        DialogButton(
            child: Text('CANCEL', style: TextStyle(color: Colors.white70)),
            onPressed: () => Navigator.pop(context)),
      ],
      closeFunction: (){}
    ).show();
  }

  DropdownButton<String> _buildPickTopCard() {
    // TODO: https://makicamel.hatenablog.com/entry/2019/04/06/005255
    // TODO: Dialog系はStatelessなのでsetStateしても値が変わらない、customか別の路線か考える
    List<String> _items = ['aaaaa', 'bbbbb', 'ccccc']; // FIXME: テストデータ
    String _selectedItem = 'aaaaa';
    return DropdownButton<String>(
      value: _selectedItem,
      onChanged: (String val) {
        setState(() {
          _selectedItem = val;
        });
      },
      selectedItemBuilder: (context) {
        return _items.map((String item) {
          return Text('TopCard: $item', style: TextStyle(fontSize: 20));
        }).toList();
      },
      items: _items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: item == _selectedItem
                ? TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        );
      }).toList(),
    );
  }

  void addDeckElement(CardContent content) {
    // 80枚超えるなら追加しない
    if (deckContentNum + 1 > 80) {
      alertExceedDeckList();
    } else {
      int existsCardIndex = -1;
      for (int i = 0; i < deckElementList.length; i++) {
        if (deckElementList[i].item1.isTheSameEffectCard(content)) {
          existsCardIndex = i;
          break;
        }
      }

      // indexがなければ新規追加
      if (existsCardIndex == -1) {
        deckElementList.add(Tuple2(content, 1));
        sortDeckElement();
      } else {
        final Tuple2<CardContent, int> _target = deckElementList[existsCardIndex];
        if (_target.item2 >= 4) {
          alertExceedCardList();
        } else {
          // Tuple要素がfinalなのでList要素を置き換える
          deckElementList[existsCardIndex] = _target.withItem2(_target.item2 + 1);
        }
      }
      setState(() {});
    }
  }

  void subDeckElement(int index) {
    final Tuple2<CardContent, int> _target = deckElementList[index];
    // 減らす前が1枚ならListから削除
    if (_target.item2 == 1) {
      deckElementList.removeAt(index);
    } else {
      // Tuple要素がfinalなのでList要素を置き換える
      deckElementList[index] = _target.withItem2(_target.item2 - 1);
    }
    setState(() {});
  }

  // FIXME: 追加するカードの位置だけ探せれば良い、全部並びかえは無駄
  void sortDeckElement() {
    deckElementList.sort(
        (a, b) {
          int supertypeSort = a.item1.cardSupertype.index.compareTo(b.item1.cardSupertype.index);
          int subtypeSort = a.item1.cardSubtype.index.compareTo(b.item1.cardSupertype.index);
          if (supertypeSort != 0) {
            return supertypeSort;
          } else if (subtypeSort != 0){
            return subtypeSort;
          } else {
            return a.item1.nameJp.compareTo(b.item1.nameJp);
          }
        }
    );
  }

  int get deckContentNum {
    int _nums = 0;
    deckElementList.forEach((val) => _nums += val.item2);
    return _nums;
  }

  void alertExceedDeckList() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text('Exceed 80.'),
              content: Text('Please reduce the number of cards in the deck list first'),
              actions: <Widget>[
                FlatButton(child: Text('OK'), onPressed: () => Navigator.pop(context)),
              ]
          );
        }
    );
  }

  void alertExceedCardList() {
    Alert(
      context: context,
      type: AlertType.error,
      title: 'Exceed 4.',
      desc: 'Please reduce the number of cards first',
      buttons: [
        DialogButton(
          child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
      closeFunction: () {},
    ).show();
  }

  void alertRequire60CardsInDecks() {
    Alert(
      context: context,
      type: AlertType.error,
      title: 'Require 60 cards in the deck.',
      desc: 'Adjust cards properly.',
      buttons: [
        DialogButton(
          child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
      closeFunction: () {},
    ).show();
  }

  /// テストデータ
  /// TODO: 実際のデッキの中身で置き換える
  /// TODO: データ構造考える
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('P', 15),
      new OrdinalSales('T', 14),
      new OrdinalSales('E', 6),
    ];

    final tableSalesData = [
      new OrdinalSales('P', 7),
      new OrdinalSales('T', 10),
      new OrdinalSales('E', 8),
    ];

    final mobileSalesData = [
      new OrdinalSales('P', 3),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.supertype,
        measureFn: (OrdinalSales sales, _) => sales.cards,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.supertype,
        measureFn: (OrdinalSales sales, _) => sales.cards,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.supertype,
        measureFn: (OrdinalSales sales, _) => sales.cards,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String supertype;
  final int cards;

  OrdinalSales(this.supertype, this.cards);
}
