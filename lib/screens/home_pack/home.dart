import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'accept_orders_pac/accept_orders.dart';
import 'manage_orders_pac/manage_orders_home.dart';

class Home extends StatefulWidget {
  final String user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

bool _isShutterOpen = true;
bool _isDelivery = true;
String _time1 = "";
String _time2 = "";

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
            child: Column(
              children: <Widget>[
                Container(
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
                          child: Text("Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                      Spacer(flex: 3,),
                    ],
                  ),
                ),
                Spacer(flex: 20,),
                Container(
                  height: 100.0.h,
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(flex: 1,),
                          Row(
                            children: <Widget>[
                              Text("Close", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                              SizedBox(width: 7.0,),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isShutterOpen = !_isShutterOpen;
                                    });
                                  },
                                  child: _switch_button(_isShutterOpen)),
                              SizedBox(width: 7.0,),
                              Text("Open", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                            ],
                          ),
                          Spacer(flex: 5,),
                          Row(
                            children: <Widget>[
                              Text("Delivery", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                              SizedBox(width: 7.0,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isDelivery = !_isDelivery;
                                  });
                                },
                                  child: _switch_button(_isDelivery)),
                            ],
                          ),
                          Spacer(flex: 2,),
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
                            Spacer(flex: 1,),
                            Text("Set Time", style: Font_Style().montserrat_Bold(Colors.black, 16),),
                            Spacer(flex: 2,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 25,),
                Row(
                  children: <Widget>[
                    Spacer(flex: 1,),
                    _buttonCard("Accept Orders", "accept_orders"),
                    Spacer(flex: 2,),
                    _buttonCard("Manage orders", "manage_orders"),
                    Spacer(flex: 1,),
                  ],
                ),
                Spacer(flex: 20,),
                Row(
                  children: <Widget>[
                    Spacer(flex: 1,),
                    _buttonCard("Manage Inventory", ""),
                    Spacer(flex: 2,),
                    _buttonCard("Manage Employees", ""),
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
      );
  }
  
  Widget _buttonCard(String title, String route) {
    return InkWell(
      onTap: () {
        if(route == "accept_orders") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AcceptOrders();
          }));
        }
        else if(route == "manage_orders") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ManageOrdersHome();
          }));
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
            padding: EdgeInsets.all(20.0.h),
            height: 220.0.h,
            width: 340.0.w,
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
                      Navigator.of(context).pop();
                  },
                  child: Container(
                      padding: EdgeInsets.all(2.0.h),
                      height: 28.0.h,
                      width: 60.0.w,
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
}
