import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json/model/jadwal_model.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';


Future<String> _loadDoafromAssets() async {
  return await rootBundle.loadString('assets/data/jadwal.json');
}

loadJadwal() async {
  await wait(2);
  String jsonString = await _loadDoafromAssets();
  final jsonResponse = json.decode(jsonString);
  // JadwalModel jadwal = JadwalModel.fromJson(jsonResponse);
  // print(jsonResponse);

  // DateFormat dateFormat = new DateFormat.Hm();
  // DateTime dhuhr = dateFormat.parse(jadwal.data.dhuhr);
  // DateTime fajr = dateFormat.parse(jadwal.data.fajr);
  // DateTime currentTime = DateTime.now();

  // if (currentTime.isAfter(fajr) && currentTime.isBefore(dhuhr)) {
  //   // do something
  //   print(currentTime.difference(dhuhr).inHours);
  // }

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
            buildCounter(),
          ],
        ),
      ),
    );
  }

  Widget printDiffTime() {
    return Container(
      child: FutureBuilder(
        future: loadJadwal(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                        "Waktu Fajr API : ${fajr.toString().split(" ")[1].split(".")[0].split(":")}"),
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


  Widget buildCounter() {
    DateFormat timeFormat;
    timeFormat = new DateFormat('H:m');

    DateTime now = DateTime.now();
    now = new DateTime(now.year, now.month, now.day, now.hour, now.minute,
        now.second, now.millisecond);

    // TODO : Implement load json data here
    DateTime fajr = timeFormat.parse("04:37");
    fajr = new DateTime(now.year, now.month, now.day, fajr.hour, fajr.minute);

    DateTime dhuhr = timeFormat.parse("11:51");
    dhuhr =
        new DateTime(now.year, now.month, now.day, dhuhr.hour, dhuhr.minute);

    DateTime asr = timeFormat.parse("15:13");
    asr = new DateTime(now.year, now.month, now.day, asr.hour, asr.minute);

    DateTime magrib = timeFormat.parse("17:44");
    magrib =
        new DateTime(now.year, now.month, now.day, magrib.hour, magrib.minute);

    DateTime isha = timeFormat.parse("18:57");
    isha = new DateTime(now.year, now.month, now.day, isha.hour, isha.minute);

    DateTime reset = timeFormat.parse("00:00");
    reset =
        new DateTime(now.year, now.month, now.day, reset.hour, reset.minute);

    var countFajr = fajr.difference(now);
    var countDhuhr = dhuhr.difference(now);
    var countAsr = asr.difference(now);
    var countMagrib = magrib.difference(now);
    var countIsha = isha.difference(now);

    if ((now.isAfter(reset) && now.isBefore(fajr)) == true) {
      return new Text(
        countFajr.toString().split(".")[0],
        style: TextStyle(
            fontFamily: "SFProDisplay",
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      );
    } else if (now.isAfter(fajr) && now.isBefore(dhuhr)) {
      // return new Text(
      //   "Sisa Waktu : ${countDhuhr.toString().split(".")[0]}",
      //   style: TextStyle(
      //       fontFamily: "SFProDisplay",
      //       fontSize: 12.0,
      //       color: Colors.black,
      //       fontWeight: FontWeight.w400),
      // );
      return new SlideCountdownClock(
              duration: Duration(seconds: countDhuhr.inSeconds),
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: TextStyle(
                fontFamily: "SFProDisplay",
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              onDone: () {
                // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            );
    } else if (now.isAfter(dhuhr) && now.isBefore(asr)) {
      return new Text(
        countAsr.toString().split(".")[0],
        style: TextStyle(
            fontFamily: "SFProDisplay",
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      );
    } else if (now.isAfter(asr) && now.isBefore(magrib)) {
      return new Text(
        countMagrib.toString().split(".")[0],
        style: TextStyle(
            fontFamily: "SFProDisplay",
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      );
    } else if (now.isAfter(magrib) && now.isBefore(isha)) {
      return new Text(
        countIsha.toString().split(".")[0],
        style: TextStyle(
            fontFamily: "SFProDisplay",
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      );
    }
    return new Text(
      "No Data Found",
      style: TextStyle(
          fontFamily: "SFProDisplay",
          fontSize: 12.0,
          color: Colors.black,
          fontWeight: FontWeight.w400),
    );
  }
}
