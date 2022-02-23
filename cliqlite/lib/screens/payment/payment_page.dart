import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  static const String id = 'payment_page';
  PaymentPage({this.url});
  final String url;
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController _webViewController;
  bool _loading = true;

  @override
  void initState() {
    print('url: ${widget.url}');

    super.initState();
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  Widget _showWebView(String url) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PAYMENT'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppLayout.id);
                AuthProvider.auth(context).setIsLoading(false);
                setState(() {});
              },
              child: Icon(Icons.arrow_back)),
        ),
      ),
      body: WebView(
        debuggingEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          print('url is ${url.substring(0, url.indexOf('&trxref'))}');
          print('url is $url');

          if (url.substring(0, url.indexOf('&trxref')) ==
              'https://cliq-lite.herokuapp.com/api/v1?status=success') {
            Navigator.pushNamed(context, AppLayout.id);
          }
          setState(() {
            _loading = false;
          });
        },
        onWebViewCreated: (controller) {
          _webViewController = controller;
          _webViewController.loadUrl(url);
        },
      ),
    );
  }

  // Widget _showWeb(String url) {
  //   return WebviewScaffold(
  //       url: url,
  //       appBar: AppBar(
  //         title: Text('PAYMENT'),
  //         leading: Padding(
  //           padding: const EdgeInsets.only(left: 15),
  //           child: BackArrow(
  //             text: '',
  //             onTap: () => Navigator.pop(context),
  //           ),
  //         ),
  //       ),
  //       withZoom: true,
  //       withLocalStorage: true,
  //       hidden: true,
  //       initialChild: Container(
  //         height: double.infinity,
  //         width: double.infinity,
  //         child: Center(
  //           child: CircularProgressIndicator(backgroundColor: primaryColor),
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    return _showWebView(url);
  }
}
