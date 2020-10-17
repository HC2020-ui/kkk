import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/screen2.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/widgetslist.dart' as list;

import '../../../appBar.dart';

class AcceptScreen extends StatefulWidget {
  String order;
  String c_name;
  String c_address;

  AcceptScreen({this.order,this.c_name,this.c_address});

  @override
  _AcceptScreenState createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
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
                              labelText: 'Order Number'),
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
                          child: Text('Order Accepted'),
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
                                  'Order Detail',
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
                                          Text(data.get('name')),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(data.get('quantity').toString()),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(data.get('selling_price')),
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
                                'Ready For Delivery',
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
