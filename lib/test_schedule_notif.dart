import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:json/model/jadwal_sholat_model.dart';

JadwalModel model;

loadJson() async {
  var str = await rootBundle.loadString('assets/data/jadwal_sholat.json');
  model = JadwalModel.fromJson(jsonDecode(str));
}

class ScheduleNotif extends StatefulWidget {
  ScheduleNotif({Key key}) : super(key: key);

  _ScheduleNotifState createState() => _ScheduleNotifState();
}

class _ScheduleNotifState extends State<ScheduleNotif> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
    print(model);
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Test Load JSON"),
      ),
      body: FutureBuilder(
        future: loadJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.jadwal.length,
              itemBuilder: (BuildContext context, int index) {
                Jadwal jadwal = snapshot.data.jadwal[index];
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
                                        jadwal.notify
                                            ? Icons.alarm
                                            : Icons.alarm_off,
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
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } return CircularProgressIndicator();
        },
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final String payload;
  SecondScreen(this.payload);
  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen with payload: " + _payload),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
