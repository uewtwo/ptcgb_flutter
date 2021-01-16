import 'package:flutter/cupertino.dart';
import 'package:ptcgb_flutter/screens/cards/card_detail.dart';
import 'package:ptcgb_flutter/screens/cards/card_list.dart';
import 'package:ptcgb_flutter/screens/cards/search_cards.dart';
import 'package:ptcgb_flutter/screens/decks/deck_creator.dart';
import 'package:ptcgb_flutter/screens/decks/decklists.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';
import 'package:ptcgb_flutter/screens/generations/generations.dart';
import 'package:ptcgb_flutter/screens/home/home.dart';
import 'package:ptcgb_flutter/screens/information/official_info_webview.dart';

Map<String, WidgetBuilder> get appRouteList {
  return {
    Home.routeName: (BuildContext context) => Home(),
    OfficialInfoWebView.routeName: (BuildContext context) =>
        OfficialInfoWebView(),
    Generations.routeName: (BuildContext context) => Generations(),
    Expansions.routeName: (BuildContext context) => Expansions(),
    CardList.routeName: (BuildContext context) => CardList(),
    CardDetail.routeName: (BuildContext context) => CardDetail(),
    Decklists.routeName: (BuildContext context) => Decklists(),
    DeckCreator.routeName: (BuildContext context) => DeckCreator(),
    '/events': (BuildContext context) => Home(),
    SearchCards.routeName: (BuildContext context) => SearchCards(),
    '/search_events': (BuildContext context) => Home(),
  };
}
