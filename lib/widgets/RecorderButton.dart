import 'package:flutter/material.dart';

class RecorderButton extends StatefulWidget {
  @override
  _RecorderButtonState createState() => _RecorderButtonState();
}

class _RecorderButtonState extends State<RecorderButton> {
  bool _isRecording = false;

  _start() async {
    try {
      print("Start recording: http://149.56.195.94:8322/bolpunjabiradio");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Recording Started',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightGreen,
        duration: Duration(seconds: 2),
      ));
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    print("Stop recording:");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'Recording Finished',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.blueGrey,
      duration: Duration(seconds: 2),
    ));
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isRecording
        ? IconButton(
            icon: Icon(Icons.fiber_manual_record),
            color: Theme.of(context).accentColor,
            onPressed: _start)
        : IconButton(
            icon: Icon(Icons.stop), color: Colors.red, onPressed: _stop);
  }
}
