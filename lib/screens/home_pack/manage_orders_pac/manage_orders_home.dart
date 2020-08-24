import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/acc_orders_list_item.dart';
import 'package:winkl/screens/home_pack/manage_orders_pac/manage_orders_delivered.dart';

class ManageOrdersHome extends StatefulWidget {
  @override
  _ManageOrdersHomeState createState() => _ManageOrdersHomeState();
}

class _ManageOrdersHomeState extends State<ManageOrdersHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title:     Container(
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
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black,)),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 234.w,
                  decoration: BoxDecoration(
                      color: Font_Style().primaryColor, borderRadius: BorderRadius.circular(10)),
                  height: 48.h,
                  child: Center(
                    child: Text(
                        "Manage Orders",
                        style: Font_Style().montserrat_Bold(Colors.white, 19)
                    ),
                  ),
                ),
                Spacer(flex: 7,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 234.w,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(23,35,147, 1), borderRadius: BorderRadius.circular(10)),
                    height: 48.h,
                    child: Center(
                      child: Text(
                          "Pending Orders",
                          style: Font_Style().montserrat_Bold(Colors.white, 19)
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 2,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                  height: 200.0.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                      child: Divider(
                        thickness: 0.7,
                        color: Color.fromRGBO(3, 90, 166, 1),
                      ),
                    ),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      return AccOrdersListItem();
                    },
                  ),
                ),
                Spacer(flex: 10,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 234.w,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(23,35,147, 1), borderRadius: BorderRadius.circular(10)),
                    height: 48.h,
                    child: Center(
                      child: Text(
                          "Delivered Orders",
                          style: Font_Style().montserrat_Bold(Colors.white, 19)
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 2,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
                  height: 200.0.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                      child: Divider(
                        thickness: 0.7,
                        color: Color.fromRGBO(3, 90, 166, 1),
                      ),
                    ),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      return ManageOrdersDelivered();
                    },
                  ),
                ),
                Spacer(flex: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){

        },
        child: Container(
          width: 234.w,
          decoration: BoxDecoration(
              color: Font_Style().primaryColor, borderRadius: BorderRadius.circular(30)),
          height: 48.h,
          child: Center(
            child: Text(
                "Login",
                style: Font_Style().montserrat_Bold(Colors.white, 19)
            ),
          ),
        ),
      ),
    );
  }
}
