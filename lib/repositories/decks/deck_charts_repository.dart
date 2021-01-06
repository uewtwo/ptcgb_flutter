import 'package:ptcgb_flutter/screens/decks/deck_creator.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DeckChartsRepository extends StateNotifier {
  DeckChartsRepository(_) : super(_);

  void exportResult(charts) => state = charts;
}
