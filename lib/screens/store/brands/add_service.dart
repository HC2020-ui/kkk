import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:winkl/config/theme.dart';

class AddServices extends StatefulWidget {
  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {

  final _formkey = GlobalKey<FormState>();
  bool _autoValidation = false;
  var uuid = Uuid();
  String name;
  String details;
  String offer;
  String _imageUrl= "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";

  String cat_val = "Choose Category";
  List<String> catlist = [
    'Choose Category',
    'Salon',
    'repair',
    'Installment'
  ];
  var _myPets = List<Widget>();
  int _index = 1;
  var _myPets1 = List<Widget>();
  int _index1 = 1;

  void _add1(){
    TextEditingController controller= new TextEditingController();
    int keyValue = _index1;
    _myPets1 = List.from(_myPets1)
    ..add(Column(
      key: Key("${keyValue}"),
      children: [
        ListTile(
          title:new TextFormField(
            controller: controller,
            autovalidate: false,
            validator: (val){
              return val.isEmpty? 'Please enter Description ':null;
            },
            onChanged: (value){
              setState(() {
                offer= value;
              });
            },
            decoration: new InputDecoration(
              hintText: "Enter Description (Optional)",
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.clear),
            onPressed: (){
              _myPets1.remove(controller);
              --_index1;
            },
          ),
        )
      ],
    ));

    setState(() {
      ++_index1;
    });
  }

  void _add() {
    int keyValue = _index;
    TextEditingController controller= new TextEditingController();
    _myPets = List.from(_myPets)
      ..add(Column(
        key: Key("${keyValue}"),
        children: [
          ListTile(
            title:new TextFormField(
              controller: controller,
              autovalidate: false,
              validator: (val){
                return val.isEmpty? 'Please enter Discount ':null;
              },
              onChanged: (value){
                setState(() {
                  offer= value;
                });
              },
              decoration: new InputDecoration(
                hintText: "Discounted Price",
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.clear),
              onPressed: (){
                _myPets.remove(controller);
                --_index;
              },
            ),
          )
        ],
      ));

    setState(() => ++_index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.green,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24, color: Colors.white,)),
        title: Text("Add Service", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: KeyboardAvoider(
          autoScroll: true,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height+300,
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Image(
                            image: AssetImage('images/placeholder.png',
                            ),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Text('Upload your image here'),
                        SizedBox(height: 5,),
                        Text('(You can add upto 4 product images)', style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text("Add Service images (upto 8)", style: TextStyle(color: Colors.grey.withOpacity(0.5)),)),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: cat_val,
                            isExpanded: true,
                            underline: Container(
                              height: 2,
                              color: Colors.orange,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                cat_val = newValue;
                              });
                            },
                            items: catlist.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(child: Text('+ Add Discount on this Item (Optional)', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                      onTap: (){
                        _add();
                      },
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 100,
                      child:ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        physics: NeverScrollableScrollPhysics(),
                        children: _myPets,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                        child: TextFormField(
                          autovalidate: _autoValidation,
                          validator: (val){
                            return val.isEmpty ? "Please enter Service Name" : null;
                          },
                          //validator: requireFieldValidator,
                          onChanged: (value){
                            setState(() {
                              name=value;
                            });
                          },
                          decoration: AppStyles.textFormFieldDecoration
                              .copyWith(hintText: 'Service Name'),
                        )),
                    SizedBox(height: 20),
                    GestureDetector(child: Text('+ Add More Details', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                      onTap: (){
                        _add1();
                      },
                    ),
                    Divider(thickness: 1.5,color: Colors.grey),
                    Container(
                      height: 100,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(5),
                          shrinkWrap: true,
                          children: _myPets1
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      height: 58.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text("Add Service"),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        onPressed: () async {
                          if(_formkey.currentState.validate()) {
                            addDatatoDatabase();
                            Navigator.pop(context,name);
                          }
                        },
                        color: Color.fromRGBO(19, 110, 180, 1),
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getProfileImageWidget(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: GestureDetector(
//
        onTap: () {
          _showMyDialog(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: FadeInImage.assetNetwork(
              placeholder: "images/placeholder.png",
              image: _imageUrl,
              height: 300,
              width: 300,
              fit: BoxFit.cover
          ),

        ),
      ),

    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.orange,
          title: Text(
            'Profile Photo',
            style: AppStyles.buttonTextStyle,
          ),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              // button 1
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
//                      getImage(ImageSource.camera);
                    },
                  ),
                  Text(
                    'Camera',
                    style: AppStyles.buttonTextStyle
                        .copyWith(color: AppColors.white),
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.photo,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
//                      getImage(ImageSource.gallery);
                    },
                  ),
                  Text(
                    'Gallery',
                    style: AppStyles.buttonTextStyle
                        .copyWith(color: AppColors.white),
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ), // button 2
            ])
          ],
        );
      },
    );
  }

  addDatatoDatabase() async {
    var rn=new Random();
    var num=rn.nextInt(89984816)+1;
    await FirebaseFirestore.instance.collection("addServices")
        .doc(num.toString()).collection('services')
    .doc(uuid.v4())
        .set({
      'service_name':name,
      'category':cat_val,
      'details':details,
    }).then((value) {
      Toast.show("Your Product details has been saved!!!", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      print("success");
    });
  }
}
