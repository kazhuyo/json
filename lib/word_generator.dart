import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json/model/jadwal_sholat_model.dart';

JadwalModel model;

void main() async {
  await loadJson();
  runApp(MyApp());
  print(model);
}

loadJson() async {
  var str = await rootBundle.loadString('assets/data/jadwal_sholat.json');
  model = JadwalModel.fromJson(jsonDecode(str));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Schedule"),
      ),
      body: ListView.builder(
        itemCount: model.jadwal.length,
        itemBuilder: (BuildContext context, int index) {
          Jadwal jadwal = model.jadwal[index];
          return new GestureDetector(
            onTap: () {
              print('on tap clicked on ' + jadwal.name);
            },
            child: Container(
                height: 45.0,
                decoration: BoxDecoration(),
                child: new Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            child: Text(
                              jadwal.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 10.0),
                              maxLines: 1,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                jadwal.notify = !jadwal.notify;
                              });
                              print(
                                  'clicked on ${jadwal.name}, notified=${jadwal.notify}');
                            },
                            child: new Container(
                                margin: const EdgeInsets.all(0.0),
                                child: new Icon(
                                  jadwal.notify ? Icons.alarm : Icons.alarm_off,
                                  color: Colors.black,
                                  size: 30.0,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
