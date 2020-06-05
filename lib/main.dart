import 'package:bol_punjabi_radio/screens/AddAlarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/Home.dart';
import './screens/Alarm.dart';
import './screens/WebView.dart';
import './screens/SleepTimer.dart';
import './screens/RecorderList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.deepOrangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => Home(),
        "/alarm": (ctx) => Alarm(),
        "/webview": (ctx) => Webview(),
        "/sleep": (ctx) => SleepTimer(),
        "/addAlarm": (ctx) => AddAlarm(),
        "/recordings": (ctx) => RecorderList(),
      },
    );
  }
}
