import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("调用Android原生WebView控件"),
      ),
      body: WebView(
        initialUrl: "https://flutterchina.club",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
