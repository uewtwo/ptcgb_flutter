import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:ptcgb_flutter/enums/navigators/bottom_navigation_event.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';

class HistorizeNavigatorRepository extends StateNotifier<PageModel> {
  HistorizeNavigatorRepository({@required this.defaultPage})
      : super(defaultPage);

  final PageModel defaultPage;

  void selectPage(int i) {
    switch (i) {
      case 0:
        state = PageModel(HistorizeNavigatorEvent.INFO);
        break;
      case 1:
        state = PageModel(HistorizeNavigatorEvent.CARDS);
        break;
      case 2:
        state = PageModel(HistorizeNavigatorEvent.DECKS);
        break;
    }
  }
}
