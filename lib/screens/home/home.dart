import 'package:flutter/material.dart';

import 'package:ptcgb_flutter/screens//decks/decks.dart';
import 'package:ptcgb_flutter/screens//expansions/expansions.dart';

import 'package:path/path.dart';
import 'package:ptcgb_flutter/screens/generations/generations.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Card Builder'),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('home'),
          _buildInformation(context),
          _buildExpansions(context),
          _buildDecks(context),
        ]
      ))
    );
  }

  Widget _buildInformation(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Navigator.of(context).pushNamed('/cards');
      },
      child: Text('Information'),
    );
  }

  Widget _buildExpansions(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Navigator.of(context).pushNamed('/generations');
      },
      child: Text('Expansions'),
    );
  }

  Widget _buildDecks(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Navigator.of(context).pushNamed('/decks');
      },
      child: Text('Decks'),
    );
  }
}
