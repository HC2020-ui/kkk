import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:winkl/config/fontstyle.dart';
import 'package:winkl/config/theme.dart';

class AddVariants extends StatefulWidget {
  @override
  _AddVariantsState createState() => _AddVariantsState();
}

class _AddVariantsState extends State<AddVariants> {
  String sizeVal = "Size";
  List<String> sizeList = [
    "Size 1",
    "Size 2",
    "Size 3",
    "Size 4",
    "Size 5"
  ];

  String colorVal = "Color";
  List<String> colorList = [
    "Colour 1",
    "Colour 2",
    "Colour 3",
    "Colour 4",
    "Colour 5"
  ];

  String offerVal = "Offer %";
  List<String> offerList = [
    "10%",
    "20%",
    "30%",
    "50%",
    "70%",
    "80%",
    "90%",
    "100%"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(19, 110, 180, 1),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back, size: 24, color: Colors.white,)),
        title: Text("Add Variants", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  height: 130.0,
                  width: 350.0,
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          sizeVal, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        items: sizeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            sizeVal = val;
                          });
                        },
                      ),
                      Spacer(),
                      Container(
                        height: 23.0,
                        width: 85.0,
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Center(child: Text("Add Size", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 20,),
              Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  height: 130.0,
                  width: 350.0,
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          colorVal, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        items: colorList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            colorVal = val;
                          });
                        },
                      ),
                      Spacer(),
                      Container(
                        height: 23.0,
                        width: 85.0,
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Center(child: Text("Add Colour", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 20,),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text("Price based on chosen Size and Colour :", style: Font_Style().montserrat_SemiBold(Font_Style().primaryColor, 16),)),
              Spacer(flex: 10,),
              Card(
                  elevation: 3.0,
                  child: Container(
                      padding: EdgeInsets.all(7),
                      child: Text("Rs. 250/-", style: Font_Style().montserrat_SemiBold(Font_Style().secondaryColor, 16),))),
              Spacer(flex: 20,),
              Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  height: 130.0,
                  width: 350.0,
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          offerVal, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        items: offerList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            offerVal = val;
                          });
                        },
                      ),
                      Spacer(),
                      Container(
                        height: 23.0,
                        width: 85.0,
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Center(child: Text("Add Offer", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 20,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Price after offer is applied :", style: Font_Style().montserrat_SemiBold(Font_Style().primaryColor, 16),)),
              Spacer(flex: 10,),
              Card(
                elevation: 3.0,
                  child: Container(
                    padding: EdgeInsets.all(7),
                      child: Text("Rs. 250/-", style: Font_Style().montserrat_SemiBold(Font_Style().secondaryColor, 16),))),
              Spacer(flex: 20,),
              Spacer(flex: 150,),
              Container(
                width: 280.0,
                height: 58.0,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text("Save & Continue", style: TextStyle(fontSize: 20),),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    ////////////
                  },
                  color: Color.fromRGBO(19, 110, 180, 1),
                ),
              ),
              Spacer(flex: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
