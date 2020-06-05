import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        alignment: Alignment.topCenter,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          IconButton(
              iconSize: 40,
              icon: FaIcon(FontAwesomeIcons.facebook),
              color: Colors.blue[700],
              onPressed: () {
                Navigator.of(context).pushNamed("/webview", arguments: {
                  "name": "Facebook",
                  "url": "https://www.facebook.com/bolpunjabiradio"
                });
              }),
          IconButton(
              iconSize: 40,
              icon: FaIcon(FontAwesomeIcons.twitter),
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.of(context).pushNamed("/webview", arguments: {
                  "name": "Twitter",
                  "url": "https://twitter.com/BolPunjabiRadio"
                });
              }),
          IconButton(
              iconSize: 40,
              icon: FaIcon(FontAwesomeIcons.whatsapp),
              color: Colors.green,
              onPressed: () async {
                const url = 'https://api.whatsapp.com/send?phone=+917070000013';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }),
          IconButton(
              iconSize: 40,
              icon: FaIcon(FontAwesomeIcons.chrome),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pushNamed("/webview", arguments: {
                  "name": "Bol Punjabi Radio Website",
                  "url": "http://bolpunjabi.com"
                });
              }),
          IconButton(
            iconSize: 40,
            icon: FaIcon(FontAwesomeIcons.powerOff),
            color: Colors.red,
            onPressed: () => SystemNavigator.pop(),
          ),
        ]),
      ),
    );
  }
}
