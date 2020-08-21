import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';

class AcceptPartial extends StatefulWidget {
  @override
  _AcceptPartialState createState() => _AcceptPartialState();
}

bool _isDelivery = true;
bool _isChecked = false;

class _AcceptPartialState extends State<AcceptPartial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24, color: Colors.black,)),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 18.0, right: 18.0),
        child: Column(
          children: <Widget>[
            Container(
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
            Spacer(flex: 10,),
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
            Spacer(flex: 5,),
            Row(
              children: <Widget>[
                Text("Delivery", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(width: 7.0,),
                InkWell(
                    onTap: () {
                      setState(() {
                        _isDelivery = !_isDelivery;
                      });
                    },
                    child: _switch_button(_isDelivery)),
              ],
            ),
            Spacer(flex: 5,),
            Text("Accept Partial Order Delivery",textAlign: TextAlign.center , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),),
            Spacer(flex: 10,),
            Text("Order Details", textAlign: TextAlign.center , style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(23, 35, 147, 1), fontSize: 20.0),),
            Spacer(flex: 5,),
            Table(
              border: TableBorder.all(
                color: Colors.black26, width: 1,),
              children: [
                TableRow(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text('Select All', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),))),
                      ),
                    ]),
                TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('Item 1', style: TextStyle(color: Colors.teal),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Checkbox(
                              value: _isChecked,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = val;
                                });
                              }
                          ),)),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('Item 2', style: TextStyle(color: Colors.teal),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Checkbox(
                              value: _isChecked,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = val;
                                });
                              }
                          ),)),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('Item 3', style: TextStyle(color: Colors.teal),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Checkbox(
                              value: _isChecked,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = val;
                                });
                              }
                          ),)),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('Item 4', style: TextStyle(color: Colors.teal),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Checkbox(
                              value: _isChecked,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = val;
                                });
                              }
                          ),)),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('Item 5', style: TextStyle(color: Colors.teal),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Text('XX', style: TextStyle(color: Colors.deepOrange),))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(child: Checkbox(
                              value: _isChecked,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = val;
                                });
                              }
                          ),)),
                    ]
                ),
              ],
            ),
            Spacer(flex: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buttonWidget(context, 150.0, 45, Colors.red, "Reject"),
                _buttonWidget(context, 150.0, 45, Colors.green, "Accept")
              ],
            ),
            Spacer(flex: 20,),
          ],
        ),
      ),
    );
  }

  Widget _buttonWidget(BuildContext context, double wid, double hei, Color color, String title) {
    return Container(
      child: InkWell(
        onTap: (){
          ///////////////////
        },
        child: Container(
          width: wid,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          height: hei,
          child: Center(
            child: Text(
                title,
                style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold, fontSize: 19.0)
            ),
          ),
        ),
      ),
    );
  }

  Widget _switch_button(bool status){
    return Container(
      padding: EdgeInsets.all(0),
      child: CustomSwitchButton(
        buttonHeight: 22.0,
        buttonWidth: 42.0,
        indicatorWidth: 15.0,
        backgroundColor: Colors.white,
        unCheckedColor: Colors.grey,
        animationDuration: Duration(milliseconds: 200),
        checkedColor: Colors.black,
        checked: status,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)
      ),
    );
  }
}
