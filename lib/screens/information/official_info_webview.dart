import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/screens/widgets/bottom_nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfficialInfoWebView extends StatefulWidget {
  static const routeName = '/information/official_info';

  @override
  State<StatefulWidget> createState() => OfficialInfoWebViewState();
}

class OfficialInfoWebViewState extends State<OfficialInfoWebView> {
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Official Information'),
      // actions: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.refresh),
      //     onPressed: () {
      //       _controller.loadUrl('https://www.twitch.tv/');
      //     },
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.add_comment),
      //     onPressed: () {
      //       showDialog(
      //           context: context,
      //           builder: (context) {
      //             return AlertDialog(
      //               title: Text('webviewの上に表示'),
      //             );
      //           });
      //     },
      //   ),
      // ],
      // ),
      body: WebView(
        initialUrl: 'https://www.pokemon-card.com/info/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
