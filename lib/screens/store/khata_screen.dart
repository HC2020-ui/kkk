import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class KhataScreen extends StatefulWidget {
  @override
  _KhataScreenState createState() => _KhataScreenState();
}

class _KhataScreenState extends State<KhataScreen> {
  int currentPosition=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.green.shade500,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24, color: Colors.white,)),
        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('My Money'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text('Yesterday'),
                      color: Colors.green.shade500,
                      onPressed: (){

                      },
                    ),
                    RaisedButton(
                      child: Text('This Week'),
                      color: Colors.green.shade500,
                      onPressed: (){

                      },
                    ),
                    RaisedButton(
                      child: Text('Last Week'),
                      color: Colors.green.shade500,
                      onPressed: (){

                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: (){

            },
          ),
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.green,
        tabs: [
          TabData(
            iconData: Icons.shopping_basket,
            title: "Home",
          ),
          TabData(
            iconData: Icons.attach_money,
            title: "Rupee",
          ),
          TabData(
            iconData: Icons.call,
            title: "What App",
          ),
          TabData(
            iconData: Icons.settings,
            title: "Settings",
          ),
        ],
        onTabChangedListener: (position){
          setState(() {
            currentPosition=position;
          });
        },
      ),
    );
  }
}
