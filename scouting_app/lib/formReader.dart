import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/FileUtils.dart';
import 'package:scoutingapp/formInterpreter.dart';

import 'form.dart' as FormBuilder;
import 'home.dart';

class FormReader extends StatefulWidget {
  final String stringForm;

  FormReader({Key key, this.stringForm}) : super(key: key);

  @override
  FormReaderState createState() {
    return FormReaderState();
  }
}

class FormReaderState extends State<FormReader> {
  Future<File> file;
  String stringForm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Match Form"),
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
                        file = FileUtils.pickFile;
                        FileUtils.readFile(file).then((data) {
                          FileUtils.saveForm(data);
                          stringForm = data;
                          print("File Picked");
                          FormCreator.formCreator(
                              stringForm, FormBuilder.getForm(), context);
                        });
                      },
                      child: new Text("Choose Match Form"),
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
