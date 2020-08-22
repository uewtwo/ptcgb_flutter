import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';

import 'package:ptcgb_flutter/views//home/home.dart';
import 'package:ptcgb_flutter/views/cards/card_detail.dart';
import 'package:ptcgb_flutter/views/cards/card_list.dart';
import 'package:ptcgb_flutter/views/cards/search_cards.dart';
import 'package:ptcgb_flutter/views/expansions/expansions.dart';

import 'decks/deck_creator.dart';
import 'decks/decklists.dart';
import 'generations/generations.dart';

class PtcgBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to PTCGB!!',
      routes: <String, WidgetBuilder> {
        Home.routeName: (BuildContext context) => Home(),
        '/information': (BuildContext context) => Home(),
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