import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'package:winkl/screens/home_pack/newHomePage.dart';

class AddBrands extends StatefulWidget {
  String establishmanetName;
  String proprietorName;
  String email;
  String phone;
  String serviceValue;
  String serviceType;
  String storeType;
  String imageUrl;
  String uid;
  String state;
  String city;
  String pin_code;
  String landmark;
  String area;
  String address2;
  String address1;
  String lat;
  String long;
  AddBrands({this.establishmanetName,this.proprietorName,this.email,this.phone,this.serviceValue,this.serviceType,this.storeType,
    this.state,this.city,this.address1,this.address2,this.area,this.landmark,this.pin_code,this.imageUrl,this.uid, this.lat,this.long});

  @override
  _AddBrandsState createState() => _AddBrandsState();
}

bool checkedValue = true;
int selectedRadoButton = 1;
FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://wnkl-f55a7.appspot.com');
StorageUploadTask _uploadTask;
i.File _imageFile;

class _AddBrandsState extends State<AddBrands> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  var len_docs=0;
  var firestoreInstance=FirebaseFirestore.instance;
  var storeType;
  var brandName="";
  String vendorId;
  var state_codes={
    'Andhra Pradesh':'AP',
    'Arunachal Pradesh':'AR',
    'Assam':'AS',
    'Bihar':'BR',
    'Karnataka':'KA',
    'Kerala':'KL',
    'Chhattisgarh':'CT',
    'Uttar Pradesh':'UP',
    'Goa':'GA',
    'Gujarat':'GJ',
    'Haryana':'HR',
    'Himachal Pradesh':'HP',
    'Jammu and Kashmir':'JK',
    'Jharkhand':'JH',
    'West Bengal':'WB',
    'Madhya Pradesh':'MP',
    'Maharashtra':'MH',
    'Manipur':'MN',
    'Meghalaya':'ML',
    'Mizoram':'MZ',
    'Nagaland':'NL',
    'Orissa':'OR',
    'Punjab':'PB',
    'Rajasthan':'RJ',
    'Sikkim':'SK',
    'Tamil Nadu':'TN',
    'Telangana':'TG',
    'Tripura':'TR',
    'Uttarakhand':'UP',
  };
  var now = new DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdocslength().whenComplete(() => setvendorId());
    addDatatoDatabase(context);
  }

  Future getdocslength() async {
    len_docs = await FirebaseFirestore.instance.collection('products').snapshots().length;
    if(len_docs==null){
      setState(() {
        len_docs=0;
      });
    }
  }

  setvendorId(){
    if(widget.storeType.toLowerCase()=='services') {
      setState(() {
        vendorId = 'S/${state_codes[capitalize(widget.state.toLowerCase())]}/${now.year}/${now.month}/${len_docs+1}';
      });
    }else{
      setState(() {
        vendorId='P/${state_codes[capitalize(widget.state.toLowerCase())]}/${now.year}/${now.month}/${len_docs+1}';
      });
    }
  }
  
  Future<void>pickimage(ImageSource source)async{
    i.File selected = await ImagePicker.pickImage(source: source);
    if(selected!=null){
      i.File cropped = await ImageCropper.cropImage(
        sourcePath: selected.path,
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.purple,
          toolbarTitle: "CROP",
          statusBarColor: Colors.blueGrey,
          backgroundColor: Colors.white,
        )
      );
      setState(() {
        _imageFile = cropped;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.blue,
              width: 5
            )
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  margin: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('WELCOME', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),),
                      ),
                      Text('TO', style: TextStyle(color: Colors.black,fontSize: 25),),
                      Text(widget.establishmanetName, style: TextStyle(color: Colors.green,fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 30,),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Center(
                            child: Text('Lets get Started', style: TextStyle(color: Colors.white),),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onTap: () {
                          if (widget.uid != null) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) =>
                                    NewHomePage(uid: widget.uid,)), (route) => false);
                          }else {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                    builder: (context) => NewHomePage()), (route) => false);
                          }
                        }
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/2.6,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: EdgeInsets.all(0),
                  child: ClipRRect(
                    child: Image.asset('images/15256.jpg',
                      fit: BoxFit.contain,
                       height: MediaQuery.of(context).size.height/2.6,
                    ),
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                )
              ],
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
          "uid": widget.uid?? "error",
        "VendorId":vendorId??"error",
        "email": widget.email?? "error",
        "phone":  widget.phone?? "error",
        "seller_category": widget.serviceType?? "error",
        "establishment_name": widget.establishmanetName?? "error",
        "proprietor_name": widget.proprietorName?? "error",
        "service_radius": widget.serviceValue?? "error",
        "store_type": widget.storeType?? "error",
        "area": widget.area?? "error",
        "state":widget.state??"error",
        "city":widget.city??"error",
        "address1":widget.address1??"error",
        "landmark":widget.landmark??"error",
        "pinCode":widget.pin_code??"error",
        "address2":widget.address2??"error",
        "imageUrl": widget.imageUrl?? "error",
      }).then((value) {
        print('successfully added');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Successfully Added'),
        ));
      })
          .catchError((e) {
        print('There is some error');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Ooops!! We have some problem, sorry'),
        ));
      });
  }

  // addtoDatabase() async {
  //
  //   await FirebaseFirestore.instance.collection("brands")
  //       .doc(widget.uid)
  //       .set({
  //     'name':_brandsController.text,
  //   }).then((value) {
  //     Toast.show("The brand has been saved!!!", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
  //     print("success");
  //   });
  // }

}
