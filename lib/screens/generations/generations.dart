import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/enums/generations/generations.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';

class Generations extends StatelessWidget {
  Generations(this.routeContext);

  final BuildContext routeContext;
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
          Navigator.of(context).pushNamed(
            Expansions.routeName,
            arguments: gen,
          );
          // Navigator.push(
          //   routeContext,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         AppRoutes.appRoutes[Expansions.routeName](context),
          //   ),
          // );
        },
      ),
    );
  }

  Image _expansionImage(String gen) {
    final String targetPath = 'assets/img/generations/$gen.png';
    return Image.asset(targetPath);
  }
}
