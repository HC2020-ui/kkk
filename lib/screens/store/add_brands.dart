import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winkl/screens/home_pack/home.dart';
import 'dart:io'as i;
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
  AddBrands({this.establishmanetName,this.proprietorName,this.email,this.phone,this.serviceValue,this.serviceType,this.storeType,this.gps,this.imageUrl,this.uid});

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
  var firestoreInstance=FirebaseFirestore.instance;
  var storeType;
  var brandName="";
  String vendorId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
    addDatatoDatabase(context);

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
                                    Home(id: widget.uid)), (route) => false);
                          }else {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                    builder: (context) => Home()), (route) => false);
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
            "email": widget.email?? "error",
            "phone":  widget.phone?? "error",
            "seller_category": widget.serviceType?? "error",
            "establishment_name": widget.establishmanetName?? "error",
            "proprietor_name": widget.proprietorName?? "error",
            "service_radius": widget.serviceValue?? "error",
            "store_type": widget.storeType?? "error",
            "imageUrl": widget.imageUrl?? "error"
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
