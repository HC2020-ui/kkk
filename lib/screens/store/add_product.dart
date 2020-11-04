import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:winkl/config/theme.dart';
import 'package:winkl/dialog_box.dart';
import 'package:winkl/main.dart';
import 'package:winkl/screens/store/add_variants.dart';
import 'package:winkl/screens/store/product_search.dart';

class AddProduct extends StatefulWidget {
  String event;
  String documentid;
  String id;
  AddProduct(this.event,{this.documentid,this.id});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {


  final _formkey = GlobalKey<FormState>();
  bool _autoValidation = false;

  TextEditingController cat_controller= new TextEditingController();
  TextEditingController brand_controller= new TextEditingController();
  TextEditingController discount_controller= TextEditingController();
  TextEditingController finalPrice_controller= TextEditingController();
  var uuid = Uuid();
  String imageUrl="https://www.essentiallysports.com/wp-content/uploads/IMG_20191230_233458.jpg";
  String name;
  String mrp;
  String Sellingprice;
  String offer;
  String details;
  String _imageUrl= "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";


  String cat_val = "Choose Category";
  String brand_name="";
  // List<String> catlist = [
  //   'Choose Category',
  //   'Category 1',
  //   'Category 2',
  //   'Category 3',
  //   'Category 4',
  //   'Category 5',
  // ];
  //
  // String unit_val = "piece";
  // List<String> unitsList = [
  //   "piece",
  //   "kg",
  //   "gm",
  //   "litre",
  //   "ml",
  //   "dozen"
  // ];

  String instock="Instock";
  List<String> instocklist = [
    'Instock',
    'yes',
    'no'
  ];
  // var _myPets = List<Widget>();
  // int _index = 1;
  // var _myPets1 = List<Widget>();
  // int _index1 = 1;
  //
  // void _add1(){
  //   TextEditingController controller= new TextEditingController();
  //   int keyValue = _index1;
  //   _myPets1 = List.from(_myPets1)
  //     ..add(Column(
  //       key: Key("${keyValue}"),
  //       children: [
  //         ListTile(
  //           title:new TextFormField(
  //             controller: controller,
  //             autovalidate: false,
  //             validator: (val){
  //               return val.isEmpty? 'Please enter Description ':null;
  //             },
  //             onChanged: (value){
  //               setState(() {
  //                 offer= value;
  //               });
  //             },
  //             decoration: new InputDecoration(
  //               hintText: "Enter Description (Optional)",
  //             ),
  //           ),
  //           trailing: IconButton(
  //             icon: Icon(Icons.clear),
  //             onPressed: (){
  //               _myPets1.remove(controller);
  //               --_index1;
  //             },
  //           ),
  //         )
  //       ],
  //     ));
  //
  //   setState(() {
  //     ++_index1;
  //   });
  // }
  //
  // void _add() {
  //   int keyValue = _index;
  //   TextEditingController controller= new TextEditingController();
  //   _myPets = List.from(_myPets)
  //     ..add(Column(
  //       key: Key("${keyValue}"),
  //       children: [
  //         ListTile(
  //           title:new TextFormField(
  //             controller: controller,
  //             autovalidate: false,
  //             validator: (val){
  //               return val.isEmpty? 'Please enter Discount ':null;
  //             },
  //             onChanged: (value){
  //               setState(() {
  //                 offer= value;
  //               });
  //             },
  //             decoration: new InputDecoration(
  //               hintText: "Discounted Price",
  //             ),
  //           ),
  //           trailing: IconButton(
  //             icon: Icon(Icons.clear),
  //             onPressed: (){
  //               _myPets.remove(controller);
  //               --_index;
  //             },
  //           ),
  //         )
  //       ],
  //     ));
  //
  //   setState(() => ++_index);
  // }

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
              child: Text("Add Product", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.black,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductSearch()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height+250,
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
                    hintText: 'ex: shoes',
                    labelText: 'Name',
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
                    hintText: 'Category name',
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
                    //\u20B9 for rupee symbol
                    hintText: 'ex: 5000.00 ₹',
                    labelText: 'MRP',
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
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: 'Offer %',
                    labelText: 'Offer',
                    suffixText: '%',
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                )),
                SizedBox(height: 20,),
                Container(child: TextFormField(
                  controller: discount_controller,
                  decoration: InputDecoration(
                    hintText: 'Discounted Price',
                    labelText: 'Discount',
                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 17),
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
                    hintText: 'Enter Description(Optional)',
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
                RaisedButton.icon(
                  icon: Icon(Icons.delivery_dining, color: Colors.white, size: 17,),
                  color: Colors.lightBlue,
                  label: Text('Add Product+', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                  onPressed: (){
                    if(widget.event=="update")
                      updatabase();
                    else
                    addtoDatabase();
                    Navigator.of(context).pop();
                  },
                ),
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
                      getImage(ImageSource.camera);
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
                      getImage(ImageSource.gallery);
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

  Future getImage(ImageSource source) async {
    String uniqueId = uuid.v1();
    String url;
    FirebaseStorage storage = FirebaseStorage.instance;

    File image;
    try {
      //Get the file from the image picker and store it
      var img = await ImagePicker().getImage(source: source);

      setState(() {
        image=File(img.path);
      });

    } on PlatformException catch (e) {
      //PlatformException is thrown with code : this happen when user back with don't
      //selected image or not approve permission so stop method here
      // check e.code to know what type is happen
      return;
    }

    //Create a reference to the location you want to upload to in firebase
    StorageReference reference =
    storage.ref().child("profileImages/${uniqueId}");

    //Upload the file to firebase
    StorageUploadTask uploadTask = reference.putFile(image);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    // Waits till the file is uploaded then stores the download url
    url = await taskSnapshot.ref.getDownloadURL();

    print(url);

    setState(() {
      _imageUrl = url;
    });


  }



  addtoDatabase() async {

    await FirebaseFirestore.instance.collection('stores').doc(widget.id).collection('products').doc(uuid.v1())
        .set({
      'category':cat_val,
      'name':name,
      'selling_price':Sellingprice,
      'imageUrl':imageUrl,
      'details':details,
      'instock':instock.toLowerCase(),
      'addedby': 'user',
    }).then((value) {
      Toast.show("Your Product details has been saved!!!", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      print("success");
    });
  }

  updatabase() async{
    FirebaseFirestore.instance.collection('stores').doc(widget.id).collection('products')
        .doc(widget.documentid)
        .update({
      'category':cat_val,
      'name':name,
      'selling_price':Sellingprice,
      'imageUrl':imageUrl,
      'details':details,
      'instock':instock.toLowerCase(),
        }).then((value) {
          Toast.show("Your Product details has been updated!!!", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
       print("success");
    });
  }
}

class CategorySearch extends StatefulWidget {
  String type;
  CategorySearch({this.type});
  @override
  _CategorySearchState createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  String name="";
  TextEditingController cat_controller= TextEditingController();
  TextEditingController brand_controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: widget.type=="category" ?StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
            .collection('products')
            .where("category", isEqualTo: name)
            .snapshots()
            : FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              if (snapshot.data.docs.length == 0) {
                return TextFormField(
                  controller: cat_controller,
                  decoration: InputDecoration(
                    hintText: 'Add your Own Category',
                    labelText: 'Enter category',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (){
                        _showdialog();
                      },
                    )
                  ),
                );
              } else {
                return InkWell(
                  child: Card(
                      child: Text(data.get('category'))
                  ),
                );
              }
            }
          );
        },
      )
          :
      StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
            .collection('brands')
            .where("name", isEqualTo: name)
            .snapshots()
            : FirebaseFirestore.instance.collection("brands").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data.docs[index];
                if (snapshot.data.docs.length == 0) {
                  return TextFormField(
                    controller: brand_controller,
                    decoration: InputDecoration(
                        hintText: 'Add your Own Brand',
                        labelText: 'Enter Brand',
                        prefixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: (){
                            _showdialog();
                          },
                        )
                    ),
                  );
                } else {
                  return InkWell(
                    child: Card(
                        child: Text(data.get('name'))
                    ),
                  );
                }
              }
          );
        },
      ),
    );
  }

  _showdialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return CustomAlertDialog(
            title: "Confirm",
            message: "Are you sure, do you want add?",
            onPostivePressed: () {
              Navigator.pop(context);
              if(widget.type=='category')
              Navigator.pop(context, cat_controller.text);
              else
                Navigator.pop(context, brand_controller.text);
            },
            onNegativePressed: (){
              Navigator.pop(context);
            },
            positiveBtnText: 'Yes',
            negativeBtnText: 'No');
      }
    );
  }
}

