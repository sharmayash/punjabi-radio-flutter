import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  var alarmList = [];
  LocalStorage storage = new LocalStorage("AlarmStorage");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.alarm_add),
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushNamed("/addAlarm");
            }),
        appBar: AppBar(
          title: Text("Alarm List"),
        ),
        body: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                var fetchedList = storage.getItem("alarmList");

                if (fetchedList != null) {
                  alarmList = fetchedList;
                }

                return (alarmList.length == 0)
                    ? Center(
                        child: Text("Add Alarm By Clicking Floating Button"),
                      )
                    : ListView(
                        children: alarmList.map((item) {
                        return ListTile(
                          title: Text(item["label"]),
                          subtitle: Row(
                            children: item["daysArray"].map<Widget>((e) {
                              return Text("${e["name"]}, ");
                            }).toList(),
                          ),
                          leading: Text(item["time"]),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_outline),
                              color: Theme.of(context).accentColor,
                              onPressed: () {}),
                        );
                      }).toList());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
