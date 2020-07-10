import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ptcgb_flutter/models/expansion/expansion_contents.dart';

class Expansions extends StatelessWidget {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final String generation = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text('Expansion List'), actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: null),
        ]),
        body: Container(
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {},
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  )),
              Expanded(
                  child: Center(
                      child: FutureBuilder(
                future: this.getExpansionContentsByGen(context, generation),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return _buildExpansions(context, snapshot);
                },
              ))),
            ])));
  }

  Widget _buildExpansions(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      // show circle during loading.
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    } else if (snapshot.hasData) {
      final List<ExpansionContent> expansions = snapshot.data;
      return Scrollbar(
        child: ListView.builder(
            itemCount: expansions.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return _expansionItem(context, expansions[index], index);
            }),
      );
    } else {
      return Text('No Data.');
    }
  }

  Widget _expansionItem(
      BuildContext context, ExpansionContent content, int index) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: _expansionImage(content),
        title: Text(content.name, style: _biggerFont),
        onTap: () {
          Navigator.of(context).pushNamed('/card_list', arguments: content);
        },
      ),
    );
  }

  Image _expansionImage(ExpansionContent content) {
    String targetPath =
        'assets/img/expansions/${content.generation}/${content.name}.png';
    // ↓DebugCode
    targetPath = 'assets/img/various/sample.png';
    try {
      return Image.asset(targetPath);
    } catch (e) {
      print(e);
      return Image.asset('assets/img/various/sample.png');
    }
  }

  Future<List<ExpansionContent>> getExpansionContentsByGen(
      BuildContext context, String gen) async {
    final String jsonPath = 'assets/text/expansions/$gen.json';
    final List<dynamic> jsonRes =
        jsonDecode(await DefaultAssetBundle.of(context).loadString(jsonPath));
    final List<ExpansionContent> _expansions =
        ExpansionContents.fromJson(jsonRes).getExpansionContentList();

    return _expansions;
  }
}
