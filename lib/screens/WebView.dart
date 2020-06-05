import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  void _handleLoad(_) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageDetail = ModalRoute.of(context).settings.arguments as Map;
    final name = pageDetail["name"];
    final url = pageDetail["url"];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          new WebView(
            initialUrl: url,
            onPageFinished: _handleLoad,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          _isLoading
              ? Container(
                  color: Colors.black,
                  child: Center(child: CircularProgressIndicator()))
              : Container(),
        ],
      ),
    );
  }
}
