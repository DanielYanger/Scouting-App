import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'importSchedule.dart';
import 'stationSelector.dart';
import 'formReader.dart';

class MySettingPage extends StatefulWidget {
  @override
  MySettingPageState createState() {
    return MySettingPageState();
  }
}

class MySettingPageState extends State<MySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(
                Icons.import_export,
                size: 50,
              ),
              title: Text("Change Station Assignment"),
              subtitle:
                  Text("Switch between different driver station assignments"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StationSelector()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.restore_page,
                size: 50,
              ),
              title: Text("Import Form"),
              subtitle: Text("Import a new scouting form"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormReader()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.cloud_download,
                size: 50,
              ),
              title: Text("Import Schedule"),
              subtitle: Text("Import a new schedule"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImportScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
