import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/themes/style.dart';
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
        backgroundColor: primaryColor,
        title: Text('PAYMENT'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppLayout.id, (Route<dynamic> route) => false);
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
          // 'https://oneschool-web.netlify.app/dashboard/account/subscription/payment-summary?status=success'
          if (url.substring(0, url.indexOf('&trxref')) ==
              'https://staging.oneschool.africa/user-dashboard/account/subscription/payment-summary?status=success') {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppLayout.id, (Route<dynamic> route) => false);
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

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    return _showWebView(url);
  }
}
