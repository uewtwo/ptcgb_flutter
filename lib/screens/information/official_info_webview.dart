import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfficialInfoWebView extends StatefulWidget {
  static const routeName = '/information/official_info';

  OfficialInfoWebView(this.routeContext);
  final BuildContext routeContext;

  @override
  State<StatefulWidget> createState() => OfficialInfoWebViewState(routeContext);
}

class OfficialInfoWebViewState extends State<OfficialInfoWebView> {
  OfficialInfoWebViewState(this.routeContext);
  final BuildContext routeContext;

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
      onWillPop: () async => await _exitApp(routeContext),
      child: Scaffold(
        body: WebView(
          initialUrl: 'https://www.pokemon-card.com/info',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.complete(webViewController);
          },
        ),
        // bottomNavigationBar: bottomNavigationBarCustom2(0),
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
