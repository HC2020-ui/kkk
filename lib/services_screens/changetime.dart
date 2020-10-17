import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:toast/toast.dart';

class ChangeTime extends StatefulWidget {
  @override
  _ChangeTimeState createState() => _ChangeTimeState();
}

class _ChangeTimeState extends State<ChangeTime> {

  String _time1 = "Not set";
  String _time2 = "Not set";
  int o_hour;
  int c_hour;
  FirebaseAuth _auth= FirebaseAuth.instance;
  final firestoreInstance=Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: new Container(
          height: 25.0,
          width: 25.0,
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              new Text('LOGO'),
            ],
          ),
        ),
        title: new Text('STORE NAME'),
        elevation: 1.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                  theme: DatePickerTheme(
                  containerHeight: 210.0,
                  ),
                  showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  if(time.hour<=9){
                    setState(() {
                      _time1='0${time.hour} : ${time.minute}';
                    });
                  }else {
                    setState(() {
                      _time1 = '${time.hour} : ${time.minute}';
                    });
                  }
                  setState(() {
                    o_hour=int.parse(_time1.substring(0,2)) ;
                  });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                  },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time1",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change opening time",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        if(time.hour<=9){
                          setState(() {
                            _time2='0${time.hour} : ${time.minute}';
                          });
                        }else {
                          setState(() {
                            _time2='${time.hour} : ${time.minute}';
                          });
                        }
                        setState(() {
                          c_hour= int.parse(_time2.substring(0,2));
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time2",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change Closing time",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(height: 20,),
              RaisedButton(
                child: Text('Save'),
                color: Colors.red,
                onPressed: (){
                  if(o_hour!=null && c_hour!=null){
                    if(o_hour<c_hour){
                      savetimetoDatabase();
                      Navigator.pop(context);
                    }else{
                      Toast.show("opening time is not valid", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                    }
                  }
                  else{
                    Toast.show("Time is null", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  savetimetoDatabase() async{
    print(_time1);
    var firebaseUser= await _auth.currentUser;
    firestoreInstance.collection("stores").document(firebaseUser.uid).updateData({
      "openingTime":_time1,
      "closingTime":_time2,
    }).then((value) {
      print("success");
    });
  }
}
