import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/dark_theme/dart_theme_provider.dart';
import 'package:winkl/dark_theme/styles.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept_partial.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/home_pack/manage_inventory/productsList.dart';
import 'package:winkl/screens/home_pack/membership.dart';
import 'package:winkl/screens/home_pack/newHomeScreen.dart';
import 'package:winkl/screens/otp_screens/verify_otp.dart';
import 'package:winkl/screens/store/add_brands.dart';
import 'package:winkl/screens/store/add_product.dart';
import 'package:winkl/screens/store/add_variants.dart';
import 'package:winkl/screens/store/brands/add_service.dart';
import 'package:winkl/screens/store/product_search.dart';
import 'package:winkl/services/auth.dart';
import 'package:winkl/services_screens/services_main.dart';
import 'package:winkl/settings_page.dart';
import 'package:winkl/user.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangeProvider= new DarkThemeProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
            return StreamProvider<UserData>.value(
              value: AuthService().user,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(themeChange.darkTheme, context),
                routes: <String, WidgetBuilder>{
                  WinklRoutes.login: (context) => Login(),
                  WinklRoutes.home: (BuildContext context) => Home(),
                  WinklRoutes.intro: (
                      BuildContext context) => new IntroScreen(),
                  '/store_form': (context) => StoreForm(),
                  '/add_brands': (context) => AddBrands(),
                  '/verify_otp': (context) => VerifyOtp("", "", "", "", "", "", "", "", ""),
                  '/accept_partial': (context) => AcceptPartial(),
                  '/accept_screen': (context) => AcceptScreen(),
                },
                home: Wrapper(),
              ),
            );
          }
      ),
    );
  }
}

class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var storeType;
  var firestoreInstance = FirebaseFirestore.instance;
  var uid;
  String imageUrl= 'https://image.winudf.com/v2/image/Y29tLk1vbmtleS5ELkx1ZmZ5LldhbGxwYXBlcnMuRmFuc0FydDIuaW5zdXJhbmNlLlByb3BlcnR5LkhEX3NjcmVlbl8zXzE1MTU4MTY5ODhfMDMw/screen-3.jpg?fakeurl=1&type=.jpg';
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      if (await FirebaseAuth.instance.currentUser != null) {
        print(FirebaseAuth.instance.currentUser);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(id: FirebaseAuth.instance.currentUser.uid)));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => AddBrands(establishmanetName: 'Nukkud store',proprietorName: 'luffy',email: 'abc123@gmail.com', phone: '9905683164',storeType: 'services',serviceValue: '3-5 kms',serviceType: 'Fruits and vegetables',gps: 'No address',imageUrl: imageUrl
        //   ,uid: '12457896',)));//NewHomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroScreen()));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  // Future<String> getuid()async{
  //   final firebaseUser=await FirebaseAuth.instance.currentUser;
  //   setState(() {
  //     uid=firebaseUser.uid;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'wnkl.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                color: Colors.green,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(Theme
                    .of(context)
                    .hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }


//class SplashScreen extends StatefulWidget {
//  @override
//  _SplashScreenState createState() => _SplashScreenState();
//}
//
//class _SplashScreenState extends State<SplashScreen> {
//  @override
//  void initState() {
//     TODO: implement initState
//    super.initState();
//
////    _checkSession().then((value) {
////      if (value) {
////        FirebaseAuth.instance
////            .currentUser()
////            .then((currentUser){
////              if(currentUser == null){
////                Navigator.pushReplacementNamed(context, WinklRoutes.intro);
////              }else{
////                Navigator.pushReplacementNamed(context, WinklRoutes.home);
////              }
////        })
////            .catchError((e) => print(e));
////      }
////    });
//  }
//
////  Future<bool> _checkSession() async {
////    await Future.delayed(Duration(milliseconds: 500), () {});
////    return true;
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: AppColors.orange,
//      body: Stack(
//        children: [
//          FlareActor(
//            "images/essaibackground1.flr",
//            alignment: Alignment.center,
//            fit: BoxFit.cover,
//            animation: "Flow",
//          ),
//          Align(
//            alignment: Alignment.topCenter,
//            child: Container(
//              height: 350,
//              width: 350,
//              child: Image(
//                image: AssetImage(
//                  'images/wnkl.png',
//                ),
//                fit: BoxFit.cover,
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
}