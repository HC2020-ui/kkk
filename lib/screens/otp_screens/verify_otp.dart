import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/store/add_brands.dart';

class VerifyOtp extends StatefulWidget {
  final String storeValue;
  VerifyOtp({this.storeValue});

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

final FocusNode _pinPutFocusNode = FocusNode();
VerifyOtp verifyOtpArgs;

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otpController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    verifyOtpArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, color: Font_Style().secondaryColor, size: 24,)),
      ),
      body: SafeArea(
        child: KeyboardAvoider(
          autoScroll: true,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, bottom: 10.0.h),
                height: MediaQuery.of(context).size.height - 100,
                width: 327.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/verify_otp.png", width: 313.0.w, height: 200.0.h,),
                    Spacer(flex: 45,),
                    Text("OTP Verification", style: Font_Style().montserrat_ExtraBold(null, 24),),
                    Spacer(flex: 16,),
                    Text("Enter the OTP send to the number ", textAlign: TextAlign.center, style: Font_Style().montserrat_SemiBold(null, 16),),
                    Spacer(flex: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 2,),
                        Text("+91 5451xxxx264", textAlign: TextAlign.center, style: Font_Style().montserrat_SemiBold(null, 16),),
                        Spacer(flex: 4,),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/get_otp");
                          },
                            child: Text("Edit", style: Font_Style().montserrat_Regular_Underline(Color.fromRGBO(214, 25, 63, 1), 12),)),
                        Spacer(flex: 2,),
                      ],
                    ),
                    Spacer(flex: 52,),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
                      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
                      child: PinPut(
                        fieldsCount: 4,
                        onSubmit: ((String pin) => () {

                        }),
                        autofocus: true,
                        focusNode: _pinPutFocusNode,
                        controller: otpController,
                        submittedFieldDecoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Font_Style().secondaryColor.withOpacity(0.2),
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
                                color: Font_Style().secondaryColor.withOpacity(0.2),
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
                                color: Font_Style().secondaryColor.withOpacity(0.2),
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
                        Text("Didn't receive OTP?  ", textAlign: TextAlign.center, style: Font_Style().montserrat_SemiBold(Font_Style().primaryColor, 14),),
                        InkWell(
                            onTap: () {
                              /////////////////////////////////
                            },
                            child: Text("RESEND", textAlign: TextAlign.center, style: Font_Style().montserrat_medium(Font_Style().primaryColor, 14),)),
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
        onTap: (){
          sucRegDialog();
          if(otpController.text.length == 4) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddBrands(storeValue: widget.storeValue,);
            }));
          }
        },
        child: Container(
          width: 234.w,
          decoration: BoxDecoration(
              color: Font_Style().primaryColor, borderRadius: BorderRadius.circular(30)),
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
            padding: EdgeInsets.only(top: 20.0.h, bottom: 20.0.h, left: 20.0.w, right: 20.0.w),
            height: 150.0.h,
            width: 350.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 20,),
                Text("You have successfully registered.", style: Font_Style().montserrat_SemiBold(Font_Style().secondaryColor, 18),),
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
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                        ),
                        child: Center(child: Text("OK", style: Font_Style().montserrat_Bold(Colors.white, 14),))),
                  ),
                ),
                Spacer(flex: 10,),
              ],
            ),
          ),
        )
    );
  }
}
