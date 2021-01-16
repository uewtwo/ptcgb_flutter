import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ptcgb_flutter/models/common/constants_child_context.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfficialInfoWebView extends StatefulWidget {
  static const routeName = '/information/official_info';

  @override
  State<StatefulWidget> createState() => OfficialInfoWebViewState();
}

class OfficialInfoWebViewState extends State<OfficialInfoWebView> {
  final int pageCount = 1;

  WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _exitApp(context),
      child: Scaffold(
        body: WebView(
          initialUrl: 'https://www.pokemon-card.com/info/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.complete(webViewController);
          },
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await (await _controllerCompleter.future).canGoBack()) {
      await (await _controllerCompleter.future).goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
