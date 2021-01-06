import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';

import 'package:ptcgb_flutter/screens//home/home.dart';
import 'package:ptcgb_flutter/screens/cards/card_detail.dart';
import 'package:ptcgb_flutter/screens/cards/card_list.dart';
import 'package:ptcgb_flutter/screens/cards/search_cards.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';
import 'package:ptcgb_flutter/screens/infomation/official_info_webview.dart';
import 'package:ptcgb_flutter/screens/widgets/bottom_nav_bar.dart';

import 'decks/deck_creator.dart';
import 'decks/decklists.dart';
import 'generations/generations.dart';

class PtcgBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to PTCGB!!',
      home: BottomNavBar(),
      routes: <String, WidgetBuilder>{
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
      },
      theme: ThemeData(
        fontFamily: 'NotoSansJP-Black',
        primaryColor: Colors.teal, // app header background
        secondaryHeaderColor: Colors.indigo[400], // card header background
        cardColor: Colors.white, // card field background
        backgroundColor: Colors.indigo[100], // app background color
        buttonColor: Colors.lightBlueAccent[100], // button background color
        textTheme: TextTheme(
          button: TextStyle(color: Colors.deepPurple[900]), // button text
          subtitle1: TextStyle(color: Colors.grey[800]), // input text
          headline6: TextStyle(color: Colors.white), // card header text
        ),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.lightBlue[50]), // app header text
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.indigo[400]), // style for labels
        ),
      ),
    );
  }
}
