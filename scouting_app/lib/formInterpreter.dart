import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormCreator {
  static List<FormBuilderFieldOption> createSetCheckbox(List<String> list) {
    List<FormBuilderFieldOption> result = [];
    for (String i in list) {
      result.add(FormBuilderFieldOption(
        value: i,
      ));
    }
    return result;
  }

  static List<DropdownMenuItem<dynamic>> createSetDropdown(List<dynamic> list) {
    List<DropdownMenuItem> result = new List<DropdownMenuItem>();
    print(list);
    result = list
        .map((option) => DropdownMenuItem(
              child: Text('$option'),
              value: option,
            ))
        .toList();
    return result;
  }

  static formCreator(
      String stringForm, List<Widget> form, BuildContext context) {
    form.clear();
    List<String> separatedForm = stringForm.split(";");
    separatedForm.removeLast();
    for (String i in separatedForm) {
      i = i.substring(1, i.length - 1);
      List<String> tempWidget = i.split(",");
      //break

      if (tempWidget[0] == "FormBuilderRadio") {
        List<String> options = [];
        for (int i = 2; i < tempWidget.length; i++) {
          options.add(tempWidget[i]);
        }
        form.add(Padding(
          padding: const EdgeInsets.all(15.0),
          child: new FormBuilderRadio(
            attribute: tempWidget[1],
            options: options
                .map((lang) => FormBuilderFieldOption(
                      value: lang,
                      child: Text('$lang'),
                    ))
                .toList(growable: false),
            decoration: InputDecoration(
              labelText: tempWidget[1],
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            ),
            leadingInput: true,
            validators: [FormBuilderValidators.required()],
            activeColor: Theme.of(context).primaryColor,
          ),
        ));
      }
      //break

      else if (tempWidget[0] == "FormBuilderCheckboxList") {
        List<String> options = [];
        for (int i = 2; i < tempWidget.length; i++) {
          options.add(tempWidget[i]);
        }
        form.add(
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new FormBuilderCheckboxList(
              activeColor: Theme
                  .of(context)
                  .primaryColor,
              attribute: tempWidget[1],
              options: createSetCheckbox(options),
              decoration: InputDecoration(
                labelText: tempWidget[1],
                labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        );
      }
      //break

      else if (tempWidget[0] == "FormBuilderBoolean") {
        form.add(Padding(
          padding: const EdgeInsets.all(15.0),
          child: new FormBuilderRadio(
            attribute: tempWidget[1],
            options: ["Yes", "No"]
                .map((lang) =>
                FormBuilderFieldOption(
                  value: lang,
                  child: Text('$lang'),
                ))
                .toList(growable: false),
            validators: [FormBuilderValidators.required()],
            decoration: InputDecoration(
              labelText: tempWidget[1],
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            ),
            activeColor: Theme
                .of(context)
                .primaryColor,
          ),
        ));
      }
      //break

      else if (tempWidget[0] == "FormBuilderTouchSpin") {
        form.add(Padding(
          padding: const EdgeInsets.all(15.0),
          child: new FormBuilderTouchSpin(
            attribute: tempWidget[1],
            decoration: InputDecoration(
              labelText: tempWidget[1],
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            ),
            initialValue: 0,
            step: 1,
            iconSize: 48.0,
            min: 0,
            addIcon: Icon(Icons.add_circle),
            subtractIcon: Icon(Icons.remove_circle),
          ),
        ));
      }
      //break

      else if (tempWidget[0] == "FormBuilderDropdown") {
        List<String> options = [];
        for (int i = 3; i < tempWidget.length; i++) {
          options.add(tempWidget[i]);
        }
        form.add(
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new FormBuilderDropdown(
              attribute: tempWidget[1],
              decoration: InputDecoration(
                labelText: tempWidget[1],
                labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
              hint: Text(tempWidget[2]),
              validators: [FormBuilderValidators.required()],
              items: createSetDropdown(options),
            ),
          ),
        );
      }
      //break

      else if (tempWidget[0] == "FormBuilderSlider") {
        form.add(Padding(
          padding: const EdgeInsets.all(15.0),
          child: new FormBuilderSlider(
            attribute: tempWidget[1],
            min: double.parse(tempWidget[2]),
            max: double.parse(tempWidget[3]),
            initialValue: double.parse(tempWidget[4]),
            divisions: int.parse(tempWidget[5]),
            decoration: InputDecoration(
              labelText: tempWidget[1],
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ));
      }
      //break

      else if (tempWidget[0] == "FormBuilderTextField") {
        form.add(
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new FormBuilderTextField(
              attribute: tempWidget[1],
              decoration: InputDecoration(
                labelText: tempWidget[1],
                labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        );
      }
      //break

      else if (tempWidget[0] == "Divider") {
        form.add(
          new Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                tempWidget[1],
                style: TextStyle(
                  fontSize: double.parse(tempWidget[2]),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }
    }

    return form;
  }
}
