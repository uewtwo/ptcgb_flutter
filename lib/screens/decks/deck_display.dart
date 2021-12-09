import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptcgb_flutter/models/arguments/deck_display_arguments.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:ptcgb_flutter/screens/widgets/image_widget.dart';

class DeckDisplay extends HookWidget {
  static const routeName = '/deck/deck_display';

  OwnedDeckInfo getDeckInfo(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${getDeckInfo(context).deckName} 画像表示"),
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
              // TODO: https://fluttergems.dev/grid/
              // https://pub.dev/packages/drag_select_grid_view
              // https://pub.dev/packages/item_selector
              // grid view がやりたかった！！！
              // 良さげなら DeckListでもこれを使いたい
              // ついでに CardList 下の Cardリストでも使いたい
              future: getDeckDisplayImages(getDeckInfo(context)),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return _buildDeckDisplayImages(snapshot);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ImageWidget>> getDeckDisplayImages(OwnedDeckInfo deckInfo) {
    // TODO: デッキのカード画像と枚数を合わせた画像のリストを返す

  }

  Widget _buildDeckDisplayImages(AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Container(
          padding: EdgeInsets.all(10.0), child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      // throw snapshot.error
      return Container(
          padding: EdgeInsets.all(10.0),
          child: Text(snapshot.error.toString()));
    } else if (snapshot.hasData) {
      final List<Widget> imageList = snapshot.data;
      return GridView.extent(
        maxCrossAxisExtent: 150,
        padding: EdgeInsets.all(5),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: imageList,
      );
    } else {
      return Text('No Data.');
    }
  }

  DeckDisplayArguments getArguments(BuildContext context) =>
      ModalRoute.of(context).settings.arguments;
}
