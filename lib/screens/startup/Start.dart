import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/config/routes.dart';
import 'package:winkl/screens/store/store_form.dart';

class StartupScreen extends StatefulWidget {
  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  final String advertiseText =
      "The Advent Of Technology \nWas To Compliment Not\n Substitute";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(
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
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.widgetBorderRadius))),
              child: MaterialButton(
                color: AppColors.yellow,
                child: Text('Register Shop', style: AppStyles.buttonTextStyle),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.widgetBorderRadius))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StoreForm();
                  }));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.widgetBorderRadius))),
                color: AppColors.yellow,
                child: Text('Login', style: AppStyles.buttonTextStyle),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, WinklRoutes.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
