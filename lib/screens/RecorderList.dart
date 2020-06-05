import 'package:flutter/material.dart';

class RecorderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recordings"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Recording 1"),
            leading: IconButton(
                icon: Icon(Icons.play_circle_outline),
                color: Colors.grey,
                onPressed: () {}),
            trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                color: Colors.red,
                onPressed: () {}),
          ),
          ListTile(
            title: Text("Recording 2"),
            leading: IconButton(
                icon: Icon(Icons.play_circle_outline),
                color: Colors.grey,
                onPressed: () {}),
            trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                color: Colors.red,
                onPressed: () {}),
          ),
          ListTile(
            title: Text("Recording 3"),
            leading: IconButton(
                icon: Icon(Icons.play_circle_outline),
                color: Colors.grey,
                onPressed: () {}),
            trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                color: Colors.red,
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
