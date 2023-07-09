import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview/common_scaffold.dart';
import 'package:webview/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: CommonScaffold(
        body: Stack(
          children: [
            SizedBox(

              child: WebView(
                onPageStarted: (String url) {
                  setState(() {
                    isLoading = true;
                  });
                },
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controllerCompleter.future
                      .then((value) => controller = value);
                  _controllerCompleter.complete(webViewController);
                },
                javascriptChannels: {
                  JavascriptChannel(
                    name: 'ZoomChannel',
                    onMessageReceived: (JavascriptMessage message) {
                      if (message.message == 'disableZoom') {
                        _controllerCompleter.future.then((controller) {
                          controller.evaluateJavascript(
                              'document.documentElement.style.touchAction = "pan-x pan-y";');
                        });
                      }
                    },
                  ),
                },
                onPageFinished: (String url) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),

          ],
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await controller!.canGoBack()) {
      controller?.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                title: const Text('Do you want to exit'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyWebView(),
                          ));
                    },
                    child: const Text('Go TO Home'),
                  ),
                ],
              ));

      return Future.value(true);
    }
  }
}
