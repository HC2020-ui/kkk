import 'dart:async';
import 'package:flutter/material.dart';
import 'package:winkl/services_screens/clock_screens/clock/hour.dart';
import 'package:winkl/services_screens/clock_screens/clock/minutes.dart';
import 'package:winkl/services_screens/clock_screens/clock/seconds.dart';


class ClockHands extends StatefulWidget {
  @override
  _ClockHandsState createState() => _ClockHandsState();
}

class _ClockHandsState extends State<ClockHands> {
  Timer _timer;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    _timer = new Timer.periodic(Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: CustomPaint(
            size: Size(250, 250),
            painter: Seconds(
              seconds: dateTime.second,
            ),
          ),
        ),
        Container(
          child: CustomPaint(
            size: Size(250, 250),
            painter: Minutes(
              minutes: dateTime.minute,
              seconds: dateTime.second,
            ),
          ),
        ),
        Container(
          child: CustomPaint(
            size: Size(250, 250),
            painter: Hours(
              hours: dateTime.hour,
              minutes: dateTime.minute,
            ),
          ),
        )
      ],
    );
  }
}
