import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ptcgb_flutter/debug/sa_expansion_list.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';

/// utilities

double screenWidth(BuildContext context) {
  return _screenSize(context).width;
}

double screenHeight(BuildContext context) {
  return _screenSize(context).height;
}

Size _screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

Future<List<FileSystemEntity>> dirContents(Directory dir, [bool isRecursive = false]) {
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

Future<List<CardContent>> getAllCardByGeneration(BuildContext context, String gen) async {
  List<CardContent> _list = [];
  final String basePath = 'assets/text/cards/jp/$gen/';
  // FIXME: debug用にsaのリストを予め用意、本来はgenによって動的にファイルリストを取得
  SA_LIST.forEach((ele) async {
    _list.addAll(CardContents.fromJson(
        jsonDecode(await DefaultAssetBundle.of(context).loadString(
            '$basePath$ele.json'))).toList()
    );
  });

  return _list;
}
