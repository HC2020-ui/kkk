import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winkl/config/fontstyle.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.0.w),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 2,),
          _settings_home_list_item("My Profile", "", context),
          _settings_home_list_item("My Offers", "", context),
          _settings_home_list_item("My Products", "", context),
          _settings_home_list_item("My Brands", "", context),
          _settings_home_list_item("My Package", "", context),
          _settings_home_list_item("Rent", "", context),
          _settings_home_list_item("Help", "", context),
          Spacer(flex: 5,),
          Container(
            width: 125.w,
            height: 41.h,
            decoration: BoxDecoration(
                color: Font_Style().primaryColor,
                borderRadius: BorderRadius.circular(41)
            ),
            child: Center(
              child: Text("Log Out",style: Font_Style().montserrat_Bold(Colors.white, 16),),
            ),
          ),
          Spacer(flex: 2,),
        ],
      ),
    );
  }

  Widget _settings_home_list_item(String title,String route, context){
    return Padding(
      padding:  EdgeInsets.only(right: 21.w, bottom: 22.0.h),
      child: InkWell(
        onTap: () {
          print(route);
          Navigator.pushNamed(context, route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,style: Font_Style().montserrat_Bold(Font_Style().secondaryColor, 16.0),),
          ],
        ),
      ),
    );
  }
}
