import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/accept.dart';
import 'package:winkl/screens/home_pack/newHomePage.dart';

import '../home.dart';
import 'accept_partial.dart';

class AcceptOrderDetails extends StatefulWidget {
  String order;
  String c_name;
  String c_address;
  String employee;
  String store_type;
  String number;
  String storename;

  AcceptOrderDetails({this.order,this.c_name,this.c_address,this.employee, this.store_type, this.number, this.storename});

  @override
  _AcceptOrderDetailsState createState() => _AcceptOrderDetailsState();
}

bool _isDelivery = true;

class _AcceptOrderDetailsState extends State<AcceptOrderDetails> {

  int Itemcount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(top: 7.0,
              bottom: 7.0,
              left: 10.0,
              right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(93, 187, 99, 1),
          ),
          child: Align(
                  alignment: Alignment.center,
                  child: Text(widget.storename==null?"Store Name":widget.storename,
                    style: TextStyle(color: AppColors
                        .white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),)),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/logo_app.png",
          ),
        ),
        actions: [
          widget.store_type != null ? IconButton(
            icon: Icon(Icons.timelapse_outlined, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FunkyOverlay(),
              );
            },
            tooltip: 'Check Appointment',
          )
              : Container()
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            Itemcount = snapshot.data.docs.length ?? 0;
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            else if (Itemcount == 0 || snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('No Item'),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              default:
                return Container(
                    child: SafeArea(
                        child: Center(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(top: 10.0,
                                  bottom: 10.0,
                                  left: 18.0,
                                  right: 18.0),
                              child: Column(
                                  children: <Widget>[
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Order No. : ${widget.order}",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight
                                                  .w500),)),
                                    Spacer(flex: 5,),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "Customer Name : ${widget
                                                .c_name}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14.0))),
                                    Spacer(flex: 5,),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "Customer Address : ${widget
                                                .c_address}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    22, 162, 55, 1),
                                                fontSize: 14.0))),
                                    Spacer(flex: 5,),
                                    Row(
                                      children: <Widget>[
                                        Text("Delivery",
                                          style: TextStyle(
                                              fontWeight: FontWeight
                                                  .bold,
                                              color: Colors.black),),
                                        SizedBox(width: 7.0,),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                _isDelivery =
                                                !_isDelivery;
                                              });
                                            },
                                            child: _switch_button(
                                                _isDelivery)),
                                      ],
                                    ),
                                    Spacer(flex: 10,),
                                    Text("Order Details",
                                      style: TextStyle(fontSize: 18.0,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.orange),),
                                    Spacer(flex: 10,),
                                    Table(
                                        border: TableBorder.all(
                                          color: Colors.black26,
                                          width: 1,),
                                        children: [
                                          TableRow(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets
                                                      .all(12.0),
                                                  child: TableCell(
                                                      verticalAlignment: TableCellVerticalAlignment
                                                          .middle,
                                                      child: Center(
                                                          child: Text(
                                                            'Item',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .red),))),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets
                                                      .all(12.0),
                                                  child: TableCell(
                                                      verticalAlignment: TableCellVerticalAlignment
                                                          .middle,
                                                      child: Center(
                                                          child: Text(
                                                            'Quantity',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .green),))),
                                                ),
                                              ]),
                                        ]
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        height: 300,
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
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .all(12.0),
                                                        child: TableCell(
                                                            verticalAlignment: TableCellVerticalAlignment
                                                                .bottom,
                                                            child: Center(
                                                                child: Text(
                                                                  data
                                                                      .get(
                                                                      'name')
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    fontSize: 18.0,),))),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .all(12.0),
                                                        child: TableCell(
                                                            verticalAlignment: TableCellVerticalAlignment
                                                                .bottom,
                                                            child: Center(
                                                                child: Text(
                                                                  data
                                                                      .get(
                                                                      'quantity')
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    fontSize: 18.0,),))),
                                                      ),
                                                    ]),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Spacer(flex: 20,),

                                    widget.employee == 'yes'
                                        ? Container()
                                        : Row(
                                      children: <Widget>[
                                        _buttonWidget(context, 90, 45,
                                            Colors.red, "Reject"),
                                        Spacer(),
                                        _buttonWidget(context, 136, 45,
                                            Colors.orangeAccent,
                                            "Accept Partial"),
                                        Spacer(),
                                        _buttonWidget(context, 90, 45,
                                            Colors.green, "Accept")
                                      ],
                                    ),
                                    Spacer(flex: 15,),
                                  ]
                              ),
                            )
                        )
                    )
                );
            }
          }
      ),
    );
  }

  Widget _buttonWidget(BuildContext context, double wid, double hei, Color color, String title) {
    return Container(
      child: InkWell(
        onTap: (){
          print(title);
          if(title == "Accept") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptScreen(order: widget.order,c_name: widget.c_name,c_address: widget.c_address,)));
          }
          else if(title == "Accept Partial") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptPartial(order: widget.order,c_name: widget.c_name,c_address: widget.c_address,n: Itemcount,number: widget.number,storename: widget.storename,)));
          }
          else {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NewHomePage()), (route) => false);
          }
        },
        child: Container(
          width: wid,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(30)),
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

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 250,
            width: 320,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: Text('Appointment status : ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                    title: Text('Done', style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w900)),
                  ),
                  Text('(Please check your Date and Time below)', style: TextStyle(color: Colors.red),),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(image: AssetImage('images/chronometer.png'),
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 20,),
                        Text('5:00', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: Text('Edit', style: TextStyle(color: Colors.blue)),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(image: AssetImage('images/calendar.png'),
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 20,),
                        Text('01/20/20', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: Text('Edit', style: TextStyle(color: Colors.blue)),
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}


