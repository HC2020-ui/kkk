import 'package:flutter/material.dart';

import '../../../appBar.dart';

double iconSize = 20;

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text('Order Number'),
            ),
            // buttonMaker(num: 1, color: Colors.grey, text: "Order No."),
            Divider(
              height: 4,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text('Customer Name'),
            ),
            Divider(
              height: 4,
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Text('Address'),
            ),
            Divider(
              height: 4,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Order Accepted'),
                    Text('Delivery'),
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Text("Order Details"),
              ),
            ),
            table(),
            // buttonMaker(num: 1, color: Colors.grey, text: ''),
            Divider(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Total Bill Amount'),
                Text('26576'),
              ],
            ),
            Divider(
              height: 4,
            ),
            Center(
              heightFactor: 1.5,
              child: RaisedButton(
                elevation: 5,
                color: Colors.indigoAccent,
                child: Text(
                  'Ready For Delivery',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
//
//  Expanded buttonMaker({int num, Color color, String text}) {
//    return Expanded(
//      child: FlatButton(
//        child: Text(text),
//        color: color,
//        onPressed: () {},
//      ),
//    );
//  }
//
//  Widget table() {
//    return Center(
//      child: Container(
//        margin: EdgeInsets.all(10.0),
//        child: Table(
//          border: TableBorder.all(),
//          children: [
//            TableRow(
//              children: [
//                Column(
//                  children: [Text('Item Detail')],
//                ),
//                Column(
//                  children: [Text('Quantity')],
//                ),
//              ],
//            ),
//            tableRowValues("Item1", "1223"),
//            tableRowValues("Item2", "1323"),
//            tableRowValues("Item3", "1523"),
//            tableRowValues("Item4", "1623"),
//            tableRowValues("Item5", "1723"),
//            tableRowValues("Item6", "1123"),
//          ],
//        ),
//      ),
//    );
//  }
//
//  TableRow tableRowValues(String first, String second) {
//    return TableRow(
//      children: [
//        Column(
//          children: <Widget>[
//            Text(first),
//          ],
//        ),
//        Column(
//          children: <Widget>[
//            Text(second),
//          ],
//        ),
//      ],
//    );
//  }

  
}
