import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ptcgb_flutter/common/app_routes.dart';
import 'package:ptcgb_flutter/models/common/page_model.dart';
import 'package:ptcgb_flutter/models/system/app_route_tree.dart';

class HistorizeNavigator extends HookWidget {
  HistorizeNavigator({this.navigatorKey, this.pageItem});

  static const String routeName = '/historize_navigator';
  final GlobalKey<NavigatorState> navigatorKey;
  final PageModel pageItem;

  @override
  Widget build(BuildContext context) {
    final AppRouteTree routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          settings: RouteSettings(
            name: '/',
            arguments: Map(),
          ),
          builder: (context) =>
              routeBuilders.routeTree[routeSettings.name](context),
        );
      },
    );
  }

  AppRouteTree _routeBuilders(BuildContext context) {
    return AppRoutes.getPageTreeByPageModel(pageItem);
  }
}
