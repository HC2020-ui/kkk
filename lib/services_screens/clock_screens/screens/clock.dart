import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import '../../changetime.dart';
//import '../changetime.dart';
import 'clock_dialog.dart';
import 'clock_face.dart';
import 'clock_hands.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.run(() => _showToast());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: GestureDetector(
            child: Stack(
              children: <Widget>[
                Center(
                  child: ClockFace(
                    height: 320,
                    width: 320,
                  ),
                ),
                Center(
                  child: Container(
                    child: CustomPaint(
                      size: Size(300, 300),
                      painter: ClockDialog(),
                    ),
                  ),
                ),
                Center(
                  child: ClockHands(),
                ),
//                Center(child: Text("Click on the clock to change the timing",style:TextStyle(color: Colors.red))),
              ],
            ),
            onTap: (){
              _showDialog(context);
            },
          ),
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to change Store timings?"),
          content: new Text("press yes to continue...", style: TextStyle(fontStyle: FontStyle.italic),),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ChangeTime()));
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

   _showToast(){
     Toast.show("Click on the clock to change the timings", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM,textColor: Colors.red);
  }

}
