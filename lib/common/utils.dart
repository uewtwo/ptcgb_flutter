import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// utilities

List<String> getGenerationOrders() => ['sa', 'sm'];

String getGenerationDisplayName(String gen) {
  final _map = {'sa': 'ソード＆シールド', 'sm': 'サン＆ムーン'};
  return _map[gen];
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
