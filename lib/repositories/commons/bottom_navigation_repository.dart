import 'package:hooks_riverpod/all.dart';
import 'package:ptcgb_flutter/enums/common/bottom_navigation_event.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';

class BottomNavigationRepository extends StateNotifier<PageModel> {
  BottomNavigationRepository() : super(defaultPage);

  static const defaultPage = PageModel(BottomNavigationEvent.INFO);

  void selectPage(int i) {
    switch (i) {
      case 0:
        state = PageModel(BottomNavigationEvent.INFO);
        break;
      case 1:
        state = PageModel(BottomNavigationEvent.CARDS);
        break;
      case 2:
        state = PageModel(BottomNavigationEvent.DECKS);
        break;
    }
  }
}
