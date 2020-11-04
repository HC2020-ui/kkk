import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_share/social_share.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

bool _isShutterOpen = true;
bool _isDelivery = true;

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(35,198,252, 1),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            Navigator.pop(context);
          }),
          title: Text('Settings', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/placeholder.png',
                        height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                          color: Color.fromRGBO(35,198,252, 1),
                        ),
                        Text('+ Add Logo', style: TextStyle(color: Color.fromRGBO(35,198,252, 1), fontWeight: FontWeight.w800, fontSize: 15),)
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Dukkan', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),),
                        Row(
                          children: [
                            Text('Edit my Store details', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Color.fromRGBO(35,198,252, 1),),),
                            SizedBox(width: 5,),
                            FaIcon(FontAwesomeIcons.arrowAltCircleRight, size: 15,)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Divider(color: Colors.grey.shade500,),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Store Status :',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: _isShutterOpen? ' Open':' Closed',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _isShutterOpen=!_isShutterOpen;
                        });
                      },
                      child: _switch_button(_isShutterOpen)),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Delivery :',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: _isDelivery? ' Available': ' Not Available',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _isDelivery=!_isDelivery;
                        });
                      },
                      child: _switch_button(_isDelivery)),
                ],
              ),
              SizedBox(height: 20,),
              InkWell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                      SizedBox(width: 10,),
                      Text('Share shop with customers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                    ],
                  ),
                ),
                onTap: (){
                  SocialShare.shareWhatsapp('http://nukkad.in/stores/{id}/');
                },
              ),
              SizedBox(height: 20,),
              Divider(thickness: 3,color: Colors.grey.shade300,),
              ListTile(
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.shareSquare),
                    SizedBox(width: 10,),
                    Text('Refer this App', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                  ],
                ),
              ),
              ListTile(
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.questionCircle),
                    SizedBox(width: 10,),
                    Text('App Guide and Help', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                  ],
                ),
              ),
              ListTile(
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.star),
                    SizedBox(width: 10,),
                    Text('Rate App on Playstore', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                  ],
                ),
              ),
              ListTile(
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.trophy),
                    SizedBox(width: 10,),
                    Text('My Rewards', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                  ],
                ),
              ),
              ListTile(
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.compass),
                    SizedBox(width: 10,),
                    Text('App Navigation', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                  ],
                ),
                trailing: IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.black,), onPressed: null),
              ),
              ListTile(
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.signOutAlt),
                    SizedBox(width: 10,),
                    Text('Logout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17)),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _switch_button(bool status){
    return Container(
      padding: EdgeInsets.all(0),
      child: CustomSwitchButton(
        buttonHeight: 22.0,
        buttonWidth: 42.0,
        indicatorWidth: 15.0,
        backgroundColor: Color.fromRGBO(35,198,252, 0.5),
        unCheckedColor: Color.fromRGBO(35,198,252, 1),
        animationDuration: Duration(milliseconds: 200),
        checkedColor: Color.fromRGBO(35,198,252, 1),
        checked: status,
      ),
    );
  }
}
