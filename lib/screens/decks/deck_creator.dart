import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DeckCreator extends StatefulWidget {
  @override
  DeckCreatorState createState() => DeckCreatorState();
}

class DeckCreatorState extends State<DeckCreator> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18);
  double screenWidth;
  double customWidth;
  List deckElements; // デッキリストの元、オブジェクト化して画像とかを用意したい

  TextEditingController editingController = TextEditingController();

  List<charts.Series> seriesList = _createSampleData();

  // テストデータ
  var listItem = ["o","t","h","o","t","h","o","t","h","o","t","h","o","t","h",];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    customWidth = screenWidth * 0.2;
    // TODO: min, max 決めてRowに表示するカードの枚数を調整する

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Deck Creator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: null),
        ],
      ),
      body: Row(
          children: <Widget>[
            Expanded(child: Column(
                    children: <Widget>[
                      _buildSearchingCard(context),
                      Text('カード検索結果'),
                      Container(
                          height: 600,
                          child: _buildDeckContents()
                      ),
                    ],
                  )
            ),
            Expanded(child: Column(
              children: <Widget>[
                _buildDeckSummaryCharts(),
                Text('デッキの中身'),
                Container(
//                    width: 100,
                    height: 450,
                    child: _buildDeckContents()
                ),
            ]))
          ])
//      body: Row(
//        children: <Widget>[
//          Container(
//            child: Expanded(child: Column(
//              children: <Widget>[
//                _buildSearchingCard(context),
//              ],
//            )),
//          ),
//          Column(
////            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              _buildDeckSummaryCharts(),
//              _buildDeckContents(),
//            ],
//          )
//        ],
//      ),
    );
  }

  Widget _buildSearchingCard(BuildContext context) {
    return Container(
        height: 70,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {}, // 入力中から裏で検索回す場合に使用
              onSubmitted: (value) {
                // TODO: resultAPIに投げるかローカルのJSONに検索かける
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'card name here...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  )
              ),
            )
        )
    );
  }


  Widget _buildDeckSummaryCharts() {
    return Container(
//                FIXME: 適当にサイズを決め打ちしてる、レイアウトから考える
        width: 200,
        height: 200,
        child: charts.BarChart(
          seriesList,
          animate: true,
          barGroupingType: charts.BarGroupingType.stacked,
        )
    );
  }

  Widget _buildDeckContents() {
    return Expanded(child: ListView.builder(
        itemCount: 100,
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
//        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: new BoxDecoration(
                border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            child: ListTile(
              title: Text('$index番目', style: _biggerFont),
              onTap: () {},
            ),
          );
        },
      ));
  }

  /// テストデータ
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('Pok', 15),
      new OrdinalSales('Tra', 14),
      new OrdinalSales('Ene', 6),
    ];

    final tableSalesData = [
      new OrdinalSales('Pok', 7),
      new OrdinalSales('Tra', 10),
      new OrdinalSales('Ene', 8),
    ];

    final mobileSalesData = [
      new OrdinalSales('Pok', 3),
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
