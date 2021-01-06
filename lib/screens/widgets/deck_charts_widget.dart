import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ptcgb_flutter/enums/cards/card_supertype.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:tuple/tuple.dart';

// TODO: 全体的に構造化して外だししたい
// TODO: card subtypeに寄っても分けたい（気がする）
class DeckChartsWidget {
  List<SupertypeChartData> chartData = [
    SupertypeChartData('ポケ', 0),
    SupertypeChartData('トレ', 0),
    SupertypeChartData('エネ', 0),
  ];

  DeckChartsWidget(List<Tuple2<CardContent, int>> deckContents) {
    deckContents.forEach((element) {
      switch (element.item1.cardSupertype) {
        case CardSupertypeEnum.POKEMON:
          chartData[0].add(element.item2);
          break;
        case CardSupertypeEnum.TRAINER:
          chartData[1].add(element.item2);
          break;
        case CardSupertypeEnum.ENERGY:
          chartData[2].add(element.item2);
          break;
      }
    });
  }

  charts.BarChart get barChart {
    return charts.BarChart(
      [
        charts.Series<SupertypeChartData, String>(
          id: 'decks',
          domainFn: (SupertypeChartData data, _) => data.supertype,
          measureFn: (SupertypeChartData data, _) => data.num,
          data: chartData,
        ),
      ],
      animate: false,
    );
  }
}

class SupertypeChartData {
  final String supertype;
  int num;

  SupertypeChartData(this.supertype, this.num);

  add(int x) {
    num += x;
  }

  sub(int x) {
    num -= x;
  }
}
