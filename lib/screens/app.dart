import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ptcgb_flutter/enums/navigators/bottom_navigation_event.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';
import 'package:ptcgb_flutter/repositories/navigators/historize_navigator_repository.dart';
import 'package:ptcgb_flutter/screens/widgets/navigators/bottom_navigation.dart';
import 'package:ptcgb_flutter/screens/widgets/navigators/historize_navigator.dart';

class PtcgBuilderApp extends HookWidget {
  static const String routeName = '/home';

  static const PageModel mainPage = PageModel(HistorizeNavigatorEvent.CARDS);

  final provider = StateNotifierProvider.autoDispose(
      (ref) => HistorizeNavigatorRepository(defaultPage: mainPage));

  // bottom navigation bar item
  final _navigatorKeys = {
    HistorizeNavigatorEvent.INFO: GlobalKey<NavigatorState>(),
    HistorizeNavigatorEvent.CARDS: GlobalKey<NavigatorState>(),
    HistorizeNavigatorEvent.DECKS: GlobalKey<NavigatorState>(),
  };

  void _selectPage(
      PageModel currentPage, PageModel selectPage, BuildContext context) {
    if (currentPage == selectPage) {
      // 今いるTabだから、 pop to first route
      _navigatorKeys[selectPage.page]
          .currentState
          .popUntil((route) => route.isFirst);
    } else {
      context.read(provider).selectPage(selectPage.page.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageModel currentPage = useProvider(provider.state);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentPage =
            !await _navigatorKeys[currentPage.page].currentState.maybePop();
        if (isFirstRouteInCurrentPage) {
          // if not on the 'main' page
          if (currentPage != mainPage) {
            // select 'main' page
            _selectPage(currentPage, mainPage, context);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentPage;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(
                currentPage, PageModel(HistorizeNavigatorEvent.INFO)),
            _buildOffstageNavigator(
                currentPage, PageModel(HistorizeNavigatorEvent.CARDS)),
            _buildOffstageNavigator(
                currentPage, PageModel(HistorizeNavigatorEvent.DECKS)),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentPage: currentPage,
          onSelectPage: (index) => context.read(provider).selectPage(index),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(PageModel currentPage, PageModel navPage) {
    return Offstage(
      offstage: currentPage.page != navPage.page,
      child: HistorizeNavigator(
        navigatorKey: _navigatorKeys[navPage.page],
        pageItem: navPage,
      ),
    );
  }

  // Future<bool> _onBackKeyAndroid(PageModel pageModel) async {
  //   if (Platform.isAndroid) {
  //     switch (pageModel.page) {
  //       case HistorizeNavigatorEvent.INFO:
  //         if (tabInfo.currentState.canPop()) {
  //           return !await tabInfo.currentState.maybePop();
  //         }
  //         break;
  //       case HistorizeNavigatorEvent.CARDS:
  //         if (tabCard.currentState.canPop()) {
  //           return !await tabCard.currentState.maybePop();
  //         }
  //         break;
  //       case HistorizeNavigatorEvent.DECKS:
  //         if (tabDeck.currentState.canPop()) {
  //           return !await tabDeck.currentState.maybePop();
  //         }
  //         break;
  //     }
  //   }
  //   return Future.value(true);
  // }
}
