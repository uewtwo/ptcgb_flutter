import 'package:flutter/cupertino.dart';
import 'package:ptcgb_flutter/enums/navigators/bottom_navigation_event.dart';
import 'package:ptcgb_flutter/errors/system/app_route_not_found_exception.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';
import 'package:ptcgb_flutter/models/system/app_route_tree.dart';
import 'package:ptcgb_flutter/screens/app.dart';
import 'package:ptcgb_flutter/screens/cards/card_detail.dart';
import 'package:ptcgb_flutter/screens/cards/card_list.dart';
import 'package:ptcgb_flutter/screens/cards/search_cards.dart';
import 'package:ptcgb_flutter/screens/decks/deck_creator.dart';
import 'package:ptcgb_flutter/screens/decks/deck_display.dart';
import 'package:ptcgb_flutter/screens/decks/deck_lists.dart';
import 'package:ptcgb_flutter/screens/decks/deck_simulator.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';
import 'package:ptcgb_flutter/screens/generations/generations.dart';
import 'package:ptcgb_flutter/screens/home/home.dart';
import 'package:ptcgb_flutter/screens/information/official_info_webview.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get appRoutes {
    return {
      PtcgBuilderApp.routeName: (context) => PtcgBuilderApp(),
      OfficialInfoWebView.routeName: (context) => OfficialInfoWebView(context),
      Generations.routeName: (context) => Generations(),
      Expansions.routeName: (context) => Expansions(),
      CardList.routeName: (context) => CardList(),
      CardDetail.routeName: (context) => CardDetail(),
      Decklists.routeName: (context) => Decklists(context),
      DeckCreator.routeName: (context) => DeckCreator(),
      '/events': (context) => Home(),
      SearchCards.routeName: (context) => SearchCards(),
      '/search_events': (context) => Home(),
    };
  }

  // For historize tab navigator
  static const String root = Generations.routeName; // とりあえずカードリストをルートページとする
  static const String info = OfficialInfoWebView.routeName;
  static const String cards = Generations.routeName;
  static const String decks = Decklists.routeName;

  // Get page tree in each route.
  static AppRouteTree getPageTreeByPageModel(PageModel pageItem) {
    switch (pageItem.page) {
      case HistorizeNavigatorEvent.INFO:
        return infoRoutesTree;
      case HistorizeNavigatorEvent.CARDS:
        return cardRoutesTree;
      case HistorizeNavigatorEvent.DECKS:
        return deckRoutesTree;
      default:
        throw AppRouteNotFoundException();
    }
  }

  // Info系
  static AppRouteTree get infoRoutesTree {
    final Map<String, WidgetBuilder> routeTree = {
      // OfficialInfoWebView.routeName: (context) => OfficialInfoWebView(context),
      '/': (context) => OfficialInfoWebView(context),
    };
    final AppRouteTree appRouteTree =
        AppRouteTree(routePage: {info: routeTree[info]}, routeTree: routeTree);
    return appRouteTree;
  }

  // カードリスト系
  static AppRouteTree get cardRoutesTree {
    final Map<String, WidgetBuilder> routeTree = {
      // Generations.routeName: (context) => Generations(context),
      '/': (context) => Generations(),
      Expansions.routeName: (context) => Expansions(),
      CardList.routeName: (context) => CardList(),
      CardDetail.routeName: (context) => CardDetail(),
    };
    final AppRouteTree appRouteTree =
        AppRouteTree(routePage: {info: routeTree[cards]}, routeTree: routeTree);
    return appRouteTree;
  }

  // デッキリスト系
  static AppRouteTree get deckRoutesTree {
    final Map<String, WidgetBuilder> routeTree = {
      // Decklists.routeName: (context) => Decklists(context),
      '/': (context) => Decklists(context),
      DeckCreator.routeName: (context) => DeckCreator(),
      CardDetail.routeName: (context) => CardDetail(),
      DeckSimulator.routeName: (context) => DeckSimulator(),
      DeckDisplay.routeName: (context) => DeckDisplay(),
    };
    final AppRouteTree appRouteTree =
        AppRouteTree(routePage: {info: routeTree[decks]}, routeTree: routeTree);
    return appRouteTree;
  }
}
