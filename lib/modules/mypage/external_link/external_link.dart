import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ExternalLink extends StatefulWidget {
  ExternalLink({@required this.url});

  final String? url;

  @override
  State<ExternalLink> createState() => _ExternalLinkState();
}

class _ExternalLinkState extends State<ExternalLink> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: SafeArea(
            child: Stack(children: <Widget>[
          WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() => isLoading = false);
              }),
          isLoading
              ? Center(
                  child: Image.asset('assets/images/indicator.gif',
                      width: 100, height: 100))
              : Stack()
        ])));
  }
}
