import 'dart:convert';
import 'dart:io';

import 'package:ptcgb_flutter/common/utils.dart';
import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:ptcgb_flutter/models/decks/deck_content_info.dart';
import 'package:ptcgb_flutter/models/decks/owned_decks_info.dart';
import 'package:tuple/tuple.dart';

class DeckFileHandler {
  static Future<String> get deckBasePath async {
    final String path = (await Utils.localBasePath()) + '/users/decks/';
    return path;
  }

  static Future<OwnedDecksInfo> get ownedDecksInfo async {
    final String fileStr = await (await ownedDecksInfoFile).readAsString();
    return fileStr.isNotEmpty
        ? OwnedDecksInfo.fromJson(json.decode(fileStr))
        : Future(null);
  }

  static Future<File> get ownedDecksInfoFile async {
    final String basePath = (await deckBasePath) + 'user_deck_info.json';
    final File file = File(basePath);
    if (!file.existsSync()) {
      await file.create(recursive: true);
      await file.writeAsString('[]');
    }

    return file;
  }

  static Future<DeckContentInfo> getDeckContent(String deckId) async {
    final String fileStr =
        (await getDeckContentFile(deckId)).readAsStringSync();
    final DeckContentInfo deckContent =
        DeckContentInfo.fromJson(json.decode(fileStr));

    return deckContent;
  }

  static Future<File> getDeckContentFile(String deckId) async {
    final String basePath = (await deckBasePath) + 'deck_contents/';
    final File file = File('$basePath$deckId.json');
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('{}');
    }

    return file;
  }

  static Future<File> _saveOwnedDeckInfo(
      String deckName, int topCardId, String deckId) async {
    OwnedDecksInfo decksInfo = (await ownedDecksInfo);
    final int sortValue = decksInfo.length;

    List<OwnedDeckInfo> deckInfoList = decksInfo.toList();
    deckInfoList.add(OwnedDeckInfo(deckId, deckName, topCardId, sortValue));

    // TODO: class に通す必要があるかないか（バリデーション的な意味で）
//    return await (await ownedDecksInfoFile)
//        .writeAsString(decksInfo.fromList(deckInfoList).jsonString);
    return (await ownedDecksInfoFile).writeAsString(json.encode(deckInfoList));
  }

  static Future<File> _overwriteOwnedDeckInfo(OwnedDeckInfo deckInfo) async {
    List<OwnedDeckInfo> deckInfoList = (await ownedDecksInfo).toList();
    deckInfoList[deckInfo.sortValue] = deckInfo;

    return (await ownedDecksInfoFile)
        .writeAsString(json.encode(deckInfoList), mode: FileMode.write);
  }

  static Future<DeckContentInfo> getDeckContentInfoById(String deckId) async {
    final String basePath = (await deckBasePath) + 'deck_contents';
    await Directory(basePath).create(recursive: true);
    final DeckContentInfo deckContentInfo =
        DeckContentInfo.fromJson(json.decode('$basePath/$deckId.json'));

    return deckContentInfo;
  }

  static Future<bool> overwriteDeckContentInfo(
      List<Tuple2<CardContent, int>> deckElement,
      String deckName,
      int topCardId,
      String deckId,
      int sortValue) async {
    return saveDeckContentInfo(deckElement, deckName, topCardId,
        deckId: deckId, sortValue: sortValue);
  }

  // FIXME: 2file更新するが、片方が失敗したらロールバックみたいなことしたい.
  static Future<bool> saveDeckContentInfo(
      List<Tuple2<CardContent, int>> deckElement,
      String deckName,
      int topCardId,
      {String deckId,
      int sortValue}) async {
    List<List<dynamic>> _deckElement = [];

    deckElement.forEach((val) {
      _deckElement.add(val.toList());
    });

    /// 上書きの場合、deckId, sortValue2つの値がないといけないが、なくても渡せてしまう状況どうにかしたい
    /// Tupleとかにパッキングするか？
    try {
      if (deckId != null && sortValue != null) {
        await _overwriteOwnedDeckInfo(
            OwnedDeckInfo(deckId, deckName, topCardId, sortValue));
        await _overwriteDeckContent(DeckContentInfo(deckId, _deckElement));
      } else {
        deckId = DateTime.now().toString().replaceAll(' ', '_');
        await _saveOwnedDeckInfo(deckName, topCardId, deckId);
        await _saveDeckContent(DeckContentInfo(deckId, _deckElement));
      }
    } catch (e) {
      // return false;
      throw e;
    }

    return true;
  }

  static Future<bool> deleteDeckContentInfo(OwnedDeckInfo deckInfo) async {
    var _a = await _deleteOwnedDeckInfo(deckInfo.sortValue);
    var _b = await _deleteDeckContent(deckInfo.deckId);
    return (_a.existsSync() && _b.existsSync());
  }

  static Future<File> _overwriteDeckContent(DeckContentInfo deckContent) async {
    File file = await getDeckContentFile(deckContent.deckId);
    return await file.writeAsString(json.encode(deckContent));
  }

  static Future<File> _saveDeckContent(DeckContentInfo deckContent) async {
    File file = await getDeckContentFile(deckContent.deckId);
    return await file.writeAsString(json.encode(deckContent));
  }

  static Future<File> _deleteDeckContent(String deckId) async {
    File file = await getDeckContentFile(deckId);
    return await file.delete();
  }

  static Future<File> _deleteOwnedDeckInfo(int sortValue) async {
    List<OwnedDeckInfo> deckInfoList = (await ownedDecksInfo)
        .toList()
        .where((element) => element.sortValue != sortValue)
        .toList();

    // TODO: class に通す必要があるかないか（バリデーション的な意味で）
//    return await (await ownedDecksInfoFile)
//        .writeAsString(decksInfo.fromList(deckInfoList).jsonString);
    return await (await ownedDecksInfoFile)
        .writeAsString(json.encode(deckInfoList));
  }
}
