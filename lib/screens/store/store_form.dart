import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:search_map_place/search_map_place.dart';
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
import 'package:winkl/services/auth.dart';

class StoreForm extends StatefulWidget {
  String id;
  String Phone;
  StoreForm({this.id,this.Phone});

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
  String lat;
  String long;
  var _phone="";
  String _gps = 'Wait for few seconds...';
  String _serviceValue = 'Service Radius';
  String _seType='Vendor Category';
  String _storeValue = 'Select Store Type';
  // String _uid;
  bool _isVerified = false;
  String _imageUrl= "https://www.wikihow.com/images/6/61/Draw-a-Cartoon-Man-Step-15.jpg";
  Address first;

  ///Firebase instances
//  FirebaseUser currentUser;
  final FirebaseStorage _storage = FirebaseStorage();
  final AuthService authService=AuthService();
  var gps_controller= TextEditingController();


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

  List<String> serviceTypes=[
    'Vendor Category',
    'Grocery',
    'Fruits and Vegetables',
    'IceCreams',
    'Beverages',
  ];

  String address2="";
  String address1="";
  String state="";
  String city="";
  String country="";
  String area="";
  String landmark="";
  String pin_code="";
  TextEditingController _controller= TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text=widget.Phone;
//    getCurrentUser();
  }

//  void getCurrentUser() async {
//    currentUser = (await FirebaseAuth.instance.currentUser());
//    print(currentUser.uid+"fuck");
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: AppColors.orange,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.of(context).pop();
      //     },
      //       child: Icon(Icons.arrow_back, size: 24.0, color: Colors.black,)),
      // ),
      body: KeyboardAvoider(
        autoScroll: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 30),
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
                        onChanged: (value) {
                          setState(() {
                            _establishmanetName = value;
                          });
                        },
                        decoration: AppStyles.textFormFieldDecoration
                            .copyWith(hintText: 'Store name'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        autovalidate: _autoValidation,
                        validator: requireFieldValidator,
                        onChanged: (value) {
                          setState(() {
                            _proprietorName = value;
                          });
                        },
                        decoration: AppStyles.textFormFieldDecoration
                            .copyWith(hintText: 'Owner Name'),
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
            onChanged: (email) {
              setState(() {
                _email = email;
              });
            },
            decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText: 'Email Address'),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                autovalidate: _autoValidation,
                controller: _controller,
                validator: (val){
                  return val.isEmpty || val.length < 10 ? "Please enter a valid Phone Number" : null;
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
                border: Border.all(color: Color.fromRGBO(93, 187, 99, 1), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Select Service Radius'),
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
//            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(93, 187, 99, 1), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("Select Service Type"),
                  value: _seType,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: AppColors.orange,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _seType = newValue;
                    });
                  },
                  items: serviceTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
//            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(93, 187, 99, 1), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Select Store type'),
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


//           Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.orange, width: 2),
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //              crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(_gps),
//                 GestureDetector(
//                       onTap: () async {
//                         var result = await Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Gps()));
//                         setState(() {
//                           if (result != null) {
//                             enter_gps();
//                             _gps = result.toString();
//                           }
//                         });
//                       },
//                       child: Icon(
//                         Icons.location_on,
//                         size: 25,
//                         color: AppColors.orange,
//                       )),
//                 ],
//               ),
//             ),
//           ),
          Container(

              child: TextFormField(
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    address1 = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText: 'Address line 1'),
              )),
          SizedBox(height: 10,),
          RaisedButton.icon(
            icon: FaIcon(FontAwesomeIcons.check, color: Colors.white,),
            color: Color.fromRGBO(93, 187, 99, 1),
            label: Text('Check Address', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            onPressed: () async{
              var address= await Geocoder.local.findAddressesFromQuery(address1);
              first = address.first;
              setState(() {
                lat=first.coordinates.latitude.toString();
                long=first.coordinates.longitude.toString();
                country=first.countryName;
                state=first.adminArea;
                city=first.locality;
                pin_code=first.postalCode;
                landmark=first.thoroughfare;
                area=first.subLocality;
                print(lat);
                print(long);
              });
              
              // Prediction p = await PlacesAutocomplete.show(
              //     context: context, apiKey: 'AIzaSyCy6I1SleZ42NlSTDVDoKx1S6r4_vEeMNw',
              //     onError: onError);
              // displayPrediction(p);
            },
          ),
          SizedBox(height: 10,),
          Container(
              child: TextFormField(
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    country = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText:country=="" ?'Country':country),
              )),
          SizedBox(height: 10,),
          Container(
              child: TextFormField(
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    state = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText:state==""? 'State':state),
              )),
          SizedBox(height: 10,),
          Container(
              child: TextFormField(
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText:city==""? 'City':city),
              )),
          SizedBox(height: 10,),
          Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    pin_code = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText:pin_code==""? 'Pin Code':pin_code),
              )),
          SizedBox(height: 10,),
          Container(
              child: TextFormField(
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    area = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText: area==""?'Area':area),
              )),
          SizedBox(height: 10,),
          Container(
              child: TextFormField(
                autovalidate: _autoValidation,
                onChanged: (value) {
                  setState(() {
                    landmark = value;
                  });
                },
                decoration:
                AppStyles.textFormFieldDecoration.copyWith(hintText: landmark==""?'Landmark':landmark),
              )),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 600,
            child: MaterialButton(
              height: 55,
              color: Color.fromRGBO(93, 187, 99, 1),
              child: Text(
                'Continue',
                style:
                    AppStyles.buttonTextStyle.copyWith(color: AppColors.white),
              ),
              onPressed: () {
//                formValidation(context);
              print(widget.Phone);
              if(_formkey.currentState.validate())
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBrands( establishmanetName: _establishmanetName, proprietorName: _proprietorName,serviceType: _seType,storeType: _storeValue,email: _email,phone: _controller.text,state: state,city: city,
                  pin_code: pin_code,area: area,address1: address1,address2: address2,landmark: landmark,serviceValue: _serviceValue,imageUrl: _imageUrl,uid: widget.id,lat: lat,long: long,)));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.widgetBorderRadius))),
            ),
          ),
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

  enter_gps(){

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
}
