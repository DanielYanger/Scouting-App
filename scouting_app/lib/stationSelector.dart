import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'home.dart';
import 'importSchedule.dart' as importSchedule;

class StationSelector extends StatefulWidget {
  @override
  StationSelectorState createState() => new StationSelectorState();
}

var station = 0;

int getStation() {
  return station;
}

List<List<String>> modifiedSchedule(int station, String schedule) {
  //stations go from 0-5
  List<List<String>> modifiedMatches = [];
  List<List<String>> matches = importSchedule.getSchedule(station, schedule);
  bool teamOnly = importSchedule.isTeamOnly();
  if (teamOnly) {
    if (station == 6) {
      modifiedMatches = matches;
    } else {
      modifiedMatches = [
        [""]
      ];
    }
  } else {
    if (station == 6) {
      modifiedMatches = matches;
    } else {
      for (int i = station; i < matches.length; i += 6) {
        modifiedMatches.add(matches[i]);
      }
    }
  }
  return modifiedMatches;
}

bool isPit() {
  //stations go from 0-5
  if (station == 6) {
    return true;
  }
  return false;
}

// ignore: missing_return
String initialStation(int station) {
  if (station == 0) {
    return "Red 1";
  } else if (station == 1) {
    return "Red 2";
  } else if (station == 2) {
    return "Red 3";
  } else if (station == 3) {
    return "Blue 1";
  } else if (station == 4) {
    return "Blue 2";
  } else if (station == 5) {
    return "Blue 3";
  } else if (station == 6) {
    return "Pit Scouting";
  }
}

class StationSelectorState extends State<StationSelector> {
  ValueChanged _onChanged = (val) => print(val);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Station")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FormBuilderRadio(
                    decoration: InputDecoration(
                      labelText: 'Station',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    activeColor: Theme.of(context).primaryColor,
                    attribute: "station",
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: [
                      "Red 1",
                      "Red 2",
                      'Red 3',
                      'Blue 1',
                      'Blue 2',
                      'Blue 3',
                      "Pit Scouting"
                    ]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                    initialValue: initialStation(station),
                  ),
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      String value = _fbKey.currentState.value.toString();
                      if (value == ("{station: Red 1}")) {
                        station = 0;
                      } else if (value == ("{station: Red 2}")) {
                        station = 1;
                      } else if (value == ("{station: Red 3}")) {
                        station = 2;
                      } else if (value == ("{station: Blue 1}")) {
                        station = 3;
                      } else if (value == ("{station: Blue 2}")) {
                        station = 4;
                      } else if (value == ("{station: Blue 3}")) {
                        station = 5;
                      } else if (value == ("{station: Pit Scouting}")) {
                        station = 6;
                      }
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
