import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/enums/generations/generations.dart';
import 'package:ptcgb_flutter/models/common/constants_child_context.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';
import 'package:ptcgb_flutter/screens/widgets/bottom_nav_bar_custom.dart';

class Generations extends StatelessWidget {
  static const routeName = '/generation/generations';
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Generation List'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: null),
        ],
      ),
      body: _buildExpansions(context),
    );
  }

  Widget _buildExpansions(BuildContext context) {
    return ListView.builder(
      itemCount: GenerationsEnum.values.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return _expansionItem(context, GenerationsEnum.values[index]);
      },
    );
  }

  Widget _expansionItem(BuildContext context, GenerationsEnum gen) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: _expansionImage(gen.name),
        title: Text(gen.displayName, style: _biggerFont),
        onTap: () {
          // FIXME: CupertinoTab使いながらHardware back buttonが機能するようにできなかった
          Navigator.of(context, rootNavigator: true)
              .pushNamed(Expansions.routeName, arguments: gen);
        },
      ),
    );
  }

  Image _expansionImage(String gen) {
    final String targetPath = 'assets/img/generations/$gen.png';
    return Image.asset(targetPath);
  }

//  List<String> getGenerationOrders() => ['sa', 'sm'];
//
//  String getGenerationDisplayName(String gen) {
//    final _map = {'sa': 'ソード＆シールド', 'sm': 'サン＆ムーン'};
//    return _map[gen];
//  }
}
