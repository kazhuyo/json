import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json/model/jadwal_model.dart';
import 'package:intl/intl.dart';

Future<String> _loadDoafromAssets() async {
  return await rootBundle.loadString('assets/data/jadwal.json');
}

Future<JadwalModel> loadJadwal() async {
  await wait(2);
  String jsonString = await _loadDoafromAssets();
  final jsonResponse = json.decode(jsonString);
  return JadwalModel.fromJson(jsonResponse);
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class JadwalSholat extends StatefulWidget {
  JadwalSholat({Key key}) : super(key: key);

  _JadwalSholatState createState() => _JadwalSholatState();
}

class _JadwalSholatState extends State<JadwalSholat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Jadwal"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            printDiffTime(),
          ],
        ),
      ),
    );
  }

  Widget printDiffTime() {
    return Container(
      child: FutureBuilder<JadwalModel>(
        future: loadJadwal(),
        builder: (context, snapshot) {
          DateFormat dateFormat = new DateFormat.Hm();

          DateTime now = DateTime.now();
          now = new DateTime(now.year, now.month, now.day, now.hour, now.minute,
              now.second, now.millisecond);

          DateTime jamNow = dateFormat.parse("00:00");
          jamNow = new DateTime(now.year, now.month, now.day, now.hour,
              jamNow.minute, now.second, now.millisecond);

          DateTime menitNow = dateFormat.parse("00:00");
          menitNow = new DateTime(now.year, now.month, now.day, menitNow.hour,
              now.minute, now.second, now.millisecond);

          DateTime fajr = dateFormat.parse(snapshot.data.data.fajr);
          fajr = new DateTime(
              now.year, now.month, now.day, fajr.hour, fajr.minute);

          DateTime hitungJam = dateFormat.parse("00:00");
          hitungJam = new DateTime(now.year, now.month, now.day, fajr.hour,
              hitungJam.minute, now.second);

          DateTime hitungMenit = dateFormat.parse("00:00");
          hitungMenit = new DateTime(now.year, now.month, now.day,
              hitungMenit.hour, fajr.minute, now.second, now.millisecond);

          // var countJam = jamNow.difference(hitungJam).inHours;
          // var countMenit = hitungMenit.difference(menitNow).inMinutes;
          var countDuration = fajr.difference(now);
          print(DateTime.now().toString());
          // print('difference 2: ${countDuration.toString().split(".")[0]}');
          // if (currentTime.isAfter(fajr) && currentTime.isBefore(dhuhr)) {
          // do something
          // print(currentTime.difference(dhuhr).inHours);
          // }

          return Container(
            // height: 300,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        "Waktu Saat Ini : ${now.toString().split(" ")[1].split(".")[0]}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        "Waktu Fajr API : ${fajr.toString().split(" ")[1].split(".")[0]}"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                        "Waktu Sisa : ${countDuration.toString().split(".")[0]}"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("${now.toString().split(" ")[1].split(".")[0]}"),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
