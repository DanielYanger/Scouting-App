import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'home.dart';
import 'importSchedule.dart' as importSchedule;

class StationSelector extends StatefulWidget {
  @override
  StationSelectorState createState() => new StationSelectorState();
}

var station = 0;

List<List<String>> modifiedSchedule() {
  //stations go from 0-5
  List<List<String>> modifiedMatches = [];
  List<List<String>> matches = importSchedule.getSchedule(station);
  if (station == 6) {
    modifiedMatches = matches;
  } else {
    for (int i = station; i < matches.length; i += 6) {
      modifiedMatches.add(matches[i]);
    }
  }

  return modifiedMatches;
}

bool isPit() {
  //stations go from 0-5
  if (station == 6) {
    print("true");
    return true;
  }
  print("false");
  return false;
}

class StationSelectorState extends State<StationSelector> {
  ValueChanged _onChanged = (val) => print(val);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Import Schedule")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                FormBuilderRadio(
                  decoration: InputDecoration(labelText: 'Station'),
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
                ),
                MaterialButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Submit",
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
