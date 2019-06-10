import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class CountdownTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CountdownFormatted(
        duration: Duration(hours: 1, minutes: 28, seconds: 10),
        builder: (BuildContext context, String remaining) {
          return Text(remaining); // 01:00:00
        },
      ),
    );
  }
}

