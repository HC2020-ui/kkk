import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:toast/toast.dart';
import 'package:winkl/config/theme.dart';
// import 'package:winkl/screens/components/bottom_nav.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/store/add_product.dart';
import 'package:winkl/screens/store/brands/add_service.dart';
import 'package:winkl/screens/store/brands/brandsList.dart';
// import 'file:///C:/Users/LENOVO/Desktop/StackNation_%20Internship/winkl/lib/screens/home_pack/manage_inventory/productsList.dart';
import 'package:winkl/services_screens/services_main.dart';

class AddBrands extends StatefulWidget {
  String establishmanetName;
  String proprietorName;
  String email;
  String phone;
  String serviceValue;
  String serviceType;
  String storeType;
  String gps;
  String imageUrl;
  String uid;
  AddBrands(this.establishmanetName,this.proprietorName,this.email,this.phone,this.serviceValue,this.serviceType,this.storeType,this.gps,this.imageUrl,this.uid);

  @override
  _AddBrandsState createState() => _AddBrandsState();
}

bool checkedValue = true;
int selectedRadoButton = 1;

class _AddBrandsState extends State<AddBrands> {
  final _brandsController = TextEditingController();
  final _productsController = TextEditingController();
  var _serviceController=TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  var firestoreInstance=FirebaseFirestore.instance;
  var storeType;
  var brandName="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDatatoDatabase(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void updatebrand(String name){
    setState(() {
      _brandsController.text=name;
    });
  }

  void updateservice(String uname){
    setState(() {
      _serviceController.text=uname;
    });
  }


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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 0,),
                    Align(
                      alignment: Alignment.centerLeft,
                        child: Text("All Set", style: TextStyle(fontSize: AppSizes.titleFontSize, color: AppColors.orange),)),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                        child: Text("You may now set up your shop", style: TextStyle(color: Colors.black, fontSize: 18.0),)),
                    SizedBox(height: 0,),
                    Image.asset("images/shop.png", width: 323.0, height: 219.0,),
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (value){

                      },
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
//                      initialValue: brandName,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          final name= await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BPList()),
                          );
                          print(name);
                          updatebrand(name??"updating...");
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
                    SizedBox(height: 20,),
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
                          hintText: widget.storeType=="Services"?"Service Name":"Product Name"),
                      controller: widget.storeType=="Services"?_serviceController:_productsController,
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          if(widget.storeType=="Services") {
                            var _uname=await Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>AddServices()),
                            );
                            print(_uname);
                            updateservice(_uname);
                          }else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProduct("add",id: widget.uid)),
                            );
                          }
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
                                child: Text(widget.storeType == "Services" ?"Add Services +":"Add Products +", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black54),)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    widget.storeType == "Services" ? CheckboxListTile(
                      title: Text("I agree to Terms & Conditions", style: TextStyle()),
                      value: checkedValue,
                      activeColor: Colors.green,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ) : Container(),
                    SizedBox(height: 10,),
                    MaterialButton(
                      minWidth: 324.0,
                      height: 49.0,
                      padding: EdgeInsets.all(15.0),
                      color: Color.fromRGBO(255, 81, 81, 1),
                      child: Text("Open Shop for Sales", style: TextStyle(color: Colors.white, fontSize: 18,)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                              )),
                      onPressed: () {
                       addtoDatabase();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>widget.storeType=="Services"?Home(): Homepage()), (route) => false);
                      },
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addDatatoDatabase(BuildContext context) async {

    var firebaseUser=await _auth.currentUser;
      FirebaseFirestore.instance
          .collection("stores")
          .doc(firebaseUser.uid)
          .set({
          "uid": widget.uid,
        "email": widget.email,
        "phone":  widget.phone,
        "seller_category": widget.serviceType,
        "establishment_name": widget.establishmanetName,
        "proprietor_name": widget.proprietorName,
        "service_radius": widget.serviceValue,
        "store_type": widget.storeType,
        "area": widget.gps,
        "imageUrl": widget.imageUrl
      }).then((value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Ooops!! We have some problem, sorry'),
        ));
      })
          .catchError((e) {
        print('There is some error');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Ooops!! We have some problem, sorry'),
        ));
      });
  }

  addtoDatabase() async {

    await FirebaseFirestore.instance.collection("brands")
        .doc(widget.uid)
        .set({
      'name':_brandsController.text,
    }).then((value) {
      Toast.show("The brand has been saved!!!", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      print("success");
    });
  }

}
