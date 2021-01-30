import 'package:flutter/material.dart';

class AppRouteTree {
  AppRouteTree({@required this.routePage, @required this.routeTree});

  final Map<String, WidgetBuilder> routePage;
  final Map<String, WidgetBuilder> routeTree;
}
