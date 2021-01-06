import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

/// utilities

double getScreenWidth(BuildContext context) {
  return _screenSize(context).width;
}

double getScreenHeight(BuildContext context) {
  return _screenSize(context).height;
}

Size _screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

Future<List<FileSystemEntity>> dirContents(Directory dir,
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

Future<String> localBasePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

List<FileSystemEntity> listDir(String path) {
  final Directory dir = Directory(path);
  return dir.listSync();
}
