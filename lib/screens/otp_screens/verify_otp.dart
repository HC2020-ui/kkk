import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/store/add_brands.dart';
import 'package:winkl/screens/store/store_form.dart';

class VerifyOtp extends StatefulWidget {
  String establishmanetName;
  String proprietorName;
  String email;
  String phone;
  String serviceValue;
  String serviceType;
  String storeType;
  String gps;
  String imageUrl;
  VerifyOtp(this.establishmanetName,this.proprietorName,this.email,this.phone,this.serviceValue,this.serviceType,this.storeType,this.gps,this.imageUrl);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

final FocusNode _pinPutFocusNode = FocusNode();
VerifyOtp verifyOtpArgs;
class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otpController = new TextEditingController();
  AuthCredential _credential;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsCode;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInwithPhone("+91${widget.phone}");
  }

  @override
  Widget build(BuildContext context) {
    verifyOtpArgs = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back, color: Font_Style().secondaryColor, size: 24,)),
      ),
      body: SafeArea(
        child: KeyboardAvoider(
          autoScroll: true,
          child: Container(
            width: MediaQuery.of(context).size.width*2,
            color: Colors.white,
            child: Center(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: 0.0.w, right: 0.0.w, bottom: 10.0.h),
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 100,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/verify_otp.png", width: 313.0.w,
                      height: 200.0.h,),
                    Spacer(flex: 45,),
                    Text("OTP Verification",
                      style: Font_Style().montserrat_ExtraBold(null, 24),),
                    Spacer(flex: 16,),
                    Text("Enter the OTP send to the number ",
                      textAlign: TextAlign.center,
                      style: Font_Style().montserrat_SemiBold(null, 16),),
                    Spacer(flex: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 2,),
                        Text("+91 ${widget.phone.substring(0, 3)}xxxx${widget
                            .phone.substring(7)}", textAlign: TextAlign.center,
                          style: Font_Style().montserrat_SemiBold(null, 16),),
                        SizedBox(width: 20,),
                        InkWell(
                            onTap: () {
//                            Navigator.pushNamed(context, "/get_otp");
                            },
                            child: Text("Edit",
                              style: Font_Style().montserrat_Regular_Underline(
                                  Color.fromRGBO(214, 25, 63, 1), 12),)),
                        Spacer(flex: 2,),
                      ],
                    ),
                    Spacer(flex: 52,),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(
                          left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
                      padding: EdgeInsets.only(
                          left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
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
                                color: Font_Style().secondaryColor.withOpacity(
                                    0.2),
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
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
                                color: Font_Style().secondaryColor.withOpacity(
                                    0.2),
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
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
                                color: Font_Style().secondaryColor.withOpacity(
                                    0.2),
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
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
                          "Didn't receive OTP?  ", textAlign: TextAlign.center,
                          style: Font_Style().montserrat_SemiBold(Font_Style()
                              .primaryColor, 14),),
                        InkWell(
                            onTap: () {
                              /////////////////////////////////
                            },
                            child: Text("RESEND", textAlign: TextAlign.center,
                              style: Font_Style().montserrat_medium(
                                  Font_Style().primaryColor, 14),)),
                      ],
                    ),
                    Spacer(flex: 52,),
                    _buttonWidget(context),
                    Spacer(flex: 120,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
//          signInwithPhone("+91${widget.phone}");
        },
        child: Container(
          width: 234.w,
          decoration: BoxDecoration(
              color: Font_Style().primaryColor,
              borderRadius: BorderRadius.circular(30)),
          height: 48.h,
          child: Center(
            child: Text(
                "Verify & Proceed",
                style: Font_Style().montserrat_Bold(Colors.white, 19)
            ),
          ),
        ),
      ),
    );
  }

  void sucRegDialog() {
    showDialog(context: context, builder: (BuildContext context) =>
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: 20.0.h, bottom: 20.0.h, left: 20.0.w, right: 20.0.w),
            height: 150.0.h,
            width: 350.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 20,),
                Text("You have successfully registered.",
                  style: Font_Style().montserrat_SemiBold(
                      Font_Style().secondaryColor, 18),),
                Spacer(flex: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.all(2.0.h),
                        height: 22.0.h,
                        width: 55.0.w,
                        decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.all(
                                Radius.circular(30.0))
                        ),
                        child: Center(child: Text(
                          "OK", style: Font_Style().montserrat_Bold(Colors
                            .white, 14),))),
                  ),
                ),
                Spacer(flex: 10,),
              ],
            ),
          ),
        )
    );
  }

  signInwithPhone(phone) async{
    _auth.verifyPhoneNumber(
      phoneNumber:phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential)async{
         await _auth.signInWithCredential(authCredential).then((UserCredential result){
           if(result.user!=null) {
             Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context) =>
                   AddBrands(
                       widget.establishmanetName,
                       widget.proprietorName,
                       widget.email,
                       widget.phone,
                       widget.serviceValue,
                       widget.serviceType,
                       widget.storeType,
                       widget.gps,
                       widget.imageUrl,
                     result.user.uid,
                   ),
             ));
           }else{
             print("error");
           }
        }).catchError((e){
          print(e);
        });
      },
      verificationFailed: (FirebaseAuthException authException){
        print(authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]){
        //show dialog to take input from the user
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Enter SMS Code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                  ),

                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    smsCode = otpController.text.trim();

                    _credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
                    await auth.signInWithCredential(_credential).then((UserCredential result) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => AddBrands(widget.establishmanetName,widget.proprietorName,widget.email,widget.phone,widget.serviceValue,widget.serviceType,widget.storeType,widget.gps,widget.imageUrl,result.user.uid,),
                      ));
                    }).catchError((e){
                      print(e);
                    });
                  },
                )
              ],
            )
        );
      },
      codeAutoRetrievalTimeout: (String verificationId){
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      },
    );
  }

}