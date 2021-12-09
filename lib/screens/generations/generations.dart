import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/enums/generations/generations.dart';
import 'package:ptcgb_flutter/models/arguments/expansions_arguments.dart';
import 'package:ptcgb_flutter/screens/expansions/expansions.dart';
import 'package:ptcgb_flutter/screens/widgets/image_widget.dart';

class Generations extends StatelessWidget {
  // Generations(this.routeContext);

  // final BuildContext routeContext;
  // final GlobalKey navigatorKey;

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
        final GenerationsEnum gen = GenerationsEnum.values[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
          ),
          child: ListTile(
            leading: ImageWidget.getGenerationImage(gen.name),
            title: Text(gen.displayName, style: _biggerFont),
            onTap: () {
              Navigator.push(
                context,
                Utils.nestedPageRoute(
                  Expansions.routeName,
                  ExpansionsArguments(gen),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
