import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/components/bottom_nav.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/store/add_product.dart';

class AddBrands extends StatefulWidget {
  final storeValue;
  AddBrands({this.storeValue});

  @override
  _AddBrandsState createState() => _AddBrandsState();
}

bool checkedValue = true;
int selectedRadoButton = 1;

class _AddBrandsState extends State<AddBrands> {
  final _brandsController = TextEditingController();
  final _productsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: KeyboardAvoider(
            autoScroll: true,
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  Spacer(flex: 5,),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text("All Set", style: TextStyle(fontSize: AppSizes.titleFontSize, color: AppColors.orange),)),
                  Spacer(flex: 5,),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text("You may now set up your shop", style: TextStyle(color: Colors.black, fontSize: 18.0),)),
                  Spacer(flex: 10,),
                  Image.asset("images/shop.png", width: 323.0, height: 219.0,),
                  Spacer(flex: 36,),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Brand Name"),
                    controller: _brandsController,
                  ),
                  Spacer(flex: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProduct()),
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                        elevation: 3.0,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                              child: Text("Add Brands +", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black54),))),
                    ),
                  ),
                  Spacer(flex: 30,),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Product Name"),
                    controller: _productsController,
                  ),
                  Spacer(flex: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProduct()),
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                          elevation: 3.0,
                          child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Add Products +", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black54),))),
                    ),
                  ),
                  Spacer(flex: 25,),
                  widget.storeValue == "Services" ? Row(
                    children: <Widget>[
                      Spacer(),
                      Text("I sell Services : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                      Spacer(flex: 1,),
                      Radio(
                        value: selectedRadoButton,
                        groupValue: 1,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          setState(() {
                            if(selectedRadoButton == 2) {
                              selectedRadoButton = 1;
                            }
                          });
                        },
                      ),
                      Text("Yes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueGrey[600]),),
                      Spacer(flex: 1,),
                      Radio(
                        value: selectedRadoButton,
                        groupValue: 2,
                        activeColor: Colors.red,
                        onChanged: (val) {
                          setState(() {
                            if(selectedRadoButton == 1) {
                              selectedRadoButton = 2;
                            }
                          });
                        },
                      ),
                      Text("No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueGrey[600]),),
                      Spacer(flex: 3,),
                    ],
                  ) : Container(),
                  Spacer(flex: 25,),
                  widget.storeValue == "Services" ? CheckboxListTile(
                    title: Text("I agree to Terms & Conditions", style: TextStyle(),),
                    value: checkedValue,
                    activeColor: Colors.green,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ) : Container(),
                  Spacer(flex: 25,),
                  MaterialButton(
                    minWidth: 324.0,
                    height: 49.0,
                    padding: EdgeInsets.all(15.0),
                    color: Color.fromRGBO(255, 81, 81, 1),
                    child: Text(widget.storeValue == "Services" ? widget.storeValue : "Open Shop for Sales", style: TextStyle(color: Colors.white, fontSize: 18,)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                            )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav(Currentindex: 0,)),
                      );
                    },
                  ),
                  Spacer(flex: 70,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
