import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/settings_pack/settings_home.dart';

class BottomNav extends StatefulWidget {
  var Currentindex;
  var location;
  BottomNav({this.Currentindex,this.location});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> _list;

  @override
  void initState() {
    if(widget.Currentindex==null){
      setState(() {
        widget.Currentindex=0;
      });
    }
    setState(() {
      _list=[
        Home(),
        Container(),
        Container(),
        Settings(),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(Icons.menu, size: 24, color: Colors.black,),
            );
          },
          ),
          title: Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Font_Style().primaryColor, size: 24,),
              SizedBox(width: 10.0.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.location!=null?widget.location:"Location not found", style: Font_Style().montserrat_Bold(null, 14),),
                  Text(widget.location!=null?widget.location:"Location not found", style: Font_Style().montserrat_Regular(null, 10),),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 30.0.w),
                child: InkWell(
                    onTap: () {
                    },
                    child: Icon(Icons.notifications, size: 24, color: Colors.black,))),
          ],
        ),
        body: SafeArea(
            child: _list[widget.Currentindex]
        ),
        bottomNavigationBar: SizedBox(
          height: 65.0.h,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text("Home"),
                icon: Padding(
                    padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                    child: Icon(Icons.home)),
              ),
              BottomNavigationBarItem(
                title: Text("Orders"),
                icon: Padding(
                    padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                    child: Icon(Icons.book)),
              ),
              BottomNavigationBarItem(
                title: Text("Khata"),
                icon: Padding(
                    padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                    child: Icon(Icons.person_outline)),
              ),
              BottomNavigationBarItem(
                title: Text("Settings"),
                icon: Padding(
                    padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                    child: Icon(Icons.settings)),
              ),
            ],
            iconSize: 26.h,
            showUnselectedLabels: true,
            selectedItemColor: Font_Style().primaryColor,
            unselectedItemColor: Color.fromRGBO(7, 9, 32, 0.5),
            currentIndex:widget.Currentindex,
            selectedLabelStyle: Font_Style().montserrat_Bold(null, 9.0),
            unselectedLabelStyle: Font_Style()
                .montserrat_Regular(Color.fromRGBO(7, 9, 32, 0.5), 9.0),
            onTap: (val) {
              setState(() {
                widget.Currentindex=val;
              });
            },
          ),
        ),
      ),
    );
  }
}
