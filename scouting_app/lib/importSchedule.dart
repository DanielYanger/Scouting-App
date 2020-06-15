import 'dart:io';

import 'package:flutter/material.dart';

import 'FileUtils.dart';
import 'home.dart';

class ImportScreen extends StatefulWidget {
  @override
  ImportScreenState createState() => new ImportScreenState();
}

//define this as from the file
String schedule = "";

String fullSchedule() {
  return schedule;
}

List<List<String>> getSchedule(int station, String schedules) {
  List<List<String>> matches = [];
  List<int> teams = [];
  if (schedules.length != 0) {
    List<String> holder = schedules.split(";");
    holder.removeLast();
    if (station != 6) {
      for (String i in holder) {
        matches.add(i.split(","));
      }
    } else if (station == 6) {
      outerLoop:
      for (String i in holder) {
        List<String> temp = i.split(",");
        for (int j in teams) {
          if (int.parse(temp[1]) == j) {
            continue outerLoop;
          }
        }
        teams.add(int.parse(temp[1]));
      }
      teams.sort();
      for (int i in teams) {
        matches.add([i.toString(), "Pit Scouting"]);
      }
    }
  }
  return matches;
}

class ImportScreenState extends State<ImportScreen> {
  Future<File> file;

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
                        file = FileUtils.pickFile;
                        FileUtils.readFile(file).then((data) {
                          FileUtils.saveSchedule(data);
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
