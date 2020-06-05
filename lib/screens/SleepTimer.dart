import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class SleepTimer extends StatefulWidget {
  @override
  _SleepTimerState createState() => _SleepTimerState();
}

class _SleepTimerState extends State<SleepTimer> {
  var _tempDateTime;
  var _diffDateTime;
  var _timeString = "2020-01-01 00:00:00";
  final LocalStorage storage = new LocalStorage("sleepTimer");

  @override
  void initState() {
    super.initState();
    _diffDateTime = storage.getItem("timeStamp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sleep Timer"),
        ),
        body: Container(
            child: _diffDateTime == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Hr",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Min",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Sec",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(80, 30, 80, 80),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Theme.of(context).accentColor),
                            borderRadius: BorderRadius.circular(50)),
                        child: TimePickerSpinner(
                          time: DateTime.tryParse("2020-01-01 00:00:00"),
                          is24HourMode: true,
                          isShowSeconds: true,
                          normalTextStyle: TextStyle(
                            fontSize: 18,
                          ),
                          highlightedTextStyle: TextStyle(
                            fontSize: 28,
                          ),
                          spacing: 20,
                          itemHeight: 80,
                          alignment: Alignment.center,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                            setState(() {
                              _tempDateTime = time;
                            });
                          },
                        ),
                      ),
                      RaisedButton(
                          child: Text("Start"),
                          onPressed: () {
                            var _diff = -DateTime.tryParse(_timeString)
                                .difference(_tempDateTime);
                            var timeStamp = DateTime.now()
                                .add(_diff)
                                .millisecondsSinceEpoch;
                            storage.setItem("timeStamp", timeStamp);

                            setState(() {
                              _diffDateTime = timeStamp;
                            });
                          })
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your Music will stop automatically in",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 100),
                        child: CountdownTimer(
                          endTime: _diffDateTime,
                          defaultHours: "--",
                          defaultMin: "**",
                          defaultSec: "++",
                          hoursSymbol: " : ",
                          minSymbol: " : ",
                          hoursTextStyle:
                              TextStyle(fontSize: 55, color: Colors.deepOrange),
                          minTextStyle:
                              TextStyle(fontSize: 55, color: Colors.deepOrange),
                          secTextStyle:
                              TextStyle(fontSize: 55, color: Colors.deepOrange),
                          daysSymbolTextStyle:
                              TextStyle(fontSize: 55, color: Colors.deepOrange),
                          hoursSymbolTextStyle:
                              TextStyle(fontSize: 55, color: Colors.deepOrange),
                          minSymbolTextStyle:
                              TextStyle(fontSize: 55, color: Colors.deepOrange),
                          onEnd: () async {
                            await storage
                                .setItem("timeStamp", null)
                                .then((_) => SystemNavigator.pop());
                          },
                        ),
                      ),
                      RaisedButton(
                          onPressed: () async {
                            await storage
                                .setItem("timeStamp", null)
                                .then((_) => Navigator.of(context).pop());
                          },
                          child: Text("Cancel"))
                    ],
                  )));
  }
}
