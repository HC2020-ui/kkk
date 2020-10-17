import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept.dart';
import 'package:winkl/screens/home_pack/home.dart';

class AcceptPartial extends StatefulWidget {

  String order;
  String c_name;
  String c_address;
  int n;
  AcceptPartial({this.order,this.c_name,this.c_address,this.n});

  @override
  _AcceptPartialState createState() => _AcceptPartialState();
}
bool _isDelivery = true;
var _isChecked= new List<dynamic>(1000);

class _AcceptPartialState extends State<AcceptPartial> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final int Itemcount = snapshot.data.docs.length ?? 0;
          if (snapshot.data == null) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          else if (Itemcount == 0 || snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Container(
                  padding: EdgeInsets.only(
                      top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
                  height: 45.0,
                  width: 345.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(255, 117, 117, 1),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text("LOGO", style: TextStyle(color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                      Spacer(flex: 2),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Store Name", style: TextStyle(color: AppColors
                              .white, fontSize: 16, fontWeight: FontWeight
                              .bold),)),
                      Spacer(flex: 3,),
                    ],
                  ),
                ),
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back, size: 24, color: Colors.black,)
                ),
              ),
              body: Center(
                child: Text('No Item'),
              ),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            default:
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Container(
                    padding: EdgeInsets.only(
                        top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
                    height: 45.0,
                    width: 345.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 117, 117, 1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text("LOGO", style: TextStyle(color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),),
                        Spacer(flex: 2,),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Store Name", style: TextStyle(color: AppColors
                                .white, fontSize: 16, fontWeight: FontWeight
                                .bold),)),
                        Spacer(flex: 3,),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back, size: 24.0, color: Colors.black,)),
                ),
                body: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 18.0, right: 18.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Order No. : ${widget.order}",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),)),
                      Spacer(flex: 5,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Customer Name : ${widget.c_name}",
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14.0))),
                      Spacer(flex: 5,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Customer Address : ${widget.c_address}",
                              style: TextStyle(
                                  color: Color.fromRGBO(22, 162, 55, 1),
                                  fontSize: 14.0))),
                      Spacer(flex: 5,),
                      Row(
                        children: <Widget>[
                          Text("Delivery", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
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
                      Text("Accept Partial Order Delivery",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0),),
                      Spacer(flex: 10,),
                      Text("Order Details", textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(23, 35, 147, 1),
                            fontSize: 20.0),),
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
                                      verticalAlignment: TableCellVerticalAlignment
                                          .middle,
                                      child: Center(child: Text('Sr. No.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,),))),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TableCell(
                                      verticalAlignment: TableCellVerticalAlignment
                                          .middle,
                                      child: Center(child: Text('Item',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,),))),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TableCell(
                                      verticalAlignment: TableCellVerticalAlignment
                                          .middle,
                                      child: Center(child: Text('Quantity',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,),))),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TableCell(
                                      verticalAlignment: TableCellVerticalAlignment
                                          .middle,
                                      child: Center(child: Text('Select',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,),))),
                                ),
                              ]),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: 250,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: ListView.builder(
                            itemCount: Itemcount,
                            itemBuilder: (context,
                                index) {
                              print(Itemcount.toString());
                              print('hey');
                              final DocumentSnapshot data = snapshot
                                  .data.docs[index];
                              return Table(
                                border: TableBorder.all(
                                  color: Colors.black26,
                                  width: 1,),
                                children: [
                                  TableRow(
                                      children: <Widget>[
                                        TableCell(
                                            verticalAlignment: TableCellVerticalAlignment
                                                .middle,
                                            child: Center(child: Text((index+1).toString(),
                                              style: TextStyle(color: Colors.black),))),
                                        TableCell(
                                            verticalAlignment: TableCellVerticalAlignment
                                                .middle,
                                            child: Center(child: Text(data.get('name').toString().toUpperCase(),
                                              style: TextStyle(color: Colors.teal,fontSize: 13))
                                            )
                                        ),
                                        TableCell(
                                            verticalAlignment: TableCellVerticalAlignment
                                                .middle,
                                            child: Center(child: Text(data.get('quantity').toString(),
                                              style: TextStyle(
                                                  color: Colors.deepOrange),))),
                                        TableCell(
                                            verticalAlignment: TableCellVerticalAlignment
                                                .middle,
                                            child: Center(child: Checkbox(
                                                value: true,
                                                onChanged: (val) {
                                                  setState(() {

                                                  });
                                                }
                                            ),)),
                                      ]
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Spacer(flex: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buttonWidget(
                              context, 150.0, 45, Colors.red, "Reject"),
                          _buttonWidget(
                              context, 150.0, 45, Colors.green, "Accept")
                        ],
                      ),
                      Spacer(flex: 20,),
                    ],
                  ),
                ),
              );
          }
        }
    );
  }

  Widget _buttonWidget(BuildContext context, double wid, double hei, Color color, String title) {
    return Container(
      child: InkWell(
        onTap: (){
          if(title=="Reject"){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
          }else if(title=="Accept"){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptScreen()));
          }
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
