
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/screens/home_pack/home.dart';

import '../add_product.dart';
import '../add_variants.dart';
import '../product_search.dart';

class AddServices extends StatefulWidget {
  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {

  TextEditingController cat_controller= new TextEditingController();
  TextEditingController brand_controller= new TextEditingController();
  TextEditingController discount_controller= TextEditingController();
  TextEditingController finalPrice_controller= TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _autoValidation = false;
  var uuid = Uuid();
  String name;
  String details;
  String offer;
  String _imageUrl= "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";
  String brand_name="";
  String Sellingprice="";

  String cat_val = "Choose Category";
  List<String> catlist = [
    'Choose Category',
    'Salon',
    'repair',
    'Installment'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 10.0, right: 10.0),
          height: 45.0,
          width: 345.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            // color: Color.fromRGBO(255, 117, 117, 1),
          ),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Add Service", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height+300,
          child: Form(
            key: _formkey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    DottedBorder(
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Center(
                                child: Image.network('https://tekrabuilders.com/wp-content/uploads/2018/12/male-placeholder-image.jpeg',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                )
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      color: Colors.black,
                      strokeWidth: 1,
                    ),
                    Text('(You can add up to 4 product images)', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: Colors.grey),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Container(
                    child: TextFormField(
                      autovalidate: false,
                      validator: (val){
                        return val.isEmpty ? "Plz Provide Item name" : null;
                      },
                      onChanged: (value){
                        setState(() {
                          name=value;
                        });
                      },
                      decoration: new InputDecoration(
                        hintText: 'ex: AC Repair',
                        labelText: 'Service Name',
                        hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                      ),
                    )),

//                 new ListTile(
//                   leading: const Icon(Icons.person),
//                   title: new TextFormField(
//                     autovalidate: false,
//                     validator: (val){
//                       return val.isEmpty ? "Plz Provide Item name" : null;
//                     },
//                     onChanged: (value){
//                       setState(() {
//                         name=value;
//                       });
//                     },
//                     decoration: new InputDecoration(
//                       hintText: "Item Name and Size",
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // ListTile(
//                 //   title: Text('+ Add Discount on this Item (Optional)',textAlign: TextAlign.left ,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
//                 //   onTap: (){
//                 //     _add();
//                 //   },
//                 // ),
//                 // SizedBox(height: 10,),
//                 // Container(
//                 //   height: 50,
//                 //   child:ListView(
//                 //     shrinkWrap: true,
//                 //     padding: EdgeInsets.all(10),
//                 //     physics: NeverScrollableScrollPhysics(),
//                 //     children: _myPets,
//                 //   ),
//                 // ),
//                 SizedBox(height: 10,),
//                 new ListTile(
//                   leading: const Text('\u{20B9}'),
//                   title: new TextFormField(
//                     autovalidate: false,
//                     validator: (val){
//                       return val.isEmpty? 'Please enter the price':null;
//                     },
//                     onChanged: (value){
//                       setState(() {
//                         Sellingprice=value;
//                       });
//                     },
//                     decoration: new InputDecoration(
//                       hintText: "Price",
//                     ),
//                   ),
//                 ),
//                 new ListTile(
//                   leading: const Icon(Icons.details),
//                   title: new TextFormField(
//                     autovalidate: false,
//                     validator: (val){
//                       return val.isEmpty ? "Please enter Product details" : null;
//                     },
//                     onChanged: (value){
//                       setState(() {
//                         details=value;
//                       });
//                     },
//                     decoration: new InputDecoration(
//                       hintText: "Product Details",
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.all(10),
// //            width: 300,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: AppColors.orange, width: 2),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: ButtonTheme(
//                     alignedDropdown: false,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           hint: Text('Instock'),
//                           value: instock,
//                           isExpanded: true,
//                           underline: Container(
//                             height: 2,
//                             color: AppColors.orange,
//                           ),
//                           onChanged: (String newValue) {
//                             setState(() {
//                               instock = newValue;
//                             });
//                           },
//                           items: instocklist.map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // new ListTile(
//                 //   leading: const Icon(Icons.storage),
//                 //   title: new TextFormField(
//                 //     autovalidate: false,
//                 //     validator: (val){
//                 //       return val.isEmpty ? "Required field" : null;
//                 //     },
//                 //     onChanged: (value){
//                 //       setState(() {
//                 //         instock=value;
//                 //       });
//                 //     },
//                 //     decoration: new InputDecoration(
//                 //       hintText: "In stock",
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(height: 10,),
//                 Container(
//                   margin: EdgeInsets.all(10),
// //            width: 300,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: AppColors.orange, width: 2),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: ButtonTheme(
//                     padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     alignedDropdown: false,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           hint: Text('Choose Category'),
//                           value: cat_val,
//                           isExpanded: true,
//                           underline: Container(
//                             height: 2,
//                             color: AppColors.orange,
//                           ),
//                           onChanged: (String newValue) {
//                             setState(() {
//                               cat_val = newValue;
//                             });
//                           },
//                           items: catlist.map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  controller: cat_controller,
                  autovalidate: false,
                  validator: (val){
                    return val.isEmpty ? "Plz Provide Category name" : null;
                  },
                  onChanged: (value){
                    setState(() {
                      cat_val=value;
                    });
                  },
                  decoration: new InputDecoration(
                      hintText: 'Category name ',
                      labelText: 'Category',
                      hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){
                          var cat_name;
                          cat_name=Navigator.push(context, MaterialPageRoute(builder: (context)=> CategorySearch(type: 'category',)));
                          if(cat_name!=null) {
                            setState(() {
                              cat_controller.text = cat_name;
                              cat_val = cat_name;
                            });
                          }
                        },
                      )
                  ),
                )),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  controller: brand_controller,
                  autovalidate: false,
                  validator: (val){
                    return val.isEmpty ? "Plz Provide Brand name" : null;
                  },
                  onChanged: (value){
                    setState(() {
                      brand_name=value;
                    });
                  },
                  decoration: new InputDecoration(
                      hintText: 'Brand name',
                      labelText: 'Brand',
                      hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){
                          var brand_name;
                          brand_name=Navigator.push(context, MaterialPageRoute(builder: (context)=> CategorySearch(type: 'brand',)));
                          if(brand_name!=null) {
                            setState(() {
                              brand_controller.text = brand_name;
                              brand_name = brand_name;
                            });
                          }
                        },
                      )
                  ),
                )),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  autovalidate: false,
                  validator: (val){
                    return val.isEmpty ? "Plz Provide Item price" : null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    setState(() {
                      Sellingprice=value;
                    });
                  },
                  decoration: new InputDecoration(
                    hintText: 'ex: 5000.00 \$',
                    labelText: 'Price',
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                )),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  autovalidate: false,
                  validator: (val){
                    return val.isEmpty ? "Fill the offer" : null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    setState(() {
                      offer=value;
                      double discount;
                      double price= double.parse(Sellingprice);
                      double rate=double.parse(value);
                      discount= price*(rate/100.0);
                      discount_controller.text=discount.toString();
                      finalPrice_controller.text= (price - discount).toString();
                    });
                  },
                  decoration: new InputDecoration(
                    hintText: 'Offer %',
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    labelText: 'Offer',
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                    suffixText: '%',
                  ),
                )),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  controller: discount_controller,
                  decoration: InputDecoration(
                      hintText: 'Discount Price',
                      labelText: 'Discount',
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  controller: finalPrice_controller,
                  decoration: InputDecoration(
                      hintText: 'Final Price',
                      labelText: 'Net Price',
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                )),
                SizedBox(height: 20,),
                ListTile(
                  title: Text(
                    'ADD COLOR and SIZE'
                    ,style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVariants(MediaQuery.of(context).size.width)));
                  },
                ),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  autovalidate: false,
                  validator: (val){
                    return val.isEmpty ? "Plz Provide Item name" : null;
                  },
                  onChanged: (value){
                    setState(() {
                      details=value;
                    });
                  },
                  decoration: new InputDecoration(
                    hintText: 'Service Description(Optional)',
                    labelText: 'Description',
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                )),
                SizedBox(height: 20,),
                // ListTile(
                //   title: Text('+ Add More Details',textAlign: TextAlign.left ,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                //   onTap: (){
                //     _add1();
                //   },
                // ),
                //
                // Container(
                //   height: 50,
                //   child: ListView(
                //       physics: NeverScrollableScrollPhysics(),
                //       padding: EdgeInsets.all(5),
                //       shrinkWrap: true,
                //       children: _myPets1
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton.icon(
                    icon: Icon(Icons.miscellaneous_services, size: 17,color: Colors.white),
                    label: Text('Add Service +', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                    color: Colors.green,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    },
                  ),
                )
              ],
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
