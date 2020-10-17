import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/home_pack/manage_employees/add_employees.dart';

import 'orders.dart';

class EmployeeList2 extends StatefulWidget {
  String phone;
  EmployeeList2({this.phone});
  @override
  _EmployeeList2State createState() => _EmployeeList2State();
}

class _EmployeeList2State extends State<EmployeeList2> {

  TextEditingController otpController = new TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;
  AuthCredential _credential;
  String smsCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('employee').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            // count of events
            final int eventCount = snapshot.data.docs.length ?? 0;
            if (snapshot.data == null) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if (eventCount == 0 || snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Container(
                    padding: EdgeInsets.only(
                        top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
                    height: 45.0,
                    width: 345.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 117, 117, 1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Spacer(flex: 2,),
                        Align(
                            alignment: Alignment.center,
                            child: Text("Invalid Number", style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),)),
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
                    child: Icon(
                        Icons.arrow_back, size: 24.0, color: Colors.black),
                  ),
                ),
                body: SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 12, 5, 20),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Center(child: Text('Invalid Number!!!',
                            style: TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold),)),
                        );
                      },
                      padding: EdgeInsets.all(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    width: double.infinity,
                    height: 80,
                  ),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              default:
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Container(
                      padding: EdgeInsets.only(
                          top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
                      height: 45.0,
                      width: 345.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 117, 117, 1),
                      ),
                      child: Row(
                        children: <Widget>[
                          Spacer(flex: 2,),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Invalid Number!!!", style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),)),
                          Spacer(flex: 3,),
                        ],
                      ),
                    ),
                    actions: [
                      // IconButton(
                      //   icon: Icon(Icons.sort),
                      //   color: Colors.black26,
                      //   onPressed: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>BPList()));
                      //   },
                      // )
                    ],
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                          Icons.arrow_back, size: 24.0, color: Colors.black),
                    ),
                  ),
                  body: new ListView.builder(
                      itemCount: eventCount,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot data = snapshot.data.docs[index];
                        if (data.get('phone') == widget.phone) {
                          _signInviaOTP(widget.phone);
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "images/verify_otp.png", width: 313.0,
                                    height: 200.0,),
                                  Spacer(flex: 45,),
                                  Text("OTP Verification",
                                    style: Font_Style().montserrat_ExtraBold(
                                        null, 24),),
                                  Spacer(flex: 16,),
                                  Text("Enter the OTP send to the number ",
                                    textAlign: TextAlign.center,
                                    style: Font_Style().montserrat_SemiBold(
                                        null, 16),),
                                  Spacer(flex: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Spacer(flex: 2,),
                                      Text("+91 ${widget.phone.substring(
                                          0, 3)}xxxx${widget
                                          .phone.substring(7)}",
                                        textAlign: TextAlign.center,
                                        style: Font_Style().montserrat_SemiBold(
                                            null, 16),),
                                      SizedBox(width: 20,),
                                      InkWell(
                                          onTap: () {
//                            Navigator.pushNamed(context, "/get_otp");
                                          },
                                          child: Text("Edit",
                                            style: Font_Style()
                                                .montserrat_Regular_Underline(
                                                Color.fromRGBO(214, 25, 63, 1),
                                                12),)),
                                      Spacer(flex: 2,),
                                    ],
                                  ),
                                  Spacer(flex: 52,),
                                  Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 20.0),
                                    padding: EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 20.0),
                                    child: PinPut(
                                      fieldsCount: 6,
                                      onSubmit: ((String pin) =>
                                          () {

                                      }),
                                      autofocus: true,
                                      focusNode: _pinPutFocusNode,
                                      controller: otpController,
                                      submittedFieldDecoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Font_Style().secondaryColor
                                                  .withOpacity(
                                                  0.2),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                2.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                      selectedFieldDecoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Font_Style().secondaryColor
                                                  .withOpacity(
                                                  0.2),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                4.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                      followingFieldDecoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Font_Style().secondaryColor
                                                  .withOpacity(
                                                  0.2),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: Offset(
                                                0.0,
                                                // Move to right 10  horizontally
                                                2.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(2)
                                      ),
                                    ),
                                  ),
                                  Spacer(flex: 52,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Didn't receive OTP?  ",
                                        textAlign: TextAlign.center,
                                        style: Font_Style().montserrat_SemiBold(
                                            Font_Style()
                                                .primaryColor, 14),),
                                      InkWell(
                                          onTap: () {
                                            /////////////////////////////////
                                          },
                                          child: Text(
                                            "RESEND", textAlign: TextAlign.center,
                                            style: Font_Style().montserrat_medium(
                                                Font_Style().primaryColor, 14),)),
                                    ],
                                  ),
                                  Spacer(flex: 52,),
                                  Container(
                                    child: InkWell(
                                      onTap: () async {
                                        smsCode = otpController.text.trim();
                                        _credential = PhoneAuthProvider.credential(
                                            verificationId: _verificationId, smsCode: smsCode);
                                        await _auth.signInWithCredential(_credential).then((
                                            UserCredential result) {
                                          if (result.user != null) {
                                            print(result.user.uid);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Orders()));
                                          } else {
                                            print('error');
                                          }
                                        }).catchError((e) {
                                          print(e);
                                        });
                                      },
                                      child: Container(
                                        width: 234,
                                        decoration: BoxDecoration(
                                            color: Font_Style().primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                30)),
                                        height: 48,
                                        child: Center(
                                          child: Text(
                                              "Verify & Proceed",
                                              style: Font_Style().montserrat_Bold(
                                                  Colors.white, 19)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(flex: 120,),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }
                  ),
                );
            }
          }),
    );
  }

  _signInviaOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${phoneNumber}',
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) async {
        await _auth.signInWithCredential(authCredential).then((
            UserCredential result) {
          setState(() {
            _credential = authCredential;
          });
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Orders()
          ));
        }).catchError((e) {
          print(e);
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        if (_credential == null) {
          setState(() {
            _verificationId = verificationId;
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
