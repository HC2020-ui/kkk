import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:winkl/config/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:winkl/screens/otp_screens/verify_otp.dart';
import 'package:winkl/screens/store/add_brands.dart';
import 'package:winkl/screens/store/gps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StoreForm extends StatefulWidget {
  @override
  _StoreFormState createState() => _StoreFormState();
}

class _StoreFormState extends State<StoreForm> {
/// File
  File _image = File('images/placeholder.png');
  ///uuid instance
  var uuid = Uuid();


  final _picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  bool _autoValidation = false;
  String _establishmanetName;
  String _proprietorName;
  String _email;
  String _phone;
  String _sellerCategory;
  String _gps = 'Wait for few seconds...';
  String _serviceValue = 'Service Radius';
  String _storeValue = 'Select Store Type';
  String _uid;
  bool _isVerified = false;
  String _imageUrl= "images/placeholder.ong";

  ///Firebase instances
  FirebaseUser currentUser;
  FirebaseStorage _storage = FirebaseStorage();


  List<String> mylist = [
    'Service Radius',
    '1 Km',
    '1-3 Kms',
    '3-5 Kms',
    '5-10 Kms',
    '>10 kms'
  ];
  List<String> storeTypes = [
    'Select Store Type',
    'Luxury Store',
    'Showroom',
    'Mom & Pop Store',
    'Mobile Vendor',
    'Roadside Vendor',
    'Services'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    print(currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black,)),
      ),
      body: KeyboardAvoider(
        autoScroll: true,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Form(
              key: _formkey,
              autovalidate: _autoValidation,
              child: getForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget getForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Flexible(
                child: getProfileImageWidget(context),
                flex: 2,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 6,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        autovalidate: _autoValidation,
                        textAlign: TextAlign.left,
                        validator: requireFieldValidator,
                        onSaved: (value) {
                          _establishmanetName = value;
                        },
                        decoration: AppStyles.textFormFieldDecoration
                            .copyWith(hintText: 'Establishment Name'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        autovalidate: _autoValidation,
                        validator: requireFieldValidator,
                        onSaved: (value) {
                          _proprietorName = value;
                        },
                        decoration: AppStyles.textFormFieldDecoration
                            .copyWith(hintText: 'Proprietor Name'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: TextFormField(
            autovalidate: _autoValidation,
            validator: emailValidation,
            onSaved: (email) {
              _email = email;
            },
            decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText: 'Email'),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
              child: TextFormField(
                autovalidate: _autoValidation,
                validator: (val){
                  return val.isEmpty || val.length < 10 ? "Please enter a valid Phone Number" : null;
                },
                onSaved: (phone) {
                  _phone = phone;
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText: 'Phone Number'),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
//            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _serviceValue,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: AppColors.orange,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _serviceValue = newValue;
                    });
                  },
                  items: mylist.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: TextFormField(
            autovalidate: _autoValidation,
            validator: requireFieldValidator,
            onSaved: (value) {
              _sellerCategory = value;
            },
            decoration: AppStyles.textFormFieldDecoration
                .copyWith(hintText: 'Seller Category'),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
//            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _storeValue,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: AppColors.orange,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _storeValue = newValue;
                    });
                  },
                  items:
                      storeTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('$_gps'),
                GestureDetector(
                    onTap: () async {
                      var result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Gps()));
                      setState(() {
                        if (result != null) {
                          _gps = result.toString();
                        }
                      });
                    },
                    child: Icon(
                      Icons.location_on,
                      size: 25,
                      color: AppColors.orange,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
//            padding: EdgeInsets.symmetric(horizontal: 35),
            width: 600,
            child: MaterialButton(
              height: 55,
              color: AppColors.orange,
              child: Text(
                'Register',
                style:
                    AppStyles.buttonTextStyle.copyWith(color: AppColors.white),
              ),
              onPressed: () {
                formValidation(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VerifyOtp(storeValue: _storeValue,);
                }));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.widgetBorderRadius))),
            ),
          )
        ],
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
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile == null) {
      return;
    }

    File tmpFile = File(pickedFile.path);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final String path = appDocDir.path;
    final String fileName = basename(pickedFile.path);
    final String fileExtension = extension(pickedFile.path);
    print(fileName);
    tmpFile = await tmpFile.copy('$path/$fileName');


    StorageReference reference = _storage.ref().child("profileImages/${uniqueId}");
    StorageUploadTask uploadTask = reference.putFile(tmpFile);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    url = await taskSnapshot.ref.getDownloadURL();


    setState(() {
      _image = tmpFile;
      _imageUrl = url;
    });


  }

  String requireFieldValidator(String value) {
    if (value.length == 0) {
      return "Required field can not be empty";
    }
    return null;
  }

  String emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(email)) {
      return null;
    }
    return 'Please check your email';
  }

  void formValidation(BuildContext context) {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Firestore.instance
          .collection("stores")
          .document('stores${currentUser.uid}')
          .setData({
          "uid": currentUser.uid,
          "email":_email,
          "phone": _phone,
          "seller_category":_sellerCategory,
          "establishment_name":_establishmanetName,
          "proprietor_name":_proprietorName,
          "service_radius":_serviceValue,
          "store_type":_storeValue,
          "area":_gps,
          "imageUrl":_imageUrl
          })
          .then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddBrands(storeValue: _storeValue,);
        }));
      })
          .catchError((e) {
            print('There is some error');
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Ooops!! We have some problem, sorry'),
            ));
          });
    } else {
      setState(() {
        _autoValidation = true;
      });
    }
  }
}
