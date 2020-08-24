import 'package:flutter/material.dart';

AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      title: Text('LOGO'),
      backgroundColor: Colors.indigo,
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VerticalDivider(
              thickness: 5,
            ),
            Text('        '),
            Text(
              "Store Name",
              style: TextStyle(fontSize: 30),
            ),
            Text("                                        "),
          ],
        ),
      ],
    );
  }

  
  Widget table() {
    return Center(
      child: Container(
        // color: Colors.grey,
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