import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/enums/navigators/bottom_navigation_event.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentPage, @required this.onSelectPage});
  final PageModel currentPage;
  final ValueChanged<int> onSelectPage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.blue,
      currentIndex: currentPage.page.index,
      onTap: (index) => onSelectPage(index),
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/img/various/info_icon.png'),
            color: Colors.black,
          ),
          label: 'Info',
          backgroundColor:
              currentPage.page.index == HistorizeNavigatorEvent.INFO.index
                  ? Colors.white54
                  : Colors.white,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/img/various/card_icon.png'),
            color: Colors.black,
          ),
          label: 'Cards',
          backgroundColor:
              currentPage.page.index == HistorizeNavigatorEvent.CARDS.index
                  ? Colors.white54
                  : Colors.white,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/img/various/deck_icon.png'),
            color: Colors.black,
          ),
          label: 'Decks',
          backgroundColor:
              currentPage.page.index == HistorizeNavigatorEvent.DECKS.index
                  ? Colors.white54
                  : Colors.white,
        ),
      ],
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
