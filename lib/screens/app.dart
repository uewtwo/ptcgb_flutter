import 'package:flutter/material.dart';

import 'package:ptcgb_flutter/screens//home/home.dart';
import 'package:ptcgb_flutter/screens/cards/card_detail.dart';
import 'package:ptcgb_flutter/screens/cards/card_list.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';

import 'generations/generations.dart';

class PtcgBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to PTCGB!!',
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => Home(),
        '/information': (BuildContext context) => Home(),
        '/generations': (BuildContext context) => Generations(),
        '/expansions': (BuildContext context) => Expansions(),
        '/card_list': (BuildContext context) => CardList(),
        '/card_detail': (BuildContext context) => CardDetail(),
        '/decks': (BuildContext context) => Home(),
        '/deck': (BuildContext context) => Home(),
        '/events': (BuildContext context) => Home(),
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
