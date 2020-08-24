import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveredDetails extends StatefulWidget {
  @override
  _DeliveredDetailsState createState() => _DeliveredDetailsState();
}

class _DeliveredDetailsState extends State<DeliveredDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(255, 117, 117, 1),
          ),
          child: Row(
            children: <Widget>[
              Text("LOGO", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
              Spacer(flex: 2,),
              Align(
                  alignment: Alignment.center,
                  child: Text("Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
              Spacer(flex: 3,),
            ],
          ),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24, color: Colors.black,)),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 18.0, right: 18.0),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Order No. : 5", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),)),
                Spacer(flex: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Customer Name : XYZ", style: TextStyle(color: Colors.red, fontSize: 14.0))),
                Spacer(flex: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Customer Address : Mumbai", style: TextStyle(color: Color.fromRGBO(22, 162, 55, 1), fontSize: 14.0))),
                Spacer(flex: 10,),
                Text("Order Details", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: AppColors.orange),),
                Spacer(flex: 10,),
                Table(
                  border: TableBorder.all(
                    color: Colors.black26, width: 1,),
                  children: [
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),))),
                          ),
                        ]),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 1', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 2', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 3', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 4', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 5', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 6', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 7', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 8', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 9', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('Item 10', style: TextStyle(color: Colors.teal),))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TableCell(
                                verticalAlignment: TableCellVerticalAlignment.bottom,
                                child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                          ),
                        ]
                    ),
                  ],
                ),
                Spacer(flex: 5,),
                Align(
                  alignment: Alignment.centerLeft,
                    child: Text("Total Bill Amount : Rs. XXXX/-", style: Font_Style().montserrat_Bold(null, 16),)),
                Spacer(flex: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.orange, borderRadius: BorderRadius.circular(10)),
                  height: 48.h,
                  child: Center(
                    child: Text(
                        "Order Complete",
                        style: Font_Style().montserrat_Bold(Colors.white, 19)
                    ),
                  ),
                ),
                Spacer(flex: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
