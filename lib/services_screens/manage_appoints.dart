import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/screen2.dart';

import 'final_screen.dart';

class ManageAppoints extends StatefulWidget {
  String order;
  String c_name;
  String c_address;
  String storename;
  ManageAppoints({this.order,this.c_name,this.c_address, this.storename});
  @override
  _ManageAppointsState createState() => _ManageAppointsState();
}

class _ManageAppointsState extends State<ManageAppoints> {
  String finalDate='';
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController ordercontroller= new TextEditingController();
  TextEditingController addresscontroller= new TextEditingController();
  TextEditingController sumcontroller= new TextEditingController();
  double tAmount=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text=widget.c_name;
    addresscontroller.text=widget.c_address;
    ordercontroller.text=widget.order;
    sumcontroller.text= tAmount.toString();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          final int itemcount = snapshot.data.docs.length;
          if (snapshot.data == null) {
            return Scaffold(body: Center(child: CircularProgressIndicator(),));
          } else if (itemcount == 0 || snapshot.hasError) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          switch (snapshot.connectionState) {
            case(ConnectionState.waiting):
              return Scaffold(body: Center(child: CircularProgressIndicator(),));
            case(ConnectionState.none):
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            default:
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title:     Container(
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
                            child: Text(widget.storename!=null?widget.storename:"Store Name", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
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
                      child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black,)),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: ordercontroller,
                            decoration: InputDecoration(
                                labelText: 'Appointment Number'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                                labelText: 'Customer Name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: addresscontroller,
                            decoration: InputDecoration(
                                labelText: 'Customer Address'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Center(
                            child: Text('Appointment Accepted'),
                          ),
                          Center(
                            child: Text('Delivery'),
                          ),
                          // Divider(color: Colors.grey,),
                          Container(
                            color: Colors.grey,
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Appointment Detail',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                children: [
                                  Column(
                                    children: [Text('Sr. NO.')],
                                  ),
                                  Column(
                                    children: [Text('Date')],
                                  ),
                                  Column(
                                    children: [Text('Time')],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.grey,
                            height: 100,
                            child: ListView.builder(
                              itemCount: itemcount,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot data = snapshot.data
                                    .docs[index];
                                return Table(
                                  border: TableBorder.all(
                                      color: Colors.black26,
                                      width: 1
                                  ),
                                  children: [
                                    TableRow(
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            Text((index+1).toString()),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(data.get('date')),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(data.get('time').toString()),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          // table(),
                          // Divider(color: Colors.grey,),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Total Amount',
                            ),
                            controller: sumcontroller,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: RaisedButton(
                                color: Colors.indigoAccent,
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a Snackbar.
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SecondScreen();
                                        },
                                      ),
                                    );
                                    // Scaffold.of(context).showSnackBar(
                                    // SnackBar(content: Text('Processing Data')));
                                  }
                                },
                                child: Text(
                                  'Allot Service Man',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        }
    );
  }
}
