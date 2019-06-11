import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:json/model/jadwal_sholat_model.dart';

JadwalModel model;

loadJson() async {
  var str = await rootBundle.loadString('assets/data/jadwal_sholat.json');
  model = JadwalModel.fromJson(jsonDecode(str));
  return model;
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
  }

  Future<void> onSelectNotification(String payload) async {
    debugPrint('print payload : $payload');
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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DateFormat timeFormat;
            timeFormat = new DateFormat('H:m');

            var fajrTime = snapshot.data.jadwal[2].time;
            var dhuhrTime = snapshot.data.jadwal[4].time;
            var asrTime = snapshot.data.jadwal[5].time;
            var magribTime = snapshot.data.jadwal[6].time;
            var ishaTime = snapshot.data.jadwal[7].time;

            DateTime now = DateTime.now();
            now = new DateTime(now.year, now.month, now.day, now.hour,
                now.minute, now.second, now.millisecond);

            DateTime fajr = timeFormat.parse(fajrTime);
            fajr = new DateTime(
                now.year, now.month, now.day, fajr.hour, fajr.minute);

            DateTime dhuhr = timeFormat.parse(dhuhrTime);
            dhuhr = new DateTime(
                now.year, now.month, now.day, dhuhr.hour, dhuhr.minute);

            DateTime asr = timeFormat.parse(asrTime);
            asr = new DateTime(
                now.year, now.month, now.day, asr.hour, asr.minute);

            DateTime magrib = timeFormat.parse(magribTime);
            magrib = new DateTime(
                now.year, now.month, now.day, magrib.hour, magrib.minute);

            DateTime isha = timeFormat.parse(ishaTime);
            isha = new DateTime(
                now.year, now.month, now.day, isha.hour, isha.minute);

            String _toTwoDigitString(int value) {
              return value.toString().padLeft(2, '0');
            }

            Future<void> _showDailyFajrTime() async {
              var time = Time(fajr.hour, fajr.minute, 0);
              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'repeatDailyAtTime channel id',
                  'repeatDailyAtTime channel name',
                  'repeatDailyAtTime description');
              var iOSPlatformChannelSpecifics = IOSNotificationDetails();
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.showDailyAtTime(
                  0,
                  'show daily title',
                  'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
                  time,
                  platformChannelSpecifics);
            }

            Future<void> _showDailyDhuhrTime() async {
              var time = Time(dhuhr.hour, dhuhr.minute, 0);
              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'repeatDailyAtTime channel id',
                  'repeatDailyAtTime channel name',
                  'repeatDailyAtTime description');
              var iOSPlatformChannelSpecifics = IOSNotificationDetails();
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.showDailyAtTime(
                  0,
                  'show daily title',
                  'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
                  time,
                  platformChannelSpecifics);
            }

            Future<void> _showDailyAsrTime() async {
              var time = Time(asr.hour, asr.minute, 0);
              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'repeatDailyAtTime channel id',
                  'repeatDailyAtTime channel name',
                  'repeatDailyAtTime description');
              var iOSPlatformChannelSpecifics = IOSNotificationDetails();
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.showDailyAtTime(
                  0,
                  'show daily title',
                  'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
                  time,
                  platformChannelSpecifics);
            }

            Future<void> _showDailyMagribTime() async {
              var time = Time(magrib.hour, magrib.minute, 0);
              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'repeatDailyAtTime channel id',
                  'repeatDailyAtTime channel name',
                  'repeatDailyAtTime description');
              var iOSPlatformChannelSpecifics = IOSNotificationDetails();
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.showDailyAtTime(
                  0,
                  'show daily title',
                  'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
                  time,
                  platformChannelSpecifics);
            }

            Future<void> _showDailyIshaTime() async {
              var time = Time(isha.hour, isha.minute, 0);
              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'repeatDailyAtTime channel id',
                  'repeatDailyAtTime channel name',
                  'repeatDailyAtTime description');
              var iOSPlatformChannelSpecifics = IOSNotificationDetails();
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.showDailyAtTime(
                  0,
                  'show daily title',
                  'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
                  time,
                  platformChannelSpecifics);
            }

            return ListView.builder(
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
          }
          return CircularProgressIndicator();
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
