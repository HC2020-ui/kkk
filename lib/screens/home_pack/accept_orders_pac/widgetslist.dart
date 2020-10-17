import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Expanded buttonMaker({int num, Color color, String text}) {
  return Expanded(
    child: FlatButton(
      child: Text(text),
      color: color,
      onPressed: () {},
    ),
  );
}

Widget table() {
  return Center(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                Column(
                  children: [Text('Sr. NO.')],
                ),
                Column(
                  children: [Text('Item Detail')],
                ),
                Column(
                  children: [Text('Quantity')],
                ),
                Column(
                  children: [Text('Price')],
                ),
              ],
            ),
            tableRowValues(1, "Item", "1223", 2000.00),
            tableRowValues(2, "Item", "1323", 3000.00),
            tableRowValues(3, "Item", "1523", 5564.00),
            tableRowValues(4, "Item", "1623", 6600.00),
            tableRowValues(5, "Item", "1723", 7200.00),
            tableRowValues(6, "Item", "1123", 8060.00),
          ],
        ),
      )
  );
}

TableRow tableRowValues(int n,String first, String second,double pr) {
  return TableRow(
    children: [
      Column(
        children: <Widget>[
          Text(n.toString()),
        ],
      ),
      Column(
        children: <Widget>[
          Text(first),
        ],
      ),
      Column(
        children: <Widget>[
          Text(second),
        ],
      ),
      Column(
        children: <Widget>[
          Text(pr.toString()),
        ],
      ),
    ],
  );
}

Center buttons(String text, Color color) {
  return Center(
    heightFactor: 1.5,
    child: SizedBox(
      width: 200,
      height: 50,
      child: RaisedButton(
        elevation: 5,
        color: color,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          // Navigator.pushNamed(context, '/second');
        },
      ),
    ),
  );
}
