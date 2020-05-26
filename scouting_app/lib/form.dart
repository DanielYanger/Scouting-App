import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'FileUtils.dart';

class MyFormPage extends StatefulWidget {
  final String title;
  MyFormPage(this.title);

  @override
  MyFormPageState createState() {
    return MyFormPageState(title: title);
  }
}

class MyFormPageState extends State<MyFormPage> {
  final String title;
  MyFormPageState({Key key, @required this.title});
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  ValueChanged _onChanged = (val) => print(val);
  var climbOptions = [
    'Did not Park or Climb',
    'Parked',
    'Solo Climbed',
    'Climbed First',
    'Climbed Second',
    'Buddy Climb',
    'Carried'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              // autovalidate: true,
              initialValue: {
                'movie_rating': 3,
              },
              readOnly: false,
              child: Column(
                children: <Widget>[
                  //Insert Widgets
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: 'No Show'),
                    attribute: "no_show",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Yes", "No"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration:
                        InputDecoration(labelText: 'Lost Communication'),
                    attribute: "lost_comm",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Yes", "No"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  Text("Pregame"),
                  SizedBox(height: 15),
                  FormBuilderSlider(
                    attribute: "starting_position",
                    validators: [FormBuilderValidators.min(-10)],
                    onChanged: _onChanged,
                    min: -2.0,
                    max: 2.0,
                    initialValue: 0.0,
                    divisions: 4,
                    activeColor: Colors.green,
                    inactiveColor: Colors.green[100],
                    decoration: InputDecoration(
                      labelText: "Starting Position",
                    ),
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: 'Preloaded Cells?'),
                    attribute: "preloaded_cells",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Yes", "No"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  Text("Auton"),
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration:
                        InputDecoration(labelText: 'Left Initiation Line'),
                    attribute: "left_line",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Yes", "No"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Inner Goal"),
                    attribute: "auton_inner",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Outer Goal"),
                    attribute: "auton_outer",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Low Goal"),
                    attribute: "auton_low",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  Text("Teleop"),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Inner Goal"),
                    attribute: "teleop_inner",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Outer Goal"),
                    attribute: "teleop_outer",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Low Goal"),
                    attribute: "teleop_low",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  FormBuilderCheckboxList(
                    decoration:
                        InputDecoration(labelText: "Rotational Control"),
                    attribute: "rotation",
                    leadingInput: true,
                    options: [
                      FormBuilderFieldOption(value: "Succeeded"),
                      FormBuilderFieldOption(value: "Overshot"),
                      FormBuilderFieldOption(value: "Undershot"),
                    ],
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration: InputDecoration(
                        labelText: 'Positional Control Success'),
                    attribute: "position_success",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Yes", "No"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: 'Played Defense'),
                    attribute: "played_defense",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Yes", "No"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Fouls"),
                    attribute: "fouls",
                    initialValue: 0,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.add_circle),
                    subtractIcon: Icon(Icons.remove_circle),
                  ),
                  SizedBox(height: 15),
                  Text('Endgame'),
                  SizedBox(height: 15),
                  FormBuilderDropdown(
                    attribute: "climb",
                    decoration: InputDecoration(
                      labelText: "Climb",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 20,
                        ),
                      ),
                    ),
                    // initialValue: 'Male',
                    hint: Text('Climb Option'),
                    validators: [FormBuilderValidators.required()],
                    items: climbOptions
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text('$option'),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: 'Balance'),
                    attribute: "balance",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Balanced", "Unbalanced", "Not Applicable"]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                        FileUtils.saveToFile(
                            _fbKey.currentState.value.toString(), title);
                        Navigator.pop(context);
                      } else {
                        print("Warning: Submission Failed");
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
