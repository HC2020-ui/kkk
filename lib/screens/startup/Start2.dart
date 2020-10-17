import 'package:flutter/material.dart';
import 'package:winkl/config/routes.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/employee_section/employee_list2.dart';
import 'package:winkl/employee_section/employee_login.dart';
import 'package:winkl/login.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final String advertiseText =
      "The Advent Of Technology \nWas To Compliment Not\n Substitute";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Image(
                    image: AssetImage('images/wnkl.png'),
                    fit: BoxFit.cover,
                    width: 300,
                    height: 300,
                  )),
              Container(
                child: Text(advertiseText,
                    textAlign: TextAlign.center,
                    style: AppStyles.titileTextStyle),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.widgetBorderRadius))),
                    child: MaterialButton(
                      color: AppColors.yellow,
                      child: Text('SignIN / SignUP', style: AppStyles.buttonTextStyle),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppSizes.widgetBorderRadius))),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      },
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.widgetBorderRadius))),
                    child: MaterialButton(
                      color: AppColors.yellow,
                      child: Text('Employee Section', style: AppStyles.buttonTextStyle, textAlign: TextAlign.center,),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppSizes.widgetBorderRadius))),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return EmployeeLogin();
                        }));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
