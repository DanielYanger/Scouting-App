import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'FileUtils.dart';

class MyPitFormPage extends StatefulWidget {
  final String title;
  //final List<Widget> form;
  MyPitFormPage({Key key, @required this.title}) : super(key: key);

  @override
  MyPitFormPageState createState() {
    return MyPitFormPageState();
  }
}

List<Widget> form = [];

void addWidget(Widget item) {
  form.add(item);
}

class MyPitFormPageState extends State<MyPitFormPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
              key: _fbKey,
              readOnly: false,
              child: ListView.builder(
                itemCount:
                    form != null && form.isNotEmpty ? form.length + 1 : 1,
                itemBuilder: form != null && form.isNotEmpty
                    ? (context, index) {
                        //Import Form
                        return (index < form.length)
                            ? Column(
                                children: <Widget>[form[index]],
                              )
                            : Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MaterialButton(
                                      color: Theme.of(context).accentColor,
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (_fbKey.currentState
                                            .saveAndValidate()) {
                                          int teamNum = int.parse(widget.title
                                              .substring(
                                                  widget.title.indexOf(":") +
                                                      2));
                                          _fbKey.currentState.setAttributeValue(
                                              "Team Number", teamNum);
                                          print(_fbKey.currentState.value);
                                          print(_fbKey.currentState.toJson());
                                          FileUtils.pitSaveToFileJSON(
                                              _fbKey.currentState.toJson(),
                                              widget.title);
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
                              );
                      }
                    : (context, index) {
                        return Card(
                          child: ListTile(
                            title: Center(child: Text("No Pit Form Imported!")),
                            subtitle: Center(
                                child: Text(
                              "Please import a pit form in the settings.",
                              textAlign: TextAlign.center,
                            )),
                            isThreeLine: true,
                            leading: Icon(
                              Icons.warning,
                              size: 50,
                              color: Colors.red,
                            ),
                            trailing: Icon(
                              Icons.warning,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
              )),
        ));
  }
}

