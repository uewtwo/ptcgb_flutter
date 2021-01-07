import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ptcgb_flutter/enums/common/bottom_navigation_event.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';
import 'package:ptcgb_flutter/repositories/commons/bottom_navigation_repository.dart';
import 'package:ptcgb_flutter/screens/decks/decklists.dart';
import 'package:ptcgb_flutter/screens/generations/generations.dart';
import 'package:ptcgb_flutter/screens/information/official_info_webview.dart';

final provider =
    StateNotifierProvider.autoDispose((ref) => BottomNavigationRepository());

class BottomNavBar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final PageModel pageModel = useProvider(provider.state);

    Widget body;
    switch (pageModel.page) {
      case BottomNavigationEvent.INFO:
        body = OfficialInfoWebView();
        break;
      case BottomNavigationEvent.CARDS:
        body = Generations();
        break;
      case BottomNavigationEvent.DECKS:
        body = Decklists();
        break;
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        currentIndex: pageModel.page.index,
        onTap: (index) => context.read(provider).selectPage(index),
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/img/various/info_icon.png'),
              color: Colors.black,
            ),
            label: 'Info',
            backgroundColor:
                pageModel.page.index == BottomNavigationEvent.INFO.index
                    ? Colors.white54
                    : Colors.white,
          ),
          // BottomNavigationBarItem(
          //   icon: ImageIcon(
          //     AssetImage('assets/img/various/home_icon.png'),
          //     color: Colors.black,
          //   ),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/img/various/card_icon.png'),
              color: Colors.black,
            ),
            label: 'Cards',
            backgroundColor:
                pageModel.page.index == BottomNavigationEvent.CARDS.index
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
                pageModel.page.index == BottomNavigationEvent.DECKS.index
                    ? Colors.white54
                    : Colors.white,
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
