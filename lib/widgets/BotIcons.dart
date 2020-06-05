import 'package:bol_punjabi_radio/widgets/RecorderButton.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';

class BotIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        IconButton(
            icon: Icon(Icons.folder),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushNamed("/recordings");
            }),
        IconButton(
            icon: Icon(Icons.share),
            color: Theme.of(context).accentColor,
            onPressed: () => Share.share(
                  'Hey, checkout the Bol Punjabi Radio app. Download the app from https://play.google.com/store/apps/details?id=com.sekhontech.bolpunjabiradio',
                )),
        IconButton(
            icon: Icon(Icons.alarm),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushNamed("/alarm");
            }),
        IconButton(
            icon: Icon(Icons.hotel),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushNamed("/sleep");
            }),
        RecorderButton(),
      ]),
    );
  }
}
