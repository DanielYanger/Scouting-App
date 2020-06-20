import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/FileUtils.dart';
import 'package:scoutingapp/scouting_icons_icons.dart';

import 'formReader.dart';
import 'home.dart';
import 'importSchedule.dart';
import 'pitFormReader.dart';
import 'stationSelector.dart';

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
              title: Text("Import Match Form"),
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
                Icons.build,
                size: 50,
              ),
              title: Text("Import Pit Form"),
              subtitle: Text("Import a new pit scouting form"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PitFormReader()),
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
          Card(
            child: ListTile(
              leading: Icon(
                Icons.delete,
                size: 50,
              ),
              title: Text("Clear Data"),
              subtitle: Text("Clear all data"),
              onTap: () async {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you wish to delete all data?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("CONFIRM"),
                            onPressed: () {
                              FileUtils.deleteSchedule();
                              FileUtils.deletePitForm();
                              FileUtils.deleteForm();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                          FlatButton(
                            child: Text("CANCEL"),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      );
                    });
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("About the App"),
              subtitle: Text(""),
              leading: Icon(
                Icons.info,
                size: 50,
              ),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: Icon(ScoutingIcons.radioactive),
                    applicationVersion: '1.5.0',
                    applicationLegalese:
                        "This app was developed by Daniel Yang, a programmer for FRC Team 624. This is one of the two apps developed for the Team 624 Scouting Team for use in many years to come. The purpose of this app is to allow scouts to use the team devices to scout, independent of any connection.");
              },
            ),
          ),
        ],
      ),
    );
  }
}
