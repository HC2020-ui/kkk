import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/theme.dart';

class AddEmployees extends StatefulWidget {
  @override
  _AddEmployeesState createState() => _AddEmployeesState();
}
var now= DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');

class _AddEmployeesState extends State<AddEmployees> {
  bool checkBoxValue1=false;
  bool checkBoxValue2=false;
  String name;
  String email;
  String phone;
  String role;
  String gender;
  bool validator=false;
  final _formkey=GlobalKey<FormState>();

  String sta="Choose";
  List<String> staTypes = [
    'Choose',
    'Manager',
    'Delivery Man',
  ];


  final String formatted = formatter.format(now);

  saveToDatabase() async {
    var rn=Random();
    var num=rn.nextInt(999999999)+1;
    await FirebaseFirestore.instance.collection('employee')
        .doc(num.toString())
    .set({
      "name":name,
      "phone":phone,
      "email":email,
      "role":sta,
      "joined_date":formatted,
    }).then((value) {
      Toast.show("Employee added successfully!!!", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
      print("success");
    });
  }

  void _showdialogbox() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation",style: TextStyle(color: Colors.red)),
          content: new Text("Do you want to Save"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                  await saveToDatabase();
                  Navigator.pop(context);
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(
              top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(93, 187, 99, 1),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text('Add Employee', style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/logo_app.png",
          ),
        ),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {
            if(_formkey.currentState.validate()) {
              _showdialogbox();
            }
          })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formkey,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new ListTile(
                leading: const Icon(Icons.person),
                title: new TextFormField(
                  autovalidate: validator,
                  validator: (val){
                    return val.isEmpty ? "Please enter Your Name" : null;
                  },
                  onChanged: (value){
                    setState(() {
                      name=value;
                    });
                  },
                  decoration: new InputDecoration(
                    hintText: "Name",
                  ),
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.phone),
                title: new TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidate: validator,
                  validator: (val){
                    return val.isEmpty ? "Please enter Phone Number" : null;
                  },
                  onChanged: (value){
                    setState(() {
                      phone=value;
                    });
                  },
                  decoration: new InputDecoration(
                    hintText: "Phone",
                  ),
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.email),
                title: new TextFormField(
                  autovalidate: validator,
                  validator: (val){
                    return val.isEmpty ? "Please enter email" : null;
                  },
                  onChanged: (value){
                    setState(() {
                      email=value;
                    });
                  },
                  decoration: new InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text('Choose your role below :',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.orange, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ButtonTheme(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  alignedDropdown: false,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Instock'),
                      value: sta,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: AppColors.orange,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          sta = newValue;
                        });
                      },
                      items: staTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 1.5,
              ),
              new ListTile(
                leading: const Icon(Icons.label),
                title: const Text('Employee'),
                subtitle: const Text('Male/Female'),
              ),
              new ListTile(
                leading: const Icon(Icons.today),
                title: const Text('Date of Joining'),
                subtitle: new Text(formatted),
              ),
              new ListTile(
                leading: const Icon(Icons.group),
                title: const Text('Contact group'),
                subtitle: const Text('Not specified'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
