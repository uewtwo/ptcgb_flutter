import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';

class DeckSimulator extends HookWidget {
  static const routeName = '/deck/deck_simulator';

  OwnedDeckInfo getDeckInfo(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${getDeckInfo(context).deckName} : Simulator"),
      ),
      // body: ,
    );
  }

  // Widget _buildSimulator
}
