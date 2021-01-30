import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:ptcgb_flutter/screens/app.dart';

void main() => runApp(ProviderScope(child: App()));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome PTCG Builder',
      home: PtcgBuilderApp(),
      // initialRoute:
      // routes: AppRoutes.appRoutes,
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
