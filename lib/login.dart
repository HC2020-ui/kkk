import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:winkl/screens/store/wrap.dart';
import 'package:winkl/services_screens/services_main.dart';

class Login extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();


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
                keyboardType: TextInputType.number,
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
                    if(phone!=null || phone!="") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Otp(
                                    phoneNumber: phone,
                                  )));
//                    loginUser(phone, context);
                    }else{
                      Toast.show('Please Enter the phone', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
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
  UserCredential result;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  AuthCredential _credential;
  var storeType;
  String _verificationId;
  final firestoreUser = FirebaseFirestore.instance;
  String smsCode;


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
    print(widget.phoneNumber);
    Firebase.initializeApp().whenComplete(() => signInwithPhone("+91${widget.phoneNumber}"));
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
              onPressed: () async {
                smsCode = _pinPutController.text.trim();
                                _credential = PhoneAuthProvider.credential(
                                    verificationId: _verificationId, smsCode: smsCode);
                                await _auth.signInWithCredential(_credential).then((
                                    UserCredential result) {
                                  if (result.user != null) {
                                    print(result.user.uid);
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(
                                        builder: (context) =>
                                            Wrapper2(id: result.user.uid,phone: widget.phoneNumber,)
                                    )).then((value) {
                                      Toast.show("Login Successfully", context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                    });
                                  } else {
                                    print('error');
                                  }
                                }).catchError((e) {
                                  print(e);
                                });
                              },
                            )
//                    FirebaseAuth auth = FirebaseAuth.instance;

//                              String smsCode = _pinPutController.text.trim();
//
//                              _credential = PhoneAuthProvider.getCredential(
//                                  verificationId: _verficationId, smsCode: smsCode);
//                              await auth.signInWithCredential(_credential).then((
//                                  AuthResult result) async {
//
//                                //getting data from database
//
////                                storeType=snapshot.data['store_type'].toString();
////                                storeType= snapshot.data((DocumentSnapshot document){
////                                  return document[uid].data['store_type'].toString();
////                                });
//                                print(storeType);
//                                print("fuck");
//
//                              }).catchError((e) {
//                                print(e);
//                              });
            ),
        ],
      ),
    );
  }

//  getstoreType() async {
//    var firebaseUser= await _auth.currentUser();
//    await firestoreUser.collection("stores").document(firebaseUser.uid).get()
//        .then((DocumentSnapshot) => {
//      storeType=DocumentSnapshot.data['store_type'].toString(),
//    });
//    print(storeType);
//  }
  signInwithPhone(phone) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) async{
        await _auth.signInWithCredential(authCredential).then((
            UserCredential result) {
          setState(() {
            _credential=authCredential;
          });
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Wrapper2(id: result.user.uid,phone: phone,)
          ));
        }).catchError((e) {
          print(e);
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        if(_credential==null) {
          setState(() {
            _verificationId=verificationId;
          });
          //show dialog to take input from the user
          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (context) =>
          //         AlertDialog(
          //           title: Text("Enter SMS Code"),
          //           content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: <Widget>[
          //               TextField(
          //                 keyboardType: TextInputType.number,
          //                 controller: otpController,
          //               ),
          //             ],
          //           ),
          //           actions: <Widget>[
          //             FlatButton(
          //               child: Text("Done"),
          //               textColor: Colors.white,
          //               color: Colors.redAccent,
          //               onPressed: () async {
          //                 FirebaseAuth auth = FirebaseAuth.instance;
          //
          //                 smsCode = otpController.text.trim();
          //
          //                 _credential = PhoneAuthProvider.credential(
          //                     verificationId: verificationId, smsCode: smsCode);
          //                 await auth.signInWithCredential(_credential).then((
          //                     UserCredential result) {
          //                   if (result.user != null) {
          //                     print(result.user.uid);
          //                     Navigator.pop(context);
          //                     Navigator.pushReplacement(
          //                         context, MaterialPageRoute(
          //                         builder: (context) =>
          //                             Wrapper2(id: result.user.uid,phone: phone,)
          //                     )).then((value) {
          //                       Toast.show("Login Successfully", context,
          //                           duration: Toast.LENGTH_SHORT,
          //                           gravity: Toast.BOTTOM);
          //                     });
          //                   } else {
          //                     print('error');
          //                   }
          //                 }).catchError((e) {
          //                   print(e);
          //                 });
          //               },
          //             )
          //           ],
          //         )
          // );
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      },
    );
  }
}