import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/FileUtils.dart';
import 'package:scoutingapp/formInterpreter.dart';

import 'home.dart';
import 'pitForm.dart' as FormBuilder;

class PitFormReader extends StatefulWidget {
  final String stringForm;

  PitFormReader({Key key, this.stringForm}) : super(key: key);

  @override
  PitFormReaderState createState() {
    return PitFormReaderState();
  }
}

class PitFormReaderState extends State<PitFormReader> {
  Future<File> file;
  String stringForm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Pit Scouting Form"),
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
                          FileUtils.savePitForm(data);
                          stringForm = data;
                          FormCreator.formCreator(
                              stringForm, FormBuilder.getForm(), context);
                        });
                      },
                      child: new Text("Choose Pit Scouting Form"),
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
