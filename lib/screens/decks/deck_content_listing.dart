import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';

// デッキの中身をリストで一覧表示する
// デッキ画像生成機能とかをどこかで持たせて表示とかしたい
class DeckContentListing extends HookWidget {
  static const routeName = '/deck/deck_content_listing';

  OwnedDeckInfo getDeckInfo(context) {
    return ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${getDeckInfo(context).deckName}"),
      ),
      // body: ,
    );
  }
}
