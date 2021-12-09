import 'package:flutter/material.dart';

class ImageWidget {
  static Image getGenerationImage(String generation) {
    return _getPtcgbImage('generations', generation);
  }

  static Image getExpansionImage(String generation, String productNo) {
    // TODO: 弾毎の画像用意しないといけない
    return _getPtcgbImage('expansions', '$generation/$productNo');
  }

  static Image _getPtcgbImage(
    String genre,
    String path, {
    String type = 'png',
  }) {
    try {
      return Image.asset('assets/img/$genre/$path.$type');
    } catch (e) {
      // 画像取得できなかったらとりあえずのサンプル画像を流す.
      return Image.asset('assets/img/various/sample.png');
    }
  }
}
