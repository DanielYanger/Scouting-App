import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'home.dart';
import 'form.dart' as FormBuilder;


class PitFormReader extends StatefulWidget {
  final String stringForm;

  PitFormReader({Key key, this.stringForm}) : super(key: key);
  @override
  PitFormReaderState createState() {
    return PitFormReaderState();
  }
}

List<Widget> finalForm = [];

List<Widget> getForm() {
  return finalForm;
}

List<FormBuilderFieldOption> createSetCheckbox(List<String> list) {
  List<FormBuilderFieldOption> result = [];
  for (String i in list) {
    result.add(FormBuilderFieldOption(
      value: i,
    ));
  }
  return result;
}

List<DropdownMenuItem<dynamic>> createSetDropdown(List<dynamic> list) {
  List<DropdownMenuItem> result = new List<DropdownMenuItem>();
  print(list);
  result = list
      .map((option) => DropdownMenuItem(
    child: Text('$option'),
    value: option,
  ))
      .toList();
  print(result);
  return result;
}

class PitFormReaderState extends State<PitFormReader> {
  Future<File> file;
  String stringForm = "";

  static Future<File> get pickFile async {
    print('debug');
    Future<File> file = FilePicker.getFile(type: FileType.any);
    return file;
  }

  static Future<String> readFile(Future<File> file) async {
    final schedule = await file;
    print("test");
    return schedule.readAsString();
  }

  void formCreator(String stringForm) {
    FormBuilder.form.clear();
    List<String> separatedForm = stringForm.split(";");
    separatedForm.removeLast();
    print(separatedForm);

    for (String i in separatedForm) {
      FormBuilder.addWidget(SizedBox(
        height: 15,
      ));
      i = i.substring(1, i.length - 1);
      print(i);
      List<String> tempWidget = i.split(",");
      //break

      if (tempWidget[0] == "FormBuilderRadio") {
        List<String> options = [];
        for (int i = 2; i < tempWidget.length; i++) {
          options.add(tempWidget[i]);
        }
        FormBuilder.addWidget(new FormBuilderRadio(
          attribute: tempWidget[1],
          options: options
              .map((lang) => FormBuilderFieldOption(
            value: lang,
            child: Text('$lang'),
          ))
              .toList(growable: false),
          decoration: InputDecoration(labelText: tempWidget[1]),
          leadingInput: true,
          validators: [FormBuilderValidators.required()],
        ));
        print(FormBuilder.form);
      }
      //break

      else if (tempWidget[0] == "FormBuilderCheckboxList") {
        List<String> options = [];
        for (int i = 2; i < tempWidget.length; i++) {
          options.add(tempWidget[i]);
        }
        FormBuilder.addWidget(
          new FormBuilderCheckboxList(
            attribute: tempWidget[1],
            options: createSetCheckbox(options),
            decoration: InputDecoration(labelText: tempWidget[1]),
          ),
        );
        print(FormBuilder.form);
      }
      //break

      else if (tempWidget[0] == "FormBuilderBoolean") {
        FormBuilder.addWidget(new FormBuilderRadio(
          attribute: tempWidget[1],
          options: ["Yes", "No"]
              .map((lang) => FormBuilderFieldOption(
            value: lang,
            child: Text('$lang'),
          ))
              .toList(growable: false),
          validators: [FormBuilderValidators.required()],
          decoration: InputDecoration(labelText: tempWidget[1]),
        ));
        print("YEEEEET");
        print(FormBuilder.form);
      }
      //break

      else if (tempWidget[0] == "FormBuilderTouchSpin") {
        FormBuilder.addWidget(new FormBuilderTouchSpin(
          attribute: tempWidget[1],
          decoration: InputDecoration(labelText: tempWidget[1]),
          initialValue: 0,
          step: 1,
          iconSize: 48.0,
          min: 0,
          addIcon: Icon(Icons.add_circle),
          subtractIcon: Icon(Icons.remove_circle),
        ));
      }
      //break

      else if (tempWidget[0] == "FormBuilderDropdown") {
        List<String> options = [];
        for (int i = 3; i < tempWidget.length; i++) {
          options.add(tempWidget[i]);
        }
        FormBuilder.addWidget(
          new FormBuilderDropdown(
            attribute: tempWidget[1],
            decoration: InputDecoration(
              labelText: tempWidget[1],
            ),
            hint: Text(tempWidget[2]),
            validators: [FormBuilderValidators.required()],
            items: createSetDropdown(options),
          ),
        );
      }
      //break

      else if (tempWidget[0] == "FormBuilderSlider") {
        FormBuilder.addWidget(new FormBuilderSlider(
          attribute: tempWidget[1],
          min: double.parse(tempWidget[2]),
          max: double.parse(tempWidget[3]),
          initialValue: double.parse(tempWidget[4]),
          divisions: int.parse(tempWidget[5]),
          decoration: InputDecoration(
            labelText: tempWidget[1],
          ),
        ));
      }
      //break

      else if (tempWidget[0] == "FormBuilderTextField") {
        FormBuilder.addWidget(new FormBuilderTextField(
          attribute: tempWidget[1],
          decoration: InputDecoration(
            labelText: tempWidget[1],
          ),
        ));
      }
      //break

      else if (tempWidget[0] == "Divider") {
        FormBuilder.addWidget(
          new Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
                child: Text(tempWidget[1],
                    style: TextStyle(fontSize: double.parse(tempWidget[2])))),
          ),
        );
      }
    }

    print(FormBuilder.form);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Form"),
      ),
      body: new Center(
          child: new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Column(
                      children: <Widget>[
                        new RaisedButton(
                          onPressed: () {
                            file = pickFile;
                            readFile(file).then((data) {
                              stringForm = data;
                              print("File Picked");
                              formCreator(stringForm);
                            });
                          },
                          child: new Text("Choose Form"),
                        ),
                        new RaisedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: new Text("Import"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
