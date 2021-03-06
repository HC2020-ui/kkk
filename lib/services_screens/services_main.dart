import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/manage_employees/employee_list.dart';
import 'package:winkl/screens/home_pack/profile_page.dart';
import 'package:winkl/screens/intro/intro.dart';
import 'package:winkl/screens/store/brands/service_list.dart';
import 'package:winkl/services_screens/manage_appoints.dart';
import 'package:winkl/services_screens/manageappointments.dart';

import 'accept_appointments.dart';
import 'changetime.dart';
import 'clock_screens/screens/clock.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();

}

bool _isShutterOpen = true;
bool _isDelivery = true;
bool _isPickedup=true;
String _time1 = "09 : 00 : 00";
String _time2 = "21 : 00 : 00";
var now=DateTime.now();
int currentTime=now.hour;


class _HomepageState extends State<Homepage> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  final firestoreInstance=FirebaseFirestore.instance;

  String name;
  String email;
  String phone_number;
  String location;
  String id;
  String vendor_type;
  String store_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(currentTime);
    getuid().whenComplete(() => getUserdetails());
//    getTiming();
    setTiming();
  }

  Future getuid() async{
    var firebaseuser=await FirebaseAuth.instance.currentUser;
    setState(() {
      id=firebaseuser.uid;
    });
  }

  getUserdetails() async {
    FirebaseFirestore.instance.collection('stores').doc(id).get().then((DocumentSnapshot data) {
      setState(() {
        store_name= data.get('establishment_name').toString();
        name=data.get('proprietor_name').toString();
        email=data.get('email').toString();
        phone_number=data.get('phone').toString();
        location=data.get('area').toString();
        vendor_type=data.get('store_type').toString();
      });
    });
  }


  setTiming(){
    if(currentTime>=int.parse(_time1.substring(0,2)) && currentTime<int.parse(_time2.substring(0,2))){
      setState(() {
        _isShutterOpen=true;
        _isDelivery=false;
      });
    }else{
      setState(() {
        _isShutterOpen=false;
        _isDelivery=true;
      });
    }
  }

  // getTiming() async{
  //   var firebaseUser=await _auth.currentUser();
  //   firestoreInstance.collection("stores").document(firebaseUser.uid).get()
  //       .then((DocumentSnapshot) => {
  //     _time2=DocumentSnapshot.data['closingTime'].toString(),
  //     _time1=DocumentSnapshot.data['openingTime'].toString()
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(255, 117, 117, 1),
          ),
          child: Row(
            children: <Widget>[
              Text("LOGO", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
              Spacer(flex: 2,),
              Align(
                  alignment: Alignment.center,
                  child: store_name!=null?Text(store_name, style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  )
                      :Text("Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  )
              ),
              Spacer(flex: 3,),
            ],
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.person), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(name: name,email: email,phone: phone_number,vendor_type: vendor_type,location: location,)));
          },
              color: Colors.black
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            SystemNavigator.pop();
          },
          child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height-80,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.0,
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(flex: 1,),
                          Row(
                            children: <Widget>[
                              Text("Close", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                              SizedBox(width: 7.0,),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isShutterOpen=!_isShutterOpen;
                                    });
                                  },
                                  child: _switch_button(_isShutterOpen)),
                              SizedBox(width: 7.0),
                              Text("Open", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                            ],
                          ),
                          Spacer(flex: 5,),
                          Row(
                            children: <Widget>[
                              Text("Delivery", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                              SizedBox(width: 7.0),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isDelivery=!_isDelivery;
                                    });
                                  },
                                  child: _switch_button(_isDelivery)),
                            ],
                          ),
                          Spacer(flex: 5,),
                          Row(
                            children: <Widget>[
                              Text("Pick Up", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                              SizedBox(width: 7.0),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isPickedup=!_isPickedup;
                                    });
                                  },
                                  child: _switch_button(_isPickedup)),
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setTimeDialog();
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.access_time, size: 70.0, color: AppColors.orange,),
                            Text("Set Time",textAlign: TextAlign.center, style: Font_Style().montserrat_Bold(Colors.black, 16),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 20,),
                Row(
                  children: <Widget>[
                    Spacer(flex: 1,),
                    _buttonCard("Accept Appointments", "accept_appointments"),
                    Spacer(flex: 2,),
                    _buttonCard("Manage Appointments", "manage_appointments"),
                    Spacer(flex: 1,),
                  ],
                ),
                Spacer(flex: 20,),
                Row(
                  children: <Widget>[
                    Spacer(flex: 1,),
                    _buttonCard("Manage Services", "manage_services"),
                    Spacer(flex: 2,),
                    _buttonCard("Manage Employees", "manage_employees"),
                    Spacer(flex: 1,),
                  ],
                ),
                Spacer(flex: 50,),
                _buttonWidget(context),
                Spacer(flex: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCard(String title, String route) {
    return InkWell(
      onTap: () {
        if(route == "accept_appointments") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AcceptAppoints(storename: store_name,);
          }));
        }
        else if(route == "manage_appointments") {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageAppointMents(storename: store_name,)));
        }
        else if(route=="manage_services"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceList()));
        }else if(route== "manage_employees"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeList()));
          // _showdialogbox();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        width: 153.0,
        height: 144,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(7,9,32, 1).withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  3.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black45),),
        ),
      ),
    );
  }

  Widget _switch_button(bool status){
    return Container(
      padding: EdgeInsets.all(0),
      child: CustomSwitchButton(
        buttonHeight: 22.0,
        buttonWidth: 42.0,
        indicatorWidth: 15.0,
        backgroundColor: Colors.white,
        unCheckedColor: Colors.grey,
        animationDuration: Duration(milliseconds: 200),
        checkedColor: Colors.black,
        checked: status,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          _auth.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroScreen()));
        },
        child: Container(
          width: 345.0,
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 117, 117, 1), borderRadius: BorderRadius.circular(30)),
          height: 45.0,
          child: Center(
            child: Text(
              "Logout",
              style: TextStyle(color: AppColors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void setTimeDialog() {
    showDialog(context: context, builder: (BuildContext context) => StatefulBuilder(builder: (context, StateSetter setState) =>
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: 220.0,
            width: 340.0,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                          print('confirm $time');
                          _time1 = '${time.hour} : ${time.minute} : ${time.second}';
                          setState(() {
                            _time1 = '${time.hour} : ${time.minute} : ${time.second}';
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Card(
                    elevation: 1.5,
                    child: Container(
                        padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 7.0, bottom: 7.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.orange,
                              width: 1.5
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: _time1 == "" ? Row(
                          children: <Widget>[
                            Text("Set Open Time", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                            SizedBox(width: 7.0,),
                            Icon(Icons.access_time, size: 24.0, color: AppColors.orange,),
                          ],
                        ) : Text(_time1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue))),
                  ),
                ),
                Spacer(flex: 1,),
                Text("to", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Spacer(flex: 1,),
                InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                          print('confirm $time');
                          _time2 = '${time.hour} : ${time.minute} : ${time.second}';
                          setState(() {
                            _time2 = '${time.hour} : ${time.minute} : ${time.second}';
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Card(
                    elevation: 1.5,
                    child: Container(
                        padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 7.0, bottom: 7.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.orange,
                              width: 1.5
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: _time2 == "" ? Row(
                          children: <Widget>[
                            Text("Set Close Time", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                            SizedBox(width: 7.0,),
                            Icon(Icons.access_time, size: 24.0, color: AppColors.orange,),
                          ],
                        ) : Text(_time2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue))),
                  ),
                ),
                Spacer(flex: 10,),
                InkWell(
                  onTap: () {
                    if(_time1 != "" || _time2 != "")
                      addTime();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      padding: EdgeInsets.all(2.0),
                      height: 28.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      ),
                      child: Center(child: Text("OK", style: Font_Style().montserrat_Bold(Colors.white, 14),))),
                ),
              ],
            ),
          ),
        )
    )
    );
  }

  addTime() async {
    var firebaseUser= await _auth.currentUser;
    firestoreInstance.collection("stores").doc(firebaseUser.uid).update({
      "openingTime":_time1,
      "closingTime":_time2,
    }).then((value) {
      print("success");
    });
  }
}




