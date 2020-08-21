import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/store/store_form.dart';
import 'package:flutter/gestures.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Login extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();


//  Future<bool> loginUser(String phone, BuildContext context) async {
//    FirebaseAuth _auth = FirebaseAuth.instance;
//
//    _auth.verifyPhoneNumber(
//        phoneNumber: phone,
//        timeout: Duration(seconds: 60),
//        verificationCompleted: (AuthCredential credential) async {
//          Navigator.of(context).pop();
//
//          AuthResult result = await _auth.signInWithCredential(credential);
//
//          FirebaseUser user = result.user;
//
//          if (user != null) {
////            Navigator.pushReplacement(
////                context,
////                MaterialPageRoute(
////                    builder: (context) => Store(
//////                          user: user.uid,
////                        )));
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (context) => Home()));
//          } else {
//            print("Error");
//          }
//
//          //This callback would gets called when verification is done auto maticlly
//        },
//        verificationFailed: (AuthException exception) {
//          print(exception.message);
//        },
//        codeSent: (String verificationId, [int forceResendingToken]) {
//          showDialog(
//              context: context,
//              barrierDismissible: false,
//              builder: (context) {
//                return AlertDialog(
//                  title: Text("Give the code?"),
//                  content: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      TextField(
//                        controller: _pinPutController,
//                      ),
//                    ],
//                  ),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text("Confirm"),
//                      textColor: Colors.white,
//                      color: AppColors.orange,
//                      onPressed: () async {
//                        final code = _pinPutController.text.trim();
//                        AuthCredential credential =
//                        PhoneAuthProvider.getCredential(
//                            verificationId: verificationId, smsCode: code);
//
//                        AuthResult result =
//                        await _auth.signInWithCredential(credential);
//
//                        FirebaseUser user = result.user;
//
//                        if (user != null) {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => Home(
//                                    user: user.uid,
//                                  )));
//                        } else {
//                          print("Error");
//                        }
//                      },
//                    )
//                  ],
//                );
//              });
//        },
//        codeAutoRetrievalTimeout: null);
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('images/2.jpg'),
                fit: BoxFit.cover,

              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text("LOGIN"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Otp(
                                  phoneNumber: phone,
                                )));
//                    loginUser(phone, context);
                  },
                  color: AppColors.orange,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class Otp extends StatefulWidget {
  final String phoneNumber;

  Otp({this.phoneNumber});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCredential _phoneAuthCredential;
  String _verficationId;


  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.orange, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authentication();
  }

  Future<bool> authentication()async {
    print("+91${widget.phoneNumber}");
    _auth.verifyPhoneNumber(
        phoneNumber: "+91${widget.phoneNumber}",
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);


  }


  void verificationCompleted(AuthCredential phoneAuthCredential) async{
    print('verificationCompleted');
    this._phoneAuthCredential = phoneAuthCredential;
    AuthResult result = await _auth.signInWithCredential(this._phoneAuthCredential);

    FirebaseUser user = result.user;
    if (user != null) {
//            Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => Store(
////                          user: user.uid,
//                        )));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StoreForm()));
    } else {
      print("Error");
    }
    print(phoneAuthCredential);
  }
  void verificationFailed(AuthException error) {
    print(error);
  }

  void codeSent(String verificationId, [int code]) {
    this._verficationId = verificationId;

  }

  void codeAutoRetrievalTimeout(String verificationId) {
    this._verficationId = verificationId;
    print('codeAutoRetrievalTimeout');
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
            child: Image(
              image: AssetImage('images/3.jpg'),
              fit: BoxFit.cover,
              height: 300,
              width: 100,
            ),
          ),
          Container(
//            padding: EdgeInsets.all(20),
            color: Colors.white,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: PinPut(
              fieldsCount: 6,
              onSubmit: null,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.slide,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(10)),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.orange,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            child: MaterialButton(
              padding: EdgeInsets.all(15),
              color: AppColors.orange,
              child: Text('Submit', style: AppStyles.buttonTextStyle),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.widgetBorderRadius))),
              onPressed: () async{
                final code = _pinPutController.text.trim();
                AuthCredential credential =
                PhoneAuthProvider.getCredential(
                    verificationId: _verficationId, smsCode: code);
                AuthResult result =
                await _auth.signInWithCredential(credential);

                FirebaseUser user = result.user;
                if (user != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoreForm(
                          )));
                } else {
                  print("Error");
                }

              },
            ),
          )
        ],
      ),
    );
  }


//  Future<bool> loginUser(String phone, BuildContext context) async {
//    FirebaseAuth _auth = FirebaseAuth.instance;
//
//    _auth.verifyPhoneNumber(
//        phoneNumber: phone,
//        timeout: Duration(seconds: 60),
//        verificationCompleted: (AuthCredential credential) async {
//          Navigator.of(context).pop();
//
//          AuthResult result = await _auth.signInWithCredential(credential);
//
//          FirebaseUser user = result.user;
//
//          if (user != null) {
////            Navigator.pushReplacement(
////                context,
////                MaterialPageRoute(
////                    builder: (context) => Store(
//////                          user: user.uid,
////                        )));
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (context) => Home()));
//          } else {
//            print("Error");
//          }
//
//          //This callback would gets called when verification is done auto maticlly
//        },
//        verificationFailed: (AuthException exception) {
//          print(exception.message);
//        },
//        codeSent: (String verificationId, [int forceResendingToken]) {
//          showDialog(
//              context: context,
//              barrierDismissible: false,
//              builder: (context) {
//                return AlertDialog(
//                  title: Text("Give the code?"),
//                  content: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      TextField(
//                        controller: _pinPutController,
//                      ),
//                    ],
//                  ),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text("Confirm"),
//                      textColor: Colors.white,
//                      color: AppColors.orange,
//                      onPressed: () async {
//                        final code = _pinPutController.text.trim();
//                        AuthCredential credential =
//                        PhoneAuthProvider.getCredential(
//                            verificationId: verificationId, smsCode: code);
//
//                        AuthResult result =
//                        await _auth.signInWithCredential(credential);
//
//                        FirebaseUser user = result.user;
//
//                        if (user != null) {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => Home(
//                                    user: user.uid,
//                                  )));
//                        } else {
//                          print("Error");
//                        }
//                      },
//                    )
//                  ],
//                );
//              });
//        },
//        codeAutoRetrievalTimeout: null);
//  }
}
