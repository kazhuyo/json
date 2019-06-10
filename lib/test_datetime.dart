import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'model/jadwal_model.dart';

void main() => runApp(new TestDateTime());

class TestDateTime extends StatefulWidget {
  TestDateTime({Key key}) : super(key: key);

  // final String title;

  @override
  _TestDateTimeState createState() => new _TestDateTimeState();
}

class _TestDateTimeState extends State<TestDateTime> {

  Future<String> _loadJadwalfromAssets() async {
    return await rootBundle.loadString('assets/data/jadwal.json');
  }


  loadJadwal() async {
    String jsonString = await _loadJadwalfromAssets();
    final jsonResponse = json.decode(jsonString);
    JadwalModel jadwal = JadwalModel.fromJson(jsonResponse);
    print(jadwal.data.fajr);

    // return JadwalModel.fromJson(jsonResponse);
  }

  
  DateFormat dateFormat;
  DateFormat timeFormat;

  @override
  void initState() {
    super.initState();
    loadJadwal();
    initializeDateFormatting();
    dateFormat = new DateFormat('d - MMMM - y', 'id');
    timeFormat = new DateFormat('H:m:s', 'id');
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = new DateTime.now();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Testing DateTime"),
      ),
      body: Container(
        height: 300,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text("Waktu Saat Ini : ${timeFormat.format(dateTime)}"),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ),
    );
  }
}
