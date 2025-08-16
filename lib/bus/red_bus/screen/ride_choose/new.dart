import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckBoxListTileDemo extends StatefulWidget {
  @override
  CheckBoxListTileDemoState createState() => new CheckBoxListTileDemoState();
}

class CheckBoxListTileDemoState extends State<CheckBoxListTileDemo> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();

  @override
  Widget build(BuildContext context) {
    void itemChange(bool val, int index) {
      print('object');
      setState(() {
        checkBoxListTileModel[index].isCheck = val;
      });
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text(
          'CheckBox ListTile Demo',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new ListView.builder(
          itemCount: checkBoxListTileModel.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    new CheckboxListTile(
                        activeColor: Colors.red,
                        dense: true,
                        //font change
                        title: new Text(
                          checkBoxListTileModel[index].title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        value: checkBoxListTileModel[index].isCheck,
                        onChanged: (val) {
                          itemChange(val!, index);

                          print(val);
                          print(index);
                        })
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class CheckBoxListTileModel {
  int userId;

  String title;
  bool isCheck;

  CheckBoxListTileModel(
      {required this.userId, required this.title, required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(userId: 1, title: "Android", isCheck: true),
      CheckBoxListTileModel(userId: 2, title: "Flutter", isCheck: false),
      CheckBoxListTileModel(userId: 3, title: "IOS", isCheck: false),
      CheckBoxListTileModel(userId: 4, title: "PHP", isCheck: false),
      CheckBoxListTileModel(userId: 5, title: "Node", isCheck: false),
    ];
  }
}
