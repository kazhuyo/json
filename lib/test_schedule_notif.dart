import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'model/jadwal_sholat_model.dart';

Future<String> _loadJadwalAsset() async {
  return await rootBundle.loadString('assets/data/jadwal_sholat.json');
}

Future<JadwalModel> loadJadwal() async {
  String jsonString = await _loadJadwalAsset();
  final jsonResponse = json.decode(jsonString);
  return new JadwalModel.fromJson(jsonResponse);
}

class ScheduleNotif extends StatefulWidget {
  ScheduleNotif({Key key}) : super(key: key);

  _ScheduleNotifState createState() => _ScheduleNotifState();
}

class _ScheduleNotifState extends State<ScheduleNotif> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool _isNotify = true;

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
        title: new Text("Test Schedule"),
      ),
      body: Container(
        child: FutureBuilder<JadwalModel>(
          future: loadJadwal(),
          builder: (context, snapshot) {
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

              Future<void> _showDailyFajr() async {
                var time = Time(fajr.hour, fajr.minute, 0);
                var androidPlatformChannelSpecifics =
                    AndroidNotificationDetails(
                        'repeatDailyAtTime channel id',
                        'repeatDailyAtTime channel name',
                        'repeatDailyAtTime description');
                var iOSPlatformChannelSpecifics = IOSNotificationDetails();
                var platformChannelSpecifics = NotificationDetails(
                    androidPlatformChannelSpecifics,
                    iOSPlatformChannelSpecifics);
                await flutterLocalNotificationsPlugin.showDailyAtTime(
                    0,
                    'show daily title',
                    'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
                    time,
                    platformChannelSpecifics);
              }

              void _toggleNotify() {
                setState(() {
                  if (_isNotify) {
                    print("false");
                    _isNotify = false;
                  } else {
                    print("true");
                    _isNotify = true;
                  }
                });
              }

              // return Text("data");
              return Container(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.jadwal.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Text(snapshot.data.jadwal[index].name ),
                              Row(
                                children: <Widget>[
                                  Text(snapshot.data.jadwal[index].time),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0),
                                  ),
                                  // TODO : Trigger boolean setstate & initstate to alarm icons.
                                  //  onPressed should running setstate with condition :
                                  //  if true trigger method ScheduledNotification using channel = ID jadwal sholat, title = Jadwal Sholat, body = Memasuki Waktu Sholat "${snapshot.data.jadwal[index].name}".
                                  //  if false then run method flutterLocalNotificationsPlugin.cancel(ID Jadwal Sholat)
                                  IconButton(
                                    icon: _isNotify
                                        ? Icon(Icons.alarm)
                                        : Icon(Icons.alarm_off),
                                    onPressed: _toggleNotify,
                                    // onPressed: () =>
                                    //     setState(() => _isNotify = !_isNotify),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: new Divider(),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container();
          },
        ),
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
