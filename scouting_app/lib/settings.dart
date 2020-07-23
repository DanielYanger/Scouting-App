import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoutingapp/custom_scouting_icon_icons.dart';
import 'package:scoutingapp/scouting_icons_icons.dart';

import 'formReader.dart';
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
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                  CustomScoutingIcon.import_match_form,
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
                  CustomScoutingIcon.import_pit_form,
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
                  CustomScoutingIcon.import_schedule,
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
                  Icons.settings,
                  size: 50,
                ),
                title: Text("Admin Panel"),
                subtitle: Text("Access the admin panel"),
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
                          title: const Text("Enter Password"),
                          content: Container(
                            height: 81,
                            child: Column(
                              children: <Widget>[
                                FormBuilder(
                                  key: _formKey,
                                  child: FormBuilderTextField(
                                    attribute: "password",
                                    validators: [
                                      FormBuilderValidators.required(),
                                      // ignore: missing_return
                                      (val) {
                                        if (val != "CRyptonite2001")
                                          return "Incorrect Password";
                                      },
                                    ],
                                    maxLines: 1,
                                    obscureText: true,
                                    decoration:
                                        InputDecoration(labelText: "Password"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("CONFIRM"),
                              onPressed: () {
                                if (_formKey.currentState.saveAndValidate()) {
                                  Navigator.popAndPushNamed(context, '/admin');
                                }
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
                      applicationVersion: '1.6.2',
                      applicationLegalese:
                          "This app was developed by Daniel Yang, a programmer for FRC Team 624. This is one of the two apps developed for the Team 624 Scouting Team for use in many years to come. The purpose of this app is to allow scouts to use the team devices to scout, independent of any connection.");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
