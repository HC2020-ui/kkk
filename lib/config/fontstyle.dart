import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winkl/config/theme.dart';

class Font_Style {
  Color primaryColor = AppColors.orange;//Color.fromRGBO(23,35,147, 1);
  Color secondaryColor=Color.fromRGBO(2,4,23, 1);
  Color secondaryColorWithOpacity = Color.fromRGBO(2, 4, 23, 0.5);

//to set the label for input text field
  InputDecoration setLable(var lable,var sufix,BuildContext context){
    return  InputDecoration(
        labelText:lable,
        counterText: "",
        contentPadding: EdgeInsets.only(top: 5.h,bottom: 10.h),
        labelStyle: montserrat_medium(secondaryColor, 12.0),
        suffix: sufix);
  }
  TextStyle textfield_style(){
    return montserrat_medium(secondaryColor, null);
  }
  TextStyle montserrat_black(Color primary,double f1_32){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w800,
      color: primary==null?primaryColor:primary,
      fontSize: f1_32==null?ScreenUtil().setSp( 32.0,allowFontScalingSelf: true):ScreenUtil().setSp(f1_32,allowFontScalingSelf: true),
    );
  }

  TextStyle montserrat_ExtraBold(Color primary,double f3_20){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w900,
      color: primary==null?primaryColor:primary,
      fontSize: f3_20==null?ScreenUtil().setSp(19,allowFontScalingSelf: true):ScreenUtil().setSp(f3_20,allowFontScalingSelf: true),
    );
  }

  TextStyle montserrat_Bold(Color primary,double f3_19){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w700,
      color: primary==null?primaryColor:primary,
      fontSize: f3_19==null?ScreenUtil().setSp(19,allowFontScalingSelf: true):ScreenUtil().setSp(f3_19,allowFontScalingSelf: true),
    );
  }
  TextStyle montserrat_SemiBold(Color primary,double f5_14){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: primary==null?primaryColor:primary,
      fontSize: f5_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f5_14,allowFontScalingSelf: true),
    );
  }
  TextStyle montserrat_SemiBold_underline(Color primary,double f5_14){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: primary==null?primaryColor:primary,
      decoration: TextDecoration.underline,
      fontSize: f5_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f5_14,allowFontScalingSelf: true),
    );
  }
  TextStyle montserrat_medium(Color primary,double f4_16){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w400,
      color: primary==null?primaryColor:primary,
      fontSize: f4_16==null?ScreenUtil().setSp(16,allowFontScalingSelf: true):ScreenUtil().setSp(f4_16,allowFontScalingSelf: true),
    );
  }
  TextStyle montserrat_Regular(Color primary,double f6_12){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w300,
      color: primary==null?primaryColor:primary,
      fontSize: f6_12==null?ScreenUtil().setSp(12,allowFontScalingSelf: true):ScreenUtil().setSp(f6_12,allowFontScalingSelf: true),
    );
  }

  TextStyle montserrat_Regular_Underline(Color primary,double f6_12){
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w300,
        color: primary==null?primaryColor:primary,
        fontSize: f6_12==null?ScreenUtil().setSp(12,allowFontScalingSelf: true):ScreenUtil().setSp(f6_12,allowFontScalingSelf: true),
        decoration: TextDecoration.underline,
        decorationColor: primary==null?primaryColor:primary,
    );
  }

  TextStyle montserrat_Light(Color primary, double f6_12) {
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w300,
      color: primary==null?primaryColor:primary,
      fontSize: f6_12==null?ScreenUtil().setSp(12,allowFontScalingSelf: true):ScreenUtil().setSp(f6_12,allowFontScalingSelf: true),
    );
  }

  TextStyle montserrat_thin(Color primary,double f7_14){
    return TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w300,
      color: primary==null?primaryColor:primary,
      fontSize: f7_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f7_14,allowFontScalingSelf: true),
    );
  }

  TextStyle montserrat_thin_Underline(Color primary,double f7_14){
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w300,
        color: primary==null?primaryColor:primary,
        fontSize: f7_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f7_14,allowFontScalingSelf: true),
        decoration: TextDecoration.underline,
        decorationColor: primaryColor
    );
  }
}