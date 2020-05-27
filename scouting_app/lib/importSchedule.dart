import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class ImportScreen extends StatefulWidget {
  @override
  ImportScreenState createState() => new ImportScreenState();
}

String schedule = "";

List<List<String>> getSchedule() {
  List<List<String>> matches = [];
  if (schedule.length != 0) {
    List<String> holder = schedule.split(";");
    for (String i in holder) {
      matches.add(i.split(","));
    }
  }
  return matches;
}

class ImportScreenState extends State<ImportScreen> {
  Future<File> file;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Import Schedule")),
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
                          schedule = data;
                          print("File Picked");
                          print(schedule);
                        });
                      },
                      child: new Text("Choose Schedule"),
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