//Padding(
//        padding: EdgeInsets.all(10),
//        child: ListView(
//          children: <Widget>[
//            FormBuilder(
//              // context,
//              key: _fbKey,
//              // autovalidate: true,
//              readOnly: false,
//              child: Column(
//                children: <Widget>[
//                  //Insert Widgets
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration: InputDecoration(labelText: 'No Show'),
//                    attribute: "no_show",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Yes", "No"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration:
//                        InputDecoration(labelText: 'Lost Communication'),
//                    attribute: "lost_comm",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Yes", "No"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                  Text("Pregame"),
//                  SizedBox(height: 15),
//                  FormBuilderSlider(
//                    attribute: "starting_position",
//                    validators: [FormBuilderValidators.min(-10)],
//                    onChanged: _onChanged,
//                    min: -2.0,
//                    max: 2.0,
//                    initialValue: 0.0,
//                    divisions: 4,
//                    activeColor: Colors.green,
//                    inactiveColor: Colors.green[100],
//                    decoration: InputDecoration(
//                      labelText: "Starting Position",
//                    ),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration: InputDecoration(labelText: 'Preloaded Cells?'),
//                    attribute: "preloaded_cells",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Yes", "No"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                  Text("Auton"),
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration:
//                        InputDecoration(labelText: 'Left Initiation Line'),
//                    attribute: "left_line",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Yes", "No"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Inner Goal"),
//                    attribute: "auton_inner",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Outer Goal"),
//                    attribute: "auton_outer",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Low Goal"),
//                    attribute: "auton_low",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  Text("Teleop"),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Inner Goal"),
//                    attribute: "teleop_inner",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Outer Goal"),
//                    attribute: "teleop_outer",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Low Goal"),
//                    attribute: "teleop_low",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderCheckboxList(
//                    decoration:
//                        InputDecoration(labelText: "Rotational Control"),
//                    attribute: "rotation",
//                    leadingInput: true,
//                    options: [
//                      FormBuilderFieldOption(value: "Succeeded"),
//                      FormBuilderFieldOption(value: "Overshot"),
//                      FormBuilderFieldOption(value: "Undershot"),
//                    ],
//                    onChanged: _onChanged,
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration: InputDecoration(
//                        labelText: 'Positional Control Success'),
//                    attribute: "position_success",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Yes", "No"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration: InputDecoration(labelText: 'Played Defense'),
//                    attribute: "played_defense",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Yes", "No"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderTouchSpin(
//                    decoration: InputDecoration(labelText: "Fouls"),
//                    attribute: "fouls",
//                    initialValue: 0,
//                    step: 1,
//                    iconSize: 48.0,
//                    addIcon: Icon(Icons.add_circle),
//                    subtractIcon: Icon(Icons.remove_circle),
//                  ),
//                  SizedBox(height: 15),
//                  Text('Endgame'),
//                  SizedBox(height: 15),
//                  FormBuilderDropdown(
//                    attribute: "climb",
//                    decoration: InputDecoration(
//                      labelText: "Climb",
//                      border: UnderlineInputBorder(
//                        borderSide: BorderSide(
//                          color: Colors.green,
//                          width: 20,
//                        ),
//                      ),
//                    ),
//                    hint: Text('Climb Option'),
//                    validators: [FormBuilderValidators.required()],
//                    items: climbOptions
//                        .map((option) => DropdownMenuItem(
//                              value: option,
//                              child: Text('$option'),
//                            ))
//                        .toList(),
//                  ),
//                  SizedBox(height: 15),
//                  FormBuilderRadio(
//                    decoration: InputDecoration(labelText: 'Balance'),
//                    attribute: "balance",
//                    leadingInput: true,
//                    onChanged: _onChanged,
//                    validators: [FormBuilderValidators.required()],
//                    options: ["Balanced", "Unbalanced", "Not Applicable"]
//                        .map((lang) => FormBuilderFieldOption(
//                              value: lang,
//                              child: Text('$lang'),
//                            ))
//                        .toList(growable: false),
//                  ),
//                  SizedBox(height: 15),
//                ],
//              ),
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: MaterialButton(
//                    color: Theme.of(context).accentColor,
//                    child: Text(
//                      "Submit",
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
//                      if (_fbKey.currentState.saveAndValidate()) {
//                        print(_fbKey.currentState.value);
//                        FileUtils.saveToFile(
//                            _fbKey.currentState.value.toString(), widget.title);
//                        Navigator.pop(context);
//                      } else {
//                        print("Warning: Submission Failed");
//                      }
//                    },
//                  ),
//                ),
//                SizedBox(
//                  width: 20,
//                ),
//                Expanded(
//                  child: MaterialButton(
//                    color: Theme.of(context).accentColor,
//                    child: Text(
//                      "Reset",
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
//                      _fbKey.currentState.reset();
//                    },
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),

/*Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                readOnly: false,
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      itemCount:
                          form != null && form.isNotEmpty ? form.length : 1,
                      itemBuilder: form != null && form.isNotEmpty
                          ? (context, index) {
                              //Import Form
                              return (form[index]);
                            }
                          : (context, index) {
                              return Card(
                                child: ListTile(
                                  title:
                                      Center(child: Text("No Form Imported!")),
                                  subtitle: Center(
                                      child: Text(
                                          "Please import a form in the settings.")),
                                  isThreeLine: true,
                                  leading: Icon(
                                    Icons.warning,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                  trailing: Icon(
                                    Icons.warning,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                    ),
                    ListView.builder(
                        itemBuilder: form != null && form.isNotEmpty
                            ? (context, index) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: MaterialButton(
                                        color: Theme.of(context).accentColor,
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (_fbKey.currentState
                                              .saveAndValidate()) {
                                            print(_fbKey.currentState.value);
                                            FileUtils.saveToFile(
                                                _fbKey.currentState.value
                                                    .toString(),
                                                widget.title);
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
                                );
                              }
                            : (context, index) {
                                return;
                              }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
