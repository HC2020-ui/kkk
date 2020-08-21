import 'package:flutter/material.dart';

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const double titleFontSize = 25;
  static const double sidePadding = 15;
  static const double buttonRadius = 25;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const TEXT_FIELD_RADIUS = 4.0;
}

class AppColors {
  static const white = Color(0xFFEAF0F1);
  static const orange = Color(0xFFEA7773);
  static const yellow = Color(0xFFFBD28B);
}

class AppStyles {
  static TextStyle buttonTextStyle =
      TextStyle(color: Colors.black, fontFamily: "Nunito", fontSize: 15);
  static TextStyle titileTextStyle = TextStyle(
      color: AppColors.white,
      fontSize: AppSizes.titleFontSize,
      fontFamily: "Sniglet");

  static InputDecoration textFormFieldDecoration = InputDecoration(
    isDense: true,
//    contentPadding: EdgeInsets.all(10),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.orange, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.orange, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.orange, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.orange, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
