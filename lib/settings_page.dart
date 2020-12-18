import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:social_share/social_share.dart';
import 'package:winkl/coupons/rate_page.dart';
import 'package:winkl/screens/home_pack/membership.dart';
import 'package:winkl/screens/home_pack/profile_page.dart';
import 'package:winkl/screens/intro/intro.dart';
import 'package:winkl/screens/store/gps.dart';

import 'dark_theme/dart_theme_provider.dart';

class SettingsPage extends StatefulWidget {
  String store_name;
  String lat;
  String long;
  SettingsPage(this.store_name,this.lat, this.long);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

bool _isShutterOpen = true;
bool _isDelivery = true;
bool _isPickedup=true;
String _time1 = "09 : 00 : 00";
String _time2 = "21 : 00 : 00";

class _SettingsPageState extends State<SettingsPage> {

  FirebaseAuth _auth=FirebaseAuth.instance;
  final firestoreInstance=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(93, 187, 99, 1),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pop(context);
          }),
          title: Text(
              'Settings', style: TextStyle(fontWeight: FontWeight.w800)),
          actions: [
            IconButton(
              icon:Icon(Icons.bar_chart),
              color: Colors.black,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MembershipPage(storename: widget.store_name,lat: widget.lat,long: widget.long,)));
              },
            ),
            // IconButton(
            //   icon: themeChange.darkTheme ? Icon(
            //     Icons.brightness_2_sharp, color: Colors.black,) : Icon(
            //     Icons.lightbulb_outline, color: Colors.black,),
            //   onPressed: () {
            //     setState(() {
            //       themeChange.darkTheme = !themeChange.darkTheme;
            //     });
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.black,
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>IntroScreen()), (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey.shade200,
                        height: 100,
                        width: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/placeholder.png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.contain,
                                color: Color.fromRGBO(93, 187, 99, 1),
                              ),
                              Text('+ Add Logo', style: TextStyle(color: Color.fromRGBO(93, 187, 99, 1),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15),)
                            ]
                        )
                    ),
                    SizedBox(width: 20,),
                    Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.store_name!=null?widget.store_name:
                            'My Dukkan', style: TextStyle(fontWeight: FontWeight
                              .w900, fontSize: 20),),
                          InkWell(
                            child:Row(
                              children: [
                                Text('Edit my Store details', style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Color.fromRGBO(93, 187, 99, 1)),),
                                SizedBox(width: 5,),
                                FaIcon(FontAwesomeIcons.arrowAltCircleRight,
                                  size: 15,)
                              ],
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Divider(color: Colors.grey.shade500),
                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: <Widget>[
                        Text("Close", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                        SizedBox(width: 7.0,),
                        InkWell(
                            onTap: () {
                              setState(() {
                                _isShutterOpen=!_isShutterOpen;
                              });
                            },
                            child: _switch_button(_isShutterOpen)),
                        SizedBox(width: 7.0),
                        Text("Open", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.green),),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: <Widget>[
                        Text("Delivery", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black),),
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
                    SizedBox(height: 15,),
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
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setTimeDialog();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.access_time, size: 70.0, color: Color.fromRGBO(93, 187, 99, 1),),
                          Text("Set Time",textAlign: TextAlign.center, style:TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    FlatButton.icon(
                      icon: FaIcon(FontAwesomeIcons.locationArrow),
                      label: Text('Show My Location', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),),
                      onPressed:() async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Gps(latitude:double.parse(widget.lat),longitude: double.parse(widget.long),)));
                        },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:Colors.green,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                        SizedBox(width: 10,),
                        Text('Share Shop With Customers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                      ],
                    ),
                  ),
                  onTap: (){
                    SocialShare.shareWhatsapp('http://nukkad.in/stores/{id}/');
                  },
                ),
                SizedBox(height: 20,),
                Divider(thickness: 3,color: Colors.grey.shade300,),
                ExpansionTile(
                  title: Text('More...', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,),),
                  children: [
                    ListTile(
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FaIcon(FontAwesomeIcons.shareSquare),
                          SizedBox(width: 10,),
                          Text('Refer this App', style: TextStyle(color:Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                        ],
                      ),
                    ),
                    // ListTile(
                    //   title:Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       FaIcon(FontAwesomeIcons.questionCircle),
                    //       SizedBox(width: 10,),
                    //       Text('App Guide and Help', style: TextStyle(color:themeChange.darkTheme?Colors.white: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                    //     ],
                    //   ),
                    // ),
                    ListTile(
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FaIcon(FontAwesomeIcons.star),
                          SizedBox(width: 10,),
                          Text('Rate App on PlayStore', style: TextStyle(color:Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RateApp()));
                      },
                    ),
                    // ListTile(
                    //   title:Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       FaIcon(FontAwesomeIcons.trophy),
                    //       SizedBox(width: 10,),
                    //       Text('My Rewards', style: TextStyle(color:themeChange.darkTheme?Colors.white: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                    //     ],
                    //   ),
                    // ),
                    // ListTile(
                    //   title:Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       FaIcon(FontAwesomeIcons.compass),
                    //       SizedBox(width: 10,),
                    //       Text('App Navigation', style: TextStyle(color:themeChange.darkTheme?Colors.white: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                    //     ],
                    //   ),
                    //   trailing: IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.black,), onPressed: null),
                    // ),
                    ListTile(
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FaIcon(FontAwesomeIcons.signOutAlt),
                          SizedBox(width: 10,),
                          Text('Logout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  void setTimeDialog() {
    showDialog(context: context, builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, StateSetter setState) =>
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
                            showTitleActions: true,
                            onConfirm: (time) {
                              print('confirm $time');
                              _time1 = '${time.hour} : ${time.minute} : ${time
                                  .second}';
                              setState(() {
                                _time1 = '${time.hour} : ${time.minute} : ${time
                                    .second}';
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.en);
                      },
                      child: Card(
                        elevation: 1.5,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 7.0, right: 7.0, top: 7.0, bottom: 7.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(93, 187, 99, 0.5),
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: _time1 == "" ? Row(
                              children: <Widget>[
                                Text("Set Open Time", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),),
                                SizedBox(width: 7.0,),
                                Icon(Icons.access_time, size: 24.0,
                                    color: Color.fromRGBO(93, 187, 99, 0.5)),
                              ],
                            ) : Text(_time1, style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue))),
                      ),
                    ),
                    Spacer(flex: 1,),
                    Text("to", style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),),
                    Spacer(flex: 1,),
                    InkWell(
                      onTap: () {
                        DatePicker.showTimePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            onConfirm: (time) {
                              print('confirm $time');
                              _time2 = '${time.hour} : ${time.minute} : ${time
                                  .second}';
                              setState(() {
                                _time2 = '${time.hour} : ${time.minute} : ${time
                                    .second}';
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.en);
                      },
                      child: Card(
                        elevation: 1.5,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 7.0, right: 7.0, top: 7.0, bottom: 7.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(93, 187, 99, 0.5),
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: _time2 == "" ? Row(
                              children: <Widget>[
                                Text("Set Close Time", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),),
                                SizedBox(width: 7.0,),
                                Icon(Icons.access_time, size: 24.0,
                                  color: Colors.lightGreen,),
                              ],
                            ) : Text(_time2, style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue))),
                      ),
                    ),
                    Spacer(flex: 10,),
                    InkWell(
                      onTap: () {
                        if (_time1 != "" || _time2 != "")
                          addTime();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        height: 28.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(93, 187, 99, 1),
                            borderRadius: BorderRadius.all(Radius.circular(
                                30.0))
                        ),
                        child: Center(child: Text("OK", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))),
                      ),
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

  Widget _switch_button(bool status){
    return Container(
      padding: EdgeInsets.all(0),
      child: CustomSwitchButton(
        buttonHeight: 22.0,
        buttonWidth: 42.0,
        indicatorWidth: 15.0,
        backgroundColor: Colors.grey,
        unCheckedColor: Colors.red,
        animationDuration: Duration(milliseconds: 200),
        checkedColor: Colors.green,
        checked: status,
      ),
    );
  }
}

