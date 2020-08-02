import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/FileUtils.dart';
import 'package:scoutingapp/custom_scouting_icon_icons.dart';
import 'package:scoutingapp/form.dart';

import 'form.dart';
import 'importSchedule.dart' as importSchedule;
import 'pitForm.dart';
import 'settings.dart';
import 'stationSelector.dart' as selector;

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  Future<String> _schedule = FileUtils.readSchedule();
  var isPit = selector.isPit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("624 Scouting App"),
          leading: Icon(
            CustomScoutingIcon.radioactive,
            size: 50,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySettingPage()),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return FutureBuilder<String>(
                future:
                    _schedule, // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData && snapshot.data.toString().length > 5) {
                    String fullSchedule = snapshot.data.toString();
                    int station = selector.getStation();
                    List<List<String>> tempMatch =
                        selector.modifiedSchedule(station, fullSchedule);
                    if (!importSchedule.isTeamOnly() || station == 6) {
                      for (List<String> i in tempMatch) {
                        children.add(
                          Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(75, 229, 229, 229),
                            ),
                            child: Card(
                              child: ListTile(
                                title: Text('${i[0]}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: !isPit
                                            ? (context) => MyFormPage(
                                                title: '${i[0]}: ${i[1]}')
                                            : (context) => MyPitFormPage(
                                                title: '${i[1]}: ${i[0]}')),
                                  );
                                },
                                subtitle: Text("${i[1]}"),
                              ),
                              borderOnForeground: true,
                              shadowColor: Colors.transparent,
                              //color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                    } else {
                      children = <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            child: ListTile(
                              title:
                                  Center(child: Text("No Schedule Imported!")),
                              subtitle: Text(
                                "Please import a schedule in the settings.",
                                textAlign: TextAlign.center,
                              ),
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
                          ),
                        )
                      ];
                    }
                  } else if (snapshot.hasData && snapshot.data.length <= 5) {
                    children = <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          child: ListTile(
                            title: Center(child: Text("No Schedule Imported!")),
                            subtitle: Text(
                              "Please import a schedule in the settings.",
                              textAlign: TextAlign.center,
                            ),
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
                        ),
                      )
                    ];
                  } else {
                    children = <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            value: null,
                          ),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text("Fetching Schedule"),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              );
            }));
  }
}
