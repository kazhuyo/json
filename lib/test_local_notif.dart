import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'dart:async';

import 'model/jadwal_sholat_model.dart';

// import 'package:slide_countdown_clock/slide_countdown_clock.dart';

void main() => runApp(new MaterialApp(home: new MyHomePage()));

Future<String> _loadJadwalAsset() async {
  return await rootBundle.loadString('assets/data/jadwal_sholat.json');
}

Future<JadwalModel> loadJadwal() async {
  String jsonString = await _loadJadwalAsset();
  final jsonResponse = json.decode(jsonString);
  return new JadwalModel.fromJson(jsonResponse);
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final textStyle = TextStyle(
    wordSpacing: 0.1,
    fontFamily: "SFProDisplay",
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

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

  Future<void> selectNotification(String payload) async {
    debugPrint('print payload : $payload');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: new Text('Notification'),
            content: new Text('$payload'),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Test Notif"),
      ),
      body: FutureBuilder<JadwalModel>(
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

            DateTime close = timeFormat.parse("23:59");
            close = new DateTime(
                now.year, now.month, now.day, close.hour, close.minute);

            DateTime reset = timeFormat.parse("00:00");
            reset = new DateTime(
                now.year, now.month, now.day, reset.hour, reset.minute);

            var countFajr = fajr.difference(now);
            var countDhuhr = dhuhr.difference(now);
            var countAsr = asr.difference(now);
            var countMagrib = magrib.difference(now);
            var countIsha = isha.difference(now);
            var countClose = close.difference(now) + fajr.difference(reset);

            Future<void> _scheduleFajrNotification() async {
              var scheduledNotificationDateTime =
                  DateTime.now().add(Duration(seconds: countFajr.inSeconds));
              var vibrationPattern = Int64List(4);
              vibrationPattern[0] = 0;
              vibrationPattern[1] = 1000;
              vibrationPattern[2] = 5000;
              vibrationPattern[3] = 2000;

              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'your other channel id',
                  'your other channel name',
                  'your other channel description',
                  icon: 'secondary_icon',
                  sound: 'slow_spring_board',
                  largeIcon: 'sample_large_icon',
                  largeIconBitmapSource: BitmapSource.Drawable,
                  vibrationPattern: vibrationPattern,
                  enableLights: true,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  ledColor: const Color.fromARGB(255, 255, 0, 0),
                  ledOnMs: 1000,
                  ledOffMs: 500);
              var iOSPlatformChannelSpecifics =
                  IOSNotificationDetails(sound: "slow_spring_board.aiff");
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.schedule(
                  snapshot.data.jadwal[2].id,
                  'Jadwal Sholat',
                  'Memasuki Waktu Sholat Subuh',
                  scheduledNotificationDateTime,
                  platformChannelSpecifics);
            }

            Future<void> _scheduleDhuhrNotification() async {
              var scheduledNotificationDateTime =
                  DateTime.now().add(Duration(seconds: countDhuhr.inSeconds));
              var vibrationPattern = Int64List(4);
              vibrationPattern[0] = 0;
              vibrationPattern[1] = 1000;
              vibrationPattern[2] = 5000;
              vibrationPattern[3] = 2000;

              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'your other channel id',
                  'your other channel name',
                  'your other channel description',
                  icon: 'secondary_icon',
                  sound: 'slow_spring_board',
                  largeIcon: 'sample_large_icon',
                  largeIconBitmapSource: BitmapSource.Drawable,
                  vibrationPattern: vibrationPattern,
                  enableLights: true,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  ledColor: const Color.fromARGB(255, 255, 0, 0),
                  ledOnMs: 1000,
                  ledOffMs: 500);
              var iOSPlatformChannelSpecifics =
                  IOSNotificationDetails(sound: "slow_spring_board.aiff");
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.schedule(
                  0,
                  'Jadwal Sholat',
                  'Memasuki Waktu Sholat Dhuhr',
                  scheduledNotificationDateTime,
                  platformChannelSpecifics);
            }

            Future<void> _scheduleAsrNotification() async {
              var scheduledNotificationDateTime =
                  DateTime.now().add(Duration(seconds: countAsr.inSeconds));
              var vibrationPattern = Int64List(4);
              vibrationPattern[0] = 0;
              vibrationPattern[1] = 1000;
              vibrationPattern[2] = 5000;
              vibrationPattern[3] = 2000;

              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'your other channel id',
                  'your other channel name',
                  'your other channel description',
                  icon: 'secondary_icon',
                  sound: 'slow_spring_board',
                  largeIcon: 'sample_large_icon',
                  largeIconBitmapSource: BitmapSource.Drawable,
                  vibrationPattern: vibrationPattern,
                  enableLights: true,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  ledColor: const Color.fromARGB(255, 255, 0, 0),
                  ledOnMs: 1000,
                  ledOffMs: 500);
              var iOSPlatformChannelSpecifics =
                  IOSNotificationDetails(sound: "slow_spring_board.aiff");
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.schedule(
                  0,
                  'Jadwal Sholat',
                  'Memasuki Waktu Sholat Asr',
                  scheduledNotificationDateTime,
                  platformChannelSpecifics);
            }

            Future<void> _scheduleMagribNotification() async {
              var scheduledNotificationDateTime =
                  DateTime.now().add(Duration(seconds: countMagrib.inSeconds));
              var vibrationPattern = Int64List(4);
              vibrationPattern[0] = 0;
              vibrationPattern[1] = 1000;
              vibrationPattern[2] = 5000;
              vibrationPattern[3] = 2000;

              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'your other channel id',
                  'your other channel name',
                  'your other channel description',
                  icon: 'secondary_icon',
                  sound: 'slow_spring_board',
                  largeIcon: 'sample_large_icon',
                  largeIconBitmapSource: BitmapSource.Drawable,
                  vibrationPattern: vibrationPattern,
                  enableLights: true,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  ledColor: const Color.fromARGB(255, 255, 0, 0),
                  ledOnMs: 1000,
                  ledOffMs: 500);
              var iOSPlatformChannelSpecifics =
                  IOSNotificationDetails(sound: "slow_spring_board.aiff");
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.schedule(
                  0,
                  'Jadwal Sholat',
                  'Memasuki Waktu Sholat Magrib',
                  scheduledNotificationDateTime,
                  platformChannelSpecifics);
            }

            Future<void> _scheduleIshaNotification() async {
              var scheduledNotificationDateTime =
                  DateTime.now().add(Duration(seconds: countIsha.inSeconds));
              var vibrationPattern = Int64List(4);
              vibrationPattern[0] = 0;
              vibrationPattern[1] = 1000;
              vibrationPattern[2] = 5000;
              vibrationPattern[3] = 2000;

              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'your other channel id',
                  'your other channel name',
                  'your other channel description',
                  icon: 'secondary_icon',
                  sound: 'slow_spring_board',
                  largeIcon: 'sample_large_icon',
                  largeIconBitmapSource: BitmapSource.Drawable,
                  vibrationPattern: vibrationPattern,
                  enableLights: true,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  ledColor: const Color.fromARGB(255, 255, 0, 0),
                  ledOnMs: 1000,
                  ledOffMs: 500);
              var iOSPlatformChannelSpecifics =
                  IOSNotificationDetails(sound: "slow_spring_board.aiff");
              var platformChannelSpecifics = NotificationDetails(
                  androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
              await flutterLocalNotificationsPlugin.schedule(
                  0,
                  'Jadwal Sholat',
                  'Memasuki Waktu Sholat Isha',
                  scheduledNotificationDateTime,
                  platformChannelSpecifics);
            }

            if ((now.isAfter(reset) && now.isBefore(fajr)) == true) {
              return new SlideCountdownClock(
                duration: Duration(seconds: countFajr.inSeconds),
                slideDirection: SlideDirection.Down,
                separator: ":",
                textStyle: textStyle,
                onDone: _scheduleFajrNotification,
              );
            } else if ((now.isAfter(fajr) && now.isBefore(dhuhr)) == true) {
              return new SlideCountdownClock(
                duration: Duration(seconds: countDhuhr.inSeconds),
                slideDirection: SlideDirection.Down,
                separator: ":",
                textStyle: textStyle,
                onDone: _scheduleDhuhrNotification,
              );
            } else if ((now.isAfter(dhuhr) && now.isBefore(asr)) == true) {
              return new SlideCountdownClock(
                duration: Duration(seconds: countAsr.inSeconds),
                slideDirection: SlideDirection.Down,
                separator: ":",
                textStyle: textStyle,
                onDone: _scheduleAsrNotification,
              );
            } else if ((now.isAfter(asr) && now.isBefore(magrib)) == true) {
              return new SlideCountdownClock(
                duration: Duration(seconds: countMagrib.inSeconds),
                slideDirection: SlideDirection.Down,
                separator: ":",
                textStyle: textStyle,
                onDone: _scheduleMagribNotification,
              );
            } else if ((now.isAfter(magrib)) && (now.isBefore(isha)) == true) {
              return new SlideCountdownClock(
                duration: Duration(seconds: countIsha.inSeconds),
                slideDirection: SlideDirection.Down,
                separator: ":",
                textStyle: textStyle,
                onDone: _scheduleIshaNotification,
              );
            } else if ((now.isAfter(isha)) && (now.isBefore(close))) {
              return new SlideCountdownClock(
                duration: Duration(seconds: countClose.inSeconds),
                slideDirection: SlideDirection.Down,
                separator: ":",
                textStyle: textStyle,
                onDone: () {
                  // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
                },
              );
            }
            return Container(
              child: new Text(
                "No Data",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            );
          }
          return new CircularProgressIndicator();
        },
      ),
    );
  }

  Future<void> showNotification() async {
    var android = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();

    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Jadwal Sholat', 'Memasuki Waktu Dhuhr', platform,
        payload: 'This is my name');
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 20));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        icon: 'secondary_icon',
        sound: 'slow_spring_board',
        largeIcon: 'sample_large_icon',
        largeIconBitmapSource: BitmapSource.Drawable,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
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
        title: Text("Second Screen with payload"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
            Text(_payload),
          ],
        ),
      ),
    );
  }
}
