import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/FileUtils.dart';
import 'package:scoutingapp/custom_scouting_icon_icons.dart';

import 'home.dart';

class AdminPage extends StatefulWidget {
  @override
  AdminPageState createState() {
    return AdminPageState();
  }
}

class AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(
                  CustomScoutingIcon.export_match_data,
                  size: 50,
                ),
                title: Text("Export Match Data"),
                subtitle: Text("Export all match data"),
                onTap: () async {
                  FileUtils.exportMatchData();
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  CustomScoutingIcon.export_pit_data,
                  size: 50,
                ),
                title: Text("Export Pit Data"),
                subtitle: Text("Export all pit data"),
                onTap: () async {
                  FileUtils.exportPitData();
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  CustomScoutingIcon.clear_forms,
                  size: 50,
                ),
                title: Text("Clear Forms"),
                subtitle: Text("Clear all forms"),
                onTap: () async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          title: const Text("Confirm"),
                          content:
                              Text("Are you sure you wish to clear all forms?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("CONFIRM"),
                              onPressed: () {
                                try {
                                  FileUtils.deleteForm();
                                  FileUtils.deletePitForm();
                                } catch (e) {}
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
                leading: Icon(
                  CustomScoutingIcon.clear_schedule,
                  size: 50,
                ),
                title: Text("Clear Schedule"),
                subtitle: Text("Clear the schedule"),
                onTap: () async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          title: const Text("Confirm"),
                          content: Text(
                              "Are you sure you wish to clear the schedule?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("CONFIRM"),
                              onPressed: () {
                                try {
                                  FileUtils.deleteSchedule();
                                } catch (e) {}
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
                leading: Icon(
                  Icons.clear,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          content:
                              Text("Are you sure you wish to clear ALL data?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("CONFIRM"),
                              onPressed: () {
                                try {
                                  FileUtils.deleteData();
                                } catch (e) {}
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
          ],
        ),
      ),
    );
  }
}
