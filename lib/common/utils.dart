import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ptcgb_flutter/common/app_routes.dart';

/// utilities
class Utils {
  static double getScreenWidth(BuildContext context) {
    return _screenSize(context).width;
  }

  static double getScreenHeight(BuildContext context) {
    return _screenSize(context).height;
  }

  static Size _screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Future<List<FileSystemEntity>> dirContents(Directory dir,
      [bool isRecursive = false]) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: isRecursive);
    lister.listen(
      (file) => files.add(file),
      // TODO: Should also register onError
      onDone: () => completer.complete(files),
    );
    return completer.future;
  }

  static Future<String> localBasePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static List<FileSystemEntity> listDir(String path) {
    final Directory dir = Directory(path);
    return dir.listSync();
  }

  static MaterialPageRoute nestedPageRoute(String routeName, arguments) {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: 'custom_arguments',
        arguments: arguments,
      ),
      builder: (context) => AppRoutes.appRoutes[routeName](context),
    );
  }
}
