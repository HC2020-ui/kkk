import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept_partial.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/otp_screens/verify_otp.dart';
import 'package:winkl/screens/store/add_brands.dart';
import 'config/routes.dart';
import 'package:winkl/login.dart';
import 'package:winkl/screens/intro/intro.dart';
import 'package:winkl/screens/startup/Start.dart';
import 'package:winkl/screens/store/store_form.dart';
import 'package:winkl/screens/store/gps.dart';
import 'loading.dart';
import 'package:winkl/config/routes.dart';

import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:winkl/screens/intro/intro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        WinklRoutes.login: (context) => Login(),
        WinklRoutes.home: (BuildContext context) => Home(),
        WinklRoutes.intro: (BuildContext context) => new IntroScreen(),
        '/store_form': (context) => StoreForm(),
        '/add_brands': (context) => AddBrands(),
        '/verify_otp': (context) => VerifyOtp(),
        '/accept_partial': (context) => AcceptPartial(),
        '/accept_screen': (context) => AcceptScreen(),
      },
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkSession().then((value) {
      if (value) {
        FirebaseAuth.instance
            .currentUser()
            .then((currentUser){
              if(currentUser == null){
                Navigator.pushReplacementNamed(context, WinklRoutes.intro);
              }else{
                Navigator.pushReplacementNamed(context, WinklRoutes.home);
              }
        })
            .catchError((e) => print(e));
      }
    });
  }

  Future<bool> _checkSession() async {
    await Future.delayed(Duration(milliseconds: 500), () {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Stack(
        children: [
          FlareActor(
            "images/essaibackground1.flr",
            alignment: Alignment.center,
            fit: BoxFit.cover,
            animation: "Flow",
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 350,
              width: 350,
              child: Image(
                image: AssetImage(
                  'images/wnkl.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
