import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Form',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          // labelStyle: TextStyle(color: Colors.purple),
          border: OutlineInputBorder(
            gapPadding: 10,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
