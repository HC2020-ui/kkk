import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class KhataScreen extends StatefulWidget {
  @override
  _KhataScreenState createState() => _KhataScreenState();
}

class _KhataScreenState extends State<KhataScreen> {

  Choice _selectedChoice = choices[0];
  int currentPosition=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.green.shade500,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, size: 24, color: Colors.white,)),
          title:  Text('My Money', style: TextStyle(color: Colors.white,),),
          actions:[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.assessment,
                  size: 26.0,
                  color: Colors.white,
                ),
              )
          ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                    color: Colors.white,
                  ),
                )
            ),
            PopupMenuButton<Choice>(
              icon: new Icon(Icons.more_vert_rounded, color: Colors.white),
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title)
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
      body: ChoiceCard(choice: _selectedChoice),
    );
  }

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }
}

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  const ChoiceCard({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.display1;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                choice.icon,
                size: 128.0,
              ),
              Text(choice.title, style: textStyle)
            ],
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Yesterday', icon: Icons.today),
  const Choice(title: 'today', icon: Icons.today),
  const Choice(title: 'This Week', icon: Icons.calendar_today_outlined),
  const Choice(title: 'Last Week', icon: Icons.calendar_today_sharp),
  const Choice(title: 'This month', icon: Icons.calendar_today_sharp),
  const Choice(title: 'Last month', icon: Icons.calendar_today_sharp),
  const Choice(title: 'Custom', icon: Icons.dashboard_customize),
];