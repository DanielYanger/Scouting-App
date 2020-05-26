import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/form.dart';

import 'form.dart';
import 'settings.dart';
import 'stationSelector.dart' as selector;

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  var station;
  var items = selector.modifiedSchedule();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("624 Scouting"),
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
        itemCount: items != null && items.isNotEmpty ? items.length : 1,
        itemBuilder: items != null && items.isNotEmpty
            ? (context, index) {
                return Card(
                  child: ListTile(
                      title: Text('${items[index][0]}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFormPage(
                                  '${items[index][0]}: ${items[index][1]}')),
                        );
                      },
                      subtitle: Text("${items[index][1]}")),
                );
              }
            : (context, index) {
                return Card(
                  child: ListTile(
                    title: Center(child: Text("No Schedule Imported!")),
                    subtitle: Center(
                        child:
                            Text("Please import a schedule in the settings.")),
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
    );
  }
}
