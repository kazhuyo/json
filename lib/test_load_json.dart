import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'model/jadwal_sholat_model.dart';

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

void main() {
  runApp(TestJson());
}

class TestJson extends StatefulWidget {
  TestJson({Key key}) : super(key: key);

  _TestJsonState createState() => _TestJsonState();
}

class _TestJsonState extends State<TestJson> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Test Load JSON"),
      ),
      body: Container(
        height: 400,
        child: Column(
          children: <Widget>[
            _buildCenterText(),
            _buildCounter(),
            _buildText(),
            _buildTimezone(),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterText() {
    return new FutureBuilder<JadwalModel>(
      future: loadJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateFormat timeFormat;
          timeFormat = new DateFormat('H:m');

          var fajrText = snapshot.data.jadwal[0].time;
          var dhuhrText = snapshot.data.jadwal[1].time;
          var asrText = snapshot.data.jadwal[2].time;
          var magribText = snapshot.data.jadwal[3].time;
          var ishaText = snapshot.data.jadwal[4].time;
          var sepertigaText = snapshot.data.jadwal[5].time;

          DateTime now = DateTime.now();
          now = new DateTime(now.year, now.month, now.day, now.hour, now.minute,
              now.second, now.millisecond);

          DateTime fajr = timeFormat.parse(fajrText);
          fajr = new DateTime(
              now.year, now.month, now.day, fajr.hour, fajr.minute);

          DateTime dhuhr = timeFormat.parse(dhuhrText);
          dhuhr = new DateTime(
              now.year, now.month, now.day, dhuhr.hour, dhuhr.minute);

          DateTime asr = timeFormat.parse(asrText);
          asr =
              new DateTime(now.year, now.month, now.day, asr.hour, asr.minute);

          DateTime magrib = timeFormat.parse(magribText);
          magrib = new DateTime(
              now.year, now.month, now.day, magrib.hour, magrib.minute);

          DateTime isha = timeFormat.parse(ishaText);
          isha = new DateTime(
              now.year, now.month, now.day, isha.hour, isha.minute);

          DateTime sepertiga = timeFormat.parse(sepertigaText);
          sepertiga = new DateTime(
              now.year, now.month, now.day, sepertiga.hour, sepertiga.minute);

          DateTime close = timeFormat.parse("23:59");
          close = new DateTime(
              now.year, now.month, now.day, close.hour, close.minute);

          DateTime reset = timeFormat.parse("00:00");
          reset = new DateTime(
              now.year, now.month, now.day, reset.hour, reset.minute);

          if ((now.isAfter(reset) && now.isBefore(fajr)) == true) {
            return new Text(
              "Subuh $fajrText WIB",
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            );
          } else if ((now.isAfter(fajr) && now.isBefore(dhuhr)) == true) {
            return new Text(
              "Duhr $dhuhrText WIB",
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            );
          } else if ((now.isAfter(asr) && now.isBefore(magrib)) == true) {
            return new Text(
              "Magrib $magribText WIB",
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            );
          } else if ((now.isAfter(magrib) && now.isBefore(isha)) == true) {
            return new Text(
              "Isha $ishaText WIB",
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            );
          } else if ((now.isAfter(isha)) && now.isBefore(close)) {
            return new Text(
              "Fajr $fajrText WIB",
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            );
          }
          return Container(
            child: new Text(
              "No Data",
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildCounter() {
    final textStyle = TextStyle(
      wordSpacing: 0.1,
      fontFamily: "SFProDisplay",
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );

    return new FutureBuilder<JadwalModel>(
      future: loadJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateFormat timeFormat;
          timeFormat = new DateFormat('H:m');

          var fajrText = snapshot.data.jadwal[0].time;
          var dhuhrText = snapshot.data.jadwal[1].time;
          var asrText = snapshot.data.jadwal[2].time;
          var magribText = snapshot.data.jadwal[3].time;
          var ishaText = snapshot.data.jadwal[4].time;
          var sepertigaText = snapshot.data.jadwal[5].time;

          DateTime now = DateTime.now();
          now = new DateTime(now.year, now.month, now.day, now.hour, now.minute,
              now.second, now.millisecond);

          DateTime fajr = timeFormat.parse(fajrText);
          fajr = new DateTime(
              now.year, now.month, now.day, fajr.hour, fajr.minute);

          DateTime dhuhr = timeFormat.parse(dhuhrText);
          dhuhr = new DateTime(
              now.year, now.month, now.day, dhuhr.hour, dhuhr.minute);

          DateTime asr = timeFormat.parse(asrText);
          asr =
              new DateTime(now.year, now.month, now.day, asr.hour, asr.minute);

          DateTime magrib = timeFormat.parse(magribText);
          magrib = new DateTime(
              now.year, now.month, now.day, magrib.hour, magrib.minute);

          DateTime isha = timeFormat.parse(ishaText);
          isha = new DateTime(
              now.year, now.month, now.day, isha.hour, isha.minute);

          DateTime sepertiga = timeFormat.parse(sepertigaText);
          sepertiga = new DateTime(
              now.year, now.month, now.day, sepertiga.hour, sepertiga.minute);

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

          if ((now.isAfter(reset) && now.isBefore(fajr)) == true) {
            return new SlideCountdownClock(
              duration: Duration(seconds: countFajr.inSeconds),
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: textStyle,
              onDone: () {
                // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            );
          } else if ((now.isAfter(fajr) && now.isBefore(dhuhr)) == true) {
            return new SlideCountdownClock(
              duration: Duration(seconds: countDhuhr.inSeconds),
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: textStyle,
              onDone: () {
                // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            );
          } else if ((now.isAfter(dhuhr) && now.isBefore(asr)) == true) {
            return new SlideCountdownClock(
              duration: Duration(seconds: countAsr.inSeconds),
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: textStyle,
              onDone: () {
                // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            );
          } else if ((now.isAfter(asr) && now.isBefore(magrib)) == true) {
            return new SlideCountdownClock(
              duration: Duration(seconds: countMagrib.inSeconds),
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: textStyle,
              onDone: () {
                // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            );
          } else if ((now.isAfter(magrib)) && (now.isBefore(isha)) == true) {
            return new SlideCountdownClock(
              duration: Duration(seconds: countIsha.inSeconds),
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: textStyle,
              onDone: () {
                // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
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
              style: TextStyle(fontSize: 20, color: Color(0xffFFD800)),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildText() {
    final textStyle = TextStyle(
      wordSpacing: 0.1,
      fontFamily: "SFProDisplay",
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );

    DateFormat timeFormat;
    timeFormat = new DateFormat('H:m');

    DateTime now = DateTime.now();
    now = new DateTime(now.year, now.month, now.day, now.hour, now.minute,
        now.second, now.millisecond);

    return new FutureBuilder<JadwalModel>(
      future: loadJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var fajrText = snapshot.data.jadwal[0].time;
          var dhuhrText = snapshot.data.jadwal[1].time;
          var asrText = snapshot.data.jadwal[2].time;
          var magribText = snapshot.data.jadwal[3].time;
          var ishaText = snapshot.data.jadwal[4].time;
          var sepertigaText = snapshot.data.jadwal[5].time;

          DateTime fajr = timeFormat.parse(fajrText);
          fajr = new DateTime(
              now.year, now.month, now.day, fajr.hour, fajr.minute);

          DateTime dhuhr = timeFormat.parse(dhuhrText);
          dhuhr = new DateTime(
              now.year, now.month, now.day, dhuhr.hour, dhuhr.minute);

          DateTime asr = timeFormat.parse(asrText);
          asr =
              new DateTime(now.year, now.month, now.day, asr.hour, asr.minute);

          DateTime magrib = timeFormat.parse(magribText);
          magrib = new DateTime(
              now.year, now.month, now.day, magrib.hour, magrib.minute);

          DateTime isha = timeFormat.parse(ishaText);
          isha = new DateTime(
              now.year, now.month, now.day, isha.hour, isha.minute);

          DateTime reset = timeFormat.parse("00:00");
          reset = new DateTime(
              now.year, now.month, now.day, reset.hour, reset.minute);

          if ((now.isAfter(reset) && now.isBefore(fajr)) == true) {
            return new Text(
              'Menjelang Fajr',
              style: textStyle,
            );
          } else if (now.isAfter(fajr) && now.isBefore(dhuhr)) {
            return new Text(
              'Menjelang Dhuhr',
              style: textStyle,
            );
          } else if (now.isAfter(dhuhr) && now.isBefore(asr)) {
            return new Text(
              'Menjelang Asr',
              style: textStyle,
            );
          } else if (now.isAfter(asr) && now.isBefore(magrib)) {
            return new Text(
              'Menjelang Magrib',
              style: textStyle,
            );
          } else if (now.isAfter(magrib) && now.isBefore(isha)) {
            return new Text(
              'Menjelang Isha',
              style: textStyle,
            );
          } else if (now.isAfter(isha)) {
            return new Text(
              'Menjelang Fajr',
              style: textStyle,
            );

          }
          return new Text(
            "No Data Found",
            style: textStyle,
          );
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  Widget _buildTimezone() {
    final textStyle = new TextStyle(
        fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.w400);

    DateFormat dateFormat;
    dateFormat = new DateFormat('EEEEE, d MMM y', 'id');
    DateTime now = DateTime.now();

    return new FutureBuilder<JadwalModel>(
      future: loadJadwal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: new Text(
                  // TODO: Implement Gecoder & Geolocation
                  snapshot.data.timezone,
                  style: textStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: new Text(
                  dateFormat.format(now),
                  style: textStyle,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

}
