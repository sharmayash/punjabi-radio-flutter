import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './Home.dart';

class AddAlarm extends StatefulWidget {
  @override
  _AddAlarmState createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  String _time;
  var alrmList = [];
  TimeOfDay _selectedTime;
  TextEditingController _labelController = TextEditingController();
  List<Map> days = [
    {
      "name": "Mon",
      "isOpen": true,
    },
    {
      "name": "Tue",
      "isOpen": true,
    },
    {
      "name": "Wed",
      "isOpen": true,
    },
    {
      "name": "Thurs",
      "isOpen": true,
    },
    {
      "name": "Fri",
      "isOpen": true,
    },
    {
      "name": "Sat",
      "isOpen": true,
    },
    {
      "name": "Sun",
      "isOpen": true,
    },
  ];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(time) async {
    await notification(time);
  }

  // void _showNotificationsOnAlarm(time, days) async {
  //   await notificationOnAlarm(time, days);
  // }

  Future<void> notification(time) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hello there', 'Your Alarm Set for $time', notificationDetails);
  }

  // List<String> handleDates() {
  //   var newList = [];

  //   days.map((item) {
  //     return newList.add(item["name"]);
  //   }).toList();

  //   return newList;
  // }

  // Future<void> notificationOnAlarm(time, days) async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('show weekly channel ID',
  //           'show weekly channel title', 'show weekly channel body',
  //           priority: Priority.High,
  //           importance: Importance.Max,
  //           ticker: 'test');

  //   IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  //   NotificationDetails notificationDetails =
  //       NotificationDetails(androidNotificationDetails, iosNotificationDetails);

  //   await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //       1,
  //       'Hello there',
  //       "It's time to listen to music",
  //       Day.Wednesday,
  //       Time(5, 8, 0),
  //       notificationDetails);
  // }

  Future onSelectNotification(String payLoad) async {
    if (payLoad != null) {
      print(payLoad);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  _setTime(BuildContext ctx) async {
    _selectedTime =
        await showTimePicker(context: ctx, initialTime: TimeOfDay.now());

    final String formattedTimeOfDay =
        MaterialLocalizations.of(context).formatTimeOfDay(_selectedTime);
    setState(() {
      _time = formattedTimeOfDay;
    });
  }

  _saveAlarm() async {
    if (_labelController.text.isEmpty && _time == null) {
      return;
    }

    days = days.where((item) => item["isOpen"] == true).toList();

    var newAlarm = {
      "time": _time,
      "daysArray": days,
      "label": _labelController.text,
    };

    final LocalStorage storage = new LocalStorage("AlarmStorage");
    var fetchedList = await storage.getItem("alarmList");

    alrmList = fetchedList;

    if (alrmList == null) {
      alrmList = [newAlarm];
      await storage.setItem("alarmList", alrmList);
    } else if (alrmList != null) {
      alrmList.add(newAlarm);
      await storage.setItem("alarmList", alrmList);
    }

    _showNotifications(_time);
    // _showNotificationsOnAlarm(_time, days);

    Navigator.of(context)
        .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set An Alarm"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveAlarm();
              }),
        ],
      ),
      body: Container(
        height: 610,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Time"),
                  _time != null ? Text("$_time") : Container(),
                  RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text("Pick Time Here"),
                      onPressed: () {
                        _setTime(context);
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextField(
                controller: _labelController,
                decoration:
                    InputDecoration(labelText: 'Add a Label to Your alarm'),
              ),
            ),
            Text("Days"),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: ListView(
                  children: days.map((e) {
                return ListTile(
                  title: Text(e["name"]),
                  trailing: Switch(
                      value: e["isOpen"],
                      onChanged: (val) {
                        setState(() {
                          e["isOpen"] = val;
                        });
                      }),
                );
              }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
