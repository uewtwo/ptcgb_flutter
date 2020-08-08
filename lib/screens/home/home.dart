import 'package:flutter/material.dart';

import 'package:ptcgb_flutter/screens//decks/decklists.dart';
import 'package:ptcgb_flutter/screens//expansions/expansions.dart';

import 'package:path/path.dart';
import 'package:ptcgb_flutter/screens/cards/search_cards.dart';
import 'package:ptcgb_flutter/screens/generations/generations.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

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
          _buildSearch(context),
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
        Navigator.of(context).pushNamed(Generations.routeName);
      },
      child: Text('Expansions'),
    );
  }

  Widget _buildDecks(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Navigator.of(context).pushNamed(Decklists.routeName);
      },
      child: Text('Deck Lists'),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Navigator.of(context).pushNamed(SearchCards.routeName);
      },
      child: Text('Search'),
    );
  }
}
