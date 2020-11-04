import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/newHomeScreen.dart';
import 'package:winkl/screens/home_pack/profile_page.dart';
import 'package:winkl/screens/intro/intro.dart';
import 'package:winkl/screens/settings_pack/settings_home.dart';
import 'package:winkl/screens/store/khata_screen.dart';
import 'package:winkl/settings_page.dart';

class MembershipPage extends StatefulWidget {
  String name;
  String location;
  String phone;
  String vendor_type;
  String email;
  String storename;
  String membership;
  MembershipPage({this.name,this.email,this.phone,this.vendor_type,this.location,this.storename,this.membership});
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  
  FirebaseAuth _auth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 1020,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.grey.shade300,
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 520,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(icon: Icon(Icons.arrow_back_ios),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              ),
                              // Text('Back',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.left,),
                              FlatButton(
                                child: Text('Stats>>', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18),),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NewHomeScreen(store_name: widget.storename,)));
                                },
                              )
                            ],
                          ),
                          Center(
                           child: Image(
                              image: AssetImage('images/wnkl.png'),
                              height: 200,
                              width: 200,
                              fit: BoxFit.contain,
                             color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Center(child: Text('Monkey D. Luffy',style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30
                          ),)),
                          SizedBox(height: 10,),
                          Center(child: Text(widget.storename??'Loading...',style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25
                          ),)),
                          SizedBox(height:10,),
                          Center(
                            child: RaisedButton.icon(
                              onPressed: (){
                                Toast.show('Coming soon... ', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                              },
                              elevation: 2.0,
                              color: Colors.white,
                              icon: Icon(Icons.change_history_sharp),
                              label: Text('Change Icon', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 17),),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('192', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text('Orders',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('150', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text('Employees',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70,
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image(image: AssetImage('images/man.png'),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                backgroundColor: Colors.green,
                              ),
                              SizedBox(width: 20,),
                              Text('My Profile', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(name: widget.name,email: widget.email,phone: widget.phone,vendor_type: widget.vendor_type,location: widget.location,storename: widget.storename)));
                          },
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image(image: AssetImage('images/crown.png'),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                backgroundColor: Colors.red,
                              ),
                              SizedBox(width: 20,),
                              Text('Join Membership', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            _launchURL('https://nukkd.in/membership');
                          },
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(image: AssetImage('images/about.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 20,),
                              Text('About', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                              _launchURL('https://nukkd.in/about');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          child: Divider(thickness: 1.5,),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image(image: AssetImage('images/invitation.png'),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                backgroundColor: Colors.purpleAccent,
                              ),
                              SizedBox(width: 20,),
                              Text('Invite Vendors', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            final RenderBox box = context.findRenderObject();
                            Share.share('Download this App from here http://nukkd.in',
                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                              subject: 'Share APP'
                            );
                          },
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image(image: AssetImage('images/telemarketer.png'),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 20,),
                              Text('Help', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            _launchURL('http://nukkd.in/help');
                          }
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.star_rate,
                                size: 30,
                                  color: Colors.black,
                                ),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(width: 20,),
                              Text('Rate Us on Play-Store', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                          child: Divider(height: 10,thickness: 1.5,),
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(image: AssetImage('images/arrow.png'),
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 20,),
                              Text('Logout', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            _auth.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>IntroScreen()), (route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    // const url = 'http://nukkad.in/help';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
