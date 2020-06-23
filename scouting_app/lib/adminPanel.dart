import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoutingapp/FileUtils.dart';

import 'home.dart';

class AdminPage extends StatefulWidget {
  @override
  AdminPageState createState() {
    return AdminPageState();
  }
}

class AdminPageState extends State<AdminPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(
                Icons.delete,
                size: 50,
              ),
              title: Text("Clear Forms"),
              subtitle: Text("Clear all forms and schedule"),
              onTap: () async {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        title: const Text("Confirm"),
                        content: Container(
                          height: 129,
                          child: Column(
                            children: <Widget>[
                              Text(
                                  "Are you sure you wish to clear all forms and schedule?"),
                              SizedBox(
                                height: 10,
                              ),
                              FormBuilder(
                                key: _formKey,
                                child: FormBuilderTextField(
                                  attribute: "password",
                                  validators: [
                                    FormBuilderValidators.required(),
                                    // ignore: missing_return
                                    (val) {
                                      if (val != "CRyptonite2001")
                                        return "Incorrect Password";
                                    },
                                  ],
                                  maxLines: 1,
                                  obscureText: true,
                                  decoration:
                                      InputDecoration(labelText: "Password"),
                                ),
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("CONFIRM"),
                            onPressed: () {
                              print(_formKey);
                              if (_formKey.currentState.saveAndValidate()) {
                                try {
                                  FileUtils.deleteData();
                                } catch (e) {}
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                  (Route<dynamic> route) => false,
                                );
                              }
                            },
                          ),
                          FlatButton(
                            child: Text("CANCEL"),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      );
                    });
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.clear,
                size: 50,
              ),
              title: Text("Clear Data"),
              subtitle: Text("Clear all data"),
              onTap: () async {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        content: Container(
                          height: 129,
                          child: Column(
                            children: <Widget>[
                              Text("Are you sure you wish to clear ALL data?"),
                              SizedBox(
                                height: 10,
                              ),
                              FormBuilder(
                                key: _fbKey,
                                child: FormBuilderTextField(
                                  attribute: "password",
                                  validators: [
                                    FormBuilderValidators.required(),
                                    // ignore: missing_return
                                    (val) {
                                      if (val != "CRyptonite2001")
                                        return "Incorrect Password";
                                    },
                                  ],
                                  maxLines: 1,
                                  obscureText: true,
                                  decoration:
                                      InputDecoration(labelText: "Password"),
                                ),
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("CONFIRM"),
                            onPressed: () {
                              print(_fbKey);
                              if (_fbKey.currentState.saveAndValidate()) {
                                try {
                                  FileUtils.deleteData();
                                } catch (e) {}
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                  (Route<dynamic> route) => false,
                                );
                              }
                            },
                          ),
                          FlatButton(
                            child: Text("CANCEL"),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
