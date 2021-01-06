import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:state_notifier/state_notifier.dart';

// TODO: DeckFileHandlerと統合したい
class DeckListRepository extends StateNotifier<List<OwnedDeckInfo>> {
  DeckListRepository() : super([]);

  void addDeck(OwnedDeckInfo deck) {
    state = [...state, deck];
  }

  void deleteDeck(OwnedDeckInfo deck) {
    state = state.where((val) => val.deckId != deck.deckId).toList();
  }

  void exportResult(decks) => state = decks;

  void updateDeck(OwnedDeckInfo deck) {
    List<OwnedDeckInfo> decks = state;
    decks.remove(deck);
    state = decks;
  }
}
