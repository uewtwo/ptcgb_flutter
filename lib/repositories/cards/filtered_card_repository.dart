import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:state_notifier/state_notifier.dart';

class FilteredCardRepository extends StateNotifier<List<CardContent>> {
  FilteredCardRepository() : super([]);

  void exportResult(filteringCardList) => state = filteringCardList;
}
