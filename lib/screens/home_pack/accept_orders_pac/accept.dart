import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/accept_orders_pac/screen2.dart';

import '../../../appBar.dart';

class AcceptScreen extends StatefulWidget {
  @override
  _AcceptScreenState createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Order Number'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Customer Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Customer Address'),
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
                Container(
                  color: Colors.grey,
                  child: table(),
                ),
                // table(),
                // Divider(color: Colors.grey,),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Total Amount'),
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
