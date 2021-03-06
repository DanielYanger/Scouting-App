import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoutingapp/formInterpreter.dart';

import 'FileUtils.dart';

class MyPitFormPage extends StatefulWidget {
  final String title;
  MyPitFormPage({Key key, @required this.title}) : super(key: key);

  @override
  MyPitFormPageState createState() {
    return MyPitFormPageState();
  }
}

List<Widget> form = [];

void addWidget(Widget item) {
  form.add(item);
}

List<Widget> getForm() {
  return form;
}

class MyPitFormPageState extends State<MyPitFormPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future<String> _form = FileUtils.readPitForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 1.0, top: 0.0),
        child: FormBuilder(
          key: _fbKey,
          readOnly: false,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return FutureBuilder<String>(
                  future: _form,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children = [];
                    if (snapshot.hasData &&
                        snapshot.data.toString().length > 5) {
                      String fullForm = snapshot.data.toString();
                      children =
                          FormCreator.formCreator(fullForm, children, context);
                      children.add(
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20.0,
                            top: 10.0,
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      int teamNum = int.parse(widget.title
                                          .substring(
                                              widget.title.indexOf(":") + 2));
                                      _fbKey.currentState.setAttributeValue(
                                          "Team Number", teamNum);
                                      print(_fbKey.currentState.value);
                                      print(_fbKey.currentState.toJson());
                                      FileUtils.readAndWriteFromFilePit(
                                              _fbKey.currentState.toJson())
                                          .then((data) {
                                        String test = data;
                                        print(test);
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      print("Warning: Submission Failed");
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    "Reset",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _fbKey.currentState.reset();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      print(children);
                    } else if (snapshot.hasData && snapshot.data.length <= 5) {
                      children = <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            child: ListTile(
                              title: Center(child: Text("No Form Imported!")),
                              subtitle: Text(
                                "Please import a form in the settings.",
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
                          child: Text("Fetching Form"),
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
                  });
            },
          ),
        ),
      ),
    );
  }
}
