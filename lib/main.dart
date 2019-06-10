import 'package:flutter/material.dart';
import 'package:json/test_schedule_notif.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new ScheduleNotif(),
    );
  }
}
