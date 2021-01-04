import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:tuple/tuple.dart';

class DeckElementRepository
    extends StateNotifier<List<Tuple2<CardContent, int>>> {
  DeckElementRepository() : super([]);

  void exportResult(deckElements) => state = deckElements;
}
