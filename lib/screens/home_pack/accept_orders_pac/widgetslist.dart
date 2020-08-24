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
                children: [Text('Item Detail')],
              ),
              Column(
                children: [Text('Quantity')],
              ),
            ],
          ),
          tableRowValues("Item1", "1223"),
          tableRowValues("Item2", "1323"),
          tableRowValues("Item3", "1523"),
          tableRowValues("Item4", "1623"),
          tableRowValues("Item5", "1723"),
          tableRowValues("Item6", "1123"),
        ],
      ),
    ),
  );
}

TableRow tableRowValues(String first, String second) {
  return TableRow(
    children: [
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
